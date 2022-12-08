Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3EA4646611
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Dec 2022 01:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiLHAoH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Dec 2022 19:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiLHAoG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Dec 2022 19:44:06 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on20608.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B49C29838
        for <linux-rdma@vger.kernel.org>; Wed,  7 Dec 2022 16:44:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+ib2R8uUPkQmwkuoPQG17f3JGI8iOwo3e3U97B4TeuVaav4YvBfi5ZtPal2OfvKUr9hvHcz3kWL+5B2B+WTWSSV1CgU2B+hO9PqGFc08YANUAH4uXQZN9lkvaprL/1Fl7i+wu7bxsPNchXbNE7/yAoUuAsjn+BMuUgyyjcuo3XacwNbjV/diSOCrsnyDhoO6uLtpiM0CrxgvJMdIwbNqDMeLhaVPIACSY4SBwGPApcVV4v1WaRlnqIqeSz3P1kc1C/vbCDs/KY3bFrW375PqpFF+u+074bZ6XqMt11ddwMyq3Etyrm7cR0Q2n3skSqJoVMpw2Z3m1scIeTkNHKMZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RTF4zyvptrcm9M2opcjd5aGvlRkesjFolp2DdbKHddE=;
 b=RWys3rxmBgOdWn6wZ5JoI+73JXm3uRo31UhDe+YXwoYJxnstDQmPLwLdAipp7mFokvpizu1wTNKhXJkrEWNE4RxejhFfY2mscwcH4/SBhwSRpDswxchuQWZ827hpCZYyDn6oHLIf5BkkRWsGXLPdXSQ0RZ2D0Q2vRj/lQ/7aiejl9vEdSdN812FmHqN1rAharAR1BMlaT/m9cRhRreG3SK84a9uaEg4Pr7nKzApLe7UX4Gvc7N0SFDy880NTcstxdNGXxO/LDYCCpYGFzI4UFVTztUilvU5N9YTyTQ6rI9gv9EtZLMRptO3B9bqrRtxe7vNRg71HIDCofA8JW1GpSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RTF4zyvptrcm9M2opcjd5aGvlRkesjFolp2DdbKHddE=;
 b=ITI7mYlll9A/623HS26MAK9WDf69QqTci83RQTELc57QzmhdV0rGMCg+gdVsy2GHNmKyA7uAM7RFw7FeaBYgVqGiG1Yie/q6rNZNu2EbqN7XCm5ME+OLULCZ/UJKSQZ5e646272klHEfkG/D9WBzQdsgUdiv5+hcuPRwNDPogpdj+6lz70n5jNOrEnsGtEahAUHXuUZyHuS+CI8Yb/+J5BBxa5lVXQ0P/cF7+1TMrqUZw6KEVRbT+lOMtsVm4PH9GAOQ7JL0iGEN5pbR9xRhHUmgyQg+AL+zdg0nf8gfb8XB3YH49zZ3aMALikfVWv9SeUq6Qoj9LlwcLDYrXGJVlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB6938.namprd12.prod.outlook.com (2603:10b6:510:1bd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 00:44:02 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 00:44:02 +0000
Date:   Wed, 7 Dec 2022 20:44:01 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Guralnik <michaelgur@nvidia.com>
Cc:     leonro@nvidia.com, linux-rdma@vger.kernel.org, maorg@nvidia.com
Subject: Re: [PATCH v2 rdma-next 5/6] RDMA/mlx5: Cache all user cacheable
 mkeys on dereg MR flow
Message-ID: <Y5EzURuqzm8uauMM@nvidia.com>
References: <20221207085752.82458-1-michaelgur@nvidia.com>
 <20221207085752.82458-6-michaelgur@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207085752.82458-6-michaelgur@nvidia.com>
X-ClientProxiedBy: MN2PR15CA0011.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB6938:EE_
X-MS-Office365-Filtering-Correlation-Id: cf7b7278-fb10-419b-3de3-08dad8b54d68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Na9nIcm44DdyOhPX6Qpynxr50XR70OiwBQbu6PDVPf152PPevxbZ5Xr3t74CQsDhPfFVxfcZ8ET1QgNalZSra3mq5zapljUiy0CGAZEFgw0f+a5BVk0ib+z9lupqNGoadBq5fXcjkLZw93ymXZDa49LDF7LY4a32zah7sCND45epn1N7+3lh2rlAtDi8Lv7yVa0nPp/xY6RBFgMKHI6FSQCSKmtabU0kPIAS851zcOijSr6pv+cC5drt5IVX4IU/1pmcKR5ntLjR+3+YO27T21FA7i43k4T/G1zBpbTl812f7fmlrI2eJgkGbB65Wn5thJw2kfjOrvPs4FPeomismJqUqVus+c1kJrxPwFUUkVZozfzMoQvTp+iB7ycdCS6DFc9wsYF5A2hR3FP27l6WcGqtjZlT1tv2CWIUNUz1wCh93o6s1PQ/bigjsW2Bq4ett8yWqAE9oKaXlblKF32iHbseyWD+/DOVd2JIJjalxrbvDoXzuFJIckdoT7KVBXNl7hpps27RrK6OyqdRLFYRFdZMeksMn8z++EDnvQwPEkOoNBUGCuGI/enWjZRSmgVfiQ04dv/wXSt1cLYOtx9nBnwGPsE3JD5sSbZJ3x6qQ7xt8/C5dIavOWLmj6gIGggM1yaXbEBd9x8I0YOjIdrOfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(39860400002)(366004)(376002)(451199015)(86362001)(6506007)(478600001)(6486002)(36756003)(186003)(38100700002)(83380400001)(2616005)(6862004)(316002)(4326008)(5660300002)(6512007)(41300700001)(107886003)(66476007)(8936002)(26005)(66556008)(2906002)(6636002)(66946007)(8676002)(37006003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0yjiyixzUe6b6rwvMnvxijkZfiVslT4r0QbWLuB2ViqzRq8Jagn2r/9z2/NE?=
 =?us-ascii?Q?9jWVRxFc0ay8O5ireW+2OU+bewXQYAVzw3AOWNxG8g24TgEEy3MIbHUTuxGR?=
 =?us-ascii?Q?FMNwN1U10DqENMInfMisMHlQGyeW/9ZaX5J5ck7UkMWaNTh5E8xSiO5DUUlH?=
 =?us-ascii?Q?K+oKxGV6a+r1WF6cfEoh46+8SKZSZvSh1J728k9pHV3uvbKDaz/uJWCFFUjp?=
 =?us-ascii?Q?UkaUoHioNt3hj2Wy5KM7RQbn3iWca3ZvgfwasfdGFEiAepRWFq//uBW05h7f?=
 =?us-ascii?Q?ozYeL1SsXr9qH5oOrhuqG05wWCMq2qouN455YcXYU8a9tDDIU5aWGIp8qe50?=
 =?us-ascii?Q?CS6QGw0E30Abn8BnKtgPVb68o6QDyXxiT646QLLGeJz4NdV0X0z2sW5fqYvS?=
 =?us-ascii?Q?YpoMvAY7j7C8TS7NalxS/QxWjfp/xgaZZHGDdnl5T/ODTbdojdZWTRZdfKX2?=
 =?us-ascii?Q?x/Sxzbj3zFo6SpWpd27t83GEjJa+2gZMli0x4ReiOkCv4l29MtvRihxlyrZD?=
 =?us-ascii?Q?Lpumqtq0me3GKWtphl7sDdK0mV6O/bZCQkrp8eqwG6kAus5bMOMYwOSkLtb7?=
 =?us-ascii?Q?HkoGuLdjkGsmuw6pEBMoQnj4A8sdecDAC7f2x14pExftG0I7J0mjQ7yLnYV0?=
 =?us-ascii?Q?3ZsOwSEn1jMBlzr30FItauEhRRk5B8ROgKpsjqIgg0T3nqOlYI+z8cwwPkVj?=
 =?us-ascii?Q?Pa9SbVmEtfCv/F/7jrEmJ38yKupbxKQoAsSAmnFnn0L3+if0WwfzuqLE3cgx?=
 =?us-ascii?Q?tcVMtUkxF4oO5VApeF/ZzdW2Kfk0WlzWfvJ8k7Qjn5wAonrcnbHOrdkD/XB2?=
 =?us-ascii?Q?YDWYfBpQRsF4UtP8P5xWAs46D8n9O/fgoAOORiZpBNI4eAg5lGbSkkb8xypm?=
 =?us-ascii?Q?C2uMh5iNTY74Ju4HHPiR1WMFAXq0HeLLuBF7wwT6gNCfDAdWujoXMAICvx64?=
 =?us-ascii?Q?NjpZDk8sPhPe8uCs3pbXctbcy4R6FghTV27syJzIwMNBGKawwtqC0t2TRJ46?=
 =?us-ascii?Q?kkTdpicC5mGDxhQdHrP4jIt4zh8QSU8nKimAV9tTTmHG3RM34cZE9Y/UDCS7?=
 =?us-ascii?Q?lZD6UiVbABXkx3hdvnDbbTbdORBrTKxKiLX2Qc5PahZAFoCpVq7ahkdCvKMT?=
 =?us-ascii?Q?d1i8r/Fugmh+yA4h+C+W/qXZf+9zOYVsu/MA2cRxYBlUf17vQBmBic8TXmwP?=
 =?us-ascii?Q?OJVUZ9WM75BH7HKBvJNaCFw9poQLvFlMQhSBIFDz+gExkBRTvWiAPehM2TdI?=
 =?us-ascii?Q?K9dPbklMNuKE8/SkmeEcRCRCFkEltrv1EGmZyH6+KSCXozdaFefPenON5tq6?=
 =?us-ascii?Q?M3ZsKxma4ann52atZ/7rqb3dLaD4DiqBOXw5pnKOEBrp6DoCbIBbTNKXQPLN?=
 =?us-ascii?Q?AG7eXec1i1CdF3BM5eGz+Edp+/aSXo4zVDfu0VSKVW9CWoLbYR5TWo0gjrR0?=
 =?us-ascii?Q?H1oNND+DX9jW9xly7LshbZFv9w3ni0pjmCPpjDiV6eJw+mMqBaxyB/vY1Zaf?=
 =?us-ascii?Q?W6uhI7h3tKbYQpFiDebH2JG8wIHsMNylsWIysM3hKz+ERu3OKF70l/AeVDmn?=
 =?us-ascii?Q?cQxa4A7O2rGxg2OyGhA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf7b7278-fb10-419b-3de3-08dad8b54d68
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 00:44:02.8047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: giIAncCkhA8cYCCvB2jFGwM7ZY8SfzeUFqrIeQbAc6gR8pTJC24kMQJZTJrfedMs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6938
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 07, 2022 at 10:57:51AM +0200, Michael Guralnik wrote:
> Currently, when dereging an MR, if the mkey doesn't belong to a cache
> entry, it will be destroyed.
> As a result, the restart of applications with many non-cached mkeys is
> not efficient since all the mkeys are destroyed and then recreated.
> This process takes a long time (for 100,000 MRs, it is ~20 seconds for
> dereg and ~28 seconds for re-reg).
> 
> To shorten the restart runtime, insert all cacheable mkeys to the cache.
> If there is no fitting entry to the mkey properties, create a temporary
> entry that fits it.
> 
> After a predetermined timeout, the cache entries will shrink to the
> initial high limit.
> 
> The mkeys will still be in the cache when consuming them again after an
> application restart. Therefore, the registration will be much faster
> (for 100,000 MRs, it is ~4 seconds for dereg and ~5 seconds for re-reg).
> 
> The temporary cache entries created to store the non-cache mkeys are not
> exposed through sysfs like the default cache entries.
> 
> Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/mlx5_ib.h | 24 ++++++------
>  drivers/infiniband/hw/mlx5/mr.c      | 55 +++++++++++++++++++++-------
>  2 files changed, 55 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> index be6d9ec5b127..8f0faa6bc9b5 100644
> --- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
> +++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> @@ -617,12 +617,25 @@ enum mlx5_mkey_type {
>  	MLX5_MKEY_INDIRECT_DEVX,
>  };
>  
> +struct mlx5r_cache_rb_key {
> +	u8 ats:1;
> +	unsigned int access_mode;
> +	unsigned int access_flags;
> +	/*
> +	 * keep ndescs as the last member so entries with about the same ndescs
> +	 * will be close in the tree
> +	 */
> +	unsigned int ndescs;
> +};
> +
>  struct mlx5_ib_mkey {
>  	u32 key;
>  	enum mlx5_mkey_type type;
>  	unsigned int ndescs;
>  	struct wait_queue_head wait;
>  	refcount_t usecount;
> +	/* User Mkey must hold either a cache_key or a cache_ent. */
> +	struct mlx5r_cache_rb_key rb_key;

What is a cache_key?

Why do we now have ndecs and rb_key.ndescs in the same struct?

>  	struct mlx5_cache_ent *cache_ent;
>  };
>  
> @@ -731,17 +744,6 @@ struct umr_common {
>  	unsigned int state;
>  };
>  
> -struct mlx5r_cache_rb_key {
> -	u8 ats:1;
> -	unsigned int access_mode;
> -	unsigned int access_flags;
> -	/*
> -	 * keep ndescs as the last member so entries with about the same ndescs
> -	 * will be close in the tree
> -	 */
> -	unsigned int ndescs;
> -};

Don't move this, put it where it needs to be in the earlier patch

> diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
> index 6531e38ef4ec..2e984d436ad5 100644
> --- a/drivers/infiniband/hw/mlx5/mr.c
> +++ b/drivers/infiniband/hw/mlx5/mr.c
> @@ -1096,15 +1096,14 @@ static struct mlx5_ib_mr *alloc_cacheable_mr(struct ib_pd *pd,
>  	rb_key.access_flags = get_unchangeable_access_flags(dev, access_flags);
>  	ent = mkey_cache_ent_from_rb_key(dev, rb_key);
>  	/*
> -	 * Matches access in alloc_cache_mr(). If the MR can't come from the
> -	 * cache then synchronously create an uncached one.
> +	 * If the MR can't come from the cache then synchronously create an uncached
> +	 * one.
>  	 */
> -	if (!ent || ent->limit == 0 ||
> -	    !mlx5r_umr_can_reconfig(dev, 0, access_flags) ||
> -	    mlx5_umem_needs_ats(dev, umem, access_flags)) {
> +	if (!ent) {
>  		mutex_lock(&dev->slow_path_mutex);
>  		mr = reg_create(pd, umem, iova, access_flags, page_size, false);
>  		mutex_unlock(&dev->slow_path_mutex);
> +		mr->mmkey.rb_key = rb_key;
>  		return mr;
>  	}

Does this belong in this patch? Maybe these cleanups need their own patch

Jason
