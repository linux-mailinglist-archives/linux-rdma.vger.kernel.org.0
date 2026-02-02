Return-Path: <linux-rdma+bounces-16355-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJ5aK73MgGl3AgMAu9opvQ
	(envelope-from <linux-rdma+bounces-16355-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 17:11:41 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 110FCCEBBE
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 17:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60585303F068
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Feb 2026 16:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BED3803D8;
	Mon,  2 Feb 2026 16:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eMJ1zB8W"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010035.outbound.protection.outlook.com [52.101.61.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4013627510E;
	Mon,  2 Feb 2026 16:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770048088; cv=fail; b=BI9gUQpHiSuxWtfUzBZlCz+xp0SIvDQJP6qROnEIP3IpdGt8L+Gej1lbkSR06RNRwmvIJZkGTBvSbYrDEeH3Mf6TaQpJ5jQoGzKH+TOSEIAr28W5gB0hSvU0xsS4of/TsG8we9yZdA3VNxK/3SOxKY3s16/oDpysu/p6wbja+Dw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770048088; c=relaxed/simple;
	bh=oOrG4s8PZBS3udqz30aIteNR/j38BACJjMB9urqX9nE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=L9u6cqdUBni0txT1s1AWqQdFXi63De36ppoSc7qsaulOxizaldltSIj5tJNbhLSuK6XQ1d4knUKhLAVIy8lUKkdj96AjbOPghcKUHV2oMJ6gNhWsbDq+1ZERFfmtan0bRjmjN0n/QqrKMelmng8wTnaB2TjIPumOFv++3JVTYM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eMJ1zB8W; arc=fail smtp.client-ip=52.101.61.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oFnbDApKSnC1h3cp99khj1xUZbRZgbdhxwA5K9TamMrTDSOqg1KLU4zn7WzzDjp+0io0eiWpey8DIbpWVfX6YS4Ome5pQGUl8pWQbKYHWXwLsJZyFM6pXJsUl6WPTQhMHKYAH7FeYfTA2nS0to0lmjOUze+uP7IXFBrC9nZQas4FZzsAQDzI0VypAbbQ+pP61Z5XRH0/e6OQ/WfBKf5EbO7REc2ingHnWS+DqAxmMBhZTXdGI5iHc7fcFf5I0mqeBzuHerw962sHqZIKNuiFPxtDLBi+5PyrDNmxJnQ9zd+fZaWONGZiv4GDOMY26steIbhAZe+1zaQ2kZ/tqSqZ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJkXXCDw2BUU8XiCw97D5K6jqpvy6VbjTXLilbL2ydA=;
 b=KVej1Q66IocwGEkHKt9iXoMkMRMJv3eYNO+V4wmXuzstWnzm6woD5E9+lArJO3AEs8VNhrI0SK77IxvqpbqxBweQXiUtfLcYWsUsrifeX4BA7wlxgAQNY4TdjaD2RaqBg85VVmRZFUkXXGA2qg2We3mAI8rHMYOBZ52wha+8Y/KD9pRtd78z5eD4Li7cjIawk1Kq9njZbyXkEJPCMBeAwvHlrvjUBKGWRWK1Az1YW95zJgeTomlLIEnGS0Sk5ZSG0Xt8Y0i1db8uCokMSn/lSoFBT++S33hRKf6hn/2xNWmrphcXhyEYgVgXvfGa7SHqDcTFPfXUk+Lg475YXIWo4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJkXXCDw2BUU8XiCw97D5K6jqpvy6VbjTXLilbL2ydA=;
 b=eMJ1zB8W/3miemGzpc9PWht5jXdpTEn7Qq+zS9Q8gnnJf3pE104/R3DSedvo2b3tcYOSbNKa8M0EC48NNlrOawAZ5xRk1eKOdBWIomCfRaZ6fYIbIp9tHEUHmbDTGSTKZBmKsrwLP11Z8NjqtK/QhsoXETcJkimb9f8rEW7Bt2g0BSoBSRKHNG0gtrdD+lcipnELg4T/hY21Usc9dTf3j//zjm4jsjDEsLp/TX03uvL5qJNc587mOZ7VjJ8SuA/CxeRdfw3Lspa9RKKtRsV5c+qPHtaOqtsqgzZkOVOhQ6bJ5zv5ysuZ5IpbP3f+414lpj3vtx6Rc4eC6akEGGXrvA==
Received: from DM6PR21CA0016.namprd21.prod.outlook.com (2603:10b6:5:174::26)
 by LV8PR12MB9358.namprd12.prod.outlook.com (2603:10b6:408:201::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 16:01:17 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:174:cafe::c7) by DM6PR21CA0016.outlook.office365.com
 (2603:10b6:5:174::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.10 via Frontend Transport; Mon,
 2 Feb 2026 16:01:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 2 Feb 2026 16:01:17 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 08:00:55 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 08:00:55 -0800
Received: from c-237-169-180-182.mtl.labs.mlnx (10.127.8.13) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Mon, 2 Feb 2026 08:00:50 -0800
From: Edward Srouji <edwards@nvidia.com>
Date: Mon, 2 Feb 2026 18:00:01 +0200
Subject: [PATCH rdma-next v3 09/11] RDMA/core: Add netlink command to
 modify FRMR aging
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260202-frmr_pools-v3-9-b8405ed9deba@nvidia.com>
References: <20260202-frmr_pools-v3-0-b8405ed9deba@nvidia.com>
In-Reply-To: <20260202-frmr_pools-v3-0-b8405ed9deba@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Michael Guralnik <michaelgur@nvidia.com>, "Edward
 Srouji" <edwards@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770048005; l=6384;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=tRuNHFygl6kNwY8L9XMNXdlPN3BgvFCKFFjuog/kODM=;
 b=ifLFrMun92ROAZCkTsQHSSDBW9sUioYT1eK4y/X16SikBZ9fDP73oQrQmkpNpQN/8ZI5cRUiM
 aNRL6riUr3bBtgCNjtjpyHgKGnZ3WoE8D2DJfZmUKdYWpD1oeAWLDKX
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|LV8PR12MB9358:EE_
X-MS-Office365-Filtering-Correlation-Id: a1fd5ac3-a6fc-43b0-9107-08de62744c92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aHNCaTA5SGg2SlEyMUt1RVhUaFFnUVJBRHRoVUxwdGFzcmFVV2dsbXFTMWtB?=
 =?utf-8?B?NFloUDM0QzBSc0I5cGFBR2VXOTR5S2dXVlVpL0dCVDdBSnhqcWRGSE41UGdB?=
 =?utf-8?B?V0tHMTU3dUFoSVJ6VzR4TmN1emIvK0w1dXkzUXpOck1ETjNXdEwwTnNZL1Zl?=
 =?utf-8?B?bnJaTk9sNzFhZ0x3aDlWMUdRTHY4b3BzS0VRWkY5RlpGQTh0TzhrY2Jlakdy?=
 =?utf-8?B?dWtIZS8waDBCMFlMTmdQWXZpOGJmRC9NVXB4RURIQ0JBSkZTOUFIbTBVS3V1?=
 =?utf-8?B?MVBVWVh0SEdpUEs3VXA4WTF2S3F3MU4yY0FnTGprL2d3NnZmeVllTmhPMndD?=
 =?utf-8?B?bE9OYm40VmtzVWJ1bzVvUU13azRaTDNrSnJCSVJJSUhFVHRIcVBtWVJsMUox?=
 =?utf-8?B?K1dWL0FuRHA3engxWE93empPQXp0OHI4SDZQZzFMaStqZXdiZkRvOVZTR2NS?=
 =?utf-8?B?bmV1QzM5ek5lUkRCdXkzeGdvNE5ZZDNJb3pPSTFZazVUb3VoQWd6c0J5VmVk?=
 =?utf-8?B?L0p2ZVhmcGVIUDhhcnd5UDdkS3pQUjNkVlJGTGNnUi90Y1ZGRWNuUWpCYTBW?=
 =?utf-8?B?clFYMWExcXRQVlRsQjJpd1Y0TGU1dnR6eGdSdXEzbWtuK3krQWdLZzhUdzBB?=
 =?utf-8?B?MHZyTjNEbk1NSDJoRi80eWU2WDhDenVTUkZ6eDIrNWt0emxPR21MNGlzOFdv?=
 =?utf-8?B?NWZIbWVaT0hKWXZDSFZGYXF1Q29wOExvZk94WlVjcDF6ZEhSMXdHQ1hpbkEz?=
 =?utf-8?B?TnlDUy9mZkpCdTN3VS9Mc0RiSERFSFUzMk5HRGlvVEhocFNHTUgzSXZONm91?=
 =?utf-8?B?SnFQMXg5VnlydzZmd3ErTW5EVW1FT3lPa2tseHptODdVeVFyU1lpRWJmZExL?=
 =?utf-8?B?Mm5tRSsyRHg1YVZxNlZ3bGttd1ZrZUN2eWlMNTlkUjFWbkdjdGptZnY3S0Jo?=
 =?utf-8?B?V3JpT0pubkM1MGxUQk0yY0UzdnlReTdHNWlTLzBhQXlJOXo5eVBXYzdKQkw2?=
 =?utf-8?B?UU5GRktWMCtsb3dhU3dWZ2NJS3ljNlFOR2pqYzRUN3NjdnJHVlpQU2RFMXZK?=
 =?utf-8?B?TXJQdm5JRFZTekJiVjdadkxiVDkwRTJPWGZWVjVHQjN4R2tkVWNBMWZ1Y3lR?=
 =?utf-8?B?UXFhZWFpNjNSN08xTGIyWmFGWklHNmVwcHFHV0lldlF5MERzbTJaVUNzU3dk?=
 =?utf-8?B?Q0dxQUVkVVlRVitWWENwYm82RlYrVGlSeVpVSVdxd3VjcStqWGQ0ampQOFdE?=
 =?utf-8?B?MWZvU0ZjN3M0TmF6ckYrakltdzVIVWJXY1djTGY1bitOUFBWbll3cmd4SXVX?=
 =?utf-8?B?UHBxdENTVnJsR1dEWnJkbjVHM0NvcVc1UWloYTdac0ZEUko1VUpNbVdrTXFZ?=
 =?utf-8?B?QlRBeENDblFhQzZ0ZGdtcUNtcWJEZHo0MHNQSjZnNGg4VU1oNUVlbW1xSk1Q?=
 =?utf-8?B?NExiNFR0cGJ3WWxNY2Uvem5naTBPVXJGZUJrK0taUGJ1Y3ptQlVaNzVNL3NH?=
 =?utf-8?B?eFZRcmR1NUxxMWF1Skw1Z1o0RDZsT2pWTmlSa1pDU3NLZFN1WTF2bWdrb1V3?=
 =?utf-8?B?Y3hKL3U3OFg2dzVuRVVINmlmUE5iWXFYRmg0dXBMKzdZdHpudllYUlhKWTFJ?=
 =?utf-8?B?N0tpZzM4aERhejNaQ2kwbm1DZmRSMWcvWHJ2Q0ZLYzEzZ3dxazFhUGRPK3E4?=
 =?utf-8?B?QVBVTFJvWlZ5L28yM0ZOMForOHZvN3JaSXlDbUJTcEdGVS92OTYxYzdWWU9I?=
 =?utf-8?B?a0tKNlI0c3l1VXZxUFc4UnlDN2ZlcHdjbGNtL3NRalplY2RpdERiZ3pNNkdE?=
 =?utf-8?B?bWVWcDRhcVdPMll0L3JNUDBtTU0vblp2YkFRQ24zajdYWjU0MHIwNjNCQWtS?=
 =?utf-8?B?L0dtS0xCM0NDQ0U3emQ4VzdqQ2VsanFpQkJVZDFVemxQRWhDMVpWd1NmU083?=
 =?utf-8?B?dFI2VjhtUDA0OG9UTVdIV3ZrU3BzS3Z1OXBnYmlsQm54R0l4MDJuRGMrS1cz?=
 =?utf-8?B?OWxBUmJMZm01akkrUWRwNEtpVVBjb0VuaWFsSG5EZzhIT2V4VGxUMW9TM0Z3?=
 =?utf-8?B?MUViRk42emJQd3RDTWZJRzdmWG5FaFFnZkpQUW9uMUhIZi8wemtpUkpIQjF5?=
 =?utf-8?B?TTMzck5nc2d2RitIcVhXOFEzT3dNWCtjTWlWV2FJSHluaERWaGFjSWdVcnZH?=
 =?utf-8?B?YXV6NnIrRXlnNmVJQlJ2MlI5UFE1OXZZL3BLNS81UStxd1lXUlBWV1ovL2JP?=
 =?utf-8?Q?fQFvXbpXNnWf7477g2tfWygCtRUH7G/FPj0OOTqYYQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	auHlW3WUXf8OTzLZdx+zMW47I4Q4fMx/DZrAYvAxEM45ACy9IJghSbFucZElCbHhrLy6uHcNCX29+y97HWYavKnr22ETv3HunflIQ1eu1ur1ASaFhCAAV01ErC8Rj9EO7W+RuW0ToF5YY/Vpg2IeygarVSUnyKmnb9ogg0HYmRS7dFSs9PnMgjkdI/PTz497ly3Lb2NI7gJ7wPBJb9XY2EMwHXpO0vsxy2ldONNJ4AjpWuh/am7QlwcntPw0O9/epveDZgG4pMpmZACJCTLOMbYYdNRh92zOTNmzZuUvtcAJJHKExuq/prw2BAhVyvdzVTHw5K15MnG87vB5QaozMbDl7IutviDgJTkePxVvySv2dxb9zlnsAkMIT6LxD5YgQDUFreQiaWRRzMScy/iwPChU4GKXnBrYRQxQREIFMWkMOtp7sny90IkDvAdxrp/k
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 16:01:17.2134
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1fd5ac3-a6fc-43b0-9107-08de62744c92
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9358
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
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-16355-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 110FCCEBBE
X-Rspamd-Action: no action

From: Michael Guralnik <michaelgur@nvidia.com>

Allow users to set FRMR pools aging timer through netlink.
This functionality will allow user to control how long handles reside in
the kernel before being destroyed, thus being able to tune the tradeoff
between memory and HW object consumption and memory registration
optimization.
Since FRMR pools is highly beneficial for application restart scenarios,
this command allows users to modify the aging timer to their application
restart time, making sure the FRMR handles deregistered on application
teardown are kept for long enough in the pools for reuse in the
application startup.

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/core/frmr_pools.c | 31 ++++++++++++++++++++++++++++--
 drivers/infiniband/core/frmr_pools.h |  2 ++
 drivers/infiniband/core/nldev.c      | 37 ++++++++++++++++++++++++++++++++++++
 include/uapi/rdma/rdma_netlink.h     |  3 +++
 4 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/frmr_pools.c b/drivers/infiniband/core/frmr_pools.c
index c5abfc59f9d6..1493bf2cb064 100644
--- a/drivers/infiniband/core/frmr_pools.c
+++ b/drivers/infiniband/core/frmr_pools.c
@@ -174,7 +174,7 @@ static void pool_aging_work(struct work_struct *work)
 	if (has_work)
 		queue_delayed_work(
 			pools->aging_wq, &pool->aging_work,
-			secs_to_jiffies(FRMR_POOLS_DEFAULT_AGING_PERIOD_SECS));
+			secs_to_jiffies(READ_ONCE(pools->aging_period_sec)));
 }
 
 static void destroy_frmr_pool(struct ib_device *device,
@@ -214,6 +214,8 @@ int ib_frmr_pools_init(struct ib_device *device,
 		return -ENOMEM;
 	}
 
+	pools->aging_period_sec = FRMR_POOLS_DEFAULT_AGING_PERIOD_SECS;
+
 	device->frmr_pools = pools;
 	return 0;
 }
