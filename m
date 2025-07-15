Return-Path: <linux-rdma+bounces-12204-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB909B069B0
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Jul 2025 01:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 137E21AA5235
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Jul 2025 23:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB732D3EDD;
	Tue, 15 Jul 2025 23:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Aq0P36/V"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135262D29C2
	for <linux-rdma@vger.kernel.org>; Tue, 15 Jul 2025 23:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752620496; cv=none; b=bR2pgavnUkPg+BOmWTNV6qhBxJ//JVCyPWZ7ZYUpCRIGKSbmQxJDQCzW6KIi9tAO/nbWBWuRew8bj2kw5guItHW3Jo/60MDTREkceH+W9SoMJJTwLaeBLKf40P0q+d6sY3DqxEfE4+J6h41S4sn4O47hFmJfIgT9DfG/SN1i7+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752620496; c=relaxed/simple;
	bh=C0yIBGjgQuUwh2cILUg4KfKwRH5Zo3VTXMZAiLB5IzM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uTcddxpPF0nykLJQZ5f4hGoSdWyAo4fc9Gs3bCNrj8h030VyK/SENU4cd6ULDOwNnE4sGE1qq9ZxI2BJm7vZujOFR4rXrSfdTNei+m1M7BjBh5fMVHQdk1mVLw+vZdhOtdrfrW59OLNQHkbuqNOsfAaEnDA3DdnJqjaGGL/OTz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Aq0P36/V; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-73cddf31d10so2769430a34.0
        for <linux-rdma@vger.kernel.org>; Tue, 15 Jul 2025 16:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752620492; x=1753225292; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B4SWITf8rdF2+7Tku3l2OCdj3WOMyrXJ2wvElW7xvwI=;
        b=Aq0P36/Vw14ZTOSZP7VIoVXi0jFTCXxSroHDH9b1wV7v8QYZs64zqWi1W1JNVwADNZ
         tzJKbkbCaG2wczXIw7esS3v9YoRn1c+XrXrH578lawGjfqxViYMUlqv8aTuVmctyw0pN
         3hbX7LBqwQ2sXTiX3HiqKDQjOZIOS5I1q5+EgdKDizdV0HnM6Te5jiiw0ouhUAXT16bM
         uJT0EUXj8I9LkO+6k6KTxe/2eo3WHRSloo37tZ7qUyVwzUmmPDR/ekiERhxn8nUF46BA
         ix5d3m0XAx8s7bqczDZ/0AlMX9oe4NZxfO4ph1bRKC8GkeDPG6M1hXLP1ECisprPC/hP
         xR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752620492; x=1753225292;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B4SWITf8rdF2+7Tku3l2OCdj3WOMyrXJ2wvElW7xvwI=;
        b=VCEcsdAB7w48/h3M52k159shAaLPWkeQvm+VqSiP+QF/Ru/VrdN1B5rhCzCGLhNL38
         EiNnxlgo7aVZdL71gO73hbUUGYb9B3+owaeRBrBSPclCcaA6NIwmtj1CYT0U3x5CcUs7
         bYxWiYoCwkz9HJ7CfnZjspVKkno60+foSLnyV6NFDxmgSSST2v1VtC+3wDzeu2HmvRBo
         zBNcqILLRXc1Sdo0iR4AKQ/1N6c5K5Utl9Q2TD+zgwCYcHIZgocPfxZWnJ8kWnkPImjC
         TnM0mUTcCIjwWOJl7lvo6BecdPqOtdfGeyzfumdPl17+6YcVKzj6JfUPwjB/5GgvcEoB
         +6lA==
X-Forwarded-Encrypted: i=1; AJvYcCWVQkJosNS44OglOFtNrl7JnBiSh/eqe1BW9lny9r6fiRqVUbcRn7IDbAGRNUhjUFfPjQ6QFc4a+yzI@vger.kernel.org
X-Gm-Message-State: AOJu0YzxUh41IY9lEQbxQWW4LyBxcrZ19ER+9KBGwt2amz+JEO5pKATi
	YOss+JPI7fTIiB61ZyfGhtPhz6dFpTXwtzXn3eaBDaOqRTWi1+7D80mIOd7OiMrVJv0=
X-Gm-Gg: ASbGncvsX4gR9A0CvWBE8dvqs/dKr0JgwAyemcozP/QrfTd1/CXG4tjB8K351f05rPZ
	p0cConzEVf5/OH8XlMG/tbtRk9My5GpJDhZkJmvtsbhhNRBcuhI7jWjO+Fuf6X9w0w46vLDi9on
	GWR6rZAfzl6V0OxS/GinM3NiQN2IGKnnh0+boSq5l3gosEg+N3NI4bOjA1linl0c7PLomtucFHD
	rBIw3giyzVL5o+6MlesQpvi95yPe5AmbUOcXxi2M1rH0V6mBlWQ03iVNy/b8ujoRWV8w/3vnSxL
	xlMGd7wtr4nzIYy2IuDSSwQ0eHfGfooPlydCQtRzIJ5ddke32W1SqerB9lSWbtMnwqdiYaIk59K
	fjaZ97BIaOLnbtzhuFSkvmokh0ShEFFs83hzarqE=
X-Google-Smtp-Source: AGHT+IE8Nfeo8scY90CqHg5efo6nAkc64loFfqqe2YK8azM++ugsfehXsqpsTS6+ghhEcDe7uWrOaQ==
X-Received: by 2002:a05:6808:3c49:b0:401:e721:8b48 with SMTP id 5614622812f47-41d031f1f01mr437628b6e.8.1752620492132;
        Tue, 15 Jul 2025 16:01:32 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:9b4e:9dd8:875d:d59])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-41c267defd7sm558510b6e.11.2025.07.15.16.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 16:01:31 -0700 (PDT)
Date: Tue, 15 Jul 2025 18:01:30 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Carolina Jubran <cjubran@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Cosmin Ratiu <cratiu@nvidia.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] net/mlx5: Fix an IS_ERR() vs NULL bug in
 esw_qos_move_node()
Message-ID: <0ce4ec2a-2b5d-4652-9638-e715a99902a7@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The __esw_qos_alloc_node() function returns NULL on error.  It doesn't
return error pointers.  Update the error checking to match.

Fixes: 96619c485fa6 ("net/mlx5: Add support for setting tc-bw on nodes")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index e1cef8dd3b4d..91d863c8c152 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -1405,9 +1405,10 @@ esw_qos_move_node(struct mlx5_esw_sched_node *curr_node)
 
 	new_node = __esw_qos_alloc_node(curr_node->esw, curr_node->ix,
 					curr_node->type, NULL);
-	if (!IS_ERR(new_node))
-		esw_qos_nodes_set_parent(&curr_node->children, new_node);
+	if (!new_node)
+		return ERR_PTR(-ENOMEM);
 
+	esw_qos_nodes_set_parent(&curr_node->children, new_node);
 	return new_node;
 }
 
-- 
2.47.2


