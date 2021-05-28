Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 712673941CC
	for <lists+linux-rdma@lfdr.de>; Fri, 28 May 2021 13:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbhE1LcN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 May 2021 07:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbhE1LcG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 May 2021 07:32:06 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D20C06174A
        for <linux-rdma@vger.kernel.org>; Fri, 28 May 2021 04:30:31 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id j9so4464614edt.6
        for <linux-rdma@vger.kernel.org>; Fri, 28 May 2021 04:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UFAQcFQf4D29+rb3R9Oj+VbFp3/JqstR5WQkYTNsMzA=;
        b=K5E7JFqm+27uKc4Ahy1Glp+OvCBYV7s/EAd3Om1CzM/r90UmaU9x+wRnoYz/zNhJ4l
         dKGhyBnLddtvqW0FGiBCqDTSoVI/kc1WwNvVjLhHbcfvIiPRgXAfTQBWHksKNNh3g9dh
         WAKrcSzOkjje7VNURaS8yCoQW1877VDVt2Oe4sud9pDnIuMPrhGpo6J2qPjnzSh0IEEn
         MfxSVqaBDRQde0aSOHXcLnACf0ptBVJial/rr5+weDedZS315HeZmXJNvsrJI9t69qQn
         kfWLFl+O2jDwkPgAY7MExIvLjMy5xE0oX/dt04Kqn5lQUOGGSDQheANBWestnlgjbM1x
         yL3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UFAQcFQf4D29+rb3R9Oj+VbFp3/JqstR5WQkYTNsMzA=;
        b=EqK5qX5kFjqQGg9ofkdA+XGoCG3hbCMQNE3U3TzhLMAtSdix8FK1w6+r34tMkheEwM
         9f+KSQZLmi7iZdDbEiaZSo7S4xaLGYN6jbn5eAJQauouz/7/KMEgyPKO6DXvPTDPD0SW
         FFlBqFdR7gnkxjMRRYWYsSkNu9rILiG5mruLJXXjWgyiawdgk7OndwxeGhYlvEmv1+k5
         ePA+f0MOWqQHk9qo44ZIwvDc+31oTa1PsgQG4fo5MIAnNSzz+32FquSX7bedZ6Qs3WRE
         LxHPYVdPmBmFZaRcfr+wazBbyODD02OVi2RKHcQWIUxGJO3sYTPpWXL2n7KaW2Bc3YOj
         F9vA==
X-Gm-Message-State: AOAM530s1INyqc5w9yCR1JaMLP3hYd6GP5V4OEW6ucPXYsFZaf1lAFlF
        3/Ifh/fdfbzBmHAzUe+tKgp3wMWBClrmZg==
X-Google-Smtp-Source: ABdhPJxBCMsratx5yMro5kqFto/jfrYyk8gDOn8i7VWBuASt+xq0sb0k4TvwOgMi4f8WnfEG0QptiA==
X-Received: by 2002:a50:fb17:: with SMTP id d23mr9265353edq.338.1622201430116;
        Fri, 28 May 2021 04:30:30 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:497d:7d00:983b:122a:4685:3849])
        by smtp.gmail.com with ESMTPSA id p15sm2594578edr.50.2021.05.28.04.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 04:30:29 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv3 for-next 12/20] RDMA/rtrs-clt: Check state of the rtrs_clt_sess before reading its stats
Date:   Fri, 28 May 2021 13:30:10 +0200
Message-Id: <20210528113018.52290-13-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210528113018.52290-1-jinpu.wang@ionos.com>
References: <20210528113018.52290-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>

When get_next_path_min_inflight is called to select the next path, it
iterates over the list of available rtrs_clt_sess (paths). It then reads
the number of inflight IOs for that path to select one which has the least
inflight IO.

But it may so happen that rtrs_clt_sess (path) is no longer in the
connected state because closing or error recovery paths can change the status
of the rtrs_clt_Sess.

For example, the client sent the heart-beat and did not get the
response, it would change the session status and stop IO processing.
The added checking of this patch can prevent accessing the broken path
and generating duplicated error messages.

It is ok if the status is changed after checking the status because
the error recovery path does not free memory and only tries to
reconnection. And also it is ok if the session is closed after checking
the status because closing the session changes the session status and
flush all IO beforing free memory. If the session is being accessed for
IO processing, the closing session will wait.

Fixes: 6a98d71daea18 ("RDMA/rtrs: client: main functionality")
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Reviewed-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 79324138df9a..88a1c93f244a 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -813,6 +813,9 @@ static struct rtrs_clt_sess *get_next_path_min_inflight(struct path_it *it)
 	int inflight;
 
 	list_for_each_entry_rcu(sess, &clt->paths_list, s.entry) {
+		if (unlikely(READ_ONCE(sess->state) != RTRS_CLT_CONNECTED))
+			continue;
+
 		if (unlikely(!list_empty(raw_cpu_ptr(sess->mp_skip_entry))))
 			continue;
 
-- 
2.25.1

