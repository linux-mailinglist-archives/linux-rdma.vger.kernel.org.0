Return-Path: <linux-rdma+bounces-19042-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ME03EPfc02kingcAu9opvQ
	(envelope-from <linux-rdma+bounces-19042-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Apr 2026 18:19:03 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC8F3A5381
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Apr 2026 18:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B623C301706E
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Apr 2026 16:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D8438AC86;
	Mon,  6 Apr 2026 16:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rvo3KqG6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011013.outbound.protection.outlook.com [52.101.52.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F6031D72E;
	Mon,  6 Apr 2026 16:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775492336; cv=fail; b=Ci1JPQUOV8NPi7GeRQ29SlTzO3Iq80I0ReYR5ZFw52QYyKpc1X1yMey5YllgVKux+2K1rPXxMRxtz06hnYgXi5CEfW1flJoowvuvqUZiy0r+cIiFyO2RzuQ/e9Tk7pwqBSulZIZhLVW/0reaq+2faIA+GEeNUYstXpfGU46HZqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775492336; c=relaxed/simple;
	bh=mdaOkNQJ/Z5u2PjntpOhoRYsLXysBplu0uICd57mfzo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XsVgrlMqzfCMJWWPoVro2NDbPg71WEQWPILM1ReWCf7ak8bAwoYKqpONDiahCZSUAePE43EolC51uvDpgPvbhO2tx7EIg0kWtQqvpcDUco8W9lVUrTx4AWivAdELQcsatijtZCx0SfrJ4KPuBar5SPsCB8bNxwesVoyBbYUEucY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Rvo3KqG6; arc=fail smtp.client-ip=52.101.52.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ssOnrSWMZmOI3rIRfMdSRAdCMd9aVvVTxIGB3mR3kb4mYErWlWjvcNXt07uu2cGnS++JmfSnjkXgHgaCZ3dn+O2YmVktKI6v84/T6ztu9bjmFkYKPJJwznmDnvRzyOHpZLlxxZyW4LbxasxPau+3I/sJGMm3J60iBihNrsvPw98+rC+tZmLfTAvCvzySc7cGRueJy21mR6V3vqKeoE4s1AHpBlRXn20H0vS2WXxROENwp3YKk7ueL/XK/w3/kLy6jdzrVICCjGR9szQchisXGQvb1+YFf1UUZ2jAWraVoEOgiXwuJj1CS0lW7Y1uUWLHJ2NVzxf7xKTvB0zCGpYSmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KdACYr36jeR46z0VB/RDqwi1YYEeJM8vdYKOBScNRIU=;
 b=UEv11Dl9swWuyTW4WsULlsV1gOekwu3zkI0s1KKA0hVt2sj5/5Sf4B5c1OyUBheO80Rm/QYlr5USL2ylQP9wlbIvjsxMXiqIp9w3qPqyoa7RB0Ptr0XYQk6/xnN0bzLIWsGm91pGeYCTfoiyTCgZfl9o4t2cP77JCVQ1sf2/IzLDQA6WqtfKjEOVhxcaE66jRytnieWT1FOh4Fa2cuovedehX+nL8SHD/M3+/rw7Bcq1ZOy0Q4/a81baMNtf0zP5gdwomUSzUkhaGWQBn3J3ISRDfqse4MxV3mDOXALhKwrPU6aShkglJjq/cWBy8piqL8d3meKEfQnwHzB3zCc7pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdACYr36jeR46z0VB/RDqwi1YYEeJM8vdYKOBScNRIU=;
 b=Rvo3KqG6m83SATdEPRZhwZKQPG6UN4JI9MC/7OeqkCADapMYlmI81tv1CVDDUKzCtCz3X6VrwJRDfyN8E6In/Ic39WN20rQ9Fv0oZJOY7fyQ+zKl7etS2YON903Pwz3mJ+mnzsanv5NQ51CnjkvNRrezWcyXWuMiKYGFYskfT69+Am1Yxy9hzHDMpzzTGkz1oxT/gP/8mIV8W9QKIShgPELbTYPjxpnJ0Ht7FQ3PAiOD0+A1uzTw+G6jxQqiDn890pTvHXitn1bnESB4etmy3DLTEMpSYzM6VWyF4NAwDhkVpThMR+eCBbhCyvyikJl3hg3zh0qfahi/xWFvJSiPSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY1PR12MB9558.namprd12.prod.outlook.com (2603:10b6:930:fe::13)
 by SA1PR12MB8947.namprd12.prod.outlook.com (2603:10b6:806:386::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Mon, 6 Apr
 2026 16:18:49 +0000
Received: from CY1PR12MB9558.namprd12.prod.outlook.com
 ([fe80::920f:8246:c48b:7ce9]) by CY1PR12MB9558.namprd12.prod.outlook.com
 ([fe80::920f:8246:c48b:7ce9%4]) with mapi id 15.20.9769.018; Mon, 6 Apr 2026
 16:18:49 +0000
Message-ID: <1b91bbf1-9f7e-4551-9f02-91b1858e75fb@nvidia.com>
Date: Mon, 6 Apr 2026 19:18:36 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V4 10/12] devlink: Add resource scope filtering
 to resource dump
To: Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Simon Horman <horms@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>,
 Chuck Lever <chuck.lever@oracle.com>,
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
 Carolina Jubran <cjubran@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Shahar Shitrit <shshitrit@nvidia.com>,
 Daniel Zahka <daniel.zahka@gmail.com>,
 Jacob Keller <jacob.e.keller@intel.com>, Cosmin Ratiu <cratiu@nvidia.com>,
 Parav Pandit <parav@nvidia.com>, Shay Drori <shayd@nvidia.com>,
 Adithya Jayachandran <ajayachandra@nvidia.com>, Kees Cook <kees@kernel.org>,
 Daniel Jurgens <danielj@nvidia.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>
References: <20260401184947.135205-1-tariqt@nvidia.com>
 <20260401184947.135205-11-tariqt@nvidia.com>
 <20260402190219.61ea7da1@kernel.org>
Content-Language: en-US
From: Or Har-Toov <ohartoov@nvidia.com>
In-Reply-To: <20260402190219.61ea7da1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::17) To CY1PR12MB9558.namprd12.prod.outlook.com
 (2603:10b6:930:fe::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9558:EE_|SA1PR12MB8947:EE_
X-MS-Office365-Filtering-Correlation-Id: 0de557a5-a59d-458e-8627-08de93f82fcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Cmj0joJaamYrt3r+oJkkA3/lRDy1Q+oNZKRKPE4h3jahzVtzyzgWR2ucVSMqvWvvBHsOhOXse77OQ+xDffvvK2T/nU7k4oBBgAsYcLx7nhWv2r3+zrAg58NO2S1IwZhBe8TGo189l1+4RbS1qfaJ3Lc3LyMP3f7kn2iUf8Celb0MZ3LbenW1dc+KrM0pJi+Gvd8hXHEflv3ASFdpOaKcm1NxRdiMdgtBEER+jipr8mhFrNT4WyW3ll20aN1hkWQn6Al5T4I9bremaJnQZa7vTHstrxvUf5nqutIi2OAjv1gcCb8bmLLHBHV+oiEr95DsPluhvhbHtzGxVMUOxbqQL0EzNw7BRZe0SIvqSlRgZaM8nhdSocX0xmq3opF4nBcJZnpYIypoomOBFsYWJobpqIORjDMY3khNOQAOR1R1g9Kd6POjBVIJe0jjF91gyxgO8siaBxjiEAs8k5nPHLqtdMT/qhu7lPsWC7KiQR+xpO/C78azrreIFlBoQR4rIgQGnhEEZ2EgjNh7YZkAbkvOz8uqyJshSQXSu6C7tnJfBuVvm+AuEvXu76ZzuhYyRxzh/99GS6D52hwdlh6ETyXTOgph/bqGgv+4PHNUC8Z1pW0wgZQ3Mm6VZetFcIkYJDhqJLYCK8DBUMluTjyDshJaqZH5RcYjS0NPF/Qb3OLtk2ps385PFLZGCYB8RecNjx3mcPXRk4VT9HQmOH3rzNCO5kepVrPx5btLfdd+14BCzxM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9558.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3FUSDc4UHZTRWdTMHIyclgrNEVGRG5OcDZJdE8ydVRGOXhvK0E3akRFbjBi?=
 =?utf-8?B?THJGbDFIdlVucDd0b0xpNlJialBXTy9JS3Rta0krelRuQ3NVWmNLMTdHemRl?=
 =?utf-8?B?L1MwYmZnVTB6S3VXOW4vZDFsdWsyakZYWVlySHMxRGxnWG0wODhtNHhlcm1n?=
 =?utf-8?B?Mkc3Z2owdll1TzVqaXVib2lZYkxpeDJmN0NuV1lmKzhVZ1lHRjhOelZZMkY4?=
 =?utf-8?B?NktsMXJFL0o4ek1LMm1xZXlYSlMwTzA5bkVoUFE4M2hNSGNHWGxsODdRYkYv?=
 =?utf-8?B?UlZQdHRmbHdnZWw3SVhGNmgwaUwvVWZNbkR3MnZLM0NMak5BcUM1U1lSY1BD?=
 =?utf-8?B?UzhVVTU1YjlvWVZadXVuTTZUVG9jUGduUmIrRTZxQU4xa1phemRwcDdiTGVj?=
 =?utf-8?B?ZEowODdmY1A2a2pDbFZqaHBjS2hnc2I4anYySzNJQ2RSTjB3MWpBWkN5YlFX?=
 =?utf-8?B?ak8yQitUM3ZOZEFuRER1aXFvNStIQk9uc3UrdGRZSkpPSWNVQTRRblBPZ09p?=
 =?utf-8?B?R0RaVnVGaHcrSURSZ0hJcnRJdm9WcmxFRmNZd3BoQWFmSHIxT1BNVnpmZzVK?=
 =?utf-8?B?R0FPY3RRN1BrSmxrbjRWbDZNajhyTnp0a01waTlGSlRqczJvYmNmTjVvL2tp?=
 =?utf-8?B?WlQyRVNsM2hZc3FrWDBBcHo5U3J1dVdQam15ZzJSTEJDcVpoN2RkZFhyTjZC?=
 =?utf-8?B?MkZVR25kNmxjbWRwcS9OdFJoUmdZd21qR3ZFUlVMdnd3UmtTOUk4MWpXeUhG?=
 =?utf-8?B?K2tKOHNheDZDM0NSZW1ReWNnVUNkZzBoR0YrKzgrRXVtb2l0NnM3anBGMVcx?=
 =?utf-8?B?U2RDNkF0RzBhcEVwTjVFUDFDT1BQczV2T3ZlTkh4MUsvWTJiYXJvTlBjWnNH?=
 =?utf-8?B?UVdrcHZVUWlhM01tSmFyTlFHd09PeGt6R2tjTDRQdW1RQVBnZ2tjT2JFMTZj?=
 =?utf-8?B?dWppeUtPVzRpVHorcEtZN3BwZDM0LzVtUm8rTkFrSW1JRnkvSWF2aldPYno3?=
 =?utf-8?B?Z1NDcSsvaTVyMTRHS3E5cDI3UHBsOUQwaU0rSmJUTnJxUzl5eit0dW9xekVB?=
 =?utf-8?B?dm4wbk53em9rbWpLYzZsRHdRNmNDcFE1bGtrVk5rQlF5bXE1ZUxnSk1mVmdk?=
 =?utf-8?B?a3ROR3dHRWxaWm9aWmkyMmFHNXNPOVFVN0U1ZEQ3NStLd1U2VmxsWU5CVmQ1?=
 =?utf-8?B?QU5NKzRETy8xS1EvdjJLMGtBcFlKdGJ5MFA4NlI0Z1RMN0tZSDFWWUlHeFcr?=
 =?utf-8?B?S0p1TXlNaDArSWVjall5Y2ZXR1I5SWN0UlQ4QzBXamZIb1VzRXhJenJieWpJ?=
 =?utf-8?B?RkdKSlh2M3Jnc0hqWnEyNWN1bU5tMFpNSEdlUGpSenhkTmVNemZ2NVZwanFB?=
 =?utf-8?B?a2Q5RXFQOGliWVBkVi9GY1hvVkNOamt6a2x6SjZDM0VmWjhOcEw4MDJtWi9R?=
 =?utf-8?B?dHBhcEQ0eWMva3hPSVUvbnkyUURtSWh1T0NTbTU5NFdQMlFrNjYyT0ZCZGpj?=
 =?utf-8?B?c2pQdytGK24vOFJpN3BaMVVaME1GY0VLV1BDOHJjUlFyc3RFdVNWTDZUeDBE?=
 =?utf-8?B?SVJlc21PZHhmd1NwL2tqNjFJaVNpdG1hNk55OWwrRXpDaG9aa2NHK2tjTHlz?=
 =?utf-8?B?TmNQZUk0bjNTSGtvT29sbmkwNTlOMkg1aVpkcU5xM1hQWmZyS1JvaVdpTmRM?=
 =?utf-8?B?eC81RE5NK0xZeHI5UnJDUmZVS0FQbEhwT3lmS0tDMVMxejdoY01LYkpmTktZ?=
 =?utf-8?B?YldnN1ZtR2lpVno3bk5reHVGTFhNc2Q3aEpnblN5MFNPQWNOdHN4Mmt6YXdS?=
 =?utf-8?B?WHJuM0U3aXJHaWNpcm1VejZaTTZVYVVoRFc1VjdEL2x5QXBpWkJYN1VRdFRV?=
 =?utf-8?B?UExlYjViaG1PQmhCOVMxdE55Z1VZcjkyZ3B5VzlBOTN5eEV1NTR5VVZPUndF?=
 =?utf-8?B?c0hSb3hJbmUxZTVFVVNiazl1eTM5L1lkUklTbExpSU9SS3lGM3VtMW1RMXQ4?=
 =?utf-8?B?YnJ2djBudURPaUVKaUhMSDlJYUx5U3lFMnZ0aHdhZ2VFZm9Nc0Q1QkdDVW9S?=
 =?utf-8?B?NXkwOFdrVEpGRlZ1VjRZZGpVUGU5RFFTb2FkREFaWkJoS2RGZGF3M1VtVDMz?=
 =?utf-8?B?bXdnU0dhdFJZaFpOTXdNVlhteEFPSER2N0pSbVVoN2xkanIvZEx1cytoalZI?=
 =?utf-8?B?NUZGelJjTkhoc2h2WnBPNlloR2ZENTA1QVZITks4UGtlN1JWVUVEdUtyak0w?=
 =?utf-8?B?b0tzVWlLWVFxdHFvdHluV0xRaDY2S09zNHdBMlhRbmpRUTBCNEwzcEJ1SE9O?=
 =?utf-8?B?OXVpRzRuVVQwUEVFeDgwUzVsTFNnWXZtOS91aEFhckxxbWYzMW9idz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0de557a5-a59d-458e-8627-08de93f82fcb
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 16:18:49.7543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2pF1q4PV4iS1+vPxuMbOv7YcQcbKZcRK3nNFwycj3q9f8m/DbXWzXxNeFZWsAhzVh3csmRckCEGPUEWoTAEeOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8947
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[35];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19042-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[google.com,redhat.com,lunn.ch,davemloft.net,kernel.org,gmail.com,resnulli.us,lwn.net,linuxfoundation.org,nvidia.com,oracle.com,intel.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ohartoov@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid]
X-Rspamd-Queue-Id: EEC8F3A5381
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 03/04/2026 5:02, Jakub Kicinski wrote:
> 
> On Wed, 1 Apr 2026 21:49:45 +0300 Tariq Toukan wrote:
>> @@ -873,6 +881,16 @@ attribute-sets:
>>           doc: Unique devlink instance index.
>>           checks:
>>             max: u32-max
>> +      -
>> +        name: resource-scope-mask
>> +        type: bitfield32
> 
> no need for a bitfield here, this is a simpler selector
> bitfield is for cases when we need to update some persistent
> state, in that case we want to indicate which bits we intend
> to update:
> 
>          cfg = (cfg & ~bf.mask) | bf.val
> 
> scope is a straight attribute, there's no updating of anything.
> 
> u32 or unit would do

ack, will use u32 for resource scope mask

> 
>> +        enum: resource-scope
>> +        enum-as-flags: true
>> +        doc: |
>> +          Bitmask selecting which resource classes to include in a
>> +          resource-dump response. Bit 0 (dev) selects device-level
>> +          resources; bit 1 (port) selects port-level resources.
>> +          When absent all classes are returned.
>>     -
>>       name: dl-dev-stats
>>       subset-of: devlink
>> @@ -1775,7 +1793,11 @@ operations:
>>               - resource-list
>>         dump:
>>           request:
>> -          attributes: *dev-id-attrs
>> +          attributes:
>> +            - bus-name
>> +            - dev-name
>> +            - index
>> +            - resource-scope-mask
>>           reply: *resource-dump-reply
>>
>>       -
>> diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
>> index 7de2d8cc862f..e0a0b523ce5c 100644
>> --- a/include/uapi/linux/devlink.h
>> +++ b/include/uapi/linux/devlink.h
>> @@ -645,6 +645,7 @@ enum devlink_attr {
>>        DEVLINK_ATTR_PARAM_RESET_DEFAULT,       /* flag */
>>
>>        DEVLINK_ATTR_INDEX,                     /* uint */
>> +     DEVLINK_ATTR_RESOURCE_SCOPE_MASK,       /* bitfield32 */
>>
>>        /* Add new attributes above here, update the spec in
>>         * Documentation/netlink/specs/devlink.yaml and re-generate
>> @@ -704,6 +705,22 @@ enum devlink_resource_unit {
>>        DEVLINK_RESOURCE_UNIT_ENTRY,
>>   };
>>
>> +enum devlink_resource_scope {
>> +     DEVLINK_RESOURCE_SCOPE_DEV_BIT,
>> +     DEVLINK_RESOURCE_SCOPE_PORT_BIT,
>> +
>> +     __DEVLINK_RESOURCE_SCOPE_MAX_BIT,
>> +     DEVLINK_RESOURCE_SCOPE_MAX_BIT =
> 
> do we need this? it's not an attr enum all we care about here is
> the mask, really so just a trailing value which is max real value + 1
> is enough for all users?
> 

ok, can manage without max at all, can manage also without 
DEVLINK_RESOURCE_SCOPE_VALID_MASK

>> +             __DEVLINK_RESOURCE_SCOPE_MAX_BIT - 1
>> +};
>> +
>> +#define DEVLINK_RESOURCE_SCOPE_DEV \
>> +     _BITUL(DEVLINK_RESOURCE_SCOPE_DEV_BIT)
>> +#define DEVLINK_RESOURCE_SCOPE_PORT \
>> +     _BITUL(DEVLINK_RESOURCE_SCOPE_PORT_BIT)
>> +#define DEVLINK_RESOURCE_SCOPE_VALID_MASK \
>> +     (_BITUL(__DEVLINK_RESOURCE_SCOPE_MAX_BIT) - 1)
>> +
>>   enum devlink_port_fn_attr_cap {
>>        DEVLINK_PORT_FN_ATTR_CAP_ROCE_BIT,
>>        DEVLINK_PORT_FN_ATTR_CAP_MIGRATABLE_BIT,
> 
>> +static u32 devlink_resource_scope_get(struct nlattr **attrs, int *flags)
>> +{
>> +     struct nla_bitfield32 scope;
>> +     u32 value;
>> +
>> +     if (!attrs || !attrs[DEVLINK_ATTR_RESOURCE_SCOPE_MASK])
>> +             return DEVLINK_RESOURCE_SCOPE_VALID_MASK;
>> +
>> +     scope = nla_get_bitfield32(attrs[DEVLINK_ATTR_RESOURCE_SCOPE_MASK]);
>> +     value = scope.value & scope.selector;
>> +     if (value != DEVLINK_RESOURCE_SCOPE_VALID_MASK)
>> +             *flags |= NLM_F_DUMP_FILTERED;
>> +
>> +     return value;
>> +}
>> +
>>   static int
>>   devlink_resource_dump_fill_one(struct sk_buff *skb, struct devlink *devlink,
>>                               struct devlink_port *devlink_port,
>> @@ -400,16 +416,27 @@ devlink_nl_resource_dump_one(struct sk_buff *skb, struct devlink *devlink,
>>        struct devlink_nl_dump_state *state = devlink_dump_state(cb);
>>        struct devlink_port *devlink_port;
>>        unsigned long port_idx;
>> +     u32 scope;
>>        int err;
>>
>> -     if (!state->port_number) {
>> +     scope = devlink_resource_scope_get(genl_info_dump(cb)->attrs, &flags);
>> +     if (!scope) {
>> +             NL_SET_ERR_MSG_ATTR(genl_info_dump(cb)->extack,
>> +                                 genl_info_dump(cb)->attrs[DEVLINK_ATTR_RESOURCE_SCOPE_MASK],
> 
> we have genl_info_dump(cb) 3 times here, let's save the pointer
> on the stack to make the lines shorter.
> 

ack

>> +                                 "empty resource scope selection");
>> +             return -EINVAL;
>> +     }
>> +     if (!state->port_number && (scope & DEVLINK_RESOURCE_SCOPE_DEV)) {
>>                err = devlink_resource_dump_fill_one(skb, devlink, NULL,
>> -                                                  cb, flags, &state->idx);
>> +                                                  cb, flags,
>> +                                                  &state->idx);
>>                if (err)
>>                        return err;
>>                state->idx = 0;
>>        }
>>
>> +     if (!(scope & DEVLINK_RESOURCE_SCOPE_PORT))
>> +             goto out;
>>        xa_for_each_start(&devlink->ports, port_idx, devlink_port,
>>                          state->port_number ? state->port_number - 1 : 0) {
>>                err = devlink_resource_dump_fill_one(skb, devlink, devlink_port,
>> @@ -420,6 +447,7 @@ devlink_nl_resource_dump_one(struct sk_buff *skb, struct devlink *devlink,
>>                }
>>                state->idx = 0;
>>        }
>> +out:
>>        state->port_number = 0;
>>        return 0;
>>   }
> 


