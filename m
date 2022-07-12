Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE8E57153E
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Jul 2022 11:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbiGLJBp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Jul 2022 05:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbiGLJBo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Jul 2022 05:01:44 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74649A5F6;
        Tue, 12 Jul 2022 02:01:42 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26C7rm1g022661;
        Tue, 12 Jul 2022 09:01:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=DUvBRlk6QeC3sKxtSFQRu1DylK339UDGw7P8MU5Y6Gg=;
 b=l8r95adu9uONM+y5nq38aCGVrOje79Sy54UadGCJzKwcNLwEexMwZJ+sCXQxd2rUpdVa
 IfiJxuD8bVsEzGpen0m2jba8NPmRM4MK91qkx83oC+KIHwEAZhgJFtLo8adu5HBm8wvZ
 8KWKRqc3BWtWfDghvqdwU15ES1a+Vm10jZDKyXZ1tkSrg9YQbaYeNIArVxdfEXQ6QEu2
 Uvz+zvadoJsxafoEIJQQxHMRv4VRUKVshq5KaSGrlGSWtETG6VhzehA/K6n42k4ueZRH
 VnqTCMEfryw8eAFO/kceVgeRZ1K6xNyHaNEaOly+Xqtid7S4gnCRY7TrVzEPGJ91fSfn vg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71r1606m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 09:01:36 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26C8jIBt019768;
        Tue, 12 Jul 2022 09:01:36 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2042.outbound.protection.outlook.com [104.47.73.42])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h7043f1jp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 09:01:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XmvoYUuSVfFAAdXqcEUilct7Vyvn8ag7UWL1CAwXiC8Pjy+60PAIKw6KDlhi5ZAOGLDgy05I/Di478Z/IyZR9FViTdidPkS9iBJH/cWeYsIq/cmmEjUt++t5DgxKOD7n9uIDkMJnkJF2oBgWA3xjrcCfR64lHqKaMyTgsVYKm0M2dmgtDxxFl2Ju6qNw48675PlGmkXTYQsNcnW9L2vOoEj0mPARAJPXMtTnpPGaQV6thB3wCMdYcRK20//+U+HUMNrwsRHyflmpArKQ+NROv/ZUIb4wmkh9dqeKoJ8RSQsiX6eSfdGabE5IHYdCmfxCMXufnW1z5ZZL4TBiOMvlaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DUvBRlk6QeC3sKxtSFQRu1DylK339UDGw7P8MU5Y6Gg=;
 b=E/IvMSGkWBwK3TZKfSJjS6M5YO9hIXw/5slQTpNI44DEpISegTWzvjBMBiq0SDGbIvaJ3jvAknZB+Wq39Bhe9fT+HQGnGaMy+kcSnkVYGj6gNawkon7KwPDihxqlRWOeV/0U6DU/f3V5VAVQGcWqloXMYggUhbPlWiEOYts4Ny6j+jIJKsRG7lpojqUvuj1t7pgtm/FYRmMhmCTlUGNvI0S4adF2vz/2gTecp0WrvI/8XlKUJQuW3BQvKAkrJBGUqfDv9LpUt2397qWyBqzg2PG3LD2YY2qsp3nC0SeanlfYqacmsjtZ6gX+1uykHPAu/UJYPnGPoWUL/kSKHLiGfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DUvBRlk6QeC3sKxtSFQRu1DylK339UDGw7P8MU5Y6Gg=;
 b=LwIqF5lViWMJlHJuevTYDNJyQcjPNNx2c5wSW8hFj5xGh9TPAmXO7d/ZxGVYzsXGD2J0nvcfy8xxXItZcyRWBSlc2kgwSIhYnH2aI+3w0r0Lj4TnS7n08kLOV9M+hxZ1pHBSO/G0JqvDTMk9powPiiAbMhweQXPaQX0CZssr+A8=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MN2PR10MB4240.namprd10.prod.outlook.com
 (2603:10b6:208:1d9::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Tue, 12 Jul
 2022 09:01:34 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 09:01:33 +0000
Date:   Tue, 12 Jul 2022 12:01:10 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Kai Shen <kaishen@linux.alibaba.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/2] RDMA/erdma: Use the bitmap API to allocate bitmaps
Message-ID: <20220712090110.GL2338@kadam>
References: <2764b6e204b32ef8c198a5efaf6c6bc4119f7665.1657301795.git.christophe.jaillet@wanadoo.fr>
 <670c57a2-6432-80c9-cdc0-496d836d7bf0@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <670c57a2-6432-80c9-cdc0-496d836d7bf0@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0045.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::33)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff11958b-fc14-4dbb-be38-08da63e51e2c