@@ -249,6 +251,31 @@ void ib_frmr_pools_cleanup(struct ib_device *device)
 }
 EXPORT_SYMBOL(ib_frmr_pools_cleanup);
 
+int ib_frmr_pools_set_aging_period(struct ib_device *device, u32 period_sec)
+{
+	struct ib_frmr_pools *pools = device->frmr_pools;
+	struct ib_frmr_pool *pool;
+	struct rb_node *node;
+
+	if (!pools)
+		return -EINVAL;
+
+	if (period_sec == 0)
+		return -EINVAL;
+
+	WRITE_ONCE(pools->aging_period_sec, period_sec);
+
+	read_lock(&pools->rb_lock);
+	for (node = rb_first(&pools->rb_root); node; node = rb_next(node)) {
+		pool = rb_entry(node, struct ib_frmr_pool, node);
+		mod_delayed_work(pools->aging_wq, &pool->aging_work,
+				 secs_to_jiffies(period_sec));
+	}
+	read_unlock(&pools->rb_lock);
+
+	return 0;
+}
+
 static inline int compare_keys(struct ib_frmr_key *key1,
 			       struct ib_frmr_key *key2)
 {
@@ -517,7 +544,7 @@ int ib_frmr_pool_push(struct ib_device *device, struct ib_mr *mr)
 
 	if (ret == 0 && schedule_aging)
 		queue_delayed_work(pools->aging_wq, &pool->aging_work,
-			secs_to_jiffies(FRMR_POOLS_DEFAULT_AGING_PERIOD_SECS));
+			secs_to_jiffies(READ_ONCE(pools->aging_period_sec)));
 
 	return ret;
 }
