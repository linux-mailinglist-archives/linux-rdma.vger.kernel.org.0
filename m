Return-Path: <linux-rdma+bounces-22869-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id o8D6Fz6OTWpT2AEAu9opvQ
	(envelope-from <linux-rdma+bounces-22869-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Jul 2026 01:39:42 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5296B720727
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Jul 2026 01:39:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=oracle.com header.s=corp-2025-04-25 header.b=nGP2rKKN;
	dmarc=pass (policy=reject) header.from=oracle.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22869-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22869-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 72F2A300A24A
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2026 23:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE0237AA75;
	Tue,  7 Jul 2026 23:39:29 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC51F379EC8;
	Tue,  7 Jul 2026 23:39:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783467569; cv=none; b=sKwVq8Lnpo2F/Z5BTf7giJCcmd7HtYQbnkTjBocpU5kb7CcqOGzovmzF6qos7dPN8jAezruB54TlR2YRZf8FlshlSQfpIA+vu2VHroYSAeYZDq5F0a0VAuPx5aYMdrwFnzxzhFJ2REjOlIyFV0lRahy0zPYg6ihceJtgnJqcXMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783467569; c=relaxed/simple;
	bh=XmSZYpteiO4P6aiNokFtxVG4/ZTXiL0iFv5bH0jEpiU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DaAGcQvILD6MDirOrjoEusb4x8FRrjJDLigzS/tZyZYK1PNgr5XoaKfMDs4Q35FMVQvlp0Ojq1Z5+PT16l8QCJNwgMAz3A+Fq4gACstvfSlCesbfOfb9v21vQy1YWJDkOW7o5sr8gp7R4ImKGM9D+jA4OeKxy1nLSUgY4EoyVb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nGP2rKKN; arc=none smtp.client-ip=205.220.165.32
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 667JBcPG1376103;
	Tue, 7 Jul 2026 23:39:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=sxjbhGPBIqgVVqJCzfTryvOFJNy5B
	GsBTOu6R5Gshc8=; b=nGP2rKKNQ+nUd8S7qepTdyifwIJ4z/qOUCJi7oD/ppMGP
	z7EL+QnU3qjzoASGP1VCe1RVcWV6LrsOpuGYtIlmZHwmuElrI2d/3w0o3NyOqbuC
	1MEnuTPbO/ere3tHXSwLzslQ9gJa4WuXchclhg+4tu3ltzb52sY2kfZ+g516tN4f
	gjJwK61HVYf7tddNdgKHlcjnFZF7vg94uKZLVGTqFAyHRxYkcaveZiwUybkUlqLs
	IMXKdz6cWBeYsrCzGGyPNboGZOR+zhNnBJGuJo1DlluklimYVyxOOmtWbSiW16iT
	y7SCrB0VAeV4VqTzoVg3Zq04E/Ny26c2v9z/iGhxQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4f6rs1en4q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 Jul 2026 23:39:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 667Nch2B007571;
	Tue, 7 Jul 2026 23:39:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4f84vywusa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 Jul 2026 23:39:13 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 667NdCVU009154;
	Tue, 7 Jul 2026 23:39:12 GMT
Received: from mbpatil-ws.osdevelopmeniad.oraclevcn.com (mbpatil-ol10-ws.webad1iad.osdevelopmeniad.oraclevcn.com [100.100.228.95])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4f84vywus3-1;
	Tue, 07 Jul 2026 23:39:12 +0000 (GMT)
From: Manjunath Patil <manjunath.b.patil@oracle.com>
To: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
        Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
        netdev@vger.kernel.org
Cc: Manjunath Patil <manjunath.b.patil@oracle.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Patrisious Haddad <phaddad@nvidia.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH net v2] net/mlx5e: Use sender devcom for MPV master-up
Date: Tue,  7 Jul 2026 16:39:11 -0700
Message-ID: <20260707233911.3651139-1-manjunath.b.patil@oracle.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0 mlxscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607070232
X-Proofpoint-ORIG-GUID: OqmvzcRV48Hhv-kIVH8wqed3rek77pyZ
X-Proofpoint-GUID: OqmvzcRV48Hhv-kIVH8wqed3rek77pyZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDIzMiBTYWx0ZWRfX98drcER9Ra0a
 KRSs4/BxSwcf8a5X/XfzBok7kwQZbPYsAaU8mfuZCLGIcf/sCQpLzn8R8nAfdeMs9dUnW+vEA/y
 kUuqxjUYwCnDqFTuvSp3orANiVpvK9gLzykFT6xFvvLNq87tAYYyRKCTSx1OUpdjARweC8VVGx0
 g/y2sMODYfkl2xLtDlHZLpBOHFncCOdNw7Fpu8EwE5byJci6C2Du6jB1FhVPknD+quDB5IVRJOn
 uLkTP7eruzVyUhsuISiO41OBtxQVSqF5iPDdVUpx3uBq3iOt+gqbNrqYTsTNhwRBwVjU7VHiNBh
 ohJhEOLnEnX9yMYAQy69YgzzSs7Q0NiVUgWzgQhapqwHZGp/Efbv5VJdgjSYPY8IPaa4lSjLth3
 twXRp+YNrek8+53NbKRc6XzIldDngJORcSfp0jgu45Dhbf7BZmPrbIeYsJDr0mqpStDe9Fmdi+B
 oDFz7JlmmpDUj7ZVzJNp/c7d0tdvSoiuFGgN+G9w=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDIzMiBTYWx0ZWRfX46Ja22MijOuy
 Ftp2RO1ZEmMsg4DVvCABSnB/45etxYGJq9o3QZIYnQA0GRdQHX4h72HPJ3VdwkjH6sY1d8yXpZ2
 2kud1hjb9MKbPUozxxywUuZo6tGm5Vu300DrmVy8B+NCwFaq400A
