Return-Path: <linux-rdma+bounces-15351-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AFCCFEDDD
	for <lists+linux-rdma@lfdr.de>; Wed, 07 Jan 2026 17:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9135530090FE
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Jan 2026 16:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A568735B145;
	Wed,  7 Jan 2026 16:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="VrPAwrYB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C0D347FEC
	for <linux-rdma@vger.kernel.org>; Wed,  7 Jan 2026 16:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767802535; cv=none; b=LZF68M5TLrJ0HrgTJWk/iea0GyFKWDzwWTrLMhx++towa3FgNVXHX2hS3G/5iDkEVkMSQP8RVwz5Ny67wyQ8yFXCYCI8G+kPXH13ErXuHiLG2EpNhk8aqJyHK0s1Gbq3nzgv1QXTq3kWr67UKOH3ovcIUgP6aAFJbwlzJHyOLWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767802535; c=relaxed/simple;
	bh=e0Z9/hxJSdmOEPOOMC3o7DNzjhNWtv/IsD+YFfDwRqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KyrMf8whfQmGiqIgK1zs/YJ2iVPrb+dS4CLIGuK5FI0emrTIRF/Ckha5Hy11Ig2n7okoEhoEiYt+JLfv9nAAiMIRC129eSn6+mX3vIh/WWXCpSQQeTEfmaH/axS1Maf73altV4YClldOJg8N2yMpWsvxOTLA4DOX1SrzomPUNbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=VrPAwrYB; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-64b5ed53d0aso3180956a12.3
        for <linux-rdma@vger.kernel.org>; Wed, 07 Jan 2026 08:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1767802523; x=1768407323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nkhqR4oCz4fvFJhQr9EweN1fKZGGVzECXm4eJvLcVfg=;
        b=VrPAwrYBvVJi4cnwJnCgJxrMeIOmUs34COTst9cyJKsdKh0az9wnP9DB/hwgtwuPz4
         jZ5caO5r18Yh9scwkA5M+OhiO8aUJx15oX17julhoUYarkRpzsUlWAr9JnHj/Uw6kJf5
         JGez9ZdkjXCAWkDXamEtyehtAV+IZHOBLwRBt/xnHlVCk4A2Drv7DPsY1XnWrV2oWUb2
         JjeNkginql2Xa0H0hG3uMYkvmvaTiq2OpD7pHO3wsM6SIzHsORFYzLfeC8yehO1rFokF
         x5x/R4K84RjPfYVL+QuuVXLwQ5orpBeAMeMxP/y6+fiC+/QutWYaO7PL3zUa2cCcx4BW
         901g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767802523; x=1768407323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nkhqR4oCz4fvFJhQr9EweN1fKZGGVzECXm4eJvLcVfg=;
        b=rye/6IXrxOy4+ukAVMN2Vr7AhQN3W/8/h4lizEYFnjDvILPyw6PxQ3zSORtEmuyu/e
         U7e6N4K3Xrlnw4jA1mWeJdvG5HnvMxn6CnbXhLrFR/yGf6sC25pcINvF2JUoLErubpG5
         prZ26fYAUN80Pxd33u2aUSdkN9iREwc3BkyUH9Ohr/3oYbiFwwt3ilcd7Kr2RI350XVf
         ovaGKoNwmkhZrIZcaUhhYYGe3Ee6HPvPd7c0MGAliTCvzesTAI0prLK7PQRdWQ17dXfC
         zEAHIq3xhZTYf+m+2bYYzVuhRVMGIGRjlqnpqMtvOz9JGPQX657akgwzra30NVFiraqX
         ZMNw==
X-Gm-Message-State: AOJu0YxIjw2q9J9Lz3lWNOQO+gZU3BtHoU4zP42sv8hzk6ay/CD8fOys
	F0qm8CMpk+IN7Fc7lDOfv2STvo5UDO8jufY06H4NSMHvktjL5e532Ivudz6uXuv6L6cZQXvfYAX
	sm+fq
