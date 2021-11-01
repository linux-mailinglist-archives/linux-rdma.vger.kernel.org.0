Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D83DF441F72
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Nov 2021 18:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhKARn7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 1 Nov 2021 13:43:59 -0400
Received: from mail-co1nam11on2057.outbound.protection.outlook.com ([40.107.220.57]:49400
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232635AbhKARnd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 1 Nov 2021 13:43:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JE3nG2oILAdngdp2xs1h+V8QCBXtOqx2z6JMNp+S+Fh6mH96/UULSHWoupb+iqRGW0Gq7djduhtyczSHX1NDQxuKRTLf8PyZxFJSPJPepygA8wv5lUA1njRDRYlikGvZ/w5Nq4XS5iiIe0RSZFMX6Hcc1QFdilHp5jG/G48MIDneSjLXM+ijUhw2zw6cSLErGmlVUU+zYl66nV79sXhZfOBrCz6hMCIvSgVUzIkY0PZaWT7zjmIz9wObZHEDWZYF0kz7efGHUYfEN2wncG/InZ/4X4Gzj23l18APnBQsb91vLFhSyxvMjgQGJnv8Il7+P5xaPpoyecwJZwmgcKoDQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oC2fZKJLUTKAcU5xSiES+GY2Ehlo8KvH9t7RYPdRUK0=;
 b=TFMWSGdQxy6hwZb87ZX114QSMsjFB/1OV9s14wfCN3wSIOJpc18hafqz2/QI1sbH/g4r+SwtRcKeHftPlyHN4MuV0POYYfEQs66JFCW467cq3icbDJX/6wvqYB9059Yly/haVSVYpF5yCjXZmnl4Y2ilvevEN3Vbo3GyUhQCHab5EJtxuhcMHGAnolQ0H4dHPrHMGpAB/be/WrjZIm6/IKJ5ijQBTysTp0ruVz7+aLj41Y1sLHEhj/VS/U4czsScd2z43aDZhcINrNUh5bb+stoeKGBzmQkQeVbfIs8FIhU7M3QxWUcYAVatoSw61ClwtH09aNFC8XPQO567gmPQBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oC2fZKJLUTKAcU5xSiES+GY2Ehlo8KvH9t7RYPdRUK0=;
 b=hU09IPoPrgwiJ/acfOzuqWXH9kTlNOLOt2b2erqL7dB0dAg6PmERDBsPhaBddiICIOKEGGQqjoDThDLBtZGOdXwaP8e4SthclLch2ebqy5Mm47O4rkj9ThAbdjBtgUICwRaNdbpqd/Gh+bDO+ZPb1KfuuABo/OsETXDynX+gDjf0sKlGOOcTLUU26KEJZndDZzJnExo301H0LYc4gvnMG2xGJ/+hdcoJzFhfZT3OiWjQty8yg4Vxmja4k5Y74N5xLi5465pzQoSYN/R38wkTOXrf7balG8VslwuaedrXZDAS0UbRYh2KPfQiXDm5lr0XJFFsNZ5EWSfP7BH+Y3RgiA==
Authentication-Results: linux.dev; dkim=none (message not signed)
 header.d=none;linux.dev; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5539.namprd12.prod.outlook.com (2603:10b6:208:1c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Mon, 1 Nov
 2021 17:40:58 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4649.019; Mon, 1 Nov 2021
 17:40:58 +0000
Date:   Mon, 1 Nov 2021 14:40:56 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     yanjun.zhu@linux.dev
Cc:     mustafa.ismail@intel.com, shiraz.saleem@intel.com,
        dledford@redhat.com, linux-rdma@vger.kernel.org, leonro@nvidia.com
Subject: Re: [PATCHv2 1/1] RDMA/irdma: optimize rx path by removing
 unnecessary copy
Message-ID: <20211101174056.GA1091095@nvidia.com>
References: <20211030104226.253346-1-yanjun.zhu@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211030104226.253346-1-yanjun.zhu@linux.dev>
X-ClientProxiedBy: MN2PR22CA0026.namprd22.prod.outlook.com
 (2603:10b6:208:238::31) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR22CA0026.namprd22.prod.outlook.com (2603:10b6:208:238::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Mon, 1 Nov 2021 17:40:57 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mhbIm-004ZrS-3t; Mon, 01 Nov 2021 14:40:56 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b5832b9-a552-48f5-fd4f-08d99d5ec347
X-MS-TrafficTypeDiagnostic: BL0PR12MB5539:
X-Microsoft-Antispam-PRVS: <BL0PR12MB5539B2DD84706FFD9549E645C28A9@BL0PR12MB5539.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zO4rQFJobFhVbyeJw5wqvtGGLNyK2B+UNrtqz9VrFgLsgI5AjzfgXASf/g0xCUlVhWI3mlYNi2qAhuMf0/m3IcXps5J/kOUmiOrXwEWlksdcVdatVTtJbbc+lNP+r7PhArbgfStvAQ9khsvujLMi7utsU0AMc3juUvCUVlv44KlOXpaCOH8xegdvsBC1JGzVdr59gEe3mrLSCM5KjkhWpTp+6d8cCA8qpcXCdM1H+gP+//VmdqmMpZvcGwFRxVfOTI2PTyZC/RejlvX3/908FWG++wHGCKfSVinvDh2er+fST7wxZ3wYNQ4W1q6pA/crRSIHkgQfCm+EYL5L+jMPAqR9f97Q8XcExwVsnpFEq4kqk5+YlwcIN0eFk8hGxSqr5jMfFL9iK3+1mpK4D4LzWXXfA2ipJGztALL3GgG9qNB84utUcmXkfX+2jQX0w37K4pAw0tqMR5XcrGiN43YFSK7EPY6FYyhK9XyfH0JrAnzN7nGSRplHCeEOH0m5sgN4gP25QpglYBhpkhs1cXRx0+3KwXKMqAiSgX3Ht2BQ80CuYpsT769ki6VHkGnK1+E8AWbwm+QJ1Xc0NNECliWyfyY9KCAY6dpVcvN0lYTLOfNrq8wP8kXCZXgQMYg4WMHtK5FQi5WZI6dhh3DxiDrtAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(316002)(33656002)(86362001)(5660300002)(66946007)(9746002)(9786002)(107886003)(1076003)(66476007)(186003)(36756003)(4326008)(426003)(38100700002)(2906002)(2616005)(8936002)(26005)(8676002)(6916009)(83380400001)(508600001)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4XWN6o45AN/vgV4hLb2jyNph++AdZopORu8Iv/MQ4cYYu37Go2PPHQTiZAd3?=
 =?us-ascii?Q?sRF1TpqiN8u1n2UewSoM7N9Ej5S6YTCukhDNHpEnHGhrNzvdjTqzj1Xtwa8p?=
 =?us-ascii?Q?dlIY6fLjAUttetnZgaDbiizthacQgcHud1q6INLGpIuO/J0PMpK3FlRa16K2?=
 =?us-ascii?Q?ik+yiLUx+Z3Q2AgZzQhFTn6d7T+lbGN/IC/LHWt6FGQeCP64goZoT1OBSrFq?=
 =?us-ascii?Q?kIwct4krAzm2HJSooU3yBwAIqOHxci+OOdz0iOkrPnrOZdXCG9+ACJJ4ExG5?=
 =?us-ascii?Q?aQl7jDbs/bOAWzn1xX9jm1dStPyhU1k3XPMfciwwmNoakVULlWwOZ4s/iew5?=
 =?us-ascii?Q?5UmdPqDlooynzPmBtZ192vhYWqyVB6G0Rx8SW+Ya4mN8U53Thr7899gbGa6p?=
 =?us-ascii?Q?vjyeC50FwoMsLCFbX1Y+x55wm1ROjgHQqnoJ+Gyy4gV4fnOkiUJphy8bCst/?=
 =?us-ascii?Q?sLXbdFRICiHk6A1t9MNpybUS+AsLWmq09YziTWuq1Ald7XogHolqd7pC2G63?=
 =?us-ascii?Q?YeVAIL8IWUDn0i64ecgQGVg7nlnrm8Eqibl7nuEA0yAcFlIh7tUT+GgxhcUT?=
 =?us-ascii?Q?vZv8tPNH+fJyW15h6ya5JC0o36lKPSMBn0gcPdGpYUnLJC8pW/HfRCe9lCCN?=
 =?us-ascii?Q?1LsoySj346oBntfNL6Sia0ocr2O8gkz6VAsZ2yn6keG9mCZkUG68LL2PWEAU?=
 =?us-ascii?Q?3wRNEUepYQzvoFAi4wvFOyodME1sDpWfzNFEuJun+5+0DYV3c3SLvUzH4Rzu?=
 =?us-ascii?Q?Db+z8rhjbPB/1dhc2DkmKw1udVFupENjEr0P7UFEMnN5I0DB52p211VtEnni?=
 =?us-ascii?Q?aUtIXjop5R9Lyn60Ar2IMzJ/XnRLlgbevxVoCsWT9TyoLRPzPQuYPVgsgeot?=
 =?us-ascii?Q?cd0OYn//Lj2PhO8dukAiaBIbrQjCG8u70ejqlGxmfcgHuVOTeUCk7HFbxNRh?=
 =?us-ascii?Q?BDAnYuM09BwZkpmRorNSRtVO0SGKaKfLR2pZiEbdNkU8+JecQnoCLc/w/rpD?=
 =?us-ascii?Q?ZfZOyaIIYRfVGaBDYdSQ1kbrKkwfljcxrXZTDS7iNym/VLwVVtdkyzZWdx/h?=
 =?us-ascii?Q?i2qbQvvo0KAHidH9SMZIp2XHwsZUJL7O+i44gN9wBndhej1/v1MyC75seoY7?=
 =?us-ascii?Q?V5SJiXxJYCqDID9B366fH/wWLeG2xtCG/Ip1oqKTHpIGGNilMmckhIqOy/FB?=
 =?us-ascii?Q?Ox4MpQy68KCVuslS/TS99+S9uo9+VJNLabYkbf39jjEsIEJ+JHOID/yMKSIS?=
 =?us-ascii?Q?KrOeYsKwYUv/dO7/8nZ7eGNjxLMrdDLooIef8T2jMN4a2ksv35+g0KB0I7EV?=
 =?us-ascii?Q?FYII4A9QEXUCTVjW18QlD7HxVNh5i67njaIKA9H/rifUi/uF4mGRVTs7mv2c?=
 =?us-ascii?Q?I9jPyWugCzoiLLByoBEpFlWpliv9dvGbwAYmPV4yt0wpxZMRQC3mHCxhWfEc?=
 =?us-ascii?Q?cUcQBYW+NaQ524AXUxJQGz3HR7pNdY4v1SrjxLs1A/AEUOGp+/bd30zAfJ5U?=
 =?us-ascii?Q?OZ+K34A7EFDGiyzwJxjJk3tJayvXW3vYVzdadhK1/MkOq2Tnhf+1U1Euww8C?=
 =?us-ascii?Q?dOX9FPemhElg/AIhYqg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b5832b9-a552-48f5-fd4f-08d99d5ec347
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2021 17:40:58.4321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4o5skTuP8Q8o2+Dib0rnShGO/mVRmuoA753ecVOLa4zxFCJvYawvzZuIphfabgUi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5539
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Oct 30, 2021 at 06:42:26AM -0400, yanjun.zhu@linux.dev wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> In the function irdma_post_recv, the function irdma_copy_sg_list is
> not needed since the struct irdma_sge and ib_sge have the similar
> member variables. The struct irdma_sge can be replaced with the
> struct ib_sge totally.
> 
> This can increase the rx performance of irdma.
> 
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> Reviewed-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
> V1->V2: remove the unnecessary typecast.
> ---
>  drivers/infiniband/hw/irdma/uk.c    | 38 +++++++++++++-------------
>  drivers/infiniband/hw/irdma/user.h  | 23 ++++++----------
>  drivers/infiniband/hw/irdma/verbs.c | 42 +++++++++--------------------
>  3 files changed, 39 insertions(+), 64 deletions(-)

Applied to for-next, thanks

Jason
