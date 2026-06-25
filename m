Return-Path: <linux-rdma+bounces-22463-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id L1RlNMDHPGq6rwgAu9opvQ
	(envelope-from <linux-rdma+bounces-22463-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jun 2026 08:16:32 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B30C26C2F29
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jun 2026 08:16:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qq.com header.s=s201512 header.b=kPcFkaQm;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22463-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22463-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=qq.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FE173032F7B
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jun 2026 06:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577F62FB969;
	Thu, 25 Jun 2026 06:16:27 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684E427707;
	Thu, 25 Jun 2026 06:16:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782368187; cv=none; b=dsKzYM8xm7LrxNiUO/VHhobPIQuO7J5DXMLF9zdLSuM4jdUGY6gT1lR2GfadKuWKgGpUsw+qcXu0D4A+VIuyNyZ3B9jDchDvvof+rD740AKMB9YlEpkeY3G8452Ywr8i5DsINdxXLuWNkyXcc+usLr9A1qpazkewzcpVF+IFrmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782368187; c=relaxed/simple;
	bh=m94FP2S7yW5fcFsA/1C6pDNATxziBsG6xZzwrCPUfEk=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=oSeY76afBgVryPgS5PvH6Vmqo5ZJN/qUmvrHJIFLOK3ys1hBf0cr2SoTEAd31R5h2RO0uP9ImcCxkxlFecfJw+A6P9dhK0ybAFPNGvfFALySvsed60DJvyPBfHf8qNkOwJJYygR4FVcS40w0vSvEnNfJlOYhKfAypej92b+S/es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=kPcFkaQm; arc=none smtp.client-ip=162.62.57.87
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1782368178; bh=FR0mYuXCL/PqVO5fp2WD+k2ON797gpcyXnLtBL1DkLw=;
	h=From:To:Cc:Subject:Date;
	b=kPcFkaQmaz0ryN+RLTjhXDnGNuskJJFcYBQdr6d0vHvzogkl77FNskwPwkXJYExnv
	 mFvMRe3jA2jgmwpIZK5D8L1i8LHpOcFmT5WphbCroYY2Wfb2ZMLyAPXLavI+udLa10
	 OQZ87fSI944fkvxDKEML4lYaW+mshvKgjJ6RCtg4=
Received: from localhost.localdomain ([140.207.156.139])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 405A6882; Thu, 25 Jun 2026 14:16:05 +0800
X-QQ-mid: xmsmtpt1782368165trb3qp81x
Message-ID: <tencent_88CB6CA0A60CDD53B24EA5E3A865E6FF5A0A@qq.com>
X-QQ-XMAILINFO: NIZUVneQWgbc/1QrYg6pRNKre9mIZxubxyDuBND0nKqojKgutqtUNG277sjNRS
	 vDlaGrPH9o2UIg5UvaVWCB6iVHMZc+Tw2WkQqQ2o/FUJ/HKKHns6SgtOTFWFPchZmy7GjYOuyBFa
	 iYHnnVyn8TDrVo8lBxF5oPa6FYMp9K/M5FzMxmIdmpZz+5cLJXFfaAPbNjxyNipoXZWEAgQrlUYJ
	 RoNAa9SHyKCDSxFY0IOGMXY+g+eK9UmU+qdO/ztAMBq1Ziu++CMDsmlFGMdV5XfKll9Lfm62EW8x
	 YPAa0rk38MaaZWl7TmTLJlkWFaPaL1xRbl930GN67/xvyrdOoXGbtQ5tHAhz65UwgxkRXLQrpQYg
	 LvKC/37AIhJMWsusPyXABoeTlIs4BHSspxDwn28v1SLG743RK0v6O8lfZ2G1wL1Qd2/XmkZMzSGt
	 gthEVo/sp4wgmOD1UVqb18agH2YimMmPwdQ7G1AMOIyNKBl62exQiH56H8tNKPjHSFLvyKHEuYBz
	 +MMWl2hEFGcKwFMlMeitQeXxU1xEnLCk7/7GiR4W7y+GxNMDxZNRi2r9lkUZViD63kRYSbpbGzQN
	 IX3Gg6CYrL6G0NdWnU6twmWRCDq6j48HJUqE3d8kPm5QU1Z8EjJV0YMMkNsY81M4DyE0t1b3C7AH
	 u2QjIuKQHwrbIJ9eytJ9d4Nd+VvSG2WWHwNiXSx3SZbYQy4p8WRIYW4Xl5W3TF1pg1+JEoa0gk2V
	 KiPW2nv1/hnWR7OahtPiF6VW1aay0gjWUc7RXumkm2l39pcqwfvLIUnrz3sMlRumswQcBpf5KRvz
	 rtH6ReOeWLCADGIh5dzV7xV1Hih2qADkd6g2apx8afb5P5289w7hW2ayLuQ4uryE0idBboCrmlos
	 r50vAcyASCotaEGvMJtv5dbi7GiL6wn1IeKfZzQvw11WHzaHxVPSjPF6jNyuk0bOslMezVI2Bpxx
	 5megrjRW3KfA7r0kiJuslbXgYsIqHZqzT5M1BK6jFwI7TqPjozr/BPJuYf4aC4e+SxmhF0WP4IMy
	 KASmSS0C08cFMFSqGUtTjXf/lL24usQ9pFFaIMP536dLdLHqIRiRL+0ovdDCJGWFGGPGFeKQ==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Zhiwei Zhang <202275009@qq.com>
To: Zhu Yanjun <zyjzyj2000@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhiwei Zhang <202275009@qq.com>
Subject: [PATCH] RDMA/rxe: Check PDs for memory window binds
Date: Thu, 25 Jun 2026 14:16:02 +0800
X-OQ-MSGID: <20260625061602.88142-1-202275009@qq.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zyjzyj2000@gmail.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:202275009@qq.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[202275009@qq.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[qq.com];
	FREEMAIL_TO(0.00)[gmail.com,ziepe.ca,kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22463-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[qq.com:+];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[202275009@qq.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,qq.com];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qq.com:dkim,qq.com:email,qq.com:mid,qq.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B30C26C2F29

The IBTA Software Transport Verbs specification requires the QP,
Memory Window and Memory Region for a Bind Memory Window operation
to belong to the same HCA and protection domain.

rxe only checked the QP and MW protection domain for type 2 MWs.
Move the QP/MW PD check to the common bind path and also reject
binding an MW to an MR from a different PD.

Invalid bind requests continue to fail with IB_WC_MW_BIND_ERR.

Signed-off-by: Zhiwei Zhang <202275009@qq.com>
---
 drivers/infiniband/sw/rxe/rxe_mw.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index 379e65bfcd49..aa9371e4ccd5 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -72,13 +72,6 @@ static int rxe_check_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 			return -EINVAL;
 		}
 
-		/* C10-72 */
-		if (unlikely(qp->pd != to_rpd(mw->ibmw.pd))) {
-			rxe_dbg_mw(mw,
-				"attempt to bind type 2 MW with qp with different PD\n");
-			return -EINVAL;
-		}
-
 		/* o10-37.2.40 */
 		if (unlikely(!mr || wqe->wr.wr.mw.length == 0)) {
 			rxe_dbg_mw(mw,
@@ -87,10 +80,21 @@ static int rxe_check_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 		}
 	}
 
-	/* remaining checks only apply to a nonzero MR */
+	/* C10-72 */
+	if (unlikely(qp->pd != rxe_mw_pd(mw))) {
+		rxe_dbg_mw(mw, "attempt to bind MW with qp with different PD\n");
+		return -EINVAL;
+	}
+
 	if (!mr)
 		return 0;
 
+	/* remaining checks only apply to a nonzero MR */
+	if (unlikely(qp->pd != mr_pd(mr))) {
+		rxe_dbg_mw(mw, "attempt to bind MW to MR with different PD\n");
+		return -EINVAL;
+	}
+
 	if (unlikely(mr->access & IB_ZERO_BASED)) {
 		rxe_dbg_mw(mw, "attempt to bind MW to zero based MR\n");
 		return -EINVAL;
-- 
2.51.0


