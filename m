Return-Path: <linux-rdma+bounces-15349-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2B6CFF285
	for <lists+linux-rdma@lfdr.de>; Wed, 07 Jan 2026 18:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F439325CE2E
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Jan 2026 16:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60DA34D383;
	Wed,  7 Jan 2026 16:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="XcjYraPu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B663433B940
	for <linux-rdma@vger.kernel.org>; Wed,  7 Jan 2026 16:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767802529; cv=none; b=Kn6CJHXO6gQOUQQKp9AhaHholViIDHxHMsPxNIvnezcT8bsRp9Kc15zlTFq8qnypinydOkp9BCcbJNKQqpvdL8zVGbYFn+2mW58duGgbYavvHZYnQOeBEMcBxpCLBtV07c/uW5wQW+llN+CWGeNReqFQQDOOPjOyioru1ctEQQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767802529; c=relaxed/simple;
	bh=n70b9r3rRBxfP1jXA5UglvNZXeI6WBWlJoVDRCLUCT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RnTG+5X/b81HrcVpcdRrWy2tpRJrcMxsUv2Eu3OUwO+KIzJU+M3oYCeAL9LecE7TXTjOFfYaGsrCnQi9fWdoZEnV3KlY7Qx205Y8AnJrA4RWQg1zSQhDIBqKg4Aqz3leemeez/WjzVpnE3QtjWJYRKbTFhsjIRZwk/n82/DAzL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=XcjYraPu; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-64b791b5584so3588878a12.0
        for <linux-rdma@vger.kernel.org>; Wed, 07 Jan 2026 08:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1767802522; x=1768407322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbFF+R4MIbujC0PeUW5w+RgWBQrLZb3gIAVoq9l8yYM=;
        b=XcjYraPuqveuT6rdBTYX1Ojo08KXkKBtbPDUXjjwxjThXhd8wTucF25l5ecxa9gaf6
         UUUxXylY8QCQFaiCLGFxkG+HeuE1L90TaX2bAMo63n5nR7/OU7tCL0FjxaJHWVZFCTnn
         25eeAYtQrMxy8m2hxuRUGLB780mBxdpcLAYzL4cTXT3MTXkkXYhsO9jykjX5q2Ql0cNJ
         2l2sUPdG7/veAOdU5vdmEhDREiOWOBO8uPZkp/6IY0ZZMUUnBYrgQs7AVynHU/NmOJr9
         SubxxRHXheYnIQOshN3kfhWlXduUnazEWKdHVraK2trDVEYKJHB3Z8FiexE+xQvcB0dN
         iUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767802522; x=1768407322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zbFF+R4MIbujC0PeUW5w+RgWBQrLZb3gIAVoq9l8yYM=;
        b=AeHmXxAVd1J6qZqXNs7vbdjJVGWI25yfI1eBmD1oFt+CA5slNtIJcDo5XgizQGlhJM
         nQbzyXlzFRI0h/39Xg0bqi8xr1AD9HItlwbiut1CGvv2RYH/Xlo0BzBKa3RYOf3U7kWY
         qMZ8v6pbszfysc99xbPE4ITxObYuViBwjebQuxNysN5H5fCKDANszHKDcm2UkXpHBqpk
         2cFkOpLBwPkS8o3m71QLm8dbK+gpRLgxYYEDuboIJmic8tnrL5uVlQGPNMQi8Kv0u9bV
         G+3l5QHNTKdDkI2sokXZW+V7OBNBTfRteUSrLgwSpApzDMCxz5K6SCgHco20jCPMjM/X
         b5oQ==
X-Gm-Message-State: AOJu0Yx1WQdhz9+yyZOt18Rv8w0upRCoFwnsGphR4RCwjMC7u2XGUmMA
	0WIlz847JEs1e76vI6FMgdEUdM7aCPHV2cTj7KSi+VO59EbML5vAEQhrqeDx8fOC181g0SrASIn
	/OCLw
X-Gm-Gg: AY/fxX6b/+tdS4GUzhizh8mvgYRXflS5CutqQxRJbWh/XLhtr8+WU6d0SM0BEyniGng
	F4sZEo6hV5SJtXopMaUOX0DS/D9zXJ3POSmK6Uue33ieebgFlj9ZNXUvjF27vWkfbY9ICwPxAbi
	2Yylzo1cRe8Gem2YLAFe5w9WhJV6jFJmxftgHclseH1KeaCUzDm3Xu3gFk6/HVFUggxzmD3dcdm
	Tt08HONAqCc088G9LbRt21XcG/brBs8rk1TZetbMDGRE292PLVI6zBKVG2q7Nei6b9hOeZnoL0E
	rnWUEvgF8N1mLkiFzItPOrhmvAeOdT/EgwFpYaFd7WSVFblf7ebYAwkcc1PmS1SN8YSERFMmKi/
	ZILtGYRz4KarRv7jPRJYpuAB69t+/N4/6c+2SCcW8Uf7LWDi4puiUZwYuiqRhjY4Khf4EhCgGX2
	5dgjafDN7lhX0TIdLrerjdQ09pDZbys7n+Ak2BGXhq0wnbUBL8ir/OQg04VHyoVv1ZvWRn/5ntY
	ddDTNKkfjFyUJDPO6gX7FY=
