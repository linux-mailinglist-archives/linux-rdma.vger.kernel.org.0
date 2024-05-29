Return-Path: <linux-rdma+bounces-2649-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 435D38D2B95
	for <lists+linux-rdma@lfdr.de>; Wed, 29 May 2024 05:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D33BB22DFD
	for <lists+linux-rdma@lfdr.de>; Wed, 29 May 2024 03:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D050015B146;
	Wed, 29 May 2024 03:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="q0Xx0aQM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9833E2B2CF;
	Wed, 29 May 2024 03:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716955158; cv=none; b=KNWvTEgyGidPGZZAcC3FOHp7DnRBOeMj0UD7vxQWf6P7e/CMhK7WHRlmF6dOgqHdDyX50XqGjhcI6M7WG/AC+Ck/yp3fRAoyjpazFmmsveBPhAoiEUwsadB2CZr21K540sKsRNgoad6J06HGdFcVFF+fqZSf//lii1YIPuEpnko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716955158; c=relaxed/simple;
	bh=MzV/RmRZkPTd+jBBOwrHOy3AJmBC0jmJ8OAzoazNJOo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=pLqB243HhkPvzp1+9mKx+qHfB6WwpZBgeHL2b38myrZ+OCdJUq8xW/szbTsaQW/uwEdJJvhx21c3YhwLFs3ogQcSB0NfAzpQABpWfi2oybCa3CY8k4foSNZ+2rqc+YFKk7fg4Dgmqjr1zxwOV7Pu2OYpKMykZ50iV3cnnEJZqn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=q0Xx0aQM; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716955153; h=From:To:Subject:Date:Message-Id;
	bh=fMRDSFI1bkTZ2M21uOVs0FZqSR1jgDwZZ8p12UYIW+I=;
	b=q0Xx0aQM5Gx0y0LNIIIO45WJ89GU/+a+2SnRHRPzIyHXe6opmx7zkW/KJGpj9wHcOiZgEZbGgntMBuMzZuOKjqfDvtIQJ747/cvAzjbmYdJ8oIPXoInfq+OEt1NLPos+xsei5iMUemr1rnztx9XFa/jHiEEVl0tLxYvyirbuA9Q=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W7RK2wi_1716955147;
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0W7RK2wi_1716955147)
          by smtp.aliyun-inc.com;
          Wed, 29 May 2024 11:59:12 +0800
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
Subject: [PATCH net-next v4 0/3] Introduce IPPROTO_SMC
Date: Wed, 29 May 2024 11:59:04 +0800
Message-Id: <1716955147-88923-1-git-send-email-alibuda@linux.alibaba.com>
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

v2 -> v1 :

- Code formatting, mainly including alignment and annotation repair.
- move inet_smc proto ops to inet_smc.c, avoiding af_smc.c becoming too bulky.
- Fix the issue where refactoring affects the initialization order.
- Fix compile warning (unused out_inet_prot) while CONFIG_IPV6 was not set.

v3 -> v2 :

- Add Alibaba's copyright information to the newfile

v4 -> v3 :

- Fix some spelling errors
- Align function naming style with smc_sock_init() to smc_sk_init()
- Reversing the order of the conditional checks on clcsock to make the code more intuitive

D. Wythe (3):
  net/smc: refactoring initialization of smc sock
  net/smc: expose smc proto operations
  net/smc: Introduce IPPROTO_SMC

 include/uapi/linux/in.h |   2 +
 net/smc/Makefile        |   2 +-
 net/smc/af_smc.c        | 182 ++++++++++++++++++++++++++++++------------------
 net/smc/inet_smc.c      | 108 ++++++++++++++++++++++++++++
 net/smc/inet_smc.h      |  34 +++++++++
 net/smc/smc.h           |  38 ++++++++++
 6 files changed, 297 insertions(+), 69 deletions(-)
 create mode 100644 net/smc/inet_smc.c
 create mode 100644 net/smc/inet_smc.h

-- 
1.8.3.1


