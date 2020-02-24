Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFE816A84B
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Feb 2020 15:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbgBXO0F (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Feb 2020 09:26:05 -0500
Received: from mail-pj1-f54.google.com ([209.85.216.54]:35922 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727281AbgBXO0F (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Feb 2020 09:26:05 -0500
Received: by mail-pj1-f54.google.com with SMTP id gv17so4265083pjb.1
        for <linux-rdma@vger.kernel.org>; Mon, 24 Feb 2020 06:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=/CiAt79OhfNZRy47R0XHS2HEux49NnI/0eFkOc5KejM=;
        b=F3t3rXeLJghjKjKsRVGIBKp0Y1/a0TRgOB40ten66q920n5wXg4z7csE3QtFoqV3Fz
         fuVBwlw98K4cP4YeePHIsHnqCAmylxKjxTmW/nv7w6AmaC2qwE7F7lZxRjDKQTq+6Lpj
         4qZUUDw9xYHciUjsvRkKjQQ2aGlD+LtU/nT6OO1bFOmxrqfbF7vDaDmY/bZXo6AqDWkr
         v6oHNWkCyFJUjGCsILL7m5VBhH/WGMKNLF9feOjdQXAS4nR5YnRgKgSnuErO4R1DNmTX
         ebCWantzn7csp+klWO8u1ilYKxq4qUZ8eFEiILEh1F4JbKNa1Qnk1edG0XnxnL1QGt7s
         OnjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=/CiAt79OhfNZRy47R0XHS2HEux49NnI/0eFkOc5KejM=;
        b=l5ykrJwyhsV4UCbcEqNqry/oty6V+QlZefYikVIFyMwdW7dWFko+eLUfoTTt2FY3+v
         dBGBznOtSHi22qbbChj+7ag6RvKhojt/Q6jhbjcA3Xsd01m2mtXXuK7s6vA8kHafYjqD
         5mhFkFj3rzgO6QUmOf/sBWVUXb5o8tAlWtfQvREicIC9SQp/0cQ0tHuRUr2SbtTknHgJ
         DcvGkexCfRoKSbYYdSE4pXAuUTk7Smljsgxppmp3mFhmp/9SQRV0YPaIw5zQsHFL+ERa
         zn5XCXxrDZkF6t9RS0BY3nZ7QSLY0WOld7OJlI8HWcPMHKRoYsti4sVbhWzuSFRhoAOX
         Rzgg==
X-Gm-Message-State: APjAAAWN0jwEHq3GpW4o80+0rqOQTy7KGN/q+AEcuW7VvYSRi3sXqPcn
        I4fGNSJjSl68dUJonr9XB3tKddYIGan737ioIpqYIw20
X-Google-Smtp-Source: APXvYqyyer7FdFZ1km3ONXm2oor/9L+d6ZK4fUOuBYlsIjhJqF5qNWYowvK5zxlYYh1hSFUuzQyY3RAemULzaFdBRbg=
X-Received: by 2002:a17:90a:be06:: with SMTP id a6mr20403064pjs.73.1582554363937;
 Mon, 24 Feb 2020 06:26:03 -0800 (PST)
MIME-Version: 1.0
References: <CANS8p=-hYd9x9n2-DUxuvHirD2b9MTS=gDOskfD_mipD+kb=vQ@mail.gmail.com>
In-Reply-To: <CANS8p=-hYd9x9n2-DUxuvHirD2b9MTS=gDOskfD_mipD+kb=vQ@mail.gmail.com>
From:   Umang Patel <umangsp.1199@gmail.com>
Date:   Mon, 24 Feb 2020 19:55:52 +0530
Message-ID: <CANS8p=-8waZ5TSQ3Ei+DO+M5gr5VW8itbByzgCDrnog-KDxy1A@mail.gmail.com>
Subject: Re: Regarding using UMR feature from. rdma-core API
To:     linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

So that means if i use ibv_wr_send or ibv_post_send after
mlx5dv_wr_mr_list, then the send request will be posted with the UMR
feature?

On Mon, Feb 24, 2020 at 4:24 PM Umang Patel <umangsp.1199@gmail.com> wrote:
>
> Hello!
>
> As you said, I have already read the mlx5dv_wr_post() manual but I am
> still having trouble even after following the instructions given in
> it. I have created a normal client-server code for transferring some
> data from client to server using rdma. I am using the the rdma-core
> repo for the code. For posting the send request with the UMR feature,
> i use the function "mlx5dv_wr_mr_list" and to post the send request
> without UMR feature, i use the function "ibv_wr_send". The two
> functions that I mentioned are similar as mentioned in the manual. I
> have written my code in such a way that it asks whether or not to use
> the UMR feature and I have put an if else in the code which runs the
> function according to the user's answer whether or not to use the
> function and rest of the code is the does not change for with UMR and
> without UMR. However, I am unable to receive the data with
> mlx5dv_wr_mr_list function. Whereas, using ibv_wr_send, I am able to
> receive the correct data.
>
> Can you please look into it? Am I missing something in the code that i
> have to add for the UMR feature or the server side requires something
> else? what is the problem? I have attached the client-server code with
> this email.
>
> Thank You!
