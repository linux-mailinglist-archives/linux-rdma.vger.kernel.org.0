Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F17318485E
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2020 14:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgCMNlk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Mar 2020 09:41:40 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:36612 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgCMNlk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Mar 2020 09:41:40 -0400
Received: by mail-qv1-f67.google.com with SMTP id r15so4564061qve.3
        for <linux-rdma@vger.kernel.org>; Fri, 13 Mar 2020 06:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dkS6JIPR1G7/ckvm3Z4onuuL0vhlX5um3b3nRMVYRJ4=;
        b=aLp7jiJYA/Q94B+gpPIGN84GH6cFiSUqJsmQyy+5k5QTpUfeawdyujh2xIM57kkQsm
         x7yjzP2S0vno+JzTiyp3ybBftBpIqYLeBBy2IYvR9wjZxFYM/KEeKKrB47Z9pnNiHmen
         diCIrQsLjTR4JkVbAkrz+Xyh0miyh3mBrnaNY9AHdwwAmFBXZYg/dZD7yzUlgMLU3Ssk
         BHbtNig4l0zn6z9hfc0Z9Q03fwSzAUrI5k5jXbuVuqQYxDfwUr278NE0FNvBdqvFWnvQ
         xWiB4VmZuxwVj+hKHeaCNG2QL2oHUyEV+wPfNGlVAsS6UHyGQ0pxFeGkcKY7IueYsnyY
         65lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dkS6JIPR1G7/ckvm3Z4onuuL0vhlX5um3b3nRMVYRJ4=;
        b=mY8VRWDwGNlLIe3XRPmL8RQuq3sslmMuJ0uk/UV1gqG4LGSXKMDx/crrGy4YIiaHhD
         GEUhBIY6CUBri3m+7ZY31HO/0O+m/mN+C31RdaNKc1qfQi3erxU1ILNSErqyKvLWbYDt
         n01Bw1+FWuK2nWPaPpVfINmGE5RSGL7usoc1fMMgGnRkV0ULPm4JNx5GMkhzznlXCFGI
         L+dKX2/tQHSJBibgfcbfqt/8lBbCQdzJVZM4W3p2HOROV5TAy35aMzf7HVZuEjJuUjxB
         W0z9NBB2iK1vJA8qspm8whm5xc36B5byBx1QaQsAnehnJ8rYnfSslCW4Hg/aX76t34xt
         C00A==
X-Gm-Message-State: ANhLgQ3iQcfrzgwSnOYrSi8UK5holOC2WDiSnLzK6W8IrLEIrYu8IiGP
        ou41t5Bkp8EVGjrb9IX5lMpemI9og80=
X-Google-Smtp-Source: ADFU+vtmxXSlQwcSWLoSB9lZ4ew25e+Lw3S0ns1RXZAuzJ2KpOZjF/oJEw7kg/bownJ1K+D8Qb42CQ==
X-Received: by 2002:ad4:498c:: with SMTP id t12mr12500926qvx.27.1584106899510;
        Fri, 13 Mar 2020 06:41:39 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id x19sm29242486qtm.47.2020.03.13.06.41.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Mar 2020 06:41:39 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jCkZG-0006H8-D1; Fri, 13 Mar 2020 10:41:38 -0300
Date:   Fri, 13 Mar 2020 10:41:38 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next v1 00/12] MR cache fixes and refactoring
Message-ID: <20200313134138.GA24090@ziepe.ca>
References: <20200310082238.239865-1-leon@kernel.org>
 <20200310083531.GA242734@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310083531.GA242734@unreal>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 10, 2020 at 10:35:31AM +0200, Leon Romanovsky wrote:
> + RDMA
> 
> On Tue, Mar 10, 2020 at 10:22:26AM +0200, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@mellanox.com>
> >
> > Changelog:
> >  * v1: Added Saeed's patches.
> >  * v0: https://lore.kernel.org/linux-rdma/20200227123400.97758-1-leon@kernel.org
> >
> > Hi,
> >
> > This series fixes various corner cases in the mlx5_ib MR
> > cache implementation, see specific commit messages for more
> > information.
> >
> > Thanks
> >
> >
> > Jason Gunthorpe (8):
> >   RDMA/mlx5: Rename the tracking variables for the MR cache
> >   RDMA/mlx5: Simplify how the MR cache bucket is located
> >   RDMA/mlx5: Always remove MRs from the cache before destroying them
> >   RDMA/mlx5: Fix MR cache size and limit debugfs
> >   RDMA/mlx5: Lock access to ent->available_mrs/limit when doing
> >     queue_work
> >   RDMA/mlx5: Fix locking in MR cache work queue
> >   RDMA/mlx5: Revise how the hysteresis scheme works for cache filling
> >   RDMA/mlx5: Allow MRs to be created in the cache synchronously
> >
> > Michael Guralnik (1):
> >   {IB,net}/mlx5: Move asynchronous mkey creation to mlx5_ib
> >
> > Saeed Mahameed (3):
> >   {IB,net}/mlx5: Setup mkey variant before mr create command invocation
> >   {IB,net}/mlx5: Assign mkey variant in mlx5_ib only
> >   IB/mlx5: Replace spinlock protected write with atomic var

These seem fine, can you update the shared branch please

Thanks,
Jason
