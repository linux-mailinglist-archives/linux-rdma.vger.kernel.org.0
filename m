Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A42776866
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Aug 2023 21:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjHITSI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Aug 2023 15:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjHITR7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Aug 2023 15:17:59 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2058.outbound.protection.outlook.com [40.107.101.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7E226BC
        for <linux-rdma@vger.kernel.org>; Wed,  9 Aug 2023 12:17:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mux4O84jp58OEewzxIWJ+Whi4s7929kuJwoVxVYROoZ+r18wTbzfQ3Xuxpbhd7KhI08UNRpMzE/tUrU//dEr+RBKR0DT71FdE1Vyw7qAjDjOkg3ir+nvdaZP7p68txmyPJ9J3dORUklNmgdFykkzGZZD8hiYS4DmGTOI4h1DZqqRbVn7qATo7iwdwsSjRcq/mrgq4ggpgRUSapTuSEJbkt1rmyP9g9QehGD7FVkhh6AbRkJfX/5hDkuQ/fIFRz+39Gu/+sbaeDxn9WhOVqFJUaSzfLsSEgcVMPPJ3NGCQSro+4JWieIgbjf+ar+STfXLPuYbNumSgff8OP59d2Kp7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWj98LlwWvfKGyz9CEjNtawpvPDqe/AvgXrXaFrp+/o=;
 b=Y0qBOgECcnS/mFQ25PtAk1uEuhljsdQbQLhqBE2/uwBiQN4rVGoFAPKysTgRbGQ6XBS9c2CSr7QnRmuGJRDVceNGM1JMTTvR8yjNwHqKYQBCPjs9alGa8oxWAri9s2/Up7whA6pxGzh4gMVkED872xdXYlYwdxpktfFhLb1iIZc/vwoTygw5Spyiw0Jlz+cBH2r6FRFqlAXzouv7+Orqrr/MKdOx7JUEUq+4FlbAu49edrQw5SlmtyC5ouoopeC0+beAovoc7C9cbYhFSKLakgabu5Wyx9ePd3TzA1hGftnM9/t4uQLV33E5O0Vciei9ND2+b/m3FDLlU5u5cpHicw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWj98LlwWvfKGyz9CEjNtawpvPDqe/AvgXrXaFrp+/o=;
 b=RuihVel7cNLp162nHEvBJqTiYMNZqzdE7QFsH0o9ZkL3cSexizYWNAToGZDCYR7yGOgMivwRMsaZPoOyzIi86d9+Mie6u6gpnWg30gwGTN1AM/3HYka716DBzizCinxAFJwSzcg5ui4vWrlM7Eq/SL5A/f1GwSiY+PjorlzKIM6/hnAW+zXVZWpSMNdNBU5Ss2xhlIri2UPgPjudPdRuGdgPKOJCJAEYrnq9h8WPzk63ZUIi4NK1E/HIZfNtKU0YnMEuU5ZuhpXy3G57USi8gP8IOJ4U/MDvwA/P16734IRHNBFDSGS1l1bGGkGC/ebsGWt2Ml8sWurTxPIyZLlYPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Wed, 9 Aug
 2023 19:17:38 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 19:17:37 +0000
Date:   Wed, 9 Aug 2023 16:17:34 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     leon@kernel.org, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        jhack@hpe.com
Subject: Re: [PATCH for-next 2/2] RDMA/rxe: Enable rcu locking of indexed
 objects
Message-ID: <ZNPmTjywkC30MkKR@nvidia.com>
References: <20230718175943.16734-1-rpearsonhpe@gmail.com>
 <20230718175943.16734-3-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718175943.16734-3-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BY5PR04CA0025.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::35) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5336:EE_
