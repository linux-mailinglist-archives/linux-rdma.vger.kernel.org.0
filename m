Return-Path: <linux-rdma+bounces-22117-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pYxcIBTRKmrexQMAu9opvQ
	(envelope-from <linux-rdma+bounces-22117-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 17:15:32 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 32711672FC9
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 17:15:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b=Orw2jSL8;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22117-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22117-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A4D0D30BB63B
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 15:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4283F1AB1;
	Thu, 11 Jun 2026 15:12:43 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD59B3F0773
	for <linux-rdma@vger.kernel.org>; Thu, 11 Jun 2026 15:12:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781190763; cv=none; b=Hrr9DqVzzsCxxCtFUZ9iIeH9eF7ueuoVxITtpXIbj9DZCuRrgu+fDQrbUQJLJVnUUR77j0sMd33HI4tBjlOya7gwc+P7CTqcHp75J1WSVzDTNoW7hVueoxgaZYNxG8cZOo2Cg4rJXKI7wDzn2FZQmk4d8BjCGI26eD6E6nxufSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781190763; c=relaxed/simple;
	bh=1dtjekxpal9QSMlkmnf2TJ7lm8VDz2yYsV9PGORCcMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=amxHHqWIqilBcboajnI1kxUvc9O4CP/ifezchhwOYc00zdX6ylUmjw7BLdEBt4sL+VAGsr3PtwBlrtXsHtxJkIFYz8FLaanXxZHO9K6TCB4JTAKqT/vK3P1aHDfjSGkNzoJcxstkoEU6IPpvQVSTWEVrj9r//NPgCLUlZyNaYkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=Orw2jSL8; arc=none smtp.client-ip=209.85.221.49
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-45ef1629ff4so5612539f8f.0
        for <linux-rdma@vger.kernel.org>; Thu, 11 Jun 2026 08:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1781190759; x=1781795559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=735A05IgxdrJE6zOTsFT8JH9LSGF0txx0m0v/Bul06A=;
        b=Orw2jSL8Tm7yq4fR2cVL+ko13WuYOlWIOy72tbPrQduetfv7oTZfvBml3sqLR0OAL3
         Nkg8wgT0hYG9O7u/gQgTk1ktJJPfhe2UfJrvj09X0qVhWTfNsNvpGNv7qlw6YsNEvfbk
         Q3Q9mM5bAsl2hybXFMhyhHgG0jyU/IUf7ZzPNAb0lmUqvb4+nH9ZILGm3/2SKWy1C/HP
         AWf5mDavZgoyA7zer73+rF+NxS+gOJSEZlihKH4SrvLcU7c3WUe9dAWEzJmXh1VjMvoX
         y7Zv2oG1BrOuGgUprDRdFNi1HO0kMbzJtW5CbmRZaFWLvGRRoW/iSUWbDMHplatdGcEK
         5J0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781190759; x=1781795559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=735A05IgxdrJE6zOTsFT8JH9LSGF0txx0m0v/Bul06A=;
        b=GBgd/SvF2AvplMRe8jJSHDLP+gwGpMEHwioZ73MGtlA4LGINp3L8Vne5QMWC4zDBGO
         Fadc7306JIxHdffMzmK3m6kKNvBXSLm1LJKKZYp29/NRxFgbIa9jLjbTj4xLuwsXllkT
         LMA9fnpv086rO+uv4e78eQ2h9N6bsjNnHrBdTYpH58t8YhvpPxRayUygWda9VX8yGhXW
         52BmoFBd9eMZanZyQcOGS5yn6oEsdSXrprmNb9eKpSLDNWj4zjN252MdpJgdQs8HrMoL
         B9kw0c22X73K6bb2UT3lN7Z+/UtBZiIb88r7JRNWeJQDYlJnaZVfvXHVaIqux4u6PXoZ
         Pk/g==
X-Gm-Message-State: AOJu0YwJKPEqBrG94kNfp/TiiHhfIPDnCh0R2+MduMRp88PWImmy470J
	q1s03u3kYEpREzajlf9Zof8e4S4DRbqD8CJOB2lvP50XtWbleiUvjh90MJ0h26JjE4ResRLcu0A
	s7L+ggtxr3w==
X-Gm-Gg: Acq92OEkn/TQYCEG3NVZNxrJWHFq0Rqt2ArtHGjwWtuXZQc2uNhXdTTO9ylQVOPMoUz
	FtZg9ou2JFCXbWTxWfz936INQwSgHQWMdfjZ89gyb9DwoYUSeuzL6AOaylEW6BLo9Klt6pJNWlP
	0fTgMBKohLjhVtGGTiFy1lxXX4rmJuxOkgd1wvkMdcrWHVlJY3FpVi4eY4R+TzpiJQQsJ1mGGeX
	PPtWmX8GqMsDrylFh59bRW2dy0lJcC/H7lruVYA/c59Ss6XGfk4xWygYhwQ4cpSC/T9qkPhdYOM
	yc+kPBwAVUzlPQeSCgXk7v/xLMUslgLqn7RzbK390qp79jrWG5z0hd9oACrUNAZv7Je4mv1cXmV
	hlmLh9vTN+r2q0XOvcYUuiZokbCLa0wQRK9rEShBJZAgXb46Olc0JgPW/FBqSo0CX9FFkeRfKn7
	b9PQYpBVjaSekeLVZEjBb24xy0hhkIx4Cu+FiC9WtR3Ec=
X-Received: by 2002:a05:6000:25f0:b0:43c:fb48:6856 with SMTP id ffacd0b85a97d-46067599154mr4906642f8f.13.1781190759265;
        Thu, 11 Jun 2026 08:12:39 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcde3sm83648526f8f.1.2026.06.11.08.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 08:12:38 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	mrgolin@amazon.com,
	sfual@cse.ust.hk
Subject: [PATCH rdma-next 2/6] RDMA/mlx5: Use UMEM attribute for SRQ buffer in create_srq
Date: Thu, 11 Jun 2026 17:12:25 +0200
Message-ID: <20260611151229.879514-3-jiri@resnulli.us>
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
	TAGGED_FROM(0.00)[bounces-22117-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,resnulli-us.20251104.gappssmtp.com:dkim,vger.kernel.org:from_smtp,nvidia.com:email,resnulli.us:mid,resnulli.us:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 32711672FC9

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


