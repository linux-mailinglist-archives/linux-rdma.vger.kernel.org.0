Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCECA356B52
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Apr 2021 13:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351850AbhDGLfC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Apr 2021 07:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351851AbhDGLe7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Apr 2021 07:34:59 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88007C061761
        for <linux-rdma@vger.kernel.org>; Wed,  7 Apr 2021 04:34:49 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id ba6so12903510edb.1
        for <linux-rdma@vger.kernel.org>; Wed, 07 Apr 2021 04:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/8fESDjmq2WZTwD7IhRinSow2BPuuJ6W9DQcZYA8724=;
        b=MFdJP5jptTmtceEU8StAz0OpxjTik2CtWqKpe0e5asXmkjG0xy4H3JSpnZtMm7XsDt
         sSGR8nrbEclbEKy4VhwfDI0PI/IXPHGPOf4dlQeROLvxMPh2v6KmaxKL30IoFVtimT/B
         niiA+TrLVyVqb/uV9rmOAyq7N4O7bIZkvNG60jMM2rkOt0Mriv8r1XpeRzl2KJNlrY87
         OtDJDvEOh56+3B07LqLsfZRumG8LQ5dhHgS25qINr9DzbXPG8yvNytPTJ12WOqXcQhKP
         Vt7H40JVSlU1/HLLbMwOrXiIzGWwpmX+t+flQ4mF1lpLtOJpOVGFRb5BANQ435o7OIy6
         czkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/8fESDjmq2WZTwD7IhRinSow2BPuuJ6W9DQcZYA8724=;
        b=VXj4QQzukKRIm/2t9qpp09fS04BlnMXpz1e1vOVPbv2B13ayMH8a1xcmw6fJgZtyI5
         tu2TA6QRR+rLR3GRTwrB/1rvNbhx31ScVTIboXWSOU/Nc9rm4v2tl0Q2nH81aP+UULMS
         o44fH/w/zfypL1g08qUU4lSyBYWs+i0Dpc5m6A8Dzq63fFgBd+MKCai/pJ5eC42AiQgx
         lfF6lQw1BUIne2MI1V+31NlM04oyXFQKisUc2L/hKSVqjSeEc0eQ/vBRqQcCpYV7ZldH
         u19DQDReWpbBGkEQ3NaJqRPvrmjmPEXstDCBFJboFwuWT0i9h5Oh4WgrZF1UX0O8m/TE
         Metg==
X-Gm-Message-State: AOAM531qBCAyTzfNLNcO4UtXtUhB0qO9LStmAsMEdB4K3WBAWTP7y7M8
        KaRPmrZhQcJoXiLSTTxODoi7oPpTkn/OL10E
X-Google-Smtp-Source: ABdhPJxIAo8PiydckSFjYr/2YncFeNU0L3gGl2Z+Y7v6YrGHtj82ugLW2U0zs6P55iW1x8qgcolVxg==
X-Received: by 2002:a05:6402:51cd:: with SMTP id r13mr3883138edd.116.1617795288223;
        Wed, 07 Apr 2021 04:34:48 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id a9sm15491186eds.33.2021.04.07.04.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 04:34:47 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv3 for-next 2/4] RDMA/rtrs-clt: new sysfs attribute to print the latency of each path
Date:   Wed,  7 Apr 2021 13:34:42 +0200
Message-Id: <20210407113444.150961-3-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210407113444.150961-1-gi-oh.kim@ionos.com>
References: <20210407113444.150961-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

It shows the latest latency that the client checked when sending
the heart-beat.

Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
index c8669d3f79f1..b083154f567e 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
@@ -355,6 +355,21 @@ static ssize_t rtrs_clt_hca_name_show(struct kobject *kobj,
 static struct kobj_attribute rtrs_clt_hca_name_attr =
 	__ATTR(hca_name, 0444, rtrs_clt_hca_name_show, NULL);
 
+static ssize_t rtrs_clt_cur_latency_show(struct kobject *kobj,
+				    struct kobj_attribute *attr,
+				    char *page)
+{
+	struct rtrs_clt_sess *sess;
+
+	sess = container_of(kobj, struct rtrs_clt_sess, kobj);
+
+	return sysfs_emit(page, "%lld ns\n",
+			  ktime_to_ns(sess->s.hb_cur_latency));
+}
+
+static struct kobj_attribute rtrs_clt_cur_latency_attr =
+	__ATTR(cur_latency, 0444, rtrs_clt_cur_latency_show, NULL);
+
 static ssize_t rtrs_clt_src_addr_show(struct kobject *kobj,
 				       struct kobj_attribute *attr,
 				       char *page)
@@ -398,6 +413,7 @@ static struct attribute *rtrs_clt_sess_attrs[] = {
 	&rtrs_clt_reconnect_attr.attr,
 	&rtrs_clt_disconnect_attr.attr,
 	&rtrs_clt_remove_path_attr.attr,
+	&rtrs_clt_cur_latency_attr.attr,
 	NULL,
 };
 
-- 
2.25.1

