Return-Path: <linux-rdma+bounces-1207-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC931871177
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Mar 2024 01:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9893DB20CCB
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Mar 2024 00:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AA9EDE;
	Tue,  5 Mar 2024 00:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="a+Q6XbOS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out203-205-251-82.mail.qq.com (out203-205-251-82.mail.qq.com [203.205.251.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1757619E;
	Tue,  5 Mar 2024 00:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709597597; cv=none; b=bNx2zdGj4vFFZqyoHpo0kDpfwILWJqVq6gBuL9MVMOf/lIj74dnv16WENZ7UHUopec9PSEsMxsHSGPIqqF/uEb2iKINmhHVX9igD0Wrzlfn9LxDi60Rrr3P94RhHLHfH7GEqBjA4bSDKgky/FggHE33Ga+FwSJPqupyhStSx6lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709597597; c=relaxed/simple;
	bh=dzFbbNoWWlnnW+Er1rHT6ITgFsCk7pt0FjAtfIvHjKA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=WihBAHJbau/F7rJkFxzo4AENXs5/S0oekVm4dnyYzYRBJh2cQJKoBCyA1Y3Frq4tHJL4nVSo+7NHV7E8QArBCoj5q2yGH0FG+JK+7HWhvMzhqbdQGmFnS5kqAhmDbhwY+mGu3/ciZy/psip/DO7Mxs2jqDeDqNSM5EUJn9PpZK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=a+Q6XbOS; arc=none smtp.client-ip=203.205.251.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709597592; bh=aS+G9OyqYa6igSB8+oaADpXxrUcRmnnV1ukdP5ZUw40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a+Q6XbOSmukfqsk5BhADoTL6N9O8ZPFHokSfvDKx1tRNldLLlBIFRmFUW+19INz5r
	 LP1R+kOjE+W61qukbVNbP7v/3Q/cU7kpUCMuK4g2M3o+u4QPQUBF7hjSbGEU1wCPqJ
	 y9Vx7pgVcCTkaRoXSmkOwpUyNcunl1gknmmqP/hc=
Received: from pek-lxu-l1.wrs.com ([111.198.228.140])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id 347B76D1; Tue, 05 Mar 2024 08:13:07 +0800
X-QQ-mid: xmsmtpt1709597587t8nqmzqn2
Message-ID: <tencent_AFA7C146CBD2DFC65989A8EEDAAED20CB106@qq.com>
X-QQ-XMAILINFO: NkHKfw09D6j8tI04hma5l8nCJ6P9+hd+dsjtTNBrGR4+PCP31iM+3PBXe5KZJB
	 b5SHuN7SjZ9XBHFjoTKhtibV/PchFFHBcufAtaogoWpdjD6SGquoyq0j4dxsr0zt0f6/hWuuhuSg
	 3MWzUVnEDQ3yl8er60CCTabeSlslvrxEONvGDXt24hMsa4SqHBtDujp/W6ADOx68Xd8mbEanAb0l
	 7qfLl/VOvuL4Dp+nzHpBch8EG0A5R+WcltBOPLlAAkK3StBpm5Mqy+Y9cqa5+YKCb3myTSDlSqR4
	 /cOzBBVjiD6snAMAhPPHZztbgj1ndvpex+S5c0b6NVjNg/FPzANrhTchIcrQzngMAOnGkC66QSGb
	 DSzPEvuxm2zBp1GBkQ23xnFyKt6q2T6GKMzFhvtiGy60R6UljIUbmYQ8DAQMSycPyoNjWg8sRaoy
	 pF+RcFc0z4qWzRz0ahXoaT+axeFAzPVUPO6piYErIyVXs5Rq+jLPXjZgA34rT4x2wGAvBLIFrZ8b
	 0IiC7srFP27ObuxjGV8d7wf71vTs34XuQ0163YQ48UPRUXPRRqLjT56VN9U0u78TYMup0/gMbQPo
	 qNjJvmcEO+gEyhC6NmUt7Onx/nngnE4D7qRWguNrwtTQ4c92B7tdrq3/7VKqq7XjruYd5skp5KZr
	 otompzJBI+7xxvMMDjvNzXI/ZVd1dCC7etP9SZTeJsRKe89pjDbpQCm2Q2wwaghse1QZ/zN/9xb2
	 E5MKiZ0z8P4KJFBBmNDoULmHH1wf/Mhp4wQoDWTLjRF5OB1KomTyA3kwfdLoUBaeRV4w5vxrBfnT
	 OQoq9XRWROTWBmguSG5kNJmXoopDGDDWm9qQQIMNg5IrqfA70WxUsNdFVrsGEMY0Da0pjuvQ8gQr
	 Jt6Nc0ULbQJZwXTQTmT095ofHs+tsmMeYgqb+NUbbSV4tXgAM/eWsVtnw0y0ZlR//WY/R6InXcwW
	 PhIFFYIupNRfIh5gNmhVPrxVeca01g06y7tJnHfdI=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: horms@kernel.org
Cc: allison.henderson@oracle.com,
	davem@davemloft.net,
	eadavis@qq.com,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	rds-devel@oss.oracle.com,
	santosh.shilimkar@oracle.com,
	syzbot+d4faee732755bba9838e@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH V2] net/rds: fix WARNING in rds_conn_connect_if_down
Date: Tue,  5 Mar 2024 08:13:08 +0800
X-OQ-MSGID: <20240305001307.2240958-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304170707.GJ403078@kernel.org>
References: <20240304170707.GJ403078@kernel.org>
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


