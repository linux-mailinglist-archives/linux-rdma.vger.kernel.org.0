Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84D49450DD
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jun 2019 02:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfFNApA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Jun 2019 20:45:00 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36880 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbfFNAo7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Jun 2019 20:44:59 -0400
Received: by mail-qk1-f196.google.com with SMTP id d15so634721qkl.4
        for <linux-rdma@vger.kernel.org>; Thu, 13 Jun 2019 17:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x2xcZ0hUzEe5obPQKOQJn2EFwkT6zfHmS/ojlfdj62g=;
        b=fmkDVzgS2vVrdEiIFYVAnbf6P4BATGmI5DV7vsT+OeMjI4tAox+P6sovJkfdiZ77nO
         TT+3owVCCkhWvSGoSNguAk+3EcblRkw7UWgxiYOoQUIg3Krv9JVjCiJAQm/Z0vfo/EQO
         KilEhiFU8QK10vlLGWCYF1bTI+QT+GOn8FgfKnRlLwynY8K2mvFNbldzrI4Lge3bpnfB
         LwwdBdhl/qwje1Wf18PrfGX26/MhvkXIgT48JtyA/Mh0PWYhgZzhVUdAvgS8HFf+7d0p
         m4F365LJ+Y/0qG+JXDxYUTDe3aQRit0hcrauKtBkjsXKtLtzRJ2lxMjKyKDLXCmxU6K9
         9xfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x2xcZ0hUzEe5obPQKOQJn2EFwkT6zfHmS/ojlfdj62g=;
        b=cBZFmzkj/Mah35zrcACx89wrbimFzePm+vZOZZqLee+NJgJoK3mKiTvhTGjI/fQWiz
         pFB4WpeVHec2kJifTjc7PGqt8oFrtXZFtNxfP+QP/T3MXPGHvd+B3TEHy8XASRtOwRbF
         UXDfp1tTG9WHrffxMb1RpPt6CRpDRHsXCHnSZU3NUjou++i156Ueb2W36kLr/tA4ZPRa
         3HQMQeeX33JZYBCqWbNcXX4GIggI7ekrpt6YKx24tiCyDck5zx/Um1PS4wScQjPGTHuA
         VpU+oJ3Ouhd7SUxv1uI34XFzEkP+pb1AvgqTAisL+nYCadSizl1jIlkeSODyhdZLpnjm
         fxIw==
X-Gm-Message-State: APjAAAVJI43lWkXgALexXf6HYxeUVX1P4H7i5rHNhperPvDPjyiAq10m
        v47FhJrXCa6hHfqscyYEfaiyeg==
X-Google-Smtp-Source: APXvYqzCPZOcBvdDvO5A/+aWYFKA+YngTOxLtxM859wIOaaSHbD/Xj8J7AD4AHMtWoKrqY+ZKezZsg==
X-Received: by 2002:a05:620a:1661:: with SMTP id d1mr13812583qko.192.1560473099006;
        Thu, 13 Jun 2019 17:44:59 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id q56sm978355qtq.64.2019.06.13.17.44.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Jun 2019 17:44:54 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hbaKs-0005KQ-1j; Thu, 13 Jun 2019 21:44:54 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Ira Weiny <iweiny@intel.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v3 hmm 10/12] mm/hmm: Do not use list*_rcu() for hmm->ranges
Date:   Thu, 13 Jun 2019 21:44:48 -0300
Message-Id: <20190614004450.20252-11-jgg@ziepe.ca>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190614004450.20252-1-jgg@ziepe.ca>
References: <20190614004450.20252-1-jgg@ziepe.ca>
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
Acked-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Ira Weiny <iweiny@intel.com>
Tested-by: Philip Yang <Philip.Yang@amd.com>
---
 mm/hmm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index e214668cba3474..26af511cbdd075 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -908,7 +908,7 @@ int hmm_range_register(struct hmm_range *range,
 
 	range->hmm = hmm;
 	kref_get(&hmm->kref);
-	list_add_rcu(&range->list, &hmm->ranges);
+	list_add(&range->list, &hmm->ranges);
 
 	/*
 	 * If there are any concurrent notifiers we have to wait for them for
@@ -934,7 +934,7 @@ void hmm_range_unregister(struct hmm_range *range)
 	struct hmm *hmm = range->hmm;
 
 	mutex_lock(&hmm->lock);
-	list_del_rcu(&range->list);
+	list_del(&range->list);
 	mutex_unlock(&hmm->lock);
 
 	/* Drop reference taken by hmm_range_register() */
-- 
2.21.0

