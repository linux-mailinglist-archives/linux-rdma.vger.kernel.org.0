Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC6B6CFC61
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Mar 2023 09:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjC3HMa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Mar 2023 03:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjC3HM3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Mar 2023 03:12:29 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C740659C0
        for <linux-rdma@vger.kernel.org>; Thu, 30 Mar 2023 00:12:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TbpYfwvYOseWXNV6pA2PiYebgUcR0AxtHG98oUjEqDT78Gop8z3K9mwyITELOUgbe8xcWddPD5289IpQe8hevCGHap9GciRsmk0s6i2OS7jD6XAwsK5Q3EF94ZZ+FqNZNlVyPayMfmCadEilLeMQJz5xj4GE+qXsJ9y0o+WSPBzrOXiHpVT7qhAbuzhdTXL2dbjiyOQa6cr5I6UnLiJDbZSwk2RaXWB+mqyrprBkWqh5PVOJovu9Iq7MFr/w0s0w57XTa+9GabFajKw98ARZQGcI5ir4Y0KS8qghFF2U++tH7voAiiBsWp0qiyUToY1suTl9d4Loo1w4Gn+GkobiMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVhBac0L+g7sYBYmgJd09uv9sMhYXzGK2UpzNxUvV34=;
 b=Qen13S9aAUfvCfB/3heuOTaHqn6aL8jOwiX4YZs9Y9OIsbLokBav0BDp8+j40Ii/9bVgkc/vPHs5TDanPtr4BCC9e/jdGi4WUjwZZqcAlaMJ96j0S7OJugF2uauyBmOn4EHTrY5orstgRhOnEcngYwjPFPpft2jIVQN62BRs3ibyco2FmFH9aRwVXBk+ddN2Au0HTfAL3JvfTt+zTDHUYsFTy27KU/RwPHK6EwnZNdD1OdBdUIqcQh4xZ70SeBbX3rKsNK6v2j6/41OJ5Oj6PwYor6jjr+wdkHal1BolVeb1+u80kN9ibqP814o/iXfzoc4q5075Vwxw+3ZqK9RL0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVhBac0L+g7sYBYmgJd09uv9sMhYXzGK2UpzNxUvV34=;
 b=tNmHgYH9oDcQ+hD4J9U9ImdVHAXjdDNFz30bHIWxb26gGErLIyjdkeekCSLuD9YXAI7Pju71s+XsswB9rdzoLTwI8x8Jo5WMh2l9bdXQI5qYQssMZ7Xl4XCmeqoqP5yY3RyhTkoI+gfuyEwoAhd15Wlgr6uQNgdBy8A/hKPagUgEhYqwbIiGI+Z//q1t5xLjczmQhzBmPkaLFMSxpmXdUYwTWqsKO47TvwNkJmQn2LosUBoJVM/hrMlo6dnjcsC1DraXURFtdZqJeK/yvZRYMaXBpphiMveWPbtYXmy+yYG+wfTeAunNLngTjZlvhlqvna7bLJDe9SYslDHkwEHpIA==
