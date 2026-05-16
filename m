Return-Path: <linux-rdma+bounces-20800-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4bIfMIl4CGpyrAMAu9opvQ
	(envelope-from <linux-rdma+bounces-20800-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 16 May 2026 16:00:41 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1A955BFAE
	for <lists+linux-rdma@lfdr.de>; Sat, 16 May 2026 16:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5B373009FAD
	for <lists+linux-rdma@lfdr.de>; Sat, 16 May 2026 14:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5822A3D5642;
	Sat, 16 May 2026 14:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="pOgRLJaZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C32176026;
	Sat, 16 May 2026 14:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778940033; cv=none; b=t+9CX5UIb3Lk42rNxDh5FM/VUaDyYsmr3kljtvGZ7ZPcGu98b4CPD3KUu83SKDQcqzQz7xqW1KpGxqn7i3ZToq6DpxGIh9uxbzisNs8NlzU//1kdTDXabFfmJkiNq6FPXRF1Z2VWg9X3IqrcLwD+Ky1SHM3lCvXZAQiOKQlKkLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778940033; c=relaxed/simple;
	bh=W8DYgOxkDKBGexHg5FZIkcHjlw4W1nl1DXVC/tSIz2U=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=WqVQsvQ+nPedvN6p6bMNzE/8DmwRix/+pE9AlzhpV6BAAfhTkWJBrZIeKtlxEZU9KlkSUUgFsx6g/vruDkx5I+BoNGjLOsWyIZMFCSUVYF/XqKC3/jqdhjT58sl7Yq3PglqMIfvYfvb41CtF0nPGk+J74bds48gslLy5jbhKGuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=pOgRLJaZ; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1778940018; bh=uDu+fzFaZgHUS8ky2zrOy8aAp6VkUTGDzXDYHZKc9dU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=pOgRLJaZ65q3yxEgSl3S/ibrbMZ4mkRvmrfUkBDaTRPJm+rn+l4WeAxtXHf533OyH
	 NxKNoh/fIXF4RABQuWC71gl/ntwRTMQplgkRCUiAHTn/WNoABrQzVjrTamoHoTeNDX
	 DQ8f/cAwNV20sLCIWLZzmQ8KMrbk5uQzxvLnJmwU=
Received: from lxu-ped-host.. ([111.198.231.89])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id EAF0A3; Sat, 16 May 2026 22:00:14 +0800
X-QQ-mid: xmsmtpt1778940014t7bbg4vp3
Message-ID: <tencent_330636464A367423778966A63DD1360E9609@qq.com>
X-QQ-XMAILINFO: NGZp1yYNf7Y+xRsjHqYHiK6vdykJ0ZcVzOwgGcraQt35QA/kcCHU3mq5CBg2FN
	 ZiqEuJ0vkhQ4bpiynMIpnCN+eSQdMf1cDZnWDuTQ5qExo5ppRsV8wX244jbcR5AOJmqUoGZvqk9b
	 dY2pEZ6xNaL1NcsyK8LFUx9kbhH1b/Z3hxmCahqflxMdz4y9vXK1+QP9aiy8OBy/RAFBJr8Ho8H3
	 wiD5kNB7B/l9o9alQ12Y3WaHf6K8yzvqnX0p4f4IcaHyab9jTCjgTbObXy/nubLtAECmb/7G/g55
	 U/06muhEq6pHZ6GdnUCXBzSB8ilLRHC9GbTOYn7duZDAJBDXNIEgkLYinbSdzsUqZ4sAWVayGM1C
	 TqxjUWxHMTSPy/tepaGUkheqXYrVfnuxy+/FpHoXiUm1yAGjIoXFZigCKKqanrBds83sLhuFlbLz
	 PZHrGq4/khaKew6qpJJTWvlOGiyngnzSFZ2EpUZwChOxYGu06GdLr3z+ZHnNN9pSUtyVOEcr+QiE
	 RqbuMckqXA5b6pGJ4ZiO6Z4cwfOox5T4BvQJI2JpqQtsDxv7tHESCMbtLc4rmIijpApjvJ+LyM+l
	 B76bQJc2ugZgSFp3I/DNZOt0UJdniV1gEkLA3mIvoYZ8vXUqElQOnVLi4ZdXGQNBl6CsBHF39M32
	 T6qFnXD+c6XgnOsD7eoxj7hfi4Jiv5KhTb9jsQUoZpRY7npANI8dwg2iP0rR6W39oIArRRuO8ng/
	 FGCvoA/k2xnl66EqxhPyi2QqvChS58LsygDu1yiX/w8NwUxugf2RZLSZKPpEJjin8dBkm1O3PHnv
	 6RwJ+FaY6mrjYVgeoa5kqX/6we75UaDMORuWnsAqYv1sMXrYAtsPUUpeUCwJP41R8tZd0o/lsRsa
	 B39H7jR56M82yYGbWSxP65fenIAu2PfvtHT+dS921ANCGFHjjXlcb7VkKebtNKBFL1A61FdqtY4l
	 StmadMCwqqadRoKtulkqRPXdRK8+GOx6tNSUsUtJ9OLThPln6v29UhFxOGLbFTlizMHFG8V5BG5d
	 epqe4EIbWArGH++6KFm9ZmnljEETgMUgmAsjiKYm8uoTGgwnj3WX4yST+7ro9J522PpDAiraTgoh
	 j4JEBo3Xz+yal9Ts8=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: Edward Adam Davis <eadavis@qq.com>
To: eadavis@qq.com
Cc: akpm@linux-foundation.org,
	arjan@linux.intel.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	hdanton@sina.com,
	horms@kernel.org,
	jgg@ziepe.ca,
	kuba@kernel.org,
	kuniyu@google.com,
	leon@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	yanjun.zhu@linux.dev,
	zyjzyj2000@gmail.com
Subject: [PATCH RDMA v2] RDMA/rxe: add mutual exclusion in rxe_net_del()
Date: Sat, 16 May 2026 22:00:15 +0800
X-OQ-MSGID: <20260516140014.434063-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_0106C0D2EA464109986EE86EF40CB5E7D406@qq.com>
References: <tencent_0106C0D2EA464109986EE86EF40CB5E7D406@qq.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7B1A955BFAE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[qq.com];
	TAGGED_FROM(0.00)[bounces-20800-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,linux.intel.com,davemloft.net,kernel.org,google.com,sina.com,ziepe.ca,vger.kernel.org,redhat.com,syzkaller.appspotmail.com,googlegroups.com,linux.dev,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[qq.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eadavis@qq.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,d8f76778263ab65c2b21];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,syzkaller.appspot.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qq.com:email,qq.com:mid,qq.com:dkim]
X-Rspamd-Action: no action

We must serialize calls to rxe_net_del() or risk a crash as syzbot
reported:

KASAN: null-ptr-deref in range [0x0000000000000020-0x0000000000000027]
Call Trace:
 udp_tunnel_sock_release+0x6d/0x80 net/ipv4/udp_tunnel_core.c:197
 rxe_release_udp_tunnel drivers/infiniband/sw/rxe/rxe_net.c:294 [inline]
 rxe_sock_put drivers/infiniband/sw/rxe/rxe_net.c:639 [inline]
 rxe_net_del+0xfb/0x290 drivers/infiniband/sw/rxe/rxe_net.c:660
 rxe_dellink+0x15/0x20 drivers/infiniband/sw/rxe/rxe.c:254

Jason Gunthorpe suggest placing the lock within rxe to protect its racy
implementation of rxe_net_del(), which looks like it is possibly also
triggered by NETDEV_UNREGISTER.

The patch addressing this issue in nldev_dellink() has already been
applied(0b28000b64f4); however, since the fix has now been relocated
to rxe, the corresponding remedial code in nldev has been removed.

Fixes: f1327abd6abe ("RDMA/rxe: Support RDMA link creation and destruction per net namespace")
Fixes: 0b28000b64f4 ("RDMA/nldev: Add mutual exclusion in nldev_dellink()")
Reported-by: syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d8f76778263ab65c2b21
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
v1 -> v2: serialize calls to rxe net del

 drivers/infiniband/core/nldev.c     | 4 ----
 drivers/infiniband/sw/rxe/rxe_net.c | 7 ++++++-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 3cb3cb7629fe..96c745d5bac4 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -1816,8 +1816,6 @@ static int nldev_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	return err;
 }
 
