Return-Path: <linux-rdma+bounces-4889-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FA9975A93
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Sep 2024 20:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D97082879B5
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Sep 2024 18:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA1D1B7903;
	Wed, 11 Sep 2024 18:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Q3CpBEoX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448F1185B7B
	for <linux-rdma@vger.kernel.org>; Wed, 11 Sep 2024 18:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726080648; cv=none; b=hbTiMej/MNkoHyAcUhCgnwB0k5dtIfbAWUc9LNLXOPpjZ6R/KwkOHY42brnRxYM2llnorVbX4/ryYhtQZPPaty48hSVhdku/BIvKXuJk2ZNDDZ0Vil7P+g4mM9f1eAJn2DCo1YT4be4Lx/UgwHKngKmn2SH6J3HvP8mlMRlcUmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726080648; c=relaxed/simple;
	bh=yHJBT0zktJrwBrQeXQk5Sz2r4oLmjnHknn8GxycdboY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=uINS3IJEdaO7TRzksQ6AIPJB4LfnRXwDSX5BH7Bj1gJ5n5nJfWz/f6m00yQgekcAJjL9/oFdQhR5bRu9TjDuCkfJBa+BwqN9THU4C7VWWe0trWItBSoQGEDfCtBUsg8jTk9Be6x98qfDsTgL+D9cu9tSZh14ZiGBgmygoTz7CpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Q3CpBEoX; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2d89229ac81so121312a91.0
        for <linux-rdma@vger.kernel.org>; Wed, 11 Sep 2024 11:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1726080646; x=1726685446; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zfPUA/rgj8ZO5zioWhOvpSaAURSYsjgbOH0/+cb7F4w=;
        b=Q3CpBEoXPunKd2WqgQNSDdS5ZUeMGI0ttt1hubj8NaAvfYXeQ2dHnz1+2OqJC1fbkv
         Q/BEwGAnweNn/CEDN7MPeClvYUGHPDuqiE47AoIQ+QkYx8xlnAlhks4XMIktImOH7gYD
         fSLwthnLvsK93Wv/4ZclfKFH35kn0kCRqm3Rw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726080646; x=1726685446;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zfPUA/rgj8ZO5zioWhOvpSaAURSYsjgbOH0/+cb7F4w=;
        b=HpMQ/ayO4/hj+Pmqi7xxywgkrzSyREsWEqtY9HEeMmcpflnlwXwGEruTPcVzX9X5LR
         7q58WnEOhwE6QUNV4Kr/wbZ7rEevyh/UgCwqCyBTQhxy/wWKOVlCMBumaKLJ/m+bJnUC
         psQ7j0cxFRrsRSVNS5cWyeK6wxxVfvWwEUmmjodpgxKpIObOGh0QUHNE9SqKu3rOF0vY
         Ehcvo3crKqybutE2SkV4f4/1rDy3JN6Pftiys85IMGWf1UsYkWN+a8o7ZiMJkqGUYbEc
         bPIVft6v5foLMkoNye4r/hGa1RvtiPijA+AKVwJbv2M8rkFYaU5WXvyNTrHIJrHAJklD
         ex2g==
X-Gm-Message-State: AOJu0Yz8e4AzNveXKXeyJVyGXOB8d8pagZRtzga6FDMzOrA4dppYL8tZ
	Sb7G6ULwSqsmEdGvjQpgKDvDueph38NOURvGNkTYZBS11DUHwe10Q/NbF2gVkw==
X-Google-Smtp-Source: AGHT+IGk8rWXghLIr8rlw7K4ecESAOLfLZ3bFPV/9jTQzleufcYWlBp6O8YS1mgwrjWsCQ+3EU1HFg==
X-Received: by 2002:a17:90a:5143:b0:2d3:cc31:5fdc with SMTP id 98e67ed59e1d1-2db9ff778camr238583a91.5.1726080646268;
        Wed, 11 Sep 2024 11:50:46 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db043c59c9sm8903996a91.24.2024.09.11.11.50.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2024 11:50:44 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH 3/4] RDMA/bnxt_re: Add a check for memory allocation
Date: Wed, 11 Sep 2024 11:29:38 -0700
Message-Id: <1726079379-19272-4-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1726079379-19272-1-git-send-email-selvin.xavier@broadcom.com>
References: <1726079379-19272-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

__alloc_pbl() can return error when memory allocation fails.
Driver is not checking the status on one of the instances.

Fixes: 0c4dcd602817 ("RDMA/bnxt_re: Refactor hardware queue memory allocation")
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_res.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infiniband/hw/bnxt_re/qplib_res.c
index dfc943f..1fdffd6 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
@@ -244,6 +244,8 @@ int bnxt_qplib_alloc_init_hwq(struct bnxt_qplib_hwq *hwq,
 			sginfo.pgsize = npde * pg_size;
 			sginfo.npages = 1;
 			rc = __alloc_pbl(res, &hwq->pbl[PBL_LVL_0], &sginfo);
+			if (rc)
+				goto fail;
 
 			/* Alloc PBL pages */
 			sginfo.npages = npbl;
-- 
2.5.5


