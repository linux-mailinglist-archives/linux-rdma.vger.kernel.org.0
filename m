Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B75C026AE7A
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Sep 2020 22:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgIOUKW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Sep 2020 16:10:22 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:14272 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727956AbgIOUIx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Sep 2020 16:08:53 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f611f150002>; Tue, 15 Sep 2020 13:07:49 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 15 Sep 2020 13:08:36 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 15 Sep 2020 13:08:36 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 15 Sep
 2020 20:08:35 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.54) by
 HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 15 Sep 2020 20:08:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8lZGj9N1+5IYffJsWX8V7ujJvoFoCfoHjhzb7B1JXwqZ0fuoTh4qr53XY7hB4QdIV26IbqYR7lx+ghM0nb5+qbt/YFG3VViqZcBEwKP9VV3poPYVzKIBrJXJrNLhFVOJoIgNly8vTWD+osRLzRMTf/CZoeYhkwIR7/FKHpI21rYe24+qd60tyKFOMG7fzFgun+D1MfVKqBWF7EHHqo/8gcuM0twQOQuVNfyYZqXH0qpZyWDCtgP0GwLMGUKgFFkwSFRDYI+pHnfDPA57s5Q9mU75qE9+GRyntHZPkxSPKpzEt4iUrul6e/4EN3JRr8bS524N2e32iba2uzAn4WMkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TX/ciV2GK8okabmv4rjUTEqqf7l2honOjcdkcv4h6h4=;
 b=PhKOy/263CuQqTLEF7V2zNcMyJaHsJGbzcQ73GKrK4qAen7k1h+VoO9hddlJRhFS68ftz7u5RXJSF1LCMKUx5EjxjzCTWp1QiT2wPqpUw5cMrwsz9Qrf+B6bpZUGNeiRt7spjfGgB7KTV/O7DuGO5QP8rPH4R+5IwriIzZdU+k8VMtRdcl47A43etd2rXrMWKCiuoEfTMF7eHrnTBxd6nw9gyG2qk4/658ekmz5XAROXNTdqOYFVq9qEjoxGUQhXLn69IqHu/YHXnx2PnF2ulcHal7ELVgOApuy91YK/vNunrHDQQHDLj6A3dZrImtX3h2DyKFZmjjNS4rEaqvbVFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4780.namprd12.prod.outlook.com (2603:10b6:5:168::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Tue, 15 Sep
 2020 20:08:33 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3391.011; Tue, 15 Sep 2020
 20:08:33 +0000
Date:   Tue, 15 Sep 2020 17:08:30 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH v3 for-next 2/4] RDMA/hns: Add support for CQE in size of
 64 Bytes
Message-ID: <20200915200830.GA1593198@nvidia.com>
References: <1599138967-17621-1-git-send-email-liweihang@huawei.com>
 <1599138967-17621-3-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1599138967-17621-3-git-send-email-liweihang@huawei.com>
