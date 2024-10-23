Return-Path: <linux-rdma+bounces-5483-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AE89ACCD9
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Oct 2024 16:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B34A8281CFE
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Oct 2024 14:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3F0202F6F;
	Wed, 23 Oct 2024 14:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="la2gk8mx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BCA20263A;
	Wed, 23 Oct 2024 14:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693903; cv=none; b=cKUV7gF9fXf/EenXgeWcbVp6Qfp1ehjpOAC2bSNFZoEZ9vpKMK6V3pvfCdrjtBz118jwBU2KlSKoAoDj0OE+HH2ap0EYmAqB6vQDPfQNqEE+rnP+C6ZcY+jMho+jpvKiQQkjGiaMDxeJNMvf88zOZyfqzAR1nOQLVLEOqIMY51I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693903; c=relaxed/simple;
	bh=s4++R1mlGf5iuA+qO5foJSvwbg1b8NPDNgpsztDq5vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H0OXJACa2+WafgW2Z9FS6jmtFYaFngeHfovMKbH6ZEv3gxjSG8glnbaeWlKFo7BtFJNXewRUTtFe70KFfELx+PFYmhtzJHvv485dJa2InO2oezX7l+TuVw2p06zt+F44VA8AbrNO7bvvRDn1oQoXzvwR3TeiyPnf3hqUQNVog+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=la2gk8mx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00CD7C4CEE5;
	Wed, 23 Oct 2024 14:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693902;
	bh=s4++R1mlGf5iuA+qO5foJSvwbg1b8NPDNgpsztDq5vo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=la2gk8mxbvLECVpHfpS6HjS5qhyI2V0HUjURfC39sjDVoRvSGt1p8KDa+7w9NJhKS
	 b7KNZ6jojZbIrhptWMmI6WlICs/J4kfYYDCfbLqoDal5ROhvRDLlYldjynjQlswr+5
	 MVktQg51TSSKPNRPZM3jKFhj4qV7kJmdW42shL8u6GietoAYTxFJbmm5qE2cUNhQpx
	 WE4RpRDPVttqXgNwUd3zcBt4MUbVdTSHIB8ekPFlwbuL+whybuDDOHzoRKCsLyYm0x
	 syq0NDTkR7PwbwKkEIr7Z9UeooU9VCbQkJFa+uzZUGU1KVNBaJWcrbea8RBfUOu3LN
	 Mxva3MvNnecig==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Showrya M N <showrya@chelsio.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Sasha Levin <sashal@kernel.org>,
	bmt@zurich.ibm.com,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 16/23] RDMA/siw: Add sendpage_ok() check to disable MSG_SPLICE_PAGES
Date: Wed, 23 Oct 2024 10:31:00 -0400
Message-ID: <20241023143116.2981369-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023143116.2981369-1-sashal@kernel.org>
References: <20241023143116.2981369-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.58
Content-Transfer-Encoding: 8bit

From: Showrya M N <showrya@chelsio.com>

[ Upstream commit 4e1e3dd88a4cedd5ccc1a3fc3d71e03b70a7a791 ]

While running ISER over SIW, the initiator machine encounters a warning
from skb_splice_from_iter() indicating that a slab page is being used in
send_page. To address this, it is better to add a sendpage_ok() check
within the driver itself, and if it returns 0, then MSG_SPLICE_PAGES flag
should be disabled before entering the network stack.

A similar issue has been discussed for NVMe in this thread:
https://lore.kernel.org/all/20240530142417.146696-1-ofir.gal@volumez.com/

  WARNING: CPU: 0 PID: 5342 at net/core/skbuff.c:7140 skb_splice_from_iter+0x173/0x320
  Call Trace:
   tcp_sendmsg_locked+0x368/0xe40
   siw_tx_hdt+0x695/0xa40 [siw]
   siw_qp_sq_process+0x102/0xb00 [siw]
   siw_sq_resume+0x39/0x110 [siw]
   siw_run_sq+0x74/0x160 [siw]
   kthread+0xd2/0x100
   ret_from_fork+0x34/0x40
   ret_from_fork_asm+0x1a/0x30

Link: https://patch.msgid.link/r/20241007125835.89942-1-showrya@chelsio.com
Signed-off-by: Showrya M N <showrya@chelsio.com>
Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/sw/siw/siw_qp_tx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c b/drivers/infiniband/sw/siw/siw_qp_tx.c
index 60b6a41359611..feae920784be8 100644
--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
@@ -337,6 +337,8 @@ static int siw_tcp_sendpages(struct socket *s, struct page **page, int offset,
 			msg.msg_flags &= ~MSG_MORE;
 
 		tcp_rate_check_app_limited(sk);
+		if (!sendpage_ok(page[i]))
+			msg.msg_flags &= ~MSG_SPLICE_PAGES;
 		bvec_set_page(&bvec, page[i], bytes, offset);
 		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, size);
 
-- 
2.43.0


