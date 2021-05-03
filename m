Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50752371480
	for <lists+linux-rdma@lfdr.de>; Mon,  3 May 2021 13:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbhECLtW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 May 2021 07:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233460AbhECLtU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 May 2021 07:49:20 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E41DC061761
        for <linux-rdma@vger.kernel.org>; Mon,  3 May 2021 04:48:27 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id j28so5890294edy.9
        for <linux-rdma@vger.kernel.org>; Mon, 03 May 2021 04:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v2jM+Ra/5Z6joqP338SkpJMALJWRGixf8r+AeqFXX7U=;
        b=RLhoPS7ErTDj/EdnXB4wRrVJiOtgvDs9Lnf5QQ2VKNWElhBFVtuzHpBHJB7b7bk8SG
         KUHU0r4mzckZXk9/PhqseWwybkofJXRehQ7Ahfr1iue8nbJPtXQBPScDZTkDbIKGE4Yc
         ZHRNetu7e1VBRguHgC/3ujyCM6a7CCq7IgAGEUz7uTv38LDE7tblDpZk4V6QaCTLNiCq
         K2beJFXX1zRWQ1MQCDd3s7Aje1/ujQka0A8KYD53/CR96zeuJZNcf2P6exJcSqdQhO3U
         MeFOUmN9Lw4TD6CSWvnuP5+4qm865zaOGvk0iYBAyHR9nsniwJl5X0pdnYmJb9MRhRPh
         F2aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v2jM+Ra/5Z6joqP338SkpJMALJWRGixf8r+AeqFXX7U=;
        b=XK+meu6kuHdlCcwXtDaeyNURHPNw479KamgEMwkIJtYetEF8cnoTqZx3lV9uvUa4e9
         oeppvZ3liG5rojqb+W3Ns7JaJ5us4Z5+47w4Ru1fP1xWS0TJDY49j+gW9uqNQcHZ21Ji
         9pj6GlPWngBx3kcaiR41HQJPCcYUfCFIgTwGdDTRVsn7m7shV5o1Tlg16nlC3DsIriJI
         yqIq8rUWeKv0+rRIbxaC7oVwOlJbovCatl80KN9KyTmt/YHm50wyY6sZpvt7uF6UIksE
         L0WUkosYXyOfQuamH4s03hxm5KtYvPnCCnEg1EbPEoilryqsNvHjf19Irwvi8oz1YaVp
         +OJg==
X-Gm-Message-State: AOAM5316U30a4523KDKnLZGrGTOmw7NJrNIbLB62yclBIsl9qz2fNJR5
        gqt7eFA3txhtj+S/4mM/rf2z/FGRYqEjdg==
X-Google-Smtp-Source: ABdhPJw7NkHJBZwPlSUd540tSAU/mTKMDa+OexxabwPHV79RxFkaYQTdPH1UjPByH7uAdYNORNMCdw==
X-Received: by 2002:a50:9e0b:: with SMTP id z11mr19731012ede.228.1620042504649;
        Mon, 03 May 2021 04:48:24 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aef30.dynamic.kabel-deutschland.de. [95.90.239.48])
        by smtp.googlemail.com with ESMTPSA id z12sm7307705ejd.83.2021.05.03.04.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 04:48:24 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Guoqing Jiang <guoqing.jiang@ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next 05/20] RDMA/rtrs-srv: Clean up the code in __rtrs_srv_change_state
Date:   Mon,  3 May 2021 13:48:03 +0200
Message-Id: <20210503114818.288896-6-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210503114818.288896-1-gi-oh.kim@ionos.com>
References: <20210503114818.288896-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

No need to use double switch to check the change of state everywhere,
let's change them to "if" to reduce size.

Signed-off-by: Guoqing Jiang <guoqing.jiang@ionos.com>
Reviewed-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index df17dd4c1e28..74a5dfe85813 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -77,32 +77,17 @@ static bool __rtrs_srv_change_state(struct rtrs_srv_sess *sess,
 	old_state = sess->state;
 	switch (new_state) {
 	case RTRS_SRV_CONNECTED:
-		switch (old_state) {
-		case RTRS_SRV_CONNECTING:
+		if (old_state == RTRS_SRV_CONNECTING)
 			changed = true;
-			fallthrough;
-		default:
-			break;
-		}
 		break;
 	case RTRS_SRV_CLOSING:
-		switch (old_state) {
-		case RTRS_SRV_CONNECTING:
-		case RTRS_SRV_CONNECTED:
+		if (old_state == RTRS_SRV_CONNECTING ||
+		    old_state == RTRS_SRV_CONNECTED)
 			changed = true;
-			fallthrough;
-		default:
-			break;
-		}
 		break;
 	case RTRS_SRV_CLOSED:
-		switch (old_state) {
-		case RTRS_SRV_CLOSING:
+		if (old_state == RTRS_SRV_CLOSING)
 			changed = true;
-			fallthrough;
-		default:
-			break;
-		}
 		break;
 	default:
 		break;
-- 
2.25.1

