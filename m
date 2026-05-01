Return-Path: <linux-rdma+bounces-19818-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMneHjr982nP9QEAu9opvQ
	(envelope-from <linux-rdma+bounces-19818-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 01 May 2026 03:09:14 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1EE4A9792
	for <lists+linux-rdma@lfdr.de>; Fri, 01 May 2026 03:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 217223022900
	for <lists+linux-rdma@lfdr.de>; Fri,  1 May 2026 01:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4557728C035;
	Fri,  1 May 2026 01:09:11 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E2C1D89EF;
	Fri,  1 May 2026 01:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777597751; cv=none; b=qNGuvDWXsq11n3JfDJTDJwGNdhDZwpF9F8z1GAegYEu9xwhxkJBvOpOMhAYM6qAxWDNa1bhIgW5Y8vdUIhjYYysChBWGHYB5VSUAVKE7+/IQo7wDCudEReHVWVzdDb6bNNr3jVbtQj3/nRM/HBy2Jb+SNS2HdMWj4PD947Xk9XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777597751; c=relaxed/simple;
	bh=BMyjissjNhljnO/Sgml67txfSPuZY0gxsDs4aRf+6NE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nS1dy0zdaoH7K2XV8WBQ50kIyGYHP3nAImUyh7Ot4ZS4jn1CBoABKQ0qkLZ03r/KzWXNv5eydPvq7X/JKzAJ91lJsG2CT6MOpYtzDP1drPIWZ1EypQ6XdL+IvSP4vFX5qYVzGhRCORoh0O3D1z3Z2L+/ejUGNziJ2rVrbGXarQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019.coin-barley.ts.net (unknown [172.23.56.36])
	by app2 (Coremail) with SMTP id zQmowAAXr4Uc_fNpKz9IAA--.31177S3;
	Fri, 01 May 2026 09:08:45 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com
Cc: achender@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	santosh.shilimkar@oracle.com,
	sowmini.varadhan@oracle.com,
	willemb@google.com,
	yuantan098@gmail.com,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	bird@lzu.edu.cn,
	lx24@stu.ynu.edu.cn,
	tonanli66@gmail.com,
	n05ec@lzu.edu.cn
Subject: [PATCH net 1/1] net/rds: handle zerocopy send cleanup before the message is queued
Date: Fri,  1 May 2026 09:08:44 +0800
Message-ID: <d2ea98a6313d5467bac00f7c9fef8c7acddb9258.1777550074.git.tonanli66@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1777550074.git.tonanli66@gmail.com>
References: <cover.1777550074.git.tonanli66@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQmowAAXr4Uc_fNpKz9IAA--.31177S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXr1ruw4UWrWUuryfGFy5twb_yoW5Xw18p3
	4fGrnYkFWkZrW7Ca10gr40vF1UWrn3GryDG3sYyay7Jws0qF1fJrWvya47XFW8AFyru3yr
	Zr4jqF1q9w4DZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBj1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW0oVCq3wA2z4x0Y4vEx4A2
	jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
	x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWU
	GwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kK
	e7AKxVW8ZVWrXwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8V
	W8GwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRpOJnUUUUU=
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQEOCWnzF2OIWwAAs6
X-Rspamd-Queue-Id: 5C1EE4A9792
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	SEM_URIBL(3.50)[ynu.edu.cn:email];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,oracle.com,gmail.com,lzu.edu.cn,stu.ynu.edu.cn];
	TAGGED_FROM(0.00)[bounces-19818-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[lzu.edu.cn];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.915];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	R_DKIM_NA(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c04:e001:36c::/64:c];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[19];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

From: Nan Li <tonanli66@gmail.com>

A zerocopy send can fail after user pages have been pinned but before
the message is attached to the sending socket.

The purge path currently infers zerocopy state from rm->m_rs, so an
unqueued message can be cleaned up as if it owned normal payload pages.
However, zerocopy ownership is really determined by the presence of
op_mmp_znotifier, regardless of whether the message has reached the
socket queue.

Capture op_mmp_znotifier up front in rds_message_purge() and use it as
the cleanup discriminator. If the message is already associated with a
socket, keep the existing completion path. Otherwise, drop the pinned
page accounting directly and release the notifier before putting the
payload pages.

This keeps early send failure cleanup consistent with the zerocopy
lifetime rules without changing the normal queued completion path.

Fixes: 0cebaccef3ac ("rds: zerocopy Tx support.")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Co-developed-by: Xiao Liu <lx24@stu.ynu.edu.cn>
Signed-off-by: Xiao Liu <lx24@stu.ynu.edu.cn>
Signed-off-by: Nan Li <tonanli66@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
 net/rds/message.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/net/rds/message.c b/net/rds/message.c
index eaa6f22601a4..25fedcb3cd00 100644
--- a/net/rds/message.c
+++ b/net/rds/message.c
@@ -131,24 +131,34 @@ static void rds_rm_zerocopy_callback(struct rds_sock *rs,
  */
 static void rds_message_purge(struct rds_message *rm)
 {
+	struct rds_znotifier *znotifier;
 	unsigned long i, flags;
-	bool zcopy = false;
+	bool zcopy;
 
 	if (unlikely(test_bit(RDS_MSG_PAGEVEC, &rm->m_flags)))
 		return;
 
 	spin_lock_irqsave(&rm->m_rs_lock, flags);
+	znotifier = rm->data.op_mmp_znotifier;
+	rm->data.op_mmp_znotifier = NULL;
+	zcopy = !!znotifier;
+
 	if (rm->m_rs) {
 		struct rds_sock *rs = rm->m_rs;
 
-		if (rm->data.op_mmp_znotifier) {
-			zcopy = true;
-			rds_rm_zerocopy_callback(rs, rm->data.op_mmp_znotifier);
+		if (znotifier) {
+			rds_rm_zerocopy_callback(rs, znotifier);
 			rds_wake_sk_sleep(rs);
-			rm->data.op_mmp_znotifier = NULL;
 		}
 		sock_put(rds_rs_to_sk(rs));
 		rm->m_rs = NULL;
+	} else if (znotifier) {
+		/*
+		 * Zerocopy can fail before the message is queued on the
+		 * socket, so there is no rs to carry the notification.
+		 */
+		mm_unaccount_pinned_pages(&znotifier->z_mmp);
+		kfree(rds_info_from_znotifier(znotifier));
 	}
 	spin_unlock_irqrestore(&rm->m_rs_lock, flags);
 
-- 
2.43.0


