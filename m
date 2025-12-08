Return-Path: <linux-rdma+bounces-14925-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FB8CADB83
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Dec 2025 17:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C60930762D4
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Dec 2025 16:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEC12DC77A;
	Mon,  8 Dec 2025 16:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="DiUbWLVL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BFB2DA77F
	for <linux-rdma@vger.kernel.org>; Mon,  8 Dec 2025 16:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765210523; cv=none; b=Ma2k+YSLbvG9mnp2no+T8jBbFlk1q9V/urp548k4eCUMhkMmZIiFV62TmIwbMmsBt0cSbLr+RxdJljyQuutf0lQ7fZ+R58HBvXn4trRmh/QyGnFQw4AOGn3GmgJWATYl7hn44OcZKnumKSrVHOzzG5eLVf0Rt2qINwydi8OO6u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765210523; c=relaxed/simple;
	bh=sZcWjmIsYRO/cmUCOdUb+MsvB+bDA3ySbplF2oGyVSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gkpVjcD9OlhameAP4MJ/qmdf8p3U8Unjpwp193a7FVy0sUSdA3+iT3Ob5od7u2WC8LNTcPl7u/O5P37dyVIJhjwfJoIp2M+hAniNK1UHkGHbgvNTNVsdFCyNMJyU9LzqFPkBVcqyyoJcdrWUzjrVz0xToEDfU41ftIb0NbWfCSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=DiUbWLVL; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47798ded6fcso35078655e9.1
        for <linux-rdma@vger.kernel.org>; Mon, 08 Dec 2025 08:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1765210520; x=1765815320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r8C2jgsCv4sSHOCWCnfxbNrRGGWWac7aq8syY0fpQ70=;
        b=DiUbWLVL9ADj4Gy3qI5VFL43h+7A3JNopPbVHkDIuaerqm31PZj9M2XAAztmRyQQ/0
         OZVisrARqa0XTyqM1yoUDsUTDMAAt0Vc2lnfcr8rn7LG4D7i+uoZ/JaCfaOueV/KzYbb
         N34nz1gkt35NFWuy1VJEPvhEQzn4FRwPjD8U5iLeyBjlWHJGhpVjKCj8r78P8/htpDvf
         CCtrtMLVWHcmPzhfTxbY1t3gu8hlFTeTgj3uFinXwh2QbqbLfuoJEdArP9EWD9exdpcM
         I3KywEx+l+tYqF7MhDcL729qGN+Pur2Rnrm3NKVZnZEEmtAKniXOahtlAwZaLdvdyG/C
         ppfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765210520; x=1765815320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r8C2jgsCv4sSHOCWCnfxbNrRGGWWac7aq8syY0fpQ70=;
        b=YqA3RtDK31oRRkFybiqgk9df/pzLH5YZYJZZCM6H91lvDoQFKEDGqVfGAHCSxycDGX
         gzCk6iaIDdYrkrtIgSgIYmwg8YHM4zjqdWbNMf6/AalCjuekt/N+otF1/kXu9oEdXdOk
         jpTWg1XCqLpEC+BJPu7PziJ6whqxDuXg3rSOXftNmL4L+o07dU6yecxR8RIT31+zeq5d
         GllOoBzYWEGz6lZ1LFhXX0KQgIZAZeoQV75q9PAsjlSuqZbB2jp7hgTylqHAvc5Wir2c
         TKww3fp/g7KmOCWqf6CauM+FM1g1nkwNyjhlizTPdh3N9DDQzy+7Gv8dXaFVEDA/Nkwp
         brhw==
X-Gm-Message-State: AOJu0YyTx3Z8Wr/3t3DoHvV9wbUIHAi1BeASmuoZ+ubaycXItSyKTkT+
	5cyxqpCroQoXfmf/rMfGqHiTa1EwwZTl9DveKht/fLb9sQQYgQZc5+6zziNovXafR3U2JfcujD1
	r41fI
