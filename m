Return-Path: <linux-rdma+bounces-16357-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WM8pCZnMgGl3AgMAu9opvQ
	(envelope-from <linux-rdma+bounces-16357-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 17:11:05 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0EFCEB9A
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 17:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0FEE531AB0AA
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Feb 2026 16:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CD53816F2;
	Mon,  2 Feb 2026 16:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i6sX2/a1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011017.outbound.protection.outlook.com [52.101.62.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5144B37D13F;
	Mon,  2 Feb 2026 16:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770048096; cv=fail; b=CijOem5+TUJwGnkJeQkcRb+j67GdmZC/CdJkOL9qF/ABhzCU+1xTfnA0CFQwM9nfw3ZZA6URaTjlrYwtphbGLojloMN8uJc82nAIBYN3uk88HfUoQ3rh1Beg2SaNuX9nUZKr0C92vCf/D+h9IqhLy2nR6zJrwdAZTkVMgUThQxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770048096; c=relaxed/simple;
	bh=/niTC4tmJWtHh5uD7XiieZjM2PMX+iwEc8ZXi4MUeaE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=fKyyQI/aqq8FBSxdWi+kIMFs8GjoeM9+79N7dNUFu3gVmwLs6MhBieybSkxPhBKZbOgSqeIUyxeUvrcO4gj1cEsFXDiUys7UPfGmQtpwNge1d9A7dvsod7jOlz1V4EbisLGSKdINsk0qyuX52CEFzLS4V+dCxWhoUwRdjRHzy/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i6sX2/a1; arc=fail smtp.client-ip=52.101.62.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nP5uIlbtgbDSWaPwHCjs5tNW7jf5v8G+HwYkYIK6bKOfkSpAZ1LhvrkMStFlg+RX5gf4TZk1Fw3ShWevPn1ybJ3TfUfkori9toESfTEcJDDCdtrBh5+8ZbD9bNzDrCqgb/SaXCuyze6ZDL0QJ71T0s8sNk6Iq/KVaJU/3pIiitYIwBn2qPj9DGDms2p4PQ8ZqUYEmeen3xppsEXgkkKJUxbUMmsU52BaSmot9sPzm8LIHB4ksE6OuBksKJYNreaKzi4TU6daWURHD4JMa5/sjBwUMGWKELHSw5zxfHSjN4VzrVtOnR8SsF8bCWPAMOA08wwVS60iHsxRj9um+MzB0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SEFHxdgNRJVKdgIGNKTpOyV6n1992e9Q53kRZrMpmwM=;
 b=e9ouQW4nXxJujpvmqL6N3FY3E1q4+7P26Mdg1MDzNewTOxTmuxu0VkXTzVXSc0x3LWtyPJ9800Cj30YqJ3Gb6N6Ei25k13pq+050wCjGeKdhZRG7dOLhQYXqazKFP2RD+HXr0BclRfm7yx8sy/X2zKzsWPRtEyp3GDby7yWn2I74eikZn0SBrJrKbiMeta+a6fGSYuLAyFnWBaGYwrUgg3Feear7g5A6eX7OjW2ecmLPdmHEJCaHn6tFy9WXSsf4b6kNCCGJQIWPa+DihyicrOJDUoVqRZhcvkBnDHF23oKgd4u5izG4cRyBaTUuTF4C3PtVQxcS3/T5H6Vol+Tv+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEFHxdgNRJVKdgIGNKTpOyV6n1992e9Q53kRZrMpmwM=;
 b=i6sX2/a1ctaIKFpcD7GuYAOGATfUo44JKNbjAZv+ywofiPsW4GYD3J+CxrPFjTa2OkWnHP+UflzKLpx/ekUtCCNKF5n0W3hD0BM6Mv9UXLWhTUJwuGzBBsoNALHRK51/nDRx5L8Ugaa8fJ8pDiOjYNejAZfM4DgUv+pZq5XiLez5aujkcq4+Q9pVzYpvYXElXXoP50Z54HV2ebL7jADqNuseqMkRqGRrUQ7cbRn7n3WdoDxrIu882hCd3QIheNCoJWyVd/L71gJOBDu54918vh7YmtbTJOQFE+BW7aohmi0LEXoAbFcJI580dBlr8BJJJgrI3zoPpXHWQLUMfPx71w==
Received: from SN7PR04CA0035.namprd04.prod.outlook.com (2603:10b6:806:120::10)
 by DM6PR12MB4059.namprd12.prod.outlook.com (2603:10b6:5:215::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 16:01:30 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:806:120:cafe::7) by SN7PR04CA0035.outlook.office365.com
 (2603:10b6:806:120::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Mon,
 2 Feb 2026 16:01:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 2 Feb 2026 16:01:30 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 08:01:05 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 08:01:05 -0800
Received: from c-237-169-180-182.mtl.labs.mlnx (10.127.8.13) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Mon, 2 Feb 2026 08:01:01 -0800
From: Edward Srouji <edwards@nvidia.com>
Date: Mon, 2 Feb 2026 18:00:03 +0200
Subject: [PATCH rdma-next v3 11/11] RDMA/nldev: Expose kernel-internal FRMR
 pools in netlink
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260202-frmr_pools-v3-11-b8405ed9deba@nvidia.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770048005; l=4321;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=ItLQsRwpSEeg2d+YlbUR87TeTE97w2C3BY/hwCOvBJU=;
 b=/nT0KWsDnAVZOFVFTPfdtxS3QSSSKL9lkRTPm9OMyYbf1ktg9RSWlxu5ck+0ZG/yDV7BbS7Fi
 Ksj9WnYgvSzBY1VjfRyP89ztC/1CpSb0hDonFG+8NZFyTHq/FJeGNHT
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|DM6PR12MB4059:EE_
X-MS-Office365-Filtering-Correlation-Id: bcfde804-821c-4453-29d8-08de62745491
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bElGdXMzdjhzOFdQQUd5b1grOHpFMk1QQytscnRKZDZRSHJVOXVwZ01IWnNv?=
 =?utf-8?B?bmhQcFBiZlFpSGhRNlhxdll4eGJFYmppVXVtVytCMllmYVM1bXlvall3cHR6?=
 =?utf-8?B?eG1FV2NlT0dKV3psQnRBRWQzUUw1SVVJYWVhRU9yTnJGckRBZnVGOXN4YVVG?=
 =?utf-8?B?YTJaK2FTSEZKNnBVSE5BblVId29aOXlvUnZKZ1JOS0M5elRndm51cXVjZ3g5?=
 =?utf-8?B?Sm5QOHdmb1NkamNFNmx5bHBiNGt5NUR0SWgvQncvZk55YWcvOFlPa1NLMERL?=
 =?utf-8?B?ZjFYbEtWSStwT3krTk5pOVh6emFFNUV5TlJaWGMwQkhNT2xHKzVwZUNjZzIv?=
 =?utf-8?B?RWNKNGFDa2pVMEFwRCtHbFhuTCtWdlpkRVJHc0pTbWtib0FyeXFKRXpIN3hu?=
 =?utf-8?B?KzVyQTd0dkZTVktYU1llRGRHWmRQU0FmSEtEeU1lZHM3VE8zZHovakh0NlZK?=
 =?utf-8?B?VG01VEpKRk9naEdMNHZMalBNNCtLTjBsSXk5eGhQbXF4VU1maEJneTRrSFhM?=
 =?utf-8?B?YmdMQlNNZTBTazBCKy8rbm0zejF1MnkxL0kwNXRHaVFOcjNKdFZYbUNMZU9N?=
 =?utf-8?B?c1l0QWtYY20vYzUzbkxpcitydUY4ZjBweWtnQnJ0ZzlVaGE3N3V1MFBkZ2Vn?=
 =?utf-8?B?RzdTS3BkcTBZY0JrZWgrcEU1TzljVXVDNWt1R3N6QUtMaGowaExISmxDT2JK?=
 =?utf-8?B?Y0VOWVRjS2k4MW9iRm56R2hKSE5mNEVFTUlkN0hpNmNsbzBqSHQyRnQwSktO?=
 =?utf-8?B?SzdRRGViVHZDUVZpNEFpZ2tFdmlDd3NYSldBQnMzQVlEWHcrRmRwaU5ZVkw2?=
 =?utf-8?B?cnFxOThGVmNtelFCdFhkVzhXaEF1M3RDOGxZclhseHFaV1pZSThRMVluTmxL?=
 =?utf-8?B?RG8wNmF5TEZXbUc3dXlid1gwaUR4cGg2VVBVRTdhUzB6c0Z0akM3Y04wZ0k1?=
 =?utf-8?B?MHJyeDRodEVUNFVHWC9iSDVjOTBVeFRTSGQ5WmJxNzVwZExFQ3d4QlhUdUlY?=
 =?utf-8?B?eVBRbDNnWVJ6OVRBUmxpYU5EZ0ZxUGU0akUxMG5remdac3ZXT2ttT25vRHFw?=
 =?utf-8?B?MUU2THNJdUJBanB6VGpBdUk5akE0RVlQR1M0eGNiZkJNdCtrMTczTXRRNTRC?=
 =?utf-8?B?RzBmZlhuT093clIzdW5PMGlMa3lhaWQrNDkwSEhHSExodnc2MDV1Y3pLSjBL?=
 =?utf-8?B?eGlWV1FIcDFoWXFCbHVrMlBCZXZpbXgrSDl0YkpMU05NLzl0OE1EbGdqQnVE?=
 =?utf-8?B?YzYvdWZWUVUwZzRDbTFIdUQ4UGRtQU9vbVF3UzJCSCswdC9tSmdrbW1ucDE5?=
 =?utf-8?B?UncxSnV0YTMzY0c3WXZra2lBRzNhMGMvZm5xTzVHNXlvZ0NMTzZPbWgyblB4?=
 =?utf-8?B?UlZnbkh5K0tWMnFZNnpraUZBRllvZ1k5WGY4ZFV2M2VETk1NNXlLeW1tTk5u?=
 =?utf-8?B?ZTd1STNrZC9lWU1WSHZJbWRLUkVvWlBBUWhDclJrUXZzcXFmM1FJcmRqbDJS?=
 =?utf-8?B?YXAyeVNjVmtsc0V2QnVCMUY5QkJKZEVBekxoRzROamFaN2NKOStQaUc1RUM5?=
 =?utf-8?B?STRXVkVvNXYySE9CSHVPNWh3ZW91ckFFYUttaWtPck96eWxpMk9TZW5RTlFx?=
 =?utf-8?B?My83NXEzakZtdHA2aHdzMEhtNG4xRDhSbXNpeTlSeGNuT0pRcDVzMktRQTdF?=
 =?utf-8?B?YTV1YzNhRys1YlJabm9iYnd5bzVyb1lPQTlndk4zQWdvbXpJOHhyWWQ1cHlz?=
 =?utf-8?B?cHlPTHZnU3BwMTlzc1VUazdSdFQwTGNrTkJnbWEwVENUb2U3L1JacUh0WUZH?=
 =?utf-8?B?RjNCR28zTCtycXhYZld3cVBoS2ljRGdCRzQ4SFdzdG9WVWlzQ0s4K1RlbUQr?=
 =?utf-8?B?M0MvSzlZY2U1NnY3ZnpiM2MwblU0ZWFtVENTdnJyL3RKUVgwU1VXWTdsbmho?=
 =?utf-8?B?S0dQSjUxTXlRc1dRcTRHZjE2RmtnZTliQlN5ZlRDaHdmeHVjOTFqSHBVRDBp?=
 =?utf-8?B?NHBlWDR4NnhhQm9LQ0doZmRIWHFmbTU1bXhYVTZOeG56R2RDMGlZMUwvbWRL?=
 =?utf-8?B?b1dtRkdSdGhkcHRrb0ZZOVB3S3ZMZzBFL0wvOFc1aWsrcU10VnJja0lnWmo1?=
 =?utf-8?B?Nng0aGVjU0IyQ0RqRVZQWjdVSC9GTVVWVk9sNHdjcTZQcjdlWWVXcEUwQzND?=
 =?utf-8?B?Ym5Dd3FnK1drUDd6c2xzQzJmdHE2Mm8vbnlGMVRSbkU4R05hMFZVT0lCWXBz?=
 =?utf-8?Q?pJc8YcUSFnw1WGX4zcUSIusCWN0x9lQn1KxZU1126g=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gCC0yNOJJe6iADVtbhblzdLD3IKATqUGHsrAoe6XCf8Gki5KpKM7RaS5RzZlEb2m2wLy79NXls2WFKVaDQ7YhF1iKqV621sGVQbI7I9qEzejHlZEcnObqgGP5HPB4cRpP5IwzcM3pJWNcIA8qCxTgnnXwxaQkBy5VQlf2txL1tZfwq+xh8L+bjPR0TMLroA+ENLiA6+uEJ5+20uKiGFj9cdARnYFYjrwYo9JfYR3JMnItewURnWhrqq7MtXjYXySGZ/15IQ9qPrw/y/65lKhc/BeWrp1ERu5ZXV5Y3t+rDzYzU135LoOVRJHNKgISn5X3OP/S2bkZHPMShZXC18RMUjNN/IMVra4UrJSxSNiCbUMQOHHs9ZdBzgE9pFcR4lhM6Y79ahkj+6qjsFUksyeozyiJBr93jBl034FG0XWrFlSOCP2O0N22uY1DESkL0N1
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 16:01:30.6849
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcfde804-821c-4453-29d8-08de62745491
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4059
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
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-16357-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 8C0EFCEB9A
X-Rspamd-Action: no action

From: Michael Guralnik <michaelgur@nvidia.com>

Allow netlink users, through the usage of driver-details netlink
attribute, to get information about internal FRMR pools that use the
kernel_vendor_key FRMR key member.

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/core/nldev.c  | 28 +++++++++++++++++++++++-----
 include/uapi/rdma/rdma_netlink.h |  1 +
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 0b0f689eadd7..80b0079f63ae 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -186,6 +186,7 @@ static const struct nla_policy nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
 	[RDMA_NLDEV_ATTR_FRMR_POOL_IN_USE]	= { .type = NLA_U64 },
 	[RDMA_NLDEV_ATTR_FRMR_POOLS_AGING_PERIOD] = { .type = NLA_U32 },
 	[RDMA_NLDEV_ATTR_FRMR_POOL_PINNED_HANDLES] = { .type = NLA_U32 },
+	[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_KERNEL_VENDOR_KEY] = { .type = NLA_U64 },
 };
 
 static int put_driver_name_print_type(struct sk_buff *msg, const char *name,
@@ -2671,6 +2672,12 @@ static int fill_frmr_pool_key(struct sk_buff *msg, struct ib_frmr_key *key)
 			      key->num_dma_blocks, RDMA_NLDEV_ATTR_PAD))
 		goto err;
 
+	if (key->kernel_vendor_key &&
+	    nla_put_u64_64bit(msg,
+			      RDMA_NLDEV_ATTR_FRMR_POOL_KEY_KERNEL_VENDOR_KEY,
+			      key->kernel_vendor_key, RDMA_NLDEV_ATTR_PAD))
+		goto err;
+
 	nla_nest_end(msg, key_attr);
 	return 0;
 
@@ -2705,9 +2712,9 @@ static int fill_frmr_pool_entry(struct sk_buff *msg, struct ib_frmr_pool *pool)
 	return -EMSGSIZE;
 }
 
