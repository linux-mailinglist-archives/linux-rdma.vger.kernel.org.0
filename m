Return-Path: <linux-rdma+bounces-4888-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8172975A94
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Sep 2024 20:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B4DEB23589
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Sep 2024 18:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6971B6558;
	Wed, 11 Sep 2024 18:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZzCAVY3a"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E169C185B7B
	for <linux-rdma@vger.kernel.org>; Wed, 11 Sep 2024 18:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726080645; cv=none; b=M0kT60QYb8cWzqjFzbZGsJGHUIYqPd8AvKIYYpffAd8/2/UESAxXGXhJ3FSZgLJ+lbKPBd8f3fJwUZie7rx521NeZXhEVUCit7G22wMwf82k1sCgzsjUPbkPtWpEIn2qHlefzg6niw91ZyorPFwmIG1Ey2o3RJfwDOgSPMnPmjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726080645; c=relaxed/simple;
	bh=RAHEbb/L3GHBY0KmyIFigaHmB+Zy8cl5UTiMWrSXoJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=KW6jySROtpK7UYjlU6YUqH/WQmgjKDG2d1JlOnDiBeVNfJG8rUR7zZdFpKGFRKZUB2jMqUBadXBwPlw2SnQprY/1xFFmex8LBEb22NXPyMFvzBMbdQqaSEutjtS/i2dSmU3wO5VJgXU7GCA6ZqBiaLTOY+RxhZOpovIA/8wqeyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZzCAVY3a; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2d87f34a650so72889a91.1
        for <linux-rdma@vger.kernel.org>; Wed, 11 Sep 2024 11:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1726080643; x=1726685443; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=03ASqymI4RekJ50OKXabyHgax5n64huK2dd3ddiQAlM=;
        b=ZzCAVY3a7SjP7I+QnvfK0FDSIrDnpiGstBtALiyTNany3lrR6lGSfZHwgiJgZwiSAd
         F9wuu5tVSPHKGVzP7cZK5ikNCuD440Y5EiHJ+1HxWZG4/SFGGYFQYjWyjp5xYGSpmKhY
         T22gLey+FQKZBoJTm6cGqc7meAZmBKlVaP0JY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726080643; x=1726685443;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=03ASqymI4RekJ50OKXabyHgax5n64huK2dd3ddiQAlM=;
        b=NzlHJxA16xiyryD/OzXu0+syUk4n52masHoHLs25fuyNzPn4j5EYdr/zW4gT00faq+
         OfmF9ELliVTqWOAhjOLN6tE/1Hryqlzk/NcjXa3wID1JoaORprlRHLVAWO86Zz3j3SLe
         ZGT+8BBd1mdTsk8ytEIUPVZbeyXAitYUO/QCaZeGsjhcBCxmOMyTR0j2xfvFQm41UIsV
         /zQ5HRndh4n1skOAIhieGftpudiivOBf29/+clLKJwoeYsAssT3KAHs2s6CeSP0brBS7
         bSnvAwvVMf6XoEe2GSb2VWVwLRKathZG9urWZjM3VEUp4K/26UDnQevZAmIZ2B5c3Cha
         is8g==
X-Gm-Message-State: AOJu0Ywhx518x3uomTayVcu/D6SKaH3tjF+RKopKN3zT041y+PeJSxmN
	HCsVSENHKEmLGKqUXofXuRI0FEXSraAtqh6HDkodNNceYMPvNV6jra+8609hgA==
X-Google-Smtp-Source: AGHT+IHFC2/WVtgDC+uBoq6F83l3zP3byj0A+mlwYj5lGRgf/3BKcT6O6lauE09rqPWca4a5slhjrw==
X-Received: by 2002:a17:90a:9b07:b0:2da:6e46:ad48 with SMTP id 98e67ed59e1d1-2db9fc19c32mr465184a91.1.1726080641968;
        Wed, 11 Sep 2024 11:50:41 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db043c59c9sm8903996a91.24.2024.09.11.11.50.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2024 11:50:39 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Saravanan Vajravel <saravanan.vajravel@broadcom.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH 2/4] RDMA/bnxt_re: Fix incorrect AVID type in WQE structure
Date: Wed, 11 Sep 2024 11:29:37 -0700
Message-Id: <1726079379-19272-3-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1726079379-19272-1-git-send-email-selvin.xavier@broadcom.com>
References: <1726079379-19272-1-git-send-email-selvin.xavier@broadcom.com>
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


