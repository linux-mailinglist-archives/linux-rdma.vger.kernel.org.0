Return-Path: <linux-rdma+bounces-10614-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D195AC1DFC
	for <lists+linux-rdma@lfdr.de>; Fri, 23 May 2025 09:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D4CF4E6E35
	for <lists+linux-rdma@lfdr.de>; Fri, 23 May 2025 07:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BF4283FFF;
	Fri, 23 May 2025 07:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VUt/viWq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D957E28369A
	for <linux-rdma@vger.kernel.org>; Fri, 23 May 2025 07:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747986972; cv=none; b=MkBXrVjpdLeRHibPyEQmOZzCwlg3tKa7M9zhOCUv5CXX+FpYLfdIDW81vaDa1HOzsDzmMVloJSjgLS4Cl9heJ6L47M+ito/Lm5/54Li+Ur7DNigI5aXE6jwJuld/q5M06wFquIRWPUPE6jLWh2xyM9aoiXpu1LR5yJr7Cyz1IUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747986972; c=relaxed/simple;
	bh=7QxLXXSi4J+6LqhmdgNWCUSKmK2TUYYuIQW2dBKNV2E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MLx++2+7NJ2B9+H3nfcM4bNkHkbNXCFiqDbFdtcHpeCyphxPWVRv5lzy1iAiacffMxOSk7+HzHPlzZNQ1VUNXPmK/6dNe1B8Pn7tTxVQZXqqqmMY8xA8StSt6E873y9g2GtFu49C3tbluvXo8REopiaPqXd7Bl3Uu11hn5qNyA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VUt/viWq; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-742c27df0daso5132236b3a.1
        for <linux-rdma@vger.kernel.org>; Fri, 23 May 2025 00:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1747986970; x=1748591770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9PbALlad7WlshTl5Oh7LNHoXkN3oay+6Jm4czDjCAzk=;
        b=VUt/viWqQNk/XCXtxNW9yjhaRhYLQCNy9QVeSZD0rmf92OOcqFyJ/gKcAKogNKLsNc
         /Vl1xOMdUoK8TQsQ0I52FTPP2l26rPZzztSPl64FcESe5IgO5JjtiYa7Ru31O11YOdLz
         nATWmzndXYBZ4Vg6Lcoo7es2WjaKyS5Lh4xsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747986970; x=1748591770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9PbALlad7WlshTl5Oh7LNHoXkN3oay+6Jm4czDjCAzk=;
        b=XgDZA4GQlHQDuFEVe8vdGcA+DGU/q2uilWDs2654ZNpahR2MIfH8qGf4b+7mKfgbMf
         f9zV+lsDRT6XD+mCONsgVVZvKbLPxXUtbY/G+qYcJ0wgZ+id+qv1mMXYpllQnEMb7R/u
         Ut2gMzVfRdvlUwCDO9L/L0YxP1PrSeIy2ZtXJTPXr2/+2rHC/GSSeGzU4WDHypDTM/tQ
         Q7HBV+Qzy3w24cW7pn6UzV2oYItZVtwY1K+sYuFnGcJ3x08sQL+tKpyl/P39nibXny3n
         TR9k4dCkeiR/xAnihmSBCRrcxAEGgZkIVlq7tYcXSlsYOEiKp2I+crjdmyW48cbatZNc
         4u7Q==
X-Gm-Message-State: AOJu0YyHVrCUUb6esiJLsPXTe/pbGNOCJIvQeGO3Lx/fx4KGTi4T60DB
	u5l7GRPbhx74HaTn/+SoB0WH6CnW/KNnt77nh+FkfIjjwC9NsuANK/twlZrqGtgVFg==
