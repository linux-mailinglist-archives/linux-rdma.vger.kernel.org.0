Return-Path: <linux-rdma+bounces-16681-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPgjLdCAiWlx+AQAu9opvQ
	(envelope-from <linux-rdma+bounces-16681-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Feb 2026 07:38:08 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A4B10C2BA
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Feb 2026 07:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A8703008224
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Feb 2026 06:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C812C2ECE9B;
	Mon,  9 Feb 2026 06:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PoxUfXnk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011047.outbound.protection.outlook.com [52.101.52.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFF8254B03;
	Mon,  9 Feb 2026 06:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770619010; cv=fail; b=SbJ9PUoGRrYNf5r9VIcRwIF7nDtoKJ9PKC+fU8XrB+rFNSpWIzGHFnBSXZvplAz9cXJalaskEzncWH84JS8iWFhRCx2rkU+b3UEGbUUEx3oU3IWs5Ft51ZL7NPeInHBCzYvKIhaRnO/Vs1CoIb9dFfBqlh5lKDqMcIs3joBNDLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770619010; c=relaxed/simple;
	bh=2TsW7YCwA55M1TYSh1Sos0XM+jsX3xPLyv7BxmS4478=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZTwc39Q4cyFhP5TfUOHVF+i72pTMYRlAe4BWMTMI4pc7+5AMtP6G9eHPaEGRVFjcuWRpnS4Pv3QAEamIGOK/uP1XIOW6ioXR7JFlEpxgnQyqFUPR+t35uL0Nf0bYnEGJWCTKB2ds7TCWSuCoY8/KPTz8RDmJwiWBWwYwpAUZBw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PoxUfXnk; arc=fail smtp.client-ip=52.101.52.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dxbz1YjckVsB3w9+lPnCNnBnPQOQWxjnoOVikgY/AHLRikSLGW7Tmsr6MEcoviie2BSK4ARaq8/OT6EfviLwKWfsgsW3WkmnTCEk4lTHjBoGWS02wR6+lapdaDLzZawEmFHNJMEOV8ffC55k2dydC9dSDQCwqnZU7aPiRaEXxkRL1DYK0+6pKfDFnx/vv+InOa6s81OopBWnO1piuQMfmsyyBOIaqLR2vAwlwLnYS9BlKvbAulOg3Tlz5OPRSZwVNwUAWKzxkcVcjOhB3rPpcvNPF+ybkUrmqoPcsp3rHxlNqOpYMj90Of3yq2r/Pirsy8fYMMUxM9SCOyqZQqH3OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OjxWTEvPXAzNKxoZypXVGPnjXNFgbhSMt5z5lUtjlko=;
 b=VB7LhwFFXdj/M932Zqa8y3gtzzfiqZAK51zBZwNix1UInQfQNQbZMYmviLMJ5G9jeChfshvY8cbK0L9HgJ8sln8EVHePxJZdCROe7N49atz6sgg3dGmORf5qX++c2hv3DrGg+r8WeBXfOMI/Llx2l0dhjhljIR2mX8G0QyxLTk7M4nI4c1vW0PbMr08Zdnqgb3ojoVmCPCctHbiWXiF1gqv/aF9wo+oL/xeOFFH+8+FUa0iiMZQXoKaWXN57xF2phAVJb4pq49XUzdwwjGQv/WHbs+4G/e+MrGujtuCnl7+Jyfmy0Nx9HUV+iGoFC8lZYlX11K7YTl9vn/0JGMXA9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=crpt.ru smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OjxWTEvPXAzNKxoZypXVGPnjXNFgbhSMt5z5lUtjlko=;
 b=PoxUfXnkC4rcBNEUu0il7O81l4s8wFT+nh4qOAoaO1dShoP5b3IH/3J13TJSsvcuBJDPpvqTfEUH1RUXYwZpDVCpYThv8MEzHn+U1H+wKuNUUSUOSfvpuPxNrOMbbV5ZaAJw3pYHzCgLx/3IoG+o9cLx2FWnFYUiFs614Gth96pLoNwphvQwJg3tD/l2UyI4cHgtbDj7k5CnTIlkVlkD27HbimnkyjKfbfCmW5mztxevJFO255rtbFj4f8staZAxc8v7R5Mu8kkzTWqbJMXPOon4NTB6t+5ZDXr7mxldQFo3ZBWEMs5Zml8avP77BcGbjvQA8X2KjLb34MTSqTcwdA==
Received: from BN9PR03CA0668.namprd03.prod.outlook.com (2603:10b6:408:10e::13)
 by DS7PR12MB5717.namprd12.prod.outlook.com (2603:10b6:8:70::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Mon, 9 Feb
 2026 06:36:41 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:408:10e:cafe::eb) by BN9PR03CA0668.outlook.office365.com
 (2603:10b6:408:10e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.19 via Frontend Transport; Mon,
 9 Feb 2026 06:36:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 9 Feb 2026 06:36:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 8 Feb
 2026 22:36:23 -0800
Received: from [10.221.208.222] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 8 Feb
 2026 22:36:16 -0800
Message-ID: <edc2fd39-c8b7-40eb-9148-85e97eb32af4@nvidia.com>
Date: Mon, 9 Feb 2026 08:36:14 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx5: return error in case of lag device
 allocation failure
To: =?UTF-8?B?0JLQsNGC0L7RgNC+0L/QuNC9INCQ0L3QtNGA0LXQuQ==?=
	<a.vatoropin@crpt.ru>, Saeed Mahameed <saeedm@nvidia.com>
CC: Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, "Mark
 Bloch" <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Gal Pressman
	<gal@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>, Gerd Bayer
	<gbayer@linux.ibm.com>, "Mark Zhang (Networking SW)" <markzhang@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20260205114206.1763509-1-a.vatoropin@crpt.ru>
Content-Language: en-US
From: Shay Drori <shayd@nvidia.com>
In-Reply-To: <20260205114206.1763509-1-a.vatoropin@crpt.ru>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|DS7PR12MB5717:EE_
X-MS-Office365-Filtering-Correlation-Id: 2937c53e-f6d5-4e43-cbc5-08de67a594d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RFpIMERZNWF4WDYzNktmRDhkeEs1QUNYdGdiZjBVdUd4K1FMRVpkZm9Mc0ZH?=
 =?utf-8?B?dTZrNDRHZ1ZreFBiZElDUmV2eTV2R00rQjMwR0R0V1lJY3MzZEFXdjA1RzlG?=
 =?utf-8?B?QUlPOXg1dkhhQTNFdklKWGdwY2JmYnE2TnlqZ3V1Z1Z0a0JIdmZiTjlSZVJD?=
 =?utf-8?B?MVlJSzhRNlYrYlV4SHA1bjRHYlBocGlNRURPNnNHWDZRRkhSQ1F3czhHOTd5?=
 =?utf-8?B?RlNZZjAvTnZicDdIaWs3SHRUQ0N1YkN6OWZZUU9DZ05aRHZTTXY1a0JnNVBy?=
 =?utf-8?B?ZHJMck1Sd2hybEVjTTVrYlVDcFJqSGJUK25kdVlCQVhIeGVxZnY0TGpoNVM2?=
 =?utf-8?B?ODNwOGtLeFprcndXbng4ck9XRWpiUXk0VzZSU0NLRHU5SVdvRWdzeEV2L2VX?=
 =?utf-8?B?a1REZnFnK2UvOWhMdmczanpQVzZ2enJWYVdDRGQzMEo2YlB2MUk2dEdHT2hl?=
 =?utf-8?B?bUxQbVRCZ3g3TGI1Z3QvT0xLRXVpUWVyRUV2RGdnaTR4dmZrWGpnemtGcnkr?=
 =?utf-8?B?Y0lsMHRYcEVoWmtaWURQU0ZkRlU4U0VHT004T2tIejlGNHhRNWFBZ1JTUFp5?=
 =?utf-8?B?RWd5dy9OZU1UT3pnV0pwRUR2Mm10ZzRmamVPclhYeXJxRVV3YkFpWmpaV3dS?=
 =?utf-8?B?TFIwK1ZkT2RBbmdrVG0zZWhFVStUTmVlRUc3WkNCTGRWZ1dwcStYSlZGMGRI?=
 =?utf-8?B?M2ZzSHZDUnFPQXlyMUs2c2FjMW43U2NPalVzN2h5OExiMWFsdzltWURyTU1u?=
 =?utf-8?B?UUxaK1ljTFV2NDkya1lXalRBK2xKSXBNL2lxL1FvdURhMkNwWUE1U0M4ZWxt?=
 =?utf-8?B?QW9aZFJveHRmRlZ6WFhRdkkvd3IxUDdzNk5CRnlRMEk5ZnFZMWVid05KRUlp?=
 =?utf-8?B?azBuSFhjZjNab2E2bmRqeEFkYWpremRoMjYwNnN4aythRFc1OGdLQVdKdVcr?=
 =?utf-8?B?R2k3cUtvWW1WWmJFdUhsWkpGdndYdmVtUUFSVUpkUmtES2liSmV1NElKTTlL?=
 =?utf-8?B?N1V1S0tjVTMxRG01a0tkdXlERXQ5NDhZSWFFOWlORGRianphWXZsTjBGc29Q?=
 =?utf-8?B?aXQxcjluZGl4dGlzS1B0eGlaZWh1UkY3eXZ5YktDR1krZEJqVWl2dVF2R2Y3?=
 =?utf-8?B?d2MxUWdNYysvQTcvWkRCZExHMUcyc2RwKy9NNHQrdnFTa3ZpOGJ3Nk9Wekgx?=
 =?utf-8?B?VWV0N1YrelRXNWUyQXhRSXZqcW9jTjdBK0RvRnhEVWpNc0RwSVFqWVMrazht?=
 =?utf-8?B?R04vTFBWbkJLRnV6VVVzeTZESGtpa2pqc2xxRWxFQmp5Nm8zNm9SNm5hSm81?=
 =?utf-8?B?TDdKdWdXa3hzVkYrSlo5clpwUzdYaU13QTNuNFowMEwyMGVBcmZvVStwQmFF?=
 =?utf-8?B?Nk5veFR5VVN4TzNxN0NIdlVsQUMycEtXL1VrNmFhNEU4dmRnUTFsMkNMSVdW?=
 =?utf-8?B?QmN3K2h4MW1idURnUkx4VkdJdXJselZkU2xzRFJsb21YK3lUMUk0NUV3TXh2?=
 =?utf-8?B?Z3dIRDlwVjcxd2I1Y0xxN1ZzYU01TWZ5OGpTZkR3Z3F1OEpoV0I4WGhTUWxF?=
 =?utf-8?B?d1JqSStBRTdzbkN2cFVDSGpFdUNtSFNvT0pSbTdLbVdGZVdHTE4rbVRud1Fk?=
 =?utf-8?B?NDNIbjhCdUhJTmh0bFVIVEUrZHBaanhtRDgzSlMwazRBQksraXlYTFBGSUhr?=
 =?utf-8?B?OFZIRmRKY1ZHVCtsZUY3R0k0aWtwLzJqZ3ljYmVrbmZLSVBCRmtwazNxUTJB?=
 =?utf-8?B?c1R5SXp0MlNsdFN2MUdIdUJLaGdGOWI5cEV4YmE4cXplNUJxd2xnN3R3Z0pG?=
 =?utf-8?B?Q2FHbmxucEIzZmFPUUZ4Y2JHQmhHbnJzaE1IR2dXcURSTThnNDJyLzVCU2ZC?=
 =?utf-8?B?K2ZldW04U1FvZy9wN21WVXV4b25OeFlhbkVNbjBnaUY0QU83aEVtQW1sSFlQ?=
 =?utf-8?B?TC93TTdONnZvY1Q5dkQ4YzZFM1BqaG5Ba0djRm9mWnZJZjR1L1NEc0tTSTBJ?=
 =?utf-8?B?MTM2K2lVbWJZZWZKaldXMmJIT3I5UVVNNVNHdDJlc0hhaUxyZXp3ZXM2QjEy?=
 =?utf-8?B?Ymk1Sm9mUEdGbWNQN3ZlUjBubHlES0ZHeFR5eCtYQ2UzNU8xU21VY09VZzhT?=
 =?utf-8?B?N3FvYkNXR09Pc3l6NTFsYlR2aW9UTFNXeElNUEVERGk1UVNma3NibzJSRzVz?=
 =?utf-8?B?Q0ZTMmVBajBjN3ZKUVVSSUdMbHluejkyWGlPTmdOUnk4bUxKcEx5VUh6aER1?=
 =?utf-8?B?dHNVL2Y5aktwZHZBUXVQMFZUcHdnPT0=?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vAB8U3m/w2UKQ1L3wT0AEABXxlwgZ47+0XIu30obw+cAQs5t926953lrr/Fl9HWJpxaJpyHqbCKaO5OlH0PGnmgUm/xFvRLF9HKNhlTwGF/wyQQFNL+oLKTrC9zd3C6+4NKaVErOmve9YHoYr0+qGpCgt8ur+S63dnW8y+/fppt//CC4e+4eZnX0Uv6gvQSsG7N40GayHjtR/JMwuOu+2eD637s52S9f5Jd60DK+fQD0cHoYygJjTCBjZIjPKV3oU3D2O3pqQwTP5kBUZq+kyA2AyPtlDbwA92+iVA6EVQkOumRcEELQryju2LGxWVe5nUm5gEevN3ei9ZBXlyGszuITxxz46Kx08M7Ku5VQs7Vwuc8gmi2CtjC7moWHi2/mxGx+DIdXMYje8Q5V+S7HA31J181+Pq1W4BAkMCRvVQHwM23f2/EDc+fWfoBVAxfh
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 06:36:39.5520
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2937c53e-f6d5-4e43-cbc5-08de67a594d3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5717
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16681-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,crpt.ru:email];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shayd@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 52A4B10C2BA
X-Rspamd-Action: no action


On 05/02/2026 13:42, Ваторопин Андрей wrote:
> External email: Use caution opening links or attachments
> 
> 
> From: Andrey Vatoropin <a.vatoropin@crpt.ru>
> 
> The function __mlx5_lag_dev_add_mdev() attempts to allocate memory for the
> pointer ldev by calling the function mlx5_lag_dev_alloc(). If the memory
> allocation fails, mlx5_lag_dev_alloc() returns NULL and the
> __mlx5_lag_dev_add_mdev() returns 0. Later in the debugfs handlers there is
> an attempt to dereference the ldev pointer.
> 
> Change the return value to "-ENOMEM" to avoid NULL pointer using. When
> "-ENOMEM" is returned __mlx5_lag_dev_add_mdev() will attempt to
> reallocate memory for ldev after a sleep interval.

first, mlx5 treat LAG failures as non-critical. e.g.: if LAG is failing
or isn't supported, the driver won't stop loading.
Second, we have a fix in the pipeline that fixes this by adding
a check in the debugfs creation function, can you wait for it?

> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: cac1eb2cf2e3 ("net/mlx5: Lag, properly lock eswitch if needed")> Cc: stable@vger.kernel.org
> Signed-off-by: Andrey Vatoropin <a.vatoropin@crpt.ru>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
> index a459a30f36ca..6e914472a2d7 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
> @@ -1392,7 +1392,7 @@ static int __mlx5_lag_dev_add_mdev(struct mlx5_core_dev *dev)
>                  ldev = mlx5_lag_dev_alloc(dev);
>                  if (!ldev) {
>                          mlx5_core_err(dev, "Failed to alloc lag dev\n");
> -                       return 0;
> +                       return -ENOMEM;

Also, This change could lead to endless loop in mlx5_lag_add_mdev().

>                  }
>                  mlx5_ldev_add_mdev(ldev, dev);
>                  return 0;
> --
> 2.43.0

Thanks
Shay


