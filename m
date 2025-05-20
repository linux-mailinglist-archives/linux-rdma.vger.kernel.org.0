Return-Path: <linux-rdma+bounces-10430-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4D2ABCE02
	for <lists+linux-rdma@lfdr.de>; Tue, 20 May 2025 05:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28E6816D8D2
	for <lists+linux-rdma@lfdr.de>; Tue, 20 May 2025 03:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C292586EE;
	Tue, 20 May 2025 03:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PLhOdi2u"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C932238152
	for <linux-rdma@vger.kernel.org>; Tue, 20 May 2025 03:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747713313; cv=none; b=UPNHn3LTmQjaFD2fX99Rpt6cjoI6C9y2D2KyX/KllDhLEI4miK/k7W6sSWJOH0rz7BL2jsROrpM7rDJRslOr+u1aZOcXrSkeriUxrDZTVeYTfeyUt+mrjFWgarxPtYuJoGc88eWTYmYzlEJ1E+6MjO603EVNnUvQoTNOD2r9F4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747713313; c=relaxed/simple;
	bh=7pPdRfrDAFnn0NhAXskvYq5oerVhy/9s4y5eFh1bsNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EI1Dqond/WZ8Aii0kDA4JReF3/QZXeG4TbzoZivU8y3Z9NIs4d5d8bX5ZTwaZE5JKd941vT/5dtLzYdqZFnLFEgpCEuM5rrQhnNFvflRnIpU9sOZe/dc5j/LbvDK1RqIvBDeQrhPllo4WeciQuecZOLc1XBnlpplKFSUJIcb04g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PLhOdi2u; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-73712952e1cso4868646b3a.1
        for <linux-rdma@vger.kernel.org>; Mon, 19 May 2025 20:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1747713311; x=1748318111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWx7N26JgRF7A7u5+V3tfmCLqQqoWzo+ZlRdwUZIAjw=;
        b=PLhOdi2u4qjWWaXcqRamV4e2EaHvC9C0tE3AAh+IbYt/mk5/udNAl/FUcdG1FtnP4W
         yqZi8/JOKKf+d9u0gyq2V49pIHYXlWFOkEA5Th/d5hEaxtd3qcT+8JxFLKFaEHjf6jlF
         kHqVTh3tu8B5tbBST6LGl0fJuF+v19TV9DcSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747713311; x=1748318111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fWx7N26JgRF7A7u5+V3tfmCLqQqoWzo+ZlRdwUZIAjw=;
        b=JQykQShpxtBMRleHvMHFpWmfMmNZWbHAlZmlJaAlthYNnkhG6IElm9JtIWCeQuoLFu
         BorTaN7RjowvBCLuct+lNiXxtojKjShOr/l+CA9S3eB5kOqWnHOBY41u2bZRT/2LXGaI
         eMP1U988V1a6DiSD7rd8sokRJAqmQGRw1aezsIeFoDf+tcB4WXaaSzGTn3fshvDhYGhK
         Xyojt4UcDmBmn/dHupgbvHhF+7WbV6pXtw263/Cwwva+YbvQArRnEbxg5lYUS0bAm7eD
         0D7XXHZwq4HRL0a4Do7a/NaPUe4JNpmN0LWNI8S6MwlXMeTk333VA7pLbvy+jhCNK5WH
         LsPA==
X-Gm-Message-State: AOJu0YzD4UA3/KIzWRajXLUae7JTBFxWepMSqAgNn4qD4ZpPYv8zNRh9
	tbjUjyyEJzWDiQgt/ca62tIzPaEEPTpSjJOkQu22+lbsy5Q5ugYuRFOCCMh6qh6hSA==
X-Gm-Gg: ASbGncscj8fPjm2P234LiPEbuxzfuEpmBbgZv5LZU5G8zLQd3zovJS3Z4l7/bxDAUVR
	zWZUWIIf/8AFrEoiIF79bPLQ583HAbrOF38Qik184384DYHQpd0sng8SA3ZtgSc11iJdFbaODHj
	4MpXzHLMuLxVwSQi/sWmcalcPdf56ucnXuLaUjgyVFfwNW5xVAkmfmdmpHabV/rtW1idiNOyzr6
	/O023AxPigQBdyN4H9STYOoCQGNIeZYnwJS6/S6XYJZmQ2cJfuPk6rCn3xJiV5Z5W48DPQ/0O19
	8cz3VtepRN0wcdmjqtSVZ5MIF20zIrvOQQ6R9YXMk+clCXZs3kSMA0p25TUjNnq5TOQmHMApm4e
	Qdd+aW9I3Py0qmNcUZv0LQGUQXkRtsyIRh67/JxtSl+2xqwtiyvPPAA==
