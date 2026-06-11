Return-Path: <linux-rdma+bounces-22115-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id a3jIABDRKmrcxQMAu9opvQ
	(envelope-from <linux-rdma+bounces-22115-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 17:15:28 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 63965672FC1
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 17:15:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b=NX86m+5f;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22115-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22115-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A39230B6940
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 15:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6603F1AB1;
	Thu, 11 Jun 2026 15:12:39 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A392DC789
	for <linux-rdma@vger.kernel.org>; Thu, 11 Jun 2026 15:12:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781190759; cv=none; b=TZ0zSPFbkxjsQzjG3jz37GhYf+4qRs+qUKyeqbB0aQVSaj/765pH+5F9iDlSKhknL+W+UM5DbPmnl+Re9/jr0Mczw73kHPbivenmXU8gHxhtC0RYfSO3qZvZthtvpMGB88GkObxBM8wLX4L56KcjWbTm+FIVhp59JwIkoVNH56c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781190759; c=relaxed/simple;
	bh=i0GU7O3sDqTUFYGPjmMjV9xNOVttUqqBJP+R5SHKDr8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JuD/OQqCGOp0A04DtPs0T+0Dd/2/oHHWS7wbPdBJDngwuL4fF9q8czm65f6f2ZsA6C4IGP03gyiTIEa1e0S5FOjiA8EJ/FnM9ehejaiEYUjzaS/NQpqUPF2UUwXpaNre/Gdbxq0CV90H9V1qDArp/faavMH3qof5o21DQV4nTns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=NX86m+5f; arc=none smtp.client-ip=209.85.221.51
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-45ef29c5561so4366783f8f.0
        for <linux-rdma@vger.kernel.org>; Thu, 11 Jun 2026 08:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1781190753; x=1781795553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MVP390BblcfxbNVATM7U83S8ASG2ZmjHThp9ypvuDGI=;
        b=NX86m+5fwbPjj1hQjwnS6C3cf8bgY3ABCPFpVmjFPI01D6YiuhaGfHUwLQb2n0s+dm
         pM2VF6Uf3wcn39o0IhGkESJV9+hnPnylFNyydwiizBv68eNSm465Hlzugt6b482FPuDv
         NsezQaXx1+gOf774aGndYhAos0X1bXLtx6Qg2TIsJYcleu3qwsOL/CJXU79YA3V5YfP2
         +KGJFY9gWqOGHvRli8KxxAC4G76FH/8LOagCOYMsQpqhJRQl4Od2lzd7dcWQUsttz0IO
         xIXPUIb+BqysYE5w4DReIYU/QY3CdEY0rZCKsLkCnVU9FI3hP8YyoqZVmz06MOth+0dO
         6FYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781190753; x=1781795553;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MVP390BblcfxbNVATM7U83S8ASG2ZmjHThp9ypvuDGI=;
        b=Olg8su9qayXHL+A/EPD8EIAmVwmXuloVLQXL38GpNd/ayr1G8ILHrUv4mWTcdFqACK
         wAeSkg6X+Z2+aEuWIU7ZpAA/vmvUWC4FYvbznJgQyRZFEanQrbXpOM7jcsw10Hl3jy8A
         ixgG/Q5OOs1TyD8gHRh6TXti+6G2tgZWmBJuHW68eK/bBnOm4lY7KANLYFBuomET6MFR
         51uTtgm/iDJCVp/VjfPwzlORMCdpv5PazG3if6GscyzZTyReCw6X1D/S3UO30OOdpK6c
         FHmKWtGnKlPCVgoTesBlOZu56N3rwNJyI3i3p3ufLYuz4nQgt8fiPJIFWLzmwx8vbLTq
         sEXA==
X-Gm-Message-State: AOJu0YwmA1gh01gtC3bJ1Nhoh95AOOQJNR06QvJuGVTGu1RvijRD/DPO
	97nd6gXmIKN7/XATHpICLbGfsXbjLDvM4rvPxHZ7C9zBJ+F8D+zbLDHRSFrEL5FwRkYvK5s+4Pn
	8EgZmszToag==
X-Gm-Gg: Acq92OFOsCJGOTw+Al4xSP84wcPOV7wFzucryYXSJCF/X6vpoERqd1+oB9dDGNECILe
	HGuf6XCVAqH6+wktKbX3K1bBVgr7PXRzeWz8tGaeSAV8UGQ06sztmFpd7jvVFddpN281/o0rx4N
	oe85uEUAGw8jzrZ9Okqnqoo2j8MmF/sW5r0DFwPNqiza3FzBR8CbgmUp5Tge/pteHjH3AFRSuGp
	gna5JDtzY5YUBGELdHHAukdOZS0xbDtp843Vjs8ZUfKp8Su6oAcStQVIwfZn15ntDi+e8F8Piaa
	ajxSBKr1mEgaCFh/DELMQndqVzOk8LyVo71hJa+QR+EAw0pX3E7YEh7RTZTCRSSKjdKAOlnifJ2
	OOeaSoJBV10GS5Q+Xei7GG+/wJKrimZCOVktVuMbIfIWt/bV+1sKXvCJPQcdQRQ5YJ8SmuFhrQ3
	EDyVgmppfN9XfldMnsOqHs8gLYhACYL7cUEzudxsvnA5ZCkF2fL0SjBg==
X-Received: by 2002:a05:6000:1883:b0:45e:8526:7dc8 with SMTP id ffacd0b85a97d-460677ae97bmr5994376f8f.25.1781190752854;
        Thu, 11 Jun 2026 08:12:32 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcb13sm82980744f8f.2.2026.06.11.08.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 08:12:32 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	mrgolin@amazon.com,
	sfual@cse.ust.hk
Subject: [PATCH rdma-next 0/6] RDMA: add per-attribute UMEM for SRQ create and CQ resize
Date: Thu, 11 Jun 2026 17:12:23 +0200
Message-ID: <20260611151229.879514-1-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
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
	TAGGED_FROM(0.00)[bounces-22115-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,nvidia.com:email,resnulli.us:mid,resnulli.us:from_mime,resnulli-us.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 63965672FC1

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

base-commit: 20ff9350862468af21b46cae2c22d17d6ec637f9

Jiri Pirko (6):
  RDMA/uverbs: Add SRQ buffer UMEM attribute
  RDMA/mlx5: Use UMEM attribute for SRQ buffer in create_srq
  RDMA/mlx5: Use UMEM attribute for SRQ doorbell record
  RDMA/uverbs: Add ioctl method for CQ resize
  RDMA/uverbs: Add CQ resize buffer UMEM attribute
  RDMA/mlx5: Use UMEM attribute for CQ resize buffer

 drivers/infiniband/core/uverbs_std_types_cq.c | 48 ++++++++++++++++++-
 .../infiniband/core/uverbs_std_types_srq.c    |  2 +
 drivers/infiniband/hw/mlx5/cq.c               |  9 ++--
 drivers/infiniband/hw/mlx5/main.c             |  1 +
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |  1 +
 drivers/infiniband/hw/mlx5/srq.c              | 25 +++++++++-
 include/uapi/rdma/ib_user_ioctl_cmds.h        |  9 ++++
 include/uapi/rdma/mlx5_user_ioctl_cmds.h      |  4 ++
 8 files changed, 93 insertions(+), 6 deletions(-)

-- 
2.54.0


