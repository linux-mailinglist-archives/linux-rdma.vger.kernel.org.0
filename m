Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127E15136E5
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Apr 2022 16:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348377AbiD1Ocz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Apr 2022 10:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiD1Ocy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Apr 2022 10:32:54 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12ECE939D7
        for <linux-rdma@vger.kernel.org>; Thu, 28 Apr 2022 07:29:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IguPccjHkJ9vIddFhJf7WqKBMBKW5h3JkaumjUa0OIEGG6p7frR+XXtpIyzPzndyGQaa/UX7fhfaqXy7kLazgYJq329q3xeSmXD04Djo9JB6KeY3sFcypQKw2xMjuC6cwcuYy9DKD2Q7qcHM0U/M4Te0z3vp4hRlNJTM9OkX2utdvZnajbJsGwA3ZYOH02HY2ebtAyzz5AtENtvCtbZzQtBBC2NpoqPb3UNevzlBLGGE5ySFGHwQQTLHC+pvnTsuAv2nfEROedKTr13YFPdbuQaDxUm/K9m10YYzbj257lbKDyDZazf8X04mfLFiCct3RbOejIhGzjWdg594DQBlRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L2SnND7G/tA8p+xt9xQgggNSa1b80FSfMWZnsEeBclY=;
 b=jfnjZ7NJ75SUkUX2oVYn5idc/9Avs6wiVOTzQ2N7qMdAILTGz0NO8fGl5knyg8D7FtSLcoX1rk6MXJZYb1e6myfkplfGsMo1LNnlXmnv1SrHd5x6QAl5tceZV/p4sNVd3oYWp7z4L2D+zuzZ6CiCHeHujSRbAhZa6Jql0N1KZCDPSn0c6ssSpKtensmOOYW1VFsNjIwcr8MOMbtHUB31KfTziW5/aInrSPGCs7A+vrxiN3xzY/1wdYMuvPXlSV5zkb/AW3vrhMQvfrbFyQmbKh0fSZr/lmMMKK8AgXMm447gPzPqTGlJXD3MtRh/R/ffLkD7jg1eGaUm/ApRMegi8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2SnND7G/tA8p+xt9xQgggNSa1b80FSfMWZnsEeBclY=;
 b=ZAe12oVjuNrg7ylsqVr8xBxyG3AxX9VqgLnvuWUWqEcMX0NJg5piu/mFryp5ysVDOgXmq1uZFKvAM/eFbQAOyhs01efqLiCuJQ8HtMLTURw4NyqZURny9t9EQY1FlRLHP11z4c3jTcSGNySuQGMMh5rGXQEcrbHz2nsgLeWgrJGIxHPJnAmfzjn4kLNlutby7Bo1bxJ8EBTqI8PvBg/BAjR8SZF/gAq2OcT+mczh01lf8abnJcyJVKYIE4zmTt+sHVFWBjdQhE0stjdeSCkX/VYKo7q3EV341W9VzoJ4OrOesrQD8va9FCzMFpLT22iwWTwqBgauPdMwOCVZt88Fdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN8PR12MB3378.namprd12.prod.outlook.com (2603:10b6:408:61::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Thu, 28 Apr
 2022 14:29:38 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%6]) with mapi id 15.20.5186.023; Thu, 28 Apr 2022
 14:29:38 +0000
Date:   Thu, 28 Apr 2022 11:29:37 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Yanjun Zhu <yanjun.zhu@linux.dev>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        jhack@hpe.com
Subject: Re: bug report for rdma_rxe
Message-ID: <20220428142937.GI8364@nvidia.com>
References: <5de7d1a9-a7ac-aea5-d11c-49423d3f0bf1@gmail.com>
 <98ad3df7-b934-ad2b-49c6-bb07a06a5c4f@linux.dev>
 <dfba7eb7-8467-59b5-2c2a-071ed1e4949f@gmail.com>
 <20220425225831.GG2125828@nvidia.com>
 <8bcec47a-a484-494a-7fc0-66a5d7f52eb8@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bcec47a-a484-494a-7fc0-66a5d7f52eb8@gmail.com>
X-ClientProxiedBy: BL0PR0102CA0040.prod.exchangelabs.com
 (2603:10b6:208:25::17) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b2732b7-3c39-4f71-fc90-08da29238678
