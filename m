Return-Path: <linux-rdma+bounces-20173-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMfoFfW1/Gn9SwAAu9opvQ
	(envelope-from <linux-rdma+bounces-20173-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 17:55:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FC64EB8E6
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 17:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 719103062C2C
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 15:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B530A3B583E;
	Thu,  7 May 2026 15:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Bcxx3vpZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1060A3F0756;
	Thu,  7 May 2026 15:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778168904; cv=none; b=nfth9YOExrgL3RFnXN2LaYcSXZTiw02GhCiLuf8vRb2jdTeP6EOHSYyYBw1b0hmrAKYBmpmH295bI/zxZkwt6Uj5906/WlYTHq8uq1gOaU43AnztUQeZB/fI+OqdExGKrDR0xsL1Lk8G2Eh8lAfmO6p/2jB/GYMXE1ZpdRfVOyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778168904; c=relaxed/simple;
	bh=HCXwR2EgdYdQ5gyCAVj4FQAbVrPx+R9g9EEWIVIt1C4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OMPB+S/GsxM+WKaUUH8bK8kTUiTr/2kTjZRl5LDIb6OCLbOK/dholRXFQkO+LQFk2OO5mjiZqztE4njOv3JTGapmCpLFL00tGqKz+LCBpHoOAKHJEd3QxuN2TrWskTJnDARYAT46TDpn2BjG9RJfWaXq6PhZKm9Q6t2qEGuSGk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Bcxx3vpZ; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647FMRBc4154776;
	Thu, 7 May 2026 15:48:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=Xx424qOwkvCbH/PgrZ2ip+esVWpmn
	8eGnY5DGbeBw48=; b=Bcxx3vpZqqY5GxmsKmy3YAIdPHChDvQoiKPmWxog+Wa3a
	AZZ1YQ7P0rD1RxHMCzS1uHEpdrHoTcn6RzARvF1wALOqRvMbMCGQ9j/RCsyAttZj
	qZmQxc5sSgU0pE360GJ5PUGiv1pl136UdgUUpjQ0dr8wICXQmh56Aucdfqo1eY/r
	eH+DiCoUV9cteV3nuOudd7JWk9m0pDv1fOR+1SxeSy8/Co0BIH9MRRrV/28RCDde
	sRJihZWs0NdVS00OGhLJdTsADdhAbJWCjZ6gqvJrVI6/Vfcj87VXDeS2pNGYAeB1
	xzhkYi4EMhaJA8ALfV98qaXww9fUQN942xFrJeVqQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dw9e1h7st-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 May 2026 15:48:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 647FkHle013479;
	Thu, 7 May 2026 15:48:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4dx578pmtb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 May 2026 15:48:10 +0000 (GMT)
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 647Fiv1b009129;
	Thu, 7 May 2026 15:48:09 GMT
Received: from pkannoju-dev-build.osdevelopmeniad.oraclevcn.com (pkannoju-dev-build.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.252.59])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4dx578pmrc-1;
	Thu, 07 May 2026 15:48:09 +0000 (GMT)
From: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
To: yishaih@nvidia.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: anand.a.khoje@oracle.com, manjunath.b.patil@oracle.com,
        Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
Subject: [PATCH] IB/mlx4: Fix stale CM id_map entries when RTU is never received
Date: Thu,  7 May 2026 15:47:55 +0000
Message-ID: <20260507154755.452008-1-praveen.kannoju@oracle.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2604200000 definitions=main-2605070158
X-Proofpoint-ORIG-GUID: 6kOyLCRWb78gaJRvPt4ii7CDZlwaSMqY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE1OCBTYWx0ZWRfXzmIBxETyCsyB
 Nq+IuQ16uRxlwau9y33Ri89XtuHjqbFiF4DItQNjoFZyQIHSZHfvNyV6GHZGnr4Z2woYFrrHPrH
 hVay4ujXvo9CkcaiuJoOEj3XJRD3VerOG1/ai4EJaS6wMSbWLMEOGVSa5apBnl9IvArNx0Z/d95
 TOLsG6uQIjuymG/tcB4D62dADAPYgqgXhn4yCwi/BrLUnd/vmyKzN6PwhJAv1GsFvtfZ3CjVciM
 uGrqu3zHk6ia9mm7r7+/ojGtehymc13L6Y9/LnSYZOa0nIzp6bxOd7lqU22Fat9kYKulYT+3sFC
 sEsna+XbOtgGXGpEKzHkISJxAhdt28Nvan7yFS0PPR7u3htJtLZvoXxCl9Nb0HlN4DwYE2IcV+w
 HQ7N2W9Lu5YH1T5GYLkDW2PnHHkGi8B70UhWWMZxvEgNl7kfSVbH2eKldOqBMu6JHMbULTNCIQn
 2C1Wi8gkmxdMt0bB37w==
