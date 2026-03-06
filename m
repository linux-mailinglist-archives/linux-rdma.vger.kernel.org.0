Return-Path: <linux-rdma+bounces-17567-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKOgEEckqmkPMAEAu9opvQ
	(envelope-from <linux-rdma+bounces-17567-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Mar 2026 01:48:07 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D2E219F97
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Mar 2026 01:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B13193020A7F
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Mar 2026 00:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D592DC334;
	Fri,  6 Mar 2026 00:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rWNx/CrJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010006.outbound.protection.outlook.com [52.101.85.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A495336886
	for <linux-rdma@vger.kernel.org>; Fri,  6 Mar 2026 00:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772758077; cv=fail; b=SLJEUSIrfVP9ku5cjfpddv1dscYndpixTimUijjK7yW93GQIdEgTfkAJDgJD3JvWhyGviXS2rJmTmMIMUiUHuI+EDeJzPC8ElZgjZRe8NesfEBbLANnxt2rTybR5gjebB8SB2a+h5Ry714ZhLffZoAMOih6pZUMPD+csahqjz88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772758077; c=relaxed/simple;
	bh=Hos4O5R6hfgULu+FDvoVhQvIOtGtOyWPSxTvoj3ynds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hJWNZmbV9sjwwiIwk1eIfil1YS4h1/inlJmsgdXsFRQ/cfyq1BteShsJ4aFgLZRKIO2xh0bILOTSy/GKJb3/iZa+LUdZKEyp2vqmIqoVwbYGNzB3L+rj+2hVQq9GtLG3n+n/3Fn02NeF9w+rGFuWprxqchB4OkYRDKNVBZJAJZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rWNx/CrJ; arc=fail smtp.client-ip=52.101.85.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S2cPt9RJu664TY5sUU6hAH1TNRQmCSTvOTeZHorqoR7uz4FCMzVyHaP9GN1QKgRhD2WteCnOk9AFwrAEm7Z3nDLOWeTuk+0FNJmeZskM0FPhgvHcSc93ZfTelTKTRLo6btgH1C5SuNpcqfqWIh06HR0V/cwX0rwgQ2NPhpZUKUumvEbltYx2sk4QVZ6tHQeCMhQ/CUJY0yY7nXyUsan1VEuEYc5VBwi/+irr8Civ9o5r6EmoMakwhzWCnV10qUakvESyDBkyVLqY/ItbLWrMozU6LA4rWwIol/zmwoMg9uQtD+TQXZH5qRy9BNfDSoD/wCBTlj4jMcM+kE2wK6gXcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzsiMzh/vrJj3YAydrijB927OGCcXerMgLdNXcR84IQ=;
 b=uNXn3gSke/5m27oRjtCWXnMIvj4+Z6FHoMiH3kejVIMB7da54yp2DWXMgpedzSU8zYPOJT9jem8g0NounwRO4qQbEc+GEjvq9AGW8H9HBt0uP9s1HvkIwkcavwEJUUJ6VbLllUJa9JZ2xQNne0ICF+H+UUUlatNz/gLatIi68SNrPsMNonmKe2xw6FRK6SLZW/pVo2phrhaE2TzbDFbaEZ/yfVPkcV0YFeLAYdMSNMknuKs5a2BvbRkpdN9Krl/f+g+j8L2mhnPzSBpxbGTfKTzDVrpKbPA+7boH52iImuGtUipHqPuhVfX5/EHTPRkaUjdC889FVN+a3X/RBr+3JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzsiMzh/vrJj3YAydrijB927OGCcXerMgLdNXcR84IQ=;
 b=rWNx/CrJj3Hak0XG1AoqpXEtMSRcSFW7MZoYU1zcIHt+AuLMHEccxZsp6jcPazqFY2mnkXTvTKeRQjNUJkV/VeuMKQiJNKJK0+eMhRfYPPkFspBB8TXnUwqpJ5J9jBDAC+ttj3MLG53uts1j3D0EQ5VeNnyq9VQRCaZaDjZy9P5cNN9QhLSGUFffXZyP4almgPx2kesYAAjEbHZM2NPGAWn7Sv563GvaWVwLT8UZ6WtoUtx1KBwfH4ICFYbERdaJbxeKGrBtvRxc47jXsSFvvFLZS9moWgseiydqLlf77/7UO7jiDwhcLsev7Dp2sQZPgyx6+dif0Junwn9Tm6fPhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB6531.namprd12.prod.outlook.com (2603:10b6:208:3a4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 00:47:53 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Fri, 6 Mar 2026
 00:47:51 +0000
Date: Thu, 5 Mar 2026 20:47:49 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: patches@lists.linux.dev
Subject: Re: [PATCH v3 00/13] Provide udata helpers and use them in bnxt_re
Message-ID: <20260306004749.GB2137346@nvidia.com>
References: <0-v3-bd56dd443069+49-bnxt_re_uapi_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v3-bd56dd443069+49-bnxt_re_uapi_jgg@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0391.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::6) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB6531:EE_
X-MS-Office365-Filtering-Correlation-Id: 50343c5f-942b-48c2-6973-08de7b19fe63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	hvRAtN4QqtotS07OaWwiilXNJQLNqqG+B8rTQxC21YQbDojeJ9mV/5d4F/AcHETnRUhPKZtufgrb4BWylDwbjlt2h8oxHwtAr42Cfh4+XW70mbsot8V/NDRRP51yApE8J41SEfXq5zzHr24GpdX3ExRpZZcQ9+wyXCB2qDR0cezuDACBcL00bZOQ7UFdk01w/nj0+aQn8VNq01pH5Ytwn7bgXbm1AexIBaF8QM8Eogo44IWzrHXMyXosd1e5y2T8VlO3ke/i1i9K8mlMvrRFcjAwgmM53O2mMa9B9EoKuQ36HU80MBcdiv5lBlaDDQAzvzq6aNWFMfWYk3E1RPf1ye+wwaVlpSepLfhzNuMCVYWHpxPE0FcIq/LtLNifSDPHRadWzmKC3zDAudkeYUfQZ5fXBvk2m3Cge4HUOOGc8hsEIZN5VjsnRUXxdS5Mp7WbJqAVoecP+u/UrRvQy1KjsAT4UcKeeNTY9KaGWP1GBRXuT3KtLQESkzgLSSK3Q+BBgi04QXWNIHBPFnHNToxuCx2d6+xFTHXmqoqDXTY01uDtDHAs8l6pIFLnpqOvKsp+B1/awgBlcAJ1y8tf1HJq5Fvq7TWxgLI4orwsycOXlJtL34WJn6Q2isT8vs5pf2jR5sEfFNOZzuWwfELBmduLiQkbjgZP9jgm1swjkqMSFBADInRCda7kK+WCDcqhGpwezw1pT4VYkkbPGf4nPEnyuZ+FIHAPJjzuwVUvT55JnAc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qJVmfaxO8ZyS1KiYg8gvm+4D2buB15RG+IY+hvFRvjyu8xlF6xt1XCwBG8v7?=
 =?us-ascii?Q?TPKYUNAeGc0YNO/rW3BxWXhye17KQMSvs4GIGZBeFbvMM5L9A0uVgnEAgZPe?=
 =?us-ascii?Q?EejV88E4tWwlN8gJZ4Nn6SE05gXsEKEF70y8bUXLv6JyUeh9Rjs9VSsNxv3i?=
 =?us-ascii?Q?tFSDK0LhjZF+FtJuK7Z6OEXSIEikmWbdCqLymtpRJLj2zhXhmcucXFp8+mG9?=
 =?us-ascii?Q?2c3AakN19MY4EDGyZVVmzI+p2soK3TGxbV2y9+v1YxNdBU2NWfBoVolpLdns?=
 =?us-ascii?Q?8LcALFjHnYmS1XFHQxNRb+Qt4xnjcLia22w33SG0LnpIZs8e8A4SfZ1wGZuH?=
 =?us-ascii?Q?IBNHsoDZmZQVqNMzKGXHVyOfvvp/9/QajYhe/jRsM7lyLyZZuANATYIfAX7K?=
 =?us-ascii?Q?HbmWJHlGMSFiqR0ojHlHVcQQ2RG2tMf0lm+WEdQQRvrjJOD5YN71/t2UH+LZ?=
 =?us-ascii?Q?9W/a7KwnmX0gkhmGN4RPWOBck1goTWx5TaDDsC81Xu2D7yT57vuSATBE8rez?=
 =?us-ascii?Q?A8bHTek5EI46Ch6ER1ENrJpSQD5rYCGrLiJ0vwv47gc3iQ3bOOMMGTyjJ4kL?=
 =?us-ascii?Q?H7VbpiGN43lhfazfmcXdgbWwEBtJoDKHcEzdq3QhDYNH200I20rYBIUTMir/?=
 =?us-ascii?Q?EMC67+a0iFvCDVGDA7/vH9/APojb2wCevD97emgOknd7WkWg6YdbXTSimCU0?=
 =?us-ascii?Q?GUxr8RsFQf8rKRLc2cecoKGZuv+UT6x20iTMvSthPjLcEsc6V1slih4syL+i?=
 =?us-ascii?Q?4qjN7N5xGxK1EsLN0k1j9kkA0+zaV6O2XwvX4PfKYY2CI+fU0Q0VmME1wrda?=
 =?us-ascii?Q?w68+TC6HqdQmFEo/f57cNwwfgJZwHXJG9vt81CXh/i66ChX/VPhnpcgl93Pg?=
 =?us-ascii?Q?GOqBKo6Y6TIhgbXWFrT/KY0y8BsInIOKabjVkzkdlAO52bwxo5XSnI0tPcy8?=
 =?us-ascii?Q?1vucaqv2K3NPlx6FbL1e3xj0694qqUXaKK6FwrhIpYNLItXc6XBjSGou8U4W?=
 =?us-ascii?Q?A7VybB8G3jolQJ1adnuOjPoJD0QCdXLv2wHlrPCxCbgdKvKx4YsNHnJbQ4R0?=
 =?us-ascii?Q?AVjZrE0z5CbERkGQDBiR72UdJbwy/J+SX8hSP60Lz50ZRzuvNa8cD0xmhYnp?=
 =?us-ascii?Q?WsQIVDgeVLeX2NY/OzJsjTo5mz4c8+8Cm+lPapdxWO/9WCN6uuDXRcOVyq9z?=
 =?us-ascii?Q?Uj6bpAnc3jRSGuf8qOGgk0TXs6q4Y2wakdI+n2AZ6nNRPuH1QRck65W9E1bu?=
 =?us-ascii?Q?3bm5j4AFJcpBXaYkJZQ0sBB6C610h1Rv3QHyspTHZK371Awp0j6k7DPUPznv?=
 =?us-ascii?Q?/Z7pMl9hxKl4aag5rgGvnXbZ8Dgqkm1fxCnXJfml7yqMu3q1ecLqKiy2VMdB?=
 =?us-ascii?Q?HK6eL9hQvqg68mTTZ28w3pVyHxZvZLna016JtC9uxq2EZvqH2OCgZDsrKbnr?=
 =?us-ascii?Q?oar8meNMAWEIP4+iLTO8/ruFS7GpbOy6c+JeJE3z6xRDPPsmgnr5V6xKMnyd?=
 =?us-ascii?Q?M4+vNFtKx5llXr71y2i0/HXNn7D6nwbS8oiGx19IOdXqQgM3hhBXLLu9bvnp?=
 =?us-ascii?Q?V9SRHGI8hdD8BCtyXYHPeWkHwsE0l2jVz+OsxS9Szda97E/nbWGwNUuPGWsy?=
 =?us-ascii?Q?AtRV89L/lhpnDLxbT0bE3g3vZ4IcmPWLttrdJx2XFSyNLd9uhHQXwb18BGFD?=
 =?us-ascii?Q?Fwe/qoMkJDWxnO/1JoGvalmcwZSC6aOX2iglZ6y/os+lD9NU/oZSWl98oAvs?=
 =?us-ascii?Q?JO+dF7q+Zw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50343c5f-942b-48c2-6973-08de7b19fe63
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 00:47:51.3549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p7B5H8UIJZ3E02YrSZ10YKnKH0YgFmqhmY7FU96e6FXv5axbjUTbOxHW9FCOIChw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6531
X-Rspamd-Queue-Id: D4D2E219F97
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17567-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 03:49:57PM -0400, Jason Gunthorpe wrote:
> Jason Gunthorpe (13):
>   RDMA: Use copy_struct_from_user() instead of open coding
>   RDMA/core: Add rdma_udata_to_dev()
>   RDMA: Add ib_copy_validate_udata_in()
>   RDMA: Add ib_copy_validate_udata_in_cm()
>   RDMA: Add ib_respond_udata()
>   RDMA: Add ib_is_udata_in_empty()
>   RDMA: Provide documentation about the uABI compatibility rules
>   RDMA/bnxt_re: Add compatibility checks to the uapi path
>   RDMA/bnxt_re: Add compatibility checks to the uapi path for no data
>   RDMA/bnxt_re: Add missing comp_mask validation
>   RDMA/bnxt_re: Use ib_respond_udata()
>   RDMA/bnxt_re: Use ib_respond_empty_udata()
>   RDMA: Add IB_UVERBS_CORE_SUPPORT_ROBUST_UDATA

Applied to for-next

Jason

