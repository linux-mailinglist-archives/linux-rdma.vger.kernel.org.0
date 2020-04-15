Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8255A1A9890
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2020 11:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895426AbgDOJXh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Apr 2020 05:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2895417AbgDOJXT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Apr 2020 05:23:19 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EFBC03C1AD
        for <linux-rdma@vger.kernel.org>; Wed, 15 Apr 2020 02:23:18 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f13so18216890wrm.13
        for <linux-rdma@vger.kernel.org>; Wed, 15 Apr 2020 02:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+lzbi8aK38U3+DnvnY6rCKYXK2X3LSq1Bs0xPjQHnEY=;
        b=IhRTjTDz7EJWFq9QmsxzQIXFo/Rz3p94HTg5QUIce2pHs0vR3K/yQlWoDkJjT7He0Z
         xRnivZ/Znkw7AR7UZS6EvUSTJY9YeFboUWxVV1VjtXTiprve5IVpyGRptJE+8C3tBH0/
         tgkpnAjMv3N4JiZRQ5Mr+W+Fji7QVJn1rwXgHnJbYwWK6V/GoCpM/Ci6daZx62Moh+Lm
         IRLgxB7s3VdZUjGuqH70CDCrUcxhyqHZXGuASdLZca4OrXD017gWVnF+KU585tMXB+YE
         24sCXYIC4zPEfv/B6eH+75F7xLSJ/p6tY2Kod7H0tPDoR2GZNZ6yhp6Rh6eYbUAzQOhT
         OwvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+lzbi8aK38U3+DnvnY6rCKYXK2X3LSq1Bs0xPjQHnEY=;
        b=OpfsSiZgrmeYidD2jkyQSbiFCiii3oyDjH9kCauRe8N8u8weei8mXY5BUC0PcRLOLk
         H5WEj0T2uIq24gjFJG2EGFjxtP9MYufP4fvUseNRvwyGecL1YN6Dol77+4gW1doUXDrL
         R6NFzQDIvdURPUwIDYp3CLYMTlZt1BD9k4WViYvlaYqFVWggkmD69brop15Dgj1xPjB9
         gjJZdV3gVojG+eW0ndtGLdCSlZlc7FR9NAmVhB8EvykI1UTXxqr2XZ+Fut0/RXCGf8pQ
         81n3RdGFs3IRGYNlhBYSzsItGzJHwKtYwcMPSVFzVNxQoLtd9Xk+bYW/dMLzyY0uFvU/
         AMTA==
X-Gm-Message-State: AGi0PubCPYZGW0+uEOcA8/Yl26rLyce95Al7g/piP0E1Xk1jD4noeo3+
        5bG3RqqXDOjnbzG28sOi+ouw
X-Google-Smtp-Source: APiQypJ3GJM0/+2P/AexxwNZcsOmkayjLCRqYin26oqaGvC5I/yiPcNjbwDbLtPAlMe8SMno++ygnQ==
X-Received: by 2002:a5d:50c9:: with SMTP id f9mr9515274wrt.191.1586942597275;
        Wed, 15 Apr 2020 02:23:17 -0700 (PDT)
Received: from dkxps.fkb.profitbricks.net (dslb-002-204-231-072.002.204.pools.vodafone-ip.de. [2.204.231.72])
        by smtp.gmail.com with ESMTPSA id v7sm22534615wmg.3.2020.04.15.02.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 02:23:16 -0700 (PDT)
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, pankaj.gupta@cloud.ionos.com
Subject: [PATCH v12 25/25] MAINTAINERS: Add maintainers for RNBD/RTRS modules
Date:   Wed, 15 Apr 2020 11:20:45 +0200
Message-Id: <20200415092045.4729-26-danil.kipnis@cloud.ionos.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415092045.4729-1-danil.kipnis@cloud.ionos.com>
References: <20200415092045.4729-1-danil.kipnis@cloud.ionos.com>
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
index e64e5db31497..8031a923e5a5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14448,6 +14448,13 @@ F:	arch/riscv/
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
@@ -14576,6 +14583,13 @@ S:	Maintained
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

