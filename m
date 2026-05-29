Return-Path: <linux-rdma+bounces-21478-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KP8EFTUjGWqVqwgAu9opvQ
	(envelope-from <linux-rdma+bounces-21478-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 07:25:09 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D725FD53E
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 07:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69B8030599D2
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 05:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737662E7380;
	Fri, 29 May 2026 05:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kOKzJDw5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012044.outbound.protection.outlook.com [52.101.43.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129DD32AAAB;
	Fri, 29 May 2026 05:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780032298; cv=fail; b=rzQOq77njKfGIU9sXFOptmUnxzeTVqXYMKXj8iYbh3DA6g/+154N+Np3zsTAJzutUN6T55mU1OIq9kCcBSDynA/a+JaYlqS539yzDgYl0wGJnoAAq0qsgMiSBbo5/yEvXby+06gfPVJCX+f/if6YLGCT/584moktlJ0Q2VNsLSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780032298; c=relaxed/simple;
	bh=3dljUJem/mSGfUv7UmxbYHJXY+LKbZM95Pmb9KnuZNQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NMaBhZ3dPyp7pay0zTfuhh9WifyOUvLIL1iXEIvlSlCOOaShuLd3BM1sl9BQGjLtfqnO397KvShIWXwZldVZBQTkICdBKOL4iBW9AU6MrPKQy2s8c6jrIf1752p8ZKGpJ3tcMqirlyytTxJppDYLGvA34sW9JuofFHi1l/sNCQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kOKzJDw5; arc=fail smtp.client-ip=52.101.43.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IbM+f7pG/vZplEah+tFDqps1Jji1ylmAj8Nj6NUKryZLfiq1eU+qv/IXWcMQopRZcikPPqleeQOEyYxq/B6nyqTPve0y1BXTOVWqZxYibpLGMaKGnQhPaaN8EGzkzNl5somu8uV+Vu6RkXJV3Km2lrvgBeNWMzOp9hMIEDbxCtLFp/wNxl19ax7Uq402BK97jZ8nuE+sx5rTx+SnTj4htkzS7fZgHOSYyt/syYCaJQMDgI3am6tW6G1tf8x/BihHLSWNEprrGWa2RQexe+9CrYpwuCmJi+P0ZpVBHU24kEEW5GQzdfSKvEpRXtr3qRfzfnqkJG2sB9nw//QmxTZD1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b918hFwbW4b7A/O4Jg8b85HQlHXSHBod7QvSomm2rbU=;
 b=ox7odOAorK78Wcq1DcU9nO7vobLdNechZv33qB0pn3jzna7KiSUXJVl4mhe6dxzQYai/T0y2eduSW01BcvYpkOZUrI8VEQoi0fjbcH/Tzex4+YO2A4UVDtWcSJDQKRAhdZ4HE+0QsY8AGc6eFDBKX8V/+ZvEdZzH7q39jp0M1I3FL+Dsic0hIJoLthx8QKChWkOcBOl6vWTh4Y1mKwiQjumaoIr6pdhtcOdLmDf/URBrRPjUCsJsVGnpjhGbNZ5kqRfFT0ydZ+Oy1xukOgPd1C0bzExQUP4Qif5PmoKn7kGTdRutaqSO6Fz+N/HiPGbxQf4QrcdK8i50cwqCZ+MCYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b918hFwbW4b7A/O4Jg8b85HQlHXSHBod7QvSomm2rbU=;
 b=kOKzJDw5ETQ8KTK2ButROmFYQ9mF0bllxYLPWqoAPvRXglaBWLT9LAK3xOtA2gFG8hegNfrQG9gZo+pFV6xyWVlMZmlXOxG8EAzhqIaa3TZNLe+gqqssKWVRGiCTBrqqQap14Fl5nlM5PQkFZ41K7qKlf/wGFvvL57G/YsCLjZwStR1iPJXe5WTC2S3JTlRIwEOkpoVp84WScIaL0Y+Me7w0sdpcAQgiyRFwTenm+/8rJ2F1bMh0FlllPSIF1tHD4BorAKDSE5E2osI4wrIOyKPuro7/6kYadq1gRU6QnT28tyZCd4nEuWvAu3puoROlf/Ib47FlOGQ4UbbL1xGgwg==
Received: from SJ0PR03CA0357.namprd03.prod.outlook.com (2603:10b6:a03:39c::32)
 by CH2PR12MB4070.namprd12.prod.outlook.com (2603:10b6:610:ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Fri, 29 May
 2026 05:24:52 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:a03:39c:cafe::d) by SJ0PR03CA0357.outlook.office365.com
 (2603:10b6:a03:39c::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.14 via Frontend Transport; Fri, 29
 May 2026 05:24:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Fri, 29 May 2026 05:24:52 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 28 May
 2026 22:24:33 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 28 May
 2026 22:24:32 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 28
 May 2026 22:24:29 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>
Subject: [PATCH mlx5-next 0/2] mlx5-next updates 2026-05-29
Date: Fri, 29 May 2026 08:23:57 +0300
Message-ID: <20260529052359.389413-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|CH2PR12MB4070:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d733a2f-465c-4e8c-0f2c-08debd429c62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|7416014|376014|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	ehL2Ngss23uFbeCt7pUMh7jvUAxSdq/CVjI3xeqvCKol1kk8MrhG3Gs2AhagTQCIq2aL/TmcYJJ18jyJ+TEfdPSJJug8EZbfoLdjkappC+HvVdGPRHLY+7yv/9u9fFM+1wiTFo/K1+8vNmrOm55FhdtQEUsNu6qbjSRiy3r16yhFgs5Zwy82A0d2lJZOY+dEaZdQwF1Ukc7jZM3koNFv/TflTjGNTlCDPBRiHH6C06Iv4prmKKJQR1dBz24M9Q2wVjuTCQK2CT28E2gQOqgXINiM7XENe0LjynhtCXzI1guyx5A2UIbZwcHioMDGfU4JJdtsOb1dTXoISHvoZwUaBAd5pNIcCrSl4A5mmeu0oFfjM+mvLryz17kjwBM7dXP6BprXAq0TmfNEDWYq2oqlrNBPgMqSZHa3F1oASP6uzIxaGo7n+9LALD3u6GqOX7PAPbtXTX35NcWnhKdxqRWCEWdXVpakUfEVsjyR8Z2D9OkTuD3IBHu5VaxkFl6iXmxbEeGDsyh3gZ+zCy8YaLQ30rFX/lXxpvnaqtYQZU4w9WIR/UwfFtN6aOp5rWe/KJsrqu2Zx+myuYmbjpc0EkOgOIePoV4AIhVaOmp5oCfvgQitwNrX1dHIKcNbAr67ywiPlN3+IdTe8TsEu3/s8FJcVnWb2eoAkRT2whvx9CwM8+qx5zGWEr10nIvgm8lIh9OI9niWj6XeNcKe225flsPhLwffN+iiCqlD4Y3yqZKPF1g=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(7416014)(376014)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MN2Eh/A0Ef8IBzfdEOQ8aP8UeP8MEIJHba2xB3Rny7oTbM7s+22mxovlYElyAliR7HCBrvHzZ3vSsgHAyxUtl9+qjGoL3SGz+rrCLoWHvpN1Ilr5/27kIbt85dtDNaoR+x2W1OEeUnWk4u74pt94HtDWQrwYPowgfz2yyv0c1KVbb54oYXi+7DXQ1LIqOpqQqNQUi3uTDVcsIr+KeUXSWBQ+EGHSSHpuZangqtwcWs+e3AFrA1s9r0gfFJUCpdXE1yJMVgPGeBXMnFQhEcMkn4y0zvf8fQxqb9AicuKk1hU7Gb8J1TjFy/eVsSf2LW7qpttPw4eXjhD4yhz4EufdLYXaRCsOK4ajWCzvgPpI7AKEkZWBwOHQ97JCvsQa/Wz7+l+ubbExu02ltEppn0quC5x5ihvrWvpTVFnroFFdeNSWWQA4jBdSwL+0K+xY4t5x
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 05:24:52.0904
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d733a2f-465c-4e8c-0f2c-08debd429c62
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4070
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21478-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: A9D725FD53E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

This series contains mlx5 shared updates.

Regards,
Tariq

Dragos Tatulea (1):
  net/mlx5: Update IFC allowed_list_size field bits

Shay Drory (1):
  net/mlx5: Add sd_group_size bits for SD management

 include/linux/mlx5/mlx5_ifc.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)


base-commit: 02c54621e81ccdc1907e2d735bcda751f2caade1
-- 
2.44.0


