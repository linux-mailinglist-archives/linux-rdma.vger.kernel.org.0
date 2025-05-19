Return-Path: <linux-rdma+bounces-10412-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E4EABBE57
	for <lists+linux-rdma@lfdr.de>; Mon, 19 May 2025 14:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77D72189FE3B
	for <lists+linux-rdma@lfdr.de>; Mon, 19 May 2025 12:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10B4278E44;
	Mon, 19 May 2025 12:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jO31Gd22"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA91D1C683;
	Mon, 19 May 2025 12:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747659164; cv=none; b=dsMNLjFaIQhT/stPtRGjjNiDSB1CqudOnMQyLcsykb/s3lFWVV5AZsa9Wnb3DskvHLZj7ln3qsJM8xbYynrhsaiQg7Mo1dNze/e0RmoRshLl2RaUf8+WDkiZUI4XL+U08zXTWLG7hZ4KhRBIcRnEwXPjNb4uCUTgd6MBFcEKcZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747659164; c=relaxed/simple;
	bh=kh44kyMOcaqgQ/Jctem92JY8R9/ZQzrh5hu2Jorx4Nk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nrY44682F9ZBYQKcjuOtVoFnjXsxKMGwQhw9iX45cmI9tblrBQwohArzmhCCd5dfUW+NwO+7vgjzS7wszVCtvIcalDmNOIZXni22LE9eP9DOaRWOVaBvXvPQ0exHSu8kDDob3+56ztxUj7vVfENNs+iM15lb0lSO9n4p+v0/6HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jO31Gd22; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a365a68057so1857614f8f.0;
        Mon, 19 May 2025 05:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747659161; x=1748263961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOhymhbVYgW8k7keXP/n1X5vmyztYmP2bMRzhPjvLGQ=;
        b=jO31Gd224mqq9DfEjOi10dSRnprdfn2pppfB8FXu3d/jif32LQCoFncFFZuqiuhpUJ
         KtJh8boXhmPkrj6c/Gl6h4zNGSawCX3NYlaYoGADItFlo1lkUhjsUv8GpoUMNq+36j3l
         0Oeur2JXERpvTJ3ghAx+NXunJTxZ7oukm9kaNbWJAtu38veZXril2PxndtThBQ3Yrhnj
         5yatQIXJVhXVFULQx0EtSz4VtaYziiqaSfN2Il6MpqClTpqSiLQjYCY1zmxvPecmbgo8
         KRDqHXQbcGhR98QuhVLge0iYISYRNOMTCWQ9ZpPRxxX1c8VyF7RdJ0HufPP0YQm6efjQ
         sabw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747659161; x=1748263961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WOhymhbVYgW8k7keXP/n1X5vmyztYmP2bMRzhPjvLGQ=;
        b=fDMN6YMIqrUroJ2a63mjWMUb3nP4ne9V2AHudYuXIsq0OzVQeOapTw3o9g3aKyvEwZ
         9O8uxTXyezxDFw5HvSQylQe4a7ag4reCRgA2sLX8J3ZVNiwzvoPKV4f+vZ0c3H5QXM78
         Dz8jk1dzvwuLawMyINuIGS4k3c1ECo6MxL80kbM58D2fdHqRXzBCaMzW91zSsFwtknsx
         UDplDjZ46GcwkeKM1QjX1U9izVSz3PQEd4lmVCYpuqin24tOWbvv6uDNw2COVwOLydbr
         3fIZtr5H5x0cGayjY3D0/CrBYhM0fwc40nkxXVIOfFEWjtixXKEXu/b5OGo1Gz+BJxIn
         7EbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrdPeAiV7POxP6FI1VYnOMp5AtNIMgPFryktRBzzteox/uAjzn6ViER2/PalnFNWvvovrkWTQ1@vger.kernel.org, AJvYcCXRXV+DSxuRze+jvO3e1WBS0wsgFdyz4BDtiCUt6J2QaIP+cH4oeYNGzLWEXbGSCwFcxulOX/FlTi54@vger.kernel.org
X-Gm-Message-State: AOJu0YyAIc93l81p96EFE4T0M9m/OjAnLyktZMGUGX0Bes9a0h/xfan6
	fhampSk+NVV2Ma4vnRIQ+YvDZQzqUFDg6D6vbHm1YoZ4LyZcypz/EyRb
X-Gm-Gg: ASbGncvq42UCvr+ZWaGe98y1pooKu5oo27nxSwmnT419J9vUSuFfiDLsYoqIOg3rdqZ
	bPbOkEVNsUgvTmLkb81qgV26SzRZTv1yC1ZwhU2WEPwpzMgAYw4p1STzOGN7nV+jSTNnqxjB86L
	PHqkjqiu/9ivL/3NZ7V/HAK0IMDfaTurVYJSx75OU4OaVl3rIP4RKWdg8Wn5y5zbqpKUPxd/Ptj
	w0Nxi3XizpC5p56HgniKcCNwxddZ2ZMzexrrBm0fI7NvvO26hASYYSnw+G2sPaqWUKy4kPhEmtL
	HBSv6Fb/VOFHuy9gMsTtNetcgEO0yr4Z+PkN/n3uav1s7YyiGNVgrMNQFbV2vX0=
X-Google-Smtp-Source: AGHT+IH++MoGiR/jcXllwZDfhYiEreWaRp8wN3RQS5F3l+90nrzVplEoMOk0J3to6PpIvypqn/Sfqg==
X-Received: by 2002:a05:6000:2211:b0:3a3:70ec:e1fb with SMTP id ffacd0b85a97d-3a370ece386mr2550128f8f.29.1747659161044;
        Mon, 19 May 2025 05:52:41 -0700 (PDT)
Received: from localhost.localdomain ([78.172.0.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca5abaesm12799939f8f.39.2025.05.19.05.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 05:52:40 -0700 (PDT)
From: Baris Can Goral <goralbaris@gmail.com>
To: michal.swiatkowski@linux.intel.com
Cc: allison.henderson@oracle.com,
	davem@davemloft.net,
	edumazet@google.com,
	goralbaris@gmail.com,
	horms@kernel.org,
	kuba@kernel.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	shankari.ak0208@gmail.com,
	skhan@linuxfoundation.org
Subject: [PATCH v4 net-next: rds] replace strncpy with strscpy_pad
Date: Mon, 19 May 2025 15:51:53 +0300
Message-Id: <20250519125151.24618-1-goralbaris@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aCrXQtrGMIntkcZs@mev-dev.igk.intel.com>
References: <aCrXQtrGMIntkcZs@mev-dev.igk.intel.com>
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


