Return-Path: <linux-rdma+bounces-22090-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MBzfMOKkKWoDbQMAu9opvQ
	(envelope-from <linux-rdma+bounces-22090-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 19:54:42 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C19166C12A
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 19:54:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22090-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22090-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5197330558B4
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 17:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACE134D93B;
	Wed, 10 Jun 2026 17:54:36 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F0E349CCD;
	Wed, 10 Jun 2026 17:54:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781114076; cv=none; b=BA41LXWFIo2J0rTCwD7GTjY//o4iP7ZufAJx2rFeDeaPU11Df8/6oPkJgG4+kq/uN1CEg3W+GCVtDatBjcxMQ9s8ygOKHkjIeoKWvEtm5jV/xfypQFt2D2DNH/0KOqz93yNpJoTaATz35JHAUH3e04vgQ2/fAldKfSmkyE5A4Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781114076; c=relaxed/simple;
	bh=4bQw0v51lD5neyWw5XtpGHO9eOOSvY1l7333tvj/AmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YbyL/72Bl/Cv9AzY8+Y++oJsPPEkGxncRLmteKhEduVjMSXxnp7MfZVy93NIWTvRMaH6quNyoovV3CmxYUK4StSC6GKVzBdtQ3AB4ZfRrRXrNdD+7gd/S+FGa0D8Xowmk1EUgf33ShdLpLNgvtSfFR23KMPhZd3NmY1DjDwlLEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=13.76.78.106
Received: from enjou-Legion-Y7000P-2019 (unknown [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowACnwLrIpClquC14AA--.36642S3;
	Thu, 11 Jun 2026 01:54:20 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org
Cc: alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	wenjia@linux.ibm.com,
	mjambigi@linux.ibm.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	ubraun@linux.ibm.com,
	stefan.raspl@linux.ibm.com,
	davem@davemloft.net,
	yuantan098@gmail.com,
	zcliangcn@gmail.com,
	bird@lzu.edu.cn,
	lx24@stu.ynu.edu.cn,
	d4n.for.sec@gmail.com,
	n05ec@lzu.edu.cn
Subject: [PATCH net 1/1] net: smc: fix splice entry lifetime imbalance in smc_rx_splice
Date: Thu, 11 Jun 2026 01:54:11 +0800
Message-ID: <192d1b44ed358ca143f44ef167d14153bccc51e9.1781097957.git.d4n.for.sec@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1781097957.git.d4n.for.sec@gmail.com>
References: <cover.1781097957.git.d4n.for.sec@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowACnwLrIpClquC14AA--.36642S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZw1rZF4xCry3KrWUWw48JFb_yoW5tF4UpF
	W7GwsFyF1kCrn0grs7Kr4q9r4S9asxKr4UWr48Kw4fZFn3K340qa40gryIvrn8AFW0krWS
	9F40qFnrJF45AFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB21xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
	jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzx
	vE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	JVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x02
	62kKe7AKxVW8ZVWrXwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaV
	Av8VW8GwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRMXdjDUUUU
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQEOCWopHlEJggAAsA
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22090-lists,linux-rdma=lfdr.de];
	DMARC_NA(0.00)[lzu.edu.cn];
	FORGED_RECIPIENTS(0.00)[m:linux-rdma@vger.kernel.org,m:linux-s390@vger.kernel.org,m:netdev@vger.kernel.org,m:alibuda@linux.alibaba.com,m:dust.li@linux.alibaba.com,m:sidraya@linux.ibm.com,m:wenjia@linux.ibm.com,m:mjambigi@linux.ibm.com,m:tonylu@linux.alibaba.com,m:guwen@linux.alibaba.com,m:ubraun@linux.ibm.com,m:stefan.raspl@linux.ibm.com,m:davem@davemloft.net,m:yuantan098@gmail.com,m:zcliangcn@gmail.com,m:bird@lzu.edu.cn,m:lx24@stu.ynu.edu.cn,m:d4n.for.sec@gmail.com,m:n05ec@lzu.edu.cn,m:d4nforsec@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[n05ec@lzu.edu.cn,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.alibaba.com,linux.ibm.com,davemloft.net,gmail.com,lzu.edu.cn,stu.ynu.edu.cn];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,ynu.edu.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7C19166C12A

From: Daming Li <d4n.for.sec@gmail.com>

smc_rx_splice() hands candidate pages to splice_to_pipe() without taking
references for the lifetime of each splice entry first. That breaks the
splice ownership contract in the VM-backed RMB path.

splice_to_pipe() drops unqueued entries through spd_release(), while
queued entries are later dropped through the pipe buffer release
callback. The current code only tries to take page references after the
splice succeeds, and it derives the number of queued VM pages from a
mutated offset value. This can underflow page refcounts and trigger a
use-after-free. It also leaves the socket lifetime imbalanced in the
multi-page VM case, where one sock_hold() can be followed by multiple
sock_put() calls.

Fix this by taking the page and socket references for every candidate
splice entry before calling splice_to_pipe(), and by releasing the
matching private state, page reference, and socket reference from
smc_rx_spd_release() for entries that never get queued. This makes the
SMC splice path follow the normal splice lifetime rules and removes the
broken post-splice VM page counting entirely.

Fixes: 9014db202cb7 ("smc: add support for splice()")
Cc: stable@vger.kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Assisted-by: Codex:GPT-5.4
Co-developed-by: Liu Xiao <lx24@stu.ynu.edu.cn>
Signed-off-by: Liu Xiao <lx24@stu.ynu.edu.cn>
Signed-off-by: Daming Li <d4n.for.sec@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
 net/smc/smc_rx.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/net/smc/smc_rx.c b/net/smc/smc_rx.c
index c1d9b923938d..88aee0d93597 100644
--- a/net/smc/smc_rx.c
+++ b/net/smc/smc_rx.c
@@ -150,18 +150,23 @@ static const struct pipe_buf_operations smc_pipe_ops = {
 static void smc_rx_spd_release(struct splice_pipe_desc *spd,
 			       unsigned int i)
 {
+	struct smc_spd_priv *priv = (struct smc_spd_priv *)spd->partial[i].private;
+	struct sock *sk = &priv->smc->sk;
+
+	kfree(priv);
 	put_page(spd->pages[i]);
+	sock_put(sk);
 }
 
 static int smc_rx_splice(struct pipe_inode_info *pipe, char *src, size_t len,
 			 struct smc_sock *smc)
 {
 	struct smc_link_group *lgr = smc->conn.lgr;
-	int offset = offset_in_page(src);
 	struct partial_page *partial;
 	struct splice_pipe_desc spd;
 	struct smc_spd_priv **priv;
 	struct page **pages;
+	int offset = offset_in_page(src);
 	int bytes, nr_pages;
 	int i;
 
@@ -209,6 +214,10 @@ static int smc_rx_splice(struct pipe_inode_info *pipe, char *src, size_t len,
 			offset = 0;
 		}
 	}
+	for (i = 0; i < nr_pages; i++) {
+		get_page(pages[i]);
+		sock_hold(&smc->sk);
+	}
 	spd.nr_pages_max = nr_pages;
 	spd.nr_pages = nr_pages;
 	spd.pages = pages;
@@ -217,16 +226,8 @@ static int smc_rx_splice(struct pipe_inode_info *pipe, char *src, size_t len,
 	spd.spd_release = smc_rx_spd_release;
 
 	bytes = splice_to_pipe(pipe, &spd);
-	if (bytes > 0) {
-		sock_hold(&smc->sk);
-		if (!lgr->is_smcd && smc->conn.rmb_desc->is_vm) {
-			for (i = 0; i < PAGE_ALIGN(bytes + offset) / PAGE_SIZE; i++)
-				get_page(pages[i]);
-		} else {
-			get_page(smc->conn.rmb_desc->pages);
-		}
+	if (bytes > 0)
 		atomic_add(bytes, &smc->conn.splice_pending);
-	}
 	kfree(priv);
 	kfree(partial);
 	kfree(pages);
-- 
2.34.1


