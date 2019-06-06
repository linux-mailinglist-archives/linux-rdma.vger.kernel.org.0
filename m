Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B48537C76
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2019 20:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfFFSov (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jun 2019 14:44:51 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]:44167 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbfFFSov (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Jun 2019 14:44:51 -0400
Received: by mail-qt1-f175.google.com with SMTP id x47so3861410qtk.11
        for <linux-rdma@vger.kernel.org>; Thu, 06 Jun 2019 11:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W85iZVgjurkkiB2a7Xxec+qLci2n6gFQqX8RW+I6lJo=;
        b=EIOU+fw3tMulwBY+jl6o/Pd7uN1ahiKKDLJKphj0SFrY3mGFeHTn1W2VV4oFCcXr7j
         cWmZ0gDNudc595ZVgI5l/RmqYCimcWM0wl22l9mGjVDztbCe051fJtkZna0E33TmapUB
         sttvDBWVXq87dQ+6H75k5wM3twYt5qFdBFS/o7++FbtFqaun0Q5YuEHy1UH3O9BInXzS
         pIETiNwzZOWJnzWU1GfKDiH4km5IjkASxVzt5h0rLlByvN4VwKEz5TKRl7R8CRCPPHgC
         iZGZpOcpwV/Xe9ToHHJdY4NMDuY9EmTPikVd4pQhwsuT6b7FpmiV8btfYq7kPkezkCcc
         rh8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W85iZVgjurkkiB2a7Xxec+qLci2n6gFQqX8RW+I6lJo=;
        b=lEVQL84SyuLkqiOxBEwIApfDmbhEJCHNByY27yGL/MpfP1NSHlJa/6At1h5p2bu4Id
         E52gMpSfkTyvu2k/nyykX0iIqWoHNQ37Ojm1OTlu1iUM/8YhY/gT9t9HiaBLX4jn6AdL
         aiaYVTHHy6YcnW7sITS+H+XdEG1zmxiZrHrxL6myBujnVJyHnXsik00Y95sZr7SGdnC9
         UTlFEIounr0ORDO/yFgMkEbwLa0LzO1G0fuARQ/LC5VpfF5t0wbHFe+mlLvYxn9trjhJ
         Yop9y+3dGyo3xeCtpnXp/EcrS80EecFySl7AMfgitGHxBHxW8LcTXX0/OPghuBmW+uW9
         PZ+g==
X-Gm-Message-State: APjAAAXfjDtk+X8SoAlw/JRodnL6CsFmh5hjdTQHeRy+6Vctcxgxkgoq
        qo6ob1Eu1R/f+3bGynC/dojNrA==
X-Google-Smtp-Source: APXvYqwcFvSukVvOu/ecnBzPeUt++yQE3oiNuMCzOwlWEIQcAIcfXxOQH4AMIgicmlTTSzjQ5g0HvQ==
X-Received: by 2002:a0c:989d:: with SMTP id f29mr21429512qvd.209.1559846690185;
        Thu, 06 Jun 2019 11:44:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id p37sm1643204qtc.35.2019.06.06.11.44.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Jun 2019 11:44:46 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hYxNV-0008Il-PR; Thu, 06 Jun 2019 15:44:45 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH v2 hmm 08/11] mm/hmm: Remove racy protection against double-unregistration
Date:   Thu,  6 Jun 2019 15:44:35 -0300
Message-Id: <20190606184438.31646-9-jgg@ziepe.ca>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190606184438.31646-1-jgg@ziepe.ca>
References: <20190606184438.31646-1-jgg@ziepe.ca>
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

Callers should provide their own protection, it appears nouveau already
does, but just in case drop a debugging POISON.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
---
 mm/hmm.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index c702cd72651b53..6802de7080d172 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -284,18 +284,13 @@ EXPORT_SYMBOL(hmm_mirror_register);
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

