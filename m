Return-Path: <linux-rdma+bounces-18158-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wE2VNN7qtGkuuQAAu9opvQ
	(envelope-from <linux-rdma+bounces-18158-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Mar 2026 05:58:06 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4C328BA13
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Mar 2026 05:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AC6530675BB
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Mar 2026 04:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E743491C2;
	Sat, 14 Mar 2026 04:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/yZ0cIO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9F321D590
	for <linux-rdma@vger.kernel.org>; Sat, 14 Mar 2026 04:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773464275; cv=none; b=hCdanedDk7PYCDyeu96DkWDDhslkNizhZ+DpKnTVFX/CXd9lwoaQ4SalkB7t8nuMK/4uGueXmFs4N/koTJ3/apgpdTC2Pm2W7cItTIn3yu8T+Ufvj+SBU5UkONQvuOOgIkTwxoB1GMdsHxgYeqGSwYAIloHJSElsjQVNaN+GMLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773464275; c=relaxed/simple;
	bh=Q7T7gEpRnDDwZL4aoZYYHdNq4RTmVw85HR/DS5ALarY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RECZqzr7ni2BSXBFWAWGF3fiTuynUwxAPOGm85K+Zeuoci1kvM3BUUQaUuFDraN36MGKSruLImVTPz66jGhccNcJ0/ltndMaPFLURfhFP7jJdok7wWAD4FdUU8LOWBUsGwhYJmrEqQKpZg4jHMBG61ICinekylhy0ZIm/TnDVwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/yZ0cIO; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-793fdbb8d3aso29964017b3.3
        for <linux-rdma@vger.kernel.org>; Fri, 13 Mar 2026 21:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773464273; x=1774069073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nkOHJmml1T2h8lU3WaH3WLJXiO/lx1Xa2aheZkpBFik=;
        b=h/yZ0cIOCWkHGC5fP7+yapZMAIA5E3jyaCY2VH2/0TcWeN4gX5ekTQF4JTJo/Vkq1P
         wnMMrHBWiGhhQ4S2rpoD1/JCyGr0BHLv2Ax3CTP4IgYabXJIl34v3MxBszF+9nLX7vHX
         efq9Ytg4tDtKIfCSB7nwA62pSUz6lox2i1VQBYl7Xi/Lt5pinpgpJXDIeWOB+Dkg2xXe
         02ym+gIS1hMueN7AhfI82g+Qbakk7sCgUoXTQcMaZ6DtSMNyP0f3DF/wMPASjwg9jVZz
         yCD4Jc1suOrRPV4nOr5hXfPpFVUCREnhoEQUA03eBJoD9ROGwux63Ana78t2T3YrDvt2
         NaOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773464273; x=1774069073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nkOHJmml1T2h8lU3WaH3WLJXiO/lx1Xa2aheZkpBFik=;
        b=npLzPLBPn5ZvFhzKN+OsphOLSPouks27I9jnUBjont5bRL7ziQ0tv31i+GHTK0Tlrj
         pzwvuulduNY2LUIl6fpCXQlIgB+beMjuoWXmQz8aiHsskKtcemcx9A/fqFh/kqbWSbsU
         2qWgFYoao3ZB5jroUyHfocaWhEmtHeGxJ8BQKcciAaP47L/lPogYJGvL5zA/Jxiv99IM
         UQ5sLXaHezDYq02n3LcW2AesxMiM+hl4HM4hQVm4iJKwaxXGIovX7EEaWzkOljYTiAwJ
         JJD3vRa7dvu0NMio+LTPPNMZMBFKDuMSFeK0fMG1o7c+eH+ekUORhnBupdgKFN7tT/VJ
         KgOA==
X-Forwarded-Encrypted: i=1; AJvYcCUM76QDOFy2Xhrq6Qc/A+GKjz107Pay4JAcTXBEPmS+/OjlTu2aWwCaOwLU0FnmRqA0HqAX22cr3xld@vger.kernel.org
X-Gm-Message-State: AOJu0YxA27XqkycQbCaVGt1+7vxfnhG5hvVk6o6mi0w5aR5MbS/5e1Qj
	DR2dooou5jHbdhLgUzNuSfztia8b7oAK9wZuY1YHoQEZvY1/ckUn3Th1
X-Gm-Gg: ATEYQzzNC9dLZXVTnhzpB473GQX8/vKgSCqzvrJtcNwd4d1H4XoHVceRfupuAdPuEV8
	2f/qAbRvtMcPXcX3osvYjHafwM5370XG0FB58XG5AK43z4Omeeaso7kdYYxXw4nylfdcLwSU3af
	KNIlKyKe664TBw5awejRmzbO0N27AP19XSFlYcI82v9Oa4LA/VdEfJC7aCrYvrV4/MFlBnp/AX7
	CcOXZ5YnzPGCTbZQUOFlOe66+1hK9z+/1ZnISc6qzRDyzscDxCH5EOtXWbFN8kFbMZl4AYZpdrM
	k36ZN+RJ+dEfy1JsoZSojiJPaGZ4YNL/8HfJfQBgJmNvW6n/3DyvB83erz764h2cUlPHTvMeBD6
	9HhmQ8Y+4XhKfu8++zm9ae+tGGooVPIIGOvQA+/pS58HjprnxKX0odMkGdM0PDNCrYCYrtrP+UT
	A/BJ40gjsyLZs011o6A88e1MJq/BzQOqqY5LBqoILWyoEVRK6FU9P3XLeJdZDxOigEexbFgE8NZ
	Qpnh+5JwgnRZQ+K/ea9Tw/b
X-Received: by 2002:a05:690c:d8d:b0:798:6619:f1cb with SMTP id 00721157ae682-79a1c1bafd7mr61299877b3.43.1773464272826;
        Fri, 13 Mar 2026 21:57:52 -0700 (PDT)
Received: from tux ([2601:7c0:c37c:4c00::5585])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79917de805dsm58007227b3.3.2026.03.13.21.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 21:57:52 -0700 (PDT)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: Michael Margolin <mrgolin@amazon.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-rdma@vger.kernel.org
Cc: Leon Romanovsky <leon@kernel.org>,
	Gal Pressman <gal.pressman@linux.dev>,
	Yossi Leybovich <sleybo@amazon.com>,
	Daniel Kranzdorf <dkkranzd@amazon.com>,
	Yonatan Nachum <ynachum@amazon.com>,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH] RDMA/efa: Fix possible deadlock
Date: Fri, 13 Mar 2026 23:57:30 -0500
Message-ID: <20260314045730.1143862-1-ethantidmore06@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,amazon.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-18158-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ethantidmore06@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7D4C328BA13
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In the error path for efa_com_alloc_comp_ctx() the lock assigned to
&aq->avail_cmds is not released.

Add release for &aq->avail_cmds in efa_com_alloc_comp_ctx() error path.

Fixes: ef3b06742c8a2 ("RDMA/efa: Fix use of completion ctx after free")
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
 drivers/infiniband/hw/efa/efa_com.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/efa/efa_com.c b/drivers/infiniband/hw/efa/efa_com.c
index 56caba612139..e97b5f0d7003 100644
--- a/drivers/infiniband/hw/efa/efa_com.c
+++ b/drivers/infiniband/hw/efa/efa_com.c
@@ -629,6 +629,7 @@ int efa_com_cmd_exec(struct efa_com_admin_queue *aq,
 	comp_ctx = efa_com_alloc_comp_ctx(aq);
 	if (!comp_ctx) {
 		clear_bit(EFA_AQ_STATE_RUNNING_BIT, &aq->state);
+		up(&aq->avail_cmds);
 		return -EINVAL;
 	}
 
-- 
2.53.0


