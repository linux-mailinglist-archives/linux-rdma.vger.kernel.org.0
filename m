Return-Path: <linux-rdma+bounces-10527-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A465AC0A7C
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 13:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C520D3BC178
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 11:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36BF288C0C;
	Thu, 22 May 2025 11:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJmPbR59"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168B8236453;
	Thu, 22 May 2025 11:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747912816; cv=none; b=jNwEl608rbNF3BR+wLgnCQKWItwo5DNbc2jmp4XoGnVR1Hq5l43Bb/1HRUPWJSor7yzS2Q27O2oqTUCt58lzrw7QW9+RgyMLZ3Qb7ImxdEyZzlH7eO6VDUF4vwI7TSQMktw2pbHhEdlT/YZnI50ECwT9XtQbEJItgustgEPefw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747912816; c=relaxed/simple;
	bh=T+EKJ7SvaQz6z1N33bT+sIu2bZxMrCXFdLefbowKC50=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n6nsdDmMfLSBfccdY2o8auxDj1/nIryLfStvkCZ8i0j/OtI68XiGlHVRBJLCu/ODmTUVHpFWozdEA/vRMRpwxzSguVc7MtAFg/6Kfop8m0BquF0dUIABdLphYD2VRhN3fI9tS+u89dy0kCWu6jXq/0hCm/AHAsz/XQn9e1e2XNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJmPbR59; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-231e21d3b63so78758475ad.3;
        Thu, 22 May 2025 04:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747912813; x=1748517613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rFDBcCBFgvqbqzgX+Nvj6RsRC7KbDuLy/hnWN3wn7FU=;
        b=lJmPbR59KklJt4Ku93BNJ2Ga4S7FOUUO5xFWy2jHOol3imFTFXdXISG0R1wKszXuSm
         ICAVEhYmlY7Hgm4t6PVWJHVnZVo9Tij4S4steXS5SOVvOjv3wfJqWhTz223qbYn5+/W3
         iXaApaBGCu3UEjcIhD99LMeOB/SAb9FlRGwVEgiYO4pRHCiT/qCnN52B5w4WtowqHGyF
         VndejItb6DAATDdXVzXET0HF/UhZjfop/TlWKE6i8lxceGFzuweFp8epdQXS1Yp2Uqu2
         t0xx/DkAiHMdiwCOgAhPiMxscM/H2KjxqqW/6kcmM+RJNhOzFoYLNhtOLJVsbLqvHHlU
         3qzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747912813; x=1748517613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rFDBcCBFgvqbqzgX+Nvj6RsRC7KbDuLy/hnWN3wn7FU=;
        b=EW087cRCzZdsNvg+r989quvToHpXXcqx8ynwtTG93qwkYjGAiwOQCp8xivVoPkScVZ
         1Sc5IEG958sQru1SQdEA7SiN0iBUu1zHaBBCj0JcNw/d+r55KwjGlAz+YqnLOTRKWJ/O
         XH2lDkU6sm6WcHMrbUUkfHSp/++B17MPmNf6GR9x5VMU/4F5inaWpKbBYMp/WlZWUhZa
         6qUOlv1p2EC6YpEtv7QJodlvQ6zV1HsI7vnkafVFYZimGO76qqx0LMGbqRYzdjAPnU0p
         Y53PZ06Tl907WK7JYHDp9Yd4Ap1iK/1EFtst4D6kL6MyJSrtioZGCHtV+MJh/+Y7Yz4f
         yeYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPYk6QBimYiGg8kZzHneaDy930aFfvGO8YSM1OwjprV9YhydK+yZOCxpeK1kGupYYcmBhElXllBtV8@vger.kernel.org
X-Gm-Message-State: AOJu0YzlOrDYEy0vQ9pNzLpOXnoOniPqr85rt4nGZDW7UxeyVb80A/1I
	i2ZjU4ENb2d2vihMhV63JB8646qH4+XNB16whzS9IsDEZgOImXSmKEUb3bt1KlzN
X-Gm-Gg: ASbGnctfcbtNUWBjXTDlHAU7afKAUjMLE2+VylOAYgQfTrwgonJTKw1MfbIXYDgf6BZ
	M8QHZbBRE43RHn56ZoZK9g3NZE3V2PAxkdWobaW9AmEztj0SHMts6NSTlyZV4QAFPKqpV6s8dbT
	ezdfRGmA8XiZiHdZJ9mNrzFYFmUxaZNqiNgG9tRzrf6vC6baFFJTuW5gTck9Ktv1cr29V9YH29r
	yT+jkGtrsyhNdsOZbvN/zqRST3aPMjnXPyUejA4NXF2jOT6nLX7O9/C9e3HPgN5ejen/R53ERDR
	GpuFdKYoqEe24azFaLOvSwcI5BuJ/hxN7uqOzT2vQgqWLqOYYJoumn+Pdvj0lINT3D7jzBDqcEd
	PGxD4eg==
X-Google-Smtp-Source: AGHT+IHtKsuVUJcmbDTxpUxqA3LMusr3Lcyq1Gze2JuCS0J/UnvUEZ9aVM/qar5AU8OO57L9Elt7Ew==
X-Received: by 2002:a17:903:320d:b0:224:1781:a947 with SMTP id d9443c01a7336-231de36ba3cmr317687435ad.21.1747912813137;
        Thu, 22 May 2025 04:20:13 -0700 (PDT)
Received: from trigkey.. (FL1-119-244-79-106.tky.mesh.ad.jp. [119.244.79.106])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ac93b3sm107730145ad.4.2025.05.22.04.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 04:20:12 -0700 (PDT)
From: Daisuke Matsuda <dskmtsd@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	zyjzyj2000@gmail.com
Cc: Daisuke Matsuda <dskmtsd@gmail.com>
Subject: [PATCH for-next v4 0/2] RDMA/rxe: Prefetching pages with explicit ODP
Date: Thu, 22 May 2025 11:19:53 +0000
Message-ID: <20250522111955.3227-1-dskmtsd@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is ibv_advise_mr(3) that can be used by applications to optimize
memory access. This series enables the feature on rxe driver, which has
already been available in mlx5.

There is a tiny change on the rdma-core util.
cf. https://github.com/linux-rdma/rdma-core/pull/1605

Currently, there are regressions in the for-next tree. When running ODP tests,
ib_uverbs and rxe can get stuck respectively. Therefore, to test this series,
please apply the patches to commit e56b4eab9cde ("RDMA/siw: Remove unused
siw_mem_add"). The regressions are under investigation.
cf. https://lore.kernel.org/linux-rdma/20250522083257.GM7435@unreal/T/#t

v2->v3:
  - Added return -EOPNOTSUPP; (1st patch)
  - Corrected type definitions mismatch (1st patch)

v3->v4:
  - merged rxe_init_prefetch_work() to rxe_ib_advise_mr_prefetch() (2nd patch)
  - Modified to use per-MR counter to ensure RXE is not destroyed while
    the asynchronous task is running  (2nd patch)

Daisuke Matsuda (2):
  RDMA/rxe: Implement synchronous prefetch for ODP MRs
  RDMA/rxe: Enable asynchronous prefetch for ODP MRs

 drivers/infiniband/sw/rxe/rxe.c     |   7 ++
 drivers/infiniband/sw/rxe/rxe_loc.h |  10 ++
 drivers/infiniband/sw/rxe/rxe_odp.c | 159 ++++++++++++++++++++++++++++
 3 files changed, 176 insertions(+)

-- 
2.43.0


