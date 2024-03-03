Return-Path: <linux-rdma+bounces-1190-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2E986F3A0
	for <lists+linux-rdma@lfdr.de>; Sun,  3 Mar 2024 05:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91820283958
	for <lists+linux-rdma@lfdr.de>; Sun,  3 Mar 2024 04:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B466FD5;
	Sun,  3 Mar 2024 04:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ospqSB5k"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out203-205-251-73.mail.qq.com (out203-205-251-73.mail.qq.com [203.205.251.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42026FA8;
	Sun,  3 Mar 2024 04:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709440049; cv=none; b=pjGf/vDOC0QXylhNnUAt4hvjjCrafjicZOiTcRf/7D7HI0DN3tYvJNidKnj9UYYMqn2K+/q7k1R39pBYLvo+PApWQRZeBetvwHzD3NH/bKS8cfQLyGUHInXEsevK6iiwesbDAuCZKs0TOTBkiYptR/PzfTqqdB08UX9SdIWzQYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709440049; c=relaxed/simple;
	bh=tgkxv0wJipx7iT6D8udnhav/UB2N8Ez2CrQrfJ3/1Fk=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=RgkrrUfNJusT1Pfc5R39fnlUKpS6wMZAFHUO2VJnrAyrqzt4ZHpuMmeTfpvxoMmTPI//n3TN8iKLHE4polsZVuI+sUMVeEET37LoBvIjJPpDKAcHL/7DqrWSqHwY+Nm4nB7E5YFJYgbChcLWkEyaQgNDEUYtjGRApoSpORHMYJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ospqSB5k; arc=none smtp.client-ip=203.205.251.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709440038; bh=aS+G9OyqYa6igSB8+oaADpXxrUcRmnnV1ukdP5ZUw40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ospqSB5kzogVUhsCSraNkPwC0bVgRVkHNZ+PZrlqmJxfE0N5jWvKBtfb2tLmafeZ9
	 /h7mjK4NhfMvsDx21laMMxI/eEuquDM2MVDJxpJ90nnw8YLjCbTl6GuOnpAvKWUQZ/
	 oRl6sxxB65urwq0EdeCmsA+6ECd8aptVAQgwS7V0=
Received: from pek-lxu-l1.wrs.com ([111.198.228.140])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 4B91820F; Sun, 03 Mar 2024 12:18:57 +0800
X-QQ-mid: xmsmtpt1709439537tv7yagi3y
Message-ID: <tencent_25067C49AB2EDF6EE5CC95A7FA86C992F806@qq.com>
X-QQ-XMAILINFO: MyIXMys/8kCtrKzo+WwWQUCutSBfQRboT1XAuuTchFnlDdd28/APvRLxK7ln2S
	 RDVzZtWZJqG9hKC2xWGS5+4d6sgY7dts/L42PLnF5ySVCZWnppoD3fk+RoEDgs3O881WKyhBMb33
	 mRBnAj8LgaAk2tTijlN0fFof8RdAvD8HwT9Tvm0tMOQoMPS/CKtOPl/ooaSC/2rM7AXF7ZrRkWJx
	 CToej6NhIINDxPeCjhOEjmuJToRByK7AmZGrplDIggmnkMTe1n9edwzQqBPtZtl8byLVkYPJxHAz
	 SVNsN3/Gg3MqiN0F+qApukqKRCUqAr10jQwKDEv092B/LbaSO4p5sHCFMw9yOaWNFwPr5Ip5lNus
	 Qu/htmJprUzq+CPVfKnwO51FIJrBcmQpxXZK8f+DbDnZeENGxbHa/Scz4MF7RvfYRPzW82Vcftt1
	 gRiHoiJYMaz2cJKK+4ToFJb7IK0LhOhg2aqtXjwD7xeb+/O+3zvWIBQEWejB/KkIlNlJ0NfXIR/G
	 rP8VLdybv/C9MujLrQqQ77cpFGWg9we8a70OJg/KPYtWZvA9UjdVUHpvf2VCdtpMBrT9uLjJF1nW
	 qFj7oWw+p2BCMdV4IRIOLBJS0YKFxxfj0CXGH2WSTCn/QpcrRrDtBmxc0plGWMWwwo0/jBCgEeAz
	 gLvZNSFr5peqIe7qFURSD7xx/7fvOqrOtPjClIyoNVwIx9zrFej4dqWAs56qzMJdKCO/P+1m/4aD
	 HbGOZJgPTPEYIv09CmdTzFH7/eE0YQwG7wrurhaoQtBcRchLwqA8jjm2xdwubj71j/7EnYQn94AA
	 fw8ZTU6NLLqkwFKBrqLkmsmZosa/HBrcHyF5SqOMmgSMrEb2aQmjcOVvytxD9Ypw/boj8BSvZbCb
	 2t3w0AGKdjNBALPBF+eughIKO5GR0OihUz7N3hXThLeKPoTUVSLpd3yUQFLexPsPRq/f/+sZ0iO6
	 6zsm8mg/2m1U2EbeCAp2K/2sz0v/tpYB4cFmzdMoKllNEyBZ4vsisp3YAQpLBnHoRSQk+jOf4Ib9
	 /H/dRYmw==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+d4faee732755bba9838e@syzkaller.appspotmail.com
Cc: allison.henderson@oracle.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	rds-devel@oss.oracle.com,
	santosh.shilimkar@oracle.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] net/rds: fix WARNING in rds_conn_connect_if_down
Date: Sun,  3 Mar 2024 12:18:57 +0800
X-OQ-MSGID: <20240303041856.31749-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000c0550506125e4118@google.com>
References: <000000000000c0550506125e4118@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If connection isn't established yet, get_mr() will fail, trigger connection after
get_mr().

Fixes: 584a8279a44a ("RDS: RDMA: return appropriate error on rdma map failures") 
Reported-and-tested-by: syzbot+d4faee732755bba9838e@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 net/rds/rdma.c | 3 +++
 net/rds/send.c | 6 +-----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/rds/rdma.c b/net/rds/rdma.c
index fba82d36593a..a4e3c5de998b 100644
--- a/net/rds/rdma.c
+++ b/net/rds/rdma.c
@@ -301,6 +301,9 @@ static int __rds_rdma_map(struct rds_sock *rs, struct rds_get_mr_args *args,
 			kfree(sg);
 		}
 		ret = PTR_ERR(trans_private);
+		/* Trigger connection so that its ready for the next retry */
+		if (ret == -ENODEV)
+			rds_conn_connect_if_down(cp->cp_conn);
 		goto out;
 	}
 
diff --git a/net/rds/send.c b/net/rds/send.c
index 5e57a1581dc6..fa1640628b2f 100644
--- a/net/rds/send.c
+++ b/net/rds/send.c
@@ -1313,12 +1313,8 @@ int rds_sendmsg(struct socket *sock, struct msghdr *msg, size_t payload_len)
 
 	/* Parse any control messages the user may have included. */
 	ret = rds_cmsg_send(rs, rm, msg, &allocated_mr, &vct);
-	if (ret) {
-		/* Trigger connection so that its ready for the next retry */
-		if (ret ==  -EAGAIN)
-			rds_conn_connect_if_down(conn);
+	if (ret) 
 		goto out;
-	}
 
 	if (rm->rdma.op_active && !conn->c_trans->xmit_rdma) {
 		printk_ratelimited(KERN_NOTICE "rdma_op %p conn xmit_rdma %p\n",
-- 
2.43.0


