Return-Path: <linux-rdma+bounces-21578-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CO7I05mHWrqaAkAu9opvQ
	(envelope-from <linux-rdma+bounces-21578-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 01 Jun 2026 13:00:30 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3578761E07A
	for <lists+linux-rdma@lfdr.de>; Mon, 01 Jun 2026 13:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 838F23008D61
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jun 2026 11:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DDD39A067;
	Mon,  1 Jun 2026 11:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UNBovWo8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011007.outbound.protection.outlook.com [52.101.57.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C9235F5E0;
	Mon,  1 Jun 2026 11:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780311626; cv=fail; b=N0G01tk1wAt/tea26x2EU+Mht7/Q1pZP/lCAjymt3JAiIIVisd5a3Seu4C9HaWNYjDNqulTVz6Bs+1vilKLCBdNNhGV5V64VLh3PiQ22Z90lgNM3JjTZTCDrZEFW4AvNDwZJR153JuIpkpOyOV777y73n7WHZVPJfAWI2tbEbUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780311626; c=relaxed/simple;
	bh=x0ZisVa/kIBIJcHG3KQULMhPTJ5MpF1J5FqD/GTiqnA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gv+qUH7RJn7fGqMtruVBrGakjTSgyd7BcHnxs/xJE5TeI1KEKo2inbiXgb8nGFO9GEAD2jOvl2W6a7YKScAi8PmT+Vtk6bJT2EYWDt16Pss18qBMquFjNeCTbLlUAz2mlTnEH7M+Vl+lijBXAzftREa4ggCAPCL6Ka2hH2bGu4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UNBovWo8; arc=fail smtp.client-ip=52.101.57.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sZ03QZ6yQLJOstH6Nd9N7f6eU82WeI5uQtd71tQYuJOvVfBCP79Avnu27wY2pS190ycXxR2CSG5jEEIWnwVDF31PeiZyxweiLdCIBZA6QtmMNYOIePYKxTtLjD32pp8SPhc2lx9LyvTnkWNNc3BUfLspPU6R3hspL1nDN/Qd6BxV8rwlg61wvPk2jfDKfBfPrz32HwqzyPWUtXHQiUl+vQ71tjvFjulvyvye2tg/jTv4SPmKLID9cwl77iwQth+MTXqhV84gGWprJTh6mI3vT/4WC8wGhHDnYgY2QEV8ru4RkQuYb9hjwTweewTIabDWprt0SKG9ImNwdEi8rRiw5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ckCE1sf2sTm/4c04Ai1t62z5kfiLH9gpxnbRmsJptHM=;
 b=N2tN8AuchTDRMPbPmLr4QbNcmPh3dufQn269/iI4RrH8b2FgbxJmeSu3by01ORBk1RTvE0O19kkR5TJzlotGb6y+pKfe7VquRxE0JvJ6FnlEmr7s92VgN8+fqZXyvr2jjhK5NFacgIFA9Cz0tE22kZtnw86caZcXQrsECJNpfcE3w2v4DL63QpwWo7AXB6h8nW3d5Tws9Cq60iiST37UD6nky4mEvvTAxzfNaZQT/vpgirAxKtH3MYzxhYSnCoDL6SKDXitWp/gRbNYHh5oiY/+o06o7fHGQ12pyuqdk7l9/3dODjzSC32kqAMEeJYSc5LuHT/dWEEhV93VABQm0gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckCE1sf2sTm/4c04Ai1t62z5kfiLH9gpxnbRmsJptHM=;
 b=UNBovWo8UuOQ1IE4h8wP9YDewFqXW+pkQ8SxBQP4mFwdLmAdkmLMOyNSfGm3UW9/s5L2j+JttZKVLZsohRA9qVJWaWuuY+wE4IrACKC6HuI0D1b+qP6iOJdre2HV0HYcCwWgbLKg2sVU4zum1yDub9/R2A25CFmEoiSlmABrVq/1N43CiktpoeZ58JwBH41TnmKHYrDYN5itx7UYZm7XH1GRwLRhqE6Z1hC5rMgNrsZDriB9hZeAaJYZf8RHRG10l/UP8bOnLc8LUBpkXW5f/GBGWke6P87lFXhl6cc2eq9iiHGsYV0DDVNa2UflSyIlpe8Nit5FuBjHdyz+lHtjWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 BL4PR12MB9481.namprd12.prod.outlook.com (2603:10b6:208:591::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.14; Mon, 1 Jun 2026 11:00:20 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::16e2:19ba:8915:90be]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::16e2:19ba:8915:90be%5]) with mapi id 15.21.0071.014; Mon, 1 Jun 2026
 11:00:20 +0000
