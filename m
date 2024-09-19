Return-Path: <linux-rdma+bounces-4992-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3F597C321
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Sep 2024 05:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DB3B1C215E1
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Sep 2024 03:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51D9125A9;
	Thu, 19 Sep 2024 03:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="H+tJPodZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291182F28
	for <linux-rdma@vger.kernel.org>; Thu, 19 Sep 2024 03:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726716419; cv=none; b=K1eAXm4ZLmI3ltHa4CuRnOiCVCRie8gflPpBQZtxzSsPRdvmNPA+61Oz5hP87kATnxA9JFnNQr/wS/xJd8kVi3Jy5WKz23Z9NP3VeoLx8gX3c8gbHNPqAfrjKxk7ndJRqoDkngnD33Dy6gios600qf3SSdw+JHMdzWCBqZe5gFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726716419; c=relaxed/simple;
	bh=RAHEbb/L3GHBY0KmyIFigaHmB+Zy8cl5UTiMWrSXoJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=MEAosZmwtooX/7CBtTCWR8kIC+KB0/d18FdpbFuKK1BlvBnQ3Ymlm4sQfMrOPLSDKwKRSKcrvuFnbGOkW4w1yMe3cU4uwR9g2rTKcQYrDi5gfRq8zwLAynNVwJKErZ70kHxtQ+GlotMmFhPrbs/25jfB3w1VKF7zOno8VNZsJqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=H+tJPodZ; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7198cb6bb02so234984b3a.3
        for <linux-rdma@vger.kernel.org>; Wed, 18 Sep 2024 20:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1726716417; x=1727321217; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=03ASqymI4RekJ50OKXabyHgax5n64huK2dd3ddiQAlM=;
        b=H+tJPodZ6c1vWWG8XqRww3otKWwcZGVv46sVRdw7umw0scHBojal5LOOThFAx7GDye
         2/nHYJqDcmLy6SoFmOQixnjJSVAEAre3zwRCcYueP+xrRNJYutI1kYLsnAdQC/rr5oNz
         Al/AtLt+VKu1MQ6AxK37q+kiopsY+W2PDNcT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726716417; x=1727321217;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=03ASqymI4RekJ50OKXabyHgax5n64huK2dd3ddiQAlM=;
        b=sofi2wJ5JU98MvUNAWatxKRfUjh3crCcJPawZcZPBzWqIGwuKIEd0mVfRk6MWqshQ0
         jBt8IZrRGf/+8P1U6ESzKlFDXOs/SxnKqbEw+T0AgWhdNIMOVthIyO3lKPxYcLd/eaig
         qGRBTrpVKKMc2jOdKx3eiKjQVl5quBiGFSRaIxEcmKEnENtjSrOwHKPORPFFj/s5oENK
         4Zp1oRorpdh2JHiugmzPPW2HRMlH1cZMAoKGbqNxxypC3JiY37s4rtZuSdVAk0RuNmA+
         BCnKSv9HxOwG9fN2TkYXj6wQx7/ZRPx/3+DdKtuD0/QZAR3LxbFePyKfUDBSj+U0nzhC
         go1A==
X-Gm-Message-State: AOJu0YwMkxI9DUDN3gtp8nwZtx5ZceKoGltoG9ItjnVMRju48BLJ+9WO
	WUZ641sUMGOyn8cRscFgeFFWrC/t9kBQYoTiiN6g2mf2KjFFRCa1gez7FQRMww==
X-Google-Smtp-Source: AGHT+IFwKgyqVM7I4k/79WIz21ojm7LF4YsGTf2XikTkviSJoOtg7WZj+GydfuLDSAHzcZTieGRHtQ==
X-Received: by 2002:a05:6a00:2d05:b0:714:1bcf:3d93 with SMTP id d2e1a72fcca58-719260562d7mr35171768b3a.5.1726716417286;
        Wed, 18 Sep 2024 20:26:57 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944a980b4sm7400686b3a.34.2024.09.18.20.26.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Sep 2024 20:26:56 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Saravanan Vajravel <saravanan.vajravel@broadcom.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH v2 for-rc 2/6] RDMA/bnxt_re: Fix incorrect AVID type in WQE structure
Date: Wed, 18 Sep 2024 20:05:57 -0700
Message-Id: <1726715161-18941-3-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1726715161-18941-1-git-send-email-selvin.xavier@broadcom.com>
References: <1726715161-18941-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Saravanan Vajravel <saravanan.vajravel@broadcom.com>

Driver uses internal data structure to construct WQE frame.
It used avid type as u16 which can accommodate up to 64K AVs.
When outstanding AVID crosses 64K, driver truncates AVID and
hence it uses incorrect AVID to WR. This leads to WR failure
due to invalid AV ID and QP is moved to error state with reason
set to 19 (INVALID AVID). When RDMA CM path is used, this issue
hits QP1 and it is moved to error state

Fixes: 1ac5a4047975 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
Reviewed-by: Chandramohan Akula <chandramohan.akula@broadcom.com>
Signed-off-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_fp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
index b62df87..820611a 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
@@ -170,7 +170,7 @@ struct bnxt_qplib_swqe {
 			};
 			u32		q_key;
 			u32		dst_qp;
-			u16		avid;
+			u32		avid;
 		} send;
 
 		/* Send Raw Ethernet and QP1 */
-- 
2.5.5


