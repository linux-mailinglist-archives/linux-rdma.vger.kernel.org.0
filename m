Return-Path: <linux-rdma+bounces-710-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3405838C1B
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jan 2024 11:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5418F1F26530
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jan 2024 10:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26A75C60F;
	Tue, 23 Jan 2024 10:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWgu091l"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237EC50A77
	for <linux-rdma@vger.kernel.org>; Tue, 23 Jan 2024 10:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706005984; cv=none; b=YGIiFUXpe/VEkjzZyMumotFn3U1tG31otDdF+PRUD8H1/PeSThX78pVExGfmmZgF7INmm4uLSfYFfMpjgQRVd0O00Z2529egkww97Q6pOtWm24tM/LDG1mzlQuozkNGqMQCx2VL2ZxPcGubHyeOTvFnppHe8HxhEQWfmjHYEcQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706005984; c=relaxed/simple;
	bh=wxouJFnR87n7JhNRDFwA631Erh6tDQvMjOlAC3Lke/E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GX8qWTFIbbT7FwVjh/sohlx1/o6O481fJCmqMAfZvT1Dn7ZYRavv+R72uLC/p/TwOdnlIGETiSXSNKD4TN/G8BfAh/vwzpjQPeOwI66RZLCkS8MYMuvrMy52WBxNAxj0j0+0lV64hxoQ33yKfuo2EwacwfhIxkBhFGrKh/Gf3uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWgu091l; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40e9101b5f9so46474525e9.3
        for <linux-rdma@vger.kernel.org>; Tue, 23 Jan 2024 02:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706005981; x=1706610781; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3PJ7HCPeId6jFeObfo3g/5X1jrYy5JAxavgqHcIzrkc=;
        b=XWgu091lUwxBFzcI0CPLG5+Lod4zqf+2Nh+JD05561onEjK2TWjAkNy4A8TJamKHYF
         h0U0Y6GPx9eo5iSvrJdRv6W4OU5zSrNNXdFkl0usxf/QlxjIPoBBNTSt0KWVLdLNkAjd
         K4v2TgXI5I0uAAFN1seKd9KvtrPDoznSDuEbiWRdrFJAba4Yf27yEUBJLdr/mqZ+y0Oh
         ENlW3uN9H0LmJLfA5MUsdpZRmNc0aIrTIpxivBnZJm/NOnwhmqiUuvRGbC3+HMc7QeRA
         7ZJCzq6UNpLpqpQaeonj9u5DqANa/I0au1crwNHDGrwN07U4+ZkYWD9yGgws2qAEIBUi
         2GTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706005981; x=1706610781;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3PJ7HCPeId6jFeObfo3g/5X1jrYy5JAxavgqHcIzrkc=;
        b=WOqg5z/ICilKhejSji7mAxmA1XxgYEVTIclrzX2o3WapL2lvhTrVK2CvuFyfPEFxFn
         P+2kTSJyE5rmL1CAkT/BaxKRTbMy5FfuQ9SdWpNO3G8IHTy6Ot4viOxb0uowogWHDmQL
         CCHWgapQrvRgClV/KQegVKifOaC+HNXbjcTNKfdq8Hu8HbU5G0avsv9iB7eHpN9RRjdA
         BFW8+6/Td0dz/6FoJDOhdquwcGL1G96onkQylS6aVsIoIL+E8y3FV/oZzIHTqDALNRE/
         a3A71pF+LB/cAG7VsBxlQ49o+vPL5qPHvFQ3sMirSQvtr65kahnl3DY2i62U2YQZJBrC
         09eQ==
X-Gm-Message-State: AOJu0YxOyshEF8t6cGQfPwHYPU9dIwRCLuJfNbVFMBEIskgNWrLEEM3F
	5g8z2sUCKftQCKch94xs/V4f/FA13NW0pLJaRiurXf1eFZoYkaZl7Qhrx3KEwQ==
X-Google-Smtp-Source: AGHT+IF9uqcU6yGWNNkfXWkWqZ0WbOEkVKJZez7+ywZsEXGmtCIiWi4uSOr29kuQS17BjsDTGw3zfg==
X-Received: by 2002:a05:600c:1d98:b0:40e:61ba:5ebe with SMTP id p24-20020a05600c1d9800b0040e61ba5ebemr386982wms.119.1706005981250;
        Tue, 23 Jan 2024 02:33:01 -0800 (PST)
Received: from p183 ([46.53.248.133])
        by smtp.gmail.com with ESMTPSA id be13-20020a05600c1e8d00b0040e96a98762sm16236285wmb.17.2024.01.23.02.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 02:33:00 -0800 (PST)
Date: Tue, 23 Jan 2024 13:32:59 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Potnuri Bharat Teja <bharat@chelsio.com>
Cc: linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH] cxgb4: delete unused prototype
Message-ID: <a67881e7-469b-43d9-9973-ad7579eb2c4b@p183>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

c4iw_ep_redirect() doesn't exist (and g++ doesn't like it because "new"
is reserved keyword in C++).

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/infiniband/hw/cxgb4/iw_cxgb4.h |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
+++ b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
@@ -930,8 +930,6 @@ void c4iw_id_table_free(struct c4iw_id_table *alloc);
 
 typedef int (*c4iw_handler_func)(struct c4iw_dev *dev, struct sk_buff *skb);
 
-int c4iw_ep_redirect(void *ctx, struct dst_entry *old, struct dst_entry *new,
-		     struct l2t_entry *l2t);
 void c4iw_put_qpid(struct c4iw_rdev *rdev, u32 qpid,
 		   struct c4iw_dev_ucontext *uctx);
 u32 c4iw_get_resource(struct c4iw_id_table *id_table);

