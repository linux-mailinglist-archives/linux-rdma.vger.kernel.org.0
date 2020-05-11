Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5802C1CDC11
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2020 15:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730293AbgEKNxl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 May 2020 09:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730281AbgEKNxk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 11 May 2020 09:53:40 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4D8C061A0E
        for <linux-rdma@vger.kernel.org>; Mon, 11 May 2020 06:53:39 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id x17so11092806wrt.5
        for <linux-rdma@vger.kernel.org>; Mon, 11 May 2020 06:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gx3HLgcBHV9rLoTQaiOCz4HVLX8q6jF/4mhB/jpgrdU=;
        b=XI8VvSQfbet7NemQmgC0VjVDSliQAd13Rm1d6xcvIqLC6Kbe4j0gGA2HnG7KRWvQ21
         BSdZYR4CpRXmG/r/PsI2MsFcJJaqdZyblICw207Zn9S0bnOVnlOGUSsCZpgYFNhms6QX
         Woty8WdNQFQ4NveQmN8dPxJTAZSmlkSEkH3swaeadWzrq4J5axvbJ/EgBV6xoG67yb7N
         1nSu2SvKUi8DcTDPcC9b+tCaqxGjOBVBKHVwrodY+qLIdHb2Eoih/m7qDwoD5WjdZDdL
         +Q7FiUaM7YymtTngkX/TaUU2tcWcaeIgqXwvwTJ03zSyJ/oc3RbxDuorufVfoW9d0FCp
         FcSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gx3HLgcBHV9rLoTQaiOCz4HVLX8q6jF/4mhB/jpgrdU=;
        b=ptT8ruMOshfwPga1br+7mNhJbpl15HjDmwZFK9Ju9sZshoEjKhWZqwSLzRpNz9IOUL
         MpsObpGOaDqv9jA1lx040F5FswlgLysj/zBU7Pr3Fc2Hp6HlW0zz5CVJ6JssohZ3NfPM
         j5JBCwt1MqbXUWIkH0pGZvUNvW8yy3Rii1xQa6zvDe+JAEbwCC0zC6KbQdFVOC/9FSG7
         D08xog+X4Gzoda6g8myFIvgZsjqvYa5DwkAn7ppDC1TBXSfa9O9mrkS3ODrr1Zu7iPuY
         SUEEk2b+L8yS4x2/6kNqWB9g2c2ixu5mk3G+LGMB1ldHXxM3Rpi78HYZzAT00z3zwzt7
         mtAQ==
X-Gm-Message-State: AGi0PuZpdSr+H2XO7p2jorW7Q+s2VRvhTpqqDWUpw9Jos6cm1WYV/zkJ
        P6hLRk6++yVSZ8yMWM98MntA
X-Google-Smtp-Source: APiQypKXOhfXKGGKyq0VT8zG+DfAk2nw7BFbZs/Bpu+503q4WitE/7xci0QCc+h0P8NIPqXXGItuGA==
X-Received: by 2002:adf:a1c8:: with SMTP id v8mr18851650wrv.79.1589205218551;
        Mon, 11 May 2020 06:53:38 -0700 (PDT)
Received: from dkxps.local (dslb-002-204-227-207.002.204.pools.vodafone-ip.de. [2.204.227.207])
        by smtp.gmail.com with ESMTPSA id v205sm9220018wmg.11.2020.05.11.06.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 06:53:37 -0700 (PDT)
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, pankaj.gupta@cloud.ionos.com
Subject: [PATCH v15 25/25] MAINTAINERS: Add maintainers for RNBD/RTRS modules
Date:   Mon, 11 May 2020 15:51:31 +0200
Message-Id: <20200511135131.27580-26-danil.kipnis@cloud.ionos.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200511135131.27580-1-danil.kipnis@cloud.ionos.com>
References: <20200511135131.27580-1-danil.kipnis@cloud.ionos.com>
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
index 091ec22c1a23..6b9a526cdeed 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14449,6 +14449,13 @@ F:	arch/riscv/
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
@@ -14577,6 +14584,13 @@ S:	Maintained
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

