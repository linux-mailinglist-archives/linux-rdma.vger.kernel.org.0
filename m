Return-Path: <linux-rdma+bounces-16410-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNQID9afgWkoIAMAu9opvQ
	(envelope-from <linux-rdma+bounces-16410-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 08:12:22 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 266A8D592C
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 08:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3977E30257FB
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 07:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFF63921E4;
	Tue,  3 Feb 2026 07:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d1De2J9w"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010040.outbound.protection.outlook.com [52.101.193.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E615F3921C5;
	Tue,  3 Feb 2026 07:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770102707; cv=fail; b=ZoD9Gd1XXlYaFhYzAwYsXpV0svmKFFWJ6iO29zyqItNrMvB4vU2wiokWHz/6Mr+U4jdWcac458Y4sxWuExAJ41gAwLOt9ML/J81hLs01LNnnnbYXxj58YpOCEsZEuF0mXVJ7c9JZRrhua6bauIdhI5tTZhwbTfcsHMAvU5pItdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770102707; c=relaxed/simple;
	bh=rHtIcE5zK+CnxWJsFlNj47+idUSnzobEstb1nHGkwgk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WISrNxqnW6ox0CTYGOIzbFEEf7v8zevfflWfi/cQV6Oze/ySKUNWd/vSIU2I92Mq8GOT8OkqZWoPYnOYixsiWch5RdoKLdqq8r0oduQ/2TC2eFsHjqSP43Or9EWwNEEvyh9l2ngvPwplISM+br0wH57FPE8jNdN8SKp/agHL6hA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d1De2J9w; arc=fail smtp.client-ip=52.101.193.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NpvJOXig+VFsqWRsgNguPzVBEVLx3ZqCg9sOnWedXa6S4a05egtA94dNQ8tBtVWOy513xIGkeoODFmy+jdlmOnF565ul3jqAyd0wpoo/MgUOm3qU5EP9i6CiUuWvaXaDREXgzclSC+SDFjJhTfMlqi7XofdHzw8+Mj08tiz6PNV/WrcFpZMGfGoNLOAGWDcneNU3934odB3n62BW7kBTL1TR+fiukydMNrg3UFEq7z1o33/C6rld5pPkdWFaeiJicAitEsT163HMb3Pdw9VsHbfq4g7zRp3dXyl9TPmMEwn9t+ct/mTN7X8NOQwQAcelyWAQ0JkkGCINihHdkpxzeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vrAeCkdFP6Ljc9myCwPEtBqQPE+DeCrmDhWpH9FapHs=;
 b=j33NmEtdaMQWL7hHe0VGZ8bic6GgU2bcFY/dpZSz5T25BMbhPDFUQ89W2kIDoy9Rz4EkWRTsEKDUBtxkawxs/S1XWYxd3Ow/4Ky7sIAFXbDvIUh8HOuvbeY3lkQxrwaJOcMdrnr6G2n8BmqR0TbJH0eda43iCBFs040PSfPJMrfBMGK0ggJ/dEolMBwwgoJeKlli4ZiORI5BDyheaZ/pgscR/I0/LemU+0xR7PBGdUXv8jMEQyOUzx2/4sJK904VVsQUwQonkJ098+M1bSrC8bhhoadnkzq0yhK1dx4atWJxm4Qf7PKAwDnh3D5SAdrYcQnN7P0Juo0cZ9DG8MhdCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrAeCkdFP6Ljc9myCwPEtBqQPE+DeCrmDhWpH9FapHs=;
 b=d1De2J9wptIn3rFITWqfx9eDnYc44I3P+73rHt6R0UBRIlLiW1raZU23QrudiYfcnFAvlDdl2MT9SIVGlqIqFyewxcTXJM9xB9bkl8jSgdONelOqD8F5cPypLkNrXdUyzzoOCp2ncd9he0cbnvX+n80+i/hXuywwpCg2tx11PRKCE8iaJHkuRMA+ZSCkVzXp7xuB3syRJo4KtI89cCbKEq3L2rhhZrGzcvKLbLkp2M1bkcUP73FKb7e/vzYw69h7V6E5kZ0xQOd5H3akljyetNtmRRSMbpq0gblqGcreO45oFwzE6EyAtKm+jXTIChkP0W0gUXr4tNg6YaOYpcwE1A==
Received: from DM5PR07CA0120.namprd07.prod.outlook.com (2603:10b6:4:ae::49) by
 SJ2PR12MB8012.namprd12.prod.outlook.com (2603:10b6:a03:4c7::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.16; Tue, 3 Feb 2026 07:11:40 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:4:ae:cafe::c7) by DM5PR07CA0120.outlook.office365.com
 (2603:10b6:4:ae::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 07:11:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 07:11:39 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 23:11:21 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 23:11:20 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 2 Feb
 2026 23:11:15 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Shay Drori
	<shayd@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Or Har-Toov
	<ohartoov@nvidia.com>
Subject: [PATCH net-next 2/5] net/mlx5: Register SF resource on PF port representor
Date: Tue, 3 Feb 2026 09:10:30 +0200
Message-ID: <20260203071033.1709445-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260203071033.1709445-1-tariqt@nvidia.com>
References: <20260203071033.1709445-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|SJ2PR12MB8012:EE_
X-MS-Office365-Filtering-Correlation-Id: 74e56165-536a-4c8f-d6f6-08de62f37a43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SX3H291jaw0sJRqeFPGiqgVI7liLo0QIBmlnrSne8v+wewHbPlka6te0MILh?=
 =?us-ascii?Q?ELOobtvmtJcGqo2C9JNlVM1He1rcdvsZw10nySa2C67eGBS3zYo5uHA+vVXN?=
 =?us-ascii?Q?1Ba0h4R9q38ke40oHdx/XMHXymjqTZjnCZwMzJOw0NIdYGykCxwpMn2KNlQQ?=
 =?us-ascii?Q?IjF24bVwDSCHLyRlOOLM9A4CS454oVzXbrH90G0D72D0tCScXnvi1XdqPeBA?=
 =?us-ascii?Q?GEh3AeFtkt823Abw39iENqpPX4V34yKtcJvYuYCEtJ5hmK0zGdgNOwtRp6hM?=
 =?us-ascii?Q?uHoovVzOPwfyxsopUulPll+7MuWCen950c3XmkYMc448+lVrJCcse1IsxYrn?=
 =?us-ascii?Q?eGv15RKR/kRmbtBhjJmOItOhqL1BzGunMh3USDmGFgXFIY94b4HgArVdjtLd?=
 =?us-ascii?Q?3z0W/+6ZzHsQR6SWZ91wq3GaGQzl1E6K959BwocTA4P0e4oFWnJNKyWiooEf?=
 =?us-ascii?Q?qzqc2ozvTMNVngFKMihWdFF1jNaOC+GhysDmB30zjfZhQar2qAf4CJqUwIB2?=
 =?us-ascii?Q?2dsn8d18TJrOdynqq2D2ep/m55khjkC1MMc/tz8VwVlVXx6irQrOSI1mywni?=
 =?us-ascii?Q?uXtRMPHBo5iXsolgLiXha9G+W/9p1WGWnVgi0V6OtIW+ffi4dMxSRpGrTRS1?=
 =?us-ascii?Q?0NWlxv7jvBFHJ/auk3cEiIvcwCThMBUkXhHsif3b5LhsqzkEMutmJf9TO2EP?=
 =?us-ascii?Q?G0kZXRtf20RxJF+aTmuJfPtMskV49k+L8gZZ/PKJtlmGgq21C5gPR2XlHmNn?=
 =?us-ascii?Q?gJl8XlR9ZHzYUJWi2vDPtBpjZgWrxuE6pgzyhZ4zi8j69xwZakOLqiTS8T00?=
 =?us-ascii?Q?SkebnED4LBIkco7smf/3M13qaP0VB4VATITbZ491WFpy7WPN1AB41J6Tk1BT?=
 =?us-ascii?Q?1UDNz9xpqdIhnzOWn3z27SsvfKgOk/sCJJsoGPRZlLmphAhxu+kFSOQpzgi/?=
 =?us-ascii?Q?NJbYYgYum9Bv76MZU/Hp8otbJfuaL4pbZVEvOPZAbvGU8yYHTirmzz03UhT6?=
 =?us-ascii?Q?ToVs1QcwNESts+pqA7XstmJLPwNNgaDEn/fyJ1wCqovVGD8+yKLgOIXCXH8b?=
 =?us-ascii?Q?/FiNOZL39Ug5VgEUs1r8FaQ6LyMTnQ4NQrBfxq4mg1AikDBW7Tw/gvKko3iH?=
 =?us-ascii?Q?UYtl5sXSx1+RnjwQ5e1Dc1abBG24fzh7Kye8m/CfK/BWGvN9t6dZvHq8jrFM?=
 =?us-ascii?Q?QtzK6bhN62BDEMx/Wf3EZMiSN/lRPBHMAjDJfcmx8JLgAfBtJ9/psbL8JlWz?=
 =?us-ascii?Q?0iIEPTDc9Ts7QjrzVFjHjqWL7KeEtWeA5YsDBrn9uZiDAGZXjS1sl9CwTMDk?=
 =?us-ascii?Q?JL1/wbSURR3mbxFrambz6FtWvx05rWMzk6blEgBLUkznSBPAYrzmihZoP/wy?=
 =?us-ascii?Q?nLIgcluUUJeODkzzpZIVtEm0kEKQvil5fT/l5630o/6sjJdzw8WTt9tkuQxS?=
 =?us-ascii?Q?MXPI2mV1yFdiKrPex+4y9qJ6pHTpE8gejSxfkmtS1VRnbl2jSQFuEliX8qU3?=
 =?us-ascii?Q?LsZ5+8q6vg3wYPy3RabFKZp6dwXQoOrOndvIlnFXHe/34t8TMyN5IrE+kOFw?=
 =?us-ascii?Q?39aVFENqEeLBYF7J+xBbJAbuUslkQl75qsgeHIkCHCaYd4DJrnBaSZLA+e9X?=
 =?us-ascii?Q?88fcbUIU6/DXVk6ZzMJQFQwJwkCsXQaQTHR86YHriyyH2Ejq9LzwXa/8jG5G?=
 =?us-ascii?Q?EiwJJQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GSbGD8NMChqJlDB8nwg+i37/ce+emDNpynEPSpzO/Uj9xoZSTuAVjZuz+KoivtARRjv8l1DTYf8XC4dFTeUMCSIevAb5rDwZsHmkO4kGudJWQcYgh+C1MI0BLWNZFYhmgY0Mt5blDgKKt/5IuV/bkhB0EextV/k2ozd8eJKsvmQZOqTZSKLDmn7QOHx3maj97zbirFMf62knSYMbgWHBc9M2OTjz3u9a6D8K7Uth6JtukNYF3h4D+Ku/fOCuchvSuaO3d825M8u/1H71YzDGMkHMY6kv29uH8BS7vIb5b3qTBmqWL/WLK4qaD+uS9f52uYxXw0yvn7XJAFRAIfBbdPE8XjbxV9f0oidD8ZPhTkn9RRtuCY0U9UnXDowDHIMp1uJHTttc/vyU/T/wbH9QizcOEEun61os/ooypT9N34y4VNQ6g4thVQZNgYnyPK9q
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 07:11:39.9648
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74e56165-536a-4c8f-d6f6-08de62f37a43
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8012
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,resnulli.us,lwn.net,nvidia.com,kernel.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16410-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 266A8D592C
X-Rspamd-Action: no action

From: Or Har-Toov <ohartoov@nvidia.com>

The device-level "resource show" displays max_local_SFs and
max_external_SFs without indicating which port each resource belongs
to. Users cannot determine the controller number and pfnum associated
with each SF pool.

Register max_SFs resource on the Host PF representor port to expose
per-port SF limits. Users can correlate the port resource with the
controller number and pfnum shown in 'devlink port show'.

Future patches will introduce an ECPF that manages multiple PFs,
where each PF has its own SF pool.

Example usage:

  $ devlink port resource show
  pci/0000:03:00.0/196608:
    name max_SFs size 20 unit entry
  pci/0000:03:00.1/262144:
    name max_SFs size 20 unit entry

  $ devlink port resource show pci/0000:03:00.0/196608
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
index 89a58dee50b3..2b6c3c9e5cc3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
@@ -3,6 +3,7 @@
 
 #include <linux/mlx5/driver.h>
 #include "eswitch.h"
+#include "devlink.h"
 
 static void
 mlx5_esw_get_port_parent_id(struct mlx5_core_dev *dev, struct netdev_phys_item_id *ppid)
@@ -156,6 +157,32 @@ static const struct devlink_port_ops mlx5_esw_dl_sf_port_ops = {
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
@@ -187,6 +214,15 @@ int mlx5_esw_offloads_devlink_port_register(struct mlx5_eswitch *esw, struct mlx
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
@@ -201,6 +237,7 @@ void mlx5_esw_offloads_devlink_port_unregister(struct mlx5_vport *vport)
 	if (!vport->dl_port)
 		return;
 	dl_port = vport->dl_port;
+	mlx5_esw_devlink_port_res_unregister(&dl_port->dl_port);
 
 	mlx5_esw_qos_vport_update_parent(vport, NULL, NULL);
 	devl_rate_leaf_destroy(&dl_port->dl_port);
-- 
2.40.1


