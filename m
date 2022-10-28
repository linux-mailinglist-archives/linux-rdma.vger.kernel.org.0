Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6FE6119FF
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Oct 2022 20:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiJ1SRh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Oct 2022 14:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiJ1SRg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Oct 2022 14:17:36 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D492413D9;
        Fri, 28 Oct 2022 11:17:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PKxw6vHMrqTzemW/JJqVhJrN527o1OuMdie1oo4yj0lDvg2bRiihrTL3YeS7E7ZyFWYeYZIt90u1xK2dTSqM0hNZmJ77vVh2bWGRfDXTGlzHeMLgyHLVn2Hh9jyeV6eR2q7aSySFeZfOC+Vqd46p3VRzHikfn0Tzf77TmhYDC137/B0TWV24Ok2eZQs0JDNXIHuZB8wpBr0bxNW63m10GSoBf/CiGxihYZiP4TLcKLy1EJRs1G4cfQ3k1eKEng6vo6mmQhcNkaBlON8u9gpz1DOrNkoeCSMYszNY9QoFIGye9idCxgWXynNp02+o7D+bFOGO32ieTX+q9v4g5juIxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12DMcghyqblo3NSJUM9EyoQdi34ofdpyh21u1+R/DEw=;
 b=Abch4OUybFMdEb6dZPF1Hy4LJcv6+ZIFXpNMKvpWfTV9gYEZmvioUICbpyeNyqxi83B2keJUH3ieS+gEBcVWqANUDTRJSF1UHcCeODozcmYTvLvp9eLceh+/5MW/X7PGGaUXzErny+xwAUxF78Q0Ly2a8cZMxOEZmQL8Lz4EcXRMlS+bexNj43v3lMyQUpTWxlDB5yEFJIGilG3s9KhCaWvAbl3IqFRebJM0ABox2CqmGX1SgCg5Cw2J/Tkcb14RVIFntgLVkzZ8NcE6RzpxzxjqozEYHMAWFJ1BwVgt/i7MZnDcGyFcVBPKAColM+q1Qv8Fm6BCDNtHCmicTpsAeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12DMcghyqblo3NSJUM9EyoQdi34ofdpyh21u1+R/DEw=;
 b=snIGj3pvgwTLptfoSVFowS2a42uK6DzMm2oMV/pNLD/48PIkk0UqPyg3beOJyIq1zL1bjMqx50f/TAVbBbNJd2GVVjXJo5olq5aJddwcSPdW2NiqFHrXdfqpLw45fZNkrBKeiJR4fg5uBiG8LrTSJ/BaWxTqvk2n7HPn0/AW8758vG5SuYBOvdt0phUavhpbGed8YzqKPPEFwna7nPNjaztf5To7+C31Wnorqqoayy8ebVFByV0ekKHM5EeZvmyROCdTDu/5Q1HT9ZisZGx6N98L1b8u6r0wlT1p0kBHwOeikkDEx5XFV+I8zu2ATeNHSs+YS/NnyF4UWXXpaNaebg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6109.namprd12.prod.outlook.com (2603:10b6:8:ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 18:17:34 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 18:17:34 +0000
Date:   Fri, 28 Oct 2022 15:17:33 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Haoyue Xu <xuhaoyue1@hisilicon.com>
Cc:     leon@kernel.org, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 for-next] RDMA/rxe: cleanup some error handling in
 rxe_verbs.c
