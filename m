Return-Path: <linux-rdma+bounces-4682-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EC7967F2F
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Sep 2024 08:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DD50B20CA9
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Sep 2024 06:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7797514F9FE;
	Mon,  2 Sep 2024 06:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DQW7p3hY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50EB1AACA
	for <linux-rdma@vger.kernel.org>; Mon,  2 Sep 2024 06:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725257602; cv=none; b=XZt6cBH1wh/LpMJyjYJNtu2GIUG+xI2R2rGlbhLE+m7paEu1isxPGAaoP6qZ9iXaGgWNZXdJbmwClj2s1T7zpDZeOIW1SHbgI/tVaE2JwOGI3HaSJmCk6FOh6pfa7Na1thtjwQ8iq5bdA0zJMbtBl5p30o/lwE7hMLW31LB2gyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725257602; c=relaxed/simple;
	bh=2G/7JwLcnkuV29/AbSWuA68o96/chL+5dlFb5sqUhKg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=k49bQXZdVRO21ssPkoAfbycklC77ydPCN1bMqO7tKvYIemzkYTZtti3t9YqFwfE0dWjUlDx4YXc6dsOKxpuRFjkXAlzFtKZHZqiN/JJVShH/7nH+7rDkqE3B2COlSAVtVbDbUvXFmX3AkKaE0eRwPirTBkJtRcQR+FsnujB1oiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DQW7p3hY; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2057917c493so3822955ad.0
        for <linux-rdma@vger.kernel.org>; Sun, 01 Sep 2024 23:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725257600; x=1725862400; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wyRT1yp84UcRSA1ArvBp5bpDWLAWlsDf5qZTO4gLjPw=;
        b=DQW7p3hYnp5NvXf0s5H8wjWMAtD9y2AZVyYis0Pri444PhmOgJVcbcTXoZyye6X5Xa
         ItWdtpazx8z8Zn3oEAlF3lXsNy6RPfEXyQ+pGDZMVmAKEno00b/jtrCMXlagaOHpF7O+
         xMK63zQ7oiIFugSO6sEN5SxJzTDA6aIPQl858=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725257600; x=1725862400;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wyRT1yp84UcRSA1ArvBp5bpDWLAWlsDf5qZTO4gLjPw=;
        b=ilTg1waAnVMY7AjyAEeg8ByK36kHMGgriXw+oG4NMQKkFe3SU9fYWVeVGeOZRQh6tj
         SI9RXXfmJRypnjJQAcP2vHvnXddwXbqN67WfTf0JBnd01wluMtAzARGsXF4DyFWvrGNE
         FWvG+e+j5AmYCI46oSzRWCv6DMH5vvCS2PcBRe7LEo/4ui93bcM0XNmKpkGqyKQN9pVT
         ad0r1aPirbHEvgD1WM/J4nm+pP3Y677w+FwczHMjyEeV+3Z5v9ftDAQoKyxo24ziP/ey
         81Q+0SFRIFD9A0kSuJMRZDSyeEVLx9SI/7Ft/s9zM19sMDMtXmb5rwED86RMmumbz3hl
         67tQ==
X-Gm-Message-State: AOJu0YxIvq48PNXF8wGBG8aRdNPiFBHySL1fnyEm4+ymw1ineIePlOEd
	9u/l/aMyimT0es793TOTMSj5DcFih+vukH0Yg5C9MMAxNMzx2TgHEeP9L33Itx/rAb4qzlln+xz
	jMw==
X-Google-Smtp-Source: AGHT+IFOlf7S31mUR6N0r5H413dLnVX/6qnkdOndXF4T+84KPFxGNVHBcnn8CXIPkbKOihc2FojGjA==
X-Received: by 2002:a17:902:db0b:b0:203:6cbd:7277 with SMTP id d9443c01a7336-2050e97c098mr226691255ad.9.1725257599790;
        Sun, 01 Sep 2024 23:13:19 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2054a2629c3sm28907955ad.105.2024.09.01.23.13.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Sep 2024 23:13:19 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 0/4] RDMA/bnxt_re: Enable PCIe relaxed ordering support for MRs
Date: Sun,  1 Sep 2024 22:52:27 -0700
Message-Id: <1725256351-12751-1-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

Latest generation adapters support PCIe relaxed ordering for MRs. Enable
it for those adapters if the user requests for this support.

Please review and apply

Thanks,
Selvin Xavier

Kalesh AP (4):
  RDMA/bnxt_re: Update HW interface headers
  RDMA/bnxt_re: Rename a variable
  RDMA/bnxt_re: Avoid an extra hwrm per MR creation
  RDMA/bnxt_re: Add support for MR Relaxed Ordering

 drivers/infiniband/hw/bnxt_re/ib_verbs.c  | 58 +++++++++++++++++++++----------
 drivers/infiniband/hw/bnxt_re/qplib_res.h | 10 ++++++
 drivers/infiniband/hw/bnxt_re/qplib_sp.c  | 12 +++++--
 drivers/infiniband/hw/bnxt_re/qplib_sp.h  |  3 +-
 drivers/infiniband/hw/bnxt_re/roce_hsi.h  | 36 ++++++++++++++-----
 5 files changed, 89 insertions(+), 30 deletions(-)

-- 
2.5.5


