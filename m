Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1134399D09
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Aug 2019 19:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405003AbfHVRjO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Aug 2019 13:39:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46818 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404157AbfHVRjN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 22 Aug 2019 13:39:13 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7MHd4wA096756
        for <linux-rdma@vger.kernel.org>; Thu, 22 Aug 2019 13:39:13 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uhy8wgtqe-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Thu, 22 Aug 2019 13:39:10 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-rdma@vger.kernel.org> from <bmt@zurich.ibm.com>;
        Thu, 22 Aug 2019 18:37:44 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 22 Aug 2019 18:37:41 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7MHbebY60227714
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Aug 2019 17:37:40 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE4BFA404D;
        Thu, 22 Aug 2019 17:37:40 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D55DA4040;
        Thu, 22 Aug 2019 17:37:40 +0000 (GMT)
Received: from spoke.zurich.ibm.com (unknown [9.4.69.152])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 22 Aug 2019 17:37:40 +0000 (GMT)
From:   Bernard Metzler <bmt@zurich.ibm.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@ziepe.ca, geert@linux-m68k.org, dledford@redhat.com,
        leon@kernel.org, Bernard Metzler <bmt@zurich.ibm.com>
Subject: [PATCH v3] RDMA/siw: Fix 64/32bit pointer inconsistency
Date:   Thu, 22 Aug 2019 19:37:38 +0200
X-Mailer: git-send-email 2.17.2
X-TM-AS-GCONF: 00
x-cbid: 19082217-4275-0000-0000-0000035C09BC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082217-4276-0000-0000-0000386E30AB
Message-Id: <20190822173738.26817-1-bmt@zurich.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-22_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908220158
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes improper casting between addresses and unsigned types.
Changes siw_pbl_get_buffer() function to return appropriate
dma_addr_t, and not u64.

Also fixes debug prints. Now any potentially kernel private
pointers are printed formatted as '%pK', to allow keeping that
information secret.

Fixes: d941bfe500be ("RDMA/siw: Change CQ flags from 64->32 bits")
Fixes: b0fff7317bb4 ("rdma/siw: completion queue methods")
Fixes: 8b6a361b8c48 ("rdma/siw: receive path")
Fixes: b9be6f18cf9e ("rdma/siw: transmit path")
Fixes: f29dd55b0236 ("rdma/siw: queue pair methods")
Fixes: 2251334dcac9 ("rdma/siw: application buffer management")
Fixes: 303ae1cdfdf7 ("rdma/siw: application interface")
Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
Fixes: a531975279f3 ("rdma/siw: main include file")

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reported-by: Jason Gunthorpe <jgg@ziepe.ca>
Reported-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
---
 drivers/infiniband/sw/siw/siw.h       |  8 +--
 drivers/infiniband/sw/siw/siw_cm.c    | 74 ++++++++++++---------------
 drivers/infiniband/sw/siw/siw_cq.c    |  5 +-
 drivers/infiniband/sw/siw/siw_mem.c   | 14 ++---
 drivers/infiniband/sw/siw/siw_mem.h   |  2 +-
 drivers/infiniband/sw/siw/siw_qp.c    |  2 +-
 drivers/infiniband/sw/siw/siw_qp_rx.c | 26 +++++-----
 drivers/infiniband/sw/siw/siw_qp_tx.c | 43 ++++++++--------
 drivers/infiniband/sw/siw/siw_verbs.c | 40 +++++++--------
 9 files changed, 106 insertions(+), 108 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
