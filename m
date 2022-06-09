Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A08544465
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jun 2022 08:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbiFIG7V (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Jun 2022 02:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232933AbiFIG7S (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Jun 2022 02:59:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0052C344E6;
        Wed,  8 Jun 2022 23:59:16 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2595k2B9019513;
        Thu, 9 Jun 2022 06:59:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=qREC/8sAsKI/sbA+2kpUQ48vQ08TB+tkVnyLMVNFPEE=;
 b=JStEkUS151vXnf+c6t++O1Z4Wv3BgIVGQvRyewNIHEYoE9kALjPjLQX1AZC0saKM8zXT
 OCK+ohh6XBwYHllJrbRzkNuoHGE7jVRS2H6x/xCt7MW1KYVCzhwKBOJRBDeKWT0/CN71
 agkSxMOKEwaZcSd/+aEaXSOdnhBnGEFV1eUVXe7OWrwgOCqbQd8S1ibNjjpgPnlBea9y
 FNV6JbI2h4kWtW93uQKz6yNv32mijSiLAmlP9iPsiwxpVh4YNTS3CakNVmEXe8SvN2js
 kPYXuti6hWk8gr2fY72wSSrasi7LSJA6YpS2veAFtFTTJPVto67rJQo+JPFtMsoQwzuM Sg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ggvxn0ehq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Jun 2022 06:59:09 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2596uXrt033778;
        Thu, 9 Jun 2022 06:59:08 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gfwu4as0u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Jun 2022 06:59:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ingEsuDwA7yHDKiEyvcZBvknjvm1ogI/Nue0GAGokYYC8OMencs7eGXnJ2bEGKyzsxOJWw6RAaRfwUw9lQM75Ax7KMgrR5J9xu4GuW0sDuxZdE2zUvarBMnW/YXrUoS1M8ukjS77mVxUs3U+g0+EXt9vKdhNtq5qsfJv0r3mq7XHH7NvjkIVVysU9iBrjflIkVSYoQqRBjXF39mJSaU6R+UdFLZMXN1l5VKTnpJ0S1tZHJ12t/gM0xqewfLt/feiuZ/GSwCq6s9Svvzb2x5F8N/5a0U9QGb4Sup+miL6Y2B1Czb6q445tDrAY6rmpC6nH/wmP4Bq+RCBrN7ZWng3WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qREC/8sAsKI/sbA+2kpUQ48vQ08TB+tkVnyLMVNFPEE=;
 b=hHyBFN7+AQ64WOlS28MBmagZUyc/pS4pC8kFfcR1DChUQYoXAD5ZljunBKdub//Kdmu3bvnGKa33omiS/wl+vddftD1QAzoIV0NYiyJiiw4Y4HSdH1edwG25J2ElFXZbZHnIdn2Fw8GyNv/6gQnTK2/X9Rc2rzbAe66TIoLtyPAM2owlzcd8mCrQuoViFH/MmNBwYD+UgD0X0sSJFJw3BRS7wwruYNDUd0GKe4+B2R7/x1C4S+c2V9ztBJld19rTn3nUAredxX3UPDsjPk6Ha+Kwdx8qiuC7QpBTieMU81/ixqbjr+2k4QtgVVS1J4aNrF9eP7KES+XE+6qvr9LGRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qREC/8sAsKI/sbA+2kpUQ48vQ08TB+tkVnyLMVNFPEE=;
 b=C1oyRetBMHRBxPDX6nHzDQF3rojgHEpJm0LimTP37xZRdfIcfZoTkV5oCf8HBdyzdjCeB+A2NHAXhVQUo9Oud0aG2aGtAkf12H7B08pNENmXJ+2CS5ns0IJ8Fl6h6lMncZ6Vx6QGueo2z91hlnoaNCc0MfyxGgmpheHX+GYGY70=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BLAPR10MB5043.namprd10.prod.outlook.com
 (2603:10b6:208:332::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Thu, 9 Jun
 2022 06:59:06 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5314.019; Thu, 9 Jun 2022
 06:59:06 +0000
Date:   Thu, 9 Jun 2022 09:58:57 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     Kai Shen <kaishen@linux.alibaba.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/erdma: signedness bug in erdma_request_vectors()
Message-ID: <20220609065856.GV2168@kadam>
References: <YqCoWrAXeGHPvTfO@kili>
 <604ea67b-fa8e-0e36-0adf-2940facfe4ee@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <604ea67b-fa8e-0e36-0adf-2940facfe4ee@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0178.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501::17)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0669d696-f8a5-4910-634d-08da49e58b56
X-MS-TrafficTypeDiagnostic: BLAPR10MB5043:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB504371212D2E1184CE1E1EDA8EA79@BLAPR10MB5043.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 58sxvbNX5McNv9O84lpaTWN5jBRTu9SIb1/Wk3FGnwFWuvcFwVYJXHay9dXipnWQB3FJIIZdJKtxcf6IraL+yyxYRvCbwpMkVBKCPes9jVIyGupM0t4G+M4DARuugN9FguVrSSvIOdvrvAZE2PS5cz0h0nELMs9u3O9O1a5GvNTJiKUMtgQk/IP7Dr9F7gS0kupdNjEGXf4xzw9NCB65hm457SlbFgYolmcQDixfMbqZgsRfpYT2sityCYFZ9NJCzHKwLi76cAU22W+6N3cu4YpCDZQwxvmTFjSEzubtDpHlhLo3WhaNOqBsirgFaPoaqikIRq15YrGXXprwAExft9zELSBTtozx1vrDjXPJN0JNrUwj2SY3DhSQvwZ+Ry6OrAKYC9UFSwjhKLJEjyvgjqMbByjilNdHC/CFx+A5DKsCc65YT/6DpNz6VGqst6Y8XvucLIQZznVHaf4cxtpllPp085nUijQc5EjKA+/2J7WEd7LFnV35tCD0FbU8CCeDlQQxm85XoWNWwohu55xt35ShRjzRsMuL0GRh9SLJ70OCbMh9Fu63LkerWu7kmiRTqLVAFdAc4vyGH+Nec/K/scpZls5NZoP9cEK0w/ZT7CdgZZRuc2OUoyam5mzW1WJ1DO5NOMg7FZzZHoresbLYNzKTGFHSoTqN1scbAH8ZV+47SscTB/kxhr1yHO9LRrlG9wxx0CiB9Hvo7q40fXuItA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(52116002)(4326008)(316002)(33656002)(8676002)(5660300002)(8936002)(66476007)(66946007)(66556008)(6512007)(6506007)(9686003)(26005)(33716001)(1076003)(6486002)(186003)(508600001)(38100700002)(6666004)(53546011)(44832011)(86362001)(4744005)(6916009)(38350700002)(54906003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pocOj97mmuWA4tucLxhXLn7uyYRsieWulytMh7NXMA7xz9W1E3+qWx6sEVDi?=
 =?us-ascii?Q?7TrJvQzLNQUiiB/SQVn0BzHUXVnP2tBLKwOEpwKhV06XUqbfjfUhPSwyaJ3c?=
 =?us-ascii?Q?BC1IJKmAD8cvjPHEyjqOBwfqOmCZmby9EG1hfBkXbn+xZ8Mh0XP6wx6m7lVz?=
 =?us-ascii?Q?ZB0OV3Dcwiqk8d/xMBrvQj+wdNmfwsrTVlQvXM9+nt9D9V8hPn8psMlTtw+N?=
 =?us-ascii?Q?85q7Pp5WzEwo45Jc66hzyj/nEQ8S4BwR2epb+QbP/NTech92nU9ubSjf6WuH?=
 =?us-ascii?Q?YR3MlXLCAFZNQvI3b8PcUhsKQaSDBmqLVgQmvZ70CNnE/86I3kufY8jse8ii?=
 =?us-ascii?Q?8445MRMTt8D0q4O9Q/K4lgW5IaCalJHRd636yrF3PASkxaXlxS8+Rj1An4Az?=
 =?us-ascii?Q?z+9+g7gzheS5LkFgbPe/gG3XHduBUjIMcB/CRzgUDBVZgRo9jIpcEJqERZK1?=
 =?us-ascii?Q?dkWpD2OLzE6EgK0c7b4Bau9kcGqbWeCSwCeCCNCfRCVQtRJ6Wqv9iNIbmu/G?=
 =?us-ascii?Q?txUejU5xJ8AJ3eV8dtupRYml4MKrY85YGUbYJFuHyAxpK/3lBLysKklwcslr?=
 =?us-ascii?Q?3m1R6IZhwosugDZxTmqG0j040ZkpFyZwat1qZdIM/lg1wKvC49+TeVFQQ+tP?=
 =?us-ascii?Q?+oMqwAQ0AOi5jXvYOxKUdrRB7Qy6luK7iTzeA61MYEwKB2jJoItnKKqv43km?=
 =?us-ascii?Q?fpNqCGQHTeXdiN60WHuaKCc7O/N2pnf/mcTKhdLc8bKN52bkcS+xoskYsODB?=
 =?us-ascii?Q?jNibzoj6KLEfQ3edZlyQeGOMqqr48/SlI1VaHVK9q9bhglqe4REOkV682x23?=
 =?us-ascii?Q?0iTdYoffoKLUAdPSsvfJPcCkUSfmP7u+epSNZFTGOa/8c7XsjB85eZ/MDiaQ?=
 =?us-ascii?Q?BhN0LM+7S78OzpMimrVJE3J2OS8mSwb+ov60/COpxutQenUxQPUTCPpFqYbN?=
 =?us-ascii?Q?zA09YCKW0HrYC1jS3m3aNGMUoEbREhC+luG7bGDHV+rBy6stFRs4TmXLcplr?=
 =?us-ascii?Q?3A7zy1seT3I63gaye2/X2dfhCbAVzQ8dpBj3k/9etP4bhfEfvHKoHALvkrDA?=
 =?us-ascii?Q?us4oLbB+BCsAjT4648JO4qu8CkJtC68RLtuRLDyKIl94qB+buEphNSIYARW+?=
 =?us-ascii?Q?lLzv+G29Islhjjeyriq2S9Ou/Yd7v9si/zWKjf4JmVBrNBm+3FycUqgENFjC?=
 =?us-ascii?Q?LwA0TbIcjT87zLMj7Uffg339++GVlt8e3ULnLbctbkqcGA+vlT7yhxpi5I+I?=
 =?us-ascii?Q?B2ayB9rqipMGWrJrTCz5qBXLPLmlIVgNhEqA/RnMAMVpH3QH1F3WvT5WPDP2?=
 =?us-ascii?Q?IvBbHUE989yJahz3IVVSr1rfg2hP90eQKQJEMSBOkOvANAiyHgmhTrCgOk9r?=
 =?us-ascii?Q?zSN7HcFZbo1neFykk0pQ6gvQLlmZwhv4zQheL3fic+bonblx32Ctp2tCfVqB?=
 =?us-ascii?Q?/4herltm+vhgh87LyuJhuUH7rZgEce5ppn+4hGlf9y6ZPAc7eFJ7Pc2z/+XS?=
 =?us-ascii?Q?XjgqHqcBys1+t2cvfQxn+Ll2By2nUxOZWdwEtHZnAQYZrH2vWP5WWwNFRz1j?=
 =?us-ascii?Q?Mfnwua2fE10BLaVFYjh0dRvJcmHczQnbe0YMMusBqEc+uJGuSmBBNoBOLruw?=
 =?us-ascii?Q?Jp4tryQoqCOZCAG+WeOK+1VhqnVEgxsbfeuHwQBVVPvJtru7QNMoHNtA7KFm?=
 =?us-ascii?Q?ahKDYR7pYCFHepSvKt715cBF9g3Gmxk7TEPId+UUl824B/BOzCSUgwkEzzfS?=
 =?us-ascii?Q?MOgvGOPkvuu7bh6qbto9wJFGU7xFvCw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0669d696-f8a5-4910-634d-08da49e58b56
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 06:59:06.2566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cc8XZe2J3uYU1C801m/ua6OhuU8M/4Z7qYqqVwNfdJ5oxb5vs/TFYdwtlVFE00g5tSJUNWFG7yN3GKaU7xZ4KpgoVrEmax6mUTb+XKyB6UQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5043
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-09_07:2022-06-07,2022-06-09 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 phishscore=0 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206090027
X-Proofpoint-GUID: S-s7lS8VHnShCLLuwob8zJUik1zqcgML
X-Proofpoint-ORIG-GUID: S-s7lS8VHnShCLLuwob8zJUik1zqcgML
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 09, 2022 at 11:00:03AM +0800, Cheng Xu wrote:
> 
> 
> On 6/8/22 9:47 PM, Dan Carpenter wrote:
> > The dev->attrs.irq_num variable is a u32 so the error handling won't
> > work.  In this code we are passing "1" as the minimum number of IRQs and
> > if it cannot allocate the minimum number of IRQs then the function
> > returns -ENOSPC.  This means that it cannot return 0 here.
> > 
> > Fix the signedness bug by using a "int ret;" and preserve the error
> > code instead of always returning -ENOSPC.
> > 
> > Fixes: d4d7a22521c9 ("RDMA/erdma: Add the erdma module")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> Since this bug is found in the initial upstream patch of our new
> driver, I would squash your changes into the relevant patch in our next
> version patch set to make the commit history cleaner.

Sure, no problem.

regards,
dan carpenter

