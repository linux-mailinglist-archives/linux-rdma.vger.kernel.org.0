Return-Path: <linux-rdma+bounces-3128-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D26907A81
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2024 20:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF73CB21D5B
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2024 18:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF13A14A4D4;
	Thu, 13 Jun 2024 18:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HyWjNgmJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D61114A4FF;
	Thu, 13 Jun 2024 18:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718301640; cv=none; b=FQhRfmUJ772c8XAk7fgs7uwnLCOPTi22QNOk+sX0tLoqo6T/0SC5xE7Q56a7Dor13Lqyj3Nf593WFxpR0i4GWNHIKnWRWIoj+uUG1nYJ9RoIyVpW+ZoihtLE+lRpcL1KS0gVlrVdJa8DHY2C1jiiErUDgP+Ln/oOlR4c/iWA5HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718301640; c=relaxed/simple;
	bh=8suLW6HES0e5R6jb6nr5yyPnYZGuw1q84bXC1+9xJhQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=HJv8z+1nTV95Q9LlM7bIZcxmy6PiSxEdJmISXtW9Rmalo8MvBqPV3d3UhCGjN+zYnpk0CEhH+9qTYFWCqofbPJyKaO8RqcgM0dSQP5fW/7tHgwdZ3YDjmm5hM5R7jTPUExWqiOCKDyG7vUNgJPIC5uUl4K7j975MU0sdATF7ZaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HyWjNgmJ; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718301634; h=From:To:Subject:Date:Message-Id;
	bh=asERPIKqgVTMdLkj0pxB6Wr+Jn9/+q7aRXCjQ02KkaE=;
	b=HyWjNgmJScF23yev6ffsYhmJQEEREgQMRAyNq4IsehlHM/omkwQ78AhdbDfbsHW8Y+9WZrn5oDhY12XI/qnzVHmuaNbUEdFdUzY85/iLJqqLXKQf3T34n7uTXSEsseQSz7iDY7K7nhmcdaZsHcr7CEzFZbvIqTLYYB20CI7MObI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W8OkrBr_1718301630;
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0W8OkrBr_1718301630)
          by smtp.aliyun-inc.com;
          Fri, 14 Jun 2024 02:00:34 +0800
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
Subject: [PATCH net-next v8 0/3] Introduce IPPROTO_SMC
Date: Fri, 14 Jun 2024 02:00:27 +0800
Message-Id: <1718301630-63692-1-git-send-email-alibuda@linux.alibaba.com>
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

v8 -> v7:

- Remove useless declarations.

D. Wythe (3):
  net/smc: refactoring initialization of smc sock
  net/smc: expose smc proto operations
  net/smc: Introduce IPPROTO_SMC

 include/uapi/linux/in.h |   2 +
 net/smc/Makefile        |   2 +-
 net/smc/af_smc.c        | 162 +++++++++++++++++++++++++++---------------------
 net/smc/smc.h           |  38 ++++++++++++
 net/smc/smc_inet.c      | 159 +++++++++++++++++++++++++++++++++++++++++++++++
 net/smc/smc_inet.h      |  22 +++++++
 6 files changed, 314 insertions(+), 71 deletions(-)
 create mode 100644 net/smc/smc_inet.c
 create mode 100644 net/smc/smc_inet.h

-- 
1.8.3.1


