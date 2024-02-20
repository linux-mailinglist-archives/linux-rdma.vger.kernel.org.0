Return-Path: <linux-rdma+bounces-1060-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D35885B378
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Feb 2024 08:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ACA328260C
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Feb 2024 07:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD425BAC3;
	Tue, 20 Feb 2024 07:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jBdmAsHB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BAC5B673;
	Tue, 20 Feb 2024 07:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708412528; cv=none; b=JMflbdXhAB49F87X9q7qrw5HMKy/GYsy5F08a4wNwG4+zyy36HJ6brgGgiKGJdE1AGrdpsPMEaWCMV6uzzpr+jIZDi4DgCm36jtZXiCeGBp1i8TpyaO7kBKH+VTYAGr4K7961TBqyYUqWRI7QYYsrnfjMHmeBfcJT9rT8YMlM9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708412528; c=relaxed/simple;
	bh=AR2vZ2Pk14pFkuCI5pWdkzga/sx98D1kPbpMRsNxMFM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=O6OvgfPYQCoTGzT7cmX0J8jvID7Q6UiYkCPrYSygaeUAAJadCTb1HmH/mjAS83c1UcfcVbeTv6jMUs4XCZSk9q6zsNfGR3zxAJmLdvnpS057PXOrYz0Nm5Obys52PD15OAG1v4moMg0O7y+v98MWOPduV5ueFiQgM3L6xPrZlCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jBdmAsHB; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708412518; h=From:To:Subject:Date:Message-Id;
	bh=winjUbtGrzKRyXsXM3mIb5ppf4C3A0xLqD6cwkkdcKY=;
	b=jBdmAsHBRzbTIxScnrr3aZGpbMoOzt9spz4+sB4eQjwqhMnwWB9dC9IN3fh9JjQP0feuXFgmu8FZcmxNjTHH/FdJx4PpBl8wOW+FFhZCb5JXqSQJjfN6CAm0tbNuE39Ar5Ffv/c3J1vAyVaGjDbUGEdh+2GHS7mlU6wDMhtYlX0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W0vuXfh_1708412516;
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0W0vuXfh_1708412516)
          by smtp.aliyun-inc.com;
          Tue, 20 Feb 2024 15:01:56 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com>
To: kgraul@linux.ibm.com,
	wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	wintera@linux.ibm.com,
	guwen@linux.alibaba.com
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	tonylu@linux.alibaba.com,
	pabeni@redhat.com,
	edumazet@google.com
Subject: [RFC net-next 11/20] net/smc: make __smc_accept can return the new accepted sock
Date: Tue, 20 Feb 2024 15:01:36 +0800
Message-Id: <1708412505-34470-12-git-send-email-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1708412505-34470-1-git-send-email-alibuda@linux.alibaba.com>
References: <1708412505-34470-1-git-send-email-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: "D. Wythe" <alibuda@linux.alibaba.com>

This patch is a refactoring for smc_accept(), the extracted
__smc_accept() make it possible to obtain the accepted sock
when an NULL clcsock passed in. In that way, the inet version
of SMC can access the accepted sock without providing a faked
clcsock.

Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
---
 net/smc/af_smc.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 484e981..e0505d6 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -2684,17 +2684,16 @@ static int smc_listen(struct socket *sock, int backlog)
 	return rc;
 }
 
-static int smc_accept(struct socket *sock, struct socket *new_sock,
-		      int flags, bool kern)
+static struct sock *__smc_accept(struct sock *sk, struct socket *new_sock,
+				 int flags, int *err, bool kern)
 {
-	struct sock *sk = sock->sk, *nsk;
 	DECLARE_WAITQUEUE(wait, current);
+	struct sock *nsk = NULL;
 	struct smc_sock *lsmc;
 	long timeo;
 	int rc = 0;
 
 	lsmc = smc_sk(sk);
-	sock_hold(sk); /* sock_put below */
 	lock_sock(sk);
 
 	if (smc_sk_state(&lsmc->sk) != SMC_LISTEN) {
@@ -2750,8 +2749,21 @@ static int smc_accept(struct socket *sock, struct socket *new_sock,
 	}
 
 out:
-	sock_put(sk); /* sock_hold above */
-	return rc;
+	*err = rc;
+	return nsk;
+}
+
+static int smc_accept(struct socket *sock, struct socket *new_sock,
+		      int flags, bool kern)
+{
+	struct sock *sk = sock->sk;
+	int error;
+
+	sock_hold(sk);
+	__smc_accept(sk, new_sock, flags, &error, kern);
+	sock_put(sk);
+
+	return error;
 }
 
 static int smc_getname(struct socket *sock, struct sockaddr *addr,
-- 
1.8.3.1