X-Google-Smtp-Source: AGHT+IFs84gvl257caSgaOdEj1xKtZVrqAqzQXc7zsSTlLabZRqtDqV3kd8iDKQ38gQ8jWYMdbHUig==
X-Received: by 2002:a05:6402:4316:b0:64b:7dd2:6bc2 with SMTP id 4fb4d7f45d1cf-65097de7d06mr2652027a12.7.1767802521812;
        Wed, 07 Jan 2026 08:15:21 -0800 (PST)
Received: from lb03189.fkb.profitbricks.net ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507b9d4c89sm4864773a12.10.2026.01.07.08.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 08:15:21 -0800 (PST)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-rdma@vger.kernel.org
Cc: bvanassche@acm.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com,
	grzegorz.prajsner@ionos.com,
	Kim Zhu <zhu.yanjun@ionos.com>
Subject: [PATCH v2 02/10] RDMA/rtrs: Add error description to the logs
Date: Wed,  7 Jan 2026 17:15:09 +0100
Message-ID: <20260107161517.56357-3-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260107161517.56357-1-haris.iqbal@ionos.com>
References: <20260107161517.56357-1-haris.iqbal@ionos.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kim Zhu <zhu.yanjun@ionos.com>

Print error description instead of the error number.

Signed-off-by: Kim Zhu <zhu.yanjun@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
---
v2:
- Addressed comment to print only error description.
- Removed changes for a single print which had 0/1 as err value.

 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c |  8 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt.c       | 88 ++++++++++----------
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c | 12 +--
 drivers/infiniband/ulp/rtrs/rtrs-srv.c       | 78 ++++++++---------
 drivers/infiniband/ulp/rtrs/rtrs.c           |  9 +-
 5 files changed, 100 insertions(+), 95 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
index 4aa80c9388f0..287e0ea43287 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
@@ -439,19 +439,19 @@ int rtrs_clt_create_path_files(struct rtrs_clt_path *clt_path)
 				   clt->kobj_paths,
 				   "%s", str);
 	if (err) {
-		pr_err("kobject_init_and_add: %d\n", err);
+		pr_err("kobject_init_and_add: %pe\n", ERR_PTR(err));
 		kobject_put(&clt_path->kobj);
 		return err;
 	}
 	err = sysfs_create_group(&clt_path->kobj, &rtrs_clt_path_attr_group);
 	if (err) {
-		pr_err("sysfs_create_group(): %d\n", err);
+		pr_err("sysfs_create_group(): %pe\n", ERR_PTR(err));
 		goto put_kobj;
 	}
 	err = kobject_init_and_add(&clt_path->stats->kobj_stats, &ktype_stats,
 				   &clt_path->kobj, "stats");
 	if (err) {
-		pr_err("kobject_init_and_add: %d\n", err);
+		pr_err("kobject_init_and_add: %pe\n", ERR_PTR(err));
 		kobject_put(&clt_path->stats->kobj_stats);
 		goto remove_group;
 	}
@@ -459,7 +459,7 @@ int rtrs_clt_create_path_files(struct rtrs_clt_path *clt_path)
 	err = sysfs_create_group(&clt_path->stats->kobj_stats,
 				 &rtrs_clt_stats_attr_group);
 	if (err) {
-		pr_err("failed to create stats sysfs group, err: %d\n", err);
+		pr_err("failed to create stats sysfs group, err: %pe\n", ERR_PTR(err));
 		goto put_kobj_stats;
 	}
 
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 2b397a544cb9..56b98a7fde45 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -422,8 +422,8 @@ static void complete_rdma_req(struct rtrs_clt_io_req *req, int errno,
 			refcount_inc(&req->ref);
 			err = rtrs_inv_rkey(req);
 			if (err) {
-				rtrs_err_rl(con->c.path, "Send INV WR key=%#x: %d\n",
-					  req->mr->rkey, err);
+				rtrs_err_rl(con->c.path, "Send INV WR key=%#x: %pe\n",
+					    req->mr->rkey, ERR_PTR(err));
 			} else if (can_wait) {
 				wait_for_completion(&req->inv_comp);
 			}
@@ -443,8 +443,8 @@ static void complete_rdma_req(struct rtrs_clt_io_req *req, int errno,
 
 	if (errno) {
 		rtrs_err_rl(con->c.path,
-			    "IO %s request failed: error=%d path=%s [%s:%u] notify=%d\n",
-			    req->dir == DMA_TO_DEVICE ? "write" : "read", errno,
+			    "IO %s request failed: error=%pe path=%s [%s:%u] notify=%d\n",
+			    req->dir == DMA_TO_DEVICE ? "write" : "read", ERR_PTR(errno),
 			    kobject_name(&clt_path->kobj), clt_path->hca_name,
 			    clt_path->hca_port, notify);
 	}
@@ -514,7 +514,7 @@ static void rtrs_clt_recv_done(struct rtrs_clt_con *con, struct ib_wc *wc)
 			  cqe);
 	err = rtrs_iu_post_recv(&con->c, iu);
 	if (err) {
-		rtrs_err(con->c.path, "post iu failed %d\n", err);
+		rtrs_err(con->c.path, "post iu failed %pe\n", ERR_PTR(err));
 		rtrs_rdma_error_recovery(con);
 	}
 }
