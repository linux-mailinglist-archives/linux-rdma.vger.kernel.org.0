Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386DD4E275F
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Mar 2022 14:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345828AbiCUNUX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Mar 2022 09:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347817AbiCUNUW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Mar 2022 09:20:22 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0422FFF7
        for <linux-rdma@vger.kernel.org>; Mon, 21 Mar 2022 06:18:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QnkAqp7hs6gPo279lsEFJR+drUeG5BkZQSVOLmyskHjOTCoovq/7FsGgSqb3xIw8MZUUDziPqHqFe76VdPCS58Ft0/K2D8Uik/vLlRh2DHQonCTpfc9JjOrpPy5+XXypfI9nbKYXs0rQrVjcnqO3rC97y0LgQlrXVdz9Fy8kh+R0Z4QE347m6hWJk5YIXhmyHK0WT5BnI5dwMYyZ4rpS8zNO4qjiGDjQ0Z1LQ7GoB8SiLdslsBFL04lx1No+7myqpS7mwDAq7f9yDlw7cNqE2BqvMPuM1Gc5Qh2sKH9IXkNn/AlUdGuSuoPoymPpqkby2PZ8qogXIKLwveoOzUt9FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oual/LrZV0LG1kMNk2aRSGf6pcl34Y6Wn44UW/JDB0k=;
 b=RsfiB2FTBxP2Pg117Yh87Wk3BglbNzLds7up0jczFSG0TtKZFNPJdEbrlff4IhNyGJWjg2pzEANlGu9almxeQRl94+R7TDYzleSIu/CBPJUREaByD8zZYyuCasupUeS0OHxwWt/jhXhxcETbv1VgCdcO2sUi4+/iL0rmnUI3rDcYDeCsMC/yPb0XFzb+jlluV8tutZo7lvU+oOiwRWJFIzwG/yoW5c73s/7s+zC8sQVutGk8nVkMCB3tu/zUsix/FAR9nFBypxTkC4Hb9A+6oo1hFOUhsnpfuF0qDRexsoYgyOeQ/21bPh7LHGOAQKp20EzfJC5/xkOnlqXd5fOuow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oual/LrZV0LG1kMNk2aRSGf6pcl34Y6Wn44UW/JDB0k=;
 b=GvYvOBZFWcjnREt8cHvFzzJmoyoCHWfl0ej0KZw8tC9NWPJYbpW6JYvR1nj/EKFf7lY5P6RBlwkAxDvJxjR6zO56xXmA3wJoOU2N0pkJqIhK7AtDWZKwDmjtYxLuESctOsKkR2jNDXH45z8PC1hPo44OGTmavpaQXD/QaWszpAzQe7FpcxBALbrbDUMLntGLAkmqnbTy7E3mKqJYjTs7wkxFAhLGXDWOK5RWtz9DVXelHLaAhYb9UCarJWeeD7RuZDh6JwwdbWOA3/dDgf+S+ScQUs0zIAd2VnkX63dTFNt1HP0Od4MYdmjskXLGFRFhNy5mp2Dn2QUrSzOF3NluJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB3260.namprd12.prod.outlook.com (2603:10b6:5:183::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Mon, 21 Mar
 2022 13:18:54 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c%5]) with mapi id 15.20.5081.023; Mon, 21 Mar 2022
 13:18:54 +0000
Date:   Mon, 21 Mar 2022 10:18:53 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Xiao Yang <yangx.jy@fujitsu.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 2/2] IB/uverbs: Move part of enum ib_device_cap_flags to
 uapi
Message-ID: <20220321131853.GS11336@nvidia.com>
References: <20220319170351.336731-1-yangx.jy@fujitsu.com>
 <20220319170351.336731-2-yangx.jy@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220319170351.336731-2-yangx.jy@fujitsu.com>
