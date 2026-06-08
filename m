Return-Path: <linux-rdma+bounces-21990-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cPg4KHZTJ2pkuwIAu9opvQ
	(envelope-from <linux-rdma+bounces-21990-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 01:42:46 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CAE65B356
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 01:42:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=oracle.com header.s=corp-2025-04-25 header.b=jQDqKKxV;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21990-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21990-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=oracle.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 435C8304C4C3
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jun 2026 23:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83821340A46;
	Mon,  8 Jun 2026 23:42:44 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C950C45039;
	Mon,  8 Jun 2026 23:42:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780962164; cv=none; b=rK8d5F5polfBa70xJWWpCMsoIQQylImQYvNLUTH7Ih5Qb3Ps3N8JM1gqNBMOdcqG0MjAfIb6jr3XVcdcChharJYgnq2vaZQHgZDw9/4h8EfDMvtkXKrY5vP0I7rWWFHT6vsnJY/YvlGyN3dOGCAp423gY+SSrI+4qqVmhXvtNts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780962164; c=relaxed/simple;
	bh=zgiCaXxXGVRzgNP89cYzhPkqnsgSBl8IG1Ajr12h3M0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XHuFni/tnQCd5omjQeAnsSYSXZguKnsxC9EC5ASvlzHicsO0Zgwg3mkeLHaxdifkSmVgl5kp6mR+4xNPrY3nWCOH4yr66tIKD6mBhgqNBxIXUMsd0h2oAg3WBA3/DiBSiYNnEut07dN/VTYsAYnla1aEW1MJvdDldjNElSy1OvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jQDqKKxV; arc=none smtp.client-ip=205.220.177.32
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658HSdVc1690540;
	Mon, 8 Jun 2026 23:42:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=ZAa2C7ZECaKPgBj3Rx8eALxC14FMM
	ifdbPHRqlYnfpY=; b=jQDqKKxVvoNMm64LFI99ycrOmKy2use+gBnhrsMOyaS9q
	foxqDb+Puxc4CIPdEarhoXARsTwyc6Uwe5hxcOZYSDZ2qwKl5BZA6yaqQPB4yTP/
	Y1rSqJRXGNRUIKIExLSf6TNSZhwu0txSZh20iGIiPLwiYdNacCN+3vyb6zepVI4X
	5ALSPQuj3nhut0c5Ss1CpXcWx+52WO2TKtzQzzouBOzvv9BXyPwVHgy94IUENzJ6
	4mLlNcFTRXNpvDCIB5vKkjo3coxaCyaIFwSXC9dXyQp5rHp5kdTAD7Yz/f06fnyv
	iRvmrTNSrF0Bppxpxobgt0yBNOljnWkzmlgxc4mtA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4emab4kefg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jun 2026 23:42:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 658NSXbZ001362;
	Mon, 8 Jun 2026 23:42:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ema0pdxdx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jun 2026 23:42:24 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 658NgOrx035097;
	Mon, 8 Jun 2026 23:42:24 GMT
Received: from mbpatil-ws.osdevelopmeniad.oraclevcn.com (mbpatil-ol10-ws.webad1iad.osdevelopmeniad.oraclevcn.com [100.100.228.95])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4ema0pdxdg-1;
	Mon, 08 Jun 2026 23:42:24 +0000 (GMT)
From: Manjunath Patil <manjunath.b.patil@oracle.com>
To: netdev@vger.kernel.org
Cc: saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com, leon@kernel.org,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, manjunath.b.patil@oracle.com
Subject: [PATCH net-next] net/mlx5e: Report link down on administrative close
Date: Mon,  8 Jun 2026 16:42:23 -0700
Message-ID: <20260608234223.3731557-1-manjunath.b.patil@oracle.com>
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
 definitions=2026-06-08_06,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605130000 definitions=main-2606080216
X-Authority-Analysis: v=2.4 cv=cL/QdFeN c=1 sm=1 tr=0 ts=6a275361 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=yPCof4ZbAAAA:8 a=lZAZS3N-niQ3KQdCBw4A:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13723
X-Proofpoint-GUID: kv4sTv3mVoJiexyZRQrL7pzipiJT9XP-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDIxOCBTYWx0ZWRfXzdhKGvQjEc14
 +I5ltglk/BtuK0Doz5JgXriE89bw5tIoxdLTmk7TOCWKe9k7OnAKf+8XZaiF1Cy/24NCuTLk4Yb
 nZZE+J4A7eMmD/oHSGThAyMVzgMDOT8A9UmkJrzZl9N8wYRLiqRHomFsR8SXBhmQUIyDfErQQF7
 qcEdNjcexw+4bFXhcBTDyk3PJadFwPBNbRLP5rtLgwbErIPHtpNfrrfMWs3gOJTQR3NQ8EZBJwO
 nqWv/qrlGmB0rJ1vk3GPUi3tbqQO907ioATWR0exWUpavxPLr4xukmErqJd21ls30ASNcSvjApl
 mNbZS2GN2G97ClJC1y5f5aVy2Mmf03n8HofaIvr0vtsey8NbBGFt/aF0oe/+YuQaKBlnQtgz9iM
 kLMvsjLUOTmUVgqIekLxKRHpILDjRIqwERtjTRgVzkyx37tM9PA9hidlv4iUIgeHTdvzqXoTEKu
 kZRmpGmfrqawzoCMLaGvioo7A5usQL0O7krUflvo=
X-Proofpoint-ORIG-GUID: kv4sTv3mVoJiexyZRQrL7pzipiJT9XP-
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21990-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[manjunath.b.patil@oracle.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:saeedm@nvidia.com,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:leon@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:manjunath.b.patil@oracle.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manjunath.b.patil@oracle.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oracle.com:dkim,oracle.com:email,oracle.com:mid,oracle.com:from_mime];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 30CAE65B356

mlx5e_update_carrier() reports both link-up and link-down carrier
changes, but an administrative down does not reach it in practice. The
close path first changes the port admin state and then clears
MLX5E_STATE_OPENED and drops carrier silently in mlx5e_close_locked().
Any queued carrier worker will skip update_carrier() once the device is
no longer opened.

This leaves "ip link set dev <dev> down" without a matching netdev
"Link down" message, while reopening the device still reports "Link up".

Report the link-down transition in mlx5e_close() before the common close
helper clears the opened state and drops carrier. Guard the message with
the current opened and carrier state to avoid duplicates when the netdev
is already closed or carrier is already down.

Assisted-by: Codex:gpt-5
Signed-off-by: Manjunath Patil <manjunath.b.patil@oracle.com>
---
Validation:
- Built an OL8 mainline test kernel from this change.
- Booted 7.1.0-rc6.bug123456.el8.v1.x86_64 on an mlx5-backed VM.
- Confirmed `ip link set dev re0 down/up` and `re1 down/up` now emit
  netdev `Link down` and `Link up` messages, alongside the existing RDMA
  port state notifications.

 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 8f2b3abe0092..a04a89f0eddf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -3628,6 +3628,9 @@ int mlx5e_close(struct net_device *netdev)
 
 	mutex_lock(&priv->state_lock);
 	mlx5e_modify_admin_state(priv->mdev, MLX5_PORT_DOWN);
+	if (test_bit(MLX5E_STATE_OPENED, &priv->state) &&
+	    netif_carrier_ok(netdev))
+		netdev_info(netdev, "Link down\n");
 	err = mlx5e_close_locked(netdev);
 	mutex_unlock(&priv->state_lock);
 

base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
-- 
2.47.3

