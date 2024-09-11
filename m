Return-Path: <linux-rdma+bounces-4886-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28712975A91
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Sep 2024 20:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8562B25007
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Sep 2024 18:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC271B7902;
	Wed, 11 Sep 2024 18:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GdDZsvLC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA95185B7B
	for <linux-rdma@vger.kernel.org>; Wed, 11 Sep 2024 18:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726080634; cv=none; b=sutgYKts28x/rBx9iBuSWuvrdKlytNPksCLQwOdbSfXFw5Q2YKYmr4jyCIgeC7CTPKF+YEKQH5G+FFzVLZUMjbR6ISzlfZo1xtWV1nWG4H+lOMjrHA3szJNHk5/0OeQ4DuZEkxVVHh5lx+fZBPEY1v6IfEBUdD2uF0j5WQhqROY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726080634; c=relaxed/simple;
	bh=coxTC3CmwsCs3itvnQlRbo/bHj8fV+5dtmHAeSODxeY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=hnI1BjiSQo9KNwUWIOr4bXJsGQ8xuqWdoUnKOUO3JHyX0AA5XxSfKjuLAY2F7as2Y2PnOojnyHSqKto4slYf0zBCkX2ksHXvCM6wV5Gx7IHUmtvH3GHZnqjkejmTVOv0N9uZSVRWA1Q1XAO4rff7kisatOCfIkp/AnkH5Ycp5Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GdDZsvLC; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-6c5bcb8e8edso157505a12.2
        for <linux-rdma@vger.kernel.org>; Wed, 11 Sep 2024 11:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1726080632; x=1726685432; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEuqQRME9jSTZbeJ0oqx4J7txtuQ53OIkKtlPMnNdQg=;
        b=GdDZsvLC2KjBsjqE6n6+C1IY6h2an8lx4f9jB5Q5BVb0jS3CsvxHMKWhoXctwQyxxS
         uIxJVVGw8SnIBTYcSWIJ3rlbSQ+9BfG/qL4c6JzeRVVLdvwFE0H8R3Yo9f3XHoMxz6vy
         aMI1TggPT3yaZe+9hbywKgWYSI6rEVKRs0dc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726080632; x=1726685432;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rEuqQRME9jSTZbeJ0oqx4J7txtuQ53OIkKtlPMnNdQg=;
        b=ALrzV1lgUO3Fj9FsJV3fgk1SPxDaHhG7NKaOwdkfX9fvWHoi/7HwCt8or2Z9gTCVZX
         n3++5XOODo1zik40kgFOcfABXt2GYz3gsJph6XbWhiNkuvRiJm9pe3THkcptnfQyoV+m
         MPBaApJvca3dUR5w1oGY/k1CHHDNTuuOc4CS/rz47RhKJrr7YLz9l0nbdz3WWWesORGB
         pawUcvEWfS347Wnn9dsvifNP19Q8mjhyUYXe+NaG6VBZBBHOY6o9s2OjAbwW6/3IJOYv
         J7ytYK5Tfgi3ejidwGj8JFz4xRedUJ8j3E5kc4ohEnTaD8GLfRcItY186y/sHuFVlzhY
         gYvA==
X-Gm-Message-State: AOJu0YwjobiYIDzud9PJZqFq490M9CvHDswMkpJN1fuWv19ln2EiMVpS
	GdReMjv+MRyrLU9BE3B40PLLpnsqr43HjXAcBoAMQZbNzut3IAT4GqH8vWDryA==
X-Google-Smtp-Source: AGHT+IFQzRamefZiY5mPSy1D4NextdatHJ8V3t7phECigoY1OMPHrIoNLQQ9Oo4BqUSgPohGFyzuVg==
X-Received: by 2002:a17:90a:e213:b0:2d3:cd57:bd3 with SMTP id 98e67ed59e1d1-2dba0052a92mr175683a91.29.1726080631849;
        Wed, 11 Sep 2024 11:50:31 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db043c59c9sm8903996a91.24.2024.09.11.11.50.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2024 11:50:29 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH 0/4] RDMA/bnxt_re: Bug fixes for 6.12 kernel
Date: Wed, 11 Sep 2024 11:29:35 -0700
Message-Id: <1726079379-19272-1-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

Few generic fixes in bnxt_re driver for 6.12 kernel.
Please review and apply.

Thanks,
Selvin Xavier

Kalesh AP (2):
  RDMA/bnxt_re: Fix a possible memory leak
  RDMA/bnxt_re: Add a check for memory allocation

Saravanan Vajravel (1):
  RDMA/bnxt_re: Fix incorrect AVID type in WQE structure

Selvin Xavier (1):
  RDMA/bnxt_re: synchronize the qp-handle table array

 drivers/infiniband/hw/bnxt_re/main.c       |  5 ++++-
 drivers/infiniband/hw/bnxt_re/qplib_fp.c   |  5 +++++
 drivers/infiniband/hw/bnxt_re/qplib_fp.h   |  2 +-
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 12 ++++++++----
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |  2 ++
 drivers/infiniband/hw/bnxt_re/qplib_res.c  |  2 ++
 6 files changed, 22 insertions(+), 6 deletions(-)

-- 
2.5.5


