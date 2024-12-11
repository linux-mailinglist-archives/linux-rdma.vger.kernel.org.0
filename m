Return-Path: <linux-rdma+bounces-6434-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B66E9EC8EF
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 10:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C637F2842EA
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 09:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7595D3DABFB;
	Wed, 11 Dec 2024 09:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="yMWogaph"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5ED233690;
	Wed, 11 Dec 2024 09:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733908901; cv=none; b=heOK+9YlUvtf6tRewMry7Ch6slX19tsWH0oOkQxo94Ky7CyIy+r6HiP76Y6y+GZ4XKNcNaw/LsfI9CEnTG3oCWJHKCGtLLx7P+JOcc7ZxbkwhRtm7Or9kwA8TVv9HlxeRm7Ij58Cc6vMjiKkIp4OgGtgIydVzYoQ+5rgPh+r0uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733908901; c=relaxed/simple;
	bh=6ZImDWzluYteV9HOhP6VykJDvpaBaAic9nqullcoOVA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bfRewQkt8KxwwpScE0aNA56WfNuHBTMFcTSIKGoZhHoltJyvn3Plv6SbpiLAfhA6h9MC+sNge9JgppFM3SqxsySlu2tEJ/UeG4bienGZyC3gI8wuaj32Uc0uPeb996u6hzn0XjRlYucO36UjWD8WnU2uaBLuA0tFvlUTLxY8kLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=yMWogaph; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733908895; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=VMcxHdfXm940/aFlZ2Z5NABcxYXIJPXBAIVqkgct7sA=;
	b=yMWogaph12Gq8nBerXoZ6jIuXeb4KSCi3CrWwES1osSyLSyCnjFyutazT1ctC4FmOiRSLniXh+kPYnhMAXZp6QdFU1uyKd+OVB/JC33XppuYo3+6Wp5xEnqF2nMZLRxmXK9mU/vrzSqp6LVqr8q3iYYMw1Jy3TxzqGj1faUqMEM=
Received: from localhost.localdomain(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0WLHtOpa_1733908894 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 11 Dec 2024 17:21:35 +0800
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
To: wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 6/6] net/smc: check return value of sock_recvmsg when draining clc data
Date: Wed, 11 Dec 2024 17:21:21 +0800
Message-Id: <20241211092121.19412-7-guangguan.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20241211092121.19412-1-guangguan.wang@linux.alibaba.com>
References: <20241211092121.19412-1-guangguan.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When receiving clc msg, the field length in smc_clc_msg_hdr indicates the
length of msg should be received from network and the value should not be
fully trusted as it is from the network. Once the value of length exceeds
the value of buflen in function smc_clc_wait_msg it may run into deadloop
when trying to drain the remaining data exceeding buflen.

This patch checks the return value of sock_recvmsg when draining data in
case of deadloop in draining.

Fixes: fb4f79264c0f ("net/smc: tolerate future SMCD versions")
Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
Reviewed-by: Wen Gu <guwen@linux.alibaba.com>
Reviewed-by: D. Wythe <alibuda@linux.alibaba.com>
---
 net/smc/smc_clc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index f721d03efcbd..521f5df80e10 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -774,6 +774,11 @@ int smc_clc_wait_msg(struct smc_sock *smc, void *buf, int buflen,
 						SMC_CLC_RECV_BUF_LEN : datlen;
 		iov_iter_kvec(&msg.msg_iter, ITER_DEST, &vec, 1, recvlen);
 		len = sock_recvmsg(smc->clcsock, &msg, krflags);
+		if (len < recvlen) {
+			smc->sk.sk_err = EPROTO;
+			reason_code = -EPROTO;
+			goto out;
+		}
 		datlen -= len;
 	}
 	if (clcm->type == SMC_CLC_DECLINE) {
-- 
2.24.3 (Apple Git-128)


