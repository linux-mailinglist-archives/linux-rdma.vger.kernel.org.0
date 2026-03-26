Return-Path: <linux-rdma+bounces-18715-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOJLFvmexWlqAAUAu9opvQ
	(envelope-from <linux-rdma+bounces-18715-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 22:02:49 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B54BD33BA11
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 22:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9CF0E306C7CE
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 20:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40F639FCA2;
	Thu, 26 Mar 2026 20:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltCieQgE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C543A7F5D
	for <linux-rdma@vger.kernel.org>; Thu, 26 Mar 2026 20:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774558782; cv=none; b=tPWvG/JUroYWhR3GPvpdbjwVDRM5lbvS2g2dnVaWarxukpBSLbj17mNFPDzb8bawGgs9T5ZNRpEZmD4TZ3JRUbYwXsM0u2XHMg+gYpKMuJEl+snyueLEgNR+SV6jjWixWqECdwsU8hoUbZNe9k8+jj8SzP1glcf4Gv61GRdcpKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774558782; c=relaxed/simple;
	bh=pdWhTr13yB2TeUjNjTSrTEV1W426Ty4TykkxZVSVbJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=loSbCt10FKfir6unoxKSyfY0d1x8GMXJhoX5P626Zj/dxVqDDaUVxFlosrd8XoWb1jjxVweQREN2o1QE1OD6Eua1YC5kSUqSJkbYTUjDGWsn6nXRVLV0vUur7RKtKYBMgdlXNWuvmwN8jysDetwnTnniwg6CnVFeH9cq8vMTMu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltCieQgE; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a12cd0bcd8so1715225e87.3
        for <linux-rdma@vger.kernel.org>; Thu, 26 Mar 2026 13:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774558779; x=1775163579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R36FhGs7Uipw1Isw8Vzai14giCROBLkpYdIr0Y3wTOA=;
        b=ltCieQgEYDSmrv8WRGjF8kRHdcyQMQjDiK98tZmlU75UpeqLlw76qg9I2a5/ThozhC
         2RyyYshj1diPaoD62z6n05Hd3pAT/cMKJEsJIO78d9X33KNNVrjeK6X4ozAIYXu9YXRu
         oXSRZ4ZEdUcSNfdcu98IkQJ4MbTDAjmYpgPL4a8DNIm9GoU80GJ6L3akuftnOHbDr2/j
         yUF4AJXbfiQ3Sg7Yegl3cAf6Gx+abL/WFrCyJFIa0a5R2hJK8/CVTWBvfSGZu+dTdB+D
         +sBFo5v28vvvend+LdjMOX4KC123h+KUN9uUuF6OTg5Kyou4v/fMVjgbx4i3asg6VaxG
         nAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774558779; x=1775163579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R36FhGs7Uipw1Isw8Vzai14giCROBLkpYdIr0Y3wTOA=;
        b=dB/8feimouxCJIDgbwSgZpYzfUzLNLWpBDP4saTWZYoOBYi3K47cHki7ENdnGCmh/a
         jfU+EogcMFpAY5FYoCuM0K40ID9H/BLFrdjRXl1YnvzraMwPS//lQzGYf1z+JddopH4/
         raFzy1y8Ycfmbqhf3+UH1vj3Bw0cokxnHfCXD+23/8EVOv1xy0KtIlm3y8D0grxBk/H5
         cVi2Ne1lH1UNOQSct4tkp5Jv25Q3BqC+ApVWQsClbAY7XE18uugzOHyWEqPMHVvTbt81
         Im+ohdC4cXngNgFgt7ikEzZo1eIbpfoPpydegDb8hKMnaytGdIPfztiEUCBs/ad7Y8k5
         meOg==
X-Forwarded-Encrypted: i=1; AJvYcCVxDXrdZFHwxPPDsMF8lmYvgmULhyUq33mG1F4yJMvuat+WVy3Ozddy67LR3YxFJBU+tJcr2UE4EW5W@vger.kernel.org
X-Gm-Message-State: AOJu0YyFIn1Zsint3SgiVvFyCMf4g1NVIaMbMMZHWRJ70I0nXFD3ZNvs
	TowTw7UcZNy6jaOVfYIwOujfHHSSffJLDLTRdzAVGljGzj4wdvsEWyfN
X-Gm-Gg: ATEYQzwVX1w4DWlMaM+sYlkZiVg2AMG8evsqO7hgQQzkAEzd5SK+WIu43fX/ejWkLR2
	eAB/0U2EhyjQXGf78qeXUr5AaE6aGPfO8bvFtzcXgofJPQ6TZgsLyzOeL0/HEtA/lsFsExixTxc
	bIF9gDy5XGpbSHYgh9CRKjUYVefnp7EKagxspySmQ3ZjBpXJplbnFh3uou10ZxVSMYOVkAeIOAD
	Amnzr1tiNuMcjXc/6MK6+Cv/FdOw4W8IYi34La91LqmrV1G8iGobsJKVjcJsozvS1/iqngyNUMa
	1Tpv+erfi5ap01ZUpjEz0l8b3mKPQs1APHtNJnQZ1unlB+rOfdsuYxsvs7pAE3mFw3IRIuhlgmj
	rlsejvk/CGAINMvKlxIMBRY4Q/A+ETRclPLXTrByo71g+1OVZ7a0251ADuO+3U2q0jMhpEs6kY1
	6UIMPwIlnxX+/Lc+qj0Eq94v3kGLdqCNb3G15lOfHTD1KGLcV4ouSzsGZNRrdGNY0GQWg+l/kM4
	LB1
X-Received: by 2002:a05:6512:1381:b0:5a2:aa50:4c55 with SMTP id 2adb3069b0e04-5a2ab7e9143mr12706e87.8.1774558779239;
        Thu, 26 Mar 2026 13:59:39 -0700 (PDT)
Received: from localhost.localdomain (81-237-238-191-no600.tbcn.telia.com. [81.237.238.191])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2a068f5f1sm842596e87.55.2026.03.26.13.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 13:59:37 -0700 (PDT)
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
Subject: [PATCH net 3/3] net/mlx5: Add null check for flow namespace in mlx5_cmd_set_slave_root_fdb
Date: Thu, 26 Mar 2026 21:58:24 +0100
Message-ID: <20260326205824.11749-3-rayfraytech@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-18715-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rayfraytech@gmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B54BD33BA11
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

mlx5_get_flow_namespace() can return NULL if the namespace is not
available. Add a null check to prevent potential null pointer
dereference when accessing ns->node.

Signed-off-by: Oskar Ray-Frayssinet <rayfraytech@gmail.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
index c348ee62cd3a..c52d8ca6aa0b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
@@ -186,6 +186,8 @@ static int mlx5_cmd_set_slave_root_fdb(struct mlx5_core_dev *master,
 	} else {
 		ns = mlx5_get_flow_namespace(slave,
 					     MLX5_FLOW_NAMESPACE_FDB);
+		if (!ns)
+			return -EOPNOTSUPP;
 		root = find_root(&ns->node);
 		MLX5_SET(set_flow_table_root_in, in, table_id,
 			 root->root_ft->id);
-- 
2.43.0


