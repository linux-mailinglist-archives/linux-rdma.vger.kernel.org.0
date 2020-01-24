Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B003148FC4
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Jan 2020 21:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389101AbgAXUsc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Jan 2020 15:48:32 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36530 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389009AbgAXUsb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Jan 2020 15:48:31 -0500
Received: by mail-ed1-f65.google.com with SMTP id j17so3974079edp.3;
        Fri, 24 Jan 2020 12:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/CnmT1iQ9IEIRkSuNStdLMjsEyzEPkgWsg2fkEzE3FE=;
        b=OpYZAepapFzUD7Ex5iIY8GaW9+BOOJ2vDg4g4NCY8X7SJ5K4h5+FqKuhkKrTKL5z3o
         1rKRrhgQsTnkq1x1THMERU/WO8+RgrZnlXgbT1b7zYAffvkoEpcoxlXiG3IP45ecBvAE
         3jzxF4QvYEh8ZZzL/hUGNpA1Z1PGLPq4ibKXtOntz4DhNAE+FwkNm2QW9JYcuZ+TUoMm
         Gn3vjCsROZ50mKl6FhrdIhFkR1ksnJ2/53ApzWvTvxdby742R4Kj0lsDOsbXbg/humm5
         stE+gIr4bT0jAnSmyU57+ZcK1VuyDKvoXWidpI76zV8AhS/n2Nf/T1m626Ioig32cnIl
         b/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/CnmT1iQ9IEIRkSuNStdLMjsEyzEPkgWsg2fkEzE3FE=;
        b=kGSTnRg4F47wlp232dXkuPe/To0TZedWbDrIhbOcoUvr1i6ErKwR7IWpQGfV+ayXJy
         AkAyYw/wZZh4GcDqC97M6IriCI/+RsTaiEg2xmUZaWVGHeMzfGz1VpzrbBwBEgvUOF3A
         ANtfgXD30vo3pNGMJyClp6znmAkPslbVpQVLqVSnFPecbZONtV9U9mp8ay1O4/HWz7Sm
         0+TJrVtkOHELZLxj526slN0CkAwPla13LO5vCocnlX4Yk/VBDSrMySxNd6ooIDldfkM+
         CaxfOUB7b90KQmAviwBCff1q1udYxU3vL119+ah+jvY4fuW6vG7Uy9nDFbdy37c6VOPL
         d60w==
X-Gm-Message-State: APjAAAUfwnCxKsCRnoMXc2WIaFN9Vlf/6AeuClFzeliNzgpZCqD7svM+
        +0OV9JR3yd2i9O4dOUbVswZ+gAWf
X-Google-Smtp-Source: APXvYqxqXnO9XBv2ySEYKXfWY/49u/5ZRS2Hx75MCXbNaXX5AJmAOqLL6zLgnr+jjhJs4t0BPplyfQ==
X-Received: by 2002:a17:906:7c47:: with SMTP id g7mr4434090ejp.281.1579898909660;
        Fri, 24 Jan 2020 12:48:29 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4965:9a00:596f:3f84:9af0:9e48])
        by smtp.gmail.com with ESMTPSA id b17sm53830edt.5.2020.01.24.12.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 12:48:29 -0800 (PST)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de
Subject: [PATCH v8 25/25] MAINTAINERS: Add maintainers for RNBD/RTRS modules
Date:   Fri, 24 Jan 2020 21:47:53 +0100
Message-Id: <20200124204753.13154-26-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200124204753.13154-1-jinpuwang@gmail.com>
References: <20200124204753.13154-1-jinpuwang@gmail.com>
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
index cf6ccca6e61c..a769baa05af9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14127,6 +14127,13 @@ F:	arch/riscv/
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
@@ -14262,6 +14269,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jes/linux.git rtl8xxxu-deve
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

