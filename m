Return-Path: <linux-rdma+bounces-14855-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E98C9AFFA
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Dec 2025 10:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 55D9C348957
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Dec 2025 09:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B3B309F01;
	Tue,  2 Dec 2025 09:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzaGZ+5B"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703C031A056
	for <linux-rdma@vger.kernel.org>; Tue,  2 Dec 2025 09:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764669153; cv=none; b=mPyOuaz6uqy5n0MqOQ7ZlFhcKrx+7tRso3v++LHHbmUkz29q7HhfwLg0tvFRn5S+3LvyAIi6P1PEEMrEJhCKaSp7zL3hn0a7UmTeyEl6iL8kMVbjbxyHqRgeiGtzItmDzV5C1YijwW/jO0L7wVBkRwEmlA5ba7Y6krCSCL8r+CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764669153; c=relaxed/simple;
	bh=A2mUuXYeXgH3GWgj/1Uvi0IkvWKTlPl3+NWkZcL1hdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UdhAgmfFbuSfRhIbQBv76Z0zCvFBxiQScyJUVfEEFfeXptnZlQQexl7u2TEVnNwuLDrppnCaZXAgzWJiqiQ7Q8e/UvmQu+pd/m9Ey1Oqcw5PDuV9peTHfRuYVjgqTBEyYBl7L6vJizxImCXpxeCKVyq58ZX76/3DdfK32bs3YJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mzaGZ+5B; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b996c8db896so6192795a12.3
        for <linux-rdma@vger.kernel.org>; Tue, 02 Dec 2025 01:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764669151; x=1765273951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+6Q/13dXqqU2hdMSbPVRMXa6L7LavqU9DAw5tswhZM=;
        b=mzaGZ+5B3ktREpH/BxlYH4UVp0gqR6Sd28HPen0E5pXTnZ49CM1uQOrm4jc3XFqEBs
         pCs5+amAKjOi8Xbl0i51Ex7YlRZcVvJZSa6Pluik59LNDfcU0vKO/zRmtigpZW4bXlfV
         N1dAI5ywT1fB4p61Qm39bjZQHfijFc/YZYM0b4P2sxIIMser52edwnODoxr0lfuLcPPy
         qQbujrGumoeo32lMxvp8E4R9wIr0B0ViRbLy3Bev8sZ/h52M6QgC86wz2nkZJpYtPNY+
         koNKFofPAyW7YeiWOClGwl797q9SvW1JkObwlqFq0JWA6faOE1UZ1wH30Y37LRWzRygP
         /RQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764669151; x=1765273951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X+6Q/13dXqqU2hdMSbPVRMXa6L7LavqU9DAw5tswhZM=;
        b=R1/1K7cz7d36mXpXaeNU+aC30mXVCH+0aDTLnEmI5ZlkoWKBfthPuklD+xZOsPWTxI
         BruhZCdUid8HzxXaLDfuq9xP/VX5tidEnHZV9c7fd2EafElS4KUsY3a2AVITQG2vK3CW
         Cb3T2FLmoXf251cTRbEDmlKrnqF13HqxbY5q8s1erOsY/zf37WWd3VVnDSThFh6fK0uH
         Gn9MVcyg8raauwJmS3tT3YWVCMVGtxoQNMWMo7m32iMadoQTx3kDMHAXHQTsSUNiM7w4
         BNVtwhs4TcyO50oZ6NP50wRFN4024s/iMc0s+ORxopf9oQI6a1DRAngtgbAjeCv3qF3v
         y6YQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0sVAzx+xixgRbnUm+TIah/aUYYXkCi5q40njdUBN6JNZ8/b8jvrZGEX5zuT6LOeXVzMPtYaj5Xrmx@vger.kernel.org
X-Gm-Message-State: AOJu0YxlV1kvHsrJ2Z9rKn5BAt0JDY/UnS145rFn9nGT0HLeqmBCeSnT
	23m4xJoayXVFVz+RDOp8NE7chZL6+lKkDh1654357bkHCjaFGIOfqHcmt1qlhbQ5R4c=
