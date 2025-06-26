Return-Path: <linux-rdma+bounces-11657-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 834CDAE9863
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 10:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DADDD7A8EB1
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 08:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857FB293C55;
	Thu, 26 Jun 2025 08:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="up9is5AR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB21290BCD;
	Thu, 26 Jun 2025 08:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750926857; cv=none; b=O8n6SEvvzj0J8huO1SHa0SOLgYCzGQJyHhtlGOcHQBN7TRIl0wSh59UQBXdebgE4nde6hyKTvwVYyQSFtsDq+B8FNUoRPtmU6E5mP7JxZZDOIzG4txoKjVZ4FohS9mtl4P6ZAby4FuGGtluoZH4awZYiyHS2iZXBjoj919UgM90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750926857; c=relaxed/simple;
	bh=fhLUUYVAyb1uDBHiiFLUBKdkZ0mPXVVyAvNzmr4SGO0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R5XRjaBF7trPAyLlS+brv56uLA7QLIEYbi2nHPV9uWUwpTlV8CRw+T0w+xQmVOLoD0ZuWsW/i+vkof6AuI2Vblni4pH7lcvJRXw5oafqybAAIxBEc1kvcFtHNGOjm6InCZcM/ymYtfMcgC7KJxyxlHc01wncP01tlMJ+5aUGaO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=up9is5AR; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uUi3X-00GcBO-Oq; Thu, 26 Jun 2025 10:34:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=k/l0z57m3ZEaN2DhDCC8Xr3psOdIVksIU8zRLih/bxY=; b=up9is5ARxksILixaAI6Lh3hlTr
	wbDXGEfPUcS0QfVyR+qXwyD7LrDfZD6gC4sAmbL4cF95uwGIQaN4s65AXkrfisnhZhFw98qIMCLCJ
	HPajsm3Hh8NdZLPRZlsSvbEe2MnKA+Prgla4oz1LxUbPDz54OEEcbnQkH79ZkUiOcRjhnqasdeZSb
	ZCWPCR7sAUseSSUCQfhYMmm2zkDK3g6uA1h6upzsBeOrb/QuKFqRX1RQFeOmU7Ts0UcHvTqUWI8JJ
	agxBtXvcc6PNMbZWVgRzCTXGz5XC5AWlL4dm3+6k6yZYAbl0BwWG7I8ixLNgNBTbYXUHwVigLvdKi
	n999ofUA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uUi3W-0004pt-2f; Thu, 26 Jun 2025 10:34:02 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uUi3O-009Fh5-9n; Thu, 26 Jun 2025 10:33:54 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Thu, 26 Jun 2025 10:33:37 +0200
Subject: [PATCH net-next v2 4/9] af_unix: Drop
 unix_stream_read_state::splice_flags
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250626-splice-drop-unused-v2-4-3268fac1af89@rbox.co>
References: <20250626-splice-drop-unused-v2-0-3268fac1af89@rbox.co>
In-Reply-To: <20250626-splice-drop-unused-v2-0-3268fac1af89@rbox.co>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 David Ahern <dsahern@kernel.org>, Boris Pismenny <borisp@nvidia.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Ayush Sawal <ayush.sawal@chelsio.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>, 
 "D. Wythe" <alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>, 
 Wen Gu <guwen@linux.alibaba.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Since skb_splice_bits() does not accept the @flags argument anymore,
struct's field became unused. Remove it.

No functional change indented.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/unix/af_unix.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 235319a045a1238cf27791dfefa9e61b4a593551..1e3a4db1a96a57c84c199e30c164f66409b04be4 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2674,7 +2674,6 @@ struct unix_stream_read_state {
 	struct pipe_inode_info *pipe;
 	size_t size;
 	int flags;
-	unsigned int splice_flags;
 };
 
 #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
@@ -3082,7 +3081,6 @@ static ssize_t unix_stream_splice_read(struct socket *sock,  loff_t *ppos,
 		.socket = sock,
 		.pipe = pipe,
 		.size = size,
-		.splice_flags = flags,
 	};
 
 	if (unlikely(*ppos))

-- 
2.49.0


