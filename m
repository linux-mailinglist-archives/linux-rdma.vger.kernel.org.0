Return-Path: <linux-rdma+bounces-22088-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gEhmEOehKWoDbAMAu9opvQ
	(envelope-from <linux-rdma+bounces-22088-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 19:41:59 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AD266C04F
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 19:41:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=oracle.com header.s=corp-2025-04-25 header.b="CGVsG/EJ";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22088-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22088-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=oracle.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2ADD43028800
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 17:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEDF349CFA;
	Wed, 10 Jun 2026 17:39:34 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EBF222582;
	Wed, 10 Jun 2026 17:39:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781113173; cv=none; b=OZDYtw8XbPIa2kDvKxvXAO/IL3ybmOXXagHS1ZxbpUSHzm4vqDWVwlO/HLX0lyZi4kYyq/QgjWNFgcnkaX20JyezCCjxxJiHuwE762qwi+sLnPBsetpNO+DXVQh4hmb6CbKD0OnyzoIBWhDC6Er9uOlu+/FVmr0xtzvyJ1l7I/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781113173; c=relaxed/simple;
	bh=mFsPdIQNmumD6FdOZ1f3tsuWa3qRREaX+mUfFjjJrVM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RJTF9mM6MoNchMwFTI1Uis4ZoX1QO95mbIA7sZQwty93+HaNxNxVr+otJXThFOxqWhEAHOEOhPSWmINpI0MF8eNYJdbt6PQEa83Q7aPZXan/g9gIV6sv/1WFvNalYRaGmNwDWOkq9VJnbCOjgcFRQ78oeWEHWMGvLzi6uWEa4LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CGVsG/EJ; arc=none smtp.client-ip=205.220.177.32
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65ADulOL140590;
	Wed, 10 Jun 2026 17:39:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=KYcM7IBQoilglZiFsT2AYDGdPiR3Z
	d59yAtoqkqCQaE=; b=CGVsG/EJZlJzknu1fMkTXnuvXp7Mr0jd3VMZdEZo5iUPI
	X/ej4PJH61hpJoRLZ1nUrn3Ubwx1s/l1ajxWfsBNb8MO6H8+70BAP15VNU88qrxg
	eQLNAW2rfRTrxYJ05Q9QCk9gwoBvRWdqNtDNJRifdE6L9DvsTUA7QuQe9QPZH/7E
	n5H1Ryg0fo1g79VPPcE1m36dv3mgKog/yBPlimsGVDA6DuSwlVH0/EeSObnG885D
	E09elU48TWLE2ZO8rjzFeiOSJOsNwtOKzN0e96w+7PFQGrm7YiPA2u1WLu6S5gnf
	9qjI65JJ4aIAbMWdry5QG9NkM7DN3IHNy8Qsli0dw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4embkjf5e2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 17:39:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65AHXBvJ028974;
	Wed, 10 Jun 2026 17:39:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4eqbqftdda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 17:39:18 +0000 (GMT)
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 65AHbHKj011533;
	Wed, 10 Jun 2026 17:39:17 GMT
Received: from mbpatil-ws.osdevelopmeniad.oraclevcn.com (mbpatil-ol10-ws.webad1iad.osdevelopmeniad.oraclevcn.com [100.100.228.95])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4eqbqftdcg-1;
	Wed, 10 Jun 2026 17:39:17 +0000 (GMT)
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
Subject: [PATCH net] net/mlx5e: Use sender devcom for MPV master-up
Date: Wed, 10 Jun 2026 10:39:15 -0700
Message-ID: <20260610173915.4053423-1-manjunath.b.patil@oracle.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605130000 definitions=main-2606100166
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDE2NiBTYWx0ZWRfX5k9kQImBYMJb
 TMnA5U8R2f/ilo5tGIBLsZOBGtQpXW/f1VA7Ezklmbh8vd0LZEpKoW82H6n/TnfbcP1d9RDy28P
 A5eORAeKQXS9F6vyr4KHmiOdxfaaOnrb5Zwp3zdgAEyKMuqG/iupBtskzaIosIetTg+20JwhziR
 QLQ+spAy96a/vM5bQnfy2vMl2pc3Op7aqgltz1KuQ17O4bPhPuUOHn/IjtYynVeF2eoaQaHajIT
 bRcePuOjn5svN4ijB8TFM65Oi4GRuxs3ThzUFClYtbQ7nbLmW65Xqq1UKRPA+ykYkVyx4k09LYf
 Za1nkOXPA1tPCq+4zjTjGCG6Kf8AwZG3m1JlL87tzFOqcLE6hNLt1VbYjWZRmSCLjfW4erRuuDq
 7ICJ4z9sK8fu9ZcBReuJwwdAN5XVhUpFnX8AYrKs9w62HUPHstFHQ8ng+YMjRkheZ7y1j2j4AjI
 j5T+wUcwha70ZaEAu8w==
X-Authority-Analysis: v=2.4 cv=ROSD2Yi+ c=1 sm=1 tr=0 ts=6a29a148 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8
 a=JXUkVfB3YJkj4ag9OGkA:9
X-Proofpoint-GUID: kFF8KusQBGovR0sKGsMd2h_cailNstJk
X-Proofpoint-ORIG-GUID: kFF8KusQBGovR0sKGsMd2h_cailNstJk
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[oracle.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22088-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[manjunath.b.patil@oracle.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:saeedm@nvidia.com,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:leon@kernel.org,m:netdev@vger.kernel.org,m:manjunath.b.patil@oracle.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:phaddad@nvidia.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manjunath.b.patil@oracle.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,oracle.com:dkim,oracle.com:email,oracle.com:mid,oracle.com:from_mime];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B1AD266C04F

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
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 8f2b3abe0092..f7ff20b97e8c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -211,11 +211,14 @@ static void mlx5e_disable_async_events(struct mlx5e_priv *priv)
 
 static int mlx5e_devcom_event_mpv(int event, void *my_data, void *event_data)
 {
-	struct mlx5e_priv *slave_priv = my_data;
+	struct mlx5e_priv *master_priv = event_data;
 
 	switch (event) {
 	case MPV_DEVCOM_MASTER_UP:
-		mlx5_devcom_comp_set_ready(slave_priv->devcom, true);
+		if (!master_priv || !master_priv->devcom)
+			return -EINVAL;
+
+		mlx5_devcom_comp_set_ready(master_priv->devcom, true);
 		break;
 	case MPV_DEVCOM_MASTER_DOWN:
 		/* no need for comp set ready false since we unregister after
-- 
2.47.3


