Return-Path: <linux-rdma+bounces-11476-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 839D3AE0AF2
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jun 2025 18:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E08753B9156
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jun 2025 16:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FF2272E6E;
	Thu, 19 Jun 2025 16:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fLNT7IzC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01D13085B2;
	Thu, 19 Jun 2025 16:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750348854; cv=fail; b=hJzS0y1Dv6YTucNEW6V/fwYuLu2pHllQrLen5xogwjQgfFvxDGasDs2qEj+GL85GOqwjUn7ZKyVjJ2cO38KK/lMk7x44FbWFbZMyKwUYb3WcEtLiVYCe+cT3qMSxjj0a09QbgTb4fd6inreydIfWGXovz5Bt6tIylO/clKtZ89U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750348854; c=relaxed/simple;
	bh=swkk5ynQOmoaFchNnb8SNaVqQXE+bSOCzQo6QwxE3gI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XWNx9Vtnn7eJeHX3dzD4TXYT33Scuei9i1V9qALaQEzLwaKrbjUXmUxr//1nRQ5DQf7dyQErwgzOtf/ghSge26xxcVbxsNOuodCgMbVkOsuMTPrlBL3MYeHbLEPLJ6c7WqyQVFezGLKqqa5dnvem0HlVp/Hn9GlXKbmCTn1M1Hw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fLNT7IzC; arc=fail smtp.client-ip=40.107.92.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kP4T5AP9S9RALx8JSvxz0wpEYlJE99r+hReQiiENaonMv+N2qWqvi+VRsFwJCbVnVAMLJDuO+1dLoQZGhGOt/CpKaqzV92VJNgyPP+9lUdhqXDk33z+9xPRTDBsjZUk0rVhevH7l657QWCiKJt7xDnzeJRkB6qZLgBKe+fn/3+P+12iExZA8iWADKrzkisLzkWZL9mgyVtX4Rhp3/QYwaUvPxk9ZsH7xg9IDdIzKeYN49JMbPA00pVtqr5oMpJHymJ97qqz05xGYJQOUmdW8dbdf2kNBVaHBMyg1XV2wHjUGTYl/8Fj6nFwRDUb24L7Zb9FoKYIH6gnbqpJ4FH+7RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kx/Poe+vgA4PCjl4QLuklk0VisQWIDvXeJldsDoGdQU=;
 b=EORcNWjehi70JZYAbipFnrs9EsqHvr+NQFPNt7HXrZXfMxmOaN3MOEybUUF0g/ivx76b/cXU1lxi3g0U1GLbUQ9AlNRpvhb+W+aKHp8TD3gPUUrIhNyi9BNK/bo5WXQx8BsYhIjA0/ztbv64/gTrBCyjNB5XZogYUbMzoWYqHl36S/SdwU7Jk+mzGr4H3kCK7ep2tfjggH27yebPtijYgIJX5/ua8NgQr74xfJO/wRrNJLJDtEXbmtlIbaTY01AQ+ijMXprDGFWWVwBhzmagtjJt18Vq1aqdyDJk94XJmd+hymiv2oSipZF5l5x8g/elK3NlplGP+1f6W+kJkldBhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kx/Poe+vgA4PCjl4QLuklk0VisQWIDvXeJldsDoGdQU=;
 b=fLNT7IzCmsaX3ut39BcFJGN3giqF6znexVRkzU3D3qUCMT9dib86ro/JPExvU+QZUpxWPep6YjuJ3CZzX3ZbLu0Bu1a4rJrYyoSu5gU5LkgenAMegGPj/y7rxuR63DUh1tpy+sfJTxH46CH1ArEqjb79vYfaMEzT1PdnqRBEqatRMunc9iDMjTne1O9lSJ3Xr/WLUHSHLHawT4YlMhAV4C7R9vRtjTnVGbstUezu8UFGtaeowuxkilRzdRkPDdJDA7cisNgjyCex7xJjc0g05EWYpC9LkQDMGgjuq6U7GhpBCraKgoaRvQj1ZNO7dNenQHqonNfObtH3HLCG78OnBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by DM6PR12MB4091.namprd12.prod.outlook.com (2603:10b6:5:222::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Thu, 19 Jun
 2025 16:00:48 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%3]) with mapi id 15.20.8835.032; Thu, 19 Jun 2025
 16:00:48 +0000
