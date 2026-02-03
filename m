Return-Path: <linux-rdma+bounces-16447-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBFFKPrMgWl1JwMAu9opvQ
	(envelope-from <linux-rdma+bounces-16447-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 11:24:58 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B52D78A5
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 11:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6E0AC3027B05
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 10:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022BE318139;
	Tue,  3 Feb 2026 10:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QbHRTG42"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010066.outbound.protection.outlook.com [40.93.198.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253D13164D6;
	Tue,  3 Feb 2026 10:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770114295; cv=fail; b=AueIRTNGzhZg3nmu2vdTJjaFVtx/h7t+CQjIiQvm9f/n9+2bHGsuJX9DApayzzUhMrhtxih6RnWB885iqSLLprjjPLiNkaFsDyaT+gF5gCn7u0BkFCQRDHPV7JfGbCo79Y9bT+Kd3h+xym46Yp8ICgO5iaf+oucnZ2bprjaaJjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770114295; c=relaxed/simple;
	bh=hJELxiXzXRJlPcamhFc7j/wvlbBeTV5vmKlbXwSR2NI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZFgrgEkN266oHUM1UDShvw6HVdCe4iaSNgFwk3MwnvPf6FeYyYAaqy43QRiF40DriXe4yQK96MSUqC/Pvi3phU3iWbIzv8S8vUWaFW37oJaPRa/yazAg0o43KrWe12KjumCk4U0gC2gpug2qoxOFeudQqaROP1u++wBz/U+aYCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QbHRTG42; arc=fail smtp.client-ip=40.93.198.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TomzjuCUXeuTibPluHvOGWbIss4w3Hhv2D5noQYl7FVLX7rD7C8iKF0UCAz7a9MQp70m8eqc6AXnHBkgClpzofplNOytiOOwyUmWfO4gs0EJgJYs7jwDOHGkcF3Q2PEq8Y5kfab4HWJ3GWYDzOwEcp3F+sS5Drfp8SGB0Hnc6/UL7TPI4rXFg03TxUQzyw8SNLKc4ZwYDMVrSMaUYqdRKee4j3uB0lmfFYVv40yghdm8K4uu0BUVtBlKVKdv/MLEjcJq+qdC+Tsw07ODrshuEylrxXo6HGL6Pd3HFSox8SlY82FvusjDBv8as3MyUzPcFDGnqtlMhuWvJIDAt+Pw6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmGyUMGxqUY17mScujVPoAV9t8G8aeLrf3VdfZ/fgwg=;
 b=rkb+A7qdQd/ZnDykyCbZ/yfVXbn2x41QQDtC8bcE/FQ4rLYso36HHQBr9peK9e5G4rFrGKf1QkpjeBuQP+ILxXvw7NF1BkUHirHD4Sdkw31dhX8zOadxJgaP8bkaDxFOccr2EiR6nP8XU3iDC85zOgGqLpGzhwcKwIGR4UJzLJX/EDzepvs7Uu7DInkicvUQ2UOeiS3e/pJXC9vVK4CJJNO55Lit1VZCsxFUWLesxFyOcYX+X/qmr+9JarY1T+W+dHGvOP/82jeVpD8jExl/V3kwuj7DQwl6TEZxwzetQhwUYiD01mvMB0hCC5OMle4a6qDwYvng9k9fysGs/+DhYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmGyUMGxqUY17mScujVPoAV9t8G8aeLrf3VdfZ/fgwg=;
 b=QbHRTG424NoNtLnyI2eWHDvh1isOmLY9sJRPrFGl5QLBY1VvcCiwrz/meDLcyjaLwAdYOfa8cgGb3MZhyrneGgplHUP9Jmc84jzU+jJXNkhN+yOzyyOeJwp/CJFyvjCPl112KA3fBk/beoZ5sqKDXFA18phVTPjNrbWrANfSzsufMJsMLM3REysq296tRFXQaazh3iw9bGBrls8c3Ldg84JvoprJ1yfO74xUEP+ndx9s3CRTe/KwT/KNidhaqbaLZRLXfE2EooYCXw6gBAYI7qsTcpIz9hegIsOC3C0L/ajl+K5nzCkM3iO4RZx/0ySWaiwGsUmb5JtfayIcV1GGkQ==
Received: from BL1PR13CA0018.namprd13.prod.outlook.com (2603:10b6:208:256::23)
 by IA0PR12MB7650.namprd12.prod.outlook.com (2603:10b6:208:436::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 10:24:48 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:208:256:cafe::65) by BL1PR13CA0018.outlook.office365.com
 (2603:10b6:208:256::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 10:24:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 10:24:48 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Feb
 2026 02:24:33 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Feb
 2026 02:24:33 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 3 Feb
 2026 02:24:28 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Jiri Pirko
	<jiri@nvidia.com>, Parav Pandit <parav@nvidia.com>
Subject: [PATCH net-next] net/mlx5: Support devlink port state for host PF
Date: Tue, 3 Feb 2026 12:24:02 +0200
Message-ID: <20260203102402.1712218-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|IA0PR12MB7650:EE_
X-MS-Office365-Filtering-Correlation-Id: afa2b08a-2b13-4a7d-8d2c-08de630e7596
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dzcxTEg2MEZjZTB5b0o2SGNuT280a2l2TjJDV3cxM2lsanhzSHJtNkxwUVpz?=
 =?utf-8?B?Wmo1UWE4cU1meUJ2L0xPekZ6ak1Nc3hQNFlCdWZlcTl3ZDRyTE1FNFhyZ1F6?=
 =?utf-8?B?dFBCWkJpSVd4QzRoNVlOc2M3Vis5ODFuOWhqTjBSbjBVK0NVeTlNSWoxWXln?=
 =?utf-8?B?dDhoU05NWktSakNwSWNLLzZMeDBWMWVvKzZGMkJNeEwwMW91TmtWVU5xMzQy?=
 =?utf-8?B?UE1xWjl0ZzE0YjUxQUxCTUdKOGljckwxMmpRTXphQmpDRWpERTNZWVBHUWMy?=
 =?utf-8?B?ZDNiVG9KakphOHZLV3hTL2JodjlodHdkTTZ2cmRYQkVWRUJndHBrdXNzZTEw?=
 =?utf-8?B?TkI1Z0JxVFN5Vnp0NjFnRXFYRUlhYlEvZzduQnJ6bERMaG1LRmZXTXFQdDUw?=
 =?utf-8?B?N3VYQUhWNmc2MXA5V1pycngvZHpDZGxVZW1mL3llU1F3ZGNQUmRmWjM4WkxS?=
 =?utf-8?B?ZDlOMHJZUUtXUXF5MkhLQ3A1bzZEcER3QmZxSDdkOU9WRis5K0RrY1djckRR?=
 =?utf-8?B?Ny9mWEh6R0lJYXRhek5HYmgwN3V4U1FYY25QVTJXdHNwS2dyUEI2SG1Jd1FN?=
 =?utf-8?B?OWdxLytBREpubVJ6ajE1amx5WHJoRllqcyt3WGg2SFlVVXJjc3hlK2RETHph?=
 =?utf-8?B?VXhvMnJHU0xKZG5EZnhYQVN2T09RMXU4aHhkVGo5ZWxwRWQ4QWJmNmJSNXAw?=
 =?utf-8?B?K0tIQ013OUdtMVRGNWRFNU9iSkIvYlRqWjB2M2s5dmVWVVZDdlM4clY3U0pE?=
 =?utf-8?B?NmEvZTBlWW5DZ2pPRllzcWI3OFk4clNrWmdyeDhHMzRhTjV4allvSUN6SlQ5?=
 =?utf-8?B?dXpIRTZ1YkVPdnJZOEVsT05YWjZlNEFyZmZqeGh5aE9SaVBWUlFhQS9Ed2Yr?=
 =?utf-8?B?MW4rQlcvUzZaT2JWS2FIVDRZL0FMVVI3UjE2VzlKeitucVBoRGRWa3ZZU3JT?=
 =?utf-8?B?R0QvWit4VW5JQkNPSzhMV2J2K1hZNFRWMWdQTkE1ZDh0cTdIUmFnZ2lpZ1h3?=
 =?utf-8?B?MnVqdXo5VTlDSXhWSUpxSThpdXBLdmpWREhuSHdSWDNUYnFSbmg3dkNuS3Ey?=
 =?utf-8?B?VHA3WDNxa0Rka1lvQVg4VzUzN1REWVN4d2RMYy83WncyMGFEQkVOR2Z5TENo?=
 =?utf-8?B?VHE4WW9Ydy9jOEIxOGxJZDQ1WCtkcFB0NHpmblBWT25HOHRaUktEbWpsNGNL?=
 =?utf-8?B?M3AxUm5KS29JK0pQSGtsMk1XV1M2enJqTElqOG5JYWV1cEx1Q1E4bTZKTTBu?=
 =?utf-8?B?cE1DSDhMOG4zZVA1aStLNEhDY3VvTUM1ellSSmVRNklJaW43RG5Ncy8xNTJo?=
 =?utf-8?B?eUU1dGwwNTNpQktyWjdYU3d5UDNGaU05UmwvcmFibDVRQ3JGaWpkYUF2K1Ew?=
 =?utf-8?B?TzU4MEpQbnIraDJ2b0xBQ2dwYmVtY3VDOEkwaFlCUkN4Y2VGdlROelp3M2cw?=
 =?utf-8?B?YzJIaDJSNlNoKzZ5bU5KeTRRR0xUSmZJS21iQkRMR0t6Uk9Vd1NodmhxbEJT?=
 =?utf-8?B?Rys2bFE4ZW1ZV1dhdkx0b2RVVFYvTUxUQ01BbkROMCtUWUx4QXBSZHFSb1pk?=
 =?utf-8?B?NHdyWHNJS2NBL3psaW1WaDVuamYvUzkvUzJUN1l4QndpOVhSaXVDbjNOUXZX?=
 =?utf-8?B?TEdlWWw2UlpQVENlNXlYT2Nma2l5QmhmTDJGc3IvYkVMMk4yb3d0YWFPUzl1?=
 =?utf-8?B?Z3BtdldWTHA0WFZpUklSdDlwMFFNdHdEa0JickpFSmJveTl2K2RqZmhCd0xN?=
 =?utf-8?B?ZFJ3TnUwSmhuV2gzTXBZTTMxL2g4UGZLWStoZzBWemdZMkdrNWpBL0pHeU0x?=
 =?utf-8?B?OGlpbjYwRVJWMHgvbHRoM1JWS1dBVHlOVVVEb0l1eExrYjBoNjBTcUd5ZWtk?=
 =?utf-8?B?WkVQeGZqUVRSQUhBOFJWMjVVZUxQSW5USGptSThzR0oxRXpFdERwSXY2SEFz?=
 =?utf-8?B?V1VWVGVSeEpYNDNyRWE3Mm5jT1loeGdKMW9pbFNhSFRmUVkvVXZJQ2tzUURh?=
 =?utf-8?B?b2NhOFBsSStwMEYyOE1Zb0t1clQ2L0pZUjlEZmoxNTVPeDc4LzhnVkFEL1kw?=
 =?utf-8?B?N0d0dVFQRXg4MllydUhEMzlKRkhqUVBSRC9vaXZaMXRtQlRjelBNVHIzb29C?=
 =?utf-8?B?MFVRZU1HdzJIaWc5WWowcFJnNWk0ZkJ4bFJhdUlWRDRkSGYvQzU4U2syZ2Jr?=
 =?utf-8?B?bFZIV3UySU5vT2lUNW14OWNxeWZybDA1WHU2NTRKcmYzUUNUcEdpNTRQdE1u?=
 =?utf-8?B?Wm1Od1ZwK01HYUdkdi9ZcHdqeU5RPT0=?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	s6rCk0vOu997jU0Ez5Dp3IPH+SoyCrpQL7116Ldug+jd6rZ05uXZlU2YRLBDeW3gxYg1sjq0zRjvDkiUmHwa58JaQ7IXL55ZZLDwkjDJJGwduj3Y8PhWkm0H8ImZRUJ/X1L94Uf/xaqyb7f1iugr57dt8g3G+QxW/b9tF7ImacmYvKKxk8NKpKnk0s3aGTLaeDAdLZjp8tqWqTGLcyemLfm0QKLYlCS5sVNwWiPZLpqXoOQiraOUIe1egDl4mh0V2/EQESRTZRckwejUKcjikW9mIdrbR75FWCVWP0jAzmxSFdQH/Xb7ZoIHNQk2bhEgcCPS0A+mJudWIcX7hxjofdH2aNEmzK920ARTWUk7287HjY3+dQFAe27WuzdC1RVJaNqJ/EJNGwNDFGi6K89EX21FSEnN6br8wlfBKQFrx7qBNFvofImXUAT+JBzx3iyC
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 10:24:48.4883
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afa2b08a-2b13-4a7d-8d2c-08de630e7596
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7650
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-16447-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 20B52D78A5
X-Rspamd-Action: no action

From: Moshe Shemesh <moshe@nvidia.com>

Add support for devlink port function state get/set operations for the
host physical function (PF). Until now, mlx5 only allowed state get/set
for subfunctions (SFs) ports. This change enables an administrator with
eSwitch manager privileges to query or modify the host PF’s function
state, allowing it to be explicitly inactivated or activated. While
inactivated, the administrator can modify the functions attributes, such
as enable/disable roce.

$ devlink port show pci/0000:03:00.0/196608
pci/0000:03:00.0/196608: type eth netdev eth1 flavour pcipf controller 1 pfnum 0 external true splittable false
  function:
    hw_addr a0:88:c2:45:17:7c state active opstate attached roce enable max_io_eqs 120
$ devlink port function set pci/0000:03:00.0/196608 state inactive
$ devlink port show pci/0000:03:00.0/196608
pci/0000:03:00.0/196608: type eth netdev eth1 flavour pcipf controller 1 pfnum 0 external true splittable false
  function:
    hw_addr a0:88:c2:45:17:7c state inactive opstate detached roce enable max_io_eqs 120

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/ecpf.c    |  5 +-
 .../mellanox/mlx5/core/esw/devlink_port.c     |  2 +
 .../net/ethernet/mellanox/mlx5/core/eswitch.c | 48 ++++++++++++----
 .../net/ethernet/mellanox/mlx5/core/eswitch.h | 10 ++++
 .../mellanox/mlx5/core/eswitch_offloads.c     | 55 +++++++++++++++++++
 5 files changed, 108 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/ecpf.c b/drivers/net/ethernet/mellanox/mlx5/core/ecpf.c
index d000236ddbac..15cb27aea2c9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/ecpf.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/ecpf.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2019 Mellanox Technologies. */
 
 #include "ecpf.h"
+#include "eswitch.h"
 
 bool mlx5_read_embedded_cpu(struct mlx5_core_dev *dev)
 {
@@ -49,7 +50,7 @@ static int mlx5_host_pf_init(struct mlx5_core_dev *dev)
 	/* ECPF shall enable HCA for host PF in the same way a PF
 	 * does this for its VFs when ECPF is not a eswitch manager.
 	 */
-	err = mlx5_cmd_host_pf_enable_hca(dev);
+	err = mlx5_esw_host_pf_enable_hca(dev);
 	if (err)
 		mlx5_core_err(dev, "Failed to enable external host PF HCA err(%d)\n", err);
 
@@ -63,7 +64,7 @@ static void mlx5_host_pf_cleanup(struct mlx5_core_dev *dev)
 	if (mlx5_ecpf_esw_admins_host_pf(dev))
 		return;
 
-	err = mlx5_cmd_host_pf_disable_hca(dev);
+	err = mlx5_esw_host_pf_disable_hca(dev);
 	if (err) {
 		mlx5_core_err(dev, "Failed to disable external host PF HCA err(%d)\n", err);
 		return;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
index 89a58dee50b3..cd60bc500ec5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
@@ -99,6 +99,8 @@ static const struct devlink_port_ops mlx5_esw_pf_vf_dl_port_ops = {
 	.port_fn_roce_set = mlx5_devlink_port_fn_roce_set,
 	.port_fn_migratable_get = mlx5_devlink_port_fn_migratable_get,
 	.port_fn_migratable_set = mlx5_devlink_port_fn_migratable_set,
+	.port_fn_state_get = mlx5_devlink_pf_port_fn_state_get,
+	.port_fn_state_set = mlx5_devlink_pf_port_fn_state_set,
 #ifdef CONFIG_XFRM_OFFLOAD
 	.port_fn_ipsec_crypto_get = mlx5_devlink_port_fn_ipsec_crypto_get,
 	.port_fn_ipsec_crypto_set = mlx5_devlink_port_fn_ipsec_crypto_set,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 4b7a1ce7f406..5fbfabe28bdb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1304,24 +1304,52 @@ static int mlx5_eswitch_load_ec_vf_vports(struct mlx5_eswitch *esw, u16 num_ec_v
 	return err;
 }
 
-static int host_pf_enable_hca(struct mlx5_core_dev *dev)
+int mlx5_esw_host_pf_enable_hca(struct mlx5_core_dev *dev)
 {
-	if (!mlx5_core_is_ecpf(dev))
+	struct mlx5_eswitch *esw = dev->priv.eswitch;
+	struct mlx5_vport *vport;
+	int err;
+
+	if (!mlx5_core_is_ecpf(dev) || !mlx5_esw_allowed(esw))
 		return 0;
 
+	vport = mlx5_eswitch_get_vport(esw, MLX5_VPORT_PF);
+	if (IS_ERR(vport))
+		return PTR_ERR(vport);
+
 	/* Once vport and representor are ready, take out the external host PF
 	 * out of initializing state. Enabling HCA clears the iser->initializing
 	 * bit and host PF driver loading can progress.
 	 */
-	return mlx5_cmd_host_pf_enable_hca(dev);
+	err = mlx5_cmd_host_pf_enable_hca(dev);
+	if (err)
+		return err;
+
+	vport->pf_activated = true;
+
+	return 0;
 }
 
-static void host_pf_disable_hca(struct mlx5_core_dev *dev)
+int mlx5_esw_host_pf_disable_hca(struct mlx5_core_dev *dev)
 {
-	if (!mlx5_core_is_ecpf(dev))
-		return;
+	struct mlx5_eswitch *esw = dev->priv.eswitch;
+	struct mlx5_vport *vport;
+	int err;
 
-	mlx5_cmd_host_pf_disable_hca(dev);
+	if (!mlx5_core_is_ecpf(dev) || !mlx5_esw_allowed(esw))
+		return 0;
+
+	vport = mlx5_eswitch_get_vport(esw, MLX5_VPORT_PF);
+	if (IS_ERR(vport))
+		return PTR_ERR(vport);
+
+	err = mlx5_cmd_host_pf_disable_hca(dev);
+	if (err)
+		return err;
+
+	vport->pf_activated = false;
+
+	return 0;
 }
 
 /* mlx5_eswitch_enable_pf_vf_vports() enables vports of PF, ECPF and VFs
@@ -1347,7 +1375,7 @@ mlx5_eswitch_enable_pf_vf_vports(struct mlx5_eswitch *esw,
 
 	if (mlx5_esw_host_functions_enabled(esw->dev)) {
 		/* Enable external host PF HCA */
-		ret = host_pf_enable_hca(esw->dev);
+		ret = mlx5_esw_host_pf_enable_hca(esw->dev);
 		if (ret)
 			goto pf_hca_err;
 	}
@@ -1391,7 +1419,7 @@ mlx5_eswitch_enable_pf_vf_vports(struct mlx5_eswitch *esw,
 		mlx5_eswitch_unload_pf_vf_vport(esw, MLX5_VPORT_ECPF);
 ecpf_err:
 	if (mlx5_esw_host_functions_enabled(esw->dev))
-		host_pf_disable_hca(esw->dev);
+		mlx5_esw_host_pf_disable_hca(esw->dev);
 pf_hca_err:
 	if (pf_needed && mlx5_esw_host_functions_enabled(esw->dev))
 		mlx5_eswitch_unload_pf_vf_vport(esw, MLX5_VPORT_PF);
@@ -1416,7 +1444,7 @@ void mlx5_eswitch_disable_pf_vf_vports(struct mlx5_eswitch *esw)
 	}
 
 	if (mlx5_esw_host_functions_enabled(esw->dev))
-		host_pf_disable_hca(esw->dev);
+		mlx5_esw_host_pf_disable_hca(esw->dev);
 
 	if ((mlx5_core_is_ecpf_esw_manager(esw->dev) ||
 	     esw->mode == MLX5_ESWITCH_LEGACY) &&
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 714ad28e8445..6841caef02d1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -243,6 +243,7 @@ struct mlx5_vport {
 	u16 vport;
 	bool                    enabled;
 	bool max_eqs_set;
+	bool pf_activated;
 	enum mlx5_eswitch_vport_event enabled_events;
 	int index;
 	struct mlx5_devlink_port *dl_port;
@@ -587,6 +588,13 @@ int mlx5_devlink_port_fn_migratable_get(struct devlink_port *port, bool *is_enab
 					struct netlink_ext_ack *extack);
 int mlx5_devlink_port_fn_migratable_set(struct devlink_port *port, bool enable,
 					struct netlink_ext_ack *extack);
+int mlx5_devlink_pf_port_fn_state_get(struct devlink_port *port,
+				      enum devlink_port_fn_state *state,
+				      enum devlink_port_fn_opstate *opstate,
+				      struct netlink_ext_ack *extack);
+int mlx5_devlink_pf_port_fn_state_set(struct devlink_port *port,
+				      enum devlink_port_fn_state state,
+				      struct netlink_ext_ack *extack);
 #ifdef CONFIG_XFRM_OFFLOAD
 int mlx5_devlink_port_fn_ipsec_crypto_get(struct devlink_port *port, bool *is_enabled,
 					  struct netlink_ext_ack *extack);
@@ -634,6 +642,8 @@ bool mlx5_esw_multipath_prereq(struct mlx5_core_dev *dev0,
 			       struct mlx5_core_dev *dev1);
 
 const u32 *mlx5_esw_query_functions(struct mlx5_core_dev *dev);
+int mlx5_esw_host_pf_enable_hca(struct mlx5_core_dev *dev);
+int mlx5_esw_host_pf_disable_hca(struct mlx5_core_dev *dev);
 
 void mlx5_esw_adjacent_vhcas_setup(struct mlx5_eswitch *esw);
 void mlx5_esw_adjacent_vhcas_cleanup(struct mlx5_eswitch *esw);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 02b7e474586d..1b439cef3719 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -4696,6 +4696,61 @@ int mlx5_devlink_port_fn_roce_set(struct devlink_port *port, bool enable,
 	return err;
 }
 
+int mlx5_devlink_pf_port_fn_state_get(struct devlink_port *port,
+				      enum devlink_port_fn_state *state,
+				      enum devlink_port_fn_opstate *opstate,
+				      struct netlink_ext_ack *extack)
+{
+	struct mlx5_vport *vport = mlx5_devlink_port_vport_get(port);
+	const u32 *query_out;
+	bool pf_disabled;
+
+	if (vport->vport != MLX5_VPORT_PF) {
+		NL_SET_ERR_MSG_MOD(extack, "State get is not supported for VF");
+		return -EOPNOTSUPP;
+	}
+
+	*state = vport->pf_activated ?
+		 DEVLINK_PORT_FN_STATE_ACTIVE : DEVLINK_PORT_FN_STATE_INACTIVE;
+
+	query_out = mlx5_esw_query_functions(vport->dev);
+	if (IS_ERR(query_out))
+		return PTR_ERR(query_out);
+
+	pf_disabled = MLX5_GET(query_esw_functions_out, query_out,
+			       host_params_context.host_pf_disabled);
+
+	*opstate = pf_disabled ? DEVLINK_PORT_FN_OPSTATE_DETACHED :
+				 DEVLINK_PORT_FN_OPSTATE_ATTACHED;
+
+	kvfree(query_out);
+	return 0;
+}
+
+int mlx5_devlink_pf_port_fn_state_set(struct devlink_port *port,
+				      enum devlink_port_fn_state state,
+				      struct netlink_ext_ack *extack)
+{
+	struct mlx5_vport *vport = mlx5_devlink_port_vport_get(port);
+	struct mlx5_core_dev *dev;
+
+	if (vport->vport != MLX5_VPORT_PF) {
+		NL_SET_ERR_MSG_MOD(extack, "State set is not supported for VF");
+		return -EOPNOTSUPP;
+	}
+
+	dev = vport->dev;
+
+	switch (state) {
+	case DEVLINK_PORT_FN_STATE_ACTIVE:
+		return mlx5_esw_host_pf_enable_hca(dev);
+	case DEVLINK_PORT_FN_STATE_INACTIVE:
+		return mlx5_esw_host_pf_disable_hca(dev);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 int
 mlx5_eswitch_restore_ipsec_rule(struct mlx5_eswitch *esw, struct mlx5_flow_handle *rule,
 				struct mlx5_esw_flow_attr *esw_attr, int attr_idx)

base-commit: fae1c659d7bd5640012be21b5b5d6490b83c0df8
-- 
2.44.0


