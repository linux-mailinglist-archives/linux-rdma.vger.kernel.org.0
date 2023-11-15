Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D68E7EC72C
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Nov 2023 16:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbjKOP2H (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Nov 2023 10:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbjKOP2E (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Nov 2023 10:28:04 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61603101
        for <linux-rdma@vger.kernel.org>; Wed, 15 Nov 2023 07:28:01 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9c603e2354fso197391666b.1
        for <linux-rdma@vger.kernel.org>; Wed, 15 Nov 2023 07:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1700062080; x=1700666880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pS2yg4z7QyRI3Eox8JCayMQqgQn/h9ZIZWLeABnOtg=;
        b=CA0emUV58/S1kb+vDX1/YVeOeXlW8HG/105BtAONiJtxLeW31hgFZveyB8w5rEozkp
         EQIybMSih9mtc2L9n1T9NxEIIjOSsn0sbHWsq6cpUIz7AIyl6Kq6AvRq0LbLDlxMeF7B
         zPNZIk4lrinE5azuWN2DnaOwQw0T3qWmzFnSEW5jzWHRvDxt+7aszNolAjy2tBVFcPbB
         4w5gjQvSVzfc0nZRuJU6tBrYmxy7ZFPL2R3W0awstxxpnKj0hf2/ZdyiCafb1PHoRInQ
         8UrqKi0ZbBZGgRHnC1V/9yUl66sNY/nu5o6q4ySV22dIgO7zlMdIqdlRS+LIDkE0wU1o
         VtuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700062080; x=1700666880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5pS2yg4z7QyRI3Eox8JCayMQqgQn/h9ZIZWLeABnOtg=;
        b=T9vIWv7t+oy2mEWguvE4iasipQErjJh/YURJ2k+MBateJXBc0egH3MSLYMAeUFGpPv
         L0R/EvTTFpRbBx07lYV0e9cDqFlwyMSBbGbBCYf/u5cUtsChMn2/9k69yipBoVxSoFl1
         +93hPAUBgc6MJd4nenrlta+sJZhGGYM4HN8yu+mBApRVAQgamzHi1qhNtvgIem9wLmjF
         ZT4g1dx/Ar64eWdBxSZFMn8Nq1aXnKQOki1owlvk1Jk1ppn5EDbVShgL4FUOQ8hMM/Qu
         3eT9Mgpn7GahrkBG7cgaMPxtndXjPE/cHll0Xy0m5T1YTII7pr5oAhszL5uaRKKncf0k
         Xtvw==
X-Gm-Message-State: AOJu0YzGZifPRrwp8nrWx+pIORgJ5Q/ifZxcXyyKt64zLqBP4nbyx+WO
        ojAzsTZyn9POlK2U0kydsZmft+8kAgL0gtOvBj0=
X-Google-Smtp-Source: AGHT+IHczSDIxRj6Xa3wpKd5AcelE5lcYLtzBYtcQQ1NUOwank5S2LZR7tMOrC8xocbWLGyFtDN7MA==
X-Received: by 2002:a17:907:868e:b0:9ae:5a56:be32 with SMTP id qa14-20020a170907868e00b009ae5a56be32mr5528013ejc.38.1700062079893;
        Wed, 15 Nov 2023 07:27:59 -0800 (PST)
Received: from lb01533.fkb.profitbricks.net ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id u6-20020a056402064600b00542da55a716sm6577349edx.90.2023.11.15.07.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 07:27:59 -0800 (PST)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, jgg@ziepe.ca,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Santosh Kumar Pradhan <santosh.pradhan@ionos.com>,
        Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Subject: [PATCH for-next 6/9] RDMA/rtrs-srv: Destroy path files after making sure no IOs in-flight
Date:   Wed, 15 Nov 2023 16:27:46 +0100
Message-Id: <20231115152749.424301-7-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231115152749.424301-1-haris.iqbal@ionos.com>
References: <20231115152749.424301-1-haris.iqbal@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Destroying path files may lead to the freeing of rdma_stats. This creates
the following race.

An IO is in-flight, or has just passed the session state check in
process_read/process_write. The close_work gets triggered and the function
rtrs_srv_close_work() starts and does destroy path which frees the
rdma_stats. After this the function process_read/process_write resumes and
tries to update the stats through the function rtrs_srv_update_rdma_stats

This commit solves the problem by moving the destroy path function to a
later point. This point makes sure any inflights are completed. This is
done by qp drain, and waiting for all in-flights through ops_id.

Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Santosh Kumar Pradhan <santosh.pradhan@ionos.com>
Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 925b71481c62..1d33efb8fb03 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1532,7 +1532,6 @@ static void rtrs_srv_close_work(struct work_struct *work)
 
 	srv_path = container_of(work, typeof(*srv_path), close_work);
 
-	rtrs_srv_destroy_path_files(srv_path);
 	rtrs_srv_stop_hb(srv_path);
 
 	for (i = 0; i < srv_path->s.con_num; i++) {
@@ -1552,6 +1551,8 @@ static void rtrs_srv_close_work(struct work_struct *work)
 	/* Wait for all completion */
 	wait_for_completion(&srv_path->complete_done);
 
+	rtrs_srv_destroy_path_files(srv_path);
+
 	/* Notify upper layer if we are the last path */
 	rtrs_srv_path_down(srv_path);
 
-- 
2.25.1

