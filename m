Return-Path: <linux-rdma+bounces-20296-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NrVDeEqAGpkDwEAu9opvQ
	(envelope-from <linux-rdma+bounces-20296-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 08:51:13 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A6C502D81
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 08:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9396A300E179
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 06:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1052D35E93E;
	Sun, 10 May 2026 06:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q+CiIJo9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012006.outbound.protection.outlook.com [40.107.200.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511A52571C7;
	Sun, 10 May 2026 06:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778395867; cv=fail; b=B8zGh5t2Xh+RQHkBDsbaCvvOqgpIBayBDAQspUtNWUFrykALe37fJ1Tfr//Vrhos0U+g1SQQ/Wq44ZAWP4Hq7gaKRIbCAe05KTCfsVmqgyLKF6eNmwfyagW/VbDclxvHiIdxpelGXcSyyn1ILZcU9k060PoHwf89fIdJIbWPFiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778395867; c=relaxed/simple;
	bh=prP9+9ygAiMuieiCvIzBdOdrlNSw4I3EH4xM1U1BQQs=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dY7FDW8d59C0leCRiYE3h8KlPttyhCnXnF8yfb7WWJUAWYwp4OH8iQNusUOvj1UMFTaGmzqbxwD+mFYg9E13VpEhPpncNviJcI2jMCvgs6UaDex7AOf0ohgE9koOjcpsM0KUXx8h7oTM4y+Js2/GQ02dIQkaTfkIYIDHoj6kWiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q+CiIJo9; arc=fail smtp.client-ip=40.107.200.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hW+fhudGXSydSMmoMwXFuv2ZQ4bnKoxXnhfPDtBo+uEzg6nN0nAG84ScZ/5qRB6yCzZNRyx+bxKKTRO2S8+A0WP4sl37rwlRcNUH1ia1g0Fs6i8et6zq99kU7J9NCuryAMmCGYZ5mtfz3VzCAB6zjQloKzQxdpgJZQr0hOJF2xdTRq4SBxBwYL7512ex2JYU7ZI742NeC03Jq0kqCaAsLX9HBndNUvi6YBAjOvfjAeWRh1RtSuIi8PpOqhoIFnlTVKEldJxBTglaGNK776MYk+T4M7KIQYpEimw4Yc7TbaBG2sb56jYVG2gpBkdm9YROSTTHR3Gb7BCq6SqbRzEpVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqsZcmLUfPi4TW0iTeH6OYv/42yu7nuc5d+X8cdR+/Q=;
 b=d1sTo2CaeIKWLzqCfzmXmOZ4styDHYeCm3z5QJg1DsoUG9nfdeqgsjJKkm5i37e88ORvjFC/3R3NybqDvn6UeD5nljqlGciUenjyx22SbamEcLLBPSbvsoDGsNBmNLK2nH+sWshhu7GbDJCj6PDilsktJflo7kAFqQNqtJ1DJSL0ASY9XOUZw/RB3qFiOE9C8aJH9eI4yeMiee0JCaQEK4plMo/2QqTyjbISZX7XfQjLdbQfnCPjZ8Le08NoFSUtJqt/COu7BrsSQLL7AIU7ewGKyEQzK6uPg9rf2toDA4Sx7YUGuP3gTh5PzXds3DM8+SV4YsSxamkjs5FPcmM1kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqsZcmLUfPi4TW0iTeH6OYv/42yu7nuc5d+X8cdR+/Q=;
 b=Q+CiIJo9B/zOyMt9R0Llt2rNPIH1mHLqyYzByTliWavtH+NAPHdQh2qpTNlJA3J7bj2ablOlzVg3nyG7/3A3ZzplKPLb8eUjJ11RUY4jQLKQwAdP9SEzKsJrIQUoqfhop18KR7z8AIIqKqr3aAqHzCnLodYfErVpn+5ckeP4S++Lr7mKlfjp+PNN+1YluULkGBrbEaa5a7G4+Arod05yYAMlnh8pY1VK6ckKkql58En+KNvbREcGZm3Tch/B+ty2rLRQGO2R7gj4fhB7MMtRIXA+hCZ+qxkmYkOfanEwt0uZmuvZiNZxPyFAvaR7tNGo1jtKvplJzDaSgBJn287Lsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by DM6PR12MB4060.namprd12.prod.outlook.com (2603:10b6:5:216::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.21; Sun, 10 May
 2026 06:51:01 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%7]) with mapi id 15.20.9891.020; Sun, 10 May 2026
 06:51:01 +0000
Message-ID: <ef926d49-81d6-4d26-8d74-440d4a6bb8b1@nvidia.com>
Date: Sun, 10 May 2026 08:50:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V6 2/3] net/mlx5e: Avoid copying payload to the
 skb's linear part
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Christoph Paasch <cpaasch@openai.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
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
 <b1d3f9bc-a5d7-4236-8bda-49e6327ee533@nvidia.com>
 <CAMB2axPNhveQaDPs-ttu4uFcpvAfJCdzJ3d05HWQf4+p7uVUsg@mail.gmail.com>
 <70d0b319-178f-4233-b0da-9618489a1dd6@nvidia.com>
 <CAMB2axPdqBUORn7Qy35Xccqbn+8aArZ-weegZyz=j0STh+iPNA@mail.gmail.com>
 <6b7998e7-b2c1-4650-9564-679d647146cf@nvidia.com>