X-MS-Office365-Filtering-Correlation-Id: 370cfc24-de27-4851-a0f5-08db990d4a9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VCSZ6NF9TavkfwFPzdvByJRvzBX0+sYVfegf9bF1KXPkpMxyzdp1O43rcJL69PBPLtxiHd4q5RsM1M1vtqz9EkyddSrgqBpRTeDxY8s9OwdbOQ1iRLQ18yUjDbz4P8f5s5diqi718TuFd7kJhMhw1xA3NIOMUj3DBkMyfr95ZuEgBN4z+xcS6L2Up79832JlEbgD4NHtqH5KB5Wtr/Qgx3tsEAmR/QL+ywubGtAIVn0jp+9eG+yAn6JljmzwEWxlvWjd6a0+GJ7qc5knvUgo9zElW/BwAkPyEItsXMYyuxfe3Ys0bJfbrzP5RTsptBnQtypGSVpdFO96FlsIqidDtw9F2d/+EeElr+mlzpRKfcs3inrwW6cbZXGQXLOCPmhMZDxESJJBgMWzsRqdA8SoDkf8L8U6GbeXViVIYq6NU/OJfczXTbVktBusghY3N3xwXjDgGhvbejQgG9YkVikGk0/dNYdUX+tTdCSNiENtP9FnKpkvVdPNiG5AdBUvLnWkzLIBRtDXZEt1Ur4bxtUxRKRrZavrEW9cANxCKkKFLnEPcXbaJD3fmgbTqP/H58rt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199021)(1800799006)(186006)(6486002)(6916009)(66946007)(26005)(66476007)(66556008)(6506007)(6666004)(478600001)(36756003)(83380400001)(2616005)(41300700001)(316002)(4326008)(6512007)(2906002)(86362001)(8676002)(8936002)(5660300002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V9cnQVu+o/Y7a0ASqvI5MazHYzD//hG9DW4QD+hdNGcEthXfIk1Nh3Fg5vXv?=
 =?us-ascii?Q?T8Q7j/jGviv9X9WCSuQ53tkH/nEpsDWCgGkzA3fsKcNlBDSkF3PG9pir6LzE?=
 =?us-ascii?Q?AHbdrHBWYwpsxSsm58liY9NhbJF9a99v18QhUAwwEEUeb2c6w9OIwNNVHjAu?=
 =?us-ascii?Q?t7r8UpFNFLB+9pixdERGcPZ0aiK/a8mqgmIHYp9C4cfQRRuHmGz15MRlqz6r?=
 =?us-ascii?Q?MFrnBnQPDYvJa+hf/UWfCZ1D1LQDf5lX7b851m8mNYw4aqUgq5XPWKNOklSa?=
 =?us-ascii?Q?kH2txg7RFwegIX+SmFXzIe+Zo/GRn4lqmMOFeElhxyakUq6A8MyIyW01QQeG?=
 =?us-ascii?Q?DMCT3GNON6LkSFxaPhCE/Wxvokd208Qq+Y/+MKaESCfVI5bFd5eIcbZWdxj+?=
 =?us-ascii?Q?OJqQ3xnpWhx5/pLfmjsCTfB8eRH37Ib32Pb+59Kl4tP5AkuMfYL+IsJLxuKY?=
 =?us-ascii?Q?YHSLuIrVQr+Z5uB0WLAIHtmpQ5KbCWS849UP/LpuWEUDV2uuuEyvX6/7+D3V?=
 =?us-ascii?Q?uqcimZWBB5yzdeS7Z/YmVqPwcz+wghr5/jyKIUPsmdpOMc/LcM+eBJSbOZD9?=
 =?us-ascii?Q?f8Su5sg0lfTe4CWdcW1VFJS05bH6Scww9kmFd50ONAbEPuO8RZGGIdMRWxl4?=
 =?us-ascii?Q?NdEZ22fjKMMwMIlPPaYm4yPmODXsIv6ab8Oshf3pOJu3cnT+Vhtf25fG7/RU?=
 =?us-ascii?Q?CCDjhfNliIjCQu3fvHkB3KQBp+mUwNzllhHlAJ8O7n2kvbs+xwVQSWPNZ3YM?=
 =?us-ascii?Q?/sUg54kZBE/A8bUiH+uHfMsusQCv7CgV4qJvQH+OVXD3lFD5/MIJXw4yxL4f?=
 =?us-ascii?Q?UKFesAr5C9sTih01qkSldYEDqRxksPPuY9B5Hh7oUu+C+obSQCWz2mW8Swvc?=
 =?us-ascii?Q?ag7CQSWmqa+S95A++Jse1NmXzEEsf1WlIt5btixXYjenzwmm+/J83pFAMAUo?=
 =?us-ascii?Q?twS+1pCq4QqZgIkXlgXdCrfLLCvt4Rr33yXpRKcWy8XWE+2BbKkeuq4rcdM9?=
 =?us-ascii?Q?q1cfxfcPuc859bn2E73umiauk+x8jHp3SAs6W8+Z5Vgq4CSyJyKraL9i4UZ4?=
 =?us-ascii?Q?bcE/QMw7DWTWScV1MA2GC4xDvXHff0lsV1eiH7DS1oBr2kojsAMtIIAsa7vO?=
 =?us-ascii?Q?4+tPgoInDwZvvp17tilmW2RLK6V6CohXfhXc9ufgdIcVBt8AB6E9Y+ddgl9y?=
 =?us-ascii?Q?0o2239/lY/GQdnAblKNHp7Aeb/VZG2qrMjKvi0VFnXMpQ9j+1h1VR/zflt1H?=
 =?us-ascii?Q?2xGoZ2dMZBP2jMJNPFAxI2r7UYhXW3gtJYVF9eajMmKiwyVAcnXb9Q10bfN5?=
 =?us-ascii?Q?0Ns8OW6BC7fO9rOzbTI7g2qMYQc4jMATNv0NHupY4rGHM0X/lHMUqT0rkWGZ?=
 =?us-ascii?Q?MdxeHqwtWjvoknqrSfticlOC+iIkGugOxpWog7jxswMWJEtvCpz33PsA38xk?=
 =?us-ascii?Q?e9kiMBg7i09o0z+lfePUhc/uOKbXRoiIbLiMSMdGf37Nq+lWVkh1opSJmVsk?=
 =?us-ascii?Q?SsNLqftjIA0GtRu9cLo5UQiXHvSE0EXOZ24vtmaER4IOS272RoSUfUCVFvXN?=
 =?us-ascii?Q?yfkl8dtd0adZbioQ3S8C8FOm9YUo4C7XhcNTVBDb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 370cfc24-de27-4851-a0f5-08db990d4a9a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 19:17:36.9746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O7ZaRCwGGxrG/0YU1lGHyEcjuZfgsQmvGHqrh1ZPl9cdIELv5EdLRW6UkxbbDOk4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5336
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 18, 2023 at 12:59:44PM -0500, Bob Pearson wrote:
> Make rcu_read locking of critical sections with the indexed
> verbs objects be protected from early freeing of those objects.
> The AH, QP, MR and MW objects are looked up from their indices
> contained in received packets or WQEs during I/O processing.
> Make these objects be freed using kfree_rcu to avoid races.
> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_pool.h  | 1 +
>  drivers/infiniband/sw/rxe/rxe_verbs.c | 6 +++++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
> index b42e26427a70..ef2f6f88e254 100644
> --- a/drivers/infiniband/sw/rxe/rxe_pool.h
> +++ b/drivers/infiniband/sw/rxe/rxe_pool.h
> @@ -25,6 +25,7 @@ struct rxe_pool_elem {
>  	struct kref		ref_cnt;
>  	struct list_head	list;
>  	struct completion	complete;
> +	struct rcu_head		rcu;
>  	u32			index;
>  };
>  
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index 903f0b71447e..b899924b81eb 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -1395,7 +1395,7 @@ static int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
>  	if (cleanup_err)
>  		rxe_err_mr(mr, "cleanup failed, err = %d", cleanup_err);
>  
> -	kfree_rcu_mightsleep(mr);
> +	kfree_rcu(mr, elem.rcu);
>  	return 0;
>  
>  err_out:
> @@ -1494,6 +1494,10 @@ static const struct ib_device_ops rxe_dev_ops = {
>  	INIT_RDMA_OBJ_SIZE(ib_srq, rxe_srq, ibsrq),
>  	INIT_RDMA_OBJ_SIZE(ib_ucontext, rxe_ucontext, ibuc),
>  	INIT_RDMA_OBJ_SIZE(ib_mw, rxe_mw, ibmw),
> +
> +	.rcu_offset_ah = offsetof(struct rxe_ah, elem.rcu),
> +	.rcu_offset_qp = offsetof(struct rxe_qp, elem.rcu),
> +	.rcu_offset_mw = offsetof(struct rxe_mw, elem.rcu),
>  };

This isn't quite the right calculation.. It works because the ib
struct is at the top of these structs

Do it like this:

/*
 * When used the core will RCU free the object using the driver provided
 * rcu member.
 */
#define INIT_RDMA_OBJ_SIZE_RCU(ib_struct, drv_struct, member, rcu_member)    \
	.rcu_offset_##ib_struct =                                            \
		(offsetof(struct drv_struct, rcu_member) -                   \
		 offsetof(struct drv_struct, member) +                       \
		 BUILD_BUG_ON_ZERO(offsetof(struct drv_struct, rcu_member) > \
				   offsetof(struct drv_struct, member))),    \
	INIT_RDMA_OBJ_SIZE(ib_struct, drv_struct, member),

(and maybe the prior patch could stick with the ssize_t and we could
remove the BUILD_BUG_ON_ZERO?)

Jason
