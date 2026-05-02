Return-Path: <linux-rdma+bounces-19863-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJ3qKyZZ9mn2UAIAu9opvQ
	(envelope-from <linux-rdma+bounces-19863-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 02 May 2026 22:05:58 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCBB4B35BD
	for <lists+linux-rdma@lfdr.de>; Sat, 02 May 2026 22:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87C63300EF8F
	for <lists+linux-rdma@lfdr.de>; Sat,  2 May 2026 20:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F143876D5;
	Sat,  2 May 2026 20:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nAvMr8++"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013013.outbound.protection.outlook.com [40.93.201.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF58533D51A;
	Sat,  2 May 2026 20:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777752329; cv=fail; b=UJuftINGneNLUDb/67q95ufH+ZVBJWGW80MFQtfUHiA5jRNdwnMzPYVL8YeKtNzOo//9HnWkIeb+8/6dG1xUDXgSU/KxmGKWAI6XEw/EoG37H/My2wrt09rG7+EXpi7l/RNMqS0qz19l+gNY7qtjYObAfbVcD5TbEbMsVfPhOY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777752329; c=relaxed/simple;
	bh=Tz2p5by9xTvmbtJo0LhHu2+9sj262XzRvahhEt1lAdM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cT0J+uTiQ93EPNCqWiXQSNVRP0ylWRCSQ+hz+aqdwSbfYnIVkbvZe76H7wC27QQYkpy0eye2YcvsmVtZnCD3yyRjsoo3C/bgPWQUxpMiMu0WXCyrW9mh3E1C2yf2Y1pLTHY1EVFFBEyw+eLASrJTL79sYFTo36VAkCBd6Cocc8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nAvMr8++; arc=fail smtp.client-ip=40.93.201.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N2i/lNYbubh3FpBBM/SH6/UFRMjPWHMHDTEkLhTvd8Nmbw6TvGnDh6jtatcvCKRaykSCvplUbmtq4x2K+BTd0FI+3BepfB1sEYsnttKgehNHIJAKzcoMDmOUoWOyIKQ11WE+JFQPuk5b+kvt00g370NO0h8EPiEX5gGOO/0fS9C8I/gbTYWd8DUyk483c8pst1Qw1qrMOEEGbWT8cbTF52buQK/dQ21DkesEIzkvJbHuC4f2gsD0hAkM0LfGP21nBYaem5Lo+XSOz8uNDRDkfEBIOSn5IZysUKEEf3xHBWiuNv3JH/O6DUMe54u8iYGI0aYh1+YBYX8Pk2GlxXW76w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ACb3+bGhuVJAtxPauI7761GY9jSBWseaE4ORYKjEqCI=;
 b=VsEGQXfV2JSUBv2DV+TTpom+gWyivf0XGHe1+cgBCcCXXVM89Jp3vkpy5kPVO/GvfC19+RwDiUBEPG7TZRQrN3Hfao0CH5ptWrhxQM0+cPP7tjG+RVROsrVvekbswmKOP5O3ZtF2h9tVhkSFYDnvI0DVYU+OXb2dmN8APysGNi9PDMtwBIFNdcKSFUw5oqbRcGvMfxZd3Qog4HyoD50NhmSo4JK06ZSIXuesWZJ9jSAiE2Tz9W/8Ban+RPEOlZ4mwknCgHzkUfdn73k8ipHfuwHcxXOIZvt35pPFYBteUcScddhMjZU5VCFnOic8RCDw1oQGzbcdBWXkg2av8pyiQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACb3+bGhuVJAtxPauI7761GY9jSBWseaE4ORYKjEqCI=;
 b=nAvMr8++24kvkfcCsF/uPB2MuIIMcYf0xY56QePq06ESIDRMG24czjmkz/kG43G8xJ3XytfDtZsz7HOuvpzIeFz6af6IahQyUpgvGFBoVjymSPr331tnB+CpPwC+6fCNxKtVsvX2X01zZXwlReou0eva9AXP5AIKuMLGWlzMt+RSK6NlianZFU1MFD918nPcBxH5pJq6Yl/3f6TQYnGZ9KB2Uvkx8AEDcrMLD2Y74BGEx1G7GzJ9AXOUuN2nd73CuiL55T5/envxkWq9KGfiObQcUABttwcx8rNCHjWaCZGetgtUD1Xd5MzRl0dx9qyVfsL2ugFt9OkKtSQqvaDTsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CY5PR12MB9055.namprd12.prod.outlook.com (2603:10b6:930:35::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.23; Sat, 2 May
 2026 20:05:23 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.20.9870.023; Sat, 2 May 2026
 20:05:22 +0000
Message-ID: <706b58a3-16b3-40ea-ac29-a6fb83fa76fd@nvidia.com>
Date: Sat, 2 May 2026 23:05:18 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 4/7] net/mlx5: E-Switch, serialize representor
 lifecycle
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Saeed Mahameed <saeedm@nvidia.com>, Shay Drory <shayd@nvidia.com>,
 Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji <edwards@nvidia.com>,
 Maher Sanalla <msanalla@nvidia.com>, Simon Horman <horms@kernel.org>,
 Gerd Bayer <gbayer@linux.ibm.com>, Moshe Shemesh <moshe@nvidia.com>,
 Kees Cook <kees@kernel.org>, Patrisious Haddad <phaddad@nvidia.com>,
 Parav Pandit <parav@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>,
 Cosmin Ratiu <cratiu@nvidia.com>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
References: <20260501041633.231662-1-tariqt@nvidia.com>
 <20260501041633.231662-5-tariqt@nvidia.com>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <20260501041633.231662-5-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0046.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::20) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|CY5PR12MB9055:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f0109e6-c90f-4e3b-7ef1-08dea8862498
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Jyf0nFK1rDJHdha6TKZ6R28q4PRDJMUuwbc47blDfPX/v/wLOwZgWJJWjjBSMHGNK9PVltdQrDJymVHZe92lORWK5yDi/D+4wuWQHqzjsoS1sTBqko9uq+XRfV4xcaFx2MyxJoVERrg2jQE3N68nr9rk0oOzl3mID+12DN0NwT6g/KX5QXvp/MrP1b/aQWPGLPbQ5X/vRLs74uo/Io/dFtKbEK3TRwvxRAffIM5eDqnNF0/KvyfzjJ2K7gjDDMTq6g7T3x7a5Af7hWEGJ5kAtCNSiT6XBPseiruRKs9DrZdGJYhkhQfcy/gmmnyeWAHMVTOA2ZKqy5R5rjDE/qtnrIKpXs/xQocswSP2r85Lzq7lscSVWLzxVTaZOKwADha/EdtoJL1O6pjFdnFP6g3tunJg3JyI9KjchbEYntOzEJfxoImgTjkPNvt4JZi7I/xqg5yTOcrks2I/dULTMAkpdj57GqM9sFRFVah0RuVyzSngc6A4MVj0j0JuG74WOX/4srDIj0Ywya0QtQwTaIFlpbnQzm3T8l0FOQC8xw9mT8Od8knzwvEuwBHc3Rf2eweIzvpa5aBm0JjrykKAFmTS11yI9c9j+BkMo3Eqb8iUMFQ8dmpz/J7ap6ooWV9HgHXuUIhw6a55b92dWO8NoFRJr/A/z0XhGNtIb1adG/rEAwLbJDePa+Rh1i8pCJG1V1Vv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnQ4WGx2VlNXOWhKQ3M1aW1rR2dyQm50NERzT3JsajBMY25VYTk2OHQ5cmkr?=
 =?utf-8?B?SHdiLzR2OHQxQUhkS0hJWWNQU09QN2V4S1ZOVndkbWg3dDczTGtTVDNTVDJv?=
 =?utf-8?B?ZmRtZzBxcTNiZHNub1loM3YxNHgwMXh6QTloWWgxSUR4TG0rTE12WEt5SXQ3?=
 =?utf-8?B?NnNDLzRjOWlHSWMrL0x1dE9LTWVDSzFUcHZnZzZ4QW4vZE91VXNUR0RHbWsv?=
 =?utf-8?B?djVyYmVjKzhjRDh3bmZtM2Q4UEdVN3gwL0ZXQy9QSzZQbUJYWjNtaTN6aE1J?=
 =?utf-8?B?amM4K2h1ZEhOOEsyL1lXVkEzeGRRUTNDV2MybXNyUXpNYWVKZ2JRZlJybXBM?=
 =?utf-8?B?cEFBVHF2WHZGTmZDMDJua0FnbXhCbkFtcXhJcWtBZ2lZakN1OWtvYmRkR0d1?=
 =?utf-8?B?NzFteDkxeXVXN0Y5V2VrN1hEOFZFTkh2ZmNzL0sxdTBzQkV3ZCs4bVdpeU9h?=
 =?utf-8?B?MlFwTWNWUE1ESndUZGpoRGZ0a1poUFZaQUZ0WjhkOTgyVFNpb3lUajNVNldI?=
 =?utf-8?B?Z3BqZWVtUWpyWkozUE9lS2xvOTJUNW1RSUROUEJmQ1ZGS0lGNW5uSzJiK1ND?=
 =?utf-8?B?VmpzMVdNWUFJcUlhZ0NOdlpaWFZVNEIveWxxaDFGVnBOQkFkcTdrejQxVzZ2?=
 =?utf-8?B?eVRIaWl4M1Vqc1h5SkszcFA4WTBOWm5GKzlsc2xFK1Qvbmh5bWx1SGxRV3ph?=
 =?utf-8?B?ZmZxNTEzQmhVaXZXdWd3SjdseVh0VFcvVmdMMGVvZ0RUQ0tWN0M1NkRESCti?=
 =?utf-8?B?WUpacUlRbG5UNklLZFlQa3d6Vm5wbFNweHlGYktoWXRuYmU5UUNVcjBnc1dj?=
 =?utf-8?B?VCswSjZpeWFtVC9TUHJDSXZvM3JnQnMzcFVKOGNmMEJMb3dCZWdWUmFmY0RL?=
 =?utf-8?B?M3B1SVY1eVd6c1dwa2I5UHVPWWlOUEJFKzVrRDRuSFdVWk8wZHh2VzV1b3RS?=
 =?utf-8?B?dHE2ckxRM0FxdnU3V25ZVWVobzNYNzBFa3ZpVlREbE1SNnZab0pyOFl5dVFZ?=
 =?utf-8?B?aHlDdDVnLzcyNTZCRjBNL1EvNVJHanYvdzFLSkZuTHpjdEZkVmw4K3JCYVVK?=
 =?utf-8?B?NERFN2I2cDhpVVhTaEF1STVnWkN0eXZNNWkrWU9IWDc3T096SGQ3Y0J5Rmhj?=
 =?utf-8?B?K2VEdXFpc1Q1VHRGQ3lVRkVZaHFKMThmRWNsVnNmRjhrRndHckhUdlBBQmJC?=
 =?utf-8?B?bWRqNnUyZzA0YzA1NXVnajZzK1NTNjZaY0s2WlBZV2U3Q0dTMGYxcVcwM1N6?=
 =?utf-8?B?aDBUeEY5K0tkeTdwU1FTeGkxbGxtY0FXVXF3c1BtMjA5RTN2dnlQU0FVM0Nl?=
 =?utf-8?B?VjdMK0Uyb29zT1A2TWNEK0JWM2xZcmV2MCtCZE4vR1hHM1RUMFJPdFl2Y0o2?=
 =?utf-8?B?cDk1Szh0OTNVVTdFQWdDRmdqa0xvR1k1WWswaGtKTTIvM2xnRVpkbmRna01x?=
 =?utf-8?B?cW1zSGhJUzhnOE1LbjFQSzY1WWJFcmdxb1kxdjF6VGx2K2tqVVRuWklhK0F6?=
 =?utf-8?B?V2RReWNRVU1HTmhsSThrTC9TSDlweEdhdHM3UXhVWjN0SFdMZXBkSHhLYjQ2?=
 =?utf-8?B?YzFJTkdBNDJQT3o3U0pzRGtuQkFrb0FiZm1hWGRjU1JvZTY2OUNUOHZPNXBP?=
 =?utf-8?B?S3c0RUdrdnRqWXBJaVNwb1N4OEErUCtPTElWeGtlcllzYlpaRHQ1MUtTRUZn?=
 =?utf-8?B?alF3aFlGTnRUb3RuZEdkN29yc1FZZFAydTlIbHUycEpURGVkeG1hUmxHV2FB?=
 =?utf-8?B?SXNDVUZPSjlVT2FLTUorRTYra294aWdQQ0l1RlcxYXE1ejlDVDdPZHUyVFRs?=
 =?utf-8?B?cDNkaTIrVjZFZXM2ZTZDY2kyVEVwQ2lkSUIzNVpqb2dscnFqZUUvOVFEejN4?=
 =?utf-8?B?b0FvcHk2UnU1ell2VEtGOXZBd2RxeVFCTjdpQngxcVFoSHJSdnNDUEtEQ0pu?=
 =?utf-8?B?ZnJ6dUlzcXhZTVlsMFBDZXhENThhTlU0ODgwTmlxUys2MDh1alloMmZ2MDNU?=
 =?utf-8?B?dWsxM0Y3NTNxcENRc29XVG1TTG1lM1U3N3pOK2VmZjVFd0ovWFFwd1RwUEJ6?=
 =?utf-8?B?SWFlZFVORGFFWGtwc2J1T3F5TUZxaEQzdkR0aTVtekQ3ZGFzNHQwVFlKNkxN?=
 =?utf-8?B?ZjlUM20xT0NDbWpmL2p2V2x5NkkzR3pETG9yeGt0YnVzTXhaLytQa1ZFZHZl?=
 =?utf-8?B?NmkzaVhoY2tvSTQ2WUozU2MrTThZUm4zWkUwQVZzRDJLa2lFNjJXK3JpQ0pY?=
 =?utf-8?B?cnJLaG9zWVlEeTBpNTNhQlRYQzlNNENzWnpCU1lPSGpoN0JnYlQ4ZUp2bGpG?=
 =?utf-8?B?aHpKMU1OSHpjL1ZXdXZmcmxNWlp1cUtrcE1BcGw0bG9KTHpjZzV5UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f0109e6-c90f-4e3b-7ef1-08dea8862498
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2026 20:05:22.8830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qrOGjWkEKgLAFGNyLLvmyFtgvFvd05yZIvmTkE/0lcpmKgGLy/2vLTypG7Z4z65MC9rntzESPlM6+BGTN2Idpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9055
X-Rspamd-Queue-Id: 5BCBB4B35BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[26];
	TAGGED_FROM(0.00)[bounces-19863-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]



