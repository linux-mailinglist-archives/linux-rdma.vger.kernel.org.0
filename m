Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 144CB45B643
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Nov 2021 09:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241167AbhKXINy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Nov 2021 03:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241125AbhKXINy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 24 Nov 2021 03:13:54 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023D7C061574
        for <linux-rdma@vger.kernel.org>; Wed, 24 Nov 2021 00:10:45 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id x6so6573791edr.5
        for <linux-rdma@vger.kernel.org>; Wed, 24 Nov 2021 00:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=95Ig2wU3yjxnt0yC7MVGnzD8fvLnDRvEpp4Z/SKrChI=;
        b=PUB1RjAsJVUhzOfv/nOL3Tv57ZPSdxje88JoWgfeWYqyKWlqffsj1JO4Em78oF0TNi
         1RKefdnGDf76cAcpyv+r9IyXiwh4qMELXzBSu7K8nx+bxGNCQpdQc8KeF91YqD5K6pCO
         8zhIxNWFheo75c9/8jxTtSlve0eZL+kxRWcxWABNe4FZcdbKrCcxn+s1MW9GY9c1BLTF
         nvK2jr29aCCazseI604kwro9gSE9EidFaOUzIW4074tlOj02h5EO2deZHg2cqBmiM8J8
         TrvIOTzkQfCqg9awOWh2fbexQtFA9P1Lm5244h9gII/I14yJpUX6IS3j0WJtbjoeVG56
         Vptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=95Ig2wU3yjxnt0yC7MVGnzD8fvLnDRvEpp4Z/SKrChI=;
        b=dJAvokJ0++M7KvmpG2gPUCQFZ5VceJeArN2De/u++uciFLu3OtNyKN8w74q10xmNMN
         xflxngJuVhnKLyPg2F8FlvIP0aYe8mOuzzzcUv54oqsbO4Gw8oJ78uJpmhds/ms1AKmO
         wnqL8iFMewHUEyNAVLNNtwwSOGgCpUBJX+p+KdJvR6Oy5NhTlb1Q9jHnNKZ62q5PdCH5
         YTROIpru99pqos4L6VOTsvZTvRTPDfsF7Hm0Dstm4ItHLwCTygdvGtFz4n/yacmu4CfJ
         z774ZH3LqJu+d2vrPV13C1KAkKI5Sa0pt17b3tiA6mB01S3GnWo5l0Qyre5SUHOU7Gnx
         3jwA==
X-Gm-Message-State: AOAM533nbNeglrLzHBP+pgAGTQvQinVvEtDKZ/eVdkmU3h2OWjkzWA6y
        uP1mZuas3MXp8hvIwOG0ldf0qDVyM0tPyA==
X-Google-Smtp-Source: ABdhPJzpT47slkD8Fuafoh5kWHTReUHMn4NTGKMNGqINhxfcmi5wTRv25SfwwfyRVou0MoWpY0q8/w==
X-Received: by 2002:a17:906:d553:: with SMTP id cr19mr17117487ejc.140.1637741443450;
        Wed, 24 Nov 2021 00:10:43 -0800 (PST)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4551:e400:8588:d712:ac6c:767a])
        by smtp.gmail.com with ESMTPSA id z22sm7769767edd.78.2021.11.24.00.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 00:10:43 -0800 (PST)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com
Subject: [PATCH] RDMA/rtrs-clt: Fix the initial value of min_latency
Date:   Wed, 24 Nov 2021 09:10:40 +0100
Message-Id: <20211124081040.19533-1-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The type of min_latency is ktime_t, so use KTIME_MAX to initialize
the initial value.

Fixes: dc3b66a0ce70 ("RDMA/rtrs-clt: Add a minimum latency multipath policy")
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 15c0077dd27e..e39709dee179 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -867,7 +867,7 @@ static struct rtrs_clt_sess *get_next_path_min_latency(struct path_it *it)
 	struct rtrs_clt_sess *min_path = NULL;
 	struct rtrs_clt *clt = it->clt;
 	struct rtrs_clt_sess *sess;
-	ktime_t min_latency = INT_MAX;
+	ktime_t min_latency = KTIME_MAX;
 	ktime_t latency;
 
 	list_for_each_entry_rcu(sess, &clt->paths_list, s.entry) {
-- 
2.25.1

