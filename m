Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5414D38281B
	for <lists+linux-rdma@lfdr.de>; Mon, 17 May 2021 11:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235894AbhEQJVB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 May 2021 05:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235912AbhEQJUm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 May 2021 05:20:42 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E154CC06138F
        for <linux-rdma@vger.kernel.org>; Mon, 17 May 2021 02:19:25 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id l4so8090680ejc.10
        for <linux-rdma@vger.kernel.org>; Mon, 17 May 2021 02:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t9spLpXFhwgznh2rJ1JCTTogPUurloVja5s9Gl7Y1Wk=;
        b=Q9i2I6M6jf0S6vzxr30LVFxS+pCGN5q0qSG8skUTVh6F4Du5mG3gyiJhzOOwX6gV6o
         tHnB0yXgEgyyKMdpD79JVW4VKU3adAzhvREiwWNkPRMdx5CBcm1/sRoqO3UOD2bl9D9K
         Kx/ZzQJJJ4Ua9c+lrpWCotcMS2t6ZyJDQMCCo6i6S9ZJNOvdoNgU+Lad6pj2daZhlDo5
         TM3jZ8sBHRSlMRYfbjdLmV6d1tDfJpJ/cqdOvp39sR0vYK6MDgyAh5bD1KmFfyUQ9q0+
         Mu+dPxO42zsyEfshUyHjxvZHevrdr920yrWdqERbS/Mhmqkb+pLbVHDlDRGUpmeFi8Pm
         uUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t9spLpXFhwgznh2rJ1JCTTogPUurloVja5s9Gl7Y1Wk=;
        b=MUj+CxyKInzdf21p2aob/lYgqkBQM9HlBYixSrNxRovkcCkIDy+TLuDvOPcVJUH+4G
         er4wFBTSq9B6JO19ttUG1nVxubMBtqS70xwFWHW0tUVtASeAkopGNcaG9D+5o0ZWltt1
         cSF0bofoDVomXEAw9NKVLX9foQXIG0DHeeo7og7hkvfUKm1G+8Q3oHJPOBXsfeE0I75a
         Ht9WGuXdUVxpIFwkiSAobMvZa62Fkt+0t+4Q+fp951Js9YT16hBPPSby7mmVsaR8Dsww
         EAMTO7z/4H0lEBncYqwYGUDWeKQ5kNIUtH/aRlLyW/xere+j+kYiagKzjKuaV5iVeCPu
         YA+w==
X-Gm-Message-State: AOAM530jTEh84mf9Omw65BEiK2ocEx0XBnQo/to6aba6ji7eZ9r/z9c5
        wMstdI8b2aK0oWxwwnAtwMMkFPwaqmppRA==
X-Google-Smtp-Source: ABdhPJxHGkbG4oeyYOQ+Ey5y0ZDJdQdh3IjHDjNnwgTmhDKCHkg/J2nQvF+6oActDKk/44wCUuy/yg==
X-Received: by 2002:a17:906:6ad0:: with SMTP id q16mr62392095ejs.286.1621243164425;
        Mon, 17 May 2021 02:19:24 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aef30.dynamic.kabel-deutschland.de. [95.90.239.48])
        by smtp.googlemail.com with ESMTPSA id g10sm7925845ejd.109.2021.05.17.02.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:19:24 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv2 for-next 12/19] RDMA/rtrs-clt: Check state of the rtrs_clt_sess before reading its stats
Date:   Mon, 17 May 2021 11:18:36 +0200
Message-Id: <20210517091844.260810-13-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517091844.260810-1-gi-oh.kim@ionos.com>
References: <20210517091844.260810-1-gi-oh.kim@ionos.com>
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
connected state because closing or error recovery paths can change
the status of the rtrs_clt_Sess.

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
index 757a4394fdb6..a3d20a5c5112 100644
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

