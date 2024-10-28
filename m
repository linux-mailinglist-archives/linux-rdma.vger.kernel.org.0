Return-Path: <linux-rdma+bounces-5575-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E269B2CE6
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2024 11:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CB92282BCF
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2024 10:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECECA1D5AC6;
	Mon, 28 Oct 2024 10:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZqSwon6/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884621D2F62
	for <linux-rdma@vger.kernel.org>; Mon, 28 Oct 2024 10:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730111273; cv=none; b=tGOjYNB3xN5nkNTR90Cld19NRI1lsXvuB+nx+x1pWetZh+EJThlF6dG+YL0XPLz4zhVR8yh2KkCzCNNkB3q8Ulego1lCTXFUXyZUb8VQB73+8yRv8tz0j4fp4NBo/LRiFiH2m345A8KXNrGEuv5leIUW4/RjahXkIajfdB7a0vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730111273; c=relaxed/simple;
	bh=m5v/jAbuGbaYjmCdyqEDMcMKskoAAdPZ/0qrMHvwDdQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=piXGa/HCUaQzcS/AusYCeOxduHkasejn2VQBA1pk8kOERQzI/p1brrEptf9C+iBqVhkA5waoXiGDgbkcy4EAlKYIaI3Tyj358lLJPRILVH/hm0E+/4GZQz1fkRXchqXqKAEBnmdGQZTy08wNROPp2mFOYmbqmzpWd4Jx9qocyPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZqSwon6/; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-72061bfec2dso1592814b3a.2
        for <linux-rdma@vger.kernel.org>; Mon, 28 Oct 2024 03:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1730111271; x=1730716071; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DfLNpmtReDrb/fPeMdvW7FS6UMQRUGVoBvCV9DhmElg=;
        b=ZqSwon6/vP5bC3Ju5ZxwZkLIdGGM5WtuNjA8Ymfew1YlqVsAfw8BF83075P3dWjjK8
         7KECZckWKQZEc5+lJEruoxssMp8D4m05QLtKxu0UrtgU35OINbsUAHvbB+uayTfbtzpK
         PTjZSfYqsCcc6vce/vs0BbC4njLWn22rD7bes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730111271; x=1730716071;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DfLNpmtReDrb/fPeMdvW7FS6UMQRUGVoBvCV9DhmElg=;
        b=MROznDUTyqkUV7PTL6GxklZixPAgmhCVujqA8EH2X9Qv5kGv3ueY0/n/6g33znIR90
         skQyCGPOpJR/96mv8UffYz4Bj5h6nba8ihLZNrGRvUo7NYLZirkuVuAQEXp5FrpP+3MS
         5kwlaAWh+kZ+/8euC7T0LdWDPCzMqJr58ZdnDJZ4RaZxXip7NhQ59WxuC8NlnC0Y7odc
         MVmxZYUWjnPNrNnOqDbVKK6EqeAT1pOvaBUwHa2zPExixhijATQU4C5JqTfiokveXjGE
         2uxMCcTwN1s+uuiMU9HYx7ZpKkK9+KMTbzePg9kGbnHW1YcEkuQ8w8DRQDmN3yAFzkN2
         MfpQ==
X-Gm-Message-State: AOJu0YzeBGh82aUeCS1iZJv9ZS4kuNKtJbiiXtR5IEOQJbrKr9+blJkK
	lX2zESNu3GpwgGP8icyBTfolAbqFZRwsInkT/60vSPCFlwmiQE9Fu39ymPt2mg==
X-Google-Smtp-Source: AGHT+IENQ4nVBlN5KaL7Haii9Bka5ViZEG9af+07jPh3v0NWnthnXbsPxEBIUFd1QjnDG1fxzegRtw==
X-Received: by 2002:a05:6a21:a24b:b0:1d9:3456:b75e with SMTP id adf61e73a8af0-1d9a84d7879mr11402156637.35.1730111270674;
        Mon, 28 Oct 2024 03:27:50 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc03e4a6sm47681685ad.232.2024.10.28.03.27.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Oct 2024 03:27:49 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	kashyap.desai@broadcom.com,
	Jack Wang <jinpu.wang@ionos.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-rc] RDMA/bnxt_re: Check cqe flags to know imm_data vs inv_irkey
Date: Mon, 28 Oct 2024 03:06:54 -0700
Message-Id: <1730110014-20755-1-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Kashyap Desai <kashyap.desai@broadcom.com>

Invalidate rkey is cpu endian and immediate data is in big endian format.
Both immediate data and invalidate the remote key returned by
HW is in little endian format.

While handling the commit in fixes tag, the difference between
immediate data and invalidate rkey endianness was not considered.

Without changes of this patch, Kernel ULP was failing while processing
inv_rkey.

dmesg log snippet -
nvme nvme0: Bogus remote invalidation for rkey 0x2000019Fix in this patch

Do endianness conversion based on completion queue entry flag.
Also, the HW completions are already converted to host endianness in
bnxt_qplib_cq_process_res_rc and bnxt_qplib_cq_process_res_ud and there
is no need to convert it again in bnxt_re_poll_cq. Modified the union to
hold the correct data type.

Fixes: 95b087f87b78 ("bnxt_re: Fix imm_data endianness")
Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 7 +++++--
 drivers/infiniband/hw/bnxt_re/qplib_fp.h | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index e66ae9f..1600967 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -3633,7 +3633,7 @@ static void bnxt_re_process_res_shadow_qp_wc(struct bnxt_re_qp *gsi_sqp,
 	wc->byte_len = orig_cqe->length;
 	wc->qp = &gsi_qp->ib_qp;
 
-	wc->ex.imm_data = cpu_to_be32(le32_to_cpu(orig_cqe->immdata));
+	wc->ex.imm_data = cpu_to_be32(orig_cqe->immdata);
 	wc->src_qp = orig_cqe->src_qp;
 	memcpy(wc->smac, orig_cqe->smac, ETH_ALEN);
 	if (bnxt_re_is_vlan_pkt(orig_cqe, &vlan_id, &sl)) {
@@ -3778,7 +3778,10 @@ int bnxt_re_poll_cq(struct ib_cq *ib_cq, int num_entries, struct ib_wc *wc)
 				 (unsigned long)(cqe->qp_handle),
 				 struct bnxt_re_qp, qplib_qp);
 			wc->qp = &qp->ib_qp;
-			wc->ex.imm_data = cpu_to_be32(le32_to_cpu(cqe->immdata));
+			if (cqe->flags & CQ_RES_RC_FLAGS_IMM)
+				wc->ex.imm_data = cpu_to_be32(cqe->immdata);
+			else
+				wc->ex.invalidate_rkey = cqe->invrkey;
 			wc->src_qp = cqe->src_qp;
 			memcpy(wc->smac, cqe->smac, ETH_ALEN);
 			wc->port_num = 1;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
index 820611a..f55958e 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
@@ -391,7 +391,7 @@ struct bnxt_qplib_cqe {
 	u16				cfa_meta;
 	u64				wr_id;
 	union {
-		__le32			immdata;
+		u32			immdata;
 		u32			invrkey;
 	};
 	u64				qp_handle;
-- 
2.5.5