X-Gm-Gg: AY/fxX6jghjOIMdQAaS6hB1n19tzBthcTPRZpJ7amwAvnpUlp+sYZTDhU9M4MWy/Xq2
	D/0OaXK+fm4LAo/IGwL+FLqplmXfW/TcsKwsDSqWNtS1qizluDl80PZiXtuTLb4qC8g8h/EBIKN
	ybtptPVqjIfjL7frrCNOelK+Ft3Tu8vIRl+XOAk4ux5hl9h1r4JiYI/84Vf3F+Qr6UvQtUw/Jr3
	6qKH9NaayMcDxqlHBlVA0Hfl4uGix6kzb6jSbo+3wZ2JHEHQdrlpaQysBz++nMA1E/fAEVk2I39
	gcwhEB+j2i/ladUu39xr957zQ+g2VOvFw7ywZuUTTsazaePIY+Z2VsB1qu+278agn/OaEY+4kLI
	R25Jy1p73lck8tW3Sb/XDqFvqmVSzYfOQQIgb2pI6v7i9r8Ud3vowNu7WWA0Jwl5y05AecqF4ur
	RW2R1uka7k5UroRx5lVq2uOZkJUXPqfNOXY2zAimlWAZ6yXECdu9FwgaZC44MkJLypLNDUcJYAo
	EB1aD5/ga4BUvnDZ4XmBy/DCWoMb46M3Q==
X-Google-Smtp-Source: AGHT+IGL7R3nLWc/VQwAV+Wbz238OHxtyMqj+3Lez4xD6CLydGTizfdHuxjVA3YvpMAqfmgLdCAulQ==
X-Received: by 2002:a17:907:a06:b0:b83:32b7:21b0 with SMTP id a640c23a62f3a-b8444c98cf3mr289301666b.17.1767802523185;
        Wed, 07 Jan 2026 08:15:23 -0800 (PST)
Received: from lb03189.fkb.profitbricks.net ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507b9d4c89sm4864773a12.10.2026.01.07.08.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 08:15:22 -0800 (PST)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-rdma@vger.kernel.org
Cc: bvanassche@acm.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com,
	grzegorz.prajsner@ionos.com,
	Kim Zhu <zhu.yanjun@ionos.com>
Subject: [PATCH v2 04/10] RDMA/rtrs: Improve error logging for RDMA cm events
Date: Wed,  7 Jan 2026 17:15:11 +0100
Message-ID: <20260107161517.56357-5-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260107161517.56357-1-haris.iqbal@ionos.com>
References: <20260107161517.56357-1-haris.iqbal@ionos.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kim Zhu <zhu.yanjun@ionos.com>

The member variable status in the struct rdma_cm_event is used for both
linux errors and the errors definded in rdma stack.

Signed-off-by: Kim Zhu <zhu.yanjun@ionos.com>
Reviewed-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 46 ++++++++++++++++++++------
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 22 +++++++++---
 2 files changed, 54 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index f0d43eb24c9e..393b5f35ff38 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1947,8 +1947,8 @@ static int rtrs_rdma_conn_rejected(struct rtrs_clt_con *con,
 				  status, rej_msg, ERR_PTR(errno));
 	} else {
 		rtrs_err(s,
-			  "Connect rejected but with malformed message: status %pe (%s)\n",
-			  ERR_PTR(status), rej_msg);
+			  "Connect rejected but with malformed message: status %d (%s)\n",
+			  status, rej_msg);
 	}
 
 	return -ECONNRESET;