X-Gm-Gg: ASbGncuoRLcZpifAFS9y+BOLaAWgewgq09mNpf5Nbd3GrvGoK00qg1EF/+p4R5jq3aP
	gtOcPBIjiRBF7oMNWsB92xcPwjdn1eCfqfdShGHSBTJztN3aZXA79nPy2KjFxEu7iHSAePfsuOM
	0ISUgaTltLt5gdwj0h5n6ynQVf0mvCtG5RGhSOELhSLt5U3omyZacIfew2AmH4nIvzsCOYzaf9P
	jejHuiRXCuvxCIyoj9+Kqcxq82F8xQJBxP0No078aeOrkf5YfFndzNrlj+eIfpl7F/TqQ821GT8
	6qTcORIeyRFA+ec1mv1S6YslAzS/D75kvozY2/ucgg5tcLeeiSh3unRyq0yjYNY/nBE1DlZO9ND
	ICC2qKnh9LVXuq9Z8XP4eM+rVPxy3cqbCFcqMHSiGlK8rwJby/TaSktpOrbph3d4KHCEnGMPL31
	/QYXhIUj+1Ton+XTVkMWm2kTXS6rixn3/F990nH02BoqC0c/EpkSb0ac59A69peu1qTgwNKRMTV
	fx62/4v1NAgdYTSRc3Y/5ZC
X-Google-Smtp-Source: AGHT+IH3z8UJIfkH8FtHK22y1slfQbOhFJHGQhpTH3UVJ2XiRmu1qSF99JTpjv7h7NjqHlpLQZr+FA==
X-Received: by 2002:a05:600c:5741:b0:477:7b16:5f77 with SMTP id 5b1f17b1804b1-47939deaa8cmr53286135e9.3.1765210520177;
        Mon, 08 Dec 2025 08:15:20 -0800 (PST)
Received: from lb03189.fkb.profitbricks.net (p200300f00f28af1ae57f1d6cbb50b9bc.dip0.t-ipconnect.de. [2003:f0:f28:af1a:e57f:1d6c:bb50:b9bc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479311ed466sm245275655e9.13.2025.12.08.08.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 08:15:19 -0800 (PST)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-rdma@vger.kernel.org
Cc: bvanassche@acm.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com,
	grzegorz.prajsner@ionos.com,
	Kim Zhu <zhu.yanjun@ionos.com>
Subject: [PATCH 4/9] RDMA/rtrs: Improve error logging for RDMA cm events
Date: Mon,  8 Dec 2025 17:15:08 +0100
Message-ID: <20251208161513.127049-5-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251208161513.127049-1-haris.iqbal@ionos.com>
References: <20251208161513.127049-1-haris.iqbal@ionos.com>
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
index ee0682021234..49249cc24152 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1947,8 +1947,8 @@ static int rtrs_rdma_conn_rejected(struct rtrs_clt_con *con,
 				  status, rej_msg, errno, ERR_PTR(errno));
 	} else {
 		rtrs_err(s,
-			  "Connect rejected but with malformed message: status %d(%pe) (%s)\n",
-			  status, ERR_PTR(status), rej_msg);
+			  "Connect rejected but with malformed message: status %d (%s)\n",
+			  status, rej_msg);
 	}
 
 	return -ECONNRESET;
