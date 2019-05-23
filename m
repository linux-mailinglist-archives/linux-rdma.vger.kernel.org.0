Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADA2F28153
	for <lists+linux-rdma@lfdr.de>; Thu, 23 May 2019 17:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731092AbfEWPeo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 May 2019 11:34:44 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35229 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731048AbfEWPeo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 May 2019 11:34:44 -0400
Received: by mail-qk1-f195.google.com with SMTP id c15so4077391qkl.2
        for <linux-rdma@vger.kernel.org>; Thu, 23 May 2019 08:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xpfktVbL8Us0qmdWRL9VRFwkpcEhMFdO2zVbp5WooYk=;
        b=AQy9qY5unh9pvUOhg9td8t1dNvtTOZFdIPbHYbv6sGctT7lxBlvtaDEwnhn4A+19Ea
         Rg7FPBiK+QeEfNuYYey9/yTJuLOz1p93njDBTGg1o1kwmziRbYbc7/r1RV9voanVidls
         30IOKaMwGJFM53rpfO+9jyUNcc5sGg2amlLg17lxpwhDbVQBeZP7J9K2e+vswi8oBpRV
         I+kktxprDGfdJdLVSa1IlFeSv+iaXJXGJ2txMn51i04T0ADr1iIC1/SdYT+sTveLOLmP
         1UTrdvaCWyzmYz7MafIRNnc5+Gu9nQKBqUn+NLtIyiTvORUJoBnsXlq+HNOLcEnckf0g
         Vxiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xpfktVbL8Us0qmdWRL9VRFwkpcEhMFdO2zVbp5WooYk=;
        b=G8XrGSU9mfxI07uuTJsr1bY1AvJfaiuRQEFZQzr0+tqMaye2DGCAUDb5K/Sqk4cY05
         Qm1cHUcK9b2aEN4NqolMly+etNJFJktEkxUkXyXnRCq1+pXSWS/F+oQ+Gq0EKwgl7xJl
         9Z9VnZlqxFJQx9k5vwMfV46sFCsMIUtt1DbbqE2MYuH0N7J2R3MMJdTtowDL2Iodb8QC
         F2bJelQGoA4LXpZx5eqXdhidxQsdIG/u/0vPGyVwNefuFFQr6pfOAcOMSXMuL34fWtZ4
         oy3FFPOvHVupvSMu5BFl1KzKW+zLGyKN1pD+A+OR6DmkEwP6TFNrzCexVNJZL1cP4Q0S
         M8eA==
X-Gm-Message-State: APjAAAW8puKs/isyQl+0uWRnVd4rnRpKKia0uoHCFPoZar/NbZmHSBJN
        5ad9qjZ0iuU5M3AjF30EtKFx4I075xM=
X-Google-Smtp-Source: APXvYqx9y4W6qkw9q6CFNTSxrDtAaedtA4a51WwLa3lqT4HhvTbeWF2PV7OrPjgqqyxZwLXJZH3cDQ==
X-Received: by 2002:a37:50d4:: with SMTP id e203mr18097553qkb.83.1558625683357;
        Thu, 23 May 2019 08:34:43 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id k30sm11757172qte.49.2019.05.23.08.34.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 08:34:39 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hTpjq-0004zx-7m; Thu, 23 May 2019 12:34:38 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [RFC PATCH 09/11] mm/hmm: Remove racy protection against double-unregistration
Date:   Thu, 23 May 2019 12:34:34 -0300
Message-Id: <20190523153436.19102-10-jgg@ziepe.ca>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523153436.19102-1-jgg@ziepe.ca>
References: <20190523153436.19102-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

No other register/unregister kernel API attempts to provide this kind of
protection as it is inherently racy, so just drop it.

Callers should provide their own protection, it appears nouveau already
does, but just in case drop a debugging POISON.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 mm/hmm.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 46872306f922bb..6c3b7398672c29 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -286,18 +286,13 @@ EXPORT_SYMBOL(hmm_mirror_register);
  */
 void hmm_mirror_unregister(struct hmm_mirror *mirror)
 {
-	struct hmm *hmm = READ_ONCE(mirror->hmm);
-
-	if (hmm == NULL)
-		return;
+	struct hmm *hmm = mirror->hmm;
 
 	down_write(&hmm->mirrors_sem);
 	list_del_init(&mirror->list);
-	/* To protect us against double unregister ... */
-	mirror->hmm = NULL;
 	up_write(&hmm->mirrors_sem);
-
 	hmm_put(hmm);
+	memset(&mirror->hmm, POISON_INUSE, sizeof(mirror->hmm));
 }
 EXPORT_SYMBOL(hmm_mirror_unregister);
 
-- 
2.21.0

