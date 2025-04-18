Return-Path: <linux-rdma+bounces-9534-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C81C0A9300A
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Apr 2025 04:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E919A4481DA
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Apr 2025 02:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A5E770E2;
	Fri, 18 Apr 2025 02:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqJeIsTl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C49267B12;
	Fri, 18 Apr 2025 02:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744943905; cv=none; b=V9NkP6HhFry1Myh/kHb5HwtF9pQdz868cB834bZRmk0+bc2Mi/Cu/vIdNcz0hmD3CLeAOQgu5/gdA7M9Hj2j8gm0Rt7LsvOUFwVMpmFZt4uMLLAkyupJMB40A2nshF/cg5WRaxJQmZ1alX8o67cIKv0zsoeF7C+j+izeY+X7ySY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744943905; c=relaxed/simple;
	bh=w5RzLksqRnl5QxaAsPgtygvTlr1+V8VM+ufHZCm77QA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z7x7W6T4Q/GvldnbKOzZoiMTq8jyNs6ek1mO4hT+o1EZ5bD77uN+PXKsoGXtxZjzS2qQgd83i7N/CR5UYx+sCIgC0nJlsBgYpUVdu74NyvvjKsyQxTZ66ob/MEV0MHzpHoaB1+LhIQGeIjjl4tUAKKB65dxy+2BNVim9FdyeBtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OqJeIsTl; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-7fd581c2bf4so1254994a12.3;
        Thu, 17 Apr 2025 19:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744943903; x=1745548703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gc9ETUlXAwHL9WYHin7FZ0e7X2RQp7jZ6Z40mw+LncY=;
        b=OqJeIsTlrAoRG+vOueS0DESJ7JUPRnkuAiXpyGI2j52gPuHBQIW04z7RBDoMx2IAWv
         Hm9X3eia5Wq7wWJxOgy/xNd4KPdOAgXNG/QB7TIaCf/dkPucqq1ERNc1M4+mb+1xkeyY
         2gTfUaUd76Ruqj9a/zMxgl239iRKEd9uAqW70A9Z0WPYwhWeyVdQLS6MJ+dDS+WZCUjV
         8WaHqvHC8cFz0vpGLMHAoxhqeZSLXlQ4HPVI7UQIDv7/A7PFyRwQOwGAIEilmU+ZFgP7
         9JUwl3CdeyUaxb54El0eHJda7SXxlX1K2eCGN6mZg94GjA9k7pEU3EzvNfTI62Tm1OEd
         jM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744943903; x=1745548703;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gc9ETUlXAwHL9WYHin7FZ0e7X2RQp7jZ6Z40mw+LncY=;
        b=evmQdJG2CYRjMeYUeHUnCFCvRNpribwdHMjSPK41fbfJIzZ3JhQ0CZl3tzr6jAQ+Hf
         Uv1N+bRUIl27uPulpIPTWASQC9F6qZUVyw3AOsZ9uFxZVIcKZW0PrT4M3rGYcUxzdm4y
         hHfgosxo4fLhtx2+uwgkZkm0btfDGAgawAc6GXLFZyVAhfRPpyzH4yCNeUznlDW06DwN
         gxsvBDnuO/5xKglcaXL9dz5P6IpsmaVN8OS/7H2kY0QhOasnVRuDzY5KVsowkytZGmrc
         6QOicNC6IHF6ZaW+TEuHNSiXrvdXAUQowRHskxj77aU4bLUwi95lByWc/g0nLc7WhXlh
         7MOQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7jwBMvHkElsrHOAPPLTtxe/sLqJMI4zDICH4p6lUMQBkXQzuQD0R0h26+gG6yP3ifGF8dCyx67Ca0k/A=@vger.kernel.org, AJvYcCXkCIII8Kll1oqbEA33tLdPJWEQPexWDj5RAJ7MAp8I6/5OtcBxt4mD85LEaVcPE8ZeqULYb+s03iiwWw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYueHeaZmvh5M1+jHRuo8U5JpQxbhntODUywCW6G6EVkbrI1Jy
	5WKgUZoeTx8nkNxKtuasczXI6xgBq6SbihQiD2bMrLKSBpQqiyEx
X-Gm-Gg: ASbGncuIT8AR3NXfQMg/sLX6uChabos9/zf1lMDvsBUVFhS9crt0bD9hUNxHrjDWSy7
	84DS+7fh5jb4xqynfiEVZf++8Seg78usDYZ96OauapmAcYztvkIHaDSmLIy6WtAEGcqXDjXcZnB
	Fm9hv8Ck2lVRg/b0KozpbAq3EwyHXOFP9ZfZCqPz7sG8+2a5b0XR9vtabfdpc2DdrkQMXb2iKkh
	tBvvawTtRAPfOX3OXBUtrqQBV0AKh3iNTrLBDRkAhNNHRD/3jaCCEQFuPAa+rgmB3OVzQGUhgMq
	GwfmZ7bNicm5V6sWsrjTmz6i8mY1kTAzHPrnrXWf4PIh3yAK/wzBJKOlytVo6G1cp9c+TF5bjO6
	Z
X-Google-Smtp-Source: AGHT+IGT2w3OgzSs5lpY0rNfwlOnWnwBmWNqnXJ+x8uQcXegX5dnLjsLQRV8pyAjoCRF8fdFNAnadA==
X-Received: by 2002:a17:90b:3849:b0:308:637c:74f2 with SMTP id 98e67ed59e1d1-3087bb63144mr1860538a91.17.1744943903434;
        Thu, 17 Apr 2025 19:38:23 -0700 (PDT)
Received: from henry.localdomain ([111.202.148.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3087df0be00sm189919a91.14.2025.04.17.19.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 19:38:22 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bsdhenrymartin@gmail.com,
	mbloch@nvidia.com,
	amirtz@nvidia.com
Cc: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/2] net/mlx5: Fix NULL dereference and memory leak in ttc_table creation
Date: Fri, 18 Apr 2025 10:38:12 +0800
Message-Id: <20250418023814.71789-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series addresses two issues in the
mlx5_create_inner_ttc_table() and mlx5_create_ttc_table() functions:

1. A potential NULL pointer dereference if mlx5_get_flow_namespace()
returns NULL.

2. A memory leak in the error path when ttc_type is invalid (default:
switch case).

Henry Martin (2):
  net/mlx5: Fix null-ptr-deref in mlx5_create_{inner_,}ttc_table()
  net/mlx5: Move ttc allocation after switch case to prevent leaks

 .../ethernet/mellanox/mlx5/core/lib/fs_ttc.c  | 26 +++++++++++++------
 1 file changed, 18 insertions(+), 8 deletions(-)

-- 
2.34.1


