Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E280222F889
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Jul 2020 20:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgG0S4l (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Jul 2020 14:56:41 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:27655 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727783AbgG0S4l (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Jul 2020 14:56:41 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f1f23650000>; Tue, 28 Jul 2020 02:56:38 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Mon, 27 Jul 2020 11:56:38 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Mon, 27 Jul 2020 11:56:38 -0700
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 27 Jul
 2020 18:56:37 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.57) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 27 Jul 2020 18:56:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XrlwbtZLOhVeL70ouAYFJThtklS9bLk9YNUrYsQeTCSUvYor+rVWXnTibBV2TO8zZISx82aCmQpnOE/qSVB9G6+kkzLDgZ671Hm1/Gc/+2dsyneWbT91Y67Zw/RiGRXnQOMs46erJ/hbZxgKp7oJf3n7Uj1uUhiwyzfM7Tb3OUaMMlZtHCdNGuKUV8c9zxprtDm/IB9q5yYBoWIGUPhqEPWoWG+0uCOd5igKWjoAIe0eETWVzVQooRqv3FuHfGGC1iHJzS6M8Sc7Qp0phutl0At9gDiYhJGfTi7AAqaioW0E/sq8YPh8Wu/FojBw5tEN6fTC0pRQzKL+eBnvoAYB1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9W6yowxawSjjrLhUvweyV5CUwQJ+JHIiZnNLLG2A3o=;
 b=TQ6ZD4m2198hT+78qNbuw1YD3LsI5psJyCMFiDOWJ+Mm/wSGcnx9UH5qZW1Pmh1HEXNU8thhxrvU5qpwnj8FLb5gAp5Vz+xKjgb1wGiUsppPL7MjQsX2sFBArdA5XfaoORZ6sdjjH3odmK1S7xs4xG6Iqi8ARvb1BtLs3bWKRYolLvQLef9slN65MpSSSdd1iRWUKbJQ64ZLwgrrtLKKxkrkMhYh9ykE1/OZ0CfwO8vuk5FujL9EOmcZ9IJMJ8ScjW9KT4601JEC4PM+DsuCULwy5tiFgmEKC7Xpnlgb0OWka1Bm1zShtSD9TK5TI9OILvqLyVTovYJC9PQK4tRxkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4498.namprd12.prod.outlook.com (2603:10b6:5:2a2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Mon, 27 Jul
 2020 18:56:35 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 18:56:35 +0000
Date:   Mon, 27 Jul 2020 15:56:33 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gal Pressman <galpress@amazon.com>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Shadi Ammouri <sammouri@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: Re: [PATCH for-next v4 3/4] RDMA/efa: User/kernel compatibility
 handshake mechanism
Message-ID: <20200727185633.GA70218@nvidia.com>
References: <20200722140312.3651-1-galpress@amazon.com>
 <20200722140312.3651-4-galpress@amazon.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200722140312.3651-4-galpress@amazon.com>
X-ClientProxiedBy: BL0PR02CA0112.namprd02.prod.outlook.com
 (2603:10b6:208:35::17) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR02CA0112.namprd02.prod.outlook.com (2603:10b6:208:35::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21 via Frontend Transport; Mon, 27 Jul 2020 18:56:34 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1k08Ib-000IHc-NJ; Mon, 27 Jul 2020 15:56:33 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5804737-22b4-4849-84da-08d8325ec8c8
X-MS-TrafficTypeDiagnostic: DM6PR12MB4498:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4498E2DE4B8C077B28D0A4C6C2720@DM6PR12MB4498.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6FR6R15+ycKBX0UqjMx+EiHFbexwA0Z7Yb/6YzPqNRj/ECbl97bWeXF1fJ5uKUg+cSHXxxXy7HgOVi/BG1EkaYFjGEABVFeWN4OQLRj6uAbmpDeWEXSD5REVnX4nPspxuuzcP8dPd4XcNoZWYaHd4c19G4gnLY5D3Oc0fAZn06oewDIo0upVQTWAFBxlDjUlz7TSIIsbbKm1uFv579NT+Zx8MBtkgkp8dQB7KLYp7PW0peNUNlAgryq4Ti9t4l7FUJFc7+W2AUPLi171hqnF+un4xqsRK2HSIRaD3e2yx/eOpnmTHCcfyDR2GEwyY/f+1kC3TS8TbcsNjDXvn2y5EQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(346002)(136003)(366004)(396003)(83380400001)(36756003)(86362001)(66556008)(66476007)(66946007)(5660300002)(33656002)(4326008)(2906002)(426003)(186003)(9786002)(1076003)(6916009)(9746002)(54906003)(478600001)(316002)(2616005)(26005)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: iKTX6wR/TwEasg5f41BfmIv7xhSnJ7lfPh3zMN/rgxFeCR+Nqr/HvZGd0sl6wAXajYJIotUT+0M8mmhgk06R1ozL/FjTpmggtaYkTvW9C5jNGzYcNiyXkUNmCGkZ2ZwrwQeoumBiqDrAj2k/X2rzzNb2zmcvv7NFrjRgTdvTbR3lvjTVN/lg9kiF0aZcLj9COXmSHajaP8bIe7RImFG/HTWjoLEbAuE4x0TSmTkE6bftwGc0XUqHbSbLHYl6YP13137yUYpC4kFUHw2oMx7Ydoh2pTJ6DpMD1wHCLD9UlliTFQty2GJu6QJIfuNiRQ7fAanMxg8XKtkpKAgSuBibOZ7G1kGZ+WtPvAX3H17jtofJCrzatLXc1ckFrvAdPWnGVUl3uDjN7f/OCFV5Lejh09LpxrFHpd0QpEsSkc35lROClwO2RpqgYKwTiclHhrugeslqU/2I7QghZXR0/NGbidJ621BsJL7wXXRqlhNYYtA=
X-MS-Exchange-CrossTenant-Network-Message-Id: f5804737-22b4-4849-84da-08d8325ec8c8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 18:56:35.3602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bngXfYDAFxH01RYCezDyA5g6DvFXBfPg8EqA2Mqk7yNbuwxvM6qtbXiEqqofp4DX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4498
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1595876198; bh=n9W6yowxawSjjrLhUvweyV5CUwQJ+JHIiZnNLLG2A3o=;
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
        b=Bm0/HgdBmULzBX98BjD31BD0crNr0jywsB8CS6+yS1jKWeuqaYHanlYdnEbEDl+kM
         GbZ0iNyE65F9GI/HpNAWDpA0MSRs5k3pgD6Zio6yoMlXop9PovS2vYGzmAlY+azuly
         3YOXD3PNAgha4Bz+KHMuiDF/rf0csz9h5ack7tJMgaOgQ5pSAdOyrvJ6dIiJNMZ5f5
         pOP2GU9Ri2+hjmvtLnNQTXlsUwOaKPEBxDFXJ/IP+rHD+AKnFPXkImBpBsT8AKyorS
         tYcuX05nFbQ5SWBk18NfiHqhaCAqzqNVk706j92bIK5XTtIAxOHbLoFIWXGRfUjTG/
         LHDe4wlTldCTQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 22, 2020 at 05:03:11PM +0300, Gal Pressman wrote:
> Introduce a mechanism that performs an handshake between the userspace
> provider and kernel driver which verifies that the user supports all
> required features in order to operate correctly.
> 
> The handshake verifies the needed functionality by comparing the
> reported device caps and the provider caps. If the device reports a
> non-zero capability the appropriate comp mask is required from the
> userspace provider in order to allocate the context.
> 
> Reviewed-by: Shadi Ammouri <sammouri@amazon.com>
> Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
> Signed-off-by: Gal Pressman <galpress@amazon.com>
>  drivers/infiniband/hw/efa/efa_verbs.c | 40 +++++++++++++++++++++++++++
>  include/uapi/rdma/efa-abi.h           | 10 +++++++
>  2 files changed, 50 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
> index 26102ab333b2..fda175836fb6 100644
> +++ b/drivers/infiniband/hw/efa/efa_verbs.c
> @@ -1501,11 +1501,39 @@ static int efa_dealloc_uar(struct efa_dev *dev, u16 uarn)
>  	return efa_com_dealloc_uar(&dev->edev, &params);
>  }
>  
> +#define EFA_CHECK_USER_COMP(_dev, _comp_mask, _attr, _mask, _attr_str) \
> +	(_attr_str = (!(_dev)->dev_attr._attr || ((_comp_mask) & (_mask))) ? \
> +		     NULL : #_attr)
> +
> +static int efa_user_comp_handshake(const struct ib_ucontext *ibucontext,
> +				   const struct efa_ibv_alloc_ucontext_cmd *cmd)
> +{
> +	struct efa_dev *dev = to_edev(ibucontext->device);
> +	char *attr_str;
> +
> +	if (EFA_CHECK_USER_COMP(dev, cmd->comp_mask, max_tx_batch,
> +				EFA_ALLOC_UCONTEXT_CMD_COMP_TX_BATCH, attr_str))
> +		goto err;
> +
> +	if (EFA_CHECK_USER_COMP(dev, cmd->comp_mask, min_sq_depth,
> +				EFA_ALLOC_UCONTEXT_CMD_COMP_MIN_SQ_WR,
> +				attr_str))
> +		goto err;

But this patch should be first, the kernel should never return a
non-zero value unless these input bits are set

Jason
