Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7382B5A34
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Nov 2020 08:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbgKQHUk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Nov 2020 02:20:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:40334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbgKQHUj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 17 Nov 2020 02:20:39 -0500
Received: from localhost (thunderhill.nvidia.com [216.228.112.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 766302468B;
        Tue, 17 Nov 2020 07:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605597639;
        bh=chq9ZKJTI/5W8frtRHIQ6xy0l8tLN9znqYl+iNUMYPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QEW6eSO+MNOTBRnUxQELdVvDrGKgBVpwrdDgjBfd2ytYunXszAHeybxrAg6pohCyE
         JUfTs2q5B3nUi8+flRBfBJhRb3a+WtTz8eIDKrnVwcyoW4wnVrAWPhV7PMzFqjZZK1
         i6z7Shv8jXy472NmVLXRwHgvpLxDmDcK0jG9LaXk=
Date:   Tue, 17 Nov 2020 09:20:34 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     liweihang <liweihang@huawei.com>
Cc:     "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v2 for-next 1/2] RDMA/hns: Add support for CQ stash
Message-ID: <20201117072034.GO47002@unreal>
References: <1605527919-48769-1-git-send-email-liweihang@huawei.com>
 <1605527919-48769-2-git-send-email-liweihang@huawei.com>
 <20201116134645.GL47002@unreal>
 <2692da9a4b814dfa952659a903eb96f0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2692da9a4b814dfa952659a903eb96f0@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 17, 2020 at 06:37:58AM +0000, liweihang wrote:
> On 2020/11/16 21:47, Leon Romanovsky wrote:
> > On Mon, Nov 16, 2020 at 07:58:38PM +0800, Weihang Li wrote:
> >> From: Lang Cheng <chenglang@huawei.com>
> >>
> >> Stash is a mechanism that uses the core information carried by the ARM AXI
> >> bus to access the L3 cache. It can be used to improve the performance by
> >> increasing the hit ratio of L3 cache. CQs need to enable stash by default.
> >>
> >> Signed-off-by: Lang Cheng <chenglang@huawei.com>
> >> Signed-off-by: Weihang Li <liweihang@huawei.com>
> >> ---
> >>  drivers/infiniband/hw/hns/hns_roce_common.h | 12 +++++++++
> >>  drivers/infiniband/hw/hns/hns_roce_device.h |  1 +
> >>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  3 +++
> >>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  | 39 +++++++++++++++++------------
> >>  4 files changed, 39 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/drivers/infiniband/hw/hns/hns_roce_common.h b/drivers/infiniband/hw/hns/hns_roce_common.h
> >> index f5669ff..8d96c4e 100644
> >> --- a/drivers/infiniband/hw/hns/hns_roce_common.h
> >> +++ b/drivers/infiniband/hw/hns/hns_roce_common.h
> >> @@ -53,6 +53,18 @@
> >>  #define roce_set_bit(origin, shift, val) \
> >>  	roce_set_field((origin), (1ul << (shift)), (shift), (val))
> >>
> >> +#define FIELD_LOC(field_h, field_l) field_h, field_l
> >> +
> >> +#define _hr_reg_set(arr, field_h, field_l)                                     \
> >> +	do {                                                                   \
> >> +		BUILD_BUG_ON(((field_h) / 32) != ((field_l) / 32));            \
> >> +		BUILD_BUG_ON((field_h) / 32 >= ARRAY_SIZE(arr));               \
> >> +		(arr)[(field_h) / 32] |=                                       \
> >> +			cpu_to_le32(GENMASK((field_h) % 32, (field_l) % 32));  \
> >> +	} while (0)
> >> +
> >> +#define hr_reg_set(arr, field) _hr_reg_set(arr, field)
> >
> > I afraid that it is too much.
>
> Hi Leon,
>
> Thanks for the comments.
>
> > 1. FIELD_LOC() macro to hide two fields.
>
> Jason has suggested us to simplify the function of setting/getting bit/field in
> hns driver like IBA_SET and IBA_GET.
>
> https://patchwork.kernel.org/project/linux-rdma/patch/1589982799-28728-3-git-send-email-liweihang@huawei.com/
>
> So we try to make it easier and clearer to define a bitfield for developers.

Jason asked to use genmask and FIELD_PREP, but you invented something else.

Thanks
