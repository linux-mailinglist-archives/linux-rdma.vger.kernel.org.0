Return-Path: <linux-rdma+bounces-5999-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6579CDB1A
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Nov 2024 10:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 360D81F2275A
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Nov 2024 09:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512BC18C924;
	Fri, 15 Nov 2024 09:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SQ+vTZ85"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1972018A921
	for <linux-rdma@vger.kernel.org>; Fri, 15 Nov 2024 09:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731661719; cv=none; b=mA57CtihXN8fJeff+QsUT0qnEsAz0VuEEmItamMjr9ZmJYdeRnqsk1H26dJtP5dA0qfKTLDlAoKepaOHZh3i43xIkv03jQewaX32D8+HuutHHuQIwETY/OCfyVJVzH+gTUn84DnVvASJ2L1xUVTSYdbNpsTIFcN/c65ANO4f0no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731661719; c=relaxed/simple;
	bh=1E4Npxr/tCCfKchje+vXHKVdPoyh5tkpa/IeXb4tFGQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=o9jD3+Xs+TTDiwozlbMBH9SDf0b5PcuFEj791tGM51T0K6okF9KHsO7m9UJGt2bVltebAl4dpyl0sX4ylwYJW/NckCSMDezCM0FiUZvEFDXQ0XxwgPBlZJiWNj+rT04GfKYJM7vFqvILnjRA9xz3WhtPUVRfGyGraT9GgTIQqkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SQ+vTZ85; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71e49ad46b1so1232153b3a.1
        for <linux-rdma@vger.kernel.org>; Fri, 15 Nov 2024 01:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731661716; x=1732266516; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=23uSOGq4VRiGNcux5BW7xUZZAjH/eVPIOTZBgGxxPk8=;
        b=SQ+vTZ85dog336MYUYXg2zsg+0JH4FUSK31SAi05YildItoLHD6gYeCSG6XJWByLU+
         DBqD6J9trBDio9I0SY0DNyFMyyzGOxVfUBvmLflvBY61xRexRIb2E3Iwrx1yZODD5vq+
         O3WVxYG2dgyFbrxTH4y5Y9hlNjVb3+Fc9CRGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731661716; x=1732266516;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=23uSOGq4VRiGNcux5BW7xUZZAjH/eVPIOTZBgGxxPk8=;
        b=mwL5YJ/4F7kmk+F+CiPAbfnsUODDgIO4ewS/ZuKCScoJs02IssgpvFDVy1RmDBfDnF
         q3MdqshHG+umbUi37RIyz9gJr4gpDW6aTKY40pr872G8/JRvZumpUVZSzg2qFZeqghUU
         cqYOad/WdPIf5F23AGTSUB9jr4mbrN4tbVEp4375pjaMPzXVKA1EXwPr9L9NVEBgAlPc
         uSc3KcPQF/jwXXzCLKVathiQNVq5P4H500qXc9G3zv14g5yxUUsGJpPi1gbfIrpYEDBp
         X+akWQmUs4Gp02Q6oaFwJq4c2qrZNWZpujY9BfHWL55eHIVRSjcMH9RE5H+GWHd/ZMpF
         hE1Q==
X-Gm-Message-State: AOJu0YyjeWc/S6X0iOb1T11d+GP6Q2Af5qCIjsMEYVfam8LelTlxO1GP
	dImUFRuWrfth0ietD7LJ5gax9IDoKaeUWVX57rTKZJH2GrgRykdMQ7ddQRkGMQ==
X-Google-Smtp-Source: AGHT+IGi9+TIoLJwXUQ7W89ohz1IOKUMOw/U71Sthro7CxppLGLX+VuEyAZ4xq8cEVyhEyr2CTEOTw==
X-Received: by 2002:a05:6a00:4b54:b0:71e:7046:c0f8 with SMTP id d2e1a72fcca58-72476f7c766mr2179185b3a.26.1731661716322;
        Fri, 15 Nov 2024 01:08:36 -0800 (PST)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7247711de6fsm927926b3a.61.2024.11.15.01.08.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2024 01:08:35 -0800 (PST)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-next 2/3] RDMA/bnxt_re: Use the default mode of congestion control
Date: Fri, 15 Nov 2024 00:47:43 -0800
Message-Id: <1731660464-27838-3-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1731660464-27838-1-git-send-email-selvin.xavier@broadcom.com>
References: <1731660464-27838-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

Instead of driver setting the congestion mode, use
the default values setup by Firmware. Enable the tos_ecn
field in FW.

Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/main.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 533b9f1..ac475a5 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -2204,11 +2204,10 @@ static void bnxt_re_setup_cc(struct bnxt_re_dev *rdev, bool enable)
 
 	if (enable) {
 		cc_param.enable  = 1;
-		cc_param.cc_mode = CMDQ_MODIFY_ROCE_CC_CC_MODE_PROBABILISTIC_CC_MODE;
+		cc_param.tos_ecn = 1;
 	}
 
-	cc_param.mask = (CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_CC_MODE |
-			 CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_ENABLE_CC |
+	cc_param.mask = (CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_ENABLE_CC |
 			 CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_TOS_ECN);
 
 	if (bnxt_qplib_modify_cc(&rdev->qplib_res, &cc_param))
-- 
2.5.5


