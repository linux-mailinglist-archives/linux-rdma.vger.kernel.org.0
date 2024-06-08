Return-Path: <linux-rdma+bounces-3009-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E37901101
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Jun 2024 11:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 498C21F21D58
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Jun 2024 09:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F8812BE91;
	Sat,  8 Jun 2024 09:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HWVleL9c"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D2C1B813;
	Sat,  8 Jun 2024 09:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717837965; cv=none; b=Sc1zeUq86jDrWcNfNYxlwdjA41cOTeqDnB45s3PxcUp/2E/rNmJo2CoH40IapqvhWDMtNweV3t8eMlz3NP9yAjFSe3XUqvgC9dYK1hIMEA5Bkz50MRQu0kQjvMp+veIPwO4FgELflE8sT5yzgCLD54MSGSdGbn4yryp8J6WOCWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717837965; c=relaxed/simple;
	bh=PySGkYwNjnZFT5rgrUnkIwJwoGCgLPW8v0mBTBsbDCA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=pCmElGN7rw6kOdzumzLKTWsKWZXc8vEUndZvC2EbDDKw6uisKNn8I1eHI1nj3tBlaOzhtU5L652MZ+TBH2Y7Eul1JLN5jKBriVdqe0r7GOkUvoWOtRmFTT6YwWFr/VDQYJXqtXjS8sgbPGVE3BnWHhavf8ocoDXM4uotMPL0W2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HWVleL9c; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717837954; h=From:To:Subject:Date:Message-Id;
	bh=cgd6ey7OgPlwLc5rt7UvPkd8PCmmRS9pNehw00KIcX8=;
	b=HWVleL9cBu/iKNHD1pl2icCjWd9mD5hPz+XykVS0Q5rA9KDIPgauGJxZ/3KooP+dMvpArkL3lpb/BWAcCxsDo7xLS3qfDgzWMbPbmc9odRV1gsquEFkSk2zVwqKlzoDfNzsnSfoiavrxYqtqU/YiaefiCP+ICNmO0emdMpQ0xtU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R841e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W81AVHr_1717837949;
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0W81AVHr_1717837949)
          by smtp.aliyun-inc.com;
          Sat, 08 Jun 2024 17:12:33 +0800
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
Subject: [PATCH net-next v7 0/3] Introduce IPPROTO_SMC
Date: Sat,  8 Jun 2024 17:12:26 +0800
Message-Id: <1717837949-88904-1-git-send-email-alibuda@linux.alibaba.com>
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

Another potential value is that we are attempting to optimize the
performance of fallback socks, where merging socks is an important part,
and it relies on the creation of SMC sockets under the AF_INET path. 
(More information :
https://lore.kernel.org/netdev/1699442703-25015-1-git-send-email-alibuda@linux.alibaba.com/T/)

v2 -> v1:

- Code formatting, mainly including alignment and annotation repair.
- move inet_smc proto ops to inet_smc.c, avoiding af_smc.c becoming too bulky.
- Fix the issue where refactoring affects the initialization order.
- Fix compile warning (unused out_inet_prot) while CONFIG_IPV6 was not set.

v3 -> v2:

- Add Alibaba's copyright information to the newfile

v4 -> v3:

- Fix some spelling errors
- Align function naming style with smc_sock_init() to smc_sk_init()
- Reversing the order of the conditional checks on clcsock to make the code more intuitive

v5 -> v4:

- Fix some spelling errors
- Added comment, "/* CONFIG_IPV6 */", after the final #endif directive.
- Rename smc_inet.h and smc_inet.c to smc_inet.h and smc_inet.c
- Encapsulate the initialization and destruction of inet_smc in inet_smc.c,
  rather than implementing it directly in af_smc.c.
- Remove useless header files in smc_inet.h
- Make smc_inet_prot_xxx and smc_inet_sock_init() to be static, since it's
  only used in smc_inet.c

v6 -> v5:

- Wrapping lines to not exceed 80 characters
- Combine initialization and error handling of smc_inet6 into the same #if
  macro block.

v7 -> v6:

- Modify the value of IPPROTO_SMC to 256 so that it does not affect IPPROTO-MAX

D. Wythe (3):
  net/smc: refactoring initialization of smc sock
  net/smc: expose smc proto operations
  net/smc: Introduce IPPROTO_SMC

 include/uapi/linux/in.h |   2 +
 net/smc/Makefile        |   2 +-
 net/smc/af_smc.c        | 162 ++++++++++++++++++++++++++--------------------
 net/smc/smc.h           |  38 +++++++++++
 net/smc/smc_inet.c      | 169 ++++++++++++++++++++++++++++++++++++++++++++++++
 net/smc/smc_inet.h      |  22 +++++++
 6 files changed, 324 insertions(+), 71 deletions(-)
 create mode 100644 net/smc/smc_inet.c
 create mode 100644 net/smc/smc_inet.h

-- 
1.8.3.1


