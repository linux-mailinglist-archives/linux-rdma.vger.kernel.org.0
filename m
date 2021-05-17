Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97E1C382816
	for <lists+linux-rdma@lfdr.de>; Mon, 17 May 2021 11:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235863AbhEQJU4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 May 2021 05:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235883AbhEQJUm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 May 2021 05:20:42 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0480C06138B
        for <linux-rdma@vger.kernel.org>; Mon, 17 May 2021 02:19:22 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id h16so5995433edr.6
        for <linux-rdma@vger.kernel.org>; Mon, 17 May 2021 02:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QdCAwu4GIfez2JsFvxw8TKqtVpDtoR+sxsJV0Fs4i0A=;
        b=heBIZhyeUYw+UYE4xtk17Vw7frMyzSMhXmHn3pBazFYq/eps8bjJOjvNEOkoppmLyZ
         sRhs7q4N5mXBfS9cT8+XI4u3pTMeHVhvr4lVaq1BlwRbJwFSIZUbIPqqXkI6q0z3oJOF
         gxeUf4VMqwrsF6eXyeKwBBmh5DTIa27OZA312J3i1HH8KQpP9etBezELdw5vzBoGgTI7
         82ZV1j3VjzNHPtACPb75ay0Q0CnqodF+3WqSLEpuDEw8Gu0upBtv/kKjv6jwGPwJjR3g
         2nV5HBKi5pIkfzxxPhEA4GXzg1Go2ET+ZGnPu1aMWnwnAVG6BHBnMq0OyJlQ/09pNpoK
         qgKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QdCAwu4GIfez2JsFvxw8TKqtVpDtoR+sxsJV0Fs4i0A=;
        b=cy7khMD/cXxxkzCcAjQl710dgQoCQAI3m7v9zO0MCgCE4/5qxQ+qPlhRt2EXZVsEJG
         E03CoaIveb6jnCvfjlB2LNq0nCWj6euuH1VRNkkklbavbly/9WyzrBP/jEiQLWbHmGTt
         vTRhSMIfROXSxgdn7aGakIxPd0CtiNWnFl4WWqbaHf+cVq93o6bO7GRHBPK5HzYgJMuD
         D6FSz+qW+C0yAYUatTOHNfwIFv3kaVJN+OpJzIgG7jpXpDAHrF0BnQq3i5kO3tFzzI6l
         NcdhyDVnbi9QFKZyWAZmf0t1dLl9V8kQr5O6hkC67pgprnCiYAFl/JSV2eIf1ypYseju
         V4XA==
X-Gm-Message-State: AOAM533lqeqAmmNYN5D4VleNrjbgvXmLk1kG5ozvXsN9F5P0gzCu0yxa
        RYbEdcETqa9giuyackT98JO5+ejvU4bdXQ==
X-Google-Smtp-Source: ABdhPJywDujAR5EM+JNlrn6es/HceFehWbpJb489HnVMy3805ocfAeWJud7NW3ycFPisThxzBJId7A==
X-Received: by 2002:a05:6402:176f:: with SMTP id da15mr25646476edb.380.1621243161564;
        Mon, 17 May 2021 02:19:21 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aef30.dynamic.kabel-deutschland.de. [95.90.239.48])
        by smtp.googlemail.com with ESMTPSA id g10sm7925845ejd.109.2021.05.17.02.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:19:21 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Guoqing Jiang <guoqing.jiang@ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv2 for-next 08/19] RDMA/rtrs-clt: Kill rtrs_clt_{start,stop}_hb
Date:   Mon, 17 May 2021 11:18:32 +0200
Message-Id: <20210517091844.260810-9-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517091844.260810-1-gi-oh.kim@ionos.com>
References: <20210517091844.260810-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

The two wrappers are not needed since we can call rtrs_{start,stop}_hb
directly.

Signed-off-by: Guoqing Jiang <guoqing.jiang@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index a2505ea4a7a2..0f19c133b7cc 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1449,16 +1449,6 @@ static void rtrs_clt_init_hb(struct rtrs_clt_sess *sess)
 		      rtrs_wq);
 }
 
-static void rtrs_clt_start_hb(struct rtrs_clt_sess *sess)
-{
-	rtrs_start_hb(&sess->s);
-}
-
-static void rtrs_clt_stop_hb(struct rtrs_clt_sess *sess)
-{
-	rtrs_stop_hb(&sess->s);
-}
-
 static void rtrs_clt_reconnect_work(struct work_struct *work);
 static void rtrs_clt_close_work(struct work_struct *work);
 
@@ -2088,7 +2078,7 @@ static void rtrs_clt_stop_and_destroy_conns(struct rtrs_clt_sess *sess)
 	 */
 	synchronize_rcu();
 
-	rtrs_clt_stop_hb(sess);
+	rtrs_stop_hb(&sess->s);
 
 	/*
 	 * The order it utterly crucial: firstly disconnect and complete all
@@ -2281,7 +2271,7 @@ static int init_conns(struct rtrs_clt_sess *sess)
 	if (err)
 		goto destroy;
 
-	rtrs_clt_start_hb(sess);
+	rtrs_start_hb(&sess->s);
 
 	return 0;
 
-- 
2.25.1

