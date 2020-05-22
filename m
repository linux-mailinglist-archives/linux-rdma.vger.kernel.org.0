Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56BFF1DE1CB
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2020 10:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbgEVI2i (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 May 2020 04:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728814AbgEVI2i (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 May 2020 04:28:38 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210AFC061A0E;
        Fri, 22 May 2020 01:28:38 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id l17so9325095wrr.4;
        Fri, 22 May 2020 01:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=abcoJk2Ej1/pByjWlWCcArJRiMosXUxELnPioeN+4oM=;
        b=jR5px4X0Q+1gkBgRMzjiRTeKOkOpX5IYrFjr2mNCwO5SiVYDITah9dUP1ArvhbrpUX
         OKkjdF+/JnG5ufaYvyKaYY1u8nBGSch6n0z9pFJuAOWSNmY+A2PQbvok8fWc2ffqTnsH
         tvpBGdVee9FssYsJYBtmPj64znIln9WaQuPQ16ZyEVI2eJ36XMqii4h/EX+ZtckqGYb0
         VVlV9dxQSB5ZW8D3OeJF8MMasNMYAmkPhJ0kaHcss4kMSBnFspL74638n8EKX9dHE7OJ
         LKcAC7iUFjgQXNXBstV/iQBaF0IvvnyMUIqS/v8JOzIG6CDETeJIFC6PtqgnGEDyqLM9
         dLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=abcoJk2Ej1/pByjWlWCcArJRiMosXUxELnPioeN+4oM=;
        b=VP87lU6cbM7Tlfc/N3yJlOCU+jL6bjeVxicFraZOmXB83L0H8ZvHK9s1CPcEiRumuW
         JrVWBoQugnMBUIG6/K6geCJZqeqUJbC+ISjNhLCE3ew1Lrb3ZQcir3nVNGSV6PtA5vSo
         1iszbB3wRLC5IaJ5dBdfNl4zyyn5WPMEREvtyaU1NfE+tjsdm1cCncEo++ni9fTLoxqe
         DgNMnKk9N4ZWndW23W+1Rb59LS5ZoxmHzeIZnvy6T5NgvsVkSeRkAyIo1gbESoFL4/6y
         qLvCLsdMbNu0OrFCrdpZDZoXEqan0+v23gmg1h01PhstOeXbVIs9o61P00CEjHQAcrC+
         b7AA==
X-Gm-Message-State: AOAM532OP+HhrVslm9rF3Odcylit9YV8gzhogHfO1Eb2xpDpTelGfV7i
        IEuMlSOZfqk+UlnXb2iNji3jFt5l0xC2mA==
X-Google-Smtp-Source: ABdhPJwJVMWClOn9DCvaY7m6jfEebfsMfY/AKU2SXjN5VEzla1Pbllpe9lCEWzHyycXCMEe4VaYDzQ==
X-Received: by 2002:a5d:5682:: with SMTP id f2mr2339637wrv.382.1590136116592;
        Fri, 22 May 2020 01:28:36 -0700 (PDT)
Received: from localhost.localdomain (ip217-160-210-68.pbiaas.com. [217.160.210.68])
        by smtp.gmail.com with ESMTPSA id t22sm8768630wmj.37.2020.05.22.01.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 01:28:35 -0700 (PDT)
From:   haris.phnx@gmail.com
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com
Cc:     axboe@kernel.dk, dledford@redhat.com, jgg@ziepe.ca,
        Md Haris Iqbal <haris.phnx@gmail.com>
Subject: [PATCH] RDMA/rtrs: server: use already dereferenced rtrs_sess structure
Date:   Fri, 22 May 2020 08:28:33 +0000
Message-Id: <20200522082833.1480551-1-haris.phnx@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Md Haris Iqbal <haris.phnx@gmail.com>

The rtrs_sess structure has already been extracted above from the
rtrs_srv_sess structure. Use that to avoid redundant dereferencing.

Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
Signed-off-by: Md Haris Iqbal <haris.phnx@gmail.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 1fc6ece036ff..5ef8988ee75b 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1822,13 +1822,13 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
 		/*
 		 * Sanity checks
 		 */
-		if (con_num != sess->s.con_num || cid >= sess->s.con_num) {
+		if (con_num != s->con_num || cid >= s->con_num) {
 			rtrs_err(s, "Incorrect request: %d, %d\n",
 				  cid, con_num);
 			mutex_unlock(&srv->paths_mutex);
 			goto reject_w_econnreset;
 		}
-		if (sess->s.con[cid]) {
+		if (s->con[cid]) {
 			rtrs_err(s, "Connection already exists: %d\n",
 				  cid);
 			mutex_unlock(&srv->paths_mutex);
-- 
2.25.1

