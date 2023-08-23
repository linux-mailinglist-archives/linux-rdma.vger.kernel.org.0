Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09DE78506B
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Aug 2023 08:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjHWGMc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Aug 2023 02:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbjHWGMb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Aug 2023 02:12:31 -0400
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AFAE5D;
        Tue, 22 Aug 2023 23:12:21 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="128971679"
X-IronPort-AV: E=Sophos;i="6.01,195,1684767600"; 
   d="scan'208";a="128971679"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 15:12:01 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
        by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 7C68FD29E1;
        Wed, 23 Aug 2023 15:11:59 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
        by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 5EF94D6152;
        Wed, 23 Aug 2023 15:11:58 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.234.230])
        by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id CCE9134786;
        Wed, 23 Aug 2023 15:11:54 +0900 (JST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     linux-rdma@vger.kernel.org
Cc:     zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
        linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
        Li Zhijian <lizhijian@fujitsu.com>,
        Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH v2 1/2] RDMA/rxe: Improve newline in printing messages
Date:   Wed, 23 Aug 2023 14:11:40 +0800
Message-Id: <20230823061141.258864-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27830.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27830.004
X-TMASE-Result: 10--10.199600-10.000000
X-TMASE-MatchedRID: Yzj0+v1tFFpNUB+j1JNgw869emDs42ddTSz0JdEAJbSfHrjLA9DhZp7V
        Ny7+UW/9BV/4TgPSJ/meGITKt+c+diZ0TtZEfDmeTuctSpiuWyUUi4Ehat05499RlPzeVuQQyL5
        QmWOgMfDl1EohDK9ptqcvaj5s3izWu4AM1i3aFvbvZKXlmouCkcCY5/Mqi1OiviEPmni5YZ8L85
        2CVV6DmGi6MQwgBJA7Rl9V3FrAvD/sR/15S/KqDpGA/MAGSrEg8SkdpG2/n9fa91nxwxNKpuub8
        Cv6bO3OM9jcip/xpflZQrFyhjvQc/cVnfWYnXroiSe9g7mQdJyXqCWexXV0L6ZFt+wjoynrBFYE
        ZT/HdE6wGfGRRfhlnmzhWSMNn/rUtXWrnO+cQ8Adahq+rGDn/7JEo6RFXaMBjlXUAIjJm2cSkxj
        Sj8Gsp2nZumqcXGG2CUn+J4dEdKclVAZazMJ4Z+ScxJMb2Uf4sk61leL8Ml/EWhdVdXNnvx2GXI
        wJyZk4PC80SCNdZoX00GdG7jx53a+/EguYor8cFEUknJ/kEl7dB/CxWTRRu25FeHtsUoHufkoL7
        3/vZn7+1idtrRWzW3lOIEDN+EVUmkDs7d5f+ozrpcchznD6Bw==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Previously rxe_{dbg,info,err}() macros are appened built-in newline,
sut some users will add redundent newline some times. So remove the
built-int newline for this macros.

In terms of rxe_{dbg,info,err}_xxx() macros, because they don't have
built-in newline, append newline when using them.

CC: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 I have use below script to verify if all of them are cleanup:
 git grep -n -E "rxe_info.*\"|rxe_err.*\"|rxe_dbg.*\"" drivers/infiniband/sw/rxe/ | grep -v '\\n'
---
 drivers/infiniband/sw/rxe/rxe.c       |   6 +-
 drivers/infiniband/sw/rxe/rxe.h       |   6 +-
 drivers/infiniband/sw/rxe/rxe_comp.c  |   4 +-
 drivers/infiniband/sw/rxe/rxe_cq.c    |   4 +-
 drivers/infiniband/sw/rxe/rxe_mr.c    |  16 +-
 drivers/infiniband/sw/rxe/rxe_mw.c    |   2 +-
 drivers/infiniband/sw/rxe/rxe_resp.c  |  12 +-
 drivers/infiniband/sw/rxe/rxe_task.c  |   4 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c | 216 +++++++++++++-------------
 9 files changed, 135 insertions(+), 135 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 54c723a6edda..a086d588e159 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -161,7 +161,7 @@ void rxe_set_mtu(struct rxe_dev *rxe, unsigned int ndev_mtu)
 	port->attr.active_mtu = mtu;
 	port->mtu_cap = ib_mtu_enum_to_int(mtu);
 
