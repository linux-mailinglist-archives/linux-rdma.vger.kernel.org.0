Return-Path: <linux-rdma+bounces-2615-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3AA8D121C
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2024 04:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 722FC1F23A81
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2024 02:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74531078F;
	Tue, 28 May 2024 02:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gYFiEljQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E8F1401C;
	Tue, 28 May 2024 02:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716863413; cv=none; b=bP32Olc553wZcpNyPVm74J5hg+3lxPWW0vTJrr9HhYplx2ulGhBb4bxzfpztiykAqDOldfL2FRcwiE4z/zvZmQJqLnjWhneaar9uFOgFyP1K5NCPYDiFIrSUmNbI2PY5xvvC/OeBdZD4BWchGUYRUb/tHHAC4R5Esfrwu5r0Gcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716863413; c=relaxed/simple;
	bh=w4OVIhjFqPBRTpT9PQw6dfNUL8lfUKZZjDR8RwJnU6s=;
	h=From:To:Cc:Subject:Date:Message-Id; b=s/Bp14ObshybMbm8OOTg8OuMaYsl6CWakNUY8Eq9l4Pfg1uLY0atHF+410NEfv+ug9QS0L/N0fsqQEuIf25eLZwZ3JXTWJEzDL+pei9DljLPq27mVFy3WBn8SixwMkJzEOBD/r3tNfTv9uOTuuCMV4Gz1hQIOoeTizU6VI7heAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gYFiEljQ; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716863402; h=From:To:Subject:Date:Message-Id;
	bh=5bpiKf4rTKQWf2YAJ6ozVg/Pql17xQP7M2yLjEU3rLw=;
	b=gYFiEljQths0/QgmJkdFG6uykFBsKpIiIoRclMq3DhbK7/GuQzIZ+zZQynU9JdSAWPp1s1cyUE8dmexUo56g3LLe9EJpmo5TG5Jq8BFgT4Msdeo/dCTT8pQm64jx9WWAbENVxop2ESS492TAAuvEC577PjICZqh7H9sIval8+8o=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W7O6Eib_1716863395;
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0W7O6Eib_1716863395)
          by smtp.aliyun-inc.com;
          Tue, 28 May 2024 10:30:02 +0800
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
Subject: [PATCH net-next v3 0/3] Introduce IPPROTO_SMC
Date: Tue, 28 May 2024 10:29:51 +0800
Message-Id: <1716863394-112399-1-git-send-email-alibuda@linux.alibaba.com>
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

v1 -> v2 :

- Code formatting, mainly including alignment and annotation repair.
- move inet_smc proto ops to inet_smc.c, avoiding af_smc.c becoming too bulky.
- Fix the issue where refactoring affects the initialization order.
- Fix compile warning (unused out_inet_prot) while CONFIG_IPV6 was not set.

v3 -> v2 :

- Add Alibaba's copyright information to the newfile

D. Wythe (3):
  net/smc: refatoring initialization of smc sock
  net/smc: expose smc proto operations
  net/smc: Introduce IPPROTO_SMC

 include/uapi/linux/in.h |   2 +
 net/smc/Makefile        |   2 +-
 net/smc/af_smc.c        | 183 ++++++++++++++++++++++++++++++------------------
 net/smc/inet_smc.c      | 108 ++++++++++++++++++++++++++++
 net/smc/inet_smc.h      |  34 +++++++++
 net/smc/smc.h           |  38 ++++++++++
 6 files changed, 297 insertions(+), 70 deletions(-)
 create mode 100644 net/smc/inet_smc.c
 create mode 100644 net/smc/inet_smc.h

-- 
1.8.3.1