-static void nldev_frmr_pools_parse_key(struct nlattr *tb[],
-				       struct ib_frmr_key *key,
-				       struct netlink_ext_ack *extack)
+static int nldev_frmr_pools_parse_key(struct nlattr *tb[],
+				      struct ib_frmr_key *key,
+				      struct netlink_ext_ack *extack)
 {
 	if (tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ATS])
 		key->ats = nla_get_u8(tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ATS]);
@@ -2723,6 +2730,11 @@ static void nldev_frmr_pools_parse_key(struct nlattr *tb[],
 	if (tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_NUM_DMA_BLOCKS])
 		key->num_dma_blocks = nla_get_u64(
 			tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_NUM_DMA_BLOCKS]);
+
+	if (tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_KERNEL_VENDOR_KEY])
+		return -EINVAL;
+
+	return 0;
 }
 
 static int nldev_frmr_pools_set_pinned(struct ib_device *device,
@@ -2746,7 +2758,9 @@ static int nldev_frmr_pools_set_pinned(struct ib_device *device,
 	if (err)
 		return err;
 
-	nldev_frmr_pools_parse_key(key_tb, &key, extack);
+	err = nldev_frmr_pools_parse_key(key_tb, &key, extack);
+	if (err)
+		return err;
 
 	err = ib_frmr_pools_set_pinned(device, &key, pinned_handles);
 
@@ -2762,6 +2776,7 @@ static int nldev_frmr_pools_get_dumpit(struct sk_buff *skb,
 	struct ib_frmr_pool *pool;
 	struct nlattr *table_attr;
 	struct nlattr *entry_attr;
+	bool show_details = false;
 	struct ib_device *device;
 	int start = cb->args[0];
 	struct rb_node *node;
@@ -2778,6 +2793,9 @@ static int nldev_frmr_pools_get_dumpit(struct sk_buff *skb,
 	if (!device)
 		return -EINVAL;
 
+	if (tb[RDMA_NLDEV_ATTR_DRIVER_DETAILS])
+		show_details = nla_get_u8(tb[RDMA_NLDEV_ATTR_DRIVER_DETAILS]);
+
 	pools = device->frmr_pools;
 	if (!pools) {
 		ib_device_put(device);
@@ -2803,7 +2821,7 @@ static int nldev_frmr_pools_get_dumpit(struct sk_buff *skb,
 	read_lock(&pools->rb_lock);
 	for (node = rb_first(&pools->rb_root); node; node = rb_next(node)) {
 		pool = rb_entry(node, struct ib_frmr_pool, node);
-		if (pool->key.kernel_vendor_key)
+		if (pool->key.kernel_vendor_key && !show_details)
 			continue;
 
 		if (idx < start) {
diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
index 39178df104f0..aac9782ddc09 100644
--- a/include/uapi/rdma/rdma_netlink.h
+++ b/include/uapi/rdma/rdma_netlink.h
@@ -602,6 +602,7 @@ enum rdma_nldev_attr {
 	RDMA_NLDEV_ATTR_FRMR_POOL_IN_USE,	/* u64 */
 	RDMA_NLDEV_ATTR_FRMR_POOLS_AGING_PERIOD,	/* u32 */
 	RDMA_NLDEV_ATTR_FRMR_POOL_PINNED_HANDLES,	/* u32 */
+	RDMA_NLDEV_ATTR_FRMR_POOL_KEY_KERNEL_VENDOR_KEY,	/* u64 */
 
 	/*
 	 * Always the end

-- 
2.47.1


