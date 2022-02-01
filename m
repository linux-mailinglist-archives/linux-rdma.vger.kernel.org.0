Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65DC34A6581
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Feb 2022 21:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239003AbiBAUOz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Feb 2022 15:14:55 -0500
Received: from mail-bn8nam12on2063.outbound.protection.outlook.com ([40.107.237.63]:2145
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233574AbiBAUOz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 1 Feb 2022 15:14:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YNU1Gmwu4EunY/nhcwyzQzAYQrbl2hAHoyO29uStSlTP38XlgOWWAhLY+J2Ys9gk5ld7QILuETuAMmoXLWrVWTnQnQROp1ejHjLcUOn2UUd2iuVCwjNdymdFHEhZNG9d8ha7khV7E+t5d85IwV9gd8nIdghVHZzgS1Ac4K7iTv2inNF9B241fR8bMtRBLZQ0Cat/jp1YZ/HMNaM07gM7o/cqjjhmUtLlrWBJadp5e37JeUFYIQtbxSnGOXBuHcTTahkhDafdYKiyr8dOE1WG4Tew73BvZ/TdihI5lH7NOoegl3PChRrgmzGiWPLGwDGqSYLMhfb0OTrR6rbIUGrRFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dYrBxBLDLaEw9qW2EojsCeF89OEHUr/FuNwuyoOm4Ow=;
 b=ZLcvtPXxTHGfWsz9k64OsjRMV7kXrtKZhehcr4IWTFiBb/w1+0n9n7NgWsRcTDCqZ8o7vaLE9NYSQ8WnrGwWtCmCWy99fkRId5S+OI2qN+AGIOuaoMbuLLZjhkWIQv4qCibGEnrPT2dAL0XsNMiTWnGqmWd0IJpLZAz5SH7N074bIjiiwIdhbIx2XV3kARwglWuQPNOlgiW+iXYzokd0TUGojYxuaxDfqGmIi8yKx/8z6QMMkEWlBlSzzDNQrOguh1F2UW1T0pINHkVPZUPz5XqWLR4aBlswoCjUJ2Cszqthf8tJWpp6S5Kp7BxE4pjB5qgTiWUSkZxsvUtVv4KrFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYrBxBLDLaEw9qW2EojsCeF89OEHUr/FuNwuyoOm4Ow=;
 b=Es9GbHk3Q2y5cltnL5eksHdn/hKjD2+AkL17rnmbr2fbv99Ks6KEN0RIugPIsJzuE5VYJoG3KhqTLFRPMdLZ5hmDIud5YsWyD0oz7bJJoVxi+8ciVL8rgqEwBF/VHyqo5DQU4K0q0M1LPO7XIWlU8R5wUjFYznJl7KNgf1NFVwlH3OPX98qCKf313GbUYAulkXDyM9TUFXIF310vC/XcBLZ3YTOzEvTe9GX35V7dUGnzrqKuGMkgby1sCwlwveVuw5d42y179SIdeFp1ZxJwdMOHwKjfvJns8xM75czNGMbBLFdY6fizbbEH/Ft0lImBDHqPZZyrETNK1T5lfSw3Qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN8PR12MB3572.namprd12.prod.outlook.com (2603:10b6:408:47::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Tue, 1 Feb
 2022 20:14:53 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4930.022; Tue, 1 Feb 2022
 20:14:53 +0000
Date:   Tue, 1 Feb 2022 16:14:52 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v10 07/17] RDMA/rxe: Use kzmalloc/kfree for mca
Message-ID: <20220201201452.GO1786498@nvidia.com>
References: <20220131220849.10170-1-rpearsonhpe@gmail.com>
 <20220131220849.10170-8-rpearsonhpe@gmail.com>
 <20220201145342.GI1786498@nvidia.com>
 <e1b6b398-ebe2-f5aa-e34f-58b786608b1b@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1b6b398-ebe2-f5aa-e34f-58b786608b1b@gmail.com>
X-ClientProxiedBy: BL1PR13CA0018.namprd13.prod.outlook.com
 (2603:10b6:208:256::23) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89e3c1b9-1c42-4c31-0545-08d9e5bf8231
X-MS-TrafficTypeDiagnostic: BN8PR12MB3572:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB357217FDA374823EB11E1816C2269@BN8PR12MB3572.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BnE4lYYVxHjexh/m97JyMd/wd1eBoCOuFN2PtfJDHN3CSOFiBxe0McKxm2CQTSz+I4bdRbSNTG92BgpmU0Hwf4aeAgFUgklqtiqElZUHL6jMNQUQVd9cICQ6saP2M7XrHFSQDWWwOGu+Le6TS/OnwqzVFYZNp7jiHKgq4JVtEdOyXyv817sOykdhrIGCVXVMpnYDg+orKTQvJ4/hnJCawVlDSEbKWG/aiN5NUOR8l/ghFttWrv/WATqLy3qFxyyymkQQFw017Y5OotC8Yj96BYDmIVgapxGXhqXgU0tsFaM2XkzfrEuvwBFubv53q0m+embKXYLKQl4XXT0Q+Z0DClhaNU0Kkp7IbnaG3+vKd8tRYyVngFPkrhZR0L5h/p2Rm+Krn8a6uecQtv9YX0Nsy+aa5/zWqcwIbc5LfnguMZX9WB+m1QYlyL13Zwig2OtlSLuMIzRgBsY6xO1PUEgizvDKdJI6NW4+6Br7bZNH0rdcr+EuIi7dlLx9oS47qAC2qF9AwsXOV5rpXJIOUvfQPcWAJv2CSs131xbHHU9hUvoEIxAMdItY2VepJMcP5m4CFdWpAvTA5YgiQbHSvdr9rQjsjtGueoEJdBW3rAw30BIO3QpwKEKdVMattaJsTBjiw6gUJ8XnBC3lNSVxARvSsQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(8936002)(4326008)(86362001)(2906002)(66556008)(66946007)(38100700002)(66476007)(36756003)(6916009)(1076003)(6512007)(6506007)(26005)(6486002)(33656002)(5660300002)(508600001)(316002)(2616005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w+QjORv89oVsJS9FvtP7ef0elUPjtLXWBdxb29QCGJ/iG5T2dnneJf22PW3d?=
 =?us-ascii?Q?fptZ0IHsjjX4bY8Gp5UAMk9pzgdwcfnDO1ZtU0CK9UgFRGDXiYUgriJASNZq?=
 =?us-ascii?Q?X6kvGDIoJ6UsOT3Ph2bvl4Nci+FlhvU3eVp08lHkXymGsQJU9ivm4+CTAN/q?=
 =?us-ascii?Q?/dz22ew/DvPTksP8Zuo7J42fktaB69UwPrd0trS8YRSRWLmeJhhi1KwCwdCs?=
 =?us-ascii?Q?KTyc1NulEpFz70l4/5HdSi6PaveviQBMVVZ00Uah0Stm8ak2Werovy0tifw/?=
 =?us-ascii?Q?fuMI2I2MVzB0GyhZWQZkt6VH+BirtW3kTsYT5RLpHle/ue5qMrimGDJ+dw35?=
 =?us-ascii?Q?Du25QrG+qfFzHZMuIXBCLlKzZjieLUhnI7y231dnePj2TWvSjiesauRyAdfZ?=
 =?us-ascii?Q?Nf9hYGA1jiOE5dDSLcA0P/Hr7aND2ylPo6laXxbiWEnkI84fXMWZnt2VvOTB?=
 =?us-ascii?Q?XDAHA2zgM+FDwUxxdEyjmi6xdWW537CCkdIHFik/brpApzc9ia4PMrREW5im?=
 =?us-ascii?Q?MU4j7aMp4i+VYNUa5eoZcakxUZEmmmdnlI1q36BM2NEeEtIAlrBmjjUARaRK?=
 =?us-ascii?Q?fk0oS2wByVDTTv3Ju4okp7h0i5oCjT4MKuKokkMVCN5jLlN4+tR5QVpa4FJF?=
 =?us-ascii?Q?uEXXZtdwaSClc8+h8+m7JeTXpMJkn0Z8F7+8MtafT9B8KuGBS+t9Py2zvPj7?=
 =?us-ascii?Q?8q45k60uzRVWfKnYUAfZCK2gSVckPdaED2GKOOqf2sgWnyEai3OFQVwZuQmo?=
 =?us-ascii?Q?jylLUFLsxPkbCTqsy4g+n1wJ1w4rra5CGx1s6wqfg3oUKPhauxOjhqrDaxyj?=
 =?us-ascii?Q?J2171VJtjRswp44wLzv5uCbQd9HCGPnZXyDfiGgoRHWiSPeIALc5icuo3Ssg?=
 =?us-ascii?Q?75g4HtZeMLqLArREqzsjN3BQRl+TfBpcam9gzuCxwVSOU9J3TXJwSyuVpmpS?=
 =?us-ascii?Q?uyUreUvtMrIvg+peMFZxdLTYeDc5Jg3FxcObKtmiXcxNZ55fDf8wZSDGp2iE?=
 =?us-ascii?Q?iO/6cfqwQjeCygnPKs6I/E88V/l1gK0bHh5UY+uAm+ypJ++XyBBHsZ5frnIH?=
 =?us-ascii?Q?cKqYGavMyU7KZjE+dBCRrKr/7FkbcEAWbuVm3dRszr+gUWxYKDc4h3iDfww2?=
 =?us-ascii?Q?uEiWw8HeR2IGn6jkSbkvG+lufYAytlp8vGWcslzJ6Qii2Ux+LCNsjnwJJjDQ?=
 =?us-ascii?Q?jDYbUSPPIKvSd3iu5vFpDoG1CGLEuFt1k15c3XNWGt060nZwxlvg+1EPG9KY?=
 =?us-ascii?Q?BUq6Hu41wkzp2NlQ+Co30lmb5k+ZEvGeVcjiglTrlMV1Sc8FwjFo2HCkTbjO?=
 =?us-ascii?Q?nXBdmq9o4yJBNlsE5pdIPZrNyq60SL01KeqMj923g2K3DpiXhLeeUv4IUKAH?=
 =?us-ascii?Q?G5kcqwX4Bt2kkgFTVTw7c5FSYJvUbu3V20kswE8GUI4ZRIumkG4PijZSIwDW?=
 =?us-ascii?Q?l7i5vdU3+U+jxNu4dYtxgfoFWRqAbr5VIkVMKsW/KhldhbS2aD2OcOkb4Yrb?=
 =?us-ascii?Q?ZJTQ1ICHNR5PTnexTUyEFNgBErFS2qugucr6Kd0EeqBsI0nPiqYzbGx/B05G?=
 =?us-ascii?Q?8z+Xy2Mln09vDGYvgeA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89e3c1b9-1c42-4c31-0545-08d9e5bf8231
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 20:14:53.6494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OQmIeegL7CLQqXttj8ae6KFbBB8NRh4u2xeoT9Tc7B4RG6j8UabvY5A+cKiroEjL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3572
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 01, 2022 at 02:00:09PM -0600, Bob Pearson wrote:


> as currently written the local variable has a kref obtained from the kref_get in
> rxe_lookup_mcg or the kref_init in rxe_init_mcg if it is newly created. This ref is
> dropped when the local variable goes out of scope. To protect the mcg when it is
> inactive at least one more ref is required. I take an additional ref in rxe_get_mcg
> if the mcg is created to protect the pointer in the red-black tree. This persists
> for the lifetime of the object until it is destroyed when it is removed from the tree
> and has the longest scope. This is enough to keep the object alive (it works fine BTW.)
> It is also possible to take ref's representing the pointers in the list but they
> wouldn't add anything.

I think I got it upside down, but OK this works for me. What was
kbuild complaining about?

> On the other point. Is it standard practice to user ERRPTRs in the
> kernel rather than return arguments? I seem to have seen both styles
> used but it may have been my imagination. I don't have any
> preference here but sometimes choose one or the other in parallel
> flows to make comparable routines in the flows have similar
> interfaces.

Always prefer errptrs.

Jason
