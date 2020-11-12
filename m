Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3202B0CAA
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Nov 2020 19:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgKLSc4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Nov 2020 13:32:56 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:40962 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbgKLScz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Nov 2020 13:32:55 -0500
Received: from HKMAIL103.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fad7fd60001>; Fri, 13 Nov 2020 02:32:54 +0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 12 Nov
 2020 18:32:50 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 12 Nov 2020 18:32:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D60yyTziVlM5RBBZF7AR6ksplwKICLEhTpaLTpVFGSe454l7FtCPysXT7WyGsLDYpIyyr3QyPPDuDuOwkJRIC+bpBbBRq3dmt3CKykPSY5jimHWw1OzlTgP56oT8ox3Q51A+RQWb4llU3zla5K4N6Q6+IaV4NBrG/EMZ1Olb64dBGG/WjTiX6axrz68sg2eo6TGek/Q9OfK1p2FBjXa9EI6maRilcV69QmRggMXPkVfkbECn6d8Au8V79NVtkEkt/zJUDuwNSpkidIPJ0T02T7VKcH44/cO6SPQl6cm8MiquRFmXPOI8YPSNbPHwHmGcE7yU0DGsi/KRbdt4bUsZ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8bEX51EmlVRYttfUEz6ToGWB1J+KgW9RvNupHxvneU=;
 b=S2fpRrDZI/F5tKBXkelPYWuUlQb7S2/jXBKhC1EQFNHVKQojKgAJdID1fCnPBsGsDL3qIYNYXGPcVcyoe+C85sVgtNww3ooYouxLmQfvsaUg6u93KslWZlgUBNgq3qkik6zASNSH+Um5epFzIEop7imlQYspIy2H+mr/DJ+RM7xiY6rHhuT28WiOMDPHFHozRghZU07y2qbLoVdmjyWL38XTwyl4RqBZvhcX13eNmHCQhIt4nLxYsLMh3dQWv5jaCGL7NUbJiCowFT6GI0l5q2fJqvXw0tLUOQUGdanJIjhLmEzTM+8122u8YF8mXAUwymR9mrVRK4j5ttFPbXRYRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Thu, 12 Nov
 2020 18:32:47 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.032; Thu, 12 Nov 2020
 18:32:47 +0000
Date:   Thu, 12 Nov 2020 14:32:45 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH for-next 4/8] RDMA/hns: Add check for the validity of sl
 configuration in UD SQ WQE
Message-ID: <20201112183245.GA963928@nvidia.com>
References: <1604057975-23388-1-git-send-email-liweihang@huawei.com>
 <1604057975-23388-5-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1604057975-23388-5-git-send-email-liweihang@huawei.com>
X-ClientProxiedBy: MN2PR05CA0059.namprd05.prod.outlook.com
 (2603:10b6:208:236::28) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR05CA0059.namprd05.prod.outlook.com (2603:10b6:208:236::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.21 via Frontend Transport; Thu, 12 Nov 2020 18:32:46 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kdHOn-0042m8-Mv; Thu, 12 Nov 2020 14:32:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605205974; bh=C8bEX51EmlVRYttfUEz6ToGWB1J+KgW9RvNupHxvneU=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=pKei1kbeG+dXRZ/V1NsfUxoRReump0DWQ6YAA8DhOs0Svza9qmBlWSAkrk5/I6Rwz
         p7ZH7k/a2cgayFIREC1NkzQpbLhfxoobeOh0GcxuFHRjeJX5sBhglU4u56ZQgOgwaT
         AsNjSs14LNslNP9RNwdiQH3+hSsIx921Mlg06XeXV2edo94xIzOOWBSlvUqaV+8e+F
         G0CARFxpp/uAVCteQGbxnlMCVQ76hDeCZ/3dfatYDVGlkbBISqy/WFNx2KHjvoqWOZ
         a7JbnXQ2Bfa0jJAV5WJU/SLYMVUURRpwQ4/kObQ2RIMVU3jOtGlg5O7UH3ZTYStX9T
         ndANBgAayOOFg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 30, 2020 at 07:39:31PM +0800, Weihang Li wrote:
> From: Jiaran Zhang <zhangjiaran@huawei.com>
> 
> According to the RoCE v1 specification, the sl (service level) 0-7 are
> mapped directly to priorities 0-7 respectively, sl 8-15 are reserved. The
> driver should verify whether the value of sl is larger than 7, if so, an
> exception should be returned.
> 
> Fixes: d6a3627e311c ("RDMA/hns: Optimize wqe buffer set flow for post send")
> Signed-off-by: Jiaran Zhang <zhangjiaran@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> index 7a1d30f..69386a5 100644
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> @@ -427,9 +427,10 @@ static inline int set_ud_wqe(struct hns_roce_qp *qp,
>  			     void *wqe, unsigned int *sge_idx,
>  			     unsigned int owner_bit)
>  {
> -	struct hns_roce_dev *hr_dev = to_hr_dev(qp->ibqp.device);
>  	struct hns_roce_ah *ah = to_hr_ah(ud_wr(wr)->ah);
>  	struct hns_roce_v2_ud_send_wqe *ud_sq_wqe = wqe;
> +	struct ib_device *ib_dev = qp->ibqp.device;
> +	struct hns_roce_dev *hr_dev = to_hr_dev(ib_dev);
>  	unsigned int curr_idx = *sge_idx;
>  	int valid_num_sge;
>  	u32 msg_len = 0;
> @@ -489,6 +490,13 @@ static inline int set_ud_wqe(struct hns_roce_qp *qp,
>  		       V2_UD_SEND_WQE_BYTE_36_TCLASS_S, ah->av.tclass);
>  	roce_set_field(ud_sq_wqe->byte_40, V2_UD_SEND_WQE_BYTE_40_FLOW_LABEL_M,
>  		       V2_UD_SEND_WQE_BYTE_40_FLOW_LABEL_S, ah->av.flowlabel);
> +
> +	if (unlikely(ah->av.sl > MAX_SERVICE_LEVEL)) {
> +		ibdev_err(ib_dev,
> +			  "failed to fill ud av, ud sl (%d) shouldn't be larger than %d.\n",
> +			  ah->av.sl, MAX_SERVICE_LEVEL);
> +		return -EINVAL;
> +	}

We should not print for things like this, IIRC userspace can cause the
ah's sl to become set out of bounds

Jason
