Return-Path: <linux-rdma+bounces-20802-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPt8Jnu8CGrK3AMAu9opvQ
	(envelope-from <linux-rdma+bounces-20802-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 16 May 2026 20:50:35 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA9B55D5BE
	for <lists+linux-rdma@lfdr.de>; Sat, 16 May 2026 20:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7C243051CB6
	for <lists+linux-rdma@lfdr.de>; Sat, 16 May 2026 18:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99C4349AE0;
	Sat, 16 May 2026 18:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aTGQzeED"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02023344D9B
	for <linux-rdma@vger.kernel.org>; Sat, 16 May 2026 18:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778956822; cv=none; b=fw7pBdyKlPklLfUYZzmPhqjMoCCER0v8wuDZIn/DPC8OxNL0WHgZqHfPi/erh5mxbO97wJESoNmg3z06cRKTNteUG6HNZ8WSKscjWjRyQxtt23Mm8OPYbeMNxsMaeWzh9WP/x5GR8MkB+lpe837vq9ViGsrsDBsoxT7QOijLdA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778956822; c=relaxed/simple;
	bh=VlzjVr4Rhu/SvH8Nt5oSFcfF1g5cGMDAQXdfOSuw+/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CpNFpQPmAm4dy30ekZDhzCKg6L3l0gIdTBIlk0J1Jb2TPEbhmrbUF4v8qIw9mIbZYAmJiRY42lmmq2yHE0PmtVM0BCorv62NLp/+rwK9I/qIL56DHHQycJEnYV+4Zu1KXqSsHDJTc5dekLbrVu57XDqzItJUVIQBq95geuuJWwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aTGQzeED; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e00da94e-3ce2-45b0-b928-8835c3d345e2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778956817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=11Gci8ivGSpGfce0+gtV3tlX6LTfe9d5ZxtETMgwj5w=;
	b=aTGQzeEDpbXAqsRJ7PwppT8egtiWgEP1ovLga4uO66ix+YYrXEp3igYbIOy0NE2sNP69oE
	S17UlVQTokfPRgPs55eNCwzi/hjZ2KW5hMSv3/2nRz8mPoHyinXKHaHnfvTU3VTfE73ym8
	t0zCV9MNNEHVM38RP9s1B8SIvOyg/qY=
Date: Sat, 16 May 2026 11:40:05 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [rdma] general protection fault in kernel_sock_shutdown
 (4)
To: syzbot <syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, arjan@linux.intel.com, davem@davemloft.net,
 dsahern@kernel.org, edumazet@google.com, hdanton@sina.com, horms@kernel.org,
 jgg@ziepe.ca, kuba@kernel.org, kuni1840@gmail.com, kuniyu@google.com,
 leon@kernel.org, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
 zyjzyj2000@gmail.com, "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
References: <6a081669.050a0220.f80e4.0002.GAE@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <6a081669.050a0220.f80e4.0002.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: EDA9B55D5BE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20802-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[syzkaller.appspotmail.com,linux-foundation.org,linux.intel.com,davemloft.net,kernel.org,google.com,sina.com,ziepe.ca,gmail.com,vger.kernel.org,redhat.com,googlegroups.com,linux.dev];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,d8f76778263ab65c2b21];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Action: no action

diff --git a/drivers/infiniband/core/nldev.c 
b/drivers/infiniband/core/nldev.c
index 3cb3cb7629fe..96c745d5bac4 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -1816,8 +1816,6 @@ static int nldev_newlink(struct sk_buff *skb, 
struct nlmsghdr *nlh,
  	return err;
  }

-static DEFINE_MUTEX(nldev_dellink_mutex);
-
  static int nldev_dellink(struct sk_buff *skb, struct nlmsghdr *nlh,
  			  struct netlink_ext_ack *extack)
  {
@@ -1848,9 +1846,7 @@ static int nldev_dellink(struct sk_buff *skb, 
struct nlmsghdr *nlh,
  	 * implicitly scoped to the driver supporting dynamic link deletion 
like RXE.
  	 */
  	if (device->link_ops && device->link_ops->dellink) {
-		mutex_lock(&nldev_dellink_mutex);
  		err = device->link_ops->dellink(device);
-		mutex_unlock(&nldev_dellink_mutex);
  		if (err)
  			return err;
  	}
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c 
b/drivers/infiniband/sw/rxe/rxe_net.c
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

