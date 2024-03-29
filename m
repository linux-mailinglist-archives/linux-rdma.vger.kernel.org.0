Return-Path: <linux-rdma+bounces-1672-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1A6892018
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Mar 2024 16:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B83A1C28F69
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Mar 2024 15:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F26D14B085;
	Fri, 29 Mar 2024 14:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNctGz2p"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955E514B07F
	for <linux-rdma@vger.kernel.org>; Fri, 29 Mar 2024 14:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711724157; cv=none; b=HsrMUioktee6/HHOvEVV+eUOthff+zvnfExkBQMkXBaPekPb1a8sTM/X62N/S7K25B3xOv95S3DtapZsOIVuO5uTWUF2snJ8qtOHR5NqSfgB6FS8SfpY2Tr5HUTfGsNW7c/em7tPyVr6tQiZfs+Zh60S4DNL5s9v1+NpvLagPE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711724157; c=relaxed/simple;
	bh=8iWHOP99IJh3x4cD8IHColiMPVTQtiJHUSlhmwoFscQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dug90FJ0bvpggwZnNHnB6NSfq5JB7TvmlCtgL/bBqUO8+6knm9fyRbIA+rQSTYC87P3Hpo7ULAbJWBEHaLI8rtt1SpgWGV0JIMbrapA6YBQ6f8mDtFICSXhViD7vs+9CkFaH6iF7ZfmEFBV7P7XfUtEx4MP6pqgre+7lIX933uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HNctGz2p; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2218a0f55e1so1128861fac.1
        for <linux-rdma@vger.kernel.org>; Fri, 29 Mar 2024 07:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711724154; x=1712328954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5LQvpPsIQNq+n9+JoELgdiMziRukkOmYY3wjmCQ26g=;
        b=HNctGz2pprwooIdatpxEd472p5xioR7toZFiY1yEf3Wo+45ebCpMTlX5WO7IRfLtoY
         Y/rI0PKEmOR7JvLgFJz3FmbXPay67Ad4+zh2hYorJ8V9XH8FMCIuw7RCBBEBTb6y2PSu
         psH+mvJZjwr2syUmp4jlbGxxqFU0pQ03SgRihTd+hRpnDXHJfClIdLfO4k1nnRtH0Arh
         oHa8DM/Q2NtiYbQ6aimyQNpw35hUf46VS7viVqaHBgX37pLI7ieh9L74cTbso6MSjfxo
         PmgS2ZofaMxhoCXvXOtC+nmZBfWaPdL/175+7YMFT9Sv3fcREvuS+ckBPKeoNxw70vy0
         8k1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711724154; x=1712328954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+5LQvpPsIQNq+n9+JoELgdiMziRukkOmYY3wjmCQ26g=;
        b=po5Ua7TGE4PsMpGTQERJJrun+MDf3OVu7aMnRf65DtUufaGsxducL6EN581S4irIjW
         xIl+dMPlhrmMXri/+MMHtR8DsqzbXwL+RLy6FPx1hDAluMylJcVz1+ltjOGf/qvMe2W0
         BTjXxqW7aGaEBelKL65mNA1xS99YVZVKdhcUUFB0HcnySsns5u35M4QpyFQ0E337e9AS
         90i8M2lye995D18tdrPG6WkLUMjhVtooji0oNsTsbW8Qh135tlX30gEW2p+znbBilWqU
         TDGxvGTjUFSmWmmQKialeJUGkDv74S7UWydfAxr4kqyimR0dHYuGSGJGhBQN1+5cldK1
         hc1A==
X-Forwarded-Encrypted: i=1; AJvYcCWW/hqcw3scQ4TA8CP+b+dy6wl71tegrrv5K70SJt8/kdgzoqDGUCcGfEE/MA89l3sXyyGJDpgUMKMTHSfoSExDy/ibp9cPLkhKBg==
X-Gm-Message-State: AOJu0YwwZPD8NRJ0scRNpX6q0Diujt/22CGuYPeWmJktKLtmtUtfghZu
	3cZ105be22490B39uxYVMwPq7qZGo86xlBLa3Fio69L7hOoq63Vt
X-Google-Smtp-Source: AGHT+IHTskVQpSQax87n/XexZvw1OTGC8uZNYb1b+stAsHK4ENA/ueqeMJWAPMZtYGu6jizEc0VNug==
X-Received: by 2002:a05:6870:2393:b0:22d:f9e1:dbce with SMTP id e19-20020a056870239300b0022df9e1dbcemr1956243oap.6.1711724154686;
        Fri, 29 Mar 2024 07:55:54 -0700 (PDT)
Received: from bob-pearson-dev.lan (2603-8081-1405-679b-75b6-1a40-9b4e-0264.res6.spectrum.com. [2603:8081:1405:679b:75b6:1a40:9b4e:264])
        by smtp.gmail.com with ESMTPSA id fl9-20020a056870494900b0022a58ffa4a3sm1006249oab.23.2024.03.29.07.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 07:55:53 -0700 (PDT)
From: Bob Pearson <rpearsonhpe@gmail.com>
To: yanjun.zhu@linux.dev,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	jhack@hpe.com
Cc: Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 03/12] RDMA/rxe: Remove redundant scheduling of rxe_completer
Date: Fri, 29 Mar 2024 09:55:06 -0500
Message-ID: <20240329145513.35381-6-rpearsonhpe@gmail.com>
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

In rxe_post_send_kernel() if the qp is in the error state after
posting the work requests the rxe_completer() task is scheduled.

But, the only way to move the qp into the error state is to call
rxe_qp_error() which also schedules the rxe_completer() task to drain
the queues. Calling it a second time has no effect. This commit
removes the redundant call.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_verbs.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index a49784e5156c..71b0f834030f 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -907,11 +907,6 @@ static int rxe_post_send_kernel(struct rxe_qp *qp,
 	if (good)
 		rxe_sched_task(&qp->req.task);
 
-	spin_lock_irqsave(&qp->state_lock, flags);
-	if (qp_state(qp) == IB_QPS_ERR)
-		rxe_sched_task(&qp->comp.task);
-	spin_unlock_irqrestore(&qp->state_lock, flags);
-
 	return err;
 }
 
-- 
2.43.0


