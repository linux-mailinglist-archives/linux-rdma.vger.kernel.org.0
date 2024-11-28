Return-Path: <linux-rdma+bounces-6146-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3226D9DB757
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Nov 2024 13:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DFDB163D17
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Nov 2024 12:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F781A2630;
	Thu, 28 Nov 2024 12:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GSVjF1za"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E855919004B;
	Thu, 28 Nov 2024 12:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732796098; cv=none; b=nUhVNmBBltQz8rGahHaKh3nuUUSWOcIgRQg2kPpkMxyQ+l4JcGXrDKN7bKNXi1+FVZMoqlzPw33aRtGwRaXDGY/IelnWDX51XAvWyCOZrDJ0a2AwIUZACCfJLMOsSM6OYlYkT14hi5/oJbJbXGrVctdKdGDH0/b7zVz2SsKwwCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732796098; c=relaxed/simple;
	bh=6ZImDWzluYteV9HOhP6VykJDvpaBaAic9nqullcoOVA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O+1y3XSHQJLSsMeWhOP/uJsLIA+v205dxNV1FzG9cP8aiCjqxuDhiZ3TcwtIxqjI2oWDnml0rFgVcZa9tbVDkNTxKbOsgS6vgJrTA5xjnjJgOCNpldwuEncqyjy6dXeazeoSCdq2eH8J67FV+roVg+574249SmGExzWRgjTm7jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GSVjF1za; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732796090; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=VMcxHdfXm940/aFlZ2Z5NABcxYXIJPXBAIVqkgct7sA=;
	b=GSVjF1za9ATZNH+p9mlTvy4fKnTn/9mUgiDOZGWNM6dQRZ6Fwj8ZAv/L5sZVAv5VhdVCXTuRaNnwov5Daa7qZ5QM/SUccPYef3rL5vWtUZxCSYrveUlxbzUx67VYacxkX0ADr1kppvwZVVeQYPF87KAK7vJv4Irbtdy4W6J13as=
Received: from localhost.localdomain(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0WKQ-9UR_1732796089 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 28 Nov 2024 20:14:50 +0800
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
Subject: [PATCH net 6/6] net/smc: check return value of sock_recvmsg when draining clc data
Date: Thu, 28 Nov 2024 20:14:35 +0800
Message-Id: <20241128121435.73071-7-guangguan.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20241128121435.73071-1-guangguan.wang@linux.alibaba.com>
References: <20241128121435.73071-1-guangguan.wang@linux.alibaba.com>
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


