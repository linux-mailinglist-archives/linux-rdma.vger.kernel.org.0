Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9BD951A241
	for <lists+linux-rdma@lfdr.de>; Wed,  4 May 2022 16:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243566AbiEDOhS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 May 2022 10:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbiEDOhR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 May 2022 10:37:17 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B211FA73
        for <linux-rdma@vger.kernel.org>; Wed,  4 May 2022 07:33:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DE4JoDk48/94sNInzRH45DJmJM7jPpUEr2ObScJ7IYq3BHEPibyEGnbZalCruznerEGpyIorLI8//G0bOSWCa3snqPVU8f4Myygpdupr77ZqmdB57yj++lozZyPoFqQuoMfCpZ+CddS5dfFi33S1l/a2bnFPx88xM1g1DNX5yYetnFMjRZq0+q9JOYCJ8L7lVMJsqivB3/xAr+GHuRwabLSeaKK4+kK0qo7gtaaj71LHH7uhedkeec7Ah60e4MyD51PD92mpte3GX/q8k+IUheCCAcXXXxp8ue8GQj7BGuO1lVgvdYKOxzc8dIiMQAXriSY9ZHO5RN79snxSQyH2ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uvby2zJeIl1vEZWu4bbr96FDKWidnHV0dcFGtC0NVZI=;
 b=EoK3KJZcEsQFCIwdGqXOrXaKqf9Hxwmid2QsrKh5nMqt+i35Mkmv/jrWVkonfPfpLaRmNr+jE6roC6QCxdO/ssObcfHk3xQo0USjMSEPjDA+HSlAYOrZU7f8TR9ejuB0pMtDoqZZlFSR8MpmsIWTDjDt/10TuTP/dg48dwa/mCJErL1eX84tLka7a935v5+3SwqcYuSrmuiz1v+DVXgQNpPrTisJDUcFGNrF9nfAR+YFwhEdNrdgmr9vTKVyA/xQBCsfzOC2m18R6f/HG4bddcQHVbjMrqbXdpvccdS3aSHuSwiRlDndG4W/Lp/vilituIkKg25dbwL2xsxaZsyz7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uvby2zJeIl1vEZWu4bbr96FDKWidnHV0dcFGtC0NVZI=;
 b=dSAlSzAZWJwnK/kMMO5+7KK1fLTq9DtYYXNrZPsSYv7Lv5fCe0aq/Rk1uyEkSad5YM1DaDIg+lugujIea/wJGiq0nt3TJZsPpCGzwoi9wS9MK8WU6jdFO8FbiMa2X64imI8Qj9OQevezX1w3r3+E4Sy0UztZWU21+bhJdPB7xJonAi2bMMRGQsPHCGHJGFYgQwJ1j0xIQnnk24xxJ/0WbXVr9Rvc5UFp6IsHGCGyu5rWcdeoVndV1ohSU8+guhGLK99vKY/SpcAdt2/Hu02aOpFeHlzdSut2tlr+zilaVOJbP+9kDPVpF9m1YNWRLNzdoFZJ0knccBj3Z5IS4TYcTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CH2PR12MB4806.namprd12.prod.outlook.com (2603:10b6:610:f::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 4 May
 2022 14:33:39 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%6]) with mapi id 15.20.5206.025; Wed, 4 May 2022
 14:33:39 +0000
Date:   Wed, 4 May 2022 11:33:37 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Cheng Xu <chengyou@linux.alibaba.com>, BMT@zurich.ibm.com
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/siw: Fix a condition race issue in MPA request
 processing
Message-ID: <20220504143337.GA69830@nvidia.com>
References: <d528d83466c44687f3872eadcb8c184528b2e2d4.1650526554.git.chengyou@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d528d83466c44687f3872eadcb8c184528b2e2d4.1650526554.git.chengyou@linux.alibaba.com>
X-ClientProxiedBy: CH0PR03CA0274.namprd03.prod.outlook.com
 (2603:10b6:610:e6::9) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 716c8c52-b01e-4d6d-8f7e-08da2ddb1440
