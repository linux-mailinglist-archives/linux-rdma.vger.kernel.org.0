Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEF8747442
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jul 2023 16:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjGDOlA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jul 2023 10:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGDOk7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 Jul 2023 10:40:59 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2092.outbound.protection.outlook.com [40.107.101.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCA5E49;
        Tue,  4 Jul 2023 07:40:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bUDY75HLeHShUZwVbQ2d9eXrDwipaNiK8rIUIiirnUW3tis2xqn6u+RvW64n1lRNK6cgSBsK3jcN2adCuLgqG4+A1ssmMdRINOK5SnO3beVuVMXz7aY6wHKe78eMA3Z6l9rDD/5tjKWbt9Id9jxEq4oTnI95IXBRoCh4MNMrxYRm7qMK7tWpaj/FA4RV0o8LD96RY8cUpmRD+zhFg2QJL1Tu3rQBukWED5/4/gxAcPtorPqn8FHyTwnfCHdZKwVt0mduneSi8cC0n2N9rsoGK7y708RqFMV3osjfFq2JhxMCIi1ya/sXe3vtZ5WMAAvQPdeOgHeiOJZS04jWwCpXmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SLp3GBo42GQ5XnOWZadPk3UUdg/tTVNenWCRk9X/vS0=;
 b=l/RIyqhW39jOlVykZoWht9HYJfFYdC3GdLelCR0OmU/PucRlg0C362ien5tf69vwNN1GiTHQJs/nUPiJyvdZ61ggrpRatZvKQLoO0ZpBJwxZ+bRyWe3WlUCkIYCTsG2rpWIgCd0mhiOwN8EDqdUCRukq4kyvORI9F4p/ZXhhGP0C+9/e5zwUdvDX8CKl/6IbHTg4ohcPQJWxAcPORYEIR/aYW+T4cAuCvzBiLawdmmPsxKrBaXJmogiIUWvXdMnyUdep4gpTMSwCC5WHic3t0LQHSVhnKf7n0JH6M6iZfSwVWx7F1BgsnobieBmJzb+06JJH3/QwsF6aYtQuuSQnwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLp3GBo42GQ5XnOWZadPk3UUdg/tTVNenWCRk9X/vS0=;
 b=RcoQlT9198KR84ci9Ie0d4G55IevIns/LxaKQSlUeNYZ9rQUNYgotXNHRWbbrv0jKkaE4Mxm6q0ZP3vTiXAmBaghC70qpDCUMc95460RFbPYkH8fHL88KQny6aq9iG8yB/Xr2ZcSGG7N8V+GCxe+PGtm+xGVhY7rmW+o4aJLlIc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by BN0PR13MB5231.namprd13.prod.outlook.com (2603:10b6:408:15a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 14:40:54 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 14:40:54 +0000
Date:   Tue, 4 Jul 2023 15:40:44 +0100
From:   Simon Horman <simon.horman@corigine.com>
To:     Zhengchao Shao <shaozhengchao@huawei.com>
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, valex@nvidia.com, kliteyn@nvidia.com,
        mbloch@nvidia.com, danielj@nvidia.com, erezsh@mellanox.com,
        saeedm@nvidia.com, leon@kernel.org, weiyongjun1@huawei.com,
        yuehaibing@huawei.com
Subject: Re: [PATCH net] net/mlx5: DR, fix memory leak in
 mlx5dr_cmd_create_reformat_ctx
Message-ID: <ZKQvbCkdeVWWCzEw@corigine.com>
References: <20230704033308.3773764-1-shaozhengchao@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704033308.3773764-1-shaozhengchao@huawei.com>
X-ClientProxiedBy: LO4P123CA0619.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::19) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|BN0PR13MB5231:EE_
X-MS-Office365-Filtering-Correlation-Id: f21e8a3d-6f16-4b71-5b20-08db7c9cabcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yVnOhOqznl8f/bwDOXbVx9Qe/tWVQEvDaYYm4tr/wP9oqXdwIqATEHG+EDU9GI21fB+rJh6cviVpDYxlsAAQllclD3IBTCFKpQ9ruB6TXwSL7XsRPLyEvXMj7jDeuGPkeGbJifRDqrVLgbB97lkZU05i5DvxXWKobC89+j8RrYs1YQjGii6OgwJ4KU2N6saJ4FNfcWwKaIV7zEsBxdz2/cy8TqUDXBeWgIuuhlppcXWfpZMoUCPzxY5WTvGdamSzIGZSSwBDLPbEw/bqKBshRI252FlAazT2H3AcNNpx7hwQHSVBKBObkhhHG5XBlf8nI/xncdOf02fe/HlFL9SyDpEC1z5e7gKpCk74/UPd4bBgdS2Im6x1ESQQummNLrJDz8ZFpYnhNrqQh107kH5dvLvhcF8qLUfIq0ImQLj9kPQzafhdqnEy8VagLG2ebvd+EdAS0GSPSoZn8H+pljGGOfZXNbljEOGUMmvKVn3ZuRuum+kCgFvSCGcB15GX8HfDqNb57c0bMaj5ySrKzof4KtJBJ4wkNpm4nf03ZklnDxQc/eEBDyMD/R/hOr4sZNqj14S99AEBv193HLIJdTs0YrQPY2htFWDQjRHF7YVk8l0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39840400004)(136003)(396003)(346002)(366004)(451199021)(6486002)(86362001)(478600001)(5660300002)(7416002)(4326008)(66476007)(66946007)(6916009)(66556008)(186003)(6512007)(44832011)(36756003)(26005)(2616005)(6666004)(2906002)(6506007)(83380400001)(8676002)(316002)(8936002)(41300700001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QWY5c/08WWOg3VoTisjlGpmmnFpZ2D5Qgye0bjtmfN++deDE9t9L+Mtwn/GD?=
 =?us-ascii?Q?H1VlS3voAqePs5UFMMJ6IvbUly9xWzOsrxzMc6jjFjOTXBRABZv0BJz/peXU?=
 =?us-ascii?Q?1V57WZs2yOsRen/e/OoIv/QlJats/8F2SIVRQv2hu7NCWPbx5DEnD+EF7Qen?=
 =?us-ascii?Q?+Nf6wj3LuuPs62L1lGSbnsEBxwla/aEs4aQC5G9v5yNpdoRFmj9/J2uGiCNR?=
 =?us-ascii?Q?2pvHzVrmMtoIOIdWOvl3wDR1Dmw7oa/Et3dmRMXORC/ILi2PW7zMbOEK6p8w?=
 =?us-ascii?Q?2DQYpHdQg1chqx0GWUm07mKF6SG6whSmpUa39k/2KvuQPYysKzYEInMpBVoF?=
 =?us-ascii?Q?qh1vy2sCZiXmOr+PvpA7zdSSmiRMF2KrfGrjdMkcyhl/TmmuJfKVweS+F8pE?=
 =?us-ascii?Q?O2IvSST7RtHgomQzpNawMjl2udcG4LsiUlJsCWzDPXL9aB9+wKnhlT+rDe7v?=
 =?us-ascii?Q?VQz88iFdns1f0iDC4r+iqhJrnv8dc+VIlG+R/gopnUF1yDxAerSiZ9tJOxXZ?=
 =?us-ascii?Q?RrG61vWjwy8sZl35U1V7xh7SrqZlHW3Nxf0lD6PMzm3Zvh9YU7spVBbya7kX?=
 =?us-ascii?Q?P+xkwojmnINt3m01WOYE9idCCNjADt1ehPE8XMZA6SFHLdOjDam2eBMQ9lbD?=
 =?us-ascii?Q?7SfRBVHSc55hWXmkaYlcot5Hjvn5+IfLa0BMGPf9nQr0oddtYdgfbRYpF+ZL?=
 =?us-ascii?Q?bSbQg3sZKdtN0B9NDj57j/U5JJjC3aLxwgpT/1aZYp0YzcLtezWt/vtqkJ3Y?=
 =?us-ascii?Q?lllzXM9M+7UzpkB7j1zfr7d9tC6MRUG4190Ki5M2cuCuyUdCYBYihjpea7Kg?=
 =?us-ascii?Q?6Vo2950GhGL+B5CGcZT+J/VtPaSKezrHI+qT0O8ACh3xFDUjOBND1CPTUCgt?=
 =?us-ascii?Q?6EMV7zOxGGqQRogFAH/KnV6tg3RptTTz2TEDnf/ET1Bz7JtzaHKEdgJ8/8VJ?=
 =?us-ascii?Q?Ad8b/nA5L5ZK1qXv8+K8CmbMhmUmtXcUDpGYRctKtX+PL7prHp73A0opjX2Z?=
 =?us-ascii?Q?LA7KfqLffd4wRMq3GjlCyCT5lidJKxP3FF15VNWU5bovbmSME8iDnO9E+Zr6?=
 =?us-ascii?Q?5qOlCJ1vA256uQLGqooynOAjBKXjWNOqfTsEEuS8vEFq6zKML3LjSsXhoqo0?=
 =?us-ascii?Q?A0SpWRn37pasYQB7Q6m1lS0txXZmR0Uu30a1JBcPEr5LdzzziVlvuZ3/NBaw?=
 =?us-ascii?Q?FNp6GcgBlj8tOPwH7suL+GNkdBSS2EhOvDjeucOIfIHi7ZO0t2b60HjZdK9L?=
 =?us-ascii?Q?/iTInNreoEGpPJYUKLEEdurPkUGhrwkB+i2dRIGobGkFjmPtdgDgAbZMU0hR?=
 =?us-ascii?Q?E9/9zKcr07538YVF+TInUMz+/lLqOJWTsdrqaQBAMmTVcrbDdLgwxvdvo6ft?=
 =?us-ascii?Q?wvCxbK0pXrdpABux3AvVbeIM8H0GLLpin1Em9wMPXM9CyTTHv0g0YcxCmE6o?=
 =?us-ascii?Q?Zq6mEw4B5v8oALPvtRsEqRYBqi9RqF/mPZkgBX/kcoz9sGYpgToo4Zk00u6G?=
 =?us-ascii?Q?FX7b1CPBMY9IOLsatXEBGO5nBj5A/8YanbnykVZnpnxwuEkcgveuOwaNvLdY?=
 =?us-ascii?Q?w6o3CsuIsKAbZsQ4xRSCnBCfP/LaIduhRNS2ijK2c5u9Ky2u1PfVHRTbjIpJ?=
 =?us-ascii?Q?xQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f21e8a3d-6f16-4b71-5b20-08db7c9cabcc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 14:40:54.3650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0wZHNSwcciCGnq8TSvAcoh8NuI/E5e9Korxia+pAxiadgLFHnRx6oyqO3pzOWgoPaDact+IduCtJvJd+hh+sWViTb2qPf3nqTWKcMP20yQ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR13MB5231
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 04, 2023 at 11:33:08AM +0800, Zhengchao Shao wrote:
> when mlx5_cmd_exec failed in mlx5dr_cmd_create_reformat_ctx, the memory
> pointed by 'in' is not released, which will cause memory leak. Move memory
> release after mlx5_cmd_exec.
> 
> Fixes: 1d9186476e12 ("net/mlx5: DR, Add direct rule command utilities")
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c
> index 7491911ebcb5..cf5820744e99 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c
> @@ -563,11 +563,11 @@ int mlx5dr_cmd_create_reformat_ctx(struct mlx5_core_dev *mdev,
>  		memcpy(pdata, reformat_data, reformat_size);
>  
>  	err = mlx5_cmd_exec(mdev, in, inlen, out, sizeof(out));
> +	kvfree(in);
>  	if (err)
>  		return err;
>  
>  	*reformat_id = MLX5_GET(alloc_packet_reformat_context_out, out, packet_reformat_id);
> -	kvfree(in);
>  
>  	return err;
>  }

Hi Zhengchao Shao,

I agree this is a correct fix.
However, I think a more idiomatic approach to this problem
would be to use a goto label. Something like this (completely untested!).

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c
index 7491911ebcb5..8c2a34a0d6be 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c
@@ -564,11 +564,12 @@ int mlx5dr_cmd_create_reformat_ctx(struct mlx5_core_dev *mdev,
 
 	err = mlx5_cmd_exec(mdev, in, inlen, out, sizeof(out));
 	if (err)
-		return err;
+		goto err_free_in;
 
 	*reformat_id = MLX5_GET(alloc_packet_reformat_context_out, out, packet_reformat_id);
-	kvfree(in);
 
+err_free_in:
+	kvfree(in);
 	return err;
 }
 