Message-ID: <7a018189-021c-44d1-a46d-a75016818a0b@nvidia.com>
Date: Mon, 1 Jun 2026 14:00:15 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx4: avoid GCC 10 __bad_copy_from() false
 positive
To: Yao Sang <sangyao@kylinos.cn>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 "Gustavo A . R . Silva" <gustavoars@kernel.org>,
 netdev <netdev@vger.kernel.org>, linux-rdma <linux-rdma@vger.kernel.org>,
 David Laight <david.laight.linux@gmail.com>
References: <20260520102130.423044-1-sangyao@kylinos.cn>
 <1780035629778309.247.seg@mailgw.kylinos.cn>
 <20260529064521.4i5pyilf32au4cnf@sang-pc>
Content-Language: en-US
From: Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <20260529064521.4i5pyilf32au4cnf@sang-pc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0159.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::15) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|BL4PR12MB9481:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f4ae8ca-0285-4ed0-fe8e-08debfccf8cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|56012099006|6133799003|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	yBi80fcx/grE/v3XKAD8c/LccT475Go2v9nZyA62Avy5078zl6tqo3wziunefqrM7184dvZc8qNQs+gzOmbrmrdSoA3T14dDiwHOtA+Bj7Uort/B8P1Rzz4too/jkvp/qegFbb9TeKZhYrnhxiHJvKkVQLieyMTNgXGvJz22geQGhZXoPA2vBiQT3FpdhOIE/PpMkgNfd2MJPoJ4+NGXVxMmlGxzVPQZbPWxYkQ5olY/uX5g7pJS53Tzj3MJsHRdae8c6IyKvj/ey/KcwzBPEVGTwUk6Zi1zDFEBjaQ4sOVz8/3i80s0wbTnRGO6+saiHcijfCWQyCQicmNaRcC9Va23+gZdYTNxGGn6ZYJ9cMbkDSEQpW8Ep+b/dvErfPstahpI3LcQobRbuDoxQ1rYwLhBdcqdyF/05ioyd8s9vDyqN1Kzuj5dPED8l9wzvXtLNIzS9z++eFGOhR4NySMhu2bUsDKipsn1qHKAsFYoPQ3A2wNwherbv9CjJ5vLW8g4FwU2yl0letiegSYedLDzGXqte6TCmj3lURI2n8gvgQXX6sQYwNcmVzqbhb+uqkQbtoT+6jvmdnEpPN8juBWkzBCt8iXtNkwRBOK7cDTyZsoC0+ThbpEaqvT8ncg7w3zjsGsPwM/4xrOlBAqKkYyx3RZmoDpdY5RjlEDmTLm3VlNTUddJAJPkb/7bpnUFbMOvJaaYJPcc6BWS79U/CtZ+HQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(56012099006)(6133799003)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bDJKcjVoOGh3NHEwUVJ6U2tIbmtMdDM3dDBHQUZieUhWSVdkdmdUb1VLR1Er?=
 =?utf-8?B?cTFRb05oVVYyWVFjN0xBVGJRVEZodTJ6aC94ckdTR3VOSDI2ZTB3UFNja2J0?=
 =?utf-8?B?Y3VKd0RndnFEbDBMRVFNVUoxbDdydjU1T3VsQ3dKU1BNR2t6RGhiWXRtV2VZ?=
 =?utf-8?B?NDZQaTRvMm5rU3h2d0hYSk42NlZMWFF5WGpYbGU2ZnFmTXdWakpmWmtjMHJh?=
 =?utf-8?B?UGJHQ3NoUGF1OFhCU2dBMDdyaDMxbHArNDRrVTF2b1pVMWVoS1FycytCamI5?=
 =?utf-8?B?M2dZL1hBTlRPMGVVVEZvNDNpaVB5b3BGQXpFbGx5ejNmVmQwY2dGeFFvRzZ0?=
 =?utf-8?B?QU5KeHNQaFdnNER3dFZzN1dFVldvR242b2VodGJGaTBKeFU4OFQzRTF0dzl1?=
 =?utf-8?B?L2RjUisxUTdtT25rVXhZY3FqbEtheVVhWFdQTi9jVVZMVU1sVk9ETmUreWRD?=
 =?utf-8?B?RndEdS83NXh1MDNEMFZ1bFB0cFVidE5FSzNDOCtwaFRLMml4TFUza0pWQmQ1?=
 =?utf-8?B?MFcyM0dUYXR6eTRYRzd4RzVJdWd3bFBMcVA4NFM0WXhCUWJLRUFpbU83cXhK?=
 =?utf-8?B?N0JnRzNtanlhM1piQUFzOXk2SmRHejVkUkxuUCsxeWFKOUprT3NZU21WdndD?=
 =?utf-8?B?a2c2NVdtaEJROEZQQU9KdzFQMEhEZVJnNXIzM05iT1VGSVI2ay83QmdwQ01D?=
 =?utf-8?B?Q08zenBuL24wQlVaekowdllpVUQzSTZEVVJoRkQ0TnNJYjNiV21LT3FJMTZV?=
 =?utf-8?B?VHNqVnU0WFh4b0FSMUprUWU0ZFljVlRXY2hTaUtoQVlQVFppZWxjVHpVUy9z?=
 =?utf-8?B?VGNhSGdrc3VVbVRUQm1CNXJaTlpzdXN5UEw0RENuang5bVY3MCtvRUpGc3B5?=
 =?utf-8?B?bW4yYTFjS1BvWXRKVEhYRDU2UURkWktzZEhDQnVlNGw3Ymo0cHUra0Vwb1Na?=
 =?utf-8?B?emVpRHZIdmhtVXhWRCtCRGR1MEVUQWRva0ZsenRjMEJaNzBPNmdFMmFBZTky?=
 =?utf-8?B?NUFaQUI4N3NjSStHYnd4RE9lYW5RZGFNaHR5Y3hCZzRyV1VGd1FOR0xEbkM5?=
 =?utf-8?B?N1o3VHJZSFJrdkJPUDg3SVhPZEY3UDJtRWsrV0dZSytrZ3UrUFZGR014KzVq?=
 =?utf-8?B?RTlnZmpqWHpLdFlESFk5ckJFTy9ETUxmanAzWHlreTBuZG55Q1hQWWc2QzFI?=
 =?utf-8?B?ZTBIREp5NVlyTzd1L1VrdjIzSDV0NDJEWEdVR1Y1T0t4dklTQ2VkeXgrYTNO?=
 =?utf-8?B?Z3h2T3FBekY1RjViT01aMzBTNXhaVkl3TU5lUFdwSFlXemhPbnh5ekdFcTN4?=
 =?utf-8?B?UytlUlhSK1YwcFI0UVhUS2VIKzRNaE1XVGpDMG5vUkp0RVlUTi9FN1FPRGJV?=
 =?utf-8?B?NndObFlndldReHQ0YjdlTk9QdysxanFEZWFlWVVyRGszUzBsbjlIWCtCY29C?=
 =?utf-8?B?aHJrRUlTR1hXQXFPaUxvdEJzTzBnKzVsZnhqSVY5Tk1qM1dwc2tZaXF4NEV3?=
 =?utf-8?B?dDhEekZjWmtPc0lwR0FndmpzcUpPdTBJZGxRWGd4bGd0bzJKd1R3R0FsTU5h?=
 =?utf-8?B?cXBPaURNc0l0VUZQN29aTzhBbDBWOEhUazV4REpvVE1UUXhkTXRKTXdtV1JX?=
 =?utf-8?B?c3pWQWNrT3lEZUkyNGhpY21ia0xUVU4vOEtaSzNhUld2MklKeUNMbUFwVUhV?=
 =?utf-8?B?WTVTdVRrbjIzY1MxUjlnSDB1ZmxOREpuRk9TZVlESkF2NDlaQWNaUmtmZkll?=
 =?utf-8?B?cW9BRTFSNE9aVzl5WVdleHZreUxBQ1ljckdiUUdpRmhJUnkyTDk5MmUrUmdx?=
 =?utf-8?B?QkZHcS80NmhIOGJnY3NHQVFSdS9TZTg3QUw0emVKbGVoZzNOWTFrMFN5QXNF?=
 =?utf-8?B?c0MxaHRsL1JweXE4VndFemFJQkZBaG5CbjJmbmNUVjVYOGNSZkIxNTFVNHZK?=
 =?utf-8?B?YmtnejJRcGF4YU1pMU1GaTEzdHRubU0yVTNQQThGblJhWlBkT00vV2R4WG5Z?=
 =?utf-8?B?ejNoSDZleGJBeThhVWJVQS9LVU5uMmovYUR4OUF2T2ROcTFJeGJrL082VmxY?=
 =?utf-8?B?QXg5SzBaTStKOVRXTXNPV0FYclU1MkZPOEpqNG01ZXRkYTNqMEFScHhvMHND?=
 =?utf-8?B?c1JRTklkNmtGdCtMejF6dGtxVkI5QVdKNS9tWmJNWHZOclkxT3ZQTXdnZUQy?=
 =?utf-8?B?Z1NnaUdnQUxSLzllMXkra0YzcVhVMTliaDQ5RkNieXlFSVVxUnFFb1dSWGhD?=
 =?utf-8?B?SXJubEtaLzVObGp4UlUwNERraXFNK2lKa3VHQ2dkWUM1RmNQNkpobnlTb1Mx?=
 =?utf-8?Q?Yzmcc3/yYtTitqlug1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f4ae8ca-0285-4ed0-fe8e-08debfccf8cf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 11:00:20.4254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xr46RbTw0By8AYJbEDyWEyO6oSK4CiFgh1HekkKJka3Uj1+EpMUKw6fyxQKgq8HUvw/bVok6GSH20yL7oRe17g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9481
