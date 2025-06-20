Return-Path: <linux-rdma+bounces-11496-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40991AE18C9
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Jun 2025 12:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE7714A58F6
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Jun 2025 10:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4256283FCC;
	Fri, 20 Jun 2025 10:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NuzKNGoS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403B827D781;
	Fri, 20 Jun 2025 10:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750415173; cv=none; b=k+l32IuRGheT6dP+8gOvy2BBh3kHqX1KZk7upA1ADub8xt8+Z8ujOsFn4TDA9gujeUltlOWsIDPGW11oIcSuGFghcPz/5/b4wrah8x5xvJQ2BIJM3VT7L9o9nkp48eq+ZU2K5gb6YsdG5VnXUSWuIB9LpUQ7lWmvcEtPiOUEdK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750415173; c=relaxed/simple;
	bh=xXWRBXu4b5C4VUTK6Ue37Es+r8G811Z7yW6dL+2y6C4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XR53dpDSeZLiMtt9FhIyRCzE292AmlewP8S6Gni5Mv80iEUJY18QmTWDahAlzFG7wEa7iWPEfe8f/FqJXMXymDE3uVNactsgxAW6Uq9OsHldOgcV0x1whUmA46MLpei/Evdl814KrCmuv/V+Aw86+YSqn2EYqB8d9dwBMmW20ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NuzKNGoS; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-749068b9b63so599238b3a.0;
        Fri, 20 Jun 2025 03:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750415171; x=1751019971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GxSzhVSOTXRFHb0wGgV69/LHfIPtg9HZ4PaYVasZ7YU=;
        b=NuzKNGoSNyyb1LiaXzI9HojKWqXHJ1wo13N2Hyhf7eDtApl50+/du1tGifojn63d8T
         pXmRN3yWfdAejFy2oMKvcnQEh1k2ElI7r2i2WHDabcHDP+RHSszFmK1mFVQ98jCMUyz7
         mVtm7dMbi4AphHsvj8nk4Ri24cjHI/x1U6+0PeHLLISngPhvN+Pmy8H0z40+eiiqjIVy
         HTuw8mBSLL+n5iBaZmPrmUPc3p3Vh9R22xyQ3xf/8i8176cF5N/WFsN/zlrUVIejsSjI
         yHZpEiuuB/hvwyKujwewOjY43SWhr7H6d3PW3N9ngYDj7GJU7VfqvdZj80hZlLcFL3gr
         vaxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750415171; x=1751019971;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GxSzhVSOTXRFHb0wGgV69/LHfIPtg9HZ4PaYVasZ7YU=;
        b=Me/aQmGgawG20JA4o/8Bm3ghlkuAgcQFaMdfsthP2x2kJdESre0Zx685HlvXQvm4F6
         ZddZlYzcbQPiu5Gu1EQqIF/3+S9t+WtQcjq+jmfPugm6kHqrbDLeD6j0V8i2P7Pf6Kq1
         r2oRM9EA+6WLNjMrWNsGeITN+O0p9gx+Blr4PqRIdGdot/Z/3vGzFQ0bBCz8jQFztsKy
         ORG3PI90+uDBjn67Vt8pIzIrgOjvITe0gGNmXTbqjEvSHRW9FZjN34Szyrd+9FvptDwt
         cuV2/9lArc+2KpeU3NQhREj5MGRStCKUhK+WuiKhBtfKg24WQR8olzo9ymCbl+ZIdNxS
         u2dg==
X-Forwarded-Encrypted: i=1; AJvYcCUOD//pCIxMG53n5jGIZ3Wvd0Pv21orwN4P/XXsh1NTNe+RQdcWmDJ1NP9CdlHRN9WB+djPi4i0i2OABg==@vger.kernel.org, AJvYcCVKCqlFocL2NKHj5hvCZZTP9WNAfYbLBaIZxMevAamH4+4lVmjVBucAVkb202IJfXDoJtZqIRLz@vger.kernel.org, AJvYcCVwD40vW9AKImlreI5EinZDaAGaT603CED1J3doAHZxj+lE7hb+YnkiIfgNYw5ufMvT96wf+eBGQT38FQ==@vger.kernel.org, AJvYcCWvJz6gMFx6dxa3CcHHE6krCkhRCdcfG0zCqt1HI611cRcbaQ9gv2UhHHx9u6rdKpo2voWFaMLQlTdi6/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YznQ9K9/sX1ZMnmsOflUyjH8SGPCYHR8a+Era7xX1gp9KGpEG4u
	fQluosNTGL3mLs5YPuDUjWoIzK/Ii0+AGRkjMuhKHs+fKRzCfB+APxdu
X-Gm-Gg: ASbGncuZ8dEPWWaSC44+bK/rWbu0FemTFC8JoWOV7y4XHLjSoj25VR1NssI4qhZu8ip
	/995e0yfcB2090AEQoCvUtSnpo+lmUFk+HMcOj1vbphhzd+KCCvIEMMo+rl0GNTW7TUzALrI3oT
	JawJOP3gPe+MNyRMRLpqPMxtX2nJaUU9TSkSoDDtXNmXzDC0rNkBK+FGMLLbitxlhRQij4nA3QP
	7D5tUQmIQFbpgjFuIeGzj4H4/SSZ2fRMH+I5c0g6VFxgRbDpyfpfxYJOmV3zeI1CmXyS9nBG3x6
	LeJDHZ/MxUf3BmYHyW/T/dN5t5aL1S9lE3mTvBv/gqPuFbOp5jzgqj745kPmv3Ab/KO3+lm06jh
	LRo4H6Q==
X-Google-Smtp-Source: AGHT+IGv/c6FWl5u2zYrF5GUTumfzJX/FvPvDDdMT9K2eWxzFdO5ord3yGnrQBN6yvzaQ7fDnvQZlA==
X-Received: by 2002:a05:6a00:3e17:b0:748:f1ba:9af8 with SMTP id d2e1a72fcca58-7490d6fb530mr3206147b3a.21.1750415171410;
        Fri, 20 Jun 2025 03:26:11 -0700 (PDT)
Received: from manjaro.domain.name ([2401:4900:1c66:adfa:3ba4:a43a:db76:7cb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a629678sm1750022b3a.93.2025.06.20.03.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 03:26:10 -0700 (PDT)
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
To: wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	horms@kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	Pranav Tyagi <pranav.tyagi03@gmail.com>
Subject: [PATCH v2] net/smc: replace strncpy with strscpy
Date: Fri, 20 Jun 2025 15:55:59 +0530
Message-ID: <20250620102559.6365-1-pranav.tyagi03@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the deprecated strncpy() with two-argument version of
strscpy() as the destination is an array
and should be NUL-terminated.

Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
---
 net/smc/smc_pnet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
index b391c2ef463f..76ad29e31d60 100644
--- a/net/smc/smc_pnet.c
+++ b/net/smc/smc_pnet.c
@@ -370,7 +370,7 @@ static int smc_pnet_add_eth(struct smc_pnettable *pnettable, struct net *net,
 		goto out_put;
 	new_pe->type = SMC_PNET_ETH;
 	memcpy(new_pe->pnet_name, pnet_name, SMC_MAX_PNETID_LEN);
-	strncpy(new_pe->eth_name, eth_name, IFNAMSIZ);
+	strscpy(new_pe->eth_name, eth_name);
 	rc = -EEXIST;
 	new_netdev = true;
 	mutex_lock(&pnettable->lock);
-- 
2.49.0


