Return-Path: <linux-rdma+bounces-14924-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44753CADB6D
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Dec 2025 17:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8CACE304B21D
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Dec 2025 16:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F90D2E0406;
	Mon,  8 Dec 2025 16:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="OODzEa3Y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE242DC77A
	for <linux-rdma@vger.kernel.org>; Mon,  8 Dec 2025 16:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765210523; cv=none; b=qAjXsnvpsKelVWkF4t14aOZEnK0a7lUotvSEn7opUzYepzAlHz82hnTXKBmLP+MouAX99HAs9PHD/hueS2ET//35f+PZwuInMzF6awIoXfkVT5/gftPkHW9uLJoW0tIYNmQYZDiWGQMXhIEfA23aQtvSOvMjhL9OqUJFYxgocfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765210523; c=relaxed/simple;
	bh=jk5JOy32BwQwsWKK8YwX9jvexyFV+0BO1T2p0KofjWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m8hyCz4+KAxO6jFiYJIK0luYMJzfi4iB7koQtB5DHFw8OcpEa9fp9WbWSDdDIAOb9WhXi2wAkulS4m9rNg4ARdlVHCCEpwyHBzq0wFuPhAfFqKzRtO3g61q9+UZQcXiTBO2W2waT8m1auHeLf8MJMJLVgI0Xm+EDaLSqi0othDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=OODzEa3Y; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4779ce2a624so59536305e9.2
        for <linux-rdma@vger.kernel.org>; Mon, 08 Dec 2025 08:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1765210519; x=1765815319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yHpnMS12TJkvTOGw2F9ukx6xRAZJp3ErdgUScw3Pf2A=;
        b=OODzEa3Yw4Er2FLsNS35FIq/kOQhm3BIal7zjCt0fsN6+3dkjAZPcieh0MZeYsvSoG
         b0OPHkrm4t0MZSRGq4rDh4SbHtFCLsQTqoaOLv99lmtFOd6bJqDbbl4z7poyAAkdKNyy
         zWm1uBDTXElnOCVXwsXrD85Qb8K1YHoaA9QgJaKhc5NZq53RdzlJh0DWAYUNv2MKQQqM
         qDUfkiNhQCs5+Ety9aH3xmgDWl/Vhcx5XRkmoAJ4OGLwFbvLfKSulWfcFebqxpR7dRYF
         pmUWscMPRY5YZPOvA3sR69xNQYBxvUjS0GDz8nB/DpmXOgsuW17RRKvhWxRmfJxcSYkt
         tUUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765210519; x=1765815319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yHpnMS12TJkvTOGw2F9ukx6xRAZJp3ErdgUScw3Pf2A=;
        b=IgQkevEm57YXyHvPhPj1jDpb7+Jf6eC4jAUsHB2dCil5f0IInBKP1cMFofbMmdUNVg
         Q6zAETcsy02QAbehoxmmB4mkjW2+TE0e2rOW9FdEc82AG36Q7xbgJXYQxNd/vIP8G2bu
         qIC8THMuV7XVSnraEPczYFZ9f0L0NCHnpM8/zRT1LvjJWuLnjHPp5yC0WdkGIfMzRPuo
         2+BXOTJKFj50zFt1nwMh0Nu/dyjQzFexXz0yIYE8RnfwfLOWh2GXTrgvlYyOaKVPoF7n
         E6gAOgYJOraGZXQ5oP0dKME89dCG11WYZ5s6J4LLbgejN0D6CPEJFFcIGHfpTHtSF/Q/
         nw4g==
X-Gm-Message-State: AOJu0YxSZL8Yedur/c/CbhDgpmV3m+CAlFBPXKaDFHy3gTbvPEXgljEy
	y97aujz2WJNLgCAzdIGNse9Xk1Z9x+qWUcEyXVyDzKBNxpahuz1CnhgeCT7v0Z8Io/LrHSjDe2G
	desmn
X-Gm-Gg: ASbGncvAC4CJWPYFB2RC1IZchrM8IxF1Cb2URtIWzKQZpRyf2VAPqr1mCpISGhE6chI
	syhR2Dey9vFxhoZVLZyWM2cFTJffBZFBwliaApgel6pzgtM/3SG/Z2gY62hrwl6xBOmIfafg8xo
	25UmF2ONTjDWQ96xVYGHX618vsSD2W35J1pMRoBibGkGbx95gs/AOfN4aLkBjbWbZHmbXzAXJkc
	etHvJiURtIM/+ssocVwDlY8SouRlHzmi0TxnPGNdcQNWeTjjEGxCAMZ9/YBGvLlqjIppS1Mes1N
	XxsYzSQZu8WTT5oLia1x1557TQkRn8zevQDEDUL7k80OOc2BSJHOQm6e3kM7oBM0PrUvMcb7V+k
	R58XNKHoSyPhqZKJnB7hYDcl9NtLWYZ6/0nVd996DyJWQ2qzvEPMh7PuLn4W3Wrr7Q/Vd0+JtaZ
	HVT30sYPFXw7/CEtZB8h3opSgbPg7VhyjgsIk4uM8aoskXBIf0yIOuU6UXvV9XOcZQkvEG+uTzm
	UDHyHeaZox39Pw0VMdEbRpc
