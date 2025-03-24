Return-Path: <linux-rdma+bounces-8922-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60444A6E3C2
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Mar 2025 20:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CD593AD1FA
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Mar 2025 19:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0806319E994;
	Mon, 24 Mar 2025 19:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6Jd7D40"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381F77E110;
	Mon, 24 Mar 2025 19:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742845334; cv=none; b=SMua+zPGRcEZ8Zd05kt25i8tlG+QISfU+z8K4StQeTnYKsodJfI/rV5ha6ateIeXbHvOaXQVIZq0sfSf0v/CkbREI3giYGs3XCdLuxf/uLVcSMqAM6NCVmkWuObrs/e7201BPdiHR83kKtAAxvDlZN1aL5YRVuYCW3oQf/XeuJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742845334; c=relaxed/simple;
	bh=wjvf7dpV0ebRUz1x1lkf8kGSLRI6M0ozndN0RBxrfqE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aQto7IEmzeHO4KchtaSl700sZOCs4yKVzP/gW9We7b2JQC6IZ31p97318Hzo+1K7yCrTI0jXglD2sAqMvOAxcTKxP248m9TwlIsKJGtT58z+TkFI3G4JTzEBHSN5z+ToA3AabZnMDkCpQku/NKRcSgyRd7vnykfKRFo5d2BCLY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A6Jd7D40; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43d0618746bso32631025e9.2;
        Mon, 24 Mar 2025 12:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742845331; x=1743450131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=suij/OW43K54OojlDmuIhXYtdE6GSs8v7t7ioZFap+o=;
        b=A6Jd7D40ft/DTFaj3CFwgKpPJUBy3lSvDHeDnzFrl5WcbM/5iaTOy20iH363xXPApt
         owW1tlBspvQw/YPlLW44WpMWWi5n7ZNy3CQVQXaJQDsSKyBUqj69akpJ4mmwBQNsLvvK
         wXHV0h0F5o3tGuGw9ynszQqJQLzWvergKJLXZTeUL2/H94tJ0JrTWH4MCqWA/7UOj39c
         yzFjRskpU+tURvELeeGTaFQissF23AK++wGuznDKENp2Q89pRDASDoTXytQHXTR4Z8nl
         TEI4cA1AYk1xUzxR4C+zd8ECJuTqiYrGuXYM6jnYDGBhtf33Ll+IiRdu1G00FTgbx3S1
         XL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742845331; x=1743450131;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=suij/OW43K54OojlDmuIhXYtdE6GSs8v7t7ioZFap+o=;
        b=huWyF7/XfupKXVHUWLXkqkBHoOERefiLyUyotZJpF3aKehGH+TtTGNu1k1QGjj0fe4
         7Y5rYUuq4w4E+PQ1U84AkmxQh/VNQGLA8Z6giNZnuGEt3oKreSZf4EbOFxaeq0S/dNbZ
         lFQTGvyqQ1hqUxqIxiNmJeRZpEmITObKam7/sgaNZ2SATqZU2rzmqB8UUKunEyFlps8h
         7DWR3Y67EVIqENaI16eLAcrtlMb8RbwdpW5MMZlsk8SysiR9IZm7DvSAP+py0z1Od6PG
         Av4XeJwqyiwOjmXJzk9imjgZ0zphsSvfvF0lTAl1epELAXTfK0yNn9bp1OiMGFCm3QmA
         vyTg==
X-Forwarded-Encrypted: i=1; AJvYcCUOAl7VVyPgtsh4DpO4ZDtI8YG7EV1mhpRqkWiAFHWpOXKdqG7U0s0g3ZFmTYA1UlkAxjermzL3DJwoHA==@vger.kernel.org, AJvYcCUnWgNvBAp/TnXu/goDAetLWXb4MQFw1LPBV58iIfdgQigBIZPiqUx/QlghhuNWapppM3nTWTYuRNbHK6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEgqmaPcPjwvNvyEdGwERkqu8VFWDNhpuNwesmpMoNk2E5TQzh
	sCNansNqFwrsSvb37jsm+DzqwKceCQk9g807VyPUaQ0bIBjGc01v
X-Gm-Gg: ASbGnct7hl7rCjXOfgb1t2N/jFsjO/Qn/2so0Xi/WDsiwm5MEi9/y3e4sd8jmo9WoXu
	liWBt7Vvl2bpngAzIrM2HNXHX1SkuiLNX1iGeYMZBJ06/h9Rz7Kogy8b/z0L9eHfGS5EfBhFrlc
	ASvhKVleGUxUnFMb8KrxBcY0cc7px6Mz3r2Be7e1K4BYBi9ovUN8lVtZGt3ytW9yujWHsGe6hoK
	IaAHe9Ck+Z9Bge+WQFQCouMK2PSA0863R98EuC5maAbEGya9LcrhGRJWGFfodqOqnj+CwfjqFY3
	43+WeUbpPRMQg9mbA1BVKOBEpwA530xWz4/haBYavBcQHQ==
X-Google-Smtp-Source: AGHT+IGwh4Xj+BnReKWNtaT8HPJvDc560oL7zLXsu6bA2+6nz0kEmOB+OTqSGwkolim1qSAmJPkItg==
X-Received: by 2002:a05:600c:1e18:b0:43c:eea9:f45d with SMTP id 5b1f17b1804b1-43d509f64b8mr151515275e9.18.1742845331105;
        Mon, 24 Mar 2025 12:42:11 -0700 (PDT)
Received: from qasdev.Home ([2a02:c7c:6696:8300:7409:fa18:11fe:ba2a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fdbcfaasm128315005e9.35.2025.03.24.12.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 12:42:10 -0700 (PDT)
From: Qasim Ijaz <qasdev00@gmail.com>
To: saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kliteyn@nvidia.com
Cc: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net/mlx5: DR, remove redundant object_range assignment
Date: Mon, 24 Mar 2025 19:41:59 +0000
Message-Id: <20250324194159.24282-1-qasdev00@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The initial assignment of object_range from
pool->dmn->info.caps.log_header_modify_argument_granularity is
redundant because it is immediately overwritten by the max_t() call. 

Remove the unnecessary assignment.

Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_arg.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_arg.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_arg.c
index 01ed6442095d..c2218dc556c7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_arg.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_arg.c
@@ -39,9 +39,6 @@ static int dr_arg_pool_alloc_objs(struct dr_arg_pool *pool)
 
 	INIT_LIST_HEAD(&cur_list);
 
-	object_range =
-		pool->dmn->info.caps.log_header_modify_argument_granularity;
-
 	object_range =
 		max_t(u32, pool->dmn->info.caps.log_header_modify_argument_granularity,
 		      DR_ICM_MODIFY_HDR_GRANULARITY_4K);
-- 
2.39.5