@@ -2015,27 +2015,53 @@ static int rtrs_clt_rdma_cm_handler(struct rdma_cm_id *cm_id,
 	case RDMA_CM_EVENT_UNREACHABLE:
 	case RDMA_CM_EVENT_ADDR_CHANGE:
 	case RDMA_CM_EVENT_TIMEWAIT_EXIT:
-		rtrs_wrn(s, "CM error (CM event: %s, err: %pe)\n",
-			 rdma_event_msg(ev->event), ERR_PTR(ev->status));
+		if (ev->status < 0) {
+			rtrs_wrn(s, "CM error (CM event: %s, err: %pe)\n",
+				rdma_event_msg(ev->event), ERR_PTR(ev->status));
+		} else if (ev->status > 0) {
+			rtrs_wrn(s, "CM error (CM event: %s, err: %s)\n",
+				rdma_event_msg(ev->event),
+				rdma_reject_msg(cm_id, ev->status));
+		}
 		cm_err = -ECONNRESET;
 		break;
 	case RDMA_CM_EVENT_ADDR_ERROR:
 	case RDMA_CM_EVENT_ROUTE_ERROR:
-		rtrs_wrn(s, "CM error (CM event: %s, err: %pe)\n",
-			 rdma_event_msg(ev->event), ERR_PTR(ev->status));
+		if (ev->status < 0) {
+			rtrs_wrn(s, "CM error (CM event: %s, err: %pe)\n",
+				rdma_event_msg(ev->event),
+				ERR_PTR(ev->status));
+		} else if (ev->status > 0) {
+			rtrs_wrn(s, "CM error (CM event: %s, err: %s)\n",
+				rdma_event_msg(ev->event),
+				rdma_reject_msg(cm_id, ev->status));
+		}
 		cm_err = -EHOSTUNREACH;
 		break;
 	case RDMA_CM_EVENT_DEVICE_REMOVAL:
 		/*
 		 * Device removal is a special case.  Queue close and return 0.
 		 */
-		rtrs_wrn_rl(s, "CM event: %s, status: %pe\n", rdma_event_msg(ev->event),
-			    ERR_PTR(ev->status));
+		if (ev->status < 0) {
+			rtrs_wrn_rl(s, "CM event: %s, status: %pe\n",
+					rdma_event_msg(ev->event),
+					ERR_PTR(ev->status));
+		} else if (ev->status > 0) {
+			rtrs_wrn_rl(s, "CM event: %s, status: %s\n",
+					rdma_event_msg(ev->event),
+					rdma_reject_msg(cm_id, ev->status));
+		}
 		rtrs_clt_close_conns(clt_path, false);
 		return 0;
 	default:
-		rtrs_err(s, "Unexpected RDMA CM error (CM event: %s, err: %pe)\n",
-			 rdma_event_msg(ev->event), ERR_PTR(ev->status));
+		if (ev->status < 0) {
+			rtrs_err(s, "Unexpected RDMA CM error (CM event: %s, err: %pe)\n",
+				rdma_event_msg(ev->event), ERR_PTR(ev->status));
+		} else if (ev->status > 0) {
+			rtrs_err(s, "Unexpected RDMA CM error (CM event: %s, err: %s)\n",
+				rdma_event_msg(ev->event),
+				rdma_reject_msg(cm_id, ev->status));
+		}
 		cm_err = -ECONNRESET;
 		break;
 	}
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 7ed8910ef7f5..9b8567e5ea38 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -2012,8 +2012,15 @@ static int rtrs_srv_rdma_cm_handler(struct rdma_cm_id *cm_id,
 	case RDMA_CM_EVENT_REJECTED:
 	case RDMA_CM_EVENT_CONNECT_ERROR:
 	case RDMA_CM_EVENT_UNREACHABLE:
-		rtrs_err(s, "CM error (CM event: %s, err: %pe)\n",
-			  rdma_event_msg(ev->event), ERR_PTR(ev->status));
+		if (ev->status < 0) {
+			rtrs_err(s, "CM error (CM event: %s, err: %pe)\n",
+					rdma_event_msg(ev->event),
+					ERR_PTR(ev->status));
+		} else if (ev->status > 0) {
+			rtrs_err(s, "CM error (CM event: %s, err: %s)\n",
+					rdma_event_msg(ev->event),
+					rdma_reject_msg(cm_id, ev->status));
+		}
 		fallthrough;
 	case RDMA_CM_EVENT_DISCONNECTED:
 	case RDMA_CM_EVENT_ADDR_CHANGE:
@@ -2022,8 +2029,15 @@ static int rtrs_srv_rdma_cm_handler(struct rdma_cm_id *cm_id,
 		close_path(srv_path);
 		break;
 	default:
-		pr_err("Ignoring unexpected CM event %s, err %pe\n",
-		       rdma_event_msg(ev->event), ERR_PTR(ev->status));
+		if (ev->status < 0) {
+			pr_err("Ignoring unexpected CM event %s, err %pe\n",
+					rdma_event_msg(ev->event),
+					ERR_PTR(ev->status));
+		} else if (ev->status > 0) {
+			pr_err("Ignoring unexpected CM event %s, err %s\n",
+					rdma_event_msg(ev->event),
+					rdma_reject_msg(cm_id, ev->status));
+		}
 		break;
 	}
 
-- 
2.43.0


