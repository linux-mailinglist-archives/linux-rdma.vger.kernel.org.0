Return-Path: <linux-rdma+bounces-5234-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCA3990E2D
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2024 21:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A69851F22ED0
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2024 19:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C1A21E97B;
	Fri,  4 Oct 2024 18:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4GYZs39"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9535321E970;
	Fri,  4 Oct 2024 18:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066563; cv=none; b=ESTVyPfzN1OQjBhrrg26PzlWiDU52OIIipq2Vh12paNf9VB4xddhvKs529yLJWQzgo1jcS4BfykYmVmfS3RYNurEvMMgN1t8JfG5uejhkMCvfveJzHTVpUd0ZOzT8WWTktsF707YgbS4dkJzXy+ESTyUIPG+td4pHpknayC/fg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066563; c=relaxed/simple;
	bh=fiQfPRLckoTZqtWRmX1EN7fdcgk4kBXpg1No5QtMhDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VEv6R4wRlTWnfVpdTb6eI3wzSbgNUXMkfQo+fEDPIDYmXhqTRbF3XPiOH9Uj138EUNu7gzFZhaPwSzDuq2D5uLdwNUSxkRlyfksLDDCtfw1OGq5wind+0QU6NeT7+2haHtw896q+sEQ1/1SLLFThCtDFZ+NEwlOg3vqbG5pZ1+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4GYZs39; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33BB3C4CECD;
	Fri,  4 Oct 2024 18:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066563;
	bh=fiQfPRLckoTZqtWRmX1EN7fdcgk4kBXpg1No5QtMhDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j4GYZs39f95LXiYjJtKddFNZur+ttNKWl6GkZ5eGEgehsFZLtzf1Zlq+tBQLL5Viw
	 J/I23LMi7oGeGKiH/Gr3xiLwf4REZqTqhTxjZn/DfgyXrzG/CSrg2atoNnpmjz2sie
	 piy3QQs9L7DOE7NIgnnZRZ6hv0wbk0RyeBGU4XkZyGO4QVjASE+Pe8W/taait8Kp91
	 gvRTGa2pMnoC1zmhkqxSGz+p7ZKbjZ0cfyhbne1C8i+1q306/CA9H5MI2Qve2ksxq/
	 9+FXbOkBxo6F6JiD8zULDvK3tQ5Qp/HQFPizyUPl0aPJ/JqBzShFW6y3pGwwhNhZFT
	 2bnklZGOF+H0w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Md Haris Iqbal <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Grzegorz Prajsner <grzegorz.prajsner@ionos.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 15/31] RDMA/rtrs-srv: Avoid null pointer deref during path establishment
Date: Fri,  4 Oct 2024 14:28:23 -0400
Message-ID: <20241004182854.3674661-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182854.3674661-1-sashal@kernel.org>
References: <20241004182854.3674661-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.167
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
index 27bf2b2da9fd6..7e3b2906758b2 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -943,12 +943,11 @@ static void rtrs_srv_info_req_done(struct ib_cq *cq, struct ib_wc *wc)
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
@@ -999,6 +998,16 @@ static int post_recv_path(struct rtrs_srv_path *srv_path)
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


