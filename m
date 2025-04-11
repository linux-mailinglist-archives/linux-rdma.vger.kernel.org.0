Return-Path: <linux-rdma+bounces-9377-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F0EA85E7A
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Apr 2025 15:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEE04440514
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Apr 2025 13:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D00190057;
	Fri, 11 Apr 2025 13:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYfi++gk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC1618B470;
	Fri, 11 Apr 2025 13:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744377304; cv=none; b=foYwEQBAtEnfJftgS3qDcQiywFVqcDTf9AiZgffhS2jWL0T7D3RSYJv9OilUO3kTZBYLCbHnO34yWjqAuR2nosNEduqGO3lSwEfl1WGNVWXcGHvNdxlp2AOzGsdkGy31BtWOxNgBqvkbmE9wpItKy7rs2FeS2vuW9z32Ov65Ae8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744377304; c=relaxed/simple;
	bh=1xElfPbg5LprFHa+7E7IJti0RGRNpFDBXm8RZTk7Vxo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=emUQ3HvCYTamB8rl1krsZaDfNV2Wzc12zTQagtedmCU6WUA4rv2vYv7L/pcSu3+XVCiBuGiH1jA3PYDb7P62TjgZGxYX1OU/CP145h9qBL3f8OeksjqHYvZWtBZZV/XrRBW8kWd5NsYbz0Fp0Tcnt9MyFzSskeU6i0ToKrmMUXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mYfi++gk; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-7376dd56f8fso2359348b3a.2;
        Fri, 11 Apr 2025 06:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744377302; x=1744982102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X7FlRNWTcgplkRXj12mO4wOxnjCeWCo2WAzWI8tsM/E=;
        b=mYfi++gk8i0gaPPMnRTwjuKAx/ogW4oPvTbR2yZpwMVfW3NHUyUp1/Hxq5D6AiwkIW
         oXWDWxYgyTdnJb6n30iwUZ76GoPFxx6aCTItbdbuyg/WbKRd9ym3LgVFw+yFu/QRZ0eC
         NRhxwREouvReae5ar0iygsVoMnDG+ffnn/Vi2ZuNOjesw5d+vt6S0DG/bGTHyh6ta+0g
         15wh+acEi/3eb4Iqz4/FBzjcwquPjrAmA8u3b4kjAO/vA937Pui/NcqiFO5XOQzFzeJv
         y1CPO7oexJ/BdV+6GYi0QlhaqGO+Hv4m0KQbooqq737VGXh9bdb1X9htpwTuj/qADLQL
         EIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744377302; x=1744982102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X7FlRNWTcgplkRXj12mO4wOxnjCeWCo2WAzWI8tsM/E=;
        b=sZ4Dnll+vIs07cez8msKwYcxKGrvIlIrAdehigSRQDpdbCstQfTa2hnkAPjs2HjRBC
         YUAJW6td0kueRMudBpaI76zFkEKJbGlGEDArru6gIMEGcQXAMxdv8bQZ+prhhtRsxEta
         YOGmOv1lEkGnAp9jx8HWsr4+wM/6C+9FqqXQTYW6N0iOq8lgEn9dCus4JQV7wTKdh3vb
         b/vl5eLcBc6zV4IKh0YKXT0sye/y/UcEDMBoTMg43IIIIblI1AFS8EqBWtDW74Qki4Gb
         XOstkB89zlWBJIXSp8PJAS0RDkY2TbkU8mXIZmak2C3tAZ7tdSRYU78eJ3nxT/D0/uKR
         34ww==
X-Forwarded-Encrypted: i=1; AJvYcCVOdE2iCnYnzMfu+P6kgOO26LVYPozvOWq7pWeZPkS/Cc5iA8T1s5Re2j0HsAouT5aGUR9ZPwB2@vger.kernel.org, AJvYcCW0o20Q3fDiAfXbqIeCphr36uYJpsSGunBq2jxLu1y+6Q9wXdVu2u75EtkZ9XuqQLAzUtL8g4vY+0oKQw==@vger.kernel.org, AJvYcCW4GX2N7Zy2ERjwMxlxYPXerBTczSaYhpEAN71OoPcBttbFBajG1cAdTKYwzsurRe2Sh5RVLWVoPBgzZFE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8lfPwGR3rX9oF6lXsUeQJbZkACmmZ9YOEM1q2hdPBBjWZP6hC
	kLQQQi2OyjuLjRpOGJfjwrLZzTfiNV4coPzXEcvs9G6nkT8SAgVUUSNmg5ZQDtKUew==
