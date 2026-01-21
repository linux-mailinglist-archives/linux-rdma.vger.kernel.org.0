Return-Path: <linux-rdma+bounces-15867-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4F7yAJ1IcWn2fgAAu9opvQ
	(envelope-from <linux-rdma+bounces-15867-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 22:43:57 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F0A5E361
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 22:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 823E0683704
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 21:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F7543CED7;
	Wed, 21 Jan 2026 21:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eXplUDs8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011038.outbound.protection.outlook.com [40.107.208.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C4543C07F;
	Wed, 21 Jan 2026 21:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769031775; cv=fail; b=F2yXHomr3yemi8RkDsU8R24Z+Od/i/n9HJReZ7Ij92w8TzP/f9/ZDAV6sDpDxLQw2JwmtYPEZLVFeZBkxg3+LMa+ogy3M9RRfoV1wWnBsVCOgqcnTwPZfQLgsvcCxUFBq/NPIAkQNOk+ZlIyAVRkeYWI1QKKqIGLgK+akVXRcfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769031775; c=relaxed/simple;
	bh=N7HI9gG5/OOvrdA6rvulCsa8GRmyteGxqwP83p8vUMY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=AShf5DAauadHUXd/3gvZFtj/6MvxyqGRnQiCbN6oVK5Xhk7oSUy90UCgseSeN6X0AhYA6HWr8Yl0rioo9C2JhdLooXcOSjVndXHsRvLJPLQZZ6hSLV4MQw6q+qrDjH2IaAw5Pb2uTOvp/ryxqlo3NC/XycVfY6IYE37mZfnqHuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eXplUDs8; arc=fail smtp.client-ip=40.107.208.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=beTCuBsE5ZRNxCgsQlgxfcfGtZFWotUhkQtjm3Xz8Kh8femyMbtUNT0j8SQ93NL16Yd/WgpvdyUsZlrM3HtBF6hi6DnLMv4uUlXaUQCAfkMdKiX3ju8mtwdDBZNeZjEtcQcK8ALSad8B2FCBHiXyhU/aM5RTLHAqaAbL/lIlMVrEfryDYWmTeAR1xriBD7nKe32lMeCL/OGVZ/4SdXG6jg+YqhS20Re7pocL36svCQAAiZ7Kv0mXbm+5HNijIZyBY14RMWu83syOQOQUTCFdXBCEAMAMRgnqAAVlSTKy18g5C3lPAvb6s5rSjnZI2xwNZ7JFFh+0vJTXw/dVh9dupA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/W7LqEx18WUsxvfWM3YNeaXbbGsPWoCwQCAOTqXNu8=;
 b=iVH2L+bgJBL1xC75VL8BgoSqbuQqE2NJjKha6C9OsmcDVOU7CEwi3yjX/nV+i9M1LywpWXOO9k6ug0A2/GLaWOfHgqW1YJhU3nc/4RVHFhod3el552pjd8vXN+9YaiU9lQxIqr410wOdP5olAigy00LCfwg1Pch4pEtqytzqdcrSRDoYhfMWM5VqaZ35brB1zH4HhLOWVobtaryp9XQadJryHt/wnehARpmgFPEw6eSkvajClDttvwdGCrqhZMBEwbGC0CFCTK/zs/fq+Ac7SvUFMeiNgv6YeN6IRbpjP8pw8CPYblhapeidQjkbUeBqOy0EnJPFRHERHGTo0BAibQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/W7LqEx18WUsxvfWM3YNeaXbbGsPWoCwQCAOTqXNu8=;
 b=eXplUDs80HGQ83SusUUUepAzfXKCGVa86IBRsukgMzKnHjMHRPA2eFr8ZePvaobLL/qkfwmu7+Wxgf8Gm21cVzVm8miE2CsS6HQ8gV3MhmNgMRmJ/uTp3EK5xtIkSvgec+A4I/eAW5UEm6eIeXUqbhGIPvVp4oUOwPPLckzeXtUzyacZVU4vyc70dkiZxuK96KbE/YJ1UBwV0cmOI7rkWOyf7gUJH3GYUuxZjZT3Kj5/1UBgS2Ti8VEjZvbvjfQL65DIo4NJDg9B+vYFWuFugcWiZvZqftxrmz2RA2bFEPK2gosRJnHz0IROK1amvqcaZtGRIDMv1HEHmQ/SwOEuig==
Received: from CH0PR03CA0437.namprd03.prod.outlook.com (2603:10b6:610:10e::17)
 by MW6PR12MB8735.namprd12.prod.outlook.com (2603:10b6:303:245::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 21:42:46 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:10e:cafe::44) by CH0PR03CA0437.outlook.office365.com
 (2603:10b6:610:10e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Wed,
 21 Jan 2026 21:42:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 21:42:45 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 13:42:33 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 21 Jan 2026 13:42:32 -0800
Received: from c-237-150-60-063.mtl.labs.mlnx (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 21 Jan 2026 13:42:30 -0800
From: Edward Srouji <edwards@nvidia.com>
Date: Wed, 21 Jan 2026 23:42:13 +0200
Subject: [PATCH rdma-next v2 3/3] RDMA/mlx5: Implement DMABUF export ops
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260121-dmabuf-export-v2-3-6381183bcc3d@nvidia.com>
References: <20260121-dmabuf-export-v2-0-6381183bcc3d@nvidia.com>
In-Reply-To: <20260121-dmabuf-export-v2-0-6381183bcc3d@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, "Sumit
 Semwal" <sumit.semwal@linaro.org>, =?utf-8?q?Christian_K=C3=B6nig?=
	<christian.koenig@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
	<linaro-mm-sig@lists.linaro.org>, Yishai Hadas <yishaih@nvidia.com>, "Edward
 Srouji" <edwards@nvidia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769031741; l=3906;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=XKdedpkRWS96DSpISJqiO92oMp2BawoYlv3Gdfu8C30=;
 b=11+XvVBtVXCG1xtkuR2YxwaZi0D9JuOiz1AtSmNLHCTnz629HuZWOIVB9ahLDicH0aFOhcpKK
 kjiOoyS6aiqAlXEYKIJTcM9Jju0TPiVVuqAdm4r8lv6/+LI1vxKUBSt
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|MW6PR12MB8735:EE_
X-MS-Office365-Filtering-Correlation-Id: 7166b4bc-8aa3-4fd7-b310-08de593603c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z1JLOUpTNTFoN0tsYk9vL0Q3Nm04Sjd6V2l6M1RLR0RuTzljUFc0VjN6NU9z?=
 =?utf-8?B?VzJ2a05MekZJSmRZbHJCOVVJSmZVWHo3RmlCT0xyNFJFMzgzNUphZi9GWjl4?=
 =?utf-8?B?cTgvQkVRaXNvQ0pqYzFLUkZ4VTljaWg4d3JQdUt5ZG9FSWw2SjdVaTdobG51?=
 =?utf-8?B?WnZIR1ozZk84cWZxUGVBM0xLNTZBTThzcElWK0w3OHdhVFJWK1E3aGFMMkha?=
 =?utf-8?B?VnFrbEpvWVU3QWZTNFpXTDlhSjNGVUlTeGFqNi9zcVlFV3RqZTNOckVvSUVk?=
 =?utf-8?B?QXV5byt1SG9uTGtlOGJ6ZTc4aTlIbTduVjFKUnZoZFBWMk1BU2gyRDFMa0k3?=
 =?utf-8?B?Um5BUTh5MkpRbU95S1FLaHRDUElobnFsSFBLZFcyQ1lUY0Z0YmpRR3ZCaHJh?=
 =?utf-8?B?MzMwYjgwTmFLQzh5UjFSU2hBZGg5bnVITTA0VlpVZDg0ZThZZGE4eGNlalc3?=
 =?utf-8?B?RnNsKzJ4OTB2YnJ3ejNlSTdXWjhzdndUeSt2VEU2WDBJTDJZclFacDh0djZK?=
 =?utf-8?B?elJWeDFMSzlNTCtKVTZvLzhjVStCbHUwL2ZFMnJwN2FTOVNIUmJpdmJoRTg5?=
 =?utf-8?B?SlhFb1JheXNSSXduMzdYdjJvbUF2eGM4UG8xanBnby9YNDlzbUNWUXdEWnRZ?=
 =?utf-8?B?WWhDcDFZYXR4T09Gb0REa3dPNGwvK1kxQ201TWZMeW9aY0hGK2M1SzNUVEZo?=
 =?utf-8?B?SzdkR2FxUmFMNnpkeDU3V1FlMUJZWHRRdjZJNG1icE1hbEh6UDZsbFNHZ1ZT?=
 =?utf-8?B?SnM5MDArTytCSjQ2a21UV3RzZlR5U0lXVXQ1R1hpMXVKRXBaK2NxMFY1WDAz?=
 =?utf-8?B?cUI4RTFxMjIzTUEyck9KUjMycnhkM1RqSkhJaUZzZDBvc2g0OElDWWRmMXhD?=
 =?utf-8?B?NHZhSDBvS0oxVWJnV2FrQnVjMDdhVHpscGJjMXBCYVRiKzZTVzdrdk1jak5o?=
 =?utf-8?B?MzlyVFJwdDFhaExVT3JMR0hmZzI2YUV3bWFZa2dsOFpwa1hSZ1ZnR2N5Q3R2?=
 =?utf-8?B?eFhtVHpZMTdJY2lpSVB2cVptS1A4bFNPTXFCYjRFQmpYRy9GKzlVc2V4N1pi?=
 =?utf-8?B?c3F0NUl2cU5ZQkVyREVyenlYSFcycU5kV0JzbGYvSmpDc0JlM2tYU0crZldU?=
 =?utf-8?B?UXMzMEdDek5IZEVOMXU2MWtLL3N6ZGp5OEMvRXlRY3NlSExZUDhjYWRhSzZP?=
 =?utf-8?B?VFMwM0N2bkR6c1hoSjBONS9wWmF5ZFo1RXJaT0o0Mk9hajdqVFNUUk9KTURG?=
 =?utf-8?B?YWdkRXQ1UDFEMnpUM1IxWjJLdFZXTnFxazRRU005eXJqNkVnK2ZMN1IxTUxN?=
 =?utf-8?B?aC9XUi9CTkNnMmVBMW9LS000Q3VJMDJzaG5wbFgxOTRqck96a090Z01YSXNs?=
 =?utf-8?B?VXZrbW1XcHo5RGRuYXR0RjRTYlJsSXpRbG1OV2gyd2t4aHpzQjNmY1dSSmF2?=
 =?utf-8?B?YmVCUXU2cjdlbDIwTkRhZFNQYyt5ZkdOeWpqTGNzeXFDcTRZUjZkZG5wMUZJ?=
 =?utf-8?B?U1UybU9QNVFFZ0xsaDJRWmN1NUtVTmlidVgwK1FycVEwT2QrL1FaSTlJRHVj?=
 =?utf-8?B?dmo1WDMzUEp4aVc4citDK05NcTBzNUJLUDVHT1ovb2lGbTczcEhlaUk2NHFq?=
 =?utf-8?B?RE1Qc3FkS2lVMEZmYm1nMDNWT1d6UG5DMElta2V4WVpTWmtHUWRkclJwWHZi?=
 =?utf-8?B?d3BRbjNTUkNQdlRCMWtKWmhWM0J3cXZ2Qi9SSmxNOXN2aFBCVkljd0lLaU5s?=
 =?utf-8?B?MjRncFlMWnU3KzRjcUFyTEFKdlhYS0NxUkkwdU1LS01PQ1BNTGdpcEpjamFT?=
 =?utf-8?B?WEo1d2laZWFKb01oVGF6cDVPRUFQcm5YZCtaQy9BV08veWkzcUVpWlhZVHFp?=
 =?utf-8?B?Ry9KeDIvZEJyM256elZ0MVBBQlJnMTNGMU1GRnYzSFhQbTZtbmRTRHhtSmJw?=
 =?utf-8?B?SFA3dGZIcU1EcnhkaWJqbGxwUDJ1OVVVQXV2TVl0SEV0OHk4ckY0b1NSTGVM?=
 =?utf-8?B?Si9FMVVjTTR0UmVOUlQxb2VtL0VDa0lkb0Z4ZU5SQ29ITUJhcGY3ZXZpNGlq?=
 =?utf-8?B?RmxUVmJLK3ZYYlc5WVVid3VtN0ZYU2JQZWZkUHE4bDh4MlV2NTZ1a3pHa2Nz?=
 =?utf-8?B?TjlhdjJVeWlMcFhqV0Mra2U5NHEzMGZWUXc4SDhrRFc5UzFEcUFIWkgrWjVO?=
 =?utf-8?B?bjVZNWswYzRJVVhGK3lJS2QwWVVYeFNEczJzdU0wVU1WTkFDMkZHekpOU2Fm?=
 =?utf-8?B?bnNjNjdPSUxRbTY1bmp1MTZkZHh3PT0=?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 21:42:45.8315
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7166b4bc-8aa3-4fd7-b310-08de593603c7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8735
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[nvidia.com,reject];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	TAGGED_FROM(0.00)[bounces-15867-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[linux-rdma];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 55F0A5E361
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
2.49.0


