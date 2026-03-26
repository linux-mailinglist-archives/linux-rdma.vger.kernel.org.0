Return-Path: <linux-rdma+bounces-18688-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0I6BBkLcxGlf4gQAu9opvQ
	(envelope-from <linux-rdma+bounces-18688-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 08:12:02 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EDE3304B4
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 08:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BAA930F1143
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 07:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483B134EF15;
	Thu, 26 Mar 2026 07:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tt7PQYUO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013069.outbound.protection.outlook.com [40.93.201.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725D11A6805;
	Thu, 26 Mar 2026 07:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774508509; cv=fail; b=C7Xr0kFPzL12IFx/P+9yUL8Wy9Kazii2AwNLxq4XglDAKeUvptwvw9tMorwbGBMZm2BPARAlfZDXFdwttAIJJMcZdvZu50TfM9ikxdZ/H0wdPM8Nq1RuPPOOAFKR1NHs9oONcLKe63UDqbyMmzQW2jlMqVbOOkLZ1LCKB3O4c0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774508509; c=relaxed/simple;
	bh=Pxyg/DMe3xwMGlPNJS0yiUWFKRVMWsCP3+jDKCMTpTg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eli8oAvtLgrnDVaLg4kpS0FmrVfxE4ew5/uW7Q4Nimsr1e7E0rR0sz6Dj9OgZqsPP8qh0yp8VTEyrREQrLz7CkLUk9C4Zte+EjU5vhsHctP+cL/AK+GzY4dsXoCXxdIHponziaJL0dQ10Y2HXRuJOjhdw3D3rWawoQ8GWYfmpyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tt7PQYUO; arc=fail smtp.client-ip=40.93.201.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A+SdVs3PqrJUXym29RYUZjQcnc16xwdrhTG9Jb6iRXDaeR/lEbEDBH1iKbvAnk/0N3iXE19iiH3AhHPsldVCCoA7LQN4EVo3s7oqBgc/bo/rXvT3ghushAocKfhWN/p7B5K4WVl6ejxUbAdtyAZJ9czQeF0Jy2eOLkUlRUeRb9EuKFy4eb7ar+LKK3w7ic2hea/SoQXoDMVKnEZUBDg964lbBwxO0q6QonSS4J+H6cUJVRGCpIm6EA5w3M4Iagj9264VFs0FmHt6ZW6iV+CBPjXVClsb9Ch/vxPGCZFW1uPNRTNY0Zyfn0NFIrfpDlwzigWWbmM+wXl1vlG1C11myQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a8x8qhQtSyTioxc3jdOdQMifjyL8F3ASzcOs84Npm/w=;
 b=h+hPp8Y/T7ktVxlUfBZBZiPteV88r/2fDw8+bnSm3nbp/10eMpwwh27iMis8ZAgMkCw3SJ525P8/hfHVY9dwjI7XxrVjnKmuJU6uiP+5Q2kUo0Lq8fmPBNyOZDZgiGiGuatxa7EO6uQbUjjehIMSnmrFz7zfrx4ZCbXvZZ72bRXmyodMYM1bbb/bPxUlqTHJAPRPWcCkGdc4OU70E7f0lnSN6WF35uHh+3oPsO/NP2DwZRmrrvY8ZvXXD2Ri9PknOZ1qfYTiGLw/1H+fza9MdMVpTX1GszqRzFV52L5xyy7+XicdMoopEWBXZodZIzIPl/nP/4KOiwrksmc1w+nJ9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8x8qhQtSyTioxc3jdOdQMifjyL8F3ASzcOs84Npm/w=;
 b=tt7PQYUOTPHYI+bAIQ/zULbUpMu4NPN6CMz+Fn4NhB1mGnc0nxjfCy2zOPE+tLBNnQcYpbRNcEf2ftDBUB6NLArWoe1aV4KRJ2c0u0D818HNke0l5J71ShwjEBrZTuAdhwyUat99Njw1nzYnTjIGiqrJV2W9q5gtmSuYyvcLgF4K2tqJafojtOFBI5Jpbh5N0eF0Nr3rTCcSCSFXr4xEq+etTF+Ck33b+y/cbCc2Z8kflY0i+Ljr7eRj5hLRXnVrgpEZGRz//icboylUMhf7NtRRGYM/dRitmY9NxuxfI+z+z5mix/a3Q8bLba+o3JZHq6sMXEJkWC3xH5znnUJ9lA==
Received: from BLAPR03CA0021.namprd03.prod.outlook.com (2603:10b6:208:32b::26)
 by LV2PR12MB999072.namprd12.prod.outlook.com (2603:10b6:408:354::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Thu, 26 Mar
 2026 07:01:41 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:208:32b:cafe::46) by BLAPR03CA0021.outlook.office365.com
 (2603:10b6:208:32b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Thu,
 26 Mar 2026 07:01:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 26 Mar 2026 07:01:41 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Mar
 2026 00:01:25 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 26 Mar 2026 00:01:24 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 26 Mar 2026 00:01:14 -0700
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
Subject: [PATCH net-next V9 06/14] devlink: Allow parent dev for rate-set and rate-new
Date: Thu, 26 Mar 2026 08:59:41 +0200
Message-ID: <20260326065949.44058-7-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|LV2PR12MB999072:EE_
X-MS-Office365-Filtering-Correlation-Id: e33e6624-1f11-453e-3688-08de8b0588b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	dMiyaXqcZN0vrgH5R9wOZL1eXEFe5pU5ikzLuoRDFTrW94FD5m7WuLO/FUNsn4HjVfwvSOOkUXIzgfeQWBooXLnN95/jiKwMGxwW/pjwZqfP6qIjC09PvP9PZccMVsHNGN5rAUnDK8lQ/xk3fA7hNxxOwcVuSlsEoUJ8JtlOz5g27YdLxL/XD3kx5O7EbhXf1YIvwPkCzau4Wz7qfoVUoDQ9og5up46FRfrHAHlLGp387SFogqueb/ZZW3/5lHgHlTKRfF2MJwab9/L2ONJe7f3vMRwqKi/t6npz8Zg3I4XLLk1D8kX1L/ESKIQOv9K2nSrWXpv6EdqHcM/Nks4gp12uKOZUoJhf5jRIarFHzvX3yf67tKCJGqEbEwdT7dI/NhnR1N4fBiZrSMLTzcCHHipk0NqRtWdd2b4yA4GdguZKeKpmD+cQ3FGv5kxiNrsKe8wUhY/yCvQESMJxRfqC2NVB8m78oe0eo4vFdkb81qtJyfBgV/v0Uwp5jOcdQSJ5/aR1NIiLRpF3iaj+GLtt275rYeWtOg9xmk3AzrscdU4wIBcssPEfFvgy4kG0CvnB/RHyhxDbfTk/coFnV5TvdUjV5PhKnupGhE24l48QYAg7xOza3kJHwQUnuUL9TzwihnPew8v/NcP8G1NZ/5535rlJr/dAbKayhYwiNS0Alqs2/nxydbKKIB6u7sfuDKQYLnbRW+aec8Lka61ShhAArvo/Je+8m1C6cNvdcsJZsFG2owf8SCRRBSP7D5KUsh1uaH4Mn9kiBcv3XjL61FLmkA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Qc5n/PfKzg2TBuFH7g808Of3DAdHIeyO+Moq7CwMQlTXDzTYOQWycc2HjsSQf8xmehUIqlMt4ezUDQzGKGf5BxEXT8bSwf9R/0ps+ZJc5joC+h2XNTl7hbCD/IajN5htR+AL+cTS2wcFFVGxffkoz0i5MsgSEaAkCcnDltMV1a/V9gmLEsNTo70Ph7FwV72JUEU44sdfnNaLderpyTLlwml7Itle0/qJOPSbf33jOq9CkIZeTpvJq0X5vcGTh7eFt4FOoxf1xQZiaj18NFnF1bRXuR9sBXNciYemF+R69ONCfEHWWGDBHidHlXlRkpGsWBgir43pKgsi3wr5hZt2j1cvAPyTh5/aUs87X8w3Zop1fQj8ajefZhSrC8IOfJ1rcH2K8AfTdOrRSJHdqcuYOOYKFGgF7NgLDg6ihCcrE9LUFpGqjamEjmMX+E69bBwn
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 07:01:41.6496
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e33e6624-1f11-453e-3688-08de8b0588b9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999072
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,resnulli.us,lwn.net,linuxfoundation.org,nvidia.com,oracle.com,intel.com,google.com,davidwei.uk,fomichev.me,iogearbox.net,dama.to,blackwall.org,linux.dev,redhat.com,openvpn.net,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18688-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 72EDE3304B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Cosmin Ratiu <cratiu@nvidia.com>

Currently, a devlink rate's parent device is assumed to be the same as
the one where the devlink rate is created.

This patch changes that to allow rate commands to accept an additional
argument that specifies the parent dev. This will allow devlink rate
groups with leafs from other devices.

Example of the new usage with ynl:

Creating a group on pci/0000:08:00.1 with a parent to an already
existing pci/0000:08:00.1/group1:
./tools/net/ynl/pyynl/cli.py --spec \
Documentation/netlink/specs/devlink.yaml --do rate-new --json '{
    "bus-name": "pci",
    "dev-name": "0000:08:00.1",
    "rate-node-name": "group2",
    "rate-parent-node-name": "group1",
    "parent-dev": {
        "bus-name": "pci",
        "dev-name": "0000:08:00.1"
    }
  }'

Setting the parent of leaf node pci/0000:08:00.1/65537 to
pci/0000:08:00.0/group1:
./tools/net/ynl/pyynl/cli.py --spec \
Documentation/netlink/specs/devlink.yaml --do rate-set --json '{
    "bus-name": "pci",
    "dev-name": "0000:08:00.1",
    "port-index": 65537,
    "parent-dev": {
        "bus-name": "pci",
        "dev-name": "0000:08:00.0"
    },
    "rate-parent-node-name": "group1"
  }'

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 Documentation/netlink/specs/devlink.yaml | 10 +++---
 net/devlink/netlink.c                    | 40 +++++++++++++++++++++++-
 net/devlink/netlink_gen.c                | 24 +++++++++-----
 net/devlink/netlink_gen.h                |  8 +++++
 net/devlink/rate.c                       |  4 ++-
 5 files changed, 72 insertions(+), 14 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 43cc0abf7235..7bf5116fad49 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -2271,8 +2271,8 @@ operations:
       dont-validate: [strict]
       flags: [admin-perm]
       do:
-        pre: devlink-nl-pre-doit
-        post: devlink-nl-post-doit
+        pre: devlink-nl-pre-doit-parent-dev-optional
+        post: devlink-nl-post-doit-parent-dev-optional
         request:
           attributes:
             - bus-name
@@ -2285,6 +2285,7 @@ operations:
             - rate-tx-weight
             - rate-parent-node-name
             - rate-tc-bws
+            - parent-dev
 
     -
       name: rate-new
@@ -2293,8 +2294,8 @@ operations:
       dont-validate: [strict]
       flags: [admin-perm]
       do:
-        pre: devlink-nl-pre-doit
-        post: devlink-nl-post-doit
+        pre: devlink-nl-pre-doit-parent-dev-optional
+        post: devlink-nl-post-doit-parent-dev-optional
         request:
           attributes:
             - bus-name
@@ -2307,6 +2308,7 @@ operations:
             - rate-tx-weight
             - rate-parent-node-name
             - rate-tc-bws
+            - parent-dev
 
     -
       name: rate-del
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 21a34e4d2a49..5425301acab8 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -243,7 +243,29 @@ devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs,
 struct devlink *
 devlink_get_parent_from_attrs_lock(struct net *net, struct nlattr **attrs)
 {
-	return ERR_PTR(-EOPNOTSUPP);
+	unsigned int maxtype = ARRAY_SIZE(devlink_dl_parent_dev_nl_policy) - 1;
+	struct devlink *devlink;
+	struct nlattr **tb;
+	int err;
+
+	if (!attrs[DEVLINK_ATTR_PARENT_DEV])
+		return ERR_PTR(-EINVAL);
+
+	tb = kcalloc(maxtype + 1, sizeof(*tb), GFP_KERNEL);
+	if (!tb)
+		return ERR_PTR(-ENOMEM);
+
+	err = nla_parse_nested(tb, maxtype, attrs[DEVLINK_ATTR_PARENT_DEV],
+			       devlink_dl_parent_dev_nl_policy, NULL);
+	if (err)
+		goto out;
+
+	devlink = devlink_get_from_attrs_lock(net, tb, false);
+	kfree(tb);
+	return devlink;
+out:
+	kfree(tb);
+	return ERR_PTR(err);
 }
 
 static int __devlink_nl_pre_doit(struct sk_buff *skb, struct genl_info *info,
@@ -322,6 +344,14 @@ int devlink_nl_pre_doit_port_optional(const struct genl_split_ops *ops,
 	return __devlink_nl_pre_doit(skb, info, DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT);
 }
 
+int devlink_nl_pre_doit_parent_dev_optional(const struct genl_split_ops *ops,
+					    struct sk_buff *skb,
+					    struct genl_info *info)
+{
+	return __devlink_nl_pre_doit(skb, info,
+				     DEVLINK_NL_FLAG_OPTIONAL_PARENT_DEV);
+}
+
 static void __devlink_nl_post_doit(struct sk_buff *skb, struct genl_info *info,
 				   u8 flags)
 {
@@ -348,6 +378,14 @@ devlink_nl_post_doit_dev_lock(const struct genl_split_ops *ops,
 	__devlink_nl_post_doit(skb, info, DEVLINK_NL_FLAG_NEED_DEV_LOCK);
 }
 
+void
+devlink_nl_post_doit_parent_dev_optional(const struct genl_split_ops *ops,
+					 struct sk_buff *skb,
+					 struct genl_info *info)
+{
+	__devlink_nl_post_doit(skb, info, DEVLINK_NL_FLAG_OPTIONAL_PARENT_DEV);
+}
+
 static int devlink_nl_inst_single_dumpit(struct sk_buff *msg,
 					 struct netlink_callback *cb, int flags,
 					 devlink_nl_dump_one_func_t *dump_one,
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index eb35e80e01d1..999bcc2b4a44 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -44,6 +44,12 @@ devlink_attr_param_type_validate(const struct nlattr *attr,
 }
 
 /* Common nested types */
+const struct nla_policy devlink_dl_parent_dev_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
+	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
+};
+
 const struct nla_policy devlink_dl_port_function_nl_policy[DEVLINK_PORT_FN_ATTR_CAPS + 1] = {
 	[DEVLINK_PORT_FUNCTION_ATTR_HW_ADDR] = { .type = NLA_BINARY, },
 	[DEVLINK_PORT_FN_ATTR_STATE] = NLA_POLICY_MAX(NLA_U8, 1),
@@ -597,7 +603,7 @@ static const struct nla_policy devlink_rate_get_dump_nl_policy[DEVLINK_ATTR_INDE
 };
 
 /* DEVLINK_CMD_RATE_SET - do */
-static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
+static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_PARENT_DEV + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
@@ -608,10 +614,11 @@ static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_INDEX + 1
 	[DEVLINK_ATTR_RATE_TX_WEIGHT] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_RATE_PARENT_NODE_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_RATE_TC_BWS] = NLA_POLICY_NESTED(devlink_dl_rate_tc_bws_nl_policy),
+	[DEVLINK_ATTR_PARENT_DEV] = NLA_POLICY_NESTED(devlink_dl_parent_dev_nl_policy),
 };
 
 /* DEVLINK_CMD_RATE_NEW - do */
-static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
+static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_PARENT_DEV + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
@@ -622,6 +629,7 @@ static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_INDEX + 1
 	[DEVLINK_ATTR_RATE_TX_WEIGHT] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_RATE_PARENT_NODE_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_RATE_TC_BWS] = NLA_POLICY_NESTED(devlink_dl_rate_tc_bws_nl_policy),
+	[DEVLINK_ATTR_PARENT_DEV] = NLA_POLICY_NESTED(devlink_dl_parent_dev_nl_policy),
 };
 
 /* DEVLINK_CMD_RATE_DEL - do */
