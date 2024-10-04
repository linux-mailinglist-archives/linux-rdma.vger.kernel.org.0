Return-Path: <linux-rdma+bounces-5231-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12972990E41
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2024 21:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60829B293FC
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2024 19:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE8C1D90A9;
	Fri,  4 Oct 2024 18:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pGJWUL+z"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962FF1D90A1;
	Fri,  4 Oct 2024 18:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066468; cv=none; b=hRh4JYWYSEGsxnB4Y2Fo0tio1ST1Oxr6Krldc7JAVoHDkq34YZl/doy/v+v5U98gVpyQlFNEVAyvEB3eZC10tOHR9qba9BwJ9BEReXnVkWWSoK6cBHJEKssIEefbI9P/iMcbrnb7X1uVNqU/w+w6Qk/hBBrHE5v0wVxn64uwLOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066468; c=relaxed/simple;
	bh=aI0CcmK3NZ4l0SMhc8yyG55czISfXRwzFxc9DB73wY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SCzcs+r/KtXfYqJF0mviVdJh3Z7slmLF2nkBb95xxRTCfDg9ISmxDkHDvsJ/VQdkQOE0huR2BWp2zT1yj2RQ8VuLY6QDJg5c39jfRLlM7mBShFz+Metumzsx/5g6A+sFOitLh95kgYDlRMUEH8kQZIb55ZCyY9WqytHGLXJEONA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pGJWUL+z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95633C4CECD;
	Fri,  4 Oct 2024 18:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066468;
	bh=aI0CcmK3NZ4l0SMhc8yyG55czISfXRwzFxc9DB73wY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pGJWUL+z3Q7DnlLWLVCk+k/sRzzKMgruXBv39k4hIfshG6I3TjG/TXeDNFm/YBfLh
	 B3JT73lLrUHHdAKXUVQWUl4LA3hG21QWDfFLS3sNiDyltMGUFQ8VQDGqtB9ycAA872
	 MCksm7DiIwmD8qo3SkKCNIUx2ugWKH415oH9U9CvpliCfC4B/xIeiTe4dTG8RZUg9Z
	 U8eAvuyBqcqBL+33C1M22qKImUl7ughqafKMYZc9n1WRrn4umN65CLN/Lq52eQ6lLL
	 z1DyysD+znfcxubTkl6RaASkwcjy4trnjPtdE5iDK37bxvZDmGtarw60u36z78UHeq
	 a3RpOawc3/Yxg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Md Haris Iqbal <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Grzegorz Prajsner <grzegorz.prajsner@ionos.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 16/42] RDMA/rtrs-srv: Avoid null pointer deref during path establishment
Date: Fri,  4 Oct 2024 14:26:27 -0400
Message-ID: <20241004182718.3673735-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182718.3673735-1-sashal@kernel.org>
References: <20241004182718.3673735-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.112
Content-Transfer-Encoding: 8bit

From: Md Haris Iqbal <haris.iqbal@ionos.com>

[ Upstream commit d0e62bf7b575fbfe591f6f570e7595dd60a2f5eb ]

For RTRS path establishment, RTRS client initiates and completes con_num
of connections. After establishing all its connections, the information
is exchanged between the client and server through the info_req message.
During this exchange, it is essential that all connections have been
established, and the state of the RTRS srv path is CONNECTED.

So add these sanity checks, to make sure we detect and abort process in
error scenarios to avoid null pointer deref.

Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Link: https://patch.msgid.link/20240821112217.41827-9-haris.iqbal@ionos.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index e978ee4bb73ae..e1fed7e550245 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -936,12 +936,11 @@ static void rtrs_srv_info_req_done(struct ib_cq *cq, struct ib_wc *wc)
 	if (err)
 		goto close;
 
-out:
 	rtrs_iu_free(iu, srv_path->s.dev->ib_dev, 1);
 	return;
 close:
+	rtrs_iu_free(iu, srv_path->s.dev->ib_dev, 1);
 	close_path(srv_path);
-	goto out;
 }
 
 static int post_recv_info_req(struct rtrs_srv_con *con)
@@ -992,6 +991,16 @@ static int post_recv_path(struct rtrs_srv_path *srv_path)
 			q_size = SERVICE_CON_QUEUE_DEPTH;
 		else
 			q_size = srv->queue_depth;
+		if (srv_path->state != RTRS_SRV_CONNECTING) {
+			rtrs_err(s, "Path state invalid. state %s\n",
+				 rtrs_srv_state_str(srv_path->state));
+			return -EIO;
+		}
+
+		if (!srv_path->s.con[cid]) {
+			rtrs_err(s, "Conn not set for %d\n", cid);
+			return -EIO;
+		}
 
 		err = post_recv_io(to_srv_con(srv_path->s.con[cid]), q_size);
 		if (err) {
-- 
2.43.0


