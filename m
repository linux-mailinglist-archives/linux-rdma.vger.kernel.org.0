Return-Path: <linux-rdma+bounces-1353-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B5F877129
	for <lists+linux-rdma@lfdr.de>; Sat,  9 Mar 2024 13:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1821281E04
	for <lists+linux-rdma@lfdr.de>; Sat,  9 Mar 2024 12:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634CA39FD1;
	Sat,  9 Mar 2024 12:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Hg6Y2d6t"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out203-205-251-59.mail.qq.com (out203-205-251-59.mail.qq.com [203.205.251.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596F9383B5;
	Sat,  9 Mar 2024 12:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709987274; cv=none; b=Ngv1T/lRWTNy3CoGC6f1Y0iTzN1L2AGTD9K/g1jUAn2rzxbQg7R502zWlu6M3LfPBABtY00tSnwpLaw50XoTsuxHK1aq9SO+ved2LRJTjmN6qrHJzDRvxTbzZUWwwej/hxPON5IxhIaEPwFg1Qd8w8f2PLuHT1fLrT0kw6YyEjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709987274; c=relaxed/simple;
	bh=yyHJI+i8YTw2Aotpj/dejaVqSVyw4wQdRc2NjI1BysY=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=NGYL2WXALSxQ8H7oSqSq4QHXIumhcSOAmd56+Ug9Ku5zL+Dz7aVinzMg9kv2FPiErQ9KZoIvolqkMrigFPvQTNij6lo3WZUmu1mPcQkKOGXOYLwQddhmIBWGW2lPlR+GWbrY2+8CN7nntURX0PsfmmK9+AX2NvpktLQ0ukGE20I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Hg6Y2d6t; arc=none smtp.client-ip=203.205.251.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709987258; bh=XEGyaJ+kCmmZhZFVWlD1MMdKR2X8OhuRS+vIOPo518c=;
	h=From:To:Cc:Subject:Date;
	b=Hg6Y2d6tTpKXk51dBycFCehLr9RpYTOLkpALRSlUcu69losoh/YqtPTyoiAamGDZV
	 kMXJhVIlZFZDG8zgiQR1tiuD0dDiJv+rjv6ofM7X3GlCRE5nnqhcWN++bNksfE5aEi
	 sx5nGerzAadhHBF3qB8r6BCAnENNqqaLsqgPqprE=
Received: from localhost.localdomain ([58.213.8.163])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 6E4874DF; Sat, 09 Mar 2024 20:27:36 +0800
X-QQ-mid: xmsmtpt1709987256tzodkmkla
Message-ID: <tencent_32C3AEB0599DF0A0010A862439636CDA2707@qq.com>
X-QQ-XMAILINFO: MmPNY57tR1XnXVRJMLsi2St93kTXMHZDv9XOtN6QXUCt17MhWfoztaSxFUWTti
	 NGvIQO/0OK+86B+DaF94LQqsTOQTyeDowjon/yqBcs7fVBZ8Tiaf5RPqRzLtJ7CQK/wIanfFqKiD
	 oZc47qHOQEEtTbpi6nyR5uMziAJJPjYrwhR9YbaEoXwUcvHieGse+IFlvinsw12hTFtL5Sq6ZxUc
	 aRNH1lIEO6KKQoZ7xnIY+i1gwqD62/SFUFRzLWgt+rmSnQ0qUWSKtj1UQPDW4goRts/hABqws1Us
	 ZdZ+oWk9RSl9cs7n40nGMELoz/+H0awRebUJT05j5hQE/WzZSW+JlqRHgh3S6aLNKtUTWC5OML9u
	 CpI8TjizY3U0btH6WACG4I5GGHtvqRt96+AOzRdhQksXNdpAp/dNHPGzsqTLmSwljMEe2hljE6Ro
	 9dWr+4KUXIVBXg5ZSgGus//CxhXykO25w7fWMNBQSBrflOb5fCmo2SIRi4wSEDoBXQvDa9Uz7/7J
	 P7ZvM5mzOggv08Xr7QX4P2uVHLgW4W9b/PK+hijvVvUFbIYbK5f/6Da2aHgguk2oEEMo5v/+9Rcg
	 NJn+Q4qPQbmDNxffzt1eWfBk7N71qY2yWvczxaw+wGq+X9bLr+KplQZaKuD/tTXk+45OZGjBTh0d
	 pPzZwXUz9bi1AkXClQcohAQSWg+sJX+sLvso7epWO0IjiVILPmaAUCRt/038hs6X5MNHQP/9T1M7
	 GCYHt8pqNkitiL7ave3mLZWUUS7afJrurhtz6Hwv7+gZUEMC7pFjKOjAq4+MqSoBvq4axQNDQhQi
	 NzI7fnXlFAcBUapiuMao3Dt71hau7LlPNpqbvhTVe2a1C74rw0iurPuJIBAbhn7AD0u0q4F+aJG8
	 H5HJE4C3Pkzxe93HGvrMHT352G5m31xd+DTMv3M5FjQVka6guH1/8CyOQ6124U6yjdLmiLT2wnVI
	 rz54xqcXRjRL3v9WvtRYA+/Fcmp5x0X2SvjVvVfgh2qcpQsoQ6xqOW/LPbLv4xQFaQGqWlqf3Fa7
	 4YToBChTCecAk2TSnO9hSId6HVLS30t/nhVqGfpxnW6QuVQNjPpsoVJ84DTZwnlAYZLKFBHQ==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: linke li <lilinke99@qq.com>
