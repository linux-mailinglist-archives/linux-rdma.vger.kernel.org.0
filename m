Return-Path: <linux-rdma+bounces-18144-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBzONCoxtGmuigAAu9opvQ
	(envelope-from <linux-rdma+bounces-18144-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2026 16:45:46 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E68286482
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2026 16:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 338043097E9C
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2026 15:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0273BD634;
	Fri, 13 Mar 2026 15:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HLt4pEw+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B09A3C344C
	for <linux-rdma@vger.kernel.org>; Fri, 13 Mar 2026 15:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773416445; cv=none; b=CCgzIeAnmSyhYOPnRpTy0SYOXbMmWEJz9la62GfRoNpxjlo5oG4cKUxapihPQiKT8+No49ss8Ij72TCWq7fUNi6eM8QFZfbE1DW4WMXplvhPWnPFu4bJk9ov6a41cmZlr06dtSMWUDwUeBb/eyvt38TbfS5rmompOR+oHvM++zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773416445; c=relaxed/simple;
	bh=C1C12u7lhnX3+FvtpJ/7VGSV4wgQ8XNH0CC3r8rQ+Yw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ejunl/VlyTT/jJBjDUHa/Sw/HbwjRLAtGGTCvVFnJfKux4Eq8wNhx7WdMcA56ffFdsr7qMUfWKegLATGtCy6q6XauJ4WWbwqQmqtcrxL0jChxZE0a1LELk0xxPiVE5/5ojNW4moZWeHXX4jrMjmBHmoxIqgTnJOLAlSo+ukDeUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HLt4pEw+; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-439cd6b09f8so1953366f8f.3
        for <linux-rdma@vger.kernel.org>; Fri, 13 Mar 2026 08:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773416437; x=1774021237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nmRPHsRLROZLe9Tr12wsWlfM1Xt+10Lq/FWrxDvUAXI=;
        b=HLt4pEw+yXJzWt2lZhJh/5RsobHaIJN3xF9ocVtTs/21nW8Gf5AX+y5p675AF836NH
         coOB/HO4W2OpZRM/RVhZlMqFJ+TW7pXksYTvrvhrO94zRTclMrIEA1pS3JYXY+FSJsxB
         t4UTeBr+8W7PiEiMG+1cXShfJPzxn33oLxNhWT8//svP9B42ATkmxhFbqWclKe2P5iIm
         AmNSSLuJdTsrNIUNXVJivfaEReLjhtXpaWHDSSlRnsmx2vGa6k97OEpuJZel7lZu/0wG
         qZU8QCf7SzQH90l7utb0OC75ZOdEHavI7S8eCn3RVrZMPRfAgPPqef1i1cLhqymrTjld
         jqFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773416437; x=1774021237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nmRPHsRLROZLe9Tr12wsWlfM1Xt+10Lq/FWrxDvUAXI=;
        b=YxJd8wlpjGhDyqa52gzVWM2i+MtsFILSVCz+Q0ozFiA8JphjBRBg5bH61FnFnDXiVs
         Pt1kEePatBLnHA6t2MrrN2JIrz+WNFSV8OyLDWodeXO23bnPgul4bCu7rqRdFnRYVcZY
         9eKFBH96Zw9rK2QjMpYRjjc+xl0qwUAOyH3NJNbMeqM8QLBuxPEr42N/r3pCbuo6+PwB
         urO2fHThjU9F4cM+9SX1bfZOR/0URR3fTLXQnAlafVQmY/5wT/e9e9UsuVvALq3sLi/n
         4DoK+gbKtsgQpdoh5yuhI1sU48ktzCMhR7SvbDuiqD3EMbbm29o1WBZYwjFm8PtaCv52
         txVw==
X-Forwarded-Encrypted: i=1; AJvYcCWU9c0bHP9bJMNgeqcV3Qlgcl8WZfl6mXdBZO5YQMUNQKj12yXIorTTi/r5vAEf/3RLgqhzDoLeNMss@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj+vTXS2wcbFKGV/SmQ+9LfFPfc/KhzrxOkDj7hyHj+jazU4+s
	++MREajwF3oAdDmevPEmMiydAKDT7rdgv+0iZmYPth8A/EHdl5HkQvHDBM0f0ZZDon0=
X-Gm-Gg: ATEYQzzOUPex+KVTvpAXQMlt+8uupZciNEA/wnAbn6unqMSf2h7D7vDPksd1rWRty2d
	4ICooXlB+tk+xbx+Ss91KNtpyWLhE03WL2PJgyMxI2nWWeAOlF1vlK7rLfOgEYlNGdAZiRtDeSf
	h38YhfQmWA/T0BnsYLfRCQtGGDQIgYIClf+EpXD8oAKxPU9CPcSKwkkDTPLe832MHBSpkeiOtb8
	L2vPf8NViHje/+JhU1EDWHKvXjE3CmMe2E5tnHoXmonI0aHXxN4+nV4lv5ypIlRS9XDTDW3uf8r
	D1u9sNl0vk7u3vnjOo4Ut9eaoA/iAJ1f29S/Yf5lZ4dEpi6fXdziCBR+YbLNqy46M1hZgXW6wfX
	c3fHdZbCA1ILHO/nz/MdXKhSmhrKssCdkX3baJnBrZQp29GaB5Vsas3cr8SVY3t0GrVzdXGjytP
	pOwMBv27VCN3FgcaTPPO9zerhmBIjZU3fwGQGRxW8=
X-Received: by 2002:a05:6000:2386:b0:439:ad3a:b737 with SMTP id ffacd0b85a97d-43a04daef80mr8040618f8f.35.1773416437360;
        Fri, 13 Mar 2026 08:40:37 -0700 (PDT)
Received: from linux.fritz.box ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe20b544sm19465430f8f.20.2026.03.13.08.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 08:40:37 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Subject: [PATCH] RDMA/rxe: Replace use of system_unbound_wq with system_dfl_wq
Date: Fri, 13 Mar 2026 16:40:23 +0100
Message-ID: <20260313154023.298325-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18144-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linutronix.de,suse.com,ziepe.ca];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[marco.crivellari@suse.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:dkim,suse.com:email,suse.com:mid]
X-Rspamd-Queue-Id: 39E68286482
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch continues the effort to refactor workqueue APIs, which has begun
with the changes introducing new workqueues and a new alloc_workqueue flag:

   commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
   commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

The point of the refactoring is to eventually alter the default behavior of
workqueues to become unbound by default so that their workload placement is
optimized by the scheduler.

Before that to happen, workqueue users must be converted to the better named
new workqueues with no intended behaviour changes:

   system_wq -> system_percpu_wq
   system_unbound_wq -> system_dfl_wq

This way the old obsolete workqueues (system_wq, system_unbound_wq) can be
removed in the future.

Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/infiniband/sw/rxe/rxe_odp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
index bc11b1ec59ac..d440c8cbaea5 100644
--- a/drivers/infiniband/sw/rxe/rxe_odp.c
+++ b/drivers/infiniband/sw/rxe/rxe_odp.c
@@ -545,7 +545,7 @@ static int rxe_ib_advise_mr_prefetch(struct ib_pd *ibpd,
 		work->frags[i].mr = mr;
 	}
 
-	queue_work(system_unbound_wq, &work->work);
+	queue_work(system_dfl_wq, &work->work);
 
 	return 0;
 
-- 
2.53.0