Message-ID: <Y1wcvS0ZI3acUGcF@nvidia.com>
References: <20221028075053.3990467-1-xuhaoyue1@hisilicon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028075053.3990467-1-xuhaoyue1@hisilicon.com>
X-ClientProxiedBy: BL1P221CA0022.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6109:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dd1edc9-0490-4efe-fb2a-08dab910af6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fl387rLXNmKwuhLdWbrZbACIWIyxNtCZe1TXwkVP0rImUgnD0Y20MCH599HKqDF8kiYuvYpf1D+yP3O7apNVuiyaH8h/DAB+gbshML788KBN2oQPM2YTS42vYa/s5RXMsudN+OJTFJEkw6+VN5T97qdaNHmreO+6zd6ivamMQrOYD8tFzvXCJeQe3RQaIMK3fnVy9hOcoeU3Xfd81jq2qeN+hZJySOJFC1HqsFnVX009j5pUc0eBzJgsWJvfsKSvdt1con5raQnpH0fLLddxkxzqNYGNmPe2TrrzWbQTpxYxOVedLgZyUD/t+sUoMtI3cihVNhJIeymqEsDxB+1F1J36oaL+yYBVWgE8/lYJ4+Bxy2DVOtedXAk9sUql+U+H8cCvTeiWgHfVWZJrD9L39IZIsWjIBfAaW/QZ4fdigtfToYsU1EokpkN7fQm/xZmrVuFE/kivNdN0d9iXzsLA0RuzvJiA1A6A9ejA4//Wl/8h1RC5KDO+wEEEA8MTE+kcXOruoRretEaVre/n6uCn1jXUSfD/7iA1L2QwyQ6NcbhG5wkKGfKvC8+ogcs4aFylT8R9FUB+cJoddJtO/g/dtYwbwWAOzl31yhSA/ZrZtM/SzC9pUlgwNcxQBoPgvTx8v4Ya0YFruWa66jBuci+yTvRIccGQEtKl8W8K9U8ExZH4JIT4ihqlAQuo1V5AWcLFYVS1UmV8CHHd5FpFAK2GJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(451199015)(2616005)(478600001)(6506007)(6512007)(26005)(186003)(2906002)(83380400001)(316002)(6916009)(6486002)(8936002)(4326008)(5660300002)(66476007)(66556008)(41300700001)(66946007)(8676002)(86362001)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6ZRrk6+tjr/eFpPRMvMzTDsst5AsgfRkimv4CsbX+hka5gUX4OWrLmIl+n9U?=
 =?us-ascii?Q?bOEj6cO1upe6SXhDdcO1DMsBLzbdr9M1L4OUueydvvDr+jf4j0iUQwmAHfqr?=
 =?us-ascii?Q?9CTAF8jmHWFz7Jc34Y6qD3kcXU7haXWxUUXLB6yc+Qze06tThw/pXXdowbf7?=
 =?us-ascii?Q?05kA7GuHZqsKQ1a5Ow8i0QdBNJ9psn4F9+ZaljIswm4tnD9JvVAUpRm9YOa8?=
 =?us-ascii?Q?unO9g8fWgy/tzMvwSr89Kjn9FXPyNIwQGAF8Xh/hbeQrlpGSiDwhOdKkE3bF?=
 =?us-ascii?Q?qNOZAFT8XrrclUrN/R3m/gHlaJ1Wr9BxjERADMxGIDcxtlrmhxRV2bqzez8b?=
 =?us-ascii?Q?lUE6MIpxlwyTEqvofEwDFjjPyIZ3rN0GYVgfzzPyTuCmpoQ3DlnZJT/QkTp2?=
 =?us-ascii?Q?poOvUETVjmueu246csENByjlXSkWUVejySB3YS/HyZ7Fc/NaBQ/ABxD6wUDp?=
 =?us-ascii?Q?xg+/SA+MJvSormqYx6MzT51alHPVLgJg6hGwxz/Z29novA0BUzvVxcy5CcBN?=
 =?us-ascii?Q?6X9ewAarV/NWxAF+hNMtVhDc7R5J+wCDQb/RaUiHvcjQRVC9xfbhFc2h2cYI?=
 =?us-ascii?Q?sPfdQWtmTlG6Z8nJekdgbHY7DXZDgFG33CNIt6/eUulY0wfI9f2PMMNdPMDK?=
 =?us-ascii?Q?qtqufXBfS0a11aMyTUsTV1aiXlwnCgn9tBhuNE0ZV/uKMdhUAlV0Pe9U4cL/?=
 =?us-ascii?Q?S2n3mSF+P9aVxH2KJe9g0cYbdE/mVhL1MIPCmzwCjMtv5RvzytKQ7D5oyPgE?=
 =?us-ascii?Q?WJ3Yr51CqPuPFytHL8Q6HKx5Smqu0WUCResACU300vsq9C4shVf7NaNSG8oi?=
 =?us-ascii?Q?N6IFOuMfcyK244wBvAac+Znwl9ujF2Bw5VBPujwyQm908C4QWiHc76wFSKcq?=
 =?us-ascii?Q?WTKcxWReW0Jv2PFG6xAJHAtBgRq2eAc9RxVB3eDiz+Wg8G8yW1smmZ+UAekZ?=
 =?us-ascii?Q?+Uhwq2GDw1q0IRBKFPKi0pwUwDjaIPV09CX4cS1wjYxLZQVkXoOpOgi7//ao?=
 =?us-ascii?Q?IBnZzX1/m3AgU/C5qz/gEq29xVxvwqi3O3Vh6Djo3YdCeX/G3cpEoGIhdMEk?=
 =?us-ascii?Q?upNxHPVMIOwt+tZeHV6w9umteDkKRfwlS3OcdVyLXdKkgbloukVvvPuF8LVy?=
 =?us-ascii?Q?490yI1tPfgjskQy6ZxJTMCGxtBzMNcfzj7VBeJqgNvi016OTT0bZf09jmR/2?=
 =?us-ascii?Q?/QS0A8EkZKbPwHDgkClydSd4TRC+7BlOSbWw/vc7D9XKijNpvbAawioMqY4d?=
 =?us-ascii?Q?GvVqfFs3eyzAVaWLnzpyUpTOmkclB7QF+v2ZD3PNSWJoCDFURyKqT3BKwUyq?=
 =?us-ascii?Q?ke9kAN6vKsX/BOVlqAYsKsuBsQyLUHSq2AtfeXt/uweFrr/IAxiM+KmejwXD?=
 =?us-ascii?Q?Iut6/Q3gpHOgARvg010PGHzml8dNByMK8XK/3rUGaMVHLZe3vL30kgIPGUj0?=
 =?us-ascii?Q?mymCYJKqdxAoxcbLADUaYzhMnWTVwxbgtZbUg6NGJJEOH+hygLclYncSr6/x?=
 =?us-ascii?Q?GkGdnOEedafCINK2VhDkgrFASf4Bzee+3XxdmeNN8KnzKBBA1ELMA+RjgD2m?=
 =?us-ascii?Q?n04UfyAf0g+EXT8I5jk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dd1edc9-0490-4efe-fb2a-08dab910af6c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 18:17:34.0897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: muvqpE83KfwXe1fZgWJoK8sEPcH6oCXvDkdpaJUVU4j2C/olZD9UjdypIt0RF8jA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6109
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 28, 2022 at 03:50:53PM +0800, Haoyue Xu wrote:
> From: Yunsheng Lin <linyunsheng@huawei.com>
> 
> Instead of 'goto and return', just return directly to
> simplify the error handling, and avoid some unnecessary
> return value check.
> 
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> Signed-off-by: Haoyue Xu <xuhaoyue1@hisilicon.com>
> ---
> Changes since v1:
> 	Rebased to fix some conflict in the patch.
> 
>  drivers/infiniband/sw/rxe/rxe_verbs.c | 80 ++++++++-------------------
>  1 file changed, 23 insertions(+), 57 deletions(-)

