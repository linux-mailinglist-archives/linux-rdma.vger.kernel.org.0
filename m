Return-Path: <linux-rdma+bounces-19414-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDG8FWpR4mnx4QAAu9opvQ
	(envelope-from <linux-rdma+bounces-19414-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Apr 2026 17:27:38 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 202D941C989
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Apr 2026 17:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 31715303DB79
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Apr 2026 15:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD626314D2D;
	Fri, 17 Apr 2026 15:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="MAm6plGe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010062.outbound.protection.outlook.com [52.101.69.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3353264E4;
	Fri, 17 Apr 2026 15:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776439615; cv=fail; b=N7DwuRpJbPSSxs1l8wgFWp5DdrA6WVrWge+yQmgKoJcNgrYFNQ53ehtsAddarwHrCltxQPdcvO/By+fx+NTZ9HLeLbib70JP0gpQVMMG996NjUTNzrqRkSCr4qjP+5exMXmCDhKl0Qc4SEZLZbo+VzW69T5UM5dK08J135x5tLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776439615; c=relaxed/simple;
	bh=K7Re8qnzPW4Qu4AuUbe7H0fkFFpbKdsYyvlm1grN40Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UftZRYRhdOJGg/G7g4j/ZpG10Ws7BRGpbzXMjcOJwqKF4ZRor5ZWThfQ1t2P6dDIKX6r4q+Scgqpc1UgU4KwPTVzH7ObwY5XdfZu8H9bcOeDUXDrlV8shtM1vXw/IlLAtnbFtZefXcKeuhrVxg61oeD1iyicFe6vy8P8s9RP6+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=MAm6plGe; arc=fail smtp.client-ip=52.101.69.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S3U07ikYu+bErwX73HS4u5QEb4UcfwXH9wlkvWuo/398/1NVkneBN5WhVkK9WzLtzxcXzuUirv9lgYWLmafTixrVuy2YzQuD/kdeDKf3U0dLgrz8AlmoDjBvA7G1Dn5j6hgXi6sa/flmPSaOFbg3Dhvlb63lxaSqvF7k38bUSeunhMu1HokUZCBeb+S5AAeXiULcY4FLY7ruZ1MM7sEGNsVXXWosz2jwQA6X6kd1s0AsWmYp6knXC23DgX3Vn31YA3GRe/FDKC/uLdPnBLflH5W0q8CgqVwmUzTnmUIIcxHYLN64sVbVx+mP8SsMIOZbPi4mzetuKdSuY1sFT/038Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o80gssMFVV6srv5mbUqBJ/OVRjvnP5c78mVWxRZR3Cg=;
 b=NYE1u573nvzTvJhKeSL+aQWgurnlabq4oXnHYckL+QEoMyjEGWZSpSyVpVWiJabSYoJaeTAy7W7ekGaZpBIPnE2mvcv95sjVMdtljKWe7rtTtZFlDELfW/nOW6ETl3xDHk4fK0Dt7fTvjTzZDQ7sLU8qeu3tNHvxprcFcXcuCPREke0IcffX95vDshLk5pvY64aaPA54Cwshe7DshQK5lciA4o5EgcW+3seRwlUS60ji5IER9ugADH2zXwmZgM5q8q8yQio7FgBW5Jz+ZQucqS7QDLajIrcXH34VXHI6B8fhTH/6RRx41uYunem24AT8goeY6cMnGHnUnrYmaXWiaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o80gssMFVV6srv5mbUqBJ/OVRjvnP5c78mVWxRZR3Cg=;
 b=MAm6plGe4W/SshcUlK2PSbxepFaq0cXa1BLAFYhTaSVp9zXUuNOLiyAX5WMwwiLLtbAGmWYTzW2+m7ajPwjXPinvdmESWNlm/lGvDhvfNd0mBXl5f2Wy7EUG6ZO+ytRurBePq6qtFcOZ/PwQJo568NFLiB0FFsdbJI+5uns7koeJLhIUTYlQzjF2AMNd0PkhF74AaceIqekXiPhpxTOeS18iJ6G2z3zCa8Rzu0m+2pVQgFXBqXTQoiihZ5YX48dbVgM3vxBrWs0nhCJer+8O53rzRioS9VX2Hf8ymIo+LrwzriegDTNTRFw/S+I20CDtVXbNEiCc2dekf3ViyaoAmg==
Received: from CWLP265CA0474.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1d4::12)
 by DU0PR07MB8641.eurprd07.prod.outlook.com (2603:10a6:10:311::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 15:26:50 +0000
Received: from AMS1EPF00000048.eurprd04.prod.outlook.com
 (2603:10a6:400:1d4:cafe::16) by CWLP265CA0474.outlook.office365.com
 (2603:10a6:400:1d4::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Fri,
 17 Apr 2026 15:26:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AMS1EPF00000048.mail.protection.outlook.com (10.167.16.132) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Fri, 17 Apr 2026 15:26:49 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id E8FAE200BD;
	Fri, 17 Apr 2026 18:26:47 +0300 (EEST)
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
Subject: [PATCH v4 net 1/3] net: update comments for SKB_GSO_TCP_ECN and SKB_GSO_TCP_ACCECN
Date: Fri, 17 Apr 2026 17:26:40 +0200
Message-Id: <20260417152642.71674-2-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417152642.71674-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260417152642.71674-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF00000048:EE_|DU0PR07MB8641:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fadaa96-99e0-412c-acb4-08de9c95be8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|376014|1800799024|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	BTAFLTis/GeNac0P7ykKYmUnn6TqWOEkwOvbWst+csWHlW8bf6G7kG67fH897csgYpOydTJ0DEPa1HSpGO9edG9KpHr7+SF/KvL7cg8qdCoZZlnfrjc1GRStRgCV3Jtf8pUQgIRGGUL2bl+YpOOMiWmSEW3wklraAtjrtaiVbPgDRPtO33H+cz8m3raMQsarGyWNtrRYN6LeeMxOcfEJADItaY6Pi1w2P8Jom7k4UpwaxnHFKrOUY6WlMp2Bm6+ZP59NwobfJyi3K6HCo/cKJQs9FkPl3sVBceFQqXpAKFZ/J7sCQi5H/uG52aZaaZMGyvU0x324qy+8zV/csaoXV8ASyE4oNxzxaqYiAmb+C0FQpnRCIc2XsIqWw/B+8S+zVk7RZm4D5oscxZye/9XgyGi/1fD8YjYJu5ZM+Pn3Jwsoay3rkTxxdmkZCqqIG/dDQQUdSZ8hsYV/aYXZIWvStTCspBVBwJzS3XKCPbqU0vWlRLckaE6QJOGEges8CKT7ZHZVSKJuzDff9y/8RlGIxtyLCqNVrE3lXVEytj9PwpziJorrrDeA2/yJxG8FoXXJ9hmrT9W/UNfgVBSERdN+2I4zvREx9SaVeUD2JkJO0IRDS4+qvTgaHDJV16pmxw6LXkT9e4/Fuyb/X26C2Zh6z7EvdSYkbVMjFQtKU3m/Om/B+luOH4TSn8Y7y/t7DwDCDwBuz850xXIM5Pkkb1qLZpLFWoO3q0btiKYdHkoT88P9ymxc5PXntGIcxScrK4xmhjGq3QRDrwrcGHUjcJ40KqqDTWlmd5s6GiUkH16Jj0A+mSgl6QLCUAPejUTHsNOQ
X-Forefront-Antispam-Report:
	CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(1800799024)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3KvhzQdRVaIBFLOEokM5ROooq1NtqePsq70tb8KFDogHdtgBtkD8nVpgbOAUic7DWszr22HKiT22ti0tCY8cVNKKUYF76yR1w8f/7ZACQfipgrVgRrmE+tmpY9ay65BDyCggCGuD0Zv+/qmtxrjZPZ4J7e3SzYLHzjJjTdvdmaDJaV2keH5t1K3DGK0t1XlhxsSGmV+gs7+0JQIE3UUchWn9MpvXENG3GieAJi7Ml+1B3o2n2kkr+oK7G0YCFTL7Xod4JcU8ywP+o5Wd7/Ge3ou65PUNvlHCPKX9YsiiFYcgm6Nbo4TBS+Waq35X61ggefuGrd7NdoqiM3nOJg0mhaxzdshc4Ak4H+EQNXIegtPrTks1EGsvK6Z8THEv2r1NsrtaXjWIkVFRVyB9L4NsusBJ0oxEZACpXvFk7Gn93U898zErwAonJObkgJEtn6BW
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 15:26:49.3118
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fadaa96-99e0-412c-acb4-08de9c95be8b
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS1EPF00000048.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB8641
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19414-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[huawei.com,lunn.ch,nvidia.com,redhat.com,vger.kernel.org,davemloft.net,google.com,kernel.org,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 202D941C989
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

This patch updates the documentation of ECN‑related GSO flags, it
clarifies the limitations of SKB_GSO_TCP_ECN and explains how to preserve
the CWR flag (part of the ACE signal) in the Rx path.

For Tx, SKB_GSO_TCP_ECN and SKB_GSO_TCP_ACCECN are used respectively for
RFC3168 ECN and AccECN (RFC9768). SKB_GSO_TCP_ECN indicates that the
first segment has CWR set, while subsequent segments have CWR cleared.
In contrast, SKB_GSO_TCP_ACCECN means that the segment uses AccECN and
therefore its CWR flag must not be modified during segmentation.

For RX, SKB_GSO_TCP_ECN shall NOT be used, because the stack cannot know
whether the connection uses RFC3168 ECN or AccECN, whereas RFC3168 ECN
offload may clear CWR flag and thus corrupts the ACE signal. Instead, any
segment that arrives with CWR set must use the SKB_GSO_TCP_ACCECN flag
to prevent RFC3168 ECN offload logic from clearing the CWR flag.

Co-developed-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/linux/skbuff.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 2bcf78a4de7b..9080a6d508a3 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -671,7 +671,13 @@ enum {
 	/* This indicates the skb is from an untrusted source. */
 	SKB_GSO_DODGY = 1 << 1,
 
-	/* This indicates the tcp segment has CWR set. */
+	/* For TX, this indicates that the first TCP segment has CWR set, and
+	 * any subsequent segment in the same skb has CWR cleared. This flag
+	 * must not be used in RX, because the connection to which the segment
+	 * belongs is not tracked to use RFC3168 or AccECN. Using RFC3168 ECN
+	 * offload may clear CWR and corrupt ACE signal (CWR is part of it).
+	 * Instead, SKB_GSO_TCP_ACCECN shall be used to avoid CWR corruption.
+	 */
 	SKB_GSO_TCP_ECN = 1 << 2,
 
 	__SKB_GSO_TCP_FIXEDID = 1 << 3,
@@ -706,6 +712,13 @@ enum {
 
 	SKB_GSO_FRAGLIST = 1 << 18,
 
+	/* For TX, this indicates that the TCP segment uses the CWR flag as part
+	 * of the ACE signal, and the CWR flag must not be modified in the skb.
+	 * For RX, any incoming segment with CWR set must use this flag so that
+	 * no RFC3168 ECN offload can clear the CWR flag. This is required to
+	 * preserve ACE signal correctness (CWR is part of it) in a forwarding
+	 * scenario, e.g., from one netdevice RX to other netdevice TX
+	 */
 	SKB_GSO_TCP_ACCECN = 1 << 19,
 
 	/* These indirectly map onto the same netdev feature.
-- 
2.34.1


