Return-Path: <linux-rdma+bounces-9446-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2888A89E62
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Apr 2025 14:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75D2944372B
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Apr 2025 12:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14BF2951C5;
	Tue, 15 Apr 2025 12:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAml/DqF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBD9291146;
	Tue, 15 Apr 2025 12:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744720931; cv=none; b=HlHpZsCpfrW8WVahuRuPrFLr3AltZhhVz2b7bvaJjGJNiJj/R1DSvVGKP3ZNIPS64+pkPzWFYcV+Hj1ihzxjOLo6CQCv2qXl5Do16WKCEhvtIb25qj+o3xA9B1jrbmHgGZJNMLThgfvosKdEr70tmWtDrWvKfl7qKFVqXGke66U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744720931; c=relaxed/simple;
	bh=4/ZAlSDFJnrRhctY1e6uXtyIhkdJKtWGkW2Fym9v9rs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=os7celZQ92JAQSiFe9rzAIsxXO8Yd0a2QK/CuVIELMbdMpOnYk1RLYT0pm4yJmNtv2thPakOA22N4WznCQDCDjwV1A3nwoiovPfJ4eb35ZENZH4tKxc5oZXjHjg0VjrJYFeIUHTSZDcpMlsiHMWR8cgnLfdb9ZOS25G0RfmQG7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eAml/DqF; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-7376e311086so7098499b3a.3;
        Tue, 15 Apr 2025 05:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744720929; x=1745325729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NxizCHHa7XXdqltAHbClm3SimmzDh3es0NhFnQM8e+c=;
        b=eAml/DqFdrnUnRMmhRVG36qPFjE3btJubPm6fUtxwyXflGSOjiF7kcHwSae2zKWQlS
         tnXlSU74TS3UlAJOAkxOQGhPlYyXjbsfkT6/aQet/ZGrl0Y1AIqYBUJ4X+SqTWal+/ft
         Hif+R6iPmKfCj56u5OGAZ2VNHaxH3OB6D6UmujAz8yj/2wqE7jeiOymiBf3pYUyWooVl
         YXzWmfitEV88dBzgCcCd/2JrrGjKRBI/DpSZ+sVdYNwbQxDraeLM1AFKDaLM+KYnlrks
         SmPblyVARo64C9oaVtMUw+Z2IhG3fHvBYTwpqWhbDR7bbRVohpR2gSa3r6p/rt0FuwK/
         eS2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744720929; x=1745325729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NxizCHHa7XXdqltAHbClm3SimmzDh3es0NhFnQM8e+c=;
        b=KuaP+MvNkr+WtNT/LhfXEPmwj0dPh7paZbntaSBgTAgRhj1apUt37c2qfMG1CEaWyG
         +FV1L7HU0aqEQ4Vl/w0v9xK/nqG0fsRMTx+h4efaHkFGpo2rFrk0ui2dA6Gm0JaZyrAO
         4rZz5btOc2vDIsS896KA3oVwLgHe/u1l1e9utOCPaKIhYNV8bvVKnlUfdzWyJptq+vb9
         8tVZn2AqbD9yPqDJn6Llg7ZK71QyDdTr2FQXKdVBrOf4HIWwa+uSAm73j8ACCw5K5OzW
         ANacVa2/pLuMQu6qR0HfdNsm4X0235eXARd/6jG7pGbckBpO043+8j0CnQL1QiG7k9Iw
         WBoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKuHZo7ficWMqDZleQCjg2RVV8grLkbwT4i1ET7cMH2xeYEaSfGcse4SGifKNauznSXzqGMsszK4ibyjo=@vger.kernel.org, AJvYcCUxkLDUORT8LT2Oq3C8GIn9jxRhjyJlMRygTaBUoSPLsheTiGUZZQ3zofiocUfYU1g3BkMEY7FwABH/pQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnm4Nfy+j6MnHvGkp1oX8v2qNM0LYbDrHzHqvqINwHofouYvoA
	3yUVaFKWS/pkHxRXZUxSvrdLt5jvQOMcy9XBa3U9LMs8VkiAh6Nl
X-Gm-Gg: ASbGnctp1mD4rx+683DEvI/ngxQ+4PX6aV0qNhrUCp2N1ZK0Oek5BwU0fV9PY8e9Fby
	ihQBa4FlQ9Eriw/bw26+58Es+Wt1Wu7FWls4gZJujVQ9ZpGVd+ST4NUSysJSC3PyHYH62g3UEds
	VDNlaCaNPqFvmOY+hT+5E4dLnP+QfzeAUeMxXkyriMU3euQq+Z+VtL3vI+WeqkruRJJzGZABVxr
	HmFaPwymsMCxlZ7+pnPf5132zda0YJqn9oAyz70Q6ofKeor+wsx5sh0cd1jAFj9woFNGbLL8v+K
	8NdBCo0gUtLIXoebq3/K5arbypKljq76FNDih0nde0GpqCSl1j3L92JeS8a79GGPgA==
X-Google-Smtp-Source: AGHT+IEqS8oRVy0zJ7dTnHmtpYqvg7DBV4VoeR+gjekteYO/oUuIbjLG8Rd+q11AxcYgrKpA2D5PVA==
X-Received: by 2002:a05:6a00:98c:b0:736:592e:795f with SMTP id d2e1a72fcca58-73bd11f7d72mr16985913b3a.9.1744720929250;
        Tue, 15 Apr 2025 05:42:09 -0700 (PDT)
Received: from henry.localdomain ([111.202.148.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd230e5ccsm8339526b3a.152.2025.04.15.05.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 05:42:08 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bsdhenrymartin@gmail.com,
	amirtz@nvidia.com,
	ayal@nvidia.com
Subject: [PATCH v5 2/2] net/mlx5: Fix memory leak in error path of ttc creation
Date: Tue, 15 Apr 2025 20:41:28 +0800
Message-Id: <20250415124128.59198-3-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250415124128.59198-1-bsdhenrymartin@gmail.com>
References: <20250415124128.59198-1-bsdhenrymartin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Free ttc table memory when unsupported ttc_type is passed, to avoid
memory leak on the default error path in mlx5_create_inner_ttc_table()
and mlx5_create_ttc_table().

Fixes: 137f3d50ad2a ("net/mlx5: Support matching on l4_type for ttc_table")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
index e48afd620d7e..077fe908bf86 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
@@ -651,6 +651,7 @@ struct mlx5_ttc_table *mlx5_create_inner_ttc_table(struct mlx5_core_dev *dev,
 			MLX5_CAP_NIC_RX_FT_FIELD_SUPPORT_2(dev, inner_l4_type);
 		break;
 	default:
+		kvfree(ttc);
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -729,6 +730,7 @@ struct mlx5_ttc_table *mlx5_create_ttc_table(struct mlx5_core_dev *dev,
 			MLX5_CAP_NIC_RX_FT_FIELD_SUPPORT_2(dev, outer_l4_type);
 		break;
 	default:
+		kvfree(ttc);
 		return ERR_PTR(-EINVAL);
 	}
 
-- 
2.34.1