X-Gm-Gg: ASbGnct5bgYuloHe/a+2/CtWD1MKancMNW34957ZrcoNZnHiQi1EVMawiKo4M2K2tH1
	BswLaldiGM+t3kLjgTJSvj5k3/xm3/jFGfGZk+MZZpEpRjgLXtWVwGK2nappmKidAhCc42CBz3M
	gyHq8ZbQuMNrLJBYT2z5x+1waw3RfHLKkvLFljRyFFcxAynCKO1EPNHUUl7EBtdluIqezJ1J17y
	RYao/tcqxIl/vQEw8/I3WG2ez68p9sB77TeOE4y+k3FZoeEandYv8kjc9ZJxDiAQsFEfhtOnf2j
	XMPIA5R2cC8DXM5xaVs5/vGtAFtT/9+BHuVxxRZwY/mR8ljJ/RWBnIDKxX7mXRugmimcgG332tB
	H7WsYG3dyctBM1R+KggC478xdpAS4OVGmiAffZVi5xO8peoGktn2AEwCSpPyHxFLicz7QCmJ69T
	8F+51X9SFfE6Ve0UPTrXDx+T80g49urc91RFM=
X-Google-Smtp-Source: AGHT+IFA62oLYKnlDqtoBnPUAYcC3aQLjfERYxHt0mlC+Wj3TDUDWpCBfU4LNshvI4iel+R8CqbMaA==
X-Received: by 2002:a05:7300:8a1d:b0:2a4:3592:cf5e with SMTP id 5a478bee46e88-2a9415824d7mr14493264eec.2.1764669150541;
        Tue, 02 Dec 2025 01:52:30 -0800 (PST)
Received: from localhost.localdomain ([192.146.154.240])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaed5fcasm83532079c88.2.2025.12.02.01.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 01:52:30 -0800 (PST)
From: Gaurav Gangalwar <gaurav.gangalwar@gmail.com>
To: trondmy@kernel.org,
	anna@kernel.org,
	tom@talpey.com,
	chuck.lever@oracle.com
Cc: linux-nfs@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Gaurav Gangalwar <gaurav.gangalwar@gmail.com>
Subject: [PATCH v2] NFS: inherit parent transport protocol for referral mounts
Date: Tue,  2 Dec 2025 04:52:12 -0500
Message-ID: <20251202095212.69329-1-gaurav.gangalwar@gmail.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <CAJiE4OkW6XT71xvv49VN5STPx7dQ6GxV+-Rz1=55JhoFPyM7PQ@mail.gmail.com>
References: <CAJiE4OkW6XT71xvv49VN5STPx7dQ6GxV+-Rz1=55JhoFPyM7PQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When following NFS referrals, the client always attempts RDMA first
(if compiled in), even when the parent mount uses TCP. This causes
unnecessary timeouts when the referral server doesn't support RDMA.

Modify nfs4_create_referral_server() to check the parent client's
transport protocol. Only attempt RDMA if the parent is using RDMA,
otherwise use the parent's protocol (TCP/TCP-TLS) directly.

This eliminates connection delays for TCP-based referrals in
environments where RDMA is compiled in but not deployed.

Signed-off-by: Gaurav Gangalwar <gaurav.gangalwar@gmail.com>

---
Changes since v1:
- Removed module parameter.
---
 fs/nfs/nfs4client.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 3a4baed993c9..39a0424523e5 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -1258,12 +1258,19 @@ struct nfs_server *nfs4_create_referral_server(struct fs_context *fc)
 	nfs_server_copy_userdata(server, parent_server);
 
 	/* Get a client representation */
+	/*
+	 * Only try RDMA if the parent client is using RDMA. This avoids
+	 * connection delays when parent uses TCP and referral server doesn't
+	 * support RDMA.
+	 */
 #if IS_ENABLED(CONFIG_SUNRPC_XPRT_RDMA)
-	rpc_set_port(&ctx->nfs_server.address, NFS_RDMA_PORT);
-	cl_init.proto = XPRT_TRANSPORT_RDMA;
-	error = nfs4_set_client(server, &cl_init);
-	if (!error)
-		goto init_server;
+	if (parent_client->cl_proto == XPRT_TRANSPORT_RDMA) {
+		rpc_set_port(&ctx->nfs_server.address, NFS_RDMA_PORT);
+		cl_init.proto = XPRT_TRANSPORT_RDMA;
+		error = nfs4_set_client(server, &cl_init);
+		if (!error)
+			goto init_server;
+	}
 #endif	/* IS_ENABLED(CONFIG_SUNRPC_XPRT_RDMA) */
 
 	cl_init.proto = XPRT_TRANSPORT_TCP;
-- 
2.43.7


