Return-Path: <linux-rdma+bounces-11001-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B58FACE52B
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 21:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB88018835CB
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 19:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5B3226D0D;
	Wed,  4 Jun 2025 19:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5VzBf+G"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20629213E74;
	Wed,  4 Jun 2025 19:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749065997; cv=none; b=ia7xxjuL1sodH6druVT0acyiFE1DoIW40Zrr4khzvsWvA505eNcAG2JeXEKBvb76ccc7aYJE3qHNO3Ogh+OmXjjCDWgkUujJVjF+/NwPoQ2eXPkqZN+mkIFo8hPLmp2l9kf3AaBrig8Jn0TaQ3E5ejLpobpHlu3oBvFWfQwWk4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749065997; c=relaxed/simple;
	bh=ViSSTCKpKLV5MKVh04ahkikwxHNh5vZ68dOXQITILJ8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kmaxh4hxRGCNewjNQ10SDeI5Fk8kGzJBfeD4xe1Iv19hnRwroNYKPyl+flJDqAkyiuZpXcxSNjz3HkDvmu2cQDnXimPcvcqdhh17SCTHKPFUszjvHsFN22IyCtn+4n/p2kUGAujMYWJ4k2qqvoj2aWihPldKw9szzC4X/d5BTrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5VzBf+G; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e75668006b9so279353276.3;
        Wed, 04 Jun 2025 12:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749065995; x=1749670795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vi1sLCQhsKy2utXyIOZAD3VMEh2HzP7evqyBYkZJKF8=;
        b=T5VzBf+GpzAN+aLsDTPRLqBSKSD167ySD80cfXSpv3nZS0YHXFSDfFqwri/L+XHdMb
         zTd9PpraMuXxf9e+Jv2QOUBTOnuwL73clldx7Uvwe2l9XmgIdR5o+Qr4QW7tEVrV7jQk
         hMufQQngx0TtaNWjPq/SDy/KuAsWpD0KSutQex8ze2s1hkQFtBsVRoQBKt40DOz7Oy/p
         sNfyqv/Dt1iIMN3EktKfeua4ZjJSjAXv9r9SZh7oI40wB4HU4p53jbOd4NtLbL94ZNy7
         OS2dG+2pBdPiKqyCFHcN/EmSouxnkYVrnvSLwPqtPfyMZSpLgCZONlnb8zBeQ9C7Ityh
         u2Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749065995; x=1749670795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vi1sLCQhsKy2utXyIOZAD3VMEh2HzP7evqyBYkZJKF8=;
        b=Ihi9gbSb/EzaZZ1WdlGwDgq1RtAYrxlPJNEJWFDtGL+2u0gTvz2ESsfpov7RCW5diW
         c97MTYUAyjn0aL2LhX/Ak3lIIOfaq2LdpznWaJ0cIWpCOKMnDfeop/UTCZ8AjYBZU7TF
         BLhc9UTcVBT970nUjKJKh/5uP8vjQv0N20HeQbgJwjiDv71SxeDDpThUtwnhGGGawPHC
         zQdk/36+M+EBAYhenPdlRDCBLsQhSk/WCvXrm8+apK/Fzx6xtg0kH/cKW52hg1RAP6GX
         fr3SsZnqwRk5+y9vPXgvu0r/2HXos6IBgGl4iHl8JsxRPbEL5DMGtti5VQP2HOdHhzD0
         zuVA==
X-Forwarded-Encrypted: i=1; AJvYcCWMuX8cR1dg5QgooCmfl41AiGCXixGAJfhjNIEg0fJsTCnDEezjuUeXnQDiIWUiiQR8knAYWRiIQi8d+ms=@vger.kernel.org, AJvYcCXIY2EnlEjfk/gFmNqZWqZ1kIsboFxiAJYEGLLqiEaGkfAjNZgyKu8Psq3pTapDlplGTfRorBlD9FtyoQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4sq7qwXRimHHvw6+4t3USS6WixQIdqt+CZu9JOFvozWrW3uNN
	ICJaY6xoVURQk9d3fvA9lvUADrKiu8o6He/tvG5w+TTzzKJnC2gjth1r
