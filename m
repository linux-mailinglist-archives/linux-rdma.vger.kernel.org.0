Return-Path: <linux-rdma+bounces-22230-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YHJUKJy9L2pHFgUAu9opvQ
	(envelope-from <linux-rdma+bounces-22230-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 10:53:48 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D80F684C17
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 10:53:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b=GdKdhxbP;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22230-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22230-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB01D3020108
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 08:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B529F3D5C29;
	Mon, 15 Jun 2026 08:51:12 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97833C3C1C
	for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 08:51:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781513472; cv=none; b=SqLsMwbxPP+MKNjfFmqg8K73E6AlhTG3mo8q+Jx5ECtwJfNAkj7gI/XRsywEgEP9/nOrCF4H6KDaF7IGLZfiVp8oWtxihq9UKKb8ZqAmZi7y/q9kQEQ6BFdOubCmRpy7eQoT2bjbM93MVRi4KgikCvhkFGbHt6FN+jx0wlslY0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781513472; c=relaxed/simple;
	bh=NR0S+g6TnN0g+jVTvuEjzCJGt0dAxUuDmNgcnX7lbPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i/ratA2f/UBp+zHPH8FH3Ze8SOo+WBk+JIUazpmGV1aAorCu3eBt4DswZ2Bu+EjY7Z8qsLg8gJx6uts0I9tWVLkXubTtWmKdAUPlan0WRgxMXJxt2zDeUUggTAM4Ss4RGj1Nu9rFr7rsGCcEIi8bmgc+GRnb2XqHPBm28nmuhtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=GdKdhxbP; arc=none smtp.client-ip=209.85.128.45
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4908b92904fso37527325e9.0
        for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 01:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1781513466; x=1782118266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uPY4RZH48U9XwVSnUM+TtcOa21lNhtUgEWK8c7StwMc=;
        b=GdKdhxbP9noyQa4HKnYn8g3vIJWRymb9tXOXtAtz5s6bDkV1Qi61VXQ/UirYTkCvyA
         L0kLb/BFbuOoJmEdH21fskEZ4MNEJq2eaq5Dt1bI6awrtcwq/FSvVvpScaPXF/fuq0wS
         V1WKur2YYBaS/JXgfg0lY563yFutGnUeKdranxLt43xxkobHJqm1AoiNB+E5Z3+KypzZ
         IkzubMBu4uH5cCMn2NGMgCTl9nQYWmenAtxAnX30i6vM3ZDLbaaYmLyZt39kA2AI5Gdm
         abzmMlZRZa+s5Y9BMVS5cFBp8CK0xGkeygBn/cYNIcI1imfABMpKs1YGpcMbZLHJPHmg
         zpuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781513466; x=1782118266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uPY4RZH48U9XwVSnUM+TtcOa21lNhtUgEWK8c7StwMc=;
        b=BsAfAYDOd/j2T8C5V9LINVMExT3hPlTJ4uT8SsRgL2qQNZoNr7Tmmb6+Dvj+qgbuUa
         new6ainxVrOiuLX/DwOUIwwXx1XK2O81DbY2T5UkvbyZD1Wkx2qq6sdfn7yBwRjlTRPy
         l8fAmn1Jc58LZ5ELo26EjEIn/KqFPC2hkpyOe2cTRZ1h5b/JXWtdHecnyz5xdc/aZ1mH
         t4ppXkAtaahjSodRfCt+r1MjwLqlNp0W1hahyDllsQXre8hf0jCHvOisJRO07M4SBf4h
         jK/htZWGqg+LzdVdNRnK2FRvqQvr3ZwwZxsYr6DLWnW9Y3dzvEh0l0ofphGSxc9bTWEa
         vimQ==
X-Gm-Message-State: AOJu0Ywpk64BncTeS2SuL4AGHOJsVXndvRv0T0TZT6lD+FrWezEAthOL
	F/RuqO53cVMSrodtwWajBORZdPN3C8kcTI2cP+1PE61F4CaIC5WxLt434R8iI82TVCeuCe1mzrd
	GlZ2e
X-Gm-Gg: Acq92OHIWPAgOn20Mgg4L8OhLeYWaqMPGlS8kKULJlg59Pj0KvaDDO4V9XbZ1OlffzT
	7Jf+zChMUPms0WEHoDvIwTPl3ywFPfkO0Jt64iR6icljJgQUhHfqH3z7QUVXWoxI/Ir0K0eA/jZ
	519BUUEMmhS6WFZd0/l5rJFF583JE6ivYRevfMO7OMCZw+lWN0ziu7GttqZYJVmVdbAavjeaO/4
	d7SPZ9NJLBALIuMJClvX5hejAgwSC7MlgRWHsgsA14NivOOEORyh7TYAEY8JZEa+1lhh6G8kpLQ
	4Hvn7Fd+5f2afIBgN6pnA2eG2bJeBcsVf8Oo3V/WPjjYGAjPmQK/6FHMcys0dOJDCgSkMBHvEYf
	/5H69owkaBzFDX159P6rC4swoZkBfgYc0WnMkrVFUbUP6DlA5/72/CZctM1/qJlvvRfPjE1Fn/i
	kjf68hiHgn5evgHN9l3Uii3GGoUQv01Re3
X-Received: by 2002:a05:600c:e547:20b0:490:b58b:a8ca with SMTP id 5b1f17b1804b1-490ec50c366mr113062465e9.27.1781513466259;
        Mon, 15 Jun 2026 01:51:06 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea95c51dsm224566675e9.1.2026.06.15.01.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 01:51:05 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	mrgolin@amazon.com
Subject: [PATCH rdma-next v2 6/6] RDMA/mlx5: Use UMEM attribute for CQ resize buffer
Date: Mon, 15 Jun 2026 10:50:40 +0200
Message-ID: <20260615085040.1396623-7-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615085040.1396623-1-jiri@resnulli.us>
References: <20260615085040.1396623-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22230-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-rdma@vger.kernel.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:mrgolin@amazon.com,s:lists@lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,resnulli-us.20251104.gappssmtp.com:dkim,vger.kernel.org:from_smtp,resnulli.us:mid,resnulli.us:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0D80F684C17

From: Jiri Pirko <jiri@nvidia.com>

Use the per-attribute UMEM helper to pin the resized CQ buffer umem on
demand. ib_umem_get_attr_or_va() resolves the new RESIZE_CQ_BUF_UMEM
attribute when present and otherwise falls back to the existing UHW
ucmd->buf_addr VA, preserving the legacy behavior.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/infiniband/hw/mlx5/cq.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index 49b4bf148a4a..a2d574aaebe1 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -1245,9 +1245,12 @@ static int resize_user(struct mlx5_ib_dev *dev, struct mlx5_ib_cq *cq,
 	if (ucmd.cqe_size && SIZE_MAX / ucmd.cqe_size <= entries - 1)
 		return -EINVAL;
 
-	umem = ib_umem_get_va(&dev->ib_dev, ucmd.buf_addr,
-			      (size_t)ucmd.cqe_size * entries,
-			      IB_ACCESS_LOCAL_WRITE);
+	umem = ib_umem_get_attr_or_va(&dev->ib_dev,
+				      rdma_udata_to_uverbs_attr_bundle(udata),
+				      UVERBS_ATTR_RESIZE_CQ_BUF_UMEM,
+				      ucmd.buf_addr,
+				      (size_t)ucmd.cqe_size * entries,
+				      IB_ACCESS_LOCAL_WRITE);
 	if (IS_ERR(umem)) {
 		err = PTR_ERR(umem);
 		return err;
-- 
2.54.0


