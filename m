Return-Path: <linux-rdma+bounces-20859-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WF5FBG1qCmp+1AQAu9opvQ
	(envelope-from <linux-rdma+bounces-20859-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 03:25:01 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B82DA564C04
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 03:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 087403008891
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 01:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF341229B38;
	Mon, 18 May 2026 01:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIjL9BuF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FA721FF30;
	Mon, 18 May 2026 01:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779067485; cv=none; b=Wbkmw0MbJ33jmwVjVBmjDS3tIywDgz7DA0FUxfzvwBlVrUbzGMha1w/yNYsjo1xEGHdyYaOFGzH1wnuVGOm5UdFvk1DL96f4f5agat/NXzSgsYwSTpYf3TdA7kRAIIxdI9nZpvkNNNwPK1tcXSfBwMt9MVgIdDx39OKSIjXqnqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779067485; c=relaxed/simple;
	bh=Blso7krvz+YExeomj9FGS5MXoSSvUN9u8LiWqfVDdqs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eNk888pWVNe3JLPQ9L+/7mCv923NZ/Oev5qchQSuP0fbzWSVm9RRoo6nVfXCjw5q6mj3p173xcgJNLQwYoV42iks5m25JpVa13gKI/fCRR8QnbzFvJzdme+JVPXBxpJA63Du2dyHaglXqi/hJkckFUAnj0cRDA744MzE94Bh6yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIjL9BuF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14DB6C2BCC9;
	Mon, 18 May 2026 01:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779067485;
	bh=Blso7krvz+YExeomj9FGS5MXoSSvUN9u8LiWqfVDdqs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=EIjL9BuF6p/mL5vpX69cJ12aWcpDyjk7VDXVWU7KYTR0QDAP6l0CgHX7GjaleUdOP
	 C2/y69DpzpLp/YiHDv5PLObmRgdKMwJsXtFVqeJ1CYIvOyyng9yJCvm+Gb6sY6A+Js
	 2ixYdbZxm2OcSTGYpoqUeMu/8Eks2hCPiyDXbog+NatBZuy1b2rZWs+d4i1YldjBAB
	 TqPau6/8Px40/d8RQR7yoTBm9GaLCP9SL1kjRB81RUIngqysTZx/7mM59MmGaupmlP
	 SfCwhWN1a60KMbojeitnq5g+FjW8Hn+ZJwGIVRGxQ+x90DUPBzvVcRK5ss/ofBFvJx
	 PE9ILfNsHoSaw==
From: Allison Henderson <achender@kernel.org>
To: netdev@vger.kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	achender@kernel.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org
Subject: [PATCH net-next v3 01/11] net/rds: Don't sleep inside rds_ib_conn_path_shutdown
Date: Sun, 17 May 2026 18:24:33 -0700
Message-Id: <20260518012443.2629206-2-achender@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260518012443.2629206-1-achender@kernel.org>
References: <20260518012443.2629206-1-achender@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B82DA564C04
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-20859-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

New rds rdma self tests exposed a hang when tearing down
the ib network configs.  This is caused by the shutdown worker
thread sleeping on the wait_event call, which blocks other work
items in the queue. Fix this by changing wait_event to
wait_event timeout, and looping until the wait check succeeds.

Signed-off-by: Allison Henderson <achender@kernel.org>
---
 net/rds/ib_cm.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/net/rds/ib_cm.c b/net/rds/ib_cm.c
index 0c64c504f79db..6b40345ba44d1 100644
--- a/net/rds/ib_cm.c
+++ b/net/rds/ib_cm.c
@@ -1038,6 +1038,19 @@ int rds_ib_conn_path_connect(struct rds_conn_path *cp)
 	return ret;
 }
 
+static unsigned long rds_ib_conn_path_shutdown_check_wait(struct rds_conn_path *cp)
+{
+	struct rds_connection *conn = cp->cp_conn;
+	struct rds_ib_connection *ic = conn->c_transport_data;
+
+	return (!ic->i_cm_id ||
+		(rds_ib_ring_empty(&ic->i_recv_ring) &&
+		 (atomic_read(&ic->i_signaled_sends) == 0) &&
+		 (atomic_read(&ic->i_fastreg_inuse_count)) == 0 &&
+		 (atomic_read(&ic->i_fastreg_wrs) == RDS_IB_DEFAULT_FR_WR))) ? 0
+		: msecs_to_jiffies(1000);
+}
+
 /*
  * This is so careful about only cleaning up resources that were built up
  * so that it can be called at any point during startup.  In fact it
@@ -1078,11 +1091,13 @@ void rds_ib_conn_path_shutdown(struct rds_conn_path *cp)
 		 * sends to complete we're ensured that there will be no
 		 * more tx processing.
 		 */
-		wait_event(rds_ib_ring_empty_wait,
-			   rds_ib_ring_empty(&ic->i_recv_ring) &&
-			   (atomic_read(&ic->i_signaled_sends) == 0) &&
-			   (atomic_read(&ic->i_fastreg_inuse_count) == 0) &&
-			   (atomic_read(&ic->i_fastreg_wrs) == RDS_IB_DEFAULT_FR_WR));
+		while (!wait_event_timeout(rds_ib_ring_empty_wait,
+					   rds_ib_conn_path_shutdown_check_wait(cp) == 0,
+					   msecs_to_jiffies(1000))) {
+			tasklet_schedule(&ic->i_send_tasklet);
+			tasklet_schedule(&ic->i_recv_tasklet);
+		}
+
 		tasklet_kill(&ic->i_send_tasklet);
 		tasklet_kill(&ic->i_recv_tasklet);
 
-- 
2.25.1


