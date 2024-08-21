Return-Path: <linux-rdma+bounces-4453-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6D0959A7B
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 13:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E1D61C20842
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 11:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375AD1C4EDC;
	Wed, 21 Aug 2024 11:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="MVHtzwWJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96A81A284D
	for <linux-rdma@vger.kernel.org>; Wed, 21 Aug 2024 11:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724239402; cv=none; b=M5sGl/f8/PbC23WOlBxD+x9jtfzP8EAm9k7IIdDD9w9NX3sKUXi6VGv6asQSJ1WvYoa8PZymhm5zo94Z1HoPoqePBfNulNcgYm+rKcWRcMkwoogDwpM+PpY5357GLXzuEU8aY4OZoRq0F0HzoGpvZNnPifp7OXZyP+31fbCvDZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724239402; c=relaxed/simple;
	bh=aPdeol5t6wwSSHxVfJDH5JF9MYqzC9pPQihHi5HNRHY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q7lO46Wv8/ecGjJ1y2lxJSDE44sokl8hTSbQcJL3Ti3TA+lGK7nyRfpi1Iym2eVl0ismvXwnQSAlP1Oq2m77SPM3CaEHir04d/6WFO9jKiU6a6cxgDzgMxyBeqHyD+nkwSD99LV97RK78MxmUBZ6qxrvsIxjw1WAXwmx4syBUCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=MVHtzwWJ; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7d2a9a23d9so762913666b.3
        for <linux-rdma@vger.kernel.org>; Wed, 21 Aug 2024 04:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1724239398; x=1724844198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qJ3V7YJGTaGdVFsVivjHiBFvmyNekMesA0jctJoY0g=;
        b=MVHtzwWJ2QrpQ0kwR2Ll5f5O5B6SP9LRpM4+xUAuBH9Ohh+ofcqrUg9giHEp/TxqUs
         YTOFIGDgto4YkJznqt4X2sMX6iqOb08wobMXiP6yxFhvyeMi8KIgGW088f2gMqJuv4mk
         FWkxJedPHYpFKb+Ts2VryoI35LdfIB1ggHtHAKoGxZvkNooXncIQ6TJbA2+FKssEP3fk
         pYm1Bph7cP1DJKNJ5bXebw/c6DH9pk9mYBJzTL54zDPB8z/O5e588s76gGCjCggtZ+uh
         +oC/bTaQ8S3OG7RWeogHtDdtCoYaGLRdI/Rfy1JC3x/3qL/Gwxu/OEfTE9A2LkqwX7wM
         W1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724239398; x=1724844198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4qJ3V7YJGTaGdVFsVivjHiBFvmyNekMesA0jctJoY0g=;
        b=JJZx9LH3DQ9wS2oocNk7ulNuT/AoiSgzkZ/hHvlStwKYDd49EOhNxcpdxxyH4/sE7N
         6JPxRlMAvGCbUPeAa6GD9+W6hfKW67A5RTKzutgCqS28OW/PiTNipoL72nmqw03lGmax
         YXinvtD6N2HWYzKO/AFl7isdlvSkmrhvbeLNTbvnmWoPRXRk9n376p+1UjLllE5w8fvF
         3F0YhuOTrByZAmwOg65KFGy8J6qVp91EAOKpTeo+Ge6aIlWcpNPvlN1wZz4XcWuEurH9
         Z3QpqGi7FR+eE76IBAwNZt7aZ5+TifDI+ifTKmEzsuBQPHGCBbjdcLUDSRUEdbhS67jl
         vnJg==
X-Gm-Message-State: AOJu0YxY+E/RRItALAo1gZ4NkeA/YUyQfRscHzVKlHeBLyBDAShAwvnJ
	npjM0FoeWcsXtuYXAohffghJxsu0ewn8hdi/0h+0qtMLwxSbcGIM5T0IN5DFxUJSm8jDpYCSHKe
	9iZA=
X-Google-Smtp-Source: AGHT+IFo3xr/2wRjH9B573sMM/AsBH1F846a16X87+m+NYa2uTqYpAyZHAHIfbC6knOzxIbj+tbz2g==
X-Received: by 2002:a17:907:9706:b0:a7a:a06b:eec9 with SMTP id a640c23a62f3a-a866f11c1a5mr142347266b.4.1724239397581;
        Wed, 21 Aug 2024 04:23:17 -0700 (PDT)
Received: from lb01533.speedport.ip (p200300f00f051d5f269a60e7b8956185.dip0.t-ipconnect.de. [2003:f0:f05:1d5f:269a:60e7:b895:6185])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c65e7sm887934066b.20.2024.08.21.04.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 04:23:17 -0700 (PDT)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-rdma@vger.kernel.org
Cc: leon@kernel.org,
	jgg@ziepe.ca,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com,
	Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Subject: [PATCH v2 for-next 02/11] RDMA/rtrs-clt: Fix need_inv setting in error case
Date: Wed, 21 Aug 2024 13:22:08 +0200
Message-Id: <20240821112217.41827-3-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240821112217.41827-1-haris.iqbal@ionos.com>
References: <20240821112217.41827-1-haris.iqbal@ionos.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jack Wang <jinpu.wang@ionos.com>

In some cases need_inv can be missed for write requests, additionally
driver has to handle missing invalidates for write requests. While at
it, remove the else case from write invalidate path as it is possible
to reach there.

Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 66ac4dba990f..d09018c11ece 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -391,11 +391,12 @@ static void complete_rdma_req(struct rtrs_clt_io_req *req, int errno,
 	clt_path = to_clt_path(con->c.path);
 
 	if (req->sg_cnt) {
-		if (req->dir == DMA_FROM_DEVICE && req->need_inv) {
+		if (req->need_inv) {
 			/*
-			 * We are here to invalidate read requests
+			 * We are here to invalidate read/write requests
 			 * ourselves.  In normal scenario server should
-			 * send INV for all read requests, but
+			 * send INV for all read requests, we do chained local
+			 * invalidate for write requests, but
 			 * we are here, thus two things could happen:
 			 *
 			 *    1.  this is failover, when errno != 0
@@ -422,14 +423,6 @@ static void complete_rdma_req(struct rtrs_clt_io_req *req, int errno,
 					  req->mr->rkey, err);
 			} else if (can_wait) {
 				wait_for_completion(&req->inv_comp);
-			} else {
-				/*
-				 * Something went wrong, so request will be
-				 * completed from INV callback.
-				 */
-				WARN_ON_ONCE(1);
-
-				return;
 			}
 			if (!refcount_dec_and_test(&req->ref))
 				return;
@@ -1146,6 +1139,7 @@ static int rtrs_clt_write_req(struct rtrs_clt_io_req *req)
 		};
 		wr = &rwr.wr;
 		fr_en = true;
+		req->need_inv = true;
 		refcount_inc(&req->ref);
 	}
 	/*
@@ -1164,6 +1158,10 @@ static int rtrs_clt_write_req(struct rtrs_clt_io_req *req)
 			    clt_path->hca_port);
 		if (req->mp_policy == MP_POLICY_MIN_INFLIGHT)
 			atomic_dec(&clt_path->stats->inflight);
+		if (req->need_inv) {
+			req->need_inv = false;
+			refcount_dec(&req->ref);
+		}
 		if (req->sg_cnt)
 			ib_dma_unmap_sg(clt_path->s.dev->ib_dev, req->sglist,
 					req->sg_cnt, req->dir);
-- 
2.25.1


