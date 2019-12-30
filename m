Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 701D412CEEE
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Dec 2019 11:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfL3KaP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Dec 2019 05:30:15 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46412 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727470AbfL3KaO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Dec 2019 05:30:14 -0500
Received: by mail-ed1-f67.google.com with SMTP id m8so32178088edi.13;
        Mon, 30 Dec 2019 02:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zy4NM/W5gZJcbzY8LsPxV5ADr7Rh3gMjKxUKbQBVrQg=;
        b=iq/sCuWS7ZtHUhL0MYH3su/G9aaa8HVPkaLQd36BxyKRW0Q8cH98cl8leKus5X+9/E
         h1Z/7HnzFLuxRMh/cCTy/bPfRXsalRF2PKhxWHbGaNggnYVbiMBzquGuuFlxROtgLPl8
         2NIf+BKWlqzDZ5dR6lGwtaPa3LjlvYZywJo2+m+yPty4HLFyz00G3+KIVAyUEjGSc+oV
         oaBRx8uSA8Fe+PXcyeqdUO/79Wrm2ZZOpmKYbjz6YHooyAq9FC1fG0WlrXhnnvULXVbU
         Rmtm1bNAe5PCidT2ca5uHNLSBl+Pgz2ZMbFheGaAu0/FWLpcyHqHvXXDu7Hm4Lg202GE
         80OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zy4NM/W5gZJcbzY8LsPxV5ADr7Rh3gMjKxUKbQBVrQg=;
        b=rcL1ZAV7TBatWODKufssnI7eJb8a9f5eWpg3ZF6G+4j9hCBwSyNInaH65fhd1LJhja
         rU/Vxu+uG1oJR30HpmoTNQm2WRLV/9yOaa1YgzSvdyBf4jQhp7SIdnllWjv6SEvbVNk8
         VanNtgrKNfWInU7Ii2DlY5s8QhTxBihxpKDWKM6Lw0nLTfqiXSYMKWmMLJNDPv5CP7kj
         VxeqcTJRUbGzkeGvt/a3d5de+K9xp4PieNyOekhk9a3edxBSe4Gze3qn98xQ4PHe4SBu
         J50pEiTGVtlX6utGewK6n8HmHdjVjbfCXH+IjbL4ssaQuL4m7BatLC8sUimiP5TWewUW
         9jDw==
X-Gm-Message-State: APjAAAVUuUMgxwvut7YjvhmcjHxG1OPOtNNxqhGqzZpt37ofY2QPNoUQ
        pm/mlPbZlW/0HphIdMya5vDtonmB
X-Google-Smtp-Source: APXvYqxKqT2xnliUXsGAUmU453R0AU4uOJ2XDpPjNgWqI0//aTflgcKlNquEOcJW1M6HsUzo3sn7Ow==
X-Received: by 2002:a17:906:3798:: with SMTP id n24mr68799239ejc.15.1577701812189;
        Mon, 30 Dec 2019 02:30:12 -0800 (PST)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4955:5100:b9e0:6ef7:286d:4897])
        by smtp.gmail.com with ESMTPSA id v8sm5246630edw.21.2019.12.30.02.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 02:30:11 -0800 (PST)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        rpenyaev@suse.de
Subject: [PATCH v6 25/25] MAINTAINERS: Add maintainers for RNBD/RTRS modules
Date:   Mon, 30 Dec 2019 11:29:42 +0100
Message-Id: <20191230102942.18395-26-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191230102942.18395-1-jinpuwang@gmail.com>
References: <20191230102942.18395-1-jinpuwang@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@cloud.ionos.com>

Danil and me will maintain RNBD/RTRS modules.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e09bd92a1e44..2ba370d8145d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14125,6 +14125,13 @@ F:	arch/riscv/
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
@@ -14192,6 +14199,13 @@ F:	include/net/rose.h
 F:	include/uapi/linux/rose.h
 F:	net/rose/
 
+RTRS TRANSPORT DRIVERS
+M:	Danil Kipnis <danil.kipnis@cloud.ionos.com>
+M:	Jack Wang <jinpu.wang@cloud.ionos.com>
+L:	linux-rdma@vger.kernel.org
+S:	Maintained
+F:	drivers/infiniband/ulp/rtrs/
+
 RTL2830 MEDIA DRIVER
 M:	Antti Palosaari <crope@iki.fi>
 L:	linux-media@vger.kernel.org
-- 
2.17.1

