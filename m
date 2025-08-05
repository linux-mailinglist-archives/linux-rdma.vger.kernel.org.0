Return-Path: <linux-rdma+bounces-12583-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA988B1B1AB
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Aug 2025 12:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7B8817BE71
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Aug 2025 10:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E80823817A;
	Tue,  5 Aug 2025 10:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JL8kGqwV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901CD1E9B2A
	for <linux-rdma@vger.kernel.org>; Tue,  5 Aug 2025 10:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754388235; cv=none; b=Autgr7P2JdZHpzHi8I/PmRyAzU9H8YbLUXG7GS3qhFoNQbrjaAy6SfG42m3u1S6MZ5DD7y3WDo7Y6n4J1x81hpISJyRZ9XEHzKTwI1pRITVlNVbmCsBDgCx2+pkLTUY5nLAfAMLDKoyIXyOt1WwESfGwPuvwD9p5XyMa6fkJEbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754388235; c=relaxed/simple;
	bh=9zENHLje8N1AWU897Nho8F6yLNa8xDmL2ctqPFbeLiU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QTI0oLmAOsGZcTAOsEmGYjgW5uLMphSE7eAESV7WBp4YDIr/IQGWzr359QHtyQh8+KjZKuMEFWq07wRJj3QVJ3SR2DWRFh4BCI/hX0cV9D48NMGgFTX2GtDAr0mxGhzWRFZQt5Xn58ucPjLwvD6dqSdntPlrKr9xgzfdpvllXFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JL8kGqwV; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-24022261323so67584555ad.1
        for <linux-rdma@vger.kernel.org>; Tue, 05 Aug 2025 03:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1754388234; x=1754993034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L+PlmMqfc1BVO+IBHeSYv/E7/Jb0dvHu9lNcspVXYq0=;
        b=JL8kGqwV+JqPRj3YFkNyjTXYv3DxmLYunt8cl/XD3YKaTSa7rUbSFieAOpgi2KX0DW
         15+an9oVsOIPFlJOAJCXcyfndS/b+sx8LYFKtzRpEEOWEYHNSLZo8V9YRkay1QjNNnzb
         nbYIfwTmy9fY5usyiXrRKmhspLe0aIyO9ZlLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754388234; x=1754993034;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L+PlmMqfc1BVO+IBHeSYv/E7/Jb0dvHu9lNcspVXYq0=;
        b=ArRyMumtfcGmK/UDWpURXCWZPWVp6FHxyXgxt36/GDDAClgAV+qGHQKkS0qPmauT00
         NQEn+zDP9VTEeThUiEohfVRVfHHRFkq8vbWCLsQjQOrRmaOiOlzW75fMPwPsfXn62DM4
         Ticr9ES6UjEq6l5H7gWoeWmsWg4f6uLaMLT8HxcK+AC1XRxhCk9MCYFyrhCo5v+GFoyU
         P1bPIQYMCN6pQeiHXr235dEaPg27MkOBzmLGmEYwi8w82qbtc8N4qcQtzlXaR1SvBN/b
         xjDXPOniJuYrJsLOeS0giGVJ5s+LMcu2o+iwnPaAjOMP9aumhFCs9kWTo18rVQfdim4K
         Zimw==
X-Gm-Message-State: AOJu0YzKBgWrGY1gZQE7z+otCoCcQYME5JDdAoW4ZGF7uTaYAeT/2i4S
	AaPbFr1EF1pxg2wMI6pd8ugoi++EvlLZTpZGrdPHZL+/x84zVwr0zXOh+ILAMK7SrQ==
X-Gm-Gg: ASbGncvsTzX3WzSFDp9LxzP+EX++hmNTr0UPbuKVyv88MQS2hXhh15FOw2zRuIjZNTM
	mlAfeTvnfBBpMVpt5gp7WpnrvJA4sgnIUEgl+DxLAxeOBJEEMLNGWjtceAoQaxpClt1LCPO8Yqc
	GX+5poV6C2Mhx3HUuXDB+A3nS5gAFsIuZgSjGQTNMXYmvAzYMuq/B+KPQNqXUKGbPou1SDbrRqf
	Il9EnCtQ+sS+gqsbi4yqF9ZYyDk/tkqZKsDhFr4eYJU0JMTp4lzCwTnZY3h0n+wjk56YZ+kOJoj
	pNk9N7zBYmTyYhzEf5e1zqyP+PKbZ+pjWXIc3YLJMxVG/5uWvQrzfu8LXcNXhfrCD0bJH8G4f+q
	AYaesgBZRCTEdFC8y3NUBQC4oaJkMCvWKuEP+oh/mdNzW+GLImNDl53lso5tGLaon7Vw4jLV/u3
	CXrq6zwObs37nyzn5N2UmA+TRPTw==
X-Google-Smtp-Source: AGHT+IEQ5/avuVSSV0GANqIS0Yv3GuoCYH45BHv8mUhf0OHFkslgIH7SJJX3mokvmN6ryXwmLLqx6g==
X-Received: by 2002:a17:902:d491:b0:231:c3c1:babb with SMTP id d9443c01a7336-24288d58912mr33739075ad.18.1754388233431;
        Tue, 05 Aug 2025 03:03:53 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2423783a84bsm96838595ad.51.2025.08.05.03.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 03:03:53 -0700 (PDT)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH rdma-rc 0/4] RDMA/bnxt_re: Bug fixes for bnxt_re driver
Date: Tue,  5 Aug 2025 15:39:56 +0530
Message-ID: <20250805101000.233310-1-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series of patches provides few fixes for the bnxt_re driver.
A couple of SRQ related fixes, one fix for a possible memory leak.

Thanks,
Kalesh AP

Anantha Prabhu (1):
  RDMA/bnxt_re: Fix to initialize the PBL array

Kalesh AP (1):
  RDMA/bnxt_re: Fix a possible memory leak in the driver

Kashyap Desai (2):
  RDMA/bnxt_re: Fix to do SRQ armena by default
  RDMA/bnxt_re: Fix to remove workload check in SRQ limit path

 drivers/infiniband/hw/bnxt_re/ib_verbs.c  |  8 ++----
 drivers/infiniband/hw/bnxt_re/main.c      | 23 +++++++++++++++++
 drivers/infiniband/hw/bnxt_re/qplib_fp.c  | 30 +----------------------
 drivers/infiniband/hw/bnxt_re/qplib_fp.h  |  2 --
 drivers/infiniband/hw/bnxt_re/qplib_res.c |  2 ++
 5 files changed, 28 insertions(+), 37 deletions(-)

-- 
2.43.5


