Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3562B4A52
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Nov 2020 17:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731287AbgKPQJc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Nov 2020 11:09:32 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:40654 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730679AbgKPQJc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 16 Nov 2020 11:09:32 -0500
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fb2a43a0001>; Tue, 17 Nov 2020 00:09:30 +0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 16 Nov
 2020 16:09:26 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.55) by
 HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 16 Nov 2020 16:09:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQhqcswYmf44eA80DKhm3hIq+wzw5XwWEQGQvu9qXrQF+ZWf70ET0KfG5ikDBBjGLjpVtNINotJbQ9VsoiQMRNxPVp01EMKAYbQzCa0cFlJtM1VtdowsbeA3hTumobxntIKdemBmAUkpFJLIWmTOhiXCDMdZ3K31nbQgV0vGUKXU1NDzusTadr+9C6biRXc2frTxHvQzNDoSR4TUQvMsMAILZ889kjWa6MlYn+xj1RQZKlD/Dx1cV5hUWnkgQeHXTBYGHxiL5AgvAiE9MQ7ScLycUnnwcuxwvPBeRVcLb2GkHuL3FjbbZAgFUiqez56A/eipvRsCKn32/PeTwSHCWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PmHj6fh69F3aR0asTX4fWHx+8a1oZpDGFL1jwiQFxH4=;
 b=KDh41pz8oX/KZMqhMoVUOr3ulRFzcAxTnRsBBap0yhj5gD0rSHUP+XRxtmkJvPlu4kcwmgZsb8gk1tHx2dHdfR22qYrQuoKK26j94dRjAetr8diUSivnUbnVgGzy5cmF+Xo5mL2oHrfk2Fxk0TzULk0RdVsM0h7R68dZhr1skUS4cluJNOnneuIsV7FvLj4XTUORDYJrwmo+swXoHmQ/6jV3RIQYO7216nouJE3BQd9d/LteNgkuH+TRpjOOFB91tlaxDiYOv44HKPf7w1eyJDeNUhcBxTSG7OSQ3aQCR94L+wrRPT5tE/McP67I+ohEqgLXc5bzHEVjeQS1QyyCqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3211.namprd12.prod.outlook.com (2603:10b6:5:15c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Mon, 16 Nov
 2020 16:09:23 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9%7]) with mapi id 15.20.3564.028; Mon, 16 Nov 2020
 16:09:23 +0000
Date:   Mon, 16 Nov 2020 12:09:22 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     liweihang <liweihang@huawei.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH for-next 4/8] RDMA/hns: Add check for the validity of sl
 configuration in UD SQ WQE
Message-ID: <20201116160922.GM917484@nvidia.com>
References: <1604057975-23388-1-git-send-email-liweihang@huawei.com>
 <1604057975-23388-5-git-send-email-liweihang@huawei.com>
 <20201112183245.GA963928@nvidia.com>
 <5100fe6771d24c3e83fc401e490ce4fa@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5100fe6771d24c3e83fc401e490ce4fa@huawei.com>
