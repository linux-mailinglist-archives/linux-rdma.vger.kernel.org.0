Return-Path: <linux-rdma+bounces-11832-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A49AF59CD
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jul 2025 15:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F64C4401AE
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jul 2025 13:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D5C287273;
	Wed,  2 Jul 2025 13:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="ocbLthwZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA2D2609EC;
	Wed,  2 Jul 2025 13:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751463531; cv=none; b=dAdw4hvxTUHKtdE4AJwSaaTLaLl+JxxmoifnqYlH5gfwP1mArJAeKW0J/LoucZr+8XVD0eXS6PAqS7x6Xap/8y0LyA4ZGc4rIjSkJFOazP6sGeqUgkiEJES4hGBhMVR24pd9N9IloEDq26tB6zAf2EXiqUYE+ZAFfwSiw+CFa/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751463531; c=relaxed/simple;
	bh=8R94xR6ywX8zi8DpzNLXc8nXc/KWdO8qaX7Bl2FN4Tw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HQwu1n2GmOMAbqpk2RSwHJCwi57mCCNKiPFyKF0H3YybAkXi/cGoVqyXFm4wZZLzt7zP5y+XCMCBvYPw0ZSLnMS7dGvTWI8sBl09Jau0WZv4RcwVkSS6y0HOrtvaO1+5ytBasSObo2x3j/mZCszBSHVOnQ5UHq/qyw/ry+3qFUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=ocbLthwZ; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uWxfV-00GcGe-IS; Wed, 02 Jul 2025 15:38:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=0+sqAtVYy6ujOD9J5/0Ld0QUGlNJqgikFRG6V5SJvFU=; b=ocbLthwZ3WvAfsAoRevTvAq6Om
	eU6JCUy9lWbirNXAxK/XS4XK62scLwzv3GIemA9z7tqDZLzmGc4e7aHbymeoaFulG3b5hTwUynM6t
	Qh4ukIW9Mx8o+/h7VSPuT1fKtIa78kICyTF+EF/IwqKonR3OFxGDmCJ2TyaJT2Kcp1XIqBTuien2p
	Nwny/S+/S8TKHUG8J8UGnaPMgZZ+w40jEZQumGCPIZdWO68tN6rE3hjKLw5Of9kZktd6NSmGmMmqt
	ey//7BNg3TIx2ACBS6YEJ5ZgFWunnk5jJQC7F3wJwOa0v+R/WiGaV1fcuPSBukGhFr9vI4jAP7k0n
	on7yb4bA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uWxfV-0006Ef-2W; Wed, 02 Jul 2025 15:38:33 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uWxfG-009LCR-1h; Wed, 02 Jul 2025 15:38:18 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Wed, 02 Jul 2025 15:38:10 +0200
Subject: [PATCH net-next v3 4/6] net/smc: Drop nr_pages_max initialization
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-splice-drop-unused-v3-4-55f68b60d2b7@rbox.co>
References: <20250702-splice-drop-unused-v3-0-55f68b60d2b7@rbox.co>
In-Reply-To: <20250702-splice-drop-unused-v3-0-55f68b60d2b7@rbox.co>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Ayush Sawal <ayush.sawal@chelsio.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 David Ahern <dsahern@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, Wenjia Zhang <wenjia@linux.ibm.com>, 
 Jan Karcher <jaka@linux.ibm.com>, "D. Wythe" <alibuda@linux.alibaba.com>, 
 Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
 Michal Luczaj <mhal@rbox.co>, Sidraya Jayagond <sidraya@linux.ibm.com>, 
 Dust Li <dust.li@linux.alibaba.com>
X-Mailer: b4 0.14.2

splice_pipe_desc::nr_pages_max was initialized unnecessarily in
commit b8d199451c99 ("net/smc: Allow virtually contiguous sndbufs or RMBs
for SMC-R"). Struct's field is unused in this context.

Remove the assignment. No functional change intended.

Suggested-by: Simon Horman <horms@kernel.org>
Reviewed-by: Sidraya Jayagond <sidraya@linux.ibm.com>
Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/smc/smc_rx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/smc/smc_rx.c b/net/smc/smc_rx.c
index e7f1134453ef40dd81a9574d6df4ead95acd8ae5..bbba5d4dc7eb0dbb31a9800023b0caab33e87842 100644
--- a/net/smc/smc_rx.c
+++ b/net/smc/smc_rx.c
@@ -202,7 +202,6 @@ static int smc_rx_splice(struct pipe_inode_info *pipe, char *src, size_t len,
 			offset = 0;
 		}
 	}
-	spd.nr_pages_max = nr_pages;
 	spd.nr_pages = nr_pages;
 	spd.pages = pages;
 	spd.partial = partial;

-- 
2.49.0


