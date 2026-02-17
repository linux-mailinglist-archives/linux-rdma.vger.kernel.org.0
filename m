Return-Path: <linux-rdma+bounces-16942-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENZKFd4clGn0/wEAu9opvQ
	(envelope-from <linux-rdma+bounces-16942-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 08:46:38 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E67A11494A6
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 08:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6965F3016538
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 07:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBB82D77E9;
	Tue, 17 Feb 2026 07:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xw8bj6ow"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013024.outbound.protection.outlook.com [40.93.196.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021AC134CF;
	Tue, 17 Feb 2026 07:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771314385; cv=fail; b=S9SaSrmWkA/hVAMJrjHow2XFi7eK16X95OJ4gB+A6Limj9rAkaaq+gBNj28ryig/+UmreZ3gbNCX113PkObY9K9xWu7FbPQULz7OAqQ+DjhDmjBNq+25jB7gGp6Hke5/SyzhrmpMJS7xBl+f906/tzH2Ld4o+LgG7O5voaSqCvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771314385; c=relaxed/simple;
	bh=6nTASJf/iJoK6JLnBpYHxsd3UQ6RmAymjMsLmqVDFvA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K+mcmRgfvf3r8z6PyLEwNF78yIjcCO5g13VUtuvQrtuMHBRNtP65eonk7qhInXETdhkDTQsCG5HG3OGYsfbEet+Ap9igRlvT29wDxBkrwg098mFZuv2poOcjvR8JVS7QodtjgUBvROK2Z8pqcPGJT++1DbBQbTvmxe7VS3gnpP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Xw8bj6ow; arc=fail smtp.client-ip=40.93.196.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kPPS+NRX0BKjkUf07xNPTmYNR8fHgyCyTudZQmsbM2aUxAYpgXwlNRL9cf4BxYlMKVpdPjSZEt9h8+NcPnKAlAS4ztXi8iH/09wVKYdBCE6fYCc0aLnJUNN6IpIYg8G6UGOQJ/ne609FTCFm+MJFFiZli1iFumO9ir275uAZabXnysD+T/owXVNVQJtJEhLMiMUhG2MLJLA0jdTdidNkpQO3aIH1NPYCGwN49N1Kqn+1TSNtHcrHkBdam09hv1mPFbGyuKahvDaqzTtcbaBIG1Q8eKuqLN1O+7EmlgB2dvcpiE6VmZB3LoAcGMB9C4fBizTTkLmsqQhOvoVYQMOdrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bB3MJRcZK2h7gGj0x/aJq7Rmf19NxZmuVyP+xzk13Y=;
 b=fJ2qTAXiRC9g8Jvdphy/mYzvdAQMHSvOrUdfiYX8UUbzAzjA+PskAqZHmLaAsTpFiRk0GwYWsXp13Ka5Al2/ZryNm+WDodqV3JZdkzLB1xYBKDzApiWhiI7dTlaWFThEQzSF5qCyS/MyaaJiwnmCvM5qLVSn9vr6GgAejzzV/hQfrwwkAgoZTg/wXMCPGVK8zUYtS7gBRPtaz2aPl03SLgBb6HBVBXvcCW4uX6nixZ7sHk9gRyeoxQmqAJN4K2iFA2MWPqkkcu+hlPRN1OSxe86PWGaD9syM0jT9fFJZc+OvaZGk/sw579PfRpi/veaGHTlzcv1G3NSH5thJFyrClw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bB3MJRcZK2h7gGj0x/aJq7Rmf19NxZmuVyP+xzk13Y=;
 b=Xw8bj6owjEI3O9ZRO5HdjBtPsFSUyUfmOqoxK16BoUGdRAVPiJsGiOt43Nf06n9kO+M7hQl3rU3f0rgJCNmbjcRtTfcIqgGV3iRXbywvM44C6XhveajkL94PcqxE+ib04a2fl61DSNJJwYxTbGo0hVfLvwLXBDNRr14RirncV2YetCCeL4j+My8HsEfD++OYT07kDNUi4W76sChOa0DFC2GZTuMccs4ClgCmwTjesVW+dukvuTpi6eP6orWx8XmcCBFMy7iMUY1TiSTbe4h2vH+iWLD2djQVzEbSPC37WTxYI/SHEWVSGJUa+xjT0FpBNn04eUBjVEom/yTjOTwpfw==
Received: from BY3PR04CA0022.namprd04.prod.outlook.com (2603:10b6:a03:217::27)
 by LV8PR12MB9666.namprd12.prod.outlook.com (2603:10b6:408:296::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 07:46:17 +0000
Received: from CO1PEPF000066EA.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::e9) by BY3PR04CA0022.outlook.office365.com
 (2603:10b6:a03:217::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Tue,
 17 Feb 2026 07:46:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000066EA.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 17 Feb 2026 07:46:17 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Feb
 2026 23:45:59 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Feb
 2026 23:45:59 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 16
 Feb 2026 23:45:53 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Alice Mikityanska <alice.kernel@fastmail.im>, William Tu
	<witu@nvidia.com>, David Wei <dw@davidwei.uk>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net] net/mlx5e: XSK, Fix unintended ICOSQ change
Date: Tue, 17 Feb 2026 09:45:25 +0200
Message-ID: <20260217074525.1761454-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EA:EE_|LV8PR12MB9666:EE_
X-MS-Office365-Filtering-Correlation-Id: 2518330d-9230-4cb7-3859-08de6df8a208
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BCwQePzoPA884A/ojcK8MJ4pWfJxCZZxOPBBR0RVb23aNTiPOiRCOs/+Kfkn?=
 =?us-ascii?Q?9hkM6gMoz4xVUxTq4DjgC+p5TBeXEi6gTfI6fh+1Y7Ynunwq8xYM7GubOc/L?=
 =?us-ascii?Q?9SyHnDb/+aKMtdgX5cLgLyz/q543UiWvf5o9x9xzobZOtXU8TjFoREOeTCpy?=
 =?us-ascii?Q?ZAwxBSKoPq4+Wh0LVbPgcVhFHvhzUAGLyjdUb4rudnDeyTx+DQHQToxXfEn5?=
 =?us-ascii?Q?ivIx0J+Ky6xpVBOCJxLZkBlEPdK/btKjCIEi4BECXZF4sLxLgR+MYna8Xapn?=
 =?us-ascii?Q?vQtI44yLxwKCxK2Qj+QcPbIyNM/KbKuMuDWv9MdnWAox2i2H8sjbnfaeJ2mh?=
 =?us-ascii?Q?jOsDrpWJncXUg9NghC3Eh4r6KGfEkrHsHU/wBwRY2IPIEg+KWnRYAP1apZsV?=
 =?us-ascii?Q?J+u2ZkW6sh7aOf4T3GTslFuo4rUPgHlrXCJCLllUYl9kkco/Il4sm1d77Uog?=
 =?us-ascii?Q?n7PU4/I/1t4NUjSe3jm1L21hMmyWy0+qLbojR7W9X05Ff7uHIwXVysUB7J8E?=
 =?us-ascii?Q?/EjtJnpiGmAgu6KPZgeKUSbIAxb1zrhZJM3Oq0V7cn51CQMf+grRb4mQ6f43?=
 =?us-ascii?Q?j2m/1r7kqARUC/32uFIbSy36DkqWfm0PeGF6F6Y6xkctXszr3VC7ROQvJHO/?=
 =?us-ascii?Q?aZTaEA40v33X0fgYuUbuRlrhiGmRS3IyJIBIVW1K0vTj+dpkVCYOjYgcMNHU?=
 =?us-ascii?Q?5j3o66tT2IGargRCkKqmSHQfGdWfmASM9j5+wipP0awHXXMbkjxoqgcOzcfw?=
 =?us-ascii?Q?MJQa/eTCDP714a6WZdU3PGeVFxvMpUBoU8yZX7l0MCmGA/9PZCwe9lzjfYQ7?=
 =?us-ascii?Q?eF4+L9hRqCyheF6y+mUwvUy5O6LKUOKK64DmrRniUZn8xBlzkHuSnTeEdRxj?=
 =?us-ascii?Q?MXCZPZmoX5HpotRIZCibEnlCgqU0NhwwFujVsFsBQtOGpi7G3z2uyR7FcCaC?=
 =?us-ascii?Q?jCbpNkC81q79oxRa/d064omepgATcAZY+SZ4nUkxHpvpG+DuEhccpU7yGzmT?=
 =?us-ascii?Q?YN/uxBfAVFLHnLCg3stwLe5gjS2Ujalqn3Kf1XsOitjWNZxIhzCOh5ngkPFm?=
 =?us-ascii?Q?PynfevyUleC4k8RT4EWoVulNhtjV4gpoU9dOA6JmWUDPMXjrCJTmra6xm/VR?=
 =?us-ascii?Q?MaiQW07+kVTgbfMGhr58t5DjXfzrizBxSKIXwIopWrkNMf4rGkhxt5NiMUrs?=
 =?us-ascii?Q?AmKD+b9EQX6Kwaex1qYRw4l+GRfIG3xbu9Bb3iL/QCcsQrhDtdtZiqyDC93F?=
 =?us-ascii?Q?rKkuf1LteDAxkO1KQf7RmeS8nWm8xms6Uh8LwSsYkpS3+m2UH8JnXUB63V1d?=
 =?us-ascii?Q?9yEapXNJ3BPQqj9Dik3u2W4EbOVRIjkaTLftsEDJnHOy6dqk2mD+9ar1eQ0U?=
 =?us-ascii?Q?K7frv/7uJ5hw71W8n1xHkPmPhRk9LFcrtSmyyy1nNdM2XGcPx4XQvdxrXHJj?=
 =?us-ascii?Q?3zTZYWKNfXDSQGhn6Y+WBfHueMdTNH+6joz2cYBi8Kr1PifH6MUC/CAFjJcK?=
 =?us-ascii?Q?ZzUqgdQkN3hV/FSO0zDIiIAs/AodOaFRm+gDihxjct1xMMXusz1NbleafGk/?=
 =?us-ascii?Q?6Zg5bZ5DvvpphFlICq1UbIV7qD/WrrZyvFGBgbeGSwu9I3rtYvFOqoJuzNLG?=
 =?us-ascii?Q?LWy2Jpz6j2EzfagjrCE8HYEjSDpdg+04xBzKzIYg2qU3zA0oQDQLD2aYpbtA?=
 =?us-ascii?Q?X+l0bw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ui7e8PnsevCyafk9E5AD5LC+yAB8TMjWBzf19yBM08sKBBGKVD0BxkhekbXa2C7UT5BvPOLh6/nTEKHZdP0MSUBeJMzhnFK735ZC/YxQmCDoCh/avv/ijW875osHRXnduvPSGkz0O6TkVbqV7OagUSD4AMx+Yf8N87tM3mw4PNs8G+oxpwt4Hs1hIAP0Fjlmm603SzR11sdiBLzAUvn7V3KGZoJDrcHUmSccnCZ0Xb2rZUunY14iVXUacl4dQPc0qinzZNnwdxXBU45U24MQh7F+uiNsssc7adlk0tea4DOM5npnBGiVf+sOTrDEsvxAng2NLMF0S2IsdTX0B09SZkgHe509lRrtE4YNsDb8TWEcOU0TcmTvPjhlzZJC6QX6yR963fdA6T04UI12Nw5fKPydYY7ywFSqqu9vWHg+IdMdSosiK+jJ8w/zxYVM/Kig
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 07:46:17.0010
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2518330d-9230-4cb7-3859-08de6df8a208
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9666
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16942-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,iogearbox.net,gmail.com,vger.kernel.org,fastmail.im,davidwei.uk];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: E67A11494A6
X-Rspamd-Action: no action