Message-ID: <d9bcc48d-17a2-4d12-bacd-6bef296b45c6@nvidia.com>
Date: Thu, 19 Jun 2025 19:00:45 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/5] net/mlx5e: Add support for PCIe congestion
 events
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, saeedm@nvidia.com, gal@nvidia.com,
 leonro@nvidia.com, tariqt@nvidia.com, Leon Romanovsky <leon@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250619113721.60201-1-mbloch@nvidia.com>
 <20250619075543.1d31f937@kernel.org>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <20250619075543.1d31f937@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0007.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::7)
 To CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|DM6PR12MB4091:EE_
X-MS-Office365-Filtering-Correlation-Id: 5642d64a-4f34-48b7-8bd2-08ddaf4a7504
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MlZYS05EdWJxZ1ZNUUY4a3J3S1p6dTRjY0FnbGFLUWpIaGtMSm01Y0dpbnVZ?=
 =?utf-8?B?U0hQbnNWeS9iV0ZTWFRuNnh6NGszRVF5dDZzSmErL09iN28xUEx3dVJsSmhx?=
 =?utf-8?B?aEo5TFE4bGRkb1dtZXZ5QXJxcVhXZWtHZTRteGV4bHFNVCtVemlCd2pTV3FE?=
 =?utf-8?B?ZjhIL0lBNjUrRTZGeWMxZnJzcktwdEs4Y21tczhhY1VPYldWNkwza3dJam15?=
 =?utf-8?B?TEtMem1KQWt5SHFsR2ppRkdnU3gybVY0MFMvUEd0L3gxVmcrbkxUSlMzQmhQ?=
 =?utf-8?B?NWVKMllucjc1TkNvdFcvREJvYkFnV3JtbEhXdmd6Q29tUVZnSUQrclMwTzRL?=
 =?utf-8?B?akZBV2FGbklLbEZON2R2dXFQb1h4dXVqOHlSb1oza1hlbVZUa2YxOS9qR1Iw?=
 =?utf-8?B?dTYzUHNja0RFNGtjSyt0dklLL2V4aEhFb0RGYTZ4RDlnazRoME8zeXVSMlZj?=
 =?utf-8?B?REdydE92QVpFbnBqQmgzRXlZR3c5Vjc5eVpBZGNpVytGM2gvYzdpc25VQWVW?=
 =?utf-8?B?cGZTL0NoWnB0a3JGOUlnUWhoVlFpSHBMK1lqcnJOQk5aMVhNbkhRbkwzR1Ja?=
 =?utf-8?B?bTlaYWZ2WWQ4azJZM0ZaQ1hQRFh5L2s2eGdmZTFNcVpJZnN5VFZGRXBWaU1C?=
 =?utf-8?B?eGgyc3J5TStGWStmWTFTb0Y0bDBrYkh4OVRHRkptbHdLQVdzZjRubUV4aEhC?=
 =?utf-8?B?RVBKYVc5YWVvMWdvV1EySTlvTU5IRGN2cnpIVk42cWZhbDdKR3JFSDN1Sks2?=
 =?utf-8?B?YjVNUmRaQWM0M3dSTzRqa0lmTUcxOURyaVRrSFpsZlRSdzBJMTRReHJ6MDMz?=
 =?utf-8?B?bm8vWWJ3OWFzNSs4WTd2ZDJsZS9EMTZtbUc5Mmx4ODdXQlNBYlFiOEV4VnZ5?=
 =?utf-8?B?Zm82amtaazNtemU1WlhpbzdtNXdXdHE3NThoZ3Bwb3FYV0RKQUtNWjR2dFpa?=
 =?utf-8?B?N1d6Y1h0WXduU3ZHZXpMZG9pcjVaMVN2ZEJlbXdpdUJ2QzErUGIzZ3VZTFRq?=
 =?utf-8?B?TEMrUDZWUEZ2cjkrMzdYWnBHd1lYVlJHLzU1UlRwSmxGcjRFaWtLa1hteGIy?=
 =?utf-8?B?MkwyYzNOVHBMNE9weUNaelBrTVp4cFc1aWVIOVEwOUxGWHhvc2V2Z2cybk9I?=
 =?utf-8?B?YmxIQkhMQUR0QUhXR2g5NEpmSmJWV3ZoaXRqaDM1OWJTR2NXMTBQVVdDbDRR?=
 =?utf-8?B?M2g1QWNsUzVLWUVQVXZ3MTliUUJLYkNtVUVvUThCQ3A3K29HWmVkSTduWFNM?=
 =?utf-8?B?RStnTmZRdXc1anJ2Q0k1aEhPSTQ4NTRYaFlYRTRkRTJpU0sza1FROXJxaWw0?=
 =?utf-8?B?RTNqUmdsdHovYm5uTWhqeVgwRW9Yb3NpR24wYmtkMy9vSDBhSkdCeUNYZ1pz?=
 =?utf-8?B?YW5hWGwrVFU4QUJ4SERjYzJwZzlMOU91Wll4MFBUZThOaTJLRWNmcGhEOEpV?=
 =?utf-8?B?ZHVJa0VUN1EzL0w1SGhQbHJ2dkxZNEJJTWxxQURqNzBpeXA1QjFkTVVFb3Nv?=
 =?utf-8?B?Ti84L1R1WTQvWWpYVnNWaUxBYnZNdTdxSGR0UFBWNzFLMUVUeDJrN0ZHWVJV?=
 =?utf-8?B?SHFyUjl3eHplbkdqaVQ0MitJRXJkbEE5ZEJZL3hiZWE4ZklaSlNnMGt5M3kv?=
 =?utf-8?B?a21RdzlOQUtzdWFRbEdaWmZaOGhZd054WXp4Rk9MOXUwUjhkVTdkR1JnS2gy?=
 =?utf-8?B?VjZabkp4dzNrbTFSaUxXMkxJVnBVZTc4S3c2T0FLMEFZL0FWUnNSM2Z6YmZ3?=
 =?utf-8?B?WEJ3STIwbVVHUVl5c1FGTHJmeFAzalZUQ2ZaN2VyR0YzbVlwZ29BUFJpR3hX?=
 =?utf-8?B?NkFpa1V5eTZReWhJaG9VQllLK2RUSlQ2ZmtmWGp2WEFTYTUwbVBMeTFzVDlO?=
 =?utf-8?B?R1JIVk5kbC80anFSclJCb0lmeU0xbEZ5ZUpuZDA2VEhBa3BwRUNFd0h3ZWpC?=
 =?utf-8?Q?D3T5riviR40=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TFpEUVk0YUMralVSTWFuVkJUUWxNdXpXRk1TLytKWHllZnFRbzNqUkpUUE14?=
 =?utf-8?B?MWk0K0h2Q1ZpM2gzbWxqZnBnRk03aEFLTTVHUXhWZ2V1M09iSks4dnJxdmls?=
 =?utf-8?B?M2U3R0dvV3VWL1FZWXlLS1dqOHhYdE1HSXhFKytQc0ZMMkt3SnZ6UjQwNlRo?=
 =?utf-8?B?cHpQWDRHTEU1MVN4M0x0ajZ5T0dyZG85b2NIeFByRDd5N1Aza3NzalFhUzlS?=
 =?utf-8?B?V3hvbXhseVM1V3RrTHFMREpidkgvaWZCOWhQdjZBaGZrb2s2WldGUW42SXFx?=
 =?utf-8?B?aURheDdUTWZIOWU4MUxKaHJ6QXJBR051MHJncG9Fc2EzODdINnVET2Z2MnBo?=
 =?utf-8?B?UnoxM1Z5WG9jdE9RUFdsOWVlY2VhTnN5Rzdzd0J5Wm1mNlB1WGsrdE9BVFM0?=
 =?utf-8?B?ODZsNHp1a3JpZ0JGcDlBcHZrZ21wUHRHUEc2bjV1KzhpeGlPeUdZSG81Sk1a?=
 =?utf-8?B?MnhEVzJjZFFYUVRqVHREUWhTR3NoUkwxYXkvWU1PakJ0bzB6YmxmaG5ZdllO?=
 =?utf-8?B?UCsxbEUrdG85eUhXOEZyNjJudll5bUJycmMxbitjUVVSeXU1UDAwT1JSZXlQ?=
 =?utf-8?B?dUJGVkloZEoxNExBVnpoa0JtYkZiVHN0dUN3UXFxU0tUcmR5b1dabDhsZkJI?=
 =?utf-8?B?OGNKOEtrMExWM2RqYkdzbFVmVXhRUzN4a1BiblZhUGxPWUhraWRUUDIyaTFz?=
 =?utf-8?B?MmhoTmFXb3kvUVh3eTJJbktnMktJQlVRaEFQQmlpT2wwbGtjMGROVVp4M0RC?=
 =?utf-8?B?RFlhVFB6eWlXNWNVSlgvMmwvazl0WTBTWENlNHV2dGpodHBNMmdNN0k2dDRm?=
 =?utf-8?B?UmFBaHZVSHU5VC80dHVjcENzbWhQUTc4Y0g2Q09rNGFrODBCalF5QXRnNEhK?=
 =?utf-8?B?Q3Blc0JQRlVlYzFmYktLb3JDc0Q0U1NuV2ZiNjJyM0x0N2UrZWhoY1lBdGxU?=
 =?utf-8?B?MGRVZ01OVjREMjhHUkxuaTliY1c4cExMbUtROStxWmpuWGV5bC9PYy9tcTJV?=
 =?utf-8?B?ZkVKRXV4cDBSUXhjaHYzT05ONFVjYTBtUnpDOGkyNDJxMHNOZENrUGFWZ3Z6?=
 =?utf-8?B?Vm9PZloxMEx0NEtPREhQb21oa3p5TjZkWjF0OVJJd21YSEpSbGd4Ly91QVJu?=
 =?utf-8?B?TnI2dlJaR09RTzZPREY3Unp5MjFNeGhlS2NyeHltd0lXTGk2eVY5VEpjM0N4?=
 =?utf-8?B?Um1IY0N1cGFpa3M4LzZOZm5Ra2xXSWhwZlZyZzRJOEtpRmZjS0xOOGp4QWo2?=
 =?utf-8?B?SitDdm5rbnllVENvMjAyZ1RDcnhlTnJkUEJxczNEb2ZtbWM0NWF4aDFRVkd6?=
 =?utf-8?B?YmNKSTlRYzBGWUpEWWE0TVhMRUVUaFJaWVVTTWw5b09kcHdQcWloc2kwUGN6?=
 =?utf-8?B?QjBXYlpBODJFc1BrMFZBeTRQUURkZjNnY3dBQy9jM2VRQk1jdEFZMndxaVd4?=
 =?utf-8?B?aWg5Rms1TExUN3R1VGdYVHRtTjBZeU5VR2tkMW5QR2NGM2NCanlnYUlDcGFx?=
 =?utf-8?B?Vk85UXkzWHk5eXppYkI1Mi9KV0tsbzJBRGhQd2JXOGZXZVRXYkhueFkrMVA0?=
 =?utf-8?B?eXhzNG1kYVZNZGFNQVZ3dHVURlpjUWhCTlQvUTRUUmlEWFhLVzEzcnNGajFW?=
 =?utf-8?B?RUhacUZsaU9ZUnM4dU5aS21oaGswa2lIQ1RoTDI4RVJ3bWNVZ3pXUkxoZ0Vz?=
 =?utf-8?B?aVczcUdsazVRdmRocXl6R2VqTTAxcWlpLy91dEdEVnFkTExsZEZWS3pBcDhT?=
 =?utf-8?B?S01BUVFCZDkyUHRHUGhJQjE2TVhuUGJnUVl4eUxpWXRRUHo4VTZFVW9Nc3Vq?=
 =?utf-8?B?U3BPUkxCSjZzTTNlL3NCMFdrOWVUOTFDeXNJN0pwcXpZb3BjSXlodVlMVDlL?=
 =?utf-8?B?ZThFZzNkK3A1VU9oa1p1MlU2ei9YZ3kwMHB4QmxuVWxEZjB5QkJhbkRVVGlv?=
 =?utf-8?B?Y2ltZStPVWZ3RHY4QTZQK2xxMm1nV0hNTGtCaEJkdFR3VXpDejRiUHpvVG5O?=
 =?utf-8?B?bmhiMmdnS0NlLzRQdDduR3UzdFE2Ky9XbGNpdktQdVZUd242V3NKektBMkNP?=
 =?utf-8?B?ZUFlOERGRlJPaFpwRmJZaG5GUnAxdUJtNmExa1I3Wnl6emdCTUJHUS85VHJS?=
 =?utf-8?Q?9LtA7ZJ/3ugSIp9MbV/dh36qW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5642d64a-4f34-48b7-8bd2-08ddaf4a7504
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 16:00:48.5384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F4Z1VnDP2OMyTM08BiQLN9AUJhEfwkHaI+rjykMYNu3ULpHJ4zk2GXENHe3qAIx8yqbf8NhbFSzLMUmYzbxDpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4091



