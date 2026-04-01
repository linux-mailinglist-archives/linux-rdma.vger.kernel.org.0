Return-Path: <linux-rdma+bounces-18913-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFVjM31rzWkkdQYAu9opvQ
	(envelope-from <linux-rdma+bounces-18913-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 21:01:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3511537F944
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 21:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5199030A10A6
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Apr 2026 18:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A69E47CC74;
	Wed,  1 Apr 2026 18:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e8DVbqyN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010033.outbound.protection.outlook.com [52.101.193.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA70526E711;
	Wed,  1 Apr 2026 18:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775069478; cv=fail; b=IqMCd0P/nVa1+xqKlXWBHhdfGBO4sL4fAjrRWuJlHheSIvyhA3DgpOhdUwcPugEHqb231+l5O2wsuhyLAiAnEM8wfDSGUbmZ4kGto+UAujBfhGry+YA5/3NT4vAlb4ennrsoAzW7v5vJq5J1QfTNB3LOP0xue3sjMYfkP+IAujo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775069478; c=relaxed/simple;
	bh=N+o4L9iMGp3b8ioiRRoL5M0PpKBHw+TELUz8AUOVeIk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i3S0UKlA7bv4yOWma0SrqvuwNeTKoUDeK0VjLKk9ajJSgM+GHmIzwPyBji78ftno/iJ+9TCk9PqlJodPv5YPp2699puIC+fx8vEBS9WrcTG3tYrMNhjrzfpBy4I2rsCThWzDE7v7wUsJKmi/+sxbsbH9rBTSi6jHQpXaKmmzXwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e8DVbqyN; arc=fail smtp.client-ip=52.101.193.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IUFbcghjnMBZdKGWSGhefAnT5McgrqcsuayQzfMC0TCjfPdB5YJ2MbJ0tfIPhRsis6XRB67ix4gavG4H+9bykg/IOhufeopnEwNZs7GetJ3XzYeCQSvcUtbEaCphZgWM6XLydmzFDgVKyTQTIGf/OgYqQRPL2lOjgMfwev85N+LQWrdg6AK2aX+ViNRx9GnFi7TiW1dhGpz8bzwML1eAQmyy5b3atSeWLO+pJ00h4bH6JRnbuxzDAK9Pok30jcOIk+NV5dfLGvf4UppOeJsaz+IsVnlyloqfzgc7c7naxhA9mij3I0BPg2Y3TkMI8KhvTls7Qt9Y+j/k6u2smy1pJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZxyqQA0ObwR48EcEw5sW1/9ZlBoyRj+hAe2CzzlRx3E=;
 b=S1PrhnTOPMVljRAwlS8NjhAh6p6qLOft0fMqqTz47qa26Wp0XaXdBydNkcYe6xn++n0CXjApwZLjHqkylSOlYgrV9MskF/dY4/p/CZe4BJUepHZsJk1/Fz3NbO9uM99JfodSMDASphGnoDtViOfY3BPtZmvMQXEXkFKZ7UGTRdSgWUzuJ50DLkb5VP9Ehe1TkpnwPvXz+8FeTYIDeHpuIOk/HFFu99SxE4GTOfriscfqcyYf3wJBGCY0aNJr4N/8flL8vYkK4R5DZjm9ckYcbP2darL4HOkpqz3QdjfTa87F5TOumyvFX6mi5TbduLIH1KOVEHOR7b88gc5WeMpTdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxyqQA0ObwR48EcEw5sW1/9ZlBoyRj+hAe2CzzlRx3E=;
 b=e8DVbqyNaeeWu95nc2olYXJEou6qYoCwLIt3Op8Gj5Z94HhxC/vyOqMpftHHvZNnXV/SQ1MvT80cplpvS+06/x2+3pHSoJfWr+7dSUiD/57YbzjkKNmuE9wziFhfB6VHjuZ9pql8wQ0RRnMy3mD70JWV2KNq4IV3E7Ai3m9L95nSPICqUoPev7FgJj4hVKEhZMDhAHCqUFzPMnT++zRG/j+m05OQyZSXP8Y2N64QHl0U9uLABwV3K/cOXgCeUZkbIF2t+Ujhirdi3O5POzagvLbjkVKynKPHUif/td6KN/y4iOl2m37Vg8dUb0FbNN1pOfc72YmVX7ba2D9N6B62bA==
Received: from SJ0PR05CA0156.namprd05.prod.outlook.com (2603:10b6:a03:339::11)
 by PH7PR12MB6980.namprd12.prod.outlook.com (2603:10b6:510:1ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 18:51:11 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::4) by SJ0PR05CA0156.outlook.office365.com
 (2603:10b6:a03:339::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.16 via Frontend Transport; Wed,
 1 Apr 2026 18:51:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 18:51:10 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 11:50:48 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 11:50:48 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 1 Apr
 2026 11:50:39 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>, Chuck Lever
	<chuck.lever@oracle.com>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Carolina Jubran <cjubran@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
	Shahar Shitrit <shshitrit@nvidia.com>, Daniel Zahka <daniel.zahka@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>, Cosmin Ratiu <cratiu@nvidia.com>,
	Parav Pandit <parav@nvidia.com>, Shay Drori <shayd@nvidia.com>, "Adithya
 Jayachandran" <ajayachandra@nvidia.com>, Kees Cook <kees@kernel.org>, "Daniel
 Jurgens" <danielj@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next V4 03/12] net/mlx5: Register SF resource on PF port representor
Date: Wed, 1 Apr 2026 21:49:38 +0300
Message-ID: <20260401184947.135205-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260401184947.135205-1-tariqt@nvidia.com>
References: <20260401184947.135205-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|PH7PR12MB6980:EE_
X-MS-Office365-Filtering-Correlation-Id: fa6923f6-eeb2-49ae-2cdb-08de901fa47a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	tB2bPhcWlKveS3IO7H0S5XXebT/B4JnZ5hMTCpOGXc25GcWOxIaSvW7HOMCjFp31WPzfFj65ygvrOLhudFxlZyme03riU7mI1TswShVbiqzdsPNwJp1CtsPSBYMGYjZZzYlyMbHb2kiUrpltr6cf+Ui9xiViZ8j1ou+K63ChoQzTy3Ww++EwgWAEHJI4SWxnH27v+9VSqsD7cZFhrHG33/UE1JouAGtf8EpTOmtj1MGZ977+V6f7sObJbLmAtvF5LXm5C3D+UOV8H7wNoIlWX1KjYHRPEMqTAwTvpiTxeqlLX5Jz+p30FKrL0cdMaq5wx1lh7RhmsGmHSP3YuZ2mtbdNXomdT4wN2AMhlX3FR+Jz2OPGiJfuhNJmICL8YWaxWY42PzMPmbaGuKkuuVyXWfVwx8/kmzWnvLMBWjVgGn/muY6ukFJLYPCTuT5pNjhy8vUHsat3wDtQWahVd1/XMBXTaJra0KVAW7Y/94s43Vqxl9pZiWiI/D/c+z+h6zRw9Uw+i2ltaiyVqxUntViuHxesrKP8PjTdxmrXVttxiB+fabIiaBZGVmgxKq9Zy4asA9tkaZpsb0M/QieFk8zwhPb/2a/+k4M5CQlpjM9yxUfz9G1DiEiaV1o2wPL3Zo5eXreihTgzwATnCP5/WE+eDulc+4g/pub/r1n9TytcmSHVC9ag5JlcfVYnU4i9SZp7xfFhoKCZm4GYltWy9agNX4Mll+1JP0faXVychVhKzncvh/StO/+5WsqJ3z/LYsGOOF3gKeM2Gk7FJ8Bx8os/Tw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(7416014)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lf4jnekxWlESaTokMMdi+1uoaW4m8OJpSlqkvv2iXDTQmA4QFBXmgZZkAeeTM8P/sDOCMLim6mI7JQuRFzwPFS6eUUrsnr2uZzH5xIRZzxs0iA9zSHKOpUSPjG18M3mUrMtUpvgvHDs8uED15BWG7aOs69Tx9O9V3bR7hsWvYqzzlZB52IfG0GzW6k21DPT+wLLlL8HI7eL6CdoW6xQTYKdwmeUsX449CmXE8uyyoRmatLQSxNprWu8yXLNCRP5gjXFpFMmQN+kReZzxsL8AOn8qOooM/SnnMULxvePrNuIBWFT2QFBE6DXwjboPEI/C++ZS31W28MTscCLcgKXwLQjnx1Q2UvOdFhNJxk1TQjIFwDYj/h7JHStoCTBDe7hVTJ5x61Rqlye0rUGJQ93EyS2vvb9fqpmaWwZl0/oI+2m/jWf/FpG4AB3Wn+PWsLxV
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 18:51:10.9639
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa6923f6-eeb2-49ae-2cdb-08de901fa47a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6980
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,resnulli.us,lwn.net,linuxfoundation.org,nvidia.com,oracle.com,intel.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[37];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18913-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 3511537F944
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Or Har-Toov <ohartoov@nvidia.com>

The device-level "resource show" displays max_local_SFs and
max_external_SFs without indicating which port each resource belongs
to. Users cannot determine the controller number and pfnum associated
with each SF pool.

Register max_SFs resource on the host PF representor port to expose
per-port SF limits. Users can correlate the port resource with the
controller number and pfnum shown in 'devlink port show'.

Future patches will introduce an ECPF that manages multiple PFs,
where each PF has its own SF pool.

Example usage:

  $ devlink resource show pci/0000:03:00.0/196608
  pci/0000:03:00.0/196608:
    name max_SFs size 20 unit entry

  $ devlink port show pci/0000:03:00.0/196608
  pci/0000:03:00.0/196608: type eth netdev pf0hpf flavour pcipf
    controller 1 pfnum 0 external true splittable false
    function:
      hw_addr b8:3f:d2:e1:8f:dc roce enable max_io_eqs 120

We can create up to 20 SFs over devlink port pci/0000:03:00.0/196608,
with pfnum 0 and controller 1.

Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Reviewed-by: Shay Drori <shayd@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/devlink.h |  4 ++
 .../mellanox/mlx5/core/esw/devlink_port.c     | 37 +++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.h b/drivers/net/ethernet/mellanox/mlx5/core/devlink.h
index 43b9bf8829cf..4fbb3926a3e5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.h
@@ -14,6 +14,10 @@ enum mlx5_devlink_resource_id {
 	MLX5_ID_RES_MAX = __MLX5_ID_RES_MAX - 1,
 };
 
+enum mlx5_devlink_port_resource_id {
+	MLX5_DL_PORT_RES_MAX_SFS = 1,
+};
+
 enum mlx5_devlink_param_id {
 	MLX5_DEVLINK_PARAM_ID_BASE = DEVLINK_PARAM_GENERIC_ID_MAX,
 	MLX5_DEVLINK_PARAM_ID_FLOW_STEERING_MODE,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
index 8bffba85f21f..e1d11326af1b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
@@ -3,6 +3,7 @@
 
 #include <linux/mlx5/driver.h>
 #include "eswitch.h"
+#include "devlink.h"
 
 static void
 mlx5_esw_get_port_parent_id(struct mlx5_core_dev *dev, struct netdev_phys_item_id *ppid)
@@ -158,6 +159,32 @@ static const struct devlink_port_ops mlx5_esw_dl_sf_port_ops = {
 	.port_fn_max_io_eqs_set = mlx5_devlink_port_fn_max_io_eqs_set,
 };
 
+static int mlx5_esw_devlink_port_res_register(struct mlx5_eswitch *esw,
+					      struct devlink_port *dl_port)
+{
+	struct devlink_resource_size_params size_params;
+	struct mlx5_core_dev *dev = esw->dev;
+	u16 max_sfs, sf_base_id;
+	int err;
+
+	err = mlx5_esw_sf_max_hpf_functions(dev, &max_sfs, &sf_base_id);
+	if (err)
+		return err;
+
+	devlink_resource_size_params_init(&size_params, max_sfs, max_sfs, 1,
+					  DEVLINK_RESOURCE_UNIT_ENTRY);
+
+	return devl_port_resource_register(dl_port, "max_SFs", max_sfs,
+					   MLX5_DL_PORT_RES_MAX_SFS,
+					   DEVLINK_RESOURCE_ID_PARENT_TOP,
+					   &size_params);
+}
+
+static void mlx5_esw_devlink_port_res_unregister(struct devlink_port *dl_port)
+{
+	devl_port_resources_unregister(dl_port);
+}
+
 int mlx5_esw_offloads_devlink_port_register(struct mlx5_eswitch *esw, struct mlx5_vport *vport)
 {
 	struct mlx5_core_dev *dev = esw->dev;
@@ -189,6 +216,15 @@ int mlx5_esw_offloads_devlink_port_register(struct mlx5_eswitch *esw, struct mlx
 	if (err)
 		goto rate_err;
 
+	if (vport_num == MLX5_VPORT_PF) {
+		err = mlx5_esw_devlink_port_res_register(esw,
+							 &dl_port->dl_port);
+		if (err)
+			mlx5_core_dbg(dev,
+				      "Failed to register port resources: %d\n",
+				       err);
+	}
+
 	return 0;
 
 rate_err:
@@ -203,6 +239,7 @@ void mlx5_esw_offloads_devlink_port_unregister(struct mlx5_vport *vport)
 	if (!vport->dl_port)
 		return;
 	dl_port = vport->dl_port;
+	mlx5_esw_devlink_port_res_unregister(&dl_port->dl_port);
 
 	mlx5_esw_qos_vport_update_parent(vport, NULL, NULL);
 	devl_rate_leaf_destroy(&dl_port->dl_port);
-- 
2.44.0


