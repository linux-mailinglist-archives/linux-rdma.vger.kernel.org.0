Return-Path: <linux-rdma+bounces-10429-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 765AFABCE01
	for <lists+linux-rdma@lfdr.de>; Tue, 20 May 2025 05:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34B5F7AE91A
	for <lists+linux-rdma@lfdr.de>; Tue, 20 May 2025 03:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A866258CD6;
	Tue, 20 May 2025 03:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IQGXMzm/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9288C238152
	for <linux-rdma@vger.kernel.org>; Tue, 20 May 2025 03:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747713311; cv=none; b=hSkN740JeIphQ2FQdovN80qwpaGmqdA+hp97RBGVjjgfMerCENLaxKVummtZSFlllEZC1h2Hzjc2jgh2KLuywElpJmsNVQw04ywtRzY0XgyLHmrEU0R/2zMHI64heeH3wv+2cd0qvAZcmimtXv3d5alFqazUIeTsDyAUjIvqf54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747713311; c=relaxed/simple;
	bh=F5moSPUaw1YBjvk0alTSvW/BiGqE69aKWYO0FepagWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SXFBwlmNpgLDO5ilc2Utf4w3Zy0SAiUj70Fb/GDG0VeCH9jOpTUWu1ZFdII+ZNzTdk6+ORMwL29/A7Chkzf6b32VvEZ4abujqB2TQkOr1MAy+qPZH1JgLDvdLtUMOomDU7dJ6LEPwPaaMfuLCUeNcmVSMHUOJpkwU51LUm+WuZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IQGXMzm/; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-74068f95d9fso4656691b3a.0
        for <linux-rdma@vger.kernel.org>; Mon, 19 May 2025 20:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1747713309; x=1748318109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XWnCXcpgU/jDi8miTfFPhyMxFMjysGdOVamD1nUqzHg=;
        b=IQGXMzm/dEc+vKUnG/gY+twW/0eRL2XRvJPod6TFP0n7/d0YF4lt0aWCLj3tu0Y/YJ
         26xMiPm1OqrLQ5AUcCkhZl/cYJufZtWqdHfr5OQGjLfv4Pdu+tnnYGy1P93HEQWurUyY
         FNSlbQUaRbA8VyR4Z45MF5eeznZIF0n12COKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747713309; x=1748318109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XWnCXcpgU/jDi8miTfFPhyMxFMjysGdOVamD1nUqzHg=;
        b=vjcZHGZG7N2uqwwBB6Jp3x3WialbeAD+g93jaTIlOeEOyxzbeo76Rl5k9JkK/aE+8y
         VtusNHNcgXwJz/wfpZbFOhxeDCJx+kH3W3TCNRJ+eZHv9LGaPY9tZoEuY8RL9ga4ugYW
         GmizR8ndac27hm7rACC6+TRffdpBRAVUS/7Nojcvaj2Z4jrrf0HahArNfJIFDOn5KB3I
         qwfv9lV+uV4yS2Qc15v/qvwoOImtTYO9C4kMbG5zcViKfYTYML8pMRX0xwuVbHCZL4X9
         LfP+Jt29N55IAt5wb21SSK2ai0degFGcpa77lTIDsCSALfCd5vj8aZrtL/7GzZEEz4iQ
         dDuA==
X-Gm-Message-State: AOJu0YxJxvbzpV2yG4rF33AwguO/gYEUv++WkRHF/p6xyUfrK+5Z5rcu
	kOb1uaMSUG3K69xCI0iU7nK6V1ED/f/SJNZZ5vvK6Zcrvkq+O7KIsHtBIy6U30iwrA==
X-Gm-Gg: ASbGncul4d3ygl2AWDRvAMHqVX2NkoS7SKt3ob/p08JmfKm2zr53FnB/Pwkj5+OYzcE
	CUWTvgV4/JFimmpYn+yC8sU+D6lBzotOlaHA08BGzRK5fb0BOrOPZ0YXRr6FDJBLEjcD3KRf/DI
	sAAnGzVI/YR7/Cc3lM47IP+oAfrlu39hWzUF3G4rc2zvM8PIJmPURfkomeIDRtA8S/m4hxLm3W5
	fwdXOW4RO+OAUMGS+fO9RLIoBbNtHx/I2QmQPXMjeZODckN0FkyHed7HIYRrQ4wE7SjwzOigysx
	Z/JopfH3VvoFiONDuzZVXXSpzjuAtf0uOyADwt4nGT9ZPmIU4eGSrD5gIGaKoJlUTvM5js5AjYi
	dkUvK/xlCHQLCcTN6VzqSv8JSjqpPX2Nok00yzl9CT4PVX/p9xCso8b9cbv2/Gw3E
X-Google-Smtp-Source: AGHT+IHg+QAxyC5aE/mP+BkXvXhDLVMmEXDkgB5jWmTKQ4KnFndt0hYakBwi11uqyq2YSlWUgtTXZQ==
X-Received: by 2002:a05:6a20:1591:b0:204:695f:47e1 with SMTP id adf61e73a8af0-2170ccc0efdmr21749474637.23.1747713308874;
        Mon, 19 May 2025 20:55:08 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9877063sm6984179b3a.153.2025.05.19.20.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 20:55:08 -0700 (PDT)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Gautam R A <gautam-r.a@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH rdma-rc 1/4] RDMA/bnxt_re: Fix incorrect display of inactivity_cp in debugfs output
Date: Tue, 20 May 2025 09:29:07 +0530
Message-ID: <20250520035910.1061918-2-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250520035910.1061918-1-kalesh-anakkur.purayil@broadcom.com>
References: <20250520035910.1061918-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gautam R A <gautam-r.a@broadcom.com>

The inactivity_cp parameter in debugfs was not being read or
written correctly, resulting in "Invalid argument" errors.

Fixed this by ensuring proper mapping of inactivity_cp in
both the map_cc_config_offset_gen0_ext0 and
bnxt_re_fill_gen0_ext0() functions.

Fixes: 656dff55da19 ("RDMA/bnxt_re: Congestion control settings using debugfs hook")
Signed-off-by: Gautam R A <gautam-r.a@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/debugfs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/debugfs.c b/drivers/infiniband/hw/bnxt_re/debugfs.c
index af91d16c3c77..a3aad6c3dbec 100644
--- a/drivers/infiniband/hw/bnxt_re/debugfs.c
+++ b/drivers/infiniband/hw/bnxt_re/debugfs.c
@@ -170,6 +170,9 @@ static int map_cc_config_offset_gen0_ext0(u32 offset, struct bnxt_qplib_cc_param
 	case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_TCP_CP:
 		*val =  ccparam->tcp_cp;
 		break;
+	case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_INACTIVITY_CP:
+		*val = ccparam->inact_th;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -247,7 +250,9 @@ static void bnxt_re_fill_gen0_ext0(struct bnxt_qplib_cc_param *ccparam, u32 offs
 		ccparam->tcp_cp = val;
 		break;
 	case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_TX_QUEUE:
+		break;
 	case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_INACTIVITY_CP:
+		ccparam->inact_th = val;
 		break;
 	case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_TIME_PER_PHASE:
 		ccparam->time_pph = val;
-- 
2.43.5


