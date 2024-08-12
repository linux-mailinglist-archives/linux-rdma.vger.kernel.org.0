Return-Path: <linux-rdma+bounces-4320-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2972594E876
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2024 10:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DC8D1C210E8
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2024 08:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8246316BE0C;
	Mon, 12 Aug 2024 08:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ogw8llGF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925CC16B3B7;
	Mon, 12 Aug 2024 08:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723450997; cv=none; b=ucc46X6rEowY1POn4eRcedBwgKaAEGhjWtGgAi1Ms8hDfUD5pZW7mRHEW6Ufrb4UJ/MpLIFGF2CklsrQ1RVGHT8KTX/0RJgNW79IzqeRlqhqQ/lvsKdRFsavdhGyT60FLY+H62sEsapnL5jhDRdkC/p+PWch1t0e6lkC51oeNPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723450997; c=relaxed/simple;
	bh=7V/LcjxHai5IZGt9D/pz1Iuf1LhK5rh5vii8+emDDk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=apb7B53qf+bULhKSIL3IaSCcAZuAp7vnGX3DDYBU8pMiKm4TOvVg8bF9tSdTwfSArgqmGBrDYapWSIDgKHg/wIShvl0zEMB8s3iONFn5nHgHuwNwHoDe23z8wn9V8XTd5nxwuY+xxAhXTBLQtrwLtpCHinEmgtqK7iS+gVakpuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ogw8llGF; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42816ca797fso29842865e9.2;
        Mon, 12 Aug 2024 01:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723450994; x=1724055794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rBwWNO9iayreLx98+XZuJ20vJFaxD9sssPnU6v8Prpo=;
        b=Ogw8llGFh9Pmtb/F4EuJcf8Ac2bTSxHaR66pPSwonoSDcDde4F2b4LIDr6yvSZYuto
         PQvk1DLa0bwH3Az2l19CJ9zRd1nfgFNUaOPDuUo2QbXf4KS/oeKxy1mY0gV4gBOESYGH
         UZzV1jVk7KT1A3QwI/NXtbb8dftW4f3po7KrmBNPp4XX/k/E3dn6HU1sXi3hVX+20ekB
         TmAoxj+tXegRHpq55ZSnJT9xTCAUq22Tx8mAsqTqhh0exsP+Wg80RrK5B/OUtyJMBORI
         fixC1lQUGrs04v3g2JAnjJvL+TyByzsVFG0QIlr4M+fwQdIPYQnerYqfXtoxAGxrFsYJ
         hH7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723450994; x=1724055794;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rBwWNO9iayreLx98+XZuJ20vJFaxD9sssPnU6v8Prpo=;
        b=Ro5fMUVoTv8cwok4ugHHlAweTQ11PQkNrZ1XfEqOZ+3gzB7joqB8sCUjCWzy3pEUdC
         ZSwlHzXI60jen/fzvaKHMEqmfEJr/EmUpoLrG4vTeN8Xp6ngjaT6DUV4LDGJBWIaXxaI
         Pc9kXv3xh9waQm58lYRtam51dEqTotvPvwVluxo2UXKd60xJFNalZamKcanFG0bAnAnF
         krp3Y4eNBzFKIarZdT9LD6uw4jCrNTCANb/ES8z5MK87t5RWXh6nLizdKB+liwUQMAe8
         jo8cAgdAKczzVaXo5I8W2sY2nuN7SMOVA2D3B/MMKAxGQq7QKeAvlc5Mn6wccpcpaVzt
         tQEg==
X-Forwarded-Encrypted: i=1; AJvYcCXjH8jxeoFrnybpPTOrsQesKs2mRxHZUCspN5Vnn1IJXnL6q6L1PmgwqqrNZcHjJtGhBS6zAvmCes4nO+6OVW1uHXlZZ8WLf9sxU9oGDyLRDSX0Zl0CI3/OLI7t7vZPsu8v7dz5iy2n+RHicYLapbFt8WB6iki6XTKicGGVC6/xMw==
X-Gm-Message-State: AOJu0YxU/GcFBZuzj0tpb1tL88E/4fzRPCMqouxX46JTTVZPGFybiUlF
	NkAKteRUzyfKfcsRnQlwvE8rKydzNPbd/Le0gErf29zzWHNIdckq
