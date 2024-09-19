Return-Path: <linux-rdma+bounces-4991-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B78F497C322
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Sep 2024 05:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38DC1B211C4
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Sep 2024 03:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D599E12E75;
	Thu, 19 Sep 2024 03:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EBjm3a3P"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7862F28
	for <linux-rdma@vger.kernel.org>; Thu, 19 Sep 2024 03:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726716416; cv=none; b=BLyDouC3M+VDG2rp5dJAqqBQ/Tg3vLHwNcx8PpbMbPg8aM/k9JhtE464lydunZZUKj71uewH/sGb7y9Dss2f2PBE8rZwQ9kTMve6oUbBDx4+vIrf2PUlAlDaLf/oDCk0NKLl25MQgPZKHwjvplqzpBHEyrJt7fUEqYvqulVrpTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726716416; c=relaxed/simple;
	bh=9L7/UMGLYd23DqnqG0vpJIms0XbZ75xz8nRJnSIrlDU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=o2PGRS8yUEOpwBJqE9Iy119o853SRh6WWiP/lTv7U4WFxRQI9SRCjvmo0aTsTF9CxJeSiwzYsrIf147NgqP1WR0oEcden70Uuch4TbLAp1hv35By8Yx4s/hjVmsCIOfnDHKH/wAXYSUAOevqvpLlHbQiYhXZR9caWX5IKcnDalk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=EBjm3a3P; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71971d20a95so280885b3a.3
        for <linux-rdma@vger.kernel.org>; Wed, 18 Sep 2024 20:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1726716414; x=1727321214; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ASJBR2WWDc5Ivil9kGHYQQCa3Eo0/d547rlwumu8ksM=;
        b=EBjm3a3PYqBkh6fjjAibwycMS6fUdFDZugxw+H2k0IBJx7mm7pk3dGN/PR/GeS+zIO
         RxSTsOsJd1PT7fdjSFbDoPBlarGHDk8BP72BQQ0O5u9NM8nb00jkWooNkU5PPPTfAAUO
         WHfZ+Xb0rqIzYzlmfUKQXbPXZSyr+NwAx/9Fg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726716414; x=1727321214;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ASJBR2WWDc5Ivil9kGHYQQCa3Eo0/d547rlwumu8ksM=;
        b=dg2hD5ZnoCxWD4FuMeWKSsVv2Xy/00az2Y/o44mdvZoua573vBgMRVrVzKjK1twi2v
         qbi5+3ssLu8HUFTL9iPatQuHMSGihZc8hl/b1yKNd2SBO0qJnOkOVAQRrJRHJy6XCglU
         2iL9Hvxwm5xgkFzlowrOgKvkDNPY1mTLZNksPkLgru2AiwLsVtkxHlzc87gjZDWN14mf
         zhoN+g0Egxc0mQT/llCjYqg6j11Wdg25R8LTAKCvRtgQ27U2A/Yiw0pv/mxPwPV63RXa
         ST56RHNSbCVl6RIPUyVKLbs8WZ1IraDSaGOr5jjo0pj9TNVTorPBv6NYmw8FOI3vkN3h
         9Mjw==
X-Gm-Message-State: AOJu0YwDgZMnflCS17TeyRCh0w6NHXWjGUIXGeEdepNGhvIj1C0MJUnI
	jsHVKcCJqYxTr27fe6aWxE+ns1O2ERgieahlNeJKNciMvHHKcjUqvyXyPC76F34+dOPcyL+KJkY
	=
X-Google-Smtp-Source: AGHT+IG1HVnvP2XQjnoOcQ/hkxScy2KKrDUiLK6YFlseiFhz3ioVyJ9PDB4QqAIwK5aLBRyA6YqopQ==
X-Received: by 2002:a05:6a00:c8f:b0:70d:2ac8:c838 with SMTP id d2e1a72fcca58-71936a3ac34mr36359268b3a.4.1726716414302;
        Wed, 18 Sep 2024 20:26:54 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944a980b4sm7400686b3a.34.2024.09.18.20.26.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Sep 2024 20:26:53 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH v2 for-rc 1/6] RDMA/bnxt_re: Fix a possible memory leak
Date: Wed, 18 Sep 2024 20:05:56 -0700
Message-Id: <1726715161-18941-2-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1726715161-18941-1-git-send-email-selvin.xavier@broadcom.com>
References: <1726715161-18941-1-git-send-email-selvin.xavier@broadcom.com>
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


