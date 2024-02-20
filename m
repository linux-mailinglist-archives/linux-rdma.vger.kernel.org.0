Return-Path: <linux-rdma+bounces-1054-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C367C85B367
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Feb 2024 08:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 648FFB21A4E
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Feb 2024 07:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6845A796;
	Tue, 20 Feb 2024 07:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="eOw8bREG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E8453812;
	Tue, 20 Feb 2024 07:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708412519; cv=none; b=Dk7vV26zcxyezhxNQ7VMWNiOr6nJPtrlTAAyRNhqnzEcEtYF4jMhUMJp+e3CbOhExziQ64/Sgz3ZoQyEei8LhgFPBuXG0/ebs+39ffUIqmn8ecNRFii1Iu06vW7C0aWgsTkXVwwK6aJS0geb7O4IEuK8U6HZsggkM3kZzLEHyLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708412519; c=relaxed/simple;
	bh=Iutsv3OoVwGF4kc4XgVKcahxUlu7ij77pKg7OhMyixw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=mJCMyZE5uT8R7CFzHqoQ0c20FawL+I4jyJCugqS2uHwB8T7cB8o2nWDeWqu63033n9uQP15y4O8lnqyezRu8Vp6by5NPSoFehKbWcgGTpqKe18tPVQSURUxdGjFj18Afdilo+NTR4/iD9R4ez3zfwvrS+66I0zwUHWhCMXYroLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=eOw8bREG; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708412512; h=From:To:Subject:Date:Message-Id;
	bh=BQy1WZZL5aLxU1nT2lhQS39zApqAqUDXC+HaX/JlrPE=;
	b=eOw8bREG6y/bSpF+0i5Na6jzB88tPN5hbxYdOPAnsRMEdGaB/kJB7rMp+myM5gFiqQsi6/CNVWhngt89FGoTd6QxRdf57oGoOJQ+GaRq2DMJ3ZoPEoMU0bBiLdfFYWxppkr7JfqwWG470dKNkTy1ByxTnkg+tdLmN4tIR3qPhDw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W0vuXdx_1708412511;
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0W0vuXdx_1708412511)
          by smtp.aliyun-inc.com;
          Tue, 20 Feb 2024 15:01:52 +0800
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
Subject: [RFC net-next 04/20] net/smc: refactor smc_accept_poll
Date: Tue, 20 Feb 2024 15:01:29 +0800
Message-Id: <1708412505-34470-5-git-send-email-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1708412505-34470-1-git-send-email-alibuda@linux.alibaba.com>
References: <1708412505-34470-1-git-send-email-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: "D. Wythe" <alibuda@linux.alibaba.com>

Refactoring smc_accept_poll to extract a common function for
determining whether the accept_queue is empty.

Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
---
 net/smc/af_smc.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index e87af68..7966d06 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -2832,17 +2832,16 @@ static int smc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 	return rc;
 }
 
-static __poll_t smc_accept_poll(struct sock *parent)
+static inline bool smc_accept_queue_empty(struct sock *sk)
 {
-	struct smc_sock *isk = smc_sk(parent);
-	__poll_t mask = 0;
-
-	spin_lock(&isk->accept_q_lock);
-	if (!list_empty(&isk->accept_q))
-		mask = EPOLLIN | EPOLLRDNORM;
-	spin_unlock(&isk->accept_q_lock);
+	return list_empty(&smc_sk(sk)->accept_q);
+}
 
-	return mask;
+static __poll_t smc_accept_poll(struct sock *parent)
+{
+	if (!smc_accept_queue_empty(parent))
+		return EPOLLIN | EPOLLRDNORM;
+	return 0;
 }
 
 static __poll_t smc_poll(struct file *file, struct socket *sock,
-- 
1.8.3.1


