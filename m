Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E116149FE3C
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jan 2022 17:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235545AbiA1QlD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Jan 2022 11:41:03 -0500
Received: from mail-dm6nam10on2082.outbound.protection.outlook.com ([40.107.93.82]:57358
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231236AbiA1QlD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 28 Jan 2022 11:41:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PunAgT3vG3mCSDQxIprooWENSKuo1FPY8q+31qAU+G3cWPeVK/ZvPT7qQrktrj7/jbT62RySGTiwU/CqcS8B3vi0EK1E+0BCT5VtE8qwqwrTSN9sAU6hJLDDGF6mtKTPJ+7m1thfIURvAhv4NSjnQOtOU4mC0zafGRLlJGqprla6x5FD4nr9xBkfEOdIh83kY44v6mtTjZrqimnvwe6q91zUM4SLpdFp+Jvc3Yd9AapUCvTel5wb854pRYaCr6eVwoPchuSPABIwvnkmHdboMRSzZXRXxM4urrWr23AMIZnsAlE6sGBNlSHeBrpHw9DqDXEAoQFq534k6wv6y9y1KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQbo8oAGWghQ39eSIS7x3bEzlguKso6rSQE7vC9Yxzg=;
 b=hfg5E0cvKzxaHqz3oMfUsSjO4M6+4LmnNmEZzxYCjVfZyTTwiGjrpmEmAAc80FQUq4mvmXgOckTrkFvG0eTomAAENma1w4o8sp6H6pQDOPzi0DGuJbvpjjfSB2GUgwhJ0PgZPgtVfWY491HPrKhmuXBzVsLUouB+ZhlfznfDQed88uGrjT+uWbU/niETh5mJe1c6UPwQMxBaoGC+SovQVSJzmvwoz3pbj4byqp7JI3R7rqcqP9YYyYG8bGCAbCDKCpzOtT6tA6Ag0XGPFwP6x/pxckl0dKjhb4Zc/HAwMSWmGp1xQR3eef9iAMdczvWuIncjMCPRsL7hW0fpw8I4zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQbo8oAGWghQ39eSIS7x3bEzlguKso6rSQE7vC9Yxzg=;
 b=tV5FUVQ5cdlSqCGBpKYHCyx4xe/M5vCd/L7JfpsRWC/CyLlYW7HNPdz2cCMsUZSsbEChjIZr3hOSmmoU4uv6myfBB6irpMJCGGQovinqn+Fl5KNHhkfmlC8Jw/l+FGPd7Lu0blmsLXtZriKAoMskusHSR6IHUpx/Rit+j5RnxYNe29qVcv0nbem9o/w+a4qyjvEW7kb+jXKbzhuHG6XtX0IUV1baE523foDm7TX27omxaUu+zzejTYZKkXgDBGZuQXzv/Ww1okpuTyxCBAVLcG8bJeA2/yE7D9wxXFiqU5hCn648y93A9e/9jfDkROJCSdYQ1X1RoTj1nZwsMHEj4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CH2PR12MB4072.namprd12.prod.outlook.com (2603:10b6:610:7e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.19; Fri, 28 Jan
 2022 16:41:01 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4930.020; Fri, 28 Jan 2022
 16:41:01 +0000
Date:   Fri, 28 Jan 2022 12:40:59 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Bernard Metzler <bmt@zurich.ibm.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Gal Pressman <galpress@amazon.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/siw: fix refcounting leak in siw_create_qp()
Message-ID: <20220128164059.GA1861131@nvidia.com>
References: <20220118091104.GA11671@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118091104.GA11671@kili>
X-ClientProxiedBy: MN2PR05CA0035.namprd05.prod.outlook.com
 (2603:10b6:208:c0::48) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86b806f9-bf68-4261-1389-08d9e27cf77d
X-MS-TrafficTypeDiagnostic: CH2PR12MB4072:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB407263B7052B60DA90C89CEAC2229@CH2PR12MB4072.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Pj2qfLLcxosdw/bSN3NrUWiYdT+AWvxQQnY2Y7w7HTjV8SnduskManaKWg44RMcJvdqsUhdgS0cFd4ofiL7L9pxJPWc3kG5+1r5ys+6s12NzXPn4ftlrmaiQs249s5cz47zOGYW48rnYuOQVo1Hlktqx+OYXC/5CV15SnjWxQXtOEcBx8hSq/+gbHGBisHGZrerGK+nBp24hFpsxsyitjQzkT4McunPW8U+uv3WDx5Y0yYob3V/fSKLp79rbs9Awkv2DiJsIgnpMeayKeuTNiF/z3n3wHPCJDBCeB898XfhEpyHy6nldacuqBa4sOm1o4TvkZNWaHSH5YrJNme7XrUgkt4lkO5ClbAW3oTTADAofW7aXtcqnzPAD3i6P3mJQ2c/rGi4jjwut61EWASf89bGqFrufuAfQ+iv7g9p1ZpomqhhQuGfUTotbARZX0LWYsApV129ZsHTRYJ3lAAAaX/JJti1X4N3VfitSSItUs2n9sRduiJSeD/ZB1figbGAuS7rY1p9MFNJL1tfbC9yU0/pAxRXfrFRnD/u05rNDhOd6/25+HECMIdp7KYdGjMU7/VfPd4DiW/Pqt6zGWZbBKSljyr7buw+7VIOm5ps6aBuypG3a1jWOfvEKzBBQczmpd2G/st84FhYJcnb0BS2sA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(66556008)(66476007)(8936002)(8676002)(4326008)(86362001)(4744005)(6512007)(5660300002)(6506007)(33656002)(2906002)(186003)(26005)(2616005)(83380400001)(6916009)(54906003)(508600001)(36756003)(38100700002)(6486002)(1076003)(316002)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5+3X2DRGg9cKNo94uyyQeQprITdBn2S8TKHdIEtmZME5WjBjOjlrqdhBYBZk?=
 =?us-ascii?Q?ycj/pLEsTEW2qf9LtXxdV6Wkt2cvm1lf/WpYJmTlKXJwTrYddJS4j4ZNraMq?=
 =?us-ascii?Q?/uyvw9sdXP1wQZfk5ZKu4lCfuWX3HGe2VXM5DfHEm4mYRRETxtEBUtBFAyfV?=
 =?us-ascii?Q?c9qEY1zIrpMFSp6/8ZOdmV7N6H7yOM1EovS8x1K5FJu2nfFRADruAoetMU1b?=
 =?us-ascii?Q?blUqV65h4F1G2KN34ngcSuFTXZ3FseWGqzz+ec6gmMI724uUgRV8fyoQ8Eh/?=
 =?us-ascii?Q?XN9SUPDInWbTCYXmzFSU/RuhjsQw6ZrcJQD2aEDnYIBit6hVd7sJpX/PqPap?=
 =?us-ascii?Q?xcx/2AaMW6Ph2V3Z/JvN/eq8zCB1oKFK2Z6XQAARN/jHrOD28M0objnZKlme?=
 =?us-ascii?Q?Fd1rb2Q5TpVKlyFQLuhbcNJYLy0NdUq3E0XLCGJj+YpG0DlmV85hjwmZN3Q0?=
 =?us-ascii?Q?DZ0qg0m2Vn4FsUfRxLspMZ9jMdlvAyjsIWoRRYqtkwHZlB1AR3TDvGLOqC/J?=
 =?us-ascii?Q?/yAunr9AEqAnYl5xiqV+sK2xrWNifrFTVFrvh/CxnFQrY3IrBDXsihqB0b6z?=
 =?us-ascii?Q?Qw4MypJbl0EPgH1juxIE1rKLqXdxHnSzXUmED7D6X7cMEBEG2GR5N0uuzREH?=
 =?us-ascii?Q?IUafZ6Sr1QzqyS5rAdP0Q7mDzSh6TI6WGuG2ksSHjuBRntEMormiYejGA+1g?=
 =?us-ascii?Q?8zgPX7W+7LTpgur1fJjOP6mDWa7degicP0RAfTENK9huGN5IK69RnXWS7CrI?=
 =?us-ascii?Q?QCOyjibigx5rUUIshXlcpCaSvipoX+Mjmb615MPfA3Nhib3RYw5SkLA1vXjO?=
 =?us-ascii?Q?Jjp/6nsevWpgUxPCWmpAx5SAFv+KYzNWYaZX5ydDSj6m26E+lMAImH8PFrZt?=
 =?us-ascii?Q?48GKcsNPBVlSa1nSJTksTiSHE7Zexnp4YkN6dWzTSbtFpqjyyHo2lIYHAxkz?=
 =?us-ascii?Q?K6NyW8kGx25Zn9kAXEZAvi/c8gTz/Pu+L/AZ4FeXr82YgMnaE/c/ZHt2GikD?=
 =?us-ascii?Q?CsrhFr6vJ3p3opIWWWKlR6W43A0fbH9CLkmGbG+5NjzEJMSMaRt8sFseiNEL?=
 =?us-ascii?Q?Szv657XN7KXd6dTRZ3aZG+BDnGY0TOxdx8x477HFFfy28ys6MLrISt4VuZct?=
 =?us-ascii?Q?s4VRUMtb1mAKJMEg1ZlAGvpdGI5g8c6UWveEtSRT+CXQS63demO6U4iDpVNj?=
 =?us-ascii?Q?RfrcaLWpnix9g0OEa37iIt4zp4XDr9s4726Y5jGE5iz8C26jKshDjEht506U?=
 =?us-ascii?Q?7W2UPiBkywr+iSpFAa1Nu45djY/7tPTMkcIer4dEa2hIg/wCdORmPIZ8rUng?=
 =?us-ascii?Q?mQiL65eYFp4f/X7yRjfNFdeFfbExt94Yz4pZ/tr6szu2dN5C5lQIM3dMaESY?=
 =?us-ascii?Q?Uj+wNg8FHcLfMXD5wl1dz5Zi8GAt4MFW4Xpt6L0CfQRYLgsel/WtNbJTuQPR?=
 =?us-ascii?Q?SRMwMkmOum08az4Y4rH2OgI+I3UzeniSl5K2iN7jGxwoTxVNt4cJmIZuXX2c?=
 =?us-ascii?Q?2bJ+V23Q01ZE9fsMvFi+DBfcfINGXKD6Tm8oa57fpg5zJYyiCbpqdmguBulf?=
 =?us-ascii?Q?c/ALydyYYe0IfrkIM/g=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86b806f9-bf68-4261-1389-08d9e27cf77d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 16:41:00.9377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4uyol/SO3DdyCRWbBfYTKgAM1EM8NbNlawc+RJHYI5m7fq7qPtoG9XJHzi5wXh5A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4072
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 18, 2022 at 12:11:04PM +0300, Dan Carpenter wrote:
> The atomic_inc() needs to be paired with an atomic_dec() on the error
> path.
> 
> Fixes: 514aee660df4 ("RDMA: Globally allocate and release QP memory")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> Reviewed-by: Bernard Metzler <bmt@zurich.ibm.com>
> ---
>  drivers/infiniband/sw/siw/siw_verbs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied to for-rc, thanks

Jason
