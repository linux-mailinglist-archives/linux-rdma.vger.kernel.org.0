Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6DE16AE9
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2019 21:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfEGTM2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 May 2019 15:12:28 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37131 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfEGTM2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 May 2019 15:12:28 -0400
Received: by mail-qt1-f195.google.com with SMTP id o7so8425250qtp.4
        for <linux-rdma@vger.kernel.org>; Tue, 07 May 2019 12:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nolViST0cq/q5AqeoUtNiTYjlAXMgvBgMxj3rnqyVZ4=;
        b=SN4XqDaDrgLA1AWtbYwNVuBaNp+qEuSUIpo7gBSNfE4ziaN2JLkqd0l4EuA+Y3aCnc
         4oHDR2SfzO2erksSkya+WKP5gGfpxqcRImdhiEEqG0etKqISf4eYWRFmKLDgjv7Jslei
         I5o7EglYI8G9Jb6v9H8S5TsYlvbW+8PeDXMz1tIQtW0kKAZznLkh5ZYhgx7LO6FnEV/0
         s+KsybrTwbzeEpmlBBtH5pG1fnu5EigxiTx3AKp9hBY3n4SESn5okHwOzlodD+QKO5yd
         uqP2E5rl/NNM6UQrry+VxI15BYddIasSbSeCYlrB8lpC+AGD53qbvXMwrjZ1UfNyIZ1x
         uFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nolViST0cq/q5AqeoUtNiTYjlAXMgvBgMxj3rnqyVZ4=;
        b=SgYvMLwlVsklJ1UlwhUGlALURKLljriej3coHeeRBqJuIOi1qw50YNs+skfLBK7KYm
         A6+WSx7cs1UHfu7Pg+fo82/eiB6MMqmzthMyvnx1+IpcmlFsGl/axPNcOJnG4xExSx+D
         cHCYXmIyy0z0V8opj2goZJJitYSTzRxz60j2K/g2wUDiHqoZ/MyAe1PlFbdieA/tUPhV
         8w1cN3hIErOPd9EuWvNk8c4qNAc2LMjZfyC8LLqahjTQ/KDpvf2wbT8qM+i/iIPmuj5z
         nZq4AGh/Fi9eRloWiPqPicl2etZkfYjtEn4kabPuEKjjnP47Go3wWdXKmI89ai+2tqTf
         Jj8w==
X-Gm-Message-State: APjAAAWplF7acYmaLrv0GGsx1I+JCO2GRyKrrCPZqfxZnb/YoeI0RiZp
        2G7n25oDX1Cc09SWZ7yAv3AjMezPx5Q=
X-Google-Smtp-Source: APXvYqwYCaeuqT8ZDKjiaUxPqLD4+8sqG8ohu32r5qVNsI+lxQ2stCJCHHk+qVEF8oQ385JL1QflvQ==
X-Received: by 2002:aed:3fc1:: with SMTP id w1mr28754138qth.2.1557256347148;
        Tue, 07 May 2019 12:12:27 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id s55sm9145987qte.17.2019.05.07.12.12.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 12:12:26 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hO5Vp-0000qT-LG; Tue, 07 May 2019 16:12:25 -0300
Date:   Tue, 7 May 2019 16:12:25 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Arseny Maslennikov <ar@cs.msu.ru>
Subject: Re: [PATCH rdma-next v1] RDMA/ipoib: Allow user space differentiate
 between valid dev_port
Message-ID: <20190507191225.GA3163@ziepe.ca>
References: <20190506112304.10346-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506112304.10346-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 06, 2019 at 02:23:04PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Systemd triggers the following warning during IPoIB device load:
> 
>  mlx5_core 0000:00:0c.0 ib0: "systemd-udevd" wants to know my dev_id.
>         Should it look at dev_port instead?
>         See Documentation/ABI/testing/sysfs-class-net for more info.
> 
> This is caused due to user space attempt to differentiate old systems
> without dev_port and new systems with dev_port. In case dev_port will
> be zero, the systemd will try to read dev_id instead.
> 
> There is no need to print a warning in such case, because it is valid
> situation and it is needed to ensure systemd compatibility with old
> kernels.
> 
> Link: https://github.com/systemd/systemd/blob/master/src/udev/udev-builtin-net_id.c#L358
> Cc: <stable@vger.kernel.org> # 4.19
> Fixes: f6350da41dc7 ("IB/ipoib: Log sysfs 'dev_id' accesses from userspace")
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  Changelog v0->v1:
>  * Fix typo as pointed by Gal P.
> ---
>  drivers/infiniband/ulp/ipoib/ipoib_main.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)

Applied to for-next, thanks

Jason