On 19/06/2025 17:55, Jakub Kicinski wrote:
> On Thu, 19 Jun 2025 14:37:16 +0300 Mark Bloch wrote:
>> PCIe congestion events are events generated by the firmware when the
>> device side has sustained PCIe inbound or outbound traffic above
>> certain thresholds. The high and low threshold are hysteresis thresholds
>> to prevent flapping: once the high threshold has been reached, a low
>> threshold event will be triggered only after the bandwidth usage went
>> below the low threshold.
> 
> What are we supposed to do with a series half of which is tagged for
> one tree and half for another? If you want for some of the patches to
> go via the shared tree - you have to post them separately.
> Ideally you'd post them to the list in a combined "pull request +
> patches" format (see for example how Marc posts CAN patches, or Pablo
> posts netfilter). Once we pull that you can sent the net-next stuff
> separately as patches.

Miscommunication about the proper process, thanks for the explanation.
PR + patches seems cleaner and provides more context,
so I’ll go with that.

> 
> I feel like I just had the same exact conversation with Tariq recently.
> Really not great when same process explainer has to be given to
> multiple people from the same company :( I'd like to remind y'all that
> reading the mailing list is not optional:

I do follow the mailing list and double checked what should be done in
this scenario. In the end it's my responsibility so it's my fault.

> 
>   Mailing list participation
>   --------------------------
>   
>   Linux kernel uses mailing lists as the primary form of communication.
>   Maintainers must be subscribed and follow the appropriate subsystem-wide
>   mailing list. Either by subscribing to the whole list or using more
>   modern, selective setup like
>   `lei <https://people.kernel.org/monsieuricon/lore-lei-part-1-getting-started>`_.
>   
> See: https://www.kernel.org/doc/html/next/maintainer/feature-and-driver-maintainers.html#mailing-list-participation
> 
> Then again, I guess you're not a maintainer. There are 2 maintainers
> for the driver listed and yet we get patches from a 3rd unlisted person.

Tariq is on vacation which got extended because of flight issues.
I've mentioned I'll be handling the mlx5 submissionד until his return
on v3 of the tcp zero-copy series.

> 
> SMH