Received: from BN9PR03CA0218.namprd03.prod.outlook.com (2603:10b6:408:f8::13)
 by BN9PR12MB5356.namprd12.prod.outlook.com (2603:10b6:408:105::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Thu, 30 Mar
 2023 07:12:22 +0000
Received: from BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::a4) by BN9PR03CA0218.outlook.office365.com
 (2603:10b6:408:f8::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 07:12:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT035.mail.protection.outlook.com (10.13.177.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.22 via Frontend Transport; Thu, 30 Mar 2023 07:12:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 30 Mar 2023
 00:12:07 -0700
Received: from localhost (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 30 Mar
 2023 00:12:06 -0700
Date:   Thu, 30 Mar 2023 10:12:03 +0300
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Mark Zhang <markzhang@nvidia.com>
CC:     <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/cm: Trace icm_send_rej event before the
 cm state is reset
Message-ID: <20230330071203.GS831478@unreal>
References: <20230330061812.479463-1-markzhang@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230330061812.479463-1-markzhang@nvidia.com>
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT035:EE_|BN9PR12MB5356:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dea8160-555e-4343-71d0-08db30ee1b5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A197/NDh+g7v0TgfNCC+PvHhwwklJE+rJRmy9wtxcs/SYbV2iQLRUtYOfCNU82zZCJxhQ7K4eKMj8k1UtlamvcK639NOu6TFqUBYXplJP0EfmIJMrJIoUd7jKEdncBbPrvpkndk9vAOH4hPgTJIPNYmzcjwaVZMkBRQDNBoUqftiAqIxaA7uVnWym+uc6fBupCoMDaQl12OxzShIPSKyPeUBL30Qc1Y2LC7Tk3PNVN8DA6pCHDF+CEo71+aq4GnI3JL7mdPZfk3QH6c3bxN4oo6L1HHnwaznVcnkzHZj824cLavpoaU3svNKrzny4uV0RdkJ3vPEaOkw80ftd0+mafcFWnnXNSPvC4HgO9u/R7Wtt+Qw+mTSGgql1gZV36bSTJH/ZoEnxUkqrAJbNa0Mf09rVl5aDgs3uNZ5n14t6Ew1N0FwkiUDI+sWTd+TdlU4QFt51KZubnWUYpwKqUuNMCOjp97TqM4QK8jqsMoOIPP+3yd23KUSYzROwYhyViEi8alYKz0TAWHTbjMvxQhoSzfb7pgmZkbFg7jGfplO62Z7PxEyAPFyqwm8aERLNBR/iPLmFXRzCPdNkkbk05gkS8EQsWxGQEMOPRkbg51qd6c8a/5cGwhwNkrpCHqpAa5u1AMSrtaoYo0mq4zB2WRrQ3Q8yYqaNYXcjStS0cexJg+OsA13qJpiPU6rot6HE+2hRnpSkLmS9pXl/JMeNv38pFNVucwzEG5+0OvVoKIGiJPjKlvZXYCSgu9oBIVTbeEDuxSqyisFuVdPlggbZzLIWcclEPktop6S7358xY7BTPM=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(7916004)(4636009)(346002)(396003)(39860400002)(376002)(136003)(451199021)(36840700001)(40470700004)(46966006)(83380400001)(1076003)(26005)(356005)(478600001)(70586007)(54906003)(33716001)(316002)(6636002)(40480700001)(82310400005)(7636003)(8676002)(4326008)(70206006)(6666004)(41300700001)(86362001)(33656002)(47076005)(2906002)(82740400003)(9686003)(426003)(36860700001)(5660300002)(8936002)(40460700003)(336012)(6862004)(16526019)(34020700004)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 07:12:22.0287
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dea8160-555e-4343-71d0-08db30ee1b5a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5356
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 30, 2023 at 09:18:12AM +0300, Mark Zhang wrote:
> Trace icm_send_rej event before the cm state is reset to idle, so that
> correct cm state will be logged. For example when an incoming request is
> rejected, the old trace log was:
>     icm_send_rej: local_id=961102742 remote_id=3829151631 state=IDLE reason=REJ_CONSUMER_DEFINED
> With this patch:
>     icm_send_rej: local_id=312971016 remote_id=3778819983 state=MRA_REQ_SENT reason=REJ_CONSUMER_DEFINED
> 
> Signed-off-by: Mark Zhang <markzhang@nvidia.com>
> ---
>  drivers/infiniband/core/cm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Please add the following Fixes line:
Fixes: 8dc105befe16 ("RDMA/cm: Add tracepoints to track MAD send operations")

and add the author of fixed patch to Cc list.

Thanks

> 
> diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
> index 603c0aecc361..ff58058aeadc 100644
> --- a/drivers/infiniband/core/cm.c
> +++ b/drivers/infiniband/core/cm.c
> @@ -2912,6 +2912,8 @@ static int cm_send_rej_locked(struct cm_id_private *cm_id_priv,
>  	    (ari && ari_length > IB_CM_REJ_ARI_LENGTH))
>  		return -EINVAL;
>  
> +	trace_icm_send_rej(&cm_id_priv->id, reason);
> +
>  	switch (state) {
>  	case IB_CM_REQ_SENT:
>  	case IB_CM_MRA_REQ_RCVD:
> @@ -2942,7 +2944,6 @@ static int cm_send_rej_locked(struct cm_id_private *cm_id_priv,
>  		return -EINVAL;
>  	}
>  
> -	trace_icm_send_rej(&cm_id_priv->id, reason);
>  	ret = ib_post_send_mad(msg, NULL);
>  	if (ret) {
>  		cm_free_msg(msg);
> -- 
> 2.37.1
> 
