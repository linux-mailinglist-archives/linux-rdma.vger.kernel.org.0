Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8150680EF0
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jan 2023 14:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235507AbjA3N3e (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Jan 2023 08:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234744AbjA3N3c (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Jan 2023 08:29:32 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B87392A3
        for <linux-rdma@vger.kernel.org>; Mon, 30 Jan 2023 05:29:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EW+3PFbnJWDcbeJbbSU2mxtePCOufkxYcXlXf8lCA3dAbVx2DLpEJVDOjWB1l4kMLHBuucMl/E+fmp0Hvv4T8GVeqLYs0ON77LELMpkUAHo/sWPx4iS3Wndv5R/v9mNSqXwoh1UQJenUJ7qESTNt3XhFA4Um5PVwkt6tCDt0qt4lpM6jWamLfaBPlTTcGb60VqDGF2ccu19vZ5VR9IEhnIeo5nijgxFC5Qi0ybpx57vnCtl242hjyjj3W+lksRtjzXhY8YJRqWSM1vYh96kqb4Cb3TNHiLM79urQH3xFboxTNZ6ebjvPsO9lytUWsafwcU5SGccd3TOoQWDBghG5bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/KiOgTTFbo9/rvPaCgsUKdw9MCIX380A/7r0+CLV7I=;
 b=EKvC4ejhUVaaD+KUWCrO7C0+FFQPYiN6QeThHhJjF++je5/0zunVUnDYbPIj6veKfNH2Nayc9V1ofcMjYJabCZb95nP72y9vXS2N+j5TWw1WR+RgOqDij1cem8jgVOJxCCj94ZdjT+FdP39UzXgXR/vTrpywLb5e53geq6Kr6JDJUOFRP76yxBmjE9MYeukClgLNAcptiPYqlB36ahxhZ6rl2j1gp5hH0PFDCbFu8oEp/sZlh519Jngn9MKZyVg1MalImDHRT5BNXXdBF7P7+oeg/cTjLMR07GRzez8QmloCKM+y0e7Iap3mYOljnKBHe2yodde8DxRIWyDkqAJnoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/KiOgTTFbo9/rvPaCgsUKdw9MCIX380A/7r0+CLV7I=;
 b=DnuhLyNBjzZa687sG1+L4oZo3ZE27BmyANdQ2ImFe+FwyFc68FcJ5urJf5os6S1vDHB6so5h/VFFyxlksdmj/F9iJA3pFYQ5VRQr1hnQrNCDGbQEc1bVigKYE0fvmaYB2wZ/Kwa+IzEmsTSHgiMLsLVi0syvRoPT1wCrcWzg17GRDjl3BNznWjD+1fVy9rmJq9Oz3q/sU1FmU/ofkhuUisyoVQ9PMIVQOoT1gbbRQy/Gc7VoMzsD7O/Vp4csYjxO+7/Q5KdPPZ8v6LSJih8II6lgpk630dRNa/EFjGu6lDjuGmduNZrquitrD1SXoKs2AMN49mZ0IC/8aOVokmvRSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH0PR12MB8506.namprd12.prod.outlook.com (2603:10b6:610:18a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 13:29:14 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6043.033; Mon, 30 Jan 2023
 13:29:14 +0000
Date:   Mon, 30 Jan 2023 09:29:12 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, leonro@nvidia.com, apopple@nvidia.com
Subject: Re: [PATCH] RDMA/siw: Fix user page pinning accounting
Message-ID: <Y9fGKMP4sA7+8/m7@nvidia.com>
References: <20230130132804.223144-1-bmt@zurich.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130132804.223144-1-bmt@zurich.ibm.com>
X-ClientProxiedBy: BL0PR0102CA0019.prod.exchangelabs.com
 (2603:10b6:207:18::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH0PR12MB8506:EE_
X-MS-Office365-Filtering-Correlation-Id: ac6a7d38-13e4-43bd-1982-08db02c5fa87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mvpqcYkSOaUIef3w6jNxa987GDpMR3mZ3uilmsK+dXsyKhQ5Dk8ensC/bTgjK9fHosdD3K14+nOdD1+/OWJZk1ecHuI3xVN5tAPlr/rLnQSfIqh24xKOQ6cAIWRa//3WRgsfCrQe1BE1tcnn6t8AXP94Q4ObaZ4asUa02PGbo8zGTmtEYwQirErynfIb2pyel32Q7NCijMR6k9LBMHEJm0oG1go+5yQVVvsR7xG0RLXydZlyK+hW3KFkIzCKGfsE/i5tP4WT67NU7Er5ct9UwdocX4g9zIfzC3vWoBckpoCxIY05GBrBlZo7X9vakRZT3jAZ+i7Uk/1O3CKpJywU6sHMpsmM8gTz5r8DLIVuPDBa/eElafa3eonrEHrZGMiU/nGq/P2AVcUcjfRGyq4rR6QYksmhJ+HEq5xdraFgvI+3YWivbFXL+cyRBsyqKlxJFrCZuOhDj0wrz7umD9navk6zQo045DB+qavCrqzdUbTOVgGNQRLhoYP3KbIxJLzKiDhjdwyymdvsKCD/DpMNTSgh93OPqHq/QFOPhUg+wop6M1Dl1KhmGhO9W+dgygW0OveFx+alUrbxeB9nAtDJxNYyQwEnvml6vgZoDoOM5Rf/wpHlGOzNgNmen81aFpB7TzVJU17j8Fls/z4p2it/Rg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(451199018)(15650500001)(2906002)(26005)(6512007)(186003)(478600001)(107886003)(6486002)(316002)(36756003)(86362001)(38100700002)(41300700001)(8936002)(2616005)(4326008)(66556008)(66476007)(6916009)(66946007)(8676002)(6506007)(5660300002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?62Lc8hstDinBoIxmEntDPOncuXIXHlv/aiVJXZGdanDogf4TzMgu4S9GfXVY?=
 =?us-ascii?Q?3jJj2FZkOFm+H4J3RMpHs7UOfB1GQ58NCSOI9ow6soagzxqCr3dvkqP4kp0h?=
 =?us-ascii?Q?A5cNV2V2Fg4LGl+8kwJit3miSp/p9FSsEd9LHGmK25hsaa+rrlmAlguLmxSl?=
 =?us-ascii?Q?ZUTDypg+JD+rgDGrFy4ARfQgF/wUygpY2qZsLJQIgTfdWdJzX0mOI2ybhR2g?=
 =?us-ascii?Q?7ofqj1gXwziwcq4Tcvqzwi9qSRmaePaDMdwjk6+pJ6poWIGrPNTichEEMiJU?=
 =?us-ascii?Q?2Da0rLG6eMt1pdqRRmQv2pGiAYf8xQ6Rms3ng8DiGPqT6BBAvJu71JiyKCne?=
 =?us-ascii?Q?pKDpuj+i3gVpDXaWre6u5ht/Ej4E53+/ly/lRwYuEeyse73SubTnF7ftJCoB?=
 =?us-ascii?Q?qaZK+pG+KIpIUfTr1QAgxq7MsKejzjnsd0cONXSGQN++aHdGLaM7dFshbuxF?=
 =?us-ascii?Q?DIXf+Ie88amBe41St243tDdkDdtN90o2z11OwF5PrwMU0Q4dwyHXQJNWsOtX?=
 =?us-ascii?Q?I18glzyixwiMYSDyJa7nK6COY+RPmC2ExIsFnN8K/7LdTbNb6jXnKJ4dFHtU?=
 =?us-ascii?Q?sfwpRm85pT6BEa5s8sDPnbYKmCgNVdQ6Kv7fAiHZa1wQf4UQsMzy2nMcTVym?=
 =?us-ascii?Q?V0jxghTa7rGfjw+Peh/LMWj84rZ3ekOHHfA/fdhDLKvwW1o699Qz8wF2c+Xh?=
 =?us-ascii?Q?ivf7hwRKOcZbT2JdDS40OdrFLqKo3JYq3AlnLQTrNf30LNFPSUcCZ7vo2FYp?=
 =?us-ascii?Q?kDxESIKL78LWpmqLDwQ2/CisJtI25SiPWQhHe0f5cVQglLOfONDuyZ0Ahvzh?=
 =?us-ascii?Q?c25/xOaPnCyeWwt/ZKauUkHKHu6i7451ysldGdKtw4q07kEtT5a4QLFoeGsy?=
 =?us-ascii?Q?y+ENZ6kKAwNNbKGx6Tz0ze74IAE9L5Nf7bAALEol2EtCdjyS0ZGk5ljDitBt?=
 =?us-ascii?Q?0qYencLcmpZ8KPeQN09fXxLmLCEX7CUzmMydTBEtMvQojEHIHzigFFMMnzdK?=
 =?us-ascii?Q?klefICUcHanIW2/uK7l/7OAFvX4u+WAKq8vX0pjB8+U1cSw+tNoA/A7eDxjg?=
 =?us-ascii?Q?J+T/9r9vAM/8aGgj2Wr8JF/7+z7MVrmnLy/3+bug46fpzT8icpdBO9fndZ2S?=
 =?us-ascii?Q?a0vM121sjhI6HlHMXKLCmAgc8cCuL/FpJeCZ2Eb3j9cCSRTpkJHSrbb9IX3D?=
 =?us-ascii?Q?bRF1Yla8maP9h1ujypKR3OQ0eWK79AqQed3sELOGWvgcVQHUjZMRx/0IbxTs?=
 =?us-ascii?Q?tecEl2TvGm1RycOclNVrXZzFv2h8zr9NznN0fDNuLRZsKxLRZ+VFlF7FLDvo?=
 =?us-ascii?Q?Uo01T84JifBt3vyYFr09mDz2ryNleW5LTk7/shqFLqKcp4k9KG+REfcm5FMS?=
 =?us-ascii?Q?G27yC/z25x3SWzN7QI/iq8P8IsKPZ4OdvIUq6tghrptL7heI7j6a1q+iVBmS?=
 =?us-ascii?Q?pufm5fD/5isRmUkae2buEZFoGPEqB18qaz/3MxqK1W8ZmvO+4oe3uMDO+yt/?=
 =?us-ascii?Q?3jk1OyRWc/qj3vRhLpQv3G4EJKl5VLVXXM5IrvevCMLVN03+zUrPXoCMjg6v?=
 =?us-ascii?Q?2t7Lp1xB0Q5XWGZNIsFXZ0eiZt1vx29C+GtzLkyx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac6a7d38-13e4-43bd-1982-08db02c5fa87
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 13:29:13.9277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3/H3Wh4aDIaQzUGr2rngo9p0000fUr6lvolh70FgkTA/j30bBUIVRBJ4qJWLjSub
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8506
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 30, 2023 at 02:28:04PM +0100, Bernard Metzler wrote:
> To avoid racing with other user memory reservations, immediately
> account full amount of pages to be pinned.
> 
> Fixes: 2251334dcac9 ("rdma/siw: application buffer management")
> Reported-by: Jason Gunthorpe <jgg@nvidia.com>
> Suggested-by: Alistair Popple <apopple@nvidia.com>
> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
> ---
>  drivers/infiniband/sw/siw/siw_mem.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/siw/siw_mem.c b/drivers/infiniband/sw/siw/siw_mem.c
> index b2b33dd3b4fa..7cf4d927bbab 100644
> --- a/drivers/infiniband/sw/siw/siw_mem.c
> +++ b/drivers/infiniband/sw/siw/siw_mem.c
> @@ -398,7 +398,8 @@ struct siw_umem *siw_umem_get(u64 start, u64 len, bool writable)
>  
>  	mlock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
>  
> -	if (num_pages + atomic64_read(&mm_s->pinned_vm) > mlock_limit) {
> +	if (num_pages + atomic64_add_return(num_pages, &mm_s->pinned_vm) >
> +	    mlock_limit) {

???

Doesn't atomic_add_return return the result of adding num_pages and
pinned_vm? Then you add it again?

Jason
