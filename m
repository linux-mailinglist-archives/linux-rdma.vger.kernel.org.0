Return-Path: <linux-rdma+bounces-15432-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFE3D0F7FE
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Jan 2026 18:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16846302FA1B
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Jan 2026 17:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4AE34C820;
	Sun, 11 Jan 2026 17:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yw97zs8F"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD4B346AE3
	for <linux-rdma@vger.kernel.org>; Sun, 11 Jan 2026 17:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768151571; cv=none; b=VIoATXQntQ7D4F6gFmrcj57BFxLvyhuQylGluBEv3wOomw0dM+0M4EhhReqKHTPtaDM8NveUmcE+lsbWqcPms1aTZNQPSB5bbJBHuuFooSdIoQlKO0oTHusNb2KQ7w8UoFBEpojzH8bn/sm6B6S62FTbPyWvjOj2E1MxdXm4GcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768151571; c=relaxed/simple;
	bh=FRikw+aH/EFNHxXdSeRa4aNnHKkYpt++u6s/L69FKJc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GO+/JBJVeNoeFTlygHCUdlq5Qi/cGwhbj+i63TrigKdZUp/7QCB8w8ZxemQYgr9Bu0V8oMv2ucQfLPmzsNIYPZCaE+/nrxNCw+C0URQCwamr6mNOthIBuEy9fveoul0gy1jAS3L9acp5ixcw152mrhVuQe0C8lWKBA02Q2jTGx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yw97zs8F; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-4511f736011so2550447b6e.0
        for <linux-rdma@vger.kernel.org>; Sun, 11 Jan 2026 09:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768151569; x=1768756369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MyzJdRsgxqDp5cdZgjxReGtTIZkUf+41udKNUBqMXvg=;
        b=Yw97zs8FfKWBSGEPCnClWgoTFZzumj6z85ni+a+EhyFUuGaHogc9OHbxzQAHMgv022
         ptEhV66ENNRxouGNPEKcdYIZbryrwG42xlRY95FYvf8BAYEjw1/cWU3EloOrs2nx12WQ
         nnWPkOotwWqBolF1OYtBECUd/lWT99c0tIZW/06dzSVCDqn7tzAblMwhh+3HvUq1Iq0S
         LZO3Lf+w5/PCEbmQHt98zjfmBzOw+7QQq5T0KD6CuKjKKFfx6gEPJIvSlxF1rt0gNn/H
         W5zV2qJpDQwmlqVl3nz7TjJNKdOPvd28j3dr3YgnItQvdK0875lvWuUzxi7iRmIre5zx
         bDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768151569; x=1768756369;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MyzJdRsgxqDp5cdZgjxReGtTIZkUf+41udKNUBqMXvg=;
        b=Poz/V/HLci/nUp6V14Ltkpuw7DkJwCZaf9TC0Pg36kdIbcYHNfjXIo8zIianVuCL3b
         y5I72AYZ0BLUUB4Wg3xmm2vC+OwGoQ3Xd50w6uIrpI0UfUj19ZDYs6rGIS3kH3gI9m6P
         BG/zRFxc2nP9/ZRnlW6Fr5CjanY1b1fWkoSlVXdWUXAw4X9Po0eBpz5Pi5bbuVky6YDc
         eyv1Co27zXjrHuNvDhVAvUD64dhI9Ec/zBN96mqp+ZDTIX33ugX6j/7ua9GcELjh5ldB
         7mnDB3/v3DrV8tzVAV0zGRFeykdODH9/ZhGqXpRh5a7w+/6xFA1w20OEb2/VwVVnsJzr
         yuVA==
X-Gm-Message-State: AOJu0Yy3nrHlbQdEzlo8ayS18Tb7w23f4S0AnpJsNsAkAfYsFCWuk1/b
	+HD9n2meQlyWkR7qrLhe17TTHWJ7Zl+FOOZWhnF9pjiYJ0mqqpPmMJv9
X-Gm-Gg: AY/fxX7VPoFx51C1QH3e0uE9fMRdpgM/KxhzXZGsBUILE/mUPLRPtDpyaQz93FEY1SJ
	Hhod7xKjeBGYRKIzVeXESeecIznni1H7nxYVXD7HoWwW4/nG0+DJCzBXP/aTSxd5yXEL/rru0bN
	k34gaj/5ly0/F785TrGuHYAL/8YnfDASEZXfEK8h7PReJ6aAxTFu7Ozwjj5roAtIEAE4XRHGbsg
	tDBwPiozk8dZZMH0hLaCxq/IFFI90QVbijP+SOQpT0feVkJl6OODFEvhfME6Vl22m1703DzuhEC
	ZXNRm7SKnZ/x5ilQ67KaxREq1M9S36rQY7/22hH9Y2Aw89LoDv/Iu1ebJOou592nnK1zaXo3yjr
	WL2H+unzmWMRd9Pg8jkBKpehT6zB+bsucZcwpGbxhmmN0qTm5O+xEtfZvFLpLKzsb89nZ5ZCPok
	cGfzqBqsyLzzcZsFLypYmZaT4ctmexsymA6UjTtunrAEc=
X-Google-Smtp-Source: AGHT+IGa8yfFS4/HioCoj5atiTDTumfJ0esnn6ABbbVVb4gFSnBkvjfvN1XVEejawK8KmayDSq77mg==
X-Received: by 2002:a05:6808:22ac:b0:450:bc8e:cfcd with SMTP id 5614622812f47-45a5c93f323mr10372985b6e.4.1768151568761;
        Sun, 11 Jan 2026 09:12:48 -0800 (PST)
Received: from newman.cs.purdue.edu ([128.10.127.250])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa4de8cbfsm10664316fac.3.2026.01.11.09.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 09:12:48 -0800 (PST)
From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
To: Zhu Yanjun <zyjzyj2000@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiasheng Jiang <jiashengjiangcool@gmail.com>
Subject: [PATCH] RDMA/rxe: Fix double free in rxe_srq_from_init
Date: Sun, 11 Jan 2026 17:12:45 +0000
Message-Id: <20260111171245.17759-1-jiashengjiangcool@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In rxe_srq_from_init(), the queue pointer 'q' is assigned to
'srq->rq.queue' before copying the SRQ number to user space.
If copy_to_user() fails, the function calls rxe_queue_cleanup()
to free the queue, but leaves the now-invalid pointer in
'srq->rq.queue'.

The caller of rxe_srq_from_init() (rxe_create_srq) eventually
calls rxe_srq_cleanup() upon receiving the error, which triggers
a second rxe_queue_cleanup() on the same memory, leading to a
double free.

Fix this by setting 'srq->rq.queue' to NULL after the initial
cleanup in the error path.

Fixes: aae0484e15f0 ("IB/rxe: avoid srq memory leak")
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_srq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_srq.c b/drivers/infiniband/sw/rxe/rxe_srq.c
index 2a234f26ac10..c527c1cbd4ec 100644
--- a/drivers/infiniband/sw/rxe/rxe_srq.c
+++ b/drivers/infiniband/sw/rxe/rxe_srq.c
@@ -84,6 +84,7 @@ int rxe_srq_from_init(struct rxe_dev *rxe, struct rxe_srq *srq,
 		if (copy_to_user(&uresp->srq_num, &srq->srq_num,
 				 sizeof(uresp->srq_num))) {
 			rxe_queue_cleanup(q);
+			srq->rq.queue = NULL;
 			return -EFAULT;
 		}
 	}
-- 
2.25.1