X-Proofpoint-GUID: 6kOyLCRWb78gaJRvPt4ii7CDZlwaSMqY
X-Authority-Analysis: v=2.4 cv=OPAXGyaB c=1 sm=1 tr=0 ts=69fcb43b b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=yPCof4ZbAAAA:8 a=sUeeylVOQkeUVy8lLAsA:9
X-Rspamd-Queue-Id: E2FC64EB8E6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20173-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,oracle.com:mid,oracle.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praveen.kannoju@oracle.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[oracle.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

mlx4_ib_multiplex_cm_handler() allocates an id_map_entry for CM
transactions, but the entry is only released on DREQ or REJ flows.

In the duplicate REP handling scenario, cm_dup_rep_handler() may get
invoked when the remote side receives a REP for which no matching
cm_id_priv exists. In such cases the CM handshake never reaches RTU,
and the sender side may never receive either DREQ or REJ cleanup events.

As a result, the allocated id_map_entry remains indefinitely, resulting in
a stale mapping leak.

Fix this by scheduling delayed cleanup immediately after allocating the
id_map_entry. The delayed work is cancelled once CM_RTU_ATTR_ID is
received, indicating that the CM handshake completed successfully.

This ensures abandoned mappings are eventually reclaimed even when RTU is
never received.

Signed-off-by: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
---
 drivers/infiniband/hw/mlx4/cm.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/infiniband/hw/mlx4/cm.c b/drivers/infiniband/hw/mlx4/cm.c
index 63a868a3822f..700a840d491d 100644
--- a/drivers/infiniband/hw/mlx4/cm.c
+++ b/drivers/infiniband/hw/mlx4/cm.c
@@ -299,6 +299,7 @@ static void schedule_delayed(struct ib_device *ibdev, struct id_map_entry *id)
 }
 
 #define REJ_REASON(m) be16_to_cpu(((struct cm_generic_msg *)(m))->rej_reason)
+#define RTU_RECEIVE_TIMEOUT  (60 * HZ)
 int mlx4_ib_multiplex_cm_handler(struct ib_device *ibdev, int port, int slave_id,
 		struct ib_mad *mad)
 {
@@ -321,6 +322,9 @@ int mlx4_ib_multiplex_cm_handler(struct ib_device *ibdev, int port, int slave_id
 				__func__, slave_id, sl_cm_id);
 			return PTR_ERR(id);
 		}
+
+		schedule_delayed_work(&id->timeout, RTU_RECEIVE_TIMEOUT);
+
 	} else if (mad->mad_hdr.attr_id == CM_REJ_ATTR_ID ||
 		   mad->mad_hdr.attr_id == CM_SIDR_REP_ATTR_ID) {
 		return 0;
@@ -335,6 +339,9 @@ int mlx4_ib_multiplex_cm_handler(struct ib_device *ibdev, int port, int slave_id
 		return -EINVAL;
 	}
 
+	if (mad->mad_hdr.attr_id == CM_RTU_ATTR_ID)
+		cancel_delayed_work_sync(&id->timeout);
+
 cont:
 	set_local_comm_id(mad, id->pv_cm_id);
 
@@ -479,6 +486,9 @@ int mlx4_ib_demux_cm_handler(struct ib_device *ibdev, int port, int *slave,
 	    mad->mad_hdr.attr_id == CM_REJ_ATTR_ID)
 		schedule_delayed(ibdev, id);
 
+	if (mad->mad_hdr.attr_id == CM_RTU_ATTR_ID)
+		cancel_delayed_work_sync(&id->timeout);
+
 	return 0;
 }
 
-- 
2.43.7


