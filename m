Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31AD622B072
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Jul 2020 15:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbgGWNZW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Jul 2020 09:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgGWNZV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 Jul 2020 09:25:21 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0CFC0619DC
        for <linux-rdma@vger.kernel.org>; Thu, 23 Jul 2020 06:25:21 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id md7so3063918pjb.1
        for <linux-rdma@vger.kernel.org>; Thu, 23 Jul 2020 06:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=uK6jxEXqjhfZ8uRnYgM/QCO9nqFKXjDfXYd2sunlsuo=;
        b=Stjl9dVgpeLr2wI1BnN97HllxwUKYjaDv7FfOD8XvbrRbT32kjFUx444M7S5ejQbFv
         w6NnvDCX5/eX/MtUKKcgn8N0pKNod8odXo3NjlYRdu1m0SHbr6D7vXOpuVqctR4qHtwu
         P3nnat14Ofj3S9f/vgE9q8UdNWJrkw68tbrMlBYjJTAeDAmQj/Ea8mqbq50hIMFhPwVJ
         NdvG6k70PKLvhWh5zTaGNHvac7khHEr64IsrGy7Y+SLtRo4bTwActshvlNv1h+w+s0ah
         RluFxnfmWXR+a5UO4N+y/p2ufCh7tBatpptlw9DaHYioSVIibRckfDG/1zF2fybn9ICI
         qQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=uK6jxEXqjhfZ8uRnYgM/QCO9nqFKXjDfXYd2sunlsuo=;
        b=ps91Bj9zZSuYKU1eBL3aiH/sacByQxzW8FcbZ9eh/7iHApo9Ip/x68OQsFxxRLHuv2
         fjkswvwredUtHWExbH3Ku3/lNtZlqs1rmPrDewMZaE+5l1inuWUVHVvuz3i7+zHz9YJI
         psgThQikzEtIAuw+eypSF4t4RFgLVNS77V3vrS8qlr8f9aNQcr86KmG+iEkfDiqRFtUX
         6SXb2SVBOzAPTsoWnT3FzqnJVsoFiiQgpaYzDvDGZWVhkpKX+SnD8Q/NK/n8aP/aPsqY
         YIrFRklmYdo/qexsWP9VaZYGQQtQXSpBS3YUvnRWbCO01UrMpmotw3gXGI02LR5Q83O5
         ZMsQ==
X-Gm-Message-State: AOAM533f7ierjmiMj1MspoCIiMQvnJlUwZmLzJMXm7Vcrh10MkpYTzQN
        1Se/ga8RtMzJWUZmDpJ37rVd8w==
X-Google-Smtp-Source: ABdhPJzbbdKzyvs0HmT5aU+V2fq5mkEt2FVEzMfsM4uFbb9bcnSt/YRQRQHZM9fp7xzRrZVDhTFB8w==
X-Received: by 2002:a17:90a:7103:: with SMTP id h3mr433035pjk.34.1595510721346;
        Thu, 23 Jul 2020 06:25:21 -0700 (PDT)
Received: from [10.86.108.142] ([103.136.220.66])
        by smtp.gmail.com with ESMTPSA id c1sm3132021pje.9.2020.07.23.06.25.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jul 2020 06:25:20 -0700 (PDT)
From:   Fan Yang <yangfan.fan@bytedance.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: [PATCH] RDMA/rxe: fix retry forever when rnr_retry >= 7
Message-Id: <D1A472F9-6618-41A2-9CA8-B5231BD03D63@bytedance.com>
Date:   Thu, 23 Jul 2020 21:25:17 +0800
Cc:     linux-rdma@vger.kernel.org
To:     Zhu Yanjun <yanjunz@mellanox.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently when an error occurs and the completion state becomes
COMPST_RNR_RETRY, qp->comp.rnr_retry is only decreased when
qp->comp.rnr_retry !=3D 7.

If the user happens to config the rnr retry count to be >=3D 7, the
driver will retry forever, instead of exposing IB_WC_RNR_RETRY_EXC_ERR.

---
 drivers/infiniband/sw/rxe/rxe_comp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c =
b/drivers/infiniband/sw/rxe/rxe_comp.c
index 4bc88708b355..16c1870b6482 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -745,8 +745,7 @@ int rxe_completer(void *arg)
=20
 		case COMPST_RNR_RETRY:
 			if (qp->comp.rnr_retry > 0) {
-				if (qp->comp.rnr_retry !=3D 7)
-					qp->comp.rnr_retry--;
+				qp->comp.rnr_retry--;
=20
 				qp->req.need_retry =3D 1;
 				pr_debug("qp#%d set rnr nak timer\n",
--=20
2.27.0


