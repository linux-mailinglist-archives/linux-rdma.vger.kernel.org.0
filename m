Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 037142B8553
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Nov 2020 21:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgKRUHx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Nov 2020 15:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgKRUHx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Nov 2020 15:07:53 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C53C0613D4
        for <linux-rdma@vger.kernel.org>; Wed, 18 Nov 2020 12:07:53 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id n132so3150652qke.1
        for <linux-rdma@vger.kernel.org>; Wed, 18 Nov 2020 12:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1XDH7fJ4rVGATnWwtlCMphw5YU96QLz+frx3iDQUwT4=;
        b=PsDgr16DGqk5ElSp++SMACRWjwYRDECJcS+q+e5S6RzUYIy1pdaUoItC0+hoMSlrhP
         9bUaVrp33EgZWfSppbLNoPIFh+l7q+Wb4vnSXIWA5hwUP2EeD4yuBCHja4yitnX/LkGO
         xD04KoYqdOmAkMD5XZMilMtmPnEKl0Ln9oBLnKMi5z+Im+g68XWeoC9KWdBuj0MvRd9m
         kiUPu8SsO0ObRlmwVS0EYZXH++cy3qwU0WYGRhj2B+XOtsq1isBTpY93cQ4AGzAKjnBp
         pupkh3jdZWZ7epCX7vl5xybHtXs7EcxJzD5IPxTgv90reM3GE9xdK3JbDdVe2spRB2cy
         SE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1XDH7fJ4rVGATnWwtlCMphw5YU96QLz+frx3iDQUwT4=;
        b=Omgc9hwnSyX3EuTyiVkN9RqSTKWwmP66fB4wzqJjIiTpsDaku6hVVySR1zQvxOny2J
         OvgZZcXy1lHdAQjCFi9oaNPTwAXS5ZBbTAbQyljSx1pLchrrP5BcsPM34aVRRXc3PdEX
         TcX7CDBRujTIAVezjHz6bS2bNUG+1q3aigNUl0S5gWVLXCYtDeqyzXn63mM9zmslDjpR
         ty+xAc72vXjMroQGMkGyeL6M4W24kR5Oz4kDDfoRP2drFgyrzPdk2a75iO9zPZDGKpJI
         W4d/OGA9OKDgO3iZK/CRi3TPkDnC/GG4y5+LZ8iIp2ovZ5UorMHUZ8gam3LCMcflKjoF
         DRkA==
X-Gm-Message-State: AOAM531aSoyRO8K29JUlWv58RMNWvT/peEymyVojQjrkdKGZ1D463lNr
        3TLFr6xIThaA0LSqEvslC+1apg==
X-Google-Smtp-Source: ABdhPJx8a/1uAQbue3MeBqYN3bcVRC2mYgL80d2Lcy6n114W9smIgdc1R0Odj3JVaeJOAQ1zGPFvEA==
X-Received: by 2002:a37:9fcc:: with SMTP id i195mr6611473qke.411.1605730072575;
        Wed, 18 Nov 2020 12:07:52 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id m2sm16808332qtu.62.2020.11.18.12.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 12:07:51 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kfTk6-007rJM-Rz; Wed, 18 Nov 2020 16:07:50 -0400
Date:   Wed, 18 Nov 2020 16:07:50 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     liweihang <liweihang@huawei.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v2 for-next 1/2] RDMA/hns: Add support for CQ stash
Message-ID: <20201118200750.GM244516@ziepe.ca>
References: <1605527919-48769-1-git-send-email-liweihang@huawei.com>
 <1605527919-48769-2-git-send-email-liweihang@huawei.com>
 <20201116134645.GL47002@unreal>
 <2692da9a4b814dfa952659a903eb96f0@huawei.com>
 <20201117072034.GO47002@unreal>
 <f688022a7cce488a82ce0d8427a1054e@huawei.com>
 <20201117085011.GQ47002@unreal>
 <18b9cb60c6a34f0995798affec0262c5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18b9cb60c6a34f0995798affec0262c5@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 18, 2020 at 10:49:14AM +0000, liweihang wrote:
> On 2020/11/17 16:50, Leon Romanovsky wrote:
> > On Tue, Nov 17, 2020 at 08:35:55AM +0000, liweihang wrote:
> >> On 2020/11/17 15:21, Leon Romanovsky wrote:
> >>> On Tue, Nov 17, 2020 at 06:37:58AM +0000, liweihang wrote:
> >>>> On 2020/11/16 21:47, Leon Romanovsky wrote:
> >>>>> On Mon, Nov 16, 2020 at 07:58:38PM +0800, Weihang Li wrote:
> >>>>>> From: Lang Cheng <chenglang@huawei.com>
> >>>>>>
> >>>>>> Stash is a mechanism that uses the core information carried by the ARM AXI
> >>>>>> bus to access the L3 cache. It can be used to improve the performance by
> >>>>>> increasing the hit ratio of L3 cache. CQs need to enable stash by default.
> >>>>>>
> >>>>>> Signed-off-by: Lang Cheng <chenglang@huawei.com>
> >>>>>> Signed-off-by: Weihang Li <liweihang@huawei.com>
> >>>>>>  drivers/infiniband/hw/hns/hns_roce_common.h | 12 +++++++++
> >>>>>>  drivers/infiniband/hw/hns/hns_roce_device.h |  1 +
> >>>>>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  3 +++
> >>>>>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  | 39 +++++++++++++++++------------
> >>>>>>  4 files changed, 39 insertions(+), 16 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/infiniband/hw/hns/hns_roce_common.h b/drivers/infiniband/hw/hns/hns_roce_common.h
> >>>>>> index f5669ff..8d96c4e 100644
> >>>>>> +++ b/drivers/infiniband/hw/hns/hns_roce_common.h
> >>>>>> @@ -53,6 +53,18 @@
> >>>>>>  #define roce_set_bit(origin, shift, val) \
> >>>>>>  	roce_set_field((origin), (1ul << (shift)), (shift), (val))
> >>>>>>
> >>>>>> +#define FIELD_LOC(field_h, field_l) field_h, field_l
> >>>>>> +
> >>>>>> +#define _hr_reg_set(arr, field_h, field_l)                                     \
> >>>>>> +	do {                                                                   \
> >>>>>> +		BUILD_BUG_ON(((field_h) / 32) != ((field_l) / 32));            \
> >>>>>> +		BUILD_BUG_ON((field_h) / 32 >= ARRAY_SIZE(arr));               \
> >>>>>> +		(arr)[(field_h) / 32] |=                                       \
> >>>>>> +			cpu_to_le32(GENMASK((field_h) % 32, (field_l) % 32));  \
> >>>>>> +	} while (0)
> >>>>>> +
> >>>>>> +#define hr_reg_set(arr, field) _hr_reg_set(arr, field)
> >>>>>
> >>>>> I afraid that it is too much.
> >>>>
> >>>> Hi Leon,
> >>>>
> >>>> Thanks for the comments.
> >>>>
> >>>>> 1. FIELD_LOC() macro to hide two fields.
> >>>>
> >>>> Jason has suggested us to simplify the function of setting/getting bit/field in
> >>>> hns driver like IBA_SET and IBA_GET.
> >>>>
> >>>> https://patchwork.kernel.org/project/linux-rdma/patch/1589982799-28728-3-git-send-email-liweihang@huawei.com/
> >>>>
> >>>> So we try to make it easier and clearer to define a bitfield for developers.
> >>>
> >>> Jason asked to use genmask and FIELD_PREP, but you invented something else.
> >>>
> >>> Thanks
> >>>
> >>
> >> We use them in another interface 'hr_reg_write(arr, field, val)' which hasn't been
> >> used in this series.
> >>
> >> Does it make any unacceptable mistake? We would appreciate any suggestions :)
> > 
> > The invention of FIELD_LOC() and hr_reg_set equal to __hr_reg_set are unacceptable.
> > Pass directly your field_h and field_l to hr_reg_set().
> > 
> > Thanks
> > 
> 
> Hi Leon,
> 
> We let hr_reg_set equal() to __hr_reg_set() because if not, there will be a compile error:
> 
> .../hns_roce_hw_v2.c:4566:41: error: macro "_hr_reg_set" requires 3 arguments, but only 2 given
> _hr_reg_set(cq_context->raw, CQC_STASH);

Yes, it is very un-intuitive but the rules for CPP require the extra
macro pass to generate the correct expansion. Otherwise cpp will try
to pass the value with commas in as a single argument, what we need
here is to expand the commads first and have them break up into macro
arguments as it goes down the macro chain.

> Let's compare the following implementations:
> 
> 	#define _hr_reg_set(arr, field_h, field_l) \
> 		(arr)[(field_h) / 32] |= \
> 			cpu_to_le32(GENMASK((field_h) % 32, (field_l) % 32)) + \
> 			BUILD_BUG_ON_ZERO(((field_h) / 32) != ((field_l) / 32)) + \
> 			BUILD_BUG_ON_ZERO((field_h) / 32 >= ARRAY_SIZE(arr))
> 
> 1)
> 	#define hr_reg_set(arr, field) _hr_reg_set(arr, field)
> 
> 	#define QPCEX_PASID_EN FIELD_LOC(111, 95)
> 	hr_reg_set(context->ext, QPCEX_PASID_EN);

It is also weird that something called set can only write all ones to
the field.

It feels saner to have a set that accepts a value and if the all ones
case is something very common then use a macro to compute it from the
field name.

Jason