X-Google-Smtp-Source: AGHT+IH3kLjnU9Y4xh05RPsurUDLJQuu6LHXXVm1htkvmj6llxo2qHXJ+K+iw3YWN9obCXIo4NuMTQ==
X-Received: by 2002:a05:600c:19cf:b0:477:79c7:8994 with SMTP id 5b1f17b1804b1-47939e3e208mr98847795e9.30.1765210518490;
        Mon, 08 Dec 2025 08:15:18 -0800 (PST)
Received: from lb03189.fkb.profitbricks.net (p200300f00f28af1ae57f1d6cbb50b9bc.dip0.t-ipconnect.de. [2003:f0:f28:af1a:e57f:1d6c:bb50:b9bc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479311ed466sm245275655e9.13.2025.12.08.08.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 08:15:18 -0800 (PST)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-rdma@vger.kernel.org
Cc: bvanassche@acm.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com,
	grzegorz.prajsner@ionos.com,
	Kim Zhu <zhu.yanjun@ionos.com>
Subject: [PATCH 2/9] RDMA/rtrs: Add error description to the logs
Date: Mon,  8 Dec 2025 17:15:06 +0100
Message-ID: <20251208161513.127049-3-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251208161513.127049-1-haris.iqbal@ionos.com>
References: <20251208161513.127049-1-haris.iqbal@ionos.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kim Zhu <zhu.yanjun@ionos.com>

Print error description besides the error number.

Signed-off-by: Kim Zhu <zhu.yanjun@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c |  8 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt.c       | 89 ++++++++++----------
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c | 12 +--
 drivers/infiniband/ulp/rtrs/rtrs-srv.c       | 78 ++++++++---------
 drivers/infiniband/ulp/rtrs/rtrs.c           |  9 +-
 5 files changed, 101 insertions(+), 95 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
index 4aa80c9388f0..b318acc12b10 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
@@ -439,19 +439,19 @@ int rtrs_clt_create_path_files(struct rtrs_clt_path *clt_path)
 				   clt->kobj_paths,
 				   "%s", str);
 	if (err) {
-		pr_err("kobject_init_and_add: %d\n", err);
+		pr_err("kobject_init_and_add: %d(%pe)\n", err, ERR_PTR(err));
 		kobject_put(&clt_path->kobj);
 		return err;
 	}
 	err = sysfs_create_group(&clt_path->kobj, &rtrs_clt_path_attr_group);
 	if (err) {
-		pr_err("sysfs_create_group(): %d\n", err);
+		pr_err("sysfs_create_group(): %d(%pe)\n", err, ERR_PTR(err));
 		goto put_kobj;
 	}
 	err = kobject_init_and_add(&clt_path->stats->kobj_stats, &ktype_stats,
 				   &clt_path->kobj, "stats");
 	if (err) {
-		pr_err("kobject_init_and_add: %d\n", err);
+		pr_err("kobject_init_and_add: %d(%pe)\n", err, ERR_PTR(err));
 		kobject_put(&clt_path->stats->kobj_stats);
 		goto remove_group;
 	}
@@ -459,7 +459,7 @@ int rtrs_clt_create_path_files(struct rtrs_clt_path *clt_path)
 	err = sysfs_create_group(&clt_path->stats->kobj_stats,
 				 &rtrs_clt_stats_attr_group);
 	if (err) {
-		pr_err("failed to create stats sysfs group, err: %d\n", err);
+		pr_err("failed to create stats sysfs group, err: %d(%pe)\n", err, ERR_PTR(err));
 		goto put_kobj_stats;
 	}
 
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 71387811b281..808de144d2e4 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -422,8 +422,8 @@ static void complete_rdma_req(struct rtrs_clt_io_req *req, int errno,
 			refcount_inc(&req->ref);
 			err = rtrs_inv_rkey(req);
 			if (err) {
-				rtrs_err_rl(con->c.path, "Send INV WR key=%#x: %d\n",
-					  req->mr->rkey, err);
+				rtrs_err_rl(con->c.path, "Send INV WR key=%#x: %d(%pe)\n",
+					    req->mr->rkey, err, ERR_PTR(err));
 			} else if (can_wait) {
 				wait_for_completion(&req->inv_comp);
 			}
@@ -443,8 +443,8 @@ static void complete_rdma_req(struct rtrs_clt_io_req *req, int errno,
 
 	if (errno) {
 		rtrs_err_rl(con->c.path,
-			    "IO %s request failed: error=%d path=%s [%s:%u] notify=%d\n",
-			    req->dir == DMA_TO_DEVICE ? "write" : "read", errno,
+			    "IO %s request failed: error=%d(%pe) path=%s [%s:%u] notify=%d\n",
+			    req->dir == DMA_TO_DEVICE ? "write" : "read", errno, ERR_PTR(errno),
 			    kobject_name(&clt_path->kobj), clt_path->hca_name,
 			    clt_path->hca_port, notify);
 	}
@@ -514,7 +514,8 @@ static void rtrs_clt_recv_done(struct rtrs_clt_con *con, struct ib_wc *wc)
 			  cqe);
 	err = rtrs_iu_post_recv(&con->c, iu);
 	if (err) {
-		rtrs_err(con->c.path, "post iu failed %d\n", err);
+		rtrs_err(con->c.path, "post iu failed %d(%pe)\n", err,
+			 ERR_PTR(err));
 		rtrs_rdma_error_recovery(con);
 	}
 }
@@ -659,8 +660,8 @@ static void rtrs_clt_rdma_done(struct ib_cq *cq, struct ib_wc *wc)
 		else
 			err = rtrs_post_recv_empty(&con->c, &io_comp_cqe);
 		if (err) {
-			rtrs_err(con->c.path, "rtrs_post_recv_empty(): %d\n",
-				  err);
+			rtrs_err(con->c.path, "rtrs_post_recv_empty(): %d(%pe)\n",
+				 err, ERR_PTR(err));
 			rtrs_rdma_error_recovery(con);
 		}
 		break;
@@ -731,8 +732,8 @@ static int post_recv_path(struct rtrs_clt_path *clt_path)
 
 		err = post_recv_io(to_clt_con(clt_path->s.con[cid]), q_size);
 		if (err) {
-			rtrs_err(clt_path->clt, "post_recv_io(), err: %d\n",
-				 err);
+			rtrs_err(clt_path->clt, "post_recv_io(), err: %d(%pe)\n",
+				 err, ERR_PTR(err));
 			return err;
 		}
 	}
