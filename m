Return-Path: <linux-rdma+bounces-1050-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3C085B35B
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Feb 2024 08:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FF511F22543
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Feb 2024 07:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A175A0F2;
	Tue, 20 Feb 2024 07:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="U0/Rc/hX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3233353812;
	Tue, 20 Feb 2024 07:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708412515; cv=none; b=uWkKblhTDiS9Q9IARgb/m8F5me8yE7+MEh5AYNvV0YzoqLqNnOjc8B55Ij66ii/EQdbsrMQIThg9GAgdl029sd9hq0CaGabje7WfDoKoHCrDMe5KzoceZecFqNSr+bQoaowpqaquAZRcfPbr9tizxsPUgOBKXhp2kHAovjNtPZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708412515; c=relaxed/simple;
	bh=6JL8cV6I96lFtahpU5MB/CgFV+BKf+Zz/AuzHvy7h8o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ItvBeLXEMudAWAahAcZi70UWwPwM6T1h0TZRQE5ffmg2iShAZ/kRRNjhPgXDaX5giuL8wI3rk/aW8XDGmY3CXSjIyTmcHWyRaIflXnCctdupW3jp6yiZ/3QkwYtwGh30+Lokn3tBnHcOKdrrIi2yW00z6z6HugE8p4XCqZU3NC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=U0/Rc/hX; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708412510; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=tPUrFNUVmxMmR8ZzFyQJcrqL6P7iXqB3hDLDKx1u2FM=;
	b=U0/Rc/hXe8dNUtZKjF3QXd3t7pjFAHPBn0pBcb4nKrv0p28xIMhTcmDVLednynMcWHOjIPRUiDbEUtgikRhCrS7vW0Yn+fM1GVc7wz7zsKRiTkDyI8BZ7U8kjewqW0stm+uPM/opJtzziRBZB8kiu4MNUSgxWzUlrX8WyyNfxsQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W0vuXaw_1708412505;
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0W0vuXaw_1708412505)
          by smtp.aliyun-inc.com;
          Tue, 20 Feb 2024 15:01:49 +0800
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
Subject: [RFC net-next 00/20] Introduce IPPROTO_SMC
Date: Tue, 20 Feb 2024 15:01:25 +0800
Message-Id: <1708412505-34470-1-git-send-email-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: "D. Wythe" <alibuda@linux.alibaba.com>

this patch attempts to initiate a discussion on creating smc socket
via AF_INET, similar to the following code snippet:

/* create v4 smc sock */
v4 = socket(AF_INET, SOCK_STREAM, IPPROTO_SMC);

/* create v6 smc sock */
v6 = socket(AF_INET6, SOCK_STREAM, IPPROTO_SMC);

As we all know, the way we currently create an SMC socket as
follows.

/* create v4 smc sock */
v4 = socket(AF_SMC, SOCK_STREAM, SMCPROTO_SMC);

/* create v6 smc sock */
v6 = socket(AF_SMC, SOCK_STREAM, SMCPROTO_SMC6);

Note: This is not to suggest removing the SMC path, but rather to propose
adding a new path (inet path).

There are several reasons why we believe it is much better than AF_SMC:

Semantics:

SMC extends the TCP protocol and switches it's data path to RDMA path if
RDMA link is ready. Otherwise, SMC should always try its best to degrade to
TCP. From this perspective, SMC is a protocol derived from TCP and can also
fallback to TCP, It should be considered as part of the same protocol
family as TCP (AF_INET and AF_INET6).

Compatibility & Scalability:

Due to the presence of fallback, we needs to handle it very carefully to
keep the consistent with the TCP sockets. SMC has done a lot of work to
ensure that, but still, there are quite a few issues left, such as:

1. The "ss" command cannot display the process name and ID associated with
the fallback socket.

2. The linger option is ineffective when user try’s to close the fallback
socket.

3. Some eBPF attach points related to INET_SOCK are ineffective under
fallback socket, such as BPF_CGROUP_INET_SOCK_RELEASE.

4. SO_PEEK_OFF is a un-supported sock option for fallback sockets, while
it’s of course supported for tcp sockets.

Of course, we can fix each issue one by one, but it is not a fundamental
solution. Any changes on the inet path may require re-synchronization,
including bug fixes, security fixes, tracing, new features and more. For
example, there is a commit which we think is very valueable:

commit 0dd061a6a115 ("bpf: Add update_socket_protocol hook")

This commit allows users to modify dynamically the protocol before socket
created through eBPF programs, which provides a more flexible approach
than smc_run (LP_PRELOAD). It does not require the process restart
and allows for controlling replacement at the connection level, whereas
smc_run operates at the process level.

However, to benefit from it under the SMC path requires additional
code submission while nothing changes requires to do under inet path.

I'm not saying that these issues cannot be fixed under smc path, however,
the solution for these issues often involves duplicating work that already
done on inet path. Thats to say, if we can be under the inet path, we can
easily reuse the existing infrastructure.

