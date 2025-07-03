Return-Path: <linux-rdma+bounces-11859-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B6DAF6FEA
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 12:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1A5052514F
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 10:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF052E267F;
	Thu,  3 Jul 2025 10:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRp0noeF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F1D1B95B;
	Thu,  3 Jul 2025 10:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751538169; cv=none; b=RJDCvJEg2p7ggSPU7SwSGQONt+If8jg86pZ2YnZZjDPFAsd/PGJleZdALEidJgvoi5RCXl/AqiwyHaohTlaaa29jdRmc5bh6v6kXmFTJOKPDf2mPYLCdeikEUgGLOsUYHiIMDlihBq8vOiSp2d39RGRbNEigfPcfxzI+JRJEpzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751538169; c=relaxed/simple;
	bh=MIb4mxnyzw0FyX4juSZYNLVctI/6u3UOGdOyvRwMQBo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R0iKKiS/IhSYOqY56Lk6H0Uoq4G82Xw5FkhUlRzcyOwErbqjSi9NzRQD45RdXepSrS8GkyAY0p3t6Pb487c1kNH4crEQgvcaTcdFeX7m7Tfu93FzqWSlAc3LfUGbMNSeIkzBGht8JQI6x8lf2oOuG8K3DQK+tBVW0Md1zU6SORo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRp0noeF; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a582e09144so3838511f8f.1;
        Thu, 03 Jul 2025 03:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751538166; x=1752142966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xVW/TWU56BTmNKF84fv0OAX16cBot7rYW8ArRsg5mkE=;
        b=KRp0noeFUuI1QV2Sft8b4x4s2aCLLGOEaLkRbUd6OJSBWNqACY0slzH2VZ+L28vCpH
         /9qusGMC2J28ztXhOzCYAp4MVFaup8gtY3967A+pgtPpsikaSnxdGOwZVztLJO2ZZWVs
         QKkYEgP01iICpFlzaBgQiCQmO5KpC2uOn3Y5W6xlL7CGrwkYE11FZGFBEG+uYA7nTNof
         18d+bsSOw1LBKmhGKTYDTqgcgCkWHQ8noq3PuIolgJrHZAyWbWcmbadAcCG7zGVLkXSf
         P9xcz0WJWwjfrjfnN8Bp50zF3n4pA1/Bt2/v3jcIh85MHmTXuTnDL1azOLOmjg1ISP+t
         g40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751538166; x=1752142966;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xVW/TWU56BTmNKF84fv0OAX16cBot7rYW8ArRsg5mkE=;
        b=nYhf2ugMt2Hhqk7WPBuIVH2fec0LPbqag8IzxiHxBttbOizQkN2WO8CVwaAI0SZrvy
         M0SJ0eKtTaYOxOZr7KL9npCyJiEqJVT88EFvLl/UlqTDYFtSqIga6pyqkQhe3/lo2+Ub
         Td3UlF9GuYrOFPUEbsqAAF5X10PK8k64tvTS4wAR+IXOV75KHW3erUis78ZirbC8+yex
         zV2zPrW0HVzTlKaYlJmsA59823PAU2JQ7739Sv42p8M7mMPMS5yx+m/jL9c6CZwVzQBK
         OBT5KkXhABJnq3ZILCJbNeTwP/c3em1M4YWtHyPHzYOEzS4R0bwNj6RyVySU/XwcZkkw
         xMjw==
X-Forwarded-Encrypted: i=1; AJvYcCVndsh2TzlpRDgqwTN4MIpGPGmb472+JF/DNx2Y+6PGEzb5WD3NQLVpruh/CVclaMrMSVQCjb4BRg2/+Xo=@vger.kernel.org, AJvYcCXXJli20xyi6aTTDrgjEOSbPbE9/5qD65AUy1FEcuvTAHOIbMLrkcNCEx8H/ZcUStUZj4/7M110@vger.kernel.org, AJvYcCXdAPCqq+Rcj4rvA4EFvxajK/45dbOvNeY/24nbNkQuclMBINt0Mtuj5WkBB1XD+GeU70DtcHUECh16jw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyHqpD1I9Gr24i/3gppp8EJ2cK8CQTPNfW3cXppKJjjhdysTnqP
	BI1H4T225L+z21D/CdI8bOQe5F5JBpnetB6P8WUuqKqyK148F2yAJvpO
X-Gm-Gg: ASbGnctU7ZyPRUpUERpDDYm0+QxDs4gmVbo2IBeYVAIh8u1CK8pTP5+zwasf/xT1WF6
	qN3xugRkVbEacLeAhqICcq+KTXeyo64TQfKHvA7jIYDtd2VX6F09m0E+aQAmyT11f5Z0e2mpkb7
	S+zz9JxtSiNzzth9SqZWQi3KEecdDyyMQZCz6uPSWnOwSAbaD7IO+4POmwngpFgFVAhDlGFQbwg
	P3LtAZdxO+UbUwwn2XsSro9l0QqNETU+SFLopLVsnojECcylbf4mA6p1FKy4tbejSNuJs3k9Sez
	wmjrZd9c2APuypykb5Q9XSXOn03isYMSHf+tGR6Rhv07SewQWePnGqIPohH3
X-Google-Smtp-Source: AGHT+IHx9K8dEssVjiGHPZZBWT06I6nJjqhfdZoFmqrLy6ZGIu7Jpn6N6Q2DksWjUHr6xHIQrbgIzQ==
X-Received: by 2002:a05:6000:4028:b0:3a4:d4e5:498a with SMTP id ffacd0b85a97d-3b201016931mr4974051f8f.42.1751538166292;
        Thu, 03 Jul 2025 03:22:46 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a892e595d1sm18456831f8f.71.2025.07.03.03.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 03:22:45 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] net/mlx5: Fix spelling mistake "disabliing" -> "disabling"
Date: Thu,  3 Jul 2025 11:22:19 +0100
Message-ID: <20250703102219.1248399-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a NL_SET_ERR_MSG_MOD message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 154bbb17ec0e..7ca6bba24001 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -1353,7 +1353,7 @@ static int esw_qos_switch_tc_arbiter_node_to_vports(
 					     &node->ix);
 	if (err) {
 		NL_SET_ERR_MSG_MOD(extack,
-				   "Failed to create scheduling element for vports node when disabliing vports TC QoS");
+				   "Failed to create scheduling element for vports node when disabling vports TC QoS");
 		return err;
 	}
 
-- 
2.50.0