@@ -659,8 +659,8 @@ static void rtrs_clt_rdma_done(struct ib_cq *cq, struct ib_wc *wc)
 		else
 			err = rtrs_post_recv_empty(&con->c, &io_comp_cqe);
 		if (err) {
-			rtrs_err(con->c.path, "rtrs_post_recv_empty(): %d\n",
-				  err);
+			rtrs_err(con->c.path, "rtrs_post_recv_empty(): %pe\n",
+				 ERR_PTR(err));
 			rtrs_rdma_error_recovery(con);
 		}
 		break;
@@ -731,8 +731,8 @@ static int post_recv_path(struct rtrs_clt_path *clt_path)
 
 		err = post_recv_io(to_clt_con(clt_path->s.con[cid]), q_size);
 		if (err) {
-			rtrs_err(clt_path->clt, "post_recv_io(), err: %d\n",
-				 err);
+			rtrs_err(clt_path->clt, "post_recv_io(), err: %pe\n",
+				 ERR_PTR(err));
 			return err;
 		}
 	}
@@ -1122,8 +1122,8 @@ static int rtrs_clt_write_req(struct rtrs_clt_io_req *req)
 		ret = rtrs_map_sg_fr(req, count);
 		if (ret < 0) {
 			rtrs_err_rl(s,
-				    "Write request failed, failed to map fast reg. data, err: %d\n",
-				    ret);
+				    "Write request failed, failed to map fast reg. data, err: %pe\n",
+				    ERR_PTR(ret));
 			ib_dma_unmap_sg(clt_path->s.dev->ib_dev, req->sglist,
 					req->sg_cnt, req->dir);
 			return ret;
@@ -1150,9 +1150,9 @@ static int rtrs_clt_write_req(struct rtrs_clt_io_req *req)
 				      imm, wr, NULL);
 	if (ret) {
 		rtrs_err_rl(s,
-			    "Write request failed: error=%d path=%s [%s:%u]\n",
-			    ret, kobject_name(&clt_path->kobj), clt_path->hca_name,
-			    clt_path->hca_port);
+			    "Write request failed: error=%pe path=%s [%s:%u]\n",
+			    ERR_PTR(ret), kobject_name(&clt_path->kobj),
+			    clt_path->hca_name, clt_path->hca_port);
 		if (req->mp_policy == MP_POLICY_MIN_INFLIGHT)
 			atomic_dec(&clt_path->stats->inflight);
 		if (req->mr->need_inval) {
@@ -1208,8 +1208,8 @@ static int rtrs_clt_read_req(struct rtrs_clt_io_req *req)
 		ret = rtrs_map_sg_fr(req, count);
 		if (ret < 0) {
 			rtrs_err_rl(s,
-				     "Read request failed, failed to map fast reg. data, err: %d\n",
-				     ret);
+				     "Read request failed, failed to map fast reg. data, err: %pe\n",
+				     ERR_PTR(ret));
 			ib_dma_unmap_sg(dev->ib_dev, req->sglist, req->sg_cnt,
 					req->dir);
 			return ret;
@@ -1260,9 +1260,9 @@ static int rtrs_clt_read_req(struct rtrs_clt_io_req *req)
 				   req->data_len, imm, wr);
 	if (ret) {
 		rtrs_err_rl(s,
-			    "Read request failed: error=%d path=%s [%s:%u]\n",
-			    ret, kobject_name(&clt_path->kobj), clt_path->hca_name,
-			    clt_path->hca_port);
+			    "Read request failed: error=%pe path=%s [%s:%u]\n",
+			    ERR_PTR(ret), kobject_name(&clt_path->kobj),
+			    clt_path->hca_name, clt_path->hca_port);
 		if (req->mp_policy == MP_POLICY_MIN_INFLIGHT)
 			atomic_dec(&clt_path->stats->inflight);
 		req->mr->need_inval = false;
@@ -1775,12 +1775,12 @@ static int rtrs_rdma_addr_resolved(struct rtrs_clt_con *con)
 	err = create_con_cq_qp(con);
 	mutex_unlock(&con->con_mutex);
 	if (err) {
-		rtrs_err(s, "create_con_cq_qp(), err: %d\n", err);
+		rtrs_err(s, "create_con_cq_qp(), err: %pe\n", ERR_PTR(err));
 		return err;
 	}
 	err = rdma_resolve_route(con->c.cm_id, RTRS_CONNECT_TIMEOUT_MS);
 	if (err)
