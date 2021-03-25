Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E19363495A9
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Mar 2021 16:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbhCYPdx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Mar 2021 11:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbhCYPd3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Mar 2021 11:33:29 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBF7C06174A
        for <linux-rdma@vger.kernel.org>; Thu, 25 Mar 2021 08:33:28 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id k10so3679732ejg.0
        for <linux-rdma@vger.kernel.org>; Thu, 25 Mar 2021 08:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TJCwoVhfX9oy4H7t6rqMBZgpJQ6NEUddCrBFP66DKN0=;
        b=UmvvOTa4qLOYiJGiwfWwX3o+CKcJ6EeG68W1bT/KANdySMM6RvDtn8sBDb/Iyc+cru
         RV/4sLpIwPb1lL+UM7RmzCEXHpMClfKINW3uK6Y9GdiTYHXIqVNChkX+TgAw2Nnwy1+r
         ls0o4dxxLsQmBC3gTY0q95cYcKeiOZ+wAD0JQJVeLjJwLdX5qzNkaKWa/6PDXBaLHajG
         xoUrrKxjsjztZLuuVDQYJLyevWkYyUILFepaCuSPqWvy1rVwn6dF0Hofk7NbHblRmzhl
         lugufnZo84XExLe0wa00fMSmx9t2LAz3OfgGmaDxZgBmToH7xvn8Irxg8LOKa4M9xu6B
         jJew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TJCwoVhfX9oy4H7t6rqMBZgpJQ6NEUddCrBFP66DKN0=;
        b=Lq2aOOqk+mEZhebkKe3rvQRkJpN/EEfGIs8tpm7UzN4paHxqzLRrUH2YOdS4habRlh
         rVps9Ij2VEjmIYIx5CEc5Xd52MEn+mcpRLQ62HNN+qPMf9kKowIqZvB4WOqA+DEh+vVO
         GJBoKJyWH7dgNnFBJvQWiI8Cz88O+ZzogqXvJORfDOJWcc2KG66sB+hWeQ09vjXo3Rbo
         PAhU69dg1nIsfvI1lebf3XAoge5v/+OaAyC51fyeJqdVZOO7iTobSWKVuFIbf9wA/Whp
         Rp+8o++D6zUHhoDJTrl/8SNneuieftYdAdGRzWCC8jinKCMW+CfdcXDPd+ZzOBn6Z9ca
         1cTQ==
X-Gm-Message-State: AOAM532LDZXhLPeG/hJ/sN43cNuHj0YGSyeEmuW/zpTo80xUqzwdRbdd
        hWKQ8h6kGPSypQXPnMhq05MBcO5kHiIpUPP1
X-Google-Smtp-Source: ABdhPJz3atv/57We2Pj2IcwVbdwMDd2Cm2CfP2utwWoO2mUGz6Ev2i3e7GOET+XmRWbT01/QA34lHQ==
X-Received: by 2002:a17:906:228d:: with SMTP id p13mr10184391eja.412.1616686406507;
        Thu, 25 Mar 2021 08:33:26 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id n26sm2854750eds.22.2021.03.25.08.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 08:33:26 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next 16/22] RDMA/rtrs-srv: Report temporary sessname for error message
Date:   Thu, 25 Mar 2021 16:33:02 +0100
Message-Id: <20210325153308.1214057-17-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210325153308.1214057-1-gi-oh.kim@ionos.com>
References: <20210325153308.1214057-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

Before receiving the session name, the error message cannot
include any information which connection generates the error.
This patch stores the addresses of source and target in the
sessname field to show which generates the error. And that field
will be over-written when receiving the session name from client.

Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index c1428cf602bc..8ec9c30b9887 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1690,6 +1690,9 @@ static struct rtrs_srv_sess *__alloc_sess(struct rtrs_srv *srv,
 {
 	struct rtrs_srv_sess *sess;
 	int err = -ENOMEM;
+	char str[NAME_MAX];
+	struct rtrs_sess *s;
+	struct rtrs_addr path;
 
 	if (srv->paths_num >= MAX_PATHS_NUM) {
 		err = -ECONNRESET;
@@ -1724,6 +1727,14 @@ static struct rtrs_srv_sess *__alloc_sess(struct rtrs_srv *srv,
 	sess->cur_cq_vector = -1;
 	sess->s.dst_addr = cm_id->route.addr.dst_addr;
 	sess->s.src_addr = cm_id->route.addr.src_addr;
+
+	/* temporary until receiving session-name from client */
+	s = &sess->s;
+	path.src = &sess->s.src_addr;
+	path.dst = &sess->s.dst_addr;
+	rtrs_addr_to_str(&path, str, sizeof(str));
+	strlcpy(sess->s.sessname, str, sizeof(sess->s.sessname));
+
 	sess->s.con_num = con_num;
 	sess->s.recon_cnt = recon_cnt;
 	uuid_copy(&sess->s.uuid, uuid);
-- 
2.25.1

