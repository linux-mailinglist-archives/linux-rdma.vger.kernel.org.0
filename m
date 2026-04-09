Return-Path: <linux-rdma+bounces-19180-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QC5eJNHo12mrUggAu9opvQ
	(envelope-from <linux-rdma+bounces-19180-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 19:58:41 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EA13CE5F0
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 19:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB34F3009B20
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Apr 2026 17:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E703E0C5D;
	Thu,  9 Apr 2026 17:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eEwC1Fck"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011063.outbound.protection.outlook.com [52.101.62.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDC23B6C01;
	Thu,  9 Apr 2026 17:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775757515; cv=fail; b=LFhFWQ7VRliFnbw2WK7qti+YVk3aM++P8Ho36qKgFHqArj5xXbrBujmKNMUTt4+Er2gfcOsrWZtaj4k0kqz/503sSv7Fl/eroZLd+9zS8knMtFGo4u0c22lLt4rT4i0cz1tWysfhpmyAKFkakYBbZ37nAWs/Pf2L4bCgvXTH7yw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775757515; c=relaxed/simple;
	bh=C2MkhaRjjXhgRuIAt7l02AFjhGu3A18jVwd7srxvNi4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KVCx2DtXuqIJIDI2PVE/y4jCeL8hbDopTr5NAjX8Fpr/Suy+TPAjtVBekTbWeeHvQaKorvdHzQwLFsLNm9BfKwqX2GAa/0RKJOouN3N9OtXu8HIWoeP45IKLxaVbhhGObKrvpMgFP8lz31iWbXuZtePowf1mrLsLB4UqP1d3k8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eEwC1Fck; arc=fail smtp.client-ip=52.101.62.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KiujW6C+hS8IKYMH1y2kdRwM7qC8ItbYenENyuAEiWzacEek9Lqhwkb9oxDbeDibq6gR6TJWSMeFl00+Lp0wVtCxoeL/Zxiu46rnHuFdAKaVGxfDz0myBT/pZq2Oci9yaECi05qjbEPhmoxSFKB+hMoQEUjGICtoFGnhM2LMTomMZvktG+4xrMeQEVZnAHqiWHl0mJU/9qAaqV+/gsz032RekLHUU1kOXwJhUGdv3ov+5alVf92/nSoqfKiP5wr5gJtamLGST+UVxezlbPi3jr98GyO2U8PlBMEFMBQ0BYbXoze/piXwQZeHdWeDpd0pi3q95/7bkktYKIAW3C9qBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2h1riok/It4UZTj4n/1LS5GlMxXRSw8Vlv0eIN2AQtw=;
 b=K8aghVEn7dE68kE/hacymUhpTT/jjibFwz3LREpiTPSWnz8Mm/zUUr2HxKH1Y6gXCJ8GBn/Q/cvo03SAZBcx7q4wUdKKskpnZ4vxoM0VDEuyKD50NOq5sHyA2UEWWwrHaRzp/sUfGRcrxv0xnBGboW54eoJ75jqP1mhjqrbKexeeueEo1Y2IFwThmAJlFN/1rpccXFIP6dJ/H6D855w3ndGUyzDk4j2Octl4lj0AB0wzJ73YqFM+1EN4++1ZQ4ri+WeQYxEbdqXI6nIeU2LM3h9Fi+j5WB6Du+5xzTtLIYu8nvsEt31SXHUxrG0vyMulE7QUY17JYHQnG2fb3WpsXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2h1riok/It4UZTj4n/1LS5GlMxXRSw8Vlv0eIN2AQtw=;
 b=eEwC1FckMk4Y77ibwdqdQIs3reH0UdAowiQsQD+QeouGLL/rumHmXRt38Po/KPgjWPLyZICzn4Gl13B4Py0qHmyGV80dMCuo3O3B+2VfwBOSb0kZ/OLwwiHI2W0/2P9EPbW9zSCEhvqA1WXHAfnW4tTXDeRQ7ELiFARIK6CMTQ5EFmMJY8Nyfqs0R43YB+2ebPO4Y78yWhhxKOO56bG7WZ8hQH3OHfeXWkDGerHa2/N5ktqd6VnZUz03tNFI136W/v9xxTFqnLarMQc7hE+RZSSEISCsDsdxyI/rCsPzBgHBkaDDt7evpiZFBPRkVIhgCK4dR4Ec0yHhY45LrImuWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB7541.namprd12.prod.outlook.com (2603:10b6:208:42f::13)
 by LV9PR12MB9831.namprd12.prod.outlook.com (2603:10b6:408:2e7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Thu, 9 Apr
 2026 17:58:30 +0000
Received: from IA1PR12MB7541.namprd12.prod.outlook.com
 ([fe80::4445:7716:8576:62c7]) by IA1PR12MB7541.namprd12.prod.outlook.com
 ([fe80::4445:7716:8576:62c7%5]) with mapi id 15.20.9769.018; Thu, 9 Apr 2026
 17:58:30 +0000
Message-ID: <bcd32076-5f52-4d8c-81da-7a2aed3990b0@nvidia.com>
Date: Thu, 9 Apr 2026 20:58:26 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/7] net/mlx5: E-Switch, move work queue
 generation counter
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Shay Drory <shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>,
 Edward Srouji <edwards@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>,
 Simon Horman <horms@kernel.org>, Moshe Shemesh <moshe@nvidia.com>,
 Kees Cook <kees@kernel.org>, Patrisious Haddad <phaddad@nvidia.com>,
 Gerd Bayer <gbayer@linux.ibm.com>, Parav Pandit <parav@nvidia.com>,
 Cosmin Ratiu <cratiu@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
 Dragos Tatulea <dtatulea@nvidia.com>
References: <20260409115550.156419-1-tariqt@nvidia.com>
 <20260409115550.156419-3-tariqt@nvidia.com>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <20260409115550.156419-3-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0030.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::16) To IA1PR12MB7541.namprd12.prod.outlook.com
 (2603:10b6:208:42f::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7541:EE_|LV9PR12MB9831:EE_
X-MS-Office365-Filtering-Correlation-Id: f2a75782-78ba-4e64-9f4c-08de96619b81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	zJ6OR0J3e5t/7CICeeaMmPOEGsX6V4euX+19kqdEJhfywusgTIOI3mqr+NSgYi43NmpBqJWJLXn6Q3XcFk5WbSyeP4FrPcUg/5saIjpLQlryNj8ncz2hx77xsknmR8g3XOGjZ2MUEuuJc+AtAueuSJ7jz+hld5Q76M5ZcBxZaUk4sTkjPkyQX5fx/JfzGxHTnYOy8yKi12lDPz7ST0IuiUILIo/dbKsg2+I3bmkus7T7q/pe7jD8ESr8GiOkkh8n9kKW3ST0onProWj6+5Cn2oTgnWBbzjSqH8JqrDHPBb2jpKDaa1hZjoMyQ/D4MhLm4lC3y0waIZgW8ECO+nQURVBF6iU3CQ1CAkv22R4PUdqcs/cSKYDOCIN/3yW5Uhc9xFTErxg5gM5n5Hp+QMbBHfdwWj7ul1n2xoqZBNCJs9KEfIyZWQKjZF7D8oUtE09MuggDBmhlPSU920JcKudfn5lZEsRdIPsz/GvpSpfSyuANVJAbgDR6YqySuZCh5sshd+7YtVgpHBJ5y32B6E1B5rX4KuTjXXlMEgtP4KciWWZY3Ef3uZMnX4ze0n7kEsX6ATOPc7WbrdOLiASdAezSU7q+nJ0EX73fmtYDIuz1FQcLT9hf+kyp8dPIhClqFX8EYTjo4pzB/3CrUdVueFzUCPAZor4/02T3ef8EJ+NW3otWGNB7/JLkGoo1hiq7V1AEtyq4QWTMSu17TXmuqhTbnxQZZj/LA1hTIWXEcLdmjZ8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7541.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmNpNFdrYjJPeWJCcHo1Y0xzdno0L0lUNTc3T3JDL1VaQTMrYVNyQTVVS04z?=
 =?utf-8?B?cVdLRWkvRThHRCs0RVRRakNRdmtYRUl6SDZjbUlFbkc3blpZNWpYV0laQmVU?=
 =?utf-8?B?cE1TVHBiQVRmNWdsZnR3Z1hnM0czVzRlcXBlZEJJL0U3NFpZdFFwR2xXbXRT?=
 =?utf-8?B?V0NEdU84MDlTbHROZ2xiTlFESS9iUFdMR1VqRXRxam5HN1JNY3htN29sWXN4?=
 =?utf-8?B?VFFtQWdxWE5KZ0w0cit1YVFrN0N2SlJaek5wVXB4c2V2T1FWMW5lVDhtZlZr?=
 =?utf-8?B?Uk1TbDRnM0JadzFUL0JXaW5sUVBNN0ljL1N0TEVmYlZtNVJVeDJ3dVlKWktw?=
 =?utf-8?B?aXY1aEM2Zm9kbTd5d2VPMVpDNk5QSE5DRnpNUExYT1QwbjRUb2syZ0ptdjFV?=
 =?utf-8?B?eTRPR0x6RXFXdjlDS1ZQc3ZwTWl5TFBlNjZFTHFKS0ZPWE5qdVpvbGtoUnNN?=
 =?utf-8?B?d0Z0KzRuRFlPdnl3SmFrc3NBVFZRTVRacjVVNlpWL1FObDR6SHdnb0U4ZlIy?=
 =?utf-8?B?QkRNdUxSZHJlV2dGTnYxRUR0ZVB6ajR1ZlpVTmxaUmxrSDhpR1oyK3diMlFn?=
 =?utf-8?B?M3ZFekpERDEyOWZVb0ltQ1ZDMVdFdUhTYmZCbmxMOGFLTHFZLy9YTXRxSmJx?=
 =?utf-8?B?L1BnazJma1dKV1dDM3RMcW5lQ0tOZGlrOUswUkREQngxeFVKZFhubEJvZGJ3?=
 =?utf-8?B?aFNtdm9JUThzcFJVeldSWUZDQnlBOVNpdHFjRnRzMmJ5Z3RKVkNvNFNiL3hI?=
 =?utf-8?B?Z2RoQkFYTXdYKytXL0VQNzRnb3o4VHcxYmRnTWNhRTJPNjFhdVhPWXlaRkc1?=
 =?utf-8?B?R1NzOExuUm12cjk1RGxkSW1vTGJScktlRityaFpUZmZsdG1TMGYxUFZPMFBo?=
 =?utf-8?B?eVR4a2M4V1ZHaGY5a01oV1FESTlUcE9rTWZYejhKOWVvNVF5UStzQzlOSGVn?=
 =?utf-8?B?em1tMkFsNTJYb0czTTUweUJxM0JMaFhyL3NDdm55Q0ZpWm5qcDdLNUtGeG1B?=
 =?utf-8?B?Wm9veTMwV0xBUnBpY3JJUk5hU05Fay9HN0RtTDIwZlBmVGJJQS9QV0NtemE1?=
 =?utf-8?B?TzVJREZrYTF2RGxwWGdSYkw3Rmt2RzZJVGtIT01LdWEzSnBmek12RnJwREFZ?=
 =?utf-8?B?ZzlrYkJjNjcxemFGRmV6MndCOEZwcHZoZ1hjU1FQNFFtRG1CUXo2eUl5SS84?=
 =?utf-8?B?V2JoVWlIOG1ncXBHU21pUTQrN0FaUWhlclV3UTRtYS9wWllZenJ0R1FtaVBi?=
 =?utf-8?B?UDNtSXU2TFBQb3F5RFYxNGhoZHg0MXdkUHFvSWp2UnJ3UGk4SUV1dUJTLzI1?=
 =?utf-8?B?OURRV0c5aGtPSm0vSFVGUUtuZFJKbDJlYTdCVlB0UDU4WTdaSTJRcGw5cGI5?=
 =?utf-8?B?NVNBaUJUYUNRdEo4dWsxclVMVVkzMVMyL01Xa2g4RkM3TXgxRk1LTjNEcHM2?=
 =?utf-8?B?YXViV1l2eitIZnVKZktNUEJUTHhieXpHdTl2Wm84Nkt1aStIM3IvUEU1dHVJ?=
 =?utf-8?B?Y251TUttL3pkUGkvZUdZVG9EUHkzcVZPbmQvNUx6cUpVQUVYTnBMcDVvczBa?=
 =?utf-8?B?eFd3Q1NqNzh1aFZXQzAvU0JRRHpwaHUrZXltb3UrNDNjbXhZZVRSRnNwUkp6?=
 =?utf-8?B?R2IxZmRzWkRHOHF0bFVwQVozbGhsTU5WUWZ1cjAyZDV4N1AybGl3VjFHWXhR?=
 =?utf-8?B?OHpOK3o0eU56eTEvWWs0NG5mUzNSRTdUYWZoRndKUXROSkN6V2F0Y2dhN2gv?=
 =?utf-8?B?dHRRNXc1dGYwQzBPQ0wwQS9HK0kyVnFoMElaUERjMVNiRDZDZ0FNRU80M0hy?=
 =?utf-8?B?WnlPSFhEZGk1dUVlUXdQWDNwS2VIYnUzWFdlOGY4VzFRdXptSmNtTEM4cjZE?=
 =?utf-8?B?dFBvWlZjNG03cFVyVDNqZGQrUEhXRi9iWGErTURXM0JUT0VRQmZWTlNYbkVp?=
 =?utf-8?B?bDYvbktFdE41Z3E2SXNqRlhac0lnOGd5YVovYlcrUlhzM0Fjc1d2dGkxbDd2?=
 =?utf-8?B?aXh5UXlEYllHVjRSZ3lGOXZ2STdGVXRIMUpTZVRTVUFDNXVKSEJtT1h1Zkp3?=
 =?utf-8?B?VXJnSWt3bWZzRWdpOHNSSys1R1pzSW51bmNtSG1hSDgrQUpPa2Z1M1BLSXlP?=
 =?utf-8?B?dlJERVRjaXZWbHArT2xTRlZPTmo1UVVaSjdLK2JNbHpOaXROWWF0aU9qd2JV?=
 =?utf-8?B?cG15NjZCZW1SYmtBY3B2THc2ZzJHTUJsWkRRY1hoL25vUUhIaEZ3czN2eFIx?=
 =?utf-8?B?N2ZRS0dJTlFvWDdIVXhZWnEyY0cxS0doQ3cwZWFLRW1HZ3ozQjZubmZ5S2RY?=
 =?utf-8?B?R1Y5aldBaWNLTWFXbVJKdElQV1JRUmw3QTE0ejFLdEo0U1lkZU96UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2a75782-78ba-4e64-9f4c-08de96619b81
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7541.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 17:58:29.9644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TREhFxF39HBav8lGKavjBAPU1rLxhPkqy78enoOUpKNAnKxNPlIXICo7fs3jMPaekO3EUjG2wOzxQh7AnnIj+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9831
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19180-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[25];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E1EA13CE5F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 09/04/2026 14:55, Tariq Toukan wrote:
> From: Mark Bloch <mbloch@nvidia.com>
> 
> The generation counter in mlx5_esw_functions is used to detect stale
> work items on the E-Switch work queue. Move it from mlx5_esw_functions
> to the top-level mlx5_eswitch struct so it can guard all work types,
> not just function-change events.
> 
> This is a mechanical refactor: no behavioral change.
> 
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/eswitch.c          | 3 ++-
>  drivers/net/ethernet/mellanox/mlx5/core/eswitch.h          | 2 +-
>  drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c | 4 ++--
>  3 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
> index 123c96716a54..1986d4d0e886 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
> @@ -1075,7 +1075,7 @@ static void mlx5_eswitch_event_handler_unregister(struct mlx5_eswitch *esw)
>  	if (esw->mode == MLX5_ESWITCH_OFFLOADS &&
>  	    mlx5_eswitch_is_funcs_handler(esw->dev)) {
>  		mlx5_eq_notifier_unregister(esw->dev, &esw->esw_funcs.nb);
> -		atomic_inc(&esw->esw_funcs.generation);
> +		atomic_inc(&esw->generation);
>  	}
>  }
>  
> @@ -2072,6 +2072,7 @@ int mlx5_eswitch_init(struct mlx5_core_dev *dev)
>  	mutex_init(&esw->state_lock);
>  	init_rwsem(&esw->mode_lock);
>  	refcount_set(&esw->qos.refcnt, 0);
> +	atomic_set(&esw->generation, 0);
>  
>  	esw->enabled_vports = 0;
>  	esw->offloads.inline_mode = MLX5_INLINE_MODE_NONE;
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
> index 5128f5020dae..0c3d2bdebf8c 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
> @@ -340,7 +340,6 @@ struct mlx5_host_work {
>  
>  struct mlx5_esw_functions {
>  	struct mlx5_nb		nb;
> -	atomic_t		generation;
>  	bool			host_funcs_disabled;
>  	u16			num_vfs;
>  	u16			num_ec_vfs;
> @@ -410,6 +409,7 @@ struct mlx5_eswitch {
>  	struct mlx5_devcom_comp_dev *devcom;
>  	u16 enabled_ipsec_vf_count;
>  	bool eswitch_operation_in_progress;
> +	atomic_t generation;
>  };
>  
>  void esw_offloads_disable(struct mlx5_eswitch *esw);
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> index a078d06f4567..b2e7294d3a5c 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> @@ -3667,7 +3667,7 @@ esw_vfs_changed_event_handler(struct mlx5_eswitch *esw, int work_gen,
>  	devl_lock(devlink);
>  
>  	/* Stale work from one or more mode changes ago. Bail out. */
> -	if (work_gen != atomic_read(&esw->esw_funcs.generation))
> +	if (work_gen != atomic_read(&esw->generation))
>  		goto unlock;

Sashiko writes:

> Does this generation counter pattern allow stale work to bypass the guard?
> While this issue seems to have existed before this patch, it appears the
> notifier can execute concurrently with the teardown path, creating a race
> condition.
> If a concurrent hardware event triggers mlx5_esw_funcs_changed_handler() on
> another CPU during mode teardown:
> 1. The teardown path calls mlx5_eswitch_event_handler_unregister(), which
>    unregisters the notifier and increments esw->generation.
> 2. mlx5_eq_notifier_unregister() removes the callback but does not
>    synchronize with currently executing RCU readers.
> 3. The concurrently running notifier reads the newly incremented generation
>    number via atomic_read(&esw->generation) and queues host_work with it.
> 4. The worker thread (esw_vfs_changed_event_handler) blocks waiting for
>    devl_lock(devlink), which is currently held by the teardown thread.
> 5. Once teardown finishes transitioning to legacy mode and drops the lock,
>    the worker resumes and checks the generation.
> 6. Since both the work_gen and esw->generation match the newly incremented
>    value, the guard is bypassed.
> Because teardown set esw_funcs.num_vfs = 0 but firmware might still report
> new_num_vfs > 0 (as VFs remain active), the worker calls
> mlx5_eswitch_load_vf_vports(). Could this execute offloads-specific
> initialization while the eswitch is in legacy mode and lead to state
> corruption?

False positive, atomic_notifier_call_chain() runs under rcu
read lock, while atomic_notifier_chain_unregister()
performs a synchronize_rcu() before returning.

Mark
>  
>  	new_num_vfs = MLX5_GET(query_esw_functions_out, out,
> @@ -3729,7 +3729,7 @@ int mlx5_esw_funcs_changed_handler(struct notifier_block *nb, unsigned long type
>  	esw = container_of(esw_funcs, struct mlx5_eswitch, esw_funcs);
>  
>  	host_work->esw = esw;
> -	host_work->work_gen = atomic_read(&esw_funcs->generation);
> +	host_work->work_gen = atomic_read(&esw->generation);
>  
>  	INIT_WORK(&host_work->work, esw_functions_changed_event_handler);
>  	queue_work(esw->work_queue, &host_work->work);


