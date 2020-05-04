Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1EC1C3C3D
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2020 16:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbgEDOCx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 May 2020 10:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728933AbgEDOCw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 May 2020 10:02:52 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A880C0610D5
        for <linux-rdma@vger.kernel.org>; Mon,  4 May 2020 07:02:52 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h9so10749883wrt.0
        for <linux-rdma@vger.kernel.org>; Mon, 04 May 2020 07:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=14fvy45UZp2tI9GhPNFr+nZliyDaQIiueuUCC9wqpt0=;
        b=hwteaOl2p7NwwUke6H4o6ER5tr+7LIq0WNKip5EP7laMqhObQuRUlWbchU+/cyuIh2
         n05XrmiBueh614RCCyw9eRsueZSXgzdv3dO+opxV6lK2cZJKjwRTNHhmtbQwaZ/QFHRm
         cPLU/gHhYyNniCuBcYYQ2jbrNgtADkwC9YgdTqgX6l/aHEdnJ0IvyUPG2HOed5MYrk3F
         5d2rcu+AeQY1HwYEjdBMa98rPOTIfmZjIx6k8OCtCTudg8c44HazVhQUiVP5iyB6NsBQ
         ME5ZjbnfBHbsgTwI4SdQ1KlaJ/Fcri6wt44S0u9QLU/3Y5Q9W9hJJWtYo3hQhedN59qM
         bbwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=14fvy45UZp2tI9GhPNFr+nZliyDaQIiueuUCC9wqpt0=;
        b=ChGu3NuNTegDHWwJnJb7a4LdedyrsughLxp8TAMAGIbwLuYcVVgtU98zqB/Tr1bQrf
         kb2WCMtHKgTm+q8WuqJl9Ip5KBV+iCNDrPeVjL0m+V4QnIbNPs4vtr+GGVQHecQtxAsk
         OhUWWQT43FEkDWT7Se5cCdE08nYk+IxUNANNvcTOpk+xeCrmPF7Np1f4wXSziaxxnxhk
         nPx5ODcwEJoQ0Agbtf50uMtv+rTJMnXw5mWEHYx/KU1mWGIxCU31vU58e1gxIFt5X8sG
         HGsOj5R6/bl6jd4khRkNwBLt9Xr/PAHB4tuCcR7IP5C9VSNDX5eyhqpCxELMqFcdnlqp
         X8ng==
X-Gm-Message-State: AGi0PuaxngMzm0kBE63I614xdjm6+arZl5V6Mhyu0LV59KbwNnyC35qM
        Fbm5po3l7q9BHWMzXkG7c8ty
X-Google-Smtp-Source: APiQypJLM4xnROIFFjHUvYOaFL8pyBNRDos4dqGS9MG5LGVJdgbIbnBA4yVeH6MVKKkr7EhbMK9Krg==
X-Received: by 2002:a5d:5189:: with SMTP id k9mr18946994wrv.3.1588600970959;
        Mon, 04 May 2020 07:02:50 -0700 (PDT)
Received: from dkxps.fkb.profitbricks.net (dslb-002-204-227-207.002.204.pools.vodafone-ip.de. [2.204.227.207])
        by smtp.gmail.com with ESMTPSA id a13sm11681559wrv.67.2020.05.04.07.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 07:02:50 -0700 (PDT)
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, pankaj.gupta@cloud.ionos.com
Subject: [PATCH v14 25/25] MAINTAINERS: Add maintainers for RNBD/RTRS modules
Date:   Mon,  4 May 2020 16:01:15 +0200
Message-Id: <20200504140115.15533-26-danil.kipnis@cloud.ionos.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200504140115.15533-1-danil.kipnis@cloud.ionos.com>
References: <20200504140115.15533-1-danil.kipnis@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@cloud.ionos.com>

Danil and I will maintain RNBD/RTRS modules.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2926327e4976..657093123663 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14459,6 +14459,13 @@ F:	arch/riscv/
 N:	riscv
 K:	riscv
 
+RNBD BLOCK DRIVERS
+M:	Danil Kipnis <danil.kipnis@cloud.ionos.com>
+M:	Jack Wang <jinpu.wang@cloud.ionos.com>
+L:	linux-block@vger.kernel.org
+S:	Maintained
+F:	drivers/block/rnbd/
+
 ROCCAT DRIVERS
 M:	Stefan Achatz <erazor_de@users.sourceforge.net>
 S:	Maintained
@@ -14587,6 +14594,13 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jes/linux.git rtl8xxxu-devel
 F:	drivers/net/wireless/realtek/rtl8xxxu/
 
+RTRS TRANSPORT DRIVERS
+M:	Danil Kipnis <danil.kipnis@cloud.ionos.com>
+M:	Jack Wang <jinpu.wang@cloud.ionos.com>
+L:	linux-rdma@vger.kernel.org
+S:	Maintained
+F:	drivers/infiniband/ulp/rtrs/
+
 RXRPC SOCKETS (AF_RXRPC)
 M:	David Howells <dhowells@redhat.com>
 L:	linux-afs@lists.infradead.org
-- 
2.20.1

