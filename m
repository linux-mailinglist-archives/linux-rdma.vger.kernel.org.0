Return-Path: <linux-rdma+bounces-9589-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD363A93822
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Apr 2025 15:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 760D819E6F03
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Apr 2025 13:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2155D86347;
	Fri, 18 Apr 2025 13:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNP8cqt9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3864626AF6;
	Fri, 18 Apr 2025 13:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744984632; cv=none; b=JV+flHJFkwN43qUeAbA4wmI8GNTUqB5ArfBFeLDAw/+DNB9pozaKoepuZCbBtAf+qthb2qGBlx+j6LbNGpsYVyqONwSErYIor3h4F69vm/1K0R8TG0r4b/TVGau07KcW74vKaSCs3sUgr3UZUBP6fp85aZboyqwpDURpXsn0uG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744984632; c=relaxed/simple;
	bh=M1J+HEG/+RbHresZiOLUaBEB9usWhr+brK6Uv6YmGuI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pT5OLP9y+tHc3j9AGrPEJf/aEHr8dmOih5ri4CxngCDQWoKXJnWtPnfoH+vdSVLK0RLGZJV+gmQEVACPsjIsvhXAFZW2VPNlKoJblEre4+Ru2+WsDiHIA7damZZY184UnV5kF+Nz6istHxL60dyxgSWQp1fs2FXzaqu4fAKlu/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WNP8cqt9; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39ee651e419so1073659f8f.3;
        Fri, 18 Apr 2025 06:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744984629; x=1745589429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pjwQaxw7qvIWiHL1ddPDt7WaKRitJMZ/zA3QII0Kk40=;
        b=WNP8cqt9NDbQcgsL4dy9JEVSvW64qFz/j9LdwWqftHqisCrVzxsI168EBhUPJdv8ou
         GwoyaBtFjQ2s7aUgqMSUolZ5sljq7L74RfwiNOnHADUc0vPnRt/9Md7b4pXylQ8lsVc1
         mNtRFRG3TJAZvoKSnxfo72n8Z7VHCcRTilbSQZI7kFcn9J/Syd6zEB2LKigFJE4pJsNI
         Ak+/LNkPJlMISjkgbEtqTX56AOBnnQXI+re/b+4JSwqqPQ7KHtCzECSg3zegiBfoCULi
         WPWyDwaotQhN/+weu6CFvTg4dvJK7gSWvbIfs0Bx/ICimgm4MhruXFpQ5KVWsBaddH1w
         1o0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744984629; x=1745589429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pjwQaxw7qvIWiHL1ddPDt7WaKRitJMZ/zA3QII0Kk40=;
        b=Ck5HmCNYPJEqSINk63l6LofJdlp3z4A7nX9GoANqNN1+0zW0HKsbFCRpcK4JFY/QCy
         Ype7vUZ5h1/9yxp1JWfP5uWS99lSv2lyzAml0RYLLg5C6pvUPl5HJQAf1AZYvdiL2jlq
         XL8ECzQOI+EQEUdlvVxcMgTWt2zBSXImdMaPpgilV4EZXwspMKDTb5PP6RnkIQCJVEc6
         VvQ0DGa4Jvz2JvDbJVCD+LizGmW8ybp2K8NeweQH4ZJlTVFXXJM3b5118PGf1ADwdyHy
         YdBrmbjoWqkpxPFA/cONsGLQZETaGPUsS520qpodr6yPYN8ebnjvHSKzyVcbAULUjtJI
         56BQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBX7y66sK8E/rCp/Zp5pit22AmL9bh/iJz5BM3bM4zbvNaCChaVa9h6vJzrQ3ybE7b7+siUsbnIkcNGcw=@vger.kernel.org, AJvYcCWnFoZoVSu5rU19rUGDoTp0w64gUeKNAAcqeGi8fuzf6JrMo1REmKyyiG3bnLjoI+lAOEEvFaLre/sCiA==@vger.kernel.org, AJvYcCX+Y63UV40az2JYtcUo+gFcS0YzsZK3qoqZmSKnIHFOFZ8oeFBVrYyXhU5cQOfWBCJL7EYSwMyd@vger.kernel.org