X-Google-Smtp-Source: AGHT+IHtJN0JumZwSuE1fbcWCpzj2uMA2rMojRB3ct/OJpLIU9wDqWYFceCnx91n9JrGRik9SmEgKw==
X-Received: by 2002:a05:6300:2189:b0:201:8a13:f224 with SMTP id adf61e73a8af0-2170ccc0f52mr22966209637.22.1747713311385;
        Mon, 19 May 2025 20:55:11 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9877063sm6984179b3a.153.2025.05.19.20.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 20:55:11 -0700 (PDT)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Gautam R A <gautam-r.a@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH rdma-rc 2/4] RDMA/bnxt_re: Fix missing error handling for tx_queue
Date: Tue, 20 May 2025 09:29:08 +0530
Message-ID: <20250520035910.1061918-3-kalesh-anakkur.purayil@broadcom.com>
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

bnxt_re_fill_gen0_ext0() did not return an error when
attempting to modify CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_TX_QUEUE,
leading to silent failures.

Fixed this by returning -EOPNOTSUPP for tx_queue modifications and
ensuring proper error propagation in bnxt_re_configure_cc().

Fixes: 656dff55da19 ("RDMA/bnxt_re: Congestion control settings using debugfs hook")
Signed-off-by: Gautam R A <gautam-r.a@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/debugfs.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/debugfs.c b/drivers/infiniband/hw/bnxt_re/debugfs.c
index a3aad6c3dbec..bd5343406876 100644
--- a/drivers/infiniband/hw/bnxt_re/debugfs.c
+++ b/drivers/infiniband/hw/bnxt_re/debugfs.c
@@ -206,7 +206,7 @@ static ssize_t bnxt_re_cc_config_get(struct file *filp, char __user *buffer,
 	return simple_read_from_buffer(buffer, usr_buf_len, ppos, (u8 *)(buf), rc);
 }
 
-static void bnxt_re_fill_gen0_ext0(struct bnxt_qplib_cc_param *ccparam, u32 offset, u32 val)
+static int bnxt_re_fill_gen0_ext0(struct bnxt_qplib_cc_param *ccparam, u32 offset, u32 val)
 {
 	u32 modify_mask;
 
@@ -250,7 +250,7 @@ static void bnxt_re_fill_gen0_ext0(struct bnxt_qplib_cc_param *ccparam, u32 offs
 		ccparam->tcp_cp = val;
 		break;
 	case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_TX_QUEUE:
-		break;
+		return -EOPNOTSUPP;
 	case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_INACTIVITY_CP:
 		ccparam->inact_th = val;
 		break;
@@ -263,17 +263,22 @@ static void bnxt_re_fill_gen0_ext0(struct bnxt_qplib_cc_param *ccparam, u32 offs
 	}
 
 	ccparam->mask = modify_mask;
+	return 0;
 }
 
 static int bnxt_re_configure_cc(struct bnxt_re_dev *rdev, u32 gen_ext, u32 offset, u32 val)
 {
 	struct bnxt_qplib_cc_param ccparam = { };
+	int rc;
 
 	/* Supporting only Gen 0 now */
-	if (gen_ext == CC_CONFIG_GEN0_EXT0)
-		bnxt_re_fill_gen0_ext0(&ccparam, offset, val);
-	else
+	if (gen_ext == CC_CONFIG_GEN0_EXT0) {
+		rc = bnxt_re_fill_gen0_ext0(&ccparam, offset, val);
+		if (rc)
+			return rc;
+	} else {
 		return -EINVAL;
+	}
 
 	bnxt_qplib_modify_cc(&rdev->qplib_res, &ccparam);
 	return 0;
-- 
2.43.5


