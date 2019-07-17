Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04FF76C201
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jul 2019 22:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfGQUP3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Jul 2019 16:15:29 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46915 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfGQUP2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 Jul 2019 16:15:28 -0400
Received: by mail-wr1-f65.google.com with SMTP id z1so26140034wru.13
        for <linux-rdma@vger.kernel.org>; Wed, 17 Jul 2019 13:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KdVr0hrnD9zdOsloM2hF/PyC5octG+4dpiuUk9YEW5I=;
        b=lAgK556pLDzu+UUKBFUU1bPFVDYELVTT/EC6JwRNUwr5eXT0h2RpMplHFI3ikhpQCh
         /YWjn74MHR6NvykRsH+TMtUKXFQQKbvjCWhMJTTjhntjIEjMo/5dGhHt/YxuL6E+Czk1
         qljQbr+r6SlCIo14t3ITtQAGVJVwerxTGF4HeQxeuS0Hj/j3CHhO677/SkwnI3TM3MwE
         QyNIsB8AN4e9Kr1YkfqZicnyxaVKhpP07WORGCPCepcwi6luaznr2eCXqjq2+yr6iGbM
         x9LT5v7E5XaCTrr9cdmmYrlUs4epYiP/dlspMH8HeTWXDTA2hCqvfZXrfkTdN4xiY/gN
         r3wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KdVr0hrnD9zdOsloM2hF/PyC5octG+4dpiuUk9YEW5I=;
        b=Xv7YFbd/2KjuWmx7DxhNE+V3he+WGN9emxRIHt7AAUak1Dyf1/8lLuxGcBcMgrA8tl
         DG/6TV0EeaFwQDYX4W1m18BRyI3d4+Tq/1qkv0hfD1z6P8yT0h/sF1fC5woVqhhtz4ug
         hovBZWtoW1AGLG0YT+gKjPsw6K/UeoOYHMdfbSr+AdPU0lTKFtAEr/TXkxFh4ZJ3diWP
         J1DUSlGSHqxNxNNG28kfPUEjSldkaz8mqX2Y1mC6M+KDoNqf3MPOQUOxAApqgGBgkvg2
         g5LkEnsXPn1IkgVSwVEdxg51oSzDc1HU7Ofk18F9SFJ1NLwVjQ/Xdiq6pCIxwUvATpmW
         2GiQ==
X-Gm-Message-State: APjAAAVBZk0zNMZ34PSNv6ZB47ngHo8Ca6lzym5izY53z2v79Yq6fvHQ
        SuOj5jgkBhmK16EnUj9HykA=
X-Google-Smtp-Source: APXvYqxQ3GLO3Pi/njuAmw0mBxVc6fg524yY4DN2eZ4Pbz9C4NNdf1ZIITWplcysrDYNuvh3Y/fIPQ==
X-Received: by 2002:a5d:4950:: with SMTP id r16mr38171187wrs.136.1563394526465;
        Wed, 17 Jul 2019 13:15:26 -0700 (PDT)
Received: from shamir-ThinkPad-X240 (85-250-118-146.bb.netvision.net.il. [85.250.118.146])
        by smtp.gmail.com with ESMTPSA id j10sm24142338wrw.96.2019.07.17.13.15.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Jul 2019 13:15:25 -0700 (PDT)
From:   Shamir Rabinovitch <srabinov7@gmail.com>
X-Google-Original-From: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Date:   Wed, 17 Jul 2019 23:15:21 +0300
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Shamir Rabinovitch <srabinov7@gmail.com>, dledford@redhat.com,
        leon@kernel.org, monis@mellanox.com, parav@mellanox.com,
        danielj@mellanox.com, kamalheib1@gmail.com, markz@mellanox.com,
        swise@opengridcomputing.com, johannes.berg@intel.com,
        willy@infradead.org, michaelgur@mellanox.com, markb@mellanox.com,
        yuval.shaia@oracle.com, dan.carpenter@oracle.com,
        bvanassche@acm.org, maxg@mellanox.com, israelr@mellanox.com,
        galpress@amazon.com, denisd@mellanox.com, yuvalav@mellanox.com,
        dennis.dalessandro@intel.com, will@kernel.org, ereza@mellanox.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH 15/25] IB/uverbs: Add PD import verb
Message-ID: <20190717201521.GB2515@shamir-ThinkPad-X240>
References: <20190716181200.4239-1-srabinov7@gmail.com>
 <20190716181200.4239-16-srabinov7@gmail.com>
 <20190717114432.GB12119@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717114432.GB12119@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 17, 2019 at 08:44:32AM -0300, Jason Gunthorpe wrote:
> On Tue, Jul 16, 2019 at 09:11:50PM +0300, Shamir Rabinovitch wrote:
> >  /*
> >   * Describe the input structs for write(). Some write methods have an input
> >   * only struct, most have an input and output. If the struct has an output then
> > @@ -4015,6 +4105,11 @@ const struct uapi_definition uverbs_def_write_intf[] = {
> >  			UAPI_DEF_WRITE_IO(struct ib_uverbs_query_port,
> >  					  struct ib_uverbs_query_port_resp),
> >  			UAPI_DEF_METHOD_NEEDS_FN(query_port)),
> > +		DECLARE_UVERBS_WRITE(
> > +			IB_USER_VERBS_CMD_IMPORT_FR_FD,
> > +			ib_uverbs_import_fr_fd,
> > +			UAPI_DEF_WRITE_IO(struct ib_uverbs_import_fr_fd,
> > +					  union
> > ib_uverbs_import_fr_fd_resp)),
> 
> New non-ioctl interfaces are not allowed now
> 
> Jason

Oh. Can you suggest commit(s) that can be used as ref for new ioctl in rdma & rdma-core ?

Thanks
