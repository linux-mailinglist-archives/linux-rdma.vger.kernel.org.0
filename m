Return-Path: <linux-rdma+bounces-19713-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKpuLIY48Wn4egEAu9opvQ
	(envelope-from <linux-rdma+bounces-19713-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 00:45:26 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 539B948CC23
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 00:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3C1F7300B597
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 22:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70409381AE3;
	Tue, 28 Apr 2026 22:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WV/NZNR8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8F937F8DB
	for <linux-rdma@vger.kernel.org>; Tue, 28 Apr 2026 22:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777416223; cv=none; b=KOnQCF6yXG8rfVHKSEl0AMFLs/v/0G3I04oYPSzGYWSJEmpyq714B9Jybulkc90IqUfEO1C25vKzLUIBcb4AvaFzI+qzc+KJsHOCp8X9nQ0wy1VjVjeS0llvbGu3i6lttznq/r8bxKNzCXyvrXtT+XM+084qhF6utbmnh7sxtgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777416223; c=relaxed/simple;
	bh=iYv+2vCSh7ekf6vNdDj7xBAkRnM/Nwz2fkMJWksszM4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z4/k20mlJBo8qu/QpxRMwjNE26dRn6VpAEtIphgVng26OXxsUBBUirhzXB+fKN2lm1R7XpLv/9TxzJmow88t3+axPVCHPNxEEaXY7I2XzfXDhPRsnUmyBq5paFAImEcoUSXX/zjsqIscffs8vsftCfu+bSBVHrOCmQ0X2gbkhkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WV/NZNR8; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-44509921fbcso1717347f8f.3
        for <linux-rdma@vger.kernel.org>; Tue, 28 Apr 2026 15:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777416220; x=1778021020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DD9EGaci6HkgE3pm5bh6W6PLldGlybHFeBAUFYCl54o=;
        b=WV/NZNR8Ne5tuED2dU+58P2hSVAU3Zcfjiak7d9ooVyE+WDT9QQ3VXGeT4IYTXTi38
         4NWVloL8Jy8yy/JyFcKsnVVNqHQ0d3j9HEEpNOBVOFrdJ37Tt6DD9tlVaPT2utN0pT9M
         yWUqO7jVZhLb1t13wXuseOUfgMuvqmdiXZCdTH59AT30YG6dZkqsZuGBJjI16P9XbIOy
         SwcnZljWmUp4YDWBirMYo3DXfzu7Gl/etcHiZ0TMwzCZ81UeMCQ10Ux+nMd8AMWoBMhn
         t6teAMso4rF+TIfgH3jyntDYF+EqwSrHiSrbKFFQaswtBhJkpxgQPAhbWlS3WcLXKjEc
         4FKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777416220; x=1778021020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DD9EGaci6HkgE3pm5bh6W6PLldGlybHFeBAUFYCl54o=;
        b=G9kScaRhyz+hB2kW9g004Bt09pmLZsTaCETwREsjB30RsXUG79bg8X2AhlmRePLucD
         HLUzDnJzJp1rzOr8/klsNGoSHNOG1qPEUcGVudNjruZifP013tnwBqqjEA1UfeZvP3qF
         fwpbP+MOcxs3gNXFwv/372JmDgrfG3jj4Slp3MWHv8tOjbgcxSfOThkJpE6QuSqZ7vr7
         FI/Rjt4DGL5c5cbnxCcu5IzOOaPylaHCB347p4Mk6zrzqoiprWlR39f8JjGGwqq7Lh0G
         6hy2lcQQJehArxpVGc4PexHryUbbOZbT1LJyPo4C7OxnjcR1gqEv3KgEtZX0yDDxIE1z
         13dw==
X-Forwarded-Encrypted: i=1; AFNElJ8pWwktn0Gzrm1LrdkmGmD+2xFbW7u1Wc/ZWAqnQxbaEyK/ti6AJK38llssXK9tCu5dxKc4TgHVZT2n@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu4yAW+E+oCxcF/rSn8IysJUZ3vM+mKFQ0pHw6PpwaUDzJVyZ8
	IkXKFZK/FjWmHRn9HA5LhAS0QUNtgI3hks0UgZ2GXkdI95RGGExLxbrYDKM+2LwG
X-Gm-Gg: AeBDieu1RFf6G6mffFv7V+HgsP+QNr1DGEvAvwCrtDMbZNAp/oaidvXgUS3iKWvA40G
	ls4/ydfOARoTuFALxWcH12vpDRNmhErA0ueAubEVVV+gpjk8CG3hFE0h1jWbehYI2AMVWtQMd17
	5q9b2yD9i8MLVLPDjDdp8rPlnvmliot6HrnLsW2T1BBN8+d2h/wAN4JI9zxSRJ6VvGZFbkDD5jj
	URvpffsTx18FerZCI0EgId1VnsnJfRFtrMmhElxlXZ1BZLZ7qEbmbtupoIeKEkC/RZxkK8ow0mQ
	X9OkqFIe7NiDlZgukuX+vWNSx8VXQKsnFNNF+dyZedYVI47TBbUVtdFz+aD7gP7e7BOQLzAOi84
	SC0ruySVwg0uEJ8ungG81mm3s9nja+l64+08058OCz+hawRIbJNcTVzJwwHoKQLkW3F+Ksys500
	Mbw3Xu4zfEXHMPL4ZozARyne7lIsvVcYUnfApsZjVQoivEl9jXwHYEdG7Wa4kAfJbfwhXg/G8iv
	ztLeJxiW4yinM2Ozeo+ist9vlf9IsWL/Mz6WuibHw==
X-Received: by 2002:a05:6000:250e:b0:43d:7bc9:9b2c with SMTP id ffacd0b85a97d-4478e993497mr1821523f8f.17.1777416220213;
        Tue, 28 Apr 2026 15:43:40 -0700 (PDT)
Received: from SD.localdomain (heme-13-b2-v4wan-167795-cust403.vm32.cable.virginm.net. [81.108.45.148])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b3d47ff1sm1073294f8f.6.2026.04.28.15.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 15:43:39 -0700 (PDT)
From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: yishaih@nvidia.com,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Subject: [PATCH v2] RDMA/mlx5: Fix devx subscribe-event unwind NULL dereference
Date: Tue, 28 Apr 2026 23:42:49 +0100
Message-ID: <20260428224319.37682-1-prathameshdeshpande7@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 539B948CC23
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19713-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[nvidia.com,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prathameshdeshpande7@gmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

MLX5_IB_METHOD_DEVX_SUBSCRIBE_EVENT() links event_sub into sub_list
before initializing the fields used by the shared error path.

If eventfd_ctx_fdget() then fails, the unwind path dereferences
event_sub->ev_file in uverbs_uobject_put() and calls
subscribe_event_xa_dealloc() with an unset xa_key_level1.

subscribe_event_xa_alloc() creates the XA entry exactly once for a given
key_level1, on the first occurrence of that key. The unwind path must
therefore call subscribe_event_xa_dealloc() exactly once for it as well.

Enforce that by adding devx_key_in_sub_list() and calling
subscribe_event_xa_dealloc() only when the last matching pending entry is
being cleaned up.

Fixes: 759738537142 ("IB/mlx5: Enable subscription for device events over DEVX")
Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
---
v2:
   - fix duplicate-key unwind by deallocating each XA entry only once
   - add devx_key_in_sub_list() to detect the last matching pending entry
   - keep event_sub->ev_file and xa_key_level1 initialization before sub_list insertion
   - update commit message to explain the duplicate-key unwind rule

 drivers/infiniband/hw/mlx5/devx.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index 645ebcc0832d..c2ae5a140471 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -1913,6 +1913,17 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_OBJ_ASYNC_QUERY)(
 	return err;
 }
 
+static bool devx_key_in_sub_list(struct list_head *list, u32 key_level1)
+{
+	struct devx_event_subscription *s;
+
+	list_for_each_entry(s, list, event_list)
+		if (s->xa_key_level1 == key_level1)
+			return true;
+
+	return false;
+}
+
 static void
 subscribe_event_xa_dealloc(struct mlx5_devx_event_table *devx_event_table,
 			   u32 key_level1,
@@ -2160,10 +2171,17 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_SUBSCRIBE_EVENT)(
 
 		event_sub = kzalloc_obj(*event_sub);
 		if (!event_sub) {
+			if (!devx_key_in_sub_list(&sub_list, key_level1))
+				subscribe_event_xa_dealloc(devx_event_table,
+							   key_level1,
+							   obj,
+							   obj_id);
 			err = -ENOMEM;
 			goto err;
 		}
 
+		event_sub->ev_file = ev_file;
+		event_sub->xa_key_level1 = key_level1;
 		list_add_tail(&event_sub->event_list, &sub_list);
 		uverbs_uobject_get(&ev_file->uobj);
 		if (use_eventfd) {
@@ -2178,9 +2196,6 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_SUBSCRIBE_EVENT)(
 		}
 
 		event_sub->cookie = cookie;
-		event_sub->ev_file = ev_file;
-		/* May be needed upon cleanup the devx object/subscription */
-		event_sub->xa_key_level1 = key_level1;
 		event_sub->xa_key_level2 = obj_id;
 		INIT_LIST_HEAD(&event_sub->obj_list);
 	}
@@ -2225,10 +2240,11 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_SUBSCRIBE_EVENT)(
 	list_for_each_entry_safe(event_sub, tmp_sub, &sub_list, event_list) {
 		list_del(&event_sub->event_list);
 
-		subscribe_event_xa_dealloc(devx_event_table,
-					   event_sub->xa_key_level1,
-					   obj,
-					   obj_id);
+		if (!devx_key_in_sub_list(&sub_list, event_sub->xa_key_level1))
+			subscribe_event_xa_dealloc(devx_event_table,
+						   event_sub->xa_key_level1,
+						   obj,
+						   obj_id);
 
 		if (event_sub->eventfd)
 			eventfd_ctx_put(event_sub->eventfd);
-- 
2.43.0