index 77b1aabf6ff3..dba4535494ab 100644
--- a/drivers/infiniband/sw/siw/siw.h
+++ b/drivers/infiniband/sw/siw/siw.h
@@ -138,9 +138,9 @@ struct siw_umem {
 };
 
 struct siw_pble {
-	u64 addr; /* Address of assigned user buffer */
-	u64 size; /* Size of this entry */
-	u64 pbl_off; /* Total offset from start of PBL */
+	dma_addr_t addr; /* Address of assigned buffer */
+	unsigned int size; /* Size of this entry */
+	unsigned long pbl_off; /* Total offset from start of PBL */
 };
 
 struct siw_pbl {
@@ -734,7 +734,7 @@ static inline void siw_crc_skb(struct siw_rx_stream *srx, unsigned int len)
 		  "MEM[0x%08x] %s: " fmt, mem->stag, __func__, ##__VA_ARGS__)
 
 #define siw_dbg_cep(cep, fmt, ...)                                             \
-	ibdev_dbg(&cep->sdev->base_dev, "CEP[0x%p] %s: " fmt,                  \
+	ibdev_dbg(&cep->sdev->base_dev, "CEP[0x%pK] %s: " fmt,                  \
 		  cep, __func__, ##__VA_ARGS__)
 
 void siw_cq_flush(struct siw_cq *cq);
diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 9ce8a1b925d2..ae7ea3ad7224 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -355,8 +355,8 @@ static int siw_cm_upcall(struct siw_cep *cep, enum iw_cm_event_type reason,
 		getname_local(cep->sock, &event.local_addr);
 		getname_peer(cep->sock, &event.remote_addr);
 	}
-	siw_dbg_cep(cep, "[QP %u]: id 0x%p, reason=%d, status=%d\n",
-		    cep->qp ? qp_id(cep->qp) : -1, id, reason, status);
+	siw_dbg_cep(cep, "[QP %u]: reason=%d, status=%d\n",
+		    cep->qp ? qp_id(cep->qp) : -1, reason, status);
 
 	return id->event_handler(id, &event);
 }
@@ -947,8 +947,6 @@ static void siw_accept_newconn(struct siw_cep *cep)
 	siw_cep_get(new_cep);
 	new_s->sk->sk_user_data = new_cep;
 
-	siw_dbg_cep(cep, "listen socket 0x%p, new 0x%p\n", s, new_s);
-
 	if (siw_tcp_nagle == false) {
 		int val = 1;
 
@@ -1145,9 +1143,9 @@ static void siw_cm_work_handler(struct work_struct *w)
 	}
 	if (release_cep) {
 		siw_dbg_cep(cep,
-			    "release: timer=%s, QP[%u], id 0x%p\n",
+			    "release: timer=%s, QP[%u]\n",
 			    cep->mpa_timer ? "y" : "n",
-			    cep->qp ? qp_id(cep->qp) : -1, cep->cm_id);
+			    cep->qp ? qp_id(cep->qp) : -1);
 
 		siw_cancel_mpatimer(cep);
 
@@ -1211,8 +1209,8 @@ int siw_cm_queue_work(struct siw_cep *cep, enum siw_work_type type)
 		else
 			delay = MPAREP_TIMEOUT;
 	}
-	siw_dbg_cep(cep, "[QP %u]: work type: %d, work 0x%p, timeout %lu\n",
-		    cep->qp ? qp_id(cep->qp) : -1, type, work, delay);
+	siw_dbg_cep(cep, "[QP %u]: work type: %d, timeout %lu\n",
+		    cep->qp ? qp_id(cep->qp) : -1, type, delay);
 
 	queue_delayed_work(siw_cm_wq, &work->work, delay);
 
@@ -1376,16 +1374,16 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 	}
 	if (v4)
 		siw_dbg_qp(qp,
-			   "id 0x%p, pd_len %d, laddr %pI4 %d, raddr %pI4 %d\n",
-			   id, pd_len,
+			   "pd_len %d, laddr %pI4 %d, raddr %pI4 %d\n",
+			   pd_len,
 			   &((struct sockaddr_in *)(laddr))->sin_addr,
 			   ntohs(((struct sockaddr_in *)(laddr))->sin_port),
 			   &((struct sockaddr_in *)(raddr))->sin_addr,
 			   ntohs(((struct sockaddr_in *)(raddr))->sin_port));
 	else
 		siw_dbg_qp(qp,
-			   "id 0x%p, pd_len %d, laddr %pI6 %d, raddr %pI6 %d\n",
-			   id, pd_len,
+			   "pd_len %d, laddr %pI6 %d, raddr %pI6 %d\n",
+			   pd_len,
 			   &((struct sockaddr_in6 *)(laddr))->sin6_addr,
 			   ntohs(((struct sockaddr_in6 *)(laddr))->sin6_port),
 			   &((struct sockaddr_in6 *)(raddr))->sin6_addr,
@@ -1508,8 +1506,7 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 	if (rv >= 0) {
 		rv = siw_cm_queue_work(cep, SIW_CM_WORK_MPATIMEOUT);
 		if (!rv) {
-			siw_dbg_cep(cep, "id 0x%p, [QP %u]: exit\n", id,
-				    qp_id(qp));
+			siw_dbg_cep(cep, "[QP %u]: exit\n", qp_id(qp));
 			siw_cep_set_free(cep);
 			return 0;
 		}
@@ -1580,7 +1577,7 @@ int siw_accept(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 	siw_cancel_mpatimer(cep);
 
 	if (cep->state != SIW_EPSTATE_RECVD_MPAREQ) {
-		siw_dbg_cep(cep, "id 0x%p: out of state\n", id);
+		siw_dbg_cep(cep, "out of state\n");
 
 		siw_cep_set_free(cep);
 		siw_cep_put(cep);
@@ -1601,7 +1598,7 @@ int siw_accept(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 		up_write(&qp->state_lock);
 		goto error;
 	}
-	siw_dbg_cep(cep, "id 0x%p\n", id);
+	siw_dbg_cep(cep, "[QP %d]\n", params->qpn);
 
 	if (try_gso && cep->mpa.hdr.params.bits & MPA_RR_FLAG_GSO_EXP) {
 		siw_dbg_cep(cep, "peer allows GSO on TX\n");
@@ -1611,8 +1608,8 @@ int siw_accept(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 	    params->ird > sdev->attrs.max_ird) {
 		siw_dbg_cep(
 			cep,
-			"id 0x%p, [QP %u]: ord %d (max %d), ird %d (max %d)\n",
-			id, qp_id(qp), params->ord, sdev->attrs.max_ord,
+			"[QP %u]: ord %d (max %d), ird %d (max %d)\n",
+			qp_id(qp), params->ord, sdev->attrs.max_ord,
 			params->ird, sdev->attrs.max_ird);
 		rv = -EINVAL;
 		up_write(&qp->state_lock);
@@ -1624,8 +1621,8 @@ int siw_accept(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 	if (params->private_data_len > max_priv_data) {
 		siw_dbg_cep(
 			cep,
-			"id 0x%p, [QP %u]: private data length: %d (max %d)\n",
-			id, qp_id(qp), params->private_data_len, max_priv_data);
+			"[QP %u]: private data length: %d (max %d)\n",
+			qp_id(qp), params->private_data_len, max_priv_data);
 		rv = -EINVAL;
 		up_write(&qp->state_lock);
 		goto error;
@@ -1679,7 +1676,7 @@ int siw_accept(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 		qp_attrs.flags = SIW_MPA_CRC;
 	qp_attrs.state = SIW_QP_STATE_RTS;
 
-	siw_dbg_cep(cep, "id 0x%p, [QP%u]: moving to rts\n", id, qp_id(qp));
+	siw_dbg_cep(cep, "[QP%u]: moving to rts\n", qp_id(qp));
 
 	/* Associate QP with CEP */
 	siw_cep_get(cep);
@@ -1700,8 +1697,8 @@ int siw_accept(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 	if (rv)
 		goto error;
 
-	siw_dbg_cep(cep, "id 0x%p, [QP %u]: send mpa reply, %d byte pdata\n",
-		    id, qp_id(qp), params->private_data_len);
+	siw_dbg_cep(cep, "[QP %u]: send mpa reply, %d byte pdata\n",
+		    qp_id(qp), params->private_data_len);
 
 	rv = siw_send_mpareqrep(cep, params->private_data,
 				params->private_data_len);
@@ -1759,14 +1756,14 @@ int siw_reject(struct iw_cm_id *id, const void *pdata, u8 pd_len)
 	siw_cancel_mpatimer(cep);
 
 	if (cep->state != SIW_EPSTATE_RECVD_MPAREQ) {
-		siw_dbg_cep(cep, "id 0x%p: out of state\n", id);
+		siw_dbg_cep(cep, "out of state\n");
 
 		siw_cep_set_free(cep);
 		siw_cep_put(cep); /* put last reference */
 
 		return -ECONNRESET;
 	}
-	siw_dbg_cep(cep, "id 0x%p, cep->state %d, pd_len %d\n", id, cep->state,
+	siw_dbg_cep(cep, "cep->state %d, pd_len %d\n", cep->state,
 		    pd_len);
 
 	if (__mpa_rr_revision(cep->mpa.hdr.params.bits) >= MPA_REVISION_1) {
@@ -1804,14 +1801,14 @@ static int siw_listen_address(struct iw_cm_id *id, int backlog,
 	rv = kernel_setsockopt(s, SOL_SOCKET, SO_REUSEADDR, (char *)&s_val,
 			       sizeof(s_val));
 	if (rv) {
-		siw_dbg(id->device, "id 0x%p: setsockopt error: %d\n", id, rv);
+		siw_dbg(id->device, "setsockopt error: %d\n", rv);
 		goto error;
 	}
 	rv = s->ops->bind(s, laddr, addr_family == AF_INET ?
 				    sizeof(struct sockaddr_in) :
 				    sizeof(struct sockaddr_in6));
 	if (rv) {
-		siw_dbg(id->device, "id 0x%p: socket bind error: %d\n", id, rv);
+		siw_dbg(id->device, "socket bind error: %d\n", rv);
 		goto error;
 	}
 	cep = siw_cep_alloc(sdev);
@@ -1824,13 +1821,13 @@ static int siw_listen_address(struct iw_cm_id *id, int backlog,
 	rv = siw_cm_alloc_work(cep, backlog);
 	if (rv) {
 		siw_dbg(id->device,
-			"id 0x%p: alloc_work error %d, backlog %d\n", id,
+			"alloc_work error %d, backlog %d\n",
 			rv, backlog);
 		goto error;
 	}
 	rv = s->ops->listen(s, backlog);
 	if (rv) {
-		siw_dbg(id->device, "id 0x%p: listen error %d\n", id, rv);
+		siw_dbg(id->device, "listen error %d\n", rv);
 		goto error;
 	}
 	cep->cm_id = id;
@@ -1914,8 +1911,7 @@ static void siw_drop_listeners(struct iw_cm_id *id)
 
 		list_del(p);
 
-		siw_dbg_cep(cep, "id 0x%p: drop cep, state %d\n", id,
-			    cep->state);
+		siw_dbg_cep(cep, "drop cep, state %d\n", cep->state);
 
 		siw_cep_set_inuse(cep);
 
@@ -1952,7 +1948,7 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
 	struct net_device *dev = to_siw_dev(id->device)->netdev;
 	int rv = 0, listeners = 0;
 
-	siw_dbg(id->device, "id 0x%p: backlog %d\n", id, backlog);
+	siw_dbg(id->device, "backlog %d\n", backlog);
 
 	/*
 	 * For each attached address of the interface, create a
@@ -1968,8 +1964,8 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
 		s_raddr = (struct sockaddr_in *)&id->remote_addr;
 
 		siw_dbg(id->device,
-			"id 0x%p: laddr %pI4:%d, raddr %pI4:%d\n",
-			id, &s_laddr.sin_addr, ntohs(s_laddr.sin_port),
+			"laddr %pI4:%d, raddr %pI4:%d\n",
+			&s_laddr.sin_addr, ntohs(s_laddr.sin_port),
 			&s_raddr->sin_addr, ntohs(s_raddr->sin_port));
 
 		rtnl_lock();
@@ -1994,8 +1990,8 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
 			*s_raddr = &to_sockaddr_in6(id->remote_addr);
 
 		siw_dbg(id->device,
-			"id 0x%p: laddr %pI6:%d, raddr %pI6:%d\n",
-			id, &s_laddr->sin6_addr, ntohs(s_laddr->sin6_port),
+			"laddr %pI6:%d, raddr %pI6:%d\n",
+			&s_laddr->sin6_addr, ntohs(s_laddr->sin6_port),
 			&s_raddr->sin6_addr, ntohs(s_raddr->sin6_port));
 
 		read_lock_bh(&in6_dev->lock);
@@ -2028,17 +2024,15 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
 	else if (!rv)
 		rv = -EINVAL;
 
-	siw_dbg(id->device, "id 0x%p: %s\n", id, rv ? "FAIL" : "OK");
+	siw_dbg(id->device, "%s\n", rv ? "FAIL" : "OK");
 
 	return rv;
 }
 
 int siw_destroy_listen(struct iw_cm_id *id)
 {
-	siw_dbg(id->device, "id 0x%p\n", id);
-
 	if (!id->provider_data) {
-		siw_dbg(id->device, "id 0x%p: no cep(s)\n", id);
+		siw_dbg(id->device, "no cep(s)\n");
 		return 0;
 	}
 	siw_drop_listeners(id);
diff --git a/drivers/infiniband/sw/siw/siw_cq.c b/drivers/infiniband/sw/siw/siw_cq.c
index e381ae9b7d62..d8db3bee9da7 100644
--- a/drivers/infiniband/sw/siw/siw_cq.c
+++ b/drivers/infiniband/sw/siw/siw_cq.c
@@ -71,9 +71,10 @@ int siw_reap_cqe(struct siw_cq *cq, struct ib_wc *wc)
 				wc->wc_flags = IB_WC_WITH_INVALIDATE;
 			}
 			wc->qp = cqe->base_qp;
-			siw_dbg_cq(cq, "idx %u, type %d, flags %2x, id 0x%p\n",
+			siw_dbg_cq(cq,
+				   "idx %u, type %d, flags %2x, id 0x%pK\n",
 				   cq->cq_get % cq->num_cqe, cqe->opcode,
-				   cqe->flags, (void *)cqe->id);
+				   cqe->flags, (void *)(uintptr_t)cqe->id);
 		}
 		WRITE_ONCE(cqe->flags, 0);
 		cq->cq_get++;
diff --git a/drivers/infiniband/sw/siw/siw_mem.c b/drivers/infiniband/sw/siw/siw_mem.c
index 67171c82b0c4..87a56039f0ef 100644
--- a/drivers/infiniband/sw/siw/siw_mem.c
+++ b/drivers/infiniband/sw/siw/siw_mem.c
@@ -197,12 +197,12 @@ int siw_check_mem(struct ib_pd *pd, struct siw_mem *mem, u64 addr,
 	 */
 	if (addr < mem->va || addr + len > mem->va + mem->len) {
 		siw_dbg_pd(pd, "MEM interval len %d\n", len);
-		siw_dbg_pd(pd, "[0x%016llx, 0x%016llx] out of bounds\n",
-			   (unsigned long long)addr,
-			   (unsigned long long)(addr + len));
-		siw_dbg_pd(pd, "[0x%016llx, 0x%016llx] STag=0x%08x\n",
-			   (unsigned long long)mem->va,
-			   (unsigned long long)(mem->va + mem->len),
+		siw_dbg_pd(pd, "[0x%pK, 0x%pK] out of bounds\n",
+			   (void *)(uintptr_t)addr,
+			   (void *)(uintptr_t)(addr + len));
+		siw_dbg_pd(pd, "[0x%pK, 0x%pK] STag=0x%08x\n",
+			   (void *)(uintptr_t)mem->va,
+			   (void *)(uintptr_t)(mem->va + mem->len),
 			   mem->stag);
 
 		return -E_BASE_BOUNDS;
@@ -330,7 +330,7 @@ int siw_invalidate_stag(struct ib_pd *pd, u32 stag)
  * Optionally, provides remaining len within current element, and
  * current PBL index for later resume at same element.
  */
-u64 siw_pbl_get_buffer(struct siw_pbl *pbl, u64 off, int *len, int *idx)
+dma_addr_t siw_pbl_get_buffer(struct siw_pbl *pbl, u64 off, int *len, int *idx)
 {
 	int i = idx ? *idx : 0;
 
diff --git a/drivers/infiniband/sw/siw/siw_mem.h b/drivers/infiniband/sw/siw/siw_mem.h
index f43daf280891..db138c8423da 100644
--- a/drivers/infiniband/sw/siw/siw_mem.h
+++ b/drivers/infiniband/sw/siw/siw_mem.h
@@ -9,7 +9,7 @@
 struct siw_umem *siw_umem_get(u64 start, u64 len, bool writable);
 void siw_umem_release(struct siw_umem *umem, bool dirty);
 struct siw_pbl *siw_pbl_alloc(u32 num_buf);
-u64 siw_pbl_get_buffer(struct siw_pbl *pbl, u64 off, int *len, int *idx);
+dma_addr_t siw_pbl_get_buffer(struct siw_pbl *pbl, u64 off, int *len, int *idx);
 struct siw_mem *siw_mem_id2obj(struct siw_device *sdev, int stag_index);
 int siw_mem_add(struct siw_device *sdev, struct siw_mem *m);
 int siw_invalidate_stag(struct ib_pd *pd, u32 stag);
diff --git a/drivers/infiniband/sw/siw/siw_qp.c b/drivers/infiniband/sw/siw/siw_qp.c
index 0990307c5d2c..430314c8abd9 100644
--- a/drivers/infiniband/sw/siw/siw_qp.c
+++ b/drivers/infiniband/sw/siw/siw_qp.c
@@ -949,7 +949,7 @@ int siw_activate_tx(struct siw_qp *qp)
 				rv = -EINVAL;
 				goto out;
 			}
-			wqe->sqe.sge[0].laddr = (u64)&wqe->sqe.sge[1];
+			wqe->sqe.sge[0].laddr = (uintptr_t)&wqe->sqe.sge[1];
 			wqe->sqe.sge[0].lkey = 0;
 			wqe->sqe.num_sge = 1;
 		}
diff --git a/drivers/infiniband/sw/siw/siw_qp_rx.c b/drivers/infiniband/sw/siw/siw_qp_rx.c
index f87657a11657..c0a887240325 100644
--- a/drivers/infiniband/sw/siw/siw_qp_rx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_rx.c
@@ -38,9 +38,10 @@ static int siw_rx_umem(struct siw_rx_stream *srx, struct siw_umem *umem,
 
 		p = siw_get_upage(umem, dest_addr);
 		if (unlikely(!p)) {
-			pr_warn("siw: %s: [QP %u]: bogus addr: %p, %p\n",
+			pr_warn("siw: %s: [QP %u]: bogus addr: %pK, %pK\n",
 				__func__, qp_id(rx_qp(srx)),
-				(void *)dest_addr, (void *)umem->fp_addr);
+				(void *)(uintptr_t)dest_addr,
+				(void *)(uintptr_t)umem->fp_addr);
 			/* siw internal error */
 			srx->skb_copied += copied;
 			srx->skb_new -= copied;
@@ -50,7 +51,7 @@ static int siw_rx_umem(struct siw_rx_stream *srx, struct siw_umem *umem,
 		pg_off = dest_addr & ~PAGE_MASK;
 		bytes = min(len, (int)PAGE_SIZE - pg_off);
 
-		siw_dbg_qp(rx_qp(srx), "page %p, bytes=%u\n", p, bytes);
+		siw_dbg_qp(rx_qp(srx), "page %pK, bytes=%u\n", p, bytes);
 
 		dest = kmap_atomic(p);
 		rv = skb_copy_bits(srx->skb, srx->skb_offset, dest + pg_off,
@@ -104,11 +105,11 @@ static int siw_rx_kva(struct siw_rx_stream *srx, void *kva, int len)
 {
 	int rv;
 
-	siw_dbg_qp(rx_qp(srx), "kva: 0x%p, len: %u\n", kva, len);
+	siw_dbg_qp(rx_qp(srx), "kva: 0x%pK, len: %u\n", kva, len);
 
 	rv = skb_copy_bits(srx->skb, srx->skb_offset, kva, len);
 	if (unlikely(rv)) {
-		pr_warn("siw: [QP %u]: %s, len %d, kva 0x%p, rv %d\n",
+		pr_warn("siw: [QP %u]: %s, len %d, kva 0x%pK, rv %d\n",
 			qp_id(rx_qp(srx)), __func__, len, kva, rv);
 
 		return rv;
@@ -132,7 +133,7 @@ static int siw_rx_pbl(struct siw_rx_stream *srx, int *pbl_idx,
 
 	while (len) {
 		int bytes;
-		u64 buf_addr =
+		dma_addr_t buf_addr =
 			siw_pbl_get_buffer(pbl, offset, &bytes, pbl_idx);
 		if (!buf_addr)
 			break;
@@ -485,8 +486,8 @@ int siw_proc_send(struct siw_qp *qp)
 		mem_p = *mem;
 		if (mem_p->mem_obj == NULL)
 			rv = siw_rx_kva(srx,
-					(void *)(sge->laddr + frx->sge_off),
-					sge_bytes);
+				(void *)(uintptr_t)(sge->laddr + frx->sge_off),
+				sge_bytes);
 		else if (!mem_p->is_pbl)
 			rv = siw_rx_umem(srx, mem_p->umem,
 					 sge->laddr + frx->sge_off, sge_bytes);
@@ -598,8 +599,8 @@ int siw_proc_write(struct siw_qp *qp)
 
 	if (mem->mem_obj == NULL)
 		rv = siw_rx_kva(srx,
-				(void *)(srx->ddp_to + srx->fpdu_part_rcvd),
-				bytes);
+			(void *)(uintptr_t)(srx->ddp_to + srx->fpdu_part_rcvd),
+			bytes);
 	else if (!mem->is_pbl)
 		rv = siw_rx_umem(srx, mem->umem,
 				 srx->ddp_to + srx->fpdu_part_rcvd, bytes);
@@ -841,8 +842,9 @@ int siw_proc_rresp(struct siw_qp *qp)
 	bytes = min(srx->fpdu_part_rem, srx->skb_new);
 
 	if (mem_p->mem_obj == NULL)
-		rv = siw_rx_kva(srx, (void *)(sge->laddr + wqe->processed),
-				bytes);
+		rv = siw_rx_kva(srx,
+			(void *)(uintptr_t)(sge->laddr + wqe->processed),
+			bytes);
 	else if (!mem_p->is_pbl)
 		rv = siw_rx_umem(srx, mem_p->umem, sge->laddr + wqe->processed,
 				 bytes);
diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c b/drivers/infiniband/sw/siw/siw_qp_tx.c
index 43020d2040fc..6fb60c7e10e9 100644
--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
@@ -26,7 +26,7 @@ static struct page *siw_get_pblpage(struct siw_mem *mem, u64 addr, int *idx)
 {
 	struct siw_pbl *pbl = mem->pbl;
 	u64 offset = addr - mem->va;
-	u64 paddr = siw_pbl_get_buffer(pbl, offset, NULL, idx);
+	dma_addr_t paddr = siw_pbl_get_buffer(pbl, offset, NULL, idx);
 
 	if (paddr)
 		return virt_to_page(paddr);
@@ -37,7 +37,7 @@ static struct page *siw_get_pblpage(struct siw_mem *mem, u64 addr, int *idx)
 /*
  * Copy short payload at provided destination payload address
  */
-static int siw_try_1seg(struct siw_iwarp_tx *c_tx, u64 paddr)
+static int siw_try_1seg(struct siw_iwarp_tx *c_tx, void *paddr)
 {
 	struct siw_wqe *wqe = &c_tx->wqe_active;
 	struct siw_sge *sge = &wqe->sqe.sge[0];
@@ -50,16 +50,16 @@ static int siw_try_1seg(struct siw_iwarp_tx *c_tx, u64 paddr)
 		return 0;
 
 	if (tx_flags(wqe) & SIW_WQE_INLINE) {
-		memcpy((void *)paddr, &wqe->sqe.sge[1], bytes);
+		memcpy(paddr, &wqe->sqe.sge[1], bytes);
 	} else {
 		struct siw_mem *mem = wqe->mem[0];
 
 		if (!mem->mem_obj) {
 			/* Kernel client using kva */
-			memcpy((void *)paddr, (void *)sge->laddr, bytes);
+			memcpy(paddr,
+			       (const void *)(uintptr_t)sge->laddr, bytes);
 		} else if (c_tx->in_syscall) {
-			if (copy_from_user((void *)paddr,
-					   (const void __user *)sge->laddr,
+			if (copy_from_user(paddr, u64_to_user_ptr(sge->laddr),
 					   bytes))
 				return -EFAULT;
 		} else {
@@ -79,12 +79,12 @@ static int siw_try_1seg(struct siw_iwarp_tx *c_tx, u64 paddr)
 			buffer = kmap_atomic(p);
 
 			if (likely(PAGE_SIZE - off >= bytes)) {
-				memcpy((void *)paddr, buffer + off, bytes);
+				memcpy(paddr, buffer + off, bytes);
 				kunmap_atomic(buffer);
 			} else {
 				unsigned long part = bytes - (PAGE_SIZE - off);
 
-				memcpy((void *)paddr, buffer + off, part);
+				memcpy(paddr, buffer + off, part);
 				kunmap_atomic(buffer);
 
 				if (!mem->is_pbl)
@@ -98,7 +98,7 @@ static int siw_try_1seg(struct siw_iwarp_tx *c_tx, u64 paddr)
 					return -EFAULT;
 
 				buffer = kmap_atomic(p);
-				memcpy((void *)(paddr + part), buffer,
+				memcpy(paddr + part, buffer,
 				       bytes - part);
 				kunmap_atomic(buffer);
 			}
@@ -166,7 +166,7 @@ static int siw_qp_prepare_tx(struct siw_iwarp_tx *c_tx)
 		c_tx->ctrl_len = sizeof(struct iwarp_send);
 
 		crc = (char *)&c_tx->pkt.send_pkt.crc;
-		data = siw_try_1seg(c_tx, (u64)crc);
+		data = siw_try_1seg(c_tx, crc);
 		break;
 
 	case SIW_OP_SEND_REMOTE_INV:
@@ -189,7 +189,7 @@ static int siw_qp_prepare_tx(struct siw_iwarp_tx *c_tx)
 		c_tx->ctrl_len = sizeof(struct iwarp_send_inv);
 
 		crc = (char *)&c_tx->pkt.send_pkt.crc;
-		data = siw_try_1seg(c_tx, (u64)crc);
+		data = siw_try_1seg(c_tx, crc);
 		break;
 
 	case SIW_OP_WRITE:
@@ -201,7 +201,7 @@ static int siw_qp_prepare_tx(struct siw_iwarp_tx *c_tx)
 		c_tx->ctrl_len = sizeof(struct iwarp_rdma_write);
 
 		crc = (char *)&c_tx->pkt.write_pkt.crc;
-		data = siw_try_1seg(c_tx, (u64)crc);
+		data = siw_try_1seg(c_tx, crc);
 		break;
 
 	case SIW_OP_READ_RESPONSE:
@@ -216,7 +216,7 @@ static int siw_qp_prepare_tx(struct siw_iwarp_tx *c_tx)
 		c_tx->ctrl_len = sizeof(struct iwarp_rdma_rresp);
 
 		crc = (char *)&c_tx->pkt.write_pkt.crc;
-		data = siw_try_1seg(c_tx, (u64)crc);
+		data = siw_try_1seg(c_tx, crc);
 		break;
 
 	default:
@@ -473,7 +473,8 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
 			 * tx from kernel virtual address: either inline data
 			 * or memory region with assigned kernel buffer
 			 */
-			iov[seg].iov_base = (void *)(sge->laddr + sge_off);
+			iov[seg].iov_base =
+				(void *)(uintptr_t)(sge->laddr + sge_off);
 			iov[seg].iov_len = sge_len;
 
 			if (do_crc)
@@ -526,13 +527,13 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
 						page_address(p) + fp_off,
 						plen);
 			} else {
-				u64 pa = ((sge->laddr + sge_off) & PAGE_MASK);
+				u64 va = sge->laddr + sge_off;
 
-				page_array[seg] = virt_to_page(pa);
+				page_array[seg] = virt_to_page(va & PAGE_MASK);
 				if (do_crc)
 					crypto_shash_update(
 						c_tx->mpa_crc_hd,
-						(void *)(sge->laddr + sge_off),
+						(void *)(uintptr_t)va,
 						plen);
 			}
 
@@ -829,7 +830,8 @@ static int siw_qp_sq_proc_tx(struct siw_qp *qp, struct siw_wqe *wqe)
 					rv = -EINVAL;
 					goto tx_error;
 				}
-				wqe->sqe.sge[0].laddr = (u64)&wqe->sqe.sge[1];
+				wqe->sqe.sge[0].laddr =
+					(u64)(uintptr_t)&wqe->sqe.sge[1];
 			}
 		}
 		wqe->wr_status = SIW_WR_INPROGRESS;
@@ -924,7 +926,7 @@ static int siw_qp_sq_proc_tx(struct siw_qp *qp, struct siw_wqe *wqe)
 
 static int siw_fastreg_mr(struct ib_pd *pd, struct siw_sqe *sqe)
 {
-	struct ib_mr *base_mr = (struct ib_mr *)sqe->base_mr;
+	struct ib_mr *base_mr = (struct ib_mr *)(uintptr_t)sqe->base_mr;
 	struct siw_device *sdev = to_siw_dev(pd->device);
 	struct siw_mem *mem = siw_mem_id2obj(sdev, sqe->rkey  >> 8);
 	int rv = 0;
@@ -954,8 +956,7 @@ static int siw_fastreg_mr(struct ib_pd *pd, struct siw_sqe *sqe)
 	mem->stag = sqe->rkey;
 	mem->perms = sqe->access;
 
-	siw_dbg_mem(mem, "STag now valid, MR va: 0x%016llx -> 0x%016llx\n",
-		    mem->va, base_mr->iova);
+	siw_dbg_mem(mem, "STag 0x%08x now valid\n", sqe->rkey);
 	mem->va = base_mr->iova;
 	mem->stag_valid = 1;
 out:
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index e7f3a2379d9d..da52c90e06d4 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -424,8 +424,7 @@ struct ib_qp *siw_create_qp(struct ib_pd *pd,
 		 */
 		qp->srq = to_siw_srq(attrs->srq);
 		qp->attrs.rq_size = 0;
-		siw_dbg(base_dev, "QP [%u]: [SRQ 0x%p] attached\n",
-			qp->qp_num, qp->srq);
+		siw_dbg(base_dev, "QP [%u]: SRQ attached\n", qp->qp_num);
 	} else if (num_rqe) {
 		if (qp->kernel_verbs)
 			qp->recvq = vzalloc(num_rqe * sizeof(struct siw_rqe));
@@ -610,7 +609,7 @@ int siw_destroy_qp(struct ib_qp *base_qp, struct ib_udata *udata)
 					  base_ucontext);
 	struct siw_qp_attrs qp_attrs;
 
-	siw_dbg_qp(qp, "state %d, cep 0x%p\n", qp->attrs.state, qp->cep);
+	siw_dbg_qp(qp, "state %d\n", qp->attrs.state);
 
 	/*
 	 * Mark QP as in process of destruction to prevent from
@@ -662,7 +661,7 @@ static int siw_copy_inline_sgl(const struct ib_send_wr *core_wr,
 	void *kbuf = &sqe->sge[1];
 	int num_sge = core_wr->num_sge, bytes = 0;
 
-	sqe->sge[0].laddr = (u64)kbuf;
+	sqe->sge[0].laddr = (uintptr_t)kbuf;
 	sqe->sge[0].lkey = 0;
 
 	while (num_sge--) {
@@ -825,7 +824,7 @@ int siw_post_send(struct ib_qp *base_qp, const struct ib_send_wr *wr,
 			break;
 
 		case IB_WR_REG_MR:
-			sqe->base_mr = (uint64_t)reg_wr(wr)->mr;
+			sqe->base_mr = (uintptr_t)reg_wr(wr)->mr;
 			sqe->rkey = reg_wr(wr)->key;
 			sqe->access = reg_wr(wr)->access & IWARP_ACCESS_MASK;
 			sqe->opcode = SIW_OP_REG_MR;
@@ -842,8 +841,9 @@ int siw_post_send(struct ib_qp *base_qp, const struct ib_send_wr *wr,
 			rv = -EINVAL;
 			break;
 		}
-		siw_dbg_qp(qp, "opcode %d, flags 0x%x, wr_id 0x%p\n",
-			   sqe->opcode, sqe->flags, (void *)sqe->id);
+		siw_dbg_qp(qp, "opcode %d, flags 0x%x, wr_id 0x%pK\n",
+			   sqe->opcode, sqe->flags,
+			   (void *)(uintptr_t)sqe->id);
 
 		if (unlikely(rv < 0))
 			break;
@@ -1205,8 +1205,8 @@ struct ib_mr *siw_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 	unsigned long mem_limit = rlimit(RLIMIT_MEMLOCK);
 	int rv;
 
-	siw_dbg_pd(pd, "start: 0x%016llx, va: 0x%016llx, len: %llu\n",
-		   (unsigned long long)start, (unsigned long long)rnic_va,
+	siw_dbg_pd(pd, "start: 0x%pK, va: 0x%pK, len: %llu\n",
+		   (void *)(uintptr_t)start, (void *)(uintptr_t)rnic_va,
 		   (unsigned long long)len);
 
 	if (atomic_inc_return(&sdev->num_mr) > SIW_MAX_MR) {
@@ -1363,7 +1363,7 @@ int siw_map_mr_sg(struct ib_mr *base_mr, struct scatterlist *sl, int num_sle,
 	struct siw_mem *mem = mr->mem;
 	struct siw_pbl *pbl = mem->pbl;
 	struct siw_pble *pble;
-	u64 pbl_size;
+	unsigned long pbl_size;
 	int i, rv;
 
 	if (!pbl) {
@@ -1402,16 +1402,18 @@ int siw_map_mr_sg(struct ib_mr *base_mr, struct scatterlist *sl, int num_sle,
 			pbl_size += sg_dma_len(slp);
 		}
 		siw_dbg_mem(mem,
-			"sge[%d], size %llu, addr 0x%016llx, total %llu\n",
-			i, pble->size, pble->addr, pbl_size);
+			"sge[%d], size %u, addr 0x%p, total %lu\n",
+			i, pble->size, (void *)(uintptr_t)pble->addr,
+			pbl_size);
 	}
 	rv = ib_sg_to_pages(base_mr, sl, num_sle, sg_off, siw_set_pbl_page);
 	if (rv > 0) {
 		mem->len = base_mr->length;
 		mem->va = base_mr->iova;
 		siw_dbg_mem(mem,
-			"%llu bytes, start 0x%016llx, %u SLE to %u entries\n",
-			mem->len, mem->va, num_sle, pbl->num_buf);
+			"%llu bytes, start 0x%pK, %u SLE to %u entries\n",
+			mem->len, (void *)(uintptr_t)mem->va, num_sle,
+			pbl->num_buf);
 	}
 	return rv;
 }
@@ -1529,7 +1531,7 @@ int siw_create_srq(struct ib_srq *base_srq,
 	}
 	spin_lock_init(&srq->lock);
 
-	siw_dbg_pd(base_srq->pd, "[SRQ 0x%p]: success\n", srq);
+	siw_dbg_pd(base_srq->pd, "[SRQ]: success\n");
 
 	return 0;
 
@@ -1650,8 +1652,7 @@ int siw_post_srq_recv(struct ib_srq *base_srq, const struct ib_recv_wr *wr,
 
 	if (unlikely(!srq->kernel_verbs)) {
 		siw_dbg_pd(base_srq->pd,
-			   "[SRQ 0x%p]: no kernel post_recv for mapped srq\n",
-			   srq);
+			   "[SRQ]: no kernel post_recv for mapped srq\n");
 		rv = -EINVAL;
 		goto out;
 	}
@@ -1673,8 +1674,7 @@ int siw_post_srq_recv(struct ib_srq *base_srq, const struct ib_recv_wr *wr,
 		}
 		if (unlikely(wr->num_sge > srq->max_sge)) {
 			siw_dbg_pd(base_srq->pd,
-				   "[SRQ 0x%p]: too many sge's: %d\n", srq,
-				   wr->num_sge);
+				   "[SRQ]: too many sge's: %d\n", wr->num_sge);
 			rv = -EINVAL;
 			break;
 		}
@@ -1693,7 +1693,7 @@ int siw_post_srq_recv(struct ib_srq *base_srq, const struct ib_recv_wr *wr,
 	spin_unlock_irqrestore(&srq->lock, flags);
 out:
 	if (unlikely(rv < 0)) {
-		siw_dbg_pd(base_srq->pd, "[SRQ 0x%p]: error %d\n", srq, rv);
+		siw_dbg_pd(base_srq->pd, "[SRQ]: error %d\n", rv);
 		*bad_wr = wr;
 	}
 	return rv;
-- 
2.17.2

