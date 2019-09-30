Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E38CC2AB5
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Oct 2019 01:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbfI3XR0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Sep 2019 19:17:26 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38125 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731831AbfI3XR0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Sep 2019 19:17:26 -0400
Received: by mail-pl1-f193.google.com with SMTP id w8so4039190plq.5
        for <linux-rdma@vger.kernel.org>; Mon, 30 Sep 2019 16:17:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=peXAg/IElw6iW3nPywzZ2ouBwYeCgHvHncmueQCplok=;
        b=KntH65pzJid7HM5kicPiDXSTaS+g3R3CbkX+Is6suKaX+DukFeYx/Khf3FI015KX8N
         ZjUZ90/VT/1jciSqQRkdue9OXr6cZ06i0jLAQQWAo3BaNFO7dFG000SjcqDdJwpQ8+y0
         5lYtkHfokiJkcwQu3Isl5k0hanoLN+auGIJsqUe9ipn2zehNMlup5a2++9k1FeWxOSqm
         r+3SD2Ifwc+rFaPRY0Umomw7gAtpGU++NVCd5uExs+O8AOR69dz3opHHko8mrkyswKoA
         zZauCIwwUI1wPHncW9johXLxfC1vi+6X5NM1PBDwd7j3I3/EvBVWhU0BCcFURT8uL1BH
         dX7A==
X-Gm-Message-State: APjAAAUG9lHBKwZRu737acZ1yA/BpXwu90bT/MeOAWdt5TpFfuzHr4FS
        6hRfHidvvvOPI9NetVUgiMM=
X-Google-Smtp-Source: APXvYqxwN15QedeYoD4jV1TYgJ7EcVP5gBEcAb4hxLYbcY/Cj29lG+Vm9H7mf+dt6ogeWCZFwJZwhw==
X-Received: by 2002:a17:902:209:: with SMTP id 9mr22200270plc.1.1569885443904;
        Mon, 30 Sep 2019 16:17:23 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id l7sm585406pjy.12.2019.09.30.16.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 16:17:22 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Bernard Metzler <bmt@zurich.ibm.com>
Subject: [PATCH 04/15] RDMA/siw: Fix port number endianness in a debug message
Date:   Mon, 30 Sep 2019 16:16:56 -0700
Message-Id: <20190930231707.48259-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
In-Reply-To: <20190930231707.48259-1-bvanassche@acm.org>
References: <20190930231707.48259-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

sin_port and sin6_port are big endian member variables. Convert these port
numbers into CPU endianness before printing.

Cc: Bernard Metzler <bmt@zurich.ibm.com>
Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/infiniband/sw/siw/siw_cm.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 5a75deb9870b..3bccfef40e7e 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1853,14 +1853,7 @@ static int siw_listen_address(struct iw_cm_id *id, int backlog,
 	list_add_tail(&cep->listenq, (struct list_head *)id->provider_data);
 	cep->state = SIW_EPSTATE_LISTENING;
 
-	if (addr_family == AF_INET)
-		siw_dbg(id->device, "Listen at laddr %pI4 %u\n",
-			&(((struct sockaddr_in *)laddr)->sin_addr),
-			((struct sockaddr_in *)laddr)->sin_port);
-	else
-		siw_dbg(id->device, "Listen at laddr %pI6 %u\n",
-			&(((struct sockaddr_in6 *)laddr)->sin6_addr),
-			((struct sockaddr_in6 *)laddr)->sin6_port);
+	siw_dbg(id->device, "Listen at laddr %pISp\n", laddr);
 
 	return 0;
 
-- 
2.23.0.444.g18eeb5a265-goog