diff --git a/drivers/infiniband/core/frmr_pools.h b/drivers/infiniband/core/frmr_pools.h
index b144273ee347..81149ff15e00 100644
--- a/drivers/infiniband/core/frmr_pools.h
+++ b/drivers/infiniband/core/frmr_pools.h
@@ -54,8 +54,10 @@ struct ib_frmr_pools {
 	const struct ib_frmr_pool_ops *pool_ops;
 
 	struct workqueue_struct *aging_wq;
+	u32 aging_period_sec;
 };
 
 int ib_frmr_pools_set_pinned(struct ib_device *device, struct ib_frmr_key *key,
 			     u32 pinned_handles);
+int ib_frmr_pools_set_aging_period(struct ib_device *device, u32 period_sec);
 #endif /* RDMA_CORE_FRMR_POOLS_H */
diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 6637c76165be..8d004b7568b7 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -184,6 +184,7 @@ static const struct nla_policy nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
 	[RDMA_NLDEV_ATTR_FRMR_POOL_QUEUE_HANDLES] = { .type = NLA_U32 },
 	[RDMA_NLDEV_ATTR_FRMR_POOL_MAX_IN_USE]	= { .type = NLA_U64 },
 	[RDMA_NLDEV_ATTR_FRMR_POOL_IN_USE]	= { .type = NLA_U64 },
