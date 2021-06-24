Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBB33B3580
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Jun 2021 20:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbhFXSUU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Jun 2021 14:20:20 -0400
Received: from mail-mw2nam10on2088.outbound.protection.outlook.com ([40.107.94.88]:27617
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229464AbhFXSUT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 24 Jun 2021 14:20:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hmk+URwCtpvlJKK69bAoBxUrO3BKBx0daaVLG94KNaN3pjiDVj6Wd+W8vfFHkZStvPwFD6LPm6mjL/xNPwMvxVrVG1skzA1RwN0urJkmOiGqg4zhxd4AXYuTaf90VwjyrswIXbqR+9iyem9kfSlcGGzlDXp70SMTo58Fb2iCjet71OHrM50pSWDNKNd+Ot6xg0wT5y+RibA3SatoJkRo90jKP6i9Mk0CnYewmRgDwCqpSwH1k2gGpDA/0bn3qU+lxBMPBCEhiFeagNEj61nLJzwGpsTnsjdmbyv2jYl+XxCIuV8oc2oEOP95k1NBlS/3zaOpS2hUSGX6r8F/3WdloA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ab/f6D+557fIg6kKN/DQYbSfuqhT/2ArHLFBEem9I0Q=;
 b=TfHlWsxfqkjI3NLKxCXOjyfCM41eZeLA1tup7OQXy3vfMZLSUWiscVCy65K+n+/jy9g/ZmIxom2VCFLflk8asgRgnho1H5i0SxfJZ9TR+tP8rqEyl6vHUv9fqmhqcZGru4dK9HkgaWZD8+eEJHKJpWPxKh1OKNOME4ceQIWMNSsSg+F1BtXStcPAANxml/iV/YEzPy+ZTRRmFRRb+WV+9pG1bhqa/TFLd8sEf2qMWbbmHzD44qJW8pvKk4SiG6jfbJFUWRSb3dqqrY2swvQAAs8QHrRif1Gdkb1mPkngndioB2EinCHC4L8xmcV2UOJubtnzqKeqElA/vBKLWyZzjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ab/f6D+557fIg6kKN/DQYbSfuqhT/2ArHLFBEem9I0Q=;
 b=ARlCw4sM04LWLDUjRfh/TrNuUfgLfb1JaWtmmgWfbV6Zr4l7swyGJprx9C6IdiTar7ZLQFupJlRv+XQEmuYdKxlD0jEzkU/7uXUf/dc9/r2sQ3CYkpwCCnO5RuHOmLzRRPXTRejCS2z3G5+JvyaGGv2SCX1VDITdBMwE1u9d2ihoY2GeaJ+H0PpbSevZgZRaK6cMcr8yB8nJaC8uuHBJ17dxAzfNnsALy1ocC5LgpBUZhllFg5KMaUkvIleRJkwT98BD/7uk6od9rjWJ6KX5rDbJTsRtXjAsj5QaKjF29AN91s/Mbi1CPgNa5wG76zpy5S+6V6/BMbfkyjJB9MRbUw==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5507.namprd12.prod.outlook.com (2603:10b6:208:1c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Thu, 24 Jun
 2021 18:17:59 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4264.020; Thu, 24 Jun 2021
 18:17:59 +0000
Date:   Thu, 24 Jun 2021 15:17:58 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com, Yixing Liu <liuyixing1@huawei.com>
Subject: Re: [PATCH for-next] RDMA/hns: Add window selection field of
 congestion control
Message-ID: <20210624181758.GA2916619@nvidia.com>
References: <1624364163-44185-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1624364163-44185-1-git-send-email-liweihang@huawei.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR15CA0061.namprd15.prod.outlook.com
 (2603:10b6:208:237::30) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR15CA0061.namprd15.prod.outlook.com (2603:10b6:208:237::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend Transport; Thu, 24 Jun 2021 18:17:59 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lwTvK-00CEkn-Cm; Thu, 24 Jun 2021 15:17:58 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1dae5718-66bb-4ca4-a021-08d9373c65a2
X-MS-TrafficTypeDiagnostic: BL0PR12MB5507:
X-Microsoft-Antispam-PRVS: <BL0PR12MB550719A25FDD9A03135C8DFFC2079@BL0PR12MB5507.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1LTx5kxj+2mr9LXGS63HLuNC3dtU6cynPrRgs8OFXr04VD5mknREFvlzoknetf8DC8VkVTfzds/vNM/YIFGkW3ejYfC9LDeEqLcpjRBTKQSekrzCXPOBQcPK/+WVcKs42YgqZ1cYUgW7uiCUR6K9uf/+afw2tbzn1QoqlQWkO9kml7lQWEGQjA28FkEx4C1AevV+vYHonj2wf/SajtaLkTEmf3/Aj3LRzCG68HH2g286u12Aet/+MeL19Y4IqMLGTOLvPCseTCi2fS6fDHTOyXdDdLlMhepBYsirpDpbsjSn9s/KAC6gPUESrym0Gpku1OuXsH7GOsznNSvGvphYyiu9uhZoIfhYNTV//ndcboH3nMbtIH3w2rXideOs+eHaKGxpSq1Mp2JqeGz7JOi0ZDixZvJszV7Ju07TgB6JTD6J8fgYtMZ4m5bLaFFJZF8RtwshHZOTBUWfunf6GX/3BsaaOWwiWewci//t1r4ewnHWAoGeyVPX02NsRqdMPOOhqrP8WvxPAxA9y112mMaagRDU6ogzez/8j8eE/wu351M2Ilsu3eVHFvu/1V/3pRFJvU/Y+jI+OUKdo8QvlqDb4v6qui6bF0+mPQjKe1Ah/g8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(186003)(5660300002)(4744005)(1076003)(2906002)(38100700002)(498600001)(8676002)(8936002)(83380400001)(66476007)(66556008)(86362001)(4326008)(2616005)(9786002)(6916009)(66946007)(33656002)(36756003)(9746002)(426003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ERqimwiVpZmO+mqQaa9IHy1irBviVAoByGXLYwXqHtvb1GkWSD/kldfsdNg2?=
 =?us-ascii?Q?MRxlBXaMd/BYt1Ezh/vlMnMcs+0xwmkRaZQbhD/jzEWOtfn49+qWfGm4aYAf?=
 =?us-ascii?Q?OwF9Cea8I7sf6gBTtMuCIsnFC/hbwxgvPxZsgK7yxoB8x/tFOh1D69xbv/Ja?=
 =?us-ascii?Q?9G2DGfXkUm8slieEOnpRcy4gnqYxxKBSmfVZNohpY1wWlHG2GeDU1hRMyAQK?=
 =?us-ascii?Q?HeOGdVWSyxwy9pc1d1l2GYvhXj2IfunNYGQrPDvqa123WoBLQvaTUUeB15ut?=
 =?us-ascii?Q?2cm3qIeQa550RE8Zzcwqssdu1Qbdv8Hw8wfskCYrYiQbc6J6aXSqZ6spPkqj?=
 =?us-ascii?Q?SFZJdl1856QbRk+BoickZfrJRhaFllMhPn9HbAhKudNAJffQ495ONTw+jjYr?=
 =?us-ascii?Q?FaCNKVqTguP0MSkn9nfUJKQ6tIZwEwZmpSfKm7OMH7dtWAV9S6WbNTAsPjbQ?=
 =?us-ascii?Q?LgPa6c5WIP+9BT+KXBewIncMFcbIK+U+9ysmi7VC1GEZN1E8F/jLHSspipTB?=
 =?us-ascii?Q?d6F0hw3Cjq3xfM6RUxcIvGNuga85x6Wq3tDQWevBTU1sy3QwdxGrJ1QTlcyQ?=
 =?us-ascii?Q?YVzS7cuofidxR67Fo7geYJj5r9zUbTt/hut1w8CgOlc2m1H/fQhmuD3QofiB?=
 =?us-ascii?Q?gTh+9CHRMmPsp0hpvmyRNmW7fTWiIblrSoi9X4NwzwttiwNjeg80UamUBVFS?=
 =?us-ascii?Q?JabSYuvzL/Vqa//EmZm1Ifp5qiNl/nst8zYNN9GiGDmkn6Ox3UVt1bxxq16V?=
 =?us-ascii?Q?JSh2mCp9y5UnnMpYUMUAosSJWP2gsdME6jOnEoSPN8T4YN88vvPOwAhbrgHO?=
 =?us-ascii?Q?U2oLhpaJlzpXOPyl5HpTQvRWys3200K7G3EXZjLPJy4xIFHrq88hLjBNmcX+?=
 =?us-ascii?Q?G0ldWptYpmDMMc+qMHyUewQqHG9XgMsy+hujiZVFllySTiQjL8SpuhVD0lDo?=
 =?us-ascii?Q?6Otw4CnrAp8mfvApZvYYjPxemsNM6vuwIHtE5PVy1wEbva/Xc/9jwlYQLfI1?=
 =?us-ascii?Q?4PDLybENvfQQIZbYsQhWbCvg32XzTh78KOKgDt3xpDx/leN1ExbAqHysiH4c?=
 =?us-ascii?Q?3vdPF947IVgle3wH8hjIm55Q/b0WSCJXxdvaiOzfyEffRDAqL5hg1io5WbI3?=
 =?us-ascii?Q?9Ne1RfXiJHpcbrO8jMPIzcakVN0xLAnbbbKBZFHuqiiIGEhYrn+BHbBc9C97?=
 =?us-ascii?Q?gyvhGc1AtworfKGdS1M0bU7shw37SsMjjM+zDXRKz/bq65+WjE0RlujZ+LcF?=
 =?us-ascii?Q?k7l4LKszvmofnfnLtWriNR5q+PLagkuxywj7xWvXaU06yS/eEtNow7jzWnyT?=
 =?us-ascii?Q?cxcsVF26d1N1om0Zd9KtR638?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dae5718-66bb-4ca4-a021-08d9373c65a2
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2021 18:17:59.4110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q4dUzivo+6w+ldPtx1IAH0W0dFtcn52u+ew58NtPFf+k2bKPqq3C1Pyk3vjynWIP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5507
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 22, 2021 at 08:16:03PM +0800, Weihang Li wrote:
> From: Yixing Liu <liuyixing1@huawei.com>
> 
> The window selection field is necessary for congestion control of HIP09, it
> is got from firmware and then filled into QPC. Some algorithms need it to
> decide whether to limit the number of windows.
> 
> Fixes: f91696f2f053 ("RDMA/hns: Support congestion control type selection according to the FW")
> Signed-off-by: Yixing Liu <liuyixing1@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 12 ++++++++++++
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  2 ++
>  2 files changed, 14 insertions(+)

Applied to for-next, thanks

Jason
