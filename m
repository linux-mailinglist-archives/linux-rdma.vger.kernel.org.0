Return-Path: <linux-rdma+bounces-10109-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7814AAD06A
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 23:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 556543BDFB5
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 21:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805A872615;
	Tue,  6 May 2025 21:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0vGGvLa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08BF4B1E5C;
	Tue,  6 May 2025 21:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746568512; cv=none; b=ZbXBM8BQeak81MlmoQjt+LLt49lnRcZZXlxEncylE0hjxl+gRyh5cw3ianr5FyYsVpPnCqTRStrs3WOoadoN3Ni7TO2vH2Ihd9V7aCTTMeX0sADud040mLe/46Nv4jfMCCI603FYn55G5aihCF/pK3HZkY2Wr6LCAKiWNe6SSSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746568512; c=relaxed/simple;
	bh=9nhpMzXTeNMxVi4L6WegKDk49ifAtG2YL+CH5aMmbLA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VSNzOLsMViDctzw4m41NfzBesUDFlpNGbAOqJCqwfjWcyCKIG8TZWZJ8wbznPJ4lH6YzsdsHxOLmZFri1kNqJsTi8Fysrym/7ghjbk00fV2QOeXE59l0LJWKYwaHmfuHqbHn+DHjgrzxnJwQsAjXbasK+Onl0OwkBRY1A8s38FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0vGGvLa; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-736aaeed234so5490414b3a.0;
        Tue, 06 May 2025 14:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746568510; x=1747173310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DUulXuLoXvy+J7CYdN/iBa8zKhQkvTAtk/40HjSBy8g=;
        b=R0vGGvLazDSaGHY1eTiCbSmx4ucfJTn5gWaC9+d6wfB0ErmIDutUk4CoE2+W9b/qCk
         qPcq2tPMGCEbj+Zs/KHTuCIb4wPuR/xEuG0cI0VtNNxbXcgBzhFyf3HwHHZ5nyWwIx63
         PjKxCE2uNwJskOgy+JhITPEO3qhOSg4rY6z2nT6isruWPqtBKqTqUXS0C9tRX0feVm6k
         Khx92zqQbNaoGJXz9C0aC4liY/z4AzUyc2IGUOFAaFoIqprrk0YjQi+NKJhfGhuA9QB7
         FfqpQmbaR2Pdpzt010/9ebvu4VFui+5I9cAu/uhSpBgFUQ6u2LWDNCBTXQV7i6kk4sw+
         lKUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746568510; x=1747173310;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DUulXuLoXvy+J7CYdN/iBa8zKhQkvTAtk/40HjSBy8g=;
        b=T7T73p97Oo98YwisN7SHEv5TehsyLOV42rhTt1JeDxZEZBwN4ACPDFef8DgTY8Ocxa
         8UxcC2/aQSSxjPjMehfCgeKFf6JrrGmpykqxAojktXvSlbhpbAym/57wOy8CjDDn4RUR
         38st/oQCayMYxmJqmshFrB45WmnLtrVgr6c0c4VDwq+uxj5FP4BuOSYYFNYgPZqhW56H
         iEUjG7fWCtVK4x6xEFKj00OqSMkISz1epro7NpA64P54kv8F3KUKgVe41gBAUIblZHGJ
         wDXUNeuDPRqcLyl+ch8A7Q8fCXlmLmbN1XcYYD07o4S+SMkwcApHNfFZbLuH5FtkxBk2
         +pdg==
X-Forwarded-Encrypted: i=1; AJvYcCUurtkxzqTPxrMgsztrt+i9/Tu9/djnpoBuZ4Hsm78O5kgL+6nooOBNgJ0zcQyr7kigePLcloNZIDNQpA==@vger.kernel.org, AJvYcCVJ/jXAUgRonzlEVWx4KuzW8V08uymuQDEARbqaUonl/lkD68rUryBtj5Bxx+ZvGXfRn9N0VFC0MGw0jvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUVKahRtu2TXZLniFi9So7Dyle7ysi5uQEZ91HCC5sO8CRrvtW
	BH5lp0Oy3OsOl9VDV/O5So/QNQXAbTl5nprpxmWwEKBbzORN8L3YuhKZgO4=
X-Gm-Gg: ASbGncvjfdUNvZqSOjMH/YRMhHnod0thGMPBj8dhPUWoxbWDb7UyCptNFFROqQh8CVR
	cGdmS6JVn7ieGoraAx5xtrobcYDPykF0rXJZapGp8cb3SqILa+SiD8yD4/ReqjprNaRascXOpGL
	/5fGpE+vB2ZWlDTTAb0AUu4rqto0vKwwM4lqS1t1DjMTW7LGMP8Tccym/4ZoU6lU7X6IS0/JLWl
	UBPD2ZR+9yJqdsooTUeJ5qDx0GL1cwF2mJnCxNRPnjwa+tzNc7WDvkcjc1WBESsXJ2KSubFGdNu
	Ytxhg2Xo88JaHiN9oveL4cBRUGzjyMAp5vSKRbhftbQgRNvQ/vDL5anA8Y3JwruEoQS50c24ZQw
	PObnm2ufWCg==
X-Google-Smtp-Source: AGHT+IFX2Ch7efSSLeEUlCZbZ/ZnYOKg1sJE0VDho937amSJc+t2A91D7vRhYykBcY3VbybZXfNQ+Q==
X-Received: by 2002:a05:6a00:ad8f:b0:736:d297:164 with SMTP id d2e1a72fcca58-7409cee42eamr863756b3a.1.1746568509703;
        Tue, 06 May 2025 14:55:09 -0700 (PDT)
Received: from localhost (c-73-170-40-124.hsd1.ca.comcast.net. [73.170.40.124])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b1fb3b62502sm8016838a12.32.2025.05.06.14.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 14:55:09 -0700 (PDT)
From: Stanislav Fomichev <stfomichev@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	andrew+netdev@lunn.ch,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	leon@kernel.org
Subject: [PATCH net-next] net/mlx5: support software TX timestamp
Date: Tue,  6 May 2025 14:55:08 -0700
Message-ID: <20250506215508.3611977-1-stfomichev@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Having a software timestamp (along with existing hardware one) is
useful to trace how the packets flow through the stack.
mlx5e_tx_skb_update_hwts_flags is called from tx paths
to setup HW timestamp; extend it to add software one as well.

Signed-off-by: Stanislav Fomichev <stfomichev@gmail.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c | 1 +
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index fdf9e9bb99ac..e399d7a3d6cb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -1689,6 +1689,7 @@ int mlx5e_ethtool_get_ts_info(struct mlx5e_priv *priv,
 		return 0;
 
 	info->so_timestamping = SOF_TIMESTAMPING_TX_HARDWARE |
+				SOF_TIMESTAMPING_TX_SOFTWARE |
 				SOF_TIMESTAMPING_RX_HARDWARE |
 				SOF_TIMESTAMPING_RAW_HARDWARE;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
index 4fd853d19e31..f6dd26ad29e5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
@@ -341,6 +341,7 @@ static void mlx5e_tx_skb_update_hwts_flags(struct sk_buff *skb)
 {
 	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP))
 		skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
+	skb_tx_timestamp(skb);
 }
 
 static void mlx5e_tx_check_stop(struct mlx5e_txqsq *sq)
-- 
2.49.0


