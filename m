Return-Path: <linux-rdma+bounces-17814-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAUpEYYxr2kYPgIAu9opvQ
	(envelope-from <linux-rdma+bounces-17814-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 21:45:58 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AE42410DE
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 21:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84F65304567A
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 20:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0183A36C5AD;
	Mon,  9 Mar 2026 20:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="WeNPnkcH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021112.outbound.protection.outlook.com [52.101.57.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5045536BCC2
	for <linux-rdma@vger.kernel.org>; Mon,  9 Mar 2026 20:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773089101; cv=fail; b=QU1GcRymtSphHgebFeMNSOOIG3iyy9HU9KcpEtMtBTiLQe7NUJskDwRCG3n9/mOErs8Hn91v4d9plLP5vn5FS58kGmxxvXjQIbTvGWk7PyKVTJHJJhl8CTgmHB+przbTpPx8hSIjEyqM6IorziPk5bedG49BjUTNxHHJaIhX0Ms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773089101; c=relaxed/simple;
	bh=2Z9PlyMXzBOOmvWMHn/hD3MalDOfQlrcx3tP6wdFQ1Y=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YCBPufLoprjw43q23uAsUPfKo55+9HpVyW+9rB/+G+8CuVKj0U1BizJGmzmOpQeRrvD9/wdC02d1uincjxqXHtdVULuZge//5M98Fm7pLpRiEKuuzmmy2R47S0DEr53dwhzww/vwEsZGXrf4Wf5vpp8IaW1EXJ4QX5gh0eV+Aec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=WeNPnkcH; arc=fail smtp.client-ip=52.101.57.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ixklxZK8HIPQs45/FTHw5lRF/xBudYt5b4VAUWZnuy2YdcyWptaOHDX1xErG3JI0MSbzUW33/uAKxaLF2G+cL/V9Im0iZTa49esZo3D2ibVLzs55XtcIymUiSWN2Djg8mw8IQ5+2qPelrR/V5PotLtioFMSCqsoAT1nWpb/MSpF/0+rn45dXlHx3NQik1+rsHzg4tzDC4Lhg8L8OFFohpiBkTrAgvKE1h47tt19ZT8OAYaiW+GqZXfG+Cl2yfCeqYLAeynFPaGMJsOSxnG2eltn5pRvaK5f1uFAlbLAspU/ESh5aBzHcyOQ/7QWK4JFbKE6afS55quXcuZwAHHJSmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gGktlIjrk8eNFZpkWMeN+tRcjMB7I1yRsZhLPXyko2Y=;
 b=Dptc2PDZZiZzhPNl1oy7PhdaSRMwrpMTt2M5OvkwhYJIJS2T9Iiv63jnZrzYTCVY5JZfr2ak0k2sWHYacPUDvKVihzKONqqdotwe3XhCB7dssKIJHqjNfWzc3Vf+bEiX/HwP9vY2fLOPvhr4kO3D6lMqkUGouz/AEpkwxxl6+PuxIgjd9mJv54x7plT6tSlqnowQze3UK0Xemfor7QuEZdXfKKXwiT5RFvwER0O7oYj4aDZxMAbSjCFGogO3286FJyXWJKIP+r+M9zNaPNOCYJZQtIzgpABxUllc7a8TcIB863VfUVxDHdVCo93NnJCodLyGy4YW+YwKOk2qqGps9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass (p=none sp=none pct=100)
 action=none header.from=cornelisnetworks.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGktlIjrk8eNFZpkWMeN+tRcjMB7I1yRsZhLPXyko2Y=;
 b=WeNPnkcHu3ONRmR7mGN0Chr3g7X7NSlVlqqxNVxkby3iapB5xQWOrMZIXjRcqf/5bjtv8m0ZfdMJjuOAbQNClroartkQ8ukXM8MuCLtL6n3bPzJnDxUvgtJF95jxL6E4RZiq6+2uuNuGVvxwiIiLXOAXw/s2D1600XMG3b6g7SrWkADtG7kKSl5vzqLFJ2c6cy7FFvPzEtRuv5ylvSps5o8FHEPDElWlEnBRK6J7Yfd0NWFYydqYOdpiTEhneCGMTA6XesGSMcUc9F10RKESqBMk5mRIzGZPMvJb+lT3jh9Bh/l56xhivt7HqHNfK57kWZRx52q5f0s8SZIAvaGE8A==
Received: from CH0PR03CA0235.namprd03.prod.outlook.com (2603:10b6:610:e7::30)
 by DS4PR01MB9345.prod.exchangelabs.com (2603:10b6:8:278::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.25; Mon, 9 Mar 2026 20:44:55 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::f8) by CH0PR03CA0235.outlook.office365.com
 (2603:10b6:610:e7::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Mon,
 9 Mar 2026 20:44:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=cn-mailer-00.localdomain; pr=C
Received: from cn-mailer-00.localdomain (208.255.156.42) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18
 via Frontend Transport; Mon, 9 Mar 2026 20:44:55 +0000
Received: from awdrv-04.localdomain (awdrv-04.cornelisnetworks.com [10.228.212.218])
	by cn-mailer-00.localdomain (Postfix) with ESMTPS id B420114D715;
	Mon,  9 Mar 2026 16:44:54 -0400 (EDT)
Received: from awdrv-04.cornelisnetworks.com (localhost [IPv6:::1])
	by awdrv-04.localdomain (Postfix) with ESMTP id AF3CF1810D6D7;
	Mon,  9 Mar 2026 16:44:54 -0400 (EDT)
Subject: [PATCH for-next 3/4] RDMA/rdmavt: Correct multi-port QP iteration
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To: jgg@ziepe.ca, leon@kernel.org
Cc: Dean Luick <dean.luick@cornelisnetworks.com>, linux-rdma@vger.kernel.org
Date: Mon, 09 Mar 2026 16:44:54 -0400
Message-ID:
 <177308909468.1279894.5073405674644246445.stgit@awdrv-04.cornelisnetworks.com>
In-Reply-To:
 <177308892140.1279894.3475429390519673020.stgit@awdrv-04.cornelisnetworks.com>
References:
 <177308892140.1279894.3475429390519673020.stgit@awdrv-04.cornelisnetworks.com>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|DS4PR01MB9345:EE_
X-MS-Office365-Filtering-Correlation-Id: 95a8aace-fa29-4787-4c45-08de7e1cb872
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	YAQnkPsxXhdFUZ6n1vfN9hy3E13kIjEidr3AJxlSZLbCyt0s1prIdsGxdB5qgF7XKf2eKe4bdGqWec4qmfRWV6UyXwG8YI3fflZwOur8lUEFxv+tondzqUjvcFvudAcnOy2Fn0vLkOdoUSXuCbyJ2xsVskUXFwwPQPcuhMOLZKDtvLQdfRQBi21ERoJE1d2h0ZtgFuFMY8m5zxoXk9TCluoC+tAeXkrJOh7f9xHSGJG9EXP+SrbrYG+qLlpC7NTKiqQIDMI/leRw/uTYeoT4VJnyNSjSGuqMMfmoBIp0yb7ZeblB6bNXG3C9KGNuZ8gKtqf6cluAyjreFjB4Di440+kfUYPVO7eupX88ZZjFszYrrC9WA1XOWrYyK+SK5dMjmPF85kvqp2hTI0Ai0R4onFmzZuP1UB3TtHAgUpjdMwqDIaACP02YUhjf4De/4A0KO159qFPpjwJYG1aQs6bR532N3tzwx09IdiuGEdEsGlOKegvh6G9w5YtBlYktCKWmY5ZwIXPwlZyVEkI2o7p5FufMkvEQHBrxa4Qrlq1/4zPLNQYzU+TnB+uND1SQT05Xq3iM2XRXfIuPPTF2jg78yYY0rJkQIMqUtGQ99aTiYCLk4A90vWvcE1Foyp3GOKAPGFodtXTgHhmd3UILxtpad4HZTndiuKfCTLX8vUr67jORW33mqNf8MMnAq2oW+Joq1OzNpowS1mhRj1K4v0bu2sJggttzXI30jbGJbGd/L7BJJ84A8iQPn5PeLxHnvjAQAxZe9+Ik2rB4WN2NFCFB8A==
X-Forefront-Antispam-Report:
	CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cn-mailer-00.localdomain;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sZW1fwujTj1a/yum4HNj2cLIonaePBL+OT0s84gaGnVOMzD/XvDSzUBc7I0qjHLAl/lUoepx0x+iMaZjuKYpmpsUXcIiVpxenyqEenKiJhgqmCT8C1OHxs2kNb+CxoBuaqis3ltx/HWQXtYmzOY9BdoM9xxfRtUrGtAi0VGNkkKpi2U2xFSjs0RhR54BsehuLtAGRqKI6qIYApnXGHS6MIk6nMwP70KlWFwcu2mDQUorTF4N3eQwEb+W1KBw3ZYacughIT8KW1Up1heYYV1zeYTgTcm2WtyEpvlLXt5TgNSsquikBpMS/8u54cnkeeBdfX6e4E1V2L1Vw21VKGif+bmdlNit/R3JkkTEqeWdT1d7jLHbSOoCi/TyeXqsUEBVNCK07iAGnOSXNklMUl0JB6oc5a39eM/QWxdIpmOSwi8cRCjV4KNNVUftGXkOVDtp
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 20:44:55.0957
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a8aace-fa29-4787-4c45-08de7e1cb872
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[cn-mailer-00.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR01MB9345
X-Rspamd-Queue-Id: D2AE42410DE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[cornelisnetworks.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[cornelisnetworks.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17814-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cornelisnetworks.com:dkim,cornelisnetworks.com:email,awdrv-04.cornelisnetworks.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	DKIM_TRACE(0.00)[cornelisnetworks.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dennis.dalessandro@cornelisnetworks.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

From: Dean Luick <dean.luick@cornelisnetworks.com>

When finding special QPs, the iterator makes an incorrect port
index calculation.  Fix the calculation.

Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/sw/rdmavt/qp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
index c1199ea5d41f..b519d9d0e429 100644
--- a/drivers/infiniband/sw/rdmavt/qp.c
+++ b/drivers/infiniband/sw/rdmavt/qp.c
@@ -2707,7 +2707,7 @@ int rvt_qp_iter_next(struct rvt_qp_iter *iter)
 				struct rvt_ibport *rvp;
 				int pidx;
 
-				pidx = n % rdi->ibdev.phys_port_cnt;
+				pidx = n / 2; /* QP0 and QP1 */
 				rvp = rdi->ports[pidx];
 				qp = rcu_dereference(rvp->qp[n & 1]);
 			} else {



