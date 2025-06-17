Return-Path: <linux-rdma+bounces-11400-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B692ADCB7D
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jun 2025 14:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC2EC1883C21
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jun 2025 12:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983FC2E92A8;
	Tue, 17 Jun 2025 12:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbjIGwNo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACA92E88BD;
	Tue, 17 Jun 2025 12:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750163176; cv=none; b=hnTZhObO0kV0l4BNC748Suj1OFrhdBHKfI7RU2AjKPaB+i4hIffpSqLcd09PC+Krlk9hIUtOvHz0ZZ5cbMTFCajN3hg6zZ0mZ5X4hvHGEUY4/49Y5L9myu9a414zuY0EkVtrXgfLJvMfQsYyeKymgME7lBCFmbOth3JCItyDM7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750163176; c=relaxed/simple;
	bh=GapOKwyflP+ZpWPmihqgp7HGJ5ycxWDkT3/PcFW1nHY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B7cbOapGt2sUzbHHrKQ3mhOGAWgNWEohqOh8l5MRNO3A36gYzHi99avng0LYp4OJM1hwDS9DbnU0ORU27cDNBX3GeT5+P1I7Qm62HdED0rZi2LTxlXRmr539xU+myQ/CMHeZhsZI1fshx3H0clcQBidFyQzBHD7r9/dxvVsaDmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hbjIGwNo; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b2c4331c50eso4394581a12.3;
        Tue, 17 Jun 2025 05:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750163174; x=1750767974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lmhCyj3oG+9b2plobKfmAomghZ2eZwtkaPqpuGuysqw=;
        b=hbjIGwNonfDbIJWHykv5PlLghhDAchW2zh4j0FZzebHjZeOyfvlbPO79y9NIhPVoKS
         XCOWNCnJW4gs2MLM5934X7KHxcMP8zjH/EvdywdVRJQrXEu3xW+AyIuBF2qFkikX6/bq
         f6YYFQRl48gY/f/08M1EFQclM2ZOxp1+2rauRiHpLV8trbd+HXPy7aKxDiPi/q8TNEjb
         6J+O9nQkOpPq72L4waYTU0r4GU5ZxH0yW+myOFMHfrV7mUoCauqM/4F9LTcTduNIJcL+
         YO/ao2eMfJw7qn93GylmEHDkJCj88SoIe6jPI6rRcaTWGys36CvdwJUCLb3TbqBx9JZR
         7mVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750163174; x=1750767974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lmhCyj3oG+9b2plobKfmAomghZ2eZwtkaPqpuGuysqw=;
        b=qyleUwNnB7FEq2zRacSFyKUAZr1qCznXkNedlvnWtpEDl/YfhBSECzd+BxGAQsNFaS
         Idi7FBt50vC0ZqVWae1RW00OwHeT/bOw7ciUL4FtlkvoIklKKZsJjyLTxzk2s9xW5FFI
         s5uMOCE8u2hTErEgRqyLhxL3AQiOSAcp549OYlC7FahvPw4/U+44VmGPTVpfK4xxUGJo
         ywbTQ+FQKbSHchP3g4HGEtLnPxd9cz/AEGDEsXpzct3RGNYMAtHqufFmO3ccUMktlZpf
         MfOuMYcE+nAzqnl5Ps5PL6dx3T0ALo0hxQjNBVfAey31wqm+JQRPPs8+gx6rr3rM8yeG
         mCgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsGJnhQ/PMGAx1Qbgf8WSAhlzk7MBwm1/NmGnlpTfF0c0bcpGPAcVmfIlFtB84tD2LT7+jpoHf03sLfQ==@vger.kernel.org, AJvYcCW7+/y3wk21XXKDPDBf1QFyOV9WccymIszA+uxuUe/cJ83kso8NQ+ZN1ldgDuWbWj4OO2xDbSDEYeLVCQ==@vger.kernel.org, AJvYcCWZqT2+TupiMn7LQEyD5Wlhjmd5UK3T2JyJcSZrhvWF4wPsqAw2uEP240iPXRMNv5wbdfV+EQyccYobfCk=@vger.kernel.org, AJvYcCXra89shL1lH11vQyJrFSBzJv+7XpNpAni6JTqXFcO3/7LbbTDbIAjP7IIPN6sAy2zf6TC05462@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjmmtrm0Yl24GRtskX+o0YOJBEVzeoKwyz4wjj9Q5exQ+iJzhc
	Mb9WnLaJU7JSNAwoqzQqNb6WTG1DgGb6YoJEeKZPuIWt2xdYN6zVwO73
X-Gm-Gg: ASbGncv/ypp7pb/GD+HRFk2tT+9+ULz0Ua9jddOVbAzzWl/pW+Gf7aGnOtv2RYkXvtk
	OnWwIqAjnrIZKjEAn257L8o1yGGcmlOAgT4NzRDndQfSWE7SwtRLzuHaR5mwuhOCwH4jmcI1ngE
	H36cGCmXQPTd6KBKpQKnG06S3+274fJ5gm7aBD6VjFxogv8lVcMUtnM6gn1SIfuKv15968eZT4v
	hpOnSe6RNOhfBYbfJpwkLQ3UYuuyzkR8mgmyaB8Qzh7rzuLtF8fYIvrLHhhH6L632cDqnzSBTq0
	MwDKmh6H5C8li1bL9cJpjda7HWwSa0ND9PeVJZTbqnhUxidkfGfV2nxYD3v+YDF9cYHS+Mtfij4
	HQeTYB+o=
X-Google-Smtp-Source: AGHT+IGTCN29BMxfXIJrKeN0ocQnXkWRuyj77RMW84BLrUAULMGJo41/CNVAbBqbUTHg6VLKB3GoSQ==
X-Received: by 2002:a17:90b:134f:b0:311:e8cc:425d with SMTP id 98e67ed59e1d1-313f1c00e26mr22432756a91.10.1750163173798;
        Tue, 17 Jun 2025 05:26:13 -0700 (PDT)
Received: from manjaro.domain.name ([2401:4900:1c68:884c:5800:7324:c411:408d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c19b8139sm10573302a91.1.2025.06.17.05.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 05:26:13 -0700 (PDT)
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
Subject: [PATCH] net/smc: replace strncpy with strscpy
Date: Tue, 17 Jun 2025 17:55:12 +0530
Message-ID: <20250617122512.21979-1-pranav.tyagi03@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the deprecated strncpy() with strscpy() as the destination
buffer should be NUL-terminated and does not require any trailing
NUL-padding.

Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
---
 net/smc/smc_pnet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
index b391c2ef463f..b70e1f3179c5 100644
--- a/net/smc/smc_pnet.c
+++ b/net/smc/smc_pnet.c
@@ -370,7 +370,7 @@ static int smc_pnet_add_eth(struct smc_pnettable *pnettable, struct net *net,
 		goto out_put;
 	new_pe->type = SMC_PNET_ETH;
 	memcpy(new_pe->pnet_name, pnet_name, SMC_MAX_PNETID_LEN);
-	strncpy(new_pe->eth_name, eth_name, IFNAMSIZ);
+	strscpy(new_pe->eth_name, eth_name, IFNAMSIZ);
 	rc = -EEXIST;
 	new_netdev = true;
 	mutex_lock(&pnettable->lock);
-- 
2.49.0


