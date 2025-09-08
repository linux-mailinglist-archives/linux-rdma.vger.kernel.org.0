Return-Path: <linux-rdma+bounces-13163-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 15903B497DA
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Sep 2025 20:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 093C44E2051
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Sep 2025 18:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239763148D9;
	Mon,  8 Sep 2025 18:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2P5/d75"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7DF7FBAC;
	Mon,  8 Sep 2025 18:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757354979; cv=none; b=AMEq8YNVQQsUJ9QaEncjWVvkCn6CqF9VXExZj6KC1RxUTEgn4qr9ITGMdMw7HIGz35ycfy9CFD9fexVMRX46ObuIFRSMhqU4L/3UtQVe3CgbgMe4/3JZhXMvV535/E7w2dD/9kdnFieoJ5qXpBHLsDfP5fy8Y7FEZ3Seqdgjffk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757354979; c=relaxed/simple;
	bh=NuQI4nMA0g0N9BbTVEQpy+JxTD3mg9+9KzSwGSix7cU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eOd9yDgO2LpoWlx92umlM3ZEZJ4TKG7OQrSNDMUD/gl7r0hKTiy3zRkUokCQh6vNZ7T02dzsp+S8nMz6fhpHIUd+o+sKRGs3TsXZte8GSceJxUqZAfQAu94/15NbSRWnPJlUGDPuuxuPtsiNV3Q7PypXaHA9CTJvbOPvZ8FGt9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2P5/d75; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-24cde6c65d1so34309225ad.3;
        Mon, 08 Sep 2025 11:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757354978; x=1757959778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RTgXOKpTqqoYfQsbZozKU3x3sBsg6MhNCEyIXZl9xW4=;
        b=F2P5/d7563rzk8tOjyR7iOGMwybTxV813345uok762tukNF78/gl310yyTgDOs9txT
         UViLDWMzL5HnOB9rKbW9k8ktA32MURPE4e51grCWmJUuralA4CB+BSScd3FqlbPez2Ur
         TOM14VC4F46pBbSMz/qe2og+DkBnhVdWY3SBKrd3qRZINJzmu2L9QMONGcMSdjmWR/sb
         f4o01bBRlnRGZU9NwQVd2MpGR2UUU/GfbokjAlx1re1SdgY9IJO3grAzvaBawXi/FIou
         lMLgJgBLsLdvcmBLBlhKb+ShDe9sLktu1SrWuk8NrRDxyIlUDt9hvVTo84fnkcR3pRqc
         qd8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757354978; x=1757959778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RTgXOKpTqqoYfQsbZozKU3x3sBsg6MhNCEyIXZl9xW4=;
        b=iDBH+Az0SCPIiJdD0u9Tga6oWLJvYHunqWfzczSJQ157nhY6gAcbBUjL+cNiwK/fOx
         tDwu1hlgQIZFRETSYgG7lB9gFylMXmZuUWunGfOMjIh/giMKHmexYdwrv5kTg21ceWjA
         b5wFL2/cgs8TRTEqDEzW9ozOD7vHIqFbNC64RE0aFK9HtCrLyB83KfOPyUoIa+WwsHtT
         UKj/PDlbpF9vzzPkJKjkv2A0AO6YoEcuEXeGCBPmw7iecp23Kznh2X6iwGu3igiINLCa
         LMxUJyrp0qlTKXtbumE4uObVrszMUqDLQQO0RnsIyUhQNysmI9nUOk+/KN+/ZvA/oqPk
         pWTg==
