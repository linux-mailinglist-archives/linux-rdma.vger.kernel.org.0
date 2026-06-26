Return-Path: <linux-rdma+bounces-22493-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yv6KDmaWPmprIgkAu9opvQ
	(envelope-from <linux-rdma+bounces-22493-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jun 2026 17:10:30 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE62D6CE580
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jun 2026 17:10:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22493-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22493-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DEBC230DFFAD
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jun 2026 15:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D21737AA81;
	Fri, 26 Jun 2026 15:05:23 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B93372058;
	Fri, 26 Jun 2026 15:05:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782486322; cv=none; b=vB0RPJgXR0qHbWRBh+QDX7zsZRVyrQY4ALutPRip6LpUdKI5MtJXBzit+z00UyGcsNUQwjMFefkLU+X0+3cf3s+5Ow+A/Y6F1HkdsZzF7xDTbHGGDLyfFMmNyQay7PM8g9xyVvRdBVyOqLqfpsb44RfE5sDZu5hNbNcaOB7evxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782486322; c=relaxed/simple;
	bh=cfg60twu84mX2v3dZUQeQgTuXAJSzfa0guMyntcP4V0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N/zxcb7Nj4jGBlTMr9gOVy0Bta7ElREjfkkqf8c6cR/+4YBXBF+Q0vAshfV7Wtrx8NQLxBGXv3EVYfDM3Ac8FCh00+agFHwhiCGUmyAqgKjrMV1suGbXhBqPi9bcyienPG+Ai96Z+1qm4i6R84A2apg161H6MIU776+zc3CXy+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-01 (Coremail) with SMTP id qwCowAAnzNQnlT5qeGZrAw--.16679S2;
	Fri, 26 Jun 2026 23:05:12 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] fix: infiniband/rxe: check_rkey: fix refcount underflow due to unchecked   rxe_get return value
Date: Fri, 26 Jun 2026 23:05:11 +0800
Message-Id: <20260626150511.50084-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAnzNQnlT5qeGZrAw--.16679S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar4fJF15Xry5XFyrWry8Zrb_yoW8JF43pr
	WfK34Ykr1fXay7ZanFyr1UXFZ0ka4DtFyDKa9293srZr15Gr47WFnI9FW3Wr4kAFyrA3ya
	qF1jyan5Ga1rGFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_
	Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU2Q6
	JUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRMKA2o+iCglxgAAsE
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22493-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[vulab@iscas.ac.cn,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:vulab@iscas.ac.cn,s:lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vulab@iscas.ac.cn,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,iscas.ac.cn:mid,iscas.ac.cn:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DE62D6CE580

rxe_get is a conditional get (kref_get_unless_zero) that returns 0 when
  the object's refcount is already zero. In check_rkey, the return value of
  rxe_get(mr) is ignored. If rxe_get fails (returns 0), the code continues
  to use mr without a valid reference, and error paths will call
  rxe_put(mr) on an unheld reference, causing a refcount underflow.

Check the return value of rxe_get and bail out with an error when it fails.

Cc: stable@vger.kernel.org
Fixes: 290c4a902b79 ("RDMA/rxe: Fix \"Replace mr by rkey in responder resources\"")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/infiniband/sw/rxe/rxe_resp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 9cb2f6fbf2dd..0c3f3930b494 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -514,7 +514,12 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 		if (mw->access & IB_ZERO_BASED)
 			qp->resp.offset = mw->addr;
 
-		rxe_get(mr);
+		if (!rxe_get(mr)) {
+			rxe_put(mw);
+			mw = NULL;
+			state = get_rkey_violation_state(pkt);
+			goto err;
+		}
 		rxe_put(mw);
 		mw = NULL;
 	} else {
-- 
2.39.5 (Apple Git-154)


