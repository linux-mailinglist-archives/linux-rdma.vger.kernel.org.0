Return-Path: <linux-rdma+bounces-16351-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHkbENDKgGl3AgMAu9opvQ
	(envelope-from <linux-rdma+bounces-16351-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 17:03:28 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F02CE9A7
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 17:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A0AF83029438
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Feb 2026 16:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6380D37E316;
	Mon,  2 Feb 2026 16:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Vl22fXvu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010044.outbound.protection.outlook.com [52.101.201.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9033937E30D;
	Mon,  2 Feb 2026 16:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770048080; cv=fail; b=ailKgrUUwmJIyj2JjiInOol3bYqTqXkrq41Q3aVlSxP7FHUIrodcSa2jLOTJ0jFRXhIMHLaj+sT1WqADWlGIiQx7H7i35XIZczTwzFHSxVJ9TfK+ZFzY/T5CkPW/zQ+LJDpWp+c12W/bbj+9fZPKIPXBAPvh+ABLYFOo4Hxkxhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770048080; c=relaxed/simple;
	bh=qEO6SMXx5h0SuJE3VHPo0bsj9tYQgR6WsbXiCrVNEpI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=HsNH792b1da4LbHZ6mopj/gxmdzd9df6cBMXCHPxkb2xOZB6HmmicG5zkmwZk3f6f5tgizY2oUZ9r9+6fvWDmY5l0NpJ7AK4R9UUT8h/yMxFZJSxe0ziIT2JyZ4MH1z7nZT0oKH0IUv6DaTi9fRRUcDMvQ64YV0KwwCNY3Jj/o4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Vl22fXvu; arc=fail smtp.client-ip=52.101.201.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PRYx0aNhCEB0XZ6wBNXpwDLF9qZOgv90WMpGTInRVX2+MDV9t+kjz8rke+w1KZocY3SIctaMd8OaGvoGJI5Yb395/pfcilOk01NRfr178uoVzFr5v4o5l5c33tg9pUCzk12WTxA0dzjswE8nDuzUiLJ9CYfag6xXtteDCPvmo2XH665Wwc6HthYAaC5pyrp6WwASDsSMx16Z4R0gpEPjdKyhrZuAnBYnqNJeA5LVo2/Le4k/FVN9VEp8+K7Ur9vFU7Atv5x9SlCWpw0YItq/2VGvSpKeyPwB4UsrqZs/E2cFUy2VSDeQeQz2jvd2o05j/4Yl5nXqBto8eQC2AxTI7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPFrQ6vcwU1B2vmn540/Yhh+pN7qKDcR2ZHVLLq22Ig=;
 b=ZcmrMSTtEZWnG5kOzM5YnF2riK8lY5Nl+Gh2QBHN9ayuibfQu+f6lMiv7RKMmSgcVVAkeMskPDinMqClrF3i1WuMyS9pZZBq0LxE3rJB2MaHM3sxeYUIgC1LBogBIY+jvO+WcmPhATlyZ3271AEh9nLznnTKsVAL8TTztu5ahpuw1dlt1bZvvvwMHsjwPds3C9m7+PjV+m0UoGwQeHNBfX6DnwP8ukqpX1C3bPdjxQ0JLhDofK5ReK6KaKu0mYHv4qmWHWaVH7lm4Df+BawkILeffRyPZk3pIAmsD1RkDi6r3s+U82/7msmhSioOU0mFNnfQEMN1NkdGLpQcdEmYbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPFrQ6vcwU1B2vmn540/Yhh+pN7qKDcR2ZHVLLq22Ig=;
 b=Vl22fXvuMEjcUa2e7CigVyy4Go4V9vWUlFrU2NoVBbqjL3hsZlJ1EFkpmL+3rc+CHxGnlQUT/d0hpdSaLZJ5vgKC6Rhwa6FC/Huvx5UTrK+zZavF4lAvZx9nDaDpeiZ01MKuciib0x9F3YVxBs+KvfxoE9OmmpE/1kzHfYID0pfxK9ptMH7MoeAXP5cumpUxiTrLEdbCEfXRYGlBoxAvzMyKR+DHgRGVPl49Psvb8hBS1JRXwqDJGN42bEiM5HQLQUsprVMDWk6AN+dyaKEXVRNstb3f2Fj8Xqym8VTp8W1uVVXWgZkRtr/n/NqY4wWz8B5z5ilLu24tADxTBQUp8w==
Received: from SN7P222CA0014.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::8)
 by SJ2PR12MB9192.namprd12.prod.outlook.com (2603:10b6:a03:55d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 16:01:07 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:806:124:cafe::80) by SN7P222CA0014.outlook.office365.com
 (2603:10b6:806:124::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.15 via Frontend Transport; Mon,
 2 Feb 2026 16:01:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 2 Feb 2026 16:01:06 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 08:00:35 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 08:00:35 -0800
Received: from c-237-169-180-182.mtl.labs.mlnx (10.127.8.13) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Mon, 2 Feb 2026 08:00:30 -0800
From: Edward Srouji <edwards@nvidia.com>
Date: Mon, 2 Feb 2026 17:59:57 +0200
Subject: [PATCH rdma-next v3 05/11] RDMA/core: Add pinned handles to FRMR
 pools
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260202-frmr_pools-v3-5-b8405ed9deba@nvidia.com>
References: <20260202-frmr_pools-v3-0-b8405ed9deba@nvidia.com>
In-Reply-To: <20260202-frmr_pools-v3-0-b8405ed9deba@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Michael Guralnik <michaelgur@nvidia.com>, "Edward
 Srouji" <edwards@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770048005; l=6533;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=OAH7R44pAC0LGt7GystkQSh608kMjIJQirQNoLq+Kek=;
 b=8zt81xm/YrEwxWZaOKhb4yryzggcsLjzRZ3cBSIBIy9XyvtM1n85qcRuxgIrz9Iuss2Nlmv6F
 WKCG6aZsXTiCx7XLrW4+Gvzs8pAUWcCLO14SJVw5XVZy/5ZdYPQ9FQG
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|SJ2PR12MB9192:EE_
X-MS-Office365-Filtering-Correlation-Id: c97abb4e-1e8a-45e6-c464-08de6274462c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UDFVVGU3eTdLL0VEOHRWbTkzZzZEa1N0bVJGYXUzciswN0x1NmV1bUVEMHJw?=
 =?utf-8?B?UVpmTE5nbE9XcjUrQlFDR3htanRNUHMzbG0yRHJQWGhBWkZhSE1lZGYvbFA0?=
 =?utf-8?B?ZTdocVRSOURVNEdEa3NrR0ZndkxBR1ZGcEV3b3N0MlkwY0I1ckw3OTJ6cmF2?=
 =?utf-8?B?d1M1RTlwdlN5cGlLL1hROTFhc2VWaGRLdWUwN1FPNjdYbGFhcC9ibVVkMVVU?=
 =?utf-8?B?WU1USUFKc3AxR05yQXdjMWZJRkhMang5Z0s3YkVtUnVabktGdDk2U3g0UFBv?=
 =?utf-8?B?c3Z1UkNVYWhJVkhDUVZGdHdsMDRGWDZ6NGl5MGY4bXVlSEtsSExzMFp3L1lh?=
 =?utf-8?B?eGYySnFQZlVrdVZlOWV5WXdUWnRiTnArM2t1L2FPUDdXcG15NG1YZDBqVGtr?=
 =?utf-8?B?c3ROZWNYdHU5MnBYSmg2QngyWmtZeERCMjZtNFI0WHMrRzEzWU9Lanh4ZWhp?=
 =?utf-8?B?OGZRK1VMcTRkVnRqandMRWRUa3dNU2g1VG5JSVpFT2xUbmhRTTU4cDNrVDRV?=
 =?utf-8?B?OUd1WXV0OHk3Wk1Fa2l1enQ3S3VPRzcvMlkxMGZObVJVcFR3WnlQb3Q4RkFL?=
 =?utf-8?B?MDRJcytld0xicVJDSlFuY2EvSDRrWU9odGZCYjV6MkpxVE95Y1cxVFlvRDhG?=
 =?utf-8?B?S1BJNUdVVDRHZEg2eUdCcE1saFdHMllBNkljWmlvd0IxZURsODhYZ1kycUNK?=
 =?utf-8?B?WkFqV016VHpLcU01ejhSemFQd3hLRE1xZVQ1ZEc3SzZORE5ERVZ4aGk3YVdl?=
 =?utf-8?B?WCsrVVlwMTQ5djg5Yml6blhuTHRSdUIzQXAycHJBYUU5enBxYnZzbGk2WVps?=
 =?utf-8?B?MVErblhKVFozM0pLTVduYTNqSjJFYUhYRWxoT3QxOVZYLzAvSVlvWlhXUzJn?=
 =?utf-8?B?cU9QVWVsdEJPbHBYeC80NndMci9CcmZHbWdUZVNPMlFHcWFEbGIzU2tLMENJ?=
 =?utf-8?B?d1hLZDdhL1ZTVGlQMTRqM05tOGVaT08vWXphSXRmcmgyMWNVM0NyWFNHTFJv?=
 =?utf-8?B?cThxYkxDRVFVYk1QeG9xNkhqenhMY3dGL2Y5eGUxaWRlbE12VkdIb2w3ZkU1?=
 =?utf-8?B?d2xQeXljNytCYU9YNHhiT2Fzeno2SjA1MHY1QmFCYm85MFgyVHcxM0EwUG5t?=
 =?utf-8?B?SmRqaDY0QnAzZW1vL1ptY25wZFg1VFBlUm96NE1XR0lOMXFUTEpIT2hIM2N0?=
 =?utf-8?B?TUdjY2t5QnBGQzJuK1FERkloaForWVBiVllrVWRyVjhYN29WQUhranFDOTFL?=
 =?utf-8?B?clBjbWl2NHBBajFVZ05ML2Y2OHZTaGxBeDlVd1VNeEY3RG9GMUZQMjRRR2N2?=
 =?utf-8?B?WDJWZmwyZ2JZUHhGdWtDRjdBSW80R21rVWQ5ZGNaTGNxRzhlR3R4RmJCRHhk?=
 =?utf-8?B?MnY2OWR0MmdrMXdwRDlodXpBSlZIbFQxU1FyTEVaTFE2Vmxuc01CZHhGdm1J?=
 =?utf-8?B?STc5TlZkVGFrNVNUeEZ1S1JJYnpmbldQNzgvaXdQQzNjYjRWNjlac2xpYUda?=
 =?utf-8?B?MWlhSWJnK2xMZC9Nbmh0NkIrcEJHajdoWVhKdGkxQVZNUHBralR4UllIelgz?=
 =?utf-8?B?aFBSQTk5dExFcGZzZHZScTBRSW13Sk1Cc1UrUEhKelR3OTVIRStNMXAwL2ox?=
 =?utf-8?B?SGVLbmFRcVlkZmtpYkQzeHRiR21lcEQwMWs2ZVEvaXFyUnZBMHdaaW94bVVD?=
 =?utf-8?B?V2ZsdFgwT0VhSUF2THRkcFBOaUFSYW9KbUFJYk9pd1Uvem1tRnM1ZzZLbVJq?=
 =?utf-8?B?aEs2amsxUnAzZU83QXkyMThvdzU0K3FoMlBjVGxoeTl5elppTUxnREdDOGhQ?=
 =?utf-8?B?dWtYZTk1cmdjVEFBd0pkWFhuWjU1TEhycXZ2S1VGMHZid0dSeG5RWklLczVn?=
 =?utf-8?B?aUhDYndKd2xiMHVibkJVckI1RVdwV1RVamhxeElpZUk4R3lqY2tmU3FTa1RY?=
 =?utf-8?B?QmJ0MFJiQ2lKc0VrWlBJb3ZRNU9rb2x1azVWdjA4T0U0QTdCYWpnZWFVQWNW?=
 =?utf-8?B?UDROL2FNcDdKdkcrZ0lQNG9xLytDekRSeGl3VXBuU2YwZTFaYVlJaDlSVlZ2?=
 =?utf-8?B?MkJvaUpOVTdNL3E3cWI2TVZPRm1USmVMK2FVbEZKMFVsS3lTVDBmYUI4WWk1?=
 =?utf-8?B?S3FyNUhpc053aTU2Tk8zWnEyaGIxbCtNYnRIeHBSTjFVbUhtRUtZZEJ2eVA2?=
 =?utf-8?B?TWlmai9UVFREK05PS2lOam03M0R4N0lEdDBKeVh6dEdoZmpEU0dyalY5eUhh?=
 =?utf-8?Q?VZjNooxdsQ6a39gCq9sSPlyRt5XEqLCxGYLn7WGk/I=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eHlIit1bLMo7+BDrkN7ztSm3F9q/XSkCAQXmLNXczTroRFwFh2Kcvzxvtp/JCDVs3JTaaA6r+4FGvh+r2IibGBNyh3kjs8mXNsJd5OwAZSjNMuHTFWpz0vsKrgJhcYdLIFXeodhmlGVegPGIsD1PBE/skJ6cWcIimZ0hmE++bfOjN2f7oN9xF0PCBzDPgvAAbrfmcsE7j4B3hoN80eCLXCvBKubQyLghxAEjSp1nZp0MSKMzNB3CRWiOPOmXuWURzw+12o+X7oSjRuJxqHDX3qSHyuKCnr5BzTUM5sCUbG4pGdDWpYmHgE9YOe14A+WwP26gKXF97buRptAOJpuhKI7J/BLJFH5TPhM21KP0yVKThJJmu1ZYEWb+nuf558NHqJzwwMHP8Bnb1MjYCibUljB2hZ+lLigSlDvvv6BwJxZQrg2+QJvlgaZ9rmIpWHdx
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 16:01:06.4850
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c97abb4e-1e8a-45e6-c464-08de6274462c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9192
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-16351-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 05F02CE9A7
X-Rspamd-Action: no action

From: Michael Guralnik <michaelgur@nvidia.com>

Add a configuration of pinned handles on a specific FRMR pool.
The configured amount of pinned handles will not be aged and will stay
available for users to claim.

Upon setting the amount of pinned handles to an FRMR pool, we will make
sure we have at least the pinned amount of handles associated with the
pool and create more, if necessary.
The count for pinned handles take into account handles that are used by
user MRs and handles in the queue.

Introduce a new FRMR operation of build_key that allows drivers to
manipulate FRMR keys supplied by the user, allowing failing for
unsupported properties and masking of properties that are modifiable.

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Yishai Hadas <yishaih@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/core/frmr_pools.c | 127 +++++++++++++++++++++++++++++++++++
 drivers/infiniband/core/frmr_pools.h |   3 +
 include/rdma/frmr_pools.h            |   2 +
 3 files changed, 132 insertions(+)

diff --git a/drivers/infiniband/core/frmr_pools.c b/drivers/infiniband/core/frmr_pools.c
index cba9d54a59c7..c5abfc59f9d6 100644
--- a/drivers/infiniband/core/frmr_pools.c
+++ b/drivers/infiniband/core/frmr_pools.c
@@ -97,6 +97,50 @@ static void destroy_all_handles_in_queue(struct ib_device *device,
 	}
 }
 
+static bool age_pinned_pool(struct ib_device *device, struct ib_frmr_pool *pool)
+{
+	struct ib_frmr_pools *pools = device->frmr_pools;
+	u32 total, to_destroy, destroyed = 0;
+	bool has_work = false;
+	u32 *handles;
+	u32 handle;
+
+	spin_lock(&pool->lock);
+	total = pool->queue.ci + pool->inactive_queue.ci + pool->in_use;
+	if (total <= pool->pinned_handles) {
+		spin_unlock(&pool->lock);
+		return false;
+	}
+
+	to_destroy = total - pool->pinned_handles;
+
+	handles = kcalloc(to_destroy, sizeof(*handles), GFP_ATOMIC);
+	if (!handles) {
+		spin_unlock(&pool->lock);
+		return true;
+	}
+
+	/* Destroy all excess handles in the inactive queue */
+	while (pool->inactive_queue.ci && destroyed < to_destroy) {
+		handles[destroyed++] = pop_handle_from_queue_locked(
+			&pool->inactive_queue);
+	}
+
+	/* Move all handles from regular queue to inactive queue */
+	while (pool->queue.ci) {
+		handle = pop_handle_from_queue_locked(&pool->queue);
+		push_handle_to_queue_locked(&pool->inactive_queue, handle);
+		has_work = true;
+	}
+
+	spin_unlock(&pool->lock);
+
+	if (destroyed)
+		pools->pool_ops->destroy_frmrs(device, handles, destroyed);
+	kfree(handles);
+	return has_work;
+}
+
 static void pool_aging_work(struct work_struct *work)
 {
 	struct ib_frmr_pool *pool = container_of(
@@ -104,6 +148,11 @@ static void pool_aging_work(struct work_struct *work)
 	struct ib_frmr_pools *pools = pool->device->frmr_pools;
 	bool has_work = false;
 
+	if (pool->pinned_handles) {
+		has_work = age_pinned_pool(pool->device, pool);
+		goto out;
+	}
+
 	destroy_all_handles_in_queue(pool->device, pool, &pool->inactive_queue);
 
 	/* Move all pages from regular queue to inactive queue */
@@ -120,6 +169,7 @@ static void pool_aging_work(struct work_struct *work)
 	}
 	spin_unlock(&pool->lock);
 
+out:
 	/* Reschedule if there are handles to age in next aging period */
 	if (has_work)
 		queue_delayed_work(
@@ -302,6 +352,83 @@ static struct ib_frmr_pool *create_frmr_pool(struct ib_device *device,
 	return pool;
 }
 
+int ib_frmr_pools_set_pinned(struct ib_device *device, struct ib_frmr_key *key,
+			     u32 pinned_handles)
+{
+	struct ib_frmr_pools *pools = device->frmr_pools;
+	struct ib_frmr_key driver_key = {};
+	struct ib_frmr_pool *pool;
+	u32 needed_handles;
+	u32 current_total;
+	int i, ret = 0;
+	u32 *handles;
+
+	if (!pools)
+		return -EINVAL;
+
+	ret = ib_check_mr_access(device, key->access_flags);
+	if (ret)
+		return ret;
+
+	if (pools->pool_ops->build_key) {
+		ret = pools->pool_ops->build_key(device, key, &driver_key);
+		if (ret)
+			return ret;
+	} else {
+		memcpy(&driver_key, key, sizeof(*key));
+	}
+
+	pool = ib_frmr_pool_find(pools, &driver_key);
+	if (!pool) {
+		pool = create_frmr_pool(device, &driver_key);
+		if (IS_ERR(pool))
+			return PTR_ERR(pool);
+	}
+
+	spin_lock(&pool->lock);
+	current_total = pool->in_use + pool->queue.ci + pool->inactive_queue.ci;
+
+	if (current_total < pinned_handles)
+		needed_handles = pinned_handles - current_total;
+	else
+		needed_handles = 0;
+
+	pool->pinned_handles = pinned_handles;
+	spin_unlock(&pool->lock);
+
+	if (!needed_handles)
+		goto schedule_aging;
+
+	handles = kcalloc(needed_handles, sizeof(*handles), GFP_KERNEL);
+	if (!handles)
+		return -ENOMEM;
+
+	ret = pools->pool_ops->create_frmrs(device, key, handles,
+					    needed_handles);
+	if (ret) {
+		kfree(handles);
+		return ret;
+	}
+
+	spin_lock(&pool->lock);
+	for (i = 0; i < needed_handles; i++) {
+		ret = push_handle_to_queue_locked(&pool->queue,
+						  handles[i]);
+		if (ret)
+			goto end;
+	}
+
+end:
+	spin_unlock(&pool->lock);
+	kfree(handles);
+
+schedule_aging:
+	/* Ensure aging is scheduled to adjust to new pinned handles count */
+	mod_delayed_work(pools->aging_wq, &pool->aging_work, 0);
+
+	return ret;
+}
+
 static int get_frmr_from_pool(struct ib_device *device,
 			      struct ib_frmr_pool *pool, struct ib_mr *mr)
 {
diff --git a/drivers/infiniband/core/frmr_pools.h b/drivers/infiniband/core/frmr_pools.h
index 814d8a2106c2..b144273ee347 100644
--- a/drivers/infiniband/core/frmr_pools.h
+++ b/drivers/infiniband/core/frmr_pools.h
@@ -45,6 +45,7 @@ struct ib_frmr_pool {
 
 	u32 max_in_use;
 	u32 in_use;
+	u32 pinned_handles;
 };
 
 struct ib_frmr_pools {
@@ -55,4 +56,6 @@ struct ib_frmr_pools {
 	struct workqueue_struct *aging_wq;
 };
 
+int ib_frmr_pools_set_pinned(struct ib_device *device, struct ib_frmr_key *key,
+			     u32 pinned_handles);
 #endif /* RDMA_CORE_FRMR_POOLS_H */
diff --git a/include/rdma/frmr_pools.h b/include/rdma/frmr_pools.h
index da92ef4d7310..333ce31fc762 100644
--- a/include/rdma/frmr_pools.h
+++ b/include/rdma/frmr_pools.h
@@ -26,6 +26,8 @@ struct ib_frmr_pool_ops {
 			    u32 *handles, u32 count);
 	void (*destroy_frmrs)(struct ib_device *device, u32 *handles,
 			      u32 count);
+	int (*build_key)(struct ib_device *device, const struct ib_frmr_key *in,
+			 struct ib_frmr_key *out);
 };
 
 int ib_frmr_pools_init(struct ib_device *device,

-- 
2.47.1


