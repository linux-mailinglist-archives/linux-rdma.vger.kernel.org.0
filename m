Return-Path: <linux-rdma+bounces-4871-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3118B974919
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Sep 2024 06:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC31F1F267F8
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Sep 2024 04:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F13A3FB30;
	Wed, 11 Sep 2024 04:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="boTJ2iDZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91641C144
	for <linux-rdma@vger.kernel.org>; Wed, 11 Sep 2024 04:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726028964; cv=none; b=Q8p6WLNbCiyiZ0MW9bTmNnsFBuRY14JR4qEybyUbHZ35BmGBl0W7s/w/Fh6BeH59P53T7pGgL/sIn5gwZoLMJVXX3fTX6dHy1ALBdSOBBpYDMMHTc9P+sdogTfmwJJIgtF4ZeMTFTd65L+f/AJnF9cNswavVhpm5MRY9CB1f5ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726028964; c=relaxed/simple;
	bh=ZnRzLVe7k9/heTzgLTxNTMwEG7v4IucRlP754lF4TKI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=k+bDgViGkkRM3AMs+4O82QAyWOjpcjpcUlOv0Sa7pLjVtB3H6EvAn9MXlIyuzhhbEGvn4ScFVaYkW3sMbDCuNPGs02PZUj+U3hruq+Js4AzWT4UmqfWWaDi25z0evhUk9s8aLt2CbNqo2q46/FeboD/9hCmadgdfo+/B0V0NitQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=boTJ2iDZ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-718e285544fso2904367b3a.1
        for <linux-rdma@vger.kernel.org>; Tue, 10 Sep 2024 21:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1726028962; x=1726633762; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OdO4XfGUDbJzR+Axz8fU4LgIoDHdvjS3OLoRSAXJ12A=;
        b=boTJ2iDZEptLHpaeCzTJPq3LFDbKRuOm95JgKWGB3SSnvauFU4Tlt2R/DKGqwMm/Rz
         oNrOftlAUsM9piuXJ11DxH8zXk5L6BmGZgCBg5IiZ3x/ou8Vd7Av0ZfYYBxZN0Sgt94O
         3+LD8ieJQMOB674pBNBU4SEffDCfcOAVMA2Qo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726028962; x=1726633762;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OdO4XfGUDbJzR+Axz8fU4LgIoDHdvjS3OLoRSAXJ12A=;
        b=LfiN0o/4adgdHqmrvPNBC/UQM7ziNom5q65gGKMHulYA86znlPc/OWrbxzhJLoSyzf
         IDg92wFy32I25JOUloSj7gQcqM3kP3r2qLrrBm27b0vqxYLZ3/TDoZa6GE8oEKh+CUfE
         PGLlZSePjosRPCs0Ocr43vO9NPnSwU8qgzt7RWNheDM/ThQfAAx6l1UDdt6WmuSgn9n9
         XsOOkPAupd2tnXqFsyGKyilwn/NgSAX32XoUujhOgDJ4FjnLrVsivJ7USSsoUitZe1ik
         iQlgANaCpPJF9/Luo1U6756pwFyRtPLYGG1mTPAOJ1PxIwVkKMauaBRT6T4MbqRTtcQi
         sBgg==
X-Gm-Message-State: AOJu0YyPJcvoxwyeXcEdSTjHbuGz/29vWykqmHlL/Cq2KusfOtbhYH63
	FwDRHHJ+enc8CN+ayd+tHA65KbngDHnbueV3/KHiUr4yi2fNlr1OBNM8MDadwQ==
X-Google-Smtp-Source: AGHT+IGhah7LwTp0IB/J4uchk8WioxvTTducmm4Z7kvlggcExP5cfKIGlMPgoyLmXaHSRPIzWNhYrA==
X-Received: by 2002:a05:6a21:398:b0:1cf:440a:d449 with SMTP id adf61e73a8af0-1cf5e178758mr4102258637.42.1726028961421;
        Tue, 10 Sep 2024 21:29:21 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71909095184sm2123562b3a.106.2024.09.10.21.29.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Sep 2024 21:29:19 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next v2 0/4] RDMA/bnxt_re: Device re-initialization after Firmware error
Date: Tue, 10 Sep 2024 21:08:26 -0700
Message-Id: <1726027710-2292-1-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

Add support for complete re-initialization of the device when
driver detects a firmware reset. Code reorg that updates the
device handles stored with Auxiliary bus and the bnxt_en driver.
bnxt_en driver calls suspend and resume hooks upon error recovery.
Driver destroys and recreates the roce device instance upon receiving
these calls. 

Please review and apply these changes for 6.12.

Thanks,
Selvin Xavier

v1 -> v2:
 - Fix the kbuild warning by removing the variable set but not used

Chandramohan Akula (2):
  RDMA/bnxt_re: Change aux driver data to en_info to hold more
    information
  RDMA/bnxt_re: Use the aux device for L2 ULP callbacks

Selvin Xavier (2):
  RDMA/bnxt_re: Group all operations under add_device and remove_device
  RDMA/bnxt_re: Recover the device when FW error is detected

 drivers/infiniband/hw/bnxt_re/bnxt_re.h   |  21 ++++
 drivers/infiniband/hw/bnxt_re/main.c      | 198 ++++++++++++++++++++----------
 drivers/infiniband/hw/bnxt_re/qplib_res.h |   1 +
 3 files changed, 157 insertions(+), 63 deletions(-)

-- 
2.5.5