+	[RDMA_NLDEV_ATTR_FRMR_POOLS_AGING_PERIOD] = { .type = NLA_U32 },
 };
 
 static int put_driver_name_print_type(struct sk_buff *msg, const char *name,
@@ -2799,6 +2800,38 @@ static int nldev_frmr_pools_get_dumpit(struct sk_buff *skb,
 	return ret;
 }
 
+static int nldev_frmr_pools_set_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
+				     struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[RDMA_NLDEV_ATTR_MAX];
+	struct ib_device *device;
+	u32 aging_period;
+	int err;
+
+	err = nlmsg_parse(nlh, 0, tb, RDMA_NLDEV_ATTR_MAX - 1, nldev_policy,
+			  extack);
+	if (err)
+		return err;
+
+	if (!tb[RDMA_NLDEV_ATTR_DEV_INDEX])
+		return -EINVAL;
+
+	if (!tb[RDMA_NLDEV_ATTR_FRMR_POOLS_AGING_PERIOD])
+		return -EINVAL;
+
+	device = ib_device_get_by_index(
+		sock_net(skb->sk), nla_get_u32(tb[RDMA_NLDEV_ATTR_DEV_INDEX]));
+	if (!device)
+		return -EINVAL;
+
+	aging_period = nla_get_u32(tb[RDMA_NLDEV_ATTR_FRMR_POOLS_AGING_PERIOD]);
+
+	err = ib_frmr_pools_set_aging_period(device, aging_period);
+
+	ib_device_put(device);
+	return err;
+}
+
 static const struct rdma_nl_cbs nldev_cb_table[RDMA_NLDEV_NUM_OPS] = {
 	[RDMA_NLDEV_CMD_GET] = {
 		.doit = nldev_get_doit,
@@ -2908,6 +2941,10 @@ static const struct rdma_nl_cbs nldev_cb_table[RDMA_NLDEV_NUM_OPS] = {
 	[RDMA_NLDEV_CMD_FRMR_POOLS_GET] = {
 		.dump = nldev_frmr_pools_get_dumpit,
 	},
+	[RDMA_NLDEV_CMD_FRMR_POOLS_SET] = {
+		.doit = nldev_frmr_pools_set_doit,
+		.flags = RDMA_NL_ADMIN_PERM,
+	},
 };
 
 static int fill_mon_netdev_rename(struct sk_buff *msg,
diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
index 8f17ffe0190c..f9c295caf2b1 100644
--- a/include/uapi/rdma/rdma_netlink.h
+++ b/include/uapi/rdma/rdma_netlink.h
@@ -310,6 +310,8 @@ enum rdma_nldev_command {
 
 	RDMA_NLDEV_CMD_FRMR_POOLS_GET, /* can dump */
 
+	RDMA_NLDEV_CMD_FRMR_POOLS_SET,
+
 	RDMA_NLDEV_NUM_OPS
 };
 
@@ -598,6 +600,7 @@ enum rdma_nldev_attr {
 	RDMA_NLDEV_ATTR_FRMR_POOL_QUEUE_HANDLES,	/* u32 */
 	RDMA_NLDEV_ATTR_FRMR_POOL_MAX_IN_USE,	/* u64 */
 	RDMA_NLDEV_ATTR_FRMR_POOL_IN_USE,	/* u64 */
+	RDMA_NLDEV_ATTR_FRMR_POOLS_AGING_PERIOD,	/* u32 */
 
 	/*
 	 * Always the end

-- 
2.47.1


