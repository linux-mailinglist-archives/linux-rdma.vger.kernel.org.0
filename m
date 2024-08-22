Return-Path: <linux-rdma+bounces-4486-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D0E95AE1E
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Aug 2024 08:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 583FB1F223B2
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Aug 2024 06:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D790817C7C9;
	Thu, 22 Aug 2024 06:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="H4DMIfxx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4663617C230
	for <linux-rdma@vger.kernel.org>; Thu, 22 Aug 2024 06:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724309560; cv=none; b=Wrmj89EYlLj90xE7GlKBEAzvmtn80tZFM0A0kMQDQX4nEcjPvTWx+r1k6k3HD0k5XXL+MBjmM9t4U1gXJIa2ENbd4YL/QNTSi4YKV6c6InW9+9DaHDOPXEjk+lrCzderAUH/wY7ACHVB3j4bXHcAf2ILV5hVyvJMmmUkxvPBUK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724309560; c=relaxed/simple;
	bh=Kz0RL/3q+stKWuxF5Fp9HxLiFrGykJcq/tGPmXfB0W0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fdF4fjV4SZwUts51mCCIU7PF6NcWalykzZnnC5C04t9Y264Yr+6CE5lDjX36m7BaLq2IMe97JcaUmeIYTUob/lJXsLDBCBQ8BGwqakuH4BF2cf45PJ0uZkgHdR1BLHhAvmgbc46kvQ5MCWkLbCkd8m1Mejbzz5KpVcqPzqnS1LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=H4DMIfxx; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fc47abc040so4039545ad.0
        for <linux-rdma@vger.kernel.org>; Wed, 21 Aug 2024 23:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724309558; x=1724914358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kobmIypLhy6KaTQHdYtXSfesiRM34LhpRCRqHumkiI8=;
        b=H4DMIfxxp9COsfd4dI1WZlDk/hH4Qf5tB+Bgfg9F2HLGgHOK4Ix7K7sCRZuFSyzHgQ
         b1mhAyB/5tVmnPQXiH3GjV2HlYWjBfJo5U7pAzntKtsEeleW3ukIdU9Al9Vz0hEmxk+m
         jyXeITz+qqEfIQjJg0jYyo20vy9ircq8SDbwoLmYSHLvbvnCBjAmeiTs6Da2olsJ2S5O
         vUsBtjLYm5ZnufQLORMqaXdI2aMDt8oEOLByKovIG0FYrruNdgdWHSACXguVx6IWE4oF
         Guo1DFleHZB5KM+AmHwRGE8naawZYa2qjm8x8VZZV2HoKm6wTKOhRccdyze3lkyvS7ZV
         m/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724309558; x=1724914358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kobmIypLhy6KaTQHdYtXSfesiRM34LhpRCRqHumkiI8=;
        b=R89UhaVj9wobEkx+qglWwZuHNP7EybiWRWUa9t/6VFwONeReJ5vLqdG8qZzLh7xeQq
         BKqWcJHTIY3N8+7ZMFHwvRTxfWSBA7eegV4Z/I/zMbhBOBF+6wXhkE1XQcTRjqDlW9OL
         MdC669JcY6mfOftjxYQbcoscewbw0g7jpyQ18KQAZNLJogRgze+zU05HLH0kgoFDoVUG
         H0z9jI2yZJv2hVJLaXbTc8FtvF1jFX9dBj1kp84MQ2Cxyv8dR7lXqQ6D6O8pBLnOmGB6
         NWQ0jePD+274hs1Hu0Ev5RgYm8B31bbAAz7TfIUCjTFFRw6kvJzbylazn0UZOQLEwr1h
         nDrw==
X-Gm-Message-State: AOJu0YwKIGw6Qcr6X2KT/XoVHuTQvHZpz1Gx0ebOKyUFOiCjrO9clBAs
	G2ktSuU0ovNOhCJRN6420Un/hkGghr5M4N6vaLsVL1wfdx83QUga0ljN8ZB4RS0eC8xHpHYHdjZ
	+
X-Google-Smtp-Source: AGHT+IFr/jcphA0vIj3rv9to3TFxE9S9TejtS8sH68WR7W7lbaS3xbLfWvsOX6YKSbjIlyekbbDEow==
X-Received: by 2002:a17:902:e88d:b0:1fb:4a57:7cba with SMTP id d9443c01a7336-20367d3685dmr49271095ad.34.1724309558376;
        Wed, 21 Aug 2024 23:52:38 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.12])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385581165sm6150645ad.88.2024.08.21.23.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 23:52:38 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: zyjzyj2000@gmail.com,
	jgg@nvidia.com,
	leonro@nvidia.com,
	zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH 3/3] RDMA/rxe: Fix __bth_set_resv6a
Date: Thu, 22 Aug 2024 14:52:23 +0800
Message-Id: <20240822065223.1117056-4-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822065223.1117056-1-pizhenwei@bytedance.com>
References: <20240822065223.1117056-1-pizhenwei@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__bth_set_resv6a is used to clear BIT [24, 29] of rxe_bth::qpn, the
wrong expression leads other BITs into 1.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/infiniband/sw/rxe/rxe_hdr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_hdr.h b/drivers/infiniband/sw/rxe/rxe_hdr.h
index 46f82b27fcd2..1f0322491d8c 100644
--- a/drivers/infiniband/sw/rxe/rxe_hdr.h
+++ b/drivers/infiniband/sw/rxe/rxe_hdr.h
@@ -234,7 +234,7 @@ static inline void __bth_set_resv6a(void *arg)
 {
 	struct rxe_bth *bth = arg;
 
-	bth->qpn = cpu_to_be32(~BTH_RESV6A_MASK);
+	bth->qpn &= cpu_to_be32(~BTH_RESV6A_MASK);
 }
 
 static inline int __bth_ack(void *arg)
-- 
2.34.1