@@ -1122,8 +1123,8 @@ static int rtrs_clt_write_req(struct rtrs_clt_io_req *req)
 		ret = rtrs_map_sg_fr(req, count);
 		if (ret < 0) {
 			rtrs_err_rl(s,
-				    "Write request failed, failed to map fast reg. data, err: %d\n",
-				    ret);
+				    "Write request failed, failed to map fast reg. data, err: %d(%pe)\n",
+				    ret, ERR_PTR(ret));
 			ib_dma_unmap_sg(clt_path->s.dev->ib_dev, req->sglist,
 					req->sg_cnt, req->dir);
 			return ret;
@@ -1150,9 +1151,9 @@ static int rtrs_clt_write_req(struct rtrs_clt_io_req *req)
 				      imm, wr, NULL);
 	if (ret) {
 		rtrs_err_rl(s,
-			    "Write request failed: error=%d path=%s [%s:%u]\n",
-			    ret, kobject_name(&clt_path->kobj), clt_path->hca_name,
-			    clt_path->hca_port);
+			    "Write request failed: error=%d(%pe) path=%s [%s:%u]\n",
+			    ret, ERR_PTR(ret), kobject_name(&clt_path->kobj),
+			    clt_path->hca_name, clt_path->hca_port);
 		if (req->mp_policy == MP_POLICY_MIN_INFLIGHT)
 			atomic_dec(&clt_path->stats->inflight);
 		if (req->mr->need_inval) {
@@ -1208,8 +1209,8 @@ static int rtrs_clt_read_req(struct rtrs_clt_io_req *req)
 		ret = rtrs_map_sg_fr(req, count);
 		if (ret < 0) {
 			rtrs_err_rl(s,
-				     "Read request failed, failed to map fast reg. data, err: %d\n",
-				     ret);
+				     "Read request failed, failed to map fast reg. data, err: %d(%pe)\n",
+				     ret, ERR_PTR(ret));
 			ib_dma_unmap_sg(dev->ib_dev, req->sglist, req->sg_cnt,
 					req->dir);
 			return ret;
@@ -1260,9 +1261,9 @@ static int rtrs_clt_read_req(struct rtrs_clt_io_req *req)
 				   req->data_len, imm, wr);
 	if (ret) {
 		rtrs_err_rl(s,
-			    "Read request failed: error=%d path=%s [%s:%u]\n",
-			    ret, kobject_name(&clt_path->kobj), clt_path->hca_name,
-			    clt_path->hca_port);
+			    "Read request failed: error=%d(%pe) path=%s [%s:%u]\n",
+			    ret, ERR_PTR(ret), kobject_name(&clt_path->kobj),
+			    clt_path->hca_name, clt_path->hca_port);
 		if (req->mp_policy == MP_POLICY_MIN_INFLIGHT)
 			atomic_dec(&clt_path->stats->inflight);
 		req->mr->need_inval = false;
@@ -1774,12 +1775,12 @@ static int rtrs_rdma_addr_resolved(struct rtrs_clt_con *con)
 	err = create_con_cq_qp(con);
 	mutex_unlock(&con->con_mutex);
 	if (err) {
-		rtrs_err(s, "create_con_cq_qp(), err: %d\n", err);
+		rtrs_err(s, "create_con_cq_qp(), err: %d(%pe)\n", err, ERR_PTR(err));
 		return err;
 	}
 	err = rdma_resolve_route(con->c.cm_id, RTRS_CONNECT_TIMEOUT_MS);
 	if (err)
