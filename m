Return-Path: <linux-rdma+bounces-22121-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +LkyD1bRKmrmxQMAu9opvQ
	(envelope-from <linux-rdma+bounces-22121-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 17:16:38 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A6362672FE2
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 17:16:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b="f+Yw/cR0";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22121-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22121-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4B376311B4B4
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 15:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DDB3FB7F3;
	Thu, 11 Jun 2026 15:12:55 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D783F8EDF
	for <linux-rdma@vger.kernel.org>; Thu, 11 Jun 2026 15:12:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781190775; cv=none; b=GEqzg3RNsV61ySJMCHyhraYiZXY5SG7zjz7JMDM43kT9lv2PiWbEe8YMiIR7kS/2ad8R1jbevwyyGBLPot9QpM0COLFNkSc0OkirQDxI/GR+kPSlP3NQTYUgQODme+bn0kRZNh69/cc4lCM5FS9B47IcqRvxgYYX1X/uL2mBdxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781190775; c=relaxed/simple;
	bh=NR0S+g6TnN0g+jVTvuEjzCJGt0dAxUuDmNgcnX7lbPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lKJe6/zs6IbIofgY9NISmA4lsqq3INxgKM4WnXPiq/u5VjqY2OQtnO7+g7heSTb15vt3TXp+/f2KgeFIyfy2hbwIeDIpXLDoh2h8GCNaZP83YsTQeZaPhEaHEYmeFrdqSsDEsp4R5kmWaygPyxv4rgHnSTcY0qLHoT+RimgV5G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=f+Yw/cR0; arc=none smtp.client-ip=209.85.128.42
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490af320e2aso91408325e9.2
        for <linux-rdma@vger.kernel.org>; Thu, 11 Jun 2026 08:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1781190772; x=1781795572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uPY4RZH48U9XwVSnUM+TtcOa21lNhtUgEWK8c7StwMc=;
        b=f+Yw/cR0t2uUWWX9MYF7ssJ0TyIvTScpBUvRZIlyd2sqMHOoOu9WZS5glHiIZtD7pR
         pN5cpGpds5QrdHoFt0w0pMYe2R+XWDVFgiYU8t2nCnw5gOmpq2gZZm/mWl40qGYO5CXP
         vptqKbeSMS5HpUVVdqcvqfSCJ8DO9Q/qApIH7iIuFdEgOs9TZV2m3d6yzeYX5O5nOGWc
         foZzCOVKSRd7MHp753ompUnmAZ7zS53FfKYzNxkc1zIBH39k9K7slac0812OXyqaTl6N
         4eOHpSDJ1oqcjySCcTMMJkjjU1bkVTqjy2VpesXRps2vEMmsDEOs6mshZjQsiA6DXRJN
         qlXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781190772; x=1781795572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uPY4RZH48U9XwVSnUM+TtcOa21lNhtUgEWK8c7StwMc=;
        b=OxZJYqiGY11BnmZ1zNl715zQdqfmfq1L2eI9SqpsoG3mO8eLh7hzNBigIgqFuGrqoN
         AVm7bghUJTXNJnJtUqpj7dyBXGbud04Lqh5cf8RIOvVVF2H8LM3VhNORyacvyHyNclF3
         3gdqCDtWwYXIVRtQ6i3LR2HtkAIQ4/uKXw3N49YE4zwCQYdsifpfTZ3YD0M8wNXqr9Zo
         DfSjfhoJedIP0sjQBxKSQu6WAKsh+e0X6rDMQdaAr/AvpTDRFe0Qpq6rhgUuTC8GUkoU
         5Vjf8POjWIKdEsKlxCz58zTTNXz8gyl/qOnM9xiAdlL3gs1823U5gzhN9RlfFjMse0N7
         bDqg==
X-Gm-Message-State: AOJu0YyUjAo2edmn+5ZY4jgLRABKQb6loSPLzrjBhMh1c3EQ+kd1JDZ0
	3Sue2bTDguc0MjjdIvG1hnlUS94zkBS42RJvfjDHjmWqN8q5s/JNiLwrDEQZD8u9I8Fzc6AVUjr
	JEZiwXewElw==
X-Gm-Gg: Acq92OGIWARXfrEiSjxO26F8ngmEkC416TH+PS0MZubdWg6GkXqrPOqO3ZRzl4bpbI7
	PR/W/SNrWo9wB//FnFGrpl6+96qKcYpmfQfFOSvKykFt3AGvMtpXY5S+V4Svr/l01UplfozTg5Z
	KwxsuGFHVDr+jxRGW/AphxStfQstHxXZza9ezgM/cxBq8bWeRQh3k0PS57evR+H2zrv3mgAI0rC
	tqAyCqGyjK7gu3mmcNinZVzN5mspNsnriBJ7OHenRBmMMX4Ea1GLnfvH6FlO0dGsm1nxDMyO6Ny
	rV/PWVMZBjALp9Ka6edqg88LcHwWyadwOStvyNBqzSkBmafr2+TT36xshcRBcTMA5IvXrlFlLuY
	ppkODpsGXZgErjSOx8E9AscGvs1wZgFrVqZ6jrVvYZoXu0XiDkqTSn1Clq1jnHJhB3foVqJi3OH
	61kMKXYzrDagQToCCNyW+wCgXv+McitH/+0VsrRD5PjXE=
X-Received: by 2002:a05:600c:3b19:b0:490:e5c1:b8c6 with SMTP id 5b1f17b1804b1-490e5d0fffbmr48706285e9.8.1781190772012;
        Thu, 11 Jun 2026 08:12:52 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e52a553csm61744125e9.2.2026.06.11.08.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 08:12:51 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	mrgolin@amazon.com,
	sfual@cse.ust.hk
Subject: [PATCH rdma-next 6/6] RDMA/mlx5: Use UMEM attribute for CQ resize buffer
Date: Thu, 11 Jun 2026 17:12:29 +0200
Message-ID: <20260611151229.879514-7-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611151229.879514-1-jiri@resnulli.us>
References: <20260611151229.879514-1-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-rdma@vger.kernel.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:mrgolin@amazon.com,m:sfual@cse.ust.hk,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22121-lists,linux-rdma=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
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
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,resnulli-us.20251104.gappssmtp.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,resnulli.us:mid,resnulli.us:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A6362672FE2

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