To: 
Cc: lilinke99@qq.com,
	Bernard Metzler <bmt@zurich.ibm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/siw: Reuse value read using READ_ONCE instead of re-reading it
Date: Sat,  9 Mar 2024 20:27:16 +0800
X-OQ-MSGID: <20240309122717.54920-1-lilinke99@qq.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In siw_orqe_start_rx, the orqe's flag in the if condition is read using
READ_ONCE, checked, and then re-read, voiding all guarantees of the
checks. Reuse the value that was read by READ_ONCE to ensure the
consistency of the flags throughout the function.

Signed-off-by: linke li <lilinke99@qq.com>
---
 drivers/infiniband/sw/siw/siw_qp_rx.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_qp_rx.c b/drivers/infiniband/sw/siw/siw_qp_rx.c
index ed4fc39718b4..f5f69de56882 100644
--- a/drivers/infiniband/sw/siw/siw_qp_rx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_rx.c
@@ -740,6 +740,7 @@ static int siw_orqe_start_rx(struct siw_qp *qp)
 {
 	struct siw_sqe *orqe;
 	struct siw_wqe *wqe = NULL;
+	u16 orqe_flags;
 
 	if (unlikely(!qp->attrs.orq_size))
 		return -EPROTO;
@@ -748,7 +749,8 @@ static int siw_orqe_start_rx(struct siw_qp *qp)
 	smp_mb();
 
 	orqe = orq_get_current(qp);
-	if (READ_ONCE(orqe->flags) & SIW_WQE_VALID) {
+	orqe_flags = READ_ONCE(orqe->flags);
+	if (orqe_flags & SIW_WQE_VALID) {
 		/* RRESP is a TAGGED RDMAP operation */
 		wqe = rx_wqe(&qp->rx_tagged);
 		wqe->sqe.id = orqe->id;
@@ -756,7 +758,7 @@ static int siw_orqe_start_rx(struct siw_qp *qp)
 		wqe->sqe.sge[0].laddr = orqe->sge[0].laddr;
 		wqe->sqe.sge[0].lkey = orqe->sge[0].lkey;
 		wqe->sqe.sge[0].length = orqe->sge[0].length;
-		wqe->sqe.flags = orqe->flags;
+		wqe->sqe.flags = orqe_flags;
 		wqe->sqe.num_sge = 1;
 		wqe->bytes = orqe->sge[0].length;
 		wqe->processed = 0;
-- 
2.39.3 (Apple Git-146)



