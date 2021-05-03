Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F55B371487
	for <lists+linux-rdma@lfdr.de>; Mon,  3 May 2021 13:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbhECLtZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 May 2021 07:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbhECLtY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 May 2021 07:49:24 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECCAC061763
        for <linux-rdma@vger.kernel.org>; Mon,  3 May 2021 04:48:31 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id n2so7386840ejy.7
        for <linux-rdma@vger.kernel.org>; Mon, 03 May 2021 04:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ODVb56OFxa69WMChKUst3ovUVtRNZURBLnBOxe5egCE=;
        b=OgCPuqk7G/b7f00LUARDl+htF3K3CAtfecF7HaTlQSoEGk6eZbHS+zmE89oqkJ0DSx
         GjJ8QKHgbM0eTYW0WkFBdzvx4d9eiQQgQE+REoi/f+j2HsA/IQdKi9E89MVH69elka2k
         mCo3b93f7ujCncX2O495tz1IMfUHHLLbgO0tZPafFKsiUfbk6DCuGVmh/TPmqPxjosmd
         F6cdiTKGfCxrMi+M14ZWUDN/RTnGygMiqgOh44BpwkMOtqiekIxA/7enVfFFZyGP3vNu
         wexZAIDmYIRaKHHTxF3rfrUUE8B0lWM/Ags1zdHZgmF+/ZdCejrgbkroeqNlZxpcsf/t
         giAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ODVb56OFxa69WMChKUst3ovUVtRNZURBLnBOxe5egCE=;
        b=eQAxhM3NJzxXaXDQtAJUy3cZzo+dRHlTQUH8Omno526g6p7xlLGukXiiTzZsITcyoH
         zgKqfJyiZqp9Y0B+YqVQdqa06yy4j30B01Nt52UNSlTlmH78cjbyTJHLBMQw8nUH+e4d
         LxgzWR/+LMYStsXhb9GlnoCsHbIs/x5Nk1ZLa0xOKCxZAI8A5blCDBDnhoVZGiIfBEvx
         1gzZzr+4WVmOFNJQxomb7e250xbFF1QRGpo42b5gxTutvosCkAvhzxLGxS9GtQLc4uZw
         Q/snry6yF+T72s9QH7XDK6QgoqNpWFZeGoPjaW4cSROpmXdOx5jxIPwRHTakNggY3boe
         BOBw==
X-Gm-Message-State: AOAM53065w12eBmmqB3zGZzT3iZXTc9wMbBcIa07jypW2vsuqqmJ2t9t
        69VcnLJ3dMeHYqr5VCpmbPt7B9RjpQPIBw==
X-Google-Smtp-Source: ABdhPJwGvVpIewWY6+XnXNEBXIlMx4yoUWz2G2snxjrRJlZ4AxoAoTdEiY5Ir7RyQ/e1IlWveS53Jg==
X-Received: by 2002:a17:906:b0cd:: with SMTP id bk13mr16558180ejb.184.1620042510073;
        Mon, 03 May 2021 04:48:30 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aef30.dynamic.kabel-deutschland.de. [95.90.239.48])
        by smtp.googlemail.com with ESMTPSA id z12sm7307705ejd.83.2021.05.03.04.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 04:48:29 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next 13/20] RDMA/rtrs-clt: Check state of the rtrs_clt_sess before reading its stats
Date:   Mon,  3 May 2021 13:48:11 +0200
Message-Id: <20210503114818.288896-14-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210503114818.288896-1-gi-oh.kim@ionos.com>
References: <20210503114818.288896-1-gi-oh.kim@ionos.com>
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
index a57b77998573..c8a7807793bf 100644
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

