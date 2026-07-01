Return-Path: <linux-rdma+bounces-22644-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4P7yANcTRWpB6goAu9opvQ
	(envelope-from <linux-rdma+bounces-22644-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 15:19:19 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CA56EDFE8
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 15:19:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b=deZxlc6W;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22644-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22644-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 288993144CDF
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Jul 2026 12:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4F73EF0A4;
	Wed,  1 Jul 2026 12:40:27 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE2D3FC5A7
	for <linux-rdma@vger.kernel.org>; Wed,  1 Jul 2026 12:40:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782909627; cv=none; b=gWY0bn7fceeJ/Zi5Zacf8V3zegVndxMGmcbKAL7XIBQTy0zKkPZuqdJKSZ6MGm18rMsrZuGeLoteijNo/IjejShk/Ws/bpbjHI8t/6Oo3ZZ0RyVUbClxp9zncPr3LuELbjGXnerP1M5Sl8vEQ3f+ni2P4cKaA6ueuRPYZ/DYiG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782909627; c=relaxed/simple;
	bh=Yh0kDNc6omqEX8TSdsfs08ah2baD7/v+s7Ia+TxvXxY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RdNeXUwSHu5EdQ3KGZQTIrwdVs0ZFY1/kPSQ7SSB43LZ+pPlvdLoCuM/PPeFhPvfPZ8kJW3WliQr0kl0WvowjoMMgnLK3ZTr9lch8twtfbH27uqUVf79xMYCFNq0XjnWyN+SrpQB/32mxN/Ur8hGKcQE+QKtGO5t8z9ccXcNzr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=deZxlc6W; arc=none smtp.client-ip=209.85.128.44
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493b691cb44so4158865e9.0
        for <linux-rdma@vger.kernel.org>; Wed, 01 Jul 2026 05:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1782909620; x=1783514420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rsL4LMBLr4o9YX9OfFGOwIduj9iO00ZLz7xyGEgof2M=;
        b=deZxlc6WzsDHl7t/7OGUINj31WDub3V1xefiFbsJRuoo2fG1DdLSiPHcEQvqZcUQwE
         pkKBLBICXE1ofpThCky1KyuzJ02Wg1uUCbGMiK0GXQ76p/l/BoG0RCKsKWfISlf3d19/
         DUtkz94JEm7k6ykvO/r6xoTP2Hv4RfGj8F9ifxTDORSIbhNOcNOmABZEw9xjMAWf9Suq
         368lFszmSbw5zes355i9YBWGOcqRKwdFT5C+h3+PKxQgviVevJH3QO5D621vgcEBL6sV
         n+Hkq+cknsZ3Ua82t0KqsCUbhyW4vv4pmnL8mxQZ1ShwVdpmv/QuN27SgpWPqw+c6mrA
         dTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782909620; x=1783514420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rsL4LMBLr4o9YX9OfFGOwIduj9iO00ZLz7xyGEgof2M=;
        b=Yg+0h8g+AaT22BZ+wCChKWGy6go0KIbVq6GAl2lNl8ayT8Qxd9UD+VmvhmX1eQn2/d
         HUMOpXuIeDm9K4lhCGtSyV+wjd+P6xSYlbd2ekmPw5pk4avoMDoolGTxj4Nsf/G8gjPX
         k8I5KMlOLNpLGYoGn3ybuzQl1Lpv31JDBPOV+UAqGUU/IVQpxT5w7yD+cucf9ECXznTQ
         IbX4J2pKYHyEY3XCPyXtmFGyhm7CqlLkMBPRgaxoyrj3YRDbK9kktomb/lr/bjiBh5Zx
         g8RBGKCTQqRjuyP0BVXH89qK4ieUNrwTkat5O09RrqllIhH3WyVDTnXVP+6R2MykN5aH
         B6QA==
X-Gm-Message-State: AOJu0YzJtTvD0AU2x81WHLDBt6Pm9Y17idsEhMwjr3y4kLHWjp/1i5q8
	Kej7IO/l55CpI4MPn0azilP7Z13zHDmpvz7PQopOAWmVHwzl7WyLBxZoe1L7GChkWho8e1Oqj3Y
	Qs8Sp
X-Gm-Gg: AfdE7cmIj96afhH+t+/oEII4aKnoA+xTYRqXyjl35of+48e08Z+NawA4cbGO44ZzcKp
	Z4C0TVq8DXMOpcvzCMat3haarSC/iMKblCSqTKRhybaEYlRADQzwdXiAwA59bbVWoDoISRIeDTa
	Wx7WCqVbhEGnP2vVtMVWxJYD5rRsHCvEb2HXUhrKXo9mwe6T+mpHYiZN4rTIlsLLNkhzAX4+j6Q
	kxX9KQvfVX3+rEgM6ayTgud/g7ilxTO6alaw5Gyj+jXAkdCVPyIQ3YPTbK4kktz4a2d4Oco98yn
	asMO2FvnFykV6yi8c5wfb/bppgEalghMVA3wgmj5QEyFm/mmEViYMb2BqSUqm/kbGe85XBj9xLZ
	dCgCMrMv4lOk/CrYLY8pvZqiAt+7jKqFbKnYOj+wcE4LNTqWU2yZSqH+AGFp243viBaEsYh3Esp
	Vs9Fa5ZZuEt4fhqsZkQ+dULQ==
X-Received: by 2002:a05:600c:5851:b0:492:1e7f:d41e with SMTP id 5b1f17b1804b1-493c2b4e778mr15990135e9.10.1782909619121;
        Wed, 01 Jul 2026 05:40:19 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47563d195b3sm17380614f8f.8.2026.07.01.05.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 05:40:18 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	mrgolin@amazon.com
Subject: [PATCH rdma-next v3 0/3] RDMA: add per-attribute UMEM for SRQ create
Date: Wed,  1 Jul 2026 14:40:12 +0200
Message-ID: <20260701124015.64350-1-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22644-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,resnulli-us.20251104.gappssmtp.com:dkim,resnulli.us:mid,resnulli.us:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 48CA56EDFE8

From: Jiri Pirko <jiri@nvidia.com>

This series continues extending the per-attribute UMEM model to the
SRQ create uverb flow, so that userspace can back related buffers
using previously introduce descriptor infrastructure.

The underlying infrastructure - ib_umem_get_attr_or_va() and the
per-command UMEM attributes - is already in place and used by the CQ and
QP create uverbs. This series applies the same model to the SRQ create
flow (the WQE buffer and the mlx5 doorbell record) and wire this up
in mlx5 driver.

---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482

v2->v3:
- dropped resize CQ support

see individual patches for changelog

Jiri Pirko (3):
  RDMA/uverbs: Add SRQ buffer UMEM attribute
  RDMA/mlx5: Use UMEM attribute for SRQ buffer in create_srq
  RDMA/mlx5: Use UMEM attribute for SRQ doorbell record

 .../infiniband/core/uverbs_std_types_srq.c    |  2 ++
 drivers/infiniband/hw/mlx5/main.c             |  1 +
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |  1 +
 drivers/infiniband/hw/mlx5/srq.c              | 25 +++++++++++++++++--
 include/uapi/rdma/ib_user_ioctl_cmds.h        |  1 +
 include/uapi/rdma/mlx5_user_ioctl_cmds.h      |  4 +++
 6 files changed, 32 insertions(+), 2 deletions(-)

-- 
2.54.0