-	rxe_info_dev(rxe, "Set mtu to %d", port->mtu_cap);
+	rxe_info_dev(rxe, "Set mtu to %d\n", port->mtu_cap);
 }
 
 /* called by ifc layer to create new rxe device.
@@ -181,7 +181,7 @@ static int rxe_newlink(const char *ibdev_name, struct net_device *ndev)
 	int err = 0;
 
 	if (is_vlan_dev(ndev)) {
-		rxe_err("rxe creation allowed on top of a real device only");
+		rxe_err("rxe creation allowed on top of a real device only\n");
 		err = -EPERM;
 		goto err;
 	}
@@ -189,7 +189,7 @@ static int rxe_newlink(const char *ibdev_name, struct net_device *ndev)
 	rxe = rxe_get_dev_from_net(ndev);
 	if (rxe) {
 		ib_device_put(&rxe->ib_dev);
-		rxe_err_dev(rxe, "already configured on %s", ndev->name);
+		rxe_err_dev(rxe, "already configured on %s\n", ndev->name);
 		err = -EEXIST;
 		goto err;
 	}
diff --git a/drivers/infiniband/sw/rxe/rxe.h b/drivers/infiniband/sw/rxe/rxe.h
index d33dd6cf83d3..d8fb2c7af30a 100644
--- a/drivers/infiniband/sw/rxe/rxe.h
+++ b/drivers/infiniband/sw/rxe/rxe.h
@@ -38,7 +38,7 @@
 
 #define RXE_ROCE_V2_SPORT		(0xc000)
 
-#define rxe_dbg(fmt, ...) pr_debug("%s: " fmt "\n", __func__, ##__VA_ARGS__)
+#define rxe_dbg(fmt, ...) pr_debug("%s: " fmt, __func__, ##__VA_ARGS__)
 #define rxe_dbg_dev(rxe, fmt, ...) ibdev_dbg(&(rxe)->ib_dev,		\
 		"%s: " fmt, __func__, ##__VA_ARGS__)
 #define rxe_dbg_uc(uc, fmt, ...) ibdev_dbg((uc)->ibuc.device,		\
@@ -58,7 +58,7 @@
 #define rxe_dbg_mw(mw, fmt, ...) ibdev_dbg((mw)->ibmw.device,		\
 		"mw#%d %s:  " fmt, (mw)->elem.index, __func__, ##__VA_ARGS__)
 
-#define rxe_err(fmt, ...) pr_err_ratelimited("%s: " fmt "\n", __func__, \
+#define rxe_err(fmt, ...) pr_err_ratelimited("%s: " fmt, __func__, \
 					##__VA_ARGS__)
 #define rxe_err_dev(rxe, fmt, ...) ibdev_err_ratelimited(&(rxe)->ib_dev, \
 		"%s: " fmt, __func__, ##__VA_ARGS__)
@@ -79,7 +79,7 @@
 #define rxe_err_mw(mw, fmt, ...) ibdev_err_ratelimited((mw)->ibmw.device, \
 		"mw#%d %s:  " fmt, (mw)->elem.index, __func__, ##__VA_ARGS__)
 
-#define rxe_info(fmt, ...) pr_info_ratelimited("%s: " fmt "\n", __func__, \
+#define rxe_info(fmt, ...) pr_info_ratelimited("%s: " fmt, __func__, \
 					##__VA_ARGS__)
 #define rxe_info_dev(rxe, fmt, ...) ibdev_info_ratelimited(&(rxe)->ib_dev, \
 		"%s: " fmt, __func__, ##__VA_ARGS__)
diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index 5111735aafae..2810c886cfca 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -433,7 +433,7 @@ static void make_send_cqe(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 		}
 	} else {
 		if (wqe->status != IB_WC_WR_FLUSH_ERR)
-			rxe_err_qp(qp, "non-flush error status = %d",
+			rxe_err_qp(qp, "non-flush error status = %d\n",
 				wqe->status);
 	}
 }
@@ -582,7 +582,7 @@ static int flush_send_wqe(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 
 	err = rxe_cq_post(qp->scq, &cqe, 0);
 	if (err)
-		rxe_dbg_cq(qp->scq, "post cq failed, err = %d", err);
+		rxe_dbg_cq(qp->scq, "post cq failed, err = %d\n", err);
 
 	return err;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
index d5486cbb3f10..fec87c9030ab 100644
--- a/drivers/infiniband/sw/rxe/rxe_cq.c
+++ b/drivers/infiniband/sw/rxe/rxe_cq.c
@@ -27,7 +27,7 @@ int rxe_cq_chk_attr(struct rxe_dev *rxe, struct rxe_cq *cq,
 	if (cq) {
 		count = queue_count(cq->queue, QUEUE_TYPE_TO_CLIENT);
 		if (cqe < count) {
-			rxe_dbg_cq(cq, "cqe(%d) < current # elements in queue (%d)",
+			rxe_dbg_cq(cq, "cqe(%d) < current # elements in queue (%d)\n",
 					cqe, count);
 			goto err1;
 		}
@@ -96,7 +96,7 @@ int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
 
 	full = queue_full(cq->queue, QUEUE_TYPE_TO_CLIENT);
 	if (unlikely(full)) {
-		rxe_err_cq(cq, "queue full");
+		rxe_err_cq(cq, "queue full\n");
 		spin_unlock_irqrestore(&cq->cq_lock, flags);
 		if (cq->ibcq.event_handler) {
 			ev.device = cq->ibcq.device;
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index f54042e9aeb2..bc81fde696ee 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -34,7 +34,7 @@ int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length)
 	case IB_MR_TYPE_MEM_REG:
 		if (iova < mr->ibmr.iova ||
 		    iova + length > mr->ibmr.iova + mr->ibmr.length) {
-			rxe_dbg_mr(mr, "iova/length out of range");
+			rxe_dbg_mr(mr, "iova/length out of range\n");
 			return -EINVAL;
 		}
 		return 0;
@@ -319,7 +319,7 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr,
 
 	err = mr_check_range(mr, iova, length);
 	if (unlikely(err)) {
-		rxe_dbg_mr(mr, "iova out of range");
+		rxe_dbg_mr(mr, "iova out of range\n");
 		return err;
 	}
 
@@ -477,7 +477,7 @@ int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
 	u64 *va;
 
 	if (unlikely(mr->state != RXE_MR_STATE_VALID)) {
-		rxe_dbg_mr(mr, "mr not in valid state");
+		rxe_dbg_mr(mr, "mr not in valid state\n");
 		return RESPST_ERR_RKEY_VIOLATION;
 	}
 
@@ -490,7 +490,7 @@ int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
 
 		err = mr_check_range(mr, iova, sizeof(value));
 		if (err) {
-			rxe_dbg_mr(mr, "iova out of range");
+			rxe_dbg_mr(mr, "iova out of range\n");
 			return RESPST_ERR_RKEY_VIOLATION;
 		}
 		page_offset = rxe_mr_iova_to_page_offset(mr, iova);
@@ -501,7 +501,7 @@ int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
 	}
 
 	if (unlikely(page_offset & 0x7)) {
-		rxe_dbg_mr(mr, "iova not aligned");
+		rxe_dbg_mr(mr, "iova not aligned\n");
 		return RESPST_ERR_MISALIGNED_ATOMIC;
 	}
 
@@ -534,7 +534,7 @@ int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
 
 	/* See IBA oA19-28 */
 	if (unlikely(mr->state != RXE_MR_STATE_VALID)) {
-		rxe_dbg_mr(mr, "mr not in valid state");
+		rxe_dbg_mr(mr, "mr not in valid state\n");
 		return RESPST_ERR_RKEY_VIOLATION;
 	}
 
@@ -548,7 +548,7 @@ int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
 		/* See IBA oA19-28 */
 		err = mr_check_range(mr, iova, sizeof(value));
 		if (unlikely(err)) {
-			rxe_dbg_mr(mr, "iova out of range");
+			rxe_dbg_mr(mr, "iova out of range\n");
 			return RESPST_ERR_RKEY_VIOLATION;
 		}
 		page_offset = rxe_mr_iova_to_page_offset(mr, iova);
@@ -560,7 +560,7 @@ int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
 
 	/* See IBA A19.4.2 */
 	if (unlikely(page_offset & 0x7)) {
-		rxe_dbg_mr(mr, "misaligned address");
+		rxe_dbg_mr(mr, "misaligned address\n");
 		return RESPST_ERR_MISALIGNED_ATOMIC;
 	}
 
diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index d9312b5c9d20..379e65bfcd49 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -198,7 +198,7 @@ int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 	}
 
 	if (access & ~RXE_ACCESS_SUPPORTED_MW) {
-		rxe_err_mw(mw, "access %#x not supported", access);
+		rxe_err_mw(mw, "access %#x not supported\n", access);
 		ret = -EOPNOTSUPP;
 		goto err_drop_mr;
 	}
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 64c64f5f36a8..032bf305a58b 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -362,18 +362,18 @@ static enum resp_states rxe_resp_check_length(struct rxe_qp *qp,
 		if ((pkt->mask & RXE_START_MASK) &&
 		    (pkt->mask & RXE_END_MASK)) {
 			if (unlikely(payload > mtu)) {
-				rxe_dbg_qp(qp, "only packet too long");
+				rxe_dbg_qp(qp, "only packet too long\n");
 				return RESPST_ERR_LENGTH;
 			}
 		} else if ((pkt->mask & RXE_START_MASK) ||
 			   (pkt->mask & RXE_MIDDLE_MASK)) {
 			if (unlikely(payload != mtu)) {
-				rxe_dbg_qp(qp, "first or middle packet not mtu");
+				rxe_dbg_qp(qp, "first or middle packet not mtu\n");
 				return RESPST_ERR_LENGTH;
 			}
 		} else if (pkt->mask & RXE_END_MASK) {
 			if (unlikely((payload == 0) || (payload > mtu))) {
-				rxe_dbg_qp(qp, "last packet zero or too long");
+				rxe_dbg_qp(qp, "last packet zero or too long\n");
 				return RESPST_ERR_LENGTH;
 			}
 		}
@@ -382,7 +382,7 @@ static enum resp_states rxe_resp_check_length(struct rxe_qp *qp,
 	/* See IBA C9-94 */
 	if (pkt->mask & RXE_RETH_MASK) {
 		if (reth_len(pkt) > (1U << 31)) {
-			rxe_dbg_qp(qp, "dma length too long");
+			rxe_dbg_qp(qp, "dma length too long\n");
 			return RESPST_ERR_LENGTH;
 		}
 	}
@@ -1133,7 +1133,7 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 		}
 	} else {
 		if (wc->status != IB_WC_WR_FLUSH_ERR)
-			rxe_err_qp(qp, "non-flush error status = %d",
+			rxe_err_qp(qp, "non-flush error status = %d\n",
 				wc->status);
 	}
 
@@ -1442,7 +1442,7 @@ static int flush_recv_wqe(struct rxe_qp *qp, struct rxe_recv_wqe *wqe)
 
 	err = rxe_cq_post(qp->rcq, &cqe, 0);
 	if (err)
-		rxe_dbg_cq(qp->rcq, "post cq failed err = %d", err);
+		rxe_dbg_cq(qp->rcq, "post cq failed err = %d\n", err);
 
 	return err;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
index 1501120d4f52..80332638d9e3 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
@@ -156,7 +156,7 @@ static void do_task(struct rxe_task *task)
 
 		default:
 			WARN_ON(1);
-			rxe_dbg_qp(task->qp, "unexpected task state = %d",
+			rxe_dbg_qp(task->qp, "unexpected task state = %d\n",
 				   task->state);
 			task->state = TASK_STATE_IDLE;
 		}
@@ -167,7 +167,7 @@ static void do_task(struct rxe_task *task)
 			if (WARN_ON(task->num_done != task->num_sched))
 				rxe_dbg_qp(
 					task->qp,
-					"%ld tasks scheduled, %ld tasks done",
+					"%ld tasks scheduled, %ld tasks done\n",
 					task->num_sched, task->num_done);
 		}
 		spin_unlock_irqrestore(&task->lock, flags);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 903f0b71447e..73c283a2d8ed 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -23,7 +23,7 @@ static int rxe_query_device(struct ib_device *ibdev,
 	int err;
 
 	if (udata->inlen || udata->outlen) {
-		rxe_dbg_dev(rxe, "malformed udata");
+		rxe_dbg_dev(rxe, "malformed udata\n");
 		err = -EINVAL;
 		goto err_out;
 	}
@@ -33,7 +33,7 @@ static int rxe_query_device(struct ib_device *ibdev,
 	return 0;
 
 err_out:
-	rxe_err_dev(rxe, "returned err = %d", err);
+	rxe_err_dev(rxe, "returned err = %d\n", err);
 	return err;
 }
 
@@ -45,7 +45,7 @@ static int rxe_query_port(struct ib_device *ibdev,
 
 	if (port_num != 1) {
 		err = -EINVAL;
-		rxe_dbg_dev(rxe, "bad port_num = %d", port_num);
+		rxe_dbg_dev(rxe, "bad port_num = %d\n", port_num);
 		goto err_out;
 	}
 
@@ -67,7 +67,7 @@ static int rxe_query_port(struct ib_device *ibdev,
 	return ret;
 
 err_out:
-	rxe_err_dev(rxe, "returned err = %d", err);
+	rxe_err_dev(rxe, "returned err = %d\n", err);
 	return err;
 }
 
@@ -79,7 +79,7 @@ static int rxe_query_pkey(struct ib_device *ibdev,
 
 	if (index != 0) {
 		err = -EINVAL;
-		rxe_dbg_dev(rxe, "bad pkey index = %d", index);
+		rxe_dbg_dev(rxe, "bad pkey index = %d\n", index);
 		goto err_out;
 	}
 
@@ -87,7 +87,7 @@ static int rxe_query_pkey(struct ib_device *ibdev,
 	return 0;
 
 err_out:
-	rxe_err_dev(rxe, "returned err = %d", err);
+	rxe_err_dev(rxe, "returned err = %d\n", err);
 	return err;
 }
 
@@ -100,7 +100,7 @@ static int rxe_modify_device(struct ib_device *ibdev,
 	if (mask & ~(IB_DEVICE_MODIFY_SYS_IMAGE_GUID |
 		     IB_DEVICE_MODIFY_NODE_DESC)) {
 		err = -EOPNOTSUPP;
-		rxe_dbg_dev(rxe, "unsupported mask = 0x%x", mask);
+		rxe_dbg_dev(rxe, "unsupported mask = 0x%x\n", mask);
 		goto err_out;
 	}
 
@@ -115,7 +115,7 @@ static int rxe_modify_device(struct ib_device *ibdev,
 	return 0;
 
 err_out:
-	rxe_err_dev(rxe, "returned err = %d", err);
+	rxe_err_dev(rxe, "returned err = %d\n", err);
 	return err;
 }
 
@@ -128,14 +128,14 @@ static int rxe_modify_port(struct ib_device *ibdev, u32 port_num,
 
 	if (port_num != 1) {
 		err = -EINVAL;
-		rxe_dbg_dev(rxe, "bad port_num = %d", port_num);
+		rxe_dbg_dev(rxe, "bad port_num = %d\n", port_num);
 		goto err_out;
 	}
 
 	//TODO is shutdown useful
 	if (mask & ~(IB_PORT_RESET_QKEY_CNTR)) {
 		err = -EOPNOTSUPP;
-		rxe_dbg_dev(rxe, "unsupported mask = 0x%x", mask);
+		rxe_dbg_dev(rxe, "unsupported mask = 0x%x\n", mask);
 		goto err_out;
 	}
 
@@ -149,7 +149,7 @@ static int rxe_modify_port(struct ib_device *ibdev, u32 port_num,
 	return 0;
 
 err_out:
-	rxe_err_dev(rxe, "returned err = %d", err);
+	rxe_err_dev(rxe, "returned err = %d\n", err);
 	return err;
 }
 
@@ -161,14 +161,14 @@ static enum rdma_link_layer rxe_get_link_layer(struct ib_device *ibdev,
 
 	if (port_num != 1) {
 		err = -EINVAL;
-		rxe_dbg_dev(rxe, "bad port_num = %d", port_num);
+		rxe_dbg_dev(rxe, "bad port_num = %d\n", port_num);
 		goto err_out;
 	}
 
 	return IB_LINK_LAYER_ETHERNET;
 
 err_out:
-	rxe_err_dev(rxe, "returned err = %d", err);
+	rxe_err_dev(rxe, "returned err = %d\n", err);
 	return err;
 }
 
@@ -181,7 +181,7 @@ static int rxe_port_immutable(struct ib_device *ibdev, u32 port_num,
 
 	if (port_num != 1) {
 		err = -EINVAL;
-		rxe_dbg_dev(rxe, "bad port_num = %d", port_num);
+		rxe_dbg_dev(rxe, "bad port_num = %d\n", port_num);
 		goto err_out;
 	}
 
@@ -197,7 +197,7 @@ static int rxe_port_immutable(struct ib_device *ibdev, u32 port_num,
 	return 0;
 
 err_out:
-	rxe_err_dev(rxe, "returned err = %d", err);
+	rxe_err_dev(rxe, "returned err = %d\n", err);
 	return err;
 }
 
@@ -210,7 +210,7 @@ static int rxe_alloc_ucontext(struct ib_ucontext *ibuc, struct ib_udata *udata)
 
 	err = rxe_add_to_pool(&rxe->uc_pool, uc);
 	if (err)
-		rxe_err_dev(rxe, "unable to create uc");
+		rxe_err_dev(rxe, "unable to create uc\n");
 
 	return err;
 }
@@ -222,7 +222,7 @@ static void rxe_dealloc_ucontext(struct ib_ucontext *ibuc)
 
 	err = rxe_cleanup(uc);
 	if (err)
-		rxe_err_uc(uc, "cleanup failed, err = %d", err);
+		rxe_err_uc(uc, "cleanup failed, err = %d\n", err);
 }
 
 /* pd */
@@ -234,14 +234,14 @@ static int rxe_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 
 	err = rxe_add_to_pool(&rxe->pd_pool, pd);
 	if (err) {
-		rxe_dbg_dev(rxe, "unable to alloc pd");
+		rxe_dbg_dev(rxe, "unable to alloc pd\n");
 		goto err_out;
 	}
 
 	return 0;
 
 err_out:
-	rxe_err_dev(rxe, "returned err = %d", err);
+	rxe_err_dev(rxe, "returned err = %d\n", err);
 	return err;
 }
 
@@ -252,7 +252,7 @@ static int rxe_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 
 	err = rxe_cleanup(pd);
 	if (err)
-		rxe_err_pd(pd, "cleanup failed, err = %d", err);
+		rxe_err_pd(pd, "cleanup failed, err = %d\n", err);
 
 	return 0;
 }
@@ -279,7 +279,7 @@ static int rxe_create_ah(struct ib_ah *ibah,
 	err = rxe_add_to_pool_ah(&rxe->ah_pool, ah,
 			init_attr->flags & RDMA_CREATE_AH_SLEEPABLE);
 	if (err) {
-		rxe_dbg_dev(rxe, "unable to create ah");
+		rxe_dbg_dev(rxe, "unable to create ah\n");
 		goto err_out;
 	}
 
@@ -288,7 +288,7 @@ static int rxe_create_ah(struct ib_ah *ibah,
 
 	err = rxe_ah_chk_attr(ah, init_attr->ah_attr);
 	if (err) {
-		rxe_dbg_ah(ah, "bad attr");
+		rxe_dbg_ah(ah, "bad attr\n");
 		goto err_cleanup;
 	}
 
@@ -298,7 +298,7 @@ static int rxe_create_ah(struct ib_ah *ibah,
 					 sizeof(uresp->ah_num));
 		if (err) {
 			err = -EFAULT;
-			rxe_dbg_ah(ah, "unable to copy to user");
+			rxe_dbg_ah(ah, "unable to copy to user\n");
 			goto err_cleanup;
 		}
 	} else if (ah->is_user) {
@@ -314,9 +314,9 @@ static int rxe_create_ah(struct ib_ah *ibah,
 err_cleanup:
 	cleanup_err = rxe_cleanup(ah);
 	if (cleanup_err)
-		rxe_err_ah(ah, "cleanup failed, err = %d", cleanup_err);
+		rxe_err_ah(ah, "cleanup failed, err = %d\n", cleanup_err);
 err_out:
-	rxe_err_ah(ah, "returned err = %d", err);
+	rxe_err_ah(ah, "returned err = %d\n", err);
 	return err;
 }
 
@@ -327,7 +327,7 @@ static int rxe_modify_ah(struct ib_ah *ibah, struct rdma_ah_attr *attr)
 
 	err = rxe_ah_chk_attr(ah, attr);
 	if (err) {
-		rxe_dbg_ah(ah, "bad attr");
+		rxe_dbg_ah(ah, "bad attr\n");
 		goto err_out;
 	}
 
@@ -336,7 +336,7 @@ static int rxe_modify_ah(struct ib_ah *ibah, struct rdma_ah_attr *attr)
 	return 0;
 
 err_out:
-	rxe_err_ah(ah, "returned err = %d", err);
+	rxe_err_ah(ah, "returned err = %d\n", err);
 	return err;
 }
 
@@ -358,7 +358,7 @@ static int rxe_destroy_ah(struct ib_ah *ibah, u32 flags)
 
 	err = rxe_cleanup_ah(ah, flags & RDMA_DESTROY_AH_SLEEPABLE);
 	if (err)
-		rxe_err_ah(ah, "cleanup failed, err = %d", err);
+		rxe_err_ah(ah, "cleanup failed, err = %d\n", err);
 
 	return 0;
 }
@@ -376,7 +376,7 @@ static int rxe_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init,
 	if (udata) {
 		if (udata->outlen < sizeof(*uresp)) {
 			err = -EINVAL;
-			rxe_err_dev(rxe, "malformed udata");
+			rxe_err_dev(rxe, "malformed udata\n");
 			goto err_out;
 		}
 		uresp = udata->outbuf;
@@ -384,20 +384,20 @@ static int rxe_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init,
 
 	if (init->srq_type != IB_SRQT_BASIC) {
 		err = -EOPNOTSUPP;
-		rxe_dbg_dev(rxe, "srq type = %d, not supported",
+		rxe_dbg_dev(rxe, "srq type = %d, not supported\n",
 				init->srq_type);
 		goto err_out;
 	}
 
 	err = rxe_srq_chk_init(rxe, init);
 	if (err) {
-		rxe_dbg_dev(rxe, "invalid init attributes");
+		rxe_dbg_dev(rxe, "invalid init attributes\n");
 		goto err_out;
 	}
 
 	err = rxe_add_to_pool(&rxe->srq_pool, srq);
 	if (err) {
-		rxe_dbg_dev(rxe, "unable to create srq, err = %d", err);
+		rxe_dbg_dev(rxe, "unable to create srq, err = %d\n", err);
 		goto err_out;
 	}
 
@@ -406,7 +406,7 @@ static int rxe_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init,
 
 	err = rxe_srq_from_init(rxe, srq, init, udata, uresp);
 	if (err) {
-		rxe_dbg_srq(srq, "create srq failed, err = %d", err);
+		rxe_dbg_srq(srq, "create srq failed, err = %d\n", err);
 		goto err_cleanup;
 	}
 
@@ -415,9 +415,9 @@ static int rxe_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init,
 err_cleanup:
 	cleanup_err = rxe_cleanup(srq);
 	if (cleanup_err)
-		rxe_err_srq(srq, "cleanup failed, err = %d", cleanup_err);
+		rxe_err_srq(srq, "cleanup failed, err = %d\n", cleanup_err);
 err_out:
-	rxe_err_dev(rxe, "returned err = %d", err);
+	rxe_err_dev(rxe, "returned err = %d\n", err);
 	return err;
 }
 
@@ -433,34 +433,34 @@ static int rxe_modify_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr,
 	if (udata) {
 		if (udata->inlen < sizeof(cmd)) {
 			err = -EINVAL;
-			rxe_dbg_srq(srq, "malformed udata");
+			rxe_dbg_srq(srq, "malformed udata\n");
 			goto err_out;
 		}
 
 		err = ib_copy_from_udata(&cmd, udata, sizeof(cmd));
 		if (err) {
 			err = -EFAULT;
-			rxe_dbg_srq(srq, "unable to read udata");
+			rxe_dbg_srq(srq, "unable to read udata\n");
 			goto err_out;
 		}
 	}
 
 	err = rxe_srq_chk_attr(rxe, srq, attr, mask);
 	if (err) {
-		rxe_dbg_srq(srq, "bad init attributes");
+		rxe_dbg_srq(srq, "bad init attributes\n");
 		goto err_out;
 	}
 
 	err = rxe_srq_from_attr(rxe, srq, attr, mask, &cmd, udata);
 	if (err) {
-		rxe_dbg_srq(srq, "bad attr");
+		rxe_dbg_srq(srq, "bad attr\n");
 		goto err_out;
 	}
 
 	return 0;
 
 err_out:
-	rxe_err_srq(srq, "returned err = %d", err);
+	rxe_err_srq(srq, "returned err = %d\n", err);
 	return err;
 }
 
@@ -471,7 +471,7 @@ static int rxe_query_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr)
 
 	if (srq->error) {
 		err = -EINVAL;
-		rxe_dbg_srq(srq, "srq in error state");
+		rxe_dbg_srq(srq, "srq in error state\n");
 		goto err_out;
 	}
 
@@ -481,7 +481,7 @@ static int rxe_query_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr)
 	return 0;
 
 err_out:
-	rxe_err_srq(srq, "returned err = %d", err);
+	rxe_err_srq(srq, "returned err = %d\n", err);
 	return err;
 }
 
@@ -505,7 +505,7 @@ static int rxe_post_srq_recv(struct ib_srq *ibsrq, const struct ib_recv_wr *wr,
 
 	if (err) {
 		*bad_wr = wr;
-		rxe_err_srq(srq, "returned err = %d", err);
+		rxe_err_srq(srq, "returned err = %d\n", err);
 	}
 
 	return err;
@@ -518,7 +518,7 @@ static int rxe_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
 
 	err = rxe_cleanup(srq);
 	if (err)
-		rxe_err_srq(srq, "cleanup failed, err = %d", err);
+		rxe_err_srq(srq, "cleanup failed, err = %d\n", err);
 
 	return 0;
 }
@@ -536,13 +536,13 @@ static int rxe_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init,
 	if (udata) {
 		if (udata->inlen) {
 			err = -EINVAL;
-			rxe_dbg_dev(rxe, "malformed udata, err = %d", err);
+			rxe_dbg_dev(rxe, "malformed udata, err = %d\n", err);
 			goto err_out;
 		}
 
 		if (udata->outlen < sizeof(*uresp)) {
 			err = -EINVAL;
-			rxe_dbg_dev(rxe, "malformed udata, err = %d", err);
+			rxe_dbg_dev(rxe, "malformed udata, err = %d\n", err);
 			goto err_out;
 		}
 
@@ -554,25 +554,25 @@ static int rxe_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init,
 
 	if (init->create_flags) {
 		err = -EOPNOTSUPP;
-		rxe_dbg_dev(rxe, "unsupported create_flags, err = %d", err);
+		rxe_dbg_dev(rxe, "unsupported create_flags, err = %d\n", err);
 		goto err_out;
 	}
 
 	err = rxe_qp_chk_init(rxe, init);
 	if (err) {
-		rxe_dbg_dev(rxe, "bad init attr, err = %d", err);
+		rxe_dbg_dev(rxe, "bad init attr, err = %d\n", err);
 		goto err_out;
 	}
 
 	err = rxe_add_to_pool(&rxe->qp_pool, qp);
 	if (err) {
-		rxe_dbg_dev(rxe, "unable to create qp, err = %d", err);
+		rxe_dbg_dev(rxe, "unable to create qp, err = %d\n", err);
 		goto err_out;
 	}
 
 	err = rxe_qp_from_init(rxe, qp, pd, init, uresp, ibqp->pd, udata);
 	if (err) {
-		rxe_dbg_qp(qp, "create qp failed, err = %d", err);
+		rxe_dbg_qp(qp, "create qp failed, err = %d\n", err);
 		goto err_cleanup;
 	}
 
@@ -582,9 +582,9 @@ static int rxe_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init,
 err_cleanup:
 	cleanup_err = rxe_cleanup(qp);
 	if (cleanup_err)
-		rxe_err_qp(qp, "cleanup failed, err = %d", cleanup_err);
+		rxe_err_qp(qp, "cleanup failed, err = %d\n", cleanup_err);
 err_out:
-	rxe_err_dev(rxe, "returned err = %d", err);
+	rxe_err_dev(rxe, "returned err = %d\n", err);
 	return err;
 }
 