-		rtrs_err(s, "Resolving route failed, err: %d\n", err);
+		rtrs_err(s, "Resolving route failed, err: %pe\n", ERR_PTR(err));
 
 	return err;
 }
@@ -1814,7 +1814,7 @@ static int rtrs_rdma_route_resolved(struct rtrs_clt_con *con)
 
 	err = rdma_connect_locked(con->c.cm_id, &param);
 	if (err)
-		rtrs_err(clt, "rdma_connect_locked(): %d\n", err);
+		rtrs_err(clt, "rdma_connect_locked(): %pe\n", ERR_PTR(err));
 
 	return err;
 }
@@ -1847,8 +1847,8 @@ static int rtrs_rdma_conn_established(struct rtrs_clt_con *con,
 	}
 	errno = le16_to_cpu(msg->errno);
 	if (errno) {
-		rtrs_err(clt, "Invalid RTRS message: errno %d\n",
-			  errno);
+		rtrs_err(clt, "Invalid RTRS message: errno %pe\n",
+			 ERR_PTR(errno));
 		return -ECONNRESET;
 	}
 	if (con->c.cid == 0) {
@@ -1937,12 +1937,12 @@ static int rtrs_rdma_conn_rejected(struct rtrs_clt_con *con,
 				  "Previous session is still exists on the server, please reconnect later\n");
 		else
 			rtrs_err(s,
-				  "Connect rejected: status %d (%s), rtrs errno %d\n",
-				  status, rej_msg, errno);
+				  "Connect rejected: status %d (%s), rtrs errno %pe\n",
+				  status, rej_msg, ERR_PTR(errno));
 	} else {
 		rtrs_err(s,
-			  "Connect rejected but with malformed message: status %d (%s)\n",
-			  status, rej_msg);
+			  "Connect rejected but with malformed message: status %pe (%s)\n",
+			  ERR_PTR(status), rej_msg);
 	}
 
 	return -ECONNRESET;
@@ -2009,27 +2009,27 @@ static int rtrs_clt_rdma_cm_handler(struct rdma_cm_id *cm_id,
 	case RDMA_CM_EVENT_UNREACHABLE:
 	case RDMA_CM_EVENT_ADDR_CHANGE:
 	case RDMA_CM_EVENT_TIMEWAIT_EXIT:
-		rtrs_wrn(s, "CM error (CM event: %s, err: %d)\n",
-			 rdma_event_msg(ev->event), ev->status);
+		rtrs_wrn(s, "CM error (CM event: %s, err: %pe)\n",
+			 rdma_event_msg(ev->event), ERR_PTR(ev->status));
 		cm_err = -ECONNRESET;
 		break;
 	case RDMA_CM_EVENT_ADDR_ERROR:
 	case RDMA_CM_EVENT_ROUTE_ERROR:
-		rtrs_wrn(s, "CM error (CM event: %s, err: %d)\n",
-			 rdma_event_msg(ev->event), ev->status);
+		rtrs_wrn(s, "CM error (CM event: %s, err: %pe)\n",
+			 rdma_event_msg(ev->event), ERR_PTR(ev->status));
 		cm_err = -EHOSTUNREACH;
 		break;
 	case RDMA_CM_EVENT_DEVICE_REMOVAL:
 		/*
 		 * Device removal is a special case.  Queue close and return 0.
 		 */
-		rtrs_wrn_rl(s, "CM event: %s, status: %d\n", rdma_event_msg(ev->event),
-			    ev->status);
+		rtrs_wrn_rl(s, "CM event: %s, status: %pe\n", rdma_event_msg(ev->event),
+			    ERR_PTR(ev->status));
 		rtrs_clt_close_conns(clt_path, false);
 		return 0;
 	default:
-		rtrs_err(s, "Unexpected RDMA CM error (CM event: %s, err: %d)\n",
-			 rdma_event_msg(ev->event), ev->status);
+		rtrs_err(s, "Unexpected RDMA CM error (CM event: %s, err: %pe)\n",
+			 rdma_event_msg(ev->event), ERR_PTR(ev->status));
 		cm_err = -ECONNRESET;
 		break;
 	}
