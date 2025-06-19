Return-Path: <linux-rdma+bounces-11472-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C435AE0823
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jun 2025 16:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40300189048A
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jun 2025 13:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4967C28640E;
	Thu, 19 Jun 2025 13:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUD9dLXt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EB627A92F;
	Thu, 19 Jun 2025 13:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750341525; cv=none; b=ZkdBt1nJuIBbyIVe/bL8iJz/oOficdlIPkP9IT2EIMY0KS6RmSfXtzUmsuwGd1WbYQLuu3dEAfOjevJs3YbdZWl/vagZ3be8yuOjS68mhQjcOdy87Cx0poogS7Ftvd6zykoX+cgbsgYXX2rhmzdZh1C2BiRPLkwZwJ8tBAgJmtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750341525; c=relaxed/simple;
	bh=maHkbMNGfOFR7+3e8JOVKOI5dAbeMgVGRbGkvpNuPy4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mkbk5MXQ4cerMKw1+lIc76VRwDB6P4lIPg2PdXao0auOTFA4StNlAGi3NVGpEZZyuweVdqR0zx8J8yJ6+U1iBlGP+D0mugw/qzUNQ3s8lBDBxLm8g2i4ElW4IZ5vbNxT9nfND5+shWF7H4fU7wN9m7rH8e8VXeohVG8Tgoi+bd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HUD9dLXt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED6B6C4CEEA;
	Thu, 19 Jun 2025 13:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750341524;
	bh=maHkbMNGfOFR7+3e8JOVKOI5dAbeMgVGRbGkvpNuPy4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HUD9dLXtRhWp2DGEx3CT1srgNucu51NGvIVjE7K6MS1uoL2eBidYoCL/qGlGGaSmw
	 VAyJu9m338gcPoX8J7PkbGCmOBgn6k7fyHsERRTOLlBQLw2FITrZvlKzuaLzH31D6I
	 XSd/+B46S80k3jkFJimchySQxK5xB1500BV33ReTD4rrC9MU84hdcFAK69iDtlJ9TO
	 DfqtJbsrMegXseW1znZGBBNGR8whi6sjAiwV25awGZ16/M//ZrMjgtJoTv/E1fXRFR
	 59rtSk0J5NXBm/eJZoAjngCbuGHkNeML/H3kOnwwJiGKXHhUwSRP5mNql1u1s2rH97
	 nCFshO9K6knOg==
From: Simon Horman <horms@kernel.org>
Date: Thu, 19 Jun 2025 14:58:33 +0100
Subject: [PATCH net-next 2/2] rds: Correct spelling
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250619-rds-minor-v1-2-86d2ee3a98b9@kernel.org>
References: <20250619-rds-minor-v1-0-86d2ee3a98b9@kernel.org>
In-Reply-To: <20250619-rds-minor-v1-0-86d2ee3a98b9@kernel.org>
To: Allison Henderson <allison.henderson@oracle.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
 linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, 
 Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.0

Correct spelling as flagged by codespell.
With these changes in place codespell only flags false positives
in net/rds.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 net/rds/af_rds.c | 2 +-
 net/rds/send.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/rds/af_rds.c b/net/rds/af_rds.c
index 8435a20968ef..086a13170e09 100644
--- a/net/rds/af_rds.c
+++ b/net/rds/af_rds.c
@@ -598,7 +598,7 @@ static int rds_connect(struct socket *sock, struct sockaddr *uaddr,
 		}
 
 		if (addr_type & IPV6_ADDR_LINKLOCAL) {
-			/* If socket is arleady bound to a link local address,
+			/* If socket is already bound to a link local address,
 			 * the peer address must be on the same link.
 			 */
 			if (sin6->sin6_scope_id == 0 ||
diff --git a/net/rds/send.c b/net/rds/send.c
index 09a280110654..42d991bc8543 100644
--- a/net/rds/send.c
+++ b/net/rds/send.c
@@ -232,7 +232,7 @@ int rds_send_xmit(struct rds_conn_path *cp)
 		 * If not already working on one, grab the next message.
 		 *
 		 * cp_xmit_rm holds a ref while we're sending this message down
-		 * the connction.  We can use this ref while holding the
+		 * the connection.  We can use this ref while holding the
 		 * send_sem.. rds_send_reset() is serialized with it.
 		 */
 		if (!rm) {

-- 
2.47.2


