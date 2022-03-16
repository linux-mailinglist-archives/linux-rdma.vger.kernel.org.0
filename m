Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49844DA6D8
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Mar 2022 01:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352789AbiCPA0d (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Mar 2022 20:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242769AbiCPA0c (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Mar 2022 20:26:32 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2067.outbound.protection.outlook.com [40.107.212.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7640E48397
        for <linux-rdma@vger.kernel.org>; Tue, 15 Mar 2022 17:25:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yj9/N327pQQC3k8OEhy09ecTb/Z5W8wQInXW7/J/IYYlSVg3Hx2s3NC6EVTtVKnCr+FAG4W4f4180xkcFHKH44vWwAh4cY17LkgztJDKL++nz6WVYWNXv3yi3nNUmvOdv6W2ymeNZHLwi4MLld6+BiyGNOv6q/4mxY56YTtCzoYUDeV9ixzEHlx9jVnoHGMV9n7b7wVBdY3UQyMxZyN5iVXDG45PIavw6fU3RE+wVW408ZlvPXEXhVb4qzDHKmAgKLAqO4Tp7JceWPFBO0xxzwhN/3k+JOIGX1ox5/KTCHDzqZs/t/nM3Z4zPGgVmlRLNYHDTWHxNYIAVvcwt/V/hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3BIPLI36dGeTflFPzxor0/R4TDiFhOGLTQZPXkOAHo=;
 b=SsgFvKyqIM9dOT/lHsffIuzJrNNYCSHiS0EWQ43tMoaI4pVEPkk3w2NFRqliUEGjGYgXYu9ooY2znDrnfrDfEegxn01bGPbvj7MWSnpRnkFQkOirPxQfJORhKygHXqrFCjUzhQ48UXxRviK6VfhO5+GqswMOQJ9t7Qi/YVn3q6LNPRRRQGEdZ2NYBuSeo8uzGGDVAAU7HaBHsBhBUniF6y8Si8Yb1NqjVo+g+Nv+TGVohVd/kqAsawmFFuxprDFc6k5pv3v+Zvu9J4xTz2ihy8H8y5wLNAyJ9tS+L3YC5gU0sMr7yrFxKF+iMh4P5jUl7U8W9QaDLyum8nW3Oy+0Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3BIPLI36dGeTflFPzxor0/R4TDiFhOGLTQZPXkOAHo=;
 b=pdAvQnZmQrq6zRv/ZS3HujxDsKsnNom1WSBPij8JlbjnHbLq3H9WJpeU/kVoF2dUeAG46VWGNKJ+xGJ1aVoK5KWOrfADlqZv/1QPU0hY/273WOOeT7D/teIFXC9hnkub4b8unfxpb3ziXHkZ4aRRxPh0EzVdj4Ji0QZCfRRHo9S47DsizhRNfSZPYme6MtrlTGLEd1LNaaMn75fuYMsS82OS9U3/Ur2F9Nv9ZJltO5HAWynl5SYd8ewOveW74xWHepR9tPG9VWZLzhoacnTmgrNw1MM/3MiPpX4LnnJj4u9EAJuR/jHmZezxF2h3eF3lBoEfpJBLibzxWmXKsIO19g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
 by MN2PR12MB3248.namprd12.prod.outlook.com (2603:10b6:208:a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Wed, 16 Mar
 2022 00:25:16 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::9ce9:6278:15f:fd03]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::9ce9:6278:15f:fd03%9]) with mapi id 15.20.5061.029; Wed, 16 Mar 2022
 00:25:16 +0000
Date:   Tue, 15 Mar 2022 21:25:15 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v11 00/13] Fix race conditions in rxe_pool
Message-ID: <20220316002515.GZ11336@nvidia.com>
References: <20220304000808.225811-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304000808.225811-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BL1P223CA0011.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::16) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e07e9eeb-3a54-4c66-f7a0-08da06e371a3
X-MS-TrafficTypeDiagnostic: MN2PR12MB3248:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB324885FEBFECD092B5D1FFECC2119@MN2PR12MB3248.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dDdFzbAsCgHx8OX1d3xSOVUcLIa8N7OCvyguo7IBC84BToT27rZvLHlGrN/iiWU5QFdlb+XnhjkulTMmsgk3xF9Fvmq2VzhSqne2y/Ir36uPQhG4WbJpebKLoxdbUw49P2zbwxUJ+L3v63dohrq0MMtb7rK3HXseeMnX1rGP+zcwaZvxSrDuc6m/+oneaW1y5utTLnzPZ6JE7uIWxvKWtR2JM4GG23HYK+z1iAIRrAUxr8GdDDhsu6bpza4Odj3vH2zmCmP+kgEVwMpKP9bOPawSWqQhg9K0W4lJWR8wfu0FczfsIobGE/ceTyY6mxSdbLhaJKRN1ruOi6vh1vWZShFaPrUUkRKFQXTwBYyW16r3sBIuk0E3KIyv+j4pkg+Eu5AOBdy61tOEFlYr3Mc/aJ3F3xVou8qg1BDXC9LhTzFWKJZu8Vs1xPwv5eq1FU34PlWkZedFKowqUmGWwlt41SiHYqpu70WtlpbvMMQ4W+xZdnBM2t2+EcyMqOO9p6+9lHRxgzLFkBoE8KXHx6I2a+JYievMUS9/2AZeEbvpXq26iwYVpcphOzqapa73X/hj2pj6dAehdLEb5aJXh6PufXVkKYTZjfO0lslT4xYx2AGyDqAFOUdZ8dbHLszrt04kI3O49hPixXZjCdCBurfqL2/vbzHYpTxCZupRkPvuXG4DeAWtpwieuirJCG1YRkeIpiyIq+GDVcFndvOqX+UVBBXet6cobv2apCwdUd+ZvzcqZx/902cyu80GHMULqhwttnscUhypLS74XJOfNxqCLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(66476007)(66556008)(6486002)(66946007)(8676002)(33656002)(6506007)(6916009)(316002)(966005)(508600001)(5660300002)(8936002)(36756003)(1076003)(186003)(26005)(83380400001)(6512007)(2906002)(2616005)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HH1IaxQfixGl1mGVFjNIBNkECMUsDEXTtExrG2752PKXRtTMp7Ca2V0xHZER?=
 =?us-ascii?Q?pNrz5nU4fW/Jt4o6ko9BB3yz/5iUG8GsSHtf4FBHaxRm9JLjPumnwjGhyMox?=
 =?us-ascii?Q?TC+YFQ3PCejEJ5/Br72fWcqxavFpDUhoX466znSQgDg2CfFLAfpK5LHi5Ov/?=
 =?us-ascii?Q?XbIaiBHGPijdnmqtHP//CIs5LR0OETIWkHO5F1ktT4pEA/Wn5mnDRJiMDfwB?=
 =?us-ascii?Q?hF/2cihpDbz0+T8QquIlYq3n2FsrZV7eZ6iq8C+8RW08cH+y7ynOL1qX/eE0?=
 =?us-ascii?Q?1dj97YzMcyG1y0m/y6gAqBv1Sv9Tp+8EfOMHefof7SYWyPPYlzLrlBRrMhju?=
 =?us-ascii?Q?9r1CZk1d44o77hrAOj6A5HAANUw4xpNiRlkauqvTSfEJRFR8TcBuGeCnTkrR?=
 =?us-ascii?Q?PL+9yTVq0BmMKDeFhIxHG0weWWir+7mJNUrCtDB+W0Sner9PQKuINKxTbGha?=
 =?us-ascii?Q?403VP7jZYPopBUuSxNClYjZDFQED4oK9qEDxUkPcV/ZU3iSYL5BiQMO6bMxu?=
 =?us-ascii?Q?YVuFteKbC5LMs23ozOv0EEjOLSMoaOiADaH2wlUKQYVtSgSs7Ln+iaduDr/n?=
 =?us-ascii?Q?WoihpXEIj0GVOEtvEc4ycNi2Epu9f8vdVgBVZpwspxwzemrxJArDLxbGdACq?=
 =?us-ascii?Q?7+uv+E+tDFX4t+sPTtIQw4zJa5wztapWEZNuzL8a7yAO1dTJYN2V8jSBE2aV?=
 =?us-ascii?Q?8XLS5srE0RQjoaR0gZkHwURJSo82ltkj9stDMRt9ptBsVOai7lNKH7rvzvop?=
 =?us-ascii?Q?Vqhi0EAJBvD0qbjMj8GHmph98HFWHp5mPJPCHukicTnfcq3OH9ZKpwo9mXCb?=
 =?us-ascii?Q?7TGUpGq7L8JbVnpIaSBS9GJCGmkMXxBgpSY5hlDAUNjHGHHPEDQel/EBNCEM?=
 =?us-ascii?Q?BcX0VNa+9JgY68LXAR9ZqlEQRdovyiSAHmUPLMyScUn5zEqjRpLG2HYoU+oZ?=
 =?us-ascii?Q?17jsj2EYvPNNI26FvfCLUbr2h7Nf6mf7b5pmYGGhLgrslyFA7Hk+S4Vzn8g+?=
 =?us-ascii?Q?YnAo71WZNK40doCRD9I3ooJ7fLCFKM/kvyyj6rvLSmqM5DHhIMTgsB0ME5pj?=
 =?us-ascii?Q?kqcqrBwaW75YK4BWtE54BKMPY1ICMNgiPnHzP9sTe//zcrNLis22wujO1TIG?=
 =?us-ascii?Q?g3YPMWqYYLiIFJsnTLHvGCexUtj0+2AO6m+O+LZL899mC1vpOHrqsMuaLFv/?=
 =?us-ascii?Q?0A/qzjLeduAtXDK2GarTKyjrxDwJWXUZqdCZoWaznJOH01YyIBL4PqkGUMQS?=
 =?us-ascii?Q?aDfgRBYEdTRVCUu9tYmuPLQqVcpXd2u9FzLONCesPcwdL666gRYCTD1CxM33?=
 =?us-ascii?Q?DLZqWtMYxO3X8qsYrgw6/bKN7QCFdhDF1yD1YwHAH+Kb3XW4JRxg3XN4SwlP?=
 =?us-ascii?Q?ZROM538JsLSzxz5gO+Bj/Om7zQwUgXIvNOBPTDcjmPGfLvEV3Y0C7iVsBe0v?=
 =?us-ascii?Q?Zuj39tI/Qa88Inwr3OkRHQdfFStxWXaM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e07e9eeb-3a54-4c66-f7a0-08da06e371a3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 00:25:16.1823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h5mihn9tOHcHNJjoFdYAcCwghVSLoC9Hl5T87Nc7OYBjb9aH13JkNbaa25M4O1Ae
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3248
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 03, 2022 at 06:07:56PM -0600, Bob Pearson wrote:
> There are several race conditions discovered in the current rdma_rxe
> driver.  They mostly relate to races between normal operations and
> destroying objects.  This patch series
>  - Makes several minor cleanups in rxe_pool.[ch]
>  - Replaces the red-black trees currently used by xarrays for indices
>  - Corrects several reference counting errors
>  - Adds wait for completions to the paths in verbs APIs which destroy
>    objects.
>  - Changes read side locking to rcu.
> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> v11
>   Rebased to current for-next.
>   Reordered patches and made other changes to respond to issues
>   reported by Jason Gunthorpe.
> v10
>   Rebased to current wip/jgg-for-next.
>   Split some patches into smaller ones.
> v9
>   Corrected issues reported by Jason Gunthorpe,
>   Converted locking in rxe_mcast.c and rxe_pool.c to use RCU
>   Split up the patches into smaller changes
> v8
>   Fixed an additional race in 3/8 which was not handled correctly.
> v7
>   Corrected issues reported by Jason Gunthorpe
> Link: https://lore.kernel.org/linux-rdma/20211207190947.GH6385@nvidia.com/
> Link: https://lore.kernel.org/linux-rdma/20211207191857.GI6385@nvidia.com/
> Link: https://lore.kernel.org/linux-rdma/20211207192824.GJ6385@nvidia.com/
> v6
>   Fixed a kzalloc flags bug.
>   Fixed comment bug reported by 'Kernel Test Robot'.
>   Changed type of rxe_pool.c in __rxe_fini().
> v5
>   Removed patches already accepted into for-next and addressed comments
>   from Jason Gunthorpe.
> v4
>   Restructured patch series to change to xarray earlier which
>   greatly simplified the changes.
>   Rebased to current for-next
> v3
>   Changed rxe_alloc to use GFP_KERNEL
>   Addressed other comments by Jason Gunthorp
>   Merged the previous 06/10 and 07/10 patches into one since they overlapped
>   Added some minor cleanups as 10/10
> v2
>   Rebased to current for-next.
>   Added 4 additional patches
> 
> Bob Pearson (13):
>   RDMA/rxe: Fix ref error in rxe_av.c
>   RDMA/rxe: Replace mr by rkey in responder resources
>   RDMA/rxe: Reverse the sense of RXE_POOL_NO_ALLOC
>   RDMA/rxe: Delete _locked() APIs for pool objects
>   RDMA/rxe: Replace obj by elem in declaration
>   RDMA/rxe: Move max_elem into rxe_type_info
>   RDMA/rxe: Shorten pool names in rxe_pool.c
>   RDMA/rxe: Replace red-black trees by xarrays
>   RDMA/rxe: Use standard names for ref counting

If you let me know about the WARN_ON I think up to here is good

Thanks,
Jason