@@ -2066,14 +2066,14 @@ static int create_cm(struct rtrs_clt_con *con)
 	/* allow the port to be reused */
 	err = rdma_set_reuseaddr(cm_id, 1);
 	if (err != 0) {
-		rtrs_err(s, "Set address reuse failed, err: %d\n", err);
+		rtrs_err(s, "Set address reuse failed, err: %pe\n", ERR_PTR(err));
 		return err;
 	}
 	err = rdma_resolve_addr(cm_id, (struct sockaddr *)&clt_path->s.src_addr,
 				(struct sockaddr *)&clt_path->s.dst_addr,
 				RTRS_CONNECT_TIMEOUT_MS);
 	if (err) {
-		rtrs_err(s, "Failed to resolve address, err: %d\n", err);
+		rtrs_err(s, "Failed to resolve address, err: %pe\n", ERR_PTR(err));
 		return err;
 	}
 	/*
@@ -2548,7 +2548,7 @@ static int rtrs_send_path_info(struct rtrs_clt_path *clt_path)
 	/* Prepare for getting info response */
 	err = rtrs_iu_post_recv(&usr_con->c, rx_iu);
 	if (err) {
-		rtrs_err(clt_path->clt, "rtrs_iu_post_recv(), err: %d\n", err);
+		rtrs_err(clt_path->clt, "rtrs_iu_post_recv(), err: %pe\n", ERR_PTR(err));
 		goto out;
 	}
 	rx_iu = NULL;
@@ -2564,7 +2564,7 @@ static int rtrs_send_path_info(struct rtrs_clt_path *clt_path)
 	/* Send info request */
 	err = rtrs_iu_post_send(&usr_con->c, tx_iu, sizeof(*msg), NULL);
 	if (err) {
-		rtrs_err(clt_path->clt, "rtrs_iu_post_send(), err: %d\n", err);
+		rtrs_err(clt_path->clt, "rtrs_iu_post_send(), err: %pe\n", ERR_PTR(err));
 		goto out;
 	}
 	tx_iu = NULL;
@@ -2615,15 +2615,15 @@ static int init_path(struct rtrs_clt_path *clt_path)
 	err = init_conns(clt_path);
 	if (err) {
 		rtrs_err(clt_path->clt,
-			 "init_conns() failed: err=%d path=%s [%s:%u]\n", err,
-			 str, clt_path->hca_name, clt_path->hca_port);
+			 "init_conns() failed: err=%pe path=%s [%s:%u]\n",
+			 ERR_PTR(err), str, clt_path->hca_name, clt_path->hca_port);
 		goto out;
 	}
 	err = rtrs_send_path_info(clt_path);
 	if (err) {
 		rtrs_err(clt_path->clt,
-			 "rtrs_send_path_info() failed: err=%d path=%s [%s:%u]\n",
-			 err, str, clt_path->hca_name, clt_path->hca_port);
+			 "rtrs_send_path_info() failed: err=%pe path=%s [%s:%u]\n",
+			 ERR_PTR(err), str, clt_path->hca_name, clt_path->hca_port);
 		goto out;
 	}
 	rtrs_clt_path_up(clt_path);
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
index 3f305e694fe8..51727c7d710c 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
@@ -176,14 +176,14 @@ static int rtrs_srv_create_once_sysfs_root_folders(struct rtrs_srv_path *srv_pat
 	dev_set_uevent_suppress(&srv->dev, true);
 	err = device_add(&srv->dev);
 	if (err) {
-		pr_err("device_add(): %d\n", err);
+		pr_err("device_add(): %pe\n", ERR_PTR(err));
 		put_device(&srv->dev);
 		goto unlock;
 	}
 	srv->kobj_paths = kobject_create_and_add("paths", &srv->dev.kobj);
 	if (!srv->kobj_paths) {
 		err = -ENOMEM;
-		pr_err("kobject_create_and_add(): %d\n", err);
+		pr_err("kobject_create_and_add(): %pe\n", ERR_PTR(err));
 		device_del(&srv->dev);
 		put_device(&srv->dev);
 		goto unlock;
@@ -237,14 +237,14 @@ static int rtrs_srv_create_stats_files(struct rtrs_srv_path *srv_path)
 	err = kobject_init_and_add(&srv_path->stats->kobj_stats, &ktype_stats,
 				   &srv_path->kobj, "stats");
 	if (err) {
-		rtrs_err(s, "kobject_init_and_add(): %d\n", err);
+		rtrs_err(s, "kobject_init_and_add(): %pe\n", ERR_PTR(err));
 		kobject_put(&srv_path->stats->kobj_stats);
 		return err;
 	}
 	err = sysfs_create_group(&srv_path->stats->kobj_stats,
 				 &rtrs_srv_stats_attr_group);
 	if (err) {
-		rtrs_err(s, "sysfs_create_group(): %d\n", err);
+		rtrs_err(s, "sysfs_create_group(): %pe\n", ERR_PTR(err));
 		goto err;
 	}
 
@@ -276,12 +276,12 @@ int rtrs_srv_create_path_files(struct rtrs_srv_path *srv_path)
 	err = kobject_init_and_add(&srv_path->kobj, &ktype, srv->kobj_paths,
 				   "%s", str);
 	if (err) {
-		rtrs_err(s, "kobject_init_and_add(): %d\n", err);
+		rtrs_err(s, "kobject_init_and_add(): %pe\n", ERR_PTR(err));
 		goto destroy_root;
 	}
 	err = sysfs_create_group(&srv_path->kobj, &rtrs_srv_path_attr_group);
 	if (err) {
-		rtrs_err(s, "sysfs_create_group(): %d\n", err);
+		rtrs_err(s, "sysfs_create_group(): %pe\n", ERR_PTR(err));
 		goto put_kobj;
 	}
 	err = rtrs_srv_create_stats_files(srv_path);
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index adb798e2a54a..be44fd1b9944 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -317,8 +317,8 @@ static int rdma_write_sg(struct rtrs_srv_op *id)
 	err = ib_post_send(id->con->c.qp, &id->tx_wr.wr, NULL);
 	if (err)
 		rtrs_err(s,
-			  "Posting RDMA-Write-Request to QP failed, err: %d\n",
-			  err);
+			  "Posting RDMA-Write-Request to QP failed, err: %pe\n",
+			  ERR_PTR(err));
 
 	return err;
 }
