Return-Path: <linux-rdma+bounces-22224-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xDw0MO+8L2q3FQUAu9opvQ
	(envelope-from <linux-rdma+bounces-22224-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 10:50:55 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDA2684BB9
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 10:50:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b=uctdGJYm;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22224-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22224-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 24CAB30046A2
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 08:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89403C3C06;
	Mon, 15 Jun 2026 08:50:49 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F263AA500
	for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 08:50:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781513449; cv=none; b=WnYPXu4lBk+TbYmJlx95g0YbMtJ+Qao9R8MZFNezbyXXk9onZcHGI4F3Aj+i5K/K0KuKFV5o39kJ+ZMz/3ioW/EeuwEIPUFpE2xla68WSimjnkZbBeC4UqYtPygEKA6H0ScZbDKYtqkRCrwK9TzbH9oR6+XjCoadP9jGFYM0vzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781513449; c=relaxed/simple;
	bh=2VpSzCXHjERpiLBpjhjuGBMKte+7QCr6sryWd3OhH1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fojR0t9VtrIRwybrul8jaPeX6sTRAb2T82FVwYEDweUWEkwP11WpF+n0W6Ebbv8T4crlEo13YNf2qnFP467X3FhwjjP1jYeiijErmF9BQ/QkqryyLB+HO33ZQNLhNHPh8aDLn59xcyiCxUQQzOx240mSo5NC4W/slQjnyG8luYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=uctdGJYm; arc=none smtp.client-ip=209.85.128.43
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490be29c1c5so34307185e9.2
        for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 01:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1781513445; x=1782118245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mXNqs0V6Xe4qKcXiOexhD1YEODwediSi18fKoIozj2k=;
        b=uctdGJYmOiAdy+wZsj2VMdgoSJWPCUZZxm85gKlDO56Y28V3I8J8L3sXKuppu7bmoc
         WNh6pG0qZ1nJUUqvBqg/Bt69fCJS6lH2OvoNP124F8xK0jE6PGsCIRX757EcvfkbmPTx
         ll1EgcgiouQU/CKqyLTclatY0Z4RxMjNTGXAk64Hg/ZX+EMY1lT6OJIuM8pK2eBt0arN
         b7hgvqwc+/v29ftiqhQSyyHT49fbtCJrmW9MXXwUjWdfD1xbgtKDyoNgHubZB/WRppIn
         Ck/uNwG99s0M5Tywudt/Cbz8D6QBp1LG3atk6KYzS4chUQNQ9SIU9CEomodUpL3GQSka
         YDFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781513445; x=1782118245;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mXNqs0V6Xe4qKcXiOexhD1YEODwediSi18fKoIozj2k=;
        b=AnDDfPW7vuBG/A0C8yNHO0DBwEVkerc7dgNgaUDbwuiwFNmDkwHm4RZAntS7go0ThS
         jQWCh3mE8LvoP2dGLxszmk+264kYwlH/ix5a3mNIKsDJCIu+CEkDntTY+YXwVbpyg/Na
         29SMEPDKZmmZffmb3mcYHiyEv6k3VMfb0HYk5I43jGsgY/UH1gwVSpwrFo8bBTsSchto
         glxyxO007UyXc5Tr2BhNpsWAuiDbtMxTBawFoP54Cz6lGNqvURp5V4oRCju82GXSy7K9
         5zqOqL6gPxGsDLEO9aKRZb1/lFibyMN8oZVgT20fdJaG6r/sYin9GQ2mc79cZZOTE0xt
         Cvjg==
X-Gm-Message-State: AOJu0Yy1yv60Pm7iw+J1/pLdqAcKL1qcw0KPtsoPUsuZuoFHy5JRRGqm
	VMqNsIb4z9BzV4lMfyAYpJI75WspXV/yVhgnpqtOkObxdUYJ++3mfBFGo7+BAJyHMk+kC4VFJ5G
	/6AqY
X-Gm-Gg: Acq92OHBAHKzqUUnS0/SflHUNkdwhc8w5EwchSFdKPvrairy4AdZJVlHoROv5R9SAGR
	r7iYrNAlCstjkZ8sp6nyg2C0ryLNg44HM8vYNQknmjXjeKvIVpRK549c+GHWFFu4pXo9cVptknU
	JU1wJyCs/MPY0Y9Ob5BJ5BQ7DJbEBe406cuRptgSBHyGwcUWlAeLTq6LE6tZnsg53cuPxBmPloI
	aEpIIk1HTuURyF5lJAq9Epc7OL9AhOKv0+l/O1GVmb+g8+boog7PUaQDkS5+jPEk/iysM0VDAei
	MNlwED3LCBUf1dxLEdFFAYTjf6ZnxxaQBR5E9A7STfN4OwQov8GEW5UXwnGvPbC4S8osrfReqUs
	VOdAPQpOAZQ3we1TQgXts1gufRI8Hxa1hKOlQensQ37JnyDQFIOYGRN1FNH8oUDW5/a9OnNmcuf
	SzfGBzAp5BOrijlzBCgvcPRC/vNZfnWCzq
X-Received: by 2002:a05:600c:5296:b0:492:1e7f:d426 with SMTP id 5b1f17b1804b1-4921e7fd54bmr130251995e9.2.1781513444636;
        Mon, 15 Jun 2026 01:50:44 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49220368ef4sm231411705e9.12.2026.06.15.01.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 01:50:44 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	mrgolin@amazon.com
Subject: [PATCH rdma-next v2 0/6] RDMA: add per-attribute UMEM for SRQ create and CQ resize
Date: Mon, 15 Jun 2026 10:50:34 +0200
Message-ID: <20260615085040.1396623-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22224-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,resnulli-us.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CEDA2684BB9

From: Jiri Pirko <jiri@nvidia.com>

This series continues extending the per-attribute UMEM model to the
couple of other uverbs flows that pin user buffers, so that userspace
can back those buffers using previously introduce descriptor
infrastructure.

The underlying infrastructure - ib_umem_get_attr_or_va() and the
per-command UMEM attributes - is already in place and used by the CQ and
QP create methods. This series applies the same model to the flows that
were still VA-only:
- SRQ create: the WQE buffer and the mlx5 doorbell record.
- CQ resize: the resized CQ buffer. Resize CQ was only reachable
  through the legacy write() command (IB_USER_VERBS_CMD_RESIZE_CQ), so
  a modern ioctl method (UVERBS_METHOD_CQ_RESIZE) is added first; the
  per-attribute UMEM descriptor is then carried on top of it.

Wire this up in mlx5 driver for both cases. When the new UMEM
attribute is not supplied, the code falls back to the existing UHW.

---

base-commit: 20ff9350862468af21b46cae2c22d17d6ec637f9
see individual patches for changelog

Jiri Pirko (6):
  RDMA/uverbs: Add SRQ buffer UMEM attribute
  RDMA/mlx5: Use UMEM attribute for SRQ buffer in create_srq
  RDMA/mlx5: Use UMEM attribute for SRQ doorbell record
  RDMA/uverbs: Add ioctl method for CQ resize
  RDMA/uverbs: Add CQ resize buffer UMEM attribute
  RDMA/mlx5: Use UMEM attribute for CQ resize buffer

 drivers/infiniband/core/uverbs_std_types_cq.c | 45 ++++++++++++++++++-
 .../infiniband/core/uverbs_std_types_srq.c    |  2 +
 drivers/infiniband/hw/mlx5/cq.c               |  9 ++--
 drivers/infiniband/hw/mlx5/main.c             |  1 +
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |  1 +
 drivers/infiniband/hw/mlx5/srq.c              | 25 ++++++++++-
 include/uapi/rdma/ib_user_ioctl_cmds.h        |  9 ++++
 include/uapi/rdma/mlx5_user_ioctl_cmds.h      |  4 ++
 8 files changed, 90 insertions(+), 6 deletions(-)

-- 
2.54.0


