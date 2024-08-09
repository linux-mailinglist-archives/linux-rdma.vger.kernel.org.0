Return-Path: <linux-rdma+bounces-4280-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B0D94D0F5
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2024 15:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CA631C20F17
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2024 13:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0562195962;
	Fri,  9 Aug 2024 13:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="aLToIZvU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34FF19580F
	for <linux-rdma@vger.kernel.org>; Fri,  9 Aug 2024 13:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723209362; cv=none; b=M2rYQRfvTmMIVwoJVa/JEWikaSrEMmQ4sYl72NEyDqvWfnJLnzJMC/K8MUdzJunIvBhzBw0ndf8klpXVucv1Ljm8QymKdFun/+Y8QrPfZbrk/xPiJcbzoigp5tooRykkXHE4/ro9u4BwS19zlxq4xgFG8zRkwA0rgVOe/qkMx1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723209362; c=relaxed/simple;
	bh=WRV7DY/vIWFiZ3gU6V1V+cCtOFglJblnZJhmSfbRmuY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E7MVeljPZq/aFJREkKDtT1IxeMlXUnXrKHyE8rFFVeb3dTtyVHQEik3NJM462mEX7VMPzylPn3x2zW7vRpnJDSPkH1YaFB4P7JJ4WlDs7kr5GuGjlYWqBumUKArJH5igFfc+FsE83WmwIlQZqHSVvZMQP+omt2zSdqqeA69deNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=aLToIZvU; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42817f1eb1fso13873075e9.1
        for <linux-rdma@vger.kernel.org>; Fri, 09 Aug 2024 06:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1723209359; x=1723814159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+XXHfR6ei5DWieETKO7ps9vaiG5tNzbNEBSlnAsZkFM=;
        b=aLToIZvUao40ePz+phS6m3v09/MBaBNLc6XevK+cuxteGGW3hygR6Us/INPmH5XGxW
         tUIL/hH9/NCiGh5MEF8endQ8giwrD9ECCQzXxpft1MOB0bmAmTr6w4g1aKIbHi2wexHY
         IAn/buOGekuv43m3ErGhlZv3b3A8kRkzNQPPorOfCP7xV5hRCMDlwAdnChUFyiYhPRHw
         0qzRo0zCWQFXtCcp7gSv211Vu5b5IyP50gqO5TVqHWa02rl2mXseyyS11xj2Y5708Mau
         QmY61NV7oCm/WZcLmF5vTDlApBfCiIugSaJj/vKpzRq1tkcGXp9NqqBUoPSyM1KfqHom
         9VMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723209359; x=1723814159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+XXHfR6ei5DWieETKO7ps9vaiG5tNzbNEBSlnAsZkFM=;
        b=wdToHw+QJpQtVrK6E1UMXwA8yMNAsuGY1jV9cmjx/LLhIDildIlX+/BF7Qei0r7TgA
         s0faT306VIm0eSS1yz3HU7SfLgwZNkGTynUSDxaAaoxDjQiaBQclLsjxGg/TU7pEzwhB
         SgRZLdltqIxssX2tKe4+2Hl4cUYE4+neMLJjWuhVBcQme8ITI4BurYykMyPSwr0jHqaU
         35jzg+2btQFfZiCc1CMtLdkX/Idgyv3qxXJdZ3vcQqZ0s66mi24Acmm2l+yFZyc1QFQd
         hW2+LUYqbjZyN5LlHmKId7Y9puEcoZ8Vu2YCnRTPKvgkPA4Us8dwZoxUbMVOs+83+Gwe
         oHBw==
X-Gm-Message-State: AOJu0YxAA8cANyLHRjcFxSL5MLwmCz1mEVA2StWYxaKVc6HI1SizXIo+
	7iCK6jvwZP5O1F1T/wHHyyYvHVFE5lZIH6rBh2Ekgcy6mx83iPH+Y5QU+sOBM58LP3VZtBBl7IP
	ucDY=
X-Google-Smtp-Source: AGHT+IFOy/Vp1or3cPmYTvwJRTcH+PWPhvz/v7WX2cpz3oAkiABEA+9m0lWzfee0JDQvtSz+n9zC3g==
X-Received: by 2002:a05:600c:4708:b0:427:dae6:8416 with SMTP id 5b1f17b1804b1-429c3a56c64mr10586625e9.36.1723209359181;
        Fri, 09 Aug 2024 06:15:59 -0700 (PDT)
Received: from lb01533.fkb.profitbricks.net ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c77f078sm78280625e9.37.2024.08.09.06.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 06:15:58 -0700 (PDT)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-rdma@vger.kernel.org
Cc: bvanassche@acm.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com,
	Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Subject: [PATCH for-next 08/13] RDMA/rtrs-clt: Reset cid to con_num - 1 to stay in bounds
Date: Fri,  9 Aug 2024 15:15:33 +0200
Message-Id: <20240809131538.944907-9-haris.iqbal@ionos.com>
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

In the function init_conns(), after the create_con() and create_cm() for
loop if something fails. In the cleanup for loop after the destroy tag, we
access out of bound memory because cid is set to clt_path->s.con_num.

This commits resets the cid to clt_path->s.con_num - 1, to stay in bounds
in the cleanup loop later.

Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index e1557b0cda05..777f8e52ed7c 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -2347,6 +2347,12 @@ static int init_conns(struct rtrs_clt_path *clt_path)
 		if (err)
 			goto destroy;
 	}
+
+	/*
+	 * Set the cid to con_num - 1, since if we fail later, we want to stay in bounds.
+	 */
+	cid = clt_path->s.con_num - 1;
+
 	err = alloc_path_reqs(clt_path);
 	if (err)
 		goto destroy;
-- 
2.25.1