Content-Language: en-US
In-Reply-To: <6b7998e7-b2c1-4650-9564-679d647146cf@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0337.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::14) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|DM6PR12MB4060:EE_
X-MS-Office365-Filtering-Correlation-Id: 56bea201-57ad-4099-396b-08deae607f26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	qRGXeVqdxe8ZbiWESXurCCkh+/Q/G58mYvAW2gAV1ovOivF52za9wmjFCiJqIm8+i8xEmgdXS8mrK94jobeUx4rit3KqPuvZLyIENN9ybiGf0C4qvEQYqfpEQH6YLnM/fYB9jLYm7/F+GPikm0k/wqB63PyYKXDUOVtG5R9foBfqqVTf9cNYBwTuVDLvCudIPohZI1wHSveqlge7XkkOiGCWP+hDWxJM7vKX1uw7vSI+0BjLcwWV1gY50S7vNDef/JgTgWENGajbsd9zxthvBmif/b9XpsldRUpCNTVVaBUZLDS+skvbEtVquluBjA3NmHya7hWXuEUsmKmEVsLULMn4BYqeMPbe3A57MV4bcQzlUsnLQMdO7FmJYUUqb2UoVpF4oUfcqQctfvZT2lVmrHr/dp/YUjnE3ucK+kfmG8cfdahrtWuMoUdeS+iaqT0YBXzhXPKnJatndHDv2y3/jnnIo52emSQX7dAXz4qItsXC1RqONEJ6ZyAd+0CRzZDjbqqdFmEjigOS/DCYhu6US3cvY+WeN3gtENpnuN9sLqopHkZLpUtsPy0jRD+1vC6ZyXBAU4ioJOfFpS1yC3fr7QOsHZwce2NuOpGgmaXsSgAYkS0FFurt9bD5rfnQh2DP7GC94iz6D9b+AswyO1HGnVpahABEIGTdmgpgR3vIeg2oTQNrgQzOD5Ei8gY7zrb9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ckV1dDNtNW9NM2lkY3k4OWhCSUtyZXRHRk1CQ0VoUFprWGF4R3Q3WXB0QzlI?=
 =?utf-8?B?M3YwZm5zZmMrQm16bDNSY3lvSFh5M0J6MW02dkpqbEtNbGhDTUZqNjRXY3Rk?=
 =?utf-8?B?VEJGREJZVzNxbmg4SmV3ekttczFpWFNodTl5eFA1UnFzTmgrQ01QRWozV0FE?=
 =?utf-8?B?akFMZEJKekNxNTNnV3ZPMnZBNlpVUDZKWmdPbC8rdlIwaUlFRXl0Y00wQTNz?=
 =?utf-8?B?MzR3TG14Vk5McGV6QytxWGxudWpsK1pjYWxyWWtYMkE4Qmp3KzgwZEYzMVEy?=
 =?utf-8?B?WlQ3Vkl2RWJHT0dxbFpMQ3o0NVBXcFcvVGhOeXJGaStWYlFmcmNOVmYzNjI0?=
 =?utf-8?B?QlRRVStHTFVKT3VZRjkySVo4MkhackhUNGxHa0QrWHk4c1lCamJNZHZpV1NX?=
 =?utf-8?B?UHpDV201S2pRUzkxTm9pNjdwNTdhVG55a0lRSWNBVGM4RkYwbXNra3A2VHpm?=
 =?utf-8?B?YTJWZjVTVmp3ZFZHZVJHNGxMUmYzRVNicHlMdTlJWmRIWmZ4dDlBellienc0?=
 =?utf-8?B?aXUvaTh5U054RVZJTEFIS0wzVjRGWEdYbXpMVE5tMXlGZlZWVVZCQmFsYUV2?=
 =?utf-8?B?R1B4Z2djZ2dSd1A2SGZaWnJCZkFnUm9KVGF2cXB4bHM2S2YxOWhZeFNVajUx?=
 =?utf-8?B?anM0RlJ5Vkk3VVo3czhCZGUwdW8yM0h5NHBCdzhJbTNpSks0akZBRHV1eFkx?=
 =?utf-8?B?alBUZ3o1UExTME9ldlJob0JsaHJNc2VWcTRYMENsejJzbFl0b281WlpUSUZX?=
 =?utf-8?B?T083dmRpL0U1cUFJMzBaaFA2eVVwRjBhWjJwbm5URDM0MFF5anJtU2prejJj?=
 =?utf-8?B?QVpjZjJqNlhvYXZHUGF3VGhFa1VvZW11alhtV3hjSkFScHNCREVBU1lTQklC?=
 =?utf-8?B?YzJ2QXlZY2dieUhPNndoZDlPT0l2REx0bmxSM0FIbEhuQUd4a2tZMjN1WWJC?=
 =?utf-8?B?MWpGaHN2ZzVqYm9pbXB2MzJ0UktVeG5kRkhkNys2TGYwOFU2V1AzMG5mOWxV?=
 =?utf-8?B?ZUd0YzNsZTVab0NCRnlNYVRaZVJtZjFCRzdldFFNN21aODJleXliQWphQ0kz?=
 =?utf-8?B?ZVlhaVZmOWdHaldoVVc1OGVTbldKYWdQd3BqYTNiODJsQ3dWNU03a2MzU2dR?=
 =?utf-8?B?UXhzSFBsSloyVTJnaXp0d2FISXgxa0NRcXFHMVlUbEtEVGVzU2E5V056Ump5?=
 =?utf-8?B?WGNzSnJBQVUwKzJ0bjBqMmVsdExRUmxXR095V1VpMmhTMWFmOWFqVzFHMHpx?=
 =?utf-8?B?eFJOalU0WHRtTnhjV0p0RFVIenlmUENIbFY3aW9RUGQwRCtsY3J5Snc1aUJj?=
 =?utf-8?B?NWRQZVZlMGZ6VDdYY0M2OWV2RytLRyswa3JWTTNud0VOemVYZFBVTmo0eVp1?=
 =?utf-8?B?RUxrRVJsVVZtRWlUbWZ1ajNwOUhRMkhkaGtZaDU2clFqb1Z2NGpCWEg4T3hl?=
 =?utf-8?B?aXI5YzJ1ZXFtOEJONEVJcHUrSVQyUnFncXloYUMxWXlnRWFLYzZSSlpCQnRR?=
 =?utf-8?B?QVZBNnA5alJ4RmM2UThvZFpaM05ELytYZGV3U0ZNd3N5Ym5UMlI5VVhCK29S?=
 =?utf-8?B?Y3MrUlg2OHBFMTlBeCtBa2lNNXBMYm1qbmNzVTZmSFRiZlFabGkzTHc1Yy9s?=
 =?utf-8?B?VWM2QUVNTXR0MlU2OEJJTHo4bEY5eVdndUVKQS9tbWtMMGVsZWZqMjlMQ3hM?=
 =?utf-8?B?a1hlVTA3aUF3Z3VxQlFJbURGSlBQZVJjS3IrRXoyL0E5Q2QzMVBlUnJwWFp6?=
 =?utf-8?B?ckdPRVExc290WEJDazJ3aE1Bc0NIUU5BZkNUUnJ3V2lBc3ZDeFBBNWRSckpS?=
 =?utf-8?B?ZTBHaDh4OW1xSE1reElsMGhRVlZYbGdlN3BwMjlqWVpuQmJjMXhGUE8xdGkw?=
 =?utf-8?B?WTE3U1BXKzVXSU9YTi9NbU0zckFtM2gyT2c1ZzFJeitmUG9SSjQwSDFDeDho?=
 =?utf-8?B?K3FBQWlmTndLWldOQnBYT1JmSko3ZVVKckV0YWxuMFpaZjVFZHBkdVVaQ2pk?=
 =?utf-8?B?aDhGMGxpTzdUWFNvZzdZRE9VS3ZWRkFNMGR5V1J3WDAxN0xUbU1HU3dZdi9a?=
 =?utf-8?B?MHU5ek0vTmJCWkpqR0ozRDFoRUNHM0p4QmxYNnNwbmhMN08rZDhOdE5JS1ZR?=
 =?utf-8?B?QjdNOENwc20yN3QrWmRsOGR0SVFRVlBVSHl4WUlSdUdtMnBmT1JYUXZScnZU?=
 =?utf-8?B?N28rd2RPMlBjY1dobXl5SFB2b2ZXOGJjNERqaG5hR3JyWUNmemE5blBNd1Fw?=
 =?utf-8?B?U0hBQUNYQTBLU1JIaHJPdFpRcVdhbFVmRU9LeEx4RzVHM1hUd2Z5ODE2dGZj?=
 =?utf-8?B?QnI3aE1NaE9ka2hoUjdwVk5rMHRBZFZjK3VibkZKNFNLZkFBOTJ3Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56bea201-57ad-4099-396b-08deae607f26
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2026 06:51:01.0140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B0SrllSDGdES46EZO7KPCHF2FZXjgOzqNtY8T4t71Le+38aiuyX8oc4PaxmgrjU9xv+v7YNRapeQ7I331JKOdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4060
X-Rspamd-Queue-Id: 02A6C502D81
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20296-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[nvidia.com,openai.com,google.com,kernel.org,redhat.com,lunn.ch,davemloft.net,vger.kernel.org,iogearbox.net,gmail.com,fomichev.me];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dtatulea@nvidia.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Action: no action



