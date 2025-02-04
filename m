Return-Path: <linux-rdma+bounces-7394-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2599FA26E43
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2025 10:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C70B61666B6
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2025 09:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01ECA207DE8;
	Tue,  4 Feb 2025 09:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ap59NJaF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23D1207A1D
	for <linux-rdma@vger.kernel.org>; Tue,  4 Feb 2025 09:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738661216; cv=none; b=k13svvksa7wJPXmuHGu6IDtiek6DWT4mZ2MBdPkhtd+hrAPEMnv4E/oEXfneno3Mp+THvAKug8S1RhqJ7skxM31bdjrUv8coLku5U8THBaLTJPdIhNWFDRuYxdf8qding7hB3s22pxmD+alHHo+sItKKmfIyGnpwIGv41z9t9RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738661216; c=relaxed/simple;
	bh=4vKMMrFsdXm0idFSPVYbYZbSyCTAoide7ejR3fJ8WTQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=UperoVCv/xHTK/b4ezU/HeS2sTOxLgroI+jdZCMPrVyi6zezmzrpOUx7pzlhNEoUn4VQvhRFHhBanwtEtuDs6DCUV3/9Qho81Lx5o3yhw7BVkdSnV/CuerkaJKq12fj0VE84TdFy2o2YyWZunF9kDXrJz4oOmsxHKWF52M5H7Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ap59NJaF; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2aa17010cbcso2056292fac.3
        for <linux-rdma@vger.kernel.org>; Tue, 04 Feb 2025 01:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1738661214; x=1739266014; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EwqxsDuT+F6TxjpPVMUt5abBCas35Hg0/oCZjbp7P9c=;
        b=ap59NJaFLAbFbvFuB661IAoWxS8mCWyNG9HDQAKICNKDTBsoir99XEVgByq0o6D2fP
         FoPtDWR2kAv3FYRZMebTqDKB0YYU5ysdYLNNNtiJzr2oJLBsXp0BiWJcWfrns1VtIwGr
         kSw4ZQ2seI0jeACc+mGMSQoOx10IAqrf5Cy8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738661214; x=1739266014;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EwqxsDuT+F6TxjpPVMUt5abBCas35Hg0/oCZjbp7P9c=;
        b=biAyBYGNfrHSCKTGFHl/qLlt1krtFBRDYomfttd50eEjjy9hm9ZEP3OOBV6HoMhIua
         h0niwiRidEhTDVzBwoqkfeLmSfRUFqsolUH5qv25FceuDs2T5kOCLG3oSFG+T3T1V4O9
         9Sj09zI+WEVolyt+J6cfqKl1AZFxQPuRXZK1outUI+L7z4cC1T+5rzDMso8NeeXyTary
         Vmj2/BpdoviezlbPjI1X64Re5u0lYlFDHnwE7MQX43pIoqDWeEb6rctzqTtlwkxdy/d+
         oSitn6slqRchmAgreHcF9vtUyJAh/38IGFLds8jumObsgQH3258g6i7O8XOK+LU0LZAz
         67KA==
X-Gm-Message-State: AOJu0YyFrDdTtAJhnVhNFxGaEX1Zh5BMZq0VJ6yPlIeqEdY4t2C0ZVuY
	gi5lKNuzZKgArQbUk0PTvSWpDY1AKruZLVbNpQovaw1MUxQ6k5FIupQQ1OvoggLXTYU1JH/L2MZ
	TXQ==
X-Gm-Gg: ASbGncvdPIN0WqhmUgGVOB0634jrQBZ2cui5yHIXlSsDmh/rK/TRQs15Aj7S9QLZLcT
	3/O3fJP2/xFYF23wgxDg5N3NNyi9yVeVhB6NxrqJn4e4MPIMI+OamgxqU+IAV7zF9DKRodo89/2
	fXs55XAnxDajAit4aLeMQYcCa0w66C2eVCCu93u1W35Cfw2QEbMc2P5y0YecNebLEREDpdd+4qc
	S+3UGGshhLTnMCXN2XUPxDTZE+HoU0UzA+uwaOPoEKd6ISONsYjIt+B8p2Dv+bAdIbWqyjchPfZ
	oPOdTCWl1IDyZmoKuFNo7Uqxb1r5B6afmJVmegne5jgm4fpaKDI/iaMAeMSL1iKo14d3odA=
X-Google-Smtp-Source: AGHT+IG3AXQQGuMTAfMijWnrKWIHv4OdZwSXkRqW7mS+XNseQpnCvKDbOEJ4SPPBEbLJ3szZ34vitg==
X-Received: by 2002:a05:6871:64cc:b0:29e:5dfd:1e17 with SMTP id 586e51a60fabf-2b32f089891mr13827738fac.23.1738661213873;
        Tue, 04 Feb 2025 01:26:53 -0800 (PST)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b3565b8120sm3901572fac.34.2025.02.04.01.26.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Feb 2025 01:26:53 -0800 (PST)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-next] RDMA/bnxt_re: Fix the error due to the array depth
Date: Tue,  4 Feb 2025 01:06:06 -0800
Message-Id: <1738659966-26557-1-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

Fixing the issue reported by kernel test robot

drivers/infiniband/hw/bnxt_re/debugfs.h:34:40: error: variably modified 'gen0_parms' at file scope

Using the fixed size depth for the array.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202502041114.K8XQYeJg-lkp@intel.com/
Fixes: a3c71713d954 ("RDMA/bnxt_re: Congestion control settings using debugfs hook")
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/debugfs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/debugfs.h b/drivers/infiniband/hw/bnxt_re/debugfs.h
index 3374097..8f101df 100644
--- a/drivers/infiniband/hw/bnxt_re/debugfs.h
+++ b/drivers/infiniband/hw/bnxt_re/debugfs.h
@@ -21,7 +21,7 @@ void bnxt_re_unregister_debugfs(void);
 #define CC_CONFIG_GEN_EXT(x, y)	(((x) << 16) | (y))
 #define CC_CONFIG_GEN0_EXT0  CC_CONFIG_GEN_EXT(0, 0)
 
-#define BNXT_RE_CC_PARAM_GEN0	__ffs(CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_INACTIVITY_CP)
+#define BNXT_RE_CC_PARAM_GEN0  14
 
 struct bnxt_re_cc_param {
 	struct bnxt_re_dev *rdev;
@@ -31,6 +31,6 @@ struct bnxt_re_cc_param {
 };
 
 struct bnxt_re_dbg_cc_config_params {
-	struct bnxt_re_cc_param        gen0_parms[BNXT_RE_CC_PARAM_GEN0];
+	struct bnxt_re_cc_param	gen0_parms[BNXT_RE_CC_PARAM_GEN0];
 };
 #endif
-- 
2.5.5


