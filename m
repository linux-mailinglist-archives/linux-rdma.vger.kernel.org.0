Return-Path: <linux-rdma+bounces-12920-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B75D3B35459
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Aug 2025 08:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E6BF681D4E
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Aug 2025 06:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D352F6561;
	Tue, 26 Aug 2025 06:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VuOKlDha"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com [209.85.215.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9853A2F5479
	for <linux-rdma@vger.kernel.org>; Tue, 26 Aug 2025 06:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756189239; cv=none; b=se61wm+o3TYZpvv2jQLogAGqHOqj6b61Bq2MHBvY+84WrLxMZAyuHNx1RVrj133mXTfJ7rosWghPDbtkIWo4k84R0vTPLDJcX1tYE9j2mIwPuBoc1ylsQx25cKaOQUpxRZwWrrgHyxowuwQUDocS0W068sN4Rti8pPevm0jUB/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756189239; c=relaxed/simple;
	bh=OdwXwwbCU5fHvuN0L5iu3ZVAIdZq9hq+Cbn2jIXkqjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QzZFLlf86loYOEPd0HfT5AVDOpo4aY55aXvAYGlylmA04W1B3wfNK9TAEcoq957YjHVQ3WGvo7c/KbHdB6E1tUEiM1NrYWfeYk97F5wMw4llWdDPDXP/1asfELSlGqKyCsbMlCB7lq9AGV/QskxhyRYNdInxFMO0STmzlWnuE9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VuOKlDha; arc=none smtp.client-ip=209.85.215.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f228.google.com with SMTP id 41be03b00d2f7-b49b56a3f27so2787533a12.1
        for <linux-rdma@vger.kernel.org>; Mon, 25 Aug 2025 23:20:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756189237; x=1756794037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aoR+gqx8oECrEElXGnqOHBHQF88CEE1za8gExAMJp7Q=;
        b=hsTkeeJ2l3wEc+K2hE+ZAcACR9gQk37c1H9jEqsfnZ3RnmmyncoJ9PvCmh8eRHmD5+
         MbQzC6e/BDZRWPBIB2dL4HZFZ1Uk/RLUKLREaF3e4Fniaz/IYdkd4wUUnLvEdKCmE1nX
         YNs3wIoqpwdQFXx6ODFSNNf0OHVaQi/fNxZLrmTccM1Eu8+aOWY7I+UFsPFgEXIrqgN+
         +y4RxewkU0976gnhd50kybSSY8tQezgRe36zonNvK0Sw90aXdEVgaT9KfCaoLqWenNri
         Ukh5N7vH4C2ZlA/fPWlw5PFoVsx0FEC1IOIt7Ok/hMCnyVF/HU8HZatnoamPH2PqE9nB
         cwNg==
X-Gm-Message-State: AOJu0YyNmlgCm08O82HbwHZYfAJd1jnrFx2X3BRXCpyas1HvPhTwvTi6
	QaRG5Y/wjFrTNVzfh20I5VM/GUZmEx3ZM09G1Rjpcd9qyCg0I+DiupcDuaHaBsXmZD9NeNeOmv2
	S/axYBVnzU5pUnH/iZ4iuhnb9eWUCLWe2wOATQCyEDPHYnv7bH/Nafk1xGbZpPkceIyB2WdczuW
	MtutunhfI3zSIh2+IWqhch2km/2xKAhQyggHS2lOIdUY4lnKHGxQatmV9ZUqv+bMZ6Gib53sdrV
	yb2ZIpXhZV4TMjX67otllsM48A0zw==
X-Gm-Gg: ASbGncvlyhQu2q7eCAtWPeyJNL+owHPpiJjEVYcLczO5Ndqp1rG2+CAQnUEWrTk8yDK
	+euCuGiZFqeeaGqKwT+u1OP6wkTLyErhZjoGrd9ysG6zCl3JBxbp1GqE2DuE4DKrTSHKlsVOlnE
	jhXxMieORFepFYHj7+WGhPNAs+X9/oJbD/z0Raqs43rUQP3FtPonGh2XYm+Elx78qz2DjWMutQp
	gQ8dKoq1twVtGSeghwTmzoZ7zBd5oZ1E56dmJLdUJ0tNGjDa8EKl5LHgK6yiEzzywxA/Wvx3Lav
	oNIfEdyvlj/KdKyPRa2SeM3HjtnwScT2E8YIX7Ba1L5McohZviwkp+i4AFnOCxi7wrK6GVO+y3w
	BNTbXAOGzMlRbJt8HOZ3K9inIgzYr+zlmwhJh/5siNbQV5vM0Qm7kcQNd6FRRQzZl9xe0leoF33
	2P7tjr6to0dfqg
X-Google-Smtp-Source: AGHT+IE3j61kAbl9hMEzJXcqXreOC9g+IwzdlZFxDBxim+4keHEnsS6QbmyJQcw56X9dEBFZhTGsKgV2qc5Y
X-Received: by 2002:a17:903:28f:b0:246:43a5:1ffb with SMTP id d9443c01a7336-24643a521f7mr159922945ad.4.1756189236794;
        Mon, 25 Aug 2025 23:20:36 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2466886d4adsm7566285ad.53.2025.08.25.23.20.36
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Aug 2025 23:20:36 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b471757d82fso4027582a12.3
        for <linux-rdma@vger.kernel.org>; Mon, 25 Aug 2025 23:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756189235; x=1756794035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aoR+gqx8oECrEElXGnqOHBHQF88CEE1za8gExAMJp7Q=;
        b=VuOKlDhaZqqz5iNzR5UvQyXFALT2ZuKrxt82McFSKdTB+qv5PJbSuCogmcMZ+Wyyd7
         QHJqWZFisKawI4t9QDg3rx6UBhPyTxOD8qVhHm/SGoJbbT17IjvwBNjxgTrRW4kLK8kL
         FWEdvcm8qmAdcf2uxzpelgcYDDAhDl4iKs/fA=
