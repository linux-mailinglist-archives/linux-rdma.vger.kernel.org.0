Return-Path: <linux-rdma+bounces-11664-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B36F5AE987F
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 10:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A8444A2D8F
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 08:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7A2295525;
	Thu, 26 Jun 2025 08:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="cw0cTVwd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549882D3EC5;
	Thu, 26 Jun 2025 08:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750926876; cv=none; b=BzLa2hJ7TqR+ehfzIr7ygxQBAW0Ylp8Ga9MBgGIHid1sNpvwkV5niZth9jjd/SLxsiQVO3LBylol8/lWps+Bk9rmEzw4GP+Ro4a8Fq5EKe6L37v/EInF0q0A2Ywj3um/jI+vZG4C7xNbQe7y/Naf2hUX0SrItCeIXoTL0hQNFEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750926876; c=relaxed/simple;
	bh=6M3+Kejjthb9PzX8o0duukEZx4ujkx8KuJdBNeQc0eo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ek4fQpMrbS/9dRt1/NT3J0idCcWUvRxwj4Aj84wXIAcYgXo+XAfWV/sXovoc2CI9ZNP0xIiRd2mOm4gGWFovZBL6bNpHTXg+f0rClmjd1U3bq2nHzxKE8awL3id4euUWT65oVTt0N9YnFrASUDwVTnw8q82Iu8HnwJ+3UhO2nX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=cw0cTVwd; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uUi3z-00GFjz-VI; Thu, 26 Jun 2025 10:34:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=AEEm1mh2ODaRsVEx0hztjw2fokITpGel2veEExfQMHw=; b=cw0cTVwdCvr1QBtD58GX26soss
	g+sG2dTmF+JBrCEHwqfr0J4Ik9g2/kYUZLkbsWJZcTLchBryeJBL+nn04tnw5rb3JGTURk+/jp8tH
	S+n1vKEuMJkfRk1SlX5wVoBJmUfxQ4GtNohG4SdWM3Gcqj/4kyNQ1Dw4KJYWocEwMwobbOFqwyyDY
	t+VoOrKf7L7R7NZgWSk1BumtA5rIO7m2X6ru/e/DMG1/wobAhhJOa6bhOmSZZvSni301x35B4ODJ6
	jOVbsdsjpdDWT9Z+myEFXJfFs/GxdAGqlUDC9Q4H1tdrw4rBYtmCcICC8IAdWs312S1JvW8lJZfME
	aaReF7gA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uUi3x-0002K1-BP; Thu, 26 Jun 2025 10:34:30 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uUi3Q-009Fh5-AL; Thu, 26 Jun 2025 10:33:56 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Thu, 26 Jun 2025 10:33:39 +0200
Subject: [PATCH net-next v2 6/9] net: splice: Drop nr_pages_max
 initialization
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250626-splice-drop-unused-v2-6-3268fac1af89@rbox.co>
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

splice_pipe_desc::nr_pages_max was initialized unnecessarily in commit
41c73a0d44c9 ("net: speedup skb_splice_bits()"). spd_fill_page() compares
spd->nr_pages against a constant MAX_SKB_FRAGS, which makes setting
nr_pages_max redundant.

Remove the assignment. No functional change intended.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/core/skbuff.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index c381a097aa6e087d1b5934f2d193a896a255bf83..b4f7843430a3f8f84aed387bf41ae761d97687ad 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3188,7 +3188,6 @@ int skb_splice_bits(struct sk_buff *skb, struct sock *sk, unsigned int offset,
 	struct splice_pipe_desc spd = {
 		.pages = pages,
 		.partial = partial,
-		.nr_pages_max = MAX_SKB_FRAGS,
 		.ops = &nosteal_pipe_buf_ops,
 		.spd_release = sock_spd_release,
 	};

-- 
2.49.0


