Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14ECB3495AF
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Mar 2021 16:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbhCYPdy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Mar 2021 11:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbhCYPde (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Mar 2021 11:33:34 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552B0C061760
        for <linux-rdma@vger.kernel.org>; Thu, 25 Mar 2021 08:33:29 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id dm8so2912880edb.2
        for <linux-rdma@vger.kernel.org>; Thu, 25 Mar 2021 08:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5hOLqUS+wxfHQWGO8TQFoPRuI7kC2MV9v5jxSDYaxM0=;
        b=GZaceeiGq0IcWYXuv/GUTb1mkQ9e97g4jm74IAVYVZxsy66vy4CRtFVXNvOnFQrQkH
         jC8QSycXD0Z2wFOCT/FZDxLm+fRFG5QtN43LhAq5lPtn9oqmBkvsqSzJWyAEu+0usMHl
         sRRJJ7helwD4c4clszTdJtUVLNnpWKDhUyhfIMusjarPMDEXcevje2P5ABCBRuomjS0U
         XZnLA256bLq07J94zlJuQ/tdfrispK6aBCrUVDZHn2v02b1V8eiKaNmXIWFVokW3UBRa
         q5BLNSTckIMEZ6Lk6xH8IpLMUD5hqHHgtC/34B+Sz+Qjy2Zme8KTJM5LApEAEMcRXTCE
         tFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5hOLqUS+wxfHQWGO8TQFoPRuI7kC2MV9v5jxSDYaxM0=;
        b=KwfHAPs/OwnLPLcp4Viv5z3a2Nfaha9hzzYeC4y0Fph/4+S9NS948La78HPxOuVOJi
         oGO8wMH2SirVB7A8szYUUlIE2jefJVdKLh2F4rakEW/56DwbZPhaSkSYT7Lka7gw6KdV
         xpxSE6qZ6Yku6gLy5jfXXG3IJFC5d030AlRLstLhC46+fIaNqGJkrJ2vHn7gMEfG/1s7
         CculGR95XXfB4i51j3KcnzJcsaCSVMof/KqhFnNbdQ3MrPyo1eEebfIh7YwEcvr3++3n
         WBKaDL7DrYIiBXZHcaNdCn1XK2IrsoJO9gNCl1fR5Qqeq4JjXDOLSr58vh1IBIwTSFYF
         FTHQ==
X-Gm-Message-State: AOAM531jrmhC5n0zLpxxsQcX4Vg96Ml2qRYVRPacA+vyYifAJ4OFI1ef
        qQGj7Cy2fXSJIQz3FLNkSfGga3b3YkujhKku
X-Google-Smtp-Source: ABdhPJz0uUpiyKy5j6kwMUsGdcZxabp519pThAmc3GPYnnp7cukVuwqcLTxKRPM/zSHlR9EabBociQ==
X-Received: by 2002:aa7:dc0b:: with SMTP id b11mr9927145edu.124.1616686407965;
        Thu, 25 Mar 2021 08:33:27 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id n26sm2854750eds.22.2021.03.25.08.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 08:33:27 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next 18/22] RDMA/rtrs-clt: Simplify error message
Date:   Thu, 25 Mar 2021 16:33:04 +0100
Message-Id: <20210325153308.1214057-19-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210325153308.1214057-1-gi-oh.kim@ionos.com>
References: <20210325153308.1214057-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

Two error messages are only different message but have common
code to generate the path string.

Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index a41864ec853d..eb830c66fa44 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -2468,30 +2468,22 @@ static int rtrs_send_sess_info(struct rtrs_clt_sess *sess)
 static int init_sess(struct rtrs_clt_sess *sess)
 {
 	int err;
+	char str[NAME_MAX];
+	struct rtrs_addr path = {
+		.src = &sess->s.src_addr,
+		.dst = &sess->s.dst_addr,
+	};
+	rtrs_addr_to_str(&path, str, sizeof(str));
 
 	mutex_lock(&sess->init_mutex);
 	err = init_conns(sess);
 	if (err) {
-		char str[NAME_MAX];
-		int err;
-		struct rtrs_addr path = {
-			.src = &sess->s.src_addr,
-			.dst = &sess->s.dst_addr,
-		};
-		rtrs_addr_to_str(&path, str, sizeof(str));
 		rtrs_err(sess->clt, "init_conns() failed: err=%d path=%s [%s:%u]\n",
 			 err, str, sess->hca_name, sess->hca_port);
 		goto out;
 	}
 	err = rtrs_send_sess_info(sess);
 	if (err) {
-		char str[NAME_MAX];
-		int err;
-		struct rtrs_addr path = {
-			.src = &sess->s.src_addr,
-			.dst = &sess->s.dst_addr,
-		};
-		rtrs_addr_to_str(&path, str, sizeof(str));
 		rtrs_err(sess->clt, "rtrs_send_sess_info() failed: err=%d path=%s [%s:%u]\n",
 			 err, str, sess->hca_name, sess->hca_port);
 		goto out;
-- 
2.25.1

