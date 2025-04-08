Return-Path: <linux-rdma+bounces-9281-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 777C9A81788
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 23:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 556EB4C2BA3
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 21:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A58F254862;
	Tue,  8 Apr 2025 21:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvWwiKZX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A200625291E
	for <linux-rdma@vger.kernel.org>; Tue,  8 Apr 2025 21:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744147321; cv=none; b=b06VPUO2ChRDXkcuiUPH84pKk4BsyiupefeW/CU0yZ6vMAbklx4RDNDfDN0haXMgyPNhoGfqFUlVmL54khPqKMN4VNGoSdUNlTtt5P/eIIbz0gkJGh2Ooh0fYmaB+Apu/DUgQ5QoRtOVM4G+Jm7DtKmk7JBC84ymjW2qsnI6bdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744147321; c=relaxed/simple;
	bh=x6TZN88WQbikyjqw5r9BuJ8HGOFdLu+jME35JB76srQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kim5OAKfjsTAySHKdoGcDHsQmTWTxz8mbWukP+TWEdXdPs5SUE+CH04Col3mCGXPD23Wv3ofsCYolwsQkAnCmur4pcuMzU3+uxlJU+K1E1Anarn+BsyxKQ1p14ZFoT2NUXR043B1vpGogTfKd7dCN8LyIDGijSSBjJWOlCNOiUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QvWwiKZX; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43d0618746bso44692585e9.2
        for <linux-rdma@vger.kernel.org>; Tue, 08 Apr 2025 14:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744147318; x=1744752118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zv2Bo1sbQ/znOLU52yFQl04ZMBZRAP4tf5oXvdbBBw4=;
        b=QvWwiKZXB95nOsltfQ+gvlNpJDo2e8uAj2HclyqfnyaGM9rHBLKHjsFw7uZS0l9Mq+
         skkflLSMXLEBitrm+bWXeqdSpyhUJe9FNikZZjxsY1N2dc0kv4CIrh4UI7fdR5ISKxmO
         q6bnnGDwfiwNL0DLf2Kwc97dYGSFOVNNsoNBT/PdG4a1NQVir8WP8kg7J27Nu6csAnZr
         DLJuEg+Qi83xZenXGhL26RKjVHVzowgxR1F6puBb+hoxshiHClCBh5WtIZJjXLmTRz0G
         RR5DowvqYqAQeKZvbSwukN/h0cn+BIP/wJJxyFJ8NPKzstFMLo2NGfd89AnTFWH2C40v
         xXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744147318; x=1744752118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zv2Bo1sbQ/znOLU52yFQl04ZMBZRAP4tf5oXvdbBBw4=;
        b=vO/W0U4u/sm5+/XF6metaMvd10oEP/z+AAVeEM0v1misJFdRETZspJGYM0+IPtP5fl
         SY+43ZSBriXmvrs8AUOiTY8uLh0LT13+wRE2GC85yCjTsoOsAZ0gF1wXdnwbgN+P7iUv
         HgHmQXEmamkU1xpQC6IfMsgNK9Nv6t+Yz3P4gcFAEZQK/f1S1n9/HFHEHODKin0w0oUW
         62/ixJBF4F/gAJdhzs2vUbhITf7ocYJJS7jwpcYkQAEBL8Da9m71nf3VsU1Ye/7Ngig8
         DbxULXQwgIXCU93+N7HkkUmDntbPRlfUs6Xf/pPNPZp8RVodUujDGNDHH9Xut4Ihh7L/
         FSrg==
X-Forwarded-Encrypted: i=1; AJvYcCUDZN7P10v/6qVtuBIVYNnZsuTb3Z/RCzcJNnbbDFfLKcEgHNqat/HmP+PfRtqn5M9GYta/DPyl9par@vger.kernel.org
X-Gm-Message-State: AOJu0YzJHCd+SqW+9KQVBG+BL7R7j+Be6EZr1tsUTq834L+kgAsyq6lQ
	9Zn8Xm7PBSHy15HNEIjeThjFYXjF4x992g9GRmEbTySLG2NlkDYo
