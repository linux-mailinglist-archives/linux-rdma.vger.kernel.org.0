Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 157B217A771
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2020 15:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgCEOaa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Mar 2020 09:30:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:59782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbgCEOaa (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 5 Mar 2020 09:30:30 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1348520732;
        Thu,  5 Mar 2020 14:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583418629;
        bh=E2f2xSzo/HlifBc9VivsPpM5+fmIduPR+EM3kwQofRE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SMHCUWQxRHChxqfsIN9jvpIpRys1XToGqY019i1OAI9BdMV0kIJ/8hVcTMGhVFZEk
         YrRSpNN0k1/oKTKDMkLuHBi1FHn8AeEI/aHIWtqysqtzp9Ru0e8/baQV+V3p0NqZ7k
         dBF/+346XrWA0yrnQfriVTs0QOnZ3O36R1SM3bmw=
Date:   Thu, 5 Mar 2020 16:30:26 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     liweihang <liweihang@huawei.com>
Cc:     "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH for-next 3/5] RDMA/hns: Optimize the wr opcode conversion
 from ib to hns
Message-ID: <20200305143026.GG184088@unreal>
References: <1583151093-30402-1-git-send-email-liweihang@huawei.com>
 <1583151093-30402-4-git-send-email-liweihang@huawei.com>
 <20200305061839.GQ121803@unreal>
 <B82435381E3B2943AA4D2826ADEF0B3A02274225@DGGEML522-MBX.china.huawei.com>
 <20200305120911.GC184088@unreal>
 <B82435381E3B2943AA4D2826ADEF0B3A022743C5@DGGEML522-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B82435381E3B2943AA4D2826ADEF0B3A022743C5@DGGEML522-MBX.china.huawei.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 05, 2020 at 01:28:28PM +0000, liweihang wrote:
> On 2020/3/5 20:09, Leon Romanovsky wrote:
> > On Thu, Mar 05, 2020 at 11:22:18AM +0000, liweihang wrote:
> >> On 2020/3/5 14:18, Leon Romanovsky wrote:
> >>> On Mon, Mar 02, 2020 at 08:11:31PM +0800, Weihang Li wrote:
> >>>> From: Xi Wang <wangxi11@huawei.com>
> >>>>
> >>>> Simplify the wr opcode conversion from ib to hns by using a map table
> >>>> instead of the switch-case statement.
> >>>>
> >>>> Signed-off-by: Xi Wang <wangxi11@huawei.com>
> >>>> Signed-off-by: Weihang Li <liweihang@huawei.com>
> >>>> ---
> >>>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 70 ++++++++++++++++++------------
> >>>>  1 file changed, 43 insertions(+), 27 deletions(-)
> >>>>
> >>>> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> >>>> index c8c345f..ea61ccb 100644
> >>>> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> >>>> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> >>>> @@ -56,6 +56,47 @@ static void set_data_seg_v2(struct hns_roce_v2_wqe_data_seg *dseg,
> >>>>  	dseg->len  = cpu_to_le32(sg->length);
> >>>>  }
> >>>>
> >>>> +/*
> >>>> + * mapped-value = 1 + real-value
> >>>> + * The hns wr opcode real value is start from 0, In order to distinguish between
> >>>> + * initialized and uninitialized map values, we plus 1 to the actual value when
> >>>> + * defining the mapping, so that the validity can be identified by checking the
> >>>> + * mapped value is greater than 0.
> >>>> + */
> >>>> +#define HR_OPC_MAP(ib_key, hr_key) \
> >>>> +		[IB_WR_ ## ib_key] = 1 + HNS_ROCE_V2_WQE_OP_ ## hr_key
> >>>> +
> >>>> +static const u32 hns_roce_op_code[] = {
> >>>> +	HR_OPC_MAP(RDMA_WRITE,			RDMA_WRITE),
> >>>> +	HR_OPC_MAP(RDMA_WRITE_WITH_IMM,		RDMA_WRITE_WITH_IMM),
> >>>> +	HR_OPC_MAP(SEND,			SEND),
> >>>> +	HR_OPC_MAP(SEND_WITH_IMM,		SEND_WITH_IMM),
> >>>> +	HR_OPC_MAP(RDMA_READ,			RDMA_READ),
> >>>> +	HR_OPC_MAP(ATOMIC_CMP_AND_SWP,		ATOM_CMP_AND_SWAP),
> >>>> +	HR_OPC_MAP(ATOMIC_FETCH_AND_ADD,	ATOM_FETCH_AND_ADD),
> >>>> +	HR_OPC_MAP(SEND_WITH_INV,		SEND_WITH_INV),
> >>>> +	HR_OPC_MAP(LOCAL_INV,			LOCAL_INV),
> >>>> +	HR_OPC_MAP(MASKED_ATOMIC_CMP_AND_SWP,	ATOM_MSK_CMP_AND_SWAP),
> >>>> +	HR_OPC_MAP(MASKED_ATOMIC_FETCH_AND_ADD,	ATOM_MSK_FETCH_AND_ADD),
> >>>> +	HR_OPC_MAP(REG_MR,			FAST_REG_PMR),
> >>>> +	[IB_WR_RESERVED1] = 0,
> >>>
> >>> hns_roce_op_code[] is declared as static, everything is initialized to
> >>> 0, there is no need to set 0 again.
> >>
> >> OK, thank you.
> >>
> >>>
> >>>> +};
> >>>> +
> >>>> +static inline u32 to_hr_opcode(u32 ib_opcode)
> >>>
> >>> No inline functions in *.c, please.
> >>
> >> Hi Leon,
> >>
> >> Thanks for your comments.
> >>
> >> But I'm confused about when we should use static inline and when we should
> >> use macros if a function is only used in a *.c. A few days ago, Jason
> >> suggested me to use static inline functions, you can check the link below:
> >>
> >> https://patchwork.kernel.org/patch/11372851/
> >>
> >> Are there any rules about that in kernel or in our rdma subsystem? Should
> >> I use a macro, just remove the keyword "inline" from this definition or
> >> move this definition to .h?
> >
> > Just drop "inline" word from the declaration.
> > https://elixir.bootlin.com/linux/latest/source/Documentation/process/coding-style.rst#L882
> >
> >>
> >>>
> >>>> +{
> >>>> +	u32 hr_opcode = 0;
> >>>> +
> >>>> +	if (ib_opcode < IB_WR_RESERVED1)
> >>>
> >>> if (ib_opcode > ARRAY_SIZE(hns_roce_op_code) - 1)
> >>> 	return HNS_ROCE_V2_WQE_OP_MASK;
> >>>
> >>> return hns_roce_op_code[ib_opcode];
> >>>
> >>
> >> The index of ib_key in hns_roce_op_code[] is not continuous, so there
> >> are some invalid ib_wr_opcode for hns between the valid index.
> >>
> >> For hardware of HIP08, HNS_ROCE_V2_WQE_OP_MASK means invalid opcode but
> >> not zero. So we have to check if the ib_wr_opcode has a mapping value in
> >> hns_roce_op_code[], and if the mapping result is zero, we have to return
> >> HNS_ROCE_V2_WQE_OP_MASK. Is it ok like this?
> >
> > I didn't mean that you will use my code as is, what about this?
> >
> > if (ib_opcode > ARRAY_SIZE(hns_roce_op_code) - 1)
> >  	return HNS_ROCE_V2_WQE_OP_MASK;
> >
> > return hns_roce_op_code[ib_opcode] ?: HNS_ROCE_V2_WQE_OP_MASK;
> >
> > Thanks
> >
>
> One more question, should I add a Reviewed-by tag for anyone who has comments
> on my patch, or I should only do this when the reviewer asked me to do it?
>
> For example, should I add a reviewed-by tag for you in this patch? Thank you :)

Yes, please.

The words "Reviewed .../ Acked ..." are the actual request to add.

Thanks
