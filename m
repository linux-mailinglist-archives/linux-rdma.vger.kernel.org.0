Return-Path: <linux-rdma+bounces-20174-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDHxBeq0/Gm0SwAAu9opvQ
	(envelope-from <linux-rdma+bounces-20174-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 17:51:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 154434EB649
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 17:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4873C300D57B
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 15:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D9741B344;
	Thu,  7 May 2026 15:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MWn3rp4S"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011058.outbound.protection.outlook.com [40.107.208.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584333F0756;
	Thu,  7 May 2026 15:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778169010; cv=fail; b=VAlNgEg81o08Uypy9/04xTkCG2yAf+gYSa5BnFDt/9qMHDErWzbyoMa/gJPFEnq/pe8RyVBJD3esUvMfDJc7tm/IzZ9DTFHYBJC9QWA8PTZYF0x6heQuR5U+HkXJmbVjkHY8oLHcgxlWVVbkIcJJy/lJ2Vg2DrXDuj08elSVh9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778169010; c=relaxed/simple;
	bh=Qg9t+RiZGVa74LmdtPZwwNS1vs7TmwxYqARoS+s1n9Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n1oSWmwzCOy66cLvZr9bGp35XcopqBNgoe3SbYkerJWr9vT8seYwK6UzRUmWjigDY2svJgIgS5WjTI5DJ596bAjzWiCEew38BkE6765/EmwVW1xiBtEhdgsfRW6wtocVh/AAQ1ppEpOA/fyCSAjXmOHqkeTB9quI/JUcbBKVEv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MWn3rp4S; arc=fail smtp.client-ip=40.107.208.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AYqL0vSOu+1d/TEnMlk1hPfY8bfFa2gzscxJ0fh21WsE7AxWAwF5Xs6XBlcdJ27IXtExpx4c2t6FkPkepo5dr95OWbIQSYSumwTX2FYryx15t0WHXNLP0pnPnxOmMyg+32r/GGR2AZdioJGEykP5yLGOIkuEY9ypBPT/BN4lGhQk8x1ShyktwV0iNmc4IAKAjjciJlpxL4MS+yrgKMqCXlKf6xkoaBAGZ8v3XeZmKk5o8HaPymui8shXwD0FETnuP6osvCL19GgmcjtBmc+LO5JCEohfAJ2MlGrhQH87ELRFuxYNLpBcVYjYPSZKFeWCwboixIGwTXOJ8gKanCEfZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XylhRXdQW/m0A75uSsBNHX//7t/OVQIGwmmxfz9E3tE=;
 b=kD99+U6imgu38ihd4WX6+CVXaGgurc23r701hHF1C/Acz8H7AR9MrUN5B0HqrdTsp4kiK/rPzC6Pd1r9ur0l9NXP9P4/UL688ZCo4fJjRrkyZya89ePqXFuAndGIeZsorBAODBrxF6wgiYT9WJgBsl4BrP5CWfjM1HK061wTfF9aAHcLFbVjzl7JYTPMZUcIg/l8Xgnlwp/T0VWD4+iKxHdTI7A65AE9cUa5ODJcj0Vo4waTOEspcZ2LvjbGrT8y1/Y2XgqzOIRxf0ZQ3ovroVQgbImas9sHGLmMgdkQ89uzCkeJJskfHRaDpDv560jTkOwt6OVBVP3UrmbG7CgZdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XylhRXdQW/m0A75uSsBNHX//7t/OVQIGwmmxfz9E3tE=;
 b=MWn3rp4SBi7kZZjwPXJLxsWejXGjNu3PS2rIQ9oFfGt8rwt9UciRDOl8nlK8m5Wy3pAOpKKUMzK7sCqaCtMciUUX/lBQmiGan2pyeNVz8gKYiPVYPcw9fAG1MC6yCnFkYU9h0n656Ksz9Agz0R0BW1DuIWMWeu7IwrjDq879NjZMNRqMGV0IQ+FswNT1svsk4tIWzc7rvM6jIdSLXa5mriDvmG6oJIgCwnF9Q1JxNMtMkm5yaCHD0HrZau5QFF2Dxxx8HM0t8LpYYQgCViJpmsszS1+GkbVhKax6sq/fouAiVuq3L75zVaKBuGgh1Rfnoeu/JjLwHz+XRJg3gUciJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by SA0PR12MB4400.namprd12.prod.outlook.com (2603:10b6:806:95::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Thu, 7 May
 2026 15:50:00 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%7]) with mapi id 15.20.9891.015; Thu, 7 May 2026
 15:50:00 +0000
