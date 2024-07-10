Return-Path: <linux-rdma+bounces-3787-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD30992CE07
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2024 11:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E08161C2111E
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2024 09:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68D617BB27;
	Wed, 10 Jul 2024 09:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="no2811x1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E667D08D
	for <linux-rdma@vger.kernel.org>; Wed, 10 Jul 2024 09:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720603026; cv=none; b=WFP/SMBUXJoJL/cZVD6ZeEU1cGqZcnX3txBdYxX98lYCHfWPmZIKHb73nkPbWYEM6StNdlAGNrzIbWjVt5K68Gh6MLn1/zIBkncZF/UYDzixvmWIs8qrlw46j0nflUAe+H0ip1CnUh1bRFHf2ATQgLZQoggmeCJFjEgidOV05Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720603026; c=relaxed/simple;
	bh=492R4VMo7A/cOu8yspJiEOXFeZPLtkN1QHxffHiPltc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nv/lNa47M8KSvNvZNpEaoXvusPZDN7XAB0Joh2r1qQLoJsbxwmD4unzoOI61m7ZywqzhytqQJEd1W/sMjpfzdOpsaaYGocwcqH2QrEOHVj6sMtN6aSzITYsBEv/+11sZQsIjrBifVurgOXjkKzB6oNaGaXCxgj49MTHvOCZeNLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=no2811x1; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fb0d7e4ee9so39522395ad.3
        for <linux-rdma@vger.kernel.org>; Wed, 10 Jul 2024 02:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720603024; x=1721207824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MH9XFFDHuCxMNoCVVrKEnHyxTG0c/B61jNNryy8Ax8w=;
        b=no2811x1MsE5u2PF+dahX1TcFzmrA2qcS1Yt8u2CaQkW4G25aFBLBjll2dManR5usJ
         fBN+snuFawIOqq3K0GEfoMA5Y7ups+zJQV/Vnb3oMoWY3ney5bCHELAwXAFVMRhxaWrv
         ftOdsAXI7CGvRKya2CctMjAFF400PvhIgJuc/JDSAsRJCHxJnVKQVb+UCMAe6CN3kvUt
         PugImYo24BFwOcZqPfch9eJlYE1F9XlLFlrC6ILCFNWYFW5B1FfnK9BJju+VzV9HsDDI
         xS9Y2MWjYOf8+HMgjfQTAqbsp/42jYd7hrm+NfFaVE6GhcHE4qZymwrezpgj/nYwpqeD
         J82A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720603024; x=1721207824;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MH9XFFDHuCxMNoCVVrKEnHyxTG0c/B61jNNryy8Ax8w=;
        b=tT2rxjOov5SlK3VcsQ2XyNmcUDEKK6dRvVJTuxUNi/gw1tjx95pLK5QVR2cnMx/A7V
         78kLUc6xjLbgiMmyiAwRtjO87rXd5FVxit4T6jO7CV8F2aXSc+c0BW333y8QIoEj87FJ
         vknCrgkcNdGIAZVh6mH2+7sUuh8VVnfCFhpW7z4c/hE9G7kiTndaF0nVGjScBz/SdCym
         6wpqxaPbs2tszFayiRQNgydaaT7/f/fJFkY6Jvr4Bw/ZS1nBEnxwo7pmquxIPff2XWG6
         r7Uv5yJC9OKq+IBAarOpTxzj9gQ77qr55o5Jcx7R/Si8YyvuMgFVqhAvKAQ+WWJW8FpQ
         UMUg==
X-Gm-Message-State: AOJu0YxxDaUleHP6/dIuWtysOaPa1kry8K/Bug6/I2TegdUyGpMwPens
	t2XWxQWgxyT3VBmAUuI9+vbwJgW2Od7W0Ue1grKuqGVmCZMFBkomECNXPw==
X-Google-Smtp-Source: AGHT+IEWMG0ktcWImf7hAcQM1wDeRhuw+FZJ0/ym7zNpSwvpXVKrpTSdZAAfPYzWzXztzSeP283VQA==
X-Received: by 2002:a17:903:22c5:b0:1fb:57a6:2ae7 with SMTP id d9443c01a7336-1fbb6f0a161mr42594765ad.59.1720603024424;
        Wed, 10 Jul 2024 02:17:04 -0700 (PDT)
