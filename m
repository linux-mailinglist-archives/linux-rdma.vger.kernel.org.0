Return-Path: <linux-rdma+bounces-19537-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLdVFYwS7Gl8UAAAu9opvQ
	(envelope-from <linux-rdma+bounces-19537-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Apr 2026 03:02:04 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA4A464601
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Apr 2026 03:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 509A83017076
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Apr 2026 01:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7121F1513;
	Sat, 25 Apr 2026 01:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZElFdXBr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829B51E7C23
	for <linux-rdma@vger.kernel.org>; Sat, 25 Apr 2026 01:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777078919; cv=none; b=EUL+S/C41v/yIivXrPu48oCOtXrP478S/NkwlGJ5nHFaKwZugskJn+raGQ88E30TxwgPd6K98xrldCQooGDlSzA8jBw1SQTaGaS2bmrzzxjIp8ALfQWmNy5HlWLqxizPcg7OQcNJ8yUq/xYKjUhdEWyL5Jk7CI2BMW4RbJpHPNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777078919; c=relaxed/simple;
	bh=pGKwd41KQ8VX0PGv0k92ogSM3xjtZyf2NxufUOzNjD0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oiJ8o8bd0nbMBs+iPsPAPalSykXVSrSylDn3+gKufES4OIF9jA9VtttJiqOFZbFULkNrsl9qTOsURdr5raIOk4+iVFSxhUGzRxZMcH5aXBfycMhUo776NEqN8HpjrivdOMgP5Ouaz/C0gyBVbiN3DOInSN2rbAh+PMRW3Kn/FEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZElFdXBr; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso115241705e9.3
        for <linux-rdma@vger.kernel.org>; Fri, 24 Apr 2026 18:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777078916; x=1777683716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gkRSJPCvN16HLT6MSy3CwRc7MA4DpomgTY4ehFZ/ow0=;
        b=ZElFdXBryzfqOpNzONXivzh3xfV0niHeG+PNAtpV1LI8L86D+6UmV552sxeDD8E0Nd
         jxn+jRHG3dVJxw7hw0s7uu3xQ6EbpzB1xfD6e1p9MQY6Ke8EdSi3NG2A2DvEbax5aLwV
         4liEh2mRT0C/zwBihElQtMRTntUen930eYaidwWv2/WylrfD19nMo3d1bryKG6WrIZfq
         WfgE5cbtVl3bIpz+5HUuTOPdviCPujJAGQEpQC7PLeHAmTO9Z9MEhvO1eKrQIRrPn6VL
         viE6AZSpB9yMKn4Q7RSA+jyu9QHxhu0pfwS9XHcYI42+Qe8Zv6A5HpOhGiRvoMEfzfd+
         7afQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777078916; x=1777683716;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gkRSJPCvN16HLT6MSy3CwRc7MA4DpomgTY4ehFZ/ow0=;
        b=KwyGEJcndUL/TFxm3sSNMp2ypaO1aLymlAT19FQjaZQ8wJJA9BZO0oKCp1BL5BkRW8
         PC1kHnZF2jiqrM3s7NeBJMdl+LJ4h3N6Cs4Wadi3LyxRE/2cLvbXQPlYv3ifbgscwNN4
         /jvBKH7SeDdJWFsJVXP/pKTwkng/w+35S8rC53xA8brb+pllWWMwpjf1xMmoEf04pNFZ
         z5+khpmn4Jiwb6iq5MsJvkWRiOGBuHzDmqMb6UR9PtMCeCtGFronw/rjNS3hZgNt72AT
         9J3ROqQ2csKdoqi4W9iiXzcrYP61MQIb0k3ySegvUk7N+wm+85ZYZDvKFrraVOnMy2PM
         6sOQ==
X-Forwarded-Encrypted: i=1; AFNElJ9/keGY/Zlkqsl0YpzH3lIw5E8Dia5bTZ7fgyUJCgwodyMLvWaDjFVaQlCdouBgQYREmWLb51n2Xpi7@vger.kernel.org
X-Gm-Message-State: AOJu0Yz07WSR4UhaxAZdyx5hVdgybIqq2s2xE13VFQSfFnqEopmjxnlL
	OCnD9LwAi5fqKYPkQfnADManPDeKCeVNLDyd3pBUYYcU5JuGTJGCFUCu
X-Gm-Gg: AeBDieuCCIATcicszyvV4NhZ2pv7oJk6S7BemzvRGGzEr79JS44XXZeqf8p3Ckt4hcf
	I/BiiypUJYam6wbvBe8m67cpOw4hCSwI7XRhZ2GtA7hZVqk3WjJ/RSlyWcs61KPCtmwS9u9nGRH
	CkVue8ZOBCtCsJp7LvNcIXj+niOz2siuWSom3stvCfxL4WVqNOlG58+bvLOdqAF29q5wIOjPS0N
	Te/sYztKvrsScwoQVFmTs6hDrjvOsUUQ8+i2od0D2Xp6SH0fGkVpciQQ4tEYzUuUWkMyfiUSNa7
	b+rYLe3zCHvya147WjXPYJnguKsDdVvEpkSga4ut3zjJZhK1tUt8OuZZv20EpA4RRtRikCE59l3
	GhS0GKuQc/aR9U4vd8D0Gcvsg8TFOjJdH4vPeMtVt5E4/4/6bkGr23Z858CiwWa+xJPc/t6In3Q
	Qom8M1K4/p9aYYm2VTzrTznl7CKGbPTIWep4HNWKDOaPRQsx0qaZEBwq6PFPaDnaDW7W+2lr69M
	h0OwhxhYvZfksyZImEEawzKxX9gtNg3zCE5FLUzTxgoDReapkXs
X-Received: by 2002:a05:600c:1614:b0:489:1e8a:90b4 with SMTP id 5b1f17b1804b1-4891e8a91e8mr203282145e9.21.1777078915677;
        Fri, 24 Apr 2026 18:01:55 -0700 (PDT)
Received: from SD.localdomain (heme-13-b2-v4wan-167795-cust403.vm32.cable.virginm.net. [81.108.45.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a5549f582sm98835785e9.33.2026.04.24.18.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 18:01:55 -0700 (PDT)
From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: yishaih@mellanox.com,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Subject: [PATCH rdma v1] RDMA/mlx5: Fix devx subscribe-event unwind NULL dereference
Date: Sat, 25 Apr 2026 01:59:15 +0100
Message-ID: <20260425010107.19586-1-prathameshdeshpande7@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CAA4A464601
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[mellanox.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-19537-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prathameshdeshpande7@gmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

MLX5_IB_METHOD_DEVX_SUBSCRIBE_EVENT() links event_sub into sub_list
before initializing the fields used by the shared error path.

If eventfd_ctx_fdget() then fails, the unwind path dereferences
event_sub->ev_file in uverbs_uobject_put() and calls
subscribe_event_xa_dealloc() with event_sub->xa_key_level1 still unset.

Also, if kzalloc_obj() for event_sub fails after
subscribe_event_xa_alloc() succeeds, the current iteration is not yet
tracked in sub_list, so the shared unwind path cannot undo the XA
allocation.

Initialize the shared-unwind fields before linking event_sub into
sub_list and explicitly unwind the XA allocation on event_sub allocation
failure.

Fixes: 759738537142 ("IB/mlx5: Enable subscription for device events over DEVX")
Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
---
 drivers/infiniband/hw/mlx5/devx.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index 645ebcc0832d..3d1528b1c816 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -2160,10 +2160,16 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_SUBSCRIBE_EVENT)(
 
 		event_sub = kzalloc_obj(*event_sub);
 		if (!event_sub) {
+			subscribe_event_xa_dealloc(devx_event_table,
+						   key_level1,
+						   obj,
+						   obj_id);
 			err = -ENOMEM;
 			goto err;
 		}
 
+		event_sub->ev_file = ev_file;
+		event_sub->xa_key_level1 = key_level1;
 		list_add_tail(&event_sub->event_list, &sub_list);
 		uverbs_uobject_get(&ev_file->uobj);
 		if (use_eventfd) {
@@ -2178,9 +2184,6 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_SUBSCRIBE_EVENT)(
 		}
 
 		event_sub->cookie = cookie;
-		event_sub->ev_file = ev_file;
-		/* May be needed upon cleanup the devx object/subscription */
-		event_sub->xa_key_level1 = key_level1;
 		event_sub->xa_key_level2 = obj_id;
 		INIT_LIST_HEAD(&event_sub->obj_list);
 	}
-- 
2.43.0


