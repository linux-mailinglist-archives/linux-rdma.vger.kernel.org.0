Return-Path: <linux-rdma+bounces-5844-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6E89C0DD4
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Nov 2024 19:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF3B5283F7E
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Nov 2024 18:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47982217318;
	Thu,  7 Nov 2024 18:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="dCCfewTo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oa1-f98.google.com (mail-oa1-f98.google.com [209.85.160.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF392170D3
	for <linux-rdma@vger.kernel.org>; Thu,  7 Nov 2024 18:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731004270; cv=none; b=ggf6S/vlyGzP1BCjQj6sPfCRxKAPviVb1jZHxpCI+3kkNYrRMZkRg4hBcK2zfaa4BfHfbTYJutBF1nTo7HEySmKvRTlT4VSiifYbFks0mSC0aqBSHc0yhmWD0SGi9XkN0CCSmgjSKpSzsb9+E6o0U6Di8SqKl+M4lk5ZVQh5Np8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731004270; c=relaxed/simple;
	bh=+7GSFZS1z6Q2nK/J2hOMMCbumu8o1d3GcPgXqPKINp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ggCiILH32qVmOgF1zHHLb/Wq7EUFCl3ZLd7RCM5ntdRtQe+7NL5y6wAqvwQecDqCzwmNX4VqLX57894L0Y+E5CzB0B9cNlDOlo6HzZTKx9yWywZsw/iOWBEUmDz09JFszBh2I+2lzHYTnJrM+YYLp2nqByob59Df/V2t5gTYe2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=dCCfewTo; arc=none smtp.client-ip=209.85.160.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-oa1-f98.google.com with SMTP id 586e51a60fabf-28893cc3acdso164896fac.2
        for <linux-rdma@vger.kernel.org>; Thu, 07 Nov 2024 10:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1731004267; x=1731609067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJVBj2BWP8MSLlUfkHkKfAXT6jikollCx1oJSSB5KYA=;
        b=dCCfewToE6WDXM+aNrvaaWxNKu+Keal/QvnIC5yxKXKpdvBbK8MVTxtTI76XDng1VW
         nPDmhnzu8LT5mdALd6JzMdkTgEhVjjlj0nXYY6kd0U6DdSeiNSkQho2VJoLdHfB1rRMP
         4BxXbzupp6cElZ9H2LNKYRUj3lTbaIi2fbViwtgM6TjZu/CRGluFP3CVzaYqtbhAJ6g6
         Bg6IDnWXolgh6YpRCjWeMbvC17Md+oy2BorOVWsf6/1CE1fmXkp7p5yChoYtFMipvPWj
         adjrO1hEJOSVwcbK0h8o06r45+dfwDGvUPXNnAdEDEzg2YAc0VGOghrtNmRCcYzwOYa3
         zVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731004267; x=1731609067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sJVBj2BWP8MSLlUfkHkKfAXT6jikollCx1oJSSB5KYA=;
        b=vFWm37WANBTGXw57/DUtjqQJC+DLlOFf6nvl/oKdXkr+19Q3AO1cFXnicyN2tUJL0F
         kOdS1hA++3t1zZpIxkooyvkWHItksULP+5dKtxokzv8LExP93lq55tRZMaweJuzMVeyT
         YFLV4JEjEE1kCIH79TcaFQ7dNy2ixT7bOqB/SnzCATk97Lzx+ssqXrlH+jpF3M/0nWBw
         dXW58airkZlIDJUmfdCP4oC7drsHDAM6XOu4OqTggd0qBZF/pidIVrT6WBFu2Z3f9tbA
         ADquiqVq3Pd1Do67wn7wPugHxWaO9qYEpnp+DDoKmJX8iT9wkLc9+pkMHnix5/UgxIb5
         975w==
X-Forwarded-Encrypted: i=1; AJvYcCW5YvG0qQdxA/xcW6pbXpAKXJ3oyiSqSihbpL2l+3bntqLRpWWLFxaFV3ktGsaxFFYkoOPCZFZ6awnh@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ8gLMZw7k0IeqsAnXGhgFAODpBnfoNDjovXpXA8DM41fcthyu
	t28pUVbkTuyzEbS3z1GzcPanVp8c07gQwkpdAuq3mllLH8sAmr7ovcQBh+IIqgdd8Ad2zNmuPXP
	hv8mqBPUQZFhaenm70WduBTLSSLS9rtnw
X-Google-Smtp-Source: AGHT+IFy+P6qjGcCcGWY8SuGhP2P81lGxGaGxgCCjeNGSOOnvaRv9ggx/dWrjTCdmCSF3o0xeTnQ8LDvke76
X-Received: by 2002:a05:6871:4e86:b0:288:5240:2ffe with SMTP id 586e51a60fabf-29559d81487mr280659fac.14.1731004265868;
        Thu, 07 Nov 2024 10:31:05 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-29546d9c868sm79284fac.26.2024.11.07.10.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 10:31:05 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id C1C063401E5;
	Thu,  7 Nov 2024 11:31:04 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id D3A72E40DC8; Thu,  7 Nov 2024 11:31:04 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/2] mlx5/core: relax memory barrier in eq_update_ci()
Date: Thu,  7 Nov 2024 11:30:51 -0700
Message-ID: <20241107183054.2443218-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <ZyxMsx8o7NtTAWPp@x130>
References: <ZyxMsx8o7NtTAWPp@x130>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory barrier in eq_update_ci() after the doorbell write is a
significant hot spot in mlx5_eq_comp_int(). Under heavy TCP load, we see
3% of CPU time spent on the mfence instruction.

98df6d5b877c ("net/mlx5: A write memory barrier is sufficient in EQ ci
update") already relaxed the full memory barrier to just a write barrier
in mlx5_eq_update_ci(), which duplicates eq_update_ci(). So replace mb()
with wmb() in eq_update_ci() too.

On strongly ordered architectures, no barrier is actually needed because
the MMIO writes to the doorbell register are guaranteed to appear to the
device in the order they were made. However, the kernel's ordered MMIO
primitive writel() lacks a convenient big-endian interface.
Therefore, we opt to stick with __raw_writel() + a barrier.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
v2: keep memory barrier instead of using ordered writel()

 drivers/net/ethernet/mellanox/mlx5/core/lib/eq.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/eq.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/eq.h
index 4b7f7131c560..b1edc71ffc6d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/eq.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/eq.h
@@ -70,11 +70,11 @@ static inline void eq_update_ci(struct mlx5_eq *eq, int arm)
 	__be32 __iomem *addr = eq->doorbell + (arm ? 0 : 2);
 	u32 val = (eq->cons_index & 0xffffff) | (eq->eqn << 24);
 
 	__raw_writel((__force u32)cpu_to_be32(val), addr);
 	/* We still want ordering, just not swabbing, so add a barrier */
-	mb();
+	wmb();
 }
 
 int mlx5_eq_table_init(struct mlx5_core_dev *dev);
 void mlx5_eq_table_cleanup(struct mlx5_core_dev *dev);
 int mlx5_eq_table_create(struct mlx5_core_dev *dev);
-- 
2.45.2


