Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A604B3E2971
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Aug 2021 13:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242230AbhHFLWJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 Aug 2021 07:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242541AbhHFLWD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 6 Aug 2021 07:22:03 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FEBC061798
        for <linux-rdma@vger.kernel.org>; Fri,  6 Aug 2021 04:21:47 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id hw6so14540961ejc.10
        for <linux-rdma@vger.kernel.org>; Fri, 06 Aug 2021 04:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yc1HAxHcXjCZ1iC2V3ald0pkyVfhQRo2W6J4KmJGivU=;
        b=BPB11AaiitrDEtB8gPJRxn8z956vSN5HBOddN7jR3ALuniUq3leAhVZ79qaILtlqwc
         0b5Nscol9k/ZqrdYpEU1FXWC2aoTPkzPUu3kLbVYFOM8hHkzps1VnufaKDQTKWy4MvAS
         VrJBypXvW8Dpj85tdHflRpjD1rxf8eyqCGH4YUcha2GnDq1CXU59YX66MV4wTmFpm66O
         kKoQIA4T4OGZHb6u33G1PvuNQnDNQyzIPFLOuTpV3JU6E2e1uNfuA+P4xfM/FmOjKFZ/
         Vbk1d0Q/uqO5GfjhRGIo5uxGnxRc7xDRipwV7TGOaP7dd2tO3wH5kdD9STPESGU28oiX
         XjDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yc1HAxHcXjCZ1iC2V3ald0pkyVfhQRo2W6J4KmJGivU=;
        b=Bi5JT7oFH7Fiaz+EBdzOKMKBo69t/IMxGM7erzGb+yM2bGFXKugN01wKhKT/P9RKhw
         /piBc+v/wfq+K/ZYCIqK+Yp4WnSoL9WkVNIRD7xK3RLXhV08FOznxAsXpj5PoKm/oJwv
         ZjT4jZwHfXbYfI/P4hagH75Os0S2e85P5hEfxmYCqFYcI4/bcDrL+O1Nv1P5j0+rEwl3
         UreG2oVo1EVRsM59HXibGJZx8y167o/+VtRh4/HynJvTUY1aKl5EFIaqpfdwK8mx/ZE1
         wkxXTFvfiHkImI4cSHWJBnfv0KoYGS3dwJ2ojtX4FeOeA/6jhHcjWE4Jh5taEqIJuWuR
         I+Nw==
X-Gm-Message-State: AOAM531IybmGkB5quBOKjJCIBJ+QylHI8PDzrirUaSrqGFI3kdXXTJr2
        gfeQw+jIrcHRY9Gx/D2XTtZH13t5+Hh40A==
X-Google-Smtp-Source: ABdhPJzW8vfYwMzbS7yScbm2U9mKowCvYhGQ3cXbrNz+uNc1W4wAH423T/WJRmY5Och6kBS+u8F1pA==
X-Received: by 2002:a17:907:7faa:: with SMTP id qk42mr9323543ejc.291.1628248906322;
        Fri, 06 Aug 2021 04:21:46 -0700 (PDT)
Received: from nb01533.pb.local ([2001:1438:4010:2540:9e61:8a1a:7868:3b15])
        by smtp.gmail.com with ESMTPSA id q11sm2794729ejb.10.2021.08.06.04.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 04:21:46 -0700 (PDT)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH v2 for-next 6/6] RDMA/rtrs: remove (void) casting for functions
Date:   Fri,  6 Aug 2021 13:21:12 +0200
Message-Id: <20210806112112.124313-7-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210806112112.124313-1-haris.iqbal@ionos.com>
References: <20210806112112.124313-1-haris.iqbal@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Gioh Kim <gi-oh.kim@ionos.com>

Casting to (void) does nothing, remove them.

Link: https://www.spinics.net/lists/linux-rdma/msg102200.html

Suggested-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Reviewed-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 12215a78cc58..078a1cbac90c 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1894,7 +1894,7 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
 	err = create_con(sess, cm_id, cid);
 	if (err) {
 		rtrs_err((&sess->s), "create_con(), error %d\n", err);
-		(void)rtrs_rdma_do_reject(cm_id, err);
+		rtrs_rdma_do_reject(cm_id, err);
 		/*
 		 * Since session has other connections we follow normal way
 		 * through workqueue, but still return an error to tell cma.c
@@ -1905,7 +1905,7 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
 	err = rtrs_rdma_do_accept(sess, cm_id);
 	if (err) {
 		rtrs_err((&sess->s), "rtrs_rdma_do_accept(), error %d\n", err);
-		(void)rtrs_rdma_do_reject(cm_id, err);
+		rtrs_rdma_do_reject(cm_id, err);
 		/*
 		 * Since current connection was successfully added to the
 		 * session we follow normal way through workqueue to close the
-- 
2.25.1