X-MS-TrafficTypeDiagnostic: MN2PR10MB4240:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HcERIpVU0/xwUT95f+xgT+Emsy1xCL91rEqahPmFM9R/RQtW5nc3EfZIQbfEzkjyCT4Xs44Et09zqvYyS1Z7mBA+QOgHUqJzBQUvlgoZQWGMZ1vTFXsXkRpX9U7IBq7IeNHKe3MD34bVCo09voIsEOwuwMrru9VD4s53PeO/apy2ULMLV6j0wWA4RaZ9+/dr0l7FgUG5485wjLdkpxmUuFjp34tOroABnne4qi15JYOr/0MFvZAHS3d+mN+rqpLJLKLakOdc/nbGiPzHGF4lpPf2UasoM8RVX/AfwSSGKg4LgFN19J/+IpbiHvoMLoC47uV+CpDGL1r17YbVlx/gcixluab4E+TZJHZIKDjzFEQY07vZQU0zsgsyBZzWhYRpcuV6kowSiFAewJdQxYQQHbgGKpl5g7Q0y6J4S1iQY8h3KBKx3tGxLv8CAVXwW0pbMDQSp9lhEXrKLI7AOcedGN7ry8UMVor44/hn0IzDtlcU6YsJ38r56JWcwk8p60tNWrOQT8Fo5OaMVYNjJ7Hi/kQQgoqHdDa/vKSCBBJ9gN9RKqIEEn/qd9zdMmWRAaWlMYs12lFHvafkpEvZbJYzq7XJUfo8CF4E7Y5BGFLYU2nIkoSnjhqGTXlwjwUV1PfdcENEtyh0ZsCLT9XTQlyVO+nQseF9Xzin8j692O0TzLPLLnyD/hKrlpFCfUASUuJcw3HiMuB4OkritLqyuzjdL7qC7odmgAEx9vXsPrjviwocS+sgftWv779O0idH5NGK795k/rmHAsj272YwV/VphRK+ImmoRVj7/pXVmhEGNpEGTFDZju1iLAea4QNEdFGm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(346002)(366004)(376002)(396003)(136003)(38350700002)(38100700002)(6486002)(83380400001)(66476007)(1076003)(4326008)(8676002)(186003)(8936002)(66556008)(5660300002)(44832011)(66946007)(6506007)(2906002)(41300700001)(6512007)(9686003)(6666004)(33716001)(54906003)(316002)(52116002)(478600001)(26005)(53546011)(6916009)(86362001)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v5f6JUwPd1MhKB7Wy5NSD0tEZXxoNI5zjFHkXt/CI7P3qI+8SHjWRjxvl7vy?=
 =?us-ascii?Q?us4BJn9N4jiDQKR55P1NQlHU6V93h4qR2NupoF9pW704b/0MI7YEz36Z2XtY?=
 =?us-ascii?Q?ph10epmR7X4eljZQvscdf98ElBElDXsVSAwnb6oSMEhNZHimz/73rsMIPEOe?=
 =?us-ascii?Q?L5qou85XFoQrK4CPzTAUAVwRw5oImcPpIb7/k7HYt9Y7gGnwpF1XVyQoKtTE?=
 =?us-ascii?Q?CD+2Xb533Dy9nAwDIZoiXORYMmmjd/EDt+TcHLV/2HDVF0ve0s0U/Lu6Yh7i?=
 =?us-ascii?Q?oPA1lFCiCM33ERnzX6YUc66YUpSyi7LJdG9jXrhZXfvCzLyd0w0vJL+G4acp?=
 =?us-ascii?Q?K1ujfNiYsjHP3RccjU/o8eHPJAyTegJydo3upkGFOjYH5D6UmTpeGpRs7L9U?=
 =?us-ascii?Q?Iuz9t6o8rNEANcx/UdSzOAur0dSR9EFKxXb+6kKYwVVQPWL5JNvCkFrQfnxz?=
 =?us-ascii?Q?oceUM5SN3r4+2Hgkct0YzvWvzxCpfLVqJ3wNQWTasx/fIq0YOBb4jHGVXWY3?=
 =?us-ascii?Q?FBcTlpohkXz+rXKiMJ4kZlAQKUGcCq1pmUBXlHx+K4o5e+oPQkBFph20AQO+?=
 =?us-ascii?Q?uAktItFJaxCxWYl++gT14hpCwzdeIt+3rnuUfIYE4qFiUp/j5sY29Kd58NHz?=
 =?us-ascii?Q?bhZGaJ+fS0ryMkOO+UrqPGjLewYklPilVducwV8xlEbx4dS9fNxHGdXq0NwC?=
 =?us-ascii?Q?HdFBjxu7tU+GN5TPxIssWkceXzvNeGY3w968wSv6bVM1//yzyU3kisTgoOfV?=
 =?us-ascii?Q?xiU+gdpUDIVAf6eRSWr9gjR+h1qpodXnuGW+7aZVPI2g6EqFKwIcDz6InC55?=
 =?us-ascii?Q?AMPqwfu9aVbYwwRvQ+3mT+92ou8MypYN//SueyVBc0hnMEbhochDZkd+o/Px?=
 =?us-ascii?Q?FKImSCjErtOSgkMR5Ccdy/URRECIIM8FL4Athnz9iSFZAY/d4COc5vvE4phe?=
 =?us-ascii?Q?AdEB7/YMqNCh0qhLCkKibvaCqbWagD55wLeraUpDkABVLbRsbhSMiaIbRG7k?=
 =?us-ascii?Q?R6NXlc7fqlHw7d1RO7e7wdl2t2yLbN7m24Z02udDUpnb+dWjO4IEf0MAptjM?=
 =?us-ascii?Q?M+OkhVAc8/Y0oySNieVRq9Xro1uXoZqhotvljAyTxW0lCXnwV+ZU1vBi666m?=
 =?us-ascii?Q?2H9aF6z2h1WLLhQbienequf+f9ns/sHrF0k5qaO91T4hLAmrRpgLVBdjjQbs?=
 =?us-ascii?Q?w2Rhgxs9pOrhJz3wheaHmRFVkmeiYaAIdYVygBWwSIrOTrVLUGQIHQRMvSK0?=
 =?us-ascii?Q?HZ4WPpoS3HRsx2KfhmHKWFiv3Gw2ofcEN0TJP4BqSPlAr9mR9nsZh7RNRr10?=
 =?us-ascii?Q?BvYHwNVcJXjYcizS71VEy4rMCcgJKYAuyz18QvC/PqtNq3uMjzdTNP0tUY9q?=
 =?us-ascii?Q?/InzEVskupC6t710gfC1VRNLHDr5f7zBh5A/VWnJZXsd8jdHGB6LQPuZHVBT?=
 =?us-ascii?Q?SCSHJHkFigrkrgOmQp43OrUeYACzTC7itIOiehSpKqOcR6XIp65BQ5ghzYAe?=
 =?us-ascii?Q?EyahMvCq4nu/SfEReCQ4kesrzfzImT8/Ib7YGPEd4VcNtLRS8A9EFAUAhs1B?=
 =?us-ascii?Q?bQWke6ivEWLWWhOmR0FMGSI6mzUErOb5A/foUm6JIkQWGQvjngY9M6RgGgcn?=
 =?us-ascii?Q?Pw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff11958b-fc14-4dbb-be38-08da63e51e2c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 09:01:33.8442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v44Jh3CBC+P+FO0K+gfbszM/9VLqnEf+1zM5ywzu9gDtlcGSWpiz6wDJQ9SGnCbmswBv4LCRhc1jKQbPzdP6G6klDzF2lNsoWg2J6Zhfl5c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4240
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-12_05:2022-07-08,2022-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207120034
X-Proofpoint-ORIG-GUID: TU12ZJjBmdCu18RucbBVg2EmobNmWHHJ
X-Proofpoint-GUID: TU12ZJjBmdCu18RucbBVg2EmobNmWHHJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 11, 2022 at 03:34:56PM +0800, Cheng Xu wrote:
> 
> 
> On 7/9/22 1:37 AM, Christophe JAILLET wrote:
> > Use [devm_]bitmap_zalloc()/bitmap_free() instead of hand-writing them.
> > 
> > It is less verbose and it improves the semantic.
> > 
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > ---
> >  drivers/infiniband/hw/erdma/erdma_cmdq.c | 7 +++----
> >  drivers/infiniband/hw/erdma/erdma_main.c | 9 ++++-----
> >  2 files changed, 7 insertions(+), 9 deletions(-)
> > 
> 
> Hi Christophe,
> 
> Thanks for your two patches of erdma.
> 
> The erdma code your got is our first upstreaming code, so I would like to squash your
> changes into the relevant commit in our next patchset to make the commit history cleaner.
> 
> BTW, the coding style in the patches is OK, but has a little differences with clang-format's
> result. I will use the format from clang-format to minimize manual adjustments.
>  

Best not to use any auto-formatting tools.  They are all bad.

regards,
dan carpenter