On 01/05/2026 7:16, Tariq Toukan wrote:
> From: Mark Bloch <mbloch@nvidia.com>
> 
> Representor callbacks can be registered and unregistered while the
> E-Switch is already in switchdev mode, and the same E-Switch may also be
> reconfigured by devlink, VF changes and SF changes. Serialize these paths
> with the per-E-Switch representor mutex instead of relying on ad-hoc bit
> state and wait queues.
> 
> Take the representor lock around the mode transition, VF/SF representor
> changes and representor ops registration. Keep mode_lock and the
> representor lock unnested by using the operation flag while the mode lock
> is dropped. During mode changes, drop the representor lock around the
> auxiliary bus rescan because driver bind/unbind may register or unregister
> representor ops.
> 
> Split representor ops registration into locked public wrappers and blocked
> internal helpers, clear the ops pointer on unregister, and add nested
> wrappers for the shared-FDB master IB path that registers peer
> representor ops while another E-Switch representor lock is already held.
> 
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/ib_rep.c           |   6 +-
>  .../net/ethernet/mellanox/mlx5/core/eswitch.c |  10 ++
>  .../mellanox/mlx5/core/eswitch_offloads.c     | 102 ++++++++++++++++--
>  .../ethernet/mellanox/mlx5/core/sf/devlink.c  |   5 +
>  include/linux/mlx5/eswitch.h                  |   6 ++
>  5 files changed, 119 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/ib_rep.c b/drivers/infiniband/hw/mlx5/ib_rep.c
> index 1709b628702e..65d8767d1830 100644
> --- a/drivers/infiniband/hw/mlx5/ib_rep.c
> +++ b/drivers/infiniband/hw/mlx5/ib_rep.c
> @@ -262,9 +262,10 @@ mlx5_ib_vport_rep_unload(struct mlx5_eswitch_rep *rep)
>  			struct mlx5_core_dev *peer_mdev;
>  			struct mlx5_eswitch *esw;
>  
> +			/* Called while the master E-Switch reps_lock is held. */
>  			mlx5_lag_for_each_peer_mdev(mdev, peer_mdev, i) {
>  				esw = peer_mdev->priv.eswitch;
> -				mlx5_eswitch_unregister_vport_reps(esw, REP_IB);
> +				mlx5_eswitch_unregister_vport_reps_nested(esw, REP_IB);
>  			}
>  			mlx5_ib_release_transport(mdev);
>  		}
> @@ -284,9 +285,10 @@ static void mlx5_ib_register_peer_vport_reps(struct mlx5_core_dev *mdev)
>  	struct mlx5_eswitch *esw;
>  	int i;
>  
> +	/* Called while the master E-Switch reps_lock is held. */
>  	mlx5_lag_for_each_peer_mdev(mdev, peer_mdev, i) {
>  		esw = peer_mdev->priv.eswitch;
> -		mlx5_eswitch_register_vport_reps(esw, &rep_ops, REP_IB);
> +		mlx5_eswitch_register_vport_reps_nested(esw, &rep_ops, REP_IB);
>  	}
>  }
>  
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
> index 66a773a99876..f70737437954 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
> @@ -1712,6 +1712,7 @@ int mlx5_eswitch_enable(struct mlx5_eswitch *esw, int num_vfs)
>  		mlx5_lag_disable_change(esw->dev);
>  
>  	mlx5_eswitch_invalidate_wq(esw);
> +	mlx5_esw_reps_block(esw);
>  
>  	if (!mlx5_esw_is_fdb_created(esw)) {
>  		ret = mlx5_eswitch_enable_locked(esw, num_vfs);
> @@ -1735,6 +1736,8 @@ int mlx5_eswitch_enable(struct mlx5_eswitch *esw, int num_vfs)
>  		}
>  	}
>  
> +	mlx5_esw_reps_unblock(esw);
> +
>  	if (toggle_lag)
>  		mlx5_lag_enable_change(esw->dev);
>  
> @@ -1759,6 +1762,7 @@ void mlx5_eswitch_disable_sriov(struct mlx5_eswitch *esw, bool clear_vf)
>  		 esw->esw_funcs.num_vfs, esw->esw_funcs.num_ec_vfs, esw->enabled_vports);
>  
>  	mlx5_eswitch_invalidate_wq(esw);
> +	mlx5_esw_reps_block(esw);
>  
>  	if (!mlx5_core_is_ecpf(esw->dev)) {
>  		mlx5_eswitch_unload_vf_vports(esw, esw->esw_funcs.num_vfs);
> @@ -1770,6 +1774,8 @@ void mlx5_eswitch_disable_sriov(struct mlx5_eswitch *esw, bool clear_vf)
>  			mlx5_eswitch_clear_ec_vf_vports_info(esw);
>  	}
>  
> +	mlx5_esw_reps_unblock(esw);
> +
>  	if (esw->mode == MLX5_ESWITCH_OFFLOADS) {
>  		struct devlink *devlink = priv_to_devlink(esw->dev);
>  
> @@ -1825,7 +1831,11 @@ void mlx5_eswitch_disable(struct mlx5_eswitch *esw)
>  
>  	devl_assert_locked(priv_to_devlink(esw->dev));
>  	mlx5_lag_disable_change(esw->dev);
> +
> +	mlx5_esw_reps_block(esw);
>  	mlx5_eswitch_disable_locked(esw);
> +	mlx5_esw_reps_unblock(esw);
> +
>  	esw->mode = MLX5_ESWITCH_LEGACY;
>  	mlx5_lag_enable_change(esw->dev);
>  }
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> index 6a5143b63dfd..d4ac07c995b9 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> @@ -36,6 +36,7 @@
>  #include <linux/mlx5/mlx5_ifc.h>
>  #include <linux/mlx5/vport.h>
>  #include <linux/mlx5/fs.h>
> +#include <linux/lockdep.h>
>  #include "mlx5_core.h"
>  #include "eswitch.h"
>  #include "esw/indir_table.h"
> @@ -2413,11 +2414,21 @@ static int esw_create_restore_table(struct mlx5_eswitch *esw)
>  	return err;
>  }
>  
> +static void mlx5_esw_assert_reps_locked(struct mlx5_eswitch *esw)
> +{
> +	lockdep_assert_held(&esw->offloads.reps_lock);
> +}
> +
>  void mlx5_esw_reps_block(struct mlx5_eswitch *esw)
>  {
>  	mutex_lock(&esw->offloads.reps_lock);
>  }
>  
> +static void mlx5_esw_reps_block_nested(struct mlx5_eswitch *esw)
> +{
> +	mutex_lock_nested(&esw->offloads.reps_lock, SINGLE_DEPTH_NESTING);
> +}
> +
>  void mlx5_esw_reps_unblock(struct mlx5_eswitch *esw)
>  {
>  	mutex_unlock(&esw->offloads.reps_lock);
> @@ -2425,21 +2436,22 @@ void mlx5_esw_reps_unblock(struct mlx5_eswitch *esw)
>  
>  static void esw_mode_change(struct mlx5_eswitch *esw, u16 mode)
>  {
> +	mlx5_esw_reps_unblock(esw);
>  	mlx5_devcom_comp_lock(esw->dev->priv.hca_devcom_comp);
>  	if (esw->dev->priv.flags & MLX5_PRIV_FLAGS_DISABLE_IB_ADEV ||
>  	    mlx5_core_mp_enabled(esw->dev)) {
>  		esw->mode = mode;
> -		mlx5_rescan_drivers_locked(esw->dev);
> -		mlx5_devcom_comp_unlock(esw->dev->priv.hca_devcom_comp);
> -		return;
> +		goto out;
>  	}
>  
>  	esw->dev->priv.flags |= MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
>  	mlx5_rescan_drivers_locked(esw->dev);
>  	esw->mode = mode;
>  	esw->dev->priv.flags &= ~MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
> +out:
>  	mlx5_rescan_drivers_locked(esw->dev);
>  	mlx5_devcom_comp_unlock(esw->dev->priv.hca_devcom_comp);
> +	mlx5_esw_reps_block(esw);
>  }
>  
>  static void mlx5_esw_fdb_drop_destroy(struct mlx5_eswitch *esw)
> @@ -2776,6 +2788,8 @@ void esw_offloads_cleanup(struct mlx5_eswitch *esw)
>  static int __esw_offloads_load_rep(struct mlx5_eswitch *esw,
>  				   struct mlx5_eswitch_rep *rep, u8 rep_type)
>  {
> +	mlx5_esw_assert_reps_locked(esw);
> +
>  	if (atomic_cmpxchg(&rep->rep_data[rep_type].state,
>  			   REP_REGISTERED, REP_LOADED) == REP_REGISTERED)
>  		return esw->offloads.rep_ops[rep_type]->load(esw->dev, rep);
> @@ -2786,6 +2800,8 @@ static int __esw_offloads_load_rep(struct mlx5_eswitch *esw,
>  static void __esw_offloads_unload_rep(struct mlx5_eswitch *esw,
>  				      struct mlx5_eswitch_rep *rep, u8 rep_type)
>  {
> +	mlx5_esw_assert_reps_locked(esw);
> +
>  	if (atomic_cmpxchg(&rep->rep_data[rep_type].state,
>  			   REP_LOADED, REP_REGISTERED) == REP_LOADED) {
>  		if (rep_type == REP_ETH)
> @@ -3691,6 +3707,7 @@ static void esw_vfs_changed_event_handler(struct mlx5_eswitch *esw)
>  	if (new_num_vfs == esw->esw_funcs.num_vfs || host_pf_disabled)
>  		goto free;
>  
> +	mlx5_esw_reps_block(esw);
>  	/* Number of VFs can only change from "0 to x" or "x to 0". */
>  	if (esw->esw_funcs.num_vfs > 0) {
>  		mlx5_eswitch_unload_vf_vports(esw, esw->esw_funcs.num_vfs);
> @@ -3700,9 +3717,11 @@ static void esw_vfs_changed_event_handler(struct mlx5_eswitch *esw)
>  		err = mlx5_eswitch_load_vf_vports(esw, new_num_vfs,
>  						  MLX5_VPORT_UC_ADDR_CHANGE);
>  		if (err)
> -			goto free;
> +			goto unblock;
>  	}
>  	esw->esw_funcs.num_vfs = new_num_vfs;
> +unblock:
> +	mlx5_esw_reps_unblock(esw);
>  free:
>  	kvfree(out);
>  }
> @@ -4188,9 +4207,14 @@ int mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
>  		goto unlock;
>  	}
>  
> +	/* Keep mode_lock and reps_lock unnested. The operation flag excludes
> +	 * mode users while mode_lock is dropped before taking reps_lock.
> +	 */
>  	esw->eswitch_operation_in_progress = true;
>  	up_write(&esw->mode_lock);
>  
> +	mlx5_esw_reps_block(esw);
> +
>  	if (mlx5_mode == MLX5_ESWITCH_OFFLOADS &&
>  	    !mlx5_devlink_netdev_netns_immutable_set(devlink, true)) {
>  		NL_SET_ERR_MSG_MOD(extack,
> @@ -4223,6 +4247,10 @@ int mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
>  skip:
>  	if (mlx5_mode == MLX5_ESWITCH_OFFLOADS && err)
>  		mlx5_devlink_netdev_netns_immutable_set(devlink, false);
> +	/* Reconfiguration is done; drop reps_lock before taking mode_lock again
> +	 * to clear the operation flag.
> +	 */
> +	mlx5_esw_reps_unblock(esw);
>  	down_write(&esw->mode_lock);
>  	esw->eswitch_operation_in_progress = false;
>  unlock:
> @@ -4496,9 +4524,10 @@ mlx5_eswitch_vport_has_rep(const struct mlx5_eswitch *esw, u16 vport_num)
>  	return true;
>  }
>  
> -void mlx5_eswitch_register_vport_reps(struct mlx5_eswitch *esw,
> -				      const struct mlx5_eswitch_rep_ops *ops,
> -				      u8 rep_type)
> +static void
> +mlx5_eswitch_register_vport_reps_blocked(struct mlx5_eswitch *esw,
> +					 const struct mlx5_eswitch_rep_ops *ops,
> +					 u8 rep_type)
>  {
>  	struct mlx5_eswitch_rep_data *rep_data;
>  	struct mlx5_eswitch_rep *rep;
> @@ -4513,9 +4542,40 @@ void mlx5_eswitch_register_vport_reps(struct mlx5_eswitch *esw,
>  		}
>  	}
>  }
> +
> +static void
> +mlx5_eswitch_register_vport_reps_locked(struct mlx5_eswitch *esw,
> +					const struct mlx5_eswitch_rep_ops *ops,
> +					u8 rep_type, bool nested)
> +{
> +	if (nested)
> +		mlx5_esw_reps_block_nested(esw);
> +	else
> +		mlx5_esw_reps_block(esw);
> +	mlx5_eswitch_register_vport_reps_blocked(esw, ops, rep_type);
> +	mlx5_esw_reps_unblock(esw);
> +}
> +
> +void mlx5_eswitch_register_vport_reps(struct mlx5_eswitch *esw,
> +				      const struct mlx5_eswitch_rep_ops *ops,
> +				      u8 rep_type)
> +{
> +	mlx5_eswitch_register_vport_reps_locked(esw, ops, rep_type, false);
> +}
>  EXPORT_SYMBOL(mlx5_eswitch_register_vport_reps);
>  
> -void mlx5_eswitch_unregister_vport_reps(struct mlx5_eswitch *esw, u8 rep_type)
> +void
> +mlx5_eswitch_register_vport_reps_nested(struct mlx5_eswitch *esw,
> +					const struct mlx5_eswitch_rep_ops *ops,
> +					u8 rep_type)
> +{
> +	mlx5_eswitch_register_vport_reps_locked(esw, ops, rep_type, true);
> +}
> +EXPORT_SYMBOL(mlx5_eswitch_register_vport_reps_nested);
> +
> +static void
> +mlx5_eswitch_unregister_vport_reps_blocked(struct mlx5_eswitch *esw,
> +					   u8 rep_type)
>  {
>  	struct mlx5_eswitch_rep *rep;
>  	unsigned long i;
> @@ -4525,9 +4585,35 @@ void mlx5_eswitch_unregister_vport_reps(struct mlx5_eswitch *esw, u8 rep_type)
>  
>  	mlx5_esw_for_each_rep(esw, i, rep)
>  		atomic_set(&rep->rep_data[rep_type].state, REP_UNREGISTERED);
> +
> +	esw->offloads.rep_ops[rep_type] = NULL;

sashiko.dev says:
"
Could this assignment cause a NULL pointer dereference in concurrent readers?
In mlx5_eswitch_get_proto_dev(), the state is checked before accessing the ops
pointer without holding reps_lock:
    if (atomic_read(&rep->rep_data[rep_type].state) == REP_LOADED &&
        esw->offloads.rep_ops[rep_type]->get_proto_dev)
        return esw->offloads.rep_ops[rep_type]->get_proto_dev(rep);
If a thread in mlx5_eswitch_get_proto_dev() evaluates the state check to true
and is then preempted, can the unregister path execute and set rep_ops to NULL?
When the preempted thread resumes, it might dereference the now-NULL pointer.
Also, since the ops pointer isn't fetched into a local variable using
READ_ONCE(), could the compiler emit multiple loads, further widening the
race window?
"

The REP_LOADED check is not the only protection here, get_proto_dev() 
is only reached from representor-owned contexts, and unregister first
unloads all reps under reps_lock. That unload tears down the users
that can call into this helper before the state is set to REP_UNREGISTERED
and before rep_ops is cleared. So clearing rep_ops does not create a new
live-reader window; it only removes the stale ops pointer after the
representor lifecycle is already quiesced.

Mark

> +}
> +
> +static void
> +mlx5_eswitch_unregister_vport_reps_locked(struct mlx5_eswitch *esw,
> +					  u8 rep_type, bool nested)
> +{
> +	if (nested)
> +		mlx5_esw_reps_block_nested(esw);
> +	else
> +		mlx5_esw_reps_block(esw);
> +	mlx5_eswitch_unregister_vport_reps_blocked(esw, rep_type);
> +	mlx5_esw_reps_unblock(esw);
> +}
> +
> +void mlx5_eswitch_unregister_vport_reps(struct mlx5_eswitch *esw, u8 rep_type)
> +{
> +	mlx5_eswitch_unregister_vport_reps_locked(esw, rep_type, false);
>  }
>  EXPORT_SYMBOL(mlx5_eswitch_unregister_vport_reps);
>  
> +void mlx5_eswitch_unregister_vport_reps_nested(struct mlx5_eswitch *esw,
> +					       u8 rep_type)
> +{
> +	mlx5_eswitch_unregister_vport_reps_locked(esw, rep_type, true);
> +}
> +EXPORT_SYMBOL(mlx5_eswitch_unregister_vport_reps_nested);
> +
>  void *mlx5_eswitch_get_uplink_priv(struct mlx5_eswitch *esw, u8 rep_type)
>  {
>  	struct mlx5_eswitch_rep *rep;
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
> index 8503e532f423..2fc69897e35b 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
> @@ -245,8 +245,10 @@ static int mlx5_sf_add(struct mlx5_core_dev *dev, struct mlx5_sf_table *table,
>  	if (IS_ERR(sf))
>  		return PTR_ERR(sf);
>  
> +	mlx5_esw_reps_block(esw);
>  	err = mlx5_eswitch_load_sf_vport(esw, sf->hw_fn_id, MLX5_VPORT_UC_ADDR_CHANGE,
>  					 &sf->dl_port, new_attr->controller, new_attr->sfnum);
> +	mlx5_esw_reps_unblock(esw);
>  	if (err)
>  		goto esw_err;
>  	*dl_port = &sf->dl_port.dl_port;
> @@ -367,7 +369,10 @@ int mlx5_devlink_sf_port_del(struct devlink *devlink,
>  	struct mlx5_sf_table *table = dev->priv.sf_table;
>  	struct mlx5_sf *sf = mlx5_sf_by_dl_port(dl_port);
>  
> +	mlx5_esw_reps_block(dev->priv.eswitch);
>  	mlx5_sf_del(table, sf);
> +	mlx5_esw_reps_unblock(dev->priv.eswitch);
> +
>  	return 0;
>  }
>  
> diff --git a/include/linux/mlx5/eswitch.h b/include/linux/mlx5/eswitch.h
> index 3b29a3c6794d..a0dd162baa78 100644
> --- a/include/linux/mlx5/eswitch.h
> +++ b/include/linux/mlx5/eswitch.h
> @@ -63,7 +63,13 @@ struct mlx5_eswitch_rep {
>  void mlx5_eswitch_register_vport_reps(struct mlx5_eswitch *esw,
>  				      const struct mlx5_eswitch_rep_ops *ops,
>  				      u8 rep_type);
> +void
> +mlx5_eswitch_register_vport_reps_nested(struct mlx5_eswitch *esw,
> +					const struct mlx5_eswitch_rep_ops *ops,
> +					u8 rep_type);
>  void mlx5_eswitch_unregister_vport_reps(struct mlx5_eswitch *esw, u8 rep_type);
> +void mlx5_eswitch_unregister_vport_reps_nested(struct mlx5_eswitch *esw,
> +					       u8 rep_type);
>  void *mlx5_eswitch_get_proto_dev(struct mlx5_eswitch *esw,
>  				 u16 vport_num,
>  				 u8 rep_type);


