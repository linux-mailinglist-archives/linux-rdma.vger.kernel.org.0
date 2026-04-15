Return-Path: <linux-rdma+bounces-19359-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EH7oC+rZ3mkyJQAAu9opvQ
	(envelope-from <linux-rdma+bounces-19359-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 02:20:58 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3413FF45A
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 02:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A219303FAD0
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 00:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8196C2459CF;
	Wed, 15 Apr 2026 00:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YP/TNBJM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E0A1DDC2B
	for <linux-rdma@vger.kernel.org>; Wed, 15 Apr 2026 00:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776212412; cv=none; b=MEQdgKEbIuBppmvNwLRpqx1aOMG6uqtPYTIAMcrYw2PJBJAiUReOLMfXr5kJOirK79p7QLiYaumPZFWcQNu9ZN04ZktlUMA/D3XfriiuZ3ScYkmw9q365KyRDbxdPngk1OJ1thvcTuvqEiMpYWbqtOal+IUcE/jJI82owAyEeEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776212412; c=relaxed/simple;
	bh=Ft+xbPcJagzGp97+wIY01j6DRAMwfzGG6IzoafT+aCM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LqDq1Sd6FMaLNBU2e0k6bWP8KmbM/qDaGebqqLy3rr3VLkMqdvQpDeTcPW+GgQS3oOmvfQKkYaMDdEAKz5A3A8WP5Jq4iFsVrdRCMKlosn9Ih6Y/ms/+8r7KcQb/adasV7/tvOBahw7UfaG3Xm7nOsIu83zTU9Zi7UsyoHEQdCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YP/TNBJM; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488ba840146so60508015e9.1
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2026 17:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776212409; x=1776817209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P08uq3N8wq63acZPIIpJq24Cxn8+ezgqtYfjzUZzu34=;
        b=YP/TNBJMWIER0BtxuMfhgHMl4VrizcPxjFlxiGVuMJ3JxdOMSUD3A7xJueS6Rj6BHf
         r6IZdUXInbRHs6B2yPWM4FdAc7ctwFiUCcpZv7F4l/V6kRd1TrzzDB+BVuHyJ03UDlFj
         oMy1niOi1G0tav8ip1Cxr9NxHuLLlcvsqeVXtd2nCP0RnwcQpL5ZrPmVqmmeE5T7Qe1t
         lifNB925t4rpg9+Z37jbjVt4+GQfx8ByHC4oJkrmMa/R0zZYfGfIp3zF0YCx4vrb+B5G
         ZOvKVtbpNvdLsVwXnkxup66xPdSygmqyNpdDzVXGN6Ynyk5n3TA4Px1mqMH2PWI0/wcM
         4ztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776212409; x=1776817209;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P08uq3N8wq63acZPIIpJq24Cxn8+ezgqtYfjzUZzu34=;
        b=ool4bF/1xlz4CcHC+8vSAFR3Pssv1Aim8u0zDBwvNxpdXhYkhXZ1l7SY6zDMauSpuI
         uwQz25b7NBgtEOposBSOlBSPjPHklhrb8ntkCvpd5BdbVng62Kd5XHVc+sGwD9BWA8hA
         so8qbbO4v29VwuUZZoGYB6pX9vQuvRULGGoKl0+c1l1NxAf92oV8eQKjvx92m6deylwf
         6xmTdVaNhCKyexG0mWhSYQohPxQk3XI/A5GFXmOPPr/C+wgXfrwEhzeW2rnShvFeWR72
         8Ezcsvh1+mYQQScoxkYmpNIl5PGs/CUmdeohE3J++fMyO+wfdAHaJ01ZSHhqAILZLJDz
         pIEQ==
X-Gm-Message-State: AOJu0YweJ1y7PK8pCLbOl2iI1KoB/yC/J2+PHBn8wOTSZUMepEdBoNui
	HxC9qLTeVnBJFXHSMPwBDkm3h40MrlLsPdgs2euM9yt/FJfgI6qj3PeS
X-Gm-Gg: AeBDiev9XTqd8xNwPJrPLCZ7YdI3cF2QlvlwdJpRGY7vwHLuHmRG9r/CFkOUhC+Rnm/
	FSKHlC+25vPsLi9HlZLr5GmAdEXU6H6E20Yyu6wKg5e5Qsj345Pusc7OTBGw573iLhOU12oZQa9
	Z5KiHJh59RvExR3fn3ubqh+QUQwMd6kCRFnbQ9mclSFLutQkvJKpa5wftVRh/j6Ep1rsttVY6Gd
	8YOS4qchre6hHfldlm3ZllKA5JSYnX8YxahwvpeEf0p9o2GZBO9FW7kmXfZvqd++mngD/oumLJz
	e2no/NsfrquOZjWdRnP0DPWIXxN0VHMJzdtAXQtf8RAN9O2u2PGLzkhBveYDemJ7faigoL7+D2t
	YstbPHnslLruxBsKH1ivsxksCd3wAG79nR9Lc46QKWQ3QcM+9USQUzqcNZk3dO0Fni/n1G2vogO
	HDu4eaaBGVgt2PuB2Xj/m6O1YiN4Wm5xhSDB0pWtV4xeF1hM2WRnDgfpJkUTtY8X6j85Co0qJgS
	dNv15Und8Wyv7rnRaIypHBOuB8TZ36dqJx1SUvaxqR9dqsWdEWc
X-Received: by 2002:a05:600c:3f19:b0:485:3ff1:d5ed with SMTP id 5b1f17b1804b1-488d67bbc2amr247820385e9.1.1776212409307;
        Tue, 14 Apr 2026 17:20:09 -0700 (PDT)
Received: from SD.localdomain (heme-13-b2-v4wan-167795-cust403.vm32.cable.virginm.net. [81.108.45.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ee03898bsm83149055e9.11.2026.04.14.17.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 17:20:08 -0700 (PDT)
From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To: Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dledford@redhat.com,
	haggaie@mellanox.com,
	Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Subject: [PATCH v11 0/2] IB/mlx5: Fix loopback rollback and threshold accounting
Date: Wed, 15 Apr 2026 01:19:44 +0100
Message-ID: <20260415002001.25702-1-prathameshdeshpande7@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,mellanox.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-19359-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prathameshdeshpande7@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BC3413FF45A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series fixes transport-domain rollback and inconsistent accounting
in the regular (non-MP) device paths.

Patch 1 fixes TD rollback on mlx5_ib_enable_lb() failure, makes the
success return path explicit, and initializes lb.mutex earlier.

Patch 2 corrects the loopback threshold logic to use a capability-aware
baseline rather than a hardcoded value and ensures that
user_td/qps counters are rolled back if the hardware command fails.

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

 drivers/infiniband/hw/mlx5/main.c | 36 ++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 10 deletions(-)

-- 
2.43.0


