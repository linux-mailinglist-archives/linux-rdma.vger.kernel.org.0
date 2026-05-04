Return-Path: <linux-rdma+bounces-19960-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGj+JoMb+Wng5gIAu9opvQ
	(envelope-from <linux-rdma+bounces-19960-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 00:19:47 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FB54C458E
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 00:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B62403020E9E
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2026 22:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1D43815DC;
	Mon,  4 May 2026 22:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZ0sQ5KN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209CC3803EF
	for <linux-rdma@vger.kernel.org>; Mon,  4 May 2026 22:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777933172; cv=none; b=Hp/KAM1K8nSBDLGuvN6xA4MBPMWgJyKeZHHuPzMahgSOlLLvUyR5K21PGcuxWfMjBhJyrfCnIykmqg8KebYVZhzaG7f/BfSoiA9bPYu1CvnnBGkeIh3V12ZIEVpoUnPU1t7UZDiPi34UEBy2yC/ilPvMh8HdPNBMwl4rlEuKVl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777933172; c=relaxed/simple;
	bh=ztdrt9vzdAq7Eb3jA8QSH/Kuq6wH7FHBH/eCinh7P78=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rXLPw8yt6jkroR2ebVcPXAgeaSeOaIeq7UBw7cFXhleSzF3x8Pt5mbym/r54qCCuzO5lmbUdh3csx5WAALL1KVbjxRHgTxlXy+LVjpgvx3qKbeqUwuVVwoxt5NrzL+dRzxeAEI/CQPKxHvRG4Lh3HUAE3kJ1coviWXzM7dzKl4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZ0sQ5KN; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48896199cbaso40663905e9.1
        for <linux-rdma@vger.kernel.org>; Mon, 04 May 2026 15:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777933168; x=1778537968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KI2VHwPQhpEIeLDiMOieSMNQDxnxTzAkBbt4N2Gn7vk=;
        b=WZ0sQ5KNwc9UKb87PbRpwUbhzHCinR220WgIiug2lm5Bi43pCTBtxHXdBQsO4So5v9
         6k1JykPH3zptZbL8xYFjIFYoaUOC34LyYGg9RGPusyw+nzwyNv5p/WLRLlft9sPWeLuN
         PY05vc8/7VKF/tzXexpNum/VRNtOaCRAmbBiM82Bqn4l0FrBc+2NIj7OG6Un5kL1yAnU
         aPpmAx7LYaUlTLyyqH62NjJVi7wZIUFk+WVfPLIKCaz64XBC+n9NCNGwPKwz3BzuRa39
         SZydJIGuQNk7m1SfgSlsoECv3b2V+OYzxlw1NU9fk2Ab77rq1UuvCiMrdg0fA/q8hBZ6
         AZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777933168; x=1778537968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KI2VHwPQhpEIeLDiMOieSMNQDxnxTzAkBbt4N2Gn7vk=;
        b=eqiq+YOzvObnZdiKp7rBL3HqQ8KvYjvpaN4RrcYr9Te02bC9qTV//wrjRyZiZK3jhd
         7jF3JwR0h1kGJhgqnOLHnFL6oSkRUsEecsqgEqdKccadKnzQt7YjunlX3iRNbSv9DJ/8
         6x7pPImW0zkXKJqpjwzbGi4lqKOVWR3riiqoiuzSef25jHQ2weZpPU31RNSAIHPboJbO
         V5qHbrAhJFTYOZ95Ql55w9y2lOn8oI8GX5FSD08Aq+IBe8OdWoD405YAGRCt0cGnn0s4
         HAMUhVLn0VSI6MagZUzzlJp/K7Fd/LKHJYDvLZEJDAPbCjtk2QlWf0Op4P1qaZ+GO9rb
         1oSw==
X-Forwarded-Encrypted: i=1; AFNElJ/QYtyhG6po0Wq2ABUSyf5wBbpGwOe9g9qAy4cCUO6gwwmCuR1cCUUnIjyiTc8/P0mZlNcYQAGYQZj2@vger.kernel.org
X-Gm-Message-State: AOJu0YwMBnHr11SCSnMrIDM5ogGQ4x5Gz6eGpC7mE88oKaOSXUaeqrIj
	EnY+kt2XF5j+fbYZf7Jn5dZngp6AUPArO4WYyFHfWqLzYvOMN4GRoFLE
X-Gm-Gg: AeBDievvqidIXd3igF/CCfiqn+sVR0XryX94xv6RNHULXuYRgjlT/wxRAF+j/jI98iP
	VwNO4BFiu5+AnmnrDKKrmwULgWxzTQFcVWURo5yJ0TpwkRs/toEDgVo84/QmV9HvJCdU7bfRBQV
	I+9mcUspgnpHNPjvU9u/++Rgtd7XtR+lb/zpcZaDw3t1SUjxsatRDJIvOOFTf1exXu8YxrAKe+T
	CRhmnzBIdsBWJHvohlusReApAQmwdUlliohL4xUBjKfeF+RMDe7X1syeV634/dzID4qGEW76J3e
	nvMGJfNzjarCWfl2GTHOjtJHpH7i+fiTJENdOfr2BzPik5ChiUSGodqV4CtyjklnWdlxMWyqgR7
	k8BCmqVR2ojNjk/McY9Su9hsHYOFoNcrnmLV3QliRC0DSV1xW7XNsiDgElt8jdSEE75K9KzGh+S
	UYyCt3sUNnp0OWFyQvXmKoNAP8l83Sk7Qp3PW3RLzcPPlkVc72v/tJ8Pt/E+hmHohoSj9+8eBe3
	HVwv90ajfCwSA1+k8bobIaD4i6kZmMSXLfVP8YSjg==
X-Received: by 2002:a05:600c:4f05:b0:488:c683:be89 with SMTP id 5b1f17b1804b1-48d188dcc95mr6010225e9.9.1777933168454;
        Mon, 04 May 2026 15:19:28 -0700 (PDT)
Received: from SD.localdomain (heme-13-b2-v4wan-167795-cust403.vm32.cable.virginm.net. [81.108.45.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8ebc4201sm484802335e9.15.2026.05.04.15.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 15:19:27 -0700 (PDT)
From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>
Cc: Moshe Shemesh <moshe@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Subject: [PATCH net v1] net/mlx5: Fix HWS L2-to-L3 tunnel reformat release
Date: Mon,  4 May 2026 23:19:17 +0100
Message-ID: <20260504221920.48685-1-prathameshdeshpande7@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 26FB54C458E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-19960-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prathameshdeshpande7@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]

mlx5_cmd_hws_packet_reformat_alloc() allocates
MLX5_REFORMAT_TYPE_L2_TO_L3_TUNNEL objects from el2tol3tnl_pools with
MLX5HWS_ACTION_TYP_REFORMAT_L2_TO_TNL_L3.

The deallocation path uses el2tol2tnl_pools with
MLX5HWS_ACTION_TYP_REFORMAT_L2_TO_TNL_L2 instead. This releases the
packet-reformat entry through the wrong pool, corrupting pool accounting
and potentially moving the bulk entry onto the wrong pool list.

Use the matching L2-to-L3 tunnel pool and action type when releasing the
object.

Fixes: aecd9d1020e3 ("net/mlx5: fs, add HWS packet reformat API function")
Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
index aca77853abb8..60fbb048db10 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
@@ -1396,8 +1396,8 @@ static void mlx5_cmd_hws_packet_reformat_dealloc(struct mlx5_flow_root_namespace
 						    pr_data->data_size);
 		break;
 	case MLX5_REFORMAT_TYPE_L2_TO_L3_TUNNEL:
-		pr_pool = mlx5_fs_get_pr_encap_pool(dev, &hws_pool->el2tol2tnl_pools,
-						    MLX5HWS_ACTION_TYP_REFORMAT_L2_TO_TNL_L2,
+		pr_pool = mlx5_fs_get_pr_encap_pool(dev, &hws_pool->el2tol3tnl_pools,
+						    MLX5HWS_ACTION_TYP_REFORMAT_L2_TO_TNL_L3,
 						    pr_data->data_size);
 		break;
 	case MLX5_REFORMAT_TYPE_L3_TUNNEL_TO_L2:
-- 
2.43.0