@@ -2015,27 +2015,53 @@ static int rtrs_clt_rdma_cm_handler(struct rdma_cm_id *cm_id,
 	case RDMA_CM_EVENT_UNREACHABLE:
 	case RDMA_CM_EVENT_ADDR_CHANGE:
 	case RDMA_CM_EVENT_TIMEWAIT_EXIT:
-		rtrs_wrn(s, "CM error (CM event: %s, err: %d(%pe))\n",
-			 rdma_event_msg(ev->event), ev->status, ERR_PTR(ev->status));
+		if (ev->status < 0) {
+			rtrs_wrn(s, "CM error (CM event: %s, err: %d(%pe))\n",
+				rdma_event_msg(ev->event), ev->status, ERR_PTR(ev->status));
+		} else if (ev->status > 0) {
+			rtrs_wrn(s, "CM error (CM event: %s, err: %d(%s))\n",
+				rdma_event_msg(ev->event), ev->status,
+				rdma_reject_msg(cm_id, ev->status));
+		}
 		cm_err = -ECONNRESET;
 		break;
 	case RDMA_CM_EVENT_ADDR_ERROR:
 	case RDMA_CM_EVENT_ROUTE_ERROR:
-		rtrs_wrn(s, "CM error (CM event: %s, err: %d(%pe))\n",
-			 rdma_event_msg(ev->event), ev->status, ERR_PTR(ev->status));
+		if (ev->status < 0) {
+			rtrs_wrn(s, "CM error (CM event: %s, err: %d(%pe))\n",
+				rdma_event_msg(ev->event), ev->status,
+				ERR_PTR(ev->status));
+		} else if (ev->status > 0) {
+			rtrs_wrn(s, "CM error (CM event: %s, err: %d(%s))\n",
+				rdma_event_msg(ev->event), ev->status,
+				rdma_reject_msg(cm_id, ev->status));
+		}
 		cm_err = -EHOSTUNREACH;
 		break;
 	case RDMA_CM_EVENT_DEVICE_REMOVAL:
 		/*
 		 * Device removal is a special case.  Queue close and return 0.
 		 */
-		rtrs_wrn_rl(s, "CM event: %s, status: %d(%pe)\n", rdma_event_msg(ev->event),
-			    ev->status, ERR_PTR(ev->status));
+		if (ev->status < 0) {
+			rtrs_wrn_rl(s, "CM event: %s, status: %d(%pe)\n",
+					rdma_event_msg(ev->event),
+					ev->status, ERR_PTR(ev->status));
+		} else if (ev->status > 0) {
+			rtrs_wrn_rl(s, "CM event: %s, status: %d(%s)\n",
+					rdma_event_msg(ev->event),
+					ev->status, rdma_reject_msg(cm_id, ev->status));
+		}
 		rtrs_clt_close_conns(clt_path, false);
 		return 0;
 	default:
-		rtrs_err(s, "Unexpected RDMA CM error (CM event: %s, err: %d(%pe))\n",
-			 rdma_event_msg(ev->event), ev->status, ERR_PTR(ev->status));
+		if (ev->status < 0) {
+			rtrs_err(s, "Unexpected RDMA CM error (CM event: %s, err: %d(%pe))\n",
+				rdma_event_msg(ev->event), ev->status, ERR_PTR(ev->status));
+		} else if (ev->status > 0) {
+			rtrs_err(s, "Unexpected RDMA CM error (CM event: %s, err: %d(%s))\n",
+				rdma_event_msg(ev->event), ev->status,
+				rdma_reject_msg(cm_id, ev->status));
+		}
 		cm_err = -ECONNRESET;
 		break;
 	}
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 905d5baec89b..4e203140c990 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -2018,8 +2018,15 @@ static int rtrs_srv_rdma_cm_handler(struct rdma_cm_id *cm_id,
 	case RDMA_CM_EVENT_REJECTED:
 	case RDMA_CM_EVENT_CONNECT_ERROR:
 	case RDMA_CM_EVENT_UNREACHABLE:
-		rtrs_err(s, "CM error (CM event: %s, err: %d(%pe))\n",
-			  rdma_event_msg(ev->event), ev->status, ERR_PTR(ev->status));
+		if (ev->status < 0) {
+			rtrs_err(s, "CM error (CM event: %s, err: %d(%pe))\n",
+					rdma_event_msg(ev->event), ev->status,
+					ERR_PTR(ev->status));
+		} else if (ev->status > 0) {
+			rtrs_err(s, "CM error (CM event: %s, err: %d(%s))\n",
+					rdma_event_msg(ev->event), ev->status,
+					rdma_reject_msg(cm_id, ev->status));
+		}
 		fallthrough;
 	case RDMA_CM_EVENT_DISCONNECTED:
 	case RDMA_CM_EVENT_ADDR_CHANGE:
@@ -2028,8 +2035,15 @@ static int rtrs_srv_rdma_cm_handler(struct rdma_cm_id *cm_id,
 		close_path(srv_path);
 		break;
 	default:
-		pr_err("Ignoring unexpected CM event %s, err %d(%pe)\n",
-		       rdma_event_msg(ev->event), ev->status, ERR_PTR(ev->status));
+		if (ev->status < 0) {
+			pr_err("Ignoring unexpected CM event %s, err %d(%pe)\n",
+					rdma_event_msg(ev->event), ev->status,
+					ERR_PTR(ev->status));
+		} else if (ev->status > 0) {
+			pr_err("Ignoring unexpected CM event %s, err %d(%s)\n",
+					rdma_event_msg(ev->event), ev->status,
+					rdma_reject_msg(cm_id, ev->status));
+		}
 		break;
 	}
 
-- 
2.43.0


