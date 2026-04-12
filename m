Return-Path: <linux-rdma+bounces-19251-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sP0dB92T22lvDgkAu9opvQ
	(envelope-from <linux-rdma+bounces-19251-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Apr 2026 14:45:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B49183E3D46
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Apr 2026 14:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 135C73004F30
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Apr 2026 12:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926712E0B71;
	Sun, 12 Apr 2026 12:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOOGO3K/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9ADA281530
	for <linux-rdma@vger.kernel.org>; Sun, 12 Apr 2026 12:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775997908; cv=none; b=n9Ez04g+iYximeLFLtoVcCUMrdSD9SzxAlf5Zn2+pSksZ+wFE+dvg8l7MTZgq8RdlnA4lCLUsost+lwn6LByutYjCn4b8DlSD822UIhYPEb1af1buwbFoWy6G8cayJtK4cVrXSDnhtF1R0Qj3hVgQJgKA4DbRi5iKfw01n3n1Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775997908; c=relaxed/simple;
	bh=8Ln9L+1bUr1auVhrM1bMb8RKDwIuVqKervYg3i/L+/4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RiDqDWRkGxnrXZ5sNZy9bOU41xto7kJzMepj3CCTEE7PD1FpfpolMWyTcLSlQ8MVP7jmbn1yNloq8IyuMp3mOjtJJ+sCBaBA14NxwIgwQezB9H8Sopnsu6/acayg4wqRBxNM3E+2QBn4qSIfH5swvd8dXcZohsq5kW/b7IPEQBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QOOGO3K/; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b299b3c739so14834025ad.3
        for <linux-rdma@vger.kernel.org>; Sun, 12 Apr 2026 05:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775997905; x=1776602705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gvU9RvpBK2u7s6ovScuGMG+gjl6YN1La+ofcMQ5MbNc=;
        b=QOOGO3K/Tpb2g2ixVQWmRjGzjVV+IXEaZ0aRmrm3UUxo7YwMNoeIypR4wZJ8j60hEj
         BPZV6TfQ7Jtx7G9qsGij6p77OJnlozD5G3lFFNxZ1m5u3E8vbN3ME06493rby3g53c3x
         em2calVPZ0Pg6lb/FNjjOxlVBtsU/hvWq5EwBx3/Wa+bXpIakrH5vpsrc7akXQVnTv0g
         S/f5F557Of225IKdyhP4EHDKhO7BdGM6Bv/yL1BemjqaS6j9rvshVesMUVH2K+zBC9G0
         /s9o4xDGijjPW1svIHY3hxhRvTQtzqQXNmZQYEPN8f5wMt+4pGLsm/ZxuevT/dBS3GxD
         PVbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775997905; x=1776602705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvU9RvpBK2u7s6ovScuGMG+gjl6YN1La+ofcMQ5MbNc=;
        b=ZeGHcoMgZwoyucVt38zwyBt9IUvi/1h9kLfb0Q4+i2FtHPvRfU0vzG9UaXeNIFkzdt
         /K9HQzbYMq5NgbETQ6cqTbzrWtIZ73WZe5gC5s1iBF5tbhLnpJ8OYvYd0J1nn2dHn+y2
         2LC0g2eqDMJ15Sjd5MR7RswfjEoLvSJc30894Ky07sXF3f02oexW1wpRM0h3rFzacM3F
         8fF6x2D7KXRGVhlTSoCtgoMldjH423qJse+bbQVVJh04qOsNrpRs96y/irn/VF37IZ3y
         GtUwa5xljfrGclqTM3PWg/ewoyb8yPhmOGmrqKKewM55ByWA79nVLXwQfoZwZZ4RtyJY
         Kjtg==
X-Forwarded-Encrypted: i=1; AFNElJ87kqnUnBkIeRsQMO7/IlMy7U43WcDt7XT7b6/8kyzAkm0/k4V4ShhhdUeugS8KGjpzvXDAZsRDIn/y@vger.kernel.org
X-Gm-Message-State: AOJu0YxtVKGWSm0Oqz37XhQcssQ0wpDfCj338U2ennGkay0P37oSAXfP
	z5VJ/Mis1sIl5ySceb5L7+z1CV2/bo71jN1gXtfyxFa8pG6zYjgZowb3
X-Gm-Gg: AeBDietxafF2LrZWT57djdcNUoDkpHDRzINDFjwWGagcCO3MtGCfaIs5RggGQHjl+YG
	lq3o9wapXioEpOQ3ajpH5krtSFfjb+WkG7xnI+EY3cfLQWMd6/HTMyH8tYY/+gxFKN8vOp/R9rp
	b4Ts9yPqW3ec1wMNN2xq+Vjt0tjNEHzt3uBaZBa17cqzQfGmAIguSApsNcOuOLWAKkadPbQkORY
	sJ7BajOqczpigzbmCzQlbS0hRNAEUUIkrFdAeLbcTvEVMMiweC+PxXhVMH/fTX+A5IoeMn09RuC
	FBcWrV2g4uogZO2t4pJTEiyPEJ0ckSKrhvFXz8EyhcAm/2T4I5ufmhCZu0T/SaOOvgCEq+DTzhL
	NuafApfuQGJtGWo2PlYpH6XbfL70TTMRdzuB+b94VJ98IA+NAB6PZhg+U82gMM+j7Xye34XqU9N
	/0WmXiqwT4YcSB7rWIGx1OJGxdpAi9a3X6pH9qutA/qcVUWJrI9Dt2ZJEjUtZTU547vs6Gz15h7
	NCNwfMDt9sgKkSw2s5/h2QiSkkF
X-Received: by 2002:a17:902:ba94:b0:2b2:5840:80c4 with SMTP id d9443c01a7336-2b2d5a291e5mr70378175ad.25.1775997905142;
        Sun, 12 Apr 2026 05:45:05 -0700 (PDT)
Received: from localhost.localdomain (ec2-54-199-123-161.ap-northeast-1.compute.amazonaws.com. [54.199.123.161])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f431c3sm80273025ad.79.2026.04.12.05.45.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 12 Apr 2026 05:45:04 -0700 (PDT)
From: Xiaobo Liu <cppcoffee@gmail.com>
To: Allison Henderson <achender@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org,
	Xiaobo Liu <cppcoffee@gmail.com>
Subject: [PATCH] RDS: Fix memory leak in rds_rdma_extra_size()
Date: Sun, 12 Apr 2026 20:44:55 +0800
Message-ID: <20260412124455.2008-1-cppcoffee@gmail.com>
X-Mailer: git-send-email 2.50.1
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,oss.oracle.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-19251-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cppcoffee@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B49183E3D46
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Free iov->iov when copy_from_user() or page count validation fails in rds_rdma_extra_size().

This preserves the existing success path and avoids leaking the allocated iovec array on error.
---
 net/rds/rdma.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/net/rds/rdma.c b/net/rds/rdma.c
index aa6465dc7..91a20c1e2 100644
--- a/net/rds/rdma.c
+++ b/net/rds/rdma.c
@@ -560,6 +560,7 @@ int rds_rdma_extra_size(struct rds_rdma_args *args,
 	struct rds_iovec *vec;
 	struct rds_iovec __user *local_vec;
 	int tot_pages = 0;
+	int ret = 0;
 	unsigned int nr_pages;
 	unsigned int i;
 
@@ -578,16 +579,20 @@ int rds_rdma_extra_size(struct rds_rdma_args *args,
 	vec = &iov->iov[0];
 
 	if (copy_from_user(vec, local_vec, args->nr_local *
-			   sizeof(struct rds_iovec)))
-		return -EFAULT;
+			   sizeof(struct rds_iovec))) {
+		ret = -EFAULT;
+		goto out;
+	}
 	iov->len = args->nr_local;
 
 	/* figure out the number of pages in the vector */
 	for (i = 0; i < args->nr_local; i++, vec++) {
 
 		nr_pages = rds_pages_in_vec(vec);
-		if (nr_pages == 0)
-			return -EINVAL;
+		if (nr_pages == 0) {
+			ret = -EINVAL;
+			goto out;
+		}
 
 		tot_pages += nr_pages;
 
@@ -595,11 +600,20 @@ int rds_rdma_extra_size(struct rds_rdma_args *args,
 		 * nr_pages for one entry is limited to (UINT_MAX>>PAGE_SHIFT)+1,
 		 * so tot_pages cannot overflow without first going negative.
 		 */
-		if (tot_pages < 0)
-			return -EINVAL;
+		if (tot_pages < 0) {
+			ret = -EINVAL;
+			goto out;
+		}
 	}
 
-	return tot_pages * sizeof(struct scatterlist);
+	ret = tot_pages * sizeof(struct scatterlist);
+
+out:
+	if (ret < 0) {
+		kfree(iov->iov);
+		iov->iov = NULL;
+	}
+	return ret;
 }
 
 /*
-- 
2.34.1


