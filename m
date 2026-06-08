Return-Path: <linux-rdma+bounces-21984-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VkAPLP4OJ2rWqwIAu9opvQ
	(envelope-from <linux-rdma+bounces-21984-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 20:50:38 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6EC659DF9
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 20:50:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=SRmFCgiR;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21984-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21984-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B55A930FBD4E
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jun 2026 18:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A603E2AD5;
	Mon,  8 Jun 2026 18:34:45 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010060.outbound.protection.outlook.com [52.101.85.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7580C3E1204;
	Mon,  8 Jun 2026 18:34:44 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780943685; cv=fail; b=T4n4sew4CUV37PjnDxYtYaJ8F1qL42fYsBymeZMsAFrXgF9YxPMggvrns9PkSGGK3LKwugLdGnrGIGJ/ReXHue3j/pLFTTuVVNzmrjr8l/YDHX725YF477/RpmpgLjseh4vkQH5oAoUXYatPJ+74gbOp5sZJsDkbuMF+Jz4HQSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780943685; c=relaxed/simple;
	bh=iJQfhMhbgn88pWJdJKvGBAGDarqY4SuTEHKFCVAEtwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Zy+pr7eDTFRgOKF9z+B3kMZRBIsdFzzySKRqk5g7Hbj4GzaCoaTw/B4BbnhT1T5cFD1MhF8OTh5+0l6wv2GD5el6d8x/vtMO+FHUts7pRXtlYulTI0NSkA80PTSIzrPpogYKiiZydxqnQxd/6vlP4qrz4OlbTy12ErpsUPlN5Mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SRmFCgiR; arc=fail smtp.client-ip=52.101.85.60
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tGqnxfZPiJKFYG0hefoXHdZixOw0j4LJLUT/afPpqo9BT+FrZNHxriLyAr6+HXXzgKSr0+xuua0Ft2v6qg3xziy+sZ6SJT1f9Ko7UMCOQgGwrRBZ/PKMf/kVZcaVMi/tNBJPFUjksfbdvPxw8Wa3+14g/YiVfAugazM2Raf0jcdUR0C9se0ZInyoul75cZeT28pRlgNaLLGwLIX4qAP6db36fyHUlmdY/bdCWdwBM2m4wDk+jI3jqOE5fwgcrlb19IbvrRbBYcQLmNBL3s514s6uEo5hYFpEhxDhC8Nq3ZAQE2+55oSQVu3CQeJku58+4YGLB3TwyA63GRl83kQnOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K4Ek7EeBUt67mxP5uf93hu28YOW7PuFmq2XXUr4PZ64=;
 b=DlDNZT50mvtHkC8UFZKxANUH6BDsJl34hCif4Q9JYsDk5pTPo9ZhnTs3DaVwcFtmuxJ6GY04lQ1wobalUhGKhYODZUXw2vCi0v2QlKV7XydytadowZ+PsMZX2WnqZexe6vNghqyH9K2KMn8NxPjgLUqajYyEIexMiSrIncUca+3AwtRkq5SaeXueKeOY3O8/OYZNR1EXCPZ+MwvU/FiINycuONae0reCpX6iA1rAECFsLMlutWuVN84b8XZXqoIpi6QaY7MaQ484PyKu/7mo62OoeKtf31fBx165I6FGRKEqbVZJDvy+LDUY6buh8OJL8cI25dswQt9mFpu3vUNYHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K4Ek7EeBUt67mxP5uf93hu28YOW7PuFmq2XXUr4PZ64=;
 b=SRmFCgiRyy/vKu3WYBt+6HSWPL9JwDSGV7FmxtXc3LFssHQ3hDhRuyhPvStp1/mlgT/kI/weup35op6Wr070ZHbrb/B7d5eR/XYCgOUbkmnZnpbe2xg5E3S9YZnbo+tpVmGJMCbo1gfWaFKlNp9xEsCddBtN2szYaf8+hP8B6dIOgKzFBGuYqVmMGEehUpjwGChi7DWLvyQBggv3W9yp+VhqgwdMD1MIJQZppeGjFKGEspXN83yasfcuEuL6zVKuJjDXvmoCneN5w8d4Nni2xZunwk50B+iKA7lrCa31AsED/N/J7/2tsxjxk3XgSlP1NrevuouOt0ZfZ2zExTwGCg==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.13; Mon, 8 Jun 2026 18:34:40 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 18:34:40 +0000
Date: Mon, 8 Jun 2026 15:34:38 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] RDMA/iwpm: fix kref bypass in iwpm_register_pid() error
 path
Message-ID: <20260608183438.GA95325@nvidia.com>
References: <20260608103001.142648-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608103001.142648-1-vulab@iscas.ac.cn>
X-ClientProxiedBy: BLAP220CA0005.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM3PR12MB9416:EE_
X-MS-Office365-Filtering-Correlation-Id: 298efd7e-fc5a-4b15-6515-08dec58c99b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	P3h8l/rAqqkFzT3Xo0r7siN6Mbv6KXSJmJyn1+tnPPw9wn9v+t69mCaJaSmMlgx5igGYtCG1LfdobCLvPki1cuqwGOCT0TR/nmGc6LTj3xfA86QOxRRk2PTDHQNTwmY2yaDo+8l6T6Au5kmK/3icNnVmnQbSz+7rFwH3amHEgI+nJPAwxe1salsux/IA0Qz/a9DYFEhfa83wF7uWsy6IH7XD8TEz1rGgu32pazrxOFW8nAfvnTdO/OI6E9O23NuIylwKmFzMP+YSBctyu3Zdl91fJpuOsA78tNVVRvPTPJ/kmD/ZJ7z4mUJoBYrLCDwnrZsfyTqHAUHWe9iZoFT7PX0pvH6OOxvJDivH67E/yipa0QhtHHqrJotjuKqD62GEH18fjZGNlIDcMB1b0lrwCee3GUEWhRyajGmhb4eQNTTISV2zG1hFoIXwhTERFRvJjDsFgEaoIyYOqiZfZaPc0sCE1Wfb8pVVwZxEdm+ewgxEHNH+OlD48pr8DvdTNewiHwX994q7rBelFo5nZ3CiNgKiQ7OwsXOL3E6yE/f5yqA7A1Ca9GjuT3kaFM0ATFBz09DeyRNyFOVCr5E4extaCrJla0+NVS0pp00UsBcRqS+SJhOQhrMxZAZPTJ5YWSnazh06lcqVL5n/XLj4Hm20KzjUCaljCDT+8ThJzalq8Q7yd3lq1tuoimUgvxPlm6QViPz0lXYz7AsjFoux0hxodw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lv3wHQf2gU9zq4GqbpeTnmvqUqLKtRI8cZ5L1EJNVMHorwG0VhpdwcJFBa/A?=
 =?us-ascii?Q?6O0eF6CcCDjYUNHdtADk7LZjjS6Vu6Dz0qmAHUxam950qINyuJkD91bESC9I?=
 =?us-ascii?Q?Oe4r9eh2hc9hH5eF/iSAhpROjP3J8zSFC92qdYn9/imQypfWfvw5K2bAKcag?=
 =?us-ascii?Q?F6XMwBOcSrzf8+PL+zSuxJrM7duZIYVN8GGtlVRAvTCkKbBCCjS10kkjnCuw?=
 =?us-ascii?Q?BAJCL9ncLc7fp/SSpb1sif+aytzC7jWilvGXRdZvgGYI4Hq/SV+6pJg8Mxcq?=
 =?us-ascii?Q?wfPJSTEtoICzdWciflog8SAXon2CTmJEmZL3AXWForukXjkv2CXct62DKSbW?=
 =?us-ascii?Q?jj0++1sfw/+pJ5eGW+Ov46xMO2a8Vy5YHIPRrBBocVrJB70foPBoiXsLLcwl?=
 =?us-ascii?Q?qbM4nfvkIy8Y5K0mAHVkkuOef5YKpvhjXdjVKckuza51NXsbKQ4YfZE+8h0y?=
 =?us-ascii?Q?yg9Yo1dLnK6vp8D9GE4mZc9HT/LLBeIS2jZvX0NvCUO5vV7g9o8/sHeWY1I4?=
 =?us-ascii?Q?g6sp6nCyk3tnTSAYh9tKVqGGmbJna/HoCWyroAt/zEI8bmyjL528PGTRWN8H?=
 =?us-ascii?Q?16H8Q5sw6XsiAC8nqc4Srsk55bIus6cNDhDMbxoMGLVaiv+c2MyF/uNMlWiU?=
 =?us-ascii?Q?vgGyHq0LMvdoC5WD7rtiCEFQACO8Rso6nS9Lo7mllbLV61KpxguuWdIBVOfY?=
 =?us-ascii?Q?WAUHebYL5Zc3xdYwS3BaMvB+VAjbrGlGumBzUkKCYp1/75B1ISgp/Wx7MMNv?=
 =?us-ascii?Q?4la8ar5m5sIqVCipHC4fUVg/j966c4z7KdklTWyJiV7roiXjXEpf41M9JWwh?=
 =?us-ascii?Q?I5U7SM9USSMrHqdrzia5F/x0cFzS+NNRDekA2aAo1+bIF5IwQJzh9eFDfDPz?=
 =?us-ascii?Q?lqkKufJS5tHVg1IAr3WZbWv8Q7Fj1SdL+CBOqKiINV4cB3kONCp/CV2FK/WO?=
 =?us-ascii?Q?m8UP7mz1v4bDSSphmoqfIvDlY1HzRpyUvHgD6xUFE7v75w29DHGkp1tpQ2+G?=
 =?us-ascii?Q?vKxJNi2qmJagaGKcy56BSc+e+EmtaHOVD+Mbyu6sYgU3FTKzz5oHidqB78lL?=
 =?us-ascii?Q?tiAKf+OzuZIkkWjhz7ReOBD1PWYS5fVCPmUdmnUXZ/YvgHNKZILzIunfTnKN?=
 =?us-ascii?Q?cviP/R8T/wgDXpbH3cBv76CidYzmLDr45u84nRBQ/FpT8qdhEjnNw/7yUmzl?=
 =?us-ascii?Q?X2tvZ718AkO2ajMSXVE0UAQYEBVT5DhVzhD5P5pE3VCqGhsP04R6wFJUP/CQ?=
 =?us-ascii?Q?fLXJB8w7+fvyvtwlfy8WfdlhTVKorJpl1e9Su2PnuZN8uxehumCN0SOVJvJS?=
 =?us-ascii?Q?3nCxunWhnrsCME3tiXyE7YE7NCTns2sbA1cCEyV0vNxf6L9gwjWMeD/uCGnn?=
 =?us-ascii?Q?fgy1+JdOlP0uUhOECDf0DzmGadCD1eSst55MSNm8VkWObLrbSW2D1tn0NIoP?=
 =?us-ascii?Q?zg5+3bWoap6D+jkVn6d4ocJHy9AzBCrjOIoOQxPAWT0Rex53jfWstH+x478V?=
 =?us-ascii?Q?bhTZgWfvEPXU99GyyIjOWmR3HAhWHq/ipimbgXjdug0lF/2RDDfTuBjWhFCR?=
 =?us-ascii?Q?pDyxCahzqUF8QMskTfLBfdHH7zPRiXzRKNLeUokKzSM+qMQfRiA20HBhfeui?=
 =?us-ascii?Q?oSIp6N1XYNwTM7KIH87e4EKggFgqisw9v5x4sU0DFKbYylQ45eZ7SuxWMFnA?=
 =?us-ascii?Q?Ezem6BsaJjgk3swQlgMbW0u/RGOoEofubGWqZC2zePeusGDj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 298efd7e-fc5a-4b15-6515-08dec58c99b2
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 18:34:39.9982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RQkfZzbemHfdy6llQO9bwELn+prj6hGc6dGELCrgXtePZ80+109CRzNWeJ+VTyFj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9416
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21984-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:vulab@iscas.ac.cn,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,iscas.ac.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0D6EC659DF9

On Mon, Jun 08, 2026 at 10:30:01AM +0000, Wentao Liang wrote:
> iwpm_get_nlmsg_request() returns a request with kref_init() +
> kref_get() (refcount=2, one for the caller and one for the
> iwpm_nlmsg_req_list). On the error path, iwpm_register_pid()
> calls iwpm_free_nlmsg_request() directly instead of using
> kref_put(), bypassing the kref mechanism and freeing the object
> while the refcount is still non-zero.
> 
> Replace the direct iwpm_free_nlmsg_request() call with
> kref_put(&nlmsg_request->kref, iwpm_free_nlmsg_request).
> 
> Cc: stable@vger.kernel.org
> Fixes: 30dc5e63d6a5 ("RDMA/core: Add support for iWARP Port Mapper user space service")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/infiniband/core/iwpm_msg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/core/iwpm_msg.c b/drivers/infiniband/core/iwpm_msg.c
> index 4625abd29ac0..672b0c33a6de 100644
> --- a/drivers/infiniband/core/iwpm_msg.c
> +++ b/drivers/infiniband/core/iwpm_msg.c
> @@ -122,7 +122,7 @@ int iwpm_register_pid(struct iwpm_dev_data *pm_msg, u8 nl_client)
>  	pr_info("%s: %s (client = %u)\n", __func__, err_str, nl_client);
>  	dev_kfree_skb(skb);
>  	if (nlmsg_request)
> -		iwpm_free_nlmsg_request(&nlmsg_request->kref);
> +		kref_put(&nlmsg_request->kref, iwpm_free_nlmsg_request);
>  	return ret;

Sashiko doesn't like any of these changes.

https://patchwork.kernel.org/project/linux-rdma/patch/20260608103001.142648-1-vulab@iscas.ac.cn/

Does this change introduce a stack memory corruption risk?

Because iwpm_get_nlmsg_request() initializes the request with a refcount of
2, this kref_put() only decrements it to 1. The object is not freed or
removed from the global iwpm_nlmsg_req_list.

Jason

