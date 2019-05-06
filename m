Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF4E150C2
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2019 17:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfEFP42 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 May 2019 11:56:28 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33570 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfEFP41 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 May 2019 11:56:27 -0400
Received: by mail-qk1-f193.google.com with SMTP id k189so936829qkc.0
        for <linux-rdma@vger.kernel.org>; Mon, 06 May 2019 08:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=udngeiJLZAnnTFOxfZeh06xOt8qYZ7pnr2re5dxZ7YU=;
        b=WYM6eFeWV/BkmWY7HaWem4YU/WHYkjj3/FzNVuHO6IgllN5S5DImFvD7CktCjs9vFR
         7btgEbXikZdJMGM4dUwUXq7CmKLtM7jt5wyyT9bdXEFTXx0Paw4ah/DrkxwTmVH7s85J
         JmI8lrc4XtrNh5yVVR5UXH+Odj7Adop430FD+9l3BjgMK6UPwZw3osIumuHc8ldrH3xq
         KjLSwCVOj4L9w1cNrKdDjIUCQzPq4PjTW+stDNUoDjfQwG/wypiQcWBu9YaiVAsX+dTj
         w0+KdtiW0fip4o/6+lN+hNGZ0zpgLeWO9TK89yDOMXov//MVjUADCuhHO4VA8vR3+MhJ
         hhXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=udngeiJLZAnnTFOxfZeh06xOt8qYZ7pnr2re5dxZ7YU=;
        b=VNMdCYHt2MjFHY2QegPmhLO8tUquaXJ/SRBU0q0AljD9bYzvinOtC1WeA5LusApJPQ
         JZ0GXRXgJOAC9VtB68ckMZP959+nrMfNmdKJPYPc1MYpWlWwkXoDCCBiJ7bQRm9TA0QD
         PBvpZLM4Wixuks7v8IZ7D9Tf/elotXbqq0/ROrL5CAM7qMWKLqsSdJ5nkjv+4M+OV3Qd
         fmkf2e9kRXdPEjYk3/vtDe6NvDvE+Cx8gdMSv29iy1ax3CafYFT6f8n5hOHCbdX5y3q1
         lsPpiP1NEtMFbLzjVBfK2CFTPJevPPpet1sA3PqH1j6WrVcvdBB+c6CjTGODlJfvOApW
         X4iQ==
X-Gm-Message-State: APjAAAX768eFyg9wp41o9OX2WHVym31jKlQn5T3PYvPAJ6UPR+dytxPb
        yH2ZpFXe75OIm7juuyyZ1CyVlw==
X-Google-Smtp-Source: APXvYqxBIPIX1zO3OEwvaEm8Q+HCOaQrrcHMxyoywg8F3WLzE4is82VHfc6nS2DFtvJbCDtk9AGhTQ==
X-Received: by 2002:ae9:f503:: with SMTP id o3mr2533780qkg.345.1557158186875;
        Mon, 06 May 2019 08:56:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id g15sm7133144qta.31.2019.05.06.08.56.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 08:56:25 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hNfyb-0000Qn-1P; Mon, 06 May 2019 12:56:25 -0300
Date:   Mon, 6 May 2019 12:56:25 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Ariel Levkovich <lariel@mellanox.com>,
        Eli Cohen <eli@mellanox.com>, Mark Bloch <markb@mellanox.com>
Subject: Re: [PATCH rdma-next 0/4] User space steering
Message-ID: <20190506155625.GA1573@ziepe.ca>
References: <20190505140714.8741-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190505140714.8741-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, May 05, 2019 at 05:07:10PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Changelog v0 -> v1:
>  * Removed phys_addr dependency from kconfig
> 
> -------------------------------------------------------------------------
> >From Ariel,
> 
> This series of patches adds user space managed steering infrastructure
> to the mlx5_ib driver.
> 
> User space managed steering requires the means to access a dedicated
> memory space that is used by the device to store the packet steering
> and header modification tables and rules in order to manage them
> directly without the device's firmware involvement. This dedicated memory
> is part of the ICM memory space.
> 
> The changes are introducing the mlx5_ib API to allocate, deallocate and
> register this dedicated SW ICM memory via the existing device memory API
> using a private attribute which specifies the memory type.
> 
> The allocated memory itself is not IO mapped and user can only access it
> using remote RDMA operations.
> 
> In addition, the series exposed the ICM address of the receive transport
> interface (TIR) of Raw Packet and RSS QPs to user since they are
> required to properly create and insert steering rules that direct flows
> to these QPs.
> 
> Thanks
> 
> Ariel Levkovich (4):
>   IB/mlx5: Support device memory type attribute
>   IB/mlx5: Warn on allocated MEMIC buffers during cleanup
>   IB/mlx5: Add steering SW ICM device memory type
>   IB/mlx5: Device resource control for privileged DEVX user

Applied to for-next, thanks

Jason
