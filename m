Return-Path: <linux-rdma+bounces-12-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 850FB7F2DDE
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Nov 2023 14:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3B91B21A6F
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Nov 2023 13:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5935048787;
	Tue, 21 Nov 2023 13:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="BTzHuwt8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DB0198
	for <linux-rdma@vger.kernel.org>; Tue, 21 Nov 2023 05:03:20 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c878e228b4so33658961fa.1
        for <linux-rdma@vger.kernel.org>; Tue, 21 Nov 2023 05:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1700571798; x=1701176598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mcp3dLQQTP38Z2yPH0qP/O6KAs0emFU7a4oJCNHLsls=;
        b=BTzHuwt8/n7l+prYDMV2s2fwJsaW978Qmq3isw41Cn2dDqNuMT+gaiYvav2PHzcx6R
         zH369VbegR4M6HEf7GNK5jrT0CdZqx6uf4f2Cj2On+fNMuvEtQC+BWJKxuKAlQsCN+Qx
         OS4idwHwEngSTbTdp8CT9va40E9sgys8/HHskfC/QUhiF2BVYZU4OtXjVqmA5O4A/YqV
         cTC+fwXs5NxGvvHzfCMFEjgPVVd+i40PMieqII0yUpP1HChLdpelvyuCQZxTJwquuiUX
         cGeOaEmEYZeifhwD/mqDuwAB0gabV6wkiKKeNHnEyIEKFrQLYnKt+qvDOfUciQWodXy4
         16aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700571798; x=1701176598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mcp3dLQQTP38Z2yPH0qP/O6KAs0emFU7a4oJCNHLsls=;
        b=dkwsBej8nDhPPJhHhv3AOdeXhc8U7ftS6AO//5Q/utI/+UwgREVVjG+VikVIVY///q
         ghbMwS8nxwg1uakBuKdHJak+k5xt08g6a5xi0ZHLv95i00D4JP9m9fDlpzBat1oFmEcx
         VJj5Sk2qlqeq0FmPw0R9KOLBgriSETAKoZerbC5hs607Bjh/7KjXaP3n8srCsrpbs1YZ
         t5efHihM8Hg/hGy0ASF9QvgDMEXctZKXCXwAFscXUQXQjCd5j0cyo8itWQxod5IVNSfE
         v09hpRRPQJ0ypyL10p/x7vE9I6i4B//fl7MMvD9vmjc8uMdpmeTB/hBldZ+2iq4ACRfz
         Wb6w==
X-Gm-Message-State: AOJu0YyOGuqW3Utc3EvHZ/O9y3V5PVZeCBNf6yieG/4p5K03LNBYgaEf
	NExUQPItwlnLNQg9Ol0fPnwXd9Xj5ICo3a+7Epc=
X-Google-Smtp-Source: AGHT+IGGw3wrM08/K4+GCoT2L3qyu9L1J44+MUmizPj/ZA7ECucu8XlVKL2f/iVXtKNWs/dHlGBN8g==
X-Received: by 2002:a2e:98c6:0:b0:2c7:7b65:60b9 with SMTP id s6-20020a2e98c6000000b002c77b6560b9mr7299845ljj.4.1700571798468;
        Tue, 21 Nov 2023 05:03:18 -0800 (PST)
Received: from lb02065.fritz.box ([2001:9e8:1427:de00:2523:9f30:fa95:ba54])
        by smtp.gmail.com with ESMTPSA id bg3-20020a05600c3c8300b004077219aed5sm21949606wmb.6.2023.11.21.05.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 05:03:17 -0800 (PST)
From: Jack Wang <jinpu.wang@ionos.com>
To: linux-rdma@vger.kernel.org
Cc: leon@kernel.org,
	jgg@ziepe.ca
Subject: [PATCHv2 1/2] ipoib: Fix error code return in ipoib_mcast_join
Date: Tue, 21 Nov 2023 14:03:15 +0100
Message-Id: <20231121130316.126364-2-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121130316.126364-1-jinpu.wang@ionos.com>
References: <20231121130316.126364-1-jinpu.wang@ionos.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Return the error code in case of ib_sa_join_multicast fail.

Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
index 5b3154503bf4..9e6967a40042 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
@@ -546,6 +546,7 @@ static int ipoib_mcast_join(struct net_device *dev, struct ipoib_mcast *mcast)
 		spin_unlock_irq(&priv->lock);
 		complete(&mcast->done);
 		spin_lock_irq(&priv->lock);
+		return ret;
 	}
 	return 0;
 }
-- 
2.34.1


