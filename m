Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9407651CAB
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2019 23:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbfFXVCF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Jun 2019 17:02:05 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40749 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727172AbfFXVCF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Jun 2019 17:02:05 -0400
Received: by mail-wr1-f67.google.com with SMTP id p11so15361767wre.7
        for <linux-rdma@vger.kernel.org>; Mon, 24 Jun 2019 14:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rs1sEkzygtR6lbRJ0eUbAFkZlHYnT1CPNgA7awG9NQc=;
        b=f0F8mUp38+BSw/O1WjANVXVVMw8zhFZORjdRX1RtgtwdBgUWBtS4DuFgknhtRckqjJ
         fDPYac3PHVynkBRdhou+SH6UptVQIxVUIQifavRFZYv+BeWfES7diE3vVczt6RfpUEOL
         HKyKRdDLLYkWyPF33zlBvSCxa/KBn2/+Y2Sy1hmyEQzxoSkWZdP4GxRWfGqLBUquGL9C
         Ly8tJeOzyL9mpaDnKGNVFtycDXcnewWGVJEzIZFjBXuryCCVlKkVubMEGUB9qDKesfui
         S5zt2wnmoNX0dsm2two3hmXge0XbsLY2LY0GsVP/TYD0CD+hqf8x5J0pMRR0Lz+jvG54
         bukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rs1sEkzygtR6lbRJ0eUbAFkZlHYnT1CPNgA7awG9NQc=;
        b=CGYkD8Ax6VhsPc7R9d9HbSPBdUg4kmNzf2NR1D8md1cYSBov1JwRfS0Wd0RWtJwz1A
         6ZHfkag/zXHw50CstxHGgoY3WwkhiiBeHRYzWtBI1XItpF+Qbji0/cj+MSy1kAveaeK/
         eKL5t38y/QhF91TEVBVL2RbNgQBdu0/kypsRP07hZiAO1+VZVLtlTQShDO+Wvv+2GSr9
         3iPAjPhF4s+75vKkfPhz+tgmNKLShJBjjU9KxaftIBSRzgAne7QXCbcADq23bPClzIHn
         5YrFFGg+8Zn67yqUQwfNIL5nRBXfkaMpBrfIMXSF5OsyYYMMPdJfD6WWSaIP4xnLM1cS
         MQkg==
X-Gm-Message-State: APjAAAUGkXIltfuBdGWrhsM+/ivQeJeizBTFxTzRKBITUmgiawhXQfe1
        dmQgZm2SjXtX//uR1uMjYWZ8og==
X-Google-Smtp-Source: APXvYqxoDaUcVHfte6JF2hIkD4U/Q2PNoEzAwuS3zYv3vRjkVzwDyM9fIRPi2AhLNMqFWzhsn/OFnQ==
X-Received: by 2002:a5d:5446:: with SMTP id w6mr102260622wrv.164.1561410123399;
        Mon, 24 Jun 2019 14:02:03 -0700 (PDT)
Received: from ziepe.ca ([66.187.232.66])
        by smtp.gmail.com with ESMTPSA id h14sm11086221wrs.66.2019.06.24.14.02.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Jun 2019 14:02:02 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hfW6D-0001Mp-1k; Mon, 24 Jun 2019 18:02:01 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Philip Yang <Philip.Yang@amd.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH v4 hmm 09/12] mm/hmm: Remove racy protection against double-unregistration
Date:   Mon, 24 Jun 2019 18:01:07 -0300
Message-Id: <20190624210110.5098-10-jgg@ziepe.ca>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190624210110.5098-1-jgg@ziepe.ca>
References: <20190624210110.5098-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

No other register/unregister kernel API attempts to provide this kind of
protection as it is inherently racy, so just drop it.

Callers should provide their own protection, and it appears nouveau
already does.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Philip Yang <Philip.Yang@amd.com>
---
v3
- Drop poison, looks like there are no new patches that will use this
  wrong (Christoph)
---
 mm/hmm.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 6f5dc6d568feb1..2ef14b2b5505f6 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -276,17 +276,11 @@ EXPORT_SYMBOL(hmm_mirror_register);
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
 }
 EXPORT_SYMBOL(hmm_mirror_unregister);
-- 
2.22.0

