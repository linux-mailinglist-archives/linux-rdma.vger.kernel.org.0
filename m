Return-Path: <linux-rdma+bounces-16604-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IB4rD6nShGlo5gMAu9opvQ
	(envelope-from <linux-rdma+bounces-16604-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 18:26:01 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA2CF5E2D
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 18:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E9BDB30055CF
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Feb 2026 17:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A0843CEFB;
	Thu,  5 Feb 2026 17:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZPjJi90a"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013069.outbound.protection.outlook.com [40.93.201.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC16343CEF0;
	Thu,  5 Feb 2026 17:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770312354; cv=fail; b=EfHq+0LeldhIo5MBpkPfa4tfRmyGTjjKk1vPrMKTGwYwH70VvFPJPmaQnEpiEza7OydLanRF73ZkKagrriAqQMzkJl4jPYswSJTU6Vgq98fnK9qVJT+tru4ZgZ2c2TEjQXcjbuK2/7HJsWgb6mF6UNHoG45I2UCcBr2SEbROscM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770312354; c=relaxed/simple;
	bh=N9FbVa8aP9u4Xie0PqpuYJa6g2CllEFCszK/hSlrRn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dNoBqegFErI30KeMG/ERzs63dJFRUDWHuQ4GPmC+LNEVBurenztOWmGQ8a3PVD1o7mx5dUC6IJZItuhDOSei1FZzpDo0Vw7dn9pdJEnR9DuX9mrjnjiPEI3nxfzyXqiyB8Y+3QjPmzHjfXEDlhQhhmsMCjTUh05spzfqdwlQoGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZPjJi90a; arc=fail smtp.client-ip=40.93.201.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VQuebHL1pkqMU6DlBdo7HrYMSLZ8TIgz5ToZJrqb9cjokTQAN4Il5qWumdzydgnefRJ5L1PIhbbQA3MOR0IFtVU0o/oaCgIbIZNPK5MzA9stZpvFoq3YBQRLs3BROmNMVYKZXC90+i7ev675jAdJpkTl1LrLmfFYRIfer08k/0uJrpG1WvgInHWvPoL/EABlskXrID8GzqH9rK/qYAAP2tkSmgrDygaFNuoU28fjHj3c+nS91DcMzRDOmriktp/pDmq0f2iMFfNqMySTShn9QSpjxqWok7WNOg/i9CV+TpmlOplM3WPfJZ1fkod43EaQlnv1LUvbFcNSsqzHxs0u6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cjXDNqsg8PZq2+l42sjDyxdKW7scJKzxzdy8RbqdDrU=;
 b=noqFybtkoPZ8U+tz2Rcc2FimZA6jg0t1WU+K67nnDv8EOk0FMqnh7plo7wTwogWomcVRrI8cqtjxj3O2El9UoPXunkWtsLiNBW8eJs1QArnFIW888emXc0P4RkgqfSFGsg+8oD9D5aL8furqVsafSNcCIreJkxstiII72ss0Odxj6dTcNkIfZ06EGuSmI0wL9FOpIOHI6547vgBqvMqiPcVSCK6fozYCH6tsW/xRzduXkI84lRSy4RIL73Iu07rdgtGR5vBc+bdwHH/LDsiesAELXzsJIOBvoOA4V5EfxBMVyyS+j/9jx4gqn2D+2wC5iOOqGy4lnItjxuOUf3dSmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjXDNqsg8PZq2+l42sjDyxdKW7scJKzxzdy8RbqdDrU=;
 b=ZPjJi90aMMhVQqKzGGqY419mrLY3SAEsQJDtWKiEkqeF71ZZ+o+35+C2yQxj4d59qK+Q12/RfOcaF4udp/sSIng1b+oEEa1WYrkUxd/ZrZTmvsX6BkN/s8gMzM+t/q9MQRYmwD0KjmSCxyllpY2FoVbYgke/x2NYxqiPh/Sp+jSCYRJ3d5DhRbH0dDAUWuEU/vzz6l7yDZsqK8GM6Q8QOWI7aJcT/PPn/qiw/t5sR0OWo0IOt50ve/mBKecjAmrXc9PMETzharMk6zkMdisp7WJSKLcq6fDY+EuRg3HyjgfY7WY9Sn7hEYvpE7f77x4hjhnrhDuwhETW+f63RcfA1A==
Received: from DM6PR07CA0124.namprd07.prod.outlook.com (2603:10b6:5:330::34)
 by SJ2PR12MB7894.namprd12.prod.outlook.com (2603:10b6:a03:4c6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Thu, 5 Feb
 2026 17:25:50 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:5:330:cafe::3b) by DM6PR07CA0124.outlook.office365.com
 (2603:10b6:5:330::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.14 via Frontend Transport; Thu,
 5 Feb 2026 17:25:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 17:25:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 09:25:34 -0800
Received: from [10.242.158.240] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 09:25:30 -0800
Message-ID: <a78c486d-a92d-43de-9c8c-3bb10b82ba37@nvidia.com>
Date: Thu, 5 Feb 2026 19:25:28 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/mlx5: Support devlink port state for host PF
To: Paolo Abeni <pabeni@redhat.com>, Tariq Toukan <tariqt@nvidia.com>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Jiri Pirko
	<jiri@nvidia.com>, Parav Pandit <parav@nvidia.com>
References: <20260203102402.1712218-1-tariqt@nvidia.com>
 <722cba76-363e-4273-8150-2b50c9f591a5@redhat.com>
Content-Language: en-US
From: Moshe Shemesh <moshe@nvidia.com>
In-Reply-To: <722cba76-363e-4273-8150-2b50c9f591a5@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|SJ2PR12MB7894:EE_
X-MS-Office365-Filtering-Correlation-Id: f2ab9c9d-d489-4e2e-2aaa-08de64db9b74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?REU3am5XZzYxQlViVlJENHhHUTU4TktMTFJCOHZiNDkyMWlBc3hxY0Z2Z2Nu?=
 =?utf-8?B?MTZLcXZFNDh3eVRMdnA0MVBxSUVMdUpQV20zelhBVUF2UEdBT1ZmVzFqRm1O?=
 =?utf-8?B?WGF5SmNHWnZJSTZaK2JyUGNmSkJIZy9aajBEMmxPN3JJMWRMUzdaN3JLd2ta?=
 =?utf-8?B?aXk4MnJ5OVErcUFmekYwTk5oNnkzemROZlhmMVRRbEdVRy9xQkhxMzRIQXdr?=
 =?utf-8?B?UnhVNytXQXNXSDQvdEhDQ2Y5SVRLSVpkWGV0L3lpVXVGRWhZbC9ZN0pSLy9v?=
 =?utf-8?B?NVZVV2VpblpLZXgzVEdVNWRGdEV0T2QrWlVwSHFXZ1JUOXRkeHNlVjNBRytx?=
 =?utf-8?B?SG9iZ1kvZjNBQTBacDh2RDI2VTlVRUZMYUFyS0g0VkwxTHJueFB5anN0ZjJW?=
 =?utf-8?B?UnpkNlR5YkQybVRCMzJqZUY1T1g0RC81ekRJemVIbWtYczBkVUd1SkQ4RFIz?=
 =?utf-8?B?S2hRREhkQVFodDNrTmNGSXJCcWQxK0NZWllZRUE2bmIrT2w1cjRxRFcxLzRC?=
 =?utf-8?B?Vzk3MGxkeUhVYldTT09sNG16MXJ2Z3ZxdVVwdHNvVi9NRWRMSkRaL1h5WkRQ?=
 =?utf-8?B?SXdnVmxMQXNEUUE2RXlxQlJRbVBBTTdwRHFVenAyWE0vY1dWQU5KOHZwY25p?=
 =?utf-8?B?MEVVVWdVelFJaFN1aDhXdUVSNjFNYTR4V0d3cU5oUFhncHpWUWozUHRWcFJt?=
 =?utf-8?B?S0k3Rk5jQW9nY3kvNFl2eWFqaXdPUk9iUzBQeXdydGI3Q0owL0Vnak5aOTJV?=
 =?utf-8?B?SEhQVGhkMjJ0NlNHZ08ya2JVSHpXNmREbG5hTDBiRVhTTEordWZPREFtaTg4?=
 =?utf-8?B?MVdaUVZMWnBXVGVuMTBZMmNTbWFSSzBZQUFINElqcVBQQ1pmUXYxT0t3c2Ri?=
 =?utf-8?B?M2crSjdzbHorT2tFeG94WXdoRmZKSFhOT2lOdTZLM2VuUVNGVHhYZ3VWcDRM?=
 =?utf-8?B?cEJCMWRLUUpvUGcySDhXT1pkZXNXNDhHbDN4MUVOVjNSYzRqMW9WM0x0Q0dT?=
 =?utf-8?B?b3VOMkNvbFZoU0Z4V0VYdVZ6SkNNNDJ2aTd4cys2NWFxa0NtSXlIaE9TbWN1?=
 =?utf-8?B?Ujlta3pZRDlXZVNqdXhnUG56ZVQyVFJUQXZ2WmlCMm4xaFY2b1NqczlFY0hB?=
 =?utf-8?B?ODV1WnZDbUxYZERGSGNJUVI1a3owZnJQZ2p6RTc0MU5LU0VTREdqM0FndTQx?=
 =?utf-8?B?QTdyK2pHNFJ1ckhmbDRHNm1saUVSaURZRVczMm41VFkweS82enRORE1vNkRI?=
 =?utf-8?B?ZTlJb29qZ2VvVUNtOHV5Qm8rc205cWREQWprV2ljM043YmdoRitQUWVENkJF?=
 =?utf-8?B?Q2Z0ZGJVTjJJcEhieVJvQkt3bFl1TzlMUnhudEdiTU5oNi80QkZkTXNlNjZX?=
 =?utf-8?B?RUVFRXdkK1dWTHp1aGRoa0JUZ0poMW81bk9oTmJRM0J4OFJHR3hNNVgxY2tC?=
 =?utf-8?B?eUkwWEUxUDgwazJVNXc0ZGRWb0pQeHZ1bEw5cStleXVNczkxa3hTOWVjYlZB?=
 =?utf-8?B?SHhZY1JrVVQyYzBLcVRUb0hiTnk2OEFQQm83OTZ5Mk5jQzFsNFVhblB0WUZR?=
 =?utf-8?B?ZGpqV3d1WVVlM1BQdXVkZkJLaHVuU1ExM2VNbTY0SnpmU3pxV1BNZkFTN3lo?=
 =?utf-8?B?RGgrRHpqQXdOZ25kV0F4dnZob244U2gzWmd6T0JjUVNXZnArdWFoUEZUWTZx?=
 =?utf-8?B?NHQxNFF2NTVOeVNCVllieW8zcTFNcytHZG5BNVgwTjl2Z3pZR0JZbVQ4bEhE?=
 =?utf-8?B?UEdxS0RnY3Y2YWp4cjB3UUhpZnhBK3dwa0Y1cVlHNTZGb0JhNFE3WE9CSXF6?=
 =?utf-8?B?RlRuU0tuQlBsU3VGczJmb2JjNHZ0VWpSTEhwUXhvQ1NqajJBWXk0T1Fpckdy?=
 =?utf-8?B?WUFLUlozRWhTYnlRWElJTTR1aFU3SXdhSi9WN0FYWGZjM1BGTjlGSHZjUUY3?=
 =?utf-8?B?MjMvQ0FVVlB4emtCUU9sdlpTanptZ2E4bTNBVjFnOUw4eDJXdWtRVjFMQkVR?=
 =?utf-8?B?SFVxM0NsSkRXMkpjOWRyUURLM0w5S0JCNFpTdzFEMFFoSWNTaWtFSkxEaWo1?=
 =?utf-8?B?QjdLY3hWbkNpVnNEUU1PajFFQ1BxREJ2eUl6Wm91OEdkMWpMcTEwYVJJSG9Z?=
 =?utf-8?B?eVlFWm82U3psNHFscFhXcDJ0Q3FTVFh0dFh0dkZ2ZHFZaGhuNXVEd2tLSTVX?=
 =?utf-8?B?bHFuMkExcWhqUGtXR3ZRdCtpczBjRG9uWUM3QXZkN0dzQkg1eDVHbjhQSkVP?=
 =?utf-8?B?VFJkZUt4bVNMQzVnbVlyalF1dkdnPT0=?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lYHjJ+g4YoDT6hUGp+RjsXMI8ALrursszd6B0ZgDlwXn9dPFZ/G5SXgpEA18RSuglAwg4Aw7lr7NRhpCOAX2S75lzga24u3euDuOU6c0WN5Tp9disDc8YjcZpCtKe12MzkGjKui7DYGrARDir2bWKU+rchsRsPCncYoWX6FPebW2966FXFgGcsPguf40sfBmyvkl/NETrj25LUOANe5EhvFM9o5w6dxCS7kPk+Ji4w0kA6kIZcws86eMQPd1JowM8u8JdUUgRf59a0VreBkljZfuRzkp4gDf0h1zo80rPoFYyfKxBXZrYNBv5wWFtVHqFaydqAlObnie4XaUYnr5IqkPlOs9nE0Hz1xFzGxlSL9DTCiK8piiM26o81DBDm7r2GlOVwkKSwDr+5BnYBLrBafkJEBjbHrCsOQUFeeYfeHUGLBQ0QsofLOuPFuY8ZFq
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 17:25:50.0362
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2ab9c9d-d489-4e2e-2aaa-08de64db9b74
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7894
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
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-16604-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[moshe@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 4FA2CF5E2D
X-Rspamd-Action: no action



On 2/5/2026 5:57 PM, Paolo Abeni wrote:
> 
> On 2/3/26 11:24 AM, Tariq Toukan wrote:
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
>> index 4b7a1ce7f406..5fbfabe28bdb 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
>> @@ -1304,24 +1304,52 @@ static int mlx5_eswitch_load_ec_vf_vports(struct mlx5_eswitch *esw, u16 num_ec_v
>>        return err;
>>   }
>>
>> -static int host_pf_enable_hca(struct mlx5_core_dev *dev)
>> +int mlx5_esw_host_pf_enable_hca(struct mlx5_core_dev *dev)
>>   {
>> -     if (!mlx5_core_is_ecpf(dev))
>> +     struct mlx5_eswitch *esw = dev->priv.eswitch;
>> +     struct mlx5_vport *vport;
>> +     int err;
>> +
>> +     if (!mlx5_core_is_ecpf(dev) || !mlx5_esw_allowed(esw))
>>                return 0;
> 
> I was able to miss the AI feedback here:
> 
> ---
> The old host_pf_enable_hca() only checked mlx5_core_is_ecpf(dev) before
> calling mlx5_cmd_host_pf_enable_hca(). The new function adds a check for
> mlx5_esw_allowed(esw), which returns false when esw is NULL or when the
> device is not an eswitch manager.
> 
> When called from mlx5_host_pf_init() in ecpf.c on an ECPF device that is
> not an eswitch manager (the path when mlx5_ecpf_esw_admins_host_pf()
> returns false), this new condition will cause the function to return 0
> without enabling the HCA.

The additional check I added here is actually redundant either if we get 
from old code path or from the new caller, both will call it as eswitch 
manager only.
So there is no concern on the old code behavior change, but I can follow 
up with a patch to remove the redundant check, though not critical.

> 
> Is this behavior change intentional? The old code would enable the HCA
> in this configuration, but the new code skips it.
> 
> The same concern applies to mlx5_esw_host_pf_disable_hca() below.
> ---
> 
> and indeed it looks relevant. I think you have to follow-up or send a
> revert, whatever it's easier/faster.
> 
>> @@ -1347,7 +1375,7 @@ mlx5_eswitch_enable_pf_vf_vports(struct mlx5_eswitch *esw,
>>
>>        if (mlx5_esw_host_functions_enabled(esw->dev)) {
>>                /* Enable external host PF HCA */
>> -             ret = host_pf_enable_hca(esw->dev);
>> +             ret = mlx5_esw_host_pf_enable_hca(esw->dev);
> 
> Just FTR, more AI feedback here:
> 
> ---
> The old host_pf_disable_hca() was a void function. The new
> mlx5_esw_host_pf_disable_hca() returns int and can fail, but the return
> value is not checked here in the error path.
> 
> If mlx5_esw_host_pf_disable_hca() fails, it returns without setting
> vport->pf_activated = false. This leaves pf_activated set to true even
> though the HCA state may be inconsistent.
> 
> Later, mlx5_devlink_pf_port_fn_state_get() reads vport->pf_activated to
> report state to userspace, which could then report incorrect state.
> 
> Should the return value be checked, or should the pf_activated flag be
> updated unconditionally to reflect the intended state?

When disable function is part of the unload/teardown/error flows we 
don't check result. The function is not void anymore only for the new 
use case that it is called from devlink and return value is checked there.
Thanks, Moshe.

> 
> The same pattern appears in mlx5_eswitch_disable_pf_vf_vports().
> ---
> 