@@ -597,20 +597,20 @@ static int rxe_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 
 	if (mask & ~IB_QP_ATTR_STANDARD_BITS) {
 		err = -EOPNOTSUPP;
-		rxe_dbg_qp(qp, "unsupported mask = 0x%x, err = %d",
+		rxe_dbg_qp(qp, "unsupported mask = 0x%x, err = %d\n",
 			   mask, err);
 		goto err_out;
 	}
 
 	err = rxe_qp_chk_attr(rxe, qp, attr, mask);
 	if (err) {
-		rxe_dbg_qp(qp, "bad mask/attr, err = %d", err);
+		rxe_dbg_qp(qp, "bad mask/attr, err = %d\n", err);
 		goto err_out;
 	}
 
 	err = rxe_qp_from_attr(qp, attr, mask, udata);
 	if (err) {
-		rxe_dbg_qp(qp, "modify qp failed, err = %d", err);
+		rxe_dbg_qp(qp, "modify qp failed, err = %d\n", err);
 		goto err_out;
 	}
 
@@ -622,7 +622,7 @@ static int rxe_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 	return 0;
 
 err_out:
-	rxe_err_qp(qp, "returned err = %d", err);
+	rxe_err_qp(qp, "returned err = %d\n", err);
 	return err;
 }
 
