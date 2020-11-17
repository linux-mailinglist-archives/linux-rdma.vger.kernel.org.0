Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7192B5B43
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Nov 2020 09:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgKQIuR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Nov 2020 03:50:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:55874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbgKQIuR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 17 Nov 2020 03:50:17 -0500
Received: from localhost (thunderhill.nvidia.com [216.228.112.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3CDF2225E;
        Tue, 17 Nov 2020 08:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605603016;
        bh=aYTVVs+0OrCIXimh9iWn6oYZNlG7Q/OY9Uwo8hFAlv0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vBYBRFDdxnALiCtmn9yOhCkz3VTqGt1uckxZ35BRWIkjDiW2eV86MtyAfPNCVqbuk
         rcGE0DV6Zv/yt1gvWvgoN5SLE0kJypOf86dBMwjc1w0eO+eup+RbHZbRl8KBMrMeE7
         pecHtGCRtY5kwizIlQJQkTvNzk6K1hoYhYL03MlM=
Date:   Tue, 17 Nov 2020 10:50:11 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     liweihang <liweihang@huawei.com>
Cc:     "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v2 for-next 1/2] RDMA/hns: Add support for CQ stash
Message-ID: <20201117085011.GQ47002@unreal>
References: <1605527919-48769-1-git-send-email-liweihang@huawei.com>
 <1605527919-48769-2-git-send-email-liweihang@huawei.com>
 <20201116134645.GL47002@unreal>
 <2692da9a4b814dfa952659a903eb96f0@huawei.com>
 <20201117072034.GO47002@unreal>
 <f688022a7cce488a82ce0d8427a1054e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f688022a7cce488a82ce0d8427a1054e@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 17, 2020 at 08:35:55AM +0000, liweihang wrote:
> On 2020/11/17 15:21, Leon Romanovsky wrote:
> > On Tue, Nov 17, 2020 at 06:37:58AM +0000, liweihang wrote:
> >> On 2020/11/16 21:47, Leon Romanovsky wrote:
> >>> On Mon, Nov 16, 2020 at 07:58:38PM +0800, Weihang Li wrote:
> >>>> From: Lang Cheng <chenglang@huawei.com>
> >>>>
> >>>> Stash is a mechanism that uses the core information carried by the ARM AXI
> >>>> bus to access the L3 cache. It can be used to improve the performance by
> >>>> increasing the hit ratio of L3 cache. CQs need to enable stash by default.
> >>>>
> >>>> Signed-off-by: Lang Cheng <chenglang@huawei.com>
> >>>> Signed-off-by: Weihang Li <liweihang@huawei.com>
> >>>> ---
> >>>>  drivers/infiniband/hw/hns/hns_roce_common.h | 12 +++++++++
> >>>>  drivers/infiniband/hw/hns/hns_roce_device.h |  1 +
> >>>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  3 +++
> >>>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  | 39 +++++++++++++++++------------
> >>>>  4 files changed, 39 insertions(+), 16 deletions(-)
> >>>>
> >>>> diff --git a/drivers/infiniband/hw/hns/hns_roce_common.h b/drivers/infiniband/hw/hns/hns_roce_common.h
> >>>> index f5669ff..8d96c4e 100644
> >>>> --- a/drivers/infiniband/hw/hns/hns_roce_common.h
> >>>> +++ b/drivers/infiniband/hw/hns/hns_roce_common.h
> >>>> @@ -53,6 +53,18 @@
> >>>>  #define roce_set_bit(origin, shift, val) \
> >>>>  	roce_set_field((origin), (1ul << (shift)), (shift), (val))
> >>>>
> >>>> +#define FIELD_LOC(field_h, field_l) field_h, field_l
> >>>> +
> >>>> +#define _hr_reg_set(arr, field_h, field_l)                                     \
> >>>> +	do {                                                                   \
> >>>> +		BUILD_BUG_ON(((field_h) / 32) != ((field_l) / 32));            \
> >>>> +		BUILD_BUG_ON((field_h) / 32 >= ARRAY_SIZE(arr));               \
> >>>> +		(arr)[(field_h) / 32] |=                                       \
> >>>> +			cpu_to_le32(GENMASK((field_h) % 32, (field_l) % 32));  \
> >>>> +	} while (0)
> >>>> +
> >>>> +#define hr_reg_set(arr, field) _hr_reg_set(arr, field)
> >>>
> >>> I afraid that it is too much.
> >>
> >> Hi Leon,
> >>
> >> Thanks for the comments.
> >>
> >>> 1. FIELD_LOC() macro to hide two fields.
> >>
> >> Jason has suggested us to simplify the function of setting/getting bit/field in
> >> hns driver like IBA_SET and IBA_GET.
> >>
> >> https://patchwork.kernel.org/project/linux-rdma/patch/1589982799-28728-3-git-send-email-liweihang@huawei.com/
> >>
> >> So we try to make it easier and clearer to define a bitfield for developers.
> >
> > Jason asked to use genmask and FIELD_PREP, but you invented something else.
> >
> > Thanks
> >
>
> We use them in another interface 'hr_reg_write(arr, field, val)' which hasn't been
> used in this series.
>
> Does it make any unacceptable mistake? We would appreciate any suggestions :)

The invention of FIELD_LOC() and hr_reg_set equal to __hr_reg_set are unacceptable.
Pass directly your field_h and field_l to hr_reg_set().

Thanks


>
> Thanks
> Weihang
>
>
