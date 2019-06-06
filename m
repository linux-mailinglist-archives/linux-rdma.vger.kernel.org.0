Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEBE37C77
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2019 20:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfFFSow (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jun 2019 14:44:52 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34574 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbfFFSov (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Jun 2019 14:44:51 -0400
Received: by mail-qt1-f196.google.com with SMTP id m29so3945242qtu.1
        for <linux-rdma@vger.kernel.org>; Thu, 06 Jun 2019 11:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IcIuNwf0zSIjR7XDITYyS7Upr/ibuj30Et6ThDetGUk=;
        b=Rvt6PYlHJVz8B4LawxVuziHGCwRJD2Qr2qMiY3NEDUJNQxIcviDgQFIUHpNOBK6bPf
         MIIBJmiWVVkfUMbHMVhNgYzIahm6Aa7GUFAb3gMyDxztH5h7Eb+fHHV92q7izqEBwwUK
         enoyn9lRGevzhavWgW36BHvjzT31gUq2EFNwzhKeKkZTpVNTzzVvik0L2TrM3EnBxw1d
         HwLNV0REutZrfhliSSQTwWrC1elVFzjojR+FeHHh1CsZjd+KT2xql8gm7opCTrlBcvvX
         NVsKXd0JcUf5SXTHZ3LhocSEFVCL79+sS0K2915hv11I6abm0hUCKJT6F6DnKNs8vXBi
         N3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IcIuNwf0zSIjR7XDITYyS7Upr/ibuj30Et6ThDetGUk=;
        b=iMVsWffgrMx3uvW4TA4EbCFqM1+SyJc9IFkDuExCMvKcbeEBHVP/2Je0yZKLIGnSfs
         9B8Z5GBUdudgYHsJLstUSdOs2/FNhhNo/B84fCID1elp1Kqh5R/woFgxPwqmXS7rhJ4i
         wqCXN33LMTjXx1pZj+E4vuK/xTc4hYkmZ7QuHwLXeeSPnCAXfFlpQXz9sLaQIC/JEK5k
         25aStAL67IK4BZ1B3hACrwHSoF57H9bO6tgZ4reZl8EKHrA5jY/14NMiuYCNGB24kv7O
         06vDOTtVKL+6Gf4vIYUP9RZwI+s+qZQCilqTx+2cT/Bg33p7ApZSPx/inQ31eTsW9MPE
         Q4Bw==
X-Gm-Message-State: APjAAAWxPHbz0pEAtOuzPQo7zgasbh4PCogTYQTBQs2p7sitNgHI7ACg
        J+CeFlpEz0Z9rGSedbFL8p21+RAo4A2k2Q==
X-Google-Smtp-Source: APXvYqykn/mITkIwjkB65/z/6RCijqiu6Ix2iI3uboXOjS2+VibgJIHgW9EaDOqfs4y2pX6u4b1Wyw==
X-Received: by 2002:aed:33e6:: with SMTP id v93mr42686308qtd.157.1559846690472;
        Thu, 06 Jun 2019 11:44:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id y8sm1656836qth.22.2019.06.06.11.44.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Jun 2019 11:44:46 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hYxNV-0008Ix-Sq; Thu, 06 Jun 2019 15:44:45 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH v2 hmm 10/11] mm/hmm: Do not use list*_rcu() for hmm->ranges
Date:   Thu,  6 Jun 2019 15:44:37 -0300
Message-Id: <20190606184438.31646-11-jgg@ziepe.ca>
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

This list is always read and written while holding hmm->lock so there is
no need for the confusing _rcu annotations.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
---
 mm/hmm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index c2fecb3ecb11e1..709d138dd49027 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -911,7 +911,7 @@ int hmm_range_register(struct hmm_range *range,
 	mutex_lock(&hmm->lock);
 
 	range->hmm = hmm;
-	list_add_rcu(&range->list, &hmm->ranges);
+	list_add(&range->list, &hmm->ranges);
 
 	/*
 	 * If there are any concurrent notifiers we have to wait for them for
@@ -941,7 +941,7 @@ void hmm_range_unregister(struct hmm_range *range)
 		return;
 
 	mutex_lock(&hmm->lock);
-	list_del_rcu(&range->list);
+	list_del(&range->list);
 	mutex_unlock(&hmm->lock);
 
 	/* Drop reference taken by hmm_range_register() */
-- 
2.21.0

