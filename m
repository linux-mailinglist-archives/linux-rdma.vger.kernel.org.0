Return-Path: <linux-rdma+bounces-22490-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AgumENx6PmpCGwkAu9opvQ
	(envelope-from <linux-rdma+bounces-22490-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jun 2026 15:13:00 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 856056CD532
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jun 2026 15:12:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=CJb6eX3x;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22490-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22490-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B8A193014E6F
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jun 2026 13:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6A93F58C7;
	Fri, 26 Jun 2026 13:12:43 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010071.outbound.protection.outlook.com [40.93.198.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE73F3F20FC;
	Fri, 26 Jun 2026 13:12:41 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782479563; cv=fail; b=SDjtBogDxkSvvaOpdSP9E/bgH20tz1fXwxhowT3N1J/KdZebL/F48QzCktc01hYnai1uRxpODAlleDQP5UXJFlhjPbaeZC/wbJBIEkCpptNC/uI+J9dw2NSJ0a5ag/SGD/uX/HqHFerkvAv9I3dE+wT6RnQCmFbbGXiC3SheroA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782479563; c=relaxed/simple;
	bh=0DTMRVTk0yZ4AkFJVsdC/Rvro4lDD3Vqh4ppnviC0G4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B0Cyl761i9IAv4Zo3aFM200zA+FVMvwrEW8xgGH9EmppxriheKPDYc1C4yglyzXbt3wDh2SYWDunIpBaaRzcNuk0hbsf7WzPhEshigS1p3Hy5WgRtgMJpXYfdKYFxOpkeCj0dsK8+yStbc5HSRBsdK6/LPE21Docdo35QNJtKMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CJb6eX3x; arc=fail smtp.client-ip=40.93.198.71
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s8iN37Y+/xXMNSJRx8pywazh0t/3YFFEJkRwdQr1/Lyc/tPKoxUiyeoXmEZIPMhHpy6SlT/TLHC0rJnHPXI9nGfdSrlRUR8bMFL9BoR0xdJnP+NYMVtBbHVZEuTLf+3tBIz6YQq0JFAzR/OF9I94PoV9sZqQaFqfYrSDVkWjVo/N6rHe37URmZe9VjRlByv/zxzNJZAgjTBXz8e/qcvu9zMO7AULhn96b1GpNtzXITYLxguJN1TxuLWVA3h2rWlsU+LxzdhsDHShYz0bQT4jWm0OYqXagI3YnVkTynuHGmkxqyffUPdHL/z2pXcl4wt2t4dhFp7jqW3AsqbKAH4uTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+F4Xl6umgrjYHIzKus4lq2NGdcpkRAcnJv+iP2GEceE=;
 b=zV1vb2X9YBTkLOGl6veKjGOtvsdFSKU96s8utzoyfM1nZ0lOTkHYQXCyp3gDkt2Sg6fidAB3P3HjrREe9qw0PWDGnWt+YFUALIsD892pYpQzL+TSR7+qru0i61/XKqfIyuD8bZkwZNfnJD2BNfcr3a+2TG7/BPDX1w89cGjtTr4H/s84thgrdqTOe2NZerhGVCWi1qsRtdlzCFmLgeE5Q5uf8j3Ic6yIa0nVsnFnY4ilQg/G2xGq+Km8KW1yD2Sga/OpW2W/P+kcHblgI2WIEyFWXM3efjZFH/Y3XIB1PGDN8flGsbmSrJD4Z32KX/eyhb1VlQrTO4jwillZH0yYwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+F4Xl6umgrjYHIzKus4lq2NGdcpkRAcnJv+iP2GEceE=;
 b=CJb6eX3x/LKRkBbaBr5JSKkwiYsieVmz1pxnOnraBV8Dha8ZHZm33Ucyi83pXqbNp9P+2H0eqMsGZ+G9zZIV2iMzpy7zTWI4S7wx5kuYqSNGFllCeqGH8A7S4sum9c9t5NkrLW6oJtO+m6ED6eZA09aluFwAd0BppDyXaSG1khBU++tqcH0hSDdsPezLGVH7dK42cmzkpc9KScTsylnyriqsGb7Grifw7gmBo/IAUSNJceTx+yGBd7PAszrLBl8aMEN7fNTW4GPOWJBJwZ7cwOKDHaEl0vwLB/kQOBfeBxI4FBeCU7SgIz31pJtI+GTxsYR4vYui4HEpmhvjV3i6Tg==
Received: from IA0PR12MB8716.namprd12.prod.outlook.com (2603:10b6:208:485::18)
 by MN2PR12MB4272.namprd12.prod.outlook.com (2603:10b6:208:1de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 13:12:37 +0000
Received: from IA0PR12MB8716.namprd12.prod.outlook.com
 ([fe80::c18d:8eab:b36c:32da]) by IA0PR12MB8716.namprd12.prod.outlook.com
 ([fe80::c18d:8eab:b36c:32da%5]) with mapi id 15.21.0159.015; Fri, 26 Jun 2026
 13:12:37 +0000
Message-ID: <9f150145-d95c-4a90-a358-5b33ab78a8ef@nvidia.com>
Date: Fri, 26 Jun 2026 15:12:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [mellanox/mlx5-next RFC 1/1] net/mlx5: RX, Fix refcount warning
 on frag page release
To: "Nabil S. Alramli" <dev@nalramli.com>, saeedm@nvidia.com,
 tariqt@nvidia.com, mbloch@nvidia.com
Cc: nalramli@fastly.com, leon@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260625174059.2879717-1-dev@nalramli.com>
 <20260625174059.2879717-2-dev@nalramli.com>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <20260625174059.2879717-2-dev@nalramli.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0344.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::7) To IA0PR12MB8716.namprd12.prod.outlook.com
 (2603:10b6:208:485::18)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8716:EE_|MN2PR12MB4272:EE_
X-MS-Office365-Filtering-Correlation-Id: f63ee67e-124a-4217-6210-08ded38497cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|6133799003|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	HscfMr22GdRDgGFAwogt6KPYU4BEISkwHVPPashSRGJO9W2FsNniXCdwawG3ys82vtVYetBG/uHwUaoM+fwtH1UAKGjJu9WJDJC4nF3TVlK6rN65kd7Pej5EBz/knamiNnPQidCtYPh7zC0LEvnn2PQ+UJGxPsLjFa/5O89zqzekfEJxujaaLQuLWvfH6fKUF39Q4Y0Lay2X01EmQIRTojqsn+g75WMlUzGNw6T5OgFaoN8uZ5Ri0/+2/CHoouGyRRZN53M1ZzXjFdVL0STnIV6OcxbWxnIInyLCtonBcT2gpP0H8eCQeQ9cA5jHkDajAY6jRgdGue29AKsi6VNJd41OpzXEqMPMGgs0/WtoNYWNlVlRfrksikyHs5JUdrBWnE1pfU0lRNNaNeaATtqVWAOVTfFdAONIxCuDSxTEHRRD8jKVe8/L7+pi6vuiPe81HlQELWYcs5KTFrPMg2dMKi6X7XbOI2rrAwZV2YP5fd9b2watVoVdJ9Wbp3yWYBOJ0778B5OIPYv38/P5LpolUuwg4CIHj//EtlRSkCaT+6/1xHPsU/HI4aF5ZI/6qxq5RjX66xmA3eQpB9mnx6pp2+9S8w5MrO9f1g2xOj7Mu/pArw1Un8uyZ0Bv2oj7JYEKQhLU6QUM7Wag5WpLUjGfy7wgRLUPHLKn2T3X+ZTOL3k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8716.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S00yR3oxeHIrclRSZWkyaklFWWE3OHNqYUJpY1BGdjdWSjl3cE1pcVVXM2tO?=
 =?utf-8?B?N3I1QjRmTkpBTk50NDQ3bnlOaXp6NFlEcC9EZzd0Y2FqNUd4QXNSbllocENk?=
 =?utf-8?B?TjQ4M3I3TkxDRmh0Wnpma3Ftb05QY3dDN2MrVXlSczFmYnBsTjBIRWIzdFow?=
 =?utf-8?B?QXA0aW1peVlmcHNCUGt2Nm03RmYrcCt0NkcwOElCeFpHUld0SXlxR3dad1pi?=
 =?utf-8?B?N1hyQlpWa1JFWXRJdkwybERsMFNGTnhnR3U4a0hBaDhKU1ZwSWpZeElQQSsw?=
 =?utf-8?B?UjdIUHVDZ29pQk5idjdRZlkwYUowaVVUajRlVWF6SGZZVEs5WEFld3l1ckhH?=
 =?utf-8?B?ODVhRHEvV3g4NEtHcXFSald0aTVHOHdjTEJyUnJURGJDTWtENkkycDA3eTNR?=
 =?utf-8?B?VysrMUZEaVVXNzg5cGtCQ0tCNnl0NWZIbS9nZUxkbC9yeENRNWVTUVAwVEsr?=
 =?utf-8?B?NUNhc08xaGpLNFBJaU9ES0o5WTBFT2JCUHlQSThnem5JWjdxZVF2ZWNKNWxC?=
 =?utf-8?B?cVZ1ZGlENHZBOTFGazNoaytqWWx4TkJ6UmRjNlhoYlB0TnZ6ZUVKaVFNYkc4?=
 =?utf-8?B?SmFvaGFFZDRYV3FibVdYS0RGOXd6ZHh2RG1LM1ovNGhKY0FXeHBrZXdIai9a?=
 =?utf-8?B?YTZJalZ5U3o0M0VIUzhTQTBqUmdjZnNoa3I5dGpVYXRSTTk1RGZLRjJPdGx4?=
 =?utf-8?B?WElmY0p5bDNvdWFLMWtCTElIcEkyQ0pSK0w3eUdPUzBrZ3YreE83NVVONWsz?=
 =?utf-8?B?eWhwVTFJbnR1T3UxNi9EejVoNzNtUTU5VEY4ZUoyQUt1Y2hLUWo1N3FTZk5C?=
 =?utf-8?B?V2EzM3lqTlkvZTI1MVBwTEJ0K0pHeGJ5T0FXRmVZclJMczJ1MTF0MDJERzdT?=
 =?utf-8?B?em5sSytUZmpkK3F1L2ZxdnR1WVZCeFVyMUJhWU1qQVZXdmQ0cXRkVTBVVXRS?=
 =?utf-8?B?WkdnQ2FWWWJTY0pQajRmU3kzREhJN2NNNkJYaHQ4bzhYK0p0V1RDOExWYnJw?=
 =?utf-8?B?Y0FKdTVyaytIWjg0Q3g4VUJURFo4eVNmMVlmTVlKeE5mL1Q1dWJJUWVzVkgy?=
 =?utf-8?B?MUczWEdLeE54bFR2dVlKWDVLZWxoNEY2QmFwM1h4cEM1WkRaQVl4YXdrS004?=
 =?utf-8?B?K2ltM28xTXVVeFBrbWJJUmdHVEZGSnlQZTF2QmV1WFpJd2E0VGlCS2NpY0hK?=
 =?utf-8?B?VHV4a1o5bjVOWnU3VitSUThpQVB0UGkvQ1l0WnFNYUJreXg5V3FaQTJrVHhk?=
 =?utf-8?B?R3Vid0VpQkJUNlIxcjhPSTdTSGIxYklJSWY5cStRSHZGZC9pVGRzc3FzVDU2?=
 =?utf-8?B?T2ZqaW1RT2l0bFZHekZjYWNVODRUcStOaXovRjZjVjhNSlJDQmVUZ0ZOdENY?=
 =?utf-8?B?eDBKcTg2MzJhZHI4c1p1eFZhM1F5NVRJUncwWmllZ1BOSFoycHN0dmEyY1FJ?=
 =?utf-8?B?OEl2eWp6K1B3OXpHRVdaTVNyTWdJZGtyL3RBSFIrbTJ4MG41cGFhUjVkSVYv?=
 =?utf-8?B?ZXRTTVNCZmpMa0xiam1UMGV1NHNhTHFxRW15bEJNMmorVnNVZ0FSTFNzUjh1?=
 =?utf-8?B?UWlQR0hoQ3p5bGc3dXdVMkRPT2M1MXdtaTBKMjNFSHdLV3IwRWlDZnYzN21t?=
 =?utf-8?B?cUV4UmZxVno3TFJ5Y04rTHJLVk9TZkdmdXZwVTNwaXUyRnA0bFdJOFM2Q2Vq?=
 =?utf-8?B?MDI1cnAwTldKNllsTzl5YWVlS1hFQnBxNG0yREVtaVByUEhBVTdXbklMano4?=
 =?utf-8?B?OUsySktJM0xkYmkzbDU4RjErMGdRVzFRZmJGdThxT2ZqSzYvdFUxUk5vcXJV?=
 =?utf-8?B?ZkFOM1oyN3VVSXd5Ly9mTUQyVHlYbnEzV3IzempGSERBRHR4TEExa2JzRlpR?=
 =?utf-8?B?dUJ3cm9SSlluRXZtRWR1Z2VUWGJ2SGhTWWI1dXRLVy9qUlIwVzVxVHlBdmNS?=
 =?utf-8?B?cW51Q2NaNWVnUDJCUHVhUEN2bFVYdEtnYU1IRGplNHBRaFpWT1d6NHdzemJk?=
 =?utf-8?B?RWQ5L2tWUVEyazlIdFlZYXN5bnFzYW12ZXNXamRreDJIOE9IMkh3TVVCZ0sx?=
 =?utf-8?B?ZmFsaXA2VnNqRHU4NTVPaHBjVEJiLzVHODZOMXMzY1NlcEh6N25xQmlTeGg3?=
 =?utf-8?B?UnB6RzgxWlI5RzJ2MFNjQnhrSkt6L1pUTVJLOXp0YUREM0tMUjZRcUJhZGY3?=
 =?utf-8?B?ZnNkSE5FQW14VzJIUzdzY3JYeERnK0FYNWphRXBjVndlcTlnZjd0ZWhodEVu?=
 =?utf-8?B?WHZ4SnFCN1RLNWpUWEdCYWhQKytuaXZDS3VnN1doVGZUbWpvR1ZNWC9yK2lm?=
 =?utf-8?B?TmVzS1FrZlNaTnRtcUthSHJtVXBCWWlSOEJWSEhUd0x4eVFZcFM1dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f63ee67e-124a-4217-6210-08ded38497cb
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8716.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 13:12:37.2224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y2pmb4MsqlWAzokBHjaPDR5xzQfCG50CALwa8Un9rxnTXnTVqd82mT1TDEdzJnWegR6ort/ClD0iGPwO/fYtbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4272
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22490-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[dtatulea@nvidia.com,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dev@nalramli.com,m:saeedm@nvidia.com,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:nalramli@fastly.com,m:leon@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dtatulea@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 856056CD532



On 25.06.26 19:40, Nabil S. Alramli wrote:
> Under memory pressure, mlx5 driver has WARNING during fragmented page
> release. This happens because there is a discrepency between what mlx5
> thinks the page fragment counter is vs what the page_pool actually says it
> is.
> 
The mlx5 frag counter is not the same as pp_ref_count. The page gets
split into 64 parts during page allocation. The frag counter tracks how
many of those frags have been used.

> The cause of the issue is page allocations on concurrent cpus, which
> increment the non-atomic u16 page counter mlx5e_frag_page.frags, while at
> the same time the page reference counter net_iov.pp_ref_count is atomically
> incremented. That sometimes leads to a difference in the counts and
> therefore triggers the warning in page_pool_unref_netmem:
> 
page_pool page allocations must not happen in parallel on different CPUs.
Each queue has its own page_pool and allocation happens within the NAPI of
that queue which sticks to a single CPU. The release path does support
releasing on another CPU (release to ring).

How did you encounter this scenario of having parallel allocations on
different CPUs from the same page_pool?

> ```
> 	ret = atomic_long_sub_return(nr, pp_ref_count);
> 	WARN_ON(ret < 0);
> ```
> 
> The actual stack trace looks like this:
> 
> ```
> WARNING: CPU: 37 PID: 447795 at include/net/page_pool/helpers.h:277 mlx5e_page_release_fragmented.isra.0+0x51/0x60 [mlx5_core]
> Tainted: [S]=CPU_OUT_OF_SPEC, [O]=OOT_MODULE
> Hardware name: *
> RIP: 0010:mlx5e_page_release_fragmented.isra.0+0x51/0x60 [mlx5_core]
> RSP: 0018:ffffc90019814d98 EFLAGS: 00010293
> RAX: 000000000000003f RBX: ffff88c0993d0a10 RCX: ffffea02424592c0
> RDX: 0000000000000001 RSI: ffffea02424592c0 RDI: ffff88c090e20000
> RBP: 000000000000000a R08: 0000000000001409 R09: 0000000000000006
> R10: 0000000000000000 R11: ffff88c095fbc040 R12: 000000000000141f
> R13: 0000000000000009 R14: ffff88c090e20000 R15: 0000000000000001
> FS:  00007f34149fa6c0(0000) GS:ffff89200fa40000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ed0265eb000 CR3: 0000005091cbe000 CR4: 0000000000350ef0
> Call Trace:
>  <IRQ>
>  mlx5e_free_rx_wqes+0x7b/0xa0 [mlx5_core]
>  mlx5e_post_rx_wqes+0x1ac/0x5a0 [mlx5_core]
>  mlx5e_napi_poll+0x5e5/0x6f0 [mlx5_core]
>  __napi_poll+0x2b/0x1a0
>  net_rx_action+0x30e/0x370
>  ? sched_clock+0x9/0x10
>  ? sched_clock_cpu+0xf/0x170
>  handle_softirqs+0xe2/0x2a0
>  common_interrupt+0x85/0xa0
>  </IRQ>
>  <TASK>
>  asm_common_interrupt+0x26/0x40
> RIP: 0010:page_counter_uncharge+0x34/0x90
> RSP: 0018:ffffc900e728bb00 EFLAGS: 00000213
> RAX: ffff88aff4762000 RBX: ffff88aff4762100 RCX: 0000000000000304
> RDX: 0000000000000001 RSI: 00000000004e9e1a RDI: ffff88aff4762100
> RBP: 0000000000000001 R08: ffff891ea0560048 R09: 00007ffffffff000
> R10: 0000000000001000 R11: ffff891ae8061b00 R12: ffffffffffffffff
> R13: ffff89107fcfd4c0 R14: ffff891ae8061b00 R15: ffff892002fe1400
>  uncharge_batch+0x40/0xd0
> ```
>
Can you provide more data on how you reproduced this? This helps to
narrow down the bug. Reproduction steps would be ideal.

> The fix is to use an atomic page fragment counter, so it will always match
> the number of references held in the page_pool.
>
This is not the right fix. The mlx5 page frag counter is not atomic
on purpose because all changes to it happen only within the NAPI
context.

Thanks,
Dragos