This is good, applied to for-next, thanks

> @@ -921,26 +894,22 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
>  	struct rxe_mr *mr;
>  
>  	mr = rxe_alloc(&rxe->mr_pool);
> -	if (!mr) {
> -		err = -ENOMEM;
> -		goto err2;
> -	}
> -
> +	if (!mr)
> +		return ERR_PTR(-ENOMEM);
>  
>  	rxe_get(pd);
>  	mr->ibmr.pd = ibpd;
>  
>  	err = rxe_mr_init_user(rxe, start, length, iova, access, mr);
>  	if (err)
> -		goto err3;
> +		goto err1;
>  
>  	rxe_finalize(mr);
>  
>  	return &mr->ibmr;
>  
> -err3:
> +err1:
>  	rxe_cleanup(mr);
> -err2:
>  	return ERR_PTR(err);
>  }
>  
> @@ -956,25 +925,22 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
>  		return ERR_PTR(-EINVAL);
>  
>  	mr = rxe_alloc(&rxe->mr_pool);
> -	if (!mr) {
> -		err = -ENOMEM;
> -		goto err1;
> -	}
> +	if (!mr)
> +		return ERR_PTR(-ENOMEM);
>  
>  	rxe_get(pd);
>  	mr->ibmr.pd = ibpd;
>  
>  	err = rxe_mr_init_fast(max_num_sg, mr);
>  	if (err)
> -		goto err2;
> +		goto err1;
>  
>  	rxe_finalize(mr);
>  
>  	return &mr->ibmr;
>  
> -err2:
> -	rxe_cleanup(mr);
>  err1:
> +	rxe_cleanup(mr);
>  	return ERR_PTR(err);
>  }
>  

I fixed these two err1 labels though, do not use the errN format. I
changed them both to err_cleanup

Thanks,
Jason
