Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 086C817A77D
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2020 15:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgCEOdK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Mar 2020 09:33:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:60420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbgCEOdK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 5 Mar 2020 09:33:10 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15CA520732;
        Thu,  5 Mar 2020 14:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583418789;
        bh=TY2siLs/zWYI3rCWsT5rsWL2ssBDPjuTa9fK+pS9m7U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bCiLdKj4oxUxMxEd9r0ATr5LuTi6+MldZaovP1IwdLjGfJBVwRhwuuo0uVvCatqRz
         qFhrcKYS8szXtWMFjrZU6VcsUgV/mPXAy7iEqAnBmI31+w6JrLGGFrE8XIJ8K+ThBr
         NTlav+9Tnk3D3zd54be1VPmEQTGyl60Z9lw97E/A=
Date:   Thu, 5 Mar 2020 16:33:06 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Weihang Li <liweihang@huawei.com>, dledford@redhat.com,
        linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH for-next 3/5] RDMA/hns: Optimize the wr opcode conversion
 from ib to hns
Message-ID: <20200305143306.GH184088@unreal>
References: <1583151093-30402-1-git-send-email-liweihang@huawei.com>
 <1583151093-30402-4-git-send-email-liweihang@huawei.com>
 <20200305061839.GQ121803@unreal>
 <20200305132453.GG31668@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305132453.GG31668@ziepe.ca>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 05, 2020 at 09:24:53AM -0400, Jason Gunthorpe wrote:
> On Thu, Mar 05, 2020 at 08:18:39AM +0200, Leon Romanovsky wrote:
> > On Mon, Mar 02, 2020 at 08:11:31PM +0800, Weihang Li wrote:
> > > From: Xi Wang <wangxi11@huawei.com>
> > >
> > > Simplify the wr opcode conversion from ib to hns by using a map table
> > > instead of the switch-case statement.
> > >
> > > Signed-off-by: Xi Wang <wangxi11@huawei.com>
> > > Signed-off-by: Weihang Li <liweihang@huawei.com>
> > >  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 70 ++++++++++++++++++------------
> > >  1 file changed, 43 insertions(+), 27 deletions(-)
> > >
> > > diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> > > index c8c345f..ea61ccb 100644
> > > +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> > > @@ -56,6 +56,47 @@ static void set_data_seg_v2(struct hns_roce_v2_wqe_data_seg *dseg,
> > >  	dseg->len  = cpu_to_le32(sg->length);
> > >  }
> > >
> > > +/*
> > > + * mapped-value = 1 + real-value
> > > + * The hns wr opcode real value is start from 0, In order to distinguish between
> > > + * initialized and uninitialized map values, we plus 1 to the actual value when
> > > + * defining the mapping, so that the validity can be identified by checking the
> > > + * mapped value is greater than 0.
> > > + */
> > > +#define HR_OPC_MAP(ib_key, hr_key) \
> > > +		[IB_WR_ ## ib_key] = 1 + HNS_ROCE_V2_WQE_OP_ ## hr_key
> > > +
> > > +static const u32 hns_roce_op_code[] = {
> > > +	HR_OPC_MAP(RDMA_WRITE,			RDMA_WRITE),
> > > +	HR_OPC_MAP(RDMA_WRITE_WITH_IMM,		RDMA_WRITE_WITH_IMM),
> > > +	HR_OPC_MAP(SEND,			SEND),
> > > +	HR_OPC_MAP(SEND_WITH_IMM,		SEND_WITH_IMM),
> > > +	HR_OPC_MAP(RDMA_READ,			RDMA_READ),
> > > +	HR_OPC_MAP(ATOMIC_CMP_AND_SWP,		ATOM_CMP_AND_SWAP),
> > > +	HR_OPC_MAP(ATOMIC_FETCH_AND_ADD,	ATOM_FETCH_AND_ADD),
> > > +	HR_OPC_MAP(SEND_WITH_INV,		SEND_WITH_INV),
> > > +	HR_OPC_MAP(LOCAL_INV,			LOCAL_INV),
> > > +	HR_OPC_MAP(MASKED_ATOMIC_CMP_AND_SWP,	ATOM_MSK_CMP_AND_SWAP),
> > > +	HR_OPC_MAP(MASKED_ATOMIC_FETCH_AND_ADD,	ATOM_MSK_FETCH_AND_ADD),
> > > +	HR_OPC_MAP(REG_MR,			FAST_REG_PMR),
> > > +	[IB_WR_RESERVED1] = 0,
> >
> > hns_roce_op_code[] is declared as static, everything is initialized to
> > 0, there is no need to set 0 again.
>
> It is needed to guarentee the size of the array.

Not really, it depends on their implementation of to_hr_opcode().

>
> > > +};
> > > +
> > > +static inline u32 to_hr_opcode(u32 ib_opcode)
> >
> > No inline functions in *.c, please.
>
> Did you see CH say this is not such a strong rule apparently?

Yes, he talked about container_of which makes sense.

>
> Jason