@@ -434,8 +434,8 @@ static int send_io_resp_imm(struct rtrs_srv_con *con, struct rtrs_srv_op *id,
 
 	err = ib_post_send(id->con->c.qp, wr, NULL);
 	if (err)
-		rtrs_err_rl(s, "Posting RDMA-Reply to QP failed, err: %d\n",
-			     err);
+		rtrs_err_rl(s, "Posting RDMA-Reply to QP failed, err: %pe\n",
+			    ERR_PTR(err));
 
 	return err;
 }
@@ -519,8 +519,8 @@ bool rtrs_srv_resp_rdma(struct rtrs_srv_op *id, int status)
 		err = rdma_write_sg(id);
 
 	if (err) {
-		rtrs_err_rl(s, "IO response failed: %d: srv_path=%s\n", err,
-			    kobject_name(&srv_path->kobj));
+		rtrs_err_rl(s, "IO response failed: %pe: srv_path=%s\n",
+			    ERR_PTR(err), kobject_name(&srv_path->kobj));
 		close_path(srv_path);
 	}
 out:
@@ -637,7 +637,7 @@ static int map_cont_bufs(struct rtrs_srv_path *srv_path)
 					DMA_TO_DEVICE, rtrs_srv_rdma_done);
 			if (!srv_mr->iu) {
 				err = -ENOMEM;
-				rtrs_err(ss, "rtrs_iu_alloc(), err: %d\n", err);
+				rtrs_err(ss, "rtrs_iu_alloc(), err: %pe\n", ERR_PTR(err));
 				goto dereg_mr;
 			}
 		}