X-Gm-Message-State: AOJu0YwTuRqpmcdwhRRJkrv6WoyQ1r31K3Hnf44iOdSBlcQAFnnrGCiH
	ETi8SLtjYiYZIKAJPJoq3PLt5ZN4CwdSsACtaNQHCBKpKX8ItlO1
X-Gm-Gg: ASbGncsu/hYhYRxwS5HRDXKyq+9wEQn/+854Vn8i9wJAdMXQzKnyKEJMHt1XLdDfj+V
	Cp0KmoeW343AwkvRO1Z+zWE8iZ72RgHJkXctsf1O3uFEKInBGZzSqOmRvth6XEK5uguKD59SfWz
	wDYr7EiiKOUupU6QxDtOxICUsYTsYb9pF4auLWdaCAk5gLbeu5e0hIkazV4+W1pYIg5K9BQf8Zh
	g/oercY3OdF3/Afzl8R6odurCUeDqpCCMSrJRbhODzrRLcB7nFMbPKWao0dO4okcHXGYZXShJ5L
	+7v8OQNfNrdoa6slJjoBBI4S8JkmX73EluSRzjZajA==
X-Google-Smtp-Source: AGHT+IGOCmx88KzajYEEKdGxHIUJKniSfSXDMIJYHXoKksSP+94n5CJtBnYpPk64rQWba/lPtP/2yQ==
X-Received: by 2002:a5d:588b:0:b0:39c:dfa:e1bb with SMTP id ffacd0b85a97d-39efbae03damr2112686f8f.42.1744984629232;
        Fri, 18 Apr 2025 06:57:09 -0700 (PDT)
Received: from localhost ([194.120.133.58])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-39efa4207c5sm2812269f8f.6.2025.04.18.06.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 06:57:08 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] net/mlx5: Fix spelling mistakes in mlx5_core_dbg message and comments
Date: Fri, 18 Apr 2025 14:57:03 +0100
Message-ID: <20250418135703.542722-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a mlx5_core_dbg and two spelling mistakes
in comment blocks. Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
index 2c5f850c31f6..40024cfa3099 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
@@ -148,7 +148,7 @@ int mlx5_set_msix_vec_count(struct mlx5_core_dev *dev, int function_id,
  * Free the IRQ and other resources such as rmap from the system.
  * BUT doesn't free or remove reference from mlx5.
  * This function is very important for the shutdown flow, where we need to
- * cleanup system resoruces but keep mlx5 objects alive,
+ * cleanup system resources but keep mlx5 objects alive,
  * see mlx5_irq_table_free_irqs().
  */
 static void mlx5_system_free_irq(struct mlx5_irq *irq)
@@ -588,7 +588,7 @@ static void irq_pool_free(struct mlx5_irq_pool *pool)
 	struct mlx5_irq *irq;
 	unsigned long index;
 
-	/* There are cases in which we are destrying the irq_table before
+	/* There are cases in which we are destroying the irq_table before
 	 * freeing all the IRQs, fast teardown for example. Hence, free the irqs
 	 * which might not have been freed.
 	 */
@@ -617,7 +617,7 @@ static int irq_pools_init(struct mlx5_core_dev *dev, int sf_vec, int pcif_vec,
 	if (!mlx5_sf_max_functions(dev))
 		return 0;
 	if (sf_vec < MLX5_IRQ_VEC_COMP_BASE_SF) {
-		mlx5_core_dbg(dev, "Not enught IRQs for SFs. SF may run at lower performance\n");
+		mlx5_core_dbg(dev, "Not enough IRQs for SFs. SF may run at lower performance\n");
 		return 0;
 	}
 
-- 
2.49.0


