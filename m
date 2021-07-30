Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE3BA3DB935
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jul 2021 15:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238958AbhG3NSr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Jul 2021 09:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238947AbhG3NSq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 30 Jul 2021 09:18:46 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B2BC0613D3
        for <linux-rdma@vger.kernel.org>; Fri, 30 Jul 2021 06:18:41 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id b13so433063wrs.3
        for <linux-rdma@vger.kernel.org>; Fri, 30 Jul 2021 06:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lqPYdNt3Gv7bWSp6dNQq+BRHzI0K63w0pHIcUAXk5rI=;
        b=feJtNpxhED1R1cf0aha3h82MtAB+vMlHhIb7nJ5pOriM1sc3IFsCf0L0tn4Hu+CRBg
         UKfqQFf/p2Yg+mBHHCoveSUx5HHFyY+Ktfodyo25/POt2BP4NuonRaHGEZcZPAx9ytkU
         k8lVsjDno60waMjFLldMShqQR0v5Fvi0/QEZ39tTQFdjjO7r7SPcXAhkuWvWZmb7Yxkk
         wwuHl++TTCj5KryG+bJxe07ENLKgfhJWKwpkntgcMiQzUqUTEhi/qfHd7xwRcrPi/vSR
         4gmwV+JhmE8BRhfKpQfzJN8OQDzn/h1w0jO9zuovCQSGxNanU+T8Rb45RKqpDcfnv3Bl
         GihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lqPYdNt3Gv7bWSp6dNQq+BRHzI0K63w0pHIcUAXk5rI=;
        b=Fj+bCW79sbnd4SMG2DDC9Kx4XZWhu8zENa+58Hyae+6E5Cc8Fw8cmza4eCMp4tVRK4
         umiHswoTd3sXnD7wU69MOKo+hT5hlUcUoKfLoeu+38VGGjYl/jynkgQJpZkKwDlfkOxi
         +0DkU2dQtoOVnFcwBJjK0f3JN8Lh3f46m1oEIHdk62YwdO98OLgh+st5G2/K6QKnu8nB
         xIa6CGQ+PRoDhzs+KLj+4mKdZbni1BD90kirEiFMlcUWnGjMrrhiYI/K3iSVzFko90sN
         aEMJA1tJQBgrQSNwWZ+O7OLgm2cUzTXamCVF5r5WZ0l7rXh88i4MWGWn0ONna2SGnzSj
         iKuw==
X-Gm-Message-State: AOAM531EPp1Y9zZqd4T30KeMe7vrJVzzAP0PeFSRMbRGOCvyfJgCIYDf
        PwJoD6ywlrqMRu2RJtDjice72vRiSTiRrw==
X-Google-Smtp-Source: ABdhPJwVnZSNaTdn1EHR7wL6cqaqR6BJG5gRw+XBoDXyt5e8CX0AoXEpzkGiATVnIZjzXuMxSgwnQg==
X-Received: by 2002:a5d:6991:: with SMTP id g17mr3078606wru.253.1627651119944;
        Fri, 30 Jul 2021 06:18:39 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:496a:8500:4512:4a6e:16f3:2377])
        by smtp.gmail.com with ESMTPSA id z5sm1626012wmp.26.2021.07.30.06.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 06:18:39 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next 08/10] RDMA/rtrs-clt: Fix counting inflight IO
Date:   Fri, 30 Jul 2021 15:18:30 +0200
Message-Id: <20210730131832.118865-9-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210730131832.118865-1-jinpu.wang@ionos.com>
References: <20210730131832.118865-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Gioh Kim <gi-oh.kim@ionos.com>

There are mis-match at counting inflight IO after changing the
multipath policy.
For example, we started fio test with round-robin policy and then
we changed the policy to min-inflight. IOs created under the RR policy
is finished under the min-inflight policy and inflight counter
only decreased. So the counter would be negative value.
And also we started fio test with min-inflight policy and
changed the policy to the round-robin. IOs created under the
min-inflight policy increased the inflight IO counter but the
inflight IO counter was not decreased because the policy was
the round-robin when IO was finished.