X-ClientProxiedBy: MN2PR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:208:160::25) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f78442a-3fce-4f58-4d95-08da0b3d5957
X-MS-TrafficTypeDiagnostic: DM6PR12MB3260:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3260F3BBE69A298E09AF1589C2169@DM6PR12MB3260.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R92ZA35vDRaz3cNpZRPubJEmPPLlfuMuFJFlJpNxPiyYiCZYK1CzavrBr2jrnlMLNnRkxgfuhW4iIfrZiKOTDmd6fR5XQy6HHDVCBoIthytfjee77Eubhl6Qd1ddYMN/xjazZxCkxXcG9MItbDlPKTPbRVrOxuW5kRy85qf96Xm138Ck5OYccqx+y+J7GUYRAvOz4QamW/WLKGkvgj4yOyd3+o9VSetLx7qDadxnwEGQh40WdsS3ZdKUVoqbMoVFBV8bR/OZPigRimcaYhshE8rYdtNYseNhGZJ9meyS7ceh0wsAXYfYGjXZay1mqZN+OmWCWsfHHjLfL77qgFi1rQWH55RFGDDPg0XI+LZEDNzAaOr9Zd0rZfamgJ01cLefMxAJTVLDyf5/FuM3r29ony+pDX8gWCfc46vD3bwHQkriqnWH4SlOzHOzp3gMjahwId07VQpuEWV0dBK5syD8QvbQLX300xETQ+4Wt8AC8p8ODyH2ZLTrVY+y4O1CVwOfWrs8Np55DhL/36+UbljHtUk7hvExuE46qmNK4XPYygJqK9DgYlL+7xK1/lqkPMAcxH8dHyZacrXq5NYpsQS01NG3gHuqYo3Smr4XOh+K9sslnfFhpA8ShtFCImVl9jBtVOihA/Bll1Ulee55K8mSjm2UgMwbvkCVkd+kByu1M/1PXMG7f1+VQKXNHucdNdMY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(66556008)(83380400001)(6506007)(6512007)(36756003)(66946007)(1076003)(186003)(66476007)(8676002)(6916009)(4326008)(26005)(2616005)(316002)(8936002)(6486002)(508600001)(38100700002)(33656002)(86362001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4sm49G8az5RHlBx90fx+nHwOUNIWkRMyb0TBm6VSCB5iH8SqJeOv/TTPIyER?=
 =?us-ascii?Q?RGzwvgL43dW3gZWQ/C5E0loF+ExwJsouHtj6FoMu+fHqPiDjPJqAK+dBoDky?=
 =?us-ascii?Q?JI8DbtMPo7AfRvUXhfLrmP71pp8x3jviH5fuy3RTW/4peSHERlTnSa5VhTwz?=
 =?us-ascii?Q?7FsPGcqOoHKCG8anhzKx7AeIbokpvLRJr49r3QwW4joEaXMybgPzbLgD4ti3?=
 =?us-ascii?Q?7Vo8deJ21LUoH0srj/Yvvc+4ICwNa8eu4nz84rqcaludtbkk6KMQRXxNlz1+?=
 =?us-ascii?Q?se+tIcbB9EK7HzswMIDRk/v9WQ3Tnb5uU4CTAPJ1guQBcsSiG9WZGucC8UGZ?=
 =?us-ascii?Q?LnDQiAxW9bGlNUUuDeibev6d7pJlpKTQxpjIPaWM7YGI0ryVesexboSBN3gQ?=
 =?us-ascii?Q?VzKm4iTtOZodO14enjTzRItS3HX2uNWqS0+ryLZUAeQKnaLMAoyOHBLKaioT?=
 =?us-ascii?Q?c+5MPKgr/gHMai+YjWS5SSd/BoH26+Swq0f8ZjxwlGc4GtkWMixpyl1mKXla?=
 =?us-ascii?Q?A/2o9HeyPrzB6XcASiNyd+Ogwm9T04FNgXxQnx/qBAqzvBkOI3dBjAlEGD1Y?=
 =?us-ascii?Q?blOnJ1bE40XMXNny5AkJcButht9XHeI0A0Rb/AP9MjpQtQQIP0L9IEINS3vS?=
 =?us-ascii?Q?hrN+TtMKyRvuxZSf37hGmRWKn8f6Z10fM1vd5nuMhlGEpfKkp3Y4WkLLUwBk?=
 =?us-ascii?Q?NQmBHTsqcSZ2EoTDf0Z7ydbo3vksJ/Ldq5N4MvBAawFEA3nMLDml5XncMJwc?=
 =?us-ascii?Q?jQeCUeqhTIdJFOw8pBfzuWd+MHvTCGGs2S4hA0rwlhSbqCtPPmKIfktZ760n?=
 =?us-ascii?Q?6YgOdVroHNoMH0C2Q6oGsn0GTo8MdpV4vmE9NFIYHDUXB5yxxmXjXY9pubOj?=
 =?us-ascii?Q?pYMoYFU64DMpVp/Yz1QctpmqFMwAPszBy3Xum7GGoYS8wK+VE5DIt5ACJ9G8?=
 =?us-ascii?Q?AQN9WSXK24JI4jzSTEKWE1rNChos+ApIJkxXKi/SLGXWJLhbCeaKKEFWD/xx?=
 =?us-ascii?Q?kXcDozK6UrjWgPVszT7nZKcvTleJ6ksvIxCyGMMy23hLATQ/0zgftVrBUyt/?=
 =?us-ascii?Q?q6XvOMDt/U5cqRWjglbhP/Hq7fMK5n4r2R8dT8lYhwLRyXAd4Db6CqYS5iKM?=
 =?us-ascii?Q?AJjVX1W9qsVNwYqCg5YLuQ3GGwDc6bBfa/HVHrqfcCBfrDtwFvoZBijhw8Uc?=
 =?us-ascii?Q?TLt5H+LbJwr2HWJy372vCuStYGmjdKOVSRNqsdiqJ7vtsWjKqop3yelqKMsz?=
 =?us-ascii?Q?AhoQIt236lhl6bXqn5AnVgt5Rfr+GgrUORhUoxu/8egD24sWRnrECModQt5p?=
 =?us-ascii?Q?i4be/WSbcWo94oodDTYUJJvzqC4tgj3TsFh4ixAcKxdYAVGGpPLx5NFXbHep?=
 =?us-ascii?Q?dNcBGDHso22OrmxmUFRWPy1TKGS/sCp7zYWoSGjDloJA2/WOSU6HlOPVfjAV?=
 =?us-ascii?Q?kEdzfKON+9opPtFxHkRGvWI+iKaELDW8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f78442a-3fce-4f58-4d95-08da0b3d5957
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 13:18:54.7713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vlBu5iwMubDGNT+XSGz0zrFsXWTNDbf6s1cfg5jJb2gfx1ldHZUPKBxQU7iBsvg+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3260
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Mar 20, 2022 at 01:03:51AM +0800, Xiao Yang wrote:
> Part of enum ib_device_cap_flags are used by ibv_query_device(3)
> or ibv_query_device_ex(3), so we define them in
> include/uapi/rdma/ib_user_verbs.h and only expose them to userspace.
> 
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
>  drivers/infiniband/core/uverbs_cmd.c |  6 +-
>  include/rdma/ib_verbs.h              | 82 +++++++++++++++++++---------
>  include/uapi/rdma/ib_user_verbs.h    | 31 +++++++++++
>  3 files changed, 91 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
> index 6b6393176b3c..ca1045c28fad 100644
> +++ b/drivers/infiniband/core/uverbs_cmd.c
> @@ -337,7 +337,8 @@ static void copy_query_dev_fields(struct ib_ucontext *ucontext,
>  	resp->hw_ver		= attr->hw_ver;
>  	resp->max_qp		= attr->max_qp;
>  	resp->max_qp_wr		= attr->max_qp_wr;
> -	resp->device_cap_flags	= lower_32_bits(attr->device_cap_flags);
> +	resp->device_cap_flags	= lower_32_bits(attr->device_cap_flags &
> +		UVERBS_DEVICE_CAP_FLAGS_MASK);
>  	resp->max_sge		= min(attr->max_send_sge, attr->max_recv_sge);
>  	resp->max_sge_rd	= attr->max_sge_rd;
>  	resp->max_cq		= attr->max_cq;
> @@ -3618,7 +3619,8 @@ static int ib_uverbs_ex_query_device(struct uverbs_attr_bundle *attrs)
>  
>  	resp.timestamp_mask = attr.timestamp_mask;
>  	resp.hca_core_clock = attr.hca_core_clock;
> -	resp.device_cap_flags_ex = attr.device_cap_flags;
> +	resp.device_cap_flags_ex = attr.device_cap_flags &
> +		UVERBS_DEVICE_CAP_FLAGS_MASK;
>  	resp.rss_caps.supported_qpts = attr.rss_caps.supported_qpts;
>  	resp.rss_caps.max_rwq_indirection_tables =
>  		attr.rss_caps.max_rwq_indirection_tables;
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index e5455f6e0d82..54f0045942ca 100644
> +++ b/include/rdma/ib_verbs.h
> @@ -219,22 +219,41 @@ enum rdma_link_layer {
>  	IB_LINK_LAYER_ETHERNET,
>  };
>  
> +#define UVERBS_DEVICE_CAP_FLAGS_MASK	0x1427B67FFF

This needs to be expressed as a | of constants

>  enum ib_device_cap_flags {
> -	IB_DEVICE_RESIZE_MAX_WR			= (1 << 0),
> -	IB_DEVICE_BAD_PKEY_CNTR			= (1 << 1),
> -	IB_DEVICE_BAD_QKEY_CNTR			= (1 << 2),
> -	IB_DEVICE_RAW_MULTI			= (1 << 3),
> -	IB_DEVICE_AUTO_PATH_MIG			= (1 << 4),
> -	IB_DEVICE_CHANGE_PHY_PORT		= (1 << 5),
> -	IB_DEVICE_UD_AV_PORT_ENFORCE		= (1 << 6),
> -	IB_DEVICE_CURR_QP_STATE_MOD		= (1 << 7),
> -	IB_DEVICE_SHUTDOWN_PORT			= (1 << 8),
> -	/* Not in use, former INIT_TYPE		= (1 << 9),*/
> -	IB_DEVICE_PORT_ACTIVE_EVENT		= (1 << 10),
> -	IB_DEVICE_SYS_IMAGE_GUID		= (1 << 11),
> -	IB_DEVICE_RC_RNR_NAK_GEN		= (1 << 12),
> -	IB_DEVICE_SRQ_RESIZE			= (1 << 13),
> -	IB_DEVICE_N_NOTIFY_CQ			= (1 << 14),
> +	IB_DEVICE_RESIZE_MAX_WR			=
> +		IB_UVERBS_DEVICE_RESIZE_MAX_WR,
> +	IB_DEVICE_BAD_PKEY_CNTR			=
> +		IB_UVERBS_DEVICE_BAD_PKEY_CNTR,
> +	IB_DEVICE_BAD_QKEY_CNTR			=
> +		IB_UVERBS_DEVICE_BAD_QKEY_CNTR,
> +	IB_DEVICE_RAW_MULTI			=
> +		IB_UVERBS_DEVICE_RAW_MULTI,
> +	IB_DEVICE_AUTO_PATH_MIG			=
> +		IB_UVERBS_DEVICE_AUTO_PATH_MIG,
> +	IB_DEVICE_CHANGE_PHY_PORT		=
> +		IB_UVERBS_DEVICE_CHANGE_PHY_PORT,
> +	IB_DEVICE_UD_AV_PORT_ENFORCE		=
> +		IB_UVERBS_DEVICE_UD_AV_PORT_ENFORCE,
> +	IB_DEVICE_CURR_QP_STATE_MOD		=
> +		IB_UVERBS_DEVICE_CURR_QP_STATE_MOD,
> +	IB_DEVICE_SHUTDOWN_PORT			=
> +		IB_UVERBS_DEVICE_SHUTDOWN_PORT,
> +	/*
> +	 * IB_DEVICE_INIT_TYPE			=
> +	 * 	IB_UVERBS_DEVICE_INIT_TYPE, (not in use)
> +	 */
> +	IB_DEVICE_PORT_ACTIVE_EVENT		=
> +		IB_UVERBS_DEVICE_PORT_ACTIVE_EVENT,
> +	IB_DEVICE_SYS_IMAGE_GUID		=
> +		IB_UVERBS_DEVICE_SYS_IMAGE_GUID,
> +	IB_DEVICE_RC_RNR_NAK_GEN		=
> +		IB_UVERBS_DEVICE_RC_RNR_NAK_GEN,
> +	IB_DEVICE_SRQ_RESIZE			=
> +		IB_UVERBS_DEVICE_SRQ_RESIZE,
> +	IB_DEVICE_N_NOTIFY_CQ			=
> +		IB_UVERBS_DEVICE_N_NOTIFY_CQ,
>  
>  	/*
>  	 * This device supports a per-device lkey or stag that can be
> @@ -245,7 +264,8 @@ enum ib_device_cap_flags {
>  	 */
>  	IB_DEVICE_LOCAL_DMA_LKEY		= (1 << 15),
>  	/* Reserved, old SEND_W_INV		= (1 << 16),*/
> -	IB_DEVICE_MEM_WINDOW			= (1 << 17),
> +	IB_DEVICE_MEM_WINDOW			=
> +		IB_UVERBS_DEVICE_MEM_WINDOW,
>  	/*
>  	 * Devices should set IB_DEVICE_UD_IP_SUM if they support
>  	 * insertion of UDP and TCP checksum on outgoing UD IPoIB
> @@ -253,9 +273,11 @@ enum ib_device_cap_flags {
>  	 * incoming messages.  Setting this flag implies that the
>  	 * IPoIB driver may set NETIF_F_IP_CSUM for datagram mode.
>  	 */
> -	IB_DEVICE_UD_IP_CSUM			= (1 << 18),
> +	IB_DEVICE_UD_IP_CSUM			=
> +		IB_UVERBS_DEVICE_UD_IP_CSUM,
>  	IB_DEVICE_UD_TSO			= (1 << 19),
> -	IB_DEVICE_XRC				= (1 << 20),
> +	IB_DEVICE_XRC				=
> +		IB_UVERBS_DEVICE_XRC,
>  
>  	/*
>  	 * This device supports the IB "base memory management extension",
> @@ -266,13 +288,18 @@ enum ib_device_cap_flags {
>  	 * IB_WR_RDMA_READ_WITH_INV verb for RDMA READs that invalidate the
>  	 * stag.
>  	 */
> -	IB_DEVICE_MEM_MGT_EXTENSIONS		= (1 << 21),
> +	IB_DEVICE_MEM_MGT_EXTENSIONS		=
> +		IB_UVERBS_DEVICE_MEM_MGT_EXTENSIONS,
>  	IB_DEVICE_BLOCK_MULTICAST_LOOPBACK	= (1 << 22),
> -	IB_DEVICE_MEM_WINDOW_TYPE_2A		= (1 << 23),
> -	IB_DEVICE_MEM_WINDOW_TYPE_2B		= (1 << 24),
> -	IB_DEVICE_RC_IP_CSUM			= (1 << 25),
> +	IB_DEVICE_MEM_WINDOW_TYPE_2A		=
> +		IB_UVERBS_DEVICE_MEM_WINDOW_TYPE_2A,
> +	IB_DEVICE_MEM_WINDOW_TYPE_2B		=
> +		IB_UVERBS_DEVICE_MEM_WINDOW_TYPE_2B,
> +	IB_DEVICE_RC_IP_CSUM			=
> +		IB_UVERBS_DEVICE_RC_IP_CSUM,
>  	/* Deprecated. Please use IB_RAW_PACKET_CAP_IP_CSUM. */
> -	IB_DEVICE_RAW_IP_CSUM			= (1 << 26),
> +	IB_DEVICE_RAW_IP_CSUM			=
> +		IB_UVERBS_DEVICE_RAW_IP_CSUM,
>  	/*
>  	 * Devices should set IB_DEVICE_CROSS_CHANNEL if they
>  	 * support execution of WQEs that involve synchronization
> @@ -280,16 +307,19 @@ enum ib_device_cap_flags {
>  	 * by hardware.
>  	 */
>  	IB_DEVICE_CROSS_CHANNEL			= (1 << 27),
> -	IB_DEVICE_MANAGED_FLOW_STEERING		= (1 << 29),
> +	IB_DEVICE_MANAGED_FLOW_STEERING		=
> +		IB_UVERBS_DEVICE_MANAGED_FLOW_STEERING,
>  	IB_DEVICE_INTEGRITY_HANDOVER		= (1 << 30),
>  	IB_DEVICE_ON_DEMAND_PAGING		= (1ULL << 31),
>  	IB_DEVICE_SG_GAPS_REG			= (1ULL << 32),
>  	IB_DEVICE_VIRTUAL_FUNCTION		= (1ULL << 33),
>  	/* Deprecated. Please use IB_RAW_PACKET_CAP_SCATTER_FCS. */
> -	IB_DEVICE_RAW_SCATTER_FCS		= (1ULL << 34),
> +	IB_DEVICE_RAW_SCATTER_FCS		=
> +		IB_UVERBS_DEVICE_RAW_SCATTER_FCS,
>  	IB_DEVICE_RDMA_NETDEV_OPA		= (1ULL << 35),
>  	/* The device supports padding incoming writes to cacheline. */
> -	IB_DEVICE_PCI_WRITE_END_PADDING		= (1ULL << 36),
> +	IB_DEVICE_PCI_WRITE_END_PADDING		=
> +		IB_UVERBS_DEVICE_PCI_WRITE_END_PADDING,
>  	IB_DEVICE_ALLOW_USER_UNREG		= (1ULL << 37),
>  };

This should be reformatted, no reason to have a = indented way out
like that

> +enum ib_uverbs_device_cap_flags {
> +	IB_UVERBS_DEVICE_RESIZE_MAX_WR		= (1 << 0),
> +	IB_UVERBS_DEVICE_BAD_PKEY_CNTR		= (1 << 1),
> +	IB_UVERBS_DEVICE_BAD_QKEY_CNTR		= (1 << 2),
> +	IB_UVERBS_DEVICE_RAW_MULTI		= (1 << 3),
> +	IB_UVERBS_DEVICE_AUTO_PATH_MIG		= (1 << 4),
> +	IB_UVERBS_DEVICE_CHANGE_PHY_PORT	= (1 << 5),
> +	IB_UVERBS_DEVICE_UD_AV_PORT_ENFORCE	= (1 << 6),
> +	IB_UVERBS_DEVICE_CURR_QP_STATE_MOD	= (1 << 7),
> +	IB_UVERBS_DEVICE_SHUTDOWN_PORT		= (1 << 8),
> +	/* IB_UVERBS_DEVICE_INIT_TYPE		= (1 << 9), (not in use) */
> +	IB_UVERBS_DEVICE_PORT_ACTIVE_EVENT	= (1 << 10),
> +	IB_UVERBS_DEVICE_SYS_IMAGE_GUID		= (1 << 11),
> +	IB_UVERBS_DEVICE_RC_RNR_NAK_GEN		= (1 << 12),
> +	IB_UVERBS_DEVICE_SRQ_RESIZE		= (1 << 13),
> +	IB_UVERBS_DEVICE_N_NOTIFY_CQ		= (1 << 14),
> +	IB_UVERBS_DEVICE_MEM_WINDOW		= (1 << 17),
> +	IB_UVERBS_DEVICE_UD_IP_CSUM		= (1 << 18),
> +	IB_UVERBS_DEVICE_XRC			= (1 << 20),
> +	IB_UVERBS_DEVICE_MEM_MGT_EXTENSIONS	= (1 << 21),
> +	IB_UVERBS_DEVICE_MEM_WINDOW_TYPE_2A	= (1 << 23),
> +	IB_UVERBS_DEVICE_MEM_WINDOW_TYPE_2B	= (1 << 24),
> +	IB_UVERBS_DEVICE_RC_IP_CSUM		= (1 << 25),
> +	/* Deprecated. Please use IB_UVERBS_RAW_PACKET_CAP_IP_CSUM. */
> +	IB_UVERBS_DEVICE_RAW_IP_CSUM		= (1 << 26),
> +	IB_UVERBS_DEVICE_MANAGED_FLOW_STEERING	= (1 << 29),
> +	/* Deprecated. Please use IB_UVERBS_RAW_PACKET_CAP_SCATTER_FCS. */
> +	IB_UVERBS_DEVICE_RAW_SCATTER_FCS	= (1ULL << 34),
> +	IB_UVERBS_DEVICE_PCI_WRITE_END_PADDING	= (1ULL << 36),
> +};

Also please drop the horizontal alignment for new code

> +
>  enum ib_uverbs_raw_packet_caps {
>  	IB_UVERBS_RAW_PACKET_CAP_CVLAN_STRIPPING	= (1 << 0),
>  	IB_UVERBS_RAW_PACKET_CAP_SCATTER_FCS		= (1 << 1),
