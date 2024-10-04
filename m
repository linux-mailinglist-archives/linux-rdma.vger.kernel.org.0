Return-Path: <linux-rdma+bounces-5228-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB899990D1D
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2024 21:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A25501F22938
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2024 19:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BD7204953;
	Fri,  4 Oct 2024 18:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYoOmJLq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C96320494C;
	Fri,  4 Oct 2024 18:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066344; cv=none; b=GKQ4GCMjEHWAs2Z8YjZrWWfI+5ATxqDkdcz0iJ+iyOkDjg9JgxTGOuzKiUcy1384NE52p2rzaO6abdfDpwQci6Q+kSsOMQkn4HFQmzt9RNltlRoFQTU2T+snPZayyRlCiZ+lIoeHJSU4jjWB6FFz1uAobD3UzID4zbH1T3M4Jsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066344; c=relaxed/simple;
	bh=0a+Seo70NaweNCwlTC06rm6ofVOagReXXDNoRdVU5jI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PjYXz2OBRySj7qopzcjlcFy2c+zgPsUXLwn73D2YQYhlqTJzh+0pQWesbkaKHfS2/D3Cm26nXlyaZ4yhEdjWYXjmbr8QXZyyf6N+bdP9Gn7i9ES+bCjao1LSbXkVXVTQ7/3wZp5jqMEdLWbq7WGf/04l++Einyt3naEV8WrXWA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYoOmJLq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07639C4CED2;
	Fri,  4 Oct 2024 18:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066343;
	bh=0a+Seo70NaweNCwlTC06rm6ofVOagReXXDNoRdVU5jI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lYoOmJLqf6ZtmUrNVX8ciJwPdAbXzgrTn1+AMo+CmrE9GeKGXrW8QyDrXMmkdU8Ca
	 3GucpTdcrIFSm4n7u3iFMG6IRgDeYSORjCWEArhg+jTH7LUObpvov02WEqxyfbyfAL
	 v4vbIDlI9y4pRTxe9YkzfKGD0BrCQ6ufm6u54lZH5tEQXdtllk9HIvlDLXbCdYeV3v
	 BVcJYE+QLdYJOWLxRdp4Nn7jZCi4oIDDD5M3GLFD5f6o8xCSW3cdkJmKXQas9jSz5R
	 nTZXXTUcLJ8T3p1+v9y4O3LE+jXPuMGvqiTgUpdL8uPPWrNzcHhAQEns3cXE02lpRz
	 UhcbeD1Jhaz5w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Md Haris Iqbal <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Grzegorz Prajsner <grzegorz.prajsner@ionos.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 22/58] RDMA/rtrs-srv: Avoid null pointer deref during path establishment
Date: Fri,  4 Oct 2024 14:23:55 -0400
Message-ID: <20241004182503.3672477-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182503.3672477-1-sashal@kernel.org>
References: <20241004182503.3672477-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.54
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
index 1d33efb8fb03b..e9835a1666d3a 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -931,12 +931,11 @@ static void rtrs_srv_info_req_done(struct ib_cq *cq, struct ib_wc *wc)
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
@@ -987,6 +986,16 @@ static int post_recv_path(struct rtrs_srv_path *srv_path)
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


