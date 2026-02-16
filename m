Return-Path: <linux-rdma+bounces-16907-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Dz+HcHakmnKywEAu9opvQ
	(envelope-from <linux-rdma+bounces-16907-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 09:52:17 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B984141B12
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 09:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1DD643004932
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 08:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44C9277026;
	Mon, 16 Feb 2026 08:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Cq5GeDQu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010051.outbound.protection.outlook.com [52.101.84.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7C826463A;
	Mon, 16 Feb 2026 08:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771231934; cv=fail; b=CJupVg4FdpJupcQhGbixMjXmkCMzQYKc4UXysAtPN9Pk0WGEc/m3GiujWs4tyeaiI9c+tEMtZyBb3JC+Q6OQBG90Vvb6Qar9sqzQyecXr1rrj2tBP71OT6TtF1xIBlZIAMpZDW8+GPPhrSG44SUmpUahiAvOIdDd4o5WAeWG0Ps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771231934; c=relaxed/simple;
	bh=Zc4mYOf6uBmLYvEMeIXuNer70ZVh6V2M9oSybFrdC58=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=HMUZnDJ4UymqeUVvlP0manxYOutvd1uX0o7rjCi3sAqexrUpcly80na2Wpun0QkEgdgdQXyc2JYWtC0Odnbsu/eHjD4r++jNW6255i4l1tFgYnIo5CH7F8aLFeB1zTfm7BaChegVBGuo4ItJ5H99JgEqengCoJd3lx0WJyvq/Ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Cq5GeDQu; arc=fail smtp.client-ip=52.101.84.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FvCU3Sm+XqdI6J0sWmgUn1NVD7Wtl2AZBiZAlcIYazCsjFvtSUm6rb4+i4qg0+Llp4FqTOWmWwlltN70zYEWbTymM2r9iErItQ+dqA1NYVoXf6atnIW9X5puIyXVOINPqEVD9nP/GAxs8IAeEDVPRj3uxNnAJ8jyflKtkMuJSV0mf/tUq0pSAH0fNKAEJHAcp2KJqZMN0sk9VFjFMwJ/qiHtECukiKlKQ8QKVM4CLLAB7qXw4+1VN4JmNcwlaamJiBb/TrYSndPHUhpHrp90yTl8wQYWYA+1pNWjiSKnJZTuTmSYOfH8WeLmLgcTLkXAGpw9g5o8dAetlB8iUX6Odw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50vj9zgBruVYHZYFZpIMOKZcI4ZMqUnCQs75Yz6uwIM=;
 b=nvQOJGtGCCpEmYa9Kd4QPHXanvifYEtbtmh2AobLJIU4BqP21eIS2xUK2JcaPpC5qlr4uCT1V0DCZAJMqFNRZpT7P9VENEKRfKgqQotUU2U57Zj7cle24xfvPA+auJcubF78dcfvBtgJoeYZ++PIIKo3LckP0YK7nIG7xMvAfYR20h/fah0Dtvh3lZCEYl44Zwbm7t2ogn+QuGdeiDfvR6HlLsx0zL/KzD0XY+4c4zfHV2h6Q5rHi92Tye9TQxmubkSSqbXJ4aInZjs+SWWg4iyhlosLAHgpvN82y6MFwhEJZ7VwByKGEFauoAoOIXO9GyDT6KTQ24wkO2sIbhnLuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50vj9zgBruVYHZYFZpIMOKZcI4ZMqUnCQs75Yz6uwIM=;
 b=Cq5GeDQuKYTiKJUPtlcrgY8O0+/2EI881YYX4E+RIbrkkeRLPd7T9sot5ZiXagEr+QYv/FUl5meIwFkLNJHKW5iA4FWMmOgZqPr8vrZlGo/94doN3MtPhlm4cUbVCo6zx+GAKcNYFS7kEVLBbDFWmthWXkbuc5RNoyJvevs5HbIa3bDEm60cf9a0U39enP/Z1n8TDJoaJ+Ca+CMvFzt+nVTu/HUjIZbHKJSBHRpncuZ7lcoFey3piMZj/jo2hEu3tWWTPFkRbiYETwwWcbGU9aV66oXtMMMP9qbPmro9K36b5o3gFb20oitCuen4fVLJy/t0ARNXUAeVk2hYNn2tTw==
Received: from DU7P191CA0001.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::20)
 by AMBPR07MB11885.eurprd07.prod.outlook.com (2603:10a6:20b:759::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 08:52:09 +0000
Received: from DU2PEPF0001E9C3.eurprd03.prod.outlook.com
 (2603:10a6:10:54e:cafe::38) by DU7P191CA0001.outlook.office365.com
 (2603:10a6:10:54e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Mon,
 16 Feb 2026 08:52:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DU2PEPF0001E9C3.mail.protection.outlook.com (10.167.8.72) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.12 via
 Frontend Transport; Mon, 16 Feb 2026 08:52:08 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 53C1B1C003D;
	Mon, 16 Feb 2026 10:52:07 +0200 (EET)
From: chia-yu.chang@nokia-bell-labs.com
To: linyunsheng@huawei.com,
	andrew+netdev@lunn.ch,
	parav@nvidia.com,
	jasowang@redhat.com,
	mst@redhat.com,
	shenjian15@huawei.com,
	salil.mehta@huawei.com,
	shaojijie@huawei.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	leonro@nvidia.com,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ij@kernel.org,
	ncardwell@google.com,
	koen.de_schepper@nokia-bell-labs.com,
	g.white@cablelabs.com,
	ingemar.s.johansson@ericsson.com,
	mirja.kuehlewind@ericsson.com,
	cheshire@apple.com,
	rs.ietf@gmx.at,
	Jason_Livingood@comcast.com,
	vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v3 net 0/3] ECN offload handling for AccECN series
Date: Mon, 16 Feb 2026 09:51:40 +0100
Message-Id: <20260216085143.40242-1-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C3:EE_|AMBPR07MB11885:EE_
X-MS-Office365-Filtering-Correlation-Id: 84c746a0-15cc-45fe-f733-08de6d38ab1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024|7416014|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V1p2RGl3K2lKYjNzV1BYU3R5Q3cxc2xoYUlXWmNkZ2xxQ1IxaE5KYkVDZTV1?=
 =?utf-8?B?OU9VUkhXM1BBeEkycmpoRFFPMXMxWGdZdUZJRmJJRFZPdWRMb1Z1NXNSYzZw?=
 =?utf-8?B?OS9LYUF1NGVudkwvMDJOcTRIUTl1R2MxL0FVUmRLUXRhUmkzb09lbzVYOC9h?=
 =?utf-8?B?d2JIZmlOc25XY3M1SXRZeWkvcHFzLzA1blJJVldPMm14TElJaTVvZ2J5Ryti?=
 =?utf-8?B?UTBEVGNVNnNEUXE2WHdUL0Fodjh0STF2ODh6dTdRbUpHVEx6K29QOGlsdFpG?=
 =?utf-8?B?ZzR5Q0l0SFBkRC9YUTdKNzgya2VlSWZrQ012ZDhBTlJ6TU8xVldiSmlpUkVo?=
 =?utf-8?B?ZmpjckRxUjF5UHJWOVMzQnFnaVF6TENkUnFFS003aEFieDVtTUgxWUxBSlVW?=
 =?utf-8?B?NXJ5ZDVsSGQ0d28zcDhjVnRZUzM2VmU5UUVZeHo0Njg0RVZrR21VemswUVBZ?=
 =?utf-8?B?cUp3eVllQUZMbGpjS2VtK1NsbUtkMm82LzFScVdXdHpBdmY0bU85VFhxMjVN?=
 =?utf-8?B?Y1ZYSm0rcE0xcjhkZFpLcGxVNjZmL04xZ3RTdndGS21Ick8xVFRVRnBRdnRY?=
 =?utf-8?B?SlFGKy80RFUrSlF3MVVqKzI0SEkzY2tBMUt0Mk5JeWNWSnU4ZnlYS08vNXkw?=
 =?utf-8?B?d0RjYW9RNnU0RVUxUTluTXRUY01wdTlWQnJuazhpekpaZXkzVkJQQ1pQMkhE?=
 =?utf-8?B?NWNaUHdkOEhBcllTeFVNSmNDTmZYWHpSWmJ1QlFsbFVKK2lML3BLV0x6U0hi?=
 =?utf-8?B?c3ZmMEMwZ0U5VG5iSVlNWFdCcy8zSkUvVVlLeDFydmJBdkV4ekZSMWU0NFJ6?=
 =?utf-8?B?ZjB5YU9Ja0JKaVBWRnhHS0R4ai93RUVHZU1jSUlFd21QeGp1UElmN2VUNk9i?=
 =?utf-8?B?YWFXWHo3Z3VKbUJCZGZnbnFHdlBuL25QUHROVHlUdnM4RUFnLzVpNVdBNXBF?=
 =?utf-8?B?L3diTDFrVVpoZHN3Z0tIUlBsbVpTL1pjZU9CSzlEWTJrQ1hCTFB5V0x0Vmht?=
 =?utf-8?B?d3RaTTJKZHl5Qll6ZlBVYUhWUHV4dWIwQ1JFOUhXKzE5Rkl1eTBiRUV4TC9m?=
 =?utf-8?B?KzJBTW5sNWEveXd5V1I1c3NCYXo0dXNqemxNUWVyYUZEaUFDQUVWRTJiWGFU?=
 =?utf-8?B?UlFyYmxQTEVpR1R5eFBoY2ZMUFd2SWl5cTB6dDNCbVRhNk9PRVJRN29LUmRr?=
 =?utf-8?B?akVXU2I5TXRlKzUvZDdkVi85NHcrbVdmc0xGK0l4cUVUMUFHSXZVY1BJU3ZG?=
 =?utf-8?B?OTZLdGRZWkgvbW1Cb3djNHJYT2hUNVh3VGU4VzdreTRyV3dya0VCUXlZQjk2?=
 =?utf-8?B?UXphYWlML2p6UmZSYVU4Z2YreEowQjhEa3UzL3h6alBmcUNuaE1qRmFKY0xj?=
 =?utf-8?B?dUJNN2hCMUl4MTFLcWdCcm5abWdwb3U1LytTYWVhZGFGTk5vK29YNm1WNkh5?=
 =?utf-8?B?YWFGcFc2YlN1aFdHdkJ1SVpwU2RydXBPdis0Mno2MU42ZndMb0oxL2loTmlw?=
 =?utf-8?B?SXh3Z25TUXJ0b0NXcnRVMUcrSVp2VTBiQWdwUXF4L0ppMS9nVHQ2MTQ1eWVl?=
 =?utf-8?B?R2dCMW5lTjRyckdEUEhhRVk5THdDd0lYdU45dGcxL1JKeDBWT3NKbWh0enpw?=
 =?utf-8?B?RTQzMkJpS3RxK0dUVVc4b1RUVWVhN3pEZ1A4V0txSTdnY0NiRFdzcWVvNWJV?=
 =?utf-8?B?WkwvajNQVHNuMW4vY2l1Z2lqa2hza1VaYktyOFQ5MVlSc09SNlFxWW94MCtT?=
 =?utf-8?B?UlpjbEI5NzJVb0xzWi80cmt1S0c3RWNLTGwwSGVaMzZpYStGbnMybW9tVzZZ?=
 =?utf-8?B?NlRnY0NXVklHVVZ3V3RWMkVRemtOVm1tVStzdTlEU09JOU5DSEl6ZThHSlBj?=
 =?utf-8?B?MHo0Q0g5R0ZjZzF4YkxLVm9wdzVXRVpKOVpJL2lrb21TTUd2QnFHRTlLclVL?=
 =?utf-8?B?ckNhdHRtaXJXRmIxVEw4Qy9ZOE5kOXlYclNSMHl6NTRsNVJ1RFhIVllCc0tw?=
 =?utf-8?B?V1dtN0IzU2s4QkxBVlZ4RXZhNXQxU2dzc3JOWUVHMFp2WkdqNUtNMC9UdVlH?=
 =?utf-8?B?TnNiUHlCaHdyRW83bktQdGJYN3JaTkliSXl0SzcrRjFoczhGVEszME5OTkI4?=
 =?utf-8?B?RGo3aUtQMFlQb0xzL24vaFAvRVU1ZDNPclF6YTlXRHdFdlhXdDdnemwvTU1W?=
 =?utf-8?B?dmdMSWd1WEIxSEIwbmV0eEhRR001cW9NT0QrbzhFUGlUYkV6NFhoRXk1cEZ0?=
 =?utf-8?Q?nF0wvpp4KmjAcQYDpolkL76QsIjlOTVo9YKzrlyBQQ=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024)(7416014)(921020)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TCMKNhNf1xMw6diFELfxUjQ2m7jkqPL9ghLn2AGUIHKzRf/LCdmzOtP72VQEfekQO48Tp50pt6g/l5Ry4tJhZ+lrySHnhglmF5HNPanTz712rV1zKqaMTgw7BeFGZR/TI6ccaJXaN2fj+kVfAtne5RIJkAFOHNEqYGQrTIT87OBjAH2gs8UGZyKYMIdlt3LlRyrzPDg3vU13+Z8PUKx3GBDy2d6F750cUelb+Ce2SpHGcGgs+f3gsThMUaPeKfpAvobiffSEivgV+QUWDqb0pxTkZ+634VcNQuTH4uhjOvgbTG0FMzTY+w0I0+IejF2T528KkA1ZdhTyijhGbv1/e3CldRUku6Hsb/5SVlvj0IUpI5Zje3G/FSFedsB9o2uhZ53bQmnfxcwR5lRd1hu3Ee5OeNhCzZghRgOaRDuzRyyjpGNQK4nk/FiUlaIz2Gz2
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 08:52:08.8733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c746a0-15cc-45fe-f733-08de6d38ab1f
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU2PEPF0001E9C3.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR07MB11885
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	TAGGED_FROM(0.00)[bounces-16907-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[huawei.com,lunn.ch,nvidia.com,redhat.com,vger.kernel.org,davemloft.net,google.com,kernel.org,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1B984141B12
X-Rspamd-Action: no action

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

Please find the v3 ECN offload handling for AccECN patch series for net.
It aims to avoid potential CWR flag corruption due to RFC3168 ECN offload,
because this flag is part of ACE signal used for Accurate ECN (RFC9768).

This corresponds to discussions in virtio mailing list:
https://lore.kernel.org/all/20250814120118.81787-1-chia-yu.chang@nokia-bell-labs.com/
And it was suggested to clarify SKB_GSO_TCP_ECN and SKB_GSO_TCP_ACCECN.

A prior submission is made to net-next:
https://lore.kernel.org/all/SJ0PR12MB68066115C5329872316E6B37DC98A@SJ0PR12MB6806.namprd12.prod.outlook.com/
And it was suggetsed to submit the first two patches to net.

Best regards,
Chia-Yu

---
v2:
- Fix commit header title typo

v3:
- Fix commit message title typo
- Seprate prior #2 into #2 and #3 to have one patch per NIC (Paolo Abeni <pabeni@redhat.com>)

---
Chia-Yu Chang (3):
  net: update comments for SKB_GSO_TCP_ECN and SKB_GSO_TCP_ACCECN
  net: mlx5e: fix CWR handling in drivers to preserve ACE signal
  net: hns3: fix CWR handling in drivers to preserve ACE signal

 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c |  4 ++--
 include/linux/skbuff.h                          | 15 ++++++++++++++-
 3 files changed, 17 insertions(+), 4 deletions(-)

-- 
2.34.1