@@ -813,7 +813,7 @@ static int process_info_req(struct rtrs_srv_con *con,
 
 	err = post_recv_path(srv_path);
 	if (err) {
-		rtrs_err(s, "post_recv_path(), err: %d\n", err);
+		rtrs_err(s, "post_recv_path(), err: %pe\n", ERR_PTR(err));
 		return err;
 	}
 
@@ -876,7 +876,7 @@ static int process_info_req(struct rtrs_srv_con *con,
 	get_device(&srv_path->srv->dev);
 	err = rtrs_srv_change_state(srv_path, RTRS_SRV_CONNECTED);
 	if (!err) {
-		rtrs_err(s, "rtrs_srv_change_state(), err: %d\n", err);
+		rtrs_err(s, "rtrs_srv_change_state(), err: %pe\n", ERR_PTR(err));
 		goto iu_free;
 	}
 
@@ -890,7 +890,7 @@ static int process_info_req(struct rtrs_srv_con *con,
 	 */
 	err = rtrs_srv_path_up(srv_path);
 	if (err) {
-		rtrs_err(s, "rtrs_srv_path_up(), err: %d\n", err);
+		rtrs_err(s, "rtrs_srv_path_up(), err: %pe\n", ERR_PTR(err));
 		goto iu_free;
 	}
 
@@ -901,7 +901,7 @@ static int process_info_req(struct rtrs_srv_con *con,
 	/* Send info response */
 	err = rtrs_iu_post_send(&con->c, tx_iu, tx_sz, reg_wr);
 	if (err) {
-		rtrs_err(s, "rtrs_iu_post_send(), err: %d\n", err);
+		rtrs_err(s, "rtrs_iu_post_send(), err: %pe\n", ERR_PTR(err));
 iu_free:
 		rtrs_iu_free(tx_iu, srv_path->s.dev->ib_dev, 1);
 	}
@@ -969,7 +969,7 @@ static int post_recv_info_req(struct rtrs_srv_con *con)
 	/* Prepare for getting info response */
 	err = rtrs_iu_post_recv(&con->c, rx_iu);
 	if (err) {
-		rtrs_err(s, "rtrs_iu_post_recv(), err: %d\n", err);
+		rtrs_err(s, "rtrs_iu_post_recv(), err: %pe\n", ERR_PTR(err));
 		rtrs_iu_free(rx_iu, srv_path->s.dev->ib_dev, 1);
 		return err;
 	}
@@ -1015,7 +1015,7 @@ static int post_recv_path(struct rtrs_srv_path *srv_path)
 
 		err = post_recv_io(to_srv_con(srv_path->s.con[cid]), q_size);
 		if (err) {
-			rtrs_err(s, "post_recv_io(), err: %d\n", err);
+			rtrs_err(s, "post_recv_io(), err: %pe\n", ERR_PTR(err));
 			return err;
 		}
 	}
@@ -1063,8 +1063,8 @@ static void process_read(struct rtrs_srv_con *con,
 
 	if (ret) {
 		rtrs_err_rl(s,
-			     "Processing read request failed, user module cb reported for msg_id %d, err: %d\n",
-			     buf_id, ret);
+			     "Processing read request failed, user module cb reported for msg_id %d, err: %pe\n",
+			     buf_id, ERR_PTR(ret));
 		goto send_err_msg;
 	}
 
@@ -1074,8 +1074,8 @@ static void process_read(struct rtrs_srv_con *con,
 	ret = send_io_resp_imm(con, id, ret);
 	if (ret < 0) {
 		rtrs_err_rl(s,
-			     "Sending err msg for failed RDMA-Write-Req failed, msg_id %d, err: %d\n",
-			     buf_id, ret);
+			     "Sending err msg for failed RDMA-Write-Req failed, msg_id %d, err: %pe\n",
+			     buf_id, ERR_PTR(ret));
 		close_path(srv_path);
 	}
 	rtrs_srv_put_ops_ids(srv_path);
@@ -1115,8 +1115,8 @@ static void process_write(struct rtrs_srv_con *con,
 			       data + data_len, usr_len);
 	if (ret) {
 		rtrs_err_rl(s,
-			     "Processing write request failed, user module callback reports err: %d\n",
-			     ret);
+			     "Processing write request failed, user module callback reports err: %pe\n",
+			     ERR_PTR(ret));
 		goto send_err_msg;
 	}
 
@@ -1126,8 +1126,8 @@ static void process_write(struct rtrs_srv_con *con,
 	ret = send_io_resp_imm(con, id, ret);
 	if (ret < 0) {
 		rtrs_err_rl(s,
-			     "Processing write request failed, sending I/O response failed, msg_id %d, err: %d\n",
-			     buf_id, ret);
+			     "Processing write request failed, sending I/O response failed, msg_id %d, err: %pe\n",
+			     buf_id, ERR_PTR(ret));
 		close_path(srv_path);
 	}
 	rtrs_srv_put_ops_ids(srv_path);
@@ -1257,7 +1257,8 @@ static void rtrs_srv_rdma_done(struct ib_cq *cq, struct ib_wc *wc)
 		srv_path->s.hb_missed_cnt = 0;
 		err = rtrs_post_recv_empty(&con->c, &io_comp_cqe);
 		if (err) {
-			rtrs_err(s, "rtrs_post_recv(), err: %d\n", err);
+			rtrs_err(s, "rtrs_post_recv(), err: %pe\n",
+				 ERR_PTR(err));
 			close_path(srv_path);
 			break;
 		}
@@ -1282,8 +1283,8 @@ static void rtrs_srv_rdma_done(struct ib_cq *cq, struct ib_wc *wc)
 				mr->msg_id = msg_id;
 				err = rtrs_srv_inv_rkey(con, mr);
 				if (err) {
-					rtrs_err(s, "rtrs_post_recv(), err: %d\n",
-						  err);
+					rtrs_err(s, "rtrs_post_recv(), err: %pe\n",
+						 ERR_PTR(err));
 					close_path(srv_path);
 					break;
 				}
@@ -1632,7 +1633,7 @@ static int rtrs_rdma_do_accept(struct rtrs_srv_path *srv_path,
 
 	err = rdma_accept(cm_id, &param);
 	if (err)
-		pr_err("rdma_accept(), err: %d\n", err);
+		pr_err("rdma_accept(), err: %pe\n", ERR_PTR(err));
 
 	return err;
 }
@@ -1650,7 +1651,7 @@ static int rtrs_rdma_do_reject(struct rdma_cm_id *cm_id, int errno)
 
 	err = rdma_reject(cm_id, &msg, sizeof(msg), IB_CM_REJ_CONSUMER_DEFINED);
 	if (err)
-		pr_err("rdma_reject(), err: %d\n", err);
+		pr_err("rdma_reject(), err: %pe\n", ERR_PTR(err));
 
 	/* Bounce errno back */
 	return errno;
@@ -1726,7 +1727,7 @@ static int create_con(struct rtrs_srv_path *srv_path,
 				 max_send_wr, max_recv_wr,
 				 IB_POLL_WORKQUEUE);
 	if (err) {
-		rtrs_err(s, "rtrs_cq_qp_create(), err: %d\n", err);
+		rtrs_err(s, "rtrs_cq_qp_create(), err: %pe\n", ERR_PTR(err));
 		goto free_con;
 	}
 	if (con->c.cid == 0) {
@@ -1941,7 +1942,7 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
 	}
 	err = create_con(srv_path, cm_id, cid);
 	if (err) {
-		rtrs_err((&srv_path->s), "create_con(), error %d\n", err);
+		rtrs_err((&srv_path->s), "create_con(), error %pe\n", ERR_PTR(err));
 		rtrs_rdma_do_reject(cm_id, err);
 		/*
 		 * Since session has other connections we follow normal way
@@ -1952,7 +1953,8 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
 	}
 	err = rtrs_rdma_do_accept(srv_path, cm_id);
 	if (err) {
-		rtrs_err((&srv_path->s), "rtrs_rdma_do_accept(), error %d\n", err);
+		rtrs_err((&srv_path->s), "rtrs_rdma_do_accept(), error %pe\n",
+			 ERR_PTR(err));
 		rtrs_rdma_do_reject(cm_id, err);
 		/*
 		 * Since current connection was successfully added to the
@@ -2003,8 +2005,8 @@ static int rtrs_srv_rdma_cm_handler(struct rdma_cm_id *cm_id,
 	case RDMA_CM_EVENT_REJECTED:
 	case RDMA_CM_EVENT_CONNECT_ERROR:
 	case RDMA_CM_EVENT_UNREACHABLE:
-		rtrs_err(s, "CM error (CM event: %s, err: %d)\n",
-			  rdma_event_msg(ev->event), ev->status);
+		rtrs_err(s, "CM error (CM event: %s, err: %pe)\n",
+			  rdma_event_msg(ev->event), ERR_PTR(ev->status));
 		fallthrough;
 	case RDMA_CM_EVENT_DISCONNECTED:
 	case RDMA_CM_EVENT_ADDR_CHANGE:
@@ -2013,8 +2015,8 @@ static int rtrs_srv_rdma_cm_handler(struct rdma_cm_id *cm_id,
 		close_path(srv_path);
 		break;
 	default:
-		pr_err("Ignoring unexpected CM event %s, err %d\n",
-		       rdma_event_msg(ev->event), ev->status);
+		pr_err("Ignoring unexpected CM event %s, err %pe\n",
+		       rdma_event_msg(ev->event), ERR_PTR(ev->status));
 		break;
 	}
 
@@ -2038,13 +2040,13 @@ static struct rdma_cm_id *rtrs_srv_cm_init(struct rtrs_srv_ctx *ctx,
 	}
 	ret = rdma_bind_addr(cm_id, addr);
 	if (ret) {
-		pr_err("Binding RDMA address failed, err: %d\n", ret);
+		pr_err("Binding RDMA address failed, err: %pe\n", ERR_PTR(ret));
 		goto err_cm;
 	}
 	ret = rdma_listen(cm_id, 64);
 	if (ret) {
-		pr_err("Listening on RDMA connection failed, err: %d\n",
-		       ret);
+		pr_err("Listening on RDMA connection failed, err: %pe\n",
+		       ERR_PTR(ret));
 		goto err_cm;
 	}
 
@@ -2322,8 +2324,8 @@ static int __init rtrs_server_init(void)
 
 	err = check_module_params();
 	if (err) {
-		pr_err("Failed to load module, invalid module parameters, err: %d\n",
-		       err);
+		pr_err("Failed to load module, invalid module parameters, err: %pe\n",
+		       ERR_PTR(err));
 		return err;
 	}
 	err = class_register(&rtrs_dev_class);
diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
index bf38ac6f87c4..bc1208ae8216 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs.c
@@ -273,7 +273,8 @@ static int create_qp(struct rtrs_con *con, struct ib_pd *pd,
 
 	ret = rdma_create_qp(cm_id, pd, &init_attr);
 	if (ret) {
-		rtrs_err(con->path, "Creating QP failed, err: %d\n", ret);
+		rtrs_err(con->path, "Creating QP failed, err: %pe\n",
+			 ERR_PTR(ret));
 		return ret;
 	}
 	con->qp = cm_id->qp;
@@ -341,7 +342,8 @@ void rtrs_send_hb_ack(struct rtrs_path *path)
 	err = rtrs_post_rdma_write_imm_empty(usr_con, path->hb_cqe, imm,
 					     NULL);
 	if (err) {
-		rtrs_err(path, "send HB ACK failed, errno: %d\n", err);
+		rtrs_err(path, "send HB ACK failed, errno: %pe\n",
+			 ERR_PTR(err));
 		path->hb_err_handler(usr_con);
 		return;
 	}
@@ -375,7 +377,8 @@ static void hb_work(struct work_struct *work)
 	err = rtrs_post_rdma_write_imm_empty(usr_con, path->hb_cqe, imm,
 					     NULL);
 	if (err) {
-		rtrs_err(path, "HB send failed, errno: %d\n", err);
+		rtrs_err(path, "HB send failed, errno: %pe\n",
+			 ERR_PTR(err));
 		path->hb_err_handler(usr_con);
 		return;
 	}
-- 
2.43.0