Received: from FLYINGPENG-MB1.tencent.com ([103.7.29.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6acf8fesm29084125ad.250.2024.07.10.02.17.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 10 Jul 2024 02:17:03 -0700 (PDT)
From: flyingpenghao@gmail.com
X-Google-Original-From: flyingpeng@tencent.com
To: gg@ziepe.ca,
	nathan@kernel.org
Cc: linux-rdma@vger.kernel.org,
	Peng Hao <flyingpeng@tencent.com>
Subject: [PATCH v2] infiniband/hw/ocrdma: fix the problem of KASAN causing the stack frame size to increase
Date: Wed, 10 Jul 2024 17:16:57 +0800
Message-Id: <20240710091657.26291-1-flyingpeng@tencent.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peng Hao <flyingpeng@tencent.com>

drivers/infiniband/hw/ocrdma/ocrdma_stats.c:686:16: error: stack frame size (20664) exceeds limit (8192) in 'ocrdma_dbgfs_ops_read' [-Werror,-Wframe-larger-than]
static ssize_t ocrdma_dbgfs_ops_read(struct file *filp, char __user *buffer,
               ^

Some functions called by ocrdma_dbgfs_ops_read occupy a lot of stack space.
Mark these functions as noinline_for_stack to prevent them from accumulating
in ocrdma_dbgfs_ops_read.

Signed-off-by: Peng Hao <flyingpeng@tencent.com>
---
 drivers/infiniband/hw/ocrdma/ocrdma_stats.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_stats.c b/drivers/infiniband/hw/ocrdma/ocrdma_stats.c
index 5f831e3bdbad..3fdc57969f7d 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_stats.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_stats.c
@@ -99,7 +99,7 @@ void ocrdma_release_stats_resources(struct ocrdma_dev *dev)
 	kfree(mem->debugfs_mem);
 }
 
-static char *ocrdma_resource_stats(struct ocrdma_dev *dev)
+static noinline_for_stack char *ocrdma_resource_stats(struct ocrdma_dev *dev)
 {
 	char *stats = dev->stats_mem.debugfs_mem, *pcur;
 	struct ocrdma_rdma_stats_resp *rdma_stats =
@@ -216,7 +216,7 @@ static char *ocrdma_resource_stats(struct ocrdma_dev *dev)
 	return stats;
 }
 
-static char *ocrdma_rx_stats(struct ocrdma_dev *dev)
+static noinline_for_stack char *ocrdma_rx_stats(struct ocrdma_dev *dev)
 {
 	char *stats = dev->stats_mem.debugfs_mem, *pcur;
 	struct ocrdma_rdma_stats_resp *rdma_stats =
@@ -284,7 +284,7 @@ static u64 ocrdma_sysfs_rcv_data(struct ocrdma_dev *dev)
 		rx_stats->roce_frame_bytes_hi))/4;
 }
 
-static char *ocrdma_tx_stats(struct ocrdma_dev *dev)
+static noinline_for_stack char *ocrdma_tx_stats(struct ocrdma_dev *dev)
 {
 	char *stats = dev->stats_mem.debugfs_mem, *pcur;
 	struct ocrdma_rdma_stats_resp *rdma_stats =
@@ -358,7 +358,7 @@ static u64 ocrdma_sysfs_xmit_data(struct ocrdma_dev *dev)
 				 tx_stats->read_rsp_bytes_hi))/4;
 }
 
-static char *ocrdma_wqe_stats(struct ocrdma_dev *dev)
+static noinline_for_stack char *ocrdma_wqe_stats(struct ocrdma_dev *dev)
 {
 	char *stats = dev->stats_mem.debugfs_mem, *pcur;
 	struct ocrdma_rdma_stats_resp *rdma_stats =
@@ -391,7 +391,7 @@ static char *ocrdma_wqe_stats(struct ocrdma_dev *dev)
 	return stats;
 }
 
-static char *ocrdma_db_errstats(struct ocrdma_dev *dev)
+static noinline_for_stack char *ocrdma_db_errstats(struct ocrdma_dev *dev)
 {
 	char *stats = dev->stats_mem.debugfs_mem, *pcur;
 	struct ocrdma_rdma_stats_resp *rdma_stats =
@@ -412,7 +412,7 @@ static char *ocrdma_db_errstats(struct ocrdma_dev *dev)
 	return stats;
 }
 
-static char *ocrdma_rxqp_errstats(struct ocrdma_dev *dev)
+static noinline_for_stack char *ocrdma_rxqp_errstats(struct ocrdma_dev *dev)
 {
 	char *stats = dev->stats_mem.debugfs_mem, *pcur;
 	struct ocrdma_rdma_stats_resp *rdma_stats =
@@ -438,7 +438,7 @@ static char *ocrdma_rxqp_errstats(struct ocrdma_dev *dev)
 	return stats;
 }
 
-static char *ocrdma_txqp_errstats(struct ocrdma_dev *dev)
+static noinline_for_stack char *ocrdma_txqp_errstats(struct ocrdma_dev *dev)
 {
 	char *stats = dev->stats_mem.debugfs_mem, *pcur;
 	struct ocrdma_rdma_stats_resp *rdma_stats =
@@ -462,7 +462,7 @@ static char *ocrdma_txqp_errstats(struct ocrdma_dev *dev)
 	return stats;
 }
 
-static char *ocrdma_tx_dbg_stats(struct ocrdma_dev *dev)
+static noinline_for_stack char *ocrdma_tx_dbg_stats(struct ocrdma_dev *dev)
 {
 	int i;
 	char *pstats = dev->stats_mem.debugfs_mem;
@@ -480,7 +480,7 @@ static char *ocrdma_tx_dbg_stats(struct ocrdma_dev *dev)
 	return dev->stats_mem.debugfs_mem;
 }
 
-static char *ocrdma_rx_dbg_stats(struct ocrdma_dev *dev)
+static noinline_for_stack char *ocrdma_rx_dbg_stats(struct ocrdma_dev *dev)
 {
 	int i;
 	char *pstats = dev->stats_mem.debugfs_mem;
@@ -498,7 +498,7 @@ static char *ocrdma_rx_dbg_stats(struct ocrdma_dev *dev)
 	return dev->stats_mem.debugfs_mem;
 }
 
-static char *ocrdma_driver_dbg_stats(struct ocrdma_dev *dev)
+static noinline_for_stack char *ocrdma_driver_dbg_stats(struct ocrdma_dev *dev)
 {
 	char *stats = dev->stats_mem.debugfs_mem, *pcur;
 
-- 
2.31.1


