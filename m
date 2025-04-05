Return-Path: <linux-rdma+bounces-9166-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC30A7C8B7
	for <lists+linux-rdma@lfdr.de>; Sat,  5 Apr 2025 12:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 398187A812C
	for <lists+linux-rdma@lfdr.de>; Sat,  5 Apr 2025 10:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A391DDC10;
	Sat,  5 Apr 2025 10:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRwAhZAV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8EF1BEF74;
	Sat,  5 Apr 2025 10:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743848421; cv=none; b=oxNVU4TSrWMapsf8mE20w+ocUiLEil09dzVZz7XpKEFu8rk95jL4AZqBEMGzrNit5kEw39vGBtXihjQwZ3Vrdp1vvnuVKcECBEsqIx4zVSQozM2JYGIMAeaDPIKGpvYdrVGKup/5Cgh6AyJrRfS8nUyPBSRT3ygpQ4fPus68gag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743848421; c=relaxed/simple;
	bh=NjumOkPoCMJz5c1o9rgfdcQn7cAjdMYNDLoKq4jWNzI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D9n+g/IVYHCPDybdM+iqxYcbH29GlQitDKfuN6cqYFuP4FEgv1qXEQ+HMefzYsuBkD8ka9lcHxsM1ORXikYp3/T5rK9o+G31Io871yQJ57gdTyP+hJuwlhKwjTtiNPhkyhUV8LFqnyFbkvzANPzLonlO1LE6ReEHLONcAhdMvOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRwAhZAV; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-30572effb26so2546680a91.0;
        Sat, 05 Apr 2025 03:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743848420; x=1744453220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e8oqq+1z5lcjup3ct51URpJrm2ZmWv0Mc4Ufm2gfQM4=;
        b=nRwAhZAV28+XHQfHykZ9n1+hU4kVjQTYybnLd1EkcUBjDuGJng1WiDLfpYARjcTeCz
         wrmzdf0f5ZE1KfvaTFeLboJ465b2TQiy9NR9xB87fLoAvBAw3b1FDc38fv3drIwrfbQx
         pT2h+Y84F4wsw+xqz4y7nJuvW3rzj4Sf57vmKkqKQCgR3OtaXkyF1OymcXdaAYkeAuIi
         B4uBrMFejJPSrjU+ldU5CS9P5KdtheVRN5D8Y3Un885jYe0s6qvvuWkgKQMq4BrCFnc+
         duWDo+ufaDIrn5jmJRNQLKHlc2AELyuJqZbqSn/gyMvpIXmHiUNZ+W/hNo2sLkwSj4qp
         Q8uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743848420; x=1744453220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e8oqq+1z5lcjup3ct51URpJrm2ZmWv0Mc4Ufm2gfQM4=;
        b=jCMRGDOWd9hXbvE6huMwfJUWjx6s8gS1Pw1BC13L9Q0ZUID9X01mFXfCT8+D5kWHlh
         kOSNeX2eymBfxQVAyhYmys0oWerlowS58i72tIrqjqGA11Ei/3l+IboXc3a4E71gG3GD
         t/jVtZXa6x2a4POJUeRZDRlnqiK9YXXzeuLKmBzKKkGOJZrEdHAxktUCiBWRf22zRQvq
         JToRHghS7Q0lqSNGZsnVGld10fNHSYs0JvVqxM8VE51sRmLO/f0U6tI2bKU6tsR2+689
         RlN/uvpjLhZTR1CH4COGm0Jq9zAeTKD93ZPmDW4Mlb44W9JsY8Zxza2l5cgtZsQkOsU4
         6eWw==
X-Forwarded-Encrypted: i=1; AJvYcCVeXlhXncKdP2PYYYDGAlfW6iZQwFFjBIUv9RDvu5ZePiKlo4IL2EhQDl3+r0f8/bXvqSGoJbv8XRoEXg==@vger.kernel.org, AJvYcCVh7ZUU2kOU31EE73sjZPti75ghZEFfjh38vjQZCCcr5qhpJDPnLRr142onRMtNmxGY1Eixrrnc@vger.kernel.org, AJvYcCVuWlMykddYJclERl0vAl865DuON4BJpUk/LAQ7IRB7yeleXuQhHqRk30UrFwF/HBzAwCE+RDANI2EIj/k=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyy8AJNI3w9qM3G1wQBATFGY/wTziES5KC1c7V/74Q6eKJ8M3t
	C11HKE08mAO9hY+REQ1g+mx+1Mu+ebIBq3IcO3Pn3/VAxAj0DsJU
X-Gm-Gg: ASbGncvtmJ9cLYWk571ag54FItA8cxGi2dFMqyUmT9lcJRGiyPj+rZYV4hNWrcrbuag
	h9HF/aDHvOQ3C3VuBjOsUiSCutG+aitHKa1/2sxEDF/rBqza499ZRJ3jX1xKkh+8O4FQ6+fBf8d
	n2VNiyhou6aqDBbE1AwOJa+IkUP8mKHdLvFBbFtU0aTHZQ+pwOvX/ZS5LP7yR60UVht8/ghncU2
	awIg3K2Vw39HqZ29M3bXfVLbtJJaeCyHI7ekH931DMF9eA34SfPoExuhfL+WM1HeemfrFz/HfrD
	QOXw9oqY1cqaG9LAqPG86xwRYvPk4vrlfKQtVk8Jkn9HfRECFNLsMaK8RKkkFUpGt98=
X-Google-Smtp-Source: AGHT+IFnd+DDSixqNXBrpZFTBCxr48qyQWCpFj3gJUCh9eJfdNvZofLt59fbaDPpLX6t1EVxd6cx6g==
X-Received: by 2002:a17:90b:5242:b0:2fe:e9c6:689e with SMTP id 98e67ed59e1d1-306a4860b0dmr8718871a91.8.1743848419770;
        Sat, 05 Apr 2025 03:20:19 -0700 (PDT)
Received: from henry.localdomain ([223.72.104.9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-305983b9cfbsm5053185a91.31.2025.04.05.03.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 03:20:19 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: saeedm@nvidia.com,
	tariqt@nvidia.com
Cc: leon@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>
Subject: [PATCH v1] net/mlx5:  Fix null-ptr-deref in mlx5e_tc_nic_create_miss_table()
Date: Sat,  5 Apr 2025 18:20:08 +0800
Message-Id: <20250405102008.78451-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add NULL check for mlx5_get_flow_namespace() returns in
mlx5e_tc_nic_create_miss_table() to prevent NULL pointer dereference.

Fixes: 66cb64e292d2 ("net/mlx5e: TC NIC mode, fix tc chains miss table")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index 9ba99609999f..538c33c353ad 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -5216,6 +5216,8 @@ static int mlx5e_tc_nic_create_miss_table(struct mlx5e_priv *priv)
 	ft_attr.level = MLX5E_TC_MISS_LEVEL;
 	ft_attr.prio = 0;
 	ns = mlx5_get_flow_namespace(priv->mdev, MLX5_FLOW_NAMESPACE_KERNEL);
+	if (!ns)
+		return -EOPNOTSUPP;
 
 	*ft = mlx5_create_auto_grouped_flow_table(ns, &ft_attr);
 	if (IS_ERR(*ft)) {
-- 
2.34.1


