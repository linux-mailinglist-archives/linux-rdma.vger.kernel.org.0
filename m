Return-Path: <linux-rdma+bounces-14936-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F91FCAF1EA
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Dec 2025 08:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3AAFC300A360
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Dec 2025 07:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5E12836B1;
	Tue,  9 Dec 2025 07:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGgU87fz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC682221554
	for <linux-rdma@vger.kernel.org>; Tue,  9 Dec 2025 07:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765265012; cv=none; b=ashhULIy5BG1zqQWe1+E7wzDesKxkiIRXtMOpeYQI6nWkENijE/DWQHtfQFADOplG9//EpdJIFFyh+LIUAWMVKyczbiiOGkgvTYg15R4Ymhfx2b8oLLH35pR12+RiQCj1J5msh/c9DY7IjpA6NW+YHYBVXjF0eGQqjS5iNqhRus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765265012; c=relaxed/simple;
	bh=CieGf0uyblZlXJpLE5JXTPJH6OaHqWWtbYaiBxpacvs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LNaaFcsW0pBif5Q0tZYbvnsSupV9mHtng84/grLDd/v+6Lya7JtGjPARlmB+J7ttTZrq71SuhIrkhKjzR7aYvfWo2B0vR2ZsXmlHYF1aWqnq36WEng+zJd4VOtWq4XRPTojjww+6rYlSp7HAFtYRmAUCcBUWBuRJhIurIwIFBu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mGgU87fz; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7c66822dd6dso4202275b3a.0
        for <linux-rdma@vger.kernel.org>; Mon, 08 Dec 2025 23:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765265010; x=1765869810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c7cvKX11eOyViM5FgNJ3zbxalEQ0QlgjBqDm6LVfvO0=;
        b=mGgU87fzdPvngWTbsnvDXP3D6JrqQSVQTaUYN20bNejPfJcZe7zAxh51UG6JNHBQux
         0GWo7EyN7rnnL8+kr1AvuoNLO309epq128opInF8riRxzhcV+Puoyri5Wy9Q49boT0bt
         hZjUChFGIgZ1wXn6NKSfPRAD04G+RRVzlFq965Dha3gwe9m1cb6NVJFh0/YQ8RP1Asot
         I+g5nlzZfXEmI4v7YfA5ThbcvWV2ZVJgEuHb00tZSEueDZE2KUWe2pSYC2KTbelHfkEL
         sMfchyGLE+7K8I5V+JD8OV9ALr+QIzMmpmw7ygc6JFkKLfIUbmDK/27W7YKteZb3iJT7
         SWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765265010; x=1765869810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7cvKX11eOyViM5FgNJ3zbxalEQ0QlgjBqDm6LVfvO0=;
        b=AMw+SngmrHo5Va/8oyete3roB5TStq8aFZ7MwCdMr9fWZPdubpya5UjMLSQ3s619WJ
         mRXp5aXRRlKq3W6rAsOsZX/mvIWl1ICwEEplg0RUhuyXcSMFFeky9mhfhvtIMswiBovA
         RBPEEMdqgWC1m1YByfKlAwbpTaRnvmxMqEGF844o76uVgMu/Tl9ibAr12MvuTtEwx6YV
         oSFvJhcOReetmAQ6cpclfPpmu2wGX3bHIKO2lUYHXOIAv8Nj8Gi3rAx8QokHlsg2Yjfx
         xYt40RlbJi78YY2CLxMQNjqvZf8jTwTupEGA40YDFets+hSHH3nvTT6l7VdX8BIqZGkd
         0cag==
X-Gm-Message-State: AOJu0YwRhUvhPrdOHeRauBo6ezXsdUPNOHTbdMoj4m5SYanqo6xCuf7j
	TfsRrfMXYITmwoBanrG3qz2MXweLwy+BPW17toU7rQLupeUUzGxuhPor
X-Gm-Gg: ASbGncs65eV8c5RgMUCCR/7mKFm2jgGzagzsxo/Au5Vmk2TYhtCtIO0gksowiXfyenn
	drZN7EHAmNsZgbXHhCtkwrApCcUKHCTdHzyNMOXmd+xmYaQeLz/0VT5AClNT+PiImcqe8r+3dfg
	YYj7F4dCkofh11oECkYr7zZk8q38W2TBWgqC6papa5U3izP10lv0efi4qX3lLF7UKttzCVksKGY
	CPY0sIcaJOoQQt7HSnyTgXMwXM65QJhun0rHeCoOyK4t2VM76S+7vrLUhR0nOWYLxLDh0GLKMGS
	bz0LNmiS/Mx7iCb6skmQmFx7iSt7G9xchp6GT8PQajl0g8tTBkOmIc64gJq5yakXZ2TR8KX7fb4
	mx/Cz8gRcRRqwR39nEgg/6Yj6Q81QNygEo5lmmwSjGmrDh71S/O94hS8lNKaRBX2GvjYt3nPgVh
	c9
X-Google-Smtp-Source: AGHT+IFIS5AI+5WMNtwNWFP5mwTu+oXiujGM6rYFK/SN0GYbb0c9NUuKMZETH9B6K9cgjF0sIEzwFg==
X-Received: by 2002:a05:6a20:3d83:b0:35d:8881:e69b with SMTP id adf61e73a8af0-3665572fb86mr615062637.18.1765265010180;
        Mon, 08 Dec 2025 23:23:30 -0800 (PST)
Received: from oslab.. ([2402:f000:4:1006:809:ffff:fffe:18ea])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bf6a32deff0sm14144129a12.34.2025.12.08.23.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 23:23:29 -0800 (PST)
From: Tuo Li <islituo@gmail.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tuo Li <islituo@gmail.com>
Subject: [PATCH] IB/mlx5: Fix a possible null-pointer dereference in set_roce_addr()
Date: Tue,  9 Dec 2025 15:23:05 +0800
Message-ID: <20251209072305.3955121-1-islituo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pointer gid is checked at the beginning of set_roce_addr(). However,
if it is NULL, the function continues execution and may dereference gid
when calling mlx5_core_roce_gid_set():

  return mlx5_core_roce_gid_set(..., gid->raw, ...)

This can lead to a null-pointer dereference. To prevent this, add an else
branch that return -EINVAL when gid is NULL, and remove the redundant gid
check in the IB_GID_TYPE_ROCE_UDP_ENCAP case.

Signed-off-by: Tuo Li <islituo@gmail.com>
---
 drivers/infiniband/hw/mlx5/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 40284bbb45d6..d68a58d249d4 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -645,6 +645,8 @@ int set_roce_addr(struct mlx5_ib_dev *dev, u32 port_num,
 		ret = rdma_read_gid_l2_fields(attr, &vlan_id, &mac[0]);
 		if (ret)
 			return ret;
+	} else {
+		return -EINVAL;
 	}
 
 	switch (gid_type) {
@@ -653,7 +655,7 @@ int set_roce_addr(struct mlx5_ib_dev *dev, u32 port_num,
 		break;
 	case IB_GID_TYPE_ROCE_UDP_ENCAP:
 		roce_version = MLX5_ROCE_VERSION_2;
-		if (gid && ipv6_addr_v4mapped((void *)gid))
+		if (ipv6_addr_v4mapped((void *)gid))
 			roce_l3_type = MLX5_ROCE_L3_TYPE_IPV4;
 		else
 			roce_l3_type = MLX5_ROCE_L3_TYPE_IPV6;
-- 
2.43.0


