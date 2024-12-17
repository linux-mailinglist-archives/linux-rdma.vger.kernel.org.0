Return-Path: <linux-rdma+bounces-6568-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFB19F48EB
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Dec 2024 11:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC25F16AC71
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Dec 2024 10:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5181E0B7D;
	Tue, 17 Dec 2024 10:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NqqbRvxV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295DF1D5CFD
	for <linux-rdma@vger.kernel.org>; Tue, 17 Dec 2024 10:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734431524; cv=none; b=A6bSWXMRu7n3hJmj/Zw/t/43KHTuRgy+fVNRhlHOQhTRQYowS4vGDM30FOQjAd/yAZPjp2e+lOUrJfnlepvUtsKT8LFiIAGIWVNFzxEBvPH1WCkcPF6/M6M+6mkYye97UcJwoqjnyLhrvBhXgV81fwmhYSywAFjGVYYZ+lhaYvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734431524; c=relaxed/simple;
	bh=nlO3gVti/r6DXZb8Dl44RVwU14ShV4rqZ7ei/KH3vBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q8uhI2/QG+Vzfh5YCmso1fKwlXBSRzQp/t1Oezm7pCjVpyP8DHKIOhXQtIjVJCpIhaIcTO8nM3UtfIQigQaA6b0wjFfvExYwANkpWBJN0h/gGDpapaPBq6FAa7rW222DdgV5nhJznp0uAV4Lhz52VKAjU6TYhBSY7VMeMXd741k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NqqbRvxV; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ee76929a98so3743581a91.1
        for <linux-rdma@vger.kernel.org>; Tue, 17 Dec 2024 02:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1734431522; x=1735036322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7GcsuZXG42/f5qV8KKzngTxp9t5eJX0F39jR+TbZUus=;
        b=NqqbRvxVFK8RIGfBws/+LAAqwOiwfrSya58RS/QjuHeU3SCavyVIINCEQ0wSDFS6qI
         I2LIqM6RMXDQYGveXDgk0RgC0ujPSr/ieUvxOepx6cuLMukyhWDKDpkmGZZQBEjQn2xK
         /iAvUBBj3C5YVFwQNqHvApeanqLWc+USO2y+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734431522; x=1735036322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7GcsuZXG42/f5qV8KKzngTxp9t5eJX0F39jR+TbZUus=;
        b=Q7MMo40GgZ4IirhE/JBaMsTeoZpFHQOwz+IS07+k6kX/jQLb8oDCBtygLdlYkc3znT
         h+je47ElwhsY5SHulQyDsAc0EwfqyYtiI5QdTZ9a7V0AaymkPK77SPlL86TsMv3Oc9pf
         vUAPoqW3NjlCyaDM0JXQc7/DVVL18+3CbD1JbjdCniQrLdyJl0eTQUryrO6sPgN3RdQx
         gbjqcf/NMxvPx7/e5t8TYuQgFdYuW6pTUI4UgrBa/fuV6nhej70BZdzPBljA+Qnz4+oa
         JGDVyhXvAC+vUPNdEJ0QChUimBQgZ6ZoLaTErnfnUppdyKTsnwA5Pgyj9PcM/v5z8Aub
         cFDA==
X-Gm-Message-State: AOJu0Yx4cj4+b9ow+i0XKsqESp0hxmdXoGZgSuuQTDXBZCXYD4ZE3pWn
	/ttPYZW/maYagfpxfb6aveB7mgc5XRpZX6YV/97FDMX/TJWoZiWCHQglKwIafQ==
X-Gm-Gg: ASbGncue/OJ1zkoc9RtACs65kD8wU7GEovHHs1zBgyGNYNgGKHRcR6bQWwVE+xoInEf
	FOYO23Dp+F3f4iXUvDDyjkRy76FkIWWJQlyQhOglX1iwbKxkjuDD0IaRwfBWUB4Wh69msWrpWBT
	C4UzASbysulbbYZ2dRUprMKXHIetFA2rzWtmKRyE3ssjBUJBJsC2IjTIcmZ/OkArkhJFP99DgvX
	d2AWSvMfR2FZEjBxm8qsTWlhUVpalT8N4gO3Trh/T1uzGRRTBSX7YRh31sQ2JwwWfe7B4DygHEc
	T1NRRlduWHGV7jsuR5jSHjK7+Hehx49yubzyqzhiWTJuOQWi/IkNuS1yR0o=
X-Google-Smtp-Source: AGHT+IFNdCGPPl27MfUcF+eH7DSupDq/cdflrQzSv5wqTGr3+XATUTgxM0xY8jjUyv2pCh4CcT7kkw==
X-Received: by 2002:a17:90b:1b07:b0:2ef:cbcc:768b with SMTP id 98e67ed59e1d1-2f2d87bd428mr3962609a91.6.1734431522346;
        Tue, 17 Dec 2024 02:32:02 -0800 (PST)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142d90bd8sm10764596a91.10.2024.12.17.02.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 02:32:01 -0800 (PST)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH for-rc 1/5] RDMA/bnxt_re: Fix max_qp_wrs reported
Date: Tue, 17 Dec 2024 15:56:45 +0530
Message-ID: <20241217102649.1377704-2-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241217102649.1377704-1-kalesh-anakkur.purayil@broadcom.com>
References: <20241217102649.1377704-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Selvin Xavier <selvin.xavier@broadcom.com>

While creating qps, driver adds one extra entry to the sq size
passed by the ULPs in order to avoid queue full condition.
When ULPs creates QPs with max_qp_wr reported, driver creates
QP with 1 more than the max_wqes supported by HW. Create QP fails
in this case. To avoid this error, reduce 1 entry in max_qp_wqes
and report it to the stack.

Fixes: 1ac5a4047975 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_sp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
index 7e20ae3d2c4f..73c9baaebb4e 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -129,7 +129,7 @@ int bnxt_qplib_get_dev_attr(struct bnxt_qplib_rcfw *rcfw,
 	attr->max_qp_init_rd_atom =
 		sb->max_qp_init_rd_atom > BNXT_QPLIB_MAX_OUT_RD_ATOM ?
 		BNXT_QPLIB_MAX_OUT_RD_ATOM : sb->max_qp_init_rd_atom;
-	attr->max_qp_wqes = le16_to_cpu(sb->max_qp_wr);
+	attr->max_qp_wqes = le16_to_cpu(sb->max_qp_wr) - 1;
 	/*
 	 * 128 WQEs needs to be reserved for the HW (8916). Prevent
 	 * reporting the max number
-- 
2.43.5


