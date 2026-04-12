Return-Path: <linux-rdma+bounces-19246-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNSeJVDz2mn87QgAu9opvQ
	(envelope-from <linux-rdma+bounces-19246-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Apr 2026 03:20:16 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 409273E2581
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Apr 2026 03:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80D2E301CCEE
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Apr 2026 01:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286D229D294;
	Sun, 12 Apr 2026 01:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTOPc06t"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DDB26738C
	for <linux-rdma@vger.kernel.org>; Sun, 12 Apr 2026 01:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775956798; cv=none; b=HsLiUZbbJHWzKt4XjRSpZ4KM1uM5peJW20kbpCiyyy50JUr3Jx9pWaEs3o9UkMhr/7BfWmr1NrRSlyHwib3IADd++44QQlf5NG1SVJf5aG7xjrrrAD70WRU1SDy8a4QgpVZdwWS9MZoIAa+21rb3X6aTDLwntiS5qOiX30vY+XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775956798; c=relaxed/simple;
	bh=jSSZVL3njqqcJZu8uqW4apgriWbtKw3vW4rhUnJ829U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RJIGCC8bAhuiQKrV2e4MDYqAiUxZxoY/7G3ozRmyUOU2p4ZLyfN3lHn/xPY9QHYBTugBVf3Cf/YDd+6N7tS2ZHCAdhPip8aaOOK/WHkhaNzuf0Wr1b1ReDSZZB49i0Mvyy1TVbBN+wxWD/g7WaGsBfaU0PSy7898yDKq71gR0Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RTOPc06t; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43d04fc3bf2so1889506f8f.3
        for <linux-rdma@vger.kernel.org>; Sat, 11 Apr 2026 18:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775956796; x=1776561596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FMDTCkiVFft3vX3T+h0i/Ou46NAOiMulxREzZn7LBYY=;
        b=RTOPc06thhU7o5EcyH4BIgA8sSubSC4SqHZBV1g5JoBUvKJGAPN+SKAf1jdCw+o3MK
         o6wNcMQCvFowr2MVlV/ptpx251sr+iT3C1BqiU/qmmBk+Y8gMk4iKQub9UnAXQ14ccDF
         f9OHWZuEHFDwypNuoKX6SemT2XKReXL/o9Cdf0s7hu2PiW5FsqorejEOshZxQsAuHza7
         x/bmwi8WxfKsNh1EGkHDqBYGAAnFVjMf5Zft52+la3ipaxe6e8BZic8EfgbMetAjszSw
         9o08fMFVnkM7Inve2lJQ70y53YM2xbJl+OeFUWGgV8yN7G92hwDVNf+MjyWQgSZpM1Rd
         E9kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775956796; x=1776561596;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FMDTCkiVFft3vX3T+h0i/Ou46NAOiMulxREzZn7LBYY=;
        b=ZjIDVvP/ONKNwP8UZRWyxUXwvTu7Ry0wRG8u1STuBZ5DF+wXO+svXLIaCTRDpd8EbP
         UxpT6pGuMm3n7Nw1fVu2ZGT7UOLIgfyU20bvU7Py4aOloCfwhkcl4LMJGFOyck3D8D3e
         m9w2mqxTnF3fG13JrehqgfdnhHDZ0UdOpuxuod6UmPalzy7dqpZP6rt7m6g+cXeqO/+N
         3eASOTPEA2xPBEWbedRKbN1Is+CXOMyf45UvWe81TotimgeIDaEnp+ZWtgbIcPwy5pB4
         PPKGrJBwHYveh+MooUgMfKy2awdRO8/172XJFRZ8u7VBZE+/Ehr7Ah+JX8smrK3ZW7wr
         c1jQ==
X-Gm-Message-State: AOJu0Yz+9K92FPw4YMZKKno5ac4fy0HbjBbkuesOrWtR37HqWClaVQ0M
	/gUeqiVGGxJMjkvWGjrnkeclUtRA8f9U6FLxnU0KVAz+Tn3oIQobrXnD
X-Gm-Gg: AeBDieuUt9uDLQ7KrRNXoAB61WtziVIN65M7d+KEwyTpbEddmdOuF7zimGYo9g6oDE0
	lAW+sK9/0JiP/RN3bC4FviPFYdjl106Q70kehDKFF9P2ddk6SR7DLcPwZVGpaGsqDSK5UuU08tl
	kjHNleUCNSaUvjnMz4huje1ql0N5tinMEziN1vGfFBx8x+n6ctOlVl+4EbQHeE/IMSrtqciaM0d
	Ziu6hEAd95mxgzQIsVu+u7GAvM0siHyIgoSbpZ+8UuNgMebpYRGcdkbmYzo8j/jmq11fQkWBSNp
	+dhiD+aFrbBtvNYXoQTKdcd2iocsM/Z/GW2lnOSqP3vdcYaAGjgnPckMNcITPU5qWHEeQ8oUaab
	/VNi2jzqswDNYOM75q8SaPqss8+y/6YB3aTHtN0s5FflhCqyU+Ojjwv/Edh3NSASPYxUZ3AQSvV
	gGTsjAtHOZUBLDFbX2cZG28aNhcbOf7QQT2Ioqg4npuq6YCeWrUvzYSgDerCOe6PZsQ16+5KcQj
	Pk/LsXwXjNmwc5VfDAhuF9glHyK5KPljp0vbLEd8w==
X-Received: by 2002:a05:6000:2c02:b0:43d:75a2:44a1 with SMTP id ffacd0b85a97d-43d75a2463emr146199f8f.47.1775956795942;
        Sat, 11 Apr 2026 18:19:55 -0700 (PDT)
Received: from SD.localdomain (heme-13-b2-v4wan-167795-cust403.vm32.cable.virginm.net. [81.108.45.148])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63dec295sm19903643f8f.14.2026.04.11.18.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 18:19:55 -0700 (PDT)
From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To: Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dledford@redhat.com,
	haggaie@mellanox.com,
	Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Subject: [PATCH v10 0/2] IB/mlx5: Fix loopback rollback and locking 
Date: Sun, 12 Apr 2026 02:18:48 +0100
Message-ID: <20260412011942.13744-1-prathameshdeshpande7@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	SUBJECT_ENDS_SPACES(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19246-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,mellanox.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prathameshdeshpande7@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 409273E2581
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series fixes transport-domain rollback and loopback state
consistency in mlx5 IB.

Patch 1 fixes TD rollback on mlx5_ib_enable_lb() failure, makes the
success return path explicit, and initializes lb.mutex earlier.

Patch 2 serializes MP force-enable state updates with lb.mutex and
implements capability-aware thresholds (td_base) to ensure correct
loopback behavior on both TD-capable and no-TD hardware.

v10:
- Initialize lb.mutex before multiport master init to avoid race.
- Use <= td_base in disable paths to handle idle/no-TD cases.

v9:
- Address race/state issues around force_enable and enabled.
- Fix TD leak on failure after successful allocation.
- Implement hardware-aware thresholds via mlx5_ib_lb_td_base() to
  handle both TD-capable and no-TD hardware correctly.
- Serialize MP force-enable transitions under lb.mutex.

v8:
- Resubmitted as a fresh, independent thread per maintainer request.
- No functional changes since v7.

v7:
- Split the series into two patches to isolate the return-value/mutex 
  initialization fix from the refcounting logic.
- Moved force_enable check after increments/decrements to fix leaks.
- Updated hardware disable condition to a strict zero-check.

v1-v6:
- Initial combined versions.
- Added deallocation of tdn on failure.
- Moved mutex_init to stage_init_init to prevent crashes on non-ETH.
- Implemented atomic rollback in enable/disable paths.

Prathamesh Deshpande (2):
  IB/mlx5: Fix transport-domain rollback and initialize lb mutex earlier
  IB/mlx5: Serialize force-enable state and preserve loopback accounting

 drivers/infiniband/hw/mlx5/main.c | 82 ++++++++++++++++++++++++-------
 1 file changed, 63 insertions(+), 19 deletions(-)

-- 
2.43.0


