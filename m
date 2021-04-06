Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEB543552FB
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Apr 2021 13:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343628AbhDFL7Z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Apr 2021 07:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343683AbhDFL7X (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Apr 2021 07:59:23 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE3EC06174A
        for <linux-rdma@vger.kernel.org>; Tue,  6 Apr 2021 04:59:15 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id e14so21441678ejz.11
        for <linux-rdma@vger.kernel.org>; Tue, 06 Apr 2021 04:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AJ8EE9a1aaA2NjqRI5Hjn1ZoiC2KvCOdFdCuxW4nmlA=;
        b=UJEMyNn1+4i8rzzmvr2xb6tQfyI0kaoTDzUn1vDZn5sRHmPV5igy8ZJDUdw6h1LPGP
         LRZDPE9JDbFYXv/En+ZZuV0GRfzOfIyPdbrNdeHVydLtxPrk4vhVnKLLPc69jZJfYcR1
         ARipQ6Yyoq3FGxotSO9STf9YdEE2vCMXtbjWfMkctXys8L8bKUrfrm1aoIRYjsKttnrF
         wXSKOZdDIEtF5Aj6lijuEhsw/HLrUmDBVpGL9rb6TnSgvHNEuBBMpzwkkCEXeibVOppO
         xvAzk16pAHbKuwXCJaUNygX9H9NJ/kWwJPy8yH+C3bmzRoQIg7PCHhKRaOp0omCEB7C+
         GP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AJ8EE9a1aaA2NjqRI5Hjn1ZoiC2KvCOdFdCuxW4nmlA=;
        b=Oy9wcbQs9C+5TgIA2HhFx+XWEQRU+1dL0wroz+18mQMl9Je2LWx6US0o4/Hv5Yt8yK
         AM5LNW6QStRYcQoKfjDiBwDyV9yttpjmN5GdSRYTOcgPcfpaHkwhUhDPBsPI+gAz4bvd
         UGVVkpUPb6LLj63+G5qTZcqiFLH+V5N0yppEi+d/UQGESR+gkC5Uh0X5E3m6aZWZ5oAq
         sv2HOTB1HlHRcfPbhRlgZKk+gGTHz7c//+zYz8ys31T/akjg1Axbi4oITxKuxnOIXq85
         bdn0mzFq3A1iE3jyXWUQjRktqKm2ijOjMDSC2VZ05XZszlmgyVZfitpzeZjYjXBQ2ktW
         ylAA==
X-Gm-Message-State: AOAM532H0yir7oWip+mf+6zYkkbB4Gml6hLFgJiVjzqNYdGhk+r6ARav
        6wrNaQpDEcTGO9oKBzkg75bmfknBRphGl0jC
X-Google-Smtp-Source: ABdhPJwyiNpYFQS280rW7Z3jhuFdyWW5iCwy3yG53WdhvUZAf+l+rN5sN1HnhFrAP7cbGWlRY4I46Q==
X-Received: by 2002:a17:906:2bc3:: with SMTP id n3mr33532052ejg.418.1617710353818;
        Tue, 06 Apr 2021 04:59:13 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id da12sm3554954edb.34.2021.04.06.04.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 04:59:13 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH 3/3] RDMA/rtrs-clt: Simplify error message
Date:   Tue,  6 Apr 2021 13:59:08 +0200
Message-Id: <20210406115908.197305-4-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210406115908.197305-1-gi-oh.kim@ionos.com>
References: <20210406115908.197305-1-gi-oh.kim@ionos.com>
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
index bb10a0969e56..0fa80e0a3f27 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -2462,30 +2462,22 @@ static int rtrs_send_sess_info(struct rtrs_clt_sess *sess)
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

