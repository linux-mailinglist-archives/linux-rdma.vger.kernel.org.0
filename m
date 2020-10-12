Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F38528B5E5
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Oct 2020 15:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388233AbgJLNSX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Oct 2020 09:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388160AbgJLNSX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Oct 2020 09:18:23 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8C0C0613D1
        for <linux-rdma@vger.kernel.org>; Mon, 12 Oct 2020 06:18:22 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id e22so23151597ejr.4
        for <linux-rdma@vger.kernel.org>; Mon, 12 Oct 2020 06:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I4+0xyavodLU51SOqdhqvo2jHIogAkTTKnDKf7hTwIE=;
        b=ExPxvdfxCZtAzG9GxKs0X79WfLwNxJ78VtYZkrSgiwyYF8+lj+dIav/NFP6FQySmwq
         +JheOK8uWOUccnm3R1dr3/Ds+oFYSSfBOfPbKqhLII2kaoOOu8IXycciWehHUq1cwmwY
         cUcUgDMDnz0zP/DFrVREp1ZxjAZJgqok58Z1xnfApsCIuQl1FHAY6dIfybJwpkws+YSM
         T38CPq1v7Emw/D/YA0gqHUlMb6QyIsXOpxYViUrAxsVgZQuhDbN7NqYNOocrInckUcHb
         m5d+kUDvI/RCkM33mm47hCnn+l17aI8zREgWgM4SM1MtreBNjTNAbQ4iVTABz8JpuI1g
         nKsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I4+0xyavodLU51SOqdhqvo2jHIogAkTTKnDKf7hTwIE=;
        b=bQPsaUfi4GcUJuxCxxaDDKa9KhqMxurgqY8ClBKnd3lhkBCJG6J4jWd3LkjVeTPQQQ
         fJ7fo88wlPpnYUUw0CCgQ0hnd5Qv+i22gYAm4YLVdvDELPcXbOeGCbHKS3ELXSrDIet1
         PV1L7qpSOOGvVNIswnfokJjLdm+o2/WfSjWGX0KY6vENuZVH3AGMstsHkRFN9je+sHX6
         Yig+Bi2/VE7ItVGHRQ0UZI6i2PtL7S2MaVIfDJk0+dMie3KDgjXjmNzwiHRfW5en/8g/
         c67g9ILiNUMeqqlZyhhlebLD02TPbNyoCRn8jICtcYH8y31hXHsl9JH4cv4zoHPoALCr
         GNPA==
X-Gm-Message-State: AOAM531BQN7vsQpGyYIFZL7FbIs9c/9CBxrly2Nn+yptO7WQttogMB3K
        FPSESGXu0BpzF0eWjF6tTBuGiqXNgG3Gtg==
X-Google-Smtp-Source: ABdhPJzAw3qBfq93L/xUSI4zgwo3ALpCzAo6aaGCCCkauikmYYAaA/omAvWwfOvuVO3qXhETxvIkeg==
X-Received: by 2002:a17:906:f151:: with SMTP id gw17mr9394318ejb.119.1602508700952;
        Mon, 12 Oct 2020 06:18:20 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4915:9700:86d:33e0:2141:a74a])
        by smtp.gmail.com with ESMTPSA id o12sm10828252ejb.36.2020.10.12.06.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 06:18:20 -0700 (PDT)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: [PATCH for-next 05/13] RDMA/rtrs: removed unused filed list of rtrs_iu
Date:   Mon, 12 Oct 2020 15:18:06 +0200
Message-Id: <20201012131814.121096-6-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201012131814.121096-1-jinpu.wang@cloud.ionos.com>
References: <20201012131814.121096-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

list filed is not used anywhere

Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-pri.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-pri.h b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
index 287ff78921c7..7821ac4e827b 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-pri.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
@@ -114,7 +114,6 @@ struct rtrs_sess {
 
 /* rtrs information unit */
 struct rtrs_iu {
-	struct list_head        list;
 	struct ib_cqe           cqe;
 	dma_addr_t              dma_addr;
 	void                    *buf;
-- 
2.25.1

