Return-Path: <linux-rdma+bounces-4285-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BE294D0FA
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2024 15:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18AB71F22D68
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2024 13:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801D2195B18;
	Fri,  9 Aug 2024 13:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Eu2Fg5+g"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E787195B14
	for <linux-rdma@vger.kernel.org>; Fri,  9 Aug 2024 13:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723209366; cv=none; b=K4Nv2BbXF2t6jUXBC/gWMhVJO1TQLTyC2Zj4mN6+CjKIsU2R3RvLX0TY8btLFLY49dgS1jrdvACje/nnGnA1O3XnCOPlPq9VwgWJnZXUf8sgLkXpq6Y9r4hC6U2yHX9N2GVWu/Lwi+3ysYwf2ny76PpiVY5nIUBAWKYjwfS++ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723209366; c=relaxed/simple;
	bh=NHOZPA7FQFWYBrrm4XDDP7jjZga37iVxrWesXRzefvo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u0aLVTRuFFY9kJ8Lgy1Fec/LlTqTpIEdRld28/bISWji5DUyCHHf+lQW0vxTs12K8H2wwBlKFbtUWbVR8yfbJAE5jewAz///BB3mDs03Ll7tMT3irhibZHCGcn5fdKWWYNsLMPC7JTzu8IXsUkDLiAEfxLKnz0dG4FV9ihi87ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Eu2Fg5+g; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f15e48f35bso20647241fa.0
        for <linux-rdma@vger.kernel.org>; Fri, 09 Aug 2024 06:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1723209363; x=1723814163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ekWst1Xo947LcQ5w8RGs9hy6QKMdjD2JEkl1IhxRBGY=;
        b=Eu2Fg5+gZMDScKcIXoc2atMpcYunjNH7Cn3EoEmFgQsWCS0jjjU5at93dARRKm0RXd
         7tmK5Rr4kw5cy8QdGAzhQ6xa2BbES3h2hY8GNWADuQgc5wn0FtTKBIYy++Xgz9tnSbpr
         R8kF3thA1RCkrdnf84sJvGrowoe6AZW+H802Qa7JGkHOy16oqXThVFaFJ5BJHqPemBDz
         64CcSPLlHWCN464891bJgxfsgEUXf2U+RqaZV0KkEyRZb+UFduWb5cRAzO9FDPKwnHXg
         6nMuCv+CBfw1B/i/FbYGgfSJKQoqq5f5AccuQ6trCjiMNeOPn2XgBsxsq4cRHU+3XR86
         7+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723209363; x=1723814163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ekWst1Xo947LcQ5w8RGs9hy6QKMdjD2JEkl1IhxRBGY=;
        b=MZ7k7O+SzsVX6TrI1Gb3G5U1R/m6yYrcHcFvh2ukL22NxVB2xyrYT7IomY/4YKWT3Z
         /WvqEU93qv6qetJiUtOERHuYBm8CvgXBJDWm5y9ySOtshnF6XRdqY+Gr3P6cfMrbOU3M
         XvlnhR7XdX3UNqNPHiBJ/1jkv7ojOZGyrmd28U/6B08HtCJiYvD9FMSUB+EDoz4JXwhW
         di3WAPt7VlIjyRJ2w39k85kDolPur6getF87cNsQyxR4F5dti90pO93LOXkA3pKsPa8v
         FHYi/bzFy5Rc4U4FWrjncptSOs9RXlFFOw4HK8sh5iQtFSzZH2xb/1oyvyfDsXTJpwn9
         uUTw==
X-Gm-Message-State: AOJu0Yx7rUm4PubzvXWMjTHW0MHT0Bc79S0JWDd0ZdrihkgHoB/4htEr
	W+d7g84xCiofLjngjSOD8UaKLoAWtMMTrc453YuJDGND7v4d9/3OKFDtZWqW4zdD0ck9/Vm8ShH
	esQQ=
X-Google-Smtp-Source: AGHT+IEuOLWi7mFIp6IFy13DinFW+llzXDfxpgfP169ms/QzFtO4N0cdMMFaLzSYtI0docGmz5tM8Q==
X-Received: by 2002:a2e:b8c8:0:b0:2f0:25dc:186d with SMTP id 38308e7fff4ca-2f1a6d0038dmr13766611fa.1.1723209362497;
        Fri, 09 Aug 2024 06:16:02 -0700 (PDT)
Received: from lb01533.fkb.profitbricks.net ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c77f078sm78280625e9.37.2024.08.09.06.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 06:16:02 -0700 (PDT)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-rdma@vger.kernel.org
Cc: bvanassche@acm.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com,
	Alexei Pastuchov <alexei.pastuchov@ionos.com>,
	Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Subject: [PATCH for-next 13/13] RDMA/rtrs-clt: Remove an extra space
Date: Fri,  9 Aug 2024 15:15:38 +0200
Message-Id: <20240809131538.944907-14-haris.iqbal@ionos.com>
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

Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Alexei Pastuchov <alexei.pastuchov@ionos.com>
Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index fb548d6a0aae..71387811b281 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1208,7 +1208,7 @@ static int rtrs_clt_read_req(struct rtrs_clt_io_req *req)
 		ret = rtrs_map_sg_fr(req, count);
 		if (ret < 0) {
 			rtrs_err_rl(s,
-				     "Read request failed, failed to map  fast reg. data, err: %d\n",
+				     "Read request failed, failed to map fast reg. data, err: %d\n",
 				     ret);
 			ib_dma_unmap_sg(dev->ib_dev, req->sglist, req->sg_cnt,
 					req->dir);
-- 
2.25.1


