Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E155525315
	for <lists+linux-rdma@lfdr.de>; Thu, 12 May 2022 18:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356521AbiELQ47 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 May 2022 12:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356741AbiELQ46 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 May 2022 12:56:58 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C437449FB2
        for <linux-rdma@vger.kernel.org>; Thu, 12 May 2022 09:56:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ifUE/oqO3+WxzvVfzuD/bJhcEE1lgggQRJlAx7zumnxAHJLTiMfxmfiMyx58Q9t9hYm174vdJVR7U0koxWESFxwLMaSt/eo15H+HMPjXo+ezTWUzXcAYmDgczoSGR+3q0m4t4LKNuQYeao9AloA6Ekxf1vPCr0vVKdZbfOkpum+r31okRKuFSjzrdJxN9noVe/qb75qBg1PTNLVP6JwK1BKf0Q/G8L9Gu9pR+ULqb5ODbY8qZX5OYX1EiiObx9ZdKqnvSFMSIsm9m+mn9cBj2+xnjUl+vyyKedogis/y58lfSdyw5KyvRoegZr3YfNL+gwJxP5VI/qQvzRTyP0fOLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=98AQstgR8Mzg/Ab/vOa3bglokrq47zHfnHqlEkRKR6k=;
 b=MvwXbEQt7qnZZ+o/5O3i6T1ZOamiP+pwoXUOzP352ll5w6fm6jKnyrcRqhrflB184w8sZ1uGfKzmlb4JJpY1LUlfXlzkEcCdA40+KreGOeDLzq7vJiBVA/DDzdHP8q/EGUiSBhhOvYFb5xa9eafA5OZkOuYQ2vNUt3F9nSA+txM8TT/Eu2IYUcaZtZ4SASxu6OOj4vSqvnNKdf53o6Nl/gyrdlA4/B/vcubXLeNYjb1Sqk7Qp6D9dR7ihh1Khkjd0zOJ5QDKmN16xTngzeqzVibT2BD7h1mmyWB7NgkBexLImCHfLnTST4iie1ZtfbM7EgftUmjZ9fxWjjwEGlP40w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98AQstgR8Mzg/Ab/vOa3bglokrq47zHfnHqlEkRKR6k=;
 b=HCMY+NHTzrXOG9jpABMb5nuGgjj4qr/0SUu0RfXfQwDSQ3nI2R+EUIxp7ueJAjtWaiKbUaSC78ZzW9+nwgZ9hjferkD33vIR1Cb2QvirxzzeTrMFmwWkxAuyK852wAX1NB03q6/rwvHUQb8bXS3TqB4tKLe5liLJ70SQ84kEryH1KJ5OUdkhfbikHu+K5QKVgc9Sj4M49YXw+6Yu20vvFS1+6Aqs9gtpSN51AElggfWQZd1VpjSsTQM5ooRPLDEvbdRlAZw9mxqMrYIBTVq2Yvt5TY611jIhr3LboY9IrZeQ6ownhlYCs6eVnSNl5/8U7/swMgOwKqWJkeJjRGpRFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CY4PR1201MB0101.namprd12.prod.outlook.com (2603:10b6:910:1c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Thu, 12 May
 2022 16:56:56 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5250.013; Thu, 12 May 2022
 16:56:56 +0000
Date:   Thu, 12 May 2022 13:56:54 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Shiraz Saleem <shiraz.saleem@intel.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        Mustafa Ismail <mustafa.ismail@intel.com>
Subject: Re: [PATCH for-next] RDMA/irdma: Add SW mechanism to generate
 completions on error
Message-ID: <20220512165654.GA1364750@nvidia.com>
References: <20220425181624.1617-1-shiraz.saleem@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425181624.1617-1-shiraz.saleem@intel.com>
X-ClientProxiedBy: BL1PR13CA0367.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::12) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b446e7e-841a-40ca-ce03-08da34386c02
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0101:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB010158CE7F15DD940F658AF9C2CB9@CY4PR1201MB0101.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z8h2vVn2tmZ6EjPfsDeXWzuFt4MnfTGl8IGXB7zjcSRVBV5kGGLD++dnMx/8Ko2Vy/oTvnHEnzzEZBPOV2yh+R4vb6HBB3cDlgNZnbTpbDOUsl8HwyQ6vtzvsPBFxP+Oj83R2SQh/PMJOeYcSNxVAN0UI25Q2Wxa/i210De/adSdzBjwq3b32K5wyJNko9UUQo/x8a2u6m9uLuCetfRvVs1UGn3ejWMdcelXdHKxch+lApfm2nKAbWwl9CThVPS+zCVR8vnfBXNvjq6iHTApiNLy9puMA1uF3lxy0dmrA8Vlrl5d0ZR89gSOU/ogE/a/m/8SoT5YCKkcQQ9YOs0WNOrjTr+EUPTb1KSaexkt1O1EQOmMOVq8UEKXcOh3O2yJIVMQ/SbaigVokEwrSKiZdJZqsZcg4u6KTvrGBaQjfvUfJLcgqIm72pKlVhYLe1e9SYWSCfO/DxRjr2fHHQeHr5fBqQK/q8BF7y8Ipcdx0R3TW9Mj83dCp/ZJBBubRRJLTU1tlkDK6AE7Lu2e8uzqpkF5aDikervXo4wH7MOZL3bqqaFcL5UiRJLGMsHA9yl0YAPdg4Nr+C06xSvGz9NdeQgYylLvAfVYmwXtwM7t1k0cmPnTAFpSXeEh7o8fD9qnsd5gi64QELHPlzOVLdtEyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(36756003)(4326008)(38100700002)(8936002)(66556008)(66476007)(66946007)(316002)(33656002)(6486002)(6916009)(6506007)(5660300002)(508600001)(2906002)(1076003)(2616005)(186003)(83380400001)(26005)(6512007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7/YnLr/DQtTA1DvCh/nfz6VUypkqIpPjokZa7ys63dLxgYVtgLthW0k9TsqC?=
 =?us-ascii?Q?lRJld/Z8k/Sn7jmkE1ue2JH+fG88J9D3NKbRJK76YKxBOz3T6TxCGUVzRQHb?=
 =?us-ascii?Q?/PU9ueZRI37xf8DXv+RGJwvClBp+8NRl/ib5k5LDNLFOO9WNT9Z63Ojwg46I?=
 =?us-ascii?Q?0rHbsT3S/8LQwnPhIElbWoOKt8TgO/HvMkExS352LFp8AP7XkhEaWjyRutPG?=
 =?us-ascii?Q?eezJ3bFYllI/105QvecyUhA68GOpOiTCR32AtbSAsOaZ5eLTc1aqWR3NjqCU?=
 =?us-ascii?Q?G93dgzf8wC5XQg3zMu2Irz20yhA7UsCwMH79SlLGp1j0CrNSdHgILk+5sJsZ?=
 =?us-ascii?Q?ncXWbMt4WfDYE1Nxhu5duDRoPxHYQfzCPMA5Wy2OMcg8tCqG+Bdbb6fd2rtK?=
 =?us-ascii?Q?em4Pc635Cybf0JDPccfrTIeQwXkvfnUv2QPT3I8s4tj+Cp/q9XQ6PEg551qk?=
 =?us-ascii?Q?Xyv+qV6ShFMCAgs+TwloCgTfNaqUuCqcvqX5WVKMAKMogPuVDRTnw+ilqIf7?=
 =?us-ascii?Q?wBjLF9OM5JXdK4zytP6dbdjoZbAkMRUsAmiE0Hfkshk5Hp0qSlmOsNG9YrEQ?=
 =?us-ascii?Q?3SJahM/2WA1cMPHCZkhgft245aPeJspxTVNVAfhPJisWfKK1+gARQA+m0Ccr?=
 =?us-ascii?Q?O02dWj4U/DB48j/ex6VMELWMmADMHBbo4UKfwIU3YVIHV4NvPBw8I1XwLECJ?=
 =?us-ascii?Q?uclc8SmwOyL9XYl38rLbvElXzxuF2xbG9FpHPdp7xwypN4agbSXn6ttB80sp?=
 =?us-ascii?Q?VbmiXynDObqdoe0dcudrV6xJNpCD8zhvz2pscUCNyNDmdqhJlw9iMYA7WmqE?=
 =?us-ascii?Q?QY8YLk/fFen82+2Jsiu0c7SmdsRBbsohLdL5ZPWEyGh65HEqiZankq+bZeeb?=
 =?us-ascii?Q?lEEGdJ9027NrdE+jZCCPUPgO7/7Vd0piciHqz4T/dyuXqngSQUh8Ud8NnDtV?=
 =?us-ascii?Q?u9dhYjdp6DxfqZzOEklFzzOanGjFjfDaNv47nbguHhY12qkJ6f3AjUoN0eu4?=
 =?us-ascii?Q?bb7dOD5MRHyLLbgxKzVyg2Pa0JgnfUL45We1zsLaJaTqcpNkNIdd8yIiyFQ4?=
 =?us-ascii?Q?UVe1kBqG5wo+mZYfKuy0SJcc7Duvo1sObd4Us+vbAm+KD4Zstt+uf/KP8uuU?=
 =?us-ascii?Q?q6uy7ZXdZQf39OBdzOz27tm3H7EueVUqoW4FhL2wRVPxPyTFKFMQkhBlonnw?=
 =?us-ascii?Q?NWbCJ8g2lXoOHDbKOvYOE1YKOJHs+mz+aS2YrFKCwzcD3/z04+5FnUKbLYaN?=
 =?us-ascii?Q?XQmoNqAk7WjMRqE9h75KgGPN0r8+zhrulMPmsi4CC7JBzZ4dME/nc+wsYcLX?=
 =?us-ascii?Q?Dgi2jQiOU0iXS0oTRR/QKNKnRuUYoRBOV5uw9F0pDBfc6wdOIp8PYX6Rs23z?=
 =?us-ascii?Q?R7GBuEyAAlTQg8jg97CUHKfH4jjj+/Bd1n4hKo18xW6FhdH671p21DRiIWPv?=
 =?us-ascii?Q?QwYxL8F8sZ+aU6tyUfO2DTH7hCeM1wCoFNa2TTICW9wDkYEwH41g0x7CLJGF?=
 =?us-ascii?Q?TsfUIlbUBEgtnQxQIptNu9KWnZSv7+GBNF4VUGiBrF1SGRqTq+mjPOUWuKdj?=
 =?us-ascii?Q?kfovlBuGN+AXe8hklJPqXFaBh3MLH6gF9F/rmsmKVwdt7uf4M68VMcXkOzbX?=
 =?us-ascii?Q?3+OiZgJEo76P0JQfEVEzmvlK5GiAtim65jGB66PpUAx8j5vEVfYO6XYpV5jr?=
 =?us-ascii?Q?+He6n4RCJij/8fdy2f1Bis1pkJ5ocgp60XxwaGnA+SyzUgcMT/Dh6+vXa8Z8?=
 =?us-ascii?Q?jEM121OCYA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b446e7e-841a-40ca-ce03-08da34386c02
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 16:56:56.2829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lTan6yuBdhA5ZuGIWb1EUCPtlOXt3jnbceSlIBreSp3Fe1HZ3nmasd6ShwCCY4mC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0101
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 25, 2022 at 01:16:24PM -0500, Shiraz Saleem wrote:
> From: Mustafa Ismail <mustafa.ismail@intel.com>
> 
> HW flushes after QP in error state is not reliable. This can lead to
> application hang waiting on a completion for outstanding WRs.
> Implement a SW mechanism to generate completions for any
> outstanding WR's after the QP is modified to error.
> 
> This is accomplished by starting a delayed worker after the QP is
> modified to error and the HW flush is performed. The worker
> will generate completions that will be returned to the application
> when it polls the CQ. This mechanism only applies to Kernel
> applications.
> 
> Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>  drivers/infiniband/hw/irdma/hw.c    |  31 ++++----
>  drivers/infiniband/hw/irdma/utils.c | 147 ++++++++++++++++++++++++++++++++++++
>  drivers/infiniband/hw/irdma/verbs.c |  56 ++++++++------
>  drivers/infiniband/hw/irdma/verbs.h |  13 +++-
>  4 files changed, 210 insertions(+), 37 deletions(-)

Applied to for-next, thanks

Jason
