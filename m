Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3507035E944
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Apr 2021 00:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbhDMWwf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Apr 2021 18:52:35 -0400
Received: from mail-mw2nam10on2054.outbound.protection.outlook.com ([40.107.94.54]:11744
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231873AbhDMWwc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 13 Apr 2021 18:52:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7jJZkxDWmZkqPqrmvJADnAIKb2vzkdMxXlxytRc+f9F4qle61agQVxN1UpvaN8NN/i4Us+WuIIBLx+JdR2s4J3jwKgF0o9eJwd8K8MS8wb8c2+fLgDPcZLmuJoag58c8P8SJt1mHmh7F8ixGaDpHm804pxvyCzlM7j8F6Qs0hTbFyXfH+QSDgMfhiIm4YA+HP5mZwUXkI79RPRy6qNe8wPd+JIOAdIvh2cMZibEJ8/4061gK8n4kZsffe0vM0QMxse1Vsdg4e6ZONQOCKP2QAyPUYhSvSOJEfxnXdigQHHW4BQKGnW4WmAWkbD95wE5BJ7KcUe3FuN6pge43kiWaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mk+PisayhDPqqTy/nfG7wBSAvvTuZpfWdnraiman1HA=;
 b=DkYTs7MVmPhxC2fhThetBYI5vMbiA38IeB7mgcZREjTr2g8osEEW4mWJjcVMNAVs96BZrDmUmpPWwRRuIkniw6k5/nPUgSypqh7ff8PuQomK3T1PzBzSbSZQ11YLTOq3m8x39ksGiRceTl/PlsYFFCuMwF1ZBgWfJmCODOXCkl4PBqQAWgfV+3GAHOsOfVQd9DUwgeo8EQULQ6OxLv7U46PifanlXVeg5IWlsbI4Gp/hyhtsL1ogjBSEJlz5w+eHqnb9hEnInM7IAZc5y4r9rILhwVtDaFHLzt9OpxZkK6ydswg9sOwjGsqGMGCBA+HmHeS4+CAM7WB/a/h8J8vYEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mk+PisayhDPqqTy/nfG7wBSAvvTuZpfWdnraiman1HA=;
 b=diI4K1zu/f5/Rlzv6BFmtI7Z+vRCl0eTcCaPD8gyd1GQZ3E2dpVBLFS9phm3YIaoIeYfYI1fPTFlQdTgeAn3JNGErv3mIYlix1zUyFTp4uTRVL8WfVRl7DV71Mxiv33goNuBrhrwmVgRUC2tOBeL6JorQ1+gtgemfs/53EiH++dz9bevVSZmd7C+sR/eKQAVZ+9/2z3ieJ9EuRgUXxbSrj+SXhwO8CdnB+0rIu1Zk3ZuNtfXoDGotHbyWwhu3i8DIjWHK9kd56gh/DrZfrYoVSViuEiOLbTdNsJ5Oxg3S1aKzax317oaJ3svTJuuo8kg9keofC860C7j7NlO5537OA==
Authentication-Results: ionos.com; dkim=none (message not signed)
 header.d=none;ionos.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2859.namprd12.prod.outlook.com (2603:10b6:5:15d::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Tue, 13 Apr
 2021 22:52:10 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 22:52:10 +0000
Date:   Tue, 13 Apr 2021 19:52:07 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gioh Kim <gi-oh.kim@ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org, leon@kernel.org,
        dledford@redhat.com, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: Re: [PATCHv2 for-next 1/3] RDMA/rtrs-clt: Print more info when an
 error happens
Message-ID: <20210413225207.GA1376164@nvidia.com>
References: <20210406123639.202899-1-gi-oh.kim@ionos.com>
 <20210406123639.202899-2-gi-oh.kim@ionos.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406123639.202899-2-gi-oh.kim@ionos.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL0PR02CA0074.namprd02.prod.outlook.com
 (2603:10b6:208:51::15) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR02CA0074.namprd02.prod.outlook.com (2603:10b6:208:51::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Tue, 13 Apr 2021 22:52:09 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lWRt9-005m1F-Gq; Tue, 13 Apr 2021 19:52:07 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6db22108-2b7c-497a-e142-08d8fecec4ce
X-MS-TrafficTypeDiagnostic: DM6PR12MB2859:
X-Microsoft-Antispam-PRVS: <DM6PR12MB28599E8C3803C2CB7A743546C24F9@DM6PR12MB2859.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:517;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Xy2PLuZHhGDxaOavZsKvVLX9i6m9SBed1oRcANpfBrBNFQNRFR+1wQQ4UkdgoEdUG2d+cSzPTp9vnb4mwHhhI4Oo2I9nSbbu71vbJVF4HSkZlDqGqSnW8apAlusd7W5SkW9Ifp7krw1tYbzz/Obq2DwvjuNjEFPpGWfN3UBCN5Kb0W+eHbs/de11LlvV6qnJGxXLe8BzBSLd59oc9tAt7ccw4ryuDYxwSjqUkEWK87aN2xLfMjsvnjx9GPvMYosldvROG9PVHfV0TNrcqBMe3EgbPvN/P0b2No4ql4bl7GSiOQMOoSGUNcACnnPC+4IL4qfHSvinzqrPwVPhAAthcQSfysmUvTnvl7XR1Bw8nYa+l40lUBno9iyfOFAtLVypP8W46sc5WgGTGXMgB4KFqks7hBnbQZYW+c9ODPDfrxj/rzYRsNJGOQ5G8SJPJHyr7bwG/zAD2PXplseIrBJzOu92ehfXAHZBoI6wQTczMVVgXw+0aUT+uxE01oy3tiP4+ZtbqVZ1mf1BlW+xp0sMzYoamsJ/FCGnFPzTbqQtyqYEtM6abCi3W27EQhx8RmriJc3D9N7ULmYO5w5sSvseBGRsz/+i1GqHu8HLFBwDng=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(39860400002)(136003)(346002)(2906002)(1076003)(4326008)(426003)(86362001)(9786002)(26005)(2616005)(9746002)(186003)(8936002)(66476007)(66556008)(66946007)(5660300002)(478600001)(6916009)(316002)(36756003)(8676002)(83380400001)(33656002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?axumz2YrcntJpgw13SRGgDuaNHqnsiPphXQjTa9diRgg5sfeJKUb2jPeok9c?=
 =?us-ascii?Q?N98f9evMqDvVE3UkKEPFrY82WbrD/goRxoaRnDICe7rG5CWjPlw2G4ouwPWp?=
 =?us-ascii?Q?hA/n+Rfuqtv0bGrbEb2u6442uWDfLm5rkOW2lOC7KvGv4itxkKi/KF73JHak?=
 =?us-ascii?Q?DB4WJuQZJhjfY+Aq57cXdFpBXU43M3qIia0igG3r4Ti4fdG1lpZ1yjgsAh6A?=
 =?us-ascii?Q?/KMP3/rv/SC+pXR1MZyZ6JYe0DXa2N6uqLwWJXffaZhn3wrizcVMJYikzg5i?=
 =?us-ascii?Q?ECR62otAosetlD9LbyyPcohLR1jIAb2DltsYW7n2G1AVOv5M24Le24b4VzMB?=
 =?us-ascii?Q?uGJdyIvY3kfNwwvbZH+9hAzf4XEzbS+u0NjUOCeL0VzLbUP4G7zTCfAyAk7/?=
 =?us-ascii?Q?xXYYG2pRyv0B0CuUI1hX8bzxJtHGOtL1mGsIaWJdLTgw/uwSnJc7Lc+InXNg?=
 =?us-ascii?Q?1APwtrLrfyrW349BSne5idTtTRln1c3fj3n5Tdasz0D+cZMpnskEJFSwEC/2?=
 =?us-ascii?Q?ItRorKyKPpxI9S595Oi7hqPTSPE84wmj3DagQJ4lYYDkfjpRIFvuo19TE1wd?=
 =?us-ascii?Q?4a0EQ/wd4YvSTHrBsMPp9RlqconFqwcwmnGdpRX66mrOW2ugNNO8+r/JUDy9?=
 =?us-ascii?Q?zvzSgPMLe3/m4bEsmtQYhAmg7d3gjdGVHsKILlXlhtJ5xgg4RgwgiQESDd2K?=
 =?us-ascii?Q?44Ma6X1teW88JreJxVDZjLKWX3z+Vf0RoWizFREl5yEyKSdj2KBNi7GRSt2N?=
 =?us-ascii?Q?oNeSCaCjlJtGn6q6Z29MPlkNtxRKQvfJo9ksBOtHfXvXyPesOV3B53vrD0cT?=
 =?us-ascii?Q?TI6PTZxdAzY9k29UByJmlK3gLqSxgQUMtS/lOT5wHlVQLgrSY4JzlLlBiY6L?=
 =?us-ascii?Q?nhaKcvSqE+wVA5eAvYnnPaHBo/D6wdcyqw/cSeADKnTKrzOd5Bq5prlSdhoc?=
 =?us-ascii?Q?qwj6vT1L5qdjFXs+cSAp+vYMKHvQ4nI6dTGrTwmGZmdme0fDMP3nZ/3miOn1?=
 =?us-ascii?Q?N5yIF/HMiIKtsalDzeHde4pL53k3lVjK2NhBiuZsVNDe4cUAqxITgGGJGK7E?=
 =?us-ascii?Q?Rm4Y97QLJLszBkPunReIHd/T2scCnyQambO+lykL/91eElRwHgmZX6iBaxHW?=
 =?us-ascii?Q?HSNo3aJjeY3VVnxHnPF0BL4tJ5p0+ZHMYCN/mXzEX2/I52ZNIh5iPj6lbMlS?=
 =?us-ascii?Q?Rwbhw1NbXYDcDt+QRbAeJuh+9hh7vPSp1E78b+J5wXb4j2lDjVQIkSKby4rN?=
 =?us-ascii?Q?0QphdW1JG1XBDw2T+gMYLIjjP9IX/hMJSIAaAjIKcmMKKJIxGlT30DGTjcOR?=
 =?us-ascii?Q?uu4q2tShARxrDelSWfEJjHImT3h0gJ4vXzJ/M+/vSWCvOg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6db22108-2b7c-497a-e142-08d8fecec4ce
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 22:52:10.3459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XCQp03RzM7kMcSUWacfCIuAPTkqpEz6jHVGfH91hzR4sNBtug6r0N6t1qykq4U7R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2859
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 06, 2021 at 02:36:37PM +0200, Gioh Kim wrote:
> From: Gioh Kim <gi-oh.kim@cloud.ionos.com>
> 
> Client prints only error value and it is not enough for debugging.
> 
> 1. When client receives an error from server:
> the client does not only print the error value but also
> more information of server connection.
> 
> 2. When client failes to send IO:
> the client gets an error from RDMA layer. It also
> print more information of server connection.
> 
> Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 33 ++++++++++++++++++++++----
>  1 file changed, 29 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> index 5062328ac577..a534b2b09e13 100644
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> @@ -437,6 +437,11 @@ static void complete_rdma_req(struct rtrs_clt_io_req *req, int errno,
>  	req->in_use = false;
>  	req->con = NULL;
>  
> +	if (unlikely(errno)) {
> +		rtrs_err_rl(con->c.sess, "IO request failed: error=%d path=%s [%s:%u]\n",
> +			    errno, kobject_name(&sess->kobj), sess->hca_name, sess->hca_port);

Mind the long lines, I fixed them and removed the unlikely

Jason
