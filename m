Return-Path: <linux-rdma+bounces-22867-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zWXxJhSNTWoJ2AEAu9opvQ
	(envelope-from <linux-rdma+bounces-22867-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Jul 2026 01:34:44 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1580A7206CE
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Jul 2026 01:34:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=oracle.com header.s=corp-2025-04-25 header.b=TONy3GhC;
	dmarc=pass (policy=reject) header.from=oracle.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22867-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22867-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DF90304A9DF
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2026 23:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C8A36EA98;
	Tue,  7 Jul 2026 23:34:02 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841C23093DF;
	Tue,  7 Jul 2026 23:34:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783467242; cv=none; b=MzCJ/N/zyK8tlPVeY7NVreAbWnOP61udbp9heb4R43mwD6JEgwuYrD3qQ8Ph2Pf0o43cpvN1eYYGhUwCrNXUbtM+E12wqd9c3KdScNq6XM93UDccN0QQeFgmIQVw0jisTW3qwdgtp+gVTLnvJRSu/UCiMN9SF5FV41xWn/FGIYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783467242; c=relaxed/simple;
	bh=4IKLks/ucOA2auXD2KLMR9GT/BPTMyC9nZ/pdpCputg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NeBz8XiYNbTaakO04YqATu8FHC5ErAU5XLMeo/4TNXwM9wovOIA1PKcECT7WQLgjWPoGyPOg969WTGb31ZArujVdAIPAvVu57k53YHnVkn47nPWLDOS+iTYX/zBMRgMpb8rpnbPwyOHERdz+BxPDIHxM8wB1ElK8W03xZZ/0Q3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TONy3GhC; arc=none smtp.client-ip=205.220.177.32
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 667JCPva1347545;
	Tue, 7 Jul 2026 23:33:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=igrpj
	jJQUd+/3TCJOxayjEdZm97gP08Q/nEq7T9dCWs=; b=TONy3GhCIpCyKpqmFFVrA
	1MG8TK+bHWVR1PhIZoYms0TERlkCwi87YnyNmaXZpPxQLn2WsFoBxBScQ7E35OvK
	ZDzlw9Lzm19ioTmDFA6gNjMMjBNfiilNaWqtXWg8jxrZE9bCnaM4G5rU+ifvvia7
	2Ya16Yrfe/5Eay06KExyESYMSq2GVatif7jRPTu0znrJFrL0dXWyDoUlYKCAvDxp
	O2H87f7rgMJcEAQeH01DH6kTQwFnTC3tuEbPM89bBGg+HgR020+cEroOOiBfk5Ah
	TwRptbdpW2BGo54j/3xBPOwc6SyWIFnEOUAVeXDCt18GHfjUHw/b+LyZIddJKP1l
	w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4f6rkbeqvr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 Jul 2026 23:33:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 667NXblx027095;
	Tue, 7 Jul 2026 23:33:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4f6rmr37j1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 Jul 2026 23:33:46 +0000 (GMT)
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 667NXjpv028202;
	Tue, 7 Jul 2026 23:33:45 GMT
Received: from mbpatil-ws.osdevelopmeniad.oraclevcn.com (mbpatil-ol10-ws.webad1iad.osdevelopmeniad.oraclevcn.com [100.100.228.95])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4f6rmr37gg-1;
	Tue, 07 Jul 2026 23:33:45 +0000 (GMT)
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
Date: Tue,  7 Jul 2026 16:33:37 -0700
Message-ID: <20260707233337.3650025-1-manjunath.b.patil@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260610173915.4053423-1-manjunath.b.patil@oracle.com>
References: 
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 adultscore=0 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607070231
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDIzMSBTYWx0ZWRfX4sekCjK1gNAZ
 QfpXJvUjUW1ubt/5/K0wfgEXhPPfG9rltDFRFDlAacmWTW9jl2Mr+W0SMMKQomSG6vgYINh3x1t
 7jnmLt82MFWNyy3GY2cBNYY5zSGCp5B70ImiaELAxip7pLz5A1m6
X-Authority-Analysis: v=2.4 cv=QP1YgALL c=1 sm=1 tr=0 ts=6a4d8cdb b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8
 a=JXUkVfB3YJkj4ag9OGkA:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:12222
X-Proofpoint-GUID: 3Rm26ahq8YpeFLvGo3iYoOo9mZdWgpRx
X-Proofpoint-ORIG-GUID: 3Rm26ahq8YpeFLvGo3iYoOo9mZdWgpRx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDIzMSBTYWx0ZWRfXwE0VWMd3mEQk
 jZWl4eQToT5eO5BKmyFa7pPuo+GnZMf9MqGDBAPBrBkEKAq4kem8Bdyw7g16DqY2ShLrsEGhfxX
 zhYDxBzxtGqDYVBSkU0KFnn/NdviWGMR1I2sHPwZuR6iF4pUV/DnxM4gAtbksf5KHcW6bUYU3eD
 U0v7ueRi72G5lLgXnJT3vUU19wvMcaeGxMI0LnXAzX6YC2avaL/Y97TeExnFmDPYqRSh08eCM6d
 +c5T0s0wVhTz45c6ka6GmtFYNpyaUaPvvGQMEhBCvChCOmmcSJLvOb3fKTebMODiXFDLVfUmmwv
 iTI6W04a88x0Xi+WpRIR1Rr6+jAZA1dkk7/bzgD9bINHQvHNozxa6q+1jZtyrDN7s5BlosndQNr
 U4/hKywlDkeRf+7aCNkc62KSYOcFyluAT7I4+BSuoLNMjNyKft96gJeXhhL/IHo+jONKkpyB3im
 oVav9JIQpR8+VciMGlL8z3dS7b6Ncv7oYPjH9vTw=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[oracle.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22867-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[manjunath.b.patil@oracle.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:saeedm@nvidia.com,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:leon@kernel.org,m:netdev@vger.kernel.org,m:manjunath.b.patil@oracle.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:phaddad@nvidia.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manjunath.b.patil@oracle.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:from_mime,oracle.com:email,oracle.com:mid,oracle.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1580A7206CE

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