Message-ID: <b1d3f9bc-a5d7-4236-8bda-49e6327ee533@nvidia.com>
Date: Thu, 7 May 2026 17:49:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V6 2/3] net/mlx5e: Avoid copying payload to the
 skb's linear part
To: Amery Hung <ameryhung@gmail.com>, Tariq Toukan <tariqt@nvidia.com>
Cc: Christoph Paasch <cpaasch@openai.com>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>
References: <20260507095330.318892-1-tariqt@nvidia.com>
 <20260507095330.318892-3-tariqt@nvidia.com>
 <CAMB2axOFQN2f=veYgeJs+4tbZmb9PuNHk03TH_bmE8UL_REd7w@mail.gmail.com>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <CAMB2axOFQN2f=veYgeJs+4tbZmb9PuNHk03TH_bmE8UL_REd7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0131.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::14) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|SA0PR12MB4400:EE_
X-MS-Office365-Filtering-Correlation-Id: 09d40876-d85d-4111-edb2-08deac504b5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	fD11fouTc1Ch1Xx5Aj6v88JqGtnREtSR6KutT39dvF+/tTij3lxS4gZKJiTGTnir3IdAt1zas9JE9csiBw+rHXLFIlvCoUqd88Lhv4xn4NMmGKjA2sktDPv504zucCw0Oev9Prb99Pe7RaOxE4bXpU5wePqPUtqqiUyPfIHl/iZD3sa3x1OqQiBDwTcoLa/Jt2EEj7R+hJfQr6Q4KBQdRDrtvSXWkzPSWfXNEGLaKGY9baUYX8GEoZAgvbjcxG1IfGMrH3cneipG0q+x218aDtVCSQ6vxLJ1oJ4DqomfKgsq4usQxyIMfEOiRIWoNsq3IAOyxHWxXuA4Zrxvj47twClfggA2KCaizgXscDd/2GttVAdvYbaNuRN5d3Q6KZnxw0+mJ09dG6OTEIT/SC3RUcHzq0jmhbs6PgkRFTCgIfYXtNIW0V9eWVvRKK2aZWboCPi1xaaKlTePYDtlBwR1tSJMR1nsKtO4zMXQDP0TPyneoMzhr3rVC0w4KLnU44fLmS+zsPT3k7XMqM6C3Ud0crs2J32r2na/3pYZjbnyTgbIGDnle1eKxjl7xzGThex/gRptlDguVVv5nx5ycXPnCKbXpKuZJ5z2HVRW77cM+5T7c8MRNhK2nGmachCC6OlDYVwteJ0O8tdFy9LC/WItTXYww4xlg5Y/GZrOM9zQlNFdLpSkfZVIkg3AAablrX7x
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmdvaWdFYzFZaVllYm5Beit5di9oQTk1b2s2Q0s0RWpPSTRMNFdyYmZIUWNT?=
 =?utf-8?B?ZXljMXFQZE4xY0g4YjJ2UTFaWURmTzB2MVN4YzlkV0h6MXdWUnkrMlRJK2tY?=
 =?utf-8?B?RlFNVVh4S1ZHOVRvY2JpUTJHZjl1ck5vbDdDM3VjU21YdTVUMzd1QWtyalNr?=
 =?utf-8?B?LzhnSDZMU3dUdngvbkVnT3hweEpoQytUcnVFQ2U2OW1tZ0RodzhKeFJLVGhP?=
 =?utf-8?B?L2tNTDJWZUxYcEh5cSszeEdDT2JpamtMRlozbTNCSGFWcEE1QXphY2VDWnhC?=
 =?utf-8?B?TXBDTWZydU5RZTM4anllREsvVm5ibGVHbzVTbEV0UXNVeERoTnBNbWxrSU9U?=
 =?utf-8?B?RmlaZEQwM2UxYmhNeUkvNkIxQU1WdFFxeExYUGlSS01CcGFpT2NyajZvMWJx?=
 =?utf-8?B?VEJJOHpuMDYxUXNPU1c0L2tibjl4cVFObW9LM2dINCtWREZtTkorODl2cFcz?=
 =?utf-8?B?UDBrUlI4MEJ3RCt3RTY1NllDWlFOUjh4OTk5RlhSUUdpTHh0RndaV2djUkhG?=
 =?utf-8?B?OXphVlhoTkZXWE9IYXM0aS9CcENsYml4amVETEowMUVpcWlrY0FacTZWclpa?=
 =?utf-8?B?bDV4NjdqeDVTc2MzMmtyNy9IRzBYdVN2dnhYYStSWkdsV09Ib0Jud2Y5Zmkv?=
 =?utf-8?B?TmV1QnZEY0dFbVRxemo1L045S0ZSUEQzbE5KMStXcVE1dUcvZHk2bXJRK01Q?=
 =?utf-8?B?cERJY3d6M0tiMWZHSHg2OXB6clVubzNVNnR6Z3NpcFV0MkRBL2lpS0N6TDZG?=
 =?utf-8?B?TDRrWXF4dkJtbWlrT2M0bnNWcXc5bnBCRE15aCtjZG5JQmNlaTBxTlVmVUZT?=
 =?utf-8?B?UWg0MjA3ZmpSdGhuam9mOUcwZSt6Yy9FZTQyRVVvWGZFcjBTYTFxeG1ZVlJ6?=
 =?utf-8?B?Z1lNQkZCVTJwZ1pEM2x4UFVqNHpDNFVpTEhCeVo5OHZYZS9YSGlUUjJobk5W?=
 =?utf-8?B?di8xMW1qbHE5Um1hMGtmdzNJOHNQN2szcEN4bWNzRTJYUjhhSk5SZVBHREY4?=
 =?utf-8?B?ZnRNMDl0OEZ3RzVyZ3EyWHBKcy9FZUM4c1RtSWo3UjdYNEM1b01tRzlKbFBH?=
 =?utf-8?B?S0VSNWJrSGlXa3V3aVMxVkpteFppdzBiWVNLbWplNlFKK1dRMG82d1UwRUlD?=
 =?utf-8?B?V1VTWkM4dXh4MHNPNHFmUUlNTE81dGVQMENPcDV6ZmNhWHNZMjcrblYwNzhK?=
 =?utf-8?B?VUNYRmxjcUdscDEzcE16VkU4TTZhODdlUE1NaEoxb0phN3lkUWVYYVBTSGwz?=
 =?utf-8?B?OWdYV01xZGdrVEZpelREQjJXWDF4bHRURXRiSlZRQm5oR2t5cUduNG9abi9q?=
 =?utf-8?B?blp1Ujl1U0JRTU1QUG1RNTNVOTlQQUhKZlg5MktJMnJqRnhJMHoyeUV5QjV1?=
 =?utf-8?B?c1ZYd0FmNk1iUkFZMXVYbTZLMnJGMW5KMExPaFBPRk5NOCszTEl3aWhiUk1H?=
 =?utf-8?B?SEVwbk4rSUF0cmdHYjc3MENqV1pLY0I3akMyMlhzS1hvbTlnMEdrV05xL3lM?=
 =?utf-8?B?U1FTQlFpU0ZnOW5MR1BEeGkzaUxxN3drb2xPVjhJQzFGNnVPa0Z5Y0hJSVp4?=
 =?utf-8?B?MUZuMmIrSkhRWlR5aVR2RlFkTVF2NG5EN1dHV2NqUTh3Y1Eza25kakY5WUhX?=
 =?utf-8?B?TUpzS1hOSGJ5U3lrL2pEQXpSNmFxbi9TMWJCY1pQakpIMWlDVlhJQlcvY0pE?=
 =?utf-8?B?S01FOUF6M2Vxc2I0ck9wanl4QkVRb0hUeVcrN3ByM3k5TmUwckhZMUc4TTlX?=
 =?utf-8?B?eSsvb1NjT2M1cVh5ZWJVSDJtcW81eDBkcDU2TDJ2VnZFbUI3NTdpQUtXeE15?=
 =?utf-8?B?QUcwN09iamdxZzc4R2Uzc0EwYXhCbUpaRlBjNzBweDIyU0txVXVzZzN2cmJm?=
 =?utf-8?B?MHBXYWE2SzR5c2pQSXlKMW9LUXpOOGsyazBwa0ZxZzhJSlk2eWNmekpzZEtj?=
 =?utf-8?B?ZTJvUWs1aWRxcWtSTHRXN2I4eTJUZUc4VzJIeTFXNW1QYk4vU3FwUEg1RG82?=
 =?utf-8?B?T3pjeTM4eFdKQVdCcUlmODA4clJOOUZGdWpyOWg1ektZRldmOU00VHREUktL?=
 =?utf-8?B?ckxiMWluWE4xQ1oxUHZIOG9pRDJCQnRTM0w3WjBPb1QyNFpRa0dnWjlYR0JV?=
 =?utf-8?B?eU1ja2RmV3V1dUdWL3VFcTFjRm85VGVRS0xVOHU3NVlYVk1zQVVodjIrV0Fv?=
 =?utf-8?B?NWxBNU1IQ1YzUFJ3d2VhMzIyUXBMMVF4NlBTeUFrVUR3NmRPMThmYXJVRUpT?=
 =?utf-8?B?akVjUGFxamlvU0FNS1FGenpBQXFybjNpVE9jdU45VGhhM3R0Z2JFWndPTCtQ?=
 =?utf-8?B?bHdCeHdsRk84K1lFaTZaUG1wN2FpeGZqNnlhQmxaQkFpcjlvTG5wZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09d40876-d85d-4111-edb2-08deac504b5c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 15:49:59.9194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lgYccrc7ppgebBlW+PE0HilGuo3ta2tCpMLLu9RmkxnTEnsuQsyObw28DDRyZkjjflcpDR4y7UCp786tBXMFIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4400
