Return-Path: <linux-rdma+bounces-20323-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JSpBoEFAWptPwEAu9opvQ
	(envelope-from <linux-rdma+bounces-20323-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 00:24:01 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 73817506AEE
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 00:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C107E300C591
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 22:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59483612F1;
	Sun, 10 May 2026 22:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iY41hdfm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099A433F8B1
	for <linux-rdma@vger.kernel.org>; Sun, 10 May 2026 22:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778451823; cv=none; b=YnuQfeZ0eDxjQEdOh8ZSvSxqMTYO9Q0soP68Un1ZYU0E7j2vOf3jz32Tpv6L+APpYDiaALa+MsyNAyRQjsnoaRBMxzZrgqpTako+pUQsAzVh0Whl1vvQ4k051xGJnaJdyBQXBvisPQqBymse0n2NAcm9j++hHEiVx0hON46BRWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778451823; c=relaxed/simple;
	bh=wsuuQQeFXqjjCdzMamwoZR6Nb5LPZ2Ta7fMPyj595rg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aUmz3K/oNQo9tUeza14RZPOsKZcB3hn9rMfRjpWY2+TW9DHJvuQy87EH3aaYBpf9XOjrOBI5nOqewA+KQPjOHG4tGZSyQhdYigDNfFiy+udOEzK42K9O//qFklHRigwbPwBIDBgPHiN2iHEmOq7OjmciEOexq/B7ewbZO00d3tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iY41hdfm; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso33687525e9.2
        for <linux-rdma@vger.kernel.org>; Sun, 10 May 2026 15:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778451820; x=1779056620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QTIxERfOi6NFuZxzcV/Y+ncOqxgrdE5KUKp4LKfbWFA=;
        b=iY41hdfm8IlwHm787S2oy+/xINOHMt855TcD9smHummlm1lBWjL4Jk8oYDLGBJwrzU
         uLLzw8pRSZnlSDeKqGYiIe5rVVDONXGC6qVRcUQEb59+9hduZZCsqqIFVc0RLiMhguri
         4WqppNLJfkzXFYpZotTP1euyr2t4KEpMKUWWgBY+fSlNA+OHI2lXR8jQONHPLjr/bT9C
         N/vdOeyzbI7JsfSaFvmmSEzzWAd0zLWtVQVp3iMg0crqqDb9+kJQYDG3H+xY+YcE2Ivn
         mf0RvTnUG9saKHqf1SE82sn/Wi4Yl+NZqNqzW8KjI1x+MXpyoPqpzE/m3N8qzbIZ/XVy
         ErWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778451820; x=1779056620;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QTIxERfOi6NFuZxzcV/Y+ncOqxgrdE5KUKp4LKfbWFA=;
        b=ORv0kpg2P6fHfo8GdvIzW9I+unh08k+CJsbxcznnIJE+ijQt7c4NHKPAftD2M2jKpp
         3E472cg3ar+zpJehsuaWhysK/8SQVpuYHL7QOS36XdikR64AAzAFey5GDAuqao1GY0TH
         f20G2/jSryFfdbx8lyYW+NrRc+ZtJPzSTHIU/lW2i/8yXq9BusydkcrGvVBfb83f60o0
         d2phLk7/T0h4mNxKPkI69NH5uSRPJeNYSuVXmZ1jd+ve5jqhkvZv3qBcQQnWQvM+D2zG
         2HfQEC2kV1bDFPdY7Psv35ZjCNNq8pv3Dvwzik+X1EGPrfKXlWcfbLev3o5LnmfDNsQ/
         2JaQ==
X-Forwarded-Encrypted: i=1; AFNElJ8XoXQaW7JVgf7Abryzq5ILOIZAuZB28pBhqp8L7//gbJm0qtOJCtoqldgnb48FBqEjBk+0i1YIph7U@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7wsXO511HCeiw0TYlHHhEZnVB9BcaWPQmH+xvIJWf9psBFq2A
	4kp6u1MYzzyS9dAlKsSXR7/5ATGF9vKJhy9NCSTAItBYWcEwSHHjnvl/
X-Gm-Gg: Acq92OHFvmTejdiyajbhXj8YnIUB18RjuwJw2IWbBxlNukevr+wkJunltW8w5lqh+mA
	8XzllURmV0PvtOHPJX9Dm8ATtm81hpLk0f2UK/soJyGaKfVLXMg3WMPuooz2TKNQbhzJWZpoOcu
	tzWXdx10y5DMlIgNw0+aaNf0aVD8tufCTdhdkVnOZvqlTm0lSBZOU6oD8pe/EHztzRmv0r819Ym
	3oDIR5mlvqwlhtuKSjxGX82j0a8uS3ND2TRlsBx+Rv2vXMsVIeBJfPm2e5HW/UxzVc/tt/u4jb2
	CqKv6jInAEvu96Q6B/rF6wQ7+NQn1kmNZ7soCxtOYvd5ZdDgyd6yA26wcVoSSvgKv+TMNZNQt9G
	+PfdD3qZksROpA0tfW5v2K6+6U5HIQWv2PYvF++6TI2NbpKcXqm+TnTl1m3W1vxhVHPCnhLpCmO
	JBxqmwVZLlUbdT0zOjoN6NymWJqHumUrUO8SNxhzsAnbIptxMkwOwLNYyCk8x/P+9dgp3NhNnRS
	SAyiJ4aWDqgTTIu56W7ehGbiqf8lHLc3oyqLqnYlA==
X-Received: by 2002:a05:600c:5296:b0:487:219e:42d with SMTP id 5b1f17b1804b1-48e706932d5mr112432275e9.11.1778451820293;
        Sun, 10 May 2026 15:23:40 -0700 (PDT)
Received: from SD.localdomain (heme-13-b2-v4wan-167795-cust403.vm32.cable.virginm.net. [81.108.45.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6f9fbf12sm152399565e9.0.2026.05.10.15.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 15:23:39 -0700 (PDT)
From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To: Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Patrisious Haddad <phaddad@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Doug Ledford <dledford@redhat.com>,
	Haggai Eran <haggaie@nvidia.com>,
	Majd Dibbiny <majd@nvidia.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Subject: [PATCH v12 0/2] IB/mlx5: Fix loopback rollback and threshold accounting
Date: Sun, 10 May 2026 23:22:52 +0100
Message-ID: <20260510222258.6654-1-prathameshdeshpande7@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 73817506AEE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-20323-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prathameshdeshpande7@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This series fixes transport-domain rollback and inconsistent accounting
in the regular (non-MP) device paths.

Patch 1 fixes TD rollback on mlx5_ib_enable_lb() failure, makes the
success return path explicit, initializes lb.mutex earlier, and destroys
it on cleanup/failure paths.

Patch 2 corrects the loopback threshold logic to use a capability-aware
baseline rather than a hardcoded value and ensures that
user_td/qps counters are rolled back if the hardware command fails.

v12:
- Add mutex_destroy() for lb.mutex in mlx5_ib_stage_init_cleanup() and
  mlx5_ib_stage_init_init() failure paths.
- Keep MP helper behavior unchanged.

v11:
- Dropped the MP locking changes per review feedback
  to keep the logic unchanged.
- Narrowed the scope of Patch 2/2 to focus solely on regular-path
  threshold and accounting fixes.

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
  IB/mlx5: Fix loopback threshold/accounting in regular path

 drivers/infiniband/hw/mlx5/main.c | 47 ++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 14 deletions(-)

-- 
2.43.0


