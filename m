Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD5490479
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Aug 2019 17:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfHPPOy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Aug 2019 11:14:54 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37335 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbfHPPOy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Aug 2019 11:14:54 -0400
Received: by mail-qk1-f194.google.com with SMTP id s14so5046928qkm.4
        for <linux-rdma@vger.kernel.org>; Fri, 16 Aug 2019 08:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fov2CgaO1O1CFkZX4IfqnTZnTK7C3zpSvYgzXGSY56g=;
        b=oy5sZFjQp1BCVaEwQsb3+KNPFbSHSZHWPBMzBnqM3YkM8M6TeLN/TchFjkEdsICSuJ
         1C+Aqtldy/Y4ldUDXhcLTuhfNncF7+Dyd3fNJ1bom3uP8hS9LridrmdEdsAQXWEZtKjz
         7XP3pkdVorvFX0x7VQ1DMygwaFOvfV+UwasgUORcn3BEim4b1kFT8oE06M97uDUrjOv5
         mMHA/Z8hsM7HRGW+maHrZQD/1QDaaYGCk/ab/4r4vI2lVu52wx2id8gV5icj3phd9BLt
         KUOXu736r5AT7W/9wY/TxeK4Ryn6yfFSyNCnwDYASLlBBEV0NjKDADW49yLgEKf3SWZn
         2lUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fov2CgaO1O1CFkZX4IfqnTZnTK7C3zpSvYgzXGSY56g=;
        b=Xdq78wYPryChyLBNCdQ1FQWIRevrhvnbM8IU1WDxCPB9XC/PHKustqQ++yiakfSWgX
         NsMfjBvbZ+vmKz9nuxKAGe1p/eRlOY0cPJVvmRgrGNdpL3P6D72Cwf2LMa1Idbrwc8bH
         SmynANPiAiuV8vDBtJSxMzBh6GHuo5+ImdvQKgIylWLhGEP6WsPnEatGYAmmf0nQjPfS
         PqfHoslIsT3VZo+aUWsfxbq527SX7/DqzWqmwBvo43zK4DD29WVrd/Y/42QZMbrLVR82
         mlFWzxDcQVJ3S9exwjVpNIsZ+CWikqempZ6rBNkA3y6KsIrGfLSt8Ww0fw2uPV6jE7hN
         xPxw==
X-Gm-Message-State: APjAAAVws8sPXXPLoFMINAH4IoAiHHyDrf4l2gMMHfioe7dLhE7niTC7
        FVRdQ9HNT5YTMlr8VuxgkSZEIQ==
X-Google-Smtp-Source: APXvYqxJQYOJO15q7RlRP/vufAQqFSxN3g0+gtugu+v5p95C5icfuXRjyKSuaK0zmQH83GKJGhGMfA==
X-Received: by 2002:a05:620a:1590:: with SMTP id d16mr9385834qkk.18.1565968493491;
        Fri, 16 Aug 2019 08:14:53 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id o127sm3158342qkd.104.2019.08.16.08.14.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Aug 2019 08:14:53 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hydwK-0003JY-LJ; Fri, 16 Aug 2019 12:14:52 -0300
Date:   Fri, 16 Aug 2019 12:14:52 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-mm@kvack.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Dimitri Sivanich <sivanich@sgi.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        iommu@lists.linux-foundation.org, intel-gfx@lists.freedesktop.org,
        Gavin Shan <shangw@linux.vnet.ibm.com>,
        Andrea Righi <andrea@betterlinux.com>
Subject: Re: [PATCH v3 hmm 00/11] Add mmu_notifier_get/put for managing mmu
 notifier registrations
Message-ID: <20190816151452.GA8562@ziepe.ca>
References: <20190806231548.25242-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806231548.25242-1-jgg@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 06, 2019 at 08:15:37PM -0300, Jason Gunthorpe wrote:
> This series is already entangled with patches in the hmm & RDMA tree and
> will require some git topic branches for the RDMA ODP stuff. I intend for
> it to go through the hmm tree.

> Jason Gunthorpe (11):
>   mm/mmu_notifiers: hoist do_mmu_notifier_register down_write to the
>     caller
>   mm/mmu_notifiers: do not speculatively allocate a mmu_notifier_mm
>   mm/mmu_notifiers: add a get/put scheme for the registration
>   misc/sgi-gru: use mmu_notifier_get/put for struct gru_mm_struct
>   hmm: use mmu_notifier_get/put for 'struct hmm'
>   drm/radeon: use mmu_notifier_get/put for struct radeon_mn
>   drm/amdkfd: fix a use after free race with mmu_notifer unregister
>   drm/amdkfd: use mmu_notifier_put

Other than these patches:

>   RDMA/odp: use mmu_notifier_get/put for 'struct ib_ucontext_per_mm'
>   RDMA/odp: remove ib_ucontext from ib_umem
>   mm/mmu_notifiers: remove unregister_no_release

This series has been applied.

I will apply the ODP patches when the series they depend on is merged
to the RDMA tree

Any further acks/remarks I will annotate, thanks in advance

Thanks to all reviewers,
Jason