-		rtrs_err(s, "Resolving route failed, err: %d\n", err);
+		rtrs_err(s, "Resolving route failed, err: %d(%pe)\n", err, ERR_PTR(err));
 
 	return err;
 }
@@ -1813,7 +1814,7 @@ static int rtrs_rdma_route_resolved(struct rtrs_clt_con *con)
 
 	err = rdma_connect_locked(con->c.cm_id, &param);
 	if (err)
-		rtrs_err(clt, "rdma_connect_locked(): %d\n", err);
+		rtrs_err(clt, "rdma_connect_locked(): %d(%pe)\n", err, ERR_PTR(err));
 
 	return err;
 }
@@ -1846,8 +1847,8 @@ static int rtrs_rdma_conn_established(struct rtrs_clt_con *con,
 	}
 	errno = le16_to_cpu(msg->errno);
 	if (errno) {
-		rtrs_err(clt, "Invalid RTRS message: errno %d\n",
-			  errno);
+		rtrs_err(clt, "Invalid RTRS message: errno %d(%pe)\n",
+			  errno, ERR_PTR(errno));
 		return -ECONNRESET;
 	}
 	if (con->c.cid == 0) {
@@ -1936,12 +1937,12 @@ static int rtrs_rdma_conn_rejected(struct rtrs_clt_con *con,
 				  "Previous session is still exists on the server, please reconnect later\n");
 		else
 			rtrs_err(s,
-				  "Connect rejected: status %d (%s), rtrs errno %d\n",
-				  status, rej_msg, errno);
+				  "Connect rejected: status %d (%s), rtrs errno %d(%pe)\n",
+				  status, rej_msg, errno, ERR_PTR(errno));
 	} else {
 		rtrs_err(s,
-			  "Connect rejected but with malformed message: status %d (%s)\n",
-			  status, rej_msg);
+			  "Connect rejected but with malformed message: status %d(%pe) (%s)\n",
+			  status, ERR_PTR(status), rej_msg);
 	}
 
 	return -ECONNRESET;
@@ -2008,27 +2009,27 @@ static int rtrs_clt_rdma_cm_handler(struct rdma_cm_id *cm_id,
 	case RDMA_CM_EVENT_UNREACHABLE:
 	case RDMA_CM_EVENT_ADDR_CHANGE:
 	case RDMA_CM_EVENT_TIMEWAIT_EXIT:
-		rtrs_wrn(s, "CM error (CM event: %s, err: %d)\n",
-			 rdma_event_msg(ev->event), ev->status);
+		rtrs_wrn(s, "CM error (CM event: %s, err: %d(%pe))\n",
+			 rdma_event_msg(ev->event), ev->status, ERR_PTR(ev->status));
 		cm_err = -ECONNRESET;
 		break;
 	case RDMA_CM_EVENT_ADDR_ERROR:
 	case RDMA_CM_EVENT_ROUTE_ERROR:
-		rtrs_wrn(s, "CM error (CM event: %s, err: %d)\n",
-			 rdma_event_msg(ev->event), ev->status);
+		rtrs_wrn(s, "CM error (CM event: %s, err: %d(%pe))\n",
+			 rdma_event_msg(ev->event), ev->status, ERR_PTR(ev->status));
 		cm_err = -EHOSTUNREACH;
 		break;
 	case RDMA_CM_EVENT_DEVICE_REMOVAL:
 		/*
 		 * Device removal is a special case.  Queue close and return 0.
 		 */
-		rtrs_wrn_rl(s, "CM event: %s, status: %d\n", rdma_event_msg(ev->event),
-			    ev->status);
+		rtrs_wrn_rl(s, "CM event: %s, status: %d(%pe)\n", rdma_event_msg(ev->event),
+			    ev->status, ERR_PTR(ev->status));
 		rtrs_clt_close_conns(clt_path, false);
 		return 0;
 	default:
-		rtrs_err(s, "Unexpected RDMA CM error (CM event: %s, err: %d)\n",
-			 rdma_event_msg(ev->event), ev->status);
+		rtrs_err(s, "Unexpected RDMA CM error (CM event: %s, err: %d(%pe))\n",
+			 rdma_event_msg(ev->event), ev->status, ERR_PTR(ev->status));
 		cm_err = -ECONNRESET;
 		break;
 	}
