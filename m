Return-Path: <linux-rdma+bounces-18714-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEuNE1uexWlqAAUAu9opvQ
	(envelope-from <linux-rdma+bounces-18714-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 22:00:11 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 162F833B9CA
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 22:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B7C7730443CF
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 20:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C93D3A872B;
	Thu, 26 Mar 2026 20:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oZZTy2kS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8151C3A7822
	for <linux-rdma@vger.kernel.org>; Thu, 26 Mar 2026 20:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774558781; cv=none; b=QfsEQpnhgajsS2po3yNq2dRfgp++ZOOBEdg9qVtvQd88MSzZ9GtC084/+Iish/ysRGJyMKRwoeIGvpVW+QNRnaJIVVvApTu1rvs6QNWvMExf+fVFQtFgwdF0tLV4DjduIPEgIJ6T7p/C7Meb1FS+qfdpaFGCJLVYJdyF4lp6j0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774558781; c=relaxed/simple;
	bh=zjkhmr/61VcX+BSLwE00HTVsyPm/qhWsTHQ4Dov/aow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hvDDAijR1P978NvSkA2D3WDbzw71qBnzT+XCWE2xxJ07OAURXg7h+kB0Ny3Bg9VW6z/pN1KQqEP4dS3mXeiwhiqqBTU20Rg8fwEMRPlGkTpi2YY+DlF7lijWW3rFy7VUMxrBWf8hr8iUFu7M48Ld38IFIGIWtuGvJzws7B5OvyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oZZTy2kS; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a283c44478so1612904e87.3
        for <linux-rdma@vger.kernel.org>; Thu, 26 Mar 2026 13:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774558778; x=1775163578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AwvGgoJDadEWUFofhWZcAMj58lGXH2SGayO0FVAFsaw=;
        b=oZZTy2kSqVj2+C9Ajhd6jeqCvxhaT4o0Qs6yzExCox2SZlqxedj7NOtLp/NYWcs0qF
         mEDASQ5m5dC2v7NQazRLSux4ICncQUmReNmhzlZCxU0EmU7bPb6igglHmS2g7cgaf1Eq
         y0VEwBPsei/CHTK/VWSGSvTbaQ/+brDHjx/tr90iMOKXaxoB7yvN4zNXvWnWI8eLAtKa
         zhJGTM+K6EtBHVoGfzpvLEh7CY8VzmyLVki9ANF8UMkm6kkEniztEPMIEG9IEHPxni1O
         50qB4UwbPxbn3xxP4PrggQDidLxs5I7DMcxPaHbtpvcMYtxljOXW2bD6FGMD0imHCicJ
         1BZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774558778; x=1775163578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AwvGgoJDadEWUFofhWZcAMj58lGXH2SGayO0FVAFsaw=;
        b=TnUucF1F64TuXK0pmB8XO/kJZMXzZSDqN/htJoeQTbp9RBQOwuDPuHlS6nwo1QBCWp
         9TN6WXBz8Zo3gOdWDgbUoQj3FHjIzkcNdUKg9GfQ4piPyDuMU97x8Lm0W9SrVvwlO6N3
         01/gW9ouwz84oMjIwNz/kJPoCg7eiJ7COwknkHsdIuXSEnnT6Ac1tfud1CpzxLZ9YO8W
         aUFPeMVD353DmGrUoUzH9nVE6FBtmfMrVBZoApBINFfB1nIAj5vo9SJPY1AywJIjtevE
         qF8IJEFCoUHOXFKbQlHwNu2PQdJ7FrcLDP/31wG3snIapIsZZtLL8diqIEYanQ/Axjh2
         8XZg==
X-Forwarded-Encrypted: i=1; AJvYcCWmCPGxgLYdPIe0pNAAj8Ax4gnoeNAtTcBQbZLuMlyl9Vhw9++dYvYhTiKzdxoIxxiYkHXLSgZLJjkF@vger.kernel.org
X-Gm-Message-State: AOJu0Yxadi2dEUQybxNTsyMyhPUlFLvtweDzL62/vIWu9in5CyTxMBza
	pUpIYyXvr8PhAcqa92GpXL3XQ9y7GzyHwpAt0IFZkgaTnw3lPwf8xL+H
X-Gm-Gg: ATEYQzwgHJ0DVsgi5hTEjhS9aQXjAnjJ4zE5cucNZ3KGLbukeGWypGlQAe+cceKTPRn
	AVJDNNf4Fe65AwRobKr20JY8bIv8uZjf9IbqXHQUOdBPlQEww6Pl+aKxtz7H1dPdofr5TrqQiW7
	MBfqKUvd6wk/VKJ9rIE8RTLNemsucc4ypgzXpvF+ufwaT08An+0yPSLRVlJttEWMuQKESFnt0WK
	qYj8/3fyuE9MDJ9yjlP21/vUnmkDKstam/JKTqEPTifne3d359pfxBpb7gc5z8mAwTQfr5RInBn
	uWYdHwN7ab3Capv/5L2vHQfnfNkyfAikEl/c22g/q8YdE8kFgMLvBxSbnNEeyXw+iOQY3GRPNtd
	TJ2WrDl3nJLTZixeYKtysRoXHOgjYfPZUh73ERE4Q96Phdh2PSzePzzn85tlkQ9uW0UbWibJetn
	jcu+Hi6dzMBrvlWqDOx6vsTufJo86Dci4cY2lDpTcTHF8Y1fATX8mXv8IFq5G+IPCjjTN7lbxWZ
	1yiQg5+S6PgenQ=
X-Received: by 2002:a05:6512:230d:b0:5a2:8495:965f with SMTP id 2adb3069b0e04-5a2ab7f1deamr9497e87.15.1774558777462;
        Thu, 26 Mar 2026 13:59:37 -0700 (PDT)
Received: from localhost.localdomain (81-237-238-191-no600.tbcn.telia.com. [81.237.238.191])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2a068f5f1sm842596e87.55.2026.03.26.13.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 13:59:36 -0700 (PDT)
From: Oskar Ray-Frayssinet <rayfraytech@gmail.com>
To: saeedm@nvidia.com
Cc: tariqt@nvidia.com,
	mbloch@nvidia.com,
	leon@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Oskar Ray-Frayssinet <rayfraytech@gmail.com>
Subject: [PATCH net 2/3] net/mlx5: Add null check for flow namespace in esw_set_slave_root_fdb
Date: Thu, 26 Mar 2026 21:58:23 +0100
Message-ID: <20260326205824.11749-2-rayfraytech@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260326205824.11749-1-rayfraytech@gmail.com>
References: <20260326205824.11749-1-rayfraytech@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-18714-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rayfraytech@gmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 162F833B9CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

mlx5_get_flow_namespace() can return NULL if the namespace is not
available. Add null checks to prevent potential null pointer
dereference when accessing ns->node in both master and slave branches.

Signed-off-by: Oskar Ray-Frayssinet <rayfraytech@gmail.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 7a9ee36b8dca..63aff6255c02 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -2821,6 +2821,8 @@ static int esw_set_slave_root_fdb(struct mlx5_core_dev *master,
 	if (master) {
 		ns = mlx5_get_flow_namespace(master,
 					     MLX5_FLOW_NAMESPACE_FDB);
+		if (!ns)
+			return -EOPNOTSUPP;
 		root = find_root(&ns->node);
 		mutex_lock(&root->chain_lock);
 		MLX5_SET(set_flow_table_root_in, in,
@@ -2833,6 +2835,8 @@ static int esw_set_slave_root_fdb(struct mlx5_core_dev *master,
 	} else {
 		ns = mlx5_get_flow_namespace(slave,
 					     MLX5_FLOW_NAMESPACE_FDB);
+		if (!ns)
+			return -EOPNOTSUPP;
 		root = find_root(&ns->node);
 		mutex_lock(&root->chain_lock);
 		MLX5_SET(set_flow_table_root_in, in, table_id,
-- 
2.43.0