X-Gm-Gg: ASbGnctx6ryKTWNvzXg93WdN9MzqUF4G1CzZ/pEZA6gPaCmDUMCXMShCtCDbQ5kIyCq
	Nrla0l/Jpm3kSvO//bDyWp2UizAWsUygW8IENj9wTLcECIKMGrOILOTLG0BWkTiIAFw4DXX+IeS
	yvNsUgWX/e0YmKs/9/DccxX7Rm2PNsXYnyK57YlsUYdZODyweSUrCCjp+WLYNzex6NgaIhvMqwq
	7Iv7RzbcQwMRuBGkACXy1TrVRVa51AxvwmDEX5QVeOkcpFqIO0rRedo/TYHVA8BphxRTHFD/4rW
	dD9E2puvQft2vtJ0cGA+P16iY3CuobwkROXLq3ceZ0YURaIIlIL+Vi8Td0Q=
X-Google-Smtp-Source: AGHT+IGyO2Aw29Ml5Uh1jSrfNdD/tRGLmoFfMleFIwtOQiAPkn/eyD+KUinboqy+pn/+Yu/wrQC4xg==
X-Received: by 2002:a05:6000:178b:b0:39c:140c:25e with SMTP id ffacd0b85a97d-39d88538cf7mr165971f8f.24.1744147317650;
        Tue, 08 Apr 2025 14:21:57 -0700 (PDT)
Received: from localhost.localdomain ([78.170.183.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec364d036sm171616795e9.26.2025.04.08.14.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 14:21:56 -0700 (PDT)
From: Baris Can Goral <goralbaris@gmail.com>
To: allison.henderson@oracle.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	linux-rdma@vger.kernel.org,
	skhan@linuxfoundation.org,
	Baris Can Goral <goralbaris@gmail.com>
Subject: [PATCH net-next v2] Replace strncpy with strscpy
Date: Wed,  9 Apr 2025 00:21:23 +0300
Message-Id: <20250408212122.10517-1-goralbaris@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250408182203.GH395307@horms.kernel.org>
References: <20250408182203.GH395307@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The strncpy() function is actively dangerous to use since it may not
NULL-terminate the destination string, resulting in potential memory.
Link: https://github.com/KSPP/linux/issues/90

Signed-off-by: Baris Can Goral <goralbaris@gmail.com>
---
 net/rds/connection.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/rds/connection.c b/net/rds/connection.c
index c749c5525b40..4bb727dd13b0 100644
--- a/net/rds/connection.c
+++ b/net/rds/connection.c
@@ -749,8 +749,7 @@ static int rds_conn_info_visitor(struct rds_conn_path *cp, void *buffer)
 	cinfo->laddr = conn->c_laddr.s6_addr32[3];
 	cinfo->faddr = conn->c_faddr.s6_addr32[3];
 	cinfo->tos = conn->c_tos;
-	strncpy(cinfo->transport, conn->c_trans->t_name,
-		sizeof(cinfo->transport));
+	strscpy(cinfo->transport, conn->c_trans->t_name);
 	cinfo->flags = 0;
 
 	rds_conn_info_set(cinfo->flags, test_bit(RDS_IN_XMIT, &cp->cp_flags),
@@ -775,7 +774,7 @@ static int rds6_conn_info_visitor(struct rds_conn_path *cp, void *buffer)
 	cinfo6->next_rx_seq = cp->cp_next_rx_seq;
 	cinfo6->laddr = conn->c_laddr;
 	cinfo6->faddr = conn->c_faddr;
-	strncpy(cinfo6->transport, conn->c_trans->t_name,
+	strscpy(cinfo6->transport, conn->c_trans->t_name,
 		sizeof(cinfo6->transport));
 	cinfo6->flags = 0;
 
-- 
2.34.1