X-ClientProxiedBy: BL0PR02CA0100.namprd02.prod.outlook.com
 (2603:10b6:208:51::41) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR02CA0100.namprd02.prod.outlook.com (2603:10b6:208:51::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28 via Frontend Transport; Mon, 16 Nov 2020 16:09:23 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1keh4E-006FJS-4T; Mon, 16 Nov 2020 12:09:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605542970; bh=PmHj6fh69F3aR0asTX4fWHx+8a1oZpDGFL1jwiQFxH4=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=XmLwxauIJZGn6z+WQzQPIvQKLoCpnzNLunlIbv0eJumNNSNVERDqhxBXGCYr/6tCk
         v4jCiYJjfZtcLHCutX7TkWvU8OwQL/ZifRTIAIHmh2HyCDla5AEphgBevz97QO/I5f
         HExzKX4o28mSAb5u14Hb59pQpqt2jAx5JSCKBRvj9Tio2jrOiXULUGaSST4Wm/WaMA
         yCcDYnGALRWva5Gi/J7yjyTQtJvGPiFsHVTvaC4XEp9TMsvlnoM2vEdVo7ZvVbsiq4
         dVAHZEwUm2WeR2/1buCAdTAKIivB/9vGKwsGoyXJT2QvwgHEhXeF1rGLGGHgIpdaJy
         /Lm2GyDEZDu/w==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Nov 14, 2020 at 03:46:58AM +0000, liweihang wrote:
> On 2020/11/13 2:33, Jason Gunthorpe wrote:
> > On Fri, Oct 30, 2020 at 07:39:31PM +0800, Weihang Li wrote:
> >> From: Jiaran Zhang <zhangjiaran@huawei.com>
> >>
> >> According to the RoCE v1 specification, the sl (service level) 0-7 are
> >> mapped directly to priorities 0-7 respectively, sl 8-15 are reserved. The
> >> driver should verify whether the value of sl is larger than 7, if so, an
> >> exception should be returned.
> >>
> >> Fixes: d6a3627e311c ("RDMA/hns: Optimize wqe buffer set flow for post send")
> >> Signed-off-by: Jiaran Zhang <zhangjiaran@huawei.com>
> >> Signed-off-by: Weihang Li <liweihang@huawei.com>
> >>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 10 +++++++++-
> >>  1 file changed, 9 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> >> index 7a1d30f..69386a5 100644
> >> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> >> @@ -427,9 +427,10 @@ static inline int set_ud_wqe(struct hns_roce_qp *qp,
> >>  			     void *wqe, unsigned int *sge_idx,
> >>  			     unsigned int owner_bit)
> >>  {
> >> -	struct hns_roce_dev *hr_dev = to_hr_dev(qp->ibqp.device);
> >>  	struct hns_roce_ah *ah = to_hr_ah(ud_wr(wr)->ah);
> >>  	struct hns_roce_v2_ud_send_wqe *ud_sq_wqe = wqe;
> >> +	struct ib_device *ib_dev = qp->ibqp.device;
> >> +	struct hns_roce_dev *hr_dev = to_hr_dev(ib_dev);
> >>  	unsigned int curr_idx = *sge_idx;
> >>  	int valid_num_sge;
> >>  	u32 msg_len = 0;
> >> @@ -489,6 +490,13 @@ static inline int set_ud_wqe(struct hns_roce_qp *qp,
> >>  		       V2_UD_SEND_WQE_BYTE_36_TCLASS_S, ah->av.tclass);
> >>  	roce_set_field(ud_sq_wqe->byte_40, V2_UD_SEND_WQE_BYTE_40_FLOW_LABEL_M,
> >>  		       V2_UD_SEND_WQE_BYTE_40_FLOW_LABEL_S, ah->av.flowlabel);
> >> +
> >> +	if (unlikely(ah->av.sl > MAX_SERVICE_LEVEL)) {
> >> +		ibdev_err(ib_dev,
> >> +			  "failed to fill ud av, ud sl (%d) shouldn't be larger than %d.\n",
> >> +			  ah->av.sl, MAX_SERVICE_LEVEL);
> >> +		return -EINVAL;
> >> +	}
> > 
> > We should not print for things like this, IIRC userspace can cause the
> > ah's sl to become set out of bounds

 
> In "Annex A 16: RoCE", I found the following description:
> 
> 	SL 0-7 are mapped directly to Priorities 0-7, respectively
> 
> 	SL 8-15 are reserved.
> 
> 	CA16-18: An attempt to use an Address Vector for a RoCE port containing
> 	a reserved SL value shall result in the Invalid Address Vector verb result.
> 
> So what should we do if the user wants to use the reserved sl? Should I just let it
> do mask with 0x7 when creating AH?

Fail and don't print anything

Jason
