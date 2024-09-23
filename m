Return-Path: <linux-rdma+bounces-5047-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AE897EADB
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Sep 2024 13:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F3F7282011
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Sep 2024 11:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF70197549;
	Mon, 23 Sep 2024 11:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="Ykg4XVGy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B811EEE6;
	Mon, 23 Sep 2024 11:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727091366; cv=none; b=qkEmdi8UFXoe081xjxjXX4Jw4MpOcqEiRikneiWTqmx3Vlc2Xx+eYdC6bCCjuWPjfr5VEebYN4KFGdy2RHE7A4ispsbqmIj38hpiEDEkBSsr6hPY/f7Xn02Oef1OEFWg25/Ci6hPYQnHyb+o5L9L5GG3zqetoy/7oobvHcaQhBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727091366; c=relaxed/simple;
	bh=rCIvbFJgAUngHJRgl6SjykPegVp22wXHEMb6XUL0PPg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iJxeWV2q+gMMjn6hZ7xRZiYKEnGtkAM+Px7YdfobOAXxvMcjCje9qKH8XW5IJfZPANqwU5pGO4PddTacK9MSemr4OZOeb24Qw57PdBLhJVejvb7pqzhmi4/bYMKKojbcpGsDTXBP2tf1ztjYqea5Mx6fh8Zm0K/ihz7aYVc9jXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=Ykg4XVGy; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost.localdomain (unknown [109.252.164.162])
	by mail.ispras.ru (Postfix) with ESMTPSA id BE39540755ED;
	Mon, 23 Sep 2024 11:35:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru BE39540755ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1727091353;
	bh=It7Y3Smu6B14ewAZlJHqNThmQkADJ+N/1pQcFTizDzs=;
	h=From:To:Cc:Subject:Date:From;
	b=Ykg4XVGy5ty07cpPZbUKdNSOoZLLd6y1MB+JDQOonj5yOjvtkavif8dcHq51ZObBj
	 oRh7QQPThTmc8fVQmJq9avkwx4SklSKHT4dMcwJgiSmbjRYeomDqh996doKM9h6ujj
	 N8kqUasP645J+Jmt7wMnItKm0frqFTX6/iQZer14=
From: Elena Salomatkina <esalomatkina@ispras.ru>
To: Saeed Mahameed <saeedm@nvidia.com>
Cc: Elena Salomatkina <esalomatkina@ispras.ru>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxim Mikityanskiy <maximmi@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Maor Dickman <maord@nvidia.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net/mlx5e: Fix NULL deref in mlx5e_tir_builder_alloc()
Date: Mon, 23 Sep 2024 14:34:55 +0300
Message-Id: <20240923113455.24541-1-esalomatkina@ispras.ru>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In mlx5e_tir_builder_alloc() kvzalloc() may return NULL
which is dereferenced on the next line in a reference
to the modify field.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: a6696735d694 ("net/mlx5e: Convert TIR to a dedicated object")
Signed-off-by: Elena Salomatkina <esalomatkina@ispras.ru>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/tir.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tir.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tir.c
index d4239e3b3c88..72310452fce5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tir.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tir.c
@@ -23,6 +23,8 @@ struct mlx5e_tir_builder *mlx5e_tir_builder_alloc(bool modify)
    struct mlx5e_tir_builder *builder;
 
    builder = kvzalloc(sizeof(*builder), GFP_KERNEL);
+   if (!builder)
+       return NULL;
    builder->modify = modify;
 
    return builder;
-- 
2.33.0


