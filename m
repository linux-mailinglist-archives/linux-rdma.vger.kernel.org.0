Return-Path: <linux-rdma+bounces-19879-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0L3PEDs692kIdwIAu9opvQ
	(envelope-from <linux-rdma+bounces-19879-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 03 May 2026 14:06:19 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 948EF4B5755
	for <lists+linux-rdma@lfdr.de>; Sun, 03 May 2026 14:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9AE83009FBC
	for <lists+linux-rdma@lfdr.de>; Sun,  3 May 2026 12:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015043AD53B;
	Sun,  3 May 2026 12:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9Yfq2tL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F283ACEE8
	for <linux-rdma@vger.kernel.org>; Sun,  3 May 2026 12:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777809972; cv=none; b=s2wFV8wpBTVCnBxLjmuwfjR4S+aPuGlv4InaQ1+Y/5ptZl2CVnw/slNV/dod+1vMfAH3yRW4e9HurwkRl+uJ4bSN0R0G/d95PHMDS+/REBFfOVw5QARPy9VOFA80MMcyWn9vvF1Ko0OjQHrS6nTjIiTlc4lsUr5bbZiShGEjurs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777809972; c=relaxed/simple;
	bh=jtGYQmyKXhp0rnGo6CcPJp1nFhwv6NBzCQzmbG72KeU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qt1aAoggJLkl4tw0XItLCha9yikVHQAEsC2cVkjK9fsAYLgrzM2ZFMMyQZpD73MA9zyToBav7vZoOrnuCUPGKklXINrjpWkds8Uq2yauJkW6BdEJkRGpZjErJIuezOGPNfig1owgT4kEjXTo+Yg62bl2ZEM5CtkWdzeUxNYldjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z9Yfq2tL; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-364ff382b0bso1828341a91.2
        for <linux-rdma@vger.kernel.org>; Sun, 03 May 2026 05:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777809970; x=1778414770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=84tX2retdJJR2pohtx/GVxeV0We5TCZ6puvzbQ7vd/c=;
        b=Z9Yfq2tLhfZuv6U2/IDermvw5vuSiJMDwy3HtMteNjgfAm6V1q/t8nhU4JFQJ/EYya
         P2HLogOhqAGblJkGY7+pbYC+CndG6uARWnAkIoE/aspSZZS20+gd3Ms3owJtoheTsAgw
         vEg00H178MGEpGjFSA1Sd11Wd7j0uA99Uu45g4H39a/ITTJbkI4aVnoRq7lhelDB4cVU
         Cy2MSMv4hcrk322ejOwpZ6EDrm0727XZy5cg+CRHSKSRQxN2udt5DiyacAV+vW89MaqB
         UT65unJk84kPaAl6jXEJMCat3kGf0T48jcjZRIDiO8AEhF12ZIG8Sz99jv2X9BeCY1pC
         q1tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777809970; x=1778414770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84tX2retdJJR2pohtx/GVxeV0We5TCZ6puvzbQ7vd/c=;
        b=QMr+povfKrfkP6nDLr/tv+ebeoGPc2yoOL7e1orbtBGcpiJjuK+J8O/tDwxewL1cm2
         HOeuRnUz14VVYv0cOQashsHQlfrReJpzXfXGZUwHqUHNhW25plRU0CsYVj0NyRZ6R7bg
         iLi1JImol4G05tTYy3k0vaIH62vuCLWhC5aLAWhDsXC5IkxGearqNpcvOUDtyFwYGHSj
         7cs6o6oN9o6Neg6rhyKqKikpG4dE7iv4ALm1kf0nd6qBpFHyy2TrrQEthxKEE5cXsmzN
         tLb/rck/05L1iS8JPkgYtoLDglsxlL0w6niGDM7WFQ6DyoHXEd/vLrSIC9YB6sG6VNee
         glKA==
X-Gm-Message-State: AOJu0YzkB0avLFzQrkXLp+ItAcryKNAQ/igm9UmpF53I8vrkDkB+u51z
	ECFov2JvOMNK+LbMtGV0sI1crPEDlDx3t8fi6WTKdNXoMR0En9R7tIxGvRW0DZrvx2U=
X-Gm-Gg: AeBDieup3cH+TJxTIfFmJ+LeGjZ6eqYQum47VaDN+FBFUzmFdXWUPrz1BRmXEMjeAFx
	9f1M5xdnVTyx7BQqnINuSO/NoRdS5NUcB+kY7yv2JKkhawfhWk2SUDUOuCNcBu1mUecN7KbILUX
	B/BK24NvmpB0LcXRElJCNDqCYWqUg0OujWnXE4olJTq8T5APQLqZWrrMm1s9TLCqF8ldl3CXala
	Q84VRdyt3l/pqqcNSG5TLx3ZgQ2HCUfq4vjYScssNvQyktn0h2E6SqDFwFyFONWFBMxtWiOWb6C
	J47nhTRiGztGkv0+i3Py1YQzscjNSN0y3gNSCsNpmZYmn+JNq4LT7xxghq8s3OL+HDQFHeYFvpX
	ZY2CZQSaQrQzTocUwnW9GN5l12q5R+7So/eSt28FTxmjWxdJr9g6N2cCl68Y8KJp4ngnvEMa+LM
	dELKR8QGYm3OwAwEx6lcxQ6vuE5aQlxbt8OyEUUwW9P9hlZYqv9Is5
X-Received: by 2002:a17:90b:2b8b:b0:35a:329:73d8 with SMTP id 98e67ed59e1d1-3650cd8646fmr5924299a91.4.1777809970547;
        Sun, 03 May 2026 05:06:10 -0700 (PDT)
Received: from shirinkaul.localdomain ([122.172.84.203])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364f3c55bfasm4386797a91.0.2026.05.03.05.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 05:06:09 -0700 (PDT)
From: Shirin Kaul <shirin.kaul11@gmail.com>
To: linux-rdma@vger.kernel.org
Cc: leon@kernel.org,
	jgg@ziepe.ca,
	linux-kernel@vger.kernel.org,
	Shirin Kaul <shirin.kaul11@gmail.com>
Subject: [PATCH] infiniband: hw : use clamp() in _mlx5r_umr_zap_mkey()
Date: Sun,  3 May 2026 12:04:57 +0000
Message-ID: <20260503120457.49220-1-shirin.kaul11@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 948EF4B5755
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,ziepe.ca,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19879-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shirinkaul11@gmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.985];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Use clamp() instead of min(max()) to make the code easier to
understand.

Signed-off-by: Shirin Kaul <shirin.kaul11@gmail.com>
---
 drivers/infiniband/hw/mlx5/umr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/umr.c b/drivers/infiniband/hw/mlx5/umr.c
index 29488fba21a0..92b76ee65779 100644
--- a/drivers/infiniband/hw/mlx5/umr.c
+++ b/drivers/infiniband/hw/mlx5/umr.c
@@ -1014,7 +1014,7 @@ static int _mlx5r_umr_zap_mkey(struct mlx5_ib_mr *mr,
 		 MLX5_IB_UPD_XLT_ATOMIC;
 	max_log_size = get_max_log_entity_size_cap(dev, access_mode);
 	max_page_shift = order_base_2(mr->ibmr.length);
-	max_page_shift = min(max(max_page_shift, page_shift), max_log_size);
+	max_page_shift = clamp(max_page_shift, page_shift, max_log_size);
 	/* Count blocks in units of max_page_shift, we will zap exactly this
 	 * many to make the whole MR non-present.
 	 * Block size must be aligned to MLX5_UMR_FLEX_ALIGNMENT since it may
-- 
2.43.0


