Return-Path: <linux-rdma+bounces-16638-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PCjFzG7hWmOFgQAu9opvQ
	(envelope-from <linux-rdma+bounces-16638-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 10:58:09 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DF2FC54B
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 10:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E505301A3A1
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Feb 2026 09:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019A336075D;
	Fri,  6 Feb 2026 09:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C60kqS2W"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013065.outbound.protection.outlook.com [40.93.196.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7671732ED38;
	Fri,  6 Feb 2026 09:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770371794; cv=fail; b=TK7YhNNXM5O8brkOLOsVWRmLM5pQjZQLgi1ZQD+9WfqDUmDK9RkSDw9x7sQeQrzGA7qslvDm6LISpX4IHCKYZtLi/+sCdcrOlr+U95ylxNw161uCQ8K3WM8LTCbgInDqRuA5hoF6tSKXJRNjxSSBDH/SXM9i2VnfQc1AvEz3mg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770371794; c=relaxed/simple;
	bh=oQ2vVnrhBwiGg8GE0fMHAFMKBwJ97G7q49d0omivxKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fnKkNJAqO5QbmKQzr0l1rgTI9OyU4edO3KGNxh/2Vm/Xd6eCrNgx6HjZWDSnEqiRW+tLJ3Nlpsw7ersOquAJp6um3MTUxZf8ACZ1dqAsdsZfuO1OJUsYUKkW84yzsz3hdmd84xqxQfA/X1Wr1K6I1+TX4NL8bRMfcfej/M7HV7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C60kqS2W; arc=fail smtp.client-ip=40.93.196.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T3fyM14qFWiTjUQQJkdZH58/vnRwWrmwuf0X1YOYVwXPGlo9zO+l/Ypv06yNj/yJajYnw59h/46MAXAbLZXW1X5j/3KOi2RvQgMqC3M+fwDKnGfsluIVtNESVm6dMCBJOb1fGozHdXaLj6R7+BiUvBm7wIpYAdJD/D4whJLobWzVNwEbJk0iDCqLpQJ3gG8os98h+tVYth+EoMJc/+YsBTAl62tm1AkWz7DNV97BEjwH2cJQv/YDCp9f426dgfheh576HAB4QTrAkXWV+xWiraBY75x1iUSGIt6pdZkr3BTlSMEjwytyYbDJ8aKyy9JRMXvMXVyKeQnfeiereqCvbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0cS0TwWoPa1Z6OSy0L+tvNlX2YrEB1G6N+SDo8mqolY=;
 b=pXJXWZIpy+i30ZN24rw4F90qkyRjGnAJtYwjozpL+11GLFVLUkOhNKiKwWn3GBEo90H4+kjQ0k1CfMaoh/y6JphFEBm1Qf5391qDnWWWx52jM3oSpkO5IDA6gU/lKXBWPCZ2w1l9mDWGS1rNMhVuP7zsPCrfHCHZ1Ek6rmXR7HENM2hyyod9UNp3OO/TpxkyxNBBlgtELxawdlqG6FrU7hNsA74uS7Xt0hS6d/+JGq++om/B/F4/8IyF/Ch/dn8Xhan4H0x/w6GTsGK13E9ZQ3mDRg3WeuYubajTPG3DCQKL7I16NvIzsmGnt6+acm39IdOODCDHGbur3VOQXS2S1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0cS0TwWoPa1Z6OSy0L+tvNlX2YrEB1G6N+SDo8mqolY=;
 b=C60kqS2WXReE+IiluVQgIy6gH5au3DQYkHvSpGUk28f0fNmw3iENYj9K0loq//sXRAiDrge8bsk02Yix3mH658bu11OB2FWwzPTyfGRAOcDicJSVAAzdNNx2bbxqZw8+jjOLF+u36XiIOua6utMYUHzjuo20hcdZFAV0ssPT6x+YFNpxyaPpbeue8hmrmmkItNCr139QKVJf4YdU1WSirIogO0OA9IRw7YPwAm6G9kFaN1/hoOekQq024g8DQS2SQUg4fIQggxOE8FX/EcPYlVMPbj6/EF9jHrcIJxIo+I1vwmDptW60ZsX5kiSrNAlEiKtM+GcJSBoRUdBw6WEalw==
Received: from CH5P222CA0019.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::20)
 by DM4PR12MB8451.namprd12.prod.outlook.com (2603:10b6:8:182::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Fri, 6 Feb
 2026 09:56:28 +0000
Received: from CH1PEPF0000AD7D.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::50) by CH5P222CA0019.outlook.office365.com
 (2603:10b6:610:1ee::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.16 via Frontend Transport; Fri,
 6 Feb 2026 09:56:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD7D.mail.protection.outlook.com (10.167.244.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 09:56:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 01:56:13 -0800
Received: from [172.29.249.233] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 01:56:08 -0800
Message-ID: <8da9781c-4b89-41cc-8810-8312ef7c2c81@nvidia.com>
Date: Fri, 6 Feb 2026 17:56:08 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [net-next] net/mlx5e: fix ip6_dst_lookup link failure
To: Arnd Bergmann <arnd@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Arnd Bergmann <arnd@arndb.de>, Cosmin Ratiu <cratiu@nvidia.com>, "Raed
 Salem" <raeds@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260204130057.4107804-1-arnd@kernel.org>
Content-Language: en-US
From: Jianbo Liu <jianbol@nvidia.com>
In-Reply-To: <20260204130057.4107804-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7D:EE_|DM4PR12MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: 640c52a7-0e1f-443d-a553-08de6565ff3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RitWeFU1dGhqdGZsQVNpTXNaTGxSR1JZbnY1T3hiV0pwYzkvUHJkUm9TWW5u?=
 =?utf-8?B?dWV5RFIrek0xcGI3Y2xiYUw5ZjJaUkF2VTBna01vTUtLaVdCZFk3Rm51a0dJ?=
 =?utf-8?B?WHRtTmdQdFgwd0hmcStodUo2dUtsaUU5UXFxbmVqVFM1cC9kbEIxUUN4SlZw?=
 =?utf-8?B?SEZhL3UxWWpXdi8vSkZpaUxqWGpOcUJyR2ZuYW1lcDliSDZKQkxTZWxlaVhk?=
 =?utf-8?B?RnN1Vnc0SDhwdVdZMFgwWGRzdEhzTEllSFAvSWdpbmZYYlJucFZDTmJrb0pN?=
 =?utf-8?B?blJjb3dTU1lxRExMNUYzT05XK0FQdmlVRldYT3MremZNR25DL1YvYk91WCs5?=
 =?utf-8?B?OU5obzVBVUpwMUlNcHRJdExlTktybnNOc2xxYkZHclFMSi9YajNJNjN1Z3pR?=
 =?utf-8?B?SVpySjFiY3FCMUIxYlhjZktCVGlZOHRkVzArS3M5cTh0NHlwaEVYejNiUCs4?=
 =?utf-8?B?d081U3NUN21hNjZnYUw5eitFTWFhWGJmRnFDbDY0WFFzTUM5aG9HVlF0QTd6?=
 =?utf-8?B?WjlCcVV1V0c2dUJJMEt0MWw0TlIza0lyWlg0VXBOQ285RHZ5TEFZdEQ1cjN5?=
 =?utf-8?B?STRscUNYaDVLV3dvMWNMYkpCL0Q5WXhWd0d1TDdtSytsa1BZdVAwbHFsVXpL?=
 =?utf-8?B?emdEZHB0U0ZsM1pPdnFGbnRzOWx0ZWVFM3dRN1QvcCtkQjF1THFHYWVZQS9G?=
 =?utf-8?B?aGF3b09iVm5RYTNjMWp6dSsyM041NVhHNHdScnZaK2VDZjNEalVtaGMvZVBS?=
 =?utf-8?B?bUJwNlM3UkNGb1pod2NOMS84aU1Ia282ZktjL2JtNDFRdjE1S3NEOTBxWXBu?=
 =?utf-8?B?S1JzTjh4aGhzZ0NHWkxQK1BrZmZRY1hRTFVJaGM3NE10SHYvRG50U2doZGUr?=
 =?utf-8?B?T2hUazArNU5UeUplWE9Lcy9aNDZHQWQxQWI1R0M2d2F5Q0llQ2tKTnZkMmRI?=
 =?utf-8?B?MHpzVytFUE9JcExpaHZ2UXhXRFc3bVFZbXhNdVBySk1TR3Zvb2xMb29JbTNS?=
 =?utf-8?B?dTNRZVhYWHpvdjB2Zkl3MjdNTzN5bnlwYW9RazFHbzZPL0NlbzlJcWxmRTNk?=
 =?utf-8?B?SXlBbHFidDUva2RvUm01d2UveFRkajJiRFRxa1FoNHc3SVVQWHNHUERkbEZj?=
 =?utf-8?B?UEZNYVdFcDJyd21zYmJ4MHN3WTdwRWR6NjVteitvUVRsSmQ0eTZDclJSSFp5?=
 =?utf-8?B?WUZYNlNXM3hXVkNOaWxCOExMQU9FT1hkaDlkeTlYalBybWlicExaNWhrU3Nh?=
 =?utf-8?B?dVJ1MThUQ3UzY09YVVpuOXNjbGo5eExONnJSeXAvWmZGaFlXVVJPVEtMK3Ju?=
 =?utf-8?B?K01xUnRuMHdmanZsQnpIMnduUFRZeGpoWGF1S3FzZ0tiRkNGaGdhcEhIZS84?=
 =?utf-8?B?KzBTOExrNTZvcEkxcktSR0E3d2lqbks4ODY4TXFYbVNZS0ViSHZZR3VzSWJU?=
 =?utf-8?B?ZWV5Z3VOaW4wS3lxL1N2TzRlR2ZrWHFDWDlheGdoRy8vdCt1ZGlHeGEvK0NH?=
 =?utf-8?B?Wmh3cjB2OTBxM1BRQ3hsRFpNM3JmTE4ra29mV0E1UG0wNGYrRExkR2JjQzd3?=
 =?utf-8?B?TU53TDd3WVdydi9iZ1BjNFU3RTN3Z3BWWUVhRklaZEk3aUFyOFdUeGxzZWhQ?=
 =?utf-8?B?SmtTanp5RkwvbnNHS000VmdFZjhOa2pYVisreGxvejhoYldWQy9tNVg2NFdu?=
 =?utf-8?B?N1RQc0FybDNlOFo2TFZMUm9kQ2hzelFWYTZmTldJVFBIZGUxWTNtQXRWaEZ3?=
 =?utf-8?B?dEc2cFhZTllqemlKZ04rSHNydlJ0Z1JicHJrTWpyT2NEVC8rRFNpeWh6OXFG?=
 =?utf-8?B?bG9TbmYwZm1Ldk1uN1dqbyt4SnlTbkpXNmRHYkI4ejkzM3AraHJsTGdNQWpY?=
 =?utf-8?B?N2RRWE9tYUtjOHgwWEpIN0xFcFNCc1dSK0d0ekd5ZisxdGY2Ly9FMmJsa1I3?=
 =?utf-8?B?NnlueXZqUnBHMnN1ZkZ1b200d3BudktNS3M3V05FT3BMQitGMmlpNFVjUE1V?=
 =?utf-8?B?TnpsdThsYndkUDkvc0RLTHVBbWJEN1R2SFlCb0c2dzhTS3JtVzdvT3Z1citk?=
 =?utf-8?B?ZkZ6VzhpaklEbHUwc3VSeUxka3MzYjIrMW15OCtPUndVdm54eThpeHVuaVR0?=
 =?utf-8?B?bFYvU3pXbzY1K0JuL3FxS05YNjlQZVVzRTE1eWdiZytaTVd2SWFCUlBQWEIy?=
 =?utf-8?B?K051aDZyd1BTRmdRSjFxcWIrMmhtcVNyT1poandoLzAzZEtNSmZ2WlVWT041?=
 =?utf-8?Q?WrsgMhMXRUbyhI+jhTTkldPzE0ZeMdeV5aFAz1kIl4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024)(921020)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1O/pSNjYv35x6bpDAW70NdgDWictEkKWvZ7cPLuKpIOrXg+n9LOpgRDD+xneEoRd6wbXBU7V4sxvMrO+KS8nVUPpq32M3rBplmoMm4DnNvihJ9EALmFPWFMYqkVxliFDrkBGzzrNRPyTiDJ5rNKudLw+WNTfwlXX4Znme2ZlCjqSoK4N/iTW6pSg6vMud6ozgvCVJ7f/quEAaEpCY6Yo1Z61aZJxOXqrI0LsaMmsTzYzJ7EonyjkEgyYP/OcdRrsj05M+tVBQtPATZ8GLUYzzyPHP1BPYtbbleAEjyXZ0YLTHHp6jYw+A8qbjmy3R2RpjC24HU/SoE3nWEAdnNCChsT6aehNIpSqcZdlAEfPzeXsYuYIlDCeeS+pGO8rjGpZRRgxdp9ro6vjm3euBXaCuSk9Rgzv7M7LpGzF7QqkZXKbq9TH2PWkWCl6gRYqLOA6
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 09:56:27.9655
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 640c52a7-0e1f-443d-a553-08de6565ff3a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8451
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-16638-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,Nvidia.com:dkim,arndb.de:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jianbol@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: E3DF2FC54B
X-Rspamd-Action: no action



On 2/4/2026 9:00 PM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Changing mlx5 to call ip6_dst_lookup() means it now fails to link
> when IPv6 is a loadable module but ipsec support is built-in:
> 
> ipsec.c:(.text+0x1061): undefined reference to `ip6_dst_lookup'
> 
> Add a Kconfig dependency that removes avoids this configuration.
> 
> Fixes: e35d7da8dd9e ("net/mlx5e: Use ip6_dst_lookup instead of ipv6_dst_lookup_flow for MAC init")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Kconfig b/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
> index 9cf394c66939..c298efe93f97 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
> @@ -154,6 +154,7 @@ config MLX5_EN_IPSEC
>   	depends on MLX5_CORE_EN
>   	depends on XFRM_OFFLOAD
>   	depends on INET_ESP_OFFLOAD || INET6_ESP_OFFLOAD
> +	depends on IPV6!=m || MLX5_CORE=m

Thanks for the fix.
I received a report for this same error here: 
https://lore.kernel.org/oe-kbuild-all/202512261850.P5Jp5BSz-lkp@intel.com/

We were about to send a fix ourselves, it is to simply add:
   depends on IPV6 || !IPV6
Is there a specific reason to prefer "depends on IPV6!=m || 
MLX5_CORE=m"? To me, the IPV6 || !IPV6 syntax seems a bit cleaner.

Thanks!
Jianbo

>   	help
>   	  Build support for IPsec cryptography-offload acceleration in the NIC.
>   


