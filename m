Return-Path: <linux-rdma+bounces-10494-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0201ABFAEB
	for <lists+linux-rdma@lfdr.de>; Wed, 21 May 2025 18:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 212E9502C5C
	for <lists+linux-rdma@lfdr.de>; Wed, 21 May 2025 16:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A7F2139C8;
	Wed, 21 May 2025 16:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6lckxdo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D451714AC;
	Wed, 21 May 2025 16:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747843853; cv=none; b=SldoSUcA95ovVtUhBENz5tfA6sVIRPls1u4v/ziBYgqFx7Nl9UGnkus9jG67W7YMPUYG5ANo2OVbbzKb7ktvc7Z7iF1wbpX0juWR04RipWlvEtQoW4dFva0M0rfojODfHgmTAgOD8Gl4T3YWpjO6CVqFRNn2cco9iUThCD4prEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747843853; c=relaxed/simple;
	bh=x5muKbCVzItFqAnOAT50XHNKJhDgcS8Cum8SC4y29HM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AMdiaage1CsRKCa+JQy20cuJHAX8AQpNu3vUr6H0Py2MXI/rpxdqe9dfrSILr+YOK1BGGs4aWDjmNxESCnZemY80zqHbGY0dKl6aPSLixtjPYz1WBwFMoxij3ZpnrIkHsQGZL4aTE8Abf0ZZB06h+JsRnLRW8QcbkIdMGcUzwD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B6lckxdo; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43d0618746bso57017275e9.2;
        Wed, 21 May 2025 09:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747843850; x=1748448650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dFb/8UDIi4+DL9YBgWv8kfPMDoQAHsOz6JPN/DZoxFg=;
        b=B6lckxdoe5EcyTwx/a+4WWz4VHUAnRQGeSmgfyR68IZlmcC2qmN2W9mfrg+/rwvPTN
         kLgnnFjtAXpGmlVS5RN5RipXT7NgdSHED3t3DPe2WS73xPPU0cE/6kDwa1aODPDA3rBt
         12BCknmqR+AkJFFkREKdI1p0YPkWhhqNbq51ND4uURkv5bRhFv/zRofiDCTxDpb/F8pK
         OcNr3R/CBMg3KdTf6XmTF7yslAuXHGc6sHinQidfL4zVtl3ojFp0lRs7XOXdNghJRAFg
         ro+nMr0g+rMbT+qyAHm07tAJQ50mBF1X+EmrCgEDu4a/ggUeDAwgwPy+O956tHZj25bU
         WtEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747843850; x=1748448650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dFb/8UDIi4+DL9YBgWv8kfPMDoQAHsOz6JPN/DZoxFg=;
        b=ux4jeJoqC61IqDgyuLh/pe3ozkFMsR4UXoeaUz+C8p+cV6gLjl+LfJ+3FmI7euMMPx
         VOHIp+tnPCOzy/8HeGAC6sHUPovqEjOxdYG6Apu0tzNd16wxH03joabu1RhpL6m4m5LX
         DBUvegvPeHTrpVxHMAfCUYvmpK6fTvo2vusePz34VXW0+PqWy8NRzDzje8QhoyYGYnC8
         tYdnAhoKHywwr40EOTaonf+yPDyUnSChRiog44U+0EQmXUrU31xhkr+H4bfOqbDnmSyD
         lXkftEGymNl/KVbDf/c0Z9i2N4/4Lyi/QOjeUtKXhuc8vyCBdLUsBknZMrfkifElGHcd
         cVPA==
X-Forwarded-Encrypted: i=1; AJvYcCW5bcdL9FmzDzwKsOkgCSIC0pGfClE74a2CaXJ+iQlWQR8jOqbQlk8xeUd2kQwfIo1I8hPIld5E@vger.kernel.org, AJvYcCWU/UcDuVEDHXTB6coA3FIFb86NdIuFzLKtIG6ojn+7lDWRkl0xUWNU8bKnkrZcLLe3QyF0btEfvHTb@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv5G8NVNrAe45qmtwlhkZrogtpAEDALc1MlrbbVucD/qSyhPP2
	DTVMUk4MW+KDhe06YjO8ugBFq21YDAB6VjXrW1sc8/GUtFLOAMjZJe3Z
