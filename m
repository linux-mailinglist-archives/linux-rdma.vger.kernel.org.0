Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98464357F36
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Apr 2021 11:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbhDHJc3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Apr 2021 05:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhDHJc3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Apr 2021 05:32:29 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6085FC061760
        for <linux-rdma@vger.kernel.org>; Thu,  8 Apr 2021 02:32:18 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id u21so1840442ejo.13
        for <linux-rdma@vger.kernel.org>; Thu, 08 Apr 2021 02:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xP2qq76pr5MABRFct2AeqEMZEp1slspgFWSdVclXA/k=;
        b=dk37T73eKxMAzQ9myar3XUqzF18c3maUcAAzcUxRAZjqM0h4b3Bw/vggXglGyDPxQs
         Fm7imc94AFp815UDEOnzUceyhK2NRmQs5Tnkd6E0qnmE6jN1ukq3y0HsJ2nqwnO5itxO
         5F+GP/08o5Dh3kVQjdo6VJkDGwydJh0AAKU5wUK7e4v7W+qN9LKNpIssQJzBdwWcgw8y
         X5n4jgtkSOxkMgxM/Q+I5NFNu/kqCQLZvR6vs7F9loNEmMshtzYWrkpuXMuBuAeQO0dA
         YJ4DbOmdVnZM7q3i/TWbQkbEHpFEnsW6yFsPc7VAV3199JM+xfVIZFG/V4nu3pDmDSEX
         iQNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xP2qq76pr5MABRFct2AeqEMZEp1slspgFWSdVclXA/k=;
        b=CTtkRD6FGkqtNmicX2Qx6tG8g8j+rrKX8iMkSkR66SKL8hmlQkCvsypcV9e5w5Rxcn
         dM+US1h/meY21sJYVooQFdnBOIaZfkQkRPb5rs6ESK0kKb+citaFQPv0pmJHofYLD0CU
         PbiadDVOcnBnfNdbNISJY72BNLrTRYIcRkvQDpeEv4yIqjYZf4xkeuC814isppFVzYEp
         gNcgToRcCsDsLonQF9Z334LvH9AXQyfCD3wv7AkguV4RTlkBC+GhqnmOkmNubKiF9m7c
         /5Ua3dQV2mQyI09Op4Ic2dlwtItkJUN4hopf6vItp11U5GzSUJRpuM/t57OJiWz4lcEx
         Gffw==
X-Gm-Message-State: AOAM531K3mXtT7CokgguYT4MX4x1aMwKQCy/Fa2wS4rG+ho5aBTzbZ8B
        TcsKmrscha1T6v82mCxvPqUf5fTvELyxcA==
X-Google-Smtp-Source: ABdhPJyAwdjjHGY3K/LNfxRFDnqeg27G9MsBJuIFrib8OTG2lGT0W0fRdXQSJkj1mZgn9wftkiuXbQ==
X-Received: by 2002:a17:906:5951:: with SMTP id g17mr8850067ejr.152.1617874336982;
        Thu, 08 Apr 2021 02:32:16 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4915:d200:c1e9:172b:fc28:18a5])
        by smtp.gmail.com with ESMTPSA id d1sm13950206eje.26.2021.04.08.02.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 02:32:16 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca
Subject: [PATCH v3] RDMA/ipoib: print a message if only child interface is UP
Date:   Thu,  8 Apr 2021 11:32:15 +0200
Message-Id: <20210408093215.24023-1-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When "enhanced IPoIB" enabled for CX-5 devices, it requires
the parent device to be UP, otherwise the child devices won't
work.

This add a debug message to give admin a hint, if only child interface
is UP, but parent interface is not.

Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/ulp/ipoib/ipoib_main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index e16b40c09f82..df6329abac1d 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -164,8 +164,13 @@ int ipoib_open(struct net_device *dev)
 			dev_change_flags(cpriv->dev, flags | IFF_UP, NULL);
 		}
 		up_read(&priv->vlan_rwsem);
-	}
+	} else if (priv->parent) {
+		struct ipoib_dev_priv *ppriv = ipoib_priv(priv->parent);
 
+		if (!test_bit(IPOIB_FLAG_ADMIN_UP, &ppriv->flags))
+			ipoib_dbg(priv, "parent device %s is not up, so child device may be not functioning.\n",
+				  ppriv->dev->name);
+	}
 	netif_start_queue(dev);
 
 	return 0;
-- 
2.25.1