@@ -2065,14 +2066,14 @@ static int create_cm(struct rtrs_clt_con *con)
 	/* allow the port to be reused */
 	err = rdma_set_reuseaddr(cm_id, 1);
 	if (err != 0) {
-		rtrs_err(s, "Set address reuse failed, err: %d\n", err);
+		rtrs_err(s, "Set address reuse failed, err: %d(%pe)\n", err, ERR_PTR(err));
 		return err;
 	}
 	err = rdma_resolve_addr(cm_id, (struct sockaddr *)&clt_path->s.src_addr,
 				(struct sockaddr *)&clt_path->s.dst_addr,
 				RTRS_CONNECT_TIMEOUT_MS);
 	if (err) {
-		rtrs_err(s, "Failed to resolve address, err: %d\n", err);
+		rtrs_err(s, "Failed to resolve address, err: %d(%pe)\n", err, ERR_PTR(err));
 		return err;
 	}
 	/*
@@ -2547,7 +2548,7 @@ static int rtrs_send_path_info(struct rtrs_clt_path *clt_path)
 	/* Prepare for getting info response */
 	err = rtrs_iu_post_recv(&usr_con->c, rx_iu);
 	if (err) {
-		rtrs_err(clt_path->clt, "rtrs_iu_post_recv(), err: %d\n", err);
+		rtrs_err(clt_path->clt, "rtrs_iu_post_recv(), err: %d(%pe)\n", err, ERR_PTR(err));
 		goto out;
 	}
 	rx_iu = NULL;
@@ -2563,7 +2564,7 @@ static int rtrs_send_path_info(struct rtrs_clt_path *clt_path)
 	/* Send info request */
 	err = rtrs_iu_post_send(&usr_con->c, tx_iu, sizeof(*msg), NULL);
 	if (err) {
-		rtrs_err(clt_path->clt, "rtrs_iu_post_send(), err: %d\n", err);
+		rtrs_err(clt_path->clt, "rtrs_iu_post_send(), err: %d(%pe)\n", err, ERR_PTR(err));
 		goto out;
 	}
 	tx_iu = NULL;
@@ -2614,15 +2615,15 @@ static int init_path(struct rtrs_clt_path *clt_path)
 	err = init_conns(clt_path);
 	if (err) {
 		rtrs_err(clt_path->clt,
-			 "init_conns() failed: err=%d path=%s [%s:%u]\n", err,
-			 str, clt_path->hca_name, clt_path->hca_port);
+			 "init_conns() failed: err=%d(%pe) path=%s [%s:%u]\n", err,
+			 ERR_PTR(err), str, clt_path->hca_name, clt_path->hca_port);
 		goto out;
 	}
 	err = rtrs_send_path_info(clt_path);
 	if (err) {
 		rtrs_err(clt_path->clt,
-			 "rtrs_send_path_info() failed: err=%d path=%s [%s:%u]\n",
-			 err, str, clt_path->hca_name, clt_path->hca_port);
+			 "rtrs_send_path_info() failed: err=%d(%pe) path=%s [%s:%u]\n",
+			 err, ERR_PTR(err), str, clt_path->hca_name, clt_path->hca_port);
 		goto out;
 	}
 	rtrs_clt_path_up(clt_path);
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
index 3f305e694fe8..5e12701a3733 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
@@ -176,14 +176,14 @@ static int rtrs_srv_create_once_sysfs_root_folders(struct rtrs_srv_path *srv_pat
 	dev_set_uevent_suppress(&srv->dev, true);
 	err = device_add(&srv->dev);
 	if (err) {
-		pr_err("device_add(): %d\n", err);
+		pr_err("device_add(): %d(%pe)\n", err, ERR_PTR(err));
 		put_device(&srv->dev);
 		goto unlock;
 	}
 	srv->kobj_paths = kobject_create_and_add("paths", &srv->dev.kobj);
 	if (!srv->kobj_paths) {
 		err = -ENOMEM;
-		pr_err("kobject_create_and_add(): %d\n", err);
+		pr_err("kobject_create_and_add(): %d(%pe)\n", err, ERR_PTR(err));
 		device_del(&srv->dev);
 		put_device(&srv->dev);
 		goto unlock;
@@ -237,14 +237,14 @@ static int rtrs_srv_create_stats_files(struct rtrs_srv_path *srv_path)
 	err = kobject_init_and_add(&srv_path->stats->kobj_stats, &ktype_stats,
 				   &srv_path->kobj, "stats");
 	if (err) {
-		rtrs_err(s, "kobject_init_and_add(): %d\n", err);
+		rtrs_err(s, "kobject_init_and_add(): %d(%pe)\n", err, ERR_PTR(err));
 		kobject_put(&srv_path->stats->kobj_stats);
 		return err;
 	}
 	err = sysfs_create_group(&srv_path->stats->kobj_stats,
 				 &rtrs_srv_stats_attr_group);
 	if (err) {
-		rtrs_err(s, "sysfs_create_group(): %d\n", err);
+		rtrs_err(s, "sysfs_create_group(): %d(%pe)\n", err, ERR_PTR(err));
 		goto err;
 	}
 
@@ -276,12 +276,12 @@ int rtrs_srv_create_path_files(struct rtrs_srv_path *srv_path)
 	err = kobject_init_and_add(&srv_path->kobj, &ktype, srv->kobj_paths,
 				   "%s", str);
 	if (err) {
-		rtrs_err(s, "kobject_init_and_add(): %d\n", err);
+		rtrs_err(s, "kobject_init_and_add(): %d(%pe)\n", err, ERR_PTR(err));
 		goto destroy_root;
 	}
 	err = sysfs_create_group(&srv_path->kobj, &rtrs_srv_path_attr_group);
 	if (err) {
-		rtrs_err(s, "sysfs_create_group(): %d\n", err);
+		rtrs_err(s, "sysfs_create_group(): %d(%pe)\n", err, ERR_PTR(err));
 		goto put_kobj;
 	}
 	err = rtrs_srv_create_stats_files(srv_path);
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 2589871c0fa9..758d77206315 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -323,8 +323,8 @@ static int rdma_write_sg(struct rtrs_srv_op *id)
 	err = ib_post_send(id->con->c.qp, &id->tx_wr.wr, NULL);
 	if (err)
 		rtrs_err(s,
-			  "Posting RDMA-Write-Request to QP failed, err: %d\n",
-			  err);
+			  "Posting RDMA-Write-Request to QP failed, err: %d(%pe)\n",
+			  err, ERR_PTR(err));
 
 	return err;
 }
