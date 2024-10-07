function drawframe(frame_number)
    clf; % Clear the figure for the new frame
    axis equal;
    hold on;
    axis([-10 10 -10 10]);
    % Create background color transition (day to night simulation)
    color_shift = 0.8 - 0.8 * (frame_number / 96); 
    set(gca, 'Color', [color_shift, color_shift, 1]);
    % Animate a bouncing ball (circle)
    t = (frame_number / 96) * 2 * pi; % Time variable for bouncing effect
    x_ball = 0; % Fixed x-position for the ball
    y_ball = 5 * abs(sin(t)); % Vertical bouncing effect
    r_ball = 1; % Radius of the ball
    theta = linspace(0, 2*pi, 100);
    x_circle = r_ball * cos(theta) + x_ball;
    y_circle = r_ball * sin(theta) + y_ball;
    fill(x_circle, y_circle, [1, 0.5, 0]); % Orange ball
    
    % Draw a rotating windmill-like shape
    arm_length = 4;
    rotation_angle = (frame_number / 96) * 2 * pi; % Rotation over time
    for i = 1:4
        x_arm = [0, arm_length * cos(rotation_angle + i * pi / 2)];
        y_arm = [0, arm_length * sin(rotation_angle + i * pi / 2)];
        plot(x_arm, y_arm, 'k', 'LineWidth', 3); % Draw the arms
    end
    % Optional: Title or additional text
    text(-8, 9, sprintf('Frame: %d', frame_number), 'FontSize', 12, 'Color', 'w');
    
    hold off;
end
function createMovie()
    nFrames = 96; % Total number of frames (12 seconds * 8 fps)
    figure; % Create a figure window
    mov = struct('cdata', [], 'colormap', []); % Preallocate a structure for the movie
    for frame_number = 1:nFrames
        drawframe(frame_number); % Generate the frame
        mov(frame_number) = getframe(gcf); % Capture the current figure as a frame
        drawnow; % Update the figure window
    end
    % Play the captured movie
    movie(mov, 1, 8); % Play movie 1 time at 8 frames per second
end