Performance:

In order to ensure consistency between fallback sockets and TCP sockets,
SMC creates an additional TCP socket. This introduces additional overhead
of approximately 15%-20% for the establishment and destruction of fallback
sockets. In fact, for the users we have contacted who have shown interest
in SMC, ensuring consistency in performance between fallback and TCP has
always been their top priority. Since no one can guarantee the
availability of RDMA links, support for SMC on both sides, or if the
user's environment is 100% suitable for SMC. Fallback is the only way to
address those issues, but the additional performance overhead is
unacceptable, as fallback cannot provide the benefits of RDMA and only
brings burden right now.

A Simple Fallback benchmark within Short connection (wrk/nginx)

------------------------------------------------------------------
proto/conn          |   128     |  512    |   1024  |  2048       | 
------------------------------------------------------------------| 
TCP                 | 133947.56 | 132933.89 |129047.70 |132411.72 | 
------------------------------------------------------------------| 
Fallback in Server  |                                             | 
IPPROTO_SMC	    | 131607.38 | 131579.17 |130023.96 |131814.16 | 
------------------------------------------------------------------| 
Fallback in Server  |                                             | 
PF_SMC              | 85510.27  | 89577.23  |89850.54  |89542.41  | 
------------------------------------------------------------------| 
Fallback in Client  |                                             | 
IPPROTO_SMC         | 134589.05 | 132379.63 |133110.02 |132381.47 | 
------------------------------------------------------------------| 
Fallback in Client  |                                             | 
PF_SMC	            | 109194.38	| 115995.48 |115498.11 |108671.24 | 
------------------------------------------------------------------

In inet path, we can embed TCP sock into SMC sock, when fallback occurs,
the socket behaves exactly like a TCP socket. In our POC, the performance
of fallback socket under inet path is almost indistinguishable from of
tcp socket, with less than 1% loss. Additionally, and more importantly,
it has full feature compatibility with TCP socket.

Of course, it is also possible under smc path, but in that way, it
would require a significant amount of work to ensure compatibility with
tcp sockets, which most of them has already been done in inet path.
And still, any changes in inet path may require re-synchronization.

I also noticed that there have been some discussions on this issue before.

Link: https://lore.kernel.org/stable/4a873ea1-ba83-1506-9172-e955d5f9ae16@redhat.com/

And I saw some supportive opinions here, maybe it is time to continue
discussing this matter now.

D. Wythe (20):
  net: export partial symbols in inet/inet6 proto_ops
  net/smc: read&write sock state via unified macros
  net/smc: refactor smc_setsockopt
  net/smc: refactor smc_accept_poll
  net/smc: try test to fallback when ulp set
  net/smc: fast return on unconcernd TCP options
  net/smc: refactor sock_flag/sock_set_flag
  net/smc: optimize mutex_fback_rsn from mutex to spinlock
  net/smc: refator smc_switch_to_fallback
  net/smc: make initialization code in smc_listen independent
  net/smc: make __smc_accept can return the new accepted sock
  net/smc: refatoring initialization of smc sock
  net/smc: embedded tcp sock into smc sock
  net/smc: allow to access the state of inet smc sock
  net/smc: enable access of sock flags of inet smc sock
  net/smc: add inet proto defination for SMC
  net/smc: add dummy implementation for inet smc sock
  net/smc: add define and macro for smc_negotiation
  net/smc: support smc inet with merge socks
  net/smc: support diag for smc inet mode

 include/linux/tcp.h           |    1 +
 include/net/inet_common.h     |    3 +
 include/net/netns/smc.h       |    2 +-
 include/uapi/linux/in.h       |    2 +
 net/ipv4/af_inet.c            |    3 +-
 net/ipv6/af_inet6.c           |    2 +
 net/smc/Makefile              |    1 +
 net/smc/af_smc.c              | 1501 +++++++++++++++++++++++++++++++++++------
 net/smc/smc.h                 |   62 +-
 net/smc/smc_cdc.c             |    2 +-
 net/smc/smc_cdc.h             |    8 +
 net/smc/smc_clc.h             |    1 +
 net/smc/smc_close.c           |  120 ++--
 net/smc/smc_core.c            |   24 +-
 net/smc/smc_diag.c            |  157 ++++-
 net/smc/smc_inet.c            |  450 ++++++++++++
 net/smc/smc_inet.h            |  280 ++++++++
 net/smc/smc_rx.c              |   28 +-
 net/smc/smc_stats.c           |    6 +-
 net/smc/smc_tx.c              |    2 +-
 tools/include/uapi/linux/in.h |    2 +
 21 files changed, 2326 insertions(+), 331 deletions(-)
 create mode 100644 net/smc/smc_inet.c
 create mode 100644 net/smc/smc_inet.h

-- 
1.8.3.1