X-ClientProxiedBy: YQBPR0101CA0050.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::27) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YQBPR0101CA0050.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:1::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Tue, 15 Sep 2020 20:08:32 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kIHFe-006gUf-UX; Tue, 15 Sep 2020 17:08:30 -0300
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01537c50-ed6c-418b-0a41-08d859b31f05
X-MS-TrafficTypeDiagnostic: DM6PR12MB4780:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4780574FE9AE4901C28AE430C2200@DM6PR12MB4780.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k/YsjmdgcNrWssvfT3u8pRP/1WyJNKo8WgpiwPyCnrHy2MS3NZYxLDhlpXjF3YK+BFTClNZUhK3T0xDpBxDJkOI6tC23GTlGQf+ziguzhG/dxfyHtw+X6QGemwGanRhG0ETzBmGoSFiE2Yr5p25boaDWf7L2asfIQD2z2xSljiCXsLnxmf+qppDjx9yKGao6hjIYJmOcDwI+k0NBjlTwVyMu27SvLKwQHlUmzylgzje8p8bCmZCtwkM9efEPfyueRMEnno/ECuKE3YpxSmtxbu7q2VjqMsQ59cwIyHCFnNnKBli8DV9/2AbuKX8Wj1xb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(366004)(396003)(39860400002)(376002)(4326008)(8936002)(83380400001)(9746002)(2616005)(33656002)(9786002)(5660300002)(36756003)(6916009)(8676002)(30864003)(316002)(426003)(1076003)(66476007)(26005)(186003)(66946007)(86362001)(2906002)(66556008)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: F5WI5Sm4a1jTxDGs/4vuyI5Mes7D5GdGQDdEVZ2Uq2eIkbykw4ZL1MkKF/Pn8aGCXuWE9ND31Tl1rxYHaTm7SztoYKegZAqd7xiBhpjulBZj31LhLRtkxOvcH5YYIcaJkGwC9DiP8ey3tiJqMiONqcA13yQCVYz4CtBU0WJ+HWmPC7rBKqwzky+9as+Bpw8YjgiS8BHrKF6sj4jIeX0D8G9sz8szz9qybMs2pK6pnl20AG9r8JamnlsU749wO8nnKyQLLkL5MsriDCOhR7VMTAsK8efLQOODzPrUIuBLaSdEJwm9A1oluJsfjp5jfVz64sBVqsofYi0OhTmcmuDx/TjlPDqy8/F9tegouFw4AvA/hmGLSk3KJYMkftYGfwxZQ+5qBkRHYrSXNFWkojuoP9Q3iiJgHMVVhtMqsDYyLQf5nPI3bTQZfZRCuWS2mXVu0GjYu7orauuxVMOgoBWZ28Fd3ubzmywmR29YT94AIE6lp/xi+Eao8N8N4qancqs3pKjuDyd4QWbRTvh9FA25+3+43XC7raSk6u+AOIBnJE3OfB+SXhgdhQkYvFJ0MQyshUP4A4/stwCub+3C4PP+xSt64u8QW/qxRFZ/egjM4Ut8/lZKsl8pYKX5F5maRDExqFQX3aVL6401w2H6fYF1kQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 01537c50-ed6c-418b-0a41-08d859b31f05
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2020 20:08:33.7351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f5LorDlcqTBWw23NAjA4T0f5Db4BF8i4Wxz8dcMMy2+Q9KadvMZKAIwmhky3JT1U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4780
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600200469; bh=TX/ciV2GK8okabmv4rjUTEqqf7l2honOjcdkcv4h6h4=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=ngLgTEgSbB9FvDtp/YbSK2/G8B429yCNIceKP1qJnmdZDH9ZnV8k3gxjMKcT89eID
         qW+66E1B6AC7kQAolvPgicJIcQ8GUVxRgZSJMKsVyob2/1n2yOtDVGBifyT2Z/FlPM
         M6Y6pWEYG9vQCGyXGdz7klpY5mALNQ5/qHhbwuiZqheROLoNKeRGPAoWa6pkW8lMkh
         q+KJqcxYkwuUBKPhQ/sCUlYJQRNXCGf6wvV1rq55khLxZkfBxVn0wL04YeURvK5CoY
         0Lx/g3hBcdwxrO+Dv2sMIDk9RLjU05I5f2LWRo+6DDLS8GyL0DuR8VzJc9uSvA+BkG
         1RkumzYi5fCwg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 03, 2020 at 09:16:05PM +0800, Weihang Li wrote:
