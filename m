Return-Path: <linux-rdma+bounces-22226-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5pLGC2m9L2ojFgUAu9opvQ
	(envelope-from <linux-rdma+bounces-22226-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 10:52:57 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FE9684C03
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 10:52:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b=teb6IziI;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22226-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22226-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4B19B301D31D
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 08:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F8C3C3C1C;
	Mon, 15 Jun 2026 08:50:57 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6223D3BFAD3
	for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 08:50:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781513457; cv=none; b=eBVGSp00sKQZNlnu/bS8Exbp+l8b/OW3HzdFL+vigpCWUIcE2vZRk85JIdAFa62XoxsQae9HWCpshepH8QxWvCkcNVcreqoTpI3u3pUFCYmiZEGY29D96d0feSO2HkdZdKcLDbfBI9lMmAlG4hFwQ7pCFzPJq5KcJ+EYnbXb2pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781513457; c=relaxed/simple;
	bh=1dtjekxpal9QSMlkmnf2TJ7lm8VDz2yYsV9PGORCcMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BSSbmord9rIY4kaMjZLCH9DmjhUAR5KIhjPVQZoKzfHa2Ltc7J92VuWw9aiVc8r7dAAiw1n/YWr/7NVvdT0H1CRPZDOehL+Wc6xSMRL8GUD719AtahKSF7gsrMU98gXW2455CoGJRTtwBjI6yiCnHp0WgIwTS7UAIGLXgKJHT80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=teb6IziI; arc=none smtp.client-ip=209.85.128.42
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490b613a17bso27021455e9.3
        for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 01:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1781513453; x=1782118253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=735A05IgxdrJE6zOTsFT8JH9LSGF0txx0m0v/Bul06A=;
        b=teb6IziITLl5NhPp+fmVYp2XvhHpSU4GCJtTNWY2pCGOh02jcw4R4qSN3DXxERcERb
         zDfaUQ+/itmZT4pkdjw2wS99b4gNdIxq+WDrjH9jLLdu8GTb1pCFBvrIr7WXbq5Or/jK
         5dyxwCNrGJ7WCpaD7UfzG+NYp6UPpUZzQMHQgX3llfLA/k7ZBEWmR2lJnAfZ36c9X0z0
         lunJxfbunzBxc6VteXnooZ4mz8Hu+YjwsabTuaZicNVMOTbf1P2N2eXm8ggVVl+Spu8l
         aBibiTViLuQDU+2sqXhTmmFVynYWC36+zGlj9tOwQOUa9GdTYOVlq9IknmryeK5ef7hX
         606g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781513453; x=1782118253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=735A05IgxdrJE6zOTsFT8JH9LSGF0txx0m0v/Bul06A=;
        b=aGfTtjCqscxoqpt/xOvpxrHXkFBWITbpXvzzAV9JvPZ1bYXTI4Dsw66ugse2DtBdTg
         P8ZhsZu4mPGMGFqTM8XfhJ4Lnzgk2GfAIyKsUFuWYxI1qNlXu0aLlRMw6oLk6oDsl5cz
         GuUfnbaznkECDonIn5qxFQi8OfOfMupcA5OtfnfDcaoWvLRVVHPS1FS5rOp3dRq0CA5Z
         dAoVS7G9kyjiVa1TM/aCZvw51+Q8ES6diXclfakOWWLLAs3+xPIIpq+k+t9NQT8bHlIx
         02anUa+lvP8JkdP9KJHoUpFaOVmW6EUS/bh8kFSp0w1YsxJAOW9Iu3c5KeqpNHJLGfAa
         av9w==
X-Gm-Message-State: AOJu0YyrrkhDA6J2webi824Ba9/V7NvEkPYHyz3EEnlPihBgg+uWtEl6
	Gafr0jx0mMU/Gl6qow/+8ZTkN06XG7qmmyRsDAm3/gZtRg9JVVQgV2ht/UnlhCKjNGHz5xpe+/n
	JBmC9
X-Gm-Gg: Acq92OE9Pui+KJtBj9UD3bB66SEL51fVttojeDbxz94L5pHoQ6AwEPly4dTnFYhPGll
	Yi/HsYmiUHC+5MU2LE5DE+8N8uFl2blnbZChhoeMKsFYXdnC3ruc3auC60jf9cMEhao9BLzUdPE
	XLZs9ifVpdyKZ+8lnsDXCl5cZ9BV8MFg8BDa3nO8SgUwZIKzmiaDyGFqyaFSPK8Ybwn4QBI0arx
	fSkgauRxDQ3DZX+lM1wMXD47iVsVFSozioDTDu2e0XHWRo0voT92zqwY7zP4VXJxKWLKGUHYZ8O
	+AzU3voDNqYB1uAqwAAzyB+8af+dqo3SsRzZouaNqfb1fyvBcJOOrN2YPSA96wQp4wAYT8sPQlX
	yCvp7YK9/KiaI+5+UAScXBdFXv33ELk8VNqeWS8VLvRn/xkrRDDMieFVj01GLdl36y+3pNxld7z
	Pu130xYgeRe8r7OJ5dPHIKVXwTonoNPSbL
X-Received: by 2002:a7b:cbc3:0:b0:48a:5565:ec3d with SMTP id 5b1f17b1804b1-490ec502d01mr119587005e9.22.1781513452545;
        Mon, 15 Jun 2026 01:50:52 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea963cf8sm194557865e9.2.2026.06.15.01.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 01:50:52 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	mrgolin@amazon.com
Subject: [PATCH rdma-next v2 2/6] RDMA/mlx5: Use UMEM attribute for SRQ buffer in create_srq
Date: Mon, 15 Jun 2026 10:50:36 +0200
Message-ID: <20260615085040.1396623-3-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22226-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,resnulli-us.20251104.gappssmtp.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 93FE9684C03

From: Jiri Pirko <jiri@nvidia.com>

Use the per-attribute UMEM helper to pin the SRQ buffer umem on demand.
ib_umem_get_attr_or_va() resolves the new CREATE_SRQ_BUF_UMEM attribute
when present and otherwise falls back to the existing UHW ucmd->buf_addr
VA, preserving the legacy behavior.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/infiniband/hw/mlx5/srq.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/srq.c b/drivers/infiniband/hw/mlx5/srq.c
index 5bc48fef3744..6fa4c5a9a0d5 100644
--- a/drivers/infiniband/hw/mlx5/srq.c
+++ b/drivers/infiniband/hw/mlx5/srq.c
@@ -48,6 +48,8 @@ static int create_srq_user(struct ib_pd *pd, struct mlx5_ib_srq *srq,
 	struct mlx5_ib_create_srq ucmd;
 	struct mlx5_ib_ucontext *ucontext = rdma_udata_to_drv_context(
 		udata, struct mlx5_ib_ucontext, ibucontext);
+	struct uverbs_attr_bundle *attrs =
+		rdma_udata_to_uverbs_attr_bundle(udata);
 	int err;
 	u32 uidx = MLX5_IB_DEFAULT_UIDX;
 
@@ -66,7 +68,9 @@ static int create_srq_user(struct ib_pd *pd, struct mlx5_ib_srq *srq,
 
 	srq->wq_sig = !!(ucmd.flags & MLX5_SRQ_FLAG_SIGNATURE);
 
-	srq->umem = ib_umem_get_va(pd->device, ucmd.buf_addr, buf_size, 0);
+	srq->umem = ib_umem_get_attr_or_va(pd->device, attrs,
+					   UVERBS_ATTR_CREATE_SRQ_BUF_UMEM,
+					   ucmd.buf_addr, buf_size, 0);
 	if (IS_ERR(srq->umem)) {
 		mlx5_ib_dbg(dev, "failed umem get, size %d\n", buf_size);
 		err = PTR_ERR(srq->umem);
-- 
2.54.0


