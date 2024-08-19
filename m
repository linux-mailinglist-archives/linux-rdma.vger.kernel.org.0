Return-Path: <linux-rdma+bounces-4423-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A078F9576BA
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2024 23:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A2BC1F232F2
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2024 21:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDF515B12A;
	Mon, 19 Aug 2024 21:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="ez5atJOK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AC7159598
	for <linux-rdma@vger.kernel.org>; Mon, 19 Aug 2024 21:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724103800; cv=none; b=goXohITYsE4rm9Zm0s9p/p2S0nFK5n4Di3WB2VGQsgcjfO7fn8itFSvnLjMnAnGO5Xz2HP0UL75lrjYw27DBFTjBHxtOOL4Q2nAGg9axxZWogm//nCZ7yecdUvw8MFaHDFCIKO5A5rGDloPVflvHKufv2sF31u91o5xQyUDe/M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724103800; c=relaxed/simple;
	bh=AF7FA88IJZQJIDztq3lyuQNCNcFdr30knN8inBc5GPU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=lqU2hFI55IQx2jIrhPum1tuEyBWxlfee4ooQUWmFmEG2HYcYlpQYgJhnIHBdGM7qZonuuaN05KaJYm5EodTq1pdQ8M/h1eFK1VsvhEXpbo8FF1tcasS6R13YyQuhJQ4qyDhgEU5ItPs9WpMVIg/EXlD9zW3//Fdbi38+QNbofM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=ez5atJOK; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-713f3b4c9f7so1140806b3a.2
        for <linux-rdma@vger.kernel.org>; Mon, 19 Aug 2024 14:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1724103798; x=1724708598; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lTqdSUqce5GEmwG9R6Aq8XgjY4jDrfouBPveXJQ3bng=;
        b=ez5atJOKL+IdO8dA8HSJUgJcSWKLuZF3e4BQp4QQIN8G87rLszhgyuwCELCedVaG8r
         ElVr+CqpYKw1ofoAQ6GQ4spXK7KzqzXUWgd9el+AWVjKr0/RRvIxBMKMaaVR4oy8704h
         aBUWi2kj3y8oOohNh31TR3FFMlBK+CqgNMPmmqqnV88L8Yl3wW54vWpETKuiob/Jz+4t
         VYdjcmFut/EdXxDQ7E5u4rQe/EdgvZBO4N7Wo9al2EMf3ma9inmHV9gNOrRuIwUyWMGh
         jXs0de51TXQYfPSwudNLBlBx7tBGhyBBBsdqvnbHJjAtjJ2/j1Mm6z/hdIM4am/9tGm2
         BZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724103798; x=1724708598;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lTqdSUqce5GEmwG9R6Aq8XgjY4jDrfouBPveXJQ3bng=;
        b=P9J+yoOeCWtTdE5KrUijDkLOYHrnNkw5UUKzSjnwg8XSGDh5/6Pcxx8blq7cJO1Fl2
         ejLadUu6fZ3yaTqTmDZqgiHySHk7RpHiC/4nMnWUrUWxNCjTIFDSsyGddkaoUyvWK3iK
         Cq17YcVmSFFk3jAdsG+rMtO8miGj0DrNXfFa0JxFMmtlQjvOQDv+/bJsc3ude/dJAM2C
         U3yMZQwcHQA9Q7rmWWgIOwjmJqluIF9E0EziR0O5OFZOrLIPyGFi/SyRCL208hhyoNyV
         f9+HjPZk2u0vTm6KcpOkBVKLAX6YBLNcCujJOC2taf122Fa7LajY3vnTRr30+ph09Cbf
         uV8g==
X-Forwarded-Encrypted: i=1; AJvYcCXwJUYnHRDCVDyNNPT70HeCqJsggccf3b5B9nQgcUDXID52s3axl4CUGHAHXXX1Xwy0B35qMiFFOj8I@vger.kernel.org
X-Gm-Message-State: AOJu0Yy62fGGlMIPy5cxE7D5iO1jvByy39Wf6xasDNyHna8XX4RGsrdZ
	DeXhOS5HI+tWvi4tpXC4+8ME9KTZZD7RctBG5pMt0tB77cguWDBvQSLywTCSdLo=
X-Google-Smtp-Source: AGHT+IG+Xm+3BkxWTFsrHJE7ZjxPdu8qYymKVWMYp/liVXK+trlqOrMMuhOIo0qSpmSbcv8n2ut5Yw==
X-Received: by 2002:a05:6a00:9296:b0:6f8:e1c0:472f with SMTP id d2e1a72fcca58-713c4e379damr15568374b3a.8.1724103797592;
        Mon, 19 Aug 2024 14:43:17 -0700 (PDT)
Received: from dev-mkhalfella2.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7127add6db6sm6989801b3a.20.2024.08.19.14.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 14:43:17 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Mohamed Khalfella <mkhalfella@purestorage.com>,
	Yuanyuan Zhong <yzhong@purestorage.com>,
	Shay Drori <shayd@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net/mlx5: Added cond_resched() to crdump collection
Date: Mon, 19 Aug 2024 15:42:57 -0600
Message-Id: <20240819214259.38259-1-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

Collecting crdump involves dumping vsc registers from pci config space
of mlx device. The code can run for long time starving other threads
want to run on the cpu. Added conditional reschedule between register
reads and while waiting for register value to release the cpu more
often.

Reviewed-by: Yuanyuan Zhong <yzhong@purestorage.com>
Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
index d0b595ba6110..377cc39643b4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
@@ -191,6 +191,7 @@ static int mlx5_vsc_wait_on_flag(struct mlx5_core_dev *dev, u8 expected_val)
 		if ((retries & 0xf) == 0)
 			usleep_range(1000, 2000);
 
+		cond_resched();
 	} while (flag != expected_val);
 
 	return 0;
@@ -280,6 +281,7 @@ int mlx5_vsc_gw_read_block_fast(struct mlx5_core_dev *dev, u32 *data,
 			return read_addr;
 
 		read_addr = next_read_addr;
+		cond_resched();
 	}
 	return length;
 }
-- 
2.45.2


