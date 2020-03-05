Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA7D17A644
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2020 14:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgCENY4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Mar 2020 08:24:56 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33204 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbgCENYz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Mar 2020 08:24:55 -0500
Received: by mail-qt1-f196.google.com with SMTP id d22so4094921qtn.0
        for <linux-rdma@vger.kernel.org>; Thu, 05 Mar 2020 05:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nqBUQbPnvmzlFti1gY5Xro/UBxfPUs7ZUx4BSuFGYxA=;
        b=UtUnViR5TEZ6ddgGxsxytdNrDE0DEVr9/vAXYDOQbSeBZ1eItrLk+tX64TkOXAvkOn
         mH4ZN6wkcK9KeyCyNJSeT4bY18Irv1u2A3LTiP5r47YPibmHvX8nCChQOBEOj2RT0G+W
         555Xbzo9dqERw6nWTEQM6KG9Xpvoj23+bGzCW1FPoRPYR8tGeLTmx0WeVaDpW6fno+gi
         U740MduTWk7AqXSvK/5SVg8gsPJigwW+kDFwZL+l3Y/z8unDrQMrgHvNNWO1bUTuDHI9
         zZlHS9uPHYsqBxMwNY8vHj09F1uXyRdN2GGnxSlNJfywfUs3jv0dDCNtp1/8IGPGGCUR
         ynFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nqBUQbPnvmzlFti1gY5Xro/UBxfPUs7ZUx4BSuFGYxA=;
        b=c7uF5mo6R3RKMU7Flp02PXtH9NkLE9Y+ts2kGO0K1JcnBgwVeUhjo+ngOOaoVrdlQr
         ys0pXb0XsrGLroNAx9B36GRtI+ycpkB/Hw4UganLqILr0iZPPMLSVL2jhaOghQfD4f5t
         +8Va4KEq9E6B1lYFDnJGFYLuNbk+uPpTMcnltO97pSMBcSpr2qkIDx6s/yiYbkixUvkY
         Eg/zFBc+tF9NAlZLobHmFxa4HMz5cI+ipvaufcm8Kxwj8ZhHGew1Guh08/OJfiOrDgjy
         HpbqeAwspepwZWCcbwQHnivaRlOUW+NE3VwNPPa31LryT/8+bvkCHWM03efL2P+Igv5R
         bWUw==
X-Gm-Message-State: ANhLgQ2ZjnKfn+DHZIquarRqSGaoxbaK0fB/kKO7ogBk6hTyIGPI5c8C
        jDu2GAHKlYp2BULaQU6Dgipp3zfeHl4lzQ==
X-Google-Smtp-Source: ADFU+vtYh9VRWHXEHKa87gE1OzgnhSePoe1BZDXlalPkglRh51sj8/6tMU7ZaLRnxTPUBPhbnqLZlw==
X-Received: by 2002:ac8:3017:: with SMTP id f23mr6957591qte.315.1583414694947;
        Thu, 05 Mar 2020 05:24:54 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id v21sm13092312qto.97.2020.03.05.05.24.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Mar 2020 05:24:54 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j9qUf-0004qU-Ec; Thu, 05 Mar 2020 09:24:53 -0400
Date:   Thu, 5 Mar 2020 09:24:53 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Weihang Li <liweihang@huawei.com>, dledford@redhat.com,
        linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH for-next 3/5] RDMA/hns: Optimize the wr opcode conversion
 from ib to hns
Message-ID: <20200305132453.GG31668@ziepe.ca>
References: <1583151093-30402-1-git-send-email-liweihang@huawei.com>
 <1583151093-30402-4-git-send-email-liweihang@huawei.com>
 <20200305061839.GQ121803@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305061839.GQ121803@unreal>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 05, 2020 at 08:18:39AM +0200, Leon Romanovsky wrote:
> On Mon, Mar 02, 2020 at 08:11:31PM +0800, Weihang Li wrote:
> > From: Xi Wang <wangxi11@huawei.com>
> >
> > Simplify the wr opcode conversion from ib to hns by using a map table
> > instead of the switch-case statement.
> >
> > Signed-off-by: Xi Wang <wangxi11@huawei.com>
> > Signed-off-by: Weihang Li <liweihang@huawei.com>
> >  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 70 ++++++++++++++++++------------
> >  1 file changed, 43 insertions(+), 27 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> > index c8c345f..ea61ccb 100644
> > +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> > @@ -56,6 +56,47 @@ static void set_data_seg_v2(struct hns_roce_v2_wqe_data_seg *dseg,
> >  	dseg->len  = cpu_to_le32(sg->length);
> >  }
> >
> > +/*
> > + * mapped-value = 1 + real-value
> > + * The hns wr opcode real value is start from 0, In order to distinguish between
> > + * initialized and uninitialized map values, we plus 1 to the actual value when
> > + * defining the mapping, so that the validity can be identified by checking the
> > + * mapped value is greater than 0.
> > + */
> > +#define HR_OPC_MAP(ib_key, hr_key) \
> > +		[IB_WR_ ## ib_key] = 1 + HNS_ROCE_V2_WQE_OP_ ## hr_key
> > +
> > +static const u32 hns_roce_op_code[] = {
> > +	HR_OPC_MAP(RDMA_WRITE,			RDMA_WRITE),
> > +	HR_OPC_MAP(RDMA_WRITE_WITH_IMM,		RDMA_WRITE_WITH_IMM),
> > +	HR_OPC_MAP(SEND,			SEND),
> > +	HR_OPC_MAP(SEND_WITH_IMM,		SEND_WITH_IMM),
> > +	HR_OPC_MAP(RDMA_READ,			RDMA_READ),
> > +	HR_OPC_MAP(ATOMIC_CMP_AND_SWP,		ATOM_CMP_AND_SWAP),
> > +	HR_OPC_MAP(ATOMIC_FETCH_AND_ADD,	ATOM_FETCH_AND_ADD),
> > +	HR_OPC_MAP(SEND_WITH_INV,		SEND_WITH_INV),
> > +	HR_OPC_MAP(LOCAL_INV,			LOCAL_INV),
> > +	HR_OPC_MAP(MASKED_ATOMIC_CMP_AND_SWP,	ATOM_MSK_CMP_AND_SWAP),
> > +	HR_OPC_MAP(MASKED_ATOMIC_FETCH_AND_ADD,	ATOM_MSK_FETCH_AND_ADD),
> > +	HR_OPC_MAP(REG_MR,			FAST_REG_PMR),
> > +	[IB_WR_RESERVED1] = 0,
> 
> hns_roce_op_code[] is declared as static, everything is initialized to
> 0, there is no need to set 0 again.

It is needed to guarentee the size of the array.

> > +};
> > +
> > +static inline u32 to_hr_opcode(u32 ib_opcode)
> 
> No inline functions in *.c, please.

Did you see CH say this is not such a strong rule apparently?

Jason
