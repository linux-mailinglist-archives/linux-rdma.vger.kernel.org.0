Return-Path: <linux-rdma+bounces-4887-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 749E7975A92
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Sep 2024 20:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A20EA1C22FA8
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Sep 2024 18:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75E51B6541;
	Wed, 11 Sep 2024 18:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ImIR+yT8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302F0185B7B
	for <linux-rdma@vger.kernel.org>; Wed, 11 Sep 2024 18:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726080639; cv=none; b=rmxhBQmyF7xtDyFK2Vmcbn1TGeNuFpQHPPvvnBQJSoUCnRg3xgVxnd09MHD95kl6sN4TbuLTJCzriW2GDQL+/176+tTO78O9IJKbJ4hwgUzUs4UMxZ3f5Z+5oGDDe94kgsbZ2PAZP9eSFfV/sdcs6asiGbsu0j8O5k5P64qAYKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726080639; c=relaxed/simple;
	bh=9L7/UMGLYd23DqnqG0vpJIms0XbZ75xz8nRJnSIrlDU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=TIRB2UyHSf1DD9mHacnZssIC35WZ3tk5u0b7ppe3hFpFy7oesTbf3ss5NHL3CvKyQp/bYOLQJHguKJXL15NSiPGrHXVBugehEN2nT6nyZ2FbBJqc5iJkWQxcP+NsYkLA2bvA5gV90/Vdk5WhVnMhwfeyo/S11C6ZjNLKl0caJAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ImIR+yT8; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2d88690837eso108381a91.2
        for <linux-rdma@vger.kernel.org>; Wed, 11 Sep 2024 11:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1726080637; x=1726685437; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ASJBR2WWDc5Ivil9kGHYQQCa3Eo0/d547rlwumu8ksM=;
        b=ImIR+yT8jFBgc73ZsoYmKBnu32H9c2/T6gJvuUqQWDMraVNSjQefc7ZhP7lHycxgBY
         IQBRoRdcqH/pURVbsxQrpg5sioTyFuZtFCndin9OMTK/FIHDTQ8go1cUPi+4ULu4fTQc
         t2hnc6ubxWJ3X8UynxXvXO606Ayi/4qdNWOq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726080637; x=1726685437;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ASJBR2WWDc5Ivil9kGHYQQCa3Eo0/d547rlwumu8ksM=;
        b=jd3f9HodVpgjNebhJQFuWgBrj6Bg1yYVTFUT888eS06ihz4+7yI7IylxeKAdznoYkk
         jaPoeYIXXJmxsMw9w0/8f4WduVBfgwiFdb1cSJEjxIImVoxx6c+VKXbTummbU7SQpJEV
         +4oiyxyvJ6nBdoUZOowTBNz8bs54ibrBP2X6T82FT7Zh8+iS00t/BWAPipFft5KPIndL
         9FK8YhTag6tUPSAt8ZGznBwuJV6+KbVJGg5p48ZCrbOuI4luMxCqu9MAuThciDLYjvUb
         pQkWTpN5XMXUmm7/WHB3YHzxbLZF1Uzh7BKDFbInTysSdhdB4XIKYtA8N8jYRwY7ns43
         Zb2A==
X-Gm-Message-State: AOJu0YzP8b2u0YztU1RYDm7dcgsx5BWU8HU2DSNwlFemvq51hQgGnapq
	J/XBQNXGTgdvArvuM3ugIOR93ZgZ8EpufDWBWGxpx2JA/FdlYK+Ba5oROrY3VA==
X-Google-Smtp-Source: AGHT+IGZZbQg06YFwBWUxmSzoDr+bay7AO1SZnQxHtrGkB2dUKBswt4uLLrvt/f2U3v1OhkooCS1PA==
X-Received: by 2002:a17:90a:7407:b0:2d8:8252:f675 with SMTP id 98e67ed59e1d1-2dba007f0a6mr149600a91.39.1726080637062;
        Wed, 11 Sep 2024 11:50:37 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db043c59c9sm8903996a91.24.2024.09.11.11.50.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2024 11:50:34 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH 1/4] RDMA/bnxt_re: Fix a possible memory leak
Date: Wed, 11 Sep 2024 11:29:36 -0700
Message-Id: <1726079379-19272-2-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1726079379-19272-1-git-send-email-selvin.xavier@broadcom.com>
References: <1726079379-19272-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

In bnxt_re_setup_chip_ctx() when bnxt_qplib_map_db_bar() fails
driver is not freeing the memory allocated for "rdev->chip_ctx".

Fixes: 0ac20faf5d83 ("RDMA/bnxt_re: Reorg the bar mapping")
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 16a84ca..72719c8 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -186,8 +186,11 @@ static int bnxt_re_setup_chip_ctx(struct bnxt_re_dev *rdev)
 
 	bnxt_re_set_db_offset(rdev);
 	rc = bnxt_qplib_map_db_bar(&rdev->qplib_res);
-	if (rc)
+	if (rc) {
+		kfree(rdev->chip_ctx);
+		rdev->chip_ctx = NULL;
 		return rc;
+	}
 
 	if (bnxt_qplib_determine_atomics(en_dev->pdev))
 		ibdev_info(&rdev->ibdev,
-- 
2.5.5


