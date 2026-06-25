Return-Path: <linux-rdma+bounces-22459-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id u6bqImR4PGqioQgAu9opvQ
	(envelope-from <linux-rdma+bounces-22459-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jun 2026 02:37:56 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BB56C201D
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jun 2026 02:37:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22459-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22459-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 891A93041B86
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jun 2026 00:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2CD35AC32;
	Thu, 25 Jun 2026 00:36:29 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E490D35D615;
	Thu, 25 Jun 2026 00:36:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782347788; cv=none; b=Rz4CCbID1skf+to67wXBDKuTk3eSazG8EVZjnKVZDi8pOnGJ7pmUXnYSBd9f+5oZntK/+BqST4ei01QTgJEjHt68zGBZfY+8A+JZxWgFHd71UYSS8EDz4p3ySwG5uYCOn4bjeXIpjSJiSORzQxdKxODRgg5f8I+yYxGfB44ZlFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782347788; c=relaxed/simple;
	bh=QxduTaWA1gEwYCm2RFKBZG79WWWVm8ahM0sLSxK438A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G3opuJ7UkV6Wu6npZeKRH6zOVvR5IEMIVk2YIwD3XHeiUn522X/rZqy2+p/dvLxK93Sgqy6BZiB+XKCDlYuAXOI/tVJ4YR/Hl7hVIwPO4npq9RqaGtSn5BzfVRp+TA2fQkJ2CVvrmCLok3OLy/oI+PLeUtNbfo5mJj2VNJk+lpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-03 (Coremail) with SMTP id rQCowADXwaj_dzxqJOHCFQ--.4224S2;
	Thu, 25 Jun 2026 08:36:15 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Siva Reddy Kallam <siva.kallam@broadcom.com>
Cc: pengpeng@iscas.ac.cn,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/bng_re: return a timeout when firmware responses stall
Date: Thu, 25 Jun 2026 08:36:14 +0800
Message-ID: <20260625003614.27515-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowADXwaj_dzxqJOHCFQ--.4224S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw43Jw18JF45tF43Xw1kXwb_yoW8AF17pF
	W8K34YkFs5JF1093y0yrsY9FWYv3W8G39rC3yqg3sxAw1DJ3yIqrnYka4jqFyUAr97Cw42
	yFyrta98ur13uaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvj14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUeK
	sjUUUUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
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
	FORGED_RECIPIENTS(0.00)[m:siva.kallam@broadcom.com,m:pengpeng@iscas.ac.cn,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22459-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pengpeng@iscas.ac.cn,linux-rdma@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pengpeng@iscas.ac.cn,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,iscas.ac.cn:email,iscas.ac.cn:mid,iscas.ac.cn:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 02BB56C201D

__wait_for_resp() documents that it returns a non-zero error when a
firmware command does not complete, and bng_re_rcfw_send_message() already
marks the firmware as stalled when the helper returns -ENODEV.

However, the helper ignores wait_event_timeout() expiry.  If the response
slot remains in use after the timeout and after the polled CREQ service
attempt, the loop starts another full timeout period and can repeat
forever.

Return -ENODEV after a timed out wait that still has no response.  The
existing caller then marks FIRMWARE_STALL_DETECTED and returns
-ETIMEDOUT to the command issuer.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/infiniband/hw/bng_re/bng_fw.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/bng_re/bng_fw.c b/drivers/infiniband/hw/bng_re/bng_fw.c
index 50156c300..ab6a2d2e9 100644
--- a/drivers/infiniband/hw/bng_re/bng_fw.c
+++ b/drivers/infiniband/hw/bng_re/bng_fw.c
@@ -401,14 +401,15 @@ static int __wait_for_resp(struct bng_re_rcfw *rcfw, u16 cookie)
 {
 	struct bng_re_cmdq_ctx *cmdq;
 	struct bng_re_crsqe *crsqe;
+	unsigned long time_left;
 
 	cmdq = &rcfw->cmdq;
 	crsqe = &rcfw->crsqe_tbl[cookie];
 
 	do {
-		wait_event_timeout(cmdq->waitq,
-				   !crsqe->is_in_used,
-				   secs_to_jiffies(rcfw->max_timeout));
+		time_left = wait_event_timeout(cmdq->waitq,
+					       !crsqe->is_in_used,
+					       secs_to_jiffies(rcfw->max_timeout));
 
 		if (!crsqe->is_in_used)
 			return 0;
@@ -417,6 +418,9 @@ static int __wait_for_resp(struct bng_re_rcfw *rcfw, u16 cookie)
 
 		if (!crsqe->is_in_used)
 			return 0;
+
+		if (!time_left)
+			return -ENODEV;
 	} while (true);
 };
 
-- 
2.50.1 (Apple Git-155)