X-Google-Smtp-Source: AGHT+IGxLFFMuY6S+LaXEdo9PeyyCTui7wn3DnbZbtoZnAuiC4L9PAYYmEV6X4Oxm/lRc7G2HrZiqw==
X-Received: by 2002:a05:600c:46c5:b0:427:9a8f:9717 with SMTP id 5b1f17b1804b1-429c39c4341mr67067125e9.0.1723450993541;
        Mon, 12 Aug 2024 01:23:13 -0700 (PDT)
Received: from macminim1.retailmedia.com ([2a01:e0a:b14:c1f0:617b:c61e:d65f:861e])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-429c7737c64sm92979055e9.31.2024.08.12.01.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 01:23:12 -0700 (PDT)
From: Erwan Velu <erwanaliasr1@gmail.com>
X-Google-Original-From: Erwan Velu <e.velu@criteo.com>
To: 
Cc: Erwan Velu <e.velu@criteo.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net/mlx5: Use cpumask_local_spread() instead of custom code
Date: Mon, 12 Aug 2024 10:22:42 +0200
Message-ID: <20240812082244.22810-1-e.velu@criteo.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 2acda57736de ("net/mlx5e: Improve remote NUMA preferences used for the IRQ affinity hints")
removed the usage of cpumask_local_spread().

The issue explained in this commit was fixed by
commit 406d394abfcd ("cpumask: improve on cpumask_local_spread() locality").

Since this commit, mlx5_cpumask_default_spread() is having the same
behavior as cpumask_local_spread().

This commit is about :
- removing the specific logic and use cpumask_local_spread() instead
- passing mlx5_core_dev as argument to more flexibility

mlx5_cpumask_default_spread() is kept as it could be useful for some
future specific quirks.

Signed-off-by: Erwan Velu <e.velu@criteo.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eq.c | 27 +++-----------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
index cb7e7e4104af..f15ecaef1331 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
@@ -835,28 +835,9 @@ static void comp_irq_release_pci(struct mlx5_core_dev *dev, u16 vecidx)
 	mlx5_irq_release_vector(irq);
 }
 
-static int mlx5_cpumask_default_spread(int numa_node, int index)
+static int mlx5_cpumask_default_spread(struct mlx5_core_dev *dev, int index)
 {
-	const struct cpumask *prev = cpu_none_mask;
-	const struct cpumask *mask;
-	int found_cpu = 0;
-	int i = 0;
-	int cpu;
-
-	rcu_read_lock();
-	for_each_numa_hop_mask(mask, numa_node) {
-		for_each_cpu_andnot(cpu, mask, prev) {
-			if (i++ == index) {
-				found_cpu = cpu;
-				goto spread_done;
-			}
-		}
-		prev = mask;
-	}
-
-spread_done:
-	rcu_read_unlock();
-	return found_cpu;
+	return cpumask_local_spread(index, dev->priv.numa_node);
 }
 
 static struct cpu_rmap *mlx5_eq_table_get_pci_rmap(struct mlx5_core_dev *dev)
@@ -880,7 +861,7 @@ static int comp_irq_request_pci(struct mlx5_core_dev *dev, u16 vecidx)
 	int cpu;
 
 	rmap = mlx5_eq_table_get_pci_rmap(dev);
-	cpu = mlx5_cpumask_default_spread(dev->priv.numa_node, vecidx);
+	cpu = mlx5_cpumask_default_spread(dev, vecidx);
 	irq = mlx5_irq_request_vector(dev, cpu, vecidx, &rmap);
 	if (IS_ERR(irq))
 		return PTR_ERR(irq);
@@ -1145,7 +1126,7 @@ int mlx5_comp_vector_get_cpu(struct mlx5_core_dev *dev, int vector)
 	if (mask)
 		cpu = cpumask_first(mask);
 	else
-		cpu = mlx5_cpumask_default_spread(dev->priv.numa_node, vector);
+		cpu = mlx5_cpumask_default_spread(dev, vector);
 
 	return cpu;
 }
-- 
2.46.0


