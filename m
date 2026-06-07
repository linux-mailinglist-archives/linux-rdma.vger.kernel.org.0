Return-Path: <linux-rdma+bounces-21930-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sJrYE5i2JWpZKwIAu9opvQ
	(envelope-from <linux-rdma+bounces-21930-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 07 Jun 2026 20:21:12 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F82651394
	for <lists+linux-rdma@lfdr.de>; Sun, 07 Jun 2026 20:21:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=EPC9j4oG;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21930-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21930-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D2BA3014548
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Jun 2026 18:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1D629346F;
	Sun,  7 Jun 2026 18:19:04 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010065.outbound.protection.outlook.com [52.101.85.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B78C1DB356;
	Sun,  7 Jun 2026 18:19:03 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780856344; cv=fail; b=E/xye5aLJTQB/u/JrwLTi9zm9DIbBXJ5DetbWfFrC87bU0dEQMPzpGRzIYO/Qx5qH3HDzlIPmaI5PEjTB5IJdR9DgYh5xCzIBGhskc18aUGHz8qSxL2xhrmg4zvKNZam0uf84gNPttOdJghFDC6fKS9g3qzBuLJ6sArTiFzXRIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780856344; c=relaxed/simple;
	bh=tmIbmiVTyxn8HE2XGHzlOQ5EfoBthHl2Z5nVsEWZk/k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=sbo76yPyfNfGL/yLYy3HFGMAg529e6ieP/l3MJllhTGgILg6r86Xd62UMP5ErhKrOZXQhAaW0SNQh9GySDdxzpfUOJ+84LxFZ6LncPo5ZEgOgqXgbhHsCcjP3ZGPft+mDbg8B76VHjszevG3HIjSd6+9NImAYt9Y7WUMqCREiog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EPC9j4oG; arc=fail smtp.client-ip=52.101.85.65
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1yJQjnj8LKAALlB4sIhPRQI6f7BhGl1+yJpPIlI6bFFutjO/TqzNojypc/sgytsxeIHQrEy2s6SF5WiTwj+WaYJUV5SbeDAaYWI3s+6V31KdG58DZ6QiE340k/FU+N3Je7euHB6d2rST+Um5aBV6gIcIODI1lBJdrNjG0c1Gr+9SswKEiNjmQvidPnfAVe1XUpKTV/5d5RM4aStI061Rb2PC6gl2DvSy8aNvKIfEimTw4IlOj6rR3xdQfBtWA8nxZYffKP8jb2Ew6+RV8+781ZqAaJcyhcTlbNo4fzk4ox+KTIbdvbE9vmOICw8l6ViZIkOBA3uo+5wcMgRc4OM1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqH2r5bbDpejXIF+NG/yIEJE7iGZ912wawo/gT09k/M=;
 b=aVkXUF22IGvocnsvNm/e9y+SdrAyPH+7dx+kwzIDYzOmsruqRIPATwikmuv5C0nCrjL8u5BtEZzDOi+NOhXJZ/SpGvQqZDq/XC8hMaFdTkrLPeoq0h3MXA9PaixQPJF3ujaC2A1hbalyyr97HXRvJl7LkTV6TSeYTOnqWlS63gRef97eHZ6VNHMepK8YnjoHVu2daiwaxNf/5buZvhGA+QC0E9UVB6bAPbnSG8BGQNr0LxZcnLjbAtd6CG+CWNPhXIGcNYMQwLBrky8jF1bBjCb2lQqlkOGJzpp8ADg+Ms2VUjAPNolVMxgCBXyzcznW/CUG5ZBZSZoaWuOLqWpYOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqH2r5bbDpejXIF+NG/yIEJE7iGZ912wawo/gT09k/M=;
 b=EPC9j4oG062+SngPThQXkv6o7dnXC+cwUzhjubgp3BB8WEPo7sKxxb+4GSJl1APCmY5rox0QguLZ50U5xp0Phje/3WYQaXAwOsIu2Z+bnbHAbjXwh1rTYZ8d6vNP2DTVN9qOfgNvgbP26Nbp/NNphpAAmzDWc1Xemb798xsZa2XskrF/yGbYu+iNQgrHYNU9KkMYewxx68i6UdqvgJ7aQDLT7mOuY9wUSvnXmEt54Rwp08ed0pRnf4XCowX2cJz9Tmfcd4/4Z8GL0aBMHAobOZuhYG3rQG8DeKeEYotDWhrC6+7f1Uyucew/iMiD3fWeJAsXRJjKwQpWlWXd9tPhgQ==
Received: from SJ0PR03CA0276.namprd03.prod.outlook.com (2603:10b6:a03:39e::11)
 by CY5PR12MB6155.namprd12.prod.outlook.com (2603:10b6:930:25::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Sun, 7 Jun 2026
 18:18:59 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::38) by SJ0PR03CA0276.outlook.office365.com
 (2603:10b6:a03:39e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.12 via Frontend Transport; Sun, 7
 Jun 2026 18:18:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002321.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Sun, 7 Jun 2026 18:18:58 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 7 Jun
 2026 11:18:49 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 7 Jun
 2026 11:18:48 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 7 Jun
 2026 11:18:45 -0700
From: Edward Srouji <edwards@nvidia.com>
Date: Sun, 7 Jun 2026 21:18:11 +0300
Subject: [PATCH rdma-next 4/6] RDMA/core: Fix use after free in
 ib_query_qp()
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260607-restrack-uaf-fix-v1-4-d72e45eb76c2@nvidia.com>
References: <20260607-restrack-uaf-fix-v1-0-d72e45eb76c2@nvidia.com>
In-Reply-To: <20260607-restrack-uaf-fix-v1-0-d72e45eb76c2@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Chiara
 Meiohas" <cmeiohas@nvidia.com>, Maor Gottlieb <maorg@mellanox.com>, "Dennis
 Dalessandro" <dennis.dalessandro@cornelisnetworks.com>, Gal Pressman
	<galpress@amazon.com>, Steve Wise <larrystevenwise@gmail.com>, Mark Bloch
	<markb@mellanox.com>, Mark Zhang <markzhang@nvidia.com>, Neta Ostrovsky
	<netao@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Edward
 Srouji" <edwards@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>,
	"Michael Guralnik" <michaelgur@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780856308; l=4123;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=6jdI7Z37D3w/it38DqkQya7GneRsgpINTJu0S9W/O4g=;
 b=7XOEmRe9D1j/qyV4AtwCzUBP+X5kDGDt/+DaH/0wccK4w3Puyzp+U7KDnqxYn/J1Lawou12z1
 /bYjHbIvNJ1DHznr1x1/SuS46M+9qswdZ2z30BTV1wBk/n2l5qZtiZ/
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|CY5PR12MB6155:EE_
X-MS-Office365-Filtering-Correlation-Id: 2abd8947-0741-445f-8d01-08dec4c13e87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|921020|6133799003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	6uisKvKDDGSFTtb6zebk9ik8PfKf3fYvKUnbGnuU6KCAgDlqldNS6wHy5SDt7unMXVUMKxaPaDBO76Ai22exu6RNQ0Do8fJ5EUGT/cGA82+ljav+ya1yHbxXAQ5DL7KlqiMww3IeoLdWmV6OekGSjelDrD2nu8cHdRBRO3gydWGzxKzgc8Vq5w3GCV26/2V0HLwMXuzQD+N4HFf/4WSQZ8ylalAR0+dCENNUpx7ZTffH0HvtcStNIR3X6jcM6E27ZYiqLAI7kgco1dtTrM7VAyaI2n4uLgjcztxARYQeKl7SULkmCyGHYKK2sDo51G+HZYjTVXW/CR72m4mMb6mLmeadMDUWInPsG469E3uzI7Dw8tYX0tWb4rIyioWCgvglLfuStzn1ohzVZyOqDU6EXPiDZgsso4l16Ei0gd87c4IdRdvTpspFlEjSNCj+y/pjwAu3mmVH7dOhUcZVfTn2lvrh5iJnSIqWcMzZ1Ss7CmzCGOf9weYNDd2cdyK1uZUPkuTSh3dXdefbn7p9LAhWy7G/uLwlmhtdvL0/6N04a8cZttOAKwvFbSUN9NaSebt3dhZ8Us5UwEj2cTj9M6Fhg3HTDlSi/E1tDlQqOH9XBNuaBKmILdmmehsSL5zU4IdeqRRswi7EKg7kS+FpJsjo8Z3m4JQdcIbnDI2m1Qektp7vTPfSVejrp2HN3nRJ3Ok3A/S1tXIUJuF4J3ZWVNNX4A5FpFzq7Lg/ntoPeXPxq5LVbLQ6ebRWtSfwGcS7AWTa8OR9xkkVdhgmPr0F5A5WAg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(921020)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BPj72nO1A5kSxTTABgP9T66f5hxY9ueSF2GxpzpMTZa+5UMeRGhTnCmNrWe9VSDdVzD+d2X5QzoZOCYWR3sf5XKcuF/kBvJdYjEdkol+pVJT5EKHPgyeLyR5n3NK9c/OANaNJ/Y5whK0MjnfiCjo2Ni0q4pv15a82VrbjIvkOqfxYGWjnkwFeSh1LVqq8kDX2oeXbzx3rVMgaS5zMhYrCIIfIxNialBOJmqL6QmNCjAM+BZIPFqdabbatSYUVxsEbLse0H59Dam+cQ83il5DfnURJ/zKaHoMSngxhuaMIzR+vAquW3nmKraJKtxpslLH0kJAO9IvjFKp3jUnnpEfIf1Iei6HRIQVqATt5rQB0qZW8eR1xsVofxG8EkJ/PXAFjyxh4F+1wLE3lMaVpk6OoAn/65KuiebQv2azwVPZi6DboBz3UZUs9RBNYDil5kA4
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2026 18:18:58.9502
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2abd8947-0741-445f-8d01-08dec4c13e87
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6155
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21930-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:jgg@ziepe.ca,m:cmeiohas@nvidia.com,m:maorg@mellanox.com,m:dennis.dalessandro@cornelisnetworks.com,m:galpress@amazon.com,m:larrystevenwise@gmail.com,m:markb@mellanox.com,m:markzhang@nvidia.com,m:netao@nvidia.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:edwards@nvidia.com,m:phaddad@nvidia.com,m:michaelgur@nvidia.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,ziepe.ca,nvidia.com,mellanox.com,cornelisnetworks.com,amazon.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A3F82651394

From: Patrisious Haddad <phaddad@nvidia.com>

When querying a QP via the netlink flow the only synchronization
mechanism for the said QP is rdma_restrack_get(), meanwhile during the
QP destroy path rdma_restrack_del() is called at the end of the
ib_destroy_qp_user() function which is too late, since by then the
vendor specific resources for said QP would already be destroyed, and
until the rdma_restrack_del() is called this QP can still be accessed,
which could cause the use after free below.

Fix this by moving the rdma_restrack_begin_del() to the start of the
ib_destroy_qp_user(), which in turn waits for all usages of the QP to be
done then removes it from the database to prevent access to it while it
is being destroyed.

RIP: 0010:ib_query_qp+0x15/0x50 [ib_core]
Code: 48 83 05 5d 8e b9 ff 01 eb b5 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 c7 46 40 00 00 00 00 48 c7 46 78 00 00 00 00 <48> 8b 07 48 8b 80 88 01 00 00 48 85 c0 74 1a 48 83 05 54 91 b9 ff
RSP: 0018:ff11000108a8f2f0 EFLAGS: 00010202
RAX: 0000000000000000 RBX: ff11000108a8f370 RCX: ff11000108a8f370
RDX: 0000000000000000 RSI: ff11000108a8f3d8 RDI: 0000000000000000
RBP: ff1100010de5a000 R08: 0000000000000e80 R09: 0000000000000004
R10: ff110001057a604c R11: 0000000000000000 R12: ff11000108a8f370
R13: ff110001090e8000 R14: 0000000000000000 R15: ff110001057a602c
FS:  00007f2ffd8db6c0(0000) GS:ff110008dc90b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000010b9a7004 CR4: 0000000000373eb0
Call Trace:
 <TASK>
 mlx5_ib_gsi_query_qp+0x21/0x50 [mlx5_ib]
 mlx5_ib_query_qp+0x689/0x9d0 [mlx5_ib]
 ib_query_qp+0x35/0x50 [ib_core]
 fill_res_qp_entry_query.isra.0+0x47/0x280 [ib_core]
 ? __wake_up+0x40/0x50
 ? netlink_broadcast_filtered+0x15a/0x550
 ? kobject_uevent_env+0x562/0x710
 ? ep_poll_callback+0x242/0x270
 ? __nla_put+0xc/0x20
 ? nla_put+0x28/0x40
 ? nla_put_string+0x2e/0x40 [ib_core]
 fill_res_qp_entry+0x138/0x190 [ib_core]
 res_get_common_dumpit+0x4a5/0x800 [ib_core]
 ? fill_res_qp_entry_query.isra.0+0x280/0x280 [ib_core]
 nldev_res_get_qp_dumpit+0x1e/0x30 [ib_core]
 netlink_dump+0x16f/0x450
 __netlink_dump_start+0x1ce/0x2e0
 rdma_nl_rcv_msg+0x1d3/0x330 [ib_core]
 ? nldev_res_get_qp_raw_dumpit+0x30/0x30 [ib_core]
 rdma_nl_rcv_skb.constprop.0.isra.0+0x108/0x180 [ib_core]
 rdma_nl_rcv+0x12/0x20 [ib_core]
 netlink_unicast+0x255/0x380
 ? __alloc_skb+0xfa/0x1e0
 netlink_sendmsg+0x1f3/0x420
 __sock_sendmsg+0x38/0x60
 ____sys_sendmsg+0x1e8/0x230
 ? copy_msghdr_from_user+0xea/0x170
 ___sys_sendmsg+0x7c/0xb0
 ? __futex_wait+0x95/0xf0
 ? __futex_wake_mark+0x40/0x40
 ? futex_wait+0x67/0x100
 ? futex_wake+0xac/0x1b0
 __sys_sendmsg+0x5f/0xb0
 do_syscall_64+0x55/0xb90
 entry_SYSCALL_64_after_hwframe+0x4b/0x53

Fixes: 514aee660df4 ("RDMA: Globally allocate and release QP memory")
Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/core/verbs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index de7d19fabd75951f0c546accbbb97348e756c235..8bd39cfcf41bce3a20cfbc41be6f51a1f7f95a8a 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -2157,6 +2157,8 @@ int ib_destroy_qp_user(struct ib_qp *qp, struct ib_udata *udata)
 	if (qp->real_qp != qp)
 		return __ib_destroy_shared_qp(qp);
 
+	rdma_restrack_begin_del(&qp->res);
+
 	sec  = qp->qp_sec;
 	if (sec)
 		ib_destroy_qp_security_begin(sec);
@@ -2169,6 +2171,7 @@ int ib_destroy_qp_user(struct ib_qp *qp, struct ib_udata *udata)
 	if (ret) {
 		if (sec)
 			ib_destroy_qp_security_abort(sec);
+		rdma_restrack_abort_del(&qp->res);
 		return ret;
 	}
 
@@ -2181,7 +2184,7 @@ int ib_destroy_qp_user(struct ib_qp *qp, struct ib_udata *udata)
 	if (sec)
 		ib_destroy_qp_security_end(sec);
 
-	rdma_restrack_del(&qp->res);
+	rdma_restrack_commit_del(&qp->res);
 	kfree(qp);
 	return ret;
 }

-- 
2.49.0


