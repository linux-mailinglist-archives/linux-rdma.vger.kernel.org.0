Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4403D43CED8
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Oct 2021 18:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239534AbhJ0QoE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Oct 2021 12:44:04 -0400
Received: from mail-dm6nam12on2041.outbound.protection.outlook.com ([40.107.243.41]:35648
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233805AbhJ0QoA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 27 Oct 2021 12:44:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RuYV/QosQolCIvoVqqpqL8s4Poa+poDzy3f78E2vXg0KKIso7yJ2S0Xw/OFgS6Nu26BOGDLtUsSU4paKJSwm7Cv7yNS9IjjXSZN/IXhO9m21uJ+Gy7ZVlbRUOa+JgY4WIm/I73NcH7JApJ6kPASIBQY8id/9DeRnMqUPLSlNpkVnKg62XF+SZBOwzIxtJ57+Ecv2ph0X6Cv4BvuHUs7+d0u7IZ1AZqcQPomedttsty34zTeoeGr/+WCJwHsAJvLDT0+nbQHVtSkPbfb55z0k4aMhbNRHNGpvQx/5LpIDF/0wxgNMj0PcvS9BOBLsih59J3sdxGFpIAPOPPamYX9fxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xh3FPW0p4FFDeXQUPE7gDsCpHB11yGchY1IUT+IQ7Rk=;
 b=BtfnzLtD3H07Zhk98+fEB89bxHeAbtjiHm5vD3PWwx5XRtgRg5WT4j7teMCuh8x65YiGrB/8qC9O+6X6K64xjldivWM5/mWuW0+4di0IuPPv0o34FCnI8W3yPjB9bKIgtheB86boexy2hyQXLB7osvLRa9yFaVkw2UdQhBBEvpIxSITS8vw/ll5UTUTvO8eTqyizLhOqSsQlRWiRubN0MhKMVfg6jrGRBF97yZ77Dw1JUN5z0MQ1VMauuctP3xabXoS2jvdfkimLQuN3HQZrfgBRNngFxXNhednmdksRFiKmnWd5eTX75IDpg4z6NVJotGWEN+vTdhQNbpW+nOAh2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xh3FPW0p4FFDeXQUPE7gDsCpHB11yGchY1IUT+IQ7Rk=;
 b=kMCRbImLco5I9VKvQSsM5zjH4PioBZCdalb4nl6SRdJjtKLDjIe4sXe0AcyTvYIpWyqIWADK5mlCgF+h9ojCH2L9MTkuAdoSwNt873Hsj2N76GQJRSADsrymjdFYnTLWDDbMhoUFrJ3DaP34SYtTocBRU6qaACiSChJ8SJuWCS00tgidHIWM7UA/KMTvZdj2rCFxmXuw2CHMSflHHtgRCZhd2H3ATEZA0H4PSS2ODNkHWZeKJ6oyFNen7TDk1CIxXW32CjG4XnzTfN7DvMSvo4mCk3SSSQMcEyT2ASLO0QpZbHe/bhOUaTrXWycsXwxdlHKVGl1Ed1+W+WNSSGjv2g==
Authentication-Results: linux.dev; dkim=none (message not signed)
 header.d=none;linux.dev; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5191.namprd12.prod.outlook.com (2603:10b6:208:318::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Wed, 27 Oct
 2021 16:41:33 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4649.015; Wed, 27 Oct 2021
 16:41:31 +0000
Date:   Wed, 27 Oct 2021 13:41:29 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     yanjun.zhu@linux.dev
Cc:     mustafa.ismail@intel.com, shiraz.saleem@intel.com,
        dledford@redhat.com, linux-rdma@vger.kernel.org, leonro@nvidia.com
Subject: Re: [PATCH 1/1] RDMA/irdma: remove the unused variable local_qp
Message-ID: <20211027164129.GA631717@nvidia.com>
References: <20211027175457.201822-1-yanjun.zhu@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211027175457.201822-1-yanjun.zhu@linux.dev>
X-ClientProxiedBy: YTOPR0101CA0022.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::35) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by YTOPR0101CA0022.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Wed, 27 Oct 2021 16:41:31 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mflzV-002eLh-9z; Wed, 27 Oct 2021 13:41:29 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b016f73-4859-4241-a2c6-08d99968a162
X-MS-TrafficTypeDiagnostic: BL1PR12MB5191:
X-Microsoft-Antispam-PRVS: <BL1PR12MB519143BB6936FB38D5CEA834C2859@BL1PR12MB5191.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0qj/n9eLuK2cDPodw92VwnaHQ/s3qxLM7X2a0F37NFHb0MUtW6Epxkx7aFDPboKRZiX0sPWHbr7+FVg3LTxsb8nH9fE+Srt6JDpVkb1y5r9TfjT6n4jUg5MEbFKG1W+oeGOLxG76s0zCzZlbqzXMuQBNkehM4exFW+4ztebZenDhp+24CNvGt1nFoyMg25/xBKV7ow+cZSzBTtj34FglGNh5Lw8YuoYmYPqeqHJdf63PLz5DjKoc5hhYf7+W8t7BMNV8xdlfBq0WnOdRuSZLCyVhRJBt++tKA+HFfXKPqzfZPDXu/peZaiW0L32mF4y8RrOuMma/DtmuHk2uhnjqYk8Y30IQ73y8EcjVHWxwUd5hHyXpWm1ig5t0+Yn/R3Qn2nSBZDknSGRZRQp7ZKWOd8pquR4Jyo69idb5FgPh+Cjl6G3+RCSTGwhthWvGnOlPQBmi64VPpg5vJQKPRFWpNQhndmfswEsoGCaQ5tvnPBwJu1SHuQ3DiqvHVL2jct6FGuI7dhWZ07+puCOYGj+MqhxDZf21c4GPkQdZTU18r6pdlPE9DxggLo8ivbsDUEkfT5D8Bm9kgQ6hKuIUha2z08TOcXucWKoLshhKpMh23CUqrbaqiZZAbse0F5MUBI3FaNQap1JgGuUEkZcdnifbnfaaRROzNxOpe3FOZJN0fdFp8aJKfEuBuDrFKvSyBRtM36EiGlAuDvVEh76BgEMjCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(186003)(38100700002)(316002)(107886003)(33656002)(83380400001)(9746002)(1076003)(5660300002)(9786002)(4744005)(4326008)(2616005)(8936002)(426003)(2906002)(66476007)(66556008)(86362001)(66946007)(508600001)(8676002)(26005)(36756003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rhmVV2ua1hpJqgtqv67SA2kDfSxivYxEFHg20V6FdHBsWHr0F2TKjfJwC1Td?=
 =?us-ascii?Q?M5yM/bull7MGG7M1CUNo4LTr/J5/woXuU67lp3ur8LSS+zPLlFhzolH9TjrK?=
 =?us-ascii?Q?JH14gQsd689NYyVT9BvgmrI8swdxPpirHi9u+Lxd0pAzWXLW2MOPHckBnl7w?=
 =?us-ascii?Q?hd375mZhcDtr43m6cj+lWIAASRiXuupWNf00wuLYJpkxyqzFUtEWf7NpXuxK?=
 =?us-ascii?Q?t3IN9SYDEIAnj/IfS3jlqr/orIOE/PlE7QYGcXhk8DiSw4CMnlP3oYQToZwK?=
 =?us-ascii?Q?yHZ/Uw5LQTcWBRFnc3XhfWb5HW+vsKT/+Nzs2iEyTePQ9G7nnw3jTPxwsEH2?=
 =?us-ascii?Q?wDtrjsnLCgsMBNfXFKn4I4h0wGBZISGMpjrdp7rWcwBlt/IraXAr/Jow3FeP?=
 =?us-ascii?Q?gYqESQ1LncZKILjtvLRkLPOEw6MrbbmVmcWQlnU1R25X4GQm590m+8S2ZRsC?=
 =?us-ascii?Q?ulgsEzqVojNTgovxEk8cMjUbVSKPbB7XxY5tTCgNzb33MtCRtmzwL/iKgGB7?=
 =?us-ascii?Q?TLTmwTdvv+PetJZENq1/u6KJxPpH8dLi3DOkUoJ1YdSM4GsWO0n0q9V6jt2N?=
 =?us-ascii?Q?QiZOMkKGFBCbMyKwPcuH5kE1A1tIwMsY8Rn25aQgbw7atN2Z6Y2cxFbnfIcN?=
 =?us-ascii?Q?r3b2cHWF2+n/9RIfCxIyH9BxuxqbUNAlCfpOzzNyJBc8/qtdLqaNM5kZaHQA?=
 =?us-ascii?Q?SFkiFU/Hf5WqYHRDq10AJDEECbawOQrckC8+gKGcf7gvVtZeSrFvGexB9gE2?=
 =?us-ascii?Q?7eykUDPsTjAec/oyft6zlrXsYz/N7WeqhttKfmS9gbd943wCGUGmPC3RTEm/?=
 =?us-ascii?Q?0wGnNpsb9AfOQYhkEkThyDpNmr88hAneIZPQa8BzDJ8TfttxeyH2LBojRRi1?=
 =?us-ascii?Q?3DWvUoe+NPMjugzGkY4GjCG/EHnWLVa7YeWsGaYMK+0AgiLqrVDkfIfyt/iX?=
 =?us-ascii?Q?0Qu4AigsgUcHVOu6MniuCWLL7/eVUJlpNL09P8YxZp+UD4dytCILZQl5rTUL?=
 =?us-ascii?Q?z5SBK/XpI8DSLaWYzJ+xUJGW21grN5iLDx5hUiizk46w1wC3dkpHQQw/oc2W?=
 =?us-ascii?Q?9JHJ56OL8LeQg1sqf+WF1m0RqRMhOJMCaGF60iWZu1CH/oxPlTvwqQLc4AMM?=
 =?us-ascii?Q?pN0qEgo3Lyeqg+Nx2PWKXG4Z7DWaX7nFgYjrV/bJ2UlmdnSnhqiHVNA54zZU?=
 =?us-ascii?Q?8zNkQBEahkbDoPMWcRUV28IQyotSTyrauSs3785WdprvW9vsCdSbO3zYQXVQ?=
 =?us-ascii?Q?8y89VNiKU+U/NEUuwz3AnxR3tplZ+MPhTNwRpzSdtdBkNAYDF4Ud7iGymn2h?=
 =?us-ascii?Q?1r7tgiPHOcX/+PZetNwkmq5icXueK0jfEqpKsF0B+8T/8TI9ADLuBj5Nq4ku?=
 =?us-ascii?Q?dxSBfSywDT0sCfF/XuTIMxx1jwTFo/oMdk4Iun14XQ70p4RhwHc18CA/yPru?=
 =?us-ascii?Q?+HGliTpc7NNkDPgi49HpOL5rJKDSXQvWOHj5hcjmL/l441Y/48c1nE2QwJ35?=
 =?us-ascii?Q?qA/4sOigY32rfIyuPLH4oaxWxa59K31BsZzdxL6dCy3cbf3I+1YfPL9QXrhZ?=
 =?us-ascii?Q?KWcPFav+BVRaWTfUCUk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b016f73-4859-4241-a2c6-08d99968a162
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 16:41:31.4821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 56kGTICsyOToE3WSudyoejuESrvu6PvrsjIKDwZGJyzE4mqP7B7z9UoxXxLtXe9J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5191
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 27, 2021 at 01:54:57PM -0400, yanjun.zhu@linux.dev wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> Since the member variable local_qp is not used, remove it.
> 
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> Acked-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>  drivers/infiniband/hw/irdma/type.h  | 1 -
>  drivers/infiniband/hw/irdma/verbs.c | 1 -
>  2 files changed, 2 deletions(-)

Applied to for-next, thanks

Jason
