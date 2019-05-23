Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3822B28152
	for <lists+linux-rdma@lfdr.de>; Thu, 23 May 2019 17:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731093AbfEWPeo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 May 2019 11:34:44 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45998 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731092AbfEWPeo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 May 2019 11:34:44 -0400
Received: by mail-qt1-f196.google.com with SMTP id t1so7214117qtc.12
        for <linux-rdma@vger.kernel.org>; Thu, 23 May 2019 08:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f4j069c7ZUzoxaaL4dTtRuO7XDhSw6R18jQGsXmwSSU=;
        b=Q1iR9o21bGF01UbFLx0luDqo+LhUazJlW9vM4h0+z3TY9W6sEyxEw1R8DRsXKzCFjm
         fcxDLu6fBdQ7+NFUWl/isFjecvb1MU2/EYhsJDaOAM7XH95HyJYuhAmdg/ngedBPOT2f
         A/UL3DDA9lTnFoM9t+t3e2u8hSjSbbYi6FkF8FVBMPrnALhwH2m8B9e+n4RvWRsmYIpR
         VWSYlsfP2MkG7ZigmeiUQ0n1/bZgKIlqHLtsxqRXpvC7SLAUBoMfzAuE7zfXaTtKTa8A
         VGeDoQ8pTFRVKqryBcVNxJtEZ8Cn0TIIINgbBg2xyE45bsPeuNCxS8mtks9fFUZS1sdG
         oPlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f4j069c7ZUzoxaaL4dTtRuO7XDhSw6R18jQGsXmwSSU=;
        b=PELF6RDPt3EzTD7yJT5gDuTH/KPXg0RTBAlGEm3dUenW5lf0IXllt1WB20OlYDZLUJ
         a1PV2CawhWLUvxEtSKM13bNUs1KPPvCMGqSjv27Cvy/pukWdLfT3PpDrPrAvMqoQDc59
         HAC+Jl3nk0eyK3U86o5FEdIXLRVF0VKgH5chM8QCMCnMGMOSfAYru/qjBNLS0Ngk1zM2
         mpSV7Iu5JYTEpkhKsUDv9UlfYIkGnG5hFfxdEdNo1Z+U54wfscCbTYEmkQRrulfJQeIQ
         x9jq3DqciJQXOnWR1p58CPRkh6YSqRqMudhiu/WBhtHzkdnbt97e9Y6DmtS+1OI52Lsb
         gHzg==
X-Gm-Message-State: APjAAAWO0lMuX/WItHFMgSlivMEQiZh9lomcpg5Qot+dIWHmvusRWgNn
        B5s2/BTphQctLeOTj2QK/SUN8Ja7aDE=
X-Google-Smtp-Source: APXvYqzldSamHhkoEu6IIunxCJ747qr3gst7TXBS5fLpoamgpQBiEE2VbTR+wtaPARW5aq21amozzQ==
X-Received: by 2002:aed:3a0a:: with SMTP id n10mr82588942qte.145.1558625683002;
        Thu, 23 May 2019 08:34:43 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id p8sm15951242qta.24.2019.05.23.08.34.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 08:34:39 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hTpjq-0004zr-6W; Thu, 23 May 2019 12:34:38 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [RFC PATCH 08/11] mm/hmm: Use lockdep instead of comments
Date:   Thu, 23 May 2019 12:34:33 -0300
Message-Id: <20190523153436.19102-9-jgg@ziepe.ca>
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

So we can check locking at runtime.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 mm/hmm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 2695925c0c5927..46872306f922bb 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -256,11 +256,11 @@ static const struct mmu_notifier_ops hmm_mmu_notifier_ops = {
  *
  * To start mirroring a process address space, the device driver must register
  * an HMM mirror struct.
- *
- * THE mm->mmap_sem MUST BE HELD IN WRITE MODE !
  */
 int hmm_mirror_register(struct hmm_mirror *mirror, struct mm_struct *mm)
 {
+	lockdep_assert_held_exclusive(mm->mmap_sem);
+
 	/* Sanity check */
 	if (!mm || !mirror || !mirror->ops)
 		return -EINVAL;
-- 
2.21.0

