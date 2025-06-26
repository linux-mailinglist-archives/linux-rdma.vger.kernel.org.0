Return-Path: <linux-rdma+bounces-11665-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A66AE9885
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 10:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BDC53AC71C
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 08:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD9B2D3EC9;
	Thu, 26 Jun 2025 08:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="l5ygA6g2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A176229550C
	for <linux-rdma@vger.kernel.org>; Thu, 26 Jun 2025 08:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750926877; cv=none; b=W14eJ4LvrVLuVFWpUgjmX92S8IqQB3w3GpZX9Z95H/+5sTBEwmUkWu7054Ae//fu+XA0VvXi3Yh4DzDUGDvQ+a/A8taFaZkr+HxyChxxdSHBE9whS0LRy4yO5Q1S+E4toVhEdJW+wlrGqw0ckEUtr2pKpPdPaChONikaw/QtNLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750926877; c=relaxed/simple;
	bh=iIcOqxh36MlIjbCh3lXRjInonBMTOM+CdRCsU2ecnRE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ua3pdiIDXpMnWycCeDPsZxACcrBgze66OFcgm+v2vutcTsBIPAUhrPPnaVQQG/ycgUMOiEVNxw7W5W7XjaKiFyxxRynpgNZITmCU6sbU+418TWG4lXqkO7U2X6D29GtMVaPWQDCGBYIf2pKl39v4CcUQUjevkGN8gNafrhd+niQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=l5ygA6g2; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uUi3y-00GcHN-EU; Thu, 26 Jun 2025 10:34:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=K9csgMrzkQzumdDMFSj0XkVwfFmUy6WQ+scu2JDE5Vs=; b=l5ygA6g2+iaG9Gff8/MltMhoeN
	9OdFm6h7tOcWplXvWX8e4GwssSAG89koLcqoBHJegiCw04on96Fg0uh5emvu4iWZ+JXMr7AHe2Xuv
	jg0dju8Jyr5KNYDn50V5eQYG3MG9gz3htTiRhloCPRfjY/s8aWYva7IjIopm4GrSpKVoxL0LhcujI
	VWptib+CfKO49+DbUDYWUG0Vh8LxqADOV/LtFcGTvB7z1lSIUoduFi1gwGcx1ovF+v9KyfoBuDK6F
	IGaG6GWvX7lvamy8LfB9Ro+EKB5ImBfAprkkCLw47bH5yfpUoFPBTeAqfottJvCIf4lg8cqWFdY8z
	KMjlG1dQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uUi3x-0002Jy-3H; Thu, 26 Jun 2025 10:34:29 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uUi3R-009Fh5-Af; Thu, 26 Jun 2025 10:33:57 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Thu, 26 Jun 2025 10:33:40 +0200
Subject: [PATCH net-next v2 7/9] net/smc: Drop nr_pages_max initialization
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250626-splice-drop-unused-v2-7-3268fac1af89@rbox.co>
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

splice_pipe_desc::nr_pages_max was initialized unnecessarily in
commit b8d199451c99 ("net/smc: Allow virtually contiguous sndbufs or RMBs
for SMC-R"). Struct's field is unused in this context.

Remove the assignment. No functional change intended.

Suggested-by: Simon Horman <horms@kernel.org>
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


