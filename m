Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 871E0215467
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jul 2020 11:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbgGFJLf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jul 2020 05:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728024AbgGFJLf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Jul 2020 05:11:35 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CBAC061794
        for <linux-rdma@vger.kernel.org>; Mon,  6 Jul 2020 02:11:34 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id b6so39949901wrs.11
        for <linux-rdma@vger.kernel.org>; Mon, 06 Jul 2020 02:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K6mLL7tLM934/zbxauAezYq+UQ9iy2rbr+FRjTdUcOU=;
        b=pZmeZc0PTnkq5+3cFfnKUf2uwVlEbiFH7zk9f9BM1yYD9OzAsTS1qZmeetK0fKOJP0
         Mx5i5ZyOK8ftkPv9nr3/yvlI2n6jGCVsqSqVeVRVTXqrdQSJdfjVKqj2nlyy1Dc8VZJA
         6nYoa9rMOWYAVPziUJg3SUzhI3D7X6iC2UyLXnV894eEXS81m1TRq+UZkbu7ozE74+u9
         xrwlaliaNjp3VpWnCaXdXvfWBQdvoIoQtNlFYBYoejJ9W1cYsK3m+g7Uhf/KBW4cBLrL
         T/dX+GKe81qFPEizCPPtGPjZnd4UPpTIjZndEz5tUREQQHKtf1YJE1XY0gZTGb5AOCWr
         4Mlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K6mLL7tLM934/zbxauAezYq+UQ9iy2rbr+FRjTdUcOU=;
        b=qViw8e96F9U64jP3wMU7QEqB2Whip1Ifdk/sE/tDZELhSag9yz2sQCWOXELH242sjl
         jG85hDL3lSUCmo5Cf3d8PH9ir+uUfVzg4Eq0Ngq8pchQwCc+1XTQGiJ/ZeM4eepWktPh
         tHbun63IVa/d5Nt3e+qJVZgP+T++vlRsZGSbe/HwqVDNcbGGa5P6vsfXj7KyRcVbYEiW
         1BN3zPUQ/4RN5qYeDoXn69na809G+5wJt5aD+OkVJoz7RhPfBosGJK13Hog18+9KY5hv
         cmD9mluowlqHf8VyQUIPIIY3zpXBjiluJaYvgyp2MlRsLNSrBNDMzlCRf2wfbek0Rfjl
         vcRg==
X-Gm-Message-State: AOAM532JPwmecnOfkgXqQTG0yU8FnjRraQ0yJW7cAvb+5vgYdIgcFiWq
        WRwGoOcnYy7/Z/k7BRZW1aIcb+ZEIZE=
X-Google-Smtp-Source: ABdhPJwZ52iHwO/d4O79Io+QG7XfCHeaB8KeJWCiT7O2bAcXN6ofcQw7Hn8mFMlOmmSbWYKWD5sXkw==
X-Received: by 2002:adf:f3cd:: with SMTP id g13mr45472555wrp.45.1594026693316;
        Mon, 06 Jul 2020 02:11:33 -0700 (PDT)
Received: from kheib-workstation.redhat.com ([37.142.6.100])
        by smtp.gmail.com with ESMTPSA id j4sm18826867wrp.51.2020.07.06.02.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 02:11:32 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        Kamal Heib <kamalheib1@gmail.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-rc v1 3/4] RDMA/i40iw: Set max_pkeys attribute
Date:   Mon,  6 Jul 2020 12:11:18 +0300
Message-Id: <20200706091119.367697-4-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200706091119.367697-1-kamalheib1@gmail.com>
References: <20200706091119.367697-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Make sure to set the max_pkeys attribute to indicate the maximum number
of partitions supported by the i40iw device.

Fixes: d37498417947 ("i40iw: add files for iwarp interface")
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
Cc: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/i40iw/i40iw_verbs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
index 19af29a48c55..ef624fa5f07b 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -84,6 +84,7 @@ static int i40iw_query_device(struct ib_device *ibdev,
 	props->max_qp_init_rd_atom = props->max_qp_rd_atom;
 	props->atomic_cap = IB_ATOMIC_NONE;
 	props->max_fast_reg_page_list_len = I40IW_MAX_PAGES_PER_FMR;
+	props->max_pkeys = 1;
 	return 0;
 }
 
-- 
2.25.4