X-Rspamd-Queue-Id: 154434EB649
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20174-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,nvidia.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[openai.com,google.com,kernel.org,redhat.com,lunn.ch,davemloft.net,nvidia.com,vger.kernel.org,iogearbox.net,gmail.com,fomichev.me];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dtatulea@nvidia.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Action: no action


Hi Amery,

On 07.05.26 15:53, Amery Hung wrote:
> [...]
> Am I understanding correctly that the better performance comes with
> the assumption that the XDP does not change headers?
> 
> headlen is determined before the XDP program runs. If it push/pop
> headers, there could be headers in frags or data in the linear region
> after __pskb_pull_tail().
> 
That's right.

>>                         if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags)) {
>>                                 struct mlx5e_frag_page *pfp;
>> @@ -2060,8 +2066,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
>>                                 pagep->frags++;
>>                         while (++pagep < frag_page);
>>
>> -                       headlen = min_t(u16, MLX5E_RX_MAX_HEAD - len,
>> -                                       skb->data_len);
>> +                       headlen = min_t(u16, headlen - len, skb->data_len);
> 
> headlen - len can underflow but will be capped by skb->data_len, so
> this should be okay, right?
It is safe. But it might trigger an extra allocation in the pull when
len > headlen. We could also skip the pull in that case. Or do a
min(headlen - len, min(skb->data_len, MLX5E_RX_MAX_HEAD)). WDYT?

Thanks,
Dragos


