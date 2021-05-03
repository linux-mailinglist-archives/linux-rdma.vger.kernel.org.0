Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E87937147B
	for <lists+linux-rdma@lfdr.de>; Mon,  3 May 2021 13:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbhECLtT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 May 2021 07:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhECLtR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 May 2021 07:49:17 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C46C061761
        for <linux-rdma@vger.kernel.org>; Mon,  3 May 2021 04:48:24 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id f24so7382302ejc.6
        for <linux-rdma@vger.kernel.org>; Mon, 03 May 2021 04:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yLFpOE+TdrRPkoVKHWUcTph7C4sZk65kVFl88lmOKh8=;
        b=Nw0i0OFc3969sS45hd+dLpdQAFB84A9h4P28VSj0BC9aboqP8XQV8242g1EL71Vd+C
         3EySNZ091v3MovtH5tdGLg2ghCvw3X8OPRbENY4L3fARt3cxKJ4vbP7LjeoUZ1MObKVv
         TqU3dpG4aO076ObKRu9lBMTOZ0g++yVwtWyPAzWWaNWwV3dFaQpOVVnST5tOTX3c1lSz
         uMo6Uh30vHFjLnuaBWXwUMR1pKFZdNspN3AwqUjgDqYIH8D1iIGvXxt7HVIPmK+0S3Wt
         p32uN3uaeB5kaaNP01y/NIGU5G5Ho/J+LeNQEL4fZ7ajN+rIOV7Ffz7hnndDAUMzP7kv
         618Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yLFpOE+TdrRPkoVKHWUcTph7C4sZk65kVFl88lmOKh8=;
        b=VOFcEdz1bGyRtoFIb/RPn2JvfXyar8p2UumXgnk4NwAV+Dw8VNDi8eOFKonOBI+bpg
         3znlw5Tb9F2gmLkL6S/heM2A8CLeHzx8fcDC03rP3l9p2Fetz6umr5IiJeYaX1BIs/zq
         Lz7//HP7bSaBTOqTdEFexQg5E16xwTP+LIjcBNg1JaV0XoQRheP0gweXxUjI6GZnOLaI
         d/d8wbh9+/ZsTEggVd0SfJnDWALOyaR2mrc+cUSQFmNibTSWjuPT00xcW+t5+B7szgZp
         lFrmrRt/K0aXg1AKQxktw+Ft4biaUaxqxNAls35TRBYdJA75u47pudIpSEn/Xf8rZVau
         jQPw==
X-Gm-Message-State: AOAM531QDQezUi4pRLnwH5JaFhsT65SZNipaO4+OKbkTOd7MbFO8aQ9y
        aWctwIeowm9F7YmytAB2FR1Mo7hTqlun1A==
X-Google-Smtp-Source: ABdhPJys+41TBWppM8KIv94blXEi3HipWJ3vSV7YFuc9nK2Mox7N7BounQn9KGhr4hPCxQ5CzgP5Ww==
X-Received: by 2002:a17:907:399:: with SMTP id ss25mr16490828ejb.134.1620042502593;
        Mon, 03 May 2021 04:48:22 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aef30.dynamic.kabel-deutschland.de. [95.90.239.48])
        by smtp.googlemail.com with ESMTPSA id z12sm7307705ejd.83.2021.05.03.04.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 04:48:22 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next 02/20] RDMA/rtrs-clt: Remove MAX_SESS_QUEUE_DEPTH from rtrs_send_sess_info
Date:   Mon,  3 May 2021 13:48:00 +0200
Message-Id: <20210503114818.288896-3-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210503114818.288896-1-gi-oh.kim@ionos.com>
References: <20210503114818.288896-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

Client receives queue_depth value from server. There is no need
to use MAX_SESS_QUEUE_DEPTH value.

Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 5e94686bb22d..930a1b496f84 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -2455,7 +2455,7 @@ static int rtrs_send_sess_info(struct rtrs_clt_sess *sess)
 	int err;
 
 	rx_sz  = sizeof(struct rtrs_msg_info_rsp);
-	rx_sz += sizeof(u64) * MAX_SESS_QUEUE_DEPTH;
+	rx_sz += sizeof(struct rtrs_sg_desc) * sess->queue_depth;
 
 	tx_iu = rtrs_iu_alloc(1, sizeof(struct rtrs_msg_info_req), GFP_KERNEL,
 			       sess->s.dev->ib_dev, DMA_TO_DEVICE,
-- 
2.25.1

