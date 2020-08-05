Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E798E23D359
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Aug 2020 23:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgHEVB2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Aug 2020 17:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgHEVBZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Aug 2020 17:01:25 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40875C061575
        for <linux-rdma@vger.kernel.org>; Wed,  5 Aug 2020 14:01:25 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f1so41427972wro.2
        for <linux-rdma@vger.kernel.org>; Wed, 05 Aug 2020 14:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nFhKU1c8QJZQ3rQsIyMuD/WuH/oGWV1Tm3foNGD2v2k=;
        b=dQy8rl7aUPmsMmQWvtSUZbEMOwZdn47PqtlhgzjyJzGKZln3NAq0NNGy2R+pe1Ozl8
         BME+Ub/NOYm3Oj2XDTeGDQHcvSaqvao2dZvQOVznqxJ0P5ajFmVdvLrpdqXUDlaZs600
         +kcLgwXBPafMHymA1f1igvjCq2OvpwdCXH3ernvJxUnZsgTNE/u3wPfAYUi/RO0Ae9ij
         YKjjfMv5oM6AT8h3jkzmZDRY797BoUMhwoFTXvMgswCTPYwco44vF5bajFUZJ6HnOgt7
         ZHl1TP6qns+10Hz8t+WBfU28tu2b5Rp6MmId01L0kh8MrBS28EWIh697/EuKGYSpt6Nz
         Vf9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nFhKU1c8QJZQ3rQsIyMuD/WuH/oGWV1Tm3foNGD2v2k=;
        b=kO/WHnW2QD9KXXPIKj+DiUE68+1I21UdhmXyq2yyANTV1OXlIJzBpRrZRHxQDZFOnM
         wEs/10W6KNVYSdaBp/lZQmm3g3sEkRjO/iBWzUS4Bl3Qy2ApIzLF/uRkMJcPRwr9HVSP
         Zz4QVzeEGLbxe9aKWkGG+iPqbOfaBIpwT69cl2ikL2AzwWQ32BfCo9pGYEHgZoe51c19
         pQ8O/roMKz5bh2uzd49uff8rNoS2djn8UVwPG2LOUHk+7HTeMBVtiYAVzXp2kKJibvNZ
         vpUrPXOTjZ04+HUQsNyzS9rNAwvAzL+x2Rcwdyo+xacnIaoiVfSm5waOW8qJPxxCpznF
         orug==
X-Gm-Message-State: AOAM530HNoU97wAjj5pYeMp5MMihmTwv4PZA/mAeTz9TBjpUU4AvD21/
        AL/FynwL1uWjDZ50blvTBvwMxXtTkX0=
X-Google-Smtp-Source: ABdhPJxyx5LXj9NC7A5yN9b3+P/x7DAngwBTu0H/zdoKeZfRbDtgp6ZDiq/Aibk5Fe5uGT/2TN40dA==
X-Received: by 2002:adf:ee51:: with SMTP id w17mr4507524wro.239.1596661283798;
        Wed, 05 Aug 2020 14:01:23 -0700 (PDT)
Received: from kheib-workstation.redhat.com ([77.137.118.169])
        by smtp.gmail.com with ESMTPSA id 15sm3771690wmo.33.2020.08.05.14.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 14:01:23 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Kamal Heib <kamalheib1@gmail.com>,
        Christian Benvenuti <benve@cisco.com>
Subject: [PATCH for-rc] RDMA/usnic: Fix reported max_pkeys attribute
Date:   Thu,  6 Aug 2020 00:00:51 +0300
Message-Id: <20200805210051.800859-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Make sure to report the right max_pkeys attribute value to indicate the
maximum number of partitions supported by the usnic device.

Fixes: e3cf00d0a87f ("IB/usnic: Add Cisco VIC low-level hardware driver")
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
Cc: Christian Benvenuti <benve@cisco.com>
---
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
index b8a77ce11590..0cb2a73d46ee 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
@@ -309,7 +309,7 @@ int usnic_ib_query_device(struct ib_device *ibdev,
 	props->max_pd = USNIC_UIOM_MAX_PD_CNT;
 	props->max_mr = USNIC_UIOM_MAX_MR_CNT;
 	props->local_ca_ack_delay = 0;
-	props->max_pkeys = 0;
+	props->max_pkeys = 1;
 	props->atomic_cap = IB_ATOMIC_NONE;
 	props->masked_atomic_cap = props->atomic_cap;
 	props->max_qp_rd_atom = 0;
-- 
2.25.4

