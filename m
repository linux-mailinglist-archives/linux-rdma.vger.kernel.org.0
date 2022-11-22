Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED41633F5F
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Nov 2022 15:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbiKVOwj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Nov 2022 09:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbiKVOwg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Nov 2022 09:52:36 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2053.outbound.protection.outlook.com [40.107.101.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774AE1105;
        Tue, 22 Nov 2022 06:52:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7GDSl3uL0+bgmFSSTSNe8SDV5xOm16T2cmBQsuCSqy7Dzc9aIFEq/K+BVerAjUV2VHWsG8CuhCDa2aPwhgIqzyE8fnqdMt+l8neHW/p9hueKDze2ZLpyb5VVauSVbUW++C3mPJJjWEEK6nBs9nC4UIdwsEjEAktpH/QRC+LCnAukYE0d3sIReE71cuO1gAil45U7YAkrel9Q1GPsgZ2fLRBrPIKsDRpfmHuOL9l6YAVWvmjZZTG1E2HmnUbW0De/I95t3WgUNK8v60mw9c9utLbvvMP1xY1Jmah8vxxj9EqwiGEiq3jsdZTL3bUnP//VlnXUg7UmdQTrUl0vsNhig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RlEY+zPeDYastWnNJzN+4+hMgQPNjMzZD2qYSIYUDMs=;
 b=PJ6j+CV942YRCEfBYFBYSy03r8i2KdGLORYKE8IfX6w0ry5p2SR/V0c8U8AIx6Fb5aUlx+zwLedFzLBSgOtiFirFbd/RRtSXxrd1Y7aj219PatKuaERfL0xYZzQS/LUa8edDk2UHbaVgyjIjY+qUU+nChe3N6VFX8P2Pik7ZDRZh1oDoJJhqc42L181i6v5B6SZadAEHmRKWrYtebC/YRe5HbscZFGcJfonlPKdIlbOzyqpTvIFfV6vedVNABqHmYDyqkZfpZnLG6D7L6d8dF3Y9mh8Z6xWAMHu24WepWSRkqQuV1Jn68hcA8XFO9Dtg9PkiAK79rlXLjgimswvCbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RlEY+zPeDYastWnNJzN+4+hMgQPNjMzZD2qYSIYUDMs=;
 b=Ch1if5admZ6uDS5umJ7wrGH2UDsFPUrJhvQXGghqVKUq+oCOX3HukCU+5UXxm8Dm9ls5xPtcd0LubZ3ctaeslWa8UVDOSM2ilrCmjkbRXklDfYPcOL/JXd5ByEvpgCLvVSUhDNT17EKWfkVklRxc/sZnCCLbFEZPnsKPSK9TWauaBlZuJCpImFuHldsskziI/54y4GvquUMja/E3GLNn9T82OdE2FgCXXM8RR035mmr4B1keC+5GlNlE1efBPix5y2CW0pt7+WUTJh/ViOuwiYBGBxbTYP9vjrO1NWhfKxugf9mTOpRmP3xonE6bYg4mq6+bG63X90z9WpoGZ1UW4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6109.namprd12.prod.outlook.com (2603:10b6:8:ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 14:52:31 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 14:52:31 +0000
Date:   Tue, 22 Nov 2022 10:52:30 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Li Zhijian <lizhijian@fujitsu.com>
Cc:     zyjzyj2000@gmail.com, leon@kernel.org,
        Bob Pearson <rpearsonhpe@gmail.com>,
        linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>,
        Tom Talpey <tom@talpey.com>, tomasz.gromadzki@intel.com,
        Dan Williams <dan.j.williams@intel.com>,
        Xiao Yang <yangx.jy@fujitsu.com>, y-goto@fujitsu.com,
        linux-kernel@vger.kernel.org
Subject: Re: [for-next PATCH v6 09/10] RDMA/cm: Make QP FLUSHABLE
Message-ID: <Y3ziLoRuXFIOpnnl@nvidia.com>
References: <20221116081951.32750-1-lizhijian@fujitsu.com>
 <20221116081951.32750-10-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116081951.32750-10-lizhijian@fujitsu.com>
X-ClientProxiedBy: MN2PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:208:d4::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6109:EE_
X-MS-Office365-Filtering-Correlation-Id: d4565895-a607-4b1e-2421-08dacc992ee7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: keSEaExF349719VeRyosA41yBGP7dYRMQ1RIMniK1TyspTckZB1XJ6h946zDbpfrUIv/YXoINsg7kZXMaU7aObeuK70xy7XJmEMjYHjcGv0aZOr9VlpydIdw4vfZgzXuzrkwZeZY5rQADT2UpapALXK7Q9kjOmIAMW1+C9w7L+/K4MqO2KO55cnK5QxkIms6hDMVSk0B60JyLXN7tgUpsoyuAjb24izbdzKmsZ8NQQ40hQgcqCcp8d5+JNhqznf62C4wjLkSKW62R0FusJ/9evvr0FB99Z62zIiy0FYq+AG0uKH/+1prOZeOnSL9Fv+0wBNcnmZIj9eShdZ0TOQeBPfZK9+grPLqGvci5uhGvZKT0Z0oVh6myimvV6Gk3Ynr7G4yTWEquNGD8uEOt27jqAJtj1fNiUTUvZA0k/z/hBVCKm8BSyu5ne1U+Lak8z3DtjJPH8mWrfuDQrZnx4/UqJLxC6nKbV7INQq0M6kzkGn4z3JhfYTcBRaX+qzv2Rtk2TeMCuFL8uQvg4LRT3d0orOIyR+SLtns3petVNQ+x27VVdc39Aoud7B0n/b/BWNEIXrclaVIniM+JCjrqYSmNSEgQtA4cQmhvFuCaT4oUPGG6On+3zDDIOGfajt11uQXc8vTkG2aCoElBYQ8zIzZxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199015)(8936002)(6512007)(2616005)(186003)(4326008)(5660300002)(7416002)(26005)(6486002)(36756003)(478600001)(86362001)(38100700002)(316002)(6506007)(54906003)(6916009)(41300700001)(66946007)(66476007)(8676002)(66556008)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OE7+Mm4NoqWjOLu9+3uuQS/VqykzfeJQvg/VazN99mm4UJUUyzOKiuOJ4vtM?=
 =?us-ascii?Q?vHx1d+voCGssv+jkkMqS2JlxZM8fpDYQu3kfa5bhfka7o5qT7LyesMHRLgN2?=
 =?us-ascii?Q?caUTJMIETfsf/6QaeFweqeC71KjsYdNJ2ujiAw3G/lRAz7grdzd6SxR3AtUV?=
 =?us-ascii?Q?JE+eWE14llJn5J+I6FGn+MC3XIZM3vm4h8JqAkDL1rM487RM/qi6V/u9Tpvs?=
 =?us-ascii?Q?PfDqwMjwY7zJMq38uo9UNGNPv3uGAXA6qWmw3bZIFk4zh6vLAtGv7Cil7dxW?=
 =?us-ascii?Q?WMhlmAZPjlExV6e6BxyrFQ5h6ZuXsSteICVtgJcaH8WxmVJITGsegnqzd4PH?=
 =?us-ascii?Q?65VSKT9dw/oET/USEBVj/67x5/AhG5XKWYP2Sz9RD7cjtB7bssOuSAN5ZNPk?=
 =?us-ascii?Q?WJ7irSfS1ywik+NQi4qXbHXP+xNnws8FZpurPayqPnVwR8CqxMJLHEIAGVOb?=
 =?us-ascii?Q?He2eHvG2rS7wMy4+DHlwVv+a3ZUzidsyDXoWuXtFdox/quh8R7Qv7XmPJlr7?=
 =?us-ascii?Q?V52GJGtATQUZWTY3Wgp0r/o4heBH8pdS8x+Ed7U1Gv1kBLX+BcJCL4DI1rsf?=
 =?us-ascii?Q?ZULmfoFJXdNYFKWt6QQaSt+QUn/MgZSYVBtUnnvF+THMl8kdNUOOI5U2SO81?=
 =?us-ascii?Q?XwjJsDZ5G/h4Pb26ufrk55LuF7pozQwKD5oQXGCJd/moUoHNfyTc7qdWP1Nr?=
 =?us-ascii?Q?pf5XsfbvZ1uKEOTMEwMO21ZP6Er+9YTC0s1JE41vr1aEHkASMEc9kPbS10r8?=
 =?us-ascii?Q?DhueKsKzTAi7rIs2xr4woHVuA/oNdixUGHWCLPDIe+5+FCfkWyiyKJetGdxz?=
 =?us-ascii?Q?LygfBX6uFBxVxfhssSoofYuwus/5vgD7tpL+Z9AZthYkwkmbJ//vBwPKgoif?=
 =?us-ascii?Q?Cp0ropA7ICvGWKhNBgtPOHPk6/8xMh6YS80hg1VVATfcXPp9PIn8l8+sKZVF?=
 =?us-ascii?Q?rMyy2ZkCofUcAY/Qa7Q2vUWBBFlWIUQm2sswKxW358Q/Hce9FD1nsNUV+9Ed?=
 =?us-ascii?Q?n2tk1QCt95N+rwcdUTnIyM14B15v/9fZRr6UKvPdEjlq5MPTSqh9r7dJWfk8?=
 =?us-ascii?Q?TDaR04VAeOutzkLKLgm7KpvciGNECXdmiYwYK3Dy0i4V9Rt+LLFiymODR+Qx?=
 =?us-ascii?Q?2oOYQfWLWtYD1zRZhxDXMe+h+phgsJJefZDwoZd5g+qgV531rIKe4p4D7pyM?=
 =?us-ascii?Q?8vh1++hSsCsIlY2z7pPrEtObRE1/dJWcSQt7N3neTq4T+tFNvlj2ahHiHY59?=
 =?us-ascii?Q?A3G2NRc90fD30Tga1uQC0A0WRLMXGPcxFXniTBDZMSehiT8ZMDPH6FrLTLwI?=
 =?us-ascii?Q?OhJHdYH0gV3Xs2OZJOsKnyJ9CW3cRf1XZc477KaxbwdIDIEiG2/4HL9mgF0c?=
 =?us-ascii?Q?7fpKH6hpnOk7t985nqRgXAUu+bWQZfZWN3Zx/6mTtY2I2Z755hqO9Smtz5Uh?=
 =?us-ascii?Q?20h4ccqF/g9a10+cPkSx2uBSnn5j3EwgE2aB+g1M5c6jjNd7yg9s70Os8xYr?=
 =?us-ascii?Q?lx5AOyleFzQPVZfWFU4rvDxXqX3/ZkV+gfOohN0E0+8PsRSDMP66smMtvnfv?=
 =?us-ascii?Q?hzRwDP+Ej5JBhAPJqHU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4565895-a607-4b1e-2421-08dacc992ee7
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 14:52:31.6571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ja2JdKe48N4XR+iO0FRXVpgE+jUOaPhAuQb/3DZgEysT/CVQd4Qo1Ba3uXrccoWO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6109
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 16, 2022 at 04:19:50PM +0800, Li Zhijian wrote:
> It enables flushable access flag for qp
> 
> Reviewed-by: Zhu Yanjun <zyjzyj2000@gmail.com>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
> V5: new patch, inspired by Bob
> ---
>  drivers/infiniband/core/cm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
> index 1f9938a2c475..58837aac980b 100644
> --- a/drivers/infiniband/core/cm.c
> +++ b/drivers/infiniband/core/cm.c
> @@ -4096,7 +4096,8 @@ static int cm_init_qp_init_attr(struct cm_id_private *cm_id_priv,
>  		qp_attr->qp_access_flags = IB_ACCESS_REMOTE_WRITE;
>  		if (cm_id_priv->responder_resources)
>  			qp_attr->qp_access_flags |= IB_ACCESS_REMOTE_READ |
> -						    IB_ACCESS_REMOTE_ATOMIC;
> +						    IB_ACCESS_REMOTE_ATOMIC |
> +						    IB_ACCESS_FLUSHABLE;

What is the point of this? Nothing checks IB_ACCESS_FLUSHABLE ?

Do flush ops require a responder resource?

Why should CM set it unconditionally?

Explain in the commit message

Jason
