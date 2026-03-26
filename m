Return-Path: <linux-rdma+bounces-18696-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UM+dJJ3bxGkq4gQAu9opvQ
	(envelope-from <linux-rdma+bounces-18696-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 08:09:17 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2446D33040D
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 08:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B2D3310010C
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 07:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C103AE6E1;
	Thu, 26 Mar 2026 07:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l/uzhvE0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012070.outbound.protection.outlook.com [40.107.209.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDE43B4EB5;
	Thu, 26 Mar 2026 07:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774508590; cv=fail; b=K4wOY5q5FZFjWj6i9HSqwswnR9kI2/2CE+Tqjih13uq1AvWXTbR7AjGBwdyZ0yjL+hDvMIynF81iN7vfFwyDlXpevAKZKRRrIv0Zsj7GZM9sh9wvTawYuWKhLvCVHD7RVVQFSieNe10gIoKIFDe364OZdjp/MoL9kIDFmEJccCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774508590; c=relaxed/simple;
	bh=4eeUc9RIHIgWXag318UGpUedrMXCEQ+cUkvCB4gfNTs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VLV5pBgmsv2IOjEH/ndYH1fVYT3roU+oSsnFKlrmUqGOMQivQyUaxnCeBNq0qRD4zLUa7dBVzdXCugxLgXkBOvzK6WAojugw6FvhlkWkYfPO/3672U/V2kdMAhdX/GHBJ0VLwo07Do5or9gMxTtjFxnpmsVqZn09FOlbJvMiTY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l/uzhvE0; arc=fail smtp.client-ip=40.107.209.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NsfXJanppJp8j/SyXkmwfsud5a49//235gYHuJYXt/FmjjJLdR4MrGXZj/mTNXVXKHrZKhIRngYzNNNOnz28YEabYtZYkflDk1T23rQPeKILXePBvAJUqNGjm+HLec2L1KiSvA+PaIjpcvKxuLPbLrvpBE8fpPqoE1WiYMYV7rVF9qzJ3diWp7UR85pWExpl5VRLDjbR4DiZ5WR+iRVqc8b2hGfDyGjN5M9aWapJPHjC70mdTrVCR7nki4oUJHaR+A1F4R/rWExYKkThWhRzblRT8zNnnHA7By8pWKplAnZIE2NBH+v5oId8GCl5wv6uEOPff2/b+klL4nxJpHck3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2unoNL8G4Xxr5VtprXpzS1NFU/fJvHFzPSMcT54g87Y=;
 b=DcdJjvPMDsBZexf99JwebnMQj8MRuR0gmG+zOuEUPuXmY/ifvunG5AIuXk4V2jNYD+ND5+0ymN8dA1QZA/5rEzrbavvNXQ5mg3W/GS/uFXWoHhMbKvRXmcJXHIt6aINhk4ddfHNNxQymhu9tskbWXAJPH1nyqavPWaL8HNTEXraXS73xSmm6SDZPFImjDfBLM1fPHg6CfEC4Aq9YqhWQvSfxUW8GTOkln29Yt8LYIFGbcvfC1OrWGNd5YEOZpxix7pdMKGmZzpFVlRYgs/5+1xSiY29ZMsk7FIRBauxJ80JB0z6jB48ZcnTLrywqcHRJEQYN2a0rQLq2ovwl0svWHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2unoNL8G4Xxr5VtprXpzS1NFU/fJvHFzPSMcT54g87Y=;
 b=l/uzhvE0ZuM56l5dCnvRL19eTaWFJDC9F73n7wgV6xSTbvSd+3MtoxD2FzzCzdsyv2Osqv4FNQe3Juy2iCb8thixSQNiyHMRcRgboYozLt1NCexMebTIoT2c2TAHehMhsbJgotap2XIetVg7d4y7QmVReTztDjW3zEo0BHi0HVn0uU9qpM4v0G1vpBSyb+TtKQCYuMRvcbjZC7XHwxuGCOJ/keKvWZD4zneyOnFYawS1pHwgh824H4iUyS8vFq0voJ4GKv0x78i598SeatDJVDAKEFXY0H4OgdafZd9woeL9sySoWVORu/eoEqXZxbDSIXUuCSTaH/vGIOoqYRffJg==
Received: from BN0PR04CA0010.namprd04.prod.outlook.com (2603:10b6:408:ee::15)
 by BY5PR12MB4131.namprd12.prod.outlook.com (2603:10b6:a03:212::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Thu, 26 Mar
 2026 07:03:02 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:408:ee:cafe::52) by BN0PR04CA0010.outlook.office365.com
 (2603:10b6:408:ee::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.33 via Frontend Transport; Thu,
 26 Mar 2026 07:03:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 07:03:01 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Mar
 2026 00:02:53 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 26 Mar 2026 00:02:52 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 26 Mar 2026 00:02:42 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Donald Hunter <donald.hunter@gmail.com>, Simon Horman <horms@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>, Chuck Lever
	<chuck.lever@oracle.com>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>, Jacob Keller
	<jacob.e.keller@intel.com>, Shahar Shitrit <shshitrit@nvidia.com>, "Daniel
 Zahka" <daniel.zahka@gmail.com>, Parav Pandit <parav@nvidia.com>, "Adithya
 Jayachandran" <ajayachandra@nvidia.com>, Kees Cook <kees@kernel.org>, "Shay
 Drori" <shayd@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Willem de Bruijn <willemb@google.com>, David Wei
	<dw@davidwei.uk>, Petr Machata <petrm@nvidia.com>, Stanislav Fomichev
	<sdf@fomichev.me>, Daniel Borkmann <daniel@iogearbox.net>, Joe Damato
	<joe@dama.to>, Nikolay Aleksandrov <razor@blackwall.org>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, "Michael S. Tsirkin" <mst@redhat.com>, "Antonio
 Quartulli" <antonio@openvpn.net>, Allison Henderson
	<allison.henderson@oracle.com>, Bui Quang Minh <minhquangbui99@gmail.com>,
	Nimrod Oren <noren@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next V9 14/14] net/mlx5: Document devlink rates
Date: Thu, 26 Mar 2026 08:59:49 +0200
Message-ID: <20260326065949.44058-15-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260326065949.44058-1-tariqt@nvidia.com>
References: <20260326065949.44058-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|BY5PR12MB4131:EE_
X-MS-Office365-Filtering-Correlation-Id: cc76f1b5-2d45-4ad4-4655-08de8b05b826
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ovPVwxk/ZnQYDDVYrcv6VbD+PynDmDxmQip2nPLVTPoiIqMyDa/tqWjA9V31ulXbpLQIKdCRcZcb4t8X26yXuobS7wFNjYZAwkc2K8kdLJfvl85epazGrWyeNZg8kqHkvwbUc2NK2HGF7G5d1Ri1zD7n19fYHqK1jOpAOXrzvfe0CBs0SPxW7J6FTs3GZ4Vmg8v47d+T3PQVtImfvs0xzVp/2KlPDxSpMlA59lVMNavoDou1uHC6f4eonXrlM+2aEWwY3NZpuI5OSX2wlSfQ2imM7IW53Pqtb0WtFwXiouXFi2yvZTurF4vFSYHKB545PVOqdhGBVZ+p5v6nVlHRt1aczIjSsA49qL5A6CI0InZnG7+kFExgTeUYW8t3XHG+6JvUr5iyILtYf5ItkVnPqkc6IKdTttsOhqU7xhrqWVH+AaKqVp6OOcgnwdOOwSjNZSruqFnNZOGR8xn1DNL39fxccXLelIZw3BzEx/BKQ55Oq0aBSEwbC5v06YoVsGk82lTHhmawRkJnAzWSdlZ9Gdy4PtMnPLOC5vHLIT4rmT00uBqf5ANyTBZZKcz7lxXtYvxSPE97fYpOLPTZFco7mkZ3UxExlhZHSKrTu8oKskPura07R5lqwt687s8qdv6yyrukYgFDOMJrAsc6frj0Ux29gJudpkgSdrkve8XTfofZGN5mAYVXPrDtwA4MHYPXtWtoMpW5i9bACSiFvLYHeYY+xkgbsZVZhtdeoXmoq1H8prtiXngxxBI0tbCTFrsaH9XPLAo0WHw3Xix6fkLFxw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VDhU6Ehv6fNYizwKz3ycwBNoUD+rxPrJDaabZYFuXbQ7/a1PyEG40r2QPecpJR+7YOs5EsRcIJpw9i/xOme5blaXNJXx8uFV4SCznCG/dxopoh7GoUJOqJ91Ro8HzGTQl4bplB8UfvD4jqPJxeomSz3PY5ZNfIEJqC+QzGTMjWaf3AVsMutP5VWaQvBeZfq7+NHqzyqsTUxR3pO4tV9qloIUROPmgTMync4GJoZnpUljCuO+tlRStM8bG6VgaeDoDZotGKsw8PhfxHyebHwG0buClPrW1Xj23Bq8mZvX5vZnr1SCvPJu7KN7txSI/1QXqYBoqb2GXV71ihQZO3MNZKIekqesU9rQxINL9JR1Pz58KdT/4xZkk5R/KxyK8mkQ1byalBroHwoDUm+1BIeMTaqM7b3z85KE8q4GX87P8vmOTVHPQ+sZVFXvn6rdN/mU
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 07:03:01.2209
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc76f1b5-2d45-4ad4-4655-08de8b05b826
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4131
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,resnulli.us,lwn.net,linuxfoundation.org,nvidia.com,oracle.com,intel.com,google.com,davidwei.uk,fomichev.me,iogearbox.net,dama.to,blackwall.org,linux.dev,redhat.com,openvpn.net,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18696-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 2446D33040D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Cosmin Ratiu <cratiu@nvidia.com>

It seems rates were not documented in the mlx5-specific file, so add
examples on how to limit VFs and groups and also provide an example of
the intended way to achieve cross-esw scheduling.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 Documentation/networking/devlink/mlx5.rst | 33 +++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/Documentation/networking/devlink/mlx5.rst b/Documentation/networking/devlink/mlx5.rst
index 4bba4d780a4a..62c4d7bf0877 100644
--- a/Documentation/networking/devlink/mlx5.rst
+++ b/Documentation/networking/devlink/mlx5.rst
@@ -419,3 +419,36 @@ User commands examples:
 
 .. note::
    This command can run over all interfaces such as PF/VF and representor ports.
+
+Rates
+=====
+
+mlx5 devices can limit transmission of individual VFs or a group of them via
+the devlink-rate API in switchdev mode.
+
+User commands examples:
+
+- Print the existing rates::
+
+    $ devlink port function rate show
+
+- Set a max tx limit on traffic from VF0::
+
+    $ devlink port function rate set pci/0000:82:00.0/1 tx_max 10Gbit
+
+- Create a rate group with a max tx limit and adding two VFs to it::
+
+    $ devlink port function rate add pci/0000:82:00.0/group1 tx_max 10Gbit
+    $ devlink port function rate set pci/0000:82:00.0/1 parent group1
+    $ devlink port function rate set pci/0000:82:00.0/2 parent group1
+
+- Same scenario, with a min guarantee of 20% of the bandwidth for the first VFs::
+
+    $ devlink port function rate add pci/0000:82:00.0/group1 tx_max 10Gbit
+    $ devlink port function rate set pci/0000:82:00.0/1 parent group1 tx_share 2Gbit
+    $ devlink port function rate set pci/0000:82:00.0/2 parent group1
+
+- Cross-device scheduling::
+
+    $ devlink port function rate add pci/0000:82:00.0/group1 tx_max 10Gbit
+    $ devlink port function rate set pci/0000:82:00.1/32769 parent pci/0000:82:00.0/group1
-- 
2.44.0


