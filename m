Return-Path: <linux-rdma+bounces-10312-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E40D0AB4AB5
	for <lists+linux-rdma@lfdr.de>; Tue, 13 May 2025 07:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34FB07A67CC
	for <lists+linux-rdma@lfdr.de>; Tue, 13 May 2025 05:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E93F1DF982;
	Tue, 13 May 2025 05:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldMv8m+e"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119281BEF9B;
	Tue, 13 May 2025 05:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747112665; cv=none; b=ldoHQxCzog4vi2JQQkLQJGBkUTu3o21GpseqY9OERscIkG3OnjNN+7gFS21psOMzrRFaWnYPbrqDKqNmX/ffZkHq1TozbiQUM6leNM8mXWZos6HsaeQ+Co3E6DNoZv6h6c063fpsEWs2/awKw1y0X7Sp8D+ANui5u2buGkN8ZkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747112665; c=relaxed/simple;
	bh=rKxK+qDk7uluELix4UOUqwhXARj4KUuAdtqiQAnroWs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uf0ODEmhu3aisgbU5KND916epZUUSMMZXUvKwhQKgbPyqiW87PdbR/+TvDGqMqTxOH8c8arGSXy7zWXMMLlBVyyWqIBRaUmD8IhJTCMpj4tOyRV7xpyUlB/d88QYVPVjDB4OeqfNbMtyr4vtKTjEY8Zx1psoJpKt88t0M0l07cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ldMv8m+e; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-30a93117e1bso6927070a91.1;
        Mon, 12 May 2025 22:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747112663; x=1747717463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yyPrclMpW0ypfydPbC+pEfHaCCZLnFWn46DN0fm47R4=;
        b=ldMv8m+eZuepzHgDI6N6fOXbFIZggsoeuUrwg02yvAf4MIN+aACP+JPhsZ7574dTkm
         DQQlE06xFu8ouC/yVDSJ/vpjyA0Gloa/Bv7caiQgM1C8E6fjdZrpyw1TB1PQD1eGUPC/
         iP9N/GLXhNWlh0tutWpDhHqWythyElbdLo/R+3ltLvQHae0EI7Xl21iN3n5vAjD8gsf6
         Zf9hlOkVICtBiFCFBib6KEubGsgap6m7nNwdJWz2lbWcVcJaJl2JcotqEnhg5meyZd94
         FRWq5prEX8hZu78pDRIZeBq2WEV53vByjSG59f0s50pW+psB3R16MJjHkxmpDz5GDNxu
         ypBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747112663; x=1747717463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yyPrclMpW0ypfydPbC+pEfHaCCZLnFWn46DN0fm47R4=;
        b=kqR6gF+X96YxuhZQ3Q6YEnXhN4ewVi91pdLZA3i8WT/uFhhdOMN4OutS25ZSeBPxKP
         C0rO0WbeaS83H8cpJLpvQs3yYclV0ym7/8rung6tzdHjUq8SZHJ3xnGvDdlJRurbsL7M
         NNORVJZMleOWQZr2UQYq8qL5crz/esJf9P4xnLLp+GCrhtcNjsO3IVYJcU/mJLOWKqDQ
         NWT+Thbp7vnk0VMPVc+oZ+MAwDq4cbliXCEpORts4xOVHTKOvEG0VOBgCmMqlf2oHOB0
         v1B7HzEoiHvQXmpbS/m8TPS8jWi9s9BqzXAJr0ddRZcY4WE6zX1RHn+oUcsFHZS0iHAm
         2DZw==
X-Forwarded-Encrypted: i=1; AJvYcCWT/J0QrizWDPLT/i3R/JsGua0zcTkntqAC9CWUNPPSroFWmNYGk1d2iDOCVgSZXGiVYND3fE9UdA4X@vger.kernel.org
X-Gm-Message-State: AOJu0Yw96jc/TwEDO7LI4tKBMXbW0kXPSHF15iI7+QpqT7Wp/+vzdY/W
	Hesu8fZxwGg15yaxF/Et24n/UKXKOO+5ADe9OTGM1mrSoY8Gsv2170F0dQxC
X-Gm-Gg: ASbGncsIJupQp9G15d2K0oikk/TKyzSUOqiTEKkKPhp6oiFhXtSWiYSxt6csY7SqTvw
	8WYC4rMCj3qVLX1tO4XorN8kZ6u52Vg9swy5UltLfSXRyYz8LRLxz7R63cIOQIQLKQ18zzCuMwb
	E6stNwAIM9CmUBAaA7ofYZd/hy43AOVdLMOTnvgnFY6fKQHrFeQqWDnfDeu+TDIYOOF/T1o4/D1
	dnOA0BHhfHvX32rtcZSXCtrVp8atlfdooIeRBzjsZUihEErw3GZBicZOhNrwGPWf6Kw0YOOghss
	RZI6b2AUQfuFVE2+2OBuA0PIzViKN3fkEt/kIlQ7Jwiu+0r0N48QoAcoUhVy8KdAGsJusIQtlzu
	zkeXHqg==
X-Google-Smtp-Source: AGHT+IH/HBwng3FEaTmS2dfj9TCp9z0DYcwn17Lg5l/d7MS7TvWnV7vhnPQsDjD/EOeQ/olxvrqhkA==
X-Received: by 2002:a17:90b:3903:b0:309:fd87:821d with SMTP id 98e67ed59e1d1-30c3d64c1e4mr23995830a91.29.1747112663184;
        Mon, 12 May 2025 22:04:23 -0700 (PDT)
Received: from trigkey.. (FL1-119-244-79-106.tky.mesh.ad.jp. [119.244.79.106])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30ad4ffb545sm10744493a91.45.2025.05.12.22.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 22:04:22 -0700 (PDT)
From: Daisuke Matsuda <dskmtsd@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	zyjzyj2000@gmail.com
Cc: Daisuke Matsuda <dskmtsd@gmail.com>
Subject: [PATCH for-next v3 0/2] RDMA/rxe: Prefetching pages with explicit ODP
Date: Tue, 13 May 2025 05:04:03 +0000
Message-ID: <20250513050405.3456-1-dskmtsd@gmail.com>
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

Daisuke Matsuda (2):
  RDMA/rxe: Implement synchronous prefetch for ODP MRs
  RDMA/rxe: Enable asynchronous prefetch for ODP MRs

 drivers/infiniband/sw/rxe/rxe.c     |   7 ++
 drivers/infiniband/sw/rxe/rxe_loc.h |  10 ++
 drivers/infiniband/sw/rxe/rxe_odp.c | 162 ++++++++++++++++++++++++++++
 3 files changed, 179 insertions(+)

-- 
2.43.0


