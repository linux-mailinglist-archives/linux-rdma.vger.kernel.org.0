Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2356A56D485
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Jul 2022 08:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiGKGNr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 Jul 2022 02:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGKGNq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 Jul 2022 02:13:46 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2053.outbound.protection.outlook.com [40.107.101.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665F9632F
        for <linux-rdma@vger.kernel.org>; Sun, 10 Jul 2022 23:13:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HkwdZcvcJAZGicXWXYn6rogynjVXz19ujnl8DIzXlfGOgbQ2LW4BUEBdXc9EUbVRC2V82vtP5/cq6vsTlLpS62jKKvz0NolXtCunjCxwSnEynUHytYAudAz2v+04MsXWuX3iH8joFJSlgLVcNqariY0FsZiMBFsVG2z7L9aZhVHPBzqHG4M8D9+zG1Iz1PByDYpbY7uy2ugUsmM3omTwQAcgdkiOivPRRW+5O49/WjkUqlfaqWCPumT1akoZJoc2acRwEXlVAFmpf2JM7ObrWZhyFSaDZj6eTIeBoYIz29vna/mFaAvSQvc2dM7wVvbAIqU8fHDi5RqHRFV6b5GV+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJRwwwl87xGIOJ38r3Ss2RDg+tX6xfDURyizxd9S5B0=;
 b=LswhMSzpf40bSCw5EqiLdrmShUdg8njU4EAo7jF1VIT56uAQZ2fotjI8p+K3nJuaRtkKS7RTPbmjHN8V3gMMPYnK2Lz6ECqSpkBf/DbUbc5iGHA8D6EokL6phZAIIl/sVUAhxOd+Sea2vaBHg4ysIsQmKe30kZ4yCCpf3Cf5gbCEvnMEERswAFC/C9FjTLBgyqNbcp/D41+JIwwKUYLZoMOX/6GYNxejLmCvLB56Ir57VqhnFlwNFz54KVgStGOW/rxZem3MCh5Fj4yWLgOKFKo1ClBXyLMDpielttQlj1bgYdOV39FQ/kARst5QG+CFHrPV75afkvlMlpZcbyFAmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJRwwwl87xGIOJ38r3Ss2RDg+tX6xfDURyizxd9S5B0=;
 b=WhWxtNyVJdmmLm2vxAFvkkCeVNJEQqGpKJxSA7s9qTwDXFS3ZPLq3GSMzXFRQ3/n5shlrDsm8Xdy8GO2O8sCF9K0an5gMmUs2BQ+g+g1IJtOxhUvd87Ed79an50facJqEDAvRhX/hzssiTRnFWm1ax5E9mVR6KAHZPuksR5iOb1LY6KnA38lAARUjo1XSw3/e8ABceBSC4w/+m3DShCgibskDiyhuZlmrjvwKaxZUEwRHW3cCuqhycVFgiN5u2r2JHJMwD3tWzuc2C41A520Fz3KT4sFu0XbynCqu1u9i0PZvNPsNrfa+h6MKFGZh1XKCqEFVIjnzdHLcI57zw2OHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN8PR12MB3442.namprd12.prod.outlook.com (2603:10b6:408:43::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Mon, 11 Jul
 2022 06:13:44 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb%3]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 06:13:44 +0000
Date:   Mon, 11 Jul 2022 03:13:40 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Shiraz Saleem <shiraz.saleem@intel.com>
Cc:     linux-rdma@vger.kernel.org,
        Mustafa Ismail <mustafa.ismail@intel.com>
Subject: Re: [PATCH for-rc] RDMA/irdma: Do not advertise 1GB page size for
 x722
Message-ID: <20220711061340.GA56430@nvidia.com>
References: <20220705230837.294-1-shiraz.saleem@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705230837.294-1-shiraz.saleem@intel.com>
X-ClientProxiedBy: LO2P265CA0118.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::34) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9fb3e254-5dce-4ca8-937f-08da63048213
X-MS-TrafficTypeDiagnostic: BN8PR12MB3442:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tHzKnaXUMsp1WJ54PxSahfggjl/AMQI1TLKYjNbaTf5iIw94iDsBdxfbzMVLl0VfdnPFKYG+VJOkRjL3SVQLCERVwMZfI69iDD70uS0JJn1vzmJHBotB31a/UMzutE7TAnhQqmXS/FWOirjArvuy9abXkkQ/iisu452+Ci/8CwYt8HmJzNqZQaWoMe9C9Sgfv4OcSdc19OAsgVgysv642tprmHIvtkiTpg32zpXvr15y6B5GoyqhQgEOQC07RPzKr1ukyiCLrDBylaNpS6SgmVpgVo5W6SGeupUqAyPCxINQo6CIp1zb+YD+GDxY88SGGbkW4THVwfpdGgNWFXFUn5oZZt/qKY3G7DtLEuVfNUDSmC1W2V7ZXHBfCJrATFwdsE0+cvHxFtoNAHCsJhQpNQVNXFmohgnfpdixJdQmrCEW4uyeFcNdOdYmkZ/3UZXHPkR8vUrOtZB+sm/w0Nnt0RN5oVlMkmETrH8FEaj/ulVkMdHHlB2qQuHeFDb8MjXQ08hB8blPopr5Haloi9bxp8ORQ0RSOimTJtnLm/zVmScPcFBAtNfKnKn4nbXMQLjqoUQEOl8ehvwoptLCe1Rk8g2TL7keHcUD/TUgAo3ljB7RsPzX3zl+tj0ZNhmoJGqPHkaXcdXhtCdbcznfpRdnN8u27QH7t28bOe4P+ULs9yzwCVqsCjMxqhhEIMFWTtjEdq7tmgRyYKu/5BRxwRDDn50od78aXLrSIaUDlM8O+olykhroWSuLcxfCWgLaRhch
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(39860400002)(136003)(376002)(346002)(36756003)(38100700002)(2906002)(316002)(33656002)(83380400001)(5660300002)(8936002)(8676002)(66946007)(4744005)(186003)(66556008)(4326008)(66476007)(6512007)(1076003)(86362001)(6506007)(2616005)(6916009)(26005)(478600001)(41300700001)(6666004)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uR7iIkXhrsGT3HEe3lDpVU6jWEvQ7jagYtpLI3B8xDIlwaLPnugE5sN5uqaR?=
 =?us-ascii?Q?drA2gZFI8TeLXKqPiBD9flCyxx5VqW4E4fpIky/Q/EetZMQ816Bv/MdAGRtB?=
 =?us-ascii?Q?gKxiqrVdFm9bkZ+VaAYDzR+W9tq+MJo+NAjA13TiN2STbh4JUtOlBsP8clX5?=
 =?us-ascii?Q?dPwTHY27OI1U0QqvJxT/AvU0fu6bEV5iviz31+ykTY1BRDEkSmyoP1LWHC3m?=
 =?us-ascii?Q?pHA/RLMxyCeT2agJDGHNoWWIqKqJ0z+OndGqOLbMQwxf1q/bvC6Mpic5TKQW?=
 =?us-ascii?Q?LMwTOyToFaKaS36DXDSxz27/bvuHiRKRGALSgK6vqKoB3KTNZxvWOM1T8OBx?=
 =?us-ascii?Q?l3uiDf9FHkJaus3HfKA7LVzAXlZ3fDx/QpYO74byiNXJSD8Hi/4K3msci/nx?=
 =?us-ascii?Q?2Sda9Dip18DykETYLXjZ8kg33oZ8Pw5Xwtx4VfwTwn+3zIeMx4knv0vF2rLN?=
 =?us-ascii?Q?j78uiqKioMJXVZbMdSvHUQXYDBtDPVS2obQM5LN0icj0FS5LiSFUE17IWI8r?=
 =?us-ascii?Q?Wlawy81Ry4CFzwfnB075a+2+zE77rKFVES+IpScIY4N40LkzIsJ9lIQKm9SH?=
 =?us-ascii?Q?8zhq3gDYx/n3M6PQq05c2nhEhzULwv2daOCAKs3LSKBoIOU9iDfY3E0eEidM?=
 =?us-ascii?Q?B7drFV7vnL2GGYdEsxXNTnbB2BiVfJulTPZ6HbfDnvYbj4wMLjpBSKNQkZLp?=
 =?us-ascii?Q?cBo2Qc1uJOlSwNuoA4+lvuDFDop/7hj2Go1qXpluTsqNz319Fm5PH5+HbPhP?=
 =?us-ascii?Q?jeG6lWo/Kq4C8logeELLbetyA7cN6SDronXfMamOJu4iSrxyVGyChOuYfunK?=
 =?us-ascii?Q?3bSjmC/uJrajbPQszM8Rml6WvE5qw5Lt5rogsnUQ4pWLsuo/UbNg9Oo4MSzx?=
 =?us-ascii?Q?u/R7KE7a3uAgMPqxUowBuh8OnFgX977MZc6IdSoU4og4hiMw3o7zlMwR2Yrl?=
 =?us-ascii?Q?M9pszcRgV9ng977EMHamBfMiml8GAIniQV5NfSt0dexz0itn8nq2PvZIA56o?=
 =?us-ascii?Q?M1CU21WIMiWBFhqehxjTLI9nW5u0coxWkx7+61QG7RtD+/ec+9Toq4EaITVs?=
 =?us-ascii?Q?1VXm89l/txb0HFxI05FF1qD9M8USJUfiLxfTNKRvyt/akze8Ot6LZ7gwPqGX?=
 =?us-ascii?Q?NHEWj360m+JdRSkA+IIMTcJcngvu+SUu5oEAX51np4EQ8ruzO+1Jnm77cRkq?=
 =?us-ascii?Q?XFhTvx0Qjoi+5IHPN2y+5khhHSHHQCdTHoVTO1TwdTrn/jD+iDsN5ejLUL45?=
 =?us-ascii?Q?W3sU2tFV95ZIOK93tA4DwEZgL04ugGIoHEuZVRb9Y1w94mBiI9VF6EYJGlvK?=
 =?us-ascii?Q?IVW2eTQNHsvRCs3IIz9Qlnvx2ZCxnGOn+o7oy8akileLJ6rh2OVVBCioF/3f?=
 =?us-ascii?Q?vjD2eM8uZ/UYs8I1FViCElz0Eoc8Vnwk2Jz5sd4EVoPGF0w87+1kM7NFYJwi?=
 =?us-ascii?Q?rZqiLPGp/1odbzXvI6/9fJFcc9VT+lUlux4i8NZHbLZ44rwuyAf/R24iRq7M?=
 =?us-ascii?Q?WrXiSS6mpiGiqufVLYX0Wt48vqV6oCWlJp0AMhl6jMSuttguIdtjFRmpc0LT?=
 =?us-ascii?Q?JfclK+0dFHFIwbWU/m48OrwpsxW8MecDd1/X1ifw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fb3e254-5dce-4ca8-937f-08da63048213
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 06:13:44.1092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A1HqfSq5JLK99rtN5f91jSX9cTyPj5IZvsFNOM2IsahhoVXsJBIh1ZPVZqV2tekZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3442
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 05, 2022 at 06:08:36PM -0500, Shiraz Saleem wrote:
> From: Mustafa Ismail <mustafa.ismail@intel.com>
> 
> x722 does not support 1GB page size but the irdma driver
> incorrectly advertises 1GB page size support for x722 device
> to ib_core to compute the best page size to use on this MR.
> This could lead to incorrect start offsets computed by
> hardware on the MR.
> 
> Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
> Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>  drivers/infiniband/hw/irdma/i40iw_hw.c  | 1 +
>  drivers/infiniband/hw/irdma/icrdma_hw.c | 1 +
>  drivers/infiniband/hw/irdma/irdma.h     | 1 +
>  drivers/infiniband/hw/irdma/verbs.c     | 4 ++--
>  4 files changed, 5 insertions(+), 2 deletions(-)

Applied to for-rc, thanks

Jason
