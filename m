Return-Path: <linux-rdma+bounces-20007-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIlKNAGx+Wld/AIAu9opvQ
	(envelope-from <linux-rdma+bounces-20007-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 10:57:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A7E4C8FE0
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 10:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D5FA302DE00
	for <lists+linux-rdma@lfdr.de>; Tue,  5 May 2026 08:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092C038C430;
	Tue,  5 May 2026 08:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWwbfQ+l"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79E130BB8A
	for <linux-rdma@vger.kernel.org>; Tue,  5 May 2026 08:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777971453; cv=none; b=DcJBRX+aJvXYQIJQpNtRl+xqtg1QbGF8GSXa40naWf06SnjpPGDk1xt1QcRaLTNhPJZZffE8HCSDa3UbFSQfv02qD6fITvFZcodQvQsusRVIDbH6ingDlw9GvUxJWabyec6+drDVaBwoPuFpntPSYWb+hVdkj1CvY1agbxHuR1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777971453; c=relaxed/simple;
	bh=2VI4lWnpVau03GrlD498DUQVD7E615963XNO6/O4mFM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E9+aY8H0YmzQbD6RpuBCs/1qmJzbo9xMozAEM8Snoaarg6F8eSJoUCgDY778BMuqVrweO7XU3N30kIq5i/YRHs+XMos/Ubs+JuXkY66CAjznAIlrwfFMstSPRACSnBDIbQF3cRKEqWm+32Xy+8CFDLV639PxfDFlAYrl2GiaPfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nWwbfQ+l; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3654ebfd57cso1283338a91.1
        for <linux-rdma@vger.kernel.org>; Tue, 05 May 2026 01:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777971452; x=1778576252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f+3fp1TPBOFeXOlnvhe+rXS+DD4SMJuICf5AjILyMUc=;
        b=nWwbfQ+liRafpor+3vUZI6QouXrY3P/MxpqnLGg2tt5nGcEtNuZJE/nw71hH+R0fjk
         uRx7Rc+zS+tXHKcxcLJDY3dfNqRp0fsIwiXZhJGIz932aGcQ2KqoufvG17Ww0PVdDLwK
         ldHXZhrSKnkZKy1k4ddAX/XM2SDinUTUKXt6Ktan22Rbv4fxI5pjnqrFy1Qfd1VQR3EQ
         XVVP12JyG+K4b0JPP57hCex6xUamPy52ANvnFMhxR1OsxXVAkPY3d6RkkSIe1BD63kGz
         QeiwwCtJ0P7XpmSgD2odJqqoZVBCGwhiqp96HNnSL3QbtS8dGPtttyEN6oiJvkrPXj7U
         Cd1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777971452; x=1778576252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+3fp1TPBOFeXOlnvhe+rXS+DD4SMJuICf5AjILyMUc=;
        b=p94SYODhZQtmiRtc3aE1H2wmaJRum79SMGMkMjxObF6XkwxDr5yifNtO6Hx1a7BQ7E
         /H/9jW+UVwmGjaMp/uZp6HUASU3e3CQllOIo/YLgERnxT0bCVHdlM+T8DNcuo1/S0M5R
         KECBkdB+CQh8T0ysfgNxZ7I1PoalAN4ec+9Jy9npThVeiXnNqaZeQ/cq1F+4t/kpn4Pp
         9Z3J3NZBxlB2LZH3hd0TJJPKVkMwRSuMiSvLNsuAANCXwBHDVtKfZtVjOFW/vx6I449V
         oV4McY8ood2TzAHJ1inoDUCO27DTqUE/7qnsOSIbvU/batDbUe4iYcKy9dTXbzEr5tqS
         T6rg==
X-Forwarded-Encrypted: i=1; AFNElJ+1KRhDbJIMo4A5J2NQlM+h5Mw8ZinKWZLCHG6dWTMOr/EbpJ0fM+QUCuZclY8vcWd2pX7K0HKRcQh9@vger.kernel.org
X-Gm-Message-State: AOJu0YwCUH6bfs8U4d3WavxWzsu5TjakIJTiItU3sEEMIq3Jull6mT7Z
	y2Dk728GYZqz4IwE4jdYwxcmahFxTBsXJBpqASqdl0/r1AiHPjS4t7FI
X-Gm-Gg: AeBDieuK652GCUOY31l9FSyR1yVz7xLHTAPgfRqzKd34hzsGXgU1PTyw0tuFgy+Z2AI
	Cr/Rz3GYJLIo8h3qspJves0wt99fViVkk6zSAjpWULOPys1us3yTh1q+kRPkMGRbNAgxMbRBPDO
	L/P/7YP/UaQXtmuPDcHVXOK5b0CulXlw9Heb7ndpVBO9jECwwR4Z5hISbcEljnCynxPhCT3C/ky
	5xmR7tgv5zhYk2/WjylDM4OBNgQVnm+3C67N48Ds6ogrG/B+zJtup/pligLB3rKeC0WH5ql9a4N
	WDjTScBWQJ8Z/LOrRTgBkvsoAnP1uuCHy8zHSZMMtgNxhqy+NwenRvyQNoFCD0pSGm8KcZO66rR
	2ObxJs9fM2VHm1tWg/vR97JhXp53zkAVLgHBDWFuyYsH4bTENqAZLIa+YiE6sKLW2bgrH8q3adx
	GJiX1u0xkEJG0DLpWLpikXSecA
X-Received: by 2002:a17:90b:1648:b0:35e:3aec:718b with SMTP id 98e67ed59e1d1-3650ce705fbmr12502856a91.15.1777971452040;
        Tue, 05 May 2026 01:57:32 -0700 (PDT)
Received: from dev.. ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7ffbc6ec67sm11867994a12.17.2026.05.05.01.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 01:57:31 -0700 (PDT)
From: Rohit Chavan <roheetchavan@gmail.com>
To: siva.kallam@broadcom.com,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Rohit Chavan <roheetchavan@gmail.com>
Subject: [PATCH] RDMA/bng_re: Remove unused variable rc
Date: Tue,  5 May 2026 14:27:08 +0530
Message-Id: <20260505085709.1755534-1-roheetchavan@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 45A7E4C8FE0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-20007-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roheetchavan@gmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

The variable 'rc' is initialized to 0 and returned at the end of
bng_re_process_qp_event(), but it is never modified in between.

Simplify the function by removing the redundant variable and returning 0
directly. This cleans up the code and avoids potential compiler warnings
about unused variables.

Signed-off-by: Rohit Chavan <roheetchavan@gmail.com>
---
 drivers/infiniband/hw/bng_re/bng_fw.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/bng_re/bng_fw.c b/drivers/infiniband/hw/bng_re/bng_fw.c
index 17d7cc3aa11d..50156c300b33 100644
--- a/drivers/infiniband/hw/bng_re/bng_fw.c
+++ b/drivers/infiniband/hw/bng_re/bng_fw.c
@@ -123,7 +123,6 @@ static int bng_re_process_qp_event(struct bng_re_rcfw *rcfw,
 	bool is_waiter_alive;
 	struct pci_dev *pdev;
 	u32 wait_cmds = 0;
-	int rc = 0;
 
 	pdev = rcfw->pdev;
 	switch (qp_event->event) {
@@ -152,7 +151,7 @@ static int bng_re_process_qp_event(struct bng_re_rcfw *rcfw,
 				 "rcfw timedout: cookie = %#x, free_slots = %d",
 				 cookie, crsqe->free_slots);
 			spin_unlock(&hwq->lock);
-			return rc;
+			return 0;
 		}
 
 		if (crsqe->is_waiter_alive) {
@@ -182,7 +181,7 @@ static int bng_re_process_qp_event(struct bng_re_rcfw *rcfw,
 		spin_unlock(&hwq->lock);
 	}
 	*num_wait += wait_cmds;
-	return rc;
+	return 0;
 }
 
 /* function events */
-- 
2.34.1


