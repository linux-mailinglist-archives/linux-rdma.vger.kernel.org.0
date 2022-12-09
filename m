Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F6A648B7A
	for <lists+linux-rdma@lfdr.de>; Sat, 10 Dec 2022 00:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiLIXth (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Dec 2022 18:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiLIXtg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Dec 2022 18:49:36 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C95FCD
        for <linux-rdma@vger.kernel.org>; Fri,  9 Dec 2022 15:49:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AzITRm/gwBC1498bEvL6j0cbgDROaHLmq8GCBcRumB6Dz2987blBqanCoBYy+2wmMUlPBlt/Q4UjN6gKxZ5QyNxySYi9a2DCOPqVl/5qU43QC2mqRFJKHuRhpwWntQ6wETTPzhLKbsht2Smsk7/WMR3KligaQDpxcajAE2tylbzRPxvospWRfFS2Hci0NoYzhdIBPMFUZoEzvuEekucDng7cDMyxJAN77QnHNG7QYsaI9xAjlxJxL0CpMGqiyUfzhQiquNHKFP8aKMjxTaBODBxny8WyGxu354sm4hCm0gDrlDc5GzhBxFNYhq4QKgV8ZrxhJQbG1zmQTCDPf1iSQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xh+YojV4ng3yHLCE0SnCYCUMth+JdEna6ii1m1I0ALA=;
 b=imPxntaK1mH6Gj4NqFEMg6ipu8d6BOYDsXjGmT/+WJzNq1mZMwfjLB8pkUs5Tf73IQhBvEaEy4pjcd5JpNQsaVwOWQCHN+kEflTifVyd3R4ChIDndH+XMWukoXyq7TmErn0Ua12y9jJ4o8Vbw4mbuN1NRP5eCg0ZS/sPmNKnWig50+Yl2vQkE6ejmnAuOaVjLFDHeRMhkXX4hKaJbhnGBPcMivpV4ZZZJNiKL1flMM+/vhMCJhBKNN5hXViSIDHCbC82vGfzum4SuaAPhDdkAD4ClTgUI1FmeAIAwMRqSUsx9Ci9g57gmJu3BaRot4o3n9CVr+7SM1x3My5mSofUMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xh+YojV4ng3yHLCE0SnCYCUMth+JdEna6ii1m1I0ALA=;
 b=VRUeFHUCGE3LTvv/GUwKfqrh3aa7DeoVsdE91r5l7QJ8TYBOopokQdNjQSg4S9PSF9fezmg2MvDku6PNHXpiVgM+hVmiwp+BbVePbUa1S/L4E5b3vDYGJUkb4scwm2VqiQ1F+zGk3X68QhHN9hM+Xv4bQYAA2c2byDwDM3lYNgNIB+rPLetVymgdy1j9UyC4ZvESxPvHRRcpHrhc3P5Hz8wp+bwR1drJ9XEvMPYoC7f7sccL5vlKBAJpywedGjmn2Vl/gXpWOHVOt800idm+lG+ptwpTzQmzT1Ocl4zazZCgYXigVvehZuXFQucyHSLtJ9wu/4mBP3yJ95L0V/7SDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BN9PR12MB5210.namprd12.prod.outlook.com (2603:10b6:408:11b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Fri, 9 Dec
 2022 23:49:33 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5880.014; Fri, 9 Dec 2022
 23:49:33 +0000
Date:   Fri, 9 Dec 2022 19:49:32 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     leonro@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 4/6] RDMA-rxe: Isolate mr code from
 atomic_write_reply()
Message-ID: <Y5PJjI6yuy3Pm/pw@nvidia.com>
References: <20221208210547.28562-1-rpearsonhpe@gmail.com>
 <20221208210547.28562-5-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221208210547.28562-5-rpearsonhpe@gmail.com>
X-ClientProxiedBy: MN2PR01CA0047.prod.exchangelabs.com (2603:10b6:208:23f::16)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5210:EE_
X-MS-Office365-Filtering-Correlation-Id: 50dc7d89-0079-4d30-ed29-08dada40056c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HQY/FyZ8PCFlnF82m9eXiAUtH9ZHSIcjPuTCIjV2NuMNxWg4+o5LaSw1LBjSLyJbgDCW/tKn4ddWDJ9P0wiv8rTfw9XyYB62OGsn4jV0rF994C3yJARfY5ZKCiEjGMUDpACxUxq4w51FSPCZLqSBbQLauG/dvT6S1uNyMXSiAPTlKRZAyazqvPVRTE+1n6mUC1SBk+OC8Y0/67zNGEB+6eZxzwc+a9Is71eicRqkRBJOyKMEA0nIaSP9HcoUZXBqATI1AqxGVe0eavhfokxR07KkEfJ88ZPmJfWBfGYL0TdiY8g0kOK5c+GkVe0VpfJ5LHsp+GToSJZSsnTNnT+4TBS23xe3MCLlgwaFkJGGCHXY/TzOvAPFMbVHqlwkh9fUymwMSFEUEwYhA/dXXyHEplun3bVe5RmwMKWRIy/+UXi8U985hgBkTLr7n2DRuXtxJbXuFDVDfjC+p4UT8vMkJsDZe8ON0ClHeO3wRa5v2MOBaCM1XisDafiKmsT2JvxE5BXlmoud2jUUzJ9/SDT3AEnSIeGSnJbudkxyBI6lvwLpkLvs+VW92dXb2lVW2R3cC3PaW7veCcMdK1Gst7UbaOrWfmc2uRtAqWb9Vc0qj8ufB8DEJprdl1Yk7VmldUq+xsghh6RvI4j5UKVp+MKH1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199015)(86362001)(186003)(4326008)(8936002)(5660300002)(41300700001)(2906002)(478600001)(6506007)(6512007)(26005)(2616005)(6916009)(6486002)(316002)(8676002)(38100700002)(66556008)(66476007)(66946007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YmjdQk3e2LnsKo/NC2plgDiIsN2zr0anKF8+IPcSwixhZWTTkqZDylL2n23e?=
 =?us-ascii?Q?knlgvxPdgvali4xVb9sDfxmWgLqLAo+OiSTfeGAsIe8Jxs5H06+VdmO8Df1g?=
 =?us-ascii?Q?7E5lvSZdrEfIBeg3Z3LjwBTH9NpEFaxHVfBHP0jc1f31+pCgK7to8ElPaurP?=
 =?us-ascii?Q?0q7bTUiSary9HqzJnek1mSF9Aaazy+RqdyZ+Bf+kj2LhqlzQacFUchnknwhS?=
 =?us-ascii?Q?S0McQBSuo/rHCX1hHA9AnqoHlVevhmgNAfpjZnlBphoqS8IahVOr4MqTcQQo?=
 =?us-ascii?Q?6UW1FmEPYggD+pwIex86dfLQBgTlSsGLa5j+ZHAMB0j1uSt/t30mIg0gla2o?=
 =?us-ascii?Q?2z7uHaxu5ZNxh/m/maowx84TEnhkeJ+USwVHjnTyFBAiMDHDUcvJvgn/p03O?=
 =?us-ascii?Q?1k0wA486bkdQDvgomS1Eqfjud78dFFoI+su48fHtpPh35rHs1eLhK8/xlYBC?=
 =?us-ascii?Q?DiYEXpByz45Z4nR02Q5uXtY4NlwGR27VDHxefkTIFgZYy8/PdXoTWj7EkfAv?=
 =?us-ascii?Q?3jjIeWj4k7tGg8oSrMEoB8fZM/gHgJPciOHLCAWQiyIc85mEMUUicOcIr7+p?=
 =?us-ascii?Q?YRAcj14bFC0VX41ofZzvC7gpfDZAbT9LpTwaeGftQv/5Pll9VieiVBM6PCk9?=
 =?us-ascii?Q?fqZ5bVQl5yDqgVWkb+HZMKcrYbXHx9OiLBPJRpRap6V+KEwQAwRtlpzsSUdR?=
 =?us-ascii?Q?MVU7A2GT45ol7NkAcM+S6k+UcHqOuhPmOj5W9e7TTZ3hvJUWa4Sa4Ub2QdgD?=
 =?us-ascii?Q?IckWQFt4XhVEMr3KSS52TwwUVPJ78zTumTK8X/UIFkr9oqvTPjHngVvhl2vG?=
 =?us-ascii?Q?SFyFR+1F3VCH61TjIjRwOpBiVHle7wYmP2LEhgxo72Yn9mFEYcDsfGOl5DYU?=
 =?us-ascii?Q?uPJPNSWHApaNcHfJJZPVNHhoMbHcfGQYsdK21zqQ9MW+eVxGzrjMylfppI9j?=
 =?us-ascii?Q?s7wbigxCeer2SQbB1V62TEdLJLD3F5LP2qnDwtvZ2Cy7OR7tDJL/gkS4ECu4?=
 =?us-ascii?Q?qwkdJq1Gbqer26g53RBgZbaSYg+e926JRQCT3VB/ZfgHT+DbDKnZZNm3bu/u?=
 =?us-ascii?Q?9zIg+9v2r1GN3Elr3FKYSENBrQN0YuxwqxC2/cSjVX3Y61RuOlWjLrrtKpxW?=
 =?us-ascii?Q?rG504LJaqfG+QAH6/9E/Uz3FgSWukV+wv0JpB3DUkgMUD/xivR/pEc7cmtSC?=
 =?us-ascii?Q?EaW2oL7qfJIfEwXOWI0D9YGOb3VY4IPLiEGu8iVGRQWe7NevizrK1orjZYLf?=
 =?us-ascii?Q?5pCx5VoD/PvLZw1jYYhsFqTiEkYjuPyh2u5TKHAryDdU60quwcXiZTWkDc3K?=
 =?us-ascii?Q?J/oNFjGjPUR9P0EFp6PE9bsoRPyf5BbXW4Un/iUwztTtQnjCtP8iD1WKCC+k?=
 =?us-ascii?Q?oM1zIDZKKCtpQN0qTPjO0hB6i3gwMuSQHA8UHAdo8u+bIddMTFIeU+crZpVN?=
 =?us-ascii?Q?gwyd+9hmhAaMSqejMMB7bkmx7TdNrRZ7RJ8Zrgb77j5ggbbOaw0ZY9k5YeGc?=
 =?us-ascii?Q?v96QNvf2/cZklWNiJXKKcfpO/sz9i8NJjx8FwipCRzsdrhxRHyu8rKOgKkF6?=
 =?us-ascii?Q?4ck1/iK+LcTgx24JFvo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50dc7d89-0079-4d30-ed29-08dada40056c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 23:49:33.2164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FChWx8GTj8et3b1niMtzp4rWGz0slIyDTU4pwCAJoF745Jh4o6MoTbpcCm6r/Y9W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5210
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 08, 2022 at 03:05:46PM -0600, Bob Pearson wrote:
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> index ec3c8e6e8318..c6aa86d28b89 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -495,7 +495,7 @@ int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
>  	/* needs to match rxe_resp.c */
>  	if (mr->state != RXE_MR_STATE_VALID || !vaddr)
>  		return -EFAULT;
> -	if (vaddr & 7)
> +	if ((uintptr_t)vaddr & 7)
>  		return -EINVAL;


??

> @@ -668,22 +668,15 @@ static enum resp_states atomic_write_reply(struct rxe_qp *qp,
>  
>  	if (!res->replay) {
>  #ifdef CONFIG_64BIT
> -		if (mr->state != RXE_MR_STATE_VALID)
> -			return RESPST_ERR_RKEY_VIOLATION;
> -
> -		memcpy(&src, payload_addr(pkt), payload);
> +		u64 iova = qp->resp.va + qp->resp.offset;
>  
> -		dst = iova_to_vaddr(mr, qp->resp.va + qp->resp.offset, payload);
> -		/* check vaddr is 8 bytes aligned. */
> -		if (!dst || (uintptr_t)dst & 7)
> +		err = rxe_mr_do_atomic_write(mr, iova, addr);
> +		if (err == -1)
>  			return RESPST_ERR_MISALIGNED_ATOMIC;
> +		else
> +			return RESPST_ERR_RKEY_VIOLATION;

This doesn't look right?? Return on both else branches?

Jason
