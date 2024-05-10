Return-Path: <linux-rdma+bounces-2386-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C99B8C1D52
	for <lists+linux-rdma@lfdr.de>; Fri, 10 May 2024 06:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 065462831C8
	for <lists+linux-rdma@lfdr.de>; Fri, 10 May 2024 04:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A66149DED;
	Fri, 10 May 2024 04:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Twk10rZX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4712013B5A1;
	Fri, 10 May 2024 04:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715314350; cv=none; b=chC0CvnA2Sv60MK/iinOiY1OZmsLVmmHNJdTkh8Zj3DVpdDA/RF1GmhMSbqx1MKLNFZxfY05wkNABqFSQtfGVhLeZvdu4BFnxuCqI4IMubZuJ1j9WVAHJdkD+Pkt0H6yRHOMdy73rPFc3MIzFD+A+9k+aAr2C69lYnb3LkasW90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715314350; c=relaxed/simple;
	bh=/LbHYtzPH3iw3XGWOvqHbL99O9TWUBZA8MGRm/DAL2Q=;
	h=From:To:Cc:Subject:Date:Message-Id; b=MK42QLSyyku6EDSBnJu4cNbm/6J8EG1dfcYqiESRAaposBSf0AIXxKbwe0hM+ffRPsiEnLWyylOgMwV7/aFqd6dNnsHLLu62y/j5U3A5asne16AApjLK53IWvqFQ673ayeHR+Qk2TnUZXyCN+IkiNVxRvj26avPJaEe181YTxCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Twk10rZX; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715314339; h=From:To:Subject:Date:Message-Id;
	bh=UWrstFGN85/5yWEaFNa4Yc+QlD7Y5sQgJNMRahvXNMM=;
	b=Twk10rZXAkUUK7r23jk0jD1qldKj07pLwDY9vp3k3LvO8/2c3RXuDhsYiRiJ43p95IK6+MUF77m7inEzA9y+ZzORvpyZZAyNFyVzLNfVtjKWLU1VkInG2DCRZwzRxGlli7Rd4B7q/fg3IeamvGtpa1GG/tmTAyGVgAR6v9Y3Tx8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W68pi1J_1715314333;
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0W68pi1J_1715314333)
          by smtp.aliyun-inc.com;
          Fri, 10 May 2024 12:12:18 +0800
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
Subject: [PATCH net-next 0/2] Introduce IPPROTO_SMC
Date: Fri, 10 May 2024 12:12:11 +0800
Message-Id: <1715314333-107290-1-git-send-email-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: "D. Wythe" <alibuda@linux.alibaba.com>

This patch allows to create smc socket via AF_INET,
similar to the following code,

/* create v4 smc sock */
v4 = socket(AF_INET, SOCK_STREAM, IPPROTO_SMC);

/* create v6 smc sock */
v6 = socket(AF_INET6, SOCK_STREAM, IPPROTO_SMC);

There are several reasons why we believe it is appropriate here:

1. For smc sockets, it actually use IPv4 (AF-INET) or IPv6 (AF-INET6)
address. There is no AF_SMC address at all.

2. Create smc socket in the AF_INET(6) path, which allows us to reuse
the infrastructure of AF_INET(6) path, such as common ebpf hooks.
Otherwise, smc have to implement it again in AF_SMC path. Such as:
  1. Replace IPPROTO_TCP with IPPROTO_SMC in the socket() syscall
     initiated by the user, without the use of LD-PRELOAD.
  2. Select whether immediate fallback is required based on peer's port/ip
     before connect().

A very significant result is that we can now use eBPF to implement smc_run
instead of LD_PRELOAD, who is completely ineffective in scenarios of static
linking.

Another potential value is that we are attempting to optimize the performance of
fallback socks, where merging socks is an important part, and it relies on the
creation of SMC sockets under the AF_INET path. (More information :
https://lore.kernel.org/netdev/1699442703-25015-1-git-send-email-alibuda@linux.alibaba.com/T/)

D. Wythe (2):
  net/smc: refatoring initialization of smc sock
  net/smc: Introduce IPPROTO_SMC

 include/uapi/linux/in.h |   2 +
 net/smc/af_smc.c        | 222 +++++++++++++++++++++++++++++++++++++++---------
 net/smc/inet_smc.h      |  32 +++++++
 3 files changed, 214 insertions(+), 42 deletions(-)
 create mode 100644 net/smc/inet_smc.h

-- 
1.8.3.1


