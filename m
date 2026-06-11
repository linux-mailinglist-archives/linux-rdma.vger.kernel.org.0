Return-Path: <linux-rdma+bounces-22096-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qJB+NnBPKmrJmwMAu9opvQ
	(envelope-from <linux-rdma+bounces-22096-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 08:02:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3888F66EDE3
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 08:02:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=I4418Jbq;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22096-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22096-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B3F0304DC82
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 06:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFD42DC350;
	Thu, 11 Jun 2026 06:02:19 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011042.outbound.protection.outlook.com [40.107.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008EA35893;
	Thu, 11 Jun 2026 06:02:17 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781157739; cv=fail; b=SbcMICFdf6Q3qIFvScXvVKpi8tiUu9+qONkOeOVVVFp5L1fcYa1SMPyHa9Kn63P5aP9yxhotcmLuFrBb8xkihOFsm7WPw4L7BpRZOCI0qqGz2wcEZojVxSJ4yW7NH3JZ8h1z7kruE1gzxbv745sVdgkByvbW3cfSwJskzsr0ufg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781157739; c=relaxed/simple;
	bh=AGaMfx6qymL4aYRm7Y6DAZzkjgnOo+T85oPoEcFCFQw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IT3gAx6WdGGqkqxvYDIdB36ZfKN5/U4Tg9VubVj6kJdI8daD0zH+sZmm9HA8LqA1WdadIyVIjwWME8l6sORFS1xo7K5ZxThyOx7bMFM5PJZq/MF8N6JInDHQoUi5jhNy/KqVhLqgiosHE83hXlVAQSHv4/bTN451yZCrBBjXz8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I4418Jbq; arc=fail smtp.client-ip=40.107.208.42
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JBbUpJ6q0Em/vCl0kscqzzPoqT9d/zXf7OK/77gx03gT1pcWLKecJlAmm4rAC4nlGhaZHD0eqglsxOc9lMNsWdRms/lw4A6nB34o5CYcDkIv4QqPdoJwWp8N1+T8cTlfR8wfEe0U6vHMlv4wNW/9irsC897IdbKBWCn61j0ZsoIbB38GguFnKQrT+SfyQoG2ED93ttSRoS7egTEITLY4UaLlBATIM7klUE/aCFtJgEVQpMVtPIcn1SLCt1qUNTByyG+KFAXEPtJq6Yr3S3UloovYGEjERV36cxcWkppviNPVYQp7ON94YLhpebhhoHlnTfWpjgUM/ey3vG2mbKB6+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e11iZ0panKsnFkGIcpX3mcy5MycWQCrZuYFBqnfOio8=;
 b=UmTxrusdBp3A+KErdB+8UAwaorzI0to30NctbuahHVSo0MHYpKuTZfp0+SJrtLnsw9bG4y7DJO77fQuA2/GTSu9hZbDstPBaTJmXMrx+vSqzCXJ/YPJG18nIBbwANdjESg7OU2082SXSYoXEdBqQjvqb/CtYqcbB0VnAdmBq3K0CuroooMMMDxj+UpJRXZO1XM39bcLfHckaN57AeN5CWq5ECMYmj+sM6IJGkiYSqPPtUcspYcT9FHy0+aZTdidTy1bOUnyGFdWWukDG+Rs1bSoSOLlkYKcSSW35lUpKIoT4MkNUP4b+1+GPZoP4h7WlZ2trDSGzqrnzStFdA0ElTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e11iZ0panKsnFkGIcpX3mcy5MycWQCrZuYFBqnfOio8=;
 b=I4418JbqefIMb8Qz63l/AMTb8+FURcEKQ87rfCd0yevc7J+C0SqHcABXFMqBrtmHfqBGu8C83zfX3vGulNJaI7O+OkdLLKbMx+vGuQKXnmoiKzGH9r3FkkjtAaSM8zE4jfA+No0HYibKFpAdLDl7tEqYNhnKsEAt14zq+A12RFsbyjuwBDkMkparhT9S7TKl2ruUwM7mLlo2xgTxiB3vjA2Mp7psNmKMTYoSL6ezUq0rgln46PqzkNnHLqpJpVigh1Pc04RHfYGGLF+WouKahEJ+piy8Tjz5CwWiWDfINKHt98j8EynEOG4Ugi9W9JcPotjjXSAhWQX13yVdc3+M5w==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by PH8PR12MB7026.namprd12.prod.outlook.com (2603:10b6:510:1bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Thu, 11 Jun
 2026 06:02:13 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.21.0092.014; Thu, 11 Jun 2026
 06:02:13 +0000
Message-ID: <eb525345-da07-414c-9d05-7e00e3eb472f@nvidia.com>
Date: Thu, 11 Jun 2026 09:02:03 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V3 2/7] netdevsim: Register devlink after device
 init
To: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Jiri Pirko <jiri@resnulli.us>,
 Simon Horman <horms@kernel.org>, Sunil Goutham <sgoutham@marvell.com>,
 Linu Cherian <lcherian@marvell.com>, Geetha sowjanya <gakula@marvell.com>,
 hariprasad <hkelam@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
 Bharat Bhushan <bbhushan2@marvell.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Ethan Nelson-Moore <enelsonmoore@gmail.com>, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20260605181030.3486619-1-mbloch@nvidia.com>
 <20260605181030.3486619-3-mbloch@nvidia.com>
 <20260610165053.7c91f331@kernel.org>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <20260610165053.7c91f331@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0099.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::17) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|PH8PR12MB7026:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f5f4b18-b485-4ec3-2633-08dec77efb41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|6133799003|5023799004|4143699003|56012099006|18002099003|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info:
	lVSDK/bCpLS3XB1H55aK20A2Z0xqWJtAzbXlmm6nOw8Fdvl3r4B3u7tc2jMuUxLhQlpKvcvRD+rdoRu0qkMk4z3eoN8WR2pprzVOBD5uYprCk9b2le9vmM0J8R20vvHEtF3gxwxTSB1AW1FNSXkx76vrJG8WDRXCliv2zRbXzv6KPW+jhJ0PnEY2O0MvcnTwM/v0/aDxuDp+p7f0GKuoNS+5cbTCUcYwvlExVUOiwYwk4RxLhd5pIwNnEBDPXhXbNKpGc03RYW1eMLM2O60yJvLZvv7KDoQYUFbicw4O3fce505DEfdx60MNgai9rm5qM3m/gHtaUaqKATUe5blrLii/Lq88cwTfLESxqmZei7qANzSlG8HDaYtet8jFWjBizUY6phe/YgID9Zi5RyB+hsOS9KZrruCvoj0zOvbBSEl9o0HrNv+MOLrBZAVoP1u1XvaY/b22L2/MS96TmtUBeLEk154+swgnN0oWYDDL6uedj6vDe5U7gepJ5QPAIgFlH6iVp6u92nCvQE3YIFc4ssxH/wULmaIz1wM3JAeHXnErJj6P6lNayohv/0P1MjePjOn3YJdFaYdj4VH8aySU6GsiqMDlWDAVFlDs+MmbBmwJQEU0PJXpZCksRjqV+fDWHhOCp0xxFfWveAy4vjHQTURfMcO2OA5GJvXHfEVmkEp/WMZgNuunTkudXxSZjfGO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(6133799003)(5023799004)(4143699003)(56012099006)(18002099003)(11063799006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGR0TnJSVTAxRkVWVnNVU3NZUFJvOUVuOU1jQmVoUnkzMktJRDdjQ0dNSDdm?=
 =?utf-8?B?b0ZQMlBOWFMxRHBBNitFUVZyWHJKWnZqL2xsRTExY3cwZUk0RzF6S01EQXRu?=
 =?utf-8?B?Ulg5UEtENnFpWlZyUExZYzk3c1BhYXFYb1h5R1FkNElVYkZVOFdIWTgvY2o3?=
 =?utf-8?B?TGtxVFVlUnN3OHV0dHVONXJ0b2hLWWgvM2FuLzlqR1lhbzVWTW5wdjZmSjBy?=
 =?utf-8?B?ZGFqYkFxRHdaT1g1ZmJTU01EN2ViOEpLRkVFbDNscS8rVndKR0V3MjIwdXFl?=
 =?utf-8?B?K1VzZnlzV1ZQRVFQajZSVEJUV3dBQnZPUkxGSk5vQm9qdVRjWW1jQXhuczV6?=
 =?utf-8?B?aGhzdmtteUUxWktQUU9vQ0xEaEY5NlFYUWNZNUsxaHlKMi8yMXVrS0I2UUZM?=
 =?utf-8?B?U3NwK2NTV0dNbm5YS2EvTjhuMWVZbHltbXZVZkhQUTVIQlVtQ3RmbmlQMGYy?=
 =?utf-8?B?WWtuV0c3c3l5UVF4UU85czExRk5CQnhERVpaY3VKaFl5c3RDVXNIc1kzQTM3?=
 =?utf-8?B?VjZ2TkkyMXZ2SmpHWGxITXRkcFA5ejZ1ZklFUFJoSVhUN3RjSzZ2V2EyUlly?=
 =?utf-8?B?RzVzdmk0eVZvUSsrZE5zTjAyWlhvSkFOVVd1clpkRWxBc2d2c0RYdTRQVVMx?=
 =?utf-8?B?WFI1RzRhMFJ4a3RxOGs2SVE0bURJWWg0MTd2cXFMV2gySlcrRmV5eFZoSldu?=
 =?utf-8?B?QzQ4QXdZQTh6N1pCQzBrcXRRMjNITUVUODYzSmRmSzZ6cGJRZERYMjFIcWVi?=
 =?utf-8?B?dWtZa0d5cDRuSUtLRUJmTG9kRzZlekw1TjVvaFd3UFppVVdqRjN3emV5ajNG?=
 =?utf-8?B?V3ZyakxjQ0l6aEVFdEQwNHBkbUNEY3FUelpuNXp4blNqUWxVY3VvMS9BVEN6?=
 =?utf-8?B?UEZtNi9XTWVabi85OWJZSElmaTl0dVJReW9RQk1PS0FzWGZmb09Mb0VJbC9y?=
 =?utf-8?B?SHAvcWZWcHBKT2U2c3dUUDZUTEY3c1VXS0k3dVlSRERZQkpPNmx2aytCMVpG?=
 =?utf-8?B?YzgrVG5VMzRTVWJycHFJcXFJRzVOZnZmNG5WNldTMkVBbTkwYVZvd0E4NHV2?=
 =?utf-8?B?YU5pRllqS2twSTErUDFJQ3dYOUVuRW1OWVVuSzVxSWxlUjFkcE13bGdlVUVB?=
 =?utf-8?B?a2ZSYlh4WlEzWkk3eUdSdU1XdnAxaVRUV1VvYmtJeDMzcFAzM0xXaEthb3hC?=
 =?utf-8?B?TDdHNTdmNTJTMkJKT0cxZ3JLY0Q3bHdrQ2RrblZwWHJMVHNpWEFWNFlWeWlS?=
 =?utf-8?B?eS9LQ0R5L1UyeVlONTZPamZzdWxHd1lZUjNwMXQ4akZWcFpaTndOaSsrcHg0?=
 =?utf-8?B?ZDlpUGpDdDBmYUpyN1ZMU3FXSEw1Yy9naVcwSTNObWhUZER3S0Z0cVpSNE9S?=
 =?utf-8?B?b0drMEFTVEtZVG52SVNwZ0xHWmw4VHZmZ1lJQ0lNelVuR2pZNmduOThRRmVh?=
 =?utf-8?B?UjZQNUVvb1FZV1YvRGhwRU1LOGw3bElYUXhlK2JvRUJTek4yZms2NWdDMklH?=
 =?utf-8?B?SFVTNnFrZjNvaFBxcTl0azZxZTZtZWI5bVNhN2FWb05MYm9ROEpROFJPZTJ0?=
 =?utf-8?B?MDRUei9QYmZLeUJCR2wvUXlOOUdXMTk1MTVvNXhpYnNKbFFsQnM3d2RvNVRv?=
 =?utf-8?B?eGdKUjdVRWovd3NMd0tscUxtNDlDOEMwUDB6bzR0ZUpKVFIrUm5iRThYbGtB?=
 =?utf-8?B?Z2VIbDlaTmFUVnhvN0I1WmNWa0lSSnZxSk1zU2p5TUZreEtkNDFmMDI1d2JU?=
 =?utf-8?B?c01Hak1nQTB3TGJYZW1pdTRUVm9VTitwV2ZwbWNPRUYxc2l1UW1jUnc1S0pD?=
 =?utf-8?B?WmxDY09PK1VJS2c5cEo0MGlQNmJyQ0lwRVpTNjAyMlp0R3dTS0xiODdLYnZD?=
 =?utf-8?B?U1FFak15VElST3hlVWNUdzl4OFFqL09vYnVHdmxmTlQ0UlE2eG45RmIyaDhj?=
 =?utf-8?B?VXlEblZCWkxkeXlGNUtyOUJwZkY5OHp5Q0hZVmtNTGFKUk1YVXFWWERBWWdP?=
 =?utf-8?B?THRGc2M0aHlNaXhhUWt1Sk9SWTNncXdRVjhKbjhGVmtWYlE2SXd1VVJmY0J6?=
 =?utf-8?B?RWZqRCtvazZrbWxNZ2RkVUNFR2xNbm9FYWYxVWV2R1BVN29xT0krWkMwNkJs?=
 =?utf-8?B?bEc1RDdRSVF6ZDluUnRrNVlsSTFtOXVHNWZvMXk0VFYzeGllOWM5QW1IWHJM?=
 =?utf-8?B?RVNTM2JQYmNDQjIzZ0doWUx4OE9xTUo2WmVYWGZtR0FWYzltSm1TWll5em5u?=
 =?utf-8?B?ZFp3ZnBFbHJQVDBlVHdEWGFYYnRiajVPWGhqQXJPT0ptZk9Ra3hUckFIY0s4?=
 =?utf-8?B?ZFRFZzJRZ2t2dnpKSm1iVjJsQmtPQmFlQ1hrK1VjVWNpMnJpWENNdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f5f4b18-b485-4ec3-2633-08dec77efb41
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 06:02:12.9755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BsHITia8B78tQWo5mT54NS+yvgprIuGhNTIGWC7SKDLSMUXs0tAWsvF2XlpxQoo6SCxtl3JMWl+BIpvTwLcycg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7026
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22096-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:jiri@resnulli.us,m:horms@kernel.org,m:sgoutham@marvell.com,m:lcherian@marvell.com,m:gakula@marvell.com,m:hkelam@marvell.com,m:sbhatta@marvell.com,m:bbhushan2@marvell.com,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:enelsonmoore@gmail.com,m:linux-doc@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[google.com,redhat.com,lunn.ch,davemloft.net,lwn.net,linuxfoundation.org,resnulli.us,kernel.org,marvell.com,nvidia.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3888F66EDE3



On 11/06/2026 2:50, Jakub Kicinski wrote:
> On Fri, 5 Jun 2026 21:10:25 +0300 Mark Bloch wrote:
>> devl_register() makes the devlink instance visible to userspace. A later
>> patch also makes registration the point where devlink core may call
>> eswitch_mode_set() to apply a boot-time default eswitch mode.
>>
>> Move netdevsim registration after all objects (resources, params, regions,
>> traps, debugfs etc) are initialized, and after the initial eswitch mode is
>> set to legacy.
>>
>> Move devl_unregister() to the beginning of nsim_drv_remove(), before those
>> devlink objects are torn down. This keeps devlink register/unregister as
>> the notification barrier and makes the later object teardown paths run
>> after devlink is no longer registered, so they do not emit their own
>> netlink DEL notifications.
> 
> This is going backwards. At some point someone from nVidia thought that
> we can order our way out of locking, so mlx5 is likely ordered this way,
> but this must not be required, or in any way normalized.
> We (syzbot) quickly discovered that it doesn't cover all corner cases.
> devl_lock() is exposed specifically to allow the driver to finish
> whatever init it needs without letting user space invoke callbacks, yet.
> Almost (?) all driver callbacks hold devl_lock(), so maybe the devlink
> instance is "visible" to user space but that should not matter.

Let me clarify.

No locking is changed here, and I don't want to make register/unregister
ordering a substitute for devl_lock().

The only requirement I have for this series is that devl_register() is called
only once the driver is ready for devlink core to call eswitch_mode_set().
That follows from the earlier direction to have the core apply the default
mode from devl_register() instead of adding an explicit driver call.

So if the objection is to the commit message wording, I can fix that and drop
the "notification barrier" language.

For unregister, I can probably leave the old ordering as-is. I moved it only
to mirror the register path, which felt cleaner, but it is not required for
the default-mode change and as the lock is held I see no issue with doing
that.

Mark