@@ -440,8 +440,8 @@ static int send_io_resp_imm(struct rtrs_srv_con *con, struct rtrs_srv_op *id,
 
 	err = ib_post_send(id->con->c.qp, wr, NULL);
 	if (err)
-		rtrs_err_rl(s, "Posting RDMA-Reply to QP failed, err: %d\n",
-			     err);
+		rtrs_err_rl(s, "Posting RDMA-Reply to QP failed, err: %d(%pe)\n",
+			     err, ERR_PTR(err));
 
 	return err;
 }
@@ -525,8 +525,8 @@ bool rtrs_srv_resp_rdma(struct rtrs_srv_op *id, int status)
 		err = rdma_write_sg(id);
 
 	if (err) {
-		rtrs_err_rl(s, "IO response failed: %d: srv_path=%s\n", err,
-			    kobject_name(&srv_path->kobj));
+		rtrs_err_rl(s, "IO response failed: %d(%pe): srv_path=%s\n", err,
+			    ERR_PTR(err), kobject_name(&srv_path->kobj));
 		close_path(srv_path);
 	}
 out:
@@ -643,7 +643,7 @@ static int map_cont_bufs(struct rtrs_srv_path *srv_path)
 					DMA_TO_DEVICE, rtrs_srv_rdma_done);
 			if (!srv_mr->iu) {
 				err = -ENOMEM;
-				rtrs_err(ss, "rtrs_iu_alloc(), err: %d\n", err);
+				rtrs_err(ss, "rtrs_iu_alloc(), err: %d(%pe)\n", err, ERR_PTR(err));
 				goto dereg_mr;
 			}
 		}
