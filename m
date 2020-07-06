Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5921E21538F
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jul 2020 09:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgGFHyf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jul 2020 03:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbgGFHye (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Jul 2020 03:54:34 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28CFC061794
        for <linux-rdma@vger.kernel.org>; Mon,  6 Jul 2020 00:54:34 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f7so36721875wrw.1
        for <linux-rdma@vger.kernel.org>; Mon, 06 Jul 2020 00:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K6mLL7tLM934/zbxauAezYq+UQ9iy2rbr+FRjTdUcOU=;
        b=Gc7M6W7XiDxH2/x+ZRr/LEHHMeNt9DHvA04L8BAwfyxaNPfashMvv60OvrdhmOUDq6
         GVGSKbkD79i2XiOV29doB/Pw3MnPbEs5PjWdv48DA8TXQ0ESbe8Phg683vleQMvQqRP+
         kgcqrqXsejrDv3KTPhJfFsf5FF469SxxM0B3NDemtHihxe3CUSHjik5hOykgU+ttI0dx
         yGU9kw4p3tR3/q3yf3nl1rlki2aQwTFyDVTV67M9CZ28Tslh4jixSmOHNdKqY0R2yC/M
         f97NYlDPJ9p3ll0LpY6wJSazGJCDDiRMoijVJE+ZWOivVGFRezshGSpzmox95KKsl9iU
         GkOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K6mLL7tLM934/zbxauAezYq+UQ9iy2rbr+FRjTdUcOU=;
        b=cJod2nwXN234NK69eJJlluw01n167UcC/tMM375b4WAOSPCniSgOyal+XDswsstQmh
         OUBDH9rfmtcn5mMTHQGOEMQZn9XUleeYmwK6VrWePnMXgCNvq9hfMJfqmu9+G69DV2jB
         hLd76tmebHZTseS0GbAEylAnhAH6GNrDfhCptQMdDGOgch8YNYCtr+cW11EPaON5uKh0
         hRjmBeFxAYb/zWQgQEjELenkyAFCvFUHKn2dysS3HT8c+CYlZMOZY+SKBAUNamULGDKe
         Qw7d0kkg8uwmQlRdf58WgtN9sH/Z/BU16BNwLxC0nKPIqeNLfoK6VYgBQlBsoGsx/oCU
         rlkw==
X-Gm-Message-State: AOAM531sPOpoHkJ7XMh+swBPKaeFxwbDgNIWC6GkmoWXMupt3wAZcZt5
        ekAzFDbcnWG867Ag1VzPmqnu5oCQr10=
X-Google-Smtp-Source: ABdhPJy/G5Ik8SJddKzQ0oGJfwYdLmYPOYMIsLBcqgzYmpMM3Orcwk5995Ed2xJFM0sI8DCR0nEmgQ==
X-Received: by 2002:adf:d084:: with SMTP id y4mr46416483wrh.161.1594022073266;
        Mon, 06 Jul 2020 00:54:33 -0700 (PDT)
Received: from kheib-workstation.redhat.com ([37.142.6.100])
        by smtp.gmail.com with ESMTPSA id g145sm15028147wmg.23.2020.07.06.00.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 00:54:31 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        Kamal Heib <kamalheib1@gmail.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-next 4/5] RDMA/i40iw: Set max_pkeys attribute
Date:   Mon,  6 Jul 2020 10:54:18 +0300
Message-Id: <20200706075419.361484-5-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200706075419.361484-1-kamalheib1@gmail.com>
References: <20200706075419.361484-1-kamalheib1@gmail.com>
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