So it should count IOs only if the IO is created under the
min-inflight policy. It should not care the policy when the IO
is finished.

This patch adds a field mp_policy in struct rtrs_clt_io_req and
stores the multipath policy when an object of rtrs_clt_io_req is
created. Then rtrs-clt checks the mp_policy of only struct
rtrs_clt_io_req instead of the struct rtrs_clt.

Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c | 2 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt.c       | 7 ++++---
 drivers/infiniband/ulp/rtrs/rtrs-clt.h       | 1 +
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c b/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
index 4f1980a3608a..61d5e0018392 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
@@ -174,7 +174,7 @@ void rtrs_clt_update_all_stats(struct rtrs_clt_io_req *req, int dir)
 
 	len = req->usr_len + req->data_len;
 	rtrs_clt_update_rdma_stats(stats, len, dir);
-	if (sess->clt->mp_policy == MP_POLICY_MIN_INFLIGHT)
+	if (req->mp_policy == MP_POLICY_MIN_INFLIGHT)
 		atomic_inc(&stats->inflight);
 }
 
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 3cf7118a1c00..5cce727abca0 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -438,7 +438,7 @@ static void complete_rdma_req(struct rtrs_clt_io_req *req, int errno,
 	}
 	if (!refcount_dec_and_test(&req->ref))
 		return;
-	if (sess->clt->mp_policy == MP_POLICY_MIN_INFLIGHT)
+	if (req->mp_policy == MP_POLICY_MIN_INFLIGHT)
 		atomic_dec(&sess->stats->inflight);
 
 	req->in_use = false;
@@ -964,6 +964,7 @@ static void rtrs_clt_init_req(struct rtrs_clt_io_req *req,
 	req->need_inv_comp = false;
 	req->inv_errno = 0;
 	refcount_set(&req->ref, 1);
+	req->mp_policy = sess->clt->mp_policy;
 
 	iov_iter_kvec(&iter, READ, vec, 1, usr_len);
 	len = _copy_from_iter(req->iu->buf, usr_len, &iter);
@@ -1154,7 +1155,7 @@ static int rtrs_clt_write_req(struct rtrs_clt_io_req *req)
 			    "Write request failed: error=%d path=%s [%s:%u]\n",
 			    ret, kobject_name(&sess->kobj), sess->hca_name,
 			    sess->hca_port);
-		if (sess->clt->mp_policy == MP_POLICY_MIN_INFLIGHT)
+		if (req->mp_policy == MP_POLICY_MIN_INFLIGHT)
 			atomic_dec(&sess->stats->inflight);
 		if (req->sg_cnt)
 			ib_dma_unmap_sg(sess->s.dev->ib_dev, req->sglist,
@@ -1260,7 +1261,7 @@ static int rtrs_clt_read_req(struct rtrs_clt_io_req *req)
 			    "Read request failed: error=%d path=%s [%s:%u]\n",
 			    ret, kobject_name(&sess->kobj), sess->hca_name,
 			    sess->hca_port);
-		if (sess->clt->mp_policy == MP_POLICY_MIN_INFLIGHT)
+		if (req->mp_policy == MP_POLICY_MIN_INFLIGHT)
 			atomic_dec(&sess->stats->inflight);
 		req->need_inv = false;
 		if (req->sg_cnt)
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.h b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
index c31f920e6d10..6d81aae53df4 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
@@ -101,6 +101,7 @@ struct rtrs_clt_io_req {
 	unsigned int		usr_len;
 	void			*priv;
 	bool			in_use;
+	enum rtrs_mp_policy     mp_policy;
 	struct rtrs_clt_con	*con;
 	struct rtrs_sg_desc	*desc;
 	struct ib_sge		*sge;
-- 
2.25.1

