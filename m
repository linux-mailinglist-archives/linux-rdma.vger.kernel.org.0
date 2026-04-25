Return-Path: <linux-rdma+bounces-19541-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Ci96J4BZ7GkXXwAAu9opvQ
	(envelope-from <linux-rdma+bounces-19541-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Apr 2026 08:04:48 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 077BB465181
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Apr 2026 08:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 099733015D18
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Apr 2026 06:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DF021FF2E;
	Sat, 25 Apr 2026 06:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V69XdSTZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D902F851
	for <linux-rdma@vger.kernel.org>; Sat, 25 Apr 2026 06:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777097081; cv=none; b=JTa64xmzT2USweon4Ks3GtAkjCrFKm94vvh0UnW1msiDx2HOmxPuDnsy03tX2JfAnF2/aUZhDq+M//sI0aLHJ3JGo4d5Cq5d3wqSS/45oXXV1ZfNeIvctO/srieeKbnALK3l+eeVG2RY+LTFpkTIKphp9MmgXWGgEuhXrKpycf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777097081; c=relaxed/simple;
	bh=wlO4fWJpVs6MpGYpN9qdIJFfQRmoyQxDseldP6KKJxA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sQmn7QgTpkdlaA3EaeibfpLBCzZitHg3KkE9jGGv2RWEzTTJxIFAFnPB2QSq1GdtD9e7IVWnEl2rhCgX9TZsntotTE/Ms9GzdUGUYUgi4O8TekU2AR15AegkDY8x86IKPD+xWKcJg+iq8ek25CzNhNgwy6I7iogsZDMCorpgfqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V69XdSTZ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b7aba0af02so24674155ad.2
        for <linux-rdma@vger.kernel.org>; Fri, 24 Apr 2026 23:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777097080; x=1777701880; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OmpsPkPppWF0ldgUb/o7oxD//xHosswqFk5+aPefwbg=;
        b=V69XdSTZKM1sO3+DDBTr4p0T6Pmt8Gmh0w/saNlOv/hIXV5NWfxDAdPJdbXiX0iBM8
         pT+nS9KWHQhOaKBYDpnvO5gxn3H0wDqmC1NWt6WXJwxcViSOFrdVFoCSJSLyZ+qAhh+n
         0ptyKHRotC8dhue6uf/KnVQBpQ1HittDBvQ+1aGsmKS7DTTzjR7cehIst5aOivHENZVo
         E8JYcSGykljGz40OQADbwvG/uqIlp4m/FNXpDybUG7c0TzKIHCroXTwZ+pj41tVdfixq
         ndNACbUrpCgYoVnlDgh971HxaSJLNI64dyH2X+O11KaC/abdgeFWlXraMAOoyqrxhght
         JHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777097080; x=1777701880;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OmpsPkPppWF0ldgUb/o7oxD//xHosswqFk5+aPefwbg=;
        b=Donc1NZcZ0c+2Wi4EzlUaH+ceVHQA9SQJ/tHlWAlfsV+joEfxDfgbspg4Vu1SIymx+
         S8bbyv+RJgtvjGmK2X7LtDGHqV0XOktuXxZ8iitqnxT7gmK5u7agCe14vn0rwiXEMyMz
         gXb+1zoaee8Vw4wRyuGFxyvT6OnQC3lsd4T3NN5DYt4OaX1Ku+uTe4mLBUwPqWOjBNL/
         4UOkdko00ystN+B7nmOssT2PWvdG67NzftFlM/1RwzOOTpMfaezqJHPnHq3v6kI5ieVZ
         gkUyv1KPgj2YMazIKcRvSnvHLvhjH9z4eUzm+RO79FgQd+Ipu4rDw1HpzoGpXzc+i+z7
         eJWw==
X-Forwarded-Encrypted: i=1; AFNElJ9inq5Z0Ph5Z//60JYz1SY/4gwH36UTiWHdI3zKpHIUAMADMXrLlbyZLgDnyv0sflrN2U/xch1wJgyo@vger.kernel.org
X-Gm-Message-State: AOJu0YxzQiatH6a2/kLdDv7oCSIfzDjFK8f+1ngmqhh8hv4+LlNwZhH4
	KiN3h2SPoC6TR5fuQrM3oEwKGRtcvBWlxm4kSBRAzI5KAdxMdW9uyj5z6ZqScZnokF8qGjLTwgU
	ZM+wJ2A==
X-Received: from pfbff20.prod.google.com ([2002:a05:6a00:2f54:b0:82c:e899:f08d])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:958f:b0:39c:235:c5ec
 with SMTP id adf61e73a8af0-3a08d8bce98mr39399746637.34.1777097079600; Fri, 24
 Apr 2026 23:04:39 -0700 (PDT)
Date: Sat, 25 Apr 2026 06:04:12 +0000
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260425060436.2316620-1-kuniyu@google.com>
Subject: [PATCH v2 0/2] RDMA/rxe: Fix per-netns UDP tunnel issues.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 077BB465181
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19541-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,ziepe.ca,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Patch 1 fixes racy allocation/destruction of per-netns UDP
tunnel sockets.

Patch 2 fixes unsafe access to the socket in rxe_find_route6().

Changes:
  v2:
    Patch 1: Set up UDP tunnels in __net_init instead of adding mutex.

  v1: https://lore.kernel.org/all/20260424013759.728288-1-kuniyu@google.com/


Kuniyuki Iwashima (2):
  RDMA/rxe: Fix null-ptr-deref in kernel_sock_shutdown().
  RDMA/rxe: Fix up RCU usage for rxe_ns_pernet_sk6().

 drivers/infiniband/sw/rxe/rxe.c     |   6 --
 drivers/infiniband/sw/rxe/rxe_net.c | 137 +++-------------------------
 drivers/infiniband/sw/rxe/rxe_net.h |   5 +-
 drivers/infiniband/sw/rxe/rxe_ns.c  |  97 ++++++++------------
 drivers/infiniband/sw/rxe/rxe_ns.h  |   1 -
 5 files changed, 56 insertions(+), 190 deletions(-)

-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog


