Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0432651D24
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2019 23:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbfFXVdI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Jun 2019 17:33:08 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56117 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727520AbfFXVdI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Jun 2019 17:33:08 -0400
Received: by mail-wm1-f66.google.com with SMTP id a15so720762wmj.5
        for <linux-rdma@vger.kernel.org>; Mon, 24 Jun 2019 14:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LXLRo2PPKRMD0FsdNO4kvH6cJWSg4ysuh5L5UkxtS4c=;
        b=gMJNqHRIngzsRcDJSRqNGhhAFj5qszbwfHp7sWjkREH0cC5Wg+51IUv6Ztnp6y1sQJ
         4s8sZl4zFkpY3KIjUkN7OCuNT+5pVhM4Z9P2VYMGh6zz+dgJPGQTFMmyTF8pYefOKxHb
         RQC3U3vsTjMnbDULYbk6PEP2Dr94o6uyCpK8jOxwldZdOsr7VxS3+nUpYxsCXash5XQk
         7PaTVmaPpwPfDGC4tTkJn+amRntW1ha7ej9YjFLte5PbAElDu2HZyg7aDGR1mtYjhEC4
         a5es/TsjfPiC+icZkrWdCKcFqlYMm30vlAIazLUZsF/W2Ct6q9aWO4iYeVJJJbe9l0jw
         3AYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LXLRo2PPKRMD0FsdNO4kvH6cJWSg4ysuh5L5UkxtS4c=;
        b=JBpxu3F1nm00RTSAeKQ+zS4taXTqFllKKl38Ci/L6x5+GfK1w+0b5+9aKF+lKk1p/m
         1FukcNXVU4yWfDOWLVOIVon08PvYTnVY9XdFd4/lcmhnxF9sMQcTU8TPwnx6v5Bz690n
         ItsQ3PlpvPYsev2PuB/+Zw76Q/WKRHfPWSnRLBxkNSw9QW95d0jFZSG6UkbD4fcfQwGz
         V01bO4ZlGBW+zwV4d/80dXcE0UZkE/CQffSjUFQn5tvpuSfQlQm7VtCjGKimXwYwksHt
         ps66jB2kG71GcEx9sPtQGxJRKk6rdbAuV8gZu0zxZuHCofVBxVi4m+KIOza1jtQIaQiw
         4QTQ==
X-Gm-Message-State: APjAAAW9N3Qduq0eJ/vNg106WF00NE+Dv0mww3Rczn2icRM8+KxcZ/Pd
        jlzdV+2Fw/ck3T25m5GKnSqhyQ==
X-Google-Smtp-Source: APXvYqxpgSLdOjxG4AEMzxa4goOMrAbz+ND9ASIrtQwBg7DrjmWk1TBdaulquFyqhwOqbOtHtgBWrg==
X-Received: by 2002:a1c:407:: with SMTP id 7mr18250094wme.113.1561411985569;
        Mon, 24 Jun 2019 14:33:05 -0700 (PDT)
Received: from ziepe.ca ([66.187.232.66])
        by smtp.gmail.com with ESMTPSA id r4sm18908060wra.96.2019.06.24.14.33.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Jun 2019 14:33:04 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hfW6C-0001MR-U4; Mon, 24 Jun 2019 18:02:00 -0300
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
        Jason Gunthorpe <jgg@mellanox.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Ira Weiny <iweiny@intel.com>
Subject: [PATCH v4 hmm 06/12] mm/hmm: Do not use list*_rcu() for hmm->ranges
Date:   Mon, 24 Jun 2019 18:01:04 -0300
Message-Id: <20190624210110.5098-7-jgg@ziepe.ca>
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

This list is always read and written while holding hmm->lock so there is
no need for the confusing _rcu annotations.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Acked-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
Reviewed-by: Ira Weiny <iweiny@intel.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Philip Yang <Philip.Yang@amd.com>
---
 mm/hmm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 0423f4ca3a7e09..73c8af4827fe87 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -912,7 +912,7 @@ int hmm_range_register(struct hmm_range *range,
 
 	range->hmm = hmm;
 	kref_get(&hmm->kref);
-	list_add_rcu(&range->list, &hmm->ranges);
+	list_add(&range->list, &hmm->ranges);
 
 	/*
 	 * If there are any concurrent notifiers we have to wait for them for
@@ -942,7 +942,7 @@ void hmm_range_unregister(struct hmm_range *range)
 		return;
 
 	mutex_lock(&hmm->lock);
-	list_del_rcu(&range->list);
+	list_del(&range->list);
 	mutex_unlock(&hmm->lock);
 
 	/* Drop reference taken by hmm_range_register() */
-- 
2.22.0

