Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1CBE27F550
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Oct 2020 00:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731678AbgI3Wkh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Sep 2020 18:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731673AbgI3WkQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 30 Sep 2020 18:40:16 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D789AC0613D0;
        Wed, 30 Sep 2020 15:40:14 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id q8so4131651lfb.6;
        Wed, 30 Sep 2020 15:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aBAkipUuHHgj5iDeBSozCkzJhqD3pdBGh4enlH04/3I=;
        b=uoTfFOjPucDv2ygtToiIH8F4SKVFhe+NE9jaXEuiSYh91yxJPGhkZJG5UgMZmCMuNz
         9Dbs/Zd3uYk20Y3+FpJs0SRpoMpIhw2skwo81HMhn40RLjCLbYIntBSwWfzad9SdmpKJ
         NjbBwZD98/C+s0BDi6Iy/ZycQQbTKYjDKXsirylkEHATI74WRt9ua8EUiLCYok+jmPBN
         Jdit+LdZmPjChblpYmL9Guh+qCkZfMi8gkgThn1ZyEkTDLY7hX2f/Di0iOvtUE0uKiYu
         Rw3P5JQ0zT+2W69fGZ6um5gkZs/A0Y8j48NSzhHqCU1qTRegOtT3STH+BevC5J1E1SQU
         vPwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aBAkipUuHHgj5iDeBSozCkzJhqD3pdBGh4enlH04/3I=;
        b=Ayt4cAVqqAv01MsYZYvpLnxrGIAvrfystLdVR4EBJ2WtzaWBvaPHVvsib+B649nCtj
         36QkS9cmVq31l1W9WVzr+3d1wQm1Tqae5eqEXTSE61Z/2TWLZDuHS9iC/9Bl0Jfbl5MN
         Jog8NRrQi5IvlcTeKYo5kJe51ZHsZh8+Ur2hLT4bORRK3EXSEr7nhZLEUDFDorh7GBMb
         rEaoZiUUFuVixUTBN45ab1Be8A69jiPgWkw6FSm1nZKSBzL++h60zi95BO6KmByWDSNv
         HFj+G8+8lOACQ+AzxOqSyapTuT8y12nFjqF6hpnMz0C9DM8S5/JJkiaaRVrT+VdBvnvF
         5Qvg==
X-Gm-Message-State: AOAM530NEYjRTEXVOGiPdcG64bqbQNcz6COHqDihKNDTGKgk5gZsKEOM
        MdtaEpL8Y6ZwYt0R6HfTpME=
X-Google-Smtp-Source: ABdhPJzeGUUodnzjBKFnkP9op85AO18kVexytRWKoGsoB1Jq2W/9WMYVU/ils6tI+usKRPl9wXGEmw==
X-Received: by 2002:ac2:48b2:: with SMTP id u18mr1456797lfg.185.1601505613349;
        Wed, 30 Sep 2020 15:40:13 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-229-94.NA.cust.bahnhof.se. [98.128.229.94])
        by smtp.gmail.com with ESMTPSA id p10sm330893lfh.294.2020.09.30.15.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 15:40:12 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>
Subject: [PATCH rdma-next 2/2] RDMA/rtrs: Constify static struct attribute_group
Date:   Thu,  1 Oct 2020 00:40:04 +0200
Message-Id: <20200930224004.24279-3-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930224004.24279-1-rikard.falkeborn@gmail.com>
References: <20200930224004.24279-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The only usage of these is to pass their address to
sysfs_create_group() and sysfs_remove_group(), both which  takes const
pointers. Make the const to allow the compiler to put them in read-only
memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c | 6 +++---
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
index 298b747d0330..ac4c49cbf153 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
@@ -312,7 +312,7 @@ static struct attribute *rtrs_clt_stats_attrs[] = {
 	NULL
 };
 
-static struct attribute_group rtrs_clt_stats_attr_group = {
+static const struct attribute_group rtrs_clt_stats_attr_group = {
 	.attrs = rtrs_clt_stats_attrs,
 };
 
@@ -388,7 +388,7 @@ static struct attribute *rtrs_clt_sess_attrs[] = {
 	NULL,
 };
 
-static struct attribute_group rtrs_clt_sess_attr_group = {
+static const struct attribute_group rtrs_clt_sess_attr_group = {
 	.attrs = rtrs_clt_sess_attrs,
 };
 
@@ -460,7 +460,7 @@ static struct attribute *rtrs_clt_attrs[] = {
 	NULL,
 };
 
-static struct attribute_group rtrs_clt_attr_group = {
+static const struct attribute_group rtrs_clt_attr_group = {
 	.attrs = rtrs_clt_attrs,
 };
 
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
index cf6a2be61695..07fbb063555d 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
@@ -135,7 +135,7 @@ static struct attribute *rtrs_srv_sess_attrs[] = {
 	NULL,
 };
 
-static struct attribute_group rtrs_srv_sess_attr_group = {
+static const struct attribute_group rtrs_srv_sess_attr_group = {
 	.attrs = rtrs_srv_sess_attrs,
 };
 
@@ -148,7 +148,7 @@ static struct attribute *rtrs_srv_stats_attrs[] = {
 	NULL,
 };
 
-static struct attribute_group rtrs_srv_stats_attr_group = {
+static const struct attribute_group rtrs_srv_stats_attr_group = {
 	.attrs = rtrs_srv_stats_attrs,
 };
 
-- 
2.28.0