> From: Wenpeng Liang <liangwenpeng@huawei.com>
> 
> The new version of RoCEE supports using CQE in size of 32B or 64B. The
> performance of bus can be improved by using larger size of CQE.
> 
> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
>  drivers/infiniband/hw/hns/hns_roce_cq.c     | 19 ++++++++++++++++++-
>  drivers/infiniband/hw/hns/hns_roce_device.h |  6 +++++-
>  drivers/infiniband/hw/hns/hns_roce_hw_v1.c  |  5 ++---
>  drivers/infiniband/hw/hns/hns_roce_hw_v1.h  |  2 +-
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 20 +++++++++++++-------
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  7 +++++--
>  drivers/infiniband/hw/hns/hns_roce_main.c   |  2 ++
>  include/uapi/rdma/hns-abi.h                 |  4 +++-
>  8 files changed, 49 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
> index e87d616..9a2f745 100644
> +++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
> @@ -150,7 +150,7 @@ static int alloc_cq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq,
>  	int err;
>  
>  	buf_attr.page_shift = hr_dev->caps.cqe_buf_pg_sz + HNS_HW_PAGE_SHIFT;
> -	buf_attr.region[0].size = hr_cq->cq_depth * hr_dev->caps.cq_entry_sz;
> +	buf_attr.region[0].size = hr_cq->cq_depth * hr_cq->cqe_size;
>  	buf_attr.region[0].hopnum = hr_dev->caps.cqe_hop_num;
>  	buf_attr.region_count = 1;
>  	buf_attr.fixed_page = true;
> @@ -224,6 +224,21 @@ static void free_cq_db(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq,
>  	}
>  }
>  
> +static void set_cqe_size(struct hns_roce_cq *hr_cq, struct ib_udata *udata,
> +			 struct hns_roce_ib_create_cq *ucmd)
> +{
> +	struct hns_roce_dev *hr_dev = to_hr_dev(hr_cq->ib_cq.device);
> +
> +	if (udata) {
> +		if (udata->inlen >= offsetofend(typeof(*ucmd), cqe_size))
> +			hr_cq->cqe_size = ucmd->cqe_size;
> +		else
> +			hr_cq->cqe_size = HNS_ROCE_V2_CQE_SIZE;
> +	} else {
> +		hr_cq->cqe_size = hr_dev->caps.cqe_sz;
> +	}
> +}
> +
>  int hns_roce_create_cq(struct ib_cq *ib_cq, const struct ib_cq_init_attr *attr,
>  		       struct ib_udata *udata)
>  {
> @@ -266,6 +281,8 @@ int hns_roce_create_cq(struct ib_cq *ib_cq, const struct ib_cq_init_attr *attr,
>  		}
>  	}
>  
> +	set_cqe_size(hr_cq, udata, &ucmd);
> +
>  	ret = alloc_cq_buf(hr_dev, hr_cq, udata, ucmd.buf_addr);
>  	if (ret) {
>  		ibdev_err(ibdev, "Failed to alloc CQ buf, err %d\n", ret);
> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
> index cbf3478..2e4f6b1 100644
> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
> @@ -81,6 +81,9 @@
>  
>  #define HNS_ROCE_V3_EQE_SIZE 0x40
>  
> +#define HNS_ROCE_V2_CQE_SIZE 32
> +#define HNS_ROCE_V3_CQE_SIZE 64
> +
>  #define HNS_ROCE_SL_SHIFT			28
>  #define HNS_ROCE_TCLASS_SHIFT			20
>  #define HNS_ROCE_FLOW_LABEL_MASK		0xfffff
> @@ -469,6 +472,7 @@ struct hns_roce_cq {
>  	void __iomem			*cq_db_l;
>  	u16				*tptr_addr;
>  	int				arm_sn;
> +	int				cqe_size;
>  	unsigned long			cqn;
>  	u32				vector;
>  	atomic_t			refcount;
> @@ -796,7 +800,7 @@ struct hns_roce_caps {
>  	int		num_pds;
>  	int		reserved_pds;
>  	u32		mtt_entry_sz;
> -	u32		cq_entry_sz;
> +	u32		cqe_sz;
>  	u32		page_size_cap;
>  	u32		reserved_lkey;
>  	int		mtpt_entry_sz;
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
> index 83c07c2..f2fcea0 100644
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
> @@ -1476,7 +1476,7 @@ static int hns_roce_v1_profile(struct hns_roce_dev *hr_dev)
>  	caps->cqc_entry_sz	= HNS_ROCE_V1_CQC_ENTRY_SIZE;
>  	caps->mtpt_entry_sz	= HNS_ROCE_V1_MTPT_ENTRY_SIZE;
>  	caps->mtt_entry_sz	= HNS_ROCE_V1_MTT_ENTRY_SIZE;
> -	caps->cq_entry_sz	= HNS_ROCE_V1_CQE_ENTRY_SIZE;
> +	caps->cqe_sz		= HNS_ROCE_V1_CQE_SIZE;
>  	caps->page_size_cap	= HNS_ROCE_V1_PAGE_SIZE_SUPPORT;
>  	caps->reserved_lkey	= 0;
>  	caps->reserved_pds	= 0;
> @@ -1897,8 +1897,7 @@ static int hns_roce_v1_write_mtpt(struct hns_roce_dev *hr_dev, void *mb_buf,
>  
>  static void *get_cqe(struct hns_roce_cq *hr_cq, int n)
>  {
> -	return hns_roce_buf_offset(hr_cq->mtr.kmem,
> -				   n * HNS_ROCE_V1_CQE_ENTRY_SIZE);
> +	return hns_roce_buf_offset(hr_cq->mtr.kmem, n * HNS_ROCE_V1_CQE_SIZE);
>  }
>  
>  static void *get_sw_cqe(struct hns_roce_cq *hr_cq, int n)
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.h b/drivers/infiniband/hw/hns/hns_roce_hw_v1.h
> index 52307b2..5996892 100644
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.h
> @@ -74,7 +74,7 @@
>  #define HNS_ROCE_V1_MTPT_ENTRY_SIZE			64
>  #define HNS_ROCE_V1_MTT_ENTRY_SIZE			64
>  
> -#define HNS_ROCE_V1_CQE_ENTRY_SIZE			32
> +#define HNS_ROCE_V1_CQE_SIZE				32
>  #define HNS_ROCE_V1_PAGE_SIZE_SUPPORT			0xFFFFF000
>  
>  #define HNS_ROCE_V1_TABLE_CHUNK_SIZE			(1 << 17)
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> index 71eee67..8f7e85d 100644
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> @@ -1690,7 +1690,7 @@ static void set_default_caps(struct hns_roce_dev *hr_dev)
>  	caps->mtpt_entry_sz	= HNS_ROCE_V2_MTPT_ENTRY_SZ;
>  	caps->mtt_entry_sz	= HNS_ROCE_V2_MTT_ENTRY_SZ;
>  	caps->idx_entry_sz	= HNS_ROCE_V2_IDX_ENTRY_SZ;
> -	caps->cq_entry_sz	= HNS_ROCE_V2_CQE_ENTRY_SIZE;
> +	caps->cqe_sz		= HNS_ROCE_V2_CQE_SIZE;
>  	caps->page_size_cap	= HNS_ROCE_V2_PAGE_SIZE_SUPPORTED;
>  	caps->reserved_lkey	= 0;
>  	caps->reserved_pds	= 0;
> @@ -1770,6 +1770,7 @@ static void set_default_caps(struct hns_roce_dev *hr_dev)
>  	if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP09) {
>  		caps->aeqe_size = HNS_ROCE_V3_EQE_SIZE;
>  		caps->ceqe_size = HNS_ROCE_V3_EQE_SIZE;
> +		caps->cqe_sz = HNS_ROCE_V3_CQE_SIZE;
>  	}
>  }
>  
> @@ -1862,7 +1863,7 @@ static int hns_roce_query_pf_caps(struct hns_roce_dev *hr_dev)
>  	caps->max_sq_desc_sz	     = resp_a->max_sq_desc_sz;
>  	caps->max_rq_desc_sz	     = resp_a->max_rq_desc_sz;
>  	caps->max_srq_desc_sz	     = resp_a->max_srq_desc_sz;
> -	caps->cq_entry_sz	     = resp_a->cq_entry_sz;
> +	caps->cqe_sz		     = HNS_ROCE_V2_CQE_SIZE;
>  
>  	caps->mtpt_entry_sz	     = resp_b->mtpt_entry_sz;
>  	caps->irrl_entry_sz	     = resp_b->irrl_entry_sz;
> @@ -1993,6 +1994,7 @@ static int hns_roce_query_pf_caps(struct hns_roce_dev *hr_dev)
>  	if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP09) {
>  		caps->ceqe_size = HNS_ROCE_V3_EQE_SIZE;
>  		caps->aeqe_size = HNS_ROCE_V3_EQE_SIZE;
> +		caps->cqe_sz = HNS_ROCE_V3_CQE_SIZE;
>  	}
>  
>  	calc_pg_sz(caps->num_qps, caps->qpc_entry_sz, caps->qpc_hop_num,
> @@ -2771,8 +2773,7 @@ static int hns_roce_v2_mw_write_mtpt(void *mb_buf, struct hns_roce_mw *mw)
>  
>  static void *get_cqe_v2(struct hns_roce_cq *hr_cq, int n)
>  {
> -	return hns_roce_buf_offset(hr_cq->mtr.kmem,
> -				   n * HNS_ROCE_V2_CQE_ENTRY_SIZE);
> +	return hns_roce_buf_offset(hr_cq->mtr.kmem, n * hr_cq->cqe_size);
>  }
>  
>  static void *get_sw_cqe_v2(struct hns_roce_cq *hr_cq, int n)
> @@ -2872,6 +2873,10 @@ static void hns_roce_v2_write_cqc(struct hns_roce_dev *hr_dev,
>  	roce_set_field(cq_context->byte_8_cqn, V2_CQC_BYTE_8_CQN_M,
>  		       V2_CQC_BYTE_8_CQN_S, hr_cq->cqn);
>  
> +	roce_set_field(cq_context->byte_8_cqn, V2_CQC_BYTE_8_CQE_SIZE_M,
> +		       V2_CQC_BYTE_8_CQE_SIZE_S, hr_cq->cqe_size ==
> +		       HNS_ROCE_V3_CQE_SIZE ? 1 : 0);
> +
>  	cq_context->cqe_cur_blk_addr = cpu_to_le32(to_hr_hw_page_addr(mtts[0]));
>  
>  	roce_set_field(cq_context->byte_16_hop_addr,
> @@ -3039,7 +3044,8 @@ static int hns_roce_v2_sw_poll_cq(struct hns_roce_cq *hr_cq, int num_entries,
>  }
>  
>  static void get_cqe_status(struct hns_roce_dev *hr_dev, struct hns_roce_qp *qp,
> -			   struct hns_roce_v2_cqe *cqe, struct ib_wc *wc)
> +			   struct hns_roce_cq *cq, struct hns_roce_v2_cqe *cqe,
> +			   struct ib_wc *wc)
>  {
>  	static const struct {
>  		u32 cqe_status;
> @@ -3080,7 +3086,7 @@ static void get_cqe_status(struct hns_roce_dev *hr_dev, struct hns_roce_qp *qp,
>  
>  	ibdev_err(&hr_dev->ib_dev, "error cqe status 0x%x:\n", cqe_status);
>  	print_hex_dump(KERN_ERR, "", DUMP_PREFIX_NONE, 16, 4, cqe,
> -		       sizeof(*cqe), false);
> +		       cq->cqe_size, false);
>  
>  	/*
>  	 * For hns ROCEE, GENERAL_ERR is an error type that is not defined in
> @@ -3177,7 +3183,7 @@ static int hns_roce_v2_poll_one(struct hns_roce_cq *hr_cq,
>  		++wq->tail;
>  	}
>  
> -	get_cqe_status(hr_dev, *cur_qp, cqe, wc);
> +	get_cqe_status(hr_dev, *cur_qp, hr_cq, cqe, wc);
>  	if (unlikely(wc->status != IB_WC_SUCCESS))
>  		return 0;
>  
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
> index f98c55a..ca6b055 100644
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
> @@ -86,7 +86,6 @@
>  #define HNS_ROCE_V2_MTPT_ENTRY_SZ		64
>  #define HNS_ROCE_V2_MTT_ENTRY_SZ		64
>  #define HNS_ROCE_V2_IDX_ENTRY_SZ		4
> -#define HNS_ROCE_V2_CQE_ENTRY_SIZE		32
>  #define HNS_ROCE_V2_SCCC_ENTRY_SZ		32
>  #define HNS_ROCE_V2_QPC_TIMER_ENTRY_SZ		PAGE_SIZE
>  #define HNS_ROCE_V2_CQC_TIMER_ENTRY_SZ		PAGE_SIZE
> @@ -309,6 +308,9 @@ struct hns_roce_v2_cq_context {
>  #define	V2_CQC_BYTE_8_CQN_S 0
>  #define V2_CQC_BYTE_8_CQN_M GENMASK(23, 0)
>  
> +#define V2_CQC_BYTE_8_CQE_SIZE_S 27
> +#define V2_CQC_BYTE_8_CQE_SIZE_M GENMASK(28, 27)
> +
>  #define	V2_CQC_BYTE_16_CQE_CUR_BLK_ADDR_S 0
>  #define V2_CQC_BYTE_16_CQE_CUR_BLK_ADDR_M GENMASK(19, 0)
>  
> @@ -896,6 +898,7 @@ struct hns_roce_v2_cqe {
>  	u8	smac[4];
>  	__le32	byte_28;
>  	__le32	byte_32;
> +	__le32	rsv[8];
>  };
>  
>  #define	V2_CQE_BYTE_4_OPCODE_S 0
> @@ -1571,7 +1574,7 @@ struct hns_roce_query_pf_caps_a {
>  	u8 max_sq_desc_sz;
>  	u8 max_rq_desc_sz;
>  	u8 max_srq_desc_sz;
> -	u8 cq_entry_sz;
> +	u8 cqe_sz;
>  };
>  
>  struct hns_roce_query_pf_caps_b {
> diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
> index 5907cfd..73bdec7 100644
> +++ b/drivers/infiniband/hw/hns/hns_roce_main.c
> @@ -323,6 +323,8 @@ static int hns_roce_alloc_ucontext(struct ib_ucontext *uctx,
>  		mutex_init(&context->page_mutex);
>  	}
>  
> +	resp.cqe_size = hr_dev->caps.cqe_sz;
> +
>  	ret = ib_copy_to_udata(udata, &resp, sizeof(resp));
>  	if (ret)
>  		goto error_fail_copy_to_udata;
> diff --git a/include/uapi/rdma/hns-abi.h b/include/uapi/rdma/hns-abi.h
> index eb76b38..9ec85f7 100644
> +++ b/include/uapi/rdma/hns-abi.h
> @@ -39,6 +39,8 @@
>  struct hns_roce_ib_create_cq {
>  	__aligned_u64 buf_addr;
>  	__aligned_u64 db_addr;
> +	__u32 cqe_size;
> +	__u32 reserved;
>  };

This struct was made bigger, but the copy has to change to allow the
user to supply the smaller struct:

int hns_roce_create_cq(struct ib_cq *ib_cq, const struct ib_cq_init_attr *attr,
		       struct ib_udata *udata)
{
	struct hns_roce_ib_create_cq ucmd = {};

		ret = ib_copy_from_udata(&ucmd, udata, sizeof(ucmd));

Copies past the end of the buffer

Jason