@@ -819,7 +819,7 @@ static int process_info_req(struct rtrs_srv_con *con,
 
 	err = post_recv_path(srv_path);
 	if (err) {
-		rtrs_err(s, "post_recv_path(), err: %d\n", err);
+		rtrs_err(s, "post_recv_path(), err: %d(%pe)\n", err, ERR_PTR(err));
 		return err;
 	}
 
@@ -882,7 +882,7 @@ static int process_info_req(struct rtrs_srv_con *con,
 	get_device(&srv_path->srv->dev);
 	err = rtrs_srv_change_state(srv_path, RTRS_SRV_CONNECTED);
 	if (!err) {
-		rtrs_err(s, "rtrs_srv_change_state(), err: %d\n", err);
+		rtrs_err(s, "rtrs_srv_change_state(), err: %d(%pe)\n", err, ERR_PTR(err));
 		goto iu_free;
 	}
 
@@ -896,7 +896,7 @@ static int process_info_req(struct rtrs_srv_con *con,
 	 */
 	err = rtrs_srv_path_up(srv_path);
 	if (err) {
-		rtrs_err(s, "rtrs_srv_path_up(), err: %d\n", err);
+		rtrs_err(s, "rtrs_srv_path_up(), err: %d(%pe)\n", err, ERR_PTR(err));
 		goto iu_free;
 	}
 
@@ -907,7 +907,7 @@ static int process_info_req(struct rtrs_srv_con *con,
 	/* Send info response */
 	err = rtrs_iu_post_send(&con->c, tx_iu, tx_sz, reg_wr);
 	if (err) {
-		rtrs_err(s, "rtrs_iu_post_send(), err: %d\n", err);
+		rtrs_err(s, "rtrs_iu_post_send(), err: %d(%pe)\n", err, ERR_PTR(err));
 iu_free:
 		rtrs_iu_free(tx_iu, srv_path->s.dev->ib_dev, 1);
 	}
@@ -975,7 +975,7 @@ static int post_recv_info_req(struct rtrs_srv_con *con)
 	/* Prepare for getting info response */
 	err = rtrs_iu_post_recv(&con->c, rx_iu);
 	if (err) {
-		rtrs_err(s, "rtrs_iu_post_recv(), err: %d\n", err);
+		rtrs_err(s, "rtrs_iu_post_recv(), err: %d(%pe)\n", err, ERR_PTR(err));
 		rtrs_iu_free(rx_iu, srv_path->s.dev->ib_dev, 1);
 		return err;
 	}
@@ -1021,7 +1021,7 @@ static int post_recv_path(struct rtrs_srv_path *srv_path)
 
 		err = post_recv_io(to_srv_con(srv_path->s.con[cid]), q_size);
 		if (err) {
-			rtrs_err(s, "post_recv_io(), err: %d\n", err);
+			rtrs_err(s, "post_recv_io(), err: %d(%pe)\n", err, ERR_PTR(err));
 			return err;
 		}
 	}
@@ -1069,8 +1069,8 @@ static void process_read(struct rtrs_srv_con *con,
 
 	if (ret) {
 		rtrs_err_rl(s,
-			     "Processing read request failed, user module cb reported for msg_id %d, err: %d\n",
-			     buf_id, ret);
+			     "Processing read request failed, user module cb reported for msg_id %d, err: %d(%pe)\n",
+			     buf_id, ret, ERR_PTR(ret));
 		goto send_err_msg;
 	}
 
@@ -1080,8 +1080,8 @@ static void process_read(struct rtrs_srv_con *con,
 	ret = send_io_resp_imm(con, id, ret);
 	if (ret < 0) {
 		rtrs_err_rl(s,
-			     "Sending err msg for failed RDMA-Write-Req failed, msg_id %d, err: %d\n",
-			     buf_id, ret);
+			     "Sending err msg for failed RDMA-Write-Req failed, msg_id %d, err: %d(%pe)\n",
+			     buf_id, ret, ERR_PTR(ret));
 		close_path(srv_path);
 	}
 	rtrs_srv_put_ops_ids(srv_path);
@@ -1121,8 +1121,8 @@ static void process_write(struct rtrs_srv_con *con,
 			       data + data_len, usr_len);
 	if (ret) {
 		rtrs_err_rl(s,
-			     "Processing write request failed, user module callback reports err: %d\n",
-			     ret);
+			     "Processing write request failed, user module callback reports err: %d(%pe)\n",
+			     ret, ERR_PTR(ret));
 		goto send_err_msg;
 	}
 
@@ -1132,8 +1132,8 @@ static void process_write(struct rtrs_srv_con *con,
 	ret = send_io_resp_imm(con, id, ret);
 	if (ret < 0) {
 		rtrs_err_rl(s,
-			     "Processing write request failed, sending I/O response failed, msg_id %d, err: %d\n",
-			     buf_id, ret);
+			     "Processing write request failed, sending I/O response failed, msg_id %d, err: %d(%pe)\n",
+			     buf_id, ret, ERR_PTR(ret));
 		close_path(srv_path);
 	}
 	rtrs_srv_put_ops_ids(srv_path);
@@ -1263,7 +1263,8 @@ static void rtrs_srv_rdma_done(struct ib_cq *cq, struct ib_wc *wc)
 		srv_path->s.hb_missed_cnt = 0;
 		err = rtrs_post_recv_empty(&con->c, &io_comp_cqe);
 		if (err) {
-			rtrs_err(s, "rtrs_post_recv(), err: %d\n", err);
+			rtrs_err(s, "rtrs_post_recv(), err: %d(%pe)\n",
+				 err, ERR_PTR(err));
 			close_path(srv_path);
 			break;
 		}
@@ -1288,8 +1289,8 @@ static void rtrs_srv_rdma_done(struct ib_cq *cq, struct ib_wc *wc)
 				mr->msg_id = msg_id;
 				err = rtrs_srv_inv_rkey(con, mr);
 				if (err) {
-					rtrs_err(s, "rtrs_post_recv(), err: %d\n",
-						  err);
+					rtrs_err(s, "rtrs_post_recv(), err: %d(%pe)\n",
+						  err, ERR_PTR(err));
 					close_path(srv_path);
 					break;
 				}
@@ -1638,7 +1639,7 @@ static int rtrs_rdma_do_accept(struct rtrs_srv_path *srv_path,
 
 	err = rdma_accept(cm_id, &param);
 	if (err)
-		pr_err("rdma_accept(), err: %d\n", err);
+		pr_err("rdma_accept(), err: %d(%pe)\n", err, ERR_PTR(err));
 
 	return err;
 }
@@ -1656,7 +1657,7 @@ static int rtrs_rdma_do_reject(struct rdma_cm_id *cm_id, int errno)
 
 	err = rdma_reject(cm_id, &msg, sizeof(msg), IB_CM_REJ_CONSUMER_DEFINED);
 	if (err)
-		pr_err("rdma_reject(), err: %d\n", err);
+		pr_err("rdma_reject(), err: %d(%pe)\n", err, ERR_PTR(err));
 
 	/* Bounce errno back */
 	return errno;
@@ -1732,7 +1733,7 @@ static int create_con(struct rtrs_srv_path *srv_path,
 				 max_send_wr, max_recv_wr,
 				 IB_POLL_WORKQUEUE);
 	if (err) {
-		rtrs_err(s, "rtrs_cq_qp_create(), err: %d\n", err);
+		rtrs_err(s, "rtrs_cq_qp_create(), err: %d(%pe)\n", err, ERR_PTR(err));
 		goto free_con;
 	}
 	if (con->c.cid == 0) {
@@ -1947,7 +1948,7 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
 	}
 	err = create_con(srv_path, cm_id, cid);
 	if (err) {
-		rtrs_err((&srv_path->s), "create_con(), error %d\n", err);
+		rtrs_err((&srv_path->s), "create_con(), error %d(%pe)\n", err, ERR_PTR(err));
 		rtrs_rdma_do_reject(cm_id, err);
 		/*
 		 * Since session has other connections we follow normal way
@@ -1958,7 +1959,8 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
 	}
 	err = rtrs_rdma_do_accept(srv_path, cm_id);
 	if (err) {
-		rtrs_err((&srv_path->s), "rtrs_rdma_do_accept(), error %d\n", err);
+		rtrs_err((&srv_path->s), "rtrs_rdma_do_accept(), error %d(%pe)\n",
+				err, ERR_PTR(err));
 		rtrs_rdma_do_reject(cm_id, err);
 		/*
 		 * Since current connection was successfully added to the
@@ -2009,8 +2011,8 @@ static int rtrs_srv_rdma_cm_handler(struct rdma_cm_id *cm_id,
 	case RDMA_CM_EVENT_REJECTED:
 	case RDMA_CM_EVENT_CONNECT_ERROR:
 	case RDMA_CM_EVENT_UNREACHABLE:
-		rtrs_err(s, "CM error (CM event: %s, err: %d)\n",
-			  rdma_event_msg(ev->event), ev->status);
+		rtrs_err(s, "CM error (CM event: %s, err: %d(%pe))\n",
+			  rdma_event_msg(ev->event), ev->status, ERR_PTR(ev->status));
 		fallthrough;
 	case RDMA_CM_EVENT_DISCONNECTED:
 	case RDMA_CM_EVENT_ADDR_CHANGE:
@@ -2019,8 +2021,8 @@ static int rtrs_srv_rdma_cm_handler(struct rdma_cm_id *cm_id,
 		close_path(srv_path);
 		break;
 	default:
-		pr_err("Ignoring unexpected CM event %s, err %d\n",
-		       rdma_event_msg(ev->event), ev->status);
+		pr_err("Ignoring unexpected CM event %s, err %d(%pe)\n",
+		       rdma_event_msg(ev->event), ev->status, ERR_PTR(ev->status));
 		break;
 	}
 
@@ -2044,13 +2046,13 @@ static struct rdma_cm_id *rtrs_srv_cm_init(struct rtrs_srv_ctx *ctx,
 	}
 	ret = rdma_bind_addr(cm_id, addr);
 	if (ret) {
-		pr_err("Binding RDMA address failed, err: %d\n", ret);
+		pr_err("Binding RDMA address failed, err: %d(%pe)\n", ret, ERR_PTR(ret));
 		goto err_cm;
 	}
 	ret = rdma_listen(cm_id, 64);
 	if (ret) {
-		pr_err("Listening on RDMA connection failed, err: %d\n",
-		       ret);
+		pr_err("Listening on RDMA connection failed, err: %d(%pe)\n",
+		       ret, ERR_PTR(ret));
 		goto err_cm;
 	}
 
@@ -2328,8 +2330,8 @@ static int __init rtrs_server_init(void)
 
 	err = check_module_params();
 	if (err) {
-		pr_err("Failed to load module, invalid module parameters, err: %d\n",
-		       err);
+		pr_err("Failed to load module, invalid module parameters, err: %d(%pe)\n",
+		       err, ERR_PTR(err));
 		return err;
 	}
 	err = class_register(&rtrs_dev_class);
diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
index bf38ac6f87c4..ea91371f6ad7 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs.c
@@ -273,7 +273,8 @@ static int create_qp(struct rtrs_con *con, struct ib_pd *pd,
 
 	ret = rdma_create_qp(cm_id, pd, &init_attr);
 	if (ret) {
-		rtrs_err(con->path, "Creating QP failed, err: %d\n", ret);
+		rtrs_err(con->path, "Creating QP failed, err: %d(%pe)\n", ret,
+			 ERR_PTR(ret));
 		return ret;
 	}
 	con->qp = cm_id->qp;
@@ -341,7 +342,8 @@ void rtrs_send_hb_ack(struct rtrs_path *path)
 	err = rtrs_post_rdma_write_imm_empty(usr_con, path->hb_cqe, imm,
 					     NULL);
 	if (err) {
-		rtrs_err(path, "send HB ACK failed, errno: %d\n", err);
+		rtrs_err(path, "send HB ACK failed, errno: %d(%pe)\n", err,
+			 ERR_PTR(err));
 		path->hb_err_handler(usr_con);
 		return;
 	}
@@ -375,7 +377,8 @@ static void hb_work(struct work_struct *work)
 	err = rtrs_post_rdma_write_imm_empty(usr_con, path->hb_cqe, imm,
 					     NULL);
 	if (err) {
-		rtrs_err(path, "HB send failed, errno: %d\n", err);
+		rtrs_err(path, "HB send failed, errno: %d(%pe)\n", err,
+			 ERR_PTR(err));
 		path->hb_err_handler(usr_con);
 		return;
 	}
-- 
2.43.0


