Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3925B3E2970
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Aug 2021 13:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235355AbhHFLWH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 Aug 2021 07:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242230AbhHFLWB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 6 Aug 2021 07:22:01 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA65C06179A
        for <linux-rdma@vger.kernel.org>; Fri,  6 Aug 2021 04:21:45 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id qk33so14507705ejc.12
        for <linux-rdma@vger.kernel.org>; Fri, 06 Aug 2021 04:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ltfMO6P98dB/0rRW6F6oK+hKGGCpIWX+aPac3is5hm0=;
        b=avvofsdI29UBhNcAzPxsLSvzqreFAg8VSQABFJsiicv20zGWSw2qrRVh54gXGDHKfV
         vJ2qLtFmDzklJ+v+iK6efrwu11vzSFs/Aq7xH+4+3e5NjmiJqROkZoANELiN803tyrPT
         UBUcF2pHMjsIpDasbZWAzMv1MFMN4/NxpBj/SqiIN79+DZ4NMxRkVcZQq8AJP+Vi7KX0
         0bWWBFoJJU68rCIYTbWnJYraOTEMKMRtUSpRf60CYaKPdV2XGcy0/ge4KYIIEGOyG7sT
         ztOByjBg+IlbL6/Fad4TKTe5oEtdaRKt3fqeUI2u6YmhrnlcJicBQz0GA/9JtkNzurFf
         j+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ltfMO6P98dB/0rRW6F6oK+hKGGCpIWX+aPac3is5hm0=;
        b=Xz/qrqXAMhfQqLECoizyAjtPlP28qol/afgcva4eFR1ppEVA8bPosADcy2EDRGFxcd
         HE+yzmtY1YVL39No5GTNL0jOZpnwUj6KUkQQwbRNTRSvBI2Cq/AtFs3RrBNuqlRIzSUZ
         Sk4RGBYbYRVY1gOlK5Iw3VO0opnE3VVQ4U1Xk2K7fRwewtNjMhGXztX6TNnzVCiczlaW
         T5jMoOnSpLIABuAMGOYb3GAmjq53jGU6vpcT7x7Ew3PsmHdGs5uqMielCiniN8cwZQyy
         4pyrgwFkdZB4JixMkEiAg4aFARGn8nJP75FPexZ961t1MlwOJqWC5oGmBFJ8YmQ5DHjq
         ZbGA==
X-Gm-Message-State: AOAM530xayXA6TeWzWyuGpC10HewaidyPW9HghPmaWJ8yeHFj3sQafuT
        KDOFYzJ+VH5IdOR0igwEi8sqYdeIPLvHkA==
X-Google-Smtp-Source: ABdhPJwOtQOZJul6vBSeXy4sgbMZAZo8qmj8QNw2V6ffukbKzc/2OZpJ61azE4TZ/GuKx4Y+JnFOFg==
X-Received: by 2002:a17:906:acf:: with SMTP id z15mr9356481ejf.512.1628248904099;
        Fri, 06 Aug 2021 04:21:44 -0700 (PDT)
Received: from nb01533.pb.local ([2001:1438:4010:2540:9e61:8a1a:7868:3b15])
        by smtp.gmail.com with ESMTPSA id q11sm2794729ejb.10.2021.08.06.04.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 04:21:43 -0700 (PDT)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@ionos.com>,
        Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH v2 for-next 5/6] RDMA/rtrs-clt: Fix counting inflight IO
Date:   Fri,  6 Aug 2021 13:21:11 +0200
Message-Id: <20210806112112.124313-6-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210806112112.124313-1-haris.iqbal@ionos.com>
References: <20210806112112.124313-1-haris.iqbal@ionos.com>
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
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c | 2 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt.c       | 7 ++++---
 drivers/infiniband/ulp/rtrs/rtrs-clt.h       | 1 +
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c b/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
index b660c96a3039..5e780bdd763d 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
@@ -180,7 +180,7 @@ void rtrs_clt_update_all_stats(struct rtrs_clt_io_req *req, int dir)
 
 	len = req->usr_len + req->data_len;
 	rtrs_clt_update_rdma_stats(stats, len, dir);
-	if (sess->clt->mp_policy == MP_POLICY_MIN_INFLIGHT)
+	if (req->mp_policy == MP_POLICY_MIN_INFLIGHT)
 		atomic_inc(&stats->inflight);
 }
 
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index d3e1173e2acd..ef2904226ea2 100644
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
index 72f9136e3c24..9dc819885ec7 100644
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