X-Authority-Analysis: v=2.4 cv=Vu0Txe2n c=1 sm=1 tr=0 ts=6a4d8e22 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8
 a=JXUkVfB3YJkj4ag9OGkA:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:13633
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[oracle.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22869-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[manjunath.b.patil@oracle.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:saeedm@nvidia.com,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:leon@kernel.org,m:netdev@vger.kernel.org,m:manjunath.b.patil@oracle.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:phaddad@nvidia.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manjunath.b.patil@oracle.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oracle.com:from_mime,oracle.com:email,oracle.com:mid,oracle.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5296B720727

After PCIe DPC recovery, mlx5 reloads the affected functions and
replays multiport affiliation events. In the reported failure, the
first relevant device error was:

  pcieport 0000:10:01.1: DPC: containment event
  pcieport 0000:10:01.1: PCIe Bus Error: severity=Uncorrected (Fatal)
  pcieport 0000:10:01.1:    [ 5] SDES                   (First)

mlx5 recovered the PCI functions and resumed 0000:11:00.1. During
that resume, RDMA multiport binding replayed
MLX5_DRIVER_EVENT_AFFILIATION_DONE and mlx5e sent
MPV_DEVCOM_MASTER_UP. The host then panicked with:

  BUG: kernel NULL pointer dereference, address: 0000000000000010
  RIP: mlx5_devcom_comp_set_ready+0x5/0x40 [mlx5_core]
  RDI: 0000000000000000

Call trace included:

  mlx5_devcom_comp_set_ready
  mlx5e_devcom_event_mpv
  mlx5_devcom_send_event
  mlx5_ib_bind_slave_port
  mlx5r_mp_probe
  mlx5_pci_resume

MPV devcom registration publishes mlx5e private data to the component
peer list before mlx5e_devcom_init_mpv() stores the returned component
device in priv->devcom. A concurrent master-up event can therefore
reach a peer whose private data is visible but whose priv->devcom
backpointer is still NULL.

MPV_DEVCOM_MASTER_UP already carries the sender/master mlx5e private
data as event_data. The ready bit is stored on the shared devcom
component, not on an individual peer. Use the sender devcom when
marking the MPV component ready.

This preserves the readiness transition while avoiding a NULL
dereference of the peer devcom pointer during affiliation replay after
PCI error recovery.

Fixes: bf11485f8419 ("net/mlx5: Register mlx5e priv to devcom in MPV mode")
Assisted-by: Codex:gpt-5
Signed-off-by: Manjunath Patil <manjunath.b.patil@oracle.com>
Cc: stable@vger.kernel.org # 6.7+
---
v2:
- Drop defensive master_priv/master_priv->devcom check as suggested by Tariq.
- Resend as an independent thread per netdev posting rules.

 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 8f2b3abe0092..9b27afeb9b12 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -211,11 +211,11 @@ static void mlx5e_disable_async_events(struct mlx5e_priv *priv)
 
 static int mlx5e_devcom_event_mpv(int event, void *my_data, void *event_data)
 {
-	struct mlx5e_priv *slave_priv = my_data;
+	struct mlx5e_priv *master_priv = event_data;
 
 	switch (event) {
 	case MPV_DEVCOM_MASTER_UP:
-		mlx5_devcom_comp_set_ready(slave_priv->devcom, true);
+		mlx5_devcom_comp_set_ready(master_priv->devcom, true);
 		break;
 	case MPV_DEVCOM_MASTER_DOWN:
 		/* no need for comp set ready false since we unregister after

base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
-- 
2.47.3