On 08.05.26 20:42, Dragos Tatulea wrote:
> 
> 
> On 08.05.26 19:44, Amery Hung wrote:
>> On Fri, May 8, 2026 at 2:15 AM Dragos Tatulea <dtatulea@nvidia.com> wrote:
>>>
>>>
>>>
>>> On 07.05.26 22:50, Amery Hung wrote:
>>>> On Thu, May 7, 2026 at 4:50 PM Dragos Tatulea <dtatulea@nvidia.com> wrote:
>>>>>
>>>>>
>>>>> Hi Amery,
>>>>>
>>>>> On 07.05.26 15:53, Amery Hung wrote:
>>>>>> [...]
>>>>>> Am I understanding correctly that the better performance comes with
>>>>>> the assumption that the XDP does not change headers?
>>>>>>
>>>>>> headlen is determined before the XDP program runs. If it push/pop
>>>>>> headers, there could be headers in frags or data in the linear region
>>>>>> after __pskb_pull_tail().
>>>>>>
>>>>> That's right.
>>>>>
>>>>>>>                         if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags)) {
>>>>>>>                                 struct mlx5e_frag_page *pfp;
>>>>>>> @@ -2060,8 +2066,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
>>>>>>>                                 pagep->frags++;
>>>>>>>                         while (++pagep < frag_page);
>>>>>>>
>>>>>>> -                       headlen = min_t(u16, MLX5E_RX_MAX_HEAD - len,
>>>>>>> -                                       skb->data_len);
>>>>>>> +                       headlen = min_t(u16, headlen - len, skb->data_len);
>>>>>>
>>>>>> headlen - len can underflow but will be capped by skb->data_len, so
>>>>>> this should be okay, right?
>>>>> It is safe. But it might trigger an extra allocation in the pull when
>>>>> len > headlen. We could also skip the pull in that case. Or do a
>>>>> min(headlen - len, min(skb->data_len, MLX5E_RX_MAX_HEAD)). WDYT?
>>>>
>>>> Make sense, but this line took me a bit to understand. Maybe consider
>>>> checking len < headlen first?
>>>>
>>>> if (len < headlen) {
>>>>         headlen = min_t(u32, headlen - len, skb->data_len);
>>>>         __pskb_pull_tail(skb, headlen);
>>>> }
>>>>
>>> Yes, that's what I had in mind when skipping the pull. I would also
>>> tag this as likely.
>>>
>>>> Another clarifying question. So this patch will improve the
>>>> performance when the XDP programs don't change header length. For
>>>> those that encap/decap, they should precisely pull only headers into
>>>> the linear area for optimal performance. Is it correct?
>>>>
>>> Right for encap, but for decap not quite:
>>>
>>> Let's say that the XDP program pulls 64B header into the linear part
>>> and snips 4B of the encap out. This would result in a pull of an
>>> additional 4B (headlen (64B) - len (60B) = 4B) which are now
>>> data bytes => sub-optimal layout.
>>>
>>> I don't see how we can improve this corner case though.
>>
>> I see. Thanks for the clarification.
>>
>> I think the "if (len < headlen)" makes too many assumptions about what
>> the XDP program did.
>>
>> How about this policy instead: If the XDP program did not create/pull
>> data into the linear area, pull the parsed headers; otherwise, assume
>> the XDP program owns the geometry. min() is still needed since the
>> program can shrink the packet.
>>
>> if (!len) {
>>         headlen = min(headlen, skb->data_len);
>>         __pskb_pull_tail(skb, headen);
>> }
>>
>> This preserves the optimization for the default no-modification case,
>> and most importantly allow XDP program to get the optimal performance
>> if it gets the final geometry right.
>>
> I like this. It will also save us some neurons next time we need to
> touch these lines.
> 
Sashiko disagrees:

"""
If an XDP program changes the packet geometry by prepending data, len will
be greater than 0, which skips the __pskb_pull_tail() call entirely.
The resulting SKB's linear part will only contain the prepended data, with
the Ethernet headers remaining in the fragments.
When the network stack later calls eth_type_trans(), it unconditionally
pulls ETH_HLEN:
net/ethernet/eth.c:eth_type_trans() {
    ...
    skb_pull_inline(skb, ETH_HLEN);
    ...
}
Could pulling 14 bytes from a smaller linear area cause skb->len to drop
below skb->data_len and trigger a BUG() in __skb_pull()?
"""

So I think we need an else where we preserve the old behavior:
  if (!len)
          headlen = min(headlen, skb->data_len);
  else
          headlen = min(MLX5E_RX_MAX_HEAD - len, skb->data_len);

  __pskb_pull_tail(skb, headlen);

Thanks,
Dragos

