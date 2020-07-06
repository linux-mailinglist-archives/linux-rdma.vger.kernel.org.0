Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F82A215390
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jul 2020 09:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbgGFHyg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jul 2020 03:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbgGFHyg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Jul 2020 03:54:36 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EB7C061794
        for <linux-rdma@vger.kernel.org>; Mon,  6 Jul 2020 00:54:35 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id o11so39753787wrv.9
        for <linux-rdma@vger.kernel.org>; Mon, 06 Jul 2020 00:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nFhKU1c8QJZQ3rQsIyMuD/WuH/oGWV1Tm3foNGD2v2k=;
        b=NccZojx6VS5SLPD0LCm6xJPuhmngP4m2JasFKYcjEh51pG9kJRXznDN25mNaQEPrek
         XDhvUOy8P43VZUp2vqRrmh/HdhGlbrYCSQY/QdrU1+1CuLy8ipgNJx7jiGNhIAV4jlax
         /nREGBn9vIUvGJhwImYtzRCekJLMw1uUn+sWcSJi0ZjunOGG/YEGCPTi+pmfh384RGBT
         A7OWLUpu+kYD1v+UwerVkmz3d5RqR82iKx203ylWCgyrcasQfX0K7SQ0lU+RFSzhXvc5
         3L5781tBoZgZxHjSoBATXT3k06UXvOnXiPriCMhaV4bin+4ZBanW38ygADumbwNgk81E
         zQWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nFhKU1c8QJZQ3rQsIyMuD/WuH/oGWV1Tm3foNGD2v2k=;
        b=bKS/qFLkXltfJzjfgn+0Ecp2WFF5voVVC3RhntTncQ+4C7PCRHzdE0/4rVE8bUVhtX
         /w1VYTJScXlkiCHYKKrgHZ787jPSCu3QTxuqPIeaNvspRE6K7jlda2CIAoPfQ+UnMOyg
         YH29k5+TJ6IRloioDqemf1GkXKbTbmniAVXSmLGw1vZlmVCBIHvdhHilIQWoL4fBLaWs
         XOQDFHNeOz8RYRLKCMtJfsAMFlHu0CJHaTuUUiJu65e/y1/tPtzOqp7yMcu5TJbY9eLv
         F5gjPLBbeKLROJr//MgIt9LE2nXqVjMUmFJ6Iie7YQhWpHgkk0uHjwjRY/4NvFkon0iX
         3YwA==
X-Gm-Message-State: AOAM530IYW4n6Yx/RwnX9nulNnpgjh6EvaSZtLDTrm/OT8wrRuUucFxT
        2GvKV/Bpl7/PHvc6iRDbKbK0FCPkQB0=
X-Google-Smtp-Source: ABdhPJyA9no0jQk4GZGg41UlO5wkyozjfrOb5lHSzJAD2hrioJiTYYI4yqk7d9vWLXIy9pHz6BQxPg==
X-Received: by 2002:a5d:4b4f:: with SMTP id w15mr46311555wrs.84.1594022074424;
        Mon, 06 Jul 2020 00:54:34 -0700 (PDT)
Received: from kheib-workstation.redhat.com ([37.142.6.100])
        by smtp.gmail.com with ESMTPSA id g145sm15028147wmg.23.2020.07.06.00.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 00:54:34 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        Kamal Heib <kamalheib1@gmail.com>,
        Christian Benvenuti <benve@cisco.com>
Subject: [PATCH for-next 5/5] RDMA/usnic: Fix reported max_pkeys attribute
Date:   Mon,  6 Jul 2020 10:54:19 +0300
Message-Id: <20200706075419.361484-6-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200706075419.361484-1-kamalheib1@gmail.com>
References: <20200706075419.361484-1-kamalheib1@gmail.com>
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

