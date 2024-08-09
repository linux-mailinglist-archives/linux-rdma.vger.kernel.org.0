Return-Path: <linux-rdma+bounces-4274-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A537494D0F0
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2024 15:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F3101F22289
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2024 13:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4845194C6F;
	Fri,  9 Aug 2024 13:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="aLfLUCaM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com [209.85.208.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DCC195FEC
	for <linux-rdma@vger.kernel.org>; Fri,  9 Aug 2024 13:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723209359; cv=none; b=UkaLlJZdXgDWbjbgSUQdfumTBEZD+gM3n8/2rrEYuSOUjeFbFy/b7X17OU1Nr2pnGiN32o3LZkCsQNMW4YAwiZiPHywAKit0ZCmrt2rbw6b+JvyVNDxkiCptsXfM/MlU3zgNLwWMQx3RtkEtK5OxjFUnT7HUtZG8KPRifYXit7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723209359; c=relaxed/simple;
	bh=UKZdlURp9y8m7Wfiru0pj4BLF+QKyPW96UV/lMHLhqo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QVAW+wIa+38Hl/MwLLE9gBms2vI9WSkJTlCvtMumkbUmhzBkTCpmg+Lh9DjaDtsCfjcPK74I2yYneMKOeZx6KAvOjt/cXeP6PJl0gOVrAo+vV5LSEsk6aPrHP6JyzzbZsIRaI3mXFt5MVAGquqPuog8eTZVzeHy3QSgH/Mtmb0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=aLfLUCaM; arc=none smtp.client-ip=209.85.208.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lj1-f194.google.com with SMTP id 38308e7fff4ca-2f0dfdc9e16so24145041fa.2
        for <linux-rdma@vger.kernel.org>; Fri, 09 Aug 2024 06:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1723209355; x=1723814155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t07LWNbbJ1CWMDPd+GXylKpgK0rHVigw8wrUTpYaBe4=;
        b=aLfLUCaM3d09BJDZqjGYYzgHusCu67CVjn8RDFcRAQen7FxXxFzHz05T3ojvEgtyKc
         e2uweTniJdzWMz6yuOHIH73+Mnw9vjUeHtg0OZZB9XGFfmrRG74vMW7ClRoTheGVLUhP
         CtY+2PSFXFYDv2JcdAXP/Zyqi+X0hfSBLHHj9NrDTCtHNaKjuA558gb+/p0yKudj3Nn4
         ypp4Y37y6H7M+0Ty2pkpjwVD72jqMQyyyz+QWhCqrb0H45nO9X0Ktg8NxvcTY8XoLukX
         ovRJvMP/Y65izQsBaeXRjUEfFA6edF/JE5PovhaeFOVmeG/SLFEpTU05gEKMh6dUxCFX
         +3aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723209355; x=1723814155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t07LWNbbJ1CWMDPd+GXylKpgK0rHVigw8wrUTpYaBe4=;
        b=QCWJjbjEJ82fFhQrUwf0hlpIWlimHB+O4B798dvHHO9feszHPpx4Q8IRuG8I8g9j29
         tr+VpScjb9pjB84xEB3kNEByOUm2dDd5QWOvz3MmOH5G1LSxRiMcdV17trAVn+em5b1w
         bqKB8zTMIUvIpeyevEdpld26RcV6kvOjWozp2h/Y6AEgVZXzEEnZk/GplvVyM+McEifl
         8It0X4AgqLDkfA+xoB33NQHFIjJ/XDGFczQaukOxk5oaSjJn96jM0rxzhgNekM2sBl0I
         1DiM6SkllvL+w++5F1wClv41X77sNXbgNvKlEthDqRpseK6S5takqFiOINTDA64WHEL4
         H1kQ==
X-Gm-Message-State: AOJu0YyGY+iykaI/kytlhCtYA4Ailpoi+O/66JmhcY+Q2NFfwjQ/Q2WF
	6+1+eamqyz+qlHgfA72bR/qcwP6K3KfygYmHfG1+wPFhQeD9HA/ycujIvGf5N4xsU8ZAQVq5jtM
	S5I82WA==
X-Google-Smtp-Source: AGHT+IGTxh2gGuDmuiFwDZ65xgTy1VL3jAe4KYJ+qkdKO/F3mPdd6mY+GN8BC3Sl2JB9+hUFHbCVzw==
X-Received: by 2002:a2e:9f4f:0:b0:2ef:392e:e45 with SMTP id 38308e7fff4ca-2f1a6d32166mr11382171fa.33.1723209355294;
        Fri, 09 Aug 2024 06:15:55 -0700 (PDT)
Received: from lb01533.fkb.profitbricks.net ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c77f078sm78280625e9.37.2024.08.09.06.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 06:15:54 -0700 (PDT)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-rdma@vger.kernel.org
Cc: bvanassche@acm.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com,
	Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Subject: [PATCH for-next 02/13] RDMA/rtrs-srv: Fix use-after-free during session establishment
Date: Fri,  9 Aug 2024 15:15:27 +0200
Message-Id: <20240809131538.944907-3-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240809131538.944907-1-haris.iqbal@ionos.com>
References: <20240809131538.944907-1-haris.iqbal@ionos.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jack Wang <jinpu.wang@ionos.com>

In case of error happening during session stablishment, close_work is
running. A new RDMA CM event may arrive since we don't destroy cm_id
before destroying qp. To fix this, we first destroy cm_id after drain_qp,
so no new RDMA CM event will arrive afterwards.

Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 2 +-
 drivers/infiniband/ulp/rtrs/rtrs.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index fb67b58a7f62..90ea25ad6720 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1540,6 +1540,7 @@ static void rtrs_srv_close_work(struct work_struct *work)
 		con = to_srv_con(srv_path->s.con[i]);
 		rdma_disconnect(con->c.cm_id);
 		ib_drain_qp(con->c.qp);
+		rdma_destroy_id(con->c.cm_id);
 	}
 
 	/*
@@ -1564,7 +1565,6 @@ static void rtrs_srv_close_work(struct work_struct *work)
 			continue;
 		con = to_srv_con(srv_path->s.con[i]);
 		rtrs_cq_qp_destroy(&con->c);
-		rdma_destroy_id(con->c.cm_id);
 		kfree(con);
 	}
 	rtrs_ib_dev_put(srv_path->s.dev);
diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
index 4e17d546d4cc..44167fd1c958 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs.c
@@ -318,7 +318,7 @@ EXPORT_SYMBOL_GPL(rtrs_cq_qp_create);
 void rtrs_cq_qp_destroy(struct rtrs_con *con)
 {
 	if (con->qp) {
-		rdma_destroy_qp(con->cm_id);
+		ib_destroy_qp(con->qp);
 		con->qp = NULL;
 	}
 	destroy_cq(con);
-- 
2.25.1


