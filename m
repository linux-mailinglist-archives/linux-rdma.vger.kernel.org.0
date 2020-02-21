Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC8FE167B4D
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2020 11:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgBUKrw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Feb 2020 05:47:52 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42040 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727239AbgBUKrv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Feb 2020 05:47:51 -0500
Received: by mail-ed1-f68.google.com with SMTP id e10so1761042edv.9;
        Fri, 21 Feb 2020 02:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YGMYQFXeK9XI1ZDv64MlCdxeiU8mWVCOsmmLprsy3+0=;
        b=d9DfjQi9YNduKQg8MnXUNO4/LycGiv0ZlumpYXeiI771L/4hiKim5brG8JOP63C3K2
         2SIyQZexQvY+nLgLLVKWawuSWeNxGiAObqhfX83Z8QXKOIrg/ZHH5JS6I1Vu/BL4MYg/
         yhuWG13Yv+RixZsyh9XvhKP4NqREUHIZnVsS67oD0XpNaPRlaASZSP3uKq5SltJ/uIG5
         sDQopY7KnF7oXH9au01do/U7vN1gRQcDaByZQaqFimcwrlBDWxuaLTuBFVfbHpMCxlQG
         xE629zsnHav33kOgAI/jN0lEBpDv+cDlXg+216SPJgfzdw1JVOYIzxTe+SOW7OA052nl
         pESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YGMYQFXeK9XI1ZDv64MlCdxeiU8mWVCOsmmLprsy3+0=;
        b=bGllwFR8O9lwCMMWSKXvL8Gx0cGK7wT6bezFZuwUdNR/GYoUA2ViDf37dDUJzXJjYj
         5AS8fdFHUQv6jCReLS66Bt/rbfgzN2zF8IQsBu+ozPM2FnBVnKAt6OROity/FX4ZGnzd
         iJOekDmhaz8YGNOQwqPHdEuTsguqQoFnasB5fU0Rf5N/PhDJ49wDodwwYM4GKcSeBHOK
         vZ63h419zaWQbfgMmwjjqCFkJpmCPwtQYEkU+eOp3L2Wv0pdshqcK8Qw/VeFWAag5Zzb
         73HgBDaD8Q9md0ND7M4m8kHlUMxSf1Ynv2iC0iY0aDItQs9g3MAuEApB2hdcce5XAKyA
         oomQ==
X-Gm-Message-State: APjAAAWEtgggcKVZwrZumHAS23cf9YKedncK57oBQ1bbeGigaCMDz0g1
        uRrNVhuLpQNGkVm1yiyX/6lBYxZk
X-Google-Smtp-Source: APXvYqynAFMn/B/9d8CTYVYd6/F2k07m7QzTRBuhDR0IxFnLNQ1CYwDBy1I30N3Zy9PLXht95sC/SA==
X-Received: by 2002:a17:906:e219:: with SMTP id gf25mr32666013ejb.51.1582282069951;
        Fri, 21 Feb 2020 02:47:49 -0800 (PST)
Received: from jwang-Latitude-5491.pb.local ([2001:1438:4010:2558:d8ec:cf8e:d7de:fb22])
        by smtp.gmail.com with ESMTPSA id 2sm270594edv.87.2020.02.21.02.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 02:47:49 -0800 (PST)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de,
        pankaj.gupta@cloud.ionos.com
Subject: [PATCH v9 25/25] MAINTAINERS: Add maintainers for RNBD/RTRS modules
Date:   Fri, 21 Feb 2020 11:47:21 +0100
Message-Id: <20200221104721.350-26-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200221104721.350-1-jinpuwang@gmail.com>
References: <20200221104721.350-1-jinpuwang@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@cloud.ionos.com>

Danil and I will maintain RNBD/RTRS modules.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a0d86490c2c6..4f1124cfd771 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14288,6 +14288,13 @@ F:	arch/riscv/
 K:	riscv
 N:	riscv
 
+RNBD BLOCK DRIVERS
+M:	Danil Kipnis <danil.kipnis@cloud.ionos.com>
+M:	Jack Wang <jinpu.wang@cloud.ionos.com>
+L:	linux-block@vger.kernel.org
+S:	Maintained
+F:	drivers/block/rnbd/
+
 ROCCAT DRIVERS
 M:	Stefan Achatz <erazor_de@users.sourceforge.net>
 W:	http://sourceforge.net/projects/roccat/
@@ -14429,6 +14436,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jes/linux.git rtl8xxxu-deve
 S:	Maintained
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
2.17.1

