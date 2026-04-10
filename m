Return-Path: <linux-rdma+bounces-19197-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPPfBdVJ2GnwbAgAu9opvQ
	(envelope-from <linux-rdma+bounces-19197-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Apr 2026 02:52:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A163D0E56
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Apr 2026 02:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17D123010DA3
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Apr 2026 00:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14853164DF;
	Fri, 10 Apr 2026 00:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mx7OWKSQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE0C1DED49
	for <linux-rdma@vger.kernel.org>; Fri, 10 Apr 2026 00:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775782353; cv=none; b=B7XS5oXt5fNfzQOYFOHMWreSM5sN0fXvG7r/P++96T087OWadWYapMWafca0gB/kGmRIrH3YJBygvhtXeZBe7VDa1cekVFyrEb1XqCscR8ulCGOIU/4nJP4Wz4VOPuY8goce5RBsvdTLM3B1PaRPbM6XNrH0lMsRrph1w7w8Ppk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775782353; c=relaxed/simple;
	bh=zfY1C6nPL1/GQTDTHZXi/r7xI/Gam/Euq9fCMzlJllE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CSFJ8Ei2ohIRFtC3xARW++acym522ME6b7XkD+y1YjkTkICsfRRave5APtE+rmkFXk/HTDKnDORwjuaEgDVEmEQUFm/gvAztmV9RrfOgIVwPFs9sKYAEJhM7rL4Lbr674XDwUQ5copCumk9h0o4gda4WAK9er1s5HTb2rQguS5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mx7OWKSQ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso14877165e9.1
        for <linux-rdma@vger.kernel.org>; Thu, 09 Apr 2026 17:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775782350; x=1776387150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fBHxPlUyjkSPQjS+B7c61Ae30u9ycDttru07yHqy8gc=;
        b=mx7OWKSQb+n8xA2vMpsqF4Em4Jhu8MY2txxPk/IkdBQ4CDz/oG/RSlpHLjPqtuDfqR
         LPYsmiAxw6lT5RxD24XxWrF2L0TrBO/8Kac5kS/WAqUAw7L3k+T50QLNctkFoj/4Dl5/
         QPwJm2aYbZhDJzQ71GwNXMcydS4P12J9GyuQaz4uLUM3Bcgb63VBjEObLT9N9Fvs+bRX
         PLrSlWC2iVx4X1Maff5pMPpRAuvUdM5eh9Kcx2rBl+xPYsZUNPOgaIcz8pT1oCDo0T2f
         s577RVB7ltDquiggURXtRnMwH5OqKNRrCzeU8CT8e93Pf2GmlfXXYZ2awprEKgF3+DP3
         BC7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775782350; x=1776387150;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBHxPlUyjkSPQjS+B7c61Ae30u9ycDttru07yHqy8gc=;
        b=bQ36VHLKBtvk6K9jcQwXJjlWGsnnAlbuSmh3E6Xw6Ay7AW99upnbV9i+3M22WwK6zN
         IR7ghA5qRp/iGn/3O7B7rj4zcTdtSW7Uwsx7Q37zawFuDyFXlWcQMkSKPjN0LqrViGex
         2jz9I+Bvqd9CKlrGfhvMGSrr43AzthHD9xiUuJL6aB0BL2634SensSkA1cBQk0+O5C3v
         EN7YLIvd9dOvsFsXk11g3E3B4y6cu9gW4DMOUHP1kqUtN7svWmn7jHTxgPv/TNKvXboO
         FIwM5WsQ1OmydkgZuKMl2PcH6dUd7J4LCSrbtK7/fKPrqCgO9nmzxp5bcdsjUPASQB8r
         Kolg==
X-Gm-Message-State: AOJu0YwDYICpaEVCDiQHlFVy+dzeLpgygS+GCPo5AzPCebssKID6GAIE
	CYGL1vF2URQIl174ObAVsfOZJpla4XZXfurU8JJEaBMAjC6zAohCoOY0
X-Gm-Gg: AeBDiet1yNn8FtcK1/tz7RtpRDR9OrWleOEeAQwII2ba247PjOnmR8safjzmT/1H4Am
	2OLYzsT0RTSiuhsHRjzYHEDsc69LPmsum9iI0lWWcK3myDiv6MJPShOOMynbjtvxCHbgWC8UG/s
	QIRQjytUr8HgeKsNYOw9g/yk/C+4ulVoaAbqt7j/28wWdNQN7+uZKOpExJMT19Q/Fr3ij6kMvj4
	5bnGpfOtVeXySK/vy0NGp/rR5PpzCQXxUSQEwfHUz9oWE8b7D4RIvKM3/D94xFsXqnoEPp6/mUq
	meZ0Bz5sQxIi4KxAgjeFM7Mj9Ecfl2mXexWU0g5UaCFA/OwJlFbcxLmuD/rqUJwhsxidgOIGueH
	qbERwHrAYfppxwcxsBOAi0U4d/rWxeU5kzqIhL2DtdfJptYHl8Ys18ZXa4FxfhmOCNREfnzh3vV
	E9zr0/tcEGU4Z+FWzAKGaGvIu0RIwbMXs0T4F5eLzRFDcwQnVG+y09Ei72p71+gFgMShz7mbA2I
	tDEmBxTmhFAU2SHNvWh7qFRG+YMyczQteVvF11q65LAi1d8
X-Received: by 2002:a05:600c:6089:b0:488:d376:42cd with SMTP id 5b1f17b1804b1-488d689d9admr8981035e9.22.1775782350383;
        Thu, 09 Apr 2026 17:52:30 -0700 (PDT)
Received: from DESKTOP-NQ2T5I7.localdomain (heme-13-b2-v4wan-167795-cust403.vm32.cable.virginm.net. [81.108.45.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d67b4903sm8508265e9.5.2026.04.09.17.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 17:52:29 -0700 (PDT)
From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To: Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dledford@redhat.com,
	haggaie@mellanox.com,
	Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Subject: [PATCH v9 0/2] IB/mlx5: Fix loopback rollback and locking
Date: Fri, 10 Apr 2026 01:52:16 +0100
Message-ID: <20260410005219.5197-1-prathameshdeshpande7@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,mellanox.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19197-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prathameshdeshpande7@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 71A163D0E56
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series fixes transport-domain rollback and loopback state
consistency in mlx5 IB.

Patch 1 fixes TD rollback on mlx5_ib_enable_lb() failure, makes the
success return path explicit, and initializes lb.mutex earlier.

Patch 2 serializes MP force-enable state updates with lb.mutex and
implements capability-aware thresholds (td_base) to ensure correct
loopback behavior on both TD-capable and no-TD hardware.

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

 drivers/infiniband/hw/mlx5/main.c | 81 +++++++++++++++++++++++--------
 1 file changed, 62 insertions(+), 19 deletions(-)

-- 
2.43.0


