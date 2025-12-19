Return-Path: <linux-rdma+bounces-15107-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFA8CD0329
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Dec 2025 15:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F13A304EF49
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Dec 2025 14:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86CD324B1F;
	Fri, 19 Dec 2025 14:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="kB5Leuhl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDD613E02A;
	Fri, 19 Dec 2025 14:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766153057; cv=none; b=okFODgMEQ/o4G+mDdO4PrsutlyjbFDQKrz+z03rXDM0Zip/XGBnXicm8ECBsV0H99NvOLsVWwERBtxBo91Tzo2UWuj+u6hj2LmcqOOXLhLXMOAFfQrgFBiRgLNiEHquzlmB2qH0gf5XQYZiVUHcP9xQ8DxR2MxrRIPtkHxyRnB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766153057; c=relaxed/simple;
	bh=lb1Ntz2Kr1h3lPXH9iuyKpE+eZFBhtVfhjMw6MwoW7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k6Lbrh5/U4ml6qq4FpiChgLiHbklC5WQvXxgAnpjjmbdrWMjld8UKCQNCTOpnZlGYMDzYof0w8oSIju6KtkhKwH25xrj8k8AQZnH6hRKdwgCvp2q6PDBihKy6Fm2TKx5vSlWCXjcX833sBM5IBdU+dyojrQHVALg5UQs45MGQKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=kB5Leuhl; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:Date:Cc:To:From;
	bh=oGrtxTNHWv12XqgB1T2iiuzx13WIcYvkHIUNhdXByGk=; b=kB5LeuhlfK6/YGz4Gyb4J7JNIc
	cNPakImySVmcy0cFJQWJg7H+/3r3eusdCNr4Yh6WF6PeTeQnGPyn7m063q4TFmXjGDUTvtYF1LhS1
	KH5t6JfWu1dMETqvfSvpD1MKQOu015HaiGbe23ZLltNKWGNqEwOTmaY47ne2fgkSaJDDRfAaZAvNT
	fOIb7PyH/qDuIvzVJjnY/OA2TQjxooQ6IxwHf9b9t8tqkJfxIIYChuyzGQcNF3p5/nLtkbHWJC7R3
	4orhlnGBC1pFgQ0RbAha36lmpzdhotZKi6pucNmsTdfFlPYExWwzlzgB1BxIbeFlluLc/OhAMUNwE
	T69csLakAodG5FesjxEALSAO8xUoYShQy41gyyhXl9uaMmkWXRta8PGiS7JlAGzncE+R1wFHMyAnH
	/013FYUYXgjj1i5AcXZPB3f0b1/WzB/iYchw306448MtV+tKqAw7WxkYk58hG2WZH/2ELWEr7sjQO
	qSk4Fx0YtabARi6nfZwPXXEp;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1vWb5Y-001MsZ-1h;
	Fri, 19 Dec 2025 14:04:12 +0000
From: Stefan Metzmacher <metze@samba.org>
To: linux-rdma@vger.kernel.org
Cc: metze@samba.org,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	netdev@vger.kernel.org,
	linux-cifs@vger.kernel.org
Subject: [PATCH] RDMA/rxe: let rxe_reclassify_recv_socket() call sk_owner_put()
Date: Fri, 19 Dec 2025 15:04:08 +0100
Message-ID: <20251219140408.2300163-1-metze@samba.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On kernels build with CONFIG_PROVE_LOCKING, CONFIG_MODULES
and CONFIG_DEBUG_LOCK_ALLOC 'rmmod rdma_rxe' is no longer
possible.

For the global recv sockets rxe_net_exit() is where we
call rxe_release_udp_tunnel-> udp_tunnel_sock_release(),
which means the sockets are destroyed before 'rmmod rdma_rxe'
finishes, so there's no need to protect against
rxe_recv_slock_key and rxe_recv_sk_key disappearing
while the sockets are still alive.

Fixes: 80a85a771deb ("RDMA/rxe: reclassify sockets in order to avoid false positives from lockdep")
Cc: Zhu Yanjun <zyjzyj2000@gmail.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-rdma@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: linux-cifs@vger.kernel.org
Signed-off-by: Stefan Metzmacher <metze@samba.org>
---
 drivers/infiniband/sw/rxe/rxe_net.c | 32 +++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 0195d361e5e3..0bd0902b11f7 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -64,7 +64,39 @@ static inline void rxe_reclassify_recv_socket(struct socket *sock)
 		break;
 	default:
 		WARN_ON_ONCE(1);
+		return;
 	}
+	/*
+	 * sock_lock_init_class_and_name() calls
+	 * sk_owner_set(sk, THIS_MODULE); in order
+	 * to make sure the referenced global
+	 * variables rxe_recv_slock_key and
+	 * rxe_recv_sk_key are not removed
+	 * before the socket is closed.
+	 *
+	 * However this prevents rxe_net_exit()
+	 * from being called and 'rmmod rdma_rxe'
+	 * is refused because of the references.
+	 *
+	 * For the global sockets in recv_sockets,
+	 * we are sure that rxe_net_exit() will call
+	 * rxe_release_udp_tunnel -> udp_tunnel_sock_release.
+	 *
+	 * So we don't need the additional reference to
+	 * our own (THIS_MODULE).
+	 */
+	sk_owner_put(sk);
+	/*
+	 * We also call sk_owner_clear() otherwise
+	 * sk_owner_put(sk) in sk_prot_free will
+	 * fail, which is called via
+	 * sk_free -> __sk_free -> sk_destruct
+	 * and sk_destruct calls __sk_destruct
+	 * directly or via call_rcu()
+	 * so sk_prot_free() might be called
+	 * after rxe_net_exit().
+	 */
+	sk_owner_clear(sk);
 #endif /* CONFIG_DEBUG_LOCK_ALLOC */
 }
 
-- 
2.43.0