X-Gm-Gg: ASbGnct4UnPHD89DRcgR4VqkM5RX0YODnPEOTT8vbNUlh0mI/gIcriHf/LCx+m/29iN
	SP5ez5WWfnjuf1e5frj3QZDevfWelDoE6CDFZD5YzRXyo52BYUM6RXgFOrLC3Ig1B5I9kpF+ZBV
	6VP3EP9PwkhBYO8FvoZaWD23DW3IBusW0okFK2Dh4UmLu5nzrKOMurXh9sDf+HyFkpV9r0OzAT4
	hSCGbXG549mqoeCWAyVg5XWVCtl1IgpFbLZBEne8yVC6ADkSKU2/+kavModw9dQ/Sgj+kc08oWe
	q6lippyccAYbWmBaRlYs4a7Pe3MeodBWr2tTiwFKVII75r5gV/PD5V6tFUIY1NIe5Rs62B846g5
	S4yFigdg902Dq2V0Wl501LA==
X-Google-Smtp-Source: AGHT+IHLXyrVRpp+GuPD1ypPcVeRJtYeyciAJWyVcJxXvEzReNn1owfVG7IgU2EMJJCgJtI3oSQeYw==
X-Received: by 2002:a05:6902:1243:b0:e7d:7c54:952d with SMTP id 3f1490d57ef6-e8179c1d496mr5306728276.7.1749065994880;
        Wed, 04 Jun 2025 12:39:54 -0700 (PDT)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e7f734febd4sm3254007276.46.2025.06.04.12.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 12:39:54 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] RDMA: hfi1: fix possible divide-by-zero in find_hw_thread_mask()
Date: Wed,  4 Jun 2025 15:39:38 -0400
Message-ID: <20250604193947.11834-3-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250604193947.11834-1-yury.norov@gmail.com>
References: <20250604193947.11834-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Yury Norov [NVIDIA]" <yury.norov@gmail.com>

The function divides number of online CPUs by num_core_siblings, and
later checks the divider by zero. This implies a possibility to get
and divide-by-zero runtime error. Fix it by moving the check prior to
division. This also helps to save one indentation level.

Signed-off-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
---
 drivers/infiniband/hw/hfi1/affinity.c | 44 +++++++++++++++------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/affinity.c b/drivers/infiniband/hw/hfi1/affinity.c
index 7ead8746b79b..f2c530ab85a5 100644
--- a/drivers/infiniband/hw/hfi1/affinity.c
+++ b/drivers/infiniband/hw/hfi1/affinity.c
@@ -964,31 +964,35 @@ static void find_hw_thread_mask(uint hw_thread_no, cpumask_var_t hw_thread_mask,
 				struct hfi1_affinity_node_list *affinity)
 {
 	int possible, curr_cpu, i;
-	uint num_cores_per_socket = node_affinity.num_online_cpus /
+	uint num_cores_per_socket;
+
+	cpumask_copy(hw_thread_mask, &affinity->proc.mask);
+
+	if (affinity->num_core_siblings == 0)
+		return;
+
+	num_cores_per_socket = node_affinity.num_online_cpus /
 					affinity->num_core_siblings /
 						node_affinity.num_online_nodes;
 
-	cpumask_copy(hw_thread_mask, &affinity->proc.mask);
-	if (affinity->num_core_siblings > 0) {
-		/* Removing other siblings not needed for now */
-		possible = cpumask_weight(hw_thread_mask);
-		curr_cpu = cpumask_first(hw_thread_mask);
-		for (i = 0;
-		     i < num_cores_per_socket * node_affinity.num_online_nodes;
-		     i++)
-			curr_cpu = cpumask_next(curr_cpu, hw_thread_mask);
-
-		for (; i < possible; i++) {
-			cpumask_clear_cpu(curr_cpu, hw_thread_mask);
-			curr_cpu = cpumask_next(curr_cpu, hw_thread_mask);
-		}
+	/* Removing other siblings not needed for now */
+	possible = cpumask_weight(hw_thread_mask);
+	curr_cpu = cpumask_first(hw_thread_mask);
+	for (i = 0;
+	     i < num_cores_per_socket * node_affinity.num_online_nodes;
+	     i++)
+		curr_cpu = cpumask_next(curr_cpu, hw_thread_mask);
 
-		/* Identifying correct HW threads within physical cores */
-		cpumask_shift_left(hw_thread_mask, hw_thread_mask,
-				   num_cores_per_socket *
-				   node_affinity.num_online_nodes *
-				   hw_thread_no);
+	for (; i < possible; i++) {
+		cpumask_clear_cpu(curr_cpu, hw_thread_mask);
+		curr_cpu = cpumask_next(curr_cpu, hw_thread_mask);
 	}
+
+	/* Identifying correct HW threads within physical cores */
+	cpumask_shift_left(hw_thread_mask, hw_thread_mask,
+			   num_cores_per_socket *
+			   node_affinity.num_online_nodes *
+			   hw_thread_no);
 }
 
 int hfi1_get_proc_affinity(int node)
-- 
2.43.0