X-Received: by 2002:a05:6a20:6a26:b0:233:b51a:8597 with SMTP id adf61e73a8af0-24340d027b3mr19891742637.35.1756189235026;
        Mon, 25 Aug 2025 23:20:35 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a26:b0:233:b51a:8597 with SMTP id adf61e73a8af0-24340d027b3mr19891705637.35.1756189234627;
        Mon, 25 Aug 2025 23:20:34 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4c04c7522fsm4392543a12.5.2025.08.25.23.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 23:20:34 -0700 (PDT)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	michael.chan@broadcom.com,
	Saravanan Vajravel <saravanan.vajravel@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH V2 rdma-next 01/10] bnxt_en: Enhance stats context reservation logic
Date: Tue, 26 Aug 2025 11:55:13 +0530
Message-ID: <20250826062522.1036432-2-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250826062522.1036432-1-kalesh-anakkur.purayil@broadcom.com>
References: <20250826062522.1036432-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Saravanan Vajravel <saravanan.vajravel@broadcom.com>

When the firmware advertises that the device is capable of supporting
port mirroring on RoCE device, reserve one additional stat_ctx.
To support port mirroring feature, RDMA driver allocates one stat_ctx
for exclusive use in RawEth QP.

Signed-off-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Kashyap Desai <kashyap.desai@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Acked-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 8 ++++++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     | 3 +++
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c | 6 ++++++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 5578ddcb465d..751840fff0dc 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -9601,10 +9601,10 @@ static int __bnxt_hwrm_ptp_qcfg(struct bnxt *bp)
 
 static int __bnxt_hwrm_func_qcaps(struct bnxt *bp)
 {
+	u32 flags, flags_ext, flags_ext2, flags_ext3;
+	struct bnxt_hw_resc *hw_resc = &bp->hw_resc;
 	struct hwrm_func_qcaps_output *resp;
 	struct hwrm_func_qcaps_input *req;
-	struct bnxt_hw_resc *hw_resc = &bp->hw_resc;
-	u32 flags, flags_ext, flags_ext2;
 	int rc;
 
 	rc = hwrm_req_init(bp, req, HWRM_FUNC_QCAPS);
@@ -9671,6 +9671,10 @@ static int __bnxt_hwrm_func_qcaps(struct bnxt *bp)
 	    (flags_ext2 & FUNC_QCAPS_RESP_FLAGS_EXT2_ROCE_VF_RESOURCE_MGMT_SUPPORTED))
 		bp->fw_cap |= BNXT_FW_CAP_ROCE_VF_RESC_MGMT_SUPPORTED;
 
+	flags_ext3 = le32_to_cpu(resp->flags_ext3);
+	if (flags_ext3 & FUNC_QCAPS_RESP_FLAGS_EXT3_MIRROR_ON_ROCE_SUPPORTED)
+		bp->fw_cap |= BNXT_FW_CAP_MIRROR_ON_ROCE;
+
 	bp->tx_push_thresh = 0;
 	if ((flags & FUNC_QCAPS_RESP_FLAGS_PUSH_MODE_SUPPORTED) &&
 	    BNXT_FW_MAJ(bp) > 217)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index fda0d3cc6227..fa2b39b55e68 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2507,6 +2507,7 @@ struct bnxt {
 	#define BNXT_FW_CAP_VNIC_RE_FLUSH		BIT_ULL(40)
 	#define BNXT_FW_CAP_SW_MAX_RESOURCE_LIMITS	BIT_ULL(41)
 	#define BNXT_FW_CAP_NPAR_1_2			BIT_ULL(42)
+	#define BNXT_FW_CAP_MIRROR_ON_ROCE		BIT_ULL(43)
 
 	u32			fw_dbg_cap;
 
@@ -2528,6 +2529,8 @@ struct bnxt {
 	((bp)->fw_cap & BNXT_FW_CAP_ROCE_VF_RESC_MGMT_SUPPORTED)
 #define BNXT_SW_RES_LMT(bp)		\
 	((bp)->fw_cap & BNXT_FW_CAP_SW_MAX_RESOURCE_LIMITS)
+#define BNXT_MIRROR_ON_ROCE_CAP(bp)	\
+	((bp)->fw_cap & BNXT_FW_CAP_MIRROR_ON_ROCE)
 
 	u32			hwrm_spec_code;
 	u16			hwrm_cmd_seq;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
index 61cf201bb0dc..f8c2c72b382d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
@@ -100,6 +100,12 @@ void bnxt_set_dflt_ulp_stat_ctxs(struct bnxt *bp)
 		if (BNXT_PF(bp) && !bp->pf.port_id &&
 		    bp->port_count > 1)
 			bp->edev->ulp_num_ctxs++;
+
+		/* Reserve one additional stat_ctx when the device is capable
+		 * of supporting port mirroring on RDMA device.
+		 */
+		if (BNXT_MIRROR_ON_ROCE_CAP(bp))
+			bp->edev->ulp_num_ctxs++;
 	}
 }
 
-- 
2.43.5


