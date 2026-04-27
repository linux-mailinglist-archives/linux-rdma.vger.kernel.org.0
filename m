Return-Path: <linux-rdma+bounces-19576-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yF2/GpBC72lP/QAAu9opvQ
	(envelope-from <linux-rdma+bounces-19576-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 13:03:44 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D5447170D
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 13:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D3E0302C155
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 11:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3173ACA43;
	Mon, 27 Apr 2026 11:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nkfUiReG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012011.outbound.protection.outlook.com [52.101.43.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6BB39F191;
	Mon, 27 Apr 2026 11:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777287795; cv=fail; b=g/gt17mcGvY2htqbU7wuruW1bOEt3MJZ8sGooax5djT37HErzkHMFTto9akYCzMzfFHQ0yzpTHbZEBTSluHCL0KFyr/e3a7txLDeHptldlrTx6UL5sCzfhs15Vt24zXMJOXtvp7g/uDzCCD5eQ3xiMUzJKBGhNJZ9dmsWWpSC4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777287795; c=relaxed/simple;
	bh=pcU4TcPkPdyT7Zvb+Pr1tsj67bqbvy4jfpAhmnPY9UY=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=X4N5C7IVVKngvjIyCDHzxdCiZiaG+s+FV7bemDP0Posf9nQNdO3Rja1H3hbD0cPJzGbOTHFlbBUY/eNlCFqVObQoFpZZ/9uDKfjLuUsQDUQlStLCcyQZhP0imEHfpPFM6/2FBUJI3q1txOkM+VTRn7/0VvKRI2yHA1xfOqfUlNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nkfUiReG; arc=fail smtp.client-ip=52.101.43.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QkAfjuztl4NiDZgzR8u3zRWOWJ4PbxDHsy7phClOb3+fXrIEgsf94BGpeuOnma/tOc9ojY9x5/VsNY/aV3o6qbkQfNQOp3Oqnro5f6EM2Rf8WlAEJe5JdXBMNSWnWem49B6f+YNbdyuPUvEGlBIApZ6W941Tw/Z4iWPWKO7B4l+H+t2o+7PCbC6HFWslG7cqD/VD73SRibnxtlppnp8A5j1lztmtODeN0LLnky7IDdWje7sB2K1xzykFxQxDrsstx2MX88jelKNE7cm5TbDA5AAePpNdG50oQXcarx54rXg5T3Uc4gV92aEl8AbWAVTWo5JXRIkWz+c6ZkajZCwViw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYI15zvkcWNW70Ycz1CoA1f2h6B9K/i/G3o93oVtvvE=;
 b=DtTH2YWnXfvY4sgOXWW0jk80Wo1/G3KIBG+Eka4kpCH2Xmk37bRMZjDc7SK6zpFd9R6i3gh1rR4xn8MKCnsztdNk7if2o2FzTJZEu23UnUourP/6Qok0b24HrwCXgb/9VpwYuoNitE1nKbKfsekTfWE3xJzty61Gv73c9i+qp8LgUIswCc3JwRj3qR5Oa9ZbayXv0Dd0IfPashElbQL0Kc/JpNmitMfGDCksjeqWRsmkbss8UKNg+3LOf0abq0EwwydxmESQJIKxLiVsfG7WWc7EAHqn/fNPlPNB/EsUXc0OFZkXpUIJS4KNROHLaNkw4u5sEXzvbXx80jLWTgmfQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYI15zvkcWNW70Ycz1CoA1f2h6B9K/i/G3o93oVtvvE=;
 b=nkfUiReGVZO4WEfx4tW5uDPGTjfHVUrbcqojNL1NUnnyJTRE2c693CfjK80QFIHAgi/jOLC50FgbYqAD65NfpknkCPt3bRty2uOA0KuQoUF2QQuExgnVULEd3mJsp+VymlGp5dDlW8JPucIKaBVavstv2HQTatP92qqw7YvKN7YywCxIJ94Pmz/sl7nmPkVXrTtWxCPwTPsd6VVJomrl7ZRed6hmAStsqUksTzRBfWQJqajBpCGNgBpsZubhd1A5YRIayk1kKvwYvM9VAEDCLa9xopu83tDVm3l5T1YJ6YUWomgxhGCwxaUGpBnv+70LPXAwawUyVqsL9YbCP29grw==
Received: from MW4PR03CA0042.namprd03.prod.outlook.com (2603:10b6:303:8e::17)
 by SN7PR12MB8170.namprd12.prod.outlook.com (2603:10b6:806:32c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 11:03:09 +0000
Received: from CO1PEPF000066E9.namprd05.prod.outlook.com
 (2603:10b6:303:8e:cafe::19) by MW4PR03CA0042.outlook.office365.com
 (2603:10b6:303:8e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 11:03:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066E9.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Mon, 27 Apr 2026 11:03:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 04:02:49 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 04:02:49 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 27
 Apr 2026 04:02:44 -0700
From: Edward Srouji <edwards@nvidia.com>
Subject: [PATCH rdma-next v3 0/5] RDMA: Stability and race condition fixes
Date: Mon, 27 Apr 2026 14:02:31 +0300
Message-ID: <20260427-security-bug-fixes-v3-0-4621fa52de0e@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEdC72kC/33NQQ6CMBAF0KuQrh1Dp4DVlfcwLgodYBaAaaGBE
 O5u040xMS5//vw3u/DkmLy4ZbtwFNjzNMagTploejN2BGxjFphjlSsswVOzOJ43qJcOWl7JQ9V
 aahHttZAo4vDlKBVx9xDODgZGWmfxjFXPfp7clt4FmQ7+yUFCDo1WCq9aGovVfQxs2ZybaUhew
 I9R5NVPA6NBpLUsW6NlffkyjuN4AxiNkkMEAQAA
X-Change-ID: 20260325-security-bug-fixes-6fdef22d9412
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Chiara
 Meiohas" <cmeiohas@nvidia.com>, Dennis Dalessandro
	<dennis.dalessandro@cornelisnetworks.com>, Gal Pressman
	<galpress@amazon.com>, Mark Bloch <markb@mellanox.com>, Steve Wise
	<larrystevenwise@gmail.com>, Mark Zhang <markzhang@nvidia.com>, "Neta
 Ostrovsky" <netao@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>, "Doug
 Ledford" <dledford@redhat.com>, Matan Barak <matanb@mellanox.com>,
	<majd@mellanox.com>, Maor Gottlieb <maorg@mellanox.com>
CC: <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Edward
 Srouji" <edwards@nvidia.com>, Michael Guralnik <michaelgur@nvidia.com>,
	"Maher Sanalla" <msanalla@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777287764; l=1877;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=pcU4TcPkPdyT7Zvb+Pr1tsj67bqbvy4jfpAhmnPY9UY=;
 b=86BI1f7UgnfQ8ja1pAuOIAAlhUF+lFBM99Eb21+YRoA5tbybbOwAM2ki/DgnZScOOFY5QWQUx
 9NUI2RJ3ojVAmhFq9TarNz67KwwgqG5OZD3Mfy9AmYHcAYV7cZNJSgq
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E9:EE_|SN7PR12MB8170:EE_
X-MS-Office365-Filtering-Correlation-Id: eed22bbd-d104-4ecc-9dd7-08dea44c911b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|921020|13003099007|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	LvmKwU3zysOyAbn8YU/X3hFAqFEwLTWJB4RbZ8aQzjyOAP6Fxs3bMDNhhnyR6pKEpC/LMrpzb7szuPvovxgVQgt7MLSLG+qa6HA2p/r8NYxD6oL5qEXbC8ypjDsMrcYx+6iE0BrPrK7oyxgWjRY3GQQLAXiPuZWtI5TQPgyajcB0DVAveogNhp/NOyjs4MVIKyndm1sBV4pqMqluFI/w9L9Uf3b9nn86kpYKp7yCxcCUT3LLKYNKKyPhZBtyaCeDs5vd8rvpFOUUZnQR5HMHhONMjQkMXKQj8XTk4ma9L5zqlUIkSSBdAsgh+84MTdfAAKtpmw2ebWk8QY9q9TsqLwM/ARwXdSI5EdGqZI54r9MFlAwksnOw8nIJS/y7tjiL+rRNu3xA4K81klwl5l6w8JACSa8aNgEuBHGC0ovEYXQcrEyJv7foAA/Oya0MQK/TaEdkOFmbBB9AX4AEwsXa7lcNtYGGDHHFsK8HEjtHqkU+6ekONMY0kmceKSTV7k5RJwCFttSFU41mqxl7W3B/Ba0Rtq2wtaxUlH6TtrjZCO0dyqVRcjHcxMAcS5BsqeYLqdd/ONt9NavL+W+t1zBCPzYUm+W6RzpgEadXZu31FD3noEkRzSfREA1kxJyzk0erDUFLDc7M8piFQZFCfRyhSRuZ4T8mRpALHxQgdKR7H40JwHql8TJ9tOaxC7W0mWauxQYlGXq9XGKZbggM5wTd8Bk6cmRk55Ww6GktDYwPNxODaXRdkCUsJRUO7G36HQpngwE5CFtzQ7bVcxFMWMFb/1zliXzgg110OTxc22K2V8IMi3EfbKBmyivjHAA3XbT/YUjN3nei07iLVQZszw7pNg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(921020)(13003099007)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3x+4NjxQ1eFcpglrS5gljpoXetnt42hetxw2LYwo6ncyvTtkzukNpjgZecZuTs+cLfYXo3EBLxRAaAyeXPAG8XgARdxWnxwvwdCIDxQFw3MN9w7TKF8K81/84Mp6AnRPQLx5eB1I7jTAiiOdyoCLGCD9BWwPmcPI2Huy74gQQ1ufgzQS35DwvRr5e0ZKzTkWwo7YIerajj43de6pyfh9fL6gUaTZkrykT3J6yZyl+SFce/dOQQ8/BabckOS2atyaDh7ePCfEdZyFIjffR3pErdTx7IvW1jxt/Q9G2MjCGp3MpjAjENhaK8M7AU7/7UNGPN+aCoKY5dH3s0R8QmpQMNmq70YHNnGAOePgKZ+ETVnbR3LNiutN3bG0O/ZG3O1Pv52Iz9J3pHj5m3zQkvCXt1VOCm16ABeLMqKbNMSle0IHW067i3+ZclwbkfM2MCak
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 11:03:09.0767
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eed22bbd-d104-4ecc-9dd7-08dea44c911b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8170
X-Rspamd-Queue-Id: C1D5447170D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-19576-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,ziepe.ca,nvidia.com,cornelisnetworks.com,amazon.com,mellanox.com,gmail.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

This series addresses several stability issues in RDMA core and the
mlx5 driver.

Patches 1-2 fix xarray race conditions in the mlx5 SRQ and DCT destroy
paths where a concurrent create can reuse the same firmware object
number right after firmware releases it, causing the destroy path to
incorrectly erase the newly created entry.

The remaining patches are independent fixes.

Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
Changes in v3:
- Dropped restrack destroy-ordering fixes (patches 1-6 in v2) to
  rework them in a dedicated series based on code-review feedback
- Rebased onto latest for-next
- Link to v2: https://lore.kernel.org/r/20260406-security-bug-fixes-v2-0-ee8815fa81b7@nvidia.com

Changes in v2:
- Added patch "RDMA/mlx5: Remove raw RSS QP restrack tracking" to
  also suppress broken tracking for raw RSS QPs, which suffer from
  the same silent failures as DCTs
- Link to v1: https://lore.kernel.org/r/20260325-security-bug-fixes-v1-0-c8332981ad26@nvidia.com

---
Edward Srouji (2):
      RDMA/mlx5: Fix UAF in SRQ destroy due to race with create
      RDMA/mlx5: Fix UAF in DCT destroy due to race with create

Maher Sanalla (1):
      IB/core: Fix IPv6 netlink message size in ib_nl_ip_send_msg()

Michael Guralnik (2):
      RDMA/core: Fix rereg_mr use-after-free race
      RDMA/mlx5: Fix null-ptr-deref in Raw Packet QP creation

 drivers/infiniband/core/addr.c       | 2 +-
 drivers/infiniband/core/uverbs_cmd.c | 9 +++++++--
 drivers/infiniband/hw/mlx5/qp.c      | 5 +++++
 drivers/infiniband/hw/mlx5/qpc.c     | 9 ++++++++-
 drivers/infiniband/hw/mlx5/srq_cmd.c | 9 ++++++++-
 5 files changed, 29 insertions(+), 5 deletions(-)
---
base-commit: 9091e3b59f2bef11c0a841096327565ae0ca220b
change-id: 20260325-security-bug-fixes-6fdef22d9412

Best regards,
-- 
Edward Srouji <edwards@nvidia.com>


