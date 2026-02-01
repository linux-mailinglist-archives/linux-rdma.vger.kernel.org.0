Return-Path: <linux-rdma+bounces-16312-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +I0sKuZlf2mwpgIAu9opvQ
	(envelope-from <linux-rdma+bounces-16312-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 01 Feb 2026 15:40:38 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 249D8C6369
	for <lists+linux-rdma@lfdr.de>; Sun, 01 Feb 2026 15:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FEF0306B794
	for <lists+linux-rdma@lfdr.de>; Sun,  1 Feb 2026 14:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C8D352937;
	Sun,  1 Feb 2026 14:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Dlmm23tp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010044.outbound.protection.outlook.com [52.101.56.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5C422759C;
	Sun,  1 Feb 2026 14:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769956532; cv=fail; b=SbT89mhsIPto7fY3DP6b08SmHFfEQBJRA9m43YKMsIlttNeUeH7osB+IihMoaUucQrwrBqHMkRf4XzqCnjTOgYNewWYdG0pwB8Q8G+M5068RCi0aaAS5B0EeUJCapMS+SB7X55o6DmDv1mOL0hH0FT2PLjLhWl5J5L/6NXxyYW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769956532; c=relaxed/simple;
	bh=9j8gLuW+jzS5bKfgisnNh28fi0pym4Vlj+laH3Fde2U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=BBtsgPWotLARi6PMJgkSRH7rIget5DjZrAE3gP/wEMl2uF5Zksw1oD7SoHmsktwPQ8rvUt6AT8bavUyIUXtLPqqWWNeTI8iXIH8U5AoLoGdYcCupijz7VCUGNyT2ee3H+DUzL+yxXEV6Xcg7mYU7BnaD2DR42NeIj7peB8UjDPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Dlmm23tp; arc=fail smtp.client-ip=52.101.56.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IUGfmJ3cL4GgpEWMN/koMmZPJL/AsnU/wO6Wd8XWCHtbotNHSxTY7U19PcOqMdC2rqwpg4CcIMRnUj5sAOR9ISIawqI/4DvGvnAf+9sRUZBHolRcqmWmnWqVNGw1szWbiE7xe+qc5jWnWvoYl0J3eUK3V2hSqx99w11dnMq37hhMIUr+i1PzKcCysCBkIdNFMuf2dbOhruW8sGOdmnPchgG9epeUIqDL42XzIbJv1qQ37OClwusXIc5CpKFpLriD4JBUqCVZYE+IbrTRGQGdDADbiHAxzDymk+l7UTTpsmGzeT/drYVWv7t1EXdlBJJoLOSg7yK5xXjFAKwbSdgYwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=etM0H50chfQ8pMIhJKKZEvR9cAJMMGv8G3uw51dJjes=;
 b=fMNSJLOpTfdvTb8gENBm9AOvSJBZJHSTcIr3mrTOT7JwVYH0oW8AeKwsvcgccLROxqdR4q8V1Wwkh5/18M7bOGqwTwD90ip/Xh71oYaFlGi+hu6E+SfZNFoqRTVn9XefAFuMxNAtNj7fr5q+vm8Bb6pPPiypSUEWXw++ySrhm05kzg7aehttKiFtd1JhzAOEl8E+TV+/eJSAr8Uk9PQ32cDwsB+UXKOKE6feZVV1KJJz3LS4Rlpjz34UnITtkCs7HBeA+0/lrJme/JpzA0BCWQpPmytzl/uTtqvKl66Czj4Q1CLl1ZE5Bc+r5aWQsVa7K/wUWu/eANZbpAFVjtXUBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etM0H50chfQ8pMIhJKKZEvR9cAJMMGv8G3uw51dJjes=;
 b=Dlmm23tpB1ZakClBNGJiMCPVfy7rxpZg+HJbcQuzC/9lT7q0kpWzTFvUNMYy2P+9z7ccfBYVtxg0CComvcQzK2QU65kVwbvba4mkTUku9JNASq064aL4GXuUrhalHbIX8cTD0HfMER7nAN1EUwsY7/6IUVwr/237q9axAZuT/kPbYcReNZEQ4MQiNyVO+jqU7+VjZlv7OzLAEqTRhz1zPtjdNRMoUKNK9z4RVmycgRZyLBQHddxv13cPn8yrI5b0CWcPkf5tVw9fzP7EwPcV6ESIYk2CxDLiV03jnZmR0/RHMEnr+xPo0BPzU2i572txSTInpLkBlpScJdk04BwUKQ==
Received: from MN2PR01CA0024.prod.exchangelabs.com (2603:10b6:208:10c::37) by
 IA0PR12MB8277.namprd12.prod.outlook.com (2603:10b6:208:3de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Sun, 1 Feb
 2026 14:35:24 +0000
Received: from BN3PEPF0000B070.namprd21.prod.outlook.com
 (2603:10b6:208:10c:cafe::4) by MN2PR01CA0024.outlook.office365.com
 (2603:10b6:208:10c::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.15 via Frontend Transport; Sun,
 1 Feb 2026 14:35:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B070.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Sun, 1 Feb 2026 14:35:24 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 1 Feb
 2026 06:35:07 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 1 Feb
 2026 06:35:07 -0800
Received: from c-237-169-180-181.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Sun, 1 Feb 2026 06:35:03 -0800
From: Edward Srouji <edwards@nvidia.com>
Date: Sun, 1 Feb 2026 16:34:06 +0200
Subject: [PATCH rdma-next v3 3/3] RDMA/mlx5: Implement DMABUF export ops
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260201-dmabuf-export-v3-3-da238b614fe3@nvidia.com>
References: <20260201-dmabuf-export-v3-0-da238b614fe3@nvidia.com>
In-Reply-To: <20260201-dmabuf-export-v3-0-da238b614fe3@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, "Sumit
 Semwal" <sumit.semwal@linaro.org>, =?utf-8?q?Christian_K=C3=B6nig?=
	<christian.koenig@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
	<linaro-mm-sig@lists.linaro.org>, Yishai Hadas <yishaih@nvidia.com>, "Edward
 Srouji" <edwards@nvidia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769956492; l=3906;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=hrI5fWihP4FczMXXbh00GHcjyD2++jtKryVnX4Jyft4=;
 b=vdLJOY5jw3ITJG9c/JjQ1/0LF/XJdq1Q0EkPwU+TptD4zzP7IOJMhEvdyACZ/FCu3JwaYggt/
 NpJY/1MhBOPCmwtMaMlahk6icMGm5zsWBxr3Frmhc2HCEies2lh5jLi
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B070:EE_|IA0PR12MB8277:EE_
X-MS-Office365-Filtering-Correlation-Id: dba21f91-ed40-4db8-c324-08de619f22f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dHM5T2d1c0Vydk9PQ0tVMzc4NjVnSHFSRUUyODEreUhONmdRME43dlFUY0RE?=
 =?utf-8?B?elZKT0FhenI1MDliKzdVTnRUd1Z2RkVSNFRxZGY3R3RUa0R5UjRSWmpWUEJk?=
 =?utf-8?B?WTBYWEgrYWFIcHJieEQzUDY4MVVCQ3ROVnRCTFIwR0hPZ1E1QyttUEpUOXJU?=
 =?utf-8?B?OU9HOWQxVzdyRVpVR1o4cnVTekcvSGdDa2tjYVBTYnVpZ0swRDQ5VXpmUnZj?=
 =?utf-8?B?TzdJNko0MFR5RExVYkovWTl2L1JIeHNxK3paUFlJUlNkVGFBMU8vbEVuaWRC?=
 =?utf-8?B?cnk5RnNpcjIyd3hoNE0rS29uM3ZKN1c0T1o0aktyb0JGd1VsaHhPYlU4dXJJ?=
 =?utf-8?B?V2pSYS9JRkRObGo0UGRJanE3bVF3aTBnZFpRMVpONU5DeXRZam9CYU1KUnQ2?=
 =?utf-8?B?ZE1vMUJOYmNSY0dhV1FIdFRTZWMxSVF5enR1TDd1Z0g4aC9HWTgyQWRXdnFn?=
 =?utf-8?B?TllYREZDTGtZMXl6Y2pmTGdrUmtVekQ2WVVPb0VzaVBBWHIyM051Q3pRRHVN?=
 =?utf-8?B?Q2phYlpTU0pzRHlEcEJ6azB0cEJJcXorWjFBeXJLSE12Wnc5cFNhbVFLTXpH?=
 =?utf-8?B?QytvelhMVUZST3drQWkyMUZyYXdua2lJUDYrTUVYWEtvNTlBcWlUUWFiaEpR?=
 =?utf-8?B?bzVFVkV3VnZKMHFZK3hrMnovaWtQVnljNUw3UXJ3QktHT1kveTF6VjU3SVZl?=
 =?utf-8?B?d2tjQlVxU2RrUXpXZHQ0bUhUUzV0MWRGQ0RwUmphT3R0THlZaHZGRnNIVDdm?=
 =?utf-8?B?VWNrVkhkV01MZ3laOU1Cd2o5Sy9VdHV6dFQ3aHRSYzVWYStTL2k0VHFUQnpH?=
 =?utf-8?B?SmdLbk9uS3phMDhXQ2hCeUkrelRLSU5LMSsrR3hOSlhSSkJKUjQ2d1BwQ3Jw?=
 =?utf-8?B?bFdleVJiNmVrZW11MFdvR1BjQ28yVWVkR211anliY0JKaXFjMEdzU3gxeUN6?=
 =?utf-8?B?bDhmNjdIcVh1UzlZWmJHazh0d2UzZGE1ckxYQmlWaWI5aE5Hd29abjBiSmFG?=
 =?utf-8?B?QlovSnZzbFdzN0d3dTdlSlBHQzRtZzBab044QS9rcHFOTW1WeWI5cUhQSWwv?=
 =?utf-8?B?SFp3VWlwejZwSXp0YVJKRi9ncDlGVE1RQWhkTGFWR1NLZ3ZBTERhQWhna0wz?=
 =?utf-8?B?MWtQVytnbll0ZXpHdE1KQ2Urb1ZxckNCNTZidE1FdDNPK2VHSVIwSGV4anZm?=
 =?utf-8?B?OEpHVU5SV0FuelpONFVOYmtteE80YTVDdHZtdWZCaUNVRS9yWFRjRmtILzR0?=
 =?utf-8?B?QmptNE1lUkw4Nml1d3pVS21zVU5pTC9YZHB5RmdXT0pFWjBWaTNTZHlwR0NT?=
 =?utf-8?B?WEFjRDZGcy9nWFJtcVZnMWVLVDEvcXRwMTZaVHpKeFk0dC84clhxU1ZzQUJE?=
 =?utf-8?B?Yy9JN0M2dEFtU2ZFZXhSdUJhb1dmVXdLc0pHMWlkK1pqNE0wTXRGcm1oOWwv?=
 =?utf-8?B?Q0R0YmhVdXlDbHhYeDFlb2lwL3V1TWtRVGJpNUZGc2o3K2ZqNmwxMm9wdlZK?=
 =?utf-8?B?ajczNjBTdkFES0pYMDVHcG1xRmtwcEpmeEY2OTJZUThLT3NtWkQ1cHZrL1oy?=
 =?utf-8?B?bXBUWW1jTXdKZWd4bUU0eGxZQ2hYaGVIV1RSbi9MQVFENlNJdDhIZU53Qkw2?=
 =?utf-8?B?QkZyRC96WmlCUXNnSkxTbDJiemJqbm5CM2ZNSGpyU0lOTCtsem5sc2lMd2da?=
 =?utf-8?B?a042ZUxoTDQ3aUdUSE1kRkhVNjgvd0NOdU1aZEJNNVJjSlgxT0ovMFZ4bzAz?=
 =?utf-8?B?cmdnSXFKVkd5U2JkU0hWcGZMb21Va2RmOTI1c2dGaUNHaXlxK2p4ZXN1bWt3?=
 =?utf-8?B?anlEVTZPdm44N3JzSlljd24zc2hXZXZ5VXgwTE1ESHpHV3QvNStEOGhybFFY?=
 =?utf-8?B?Z0VKaDcyOHA0WnJvSDdrSFp3SWRnbDRDYVFRdHV0WmRwQlZBeHZKYjZYa2pq?=
 =?utf-8?B?Y3FFekRtUmxXZ2crTGtORkFnSHdoeHAzVElJU2JCU3dzdGtGeE5VT0dFT2ty?=
 =?utf-8?B?YkxiTGdiZGZ3aVN0M0VXTXRSdW1kUEVKMVk5WEJkZWZJV2JxVjZ0eEF1bVR2?=
 =?utf-8?B?L2kxT3g2RTR5SWNxOG9PSkpUUXpIUzRETkVmN0NVOU51aS95V2VDcVJ0Z2Nx?=
 =?utf-8?B?c09sOXJqRkx4SVFKNVBITEd3MGR2dThDeGxwN0ZsNFFCUEdBd2piaVFHbGU2?=
 =?utf-8?B?S0hIRUEvQ1QvSWsvUFNGTFNMdExTUDIrZE5qV21vYTZZV1JZKzQ4MnhpZno2?=
 =?utf-8?B?MkFldWlaa3MwOXc4LzhUaDFKMFF3PT0=?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0+kHjo5gv891JuMXnKTsNxp3fwyX/3m7ODA8376tip/IRzZeV2g9+9bMaCWaU3pqSzyu4uZM+nok4/g/bAnE9D+/lJiinqizy877kygvf4bohIxfcqryN1j+k5VMg7bUqV2kt7oSiGQkkAr43v8yYG+LKg8Hxo/9xvIuN4/xMcqMNrPQ5hMrjPnW5OFzJNHHajsOjFs5fe9DgpeBx0Vud4hn1wptpB+bGIHfquAfFPK5KPgt0ANEaOnP/1HJIPEtPwdqJs1j2CIEJjhuombZ70EtpfrM0cAZrIsLbxjNugbHnWgqlOxBhnXAzZZ7l+9Hp/sx2dWk1NKC0747LDK6IeQEfByIKb1H9mr+1jpboBr5MdUr/ixha4j+j9QcluoBPLxb88V9wFpfCKsWFTaeUNk+qPuSXElbgexZx2JZWwkxlS5dCmM9ZWm7e2zel8ww
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2026 14:35:24.5831
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dba21f91-ed40-4db8-c324-08de619f22f9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B070.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8277
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16312-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 249D8C6369
X-Rspamd-Action: no action

From: Yishai Hadas <yishaih@nvidia.com>

Enable p2pdma on the mlx5 PCI device to allow DMABUF-based peer-to-peer
DMA mappings.

Add implementation of the mmap_get_pfns and pgoff_to_mmap_entry device
operations required for DMABUF support in the mlx5 RDMA driver.

The pgoff_to_mmap_entry operation converts a page offset to the
corresponding rdma_user_mmap_entry by extracting the command and index
from the offset and looking it up in the ucontext's mmap_xa.

The mmap_get_pfns operation retrieves the physical address and length
from the mmap entry and obtains the p2pdma provider for the underlying
PCI device, which is needed for peer-to-peer DMA operations with
DMABUFs.

Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c | 72 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index e81080622283..f97c86c96d83 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2446,6 +2446,70 @@ static int mlx5_ib_mmap_clock_info_page(struct mlx5_ib_dev *dev,
 			      virt_to_page(dev->mdev->clock_info));
 }
 
+static int phys_addr_to_bar(struct pci_dev *pdev, phys_addr_t pa)
+{
+	resource_size_t start, end;
+	int bar;
+
+	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
+		/* Skip BARs not present or not memory-mapped */
+		if (!(pci_resource_flags(pdev, bar) & IORESOURCE_MEM))
+			continue;
+
+		start = pci_resource_start(pdev, bar);
+		end = pci_resource_end(pdev, bar);
+
+		if (!start || !end)
+			continue;
+
+		if (pa >= start && pa <= end)
+			return bar;
+	}
+
+	return -1;
+}
+
+static int mlx5_ib_mmap_get_pfns(struct rdma_user_mmap_entry *entry,
+				 struct dma_buf_phys_vec *phys_vec,
+				 struct p2pdma_provider **provider)
+{
+	struct mlx5_user_mmap_entry *mentry = to_mmmap(entry);
+	struct pci_dev *pdev = to_mdev(entry->ucontext->device)->mdev->pdev;
+	int bar;
+
+	phys_vec->paddr = mentry->address;
+	phys_vec->len = entry->npages * PAGE_SIZE;
+
+	bar = phys_addr_to_bar(pdev, phys_vec->paddr);
+	if (bar < 0)
+		return -EINVAL;
+
+	*provider = pcim_p2pdma_provider(pdev, bar);
+	/* If the kernel was not compiled with CONFIG_PCI_P2PDMA the
+	 * functionality is not supported.
+	 */
+	if (!*provider)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+static struct rdma_user_mmap_entry *
+mlx5_ib_pgoff_to_mmap_entry(struct ib_ucontext *ucontext, off_t pg_off)
+{
+	unsigned long entry_pgoff;
+	unsigned long idx;
+	u8 command;
+
+	pg_off = pg_off >> PAGE_SHIFT;
+	command = get_command(pg_off);
+	idx = get_extended_index(pg_off);
+
+	entry_pgoff = command << 16 | idx;
+
+	return rdma_user_mmap_entry_get_pgoff(ucontext, entry_pgoff);
+}
+
 static void mlx5_ib_mmap_free(struct rdma_user_mmap_entry *entry)
 {
 	struct mlx5_user_mmap_entry *mentry = to_mmmap(entry);
@@ -4360,7 +4424,13 @@ static int mlx5_ib_stage_init_init(struct mlx5_ib_dev *dev)
 	if (err)
 		goto err_mp;
 
+	err = pcim_p2pdma_init(mdev->pdev);
+	if (err && err != -EOPNOTSUPP)
+		goto err_dd;
+
 	return 0;
+err_dd:
+	mlx5_ib_data_direct_cleanup(dev);
 err_mp:
 	mlx5_ib_cleanup_multiport_master(dev);
 err:
@@ -4412,11 +4482,13 @@ static const struct ib_device_ops mlx5_ib_dev_ops = {
 	.map_mr_sg_pi = mlx5_ib_map_mr_sg_pi,
 	.mmap = mlx5_ib_mmap,
 	.mmap_free = mlx5_ib_mmap_free,
+	.mmap_get_pfns = mlx5_ib_mmap_get_pfns,
 	.modify_cq = mlx5_ib_modify_cq,
 	.modify_device = mlx5_ib_modify_device,
 	.modify_port = mlx5_ib_modify_port,
 	.modify_qp = mlx5_ib_modify_qp,
 	.modify_srq = mlx5_ib_modify_srq,
+	.pgoff_to_mmap_entry = mlx5_ib_pgoff_to_mmap_entry,
 	.pre_destroy_cq = mlx5_ib_pre_destroy_cq,
 	.poll_cq = mlx5_ib_poll_cq,
 	.post_destroy_cq = mlx5_ib_post_destroy_cq,

-- 
2.47.1