XSK wakeup must use the async ICOSQ (with proper locking), as it is not
guaranteed to run on the same CPU as the channel.

The commit that converted the NAPI trigger path to use the sync ICOSQ
incorrectly applied the same change to XSK, causing XSK wakeups to use
the sync ICOSQ as well. Revert XSK flows to use the async ICOSQ.

XDP program attach/detach triggers channel reopen, while XSK pool
enable/disable can happen on-the-fly via NDOs without reopening
channels. As a result, xsk_pool state cannot be reliably used at
mlx5e_open_channel() time to decide whether an async ICOSQ is needed.

Update the async_icosq_needed logic to depend on the presence of an XDP
program rather than the xsk_pool, ensuring the async ICOSQ is available
when XSK wakeups are enabled.

This fixes multiple issues:

1. Illegal synchronize_rcu() in an RCU read- side critical section via
   mlx5e_xsk_wakeup() -> mlx5e_trigger_napi_icosq() ->
   synchronize_net(). The stack holds RCU read-lock in xsk_poll().

2. Hitting a NULL pointer dereference in mlx5e_xsk_wakeup():

[] BUG: kernel NULL pointer dereference, address: 0000000000000240
[] #PF: supervisor read access in kernel mode
[] #PF: error_code(0x0000) - not-present page
[] PGD 0 P4D 0
[] Oops: Oops: 0000 [#1] SMP
[] CPU: 0 UID: 0 PID: 2255 Comm: qemu-system-x86 Not tainted 6.19.0-rc5+ #229 PREEMPT(none)
[] Hardware name: [...]
[] RIP: 0010:mlx5e_xsk_wakeup+0x53/0x90 [mlx5_core]

Reported-by: Daniel Borkmann <daniel@iogearbox.net>
Closes: https://lore.kernel.org/all/20260123223916.361295-1-daniel@iogearbox.net/
Fixes: 56aca3e0f730 ("net/mlx5e: Use regular ICOSQ for triggering NAPI")
Tested-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  1 +
 .../ethernet/mellanox/mlx5/core/en/xsk/pool.c |  4 ++--
 .../ethernet/mellanox/mlx5/core/en/xsk/tx.c   |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 24 +++++++++++++------
 4 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index a7de3a3efc49..19fce51117c9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -1103,6 +1103,7 @@ int mlx5e_open_locked(struct net_device *netdev);
 int mlx5e_close_locked(struct net_device *netdev);
 
 void mlx5e_trigger_napi_icosq(struct mlx5e_channel *c);
+void mlx5e_trigger_napi_async_icosq(struct mlx5e_channel *c);
 void mlx5e_trigger_napi_sched(struct napi_struct *napi);
 
 int mlx5e_open_channels(struct mlx5e_priv *priv,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/pool.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/pool.c
index db776e515b6a..5c5360a25c64 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/pool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/pool.c
@@ -127,7 +127,7 @@ static int mlx5e_xsk_enable_locked(struct mlx5e_priv *priv,
 		goto err_remove_pool;
 
 	mlx5e_activate_xsk(c);
-	mlx5e_trigger_napi_icosq(c);
+	mlx5e_trigger_napi_async_icosq(c);
 
 	/* Don't wait for WQEs, because the newer xdpsock sample doesn't provide
 	 * any Fill Ring entries at the setup stage.
@@ -179,7 +179,7 @@ static int mlx5e_xsk_disable_locked(struct mlx5e_priv *priv, u16 ix)
 	c = priv->channels.c[ix];
 
 	mlx5e_activate_rq(&c->rq);
-	mlx5e_trigger_napi_icosq(c);
+	mlx5e_trigger_napi_async_icosq(c);
 	mlx5e_wait_for_min_rx_wqes(&c->rq, MLX5E_RQ_WQES_TIMEOUT);
 
 	mlx5e_rx_res_xsk_update(priv->rx_res, &priv->channels, ix, false);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c
index 9e33156fac8a..8aeab4b21035 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c
@@ -34,7 +34,7 @@ int mlx5e_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags)
 				     &c->async_icosq->state))
 			return 0;
 
-		mlx5e_trigger_napi_icosq(c);
+		mlx5e_trigger_napi_async_icosq(c);
 	}
 
 	return 0;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 4b8084420816..6a7ca4571c19 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -2744,16 +2744,26 @@ static int mlx5e_channel_stats_alloc(struct mlx5e_priv *priv, int ix, int cpu)
 
 void mlx5e_trigger_napi_icosq(struct mlx5e_channel *c)
 {
+	struct mlx5e_icosq *sq = &c->icosq;
 	bool locked;
 
-	if (!test_and_set_bit(MLX5E_SQ_STATE_LOCK_NEEDED, &c->icosq.state))
-		synchronize_net();
+	set_bit(MLX5E_SQ_STATE_LOCK_NEEDED, &sq->state);
+	synchronize_net();
 
-	locked = mlx5e_icosq_sync_lock(&c->icosq);
-	mlx5e_trigger_irq(&c->icosq);
-	mlx5e_icosq_sync_unlock(&c->icosq, locked);
+	locked = mlx5e_icosq_sync_lock(sq);
+	mlx5e_trigger_irq(sq);
+	mlx5e_icosq_sync_unlock(sq, locked);
 
-	clear_bit(MLX5E_SQ_STATE_LOCK_NEEDED, &c->icosq.state);
+	clear_bit(MLX5E_SQ_STATE_LOCK_NEEDED, &sq->state);
+}
+
+void mlx5e_trigger_napi_async_icosq(struct mlx5e_channel *c)
+{
+	struct mlx5e_icosq *sq = c->async_icosq;
+
+	spin_lock_bh(&sq->lock);
+	mlx5e_trigger_irq(sq);
+	spin_unlock_bh(&sq->lock);
 }
 
 void mlx5e_trigger_napi_sched(struct napi_struct *napi)
@@ -2836,7 +2846,7 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
 	netif_napi_add_config_locked(netdev, &c->napi, mlx5e_napi_poll, ix);
 	netif_napi_set_irq_locked(&c->napi, irq);
 
-	async_icosq_needed = !!xsk_pool || priv->ktls_rx_was_enabled;
+	async_icosq_needed = !!params->xdp_prog || priv->ktls_rx_was_enabled;
 	err = mlx5e_open_queues(c, params, cparam, async_icosq_needed);
 	if (unlikely(err))
 		goto err_napi_del;

base-commit: ee5492fd88cfc079c19fbeac78e9e53b7f6c04f3
-- 
2.44.0