X-MS-TrafficTypeDiagnostic: BN8PR12MB3378:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3378DCC00BFC7CF5E6A0C6F7C2FD9@BN8PR12MB3378.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FvrX3voY1IbB3OUAjVN2Nw82cZR+X2ed5oqN7Hnaf900viswBudGv5rHShioXXrsMVpMzmMdkL5tiQfC82s1yqIqdyski1jD6HkdmOzNBzRSgG1fMN2Texk9eworgJ3YrCxZKU5q0Z8dTtNYzcShPVcITKiaw+jPRZqzBXE3AGGHBFI7PP0eP9qRJng9dB1/lsZaXZH9yYkhD+eUbEqAaMy25OsrC3cvtQCb7URwuDH29HA2LrW1KTyCNMw0HWVRFCgbtia6fRX6C3Yf/VWWzefOCNc14uS95uI0tSi4wm15Vf00HqvsbImC0Uqs7SUm1UMXKEtMAnawjmlnfqzF2HPqj+t6dIpKCa/RJrrMt83tvbNS+V3FT4qfYvSpYeXOMhFCjbOrxHVPMw9ZHRxrkT2wEEkM52AF5TasQ6U0l8LzL1aUEo+u0FM372jpQLPC6aBpfEJG0uDGMTtZHkJdUcEUSV2sIW+FLYPBh+Q4R9VoAsA4A11Y5IAWN67Q7IA1HycmJTUqovTayZg3EPxt2IuCB9slt78DSshfQWDY5qsry0+xrSMoKvDzmdtsXpEM9fVAmdXK9AwbpBpPAuPeUBo8WOhrfXhDzbepJXeKliJegaLIxMcZ5svvw9mWHCuS6GFSk2amJ8jKR2imm4o4XA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(5660300002)(6506007)(6512007)(6916009)(38100700002)(2906002)(8936002)(33656002)(36756003)(2616005)(1076003)(83380400001)(186003)(6486002)(508600001)(86362001)(66946007)(316002)(66476007)(66556008)(8676002)(4326008)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qTbc+QugaaeTtIDnep1o3q97jTrGhnL1j3MRIX+ztMnhksNoCvqcljP50Nmf?=
 =?us-ascii?Q?J1bgq4UyXDAomF6mRiXwxvLlmfJ0Gcv2yMiXzPf7niQnHNEx6jvVz6MTahON?=
 =?us-ascii?Q?n7Cv6sFAbNogNipoAQwfAnOROgfykjWCBLn8NkZ84P7HT5h5BXehv0a0vbah?=
 =?us-ascii?Q?LHeQgxuIDaIKfai8cXkrmKj7Bz5tz6s80GCkH6XU4Fy79MVZ1KLbSqDz/LbA?=
 =?us-ascii?Q?gZJU1McUkhUK5y+9IGHh0HeFAEipurGF40rFUhuFj1/JlcaFObRN3fDor2aE?=
 =?us-ascii?Q?n92RgwXUVfKXxUYMbtmqK3lyiGGjjoSgGwpkUquzWTte7nts1Kf76Mx8jdsg?=
 =?us-ascii?Q?DWUJpGT56JF8icOQjeSpIa2jlvYi3fAiYdgDSfL/sqYj6BugI563B469GnQl?=
 =?us-ascii?Q?aXH3PpZBStfEle8tRxLru97aDCMfnLmr4Iab7dqPLQweh9/x6TsafqjsChpw?=
 =?us-ascii?Q?/qL9Z89jl/8UPOVjiMU5t1Dc0WW0eAgX+X2H8QU5aw2ibjCBxOac19nrY789?=
 =?us-ascii?Q?jiaNyvTsMeqndwGaldw+ssSB3g4RoJPb5MmMfrYCKcxztu552Wtu5AxIeOi6?=
 =?us-ascii?Q?B0Ko3DdwXrcgb6UEC05xQlaNXzmk+iOVmVfl3bx6QMURms64IzqsC2KDOXlM?=
 =?us-ascii?Q?4zWPoOwODaaiZlLeAcGOncRVP4TDWKefoXwEiQ3AKLwEwaRGNpxEE1BcMdNR?=
 =?us-ascii?Q?ZdExXWCoRKQ1jItWtHfzzJaigWfghFAgzwP3MuUoimfVSBIKAEObOKFMSn9V?=
 =?us-ascii?Q?qPgseXl81+T1plUd6j7OgSmnIG0Fg1JVbhsdWo6PChz0vYn5YR0QKKs3XWZc?=
 =?us-ascii?Q?IbC7M/M6LRIRVTbNj2RizW39ZcI2l0ugw8pmDQYl3vzr+QhwukDPgmZNK+iY?=
 =?us-ascii?Q?KLCDjoD9v/nDkcvM82ZO+w++f6TxCdELfk1hKvxdUsApSkNzuk9QcbaeuYDY?=
 =?us-ascii?Q?PsncOrBT18MEGy7wB3caxmUlf0gikqvcAyzkSQ3GH6Kz9KETMRFH0qMekNic?=
 =?us-ascii?Q?U/DZQvzUVuXuXTxlnCoRMbWD9rsXnozH/9sdzN3/4FFBi/TXhbiDFTgY2JEt?=
 =?us-ascii?Q?ruXOBJH4jOg8BlI/Djp8oZdHfZRZFlESTCsz2282+mjb9AAy5s7t2N+XlAXf?=
 =?us-ascii?Q?nK9MdQ6+avb2+I1F1h2t4ZUr3h8N77UFog5K9YVJn9kJqkbh52bhU/+DQura?=
 =?us-ascii?Q?wwApxVPhpX5Eq01lOHVNTP95CnaaFjvEq93iOKbUeh/Vcr4QdYUEllfUxpe/?=
 =?us-ascii?Q?FlxzhcNMB8QEnRadS9tKCbmWgCQFa2lTq+nG1CeBF+gSOnH5ytWhuvZpo5/+?=
 =?us-ascii?Q?8rmCJtS7Rm479EYIlbLOsMXgxN/ReuLTgarP8yjCvdsL/uKaSKZiALxvhRa4?=
 =?us-ascii?Q?rjUocHvDnzlEeb3Ce4GglhOw3dTBP4MQNyPcEv0RI+P6PvAkT3B9V76T4Dt3?=
 =?us-ascii?Q?4cxTRc3wo4vFjREIwbns9s7OrSKJfXUGS1FBOt4G1pQBOsuG3Rqy1G+NrQPd?=
 =?us-ascii?Q?rix4gKu5QvZc9TaT6371DbgLp+a2jS3tHcLhHO/pBRiGyeFXhN86EXoLJ2kn?=
 =?us-ascii?Q?i+dSjZUKceosPAFYTShsNUZdnxq65MGlVVw2KGrxad7GFOEvc6b3Q15s8xl/?=
 =?us-ascii?Q?wL5Qm7svrDgVoDOaL93bW087XHc2Wz/u+ll5d4C2f0m29mauMM385QWCO4y7?=
 =?us-ascii?Q?ayE9BjegQUHjuU5p/StD2NA/xZa7250jRIaLeTSxcxA+672qVde/X9vSJDLB?=
 =?us-ascii?Q?M2BKNRmtpg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b2732b7-3c39-4f71-fc90-08da29238678
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 14:29:38.5014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HQkOJCjhNzPx/kt+4LsEM2mY0gNNrgK8DB86Q+HKPoRWSP6EJUxGPceylzpljkwX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3378
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 28, 2022 at 08:31:24AM -0500, Bob Pearson wrote:

