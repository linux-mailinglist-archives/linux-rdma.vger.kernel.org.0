Return-Path: <linux-rdma+bounces-2238-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E39138BAB71
	for <lists+linux-rdma@lfdr.de>; Fri,  3 May 2024 13:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FFA52853CB
	for <lists+linux-rdma@lfdr.de>; Fri,  3 May 2024 11:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B389F152DE2;
	Fri,  3 May 2024 11:13:50 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02338152501;
	Fri,  3 May 2024 11:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714734830; cv=none; b=cZGEA8NCrTqVFam/+elrJO0OPqQf6a8nq55Vtxmot4ycIupQANBG4KSWxpJGQ1CMH76doCT+vVKwPqvP48rVafGOqvpfHnYIjeIqFSTdY25iGLW5Rg4k6JzGOp/BD61lUE2pFKmgqTs2R6Gr6N1E8yKGQ+JDrLXlE7SOse8P2pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714734830; c=relaxed/simple;
	bh=cBAnSrJnc6T/6zNafgNMQ/ABTJTYXNZjAnbvdO0IzV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AyQXtvUVq8qHynWkZKVY6zsgUcNO6zJrlTIm6y89vCq9zflS4vAFafQVTlNeIQ6mDeCRkzLbzM4VntU6IMp3BET7ZO/sYReynqgR9wdki33s31bLrNfQ8uW0P6bm9G9azv2GXauz2mxOSku7LaaaRIjw2G4r56fruya6NP3y82c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51f2ebbd8a7so1966521e87.2;
        Fri, 03 May 2024 04:13:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714734827; x=1715339627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tXrwZ21nOmfdZ6s+4+0+abMwpM7qqm9U6gzSaZhDUoA=;
        b=Dzh+BpxDheC1SNa7XXwl2lsVtWMX65BPqD+x6nf6mVCFPTR9SRwihNDg8dcUgg45Rb
         61YgcMNwp2bp9oaqvdx3i1u9jjcQ+t1n3+uHR2nU7kJjVx7cfrSjtL4TGxvofhrF+A+Q
         S5Yf+nkSiEV53czVsVjppruE0EeePheKWFpe5xfoqrvmvNaEpYCtmVBzgdWScTT78Qgi
         4faQRhzrbCLUc6ysRlKxXhkXu3v3BhNFIcqP2SrCCZA4IPry1C8o55BgEAeMZ7h8MUhB
         9zNH6Xq3rKtU9JxL4t1s5Z7z7+jbZ6hT7Hj1eDSU3vhxxIqvnUu1tn/fOYF1dkbp+Pxo
         vHyg==
X-Forwarded-Encrypted: i=1; AJvYcCVaZg+BnO/USJdDRvyhW3y1gNWbFoFI1OaBqKJFzFmvDJYhIWXBxmusvM0zfOaFJHZJ8fYt2I7lmbePfbAVY0X63HLTzM37opuxxK10lJ+yAlNcJN0ddMsAck/Y96+wdSXPTJcnvLM3MA==
X-Gm-Message-State: AOJu0YxypucTGQxncBI2lpqJFaT7+w33vj0bXppgJJm0G/5/fUGgItot
	61XVq/mEDn3BFxszyKD9QbQF3lnR4sqsfa5yO25bg1Dw1YKsBm1Whe2I5Q==
X-Google-Smtp-Source: AGHT+IEUl31PUP0o+zgIUWrcD8hHrz20gaWcHnLIVz23yLtxDK3jNpocByejvyBLY2zoBc9JYNu23A==
X-Received: by 2002:ac2:4e98:0:b0:51d:497e:83d6 with SMTP id o24-20020ac24e98000000b0051d497e83d6mr1550812lfr.20.1714734826772;
        Fri, 03 May 2024 04:13:46 -0700 (PDT)
Received: from localhost (fwdproxy-lla-117.fbsv.net. [2a03:2880:30ff:75::face:b00c])
        by smtp.gmail.com with ESMTPSA id kt14-20020a170906aace00b00a5995900bd7sm441878ejb.192.2024.05.03.04.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 04:13:46 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org (open list:HFI1 DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 2/2] IB/hfi1: Remove generic .ndo_get_stats64
Date: Fri,  3 May 2024 04:13:32 -0700
Message-ID: <20240503111333.552360-2-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240503111333.552360-1-leitao@debian.org>
References: <20240503111333.552360-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 3e2f544dd8a33 ("net: get stats64 if device if driver is
configured") moved the callback to dev_get_tstats64() to net core, so,
unless the driver is doing some custom stats collection, it does not
need to set .ndo_get_stats64.

Since this driver is now relying in NETDEV_PCPU_STAT_TSTATS, then, it
doesn't need to set the dev_get_tstats64() generic .ndo_get_stats64
function pointer.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/infiniband/hw/hfi1/ipoib_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/ipoib_main.c b/drivers/infiniband/hw/hfi1/ipoib_main.c
index 59c6e55f4119..7c9d5203002b 100644
--- a/drivers/infiniband/hw/hfi1/ipoib_main.c
+++ b/drivers/infiniband/hw/hfi1/ipoib_main.c
@@ -96,7 +96,6 @@ static const struct net_device_ops hfi1_ipoib_netdev_ops = {
 	.ndo_uninit       = hfi1_ipoib_dev_uninit,
 	.ndo_open         = hfi1_ipoib_dev_open,
 	.ndo_stop         = hfi1_ipoib_dev_stop,
-	.ndo_get_stats64  = dev_get_tstats64,
 };
 
 static int hfi1_ipoib_mcast_attach(struct net_device *dev,
-- 
2.43.0