X-Gm-Gg: ASbGncs3a7gj3cnTlRTk8wKN7K4mFcX5ViJuz/xTYwOmkdYMpIBQ4RNgBm7YEYy+l5+
	/pL4MYVkTBH5OiMPAlRnwSUfMHvRNVSPeZEQfxrvhuF7aHWKKOySFqt8Bd4YYUtrQJ7w7PfN59q
	ZXSOUQ3F9I5dw12Ny0aEnVu6gZZj+zw4FcfogGxbFLgYtOaeSVTLcbQQGZr9AHqJy54AJ5Bi3cF
	r2wO/RLVhr8TwUu/yqQeelUoRmmjaPerNgr7U/rBPA6Y81OBZR4xAXu0JMvggHA7OoqigA/fTPB
	CilA6I6DMbA+smKPBY7yUUhZCGumfH6J/aCHKYEWbdDQtCJstLvR6TFNvuuUT70=
X-Google-Smtp-Source: AGHT+IHzIxNlI+zjB3xjUR+ku+S6qJVfmvxQ1Rdkn+jT5PKzhQ5pEuxf0DtxPakEoqyNf2Lbax4ZXQ==
X-Received: by 2002:a05:600c:c8c:b0:442:f4a3:b5ec with SMTP id 5b1f17b1804b1-442fefd5f8dmr219244645e9.4.1747843849476;
        Wed, 21 May 2025 09:10:49 -0700 (PDT)
Received: from localhost.localdomain ([78.172.0.119])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447eee9d8desm77947025e9.0.2025.05.21.09.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 09:10:49 -0700 (PDT)
From: Baris Can Goral <goralbaris@gmail.com>
To: allison.henderson@oracle.com,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org
Cc: goralbaris@gmail.com,
	linux-rdma@vger.kernel.org,
	michal.swiatkowski@linux.intel.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	shankari.ak0208@gmail.com,
	skhan@linuxfoundation.org
Subject: [PATCH v5 net-next: rds] replace strncpy with strscpy_pad
Date: Wed, 21 May 2025 19:10:37 +0300
Message-Id: <20250521161036.14489-1-goralbaris@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The strncpy() function is actively dangerous to use since it may not
NULL-terminate the destination string, resulting in potential memory
content exposures, unbounded reads, or crashes.
Link: https://github.com/KSPP/linux/issues/90

In addition, strscpy_pad is more appropriate because it also zero-fills
any remaining space in the destination if the source is shorter than
the provided buffer size.

Signed-off-by: Baris Can Goral <goralbaris@gmail.com>
---
 net/rds/connection.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/rds/connection.c b/net/rds/connection.c
index c749c5525b40..d62f486ab29f 100644
--- a/net/rds/connection.c
+++ b/net/rds/connection.c
@@ -749,8 +749,7 @@ static int rds_conn_info_visitor(struct rds_conn_path *cp, void *buffer)
 	cinfo->laddr = conn->c_laddr.s6_addr32[3];
 	cinfo->faddr = conn->c_faddr.s6_addr32[3];
 	cinfo->tos = conn->c_tos;
-	strncpy(cinfo->transport, conn->c_trans->t_name,
-		sizeof(cinfo->transport));
+	strscpy_pad(cinfo->transport, conn->c_trans->t_name);
 	cinfo->flags = 0;
 
 	rds_conn_info_set(cinfo->flags, test_bit(RDS_IN_XMIT, &cp->cp_flags),
@@ -775,8 +774,7 @@ static int rds6_conn_info_visitor(struct rds_conn_path *cp, void *buffer)
 	cinfo6->next_rx_seq = cp->cp_next_rx_seq;
 	cinfo6->laddr = conn->c_laddr;
 	cinfo6->faddr = conn->c_faddr;
-	strncpy(cinfo6->transport, conn->c_trans->t_name,
-		sizeof(cinfo6->transport));
+	strscpy_pad(cinfo6->transport, conn->c_trans->t_name);
 	cinfo6->flags = 0;
 
 	rds_conn_info_set(cinfo6->flags, test_bit(RDS_IN_XMIT, &cp->cp_flags),
-- 
2.34.1