X-Spamd-Result: default: False [3.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	SUSPICIOUS_URL_IN_SUSPICIOUS_MESSAGE(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	URIBL_RED(0.50)[kylinos.cn:email];
	MAILLIST(-0.15)[generic];
	HAS_ANON_DOMAIN(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-21578-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,lunn.ch,google.com,vger.kernel.org,gmail.com];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_DKIM_ALLOW(0.00)[Nvidia.com:s=selector2];
	DMARC_POLICY_ALLOW(0.00)[nvidia.com,reject];
	NEURAL_SPAM(0.00)[0.874];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_SPF_ALLOW(0.00)[+ip4:172.232.135.74:c];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,Nvidia.com:dkim,kylinos.cn:email]
X-Rspamd-Queue-Id: 3578761E07A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 29/05/2026 9:45, Yao Sang wrote:
> On Mon, May 25, 2026 at 01:47:59PM +0300, Tariq Toukan wrote:
>>
>>
>> On 20/05/2026 13:21, Yao Sang wrote:
>>> mlx4_init_user_cqes() allocates a single PAGE_SIZE buffer and fills it
>>> with the CQE initialization pattern. When entries_per_copy >= entries,
>>> the function copies array_size(entries, cqe_size) bytes from that buffer
>>> to userspace.
>>>
>>> That copy is actually bounded by PAGE_SIZE in the else branch because
>>> entries_per_copy >= entries implies entries * cqe_size <= PAGE_SIZE.
>>> However, GCC 10 does not derive that constraint and falsely triggers
>>> __bad_copy_from() in mlx4_init_user_cqes().
>>>
>>> Cap the single copy_to_user() length to PAGE_SIZE to make that bound
>>> explicit and avoid the GCC 10 false positive.
>>>
>>> Fixes: f69bf5dee7ef ("net/mlx4: Use array_size() helper in copy_to_user()")
>>> Signed-off-by: Yao Sang <sangyao@kylinos.cn>
>>> ---
>>>    drivers/net/ethernet/mellanox/mlx4/cq.c | 5 ++++-
>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/ethernet/mellanox/mlx4/cq.c b/drivers/net/ethernet/mellanox/mlx4/cq.c
>>> index e130e7259275..7b024a5e13c8 100644
>>> --- a/drivers/net/ethernet/mellanox/mlx4/cq.c
>>> +++ b/drivers/net/ethernet/mellanox/mlx4/cq.c
>>> @@ -314,8 +314,11 @@ static int mlx4_init_user_cqes(void *buf, int entries, int cqe_size)
>>>    			buf += PAGE_SIZE;
>>>    		}
>>>    	} else {
>>> +		size_t copy_bytes = min_t(size_t, array_size(entries, cqe_size),
>>> +					 PAGE_SIZE);
>>> +
>>>    		err = copy_to_user((void __user *)buf, init_ents,
>>> -				   array_size(entries, cqe_size)) ?
>>> +				   copy_bytes) ?
>>>    			-EFAULT : 0;
>>>    	}
>>
>> Thanks for your patch.
>>
>> This is a compiler issue.
>> Did you try fixing it there first?
> Hi Tariq,
> 
> Thanks for the review.
> 
> Yes, I agree this is triggered by a GCC 10 limitation / false positive.
> 
> I have not tried to make a compiler-side fix the gating item here,
> because GCC 10 is still within the documented compiler range for
> building the kernel, so I think the kernel should still build cleanly
> with it.
> 
> That said, I also agree that my v1 shape is not ideal. In particular,
> the silent min_t(..., PAGE_SIZE) clamp is too implicit.
> 
> I think Paolo's suggested direction is a better shape here, i.e. keep
> array_size(), but make the bound explicit with a runtime guard instead
> of silently clamping it, e.g.
> 
>          copy_bytes = array_size(entries, cqe_size);
>          if (WARN_ON_ONCE(copy_bytes > PAGE_SIZE))
>                  return -EINVAL;
> 
>          err = copy_to_user((void __user *)buf, init_ents, copy_bytes) ?
>                  -EFAULT : 0;
> 
> That would keep the overflow-safe multiplication, avoid the silent
> truncation in v1, and make the single-copy branch invariant explicit
> for GCC 10.
> 
> Regarding David's suggestion of using a memset_user() loop, I've also
> looked into it, but couldn't locate either of those APIs in the kernel
> after check.Please let me know if you have any additional information
> or suggestions.
> 
> If this approach looks good to you, I'll send out the full v2 patch shortly.
> 

That would work.
Thanks.


