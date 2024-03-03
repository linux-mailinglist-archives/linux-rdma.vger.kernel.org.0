Return-Path: <linux-rdma+bounces-1189-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC05A86F394
	for <lists+linux-rdma@lfdr.de>; Sun,  3 Mar 2024 05:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4F081C21008
	for <lists+linux-rdma@lfdr.de>; Sun,  3 Mar 2024 04:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6615CBD;
	Sun,  3 Mar 2024 04:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="YRJwV5+I"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E797F;
	Sun,  3 Mar 2024 04:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709438591; cv=none; b=J4V1s+hyP6CUeY0OzLi84k76YiaN/lWERxe35ttluv0VsKEvL7gNW1B02XLs0avACZMm4plRO4JhU9ieyySiJMYp1XDYU0bSMLRa51viCYVhF5c/TErcdDQhGYex040B2fr1mue2OzZfOoM7GDzjPYlsLaUdPctP0jHOlUvLZFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709438591; c=relaxed/simple;
	bh=Bh7Ou7LNgE3RsAKDPXarLzfNkzyOUV0mLT1ZekkctT4=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=KaVihlUCJflJJ+Mk4MBNdtxQi+M46B1dxJdqj1w25AE94eTg3M7UD75dQnYWIxagjyMpiujJTV1vvvrorUnivxCdgXCwgyenRask3ouS80FnvYASV51cJiQCTHgZqdXCj/65/wWjW29wkezL3eTQWSUBvBA4YR55C7LyMLqkdeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=YRJwV5+I; arc=none smtp.client-ip=203.205.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709438279; bh=5dDVBe3HuaAOncRzOnzyWpaD0IWT/pNJgquP/aC+9ec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YRJwV5+IZigCcYfmkfOk+xNBw3b7b0xDO/kAl1ztQD73Ru33wBkitAQHHOowVkUVu
	 XUhs0bFgcS0LDC8Kg9P/yUS5ViMxtJ0u21Rn/z7LhH/PXNNuxgNGZi/UUPcH9zeUgY
	 faCY7S3Ukv8MPOK4yuR/vXwlp3KITVOhsLFgzoto=
Received: from pek-lxu-l1.wrs.com ([111.198.228.140])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id E7807020; Sun, 03 Mar 2024 11:57:56 +0800
X-QQ-mid: xmsmtpt1709438276tbcyekehu
Message-ID: <tencent_08EA7471775F67F03DE536C096A636144B09@qq.com>
X-QQ-XMAILINFO: Nq1uWKlIb9DMAoxRSw7gHe9zvgZW9iTWgoA6Jqvu26fsyiuvGY1WoQ6ANc2rtQ
	 6KGvuvN+EYtq3DQR8xt7mrLrivvfqqt4PJPF37WMgly2OES3LiOZI2ZNrCQFOuGRqxl3YywurdJN
	 U01yhfiiG/pFqhp1x/e5V9UpCN8bA8/bz/aFdiz7OsDBqOWRZ2o835ntuaV3AcbdqUsm6aVpWT0Z
	 LrFEEvrf+Nd571dnl5ZRDyzvNUxYDn9+mT9lNXdq4nrVtk7kofEE03QVBXnyy3XJ3CWXIN50Gg6g
	 GRNV6YdNG7NeGEu8l+++PcFi11Wi3TeVUw0gtV0NAxjpgoJ+DCFvaCEwA2BMapKIE+GebKolK/K6
	 unkgN8jwIGH13xG7ji03MhhBVdq2jy83Msu7XOPwMet0BFLPVDUemOLCDPn3nbZUgZxmHKspoUAa
	 JgV2KO7Iye03/qw7gNFkAap71SdO+52Q3wAwLuHmtRx50msHjoJuJpWjRvarLh4xVFmzyi8kyHBW
	 h7Zd1EBXMImTAhPaaLxMKNdQ6fSAXOLQL8ZkK0799nBOy0T8AySFnqD+kh2a4b+TlHPRkCpxGvGe
	 uvH9MdfUdNcTXuOQ/iQhydERRPyeu4Ul4j4jpqt4596620ns+j/+Afyay+BZOWNlmj9gXEJe6e/v
	 5yW1IfHWQS75ty41fENDrvtoU3g3ie1HB2sTbB7SDDoEBczrAkopo/Uo7hDpOTD9Bv5slDchs2XK
	 8lYFtJGgGNvGZ9FjolmU+I6GWE6G9ioXMdVVf37ewrkx37wL4q1RE8slxTzl0T8ZWhDQPJSUmtj4
	 eA2aC9z+Fwge/75jr30+I5h5Mw8EKH/l56hJqmDV7c5UPesQdF4qXuBtAU7mz0eo6tzSZ5NwgxbL
	 2fCvU7kCzlr/fMYx7H4n6zG4KlBCtNiopMUc5nAvsVriqz+1/KTUhquOVjM3Ub0A5nAL4eBUv74m
	 Lcew8tpGo=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
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
Date: Sun,  3 Mar 2024 11:57:56 +0800
X-OQ-MSGID: <20240303035755.8320-2-eadavis@qq.com>
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

Fixes: 584a8279a44a - RDS: RDMA: return appropriate error on rdma map failures 
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


