Return-Path: <linux-rdma+bounces-21267-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6A2pKfwzFWqPTgcAu9opvQ
	(envelope-from <linux-rdma+bounces-21267-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 07:47:40 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1536C5D0F31
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 07:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A5F9302F3AF
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 05:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17BF3BF689;
	Tue, 26 May 2026 05:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6//mGGv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB41384244
	for <linux-rdma@vger.kernel.org>; Tue, 26 May 2026 05:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779774420; cv=none; b=VPErO/J4FCjWd8tjNSxiXDdykEsbTUr70xBcy01WzC4CZ1v/aSbjTqbzg0NYv0h1MGQv72o4tt3QwtKku4QbguRKHE5OvARUdd2XkYtVL+5HaXfx3CvW/K1I1QAazv9XcJwnB+3o9RaCJ4M5ZQ+0zNn+4wr5+gJiab+gha2GXd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779774420; c=relaxed/simple;
	bh=PVDzbIBA4YjAagmd+kztB/cOqPXnioxFk7d8OQzLPtg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C/qSggjJURnHPdm0rk5aKG5yN/KKNf9x96uWMPpFpbzxqd3GUWF82/F5MNSLzFexvdQHh1eFB1opk7DxwUMEE1Z20IMhKrbs0l8OUZ00hqnqgY0Oad9fVRkFeSNYLr00+3XkxIHhjrgLRF0JdUm8Lr/JNTjvREnTOUprDY20hm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6//mGGv; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-837b39eb078so7037461b3a.2
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2026 22:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779774418; x=1780379218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0PzatHJgmkNNzl7148vyb+AgfWDZJiRwa8PGXGAHFI=;
        b=K6//mGGv6V/ytxEWbOyr/XQCF6ryE1OiakQcuhEyI6jkY10Jis8o1b3qFaTwl9NdsW
         hqTm0QaiyZWnKSgNRvbE+YUC3WS7QZzC72SwqogqzzIL1YeWg3H9Oi0ycWQaceWfu5oB
         ksnvfZ7J8Ot2OSJwdEoNqQEGrOKYa2qybLcqjsdFlQkyiCUilzNI8jH726JEG2G22H27
         N1FWU7dTpNeV9/6Ot0g7NARQmke2xvoB1gH/8Hb1htiO0el7+kLpVscajB/atTWvrMpN
         K+UdtTcGQYBbbQA+D2X8t+W/L60+KsUdiSfqQkh29umOpfpSR8lQNxABMc+xsn495y4X
         DuQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779774418; x=1780379218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u0PzatHJgmkNNzl7148vyb+AgfWDZJiRwa8PGXGAHFI=;
        b=sHv0yt02ew7FWmOhl0vE3SlgrzHI3vq8dPZhUXO/ho27GBMUhDEX2eLrF+9Ml5x6XN
         ZqVn/PLsR+0jMiVPyygSq4hSLkKLygYWzeXDXB8j85jBIPcN+ybwy90ngUVkpcwdE/VP
         qjeI3Qq6i1MGYiKngl4pdQYE2n4cTWhGdIX+dAkFxmMu74qQXhpbYaNo+yHlWwBrlKyx
         vDB9ORc4qmd6eHgCzrOK3ZIlDhGe6PSZhwlDuOTaBkgpBXa/gWZWFzGAs5kkf9iCesSt
         5AQRbsDB/2K/v7gE8W6EFDh6dukMzqybFO3qDWOpE3z5hFhFpl0MUTr2/86Zq+quqyCz
         4QwA==
X-Forwarded-Encrypted: i=1; AFNElJ8pXzeyAPhFDEK1d2MLUxngUho8nptsEzp2AKfa7hToweW8eghHZ9QJraO/9Ksg8XLIbmO09DEZqAB/@vger.kernel.org
X-Gm-Message-State: AOJu0YwBT8EEs7cnx9We9/p4n5EvmKEEcC1GRYrKV9C/3flin4atsHVv
	bZuAr+R5uKiRXaSvmRZuZawNRYsA9KlssUUz28Et2o5+C4Lv9lOag3ZBTlA92w==
X-Gm-Gg: Acq92OE2TAFN628ycWs4ubVn13d58fqZMeRRpb92niQagJrS6cu1522GYjk/JZx2dfo
	cKK31uUr18FGJJ98uly27fyS3a0nVT2ooFJSi9ZxfsLfmn1erUkb5zj7L+Vs8lJQRGPA054G4Mf
	fPaZfvPjsx9XNRUArNN9EBUU/tr6qBT12MtOWsGVaqukZ9QHh69kfHN5Sj4D1AUxu1qqE82NRuQ
	whjUSZG43GjLPveD2Pu0UGkC3SiZub3Ykr0B67nRdr7Ry4jzhMRr4/w/4TUNKuy46j9bKJRwcoW
	EabpKSn7KZcRe+LdQ3zsLsWUXw6HqdpL4XAKDXTfT2zSKUjiQ2d9zETtgg7ezvG02fb5i1E82Qd
	KTlIRhOPOY6JX8vatDnR+CsAOZ69OK6rfZnyz578P2dS5giJ1gypxtgn+H5ebj5A+CKeu/Xbj1C
	46zdxSdbOG58xbzOf6s/Ya18zVEFxUXHCZwqNcobjJn4kAfYU7
X-Received: by 2002:a05:6a00:140f:b0:82c:b808:4c59 with SMTP id d2e1a72fcca58-8415f687146mr16176516b3a.46.1779774417666;
        Mon, 25 May 2026 22:46:57 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164e9ec47sm12917142b3a.32.2026.05.25.22.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 22:46:57 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Chengchang Tang <tangchengchang@huawei.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] RDMA/hns: drop dead empty check in setup_root_hem()
Date: Tue, 26 May 2026 13:46:53 +0800
Message-Id: <20260526054653.2054800-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260521132045.3430906-1-maoyixie.tju@gmail.com>
References: <20260521132045.3430906-1-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21267-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,linux-rdma@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1536C5D0F31
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

setup_root_hem() reads the first entry of head->root and checks
the returned pointer against NULL:

    root_hem = list_first_entry(&head->root,
                                struct hns_roce_hem_item, list);
    if (!root_hem)
        return -ENOMEM;

list_first_entry() never returns NULL. On an empty list it returns
container_of(head, ..., list), a non-NULL garbage pointer that
aliases the head. So the check is dead.

The only caller adds an entry to head.root right before invoking
setup_root_hem():

    list_add(&root_hem->list, &head.root);
    ret = setup_root_hem(..., &head, ...);

So head.root is guaranteed non-empty on entry. Drop the check.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
v2: drop the check entirely per Jason's review, instead of
    converting to list_first_entry_or_null() as in v1.
v1: https://lore.kernel.org/r/20260521132045.3430906-1-maoyixie.tju@gmail.com

 drivers/infiniband/hw/hns/hns_roce_hem.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
index e7c9e30ad2d8..61cd9f96423e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -1269,8 +1269,6 @@ setup_root_hem(struct hns_roce_dev *hr_dev, struct hns_roce_hem_list *hem_list,
 
 	root_hem = list_first_entry(&head->root,
 				    struct hns_roce_hem_item, list);
-	if (!root_hem)
-		return -ENOMEM;
 
 	total = 0;
 	for (i = 0; i < region_cnt && total <= max_ba_num; i++) {
-- 
2.34.1