X-Gm-Gg: ASbGncu+YLLXWi8lI2nxxY/jT3AbOXXZqmZ491vMpkefKvnnB+2jpqwnU20esL9QJZH
	f4ndQ/fLhoeIcvUQsh3Fq6/VroSqkkJm+cfw77V6ZvrpYsA2gjbmCLQyqR5n6chQZnS53zDQqHr
	j/ZcA19S4gJSGaQNm8wjAXh865M+0dpvrGHhYoCcyeGYWdFXuafUp3mEVKDGdUHV++wVMiZgX51
	Wv0xv48JMjbozbb3ZUiuHCYvKPfGMZ3sc0ngOnI0V4pef/mTfJORLct1iNzGao2KUaetuntPd04
	q5oTWaiahq/FSO+9UQ8dkHjadMvLlDWRGSYGwYTylDTRoH5YWuL1BKA/H9kd8JPG
X-Google-Smtp-Source: AGHT+IG5I1bNinfDP/O1uYGJxOmBtZhz/dbIOEH92jRoyRq5qsxGiwtrY2TE3DF/rcri6j6RHpXUIg==
X-Received: by 2002:a05:6a21:918a:b0:1f5:902e:1e8c with SMTP id adf61e73a8af0-20179982404mr4449880637.42.1744377301956;
        Fri, 11 Apr 2025 06:15:01 -0700 (PDT)
Received: from henry.localdomain ([223.72.104.59])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a0de8926sm3967494a12.30.2025.04.11.06.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 06:15:01 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	amirtz@nvidia.com,
	ayal@nvidia.com,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>
Subject: [PATCH v4 1/1] net/mlx5: Fix null-ptr-deref in mlx5_create_{inner_,}ttc_table()
Date: Fri, 11 Apr 2025 21:14:31 +0800
Message-Id: <20250411131431.46537-2-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250411131431.46537-1-bsdhenrymartin@gmail.com>
References: <20250411131431.46537-1-bsdhenrymartin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add NULL check for mlx5_get_flow_namespace() returns in
mlx5_create_inner_ttc_table() and mlx5_create_ttc_table() to prevent
NULL pointer dereference.

Fixes: 137f3d50ad2a ("net/mlx5: Support matching on l4_type for ttc_table")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
V3 -> V4: Fix potential memory leak.
V2 -> V3: No functional changes, just gathering the patches in a series.
V1 -> V2: Add a empty line after the return statement.

 drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
index eb3bd9c7f66e..077fe908bf86 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
@@ -651,10 +651,16 @@ struct mlx5_ttc_table *mlx5_create_inner_ttc_table(struct mlx5_core_dev *dev,
 			MLX5_CAP_NIC_RX_FT_FIELD_SUPPORT_2(dev, inner_l4_type);
 		break;
 	default:
+		kvfree(ttc);
 		return ERR_PTR(-EINVAL);
 	}
 
 	ns = mlx5_get_flow_namespace(dev, params->ns_type);
+	if (!ns) {
+		kvfree(ttc);
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
 	groups = use_l4_type ? &inner_ttc_groups[TTC_GROUPS_USE_L4_TYPE] :
 			       &inner_ttc_groups[TTC_GROUPS_DEFAULT];
 
@@ -724,10 +730,16 @@ struct mlx5_ttc_table *mlx5_create_ttc_table(struct mlx5_core_dev *dev,
 			MLX5_CAP_NIC_RX_FT_FIELD_SUPPORT_2(dev, outer_l4_type);
 		break;
 	default:
+		kvfree(ttc);
 		return ERR_PTR(-EINVAL);
 	}
 
 	ns = mlx5_get_flow_namespace(dev, params->ns_type);
+	if (!ns){
+		kvfree(ttc);
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
 	groups = use_l4_type ? &ttc_groups[TTC_GROUPS_USE_L4_TYPE] :
 			       &ttc_groups[TTC_GROUPS_DEFAULT];
 
-- 
2.34.1


