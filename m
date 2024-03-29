Return-Path: <linux-rdma+bounces-1670-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F16892016
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Mar 2024 16:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAD7F283EBF
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Mar 2024 15:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A3614B083;
	Fri, 29 Mar 2024 14:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nePPvcKv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6AE14B07F
	for <linux-rdma@vger.kernel.org>; Fri, 29 Mar 2024 14:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711724154; cv=none; b=JssmdGDak3vKSkSQXNgBfZE4xKxXoOOVCXBfxLRpFLtZGt9X9zPOBxKtbEDlYgvD4I6mEa+aNyBxCcTBvJfLN/oEgjYP1iqu8bx9+DqfBkGlprtJWMlGogqzrtxe/oGh+kCuTUEZDJxHMILe5m2cwpXxypUb47IZaYFCylmg69Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711724154; c=relaxed/simple;
	bh=hu+sSbFLIXAKlrWao5wVCYP2Ee0hJ4jSnfY4fHwka+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WVm105rLSbqwg3xMzDH8236AnokOileq4sGzQ4v2wfeNx/Qjl2J7lUVqywtCamjz5JRqXc/4q+LfNMaMLnk46tavZJwzRRn4Qjx8LpPLvx51e4YlHnsxUimLcdb3pe5BmF6Xbb8U/2DKK6s9Fii62UH0jMsce3R9rAyuicKm3aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nePPvcKv; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5a4d3b82e53so1238881eaf.0
        for <linux-rdma@vger.kernel.org>; Fri, 29 Mar 2024 07:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711724152; x=1712328952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GhL5vLaHOFdZg37ZOMVXMEp5PFqWRWgRRVOZKVIqNG0=;
        b=nePPvcKvzC5nTlNi113aoIdFVmEA59Dr6sD+Ny18+BWllQUJa/2vJ0cVIQBY3tmEV0
         whPbMXktaAkex3HTdoL8JwF9z8Oh248bIvM+jFjsCClfa1j6SDIui5AAnByO+Y7g0GIv
         T5/6NsflF3p0NyUCttxTOenjZb0wS54Xj2b342RJR2sRzsC2EUyRHSQVklm64RK+6OcA
         gIUwdA38YEtqYEMw/2cvq799258ILQNRBP96TXQMLjcDhrChZn+QOkBxnzqZtqS0Lq7l
         9d2jSTVf8qpRF+Rn8Mcl3jAPtEpTdrnADKixdJp+Ot6KryfMSzzSzUff8WWWZDuP6xsY
         k8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711724152; x=1712328952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GhL5vLaHOFdZg37ZOMVXMEp5PFqWRWgRRVOZKVIqNG0=;
        b=qX3aNcfRkQBCZ7dIGHBa8x6z5YWk2v2cQuiCrZaeCaGLyfsUdKcSLKWcMdc2rflOIH
         HeRDshh9RIno80YU7jN4z7rbHy+ErHW6l6liNiZ+9koADGjR3n+oWH7ueB/eXwvy/pHj
         vKZ/X6YxstjdkvHH6YsBkPitpnms9INoQ9JNv+kMYNDeOAMYd4weGstpd6BDaZl0EO25
         Jq/df5VWpCCuHChYknXjfuZF2B6Cb4vPz4SRBtPzglCPEfbSBSziOJ70cCsnd2TjY4be
         x9XDbhCsOJc3/F+CbuJWgwic5iQ+U+RTVnbH1Ht6Oc4L6rU9z+914T4isnLvnc7MzkHq
         8how==
X-Forwarded-Encrypted: i=1; AJvYcCXWGy2+vH/TFGveOfmNChPMXU1B/u2bwX3f/snJosjGV3kH2ui/5R38pr15GOTPgHD0LkGXsdE/9wETrd5UXdESIwRJoqdihiRKAg==
X-Gm-Message-State: AOJu0YzCBdKeOB9MsaCll2RLNi5YBTMJuYBFZCLw3jLG/UFFNXDr2jpH
	Fbn8rk1IelE1HuT9buQP/UA2u6ululZoL1IhPIaqpWenQS8aPraH
X-Google-Smtp-Source: AGHT+IE8BMUAzXjT6ARkgqrlLaEGbxmDIhG8opFgGVKI8fcoTT/d3hvxKuDGIZG99seaNqyPWDdv3g==
X-Received: by 2002:a05:6871:808b:b0:22e:102e:ba26 with SMTP id sl11-20020a056871808b00b0022e102eba26mr67955oab.6.1711724152438;
        Fri, 29 Mar 2024 07:55:52 -0700 (PDT)
Received: from bob-pearson-dev.lan (2603-8081-1405-679b-75b6-1a40-9b4e-0264.res6.spectrum.com. [2603:8081:1405:679b:75b6:1a40:9b4e:264])
        by smtp.gmail.com with ESMTPSA id fl9-20020a056870494900b0022a58ffa4a3sm1006249oab.23.2024.03.29.07.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 07:55:52 -0700 (PDT)
From: Bob Pearson <rpearsonhpe@gmail.com>
To: yanjun.zhu@linux.dev,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	jhack@hpe.com
Cc: Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 01/12] RDMA/rxe: Fix seg fault in rxe_comp_queue_pkt
Date: Fri, 29 Mar 2024 09:55:04 -0500
Message-ID: <20240329145513.35381-4-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329145513.35381-2-rpearsonhpe@gmail.com>
References: <20240329145513.35381-2-rpearsonhpe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In rxe_comp_queue_pkt() an incoming response packet skb is enqueued
to the resp_pkts queue and then a decision is made whether to run the
completer task inline or schedule it. Finally the skb is dereferenced
to bump a 'hw' performance counter. This is wrong because if the
completer task is already running in a separate thread it may have
already processed the skb and freed it which can cause a seg fault.
This has been observed infrequently in testing at high scale.

This patch fixes this by changing the order of enqueuing the packet
until after the counter is accessed.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
Fixes: 0b1e5b99a48b ("IB/rxe: Add port protocol stats")
---
 drivers/infiniband/sw/rxe/rxe_comp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index b78b8c0856ab..c997b7cbf2a9 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -131,12 +131,12 @@ void rxe_comp_queue_pkt(struct rxe_qp *qp, struct sk_buff *skb)
 {
 	int must_sched;
 
-	skb_queue_tail(&qp->resp_pkts, skb);
-
-	must_sched = skb_queue_len(&qp->resp_pkts) > 1;
+	must_sched = skb_queue_len(&qp->resp_pkts) > 0;
 	if (must_sched != 0)
 		rxe_counter_inc(SKB_TO_PKT(skb)->rxe, RXE_CNT_COMPLETER_SCHED);
 
+	skb_queue_tail(&qp->resp_pkts, skb);
+
 	if (must_sched)
 		rxe_sched_task(&qp->comp.task);
 	else
-- 
2.43.0


