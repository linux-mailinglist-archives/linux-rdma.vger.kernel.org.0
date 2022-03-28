Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59664E9723
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Mar 2022 14:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241018AbiC1M5Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Mar 2022 08:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234432AbiC1M5X (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Mar 2022 08:57:23 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA4634B9F
        for <linux-rdma@vger.kernel.org>; Mon, 28 Mar 2022 05:55:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M7D0sJDb2C709n4N1Gful0njwmtZaZCUQYUkxTLNq3+Dkqym/Pn+/K+30GIsUfXcNXyBlhdrlTLrgvCmWNeO2sg6F8wJRXgRv6BZVC+YCMNVuLAJICUU/qSOvTBvMBXkcpFA8DjofFL3yF9dF8PULYBNIk6Y6Ic8LYrHO2hjnD90TlEi83pkm3C5EqktuVPYN4B9sfQ+G9Fech/FZvOx5/WhBjpMhICapm05sA9FTv222gsgxH5oQerG3Uk1SREdKOkzmz0ZAxngqFKituEUdlPxg3x3EFPkIBEzsaM/emiv+0Rh6CYhaCb+wBkI+BqKHQ1IV4QzIDDAzXpr8+U/ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVFIadjWMd7uSlwSlKqK3o6JXgzXJl7TJ8FQwJ2flM4=;
 b=bsNUxkK63uUxPF2df0bhuwJvBK8pc2DGXMX8KsctOhJsZdFOf1T8zC8Zd+jTlePMTeeyZcQVX2+/FzZeVMAScWuqis67TX+ymVOu1CzHkt6LI8pGs/219dJvpsP8HlPMUQZyFAeQih12zie0UJoUq8RZnixM3x3J1f1I+6yq8cfb/wQgJExZhX0m2/ZEhulmdpA3f2T5vCkA9Pg2/PVFY+L4T2q3plzs9a8WSK+dDlHpfuvxUHIu1Jiuazf1DD1brSHicIVrrhnSyjH3s/8FqPav0zT13eL3kYK8u3hT8SH/65KxYhw2CMvT7j9vHvvRHlr6jrBWdVX1JgsY/77Usg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVFIadjWMd7uSlwSlKqK3o6JXgzXJl7TJ8FQwJ2flM4=;
 b=MF2NFJzmmLi6cFyYNxmXGoK6Bn5vXRyo1wv6AR9iOhxA7r314O14O4saxaqnf7CFFWX85H95ZMkz8WkKHhINpAC/BJ28sIR+6m5RG8hhwOqUjAFhAh4zXsnvQnt1sqDXFzFJ/dGFURw6wa6Ha7PfI8u/MKhjzXlYQvQickpZNOAuHRyiKteyguvkdtVUt+kfdxtGFx+JejuI6NnB1qeCkj/A1/I1jwZVYzQbFv2f0QffLoZySn/G+OG7dhnFi32cUJQeEnHN4utXe2wTjpN9fq2YgbTBktanpW6pOhJ9JIE53KPUUKkWqUq1Hi0RM2I97qe+uC+o7t3cTjjg+SCoUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BL0PR12MB2433.namprd12.prod.outlook.com (2603:10b6:207:4a::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Mon, 28 Mar
 2022 12:55:41 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c%6]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 12:55:41 +0000
Date:   Mon, 28 Mar 2022 09:55:39 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Xiao Yang <yangx.jy@fujitsu.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 2/2] IB/uverbs: Move part of enum ib_device_cap_flags
 to uapi
Message-ID: <20220328125539.GN1342626@nvidia.com>
References: <20220322033002.496195-1-yangx.jy@fujitsu.com>
 <20220322033002.496195-2-yangx.jy@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322033002.496195-2-yangx.jy@fujitsu.com>
X-ClientProxiedBy: BL1PR13CA0288.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::23) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45d0798e-b237-4da3-e089-08da10ba4393
X-MS-TrafficTypeDiagnostic: BL0PR12MB2433:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB24332BC7A77A9A916C497DE8C21D9@BL0PR12MB2433.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3ZJB7dF0Ehk+ZVmEQVUsydXCa18M4q/j5byg9PhQ6kjHKQQDsoHkwEF2rxTK20rqNpVbB1WAorl3YHwTksFasPuLj4GqjlFSGApVJsZiCImp+AMGCz2Tv6xoT8uj21sc7+Qp1/K5T+4wPZV4d4FBv36t7SYBcIHjEfk0eCVQObxvAjqrcf4EfN+0j8rCLgPh/Oq2fCdVOsNrDQiBsgnLmb+1dS4WOO+5HTAxqsEQyMPXO4CLyhZRHEbaOafepA1FOs5z0Y8PMpT4IRBSzS+0vf6JPV+mObkl8yweiLZ6MHcZJWqQ7AB+YGISEt3fcUUUaUOZDq2XsoHrYvxQxtbOa9wkZIEVeKPcFgx0dQMlUqjAUmvUTUOG1DU1sU1g6VjjdyyKvd56PfPn34BRj/kI6AjE6McAER25Cg67QtNRTdy4LEZ7I16JWsyIXQYsGgzJNntPCzUT+eNyU1Q1zyyjTtSF70I0OKiK34X7eLk5YGDFEcyE112dtCm0CqHgZdCSWrdv0MH7e21E6jf9zSjcVQjTJTEjir62Wpve2YRV+u+dn8xWGXwCpuObkXW5I88fpPXJOAJonqSQOoSb14/Av/24UV5uR583kv9RlNgHq2igT7feSzjHUl8Be3HbpAe9myuBmYwgFW0eQICx0qw/rQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(5660300002)(508600001)(2906002)(8936002)(6916009)(36756003)(316002)(86362001)(6512007)(83380400001)(26005)(186003)(1076003)(2616005)(38100700002)(6506007)(66476007)(66556008)(4326008)(66946007)(8676002)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IdV6eqZ6pffrubhHkyXl/cyS+u6eCfYNcdQduv1InB3KOYA15+7qaqTOYBfU?=
 =?us-ascii?Q?jixAWWS8rhkkEIGcj0w/m2gT6vBWOPlNJ8J/QdlrqfLVpyUn+3w3d0jUTt7q?=
 =?us-ascii?Q?FYN+ObtWJ39t9i5V8Pd/JuDNAjtTP9xGDIdyZeStBT0+XIMjh+1R2xzhwtws?=
 =?us-ascii?Q?98hx/QxxO+3ulmBdc6IxeoGkLC+SseRBwUlROuSqiri+HxTK/sIiFu+ZD+sT?=
 =?us-ascii?Q?AkA1Kd1n9U7jSy80S5o7ikqpZXOcr1Auinit8zgK7AyDRVuIC0LJji/NdvZO?=
 =?us-ascii?Q?wJT9Y8/OLRVOGFwUmrsw7ILAIfKnAuUkJqLH2oISJbSZcSm4NiTXV1LVVaV2?=
 =?us-ascii?Q?d3l3jjapkOJVz1wFsAVpRO/mBqwdk42JIVSk1Pin/eMUGIio13zbmr0VUiLH?=
 =?us-ascii?Q?oupPNpTh1r16ri+4o2p+MH3EqW/mAm4s4Os50kvp4ZoEN9/zHXEWOxcWIlse?=
 =?us-ascii?Q?89zpfUQAqL88ZoBSEv4hdxWCZDCbdlssOmVlWh11r+6fvsrO6cBCHpAevg34?=
 =?us-ascii?Q?b07cNq54DMmdbBrEkVnrX3bZBNLtkhnUm94L4ZgqiSt3im4wUKLT3OlZCw39?=
 =?us-ascii?Q?0CxY3AakoDA+SILjQpwiQu8bYs9Oz8Hze6m22tOWC1/PKLMRah2ilobGP7GT?=
 =?us-ascii?Q?abHRmG7Wc/Pq83sUrkvE5EBgs5rlP0ZHoMsbPv6iA6njnjKMwj5ZpJumGKkU?=
 =?us-ascii?Q?fE0opK56oeUSOGmPree1kFcAbna63ZflFWv9PVKYBu5FhXk+czL7RF2YrK6j?=
 =?us-ascii?Q?BmwfU0lz3+2n6f1IhIDT77WTx86Vnr9l8v6EReDYisKOdWUa9K52XVCYpgdX?=
 =?us-ascii?Q?Ijs6ixRSCQQrr2sN8bF4vnjkBqc0w6TadG948GWeBOfDzg+hpId7AvG677Vk?=
 =?us-ascii?Q?N700v0j9OgVW367Ci1FROLbyh1zkp6mR4rf9T2B6rD4Mz2hEfUOJ7o61imTu?=
 =?us-ascii?Q?WW+WoiYMM9viBUVzgsAGcfdNMOrIF/6AswIyDfNv8YEUJ7fyhcPYk0SsCaX0?=
 =?us-ascii?Q?r7teiT3gMDRAv2NmPtbUC1RZt0x0mgYXrWZKy6i7OHAymNldR1ym9f/CbCpM?=
 =?us-ascii?Q?aV8wCBcFctl5hSW6f+IHeRQGgDC21wVoZ7CmZU8zLEWOIOSEO/563FgBui5B?=
 =?us-ascii?Q?NfETCUFXrdjrZMAS4B8s9d855bxMO9VRNpxwz5UMjhHqO/Kf6kjb8nNydBV2?=
 =?us-ascii?Q?t3WXgOavEodXR9fJDZaGycYQ6wuYmlQ6JZgdVnw4b+tBndf36SCydyDFQp9l?=
 =?us-ascii?Q?eb2QMep6Et//CQQ5TKipMPm4aiA/j58gY1egXwWZ+VeWmEvMz9RkGrZ0ionD?=
 =?us-ascii?Q?nLMSykudqNA0DDRLKkCnzb9h2klebpVPcfHH70Hk6ZDtEhNXzTiQdCI5Q0Zf?=
 =?us-ascii?Q?Wyv0YngizMGEtbgYX9LdJ58Jm5mX2pItmEwK1qcYikisTec4b5GZromXOPrs?=
 =?us-ascii?Q?AFa+sgTdzdzta5Q0ZDWLIAB6E9Vg/17GIOqvXuCSkZ8wfJVerW2MBU07479l?=
 =?us-ascii?Q?hZ35MSlnSOBlv8ZVl5sqsiz0N9cCRoJRbBzsDh9KDqCrA76J2dOP3mWb87h/?=
 =?us-ascii?Q?uu+fpHwYp+HFKHGaignJ/Pw7TMZZ3mPsM8liDnKk9DkirI+vGEZ26zza+NY/?=
 =?us-ascii?Q?R0fmKivrTYl71Z0UNfyxK9D0XSvnM9E18KhL5iWEvicREOBeRIF/ImFnVeID?=
 =?us-ascii?Q?eeq3KGYX3G0FJKKFQ5ma5EaX4nu+3btABHxFFAQWu/8AismfDpvsAsOR7JeO?=
 =?us-ascii?Q?Hm0cY29hxA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45d0798e-b237-4da3-e089-08da10ba4393
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 12:55:41.2572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d1OWZsM5t4LdnprUcXsFhwt+SwxQV6pbJqEp+Jk1P5SULNWcUZ+dlLZ1k/KRTPuY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2433
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 22, 2022 at 11:30:02AM +0800, Xiao Yang wrote:
> 1)Part of enum ib_device_cap_flags are used by ibv_query_device(3)
>   or ibv_query_device_ex(3), so we define them in
>   include/uapi/rdma/ib_user_verbs.h and only expose them to userspace.
> 
> 2)Reformat enum ib_device_cap_flags by removing the indent before '='.
> 
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
>  drivers/infiniband/core/uverbs_cmd.c |  6 ++-
>  include/rdma/ib_verbs.h              | 76 ++++++++++++++--------------
>  include/uapi/rdma/ib_user_verbs.h    | 57 +++++++++++++++++++++
>  3 files changed, 100 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
> index 6b6393176b3c..a1978a6f8e0c 100644
> +++ b/drivers/infiniband/core/uverbs_cmd.c
> @@ -337,7 +337,8 @@ static void copy_query_dev_fields(struct ib_ucontext *ucontext,
>  	resp->hw_ver		= attr->hw_ver;
>  	resp->max_qp		= attr->max_qp;
>  	resp->max_qp_wr		= attr->max_qp_wr;
> -	resp->device_cap_flags	= lower_32_bits(attr->device_cap_flags);
> +	resp->device_cap_flags	= lower_32_bits(attr->device_cap_flags &
> +		IB_UVERBS_DEVICE_CAP_FLAGS_MASK);
>  	resp->max_sge		= min(attr->max_send_sge, attr->max_recv_sge);
>  	resp->max_sge_rd	= attr->max_sge_rd;
>  	resp->max_cq		= attr->max_cq;
> @@ -3618,7 +3619,8 @@ static int ib_uverbs_ex_query_device(struct uverbs_attr_bundle *attrs)
>  
>  	resp.timestamp_mask = attr.timestamp_mask;
>  	resp.hca_core_clock = attr.hca_core_clock;
> -	resp.device_cap_flags_ex = attr.device_cap_flags;
> +	resp.device_cap_flags_ex = attr.device_cap_flags &
> +		IB_UVERBS_DEVICE_CAP_FLAGS_MASK;
>  	resp.rss_caps.supported_qpts = attr.rss_caps.supported_qpts;
>  	resp.rss_caps.max_rwq_indirection_tables =
>  		attr.rss_caps.max_rwq_indirection_tables;
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index e3ed65920558..c486a379df47 100644
> +++ b/include/rdma/ib_verbs.h
> @@ -220,21 +220,21 @@ enum rdma_link_layer {
>  };
>  
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
> +	IB_DEVICE_RESIZE_MAX_WR = IB_UVERBS_DEVICE_RESIZE_MAX_WR,
> +	IB_DEVICE_BAD_PKEY_CNTR = IB_UVERBS_DEVICE_BAD_PKEY_CNTR,
> +	IB_DEVICE_BAD_QKEY_CNTR = IB_UVERBS_DEVICE_BAD_QKEY_CNTR,
> +	IB_DEVICE_RAW_MULTI = IB_UVERBS_DEVICE_RAW_MULTI,
> +	IB_DEVICE_AUTO_PATH_MIG = IB_UVERBS_DEVICE_AUTO_PATH_MIG,
> +	IB_DEVICE_CHANGE_PHY_PORT = IB_UVERBS_DEVICE_CHANGE_PHY_PORT,
> +	IB_DEVICE_UD_AV_PORT_ENFORCE = IB_UVERBS_DEVICE_UD_AV_PORT_ENFORCE,
> +	IB_DEVICE_CURR_QP_STATE_MOD = IB_UVERBS_DEVICE_CURR_QP_STATE_MOD,
> +	IB_DEVICE_SHUTDOWN_PORT = IB_UVERBS_DEVICE_SHUTDOWN_PORT,
> +	/* IB_DEVICE_INIT_TYPE = IB_UVERBS_DEVICE_INIT_TYPE, (not in use) */
> +	IB_DEVICE_PORT_ACTIVE_EVENT = IB_UVERBS_DEVICE_PORT_ACTIVE_EVENT,
> +	IB_DEVICE_SYS_IMAGE_GUID = IB_UVERBS_DEVICE_SYS_IMAGE_GUID,
> +	IB_DEVICE_RC_RNR_NAK_GEN = IB_UVERBS_DEVICE_RC_RNR_NAK_GEN,
> +	IB_DEVICE_SRQ_RESIZE = IB_UVERBS_DEVICE_SRQ_RESIZE,
> +	IB_DEVICE_N_NOTIFY_CQ = IB_UVERBS_DEVICE_N_NOTIFY_CQ,
>  
>  	/*
>  	 * This device supports a per-device lkey or stag that can be
> @@ -243,9 +243,9 @@ enum ib_device_cap_flags {
>  	 * instead of use the local_dma_lkey flag in the ib_pd structure,
>  	 * which will always contain a usable lkey.
>  	 */
> -	IB_DEVICE_LOCAL_DMA_LKEY		= (1 << 15),
> -	/* Reserved, old SEND_W_INV		= (1 << 16),*/
> -	IB_DEVICE_MEM_WINDOW			= (1 << 17),
> +	IB_DEVICE_LOCAL_DMA_LKEY = 1 << 15,
> +	/* Reserved, old SEND_W_INV = 1 << 16,*/
> +	IB_DEVICE_MEM_WINDOW = IB_UVERBS_DEVICE_MEM_WINDOW,
>  	/*
>  	 * Devices should set IB_DEVICE_UD_IP_SUM if they support
>  	 * insertion of UDP and TCP checksum on outgoing UD IPoIB
> @@ -253,9 +253,9 @@ enum ib_device_cap_flags {
>  	 * incoming messages.  Setting this flag implies that the
>  	 * IPoIB driver may set NETIF_F_IP_CSUM for datagram mode.
>  	 */
> -	IB_DEVICE_UD_IP_CSUM			= (1 << 18),
> -	IB_DEVICE_UD_TSO			= (1 << 19),
> -	IB_DEVICE_XRC				= (1 << 20),
> +	IB_DEVICE_UD_IP_CSUM = IB_UVERBS_DEVICE_UD_IP_CSUM,
> +	IB_DEVICE_UD_TSO = 1 << 19,
> +	IB_DEVICE_XRC = IB_UVERBS_DEVICE_XRC,
>  
>  	/*
>  	 * This device supports the IB "base memory management extension",
> @@ -266,31 +266,33 @@ enum ib_device_cap_flags {
>  	 * IB_WR_RDMA_READ_WITH_INV verb for RDMA READs that invalidate the
>  	 * stag.
>  	 */
> -	IB_DEVICE_MEM_MGT_EXTENSIONS		= (1 << 21),
> -	IB_DEVICE_BLOCK_MULTICAST_LOOPBACK	= (1 << 22),
> -	IB_DEVICE_MEM_WINDOW_TYPE_2A		= (1 << 23),
> -	IB_DEVICE_MEM_WINDOW_TYPE_2B		= (1 << 24),
> -	IB_DEVICE_RC_IP_CSUM			= (1 << 25),
> +	IB_DEVICE_MEM_MGT_EXTENSIONS = IB_UVERBS_DEVICE_MEM_MGT_EXTENSIONS,
> +	IB_DEVICE_BLOCK_MULTICAST_LOOPBACK = 1 << 22,
> +	IB_DEVICE_MEM_WINDOW_TYPE_2A = IB_UVERBS_DEVICE_MEM_WINDOW_TYPE_2A,
> +	IB_DEVICE_MEM_WINDOW_TYPE_2B = IB_UVERBS_DEVICE_MEM_WINDOW_TYPE_2B,
> +	IB_DEVICE_RC_IP_CSUM = IB_UVERBS_DEVICE_RC_IP_CSUM,
>  	/* Deprecated. Please use IB_RAW_PACKET_CAP_IP_CSUM. */
> -	IB_DEVICE_RAW_IP_CSUM			= (1 << 26),
> +	IB_DEVICE_RAW_IP_CSUM = IB_UVERBS_DEVICE_RAW_IP_CSUM,
>  	/*
>  	 * Devices should set IB_DEVICE_CROSS_CHANNEL if they
>  	 * support execution of WQEs that involve synchronization
>  	 * of I/O operations with single completion queue managed
>  	 * by hardware.
>  	 */
> -	IB_DEVICE_CROSS_CHANNEL			= (1 << 27),
> -	IB_DEVICE_MANAGED_FLOW_STEERING		= (1 << 29),
> -	IB_DEVICE_INTEGRITY_HANDOVER		= (1 << 30),
> -	IB_DEVICE_ON_DEMAND_PAGING		= (1ULL << 31),
> -	IB_DEVICE_SG_GAPS_REG			= (1ULL << 32),
> -	IB_DEVICE_VIRTUAL_FUNCTION		= (1ULL << 33),
> +	IB_DEVICE_CROSS_CHANNEL = 1 << 27,
> +	IB_DEVICE_MANAGED_FLOW_STEERING =
> +		IB_UVERBS_DEVICE_MANAGED_FLOW_STEERING,
> +	IB_DEVICE_INTEGRITY_HANDOVER = 1 << 30,
> +	IB_DEVICE_ON_DEMAND_PAGING = 1ULL << 31,
> +	IB_DEVICE_SG_GAPS_REG = 1ULL << 32,
> +	IB_DEVICE_VIRTUAL_FUNCTION = 1ULL << 33,
>  	/* Deprecated. Please use IB_RAW_PACKET_CAP_SCATTER_FCS. */
> -	IB_DEVICE_RAW_SCATTER_FCS		= (1ULL << 34),
> -	IB_DEVICE_RDMA_NETDEV_OPA		= (1ULL << 35),
> +	IB_DEVICE_RAW_SCATTER_FCS = IB_UVERBS_DEVICE_RAW_SCATTER_FCS,
> +	IB_DEVICE_RDMA_NETDEV_OPA = 1ULL << 35,
>  	/* The device supports padding incoming writes to cacheline. */
> -	IB_DEVICE_PCI_WRITE_END_PADDING		= (1ULL << 36),
> -	IB_DEVICE_ALLOW_USER_UNREG		= (1ULL << 37),
> +	IB_DEVICE_PCI_WRITE_END_PADDING =
> +		IB_UVERBS_DEVICE_PCI_WRITE_END_PADDING,
> +	IB_DEVICE_ALLOW_USER_UNREG = 1ULL << 37,
>  };
>  
>  enum ib_atomic_cap {
> diff --git a/include/uapi/rdma/ib_user_verbs.h b/include/uapi/rdma/ib_user_verbs.h
> index ff549695f1ba..7f374cc1a9df 100644
> +++ b/include/uapi/rdma/ib_user_verbs.h
> @@ -1298,6 +1298,63 @@ struct ib_uverbs_ex_modify_cq {
>  
>  #define IB_DEVICE_NAME_MAX 64
>  
> +enum ib_uverbs_device_cap_flags {
> +	IB_UVERBS_DEVICE_RESIZE_MAX_WR = 1 << 0,
> +	IB_UVERBS_DEVICE_BAD_PKEY_CNTR = 1 << 1,
> +	IB_UVERBS_DEVICE_BAD_QKEY_CNTR = 1 << 2,
> +	IB_UVERBS_DEVICE_RAW_MULTI = 1 << 3,
> +	IB_UVERBS_DEVICE_AUTO_PATH_MIG = 1 << 4,
> +	IB_UVERBS_DEVICE_CHANGE_PHY_PORT = 1 << 5,
> +	IB_UVERBS_DEVICE_UD_AV_PORT_ENFORCE = 1 << 6,
> +	IB_UVERBS_DEVICE_CURR_QP_STATE_MOD = 1 << 7,
> +	IB_UVERBS_DEVICE_SHUTDOWN_PORT = 1 << 8,
> +	/* IB_UVERBS_DEVICE_INIT_TYPE = 1 << 9, (not in use) */
> +	IB_UVERBS_DEVICE_PORT_ACTIVE_EVENT = 1 << 10,
> +	IB_UVERBS_DEVICE_SYS_IMAGE_GUID = 1 << 11,
> +	IB_UVERBS_DEVICE_RC_RNR_NAK_GEN = 1 << 12,
> +	IB_UVERBS_DEVICE_SRQ_RESIZE = 1 << 13,
> +	IB_UVERBS_DEVICE_N_NOTIFY_CQ = 1 << 14,
> +	IB_UVERBS_DEVICE_MEM_WINDOW = 1 << 17,
> +	IB_UVERBS_DEVICE_UD_IP_CSUM = 1 << 18,
> +	IB_UVERBS_DEVICE_XRC = 1 << 20,
> +	IB_UVERBS_DEVICE_MEM_MGT_EXTENSIONS = 1 << 21,
> +	IB_UVERBS_DEVICE_MEM_WINDOW_TYPE_2A = 1 << 23,
> +	IB_UVERBS_DEVICE_MEM_WINDOW_TYPE_2B = 1 << 24,
> +	IB_UVERBS_DEVICE_RC_IP_CSUM = 1 << 25,
> +	/* Deprecated. Please use IB_UVERBS_RAW_PACKET_CAP_IP_CSUM. */
> +	IB_UVERBS_DEVICE_RAW_IP_CSUM = 1 << 26,
> +	IB_UVERBS_DEVICE_MANAGED_FLOW_STEERING = 1 << 29,
> +	/* Deprecated. Please use IB_UVERBS_RAW_PACKET_CAP_SCATTER_FCS. */
> +	IB_UVERBS_DEVICE_RAW_SCATTER_FCS = 1ULL << 34,
> +	IB_UVERBS_DEVICE_PCI_WRITE_END_PADDING = 1ULL << 36,
> +};
> +
> +#define IB_UVERBS_DEVICE_CAP_FLAGS_MASK	(IB_UVERBS_DEVICE_RESIZE_MAX_WR | \
> +		IB_UVERBS_DEVICE_BAD_PKEY_CNTR | \
> +		IB_UVERBS_DEVICE_BAD_QKEY_CNTR | \
> +		IB_UVERBS_DEVICE_RAW_MULTI | \
> +		IB_UVERBS_DEVICE_AUTO_PATH_MIG | \
> +		IB_UVERBS_DEVICE_CHANGE_PHY_PORT | \
> +		IB_UVERBS_DEVICE_UD_AV_PORT_ENFORCE | \
> +		IB_UVERBS_DEVICE_CURR_QP_STATE_MOD | \
> +		IB_UVERBS_DEVICE_SHUTDOWN_PORT | \
> +		IB_UVERBS_DEVICE_PORT_ACTIVE_EVENT | \
> +		IB_UVERBS_DEVICE_SYS_IMAGE_GUID | \
> +		IB_UVERBS_DEVICE_RC_RNR_NAK_GEN | \
> +		IB_UVERBS_DEVICE_SRQ_RESIZE | \
> +		IB_UVERBS_DEVICE_N_NOTIFY_CQ | \
> +		IB_UVERBS_DEVICE_MEM_WINDOW | \
> +		IB_UVERBS_DEVICE_UD_IP_CSUM | \
> +		IB_UVERBS_DEVICE_XRC | \
> +		IB_UVERBS_DEVICE_MEM_MGT_EXTENSIONS | \
> +		IB_UVERBS_DEVICE_MEM_WINDOW_TYPE_2A | \
> +		IB_UVERBS_DEVICE_MEM_WINDOW_TYPE_2B | \
> +		IB_UVERBS_DEVICE_RC_IP_CSUM | \
> +		IB_UVERBS_DEVICE_RAW_IP_CSUM | \
> +		IB_UVERBS_DEVICE_MANAGED_FLOW_STEERING | \
> +		IB_UVERBS_DEVICE_RAW_SCATTER_FCS | \
> +		IB_UVERBS_DEVICE_PCI_WRITE_END_PADDING)

This should be in the kernel header, or perhaps in uverbs_cmd.c

It seems OK otherwise

Thanks,
Jason
