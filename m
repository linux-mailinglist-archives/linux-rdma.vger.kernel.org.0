Return-Path: <linux-rdma+bounces-16988-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJuOM0drlWkzQwIAu9opvQ
	(envelope-from <linux-rdma+bounces-16988-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 08:33:27 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 777BF153B5A
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 08:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2FBA307A88D
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 07:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F58B30F943;
	Wed, 18 Feb 2026 07:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mnDpe9e5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012032.outbound.protection.outlook.com [52.101.53.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D342877D8;
	Wed, 18 Feb 2026 07:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771399804; cv=fail; b=Iq2OXM1vRoSEg96108KqFgbUvsu4MGr1L+Caoy8PJzysITPe1lZ0PfkLqhIfdLF52oeRVSmdLzl/6DycIcrglHaOSU6bC/OJvSBxLZ8b4EhmSHAJ9xhIDkeUuMmMwfifPsuPn0DEA7/cnXSCFxoTRGLDs8eSupi3iGhjSpk6Wh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771399804; c=relaxed/simple;
	bh=+laalsW0sdPxB78bjsLFvUF6EDf4xHTD7G+IraCGMpg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=maZAAlEoH1BDTpeqvbK/g4D3G7SNedeUEZ8o/yfopZBj/W4TQ3WCI0Ogbnfwy+Vk0LM9qHqU8st/u5AbhEagzrqkAZaY08CUXk++vTzT/HGzLsmYFbl3qnV4whZmg+7MVeXKXQIksYIl2Lfqby8AfI6uiXTALK9GrW0x2MNYNjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mnDpe9e5; arc=fail smtp.client-ip=52.101.53.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S0A+4tmQ9lxLcZmWAOiLkDmbLWuSzhADsB3ADVb2MvN4G/sFQPzJNCbsHMg9Y8kJ0IZ3pw8IHIKnUhVJX7YxvOCigXy5KgAMVDEcmE8VvNFAxBKYxvbQTPHPfinBQFL7Z0xeWDKNtv2msn85TX4g20m16hCiUiXwn8dR3tJhOQ0uDQBGq0fHUlmVGVshLpHUrq6fybYdtAsrzs5x7Y8kB//ZS2XkvQzq2ho/5wnSkOEch8gxFDuGhbMFL90VakP4GWmwnWkwMO+eSBvMAuy//OEGM0a+HClQzcbggxVyKNt6PB6ft4AMOC5jmNm6VywXwqJmp9kDC64HuHqNT9mCag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OnA1LNFAH957SieIQJ1BUqpsNSkxzQPSFamYMWPp+JA=;
 b=R58P4hYu65Jdl2dnuqguYWKqHuOOeIt9aGHDB6YN/O4hQuSOUEH1VkZNkrEWmYm9U9pYYL3UDrLMtUP0PDuxDddWbsVgFN1SS5Wz7OuE3jTQzc8TC9nMl1vUCF90Fy6IqjdCyND2wkrgNhr9SyLOzPgupZLQMcV9jrxt7UZUitOPD5vtf1XSxWaqJlelc5MMBx7RD2EQ8Txks1ZO1xI4AE7SwzblCRO5sz5Ka52HdGueAjQLDzLzKwrOTCZ/hO2bAWgG6nPZD5124KxPaye6Tiu5o01vSu01TxNnvlunF7kgPMgKtQkgmjlA1d/zC2Gyey6dvKci1degguB+C90ULg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OnA1LNFAH957SieIQJ1BUqpsNSkxzQPSFamYMWPp+JA=;
 b=mnDpe9e5ngiG0pIlkjS7FZQ0Mi+oUBgv/0JAs3eaHHDhPRFfLWb/r26HvNalLX4H3lpUClSD1dCjvDkGaxWcv3FcOOjk3V4uILXfrQa1K3jY3qvpZXiPI+WtiFERxyGzKlPggiSbfe+vUjYsHDS5r0exSSLqzQIuLI+TFNZw2R+DlqdSqjwe6mT8YqsuJsuiwdDEVrIq2Cr2wwdt0okYpXZesgFocPyRGZaJyOPh99GZsW8jhEWWNncuvFTAZZOidvnHKBV0sOjnquwT+xP+/i7Lm/bpAXVSY+jXIhnrcv7000JoCSpDCZtgx5ZSrgsWH5wv+O31reNnlQHxUgdKbA==
Received: from BN0PR04CA0075.namprd04.prod.outlook.com (2603:10b6:408:ea::20)
 by MN2PR12MB4424.namprd12.prod.outlook.com (2603:10b6:208:26a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 07:30:00 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:ea:cafe::40) by BN0PR04CA0075.outlook.office365.com
 (2603:10b6:408:ea::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.14 via Frontend Transport; Wed,
 18 Feb 2026 07:30:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 18 Feb 2026 07:30:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 23:29:48 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 23:29:47 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 17
 Feb 2026 23:29:43 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Jacob Keller <jacob.e.keller@intel.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net V2 6/6] net/mlx5e: Use unsigned for mlx5e_get_max_num_channels
Date: Wed, 18 Feb 2026 09:29:04 +0200
Message-ID: <20260218072904.1764634-7-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260218072904.1764634-1-tariqt@nvidia.com>
References: <20260218072904.1764634-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|MN2PR12MB4424:EE_
X-MS-Office365-Filtering-Correlation-Id: cb1c12ed-bbeb-441a-94ca-08de6ebf8634
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SlkrMlBOVFk3RXlCMmpzMk8xSG1Jcm9SMzdmUU5aekozcm9WV1RrcjFYZVdy?=
 =?utf-8?B?Smhoakh1YjBTWUh1UFJaMjdibzRTUzZ4MjZIVnNZOVpnZmVwMFdIcVp2NFdK?=
 =?utf-8?B?by9pTFVRYmVveTk4a25RZE1ubFA2T2tZeGlrWHBDRWJUWWpZNmpreUpwZkF5?=
 =?utf-8?B?c3oydTdTM1prblhLZjdpWFN2WjZxbVZWV2lzYzY1L0JsT2o3cUhhVWViODJ5?=
 =?utf-8?B?eDQ2QU9YSHI3cmJhRXUwTkI4MjlCUHhUeDNGbjZIYUgwTkhOYXNVUVRrOTBG?=
 =?utf-8?B?OUhTWktvaU8wMUhpTTljV2lZT2NnNnpaUjlIM1Y3OVU0dVh0ZUk4bHdYQ1Jh?=
 =?utf-8?B?QUptYnIzWW9iMW5oWGtVcmVrOWJkbERqL3NwSWVJb2ppa1c3VHFMUU5iZlJa?=
 =?utf-8?B?NHRFRm1QYVQzaTFhbno5ai9uOGR2OGdFeTJkcVF5bWRZQlRiSlg4ZU8zODhC?=
 =?utf-8?B?QklsQU9pQzEvb2hTdlpIeW5XQmVkZExSeDlyU2dGWGkvLytZd2RKR1JSTXBJ?=
 =?utf-8?B?a2U5amZ6L3c0Z2JqRFNpZzNJTENzaFR6MWlvR29odStrdWNqTGtveFl6b3h6?=
 =?utf-8?B?S0ltZnhoeGQ0QTQvY0xqUlMvNW0zRS85ZWtmNTRBMHh0eW5OcTZCZ21YazZp?=
 =?utf-8?B?T1dyRzZpSnFkeU5VM2s2K3E0TlVJbTI0eGtKU092VmdJL0R4eVF5TDFCOEw1?=
 =?utf-8?B?d2RkdFh2d3dlK0pYUXIyb01OajdYL0dJaUNaNTJsMWlzMlRpRE5rKythbGlJ?=
 =?utf-8?B?UkNxNXJRQ0JhOW1ndDFrNFlGNkhRN1lnNDIvZTJ3RnE0SFlvdWdzQUpBNm5M?=
 =?utf-8?B?NXlrYyt5Y1Jyek55ZWo3Nk04V3VFSDhoRlZBZFF1ejZ3SzZUYzlBa0QwRHdQ?=
 =?utf-8?B?a0xFNmFvZm02TWxoZGlzb25pMEpFMTJrWWlnaFNzQ0h5bzFmSFp0VFJqWnFK?=
 =?utf-8?B?Q29uM3lnY1VoMkpVSmg2aTJUM1ZGK3VzNEN0eCs0YWk4cVZLcGlENDVtcEtC?=
 =?utf-8?B?YjZMMjlUN3hRY0pSY2FLV1Jvc0svaHJobWhsSW5yTVNNN1lBRXNmdVNwMzhG?=
 =?utf-8?B?MWoxY3BLdUZZOG5SdVdYcHJkUGFZQzNkN1d1aWtMNGFkeHlTd2V5MkFNbzZx?=
 =?utf-8?B?QWozZUp1OEh5TytRclBDeHFnaVZDMzdBY0dLU2JyR0FraHV6M28zWDdnYWZV?=
 =?utf-8?B?eWhWWVZkT1Zna21VTE1XRnI2aTg1RVVrdUZlYzJwTlNPRHY2bjUzSytJTzd2?=
 =?utf-8?B?b3IxNU5udzNwYi9sbi84YitQbkU0VEJLY2JsdHBDd1BPbndrSmkwbjJISDhS?=
 =?utf-8?B?YXVaeE1EeDlwdVFGcUlQVnhtNEJ3Rmp5c2YwQ1FQZmhHaGtVR2E2NGh4WGdK?=
 =?utf-8?B?MDIvK3MwcHFSTkkxN3REVnZrTFBuc21jY1hqT3grdVdKSzBiZWtMYnRXMXp6?=
 =?utf-8?B?cE5mYWFIYmtJL09LVm1BN2hpdjl4RnVWSWJVQnJRbFowZUtqVGViTEdtUGtZ?=
 =?utf-8?B?enNySE5uaUlJWFdqQjd6c05jR2pOQWdBREU0b0NHU0pZVGYxaXIrV3dYeER5?=
 =?utf-8?B?Rmx3K013Wk1sWi9NRXJ4dWg5QktkaU1Ldkl5b3d2Szl6QWo0TTVybmJ1Q05z?=
 =?utf-8?B?alA5WkJhUTdZa1llZXNNWkx5RmZrTnBtNmJocVI3WjJhMzNWUlRCL1lQUHVU?=
 =?utf-8?B?VFF4T2NrWk1DTnBadWIxbVpueVREZEdKQnRHRnZJM3Q5b21kTmdXS3FJYU4r?=
 =?utf-8?B?cWQ4eWE1VngwRTljNDBXamlXa2xNemsrVlJqOUFsRUs0QnQwMjRnNHJEaW5a?=
 =?utf-8?B?SWZwTC9jNGl6bDBSdUxLZ2JQSlNSaVpaMWpaUWxZTStveVc5a24rRGxIdkFk?=
 =?utf-8?B?L1oxamtwdGkzbFhIWXNyMkdhRFZuQnZ4M2RmVElpNUJscm9wM215V2hDRUF3?=
 =?utf-8?B?S3YxeW9FUitrMTRudSt4c1JPN00vVUNIYSt2YTFNSXI4L2tHK2xJUUN3TzBV?=
 =?utf-8?B?VlNXY0xUV2dTUmNHQ0xOcURUVWNkY28vaDJvUHl1MmFHUlFCdXY4bHRydVBG?=
 =?utf-8?B?dytZdG5hcHFqL0NYT0l4Zy9xTllYNFF3WFVlM2NSWHJucXZ1NzNxU0p5YmJr?=
 =?utf-8?B?V0s2b0M0VW8wU0tWMTBDQkR0V0JrYUkyRlFmUWZNQ25IM3JEamxvWDJPS0dX?=
 =?utf-8?B?YjNxVzBqYjJZVlYwcEhDaTgveFVNOTBObytlMUE2emxsUlY3UmZLYTNBeG5K?=
 =?utf-8?B?byswcG45TURMemc5Mm1URTlKOEhRPT0=?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JHxttftLuB4Jxo+8+nX1AdutaCWb6PvCPkKNj72n9eUBjlbqQ/E2xskWOlS6UC0qUYTRmVGl5I8Rl9gRuIYAPgdNSl4KiqG7Ibk2iefFmfgVtJqTOtseZyU6Iq3kyheIwDLPblOz8HJWkBR25MxyeI1QzSMbcYc84dUJCKGUurbf3x8Kaxd2zeQCSHoazteWzaCB1UDAVWIishoFhTrAMuIe9WVY5Thzx8C/u7tqcwut+FA0rdVGcatbe8ElOVWTXbigbuA/MTzlVtMIgdzNVli2IeipcOA2B0a6iCukJKnqNglk6ZZ7sFJWfdrUlOyh0w3rksEVogck/qC2UwpmSAu/LdCowRO5Esvk6ZzCw73pKJHPwGb9ZWJ6C1b4RBE8j/VDQKlAKcM0+MB7BG+YNf3VlnTyPhwowazP+yamPEviCcaNJzhdkdJczKINm8ms
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 07:30:00.0731
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb1c12ed-bbeb-441a-94ca-08de6ebf8634
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4424
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-16988-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 777BF153B5A
X-Rspamd-Action: no action

From: Cosmin Ratiu <cratiu@nvidia.com>

The max number of channels is always an unsigned int, use the correct
type to fix compilation errors done with strict type checking, e.g.:

error: call to ‘__compiletime_assert_1110’ declared with attribute
  error: min(mlx5e_get_devlink_param_num_doorbells(mdev),
  mlx5e_get_max_num_channels(mdev)) signedness error

Fixes: 74a8dadac17e ("net/mlx5e: Preparations for supporting larger number of channels")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index a7de3a3efc49..5215360c347b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -180,7 +180,8 @@ static inline u16 mlx5_min_rx_wqes(int wq_type, u32 wq_size)
 }
 
 /* Use this function to get max num channels (rxqs/txqs) only to create netdev */
-static inline int mlx5e_get_max_num_channels(struct mlx5_core_dev *mdev)
+static inline unsigned int
+mlx5e_get_max_num_channels(struct mlx5_core_dev *mdev)
 {
 	return is_kdump_kernel() ?
 		MLX5E_MIN_NUM_CHANNELS :
-- 
2.44.0