@@ -1272,21 +1280,21 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 	{
 		.cmd		= DEVLINK_CMD_RATE_SET,
 		.validate	= GENL_DONT_VALIDATE_STRICT,
-		.pre_doit	= devlink_nl_pre_doit,
+		.pre_doit	= devlink_nl_pre_doit_parent_dev_optional,
 		.doit		= devlink_nl_rate_set_doit,
-		.post_doit	= devlink_nl_post_doit,
+		.post_doit	= devlink_nl_post_doit_parent_dev_optional,
 		.policy		= devlink_rate_set_nl_policy,
-		.maxattr	= DEVLINK_ATTR_INDEX,
+		.maxattr	= DEVLINK_ATTR_PARENT_DEV,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
 		.cmd		= DEVLINK_CMD_RATE_NEW,
 		.validate	= GENL_DONT_VALIDATE_STRICT,
-		.pre_doit	= devlink_nl_pre_doit,
+		.pre_doit	= devlink_nl_pre_doit_parent_dev_optional,
 		.doit		= devlink_nl_rate_new_doit,
-		.post_doit	= devlink_nl_post_doit,
+		.post_doit	= devlink_nl_post_doit_parent_dev_optional,
 		.policy		= devlink_rate_new_nl_policy,
-		.maxattr	= DEVLINK_ATTR_INDEX,
+		.maxattr	= DEVLINK_ATTR_PARENT_DEV,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
diff --git a/net/devlink/netlink_gen.h b/net/devlink/netlink_gen.h
index 2817d53a0eba..e16615aaa03f 100644
--- a/net/devlink/netlink_gen.h
+++ b/net/devlink/netlink_gen.h
@@ -13,6 +13,7 @@
 #include <uapi/linux/devlink.h>
 
 /* Common nested types */
+extern const struct nla_policy devlink_dl_parent_dev_nl_policy[DEVLINK_ATTR_INDEX + 1];
 extern const struct nla_policy devlink_dl_port_function_nl_policy[DEVLINK_PORT_FN_ATTR_CAPS + 1];
 extern const struct nla_policy devlink_dl_rate_tc_bws_nl_policy[DEVLINK_RATE_TC_ATTR_BW + 1];
 extern const struct nla_policy devlink_dl_selftest_id_nl_policy[DEVLINK_ATTR_SELFTEST_ID_FLASH + 1];
@@ -29,12 +30,19 @@ int devlink_nl_pre_doit_dev_lock(const struct genl_split_ops *ops,
 int devlink_nl_pre_doit_port_optional(const struct genl_split_ops *ops,
 				      struct sk_buff *skb,
 				      struct genl_info *info);
+int devlink_nl_pre_doit_parent_dev_optional(const struct genl_split_ops *ops,
+					    struct sk_buff *skb,
+					    struct genl_info *info);
 void
 devlink_nl_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 		     struct genl_info *info);
 void
 devlink_nl_post_doit_dev_lock(const struct genl_split_ops *ops,
 			      struct sk_buff *skb, struct genl_info *info);
+void
+devlink_nl_post_doit_parent_dev_optional(const struct genl_split_ops *ops,
+					 struct sk_buff *skb,
+					 struct genl_info *info);
 
 int devlink_nl_get_doit(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
diff --git a/net/devlink/rate.c b/net/devlink/rate.c
index 9ebbc72130c6..1949746fab29 100644
--- a/net/devlink/rate.c
+++ b/net/devlink/rate.c
@@ -655,9 +655,11 @@ int devlink_nl_rate_set_doit(struct sk_buff *skb, struct genl_info *info)
 
 int devlink_nl_rate_new_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink *rate_devlink, *devlink = devlink_nl_ctx(info)->devlink;
+	struct devlink_nl_ctx *ctx = devlink_nl_ctx(info);
+	struct devlink *devlink = ctx->devlink;
 	struct devlink_rate *rate_node;
 	const struct devlink_ops *ops;
+	struct devlink *rate_devlink;
 	int err;
 
 	ops = devlink->ops;
-- 
2.44.0


