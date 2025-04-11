Return-Path: <linux-rdma+bounces-9364-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37519A852BE
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Apr 2025 06:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E6611B67D28
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Apr 2025 04:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B75D27CB05;
	Fri, 11 Apr 2025 04:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="W+XewHD5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5AC27CB2F;
	Fri, 11 Apr 2025 04:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744346709; cv=none; b=qW5kGFWhuAEXvrgelpMYNoCToswA2T1A/kLStu+gZE7As2KX8V77u0gseinU/JZMIus8FKQtzzyfwjEvXS+mow6qq9GEEi+39VSNHbj9uozWohdIKESlRW/SH0//olBe0zzQxTT2vOMWVET+sCJ5jpfB055j+QH7PUUF2/rO5LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744346709; c=relaxed/simple;
	bh=DNTUCAbzivbGtmjnFnIu06G0T3ku4zWDyqLTUN10mns=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d6Dvw/SJwTQ9Je7BGtXDvq4i0JSgBZUqPVjpKxOrdTQBGAbul3a/kDz+qveKcVoWHMjhudSj528JV28JWuZ0/+D8GrZt/Xwlrwu1DS9f9JRKo/C3B4/EKmmY+jt+afgllD8wsM0fLpOvv+44dCI0H1bslgvTtTCm7qStTf2cmfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=W+XewHD5; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from localhost.localdomain (unknown [202.119.23.198])
	by smtp.qiye.163.com (Hmail) with ESMTP id 117c6ece2;
	Fri, 11 Apr 2025 12:44:59 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: wenjia@linux.ibm.com
Cc: jaka@linux.ibm.com,
	alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [RFC PATCH] net/smc: Consider using kfree_sensitive() to free cpu_addr
Date: Fri, 11 Apr 2025 04:44:56 +0000
Message-Id: <20250411044456.1661380-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCTEhCVkJIGh0aQkkZSUIeTlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJS0lVSkpCVUlIVUpCQ1lXWRYaDxIVHRRZQVlPS0hVSktISk9ITFVKS0tVSk
	JLS1kG
X-HM-Tid: 0a96232a562603a1kunm117c6ece2
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pxg6Izo*NDJKLDUcMSkcEhoz
	FUIKCitVSlVKTE9PSE9NTEtLTUhOVTMWGhIXVQESFxIVOwgeDlUeHw5VGBVFWVdZEgtZQVlJS0lV
	SkpCVUlIVUpCQ1lXWQgBWUFJSE5DNwY+
DKIM-Signature:a=rsa-sha256;
	b=W+XewHD5T/DrVlYlf70G4CwonfJrv16/xwTI5F6FKPD1zcqZYxYBc2SH6Xf5Hsig9SYBXgEZa5tzTSoqb3EqTtzLXfZ+ATofbKKL1zlwHkZfxh4dqygk2yG+3xBRcDdD1zNxg1Up+ajZQO8HuWC7Yq6lmw3Ut42V0pCpKglAFVU=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=PL2S5ZNY/lfRwbYp6izyK3pe6SK3sLEiQc6v851Wktc=;
	h=date:mime-version:subject:message-id:from;

Hello,

In smcr_buf_unuse() and smc_buf_unuse(), memzero_explicit() is used to
clear cpu_addr when it is no longer in use, suggesting that cpu_addr
may contain sensitive information.

To ensure proper handling of this sensitive memory, I propose using
kfree_sensitive()/kvfree_sensitive instead of kfree()/vfree() to free
cpu_addr in both smcd_buf_free() and smc_buf_free(). This change aims
to prevent potential sensitive data leaks.

I am submitting this as an RFC to seek feedback on whether this change
is appropriate and aligns with the subsystem's expectations. If confirmed
to be useful, I will send a formal patch.

Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
 net/smc/smc_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index ac07b963aede..1b5eb0149b89 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -1388,7 +1388,7 @@ static void smcr_buf_free(struct smc_link_group *lgr, bool is_rmb,
 	if (!buf_desc->is_vm && buf_desc->pages)
 		__free_pages(buf_desc->pages, buf_desc->order);
 	else if (buf_desc->is_vm && buf_desc->cpu_addr)
-		vfree(buf_desc->cpu_addr);
+		kvfree_sensitive(buf_desc->cpu_addr, buf_desc->len);
 	kfree(buf_desc);
 }
 
@@ -1400,7 +1400,7 @@ static void smcd_buf_free(struct smc_link_group *lgr, bool is_dmb,
 		buf_desc->len += sizeof(struct smcd_cdc_msg);
 		smc_ism_unregister_dmb(lgr->smcd, buf_desc);
 	} else {
-		kfree(buf_desc->cpu_addr);
+		kfree_sensitive(buf_desc->cpu_addr);
 	}
 	kfree(buf_desc);
 }
-- 
2.34.1