-static DEFINE_MUTEX(nldev_dellink_mutex);
-
 static int nldev_dellink(struct sk_buff *skb, struct nlmsghdr *nlh,
 			  struct netlink_ext_ack *extack)
 {
@@ -1848,9 +1846,7 @@ static int nldev_dellink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	 * implicitly scoped to the driver supporting dynamic link deletion like RXE.
 	 */
 	if (device->link_ops && device->link_ops->dellink) {
-		mutex_lock(&nldev_dellink_mutex);
 		err = device->link_ops->dellink(device);
-		mutex_unlock(&nldev_dellink_mutex);
 		if (err)
 			return err;
 	}
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 50a2cb5405e2..92847e955ca2 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -642,6 +642,8 @@ static void rxe_sock_put(struct sock *sk,
 	}
 }
 
+static DEFINE_MUTEX(rxe_net_del_mutex);
+
 void rxe_net_del(struct ib_device *dev)
 {
 	struct rxe_dev *rxe = container_of(dev, struct rxe_dev, ib_dev);
@@ -649,9 +651,10 @@ void rxe_net_del(struct ib_device *dev)
 	struct sock *sk;
 	struct net *net;
 
+	mutex_lock(&rxe_net_del_mutex);
 	ndev = rxe_ib_device_get_netdev(&rxe->ib_dev);
 	if (!ndev)
-		return;
+		goto out;
 
 	net = dev_net(ndev);
 
@@ -664,6 +667,8 @@ void rxe_net_del(struct ib_device *dev)
 		rxe_sock_put(sk, rxe_ns_pernet_set_sk6, net);
 
 	dev_put(ndev);
+out:
+	mutex_unlock(&rxe_net_del_mutex);
 }
 
 static void rxe_port_event(struct rxe_dev *rxe,
-- 
2.43.0