@@ -644,18 +644,18 @@ static int rxe_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 
 	err = rxe_qp_chk_destroy(qp);
 	if (err) {
-		rxe_dbg_qp(qp, "unable to destroy qp, err = %d", err);
+		rxe_dbg_qp(qp, "unable to destroy qp, err = %d\n", err);
 		goto err_out;
 	}
 
 	err = rxe_cleanup(qp);
 	if (err)
-		rxe_err_qp(qp, "cleanup failed, err = %d", err);
+		rxe_err_qp(qp, "cleanup failed, err = %d\n", err);
 
 	return 0;
 
 err_out:
-	rxe_err_qp(qp, "returned err = %d", err);
+	rxe_err_qp(qp, "returned err = %d\n", err);
 	return err;
 }
 
@@ -675,12 +675,12 @@ static int validate_send_wr(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
 	do {
 		mask = wr_opcode_mask(ibwr->opcode, qp);
 		if (!mask) {
-			rxe_err_qp(qp, "bad wr opcode for qp type");
+			rxe_err_qp(qp, "bad wr opcode for qp type\n");
 			break;
 		}
 
 		if (num_sge > sq->max_sge) {
-			rxe_err_qp(qp, "num_sge > max_sge");
+			rxe_err_qp(qp, "num_sge > max_sge\n");
 			break;
 		}
 
@@ -689,27 +689,27 @@ static int validate_send_wr(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
 			length += ibwr->sg_list[i].length;
 
 		if (length > (1UL << 31)) {
-			rxe_err_qp(qp, "message length too long");
+			rxe_err_qp(qp, "message length too long\n");
 			break;
 		}
 
 		if (mask & WR_ATOMIC_MASK) {
 			if (length != 8) {
-				rxe_err_qp(qp, "atomic length != 8");
+				rxe_err_qp(qp, "atomic length != 8\n");
 				break;
 			}
 			if (atomic_wr(ibwr)->remote_addr & 0x7) {
-				rxe_err_qp(qp, "misaligned atomic address");
+				rxe_err_qp(qp, "misaligned atomic address\n");
 				break;
 			}
 		}
 		if (ibwr->send_flags & IB_SEND_INLINE) {
 			if (!(mask & WR_INLINE_MASK)) {
-				rxe_err_qp(qp, "opcode doesn't support inline data");
+				rxe_err_qp(qp, "opcode doesn't support inline data\n");
 				break;
 			}
 			if (length > sq->max_inline) {
-				rxe_err_qp(qp, "inline length too big");
+				rxe_err_qp(qp, "inline length too big\n");
 				break;
 			}
 		}
@@ -747,7 +747,7 @@ static int init_send_wr(struct rxe_qp *qp, struct rxe_send_wr *wr,
 		case IB_WR_SEND:
 			break;
 		default:
-			rxe_err_qp(qp, "bad wr opcode %d for UD/GSI QP",
+			rxe_err_qp(qp, "bad wr opcode %d for UD/GSI QP\n",
 					wr->opcode);
 			return -EINVAL;
 		}
@@ -795,7 +795,7 @@ static int init_send_wr(struct rxe_qp *qp, struct rxe_send_wr *wr,
 		case IB_WR_ATOMIC_WRITE:
 			break;
 		default:
-			rxe_err_qp(qp, "unsupported wr opcode %d",
+			rxe_err_qp(qp, "unsupported wr opcode %d\n",
 					wr->opcode);
 			return -EINVAL;
 			break;
@@ -871,7 +871,7 @@ static int post_one_send(struct rxe_qp *qp, const struct ib_send_wr *ibwr)
 
 	full = queue_full(sq->queue, QUEUE_TYPE_FROM_ULP);
 	if (unlikely(full)) {
-		rxe_err_qp(qp, "send queue full");
+		rxe_err_qp(qp, "send queue full\n");
 		return -ENOMEM;
 	}
 
@@ -923,14 +923,14 @@ static int rxe_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 	/* caller has already called destroy_qp */
 	if (WARN_ON_ONCE(!qp->valid)) {
 		spin_unlock_irqrestore(&qp->state_lock, flags);
-		rxe_err_qp(qp, "qp has been destroyed");
+		rxe_err_qp(qp, "qp has been destroyed\n");
 		return -EINVAL;
 	}
 
 	if (unlikely(qp_state(qp) < IB_QPS_RTS)) {
 		spin_unlock_irqrestore(&qp->state_lock, flags);
 		*bad_wr = wr;
-		rxe_err_qp(qp, "qp not ready to send");
+		rxe_err_qp(qp, "qp not ready to send\n");
 		return -EINVAL;
 	}
 	spin_unlock_irqrestore(&qp->state_lock, flags);
@@ -960,13 +960,13 @@ static int post_one_recv(struct rxe_rq *rq, const struct ib_recv_wr *ibwr)
 	full = queue_full(rq->queue, QUEUE_TYPE_FROM_ULP);
 	if (unlikely(full)) {
 		err = -ENOMEM;
-		rxe_dbg("queue full");
+		rxe_dbg("queue full\n");
 		goto err_out;
 	}
 
 	if (unlikely(num_sge > rq->max_sge)) {
 		err = -EINVAL;
-		rxe_dbg("bad num_sge > max_sge");
+		rxe_dbg("bad num_sge > max_sge\n");
 		goto err_out;
 	}
 
@@ -977,7 +977,7 @@ static int post_one_recv(struct rxe_rq *rq, const struct ib_recv_wr *ibwr)
 	/* IBA max message size is 2^31 */
 	if (length >= (1UL<<31)) {
 		err = -EINVAL;
-		rxe_dbg("message length too long");
+		rxe_dbg("message length too long\n");
 		goto err_out;
 	}
 
@@ -997,7 +997,7 @@ static int post_one_recv(struct rxe_rq *rq, const struct ib_recv_wr *ibwr)
 	return 0;
 
 err_out:
-	rxe_dbg("returned err = %d", err);
+	rxe_dbg("returned err = %d\n", err);
 	return err;
 }
 
@@ -1013,7 +1013,7 @@ static int rxe_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
 	/* caller has already called destroy_qp */
 	if (WARN_ON_ONCE(!qp->valid)) {
 		spin_unlock_irqrestore(&qp->state_lock, flags);
-		rxe_err_qp(qp, "qp has been destroyed");
+		rxe_err_qp(qp, "qp has been destroyed\n");
 		return -EINVAL;
 	}
 
@@ -1021,14 +1021,14 @@ static int rxe_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
 	if (unlikely((qp_state(qp) < IB_QPS_INIT))) {
 		spin_unlock_irqrestore(&qp->state_lock, flags);
 		*bad_wr = wr;
-		rxe_dbg_qp(qp, "qp not ready to post recv");
+		rxe_dbg_qp(qp, "qp not ready to post recv\n");
 		return -EINVAL;
 	}
 	spin_unlock_irqrestore(&qp->state_lock, flags);
 
 	if (unlikely(qp->srq)) {
 		*bad_wr = wr;
-		rxe_dbg_qp(qp, "qp has srq, use post_srq_recv instead");
+		rxe_dbg_qp(qp, "qp has srq, use post_srq_recv instead\n");
 		return -EINVAL;
 	}
 
@@ -1066,7 +1066,7 @@ static int rxe_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	if (udata) {
 		if (udata->outlen < sizeof(*uresp)) {
 			err = -EINVAL;
-			rxe_dbg_dev(rxe, "malformed udata, err = %d", err);
+			rxe_dbg_dev(rxe, "malformed udata, err = %d\n", err);
 			goto err_out;
 		}
 		uresp = udata->outbuf;
@@ -1074,26 +1074,26 @@ static int rxe_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 
 	if (attr->flags) {
 		err = -EOPNOTSUPP;
-		rxe_dbg_dev(rxe, "bad attr->flags, err = %d", err);
+		rxe_dbg_dev(rxe, "bad attr->flags, err = %d\n", err);
 		goto err_out;
 	}
 
 	err = rxe_cq_chk_attr(rxe, NULL, attr->cqe, attr->comp_vector);
 	if (err) {
-		rxe_dbg_dev(rxe, "bad init attributes, err = %d", err);
+		rxe_dbg_dev(rxe, "bad init attributes, err = %d\n", err);
 		goto err_out;
 	}
 
 	err = rxe_add_to_pool(&rxe->cq_pool, cq);
 	if (err) {
-		rxe_dbg_dev(rxe, "unable to create cq, err = %d", err);
+		rxe_dbg_dev(rxe, "unable to create cq, err = %d\n", err);
 		goto err_out;
 	}
 
 	err = rxe_cq_from_init(rxe, cq, attr->cqe, attr->comp_vector, udata,
 			       uresp);
 	if (err) {
-		rxe_dbg_cq(cq, "create cq failed, err = %d", err);
+		rxe_dbg_cq(cq, "create cq failed, err = %d\n", err);
 		goto err_cleanup;
 	}
 
@@ -1102,9 +1102,9 @@ static int rxe_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 err_cleanup:
 	cleanup_err = rxe_cleanup(cq);
 	if (cleanup_err)
-		rxe_err_cq(cq, "cleanup failed, err = %d", cleanup_err);
+		rxe_err_cq(cq, "cleanup failed, err = %d\n", cleanup_err);
 err_out:
-	rxe_err_dev(rxe, "returned err = %d", err);
+	rxe_err_dev(rxe, "returned err = %d\n", err);
 	return err;
 }
 
@@ -1118,7 +1118,7 @@ static int rxe_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata)
 	if (udata) {
 		if (udata->outlen < sizeof(*uresp)) {
 			err = -EINVAL;
-			rxe_dbg_cq(cq, "malformed udata");
+			rxe_dbg_cq(cq, "malformed udata\n");
 			goto err_out;
 		}
 		uresp = udata->outbuf;
@@ -1126,20 +1126,20 @@ static int rxe_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata)
 
 	err = rxe_cq_chk_attr(rxe, cq, cqe, 0);
 	if (err) {
-		rxe_dbg_cq(cq, "bad attr, err = %d", err);
+		rxe_dbg_cq(cq, "bad attr, err = %d\n", err);
 		goto err_out;
 	}
 
 	err = rxe_cq_resize_queue(cq, cqe, uresp, udata);
 	if (err) {
-		rxe_dbg_cq(cq, "resize cq failed, err = %d", err);
+		rxe_dbg_cq(cq, "resize cq failed, err = %d\n", err);
 		goto err_out;
 	}
 
 	return 0;
 
 err_out:
-	rxe_err_cq(cq, "returned err = %d", err);
+	rxe_err_cq(cq, "returned err = %d\n", err);
 	return err;
 }
 
@@ -1203,18 +1203,18 @@ static int rxe_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 	 */
 	if (atomic_read(&cq->num_wq)) {
 		err = -EINVAL;
-		rxe_dbg_cq(cq, "still in use");
+		rxe_dbg_cq(cq, "still in use\n");
 		goto err_out;
 	}
 
 	err = rxe_cleanup(cq);
 	if (err)
-		rxe_err_cq(cq, "cleanup failed, err = %d", err);
+		rxe_err_cq(cq, "cleanup failed, err = %d\n", err);
 
 	return 0;
 
 err_out:
-	rxe_err_cq(cq, "returned err = %d", err);
+	rxe_err_cq(cq, "returned err = %d\n", err);
 	return err;
 }
 
@@ -1232,7 +1232,7 @@ static struct ib_mr *rxe_get_dma_mr(struct ib_pd *ibpd, int access)
 
 	err = rxe_add_to_pool(&rxe->mr_pool, mr);
 	if (err) {
-		rxe_dbg_dev(rxe, "unable to create mr");
+		rxe_dbg_dev(rxe, "unable to create mr\n");
 		goto err_free;
 	}
 
@@ -1246,7 +1246,7 @@ static struct ib_mr *rxe_get_dma_mr(struct ib_pd *ibpd, int access)
 
 err_free:
 	kfree(mr);
-	rxe_err_pd(pd, "returned err = %d", err);
+	rxe_err_pd(pd, "returned err = %d\n", err);
 	return ERR_PTR(err);
 }
 
@@ -1260,7 +1260,7 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd, u64 start,
 	int err, cleanup_err;
 
 	if (access & ~RXE_ACCESS_SUPPORTED_MR) {
-		rxe_err_pd(pd, "access = %#x not supported (%#x)", access,
+		rxe_err_pd(pd, "access = %#x not supported (%#x)\n", access,
 				RXE_ACCESS_SUPPORTED_MR);
 		return ERR_PTR(-EOPNOTSUPP);
 	}
@@ -1271,7 +1271,7 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd, u64 start,
 
 	err = rxe_add_to_pool(&rxe->mr_pool, mr);
 	if (err) {
-		rxe_dbg_pd(pd, "unable to create mr");
+		rxe_dbg_pd(pd, "unable to create mr\n");
 		goto err_free;
 	}
 
@@ -1281,7 +1281,7 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd, u64 start,
 
 	err = rxe_mr_init_user(rxe, start, length, iova, access, mr);
 	if (err) {
-		rxe_dbg_mr(mr, "reg_user_mr failed, err = %d", err);
+		rxe_dbg_mr(mr, "reg_user_mr failed, err = %d\n", err);
 		goto err_cleanup;
 	}
 
@@ -1291,10 +1291,10 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd, u64 start,
 err_cleanup:
 	cleanup_err = rxe_cleanup(mr);
 	if (cleanup_err)
-		rxe_err_mr(mr, "cleanup failed, err = %d", cleanup_err);
+		rxe_err_mr(mr, "cleanup failed, err = %d\n", cleanup_err);
 err_free:
 	kfree(mr);
-	rxe_err_pd(pd, "returned err = %d", err);
+	rxe_err_pd(pd, "returned err = %d\n", err);
 	return ERR_PTR(err);
 }
 
@@ -1311,7 +1311,7 @@ static struct ib_mr *rxe_rereg_user_mr(struct ib_mr *ibmr, int flags,
 	 * rereg_pd and rereg_access
 	 */
 	if (flags & ~RXE_MR_REREG_SUPPORTED) {
-		rxe_err_mr(mr, "flags = %#x not supported", flags);
+		rxe_err_mr(mr, "flags = %#x not supported\n", flags);
 		return ERR_PTR(-EOPNOTSUPP);
 	}
 
@@ -1323,7 +1323,7 @@ static struct ib_mr *rxe_rereg_user_mr(struct ib_mr *ibmr, int flags,
 
 	if (flags & IB_MR_REREG_ACCESS) {
 		if (access & ~RXE_ACCESS_SUPPORTED_MR) {
-			rxe_err_mr(mr, "access = %#x not supported", access);
+			rxe_err_mr(mr, "access = %#x not supported\n", access);
 			return ERR_PTR(-EOPNOTSUPP);
 		}
 		mr->access = access;
@@ -1342,7 +1342,7 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 
 	if (mr_type != IB_MR_TYPE_MEM_REG) {
 		err = -EINVAL;
-		rxe_dbg_pd(pd, "mr type %d not supported, err = %d",
+		rxe_dbg_pd(pd, "mr type %d not supported, err = %d\n",
 			   mr_type, err);
 		goto err_out;
 	}
@@ -1361,7 +1361,7 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 
 	err = rxe_mr_init_fast(max_num_sg, mr);
 	if (err) {
-		rxe_dbg_mr(mr, "alloc_mr failed, err = %d", err);
+		rxe_dbg_mr(mr, "alloc_mr failed, err = %d\n", err);
 		goto err_cleanup;
 	}
 
@@ -1371,11 +1371,11 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 err_cleanup:
 	cleanup_err = rxe_cleanup(mr);
 	if (cleanup_err)
-		rxe_err_mr(mr, "cleanup failed, err = %d", err);
+		rxe_err_mr(mr, "cleanup failed, err = %d\n", err);
 err_free:
 	kfree(mr);
 err_out:
-	rxe_err_pd(pd, "returned err = %d", err);
+	rxe_err_pd(pd, "returned err = %d\n", err);
 	return ERR_PTR(err);
 }
 
@@ -1387,19 +1387,19 @@ static int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 	/* See IBA 10.6.7.2.6 */
 	if (atomic_read(&mr->num_mw) > 0) {
 		err = -EINVAL;
-		rxe_dbg_mr(mr, "mr has mw's bound");
+		rxe_dbg_mr(mr, "mr has mw's bound\n");
 		goto err_out;
 	}
 
 	cleanup_err = rxe_cleanup(mr);
 	if (cleanup_err)
-		rxe_err_mr(mr, "cleanup failed, err = %d", cleanup_err);
+		rxe_err_mr(mr, "cleanup failed, err = %d\n", cleanup_err);
 
 	kfree_rcu_mightsleep(mr);
 	return 0;
 
 err_out:
-	rxe_err_mr(mr, "returned err = %d", err);
+	rxe_err_mr(mr, "returned err = %d\n", err);
 	return err;
 }
 
-- 
2.29.2

