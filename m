Return-Path: <linux-rdma+bounces-6572-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D72D89F48EF
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Dec 2024 11:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C21B5189113A
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Dec 2024 10:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7991DE8AB;
	Tue, 17 Dec 2024 10:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="enNiTm1w"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F7D1D5CFD
	for <linux-rdma@vger.kernel.org>; Tue, 17 Dec 2024 10:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734431536; cv=none; b=buGqbHFYRmfSvwCFa3B2EWzWKxz5djN1AHT/xR25OWo80bSM/8siNGv79eg0/0vaMNQf/jq/q2AbF3yZ/0jEkVctOI4SEWMjgKYpFMwI60mhYkG3qVXazvnK3QfikQvA+ccGRAUDbqk4LLC1st3ROAsn4w+wQtKn3G7d2KYQYCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734431536; c=relaxed/simple;
	bh=KRWuV+7E/3KybVq5XW1jobusOoz2pUyaX+cePKeSY9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N/6UmN/1Ru1iG6i48i+Tcy7RLz4Wjx/aW2TToLnm7kQMeLipm7Jof3xRYgak7vyLOliY1dUxenugw5wbYeEpaaNZ9gqesCaaA1AW/6gnz/PpPOc9ZfEySTTyzUOMJTVDIJMnhSJIXPFU33zhiZ7IcT9giwnH6XIzqk9eFU4421s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=enNiTm1w; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-801c8164ef9so2704029a12.1
        for <linux-rdma@vger.kernel.org>; Tue, 17 Dec 2024 02:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1734431534; x=1735036334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jOkf+XviTiiQRaR+pwjwyVk5ZQwIRP0N3RQkTVTzEhs=;
        b=enNiTm1wDtoiSdGOmWLhLFfVtBKjBgTgCYh6N8fKXOTmnaNgqbN0VipG1mO3RtlR9E
         K/xZ2H5Y1ewhYZBpw3HcS4EqHK/GBG1FpxhJUF5w2Hi0cdzTp0ZeENKpCt0QwHsNlcR5
         4YKiVrLi0PFAZep0/edtgK8gdjtSdAdoANIuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734431534; x=1735036334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jOkf+XviTiiQRaR+pwjwyVk5ZQwIRP0N3RQkTVTzEhs=;
        b=sp+1AjzE5eL8J1ypbeKUJaxb/qzjTnuZGvgXwf0PnXwssQcMp1wkJZyxsNZ0iHBGb1
         CzsMQkxCHOGvGqiYU3K/X+XoHuqdoBx9EdDujkJa2EgfEMshTTE3NIlJ0SYokP9Acv/Y
         tiv2XYFWMSKQsLB7TfiLyvcU0fjSmFbtTyzqM3DQBmnoLMhX6rPsxGru1imxZUBBk0fv
         ff3x4GvH4hMZPbSQ8hRxCDan9EgIzN4yuR8xXQKrxSu7DoiM5hWWBSb6crDjfsugutyx
         ODUPi1GaTWpgYxmw5KOZK41bW74qVStokr98dFH4MeNdI6JlHlJfqn2s5vj/kBpVzvsm
         Q+jQ==
X-Gm-Message-State: AOJu0YwSrp9HYLBG0bJ7ZvQora0ngPvRRGdWoFfJ0o9rgyKt3SxgJLE3
	L3XlM3cmfk3dF6VLnveEdGAPrt+zSDB3df0hqKesFKADtLUxPAMnYbDsToGZAQ==
X-Gm-Gg: ASbGncuBUegIR9GrsBWaty4HYKWpFLu/5IUz1mmqvjlf9wzuVnbNRZt9tKjjnt6F5VT
	YefiPa51LhF9nBjF7qH20AELYdXjMB1V/GjqkyOqNgwlkJMKhepEn6Z8OndPkuZ32WkGQP+1272
	PCnE+UlgYJ/98AcF9yVo1RZ57z9Przmc56maC4iqk697uFGAKRvw8H/8zPqxuVhKaE81Kwp9Cad
	EkPrZ01ZVEj/2uqoFjZ8RQZ6/ga7Y0O948ywQargUfgtyhXKN1jqzZVLnJpKOpQLntxN19BM809
	yDBGnQGRCicVbfJyLW/fMn2g06eTsbTLC8NQaoNqXuI5ZwppRdpN9Y5/Of4=
X-Google-Smtp-Source: AGHT+IErra2Z+2cuyS72mKRbVd0b1SIJdg1FdPlOT0SXMM+JYn7ftJMAQlprCzj7qfezg8guV34IOQ==
X-Received: by 2002:a17:90b:3b85:b0:2ee:8253:9a9f with SMTP id 98e67ed59e1d1-2f2d8861341mr3978808a91.11.1734431534227;
        Tue, 17 Dec 2024 02:32:14 -0800 (PST)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142d90bd8sm10764596a91.10.2024.12.17.02.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 02:32:13 -0800 (PST)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com
Subject: [PATCH for-rc 5/5] RDMA/bnxt_re: Fix the locking while accessing the QP table
Date: Tue, 17 Dec 2024 15:56:49 +0530
Message-ID: <20241217102649.1377704-6-kalesh-anakkur.purayil@broadcom.com>
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

QP table handling is synchronized with destroy QP and Async
event from the HW. The same needs to be synchronized
during create_qp also. Use the same lock in create_qp also.

Fixes: 76d3ddff7153 ("RDMA/bnxt_re: synchronize the qp-handle table array")
Fixes: f218d67ef004 ("RDMA/bnxt_re: Allow posting when QPs are in error")
Fixes: 84cf229f4001 ("RDMA/bnxt_re: Fix the qp table indexing")
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_fp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index 951ad90f5aa9..5336f74297f8 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -1181,9 +1181,11 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 		rq->dbinfo.db = qp->dpi->dbr;
 		rq->dbinfo.max_slot = bnxt_qplib_set_rq_max_slot(rq->wqe_size);
 	}
+	spin_lock_bh(&rcfw->tbl_lock);
 	tbl_indx = map_qp_id_to_tbl_indx(qp->id, rcfw);
 	rcfw->qp_tbl[tbl_indx].qp_id = qp->id;
 	rcfw->qp_tbl[tbl_indx].qp_handle = (void *)qp;
+	spin_unlock_bh(&rcfw->tbl_lock);
 
 	return 0;
 fail:
-- 
2.43.5


