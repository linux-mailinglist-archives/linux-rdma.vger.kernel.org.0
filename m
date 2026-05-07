Return-Path: <linux-rdma+bounces-20139-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +El5JqaK/GleRAAAu9opvQ
	(envelope-from <linux-rdma+bounces-20139-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 14:50:46 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D82254E879D
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 14:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D3DE13008C0F
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 12:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2CA3CFF6C;
	Thu,  7 May 2026 12:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="rr7OduyM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com [203.205.221.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45483B6BF0;
	Thu,  7 May 2026 12:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778158241; cv=none; b=hhhbHWLTpNlg8eCtBObYuU3L/ZvXMol4sIgbfm2JRs/5RODkNhVjZ0LM4KJAN59B40bwK9EZni3vCBzIEt7dX854AqJS6xPkpwH9Sv+WRgSAk0IELUOXeAxNFBoXgSJ0SnVBXWTRe9tly0mSl1r9cVAw+iwLFxi8RLOMdTVsF9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778158241; c=relaxed/simple;
	bh=uHD2uCjN1UTQoraWvVy/fg6kCqbQLIutJoDWTGlKUVM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=SmadXXDsSGY/h09N5atpi6bhJeVDM4g8MnccMAR0R9dn+FBv8JhEQBY0/j1sTPvb1qROOiR+qGxwfYQRM5I3eCXJBg1Bs2V9UsUqA6nyTpEfq+2R/8bO1Wo69LbFk8VWMh1WzOCCDIEsyvdQtjLdFWIooHTrXrTuO1ee2e8cRc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=rr7OduyM; arc=none smtp.client-ip=203.205.221.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1778158214; bh=5ub2YWhxmtbkh6ASBeqDgX465/eiGKDulnfevlmT57E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=rr7OduyMYU4DXf7DmYjESFygDNWM7qnufZc27RENxNvqlkwpby6oIZhvSGbd1KB5+
	 OBtwMjCn8gjiOiRK8iN/KvdQgP0fgUXd42ryHHfR7CJM6/aQwelZUJ/uNqxBMMoL20
	 yHYJxVI3WSmrSxLf3MY/isKmbZY6DVOiJdY3mr7s=
Received: from lxu-ped-host.. ([111.198.231.89])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id C8A1B40D; Thu, 07 May 2026 20:50:10 +0800
X-QQ-mid: xmsmtpt1778158210t5p0eskuj
Message-ID: <tencent_611BEB4B141B1A2526BAA3BBB2335F9E9108@qq.com>
X-QQ-XMAILINFO: OPDQNGCUQ3qLkaFh7YH4cP0ef7dTVev+OCC4NTAATZsdIfJe5MGyfHz+BKAuMe
	 25RPII7oaKWNy97i06WpbHAUvoC5MxYIU5A3cshYS3tpyIPgpZZxsKICdfDMRSll03lCGDV4iH3h
	 PeGYuJJGMbuhytycfvHEhmMorKD/h9ol3uLQUe0yiBhp9ptEzUS9wb15obY0FGrJ0B+5fGGhkOL0
	 zpgFd+TJZ1BtJ2loj2+jiQ6hrCzDeJJnA5Z14C03O+Fsvgpsp0CNOqyLhmGahbZxktH83MJJBGEp
	 ZyfBmNOHxAiv14RkSg4YiDlKoAa3uAPbwxPLdg/oF3WIdcLmL5S1vlvM6AP9aQaYaD2iF/hSJ2VG
	 9C7O4DDZl2j6AfCEuekmU7c5ifXjGaZuaOeMhm5ifKc51s1SLZIXw6M4JeLQMTK0/sYrPyGfazMe
	 IBzI+KOc2uWkP3Ka+LQyu62pdFcplBjlWWX0Q/2Hk/cGhuKVVj9ZgAKtY+4fxmeWkTVGsWHnzMmA
	 j7Xa4kdm/7XkSqpC2iGBgo/3BZBdLAxuvInt8SKB+l5SSoyyX2VGen9ieUlxnoFrXpcHdu2++/dp
	 +H1JlYMZTzEoAihrdgLN7hrrwS4dT+RDH/fXtFyarOvYxYWIvrpH5dAKP7B2/rbVPbzwsCnNl6gF
	 AieCei0FZM34dGFURjSUPV4rZgR8ML3qrnptpvXhwFWmA30UOYnYrOglUo8efGEh4uymIeXaTx+L
	 CJYUgTibcL4yI3cLXcqqXfcR01CnQMf4VsKRDHkHoDZlMfM53ZvvAGTVG2NhEpVK+JuxRsAyIA08
	 +aaw5Lbv8wirV6EkLYzKPZG+HEezhBbmJbuyWnGUt4QTNwjUDro84KjM1tM6NeTq2nxzKMiZZ9EV
	 XfyZSEofBSj7rG7zUKjEWRTpFfxydNLWBemMntq75imA+ZzEt/cERcStm5evq2yXQ+IkfH1U74Ns
	 nsc7H5afldZoonbXWX3veCwtAFW6CO9h8yUKgT092qSz7Jlw2ti1E7HyEdH3HuXuQ8u3qu7ebAUJ
	 EypQS8rYRR2AItdtmlOYlSl4qUKwI=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com
Cc: akpm@linux-foundation.org,
	arjan@linux.intel.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	hdanton@sina.com,
	horms@kernel.org,
	jgg@ziepe.ca,
	kuba@kernel.org,
	kuni1840@gmail.com,
	kuniyu@google.com,
	leon@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com,
	yanjun.zhu@linux.dev,
	zyjzyj2000@gmail.com
Subject: [PATCH] RDMA/nldev: add mutual exclusion in nldev_dellink()
Date: Thu,  7 May 2026 20:50:10 +0800
X-OQ-MSGID: <20260507125009.109737-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <69fc0c7c.a00a0220.387fc1.0006.GAE@google.com>
References: <69fc0c7c.a00a0220.387fc1.0006.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D82254E879D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20139-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,linux.intel.com,davemloft.net,kernel.org,google.com,sina.com,ziepe.ca,gmail.com,vger.kernel.org,redhat.com,googlegroups.com,linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[qq.com];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eadavis@qq.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[qq.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma,d8f76778263ab65c2b21];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

We must serialize calls to nldev_dellink() or risk a crash as syzbot
reported:

KASAN: null-ptr-deref in range [0x0000000000000020-0x0000000000000027]
Call Trace:
 udp_tunnel_sock_release+0x6d/0x80 net/ipv4/udp_tunnel_core.c:197
 rxe_release_udp_tunnel drivers/infiniband/sw/rxe/rxe_net.c:294 [inline]
 rxe_sock_put drivers/infiniband/sw/rxe/rxe_net.c:639 [inline]
 rxe_net_del+0xfb/0x290 drivers/infiniband/sw/rxe/rxe_net.c:660
 rxe_dellink+0x15/0x20 drivers/infiniband/sw/rxe/rxe.c:254
 
Fixes: a60e3f3d6fba ("RDMA/nldev: Add dellink function pointer")
Reported-by: syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d8f76778263ab65c2b21
Tested-by: syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 drivers/infiniband/core/nldev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 96c745d5bac4..3cb3cb7629fe 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -1816,6 +1816,8 @@ static int nldev_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	return err;
 }
 
+static DEFINE_MUTEX(nldev_dellink_mutex);
+
 static int nldev_dellink(struct sk_buff *skb, struct nlmsghdr *nlh,
 			  struct netlink_ext_ack *extack)
 {
@@ -1846,7 +1848,9 @@ static int nldev_dellink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	 * implicitly scoped to the driver supporting dynamic link deletion like RXE.
 	 */
 	if (device->link_ops && device->link_ops->dellink) {
+		mutex_lock(&nldev_dellink_mutex);
 		err = device->link_ops->dellink(device);
+		mutex_unlock(&nldev_dellink_mutex);
 		if (err)
 			return err;
 	}
-- 
2.43.0


