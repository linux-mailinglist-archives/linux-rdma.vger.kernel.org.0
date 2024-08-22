Return-Path: <linux-rdma+bounces-4483-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 345F295AE14
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Aug 2024 08:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E59CF282614
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Aug 2024 06:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA66A1531EA;
	Thu, 22 Aug 2024 06:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="FVMD93cy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8A3152786
	for <linux-rdma@vger.kernel.org>; Thu, 22 Aug 2024 06:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724309554; cv=none; b=hzOsfJgaPau01fn1n8m2XE9mahougya/ws+Hvq2yjUoPY6c10HJVT8X+cXgw3degSeMUCFwBlUGEcG1ihiTADflaWcxXtdwf5kuUq86L7hV+JhdzNDIsw8wdwN1fL79frMgmsswuFM6/41gjBdtcyHfrB3S/ZHD/3QolH30/e6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724309554; c=relaxed/simple;
	bh=JgAmkYSjEtGXpZHuLDgMgHpuHbneSy/7OfpTBL6KeyE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Anv7Lt/kgr1JWjgsfD0NrZ7LYO6cxX/TmnpdP0fEEHs+/33nc4qIC04u1djIXpHWHLszqYAxX3aYeA0jFB18h50+wKekhy/WdhOPJMcBhIIv8LUx65wA3nV1TDi9SNpyd37eYCpiCP5BXJGihW7m2Y+qyX8qgnRhBrXMZ9tQLto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=FVMD93cy; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-202376301e6so3426925ad.0
        for <linux-rdma@vger.kernel.org>; Wed, 21 Aug 2024 23:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724309551; x=1724914351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B/FFKtEYzldzsVLIxFmFWKtQdzfb1fksBJ/Gq1pcja0=;
        b=FVMD93cyz8YoLJfMly2Qv2Gtdr3B04sJe7e8htroJ4yF2PKBk5T7IxaTRsuFQB7AgA
         uoHWvprFKuDXYGKgLe7ygyB2EyODSc32qz5RYk8UeCvQZ17Yb+cIqls8LnVnfLtsf6eK
         bxDdV/EvH7OZGI39+MjWDSGgAqt5XVooUi0EXXfupoIOwp0BzDPzeKXwB3XmJoubtQ8O
         iWnomo8KKbIhbxxuMbYTJPPt1P9LeKFqaXw2wNeE1Fk87lYvBgbUu0B6FebsoRN1uD+E
         W88T4tchp5+wN/PgribUUgIbW63dcN+1NjZvUtAr7hB27l+K080qxhkiV9F0u4Vu9owF
         Ccnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724309551; x=1724914351;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B/FFKtEYzldzsVLIxFmFWKtQdzfb1fksBJ/Gq1pcja0=;
        b=mO3HCiEpBS1ZjWdjOvA0CB1qNFxmbFn0TSVqI049TfZ8g1Bz1EZ77X4u0FHTv58tXH
         G2ARoiTLBgCSJW4gqPQu+HXsX84u2IyBMjyTR+i4HrAk1jKtraBjWkE6fexJlKg0fFA2
         +7TW3memtOS8D7vNKZUiT4FROEdRonRQ5pZ4gzJmlYFXv4qO1kQtkfYZH5sg6oloPxpC
         yQaJ1LEe8ErWyN7urNJN3QpnPosjPGDc/sMCVaTa91zCteRimA0qJbeSlaIm5C0INMSU
         W8+HbVBwBrcXqnXJ2k268280syRMbK/yN3TiiHJu9uFPfxCTiN441TITkextM6rKWEqa
         zo2g==
X-Gm-Message-State: AOJu0YwE8feewm01vY05ezK/x+UItoygFsInu4NLsbjhYTk+kH06vbjx
	l9KVR7dwBReXDMi7CPKh2CPfzjwoYN8NeG+kFPD3vgmHITOWQGjlCvgsDUs1uLCG7NB7TqUEpeq
	+
X-Google-Smtp-Source: AGHT+IG086DtRWTiv2PguF+J20DHGb88+EC7cNQNKHEMjrRPETRD0uVqkbPkuHnqyQjVbQvWS64zXQ==
X-Received: by 2002:a17:902:ea0b:b0:1fb:3474:9500 with SMTP id d9443c01a7336-20388235274mr11843445ad.27.1724309550911;
        Wed, 21 Aug 2024 23:52:30 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.12])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385581165sm6150645ad.88.2024.08.21.23.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 23:52:30 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: zyjzyj2000@gmail.com,
	jgg@nvidia.com,
	leonro@nvidia.com,
	zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH 0/3] RDMA/rxe misc fixes
Date: Thu, 22 Aug 2024 14:52:20 +0800
Message-Id: <20240822065223.1117056-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Please review these minor fixes of RXE. Thanks!

zhenwei pi (3):
  RDMA/rxe: Use sizeof instead of hard code number
  RDMA/rxe: Typo fix
  RDMA/rxe: Fix __bth_set_resv6a

 drivers/infiniband/sw/rxe/rxe_hdr.h  | 2 +-
 drivers/infiniband/sw/rxe/rxe_resp.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.34.1