X-MS-TrafficTypeDiagnostic: CH2PR12MB4806:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4806A1282490CA13019170B2C2C39@CH2PR12MB4806.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IVfdx3Xxa1lpurXBs6IUzwLfNslefPHgmaTIk2fEdVtFEIM8imosjWHXdXEthCSfNAEoxOhrC3WVfTcHliUEyh+1CyLO3+F+TAlhQQB6Mdni4Ly2F8OSyGHkQh7MAYTNFExcmMY9nzGM8JSCw88RML5QceYBvS/vncxBuptNIuX/aXxbv7WEIiEooqkD0oCjxXa9gkgJh15K/kYcjHu94DWAdNYC9rCvkRD4U4hkXwu+A5HdtBHN7Cjiia+V/llmd07pFnL4RmlmPIOZ3yLY/IWrGozAKay9rt4+13xVVkPqTaFzKdokgWlkjKYzWC3/PG0UHJpmjHgte4Ua36jM4eUpGbNPbQTUCbkPni57Wpqi/B90uh2WZ/3VGwAIvTtDO+NDcDajySiuLjL6rPID4lEIExpnregGjb8picvcUPTz+LA8VSrnavraOryu0al89nUAbT6DvYLqQgyha/KHNE81nSUsy+DyDK+OG7XS4cJt68TF9IYF2CvOionr4T+ZbxnYCWiH+7o61CdAgJRh5o3fLtUtT8cDnuY6rqa8sLzymAqJqQ4Ljpi7EJ5wRkRBrLNr2ZIOuYxEqZHHcyTkkMiL0yq/BUWQFD+0r9laGVjrnTk9xQ4+vYmfck7NFUCNyOlR4wxZCmLRlRKBXv/swkza8CPxe6XjkCZTyPrjEvH6WMdLqg1e7+DqkYT0oWuTmAm/b2zl2s/yN4tXwXgPc0pvUGIyZDjfemMwQu++KzI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(86362001)(66476007)(36756003)(4326008)(66556008)(66946007)(6486002)(966005)(508600001)(38100700002)(6512007)(316002)(6506007)(26005)(2616005)(186003)(2906002)(1076003)(5660300002)(8936002)(4744005)(83380400001)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?772m3Hg+F8spjJrdIuIempREAU4asBUhAVCrxAGFaJld39Tc3iQKI/J7SIfX?=
 =?us-ascii?Q?2SDnTPdRJsRlZE4qVGl0Xh0I/gb9lqwVKyRUMUnGH104xbMv68ukFNOm7Cyo?=
 =?us-ascii?Q?Zfu5OpU9Elqn9kEv1N60J9xXCBJjitembhpCpzRTxTOE+0tiPSlbiVi8Jl1+?=
 =?us-ascii?Q?AtDTZRW+rJUO01iLZScC8eaJ+mzltHqQ/6W5Yh1GgKhlyf306KFVwMMISAZQ?=
 =?us-ascii?Q?MA9mYzrX31jc0QBXBgoLF5ExE6S7ma7c7Se9kk7IU3C0nGfcoO1/gg9tlKTh?=
 =?us-ascii?Q?r6buvGvBlk/FIHvB81zNY1AA374CInxRknRgBDMXOoa7pNLN9P3FW3Q3UXbY?=
 =?us-ascii?Q?UgMB434pZXoD6npZiLt5Sv0psr22ypTKsbT2sayDFc+0iPuL4eD3K8tH2m5f?=
 =?us-ascii?Q?1P9rBq2/hdMLr+TcBua1zXtYwemx3MkQL7aPfUwfQbVhzjY4GsQecjEB4/z+?=
 =?us-ascii?Q?XVCojog7OJ00cX27QhjwC67T+HUMV6J5Jgke2YbA7M6ap5WMId6Ga1R33gL2?=
 =?us-ascii?Q?BJvSVKeeVd+1lwUkLUTDLjlsPBUF0VrlsKBmS60rdcVCZoFHZysxDaXxeXPX?=
 =?us-ascii?Q?l9VZYk7ZnTvm2dWkuYySCPiLwLNWsBUnE4yNl4+FcYZjHYaFfs2OTERxdnIX?=
 =?us-ascii?Q?L1aLklIiR5GQMlMKOgfxYhTy5GRK5UEfgWiS9fdgyjMysS6HQGCuMLAf9JTh?=
 =?us-ascii?Q?1wz77UWasmnmCTjUJumrb/HRGSTuHM4jFjiFMUTgC1s9DvWogiLiWQQEmb2x?=
 =?us-ascii?Q?pM7aSrdLazKJvv17THOP1G7NG3PF08rzWwTqGanT8/UftszVJ/L+o+HLnAfY?=
 =?us-ascii?Q?0vYzLWPOaXKqr/z3jegngZekgvMLdLhqNg+ExlsfxZHF9KF4TAbcUJ56wNnv?=
 =?us-ascii?Q?ouTEucqdNU6dB2u8mZzECbJ0TNDYE+n4g5sBBDecynzuohwLalo9uBdjK8Qp?=
 =?us-ascii?Q?xHMiPhYAY3ozKGxRmwNh2FcjR7X/a5RsQcNMwAQ0npAGM5Boz3aXCUJGx6cX?=
 =?us-ascii?Q?IXM/p5enDbGej3FRBkeETHU3b7dxkTANcutLS3gXcTSQ35mbOorQLSFcb88O?=
 =?us-ascii?Q?hFg3FXWBzc9t4B8mQXJfb794FrO/eb3QfVnWUOgq69UlZDUtxXj9MOo6YcLj?=
 =?us-ascii?Q?qVX1JEV8cQfP2yzQ2kjUDMqGV4dc6Q9eYkxa3h3iwLjR2SAjI2jjnz0oFUG6?=
 =?us-ascii?Q?RwTNKD+w9abeA3kXuyLCaQl7clq6xFohVN0QHITw3i4Bks9mTexXYDTjK/ns?=
 =?us-ascii?Q?g7ghVMJbVqZbPk/mKv5B9V+jCRrouCW1MXHrMylv8VNHByOEv9wz5GYAqQ4e?=
 =?us-ascii?Q?NQIXajna5XCyp6BTwmtPTeO5e/bIka/RJNNetbsqUvM4Ce4dpyJCx1hS9qrb?=
 =?us-ascii?Q?+tMaXOQMNKTL2bQz86mAXwHsGlkmP0eT7xQmvVn93jeC7M2S562UDFZJjX97?=
 =?us-ascii?Q?HnKybgSmxU8Dg1/DqTZ4FU2GqBhpZlwOIzhxKvXPqfN7X4qrEcQx500u8QPS?=
 =?us-ascii?Q?Nh7SbNSH2rryLRXQZlXpk09Gze5WE4ou3X54MiWsEMLki2eqWz3+HyVFUAdw?=
 =?us-ascii?Q?pRyErw97Po4G6UAw9llwRLo4hzF0oeQwVn6g1XKWLzBGlE+R+KMx2ZO+BMB9?=
 =?us-ascii?Q?ZtayGSUeF4sHO6q8QzV7rJRTWQ1eFk2TGv5ixpd0Ioad/fZj/SFW+BYxqKd0?=
 =?us-ascii?Q?Sf0Ge6HaSAlVoyQq1DivposC0A6REIQEhRfcEtnvw8kEYjiHHZWTvX0NEZmA?=
 =?us-ascii?Q?MEZG1Qao8w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 716c8c52-b01e-4d6d-8f7e-08da2ddb1440
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 14:33:39.1115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b4EpS37UlwWDiDQHYVXxWPUd+jWuOeG05Ia7rBi3T9GwYRyvxTGZo9KcsVp9+f55
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4806
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Apr 24, 2022 at 04:01:03PM +0800, Cheng Xu wrote:
> The calling of siw_cm_upcall and detaching new_cep with its
> listen_cep should be atomistic semantics. Otherwise siw_reject
> may be called in a temporary state, e,g, siw_cm_upcall is called
> but the new_cep->listen_cep has not being cleared.
> 
> This will generate a WARN in dmesg, which reported in:
> https://lore.kernel.org/all/Yliu2ROIh0nLk5l0@bombadil.infradead.org/
> 
> Reported-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
> ---
>  drivers/infiniband/sw/siw/siw_cm.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Bernard?

Thanks,
Jason
