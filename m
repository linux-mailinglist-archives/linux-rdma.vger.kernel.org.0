Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A16A18494C
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2020 15:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgCMO2G (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Mar 2020 10:28:06 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38745 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgCMO2G (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Mar 2020 10:28:06 -0400
Received: by mail-qk1-f195.google.com with SMTP id h14so12768471qke.5
        for <linux-rdma@vger.kernel.org>; Fri, 13 Mar 2020 07:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QDxRGtBPotnHusLsokXNzt33+BRNAwsSiTaokBca4/c=;
        b=DOzNv9sgY3QXXJukooHy/0Yeo0xaExKnaSatRSDL5CX2vltwGm4g9dhx74ynuzH8jl
         f7A/GjXkYv4Hyd4OeXnh8bWF1XQm6WhE5YkiAyKU4YsuwFLrh+gPOrPMpOlLfCpyM8ni
         Tzg7Bg7vSGpdEUk9rB7npQf7Oo38zu4YU18OrhKqDMaiKJAot/cp+MD4a8eGHTqVlxrv
         ot4H65jiUVu65seQPduqvC0DkExn7jsLuX7gDLGthoVOC4hyxB8uAT+oXt8LJNAwCllm
         z7tc7jIHAH9lCwmLfPqHtZfoCjPpUubU0ILyZPj/mEHH1+jNfeuYHRhBqHHPw91w1kdg
         FOxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QDxRGtBPotnHusLsokXNzt33+BRNAwsSiTaokBca4/c=;
        b=eelg4+Tk2Nk4iSqi3BG12ycN0F5U1We1DHNAFcDBdL+h9qImXjV6vWxqDQZYHwy7UQ
         CMxLODdEXDKhLYziV1rrOIW3zfkiQd7PI7onmW8/ljDLxWqFTtxzjKR+kg+av+8+BWxv
         s7+CQrMS3Nzl8vkFTNvXuFmZERRyX/ItkYoCk7INI2EE5g7dnRwYdr7ugwtyqclFGfFK
         uyaxsU7neSnD8IrBTbCkBe7TXz53Pv1t4lWv4jKiEmLVzhDPSqXkoEpJKs146lkKLp0E
         +Epbb9hdzeE7l4Oc54P+vEqdgogPbdWpO28oQwQsKW9IZu3i4oXqzXyRtzC7tXQkbcz5
         dPdA==
X-Gm-Message-State: ANhLgQ1WNv0liz9nKX1weT82ep57P5/Ggnz6ASEuMuI5IYMJTBxcfLh2
        n9YlDkRKXf1wQDL248/uOHHTVEfqlLE=
X-Google-Smtp-Source: ADFU+vtMwBTh3GIfZz8NFgwOmUNAdqlAHYH/CKziwEaFcNZIREOBgojWDwRX+39ldZJh+AMuqYg/Eg==
X-Received: by 2002:a05:620a:22ea:: with SMTP id p10mr13061677qki.75.1584109683985;
        Fri, 13 Mar 2020 07:28:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id m27sm6006960qtf.80.2020.03.13.07.28.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Mar 2020 07:28:03 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jClIB-0002WX-1V; Fri, 13 Mar 2020 11:28:03 -0300
Date:   Fri, 13 Mar 2020 11:28:03 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next v1 00/12] MR cache fixes and refactoring
Message-ID: <20200313142803.GF31668@ziepe.ca>
References: <20200310082238.239865-1-leon@kernel.org>
 <20200310083531.GA242734@unreal>
 <20200313134138.GA24090@ziepe.ca>
 <20200313135026.GG31504@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313135026.GG31504@unreal>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 13, 2020 at 03:50:26PM +0200, Leon Romanovsky wrote:
> On Fri, Mar 13, 2020 at 10:41:38AM -0300, Jason Gunthorpe wrote:
> > On Tue, Mar 10, 2020 at 10:35:31AM +0200, Leon Romanovsky wrote:
> > > + RDMA
> > >
> > > On Tue, Mar 10, 2020 at 10:22:26AM +0200, Leon Romanovsky wrote:
> > > > From: Leon Romanovsky <leonro@mellanox.com>
> > > >
> > > > Changelog:
> > > >  * v1: Added Saeed's patches.
> > > >  * v0: https://lore.kernel.org/linux-rdma/20200227123400.97758-1-leon@kernel.org
> > > >
> > > > Hi,
> > > >
> > > > This series fixes various corner cases in the mlx5_ib MR
> > > > cache implementation, see specific commit messages for more
> > > > information.
> > > >
> > > > Thanks
> > > >
> > > >
> > > > Jason Gunthorpe (8):
> > > >   RDMA/mlx5: Rename the tracking variables for the MR cache
> > > >   RDMA/mlx5: Simplify how the MR cache bucket is located
> > > >   RDMA/mlx5: Always remove MRs from the cache before destroying them
> > > >   RDMA/mlx5: Fix MR cache size and limit debugfs
> > > >   RDMA/mlx5: Lock access to ent->available_mrs/limit when doing
> > > >     queue_work
> > > >   RDMA/mlx5: Fix locking in MR cache work queue
> > > >   RDMA/mlx5: Revise how the hysteresis scheme works for cache filling
> > > >   RDMA/mlx5: Allow MRs to be created in the cache synchronously
> > > >
> > > > Michael Guralnik (1):
> > > >   {IB,net}/mlx5: Move asynchronous mkey creation to mlx5_ib
> > > >
> > > > Saeed Mahameed (3):
> > > >   {IB,net}/mlx5: Setup mkey variant before mr create command invocation
> > > >   {IB,net}/mlx5: Assign mkey variant in mlx5_ib only
> > > >   IB/mlx5: Replace spinlock protected write with atomic var
> >
> > These seem fine, can you update the shared branch please
> 
> Thanks, applied to mlx5-next
> a3cfdd392811 {IB,net}/mlx5: Move asynchronous mkey creation to mlx5_ib
> fc6a9f86f08a {IB,net}/mlx5: Assign mkey variant in mlx5_ib only
> 54c62e13ad76 {IB,net}/mlx5: Setup mkey variant before mr create command invocation

Applied to for-next

Thanks,
Jason
