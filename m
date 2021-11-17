Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54D7C4548A3
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Nov 2021 15:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237093AbhKQO1U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Nov 2021 09:27:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:47934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238530AbhKQO1H (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 17 Nov 2021 09:27:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 409EA6128A;
        Wed, 17 Nov 2021 14:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637159045;
        bh=5HzsIfrZ/Q6DDJao6tFMMf0uVurEmjDdLX4zHyxDW7s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o5tPqXsXldp0QXR9WDA68C3tEmAgmMl6ImyaOZ24TmN+rQp2LErGB9W/GJEPQ3TQ3
         txth+16KOgUV2Pgv8Sp4HV1bKFgMqSYPDiud7Nt4Rk3KVlnGFkxoz8VAzVeMmhfx8F
         h9GqjyHwkuG3xlc5uiO5qnTL1WwFtAt+EPONVqyrAyBj/TTNV18snkrUr27lHKOvNT
         cbXRQTQQiDPOqNg4yCnyZ6vKLsY92CPFu38GWbCa8T5sNd+OVdi6q6SA69VYIKseU7
         KcdFvM77MGkKE/AUItR7fbdCbKJ3At8uH9QttoZKHkJNeQpLsPHuUskS27VZ0gxh3w
         wybJ0iVl/03cg==
Date:   Wed, 17 Nov 2021 16:24:00 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH v2 rdma-core 1/2] Update kernel headers
Message-ID: <YZUQgOCq1ENw8Uy0@unreal>
References: <20211116150316.21925-1-liangwenpeng@huawei.com>
 <20211116150316.21925-2-liangwenpeng@huawei.com>
 <0fc3c207-afaa-7f64-3f93-d633b7ba5636@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0fc3c207-afaa-7f64-3f93-d633b7ba5636@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 16, 2021 at 11:31:00PM +0800, Wenpeng Liang wrote:
> 
> On 2021/11/16 23:03, Wenpeng Liang wrote:
> > To commit ?? ("RDMA/hns: Support direct wqe of userspace").
> > 
> > Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
> > ---
> >  kernel-headers/rdma/hns-abi.h       |  2 ++
> >  kernel-headers/rdma/rdma_netlink.h  |  5 +++++
> >  kernel-headers/rdma/rdma_user_rxe.h | 14 +++++++++++---
> >  3 files changed, 18 insertions(+), 3 deletions(-)
> 
> Hi Leon,
> 
> I have encountered a problem and I hope to master a correct
> submission method.
> 
> This user space patch modifies the hns-abi.h file, so I use the
> python command to generate the patch to keep the kernel-headers
> consistent with the kernel mode:
> 
> python3.5 kernel-headers/update --not-final <kernel space dir> <commitID>
> 
> In addition to the modification of hns-abi.h, the generated patch
> also involves the modification of other files. And resulted in the
> following compilation error:
> 
> /rdma-core/providers/rxe/rxe.c: In function ‘rxe_post_one_recv’:
> /rdma-core/providers/rxe/rxe.c:712:17: error: ‘struct rxe_dma_info’ has no member named ‘sge’
>    712 | memcpy(wqe->dma.sge, recv_wr->sg_list,
>        | ^
> /rdma-core/providers/rxe/rxe.c:713:38: error: ‘struct rxe_dma_info’ has no member named ‘sge’
>    713 | wqe->num_sge*sizeof(*wqe->dma.sge));
> 
> In this case, what is the correct way to submit the patch? Should
> I wait for the rxe patch submission to complete before submitting
> this patchset, or submit only the hns part of the patch generated
> by python?

Please wait a couple of days, we will fix Jason's PR and I will release
rdma-core, so you will be able to submit without errors.

Thanks

> 
> Thanks,
> Wenpeng
