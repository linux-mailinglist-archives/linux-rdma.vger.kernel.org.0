Return-Path: <linux-rdma+bounces-4990-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D9997C320
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Sep 2024 05:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D73B1F21EE9
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Sep 2024 03:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484D6125A9;
	Thu, 19 Sep 2024 03:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TW+uUxsb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7408B2F28
	for <linux-rdma@vger.kernel.org>; Thu, 19 Sep 2024 03:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726716414; cv=none; b=TOhWmRziSOmXvnT0jU+wLp4n8FPHr9c5Hs5WpCKs8ag9kTxrLeqESpmmr4vq6jYSBtCctpMgKsFQBgzrbRvWcRDgoufKaP/2xX8dBFajPmQ/qgObkYKL5eDpEVXJzjBiYT9gLAx7p/wRVLxqeV98WUbZzzjFuyVd0d/GqaZvX/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726716414; c=relaxed/simple;
	bh=XysSa2T53WziP1bmCAuMWTFzm/XqNuKjQA9NbDSVIIE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=tqR1Yre8o8QeljumjyL9FhELzFUojsZeyYyNCaDvpjEb+ru1FQ8sBAeL96i2R3cpTt3y1IjZ4BGRRIB4Fl4JKcSEzfVjHYoLVuhFgkLXBPxGziEvd8iZPQTuUlAREML8+BEOPRzEQrKD8po5W+F5USao2DLMw2vkBIscNUhS6Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TW+uUxsb; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71979bf5e7aso252602b3a.1
        for <linux-rdma@vger.kernel.org>; Wed, 18 Sep 2024 20:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1726716412; x=1727321212; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zk7mozYa1toO+VR1wBL2ZGEFduAgriww4HehTeB8t6M=;
        b=TW+uUxsb+5KxJyD7zRXlECOpKRi5DInuADbp3WiNOXXWtaK7/wHeKcBGbehO0dMDYX
         Gop5CiJqKJuRjad7XR78OzOCIeU0/HqScsWnzZXFhGPQtzsieHdMCC2EP3AMZ/WK4iu6
         F63DT0JdT/zvNNxWKj1R+doYKlcwXvwnY5Gg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726716412; x=1727321212;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zk7mozYa1toO+VR1wBL2ZGEFduAgriww4HehTeB8t6M=;
        b=maashDeM157/KJacs84xCVAdiv2eKEUSbNkr2LIUiW+PE0gaUYmA4r+M/3jPZKGoBF
         Tfba1seYF39nRjmumPpAjapHQJbvFto3Vn5Cxn4+AfRyp7yxPvHZ+yd3AFBJ6x1wal3c
         XqFb45bfBmTIrj2lQC4E6SO/ZVE/4cOStzsaYZhmKGqS1/c4lm+x5HOgfWmNyVTXfRZM
         gDp538Azq4VEA/N5mUB6h2tcl9TNNQ8ZF87cti0BMwhphsCwFDvx8yW/4Iz8r7gAvl3K
         asS3Zj2KMlPN5Yo+YK0SoSsU7q+rRsN5MzqTvu0w99dYpzktV0G4wvS27J9UIgx/vUL4
         aEtg==
X-Gm-Message-State: AOJu0Yw1Z1MRp9zf+N/RHvcUr0SnHFUPpOilNsqHFny1lXrFFbdTS3i4
	ARCi/LfB5JZwVC1L42yLvZoPCIMa9g9rc9ohx2X+iek2rFSvCGKFNIYpy30ij3oQCYmbaqOLAT8
	=
X-Google-Smtp-Source: AGHT+IH0YDCV6cFnBf/z5OmAH1J5ZDnDWq0MkS49KI4t7XViy0ng0+BEB+XsTHHFY/fOK8OLxPdzaQ==
X-Received: by 2002:a05:6a00:1827:b0:70d:2a4d:2edc with SMTP id d2e1a72fcca58-719261cc770mr35075580b3a.20.1726716411559;
        Wed, 18 Sep 2024 20:26:51 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944a980b4sm7400686b3a.34.2024.09.18.20.26.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Sep 2024 20:26:49 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH v2 for-rc 0/6] RDMA/bnxt_re: Bug fixes for 6.12 kernel
Date: Wed, 18 Sep 2024 20:05:55 -0700
Message-Id: <1726715161-18941-1-git-send-email-selvin.xavier@broadcom.com>
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

v1 - v2: 
	- Add a patch that removes irq variant of spinlock and use
	  spin_lock_bh as the control path processing happens from
	  tasklet context
	- Address the comments from Zhu Yanjun by initializing the
	  newly added spin lock.
	- One more fix included in the series

Kalesh AP (2):
  RDMA/bnxt_re: Fix a possible memory leak
  RDMA/bnxt_re: Add a check for memory allocation

Saravanan Vajravel (1):
  RDMA/bnxt_re: Fix incorrect AVID type in WQE structure

Selvin Xavier (3):
  RDMA/bnxt_re: Fix the usage of control path spin locks
  RDMA/bnxt_re: synchronize the qp-handle table array
  RDMA/bnxt_re: Fix the max WQEs used in Static WQE mode

 drivers/infiniband/hw/bnxt_re/ib_verbs.c   |  6 ++++-
 drivers/infiniband/hw/bnxt_re/main.c       |  5 +++-
 drivers/infiniband/hw/bnxt_re/qplib_fp.c   |  4 ++++
 drivers/infiniband/hw/bnxt_re/qplib_fp.h   |  2 +-
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 38 +++++++++++++++---------------
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |  2 ++
 drivers/infiniband/hw/bnxt_re/qplib_res.c  |  2 ++
 7 files changed, 37 insertions(+), 22 deletions(-)

-- 
2.5.5