X-Forwarded-Encrypted: i=1; AJvYcCVHqr+oHPzFCS6IzWWOOTB2aP/OJGoGa5bDC5Ycxs6X37rxhPVeMBnyYD7TizWlJ+ZKKB1Qkpwm@vger.kernel.org, AJvYcCWtrfwBzbKaXRah5kIRtdf634iXYn/bSWSgYjEaKKvUokBluBS6YQ69WCDpfGQmcXN1o9CGAQQEM6esKg==@vger.kernel.org, AJvYcCWvvg13kagMlSy3Yd/Y9ZfCTaziMQnSFkd8N9cINLTWcs5zOSceAKkd8o1ZDMSipJWgvn2bz0v1EA/6iiY=@vger.kernel.org, AJvYcCX8fQEBwlfxXvNP4NUFbHldMk679M4S9p6GoVZ1XIA4Rfe1OJyhdkwiGdz4FkUp/BOxNeUaQbKaXtvGpA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzT8thVlD5fh1Qatktjjm927Qn+m9TEAhHbtfjf2mM5nunLBfjN
	ULJqZm3hFwMKB3Cda0nIltZxSqR0ZplIEzTHD/X1VVSobBIot3g1HrLO
X-Gm-Gg: ASbGnctNEaghTdeatS7JVoRMU/kuB8A2HuLURa3a/2q8ivkUOmZNTNsZMQjtxBoRTAx
	C5eg9mR7tUgvXlOvsrpmpGeKtmSlj8Q7R0RKmB+lQuTd/xJLTap3De/jYE3TkMH6m0fsUe54LCo
	XrxIK3pzQSGJiA8GoVdlLniqSfL4wfQ6RM8ZDEDjAY/jC955g8qqRFbPagK+y0t7pqCPGBu5NkF
	m6Mq0sFXxVmu7DymV6ImEU73IJFXFS+i9u1EVv+S79Iuo/Xl1kanYhiAe8m8z9ENqz5i7qEdU0g
	xP1FLJXBTcQFE8pkCanvMzUq5VBwPbrAgRouZjUWHmY6aMEUWlLIRn4WqP6RaTbxVP6RfbC6gkR
	1IeaNS2oGxD4D1lhL3/Scf+/M6pGaUoQM3vi+pY93+gt1fhiiPtxOuML9VJYebWG5NIHJoAl1NU
	8oK/u1bwMDSjKQiVSM7QLZeNHtCgW57PGRhjqge4oCV/7pKwo=
X-Google-Smtp-Source: AGHT+IHUvGdkTF6ftj5zF8+ukk3mhEagKf7AXIJW2UU34v0dDiyGOkNx8+ez0Gtfkca6XYJRXXePLg==
X-Received: by 2002:a17:903:3d06:b0:258:2476:77db with SMTP id d9443c01a7336-25824767953mr24731155ad.42.1757354977526;
        Mon, 08 Sep 2025 11:09:37 -0700 (PDT)
Received: from crl-3.node2.local ([125.63.65.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b273e4ad5sm172768845ad.25.2025.09.08.11.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 11:09:37 -0700 (PDT)
From: Kriish Sharma <kriish.sharma2006@gmail.com>
To: alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	wenjia@linux.ibm.com
Cc: mjambigi@linux.ibm.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	kriish.sharma2006@gmail.com
Subject: [PATCH] net/smc: replace strncpy with strscpy for ib_name
Date: Mon,  8 Sep 2025 18:09:13 +0000
Message-Id: <20250908180913.356632-1-kriish.sharma2006@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the deprecated strncpy() with strscpy() for ib_name in
smc_pnet_add_ib(). The destination buffer should be NUL-terminated and
does not require any trailing NUL-padding. Since ib_name is a fixed-size
array, the two-argument form of strscpy() is sufficient and preferred.

Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
---
 net/smc/smc_pnet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
index 76ad29e31d60..b90337f86e83 100644
--- a/net/smc/smc_pnet.c
+++ b/net/smc/smc_pnet.c
@@ -450,7 +450,7 @@ static int smc_pnet_add_ib(struct smc_pnettable *pnettable, char *ib_name,
 		return -ENOMEM;
 	new_pe->type = SMC_PNET_IB;
 	memcpy(new_pe->pnet_name, pnet_name, SMC_MAX_PNETID_LEN);
-	strncpy(new_pe->ib_name, ib_name, IB_DEVICE_NAME_MAX);
+	strscpy(new_pe->ib_name, ib_name);
 	new_pe->ib_port = ib_port;
 
 	new_ibdev = true;
-- 
2.34.1