X-Gm-Gg: ASbGncuykqVNUlWpXtW0VQ0QnlsAKHTs2xZPQz4eGs/dW+C7PbLrqd3Qo2OW4IxLatG
	TNhpfSDqMI6AkluG820pOlA0Y/jG7iLApa7QR3dKyBIN4D9t3cwtnXiOL/cGVs4JSSt44Ok5T1r
	tfQpLnTGmD9IZas4qYZxO8LDHGM6C4o+QzX4HHp7J/i+UQQ0lmc948kTSAd1pUHvfOO3QA+Zyly
	Rqc7S/OJM3maLzyITtL1kmOXxqscIcFSbAZkZ9cSUFXLf3weAsXk9z2M6VpWrD4rBAloOGiS14Y
	vK/v1LXOjuy3yLf6kW3UZhyRNGTvitt2h+N1rQf9s7DVIO3IOywwYCvEYDQi1xi68IYW6fjWpri
	YS0GCaHb8oWRU5tCjf39J3nv6t6oQFHEM251I59eVqDvjgJdamLHQ1Up9Z3BfppVZ
X-Google-Smtp-Source: AGHT+IGeJ871k90oG+1kqNQVS3O+azkulYj+kJvWjdMFkrOXMofVWekSnKtXuYAP/rvTt26DSxeLOg==
X-Received: by 2002:a05:6a21:3993:b0:1f5:56fe:b437 with SMTP id adf61e73a8af0-216219b13demr50527544637.32.1747986970022;
        Fri, 23 May 2025 00:56:10 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a96e2765sm12752624b3a.19.2025.05.23.00.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 00:56:09 -0700 (PDT)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Ajit Khaparde <ajit.khaparde@broadcom.com>,
	Shravya KN <shravya.k-n@broadcom.com>,
	Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH rdma-next] RDMA/bnxt_re: Support extended stats for Thor2 VF
Date: Fri, 23 May 2025 13:29:52 +0530
Message-ID: <20250523075952.1267827-1-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ajit Khaparde <ajit.khaparde@broadcom.com>

The driver currently checks if the user is querying VF RoCE statistics.
It will not send the query_roce_stats_ext HWRM command if it is for a
VF. But Thor2 VF can support extended statistics.
Allow query of extended stats for Thor2 VFs.

Signed-off-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Signed-off-by: Shravya KN <shravya.k-n@broadcom.com>
Reviewed-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_fp.c | 2 +-
 drivers/infiniband/hw/bnxt_re/qplib_sp.c | 7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index 457eecb99f96..be34c605d516 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -1113,7 +1113,7 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 		qp_flags |= CMDQ_CREATE_QP_QP_FLAGS_FORCE_COMPLETION;
 	if (qp->wqe_mode == BNXT_QPLIB_WQE_MODE_VARIABLE)
 		qp_flags |= CMDQ_CREATE_QP_QP_FLAGS_VARIABLE_SIZED_WQE_ENABLED;
-	if (_is_ext_stats_supported(res->dattr->dev_cap_flags) && !res->is_vf)
+	if (bnxt_ext_stats_supported(res->cctx, res->dattr->dev_cap_flags, res->is_vf))
 		qp_flags |= CMDQ_CREATE_QP_QP_FLAGS_EXT_STATS_ENABLED;
 
 	req.qp_flags = cpu_to_le32(qp_flags);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
index f231e886ad9d..9efd32a3dc55 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -846,7 +846,12 @@ int bnxt_qplib_qext_stat(struct bnxt_qplib_rcfw *rcfw, u32 fid,
 
 	req.resp_size = sbuf.size / BNXT_QPLIB_CMDQE_UNITS;
 	req.resp_addr = cpu_to_le64(sbuf.dma_addr);
-	req.function_id = cpu_to_le32(fid);
+	if (bnxt_qplib_is_chip_gen_p7(rcfw->res->cctx) && rcfw->res->is_vf)
+		req.function_id =
+			cpu_to_le32(CMDQ_QUERY_ROCE_STATS_EXT_VF_VALID |
+				    (fid << CMDQ_QUERY_ROCE_STATS_EXT_VF_NUM_SFT));
+	else
+		req.function_id = cpu_to_le32(fid);
 	req.flags = cpu_to_le16(CMDQ_QUERY_ROCE_STATS_EXT_FLAGS_FUNCTION_ID);
 
 	bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, &sbuf, sizeof(req),
-- 
2.43.5