> This is a strong constraint on the send queue but is the only sane solution I suspect.
> It implies that not attempting to redo local operations implies that the verbs consumer
> must guarantee that they can safely change the MR/MW state as soon as the operation is
> executed for the first time. This means that either there is a fence or they have seen
> the completion of all IO operations that depend on the memory. It is not clear that all
> test cases obey these rules or that they don't. We should WARN on those situations where
> we can see a violation.

The spec defines the fencing requirements for this already, see for
instance "9.4.1.1.1 Invalidate Operation Ordering":

 3) a SEND with Invalidate operation may impact a previous RDMA
 READ operation. Thus, a requester should not perform a SEND with
 Invalidate while previous RDMA READ operations are still out-
 standing. The requester can set the Fence attribute on a given work
 request such as a SEND with Invalidate in order to ensure that pre-
 vious outstanding RDMA READ operations have completed before
 initiating a subsequent SEND with Invalidate operation.
 
I have no doubt we have subtle ULP bugs here, we've historically had
bugs with ULPs doing invalidation wrong - the usual mistake is
assuming that the recv completion is sufficient to trigger
invalidation - it is not true, the ULP must also see the send
completion consuming the rkey before it triggers invalidation.

It is not guarenteed that the SQ completion will arrive before the RQ
completion, even though it seems like causally that has to be true,
lost packets and other abnormal cases cause problems.

Jason
