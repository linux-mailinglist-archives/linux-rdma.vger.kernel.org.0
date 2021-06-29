Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0516C3B6E65
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Jun 2021 08:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbhF2Gzw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Jun 2021 02:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbhF2Gzw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 29 Jun 2021 02:55:52 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77377C061574
        for <linux-rdma@vger.kernel.org>; Mon, 28 Jun 2021 23:53:25 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id i24so29765288edx.4
        for <linux-rdma@vger.kernel.org>; Mon, 28 Jun 2021 23:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KuD5r33pAc3SDjyN/D8crf5rIUn7LGhRSs0oQPcggq0=;
        b=JerIfoIPhUfQp7emday/7dd5CXZE3mTVDy8LKvKuHZDzftzbnbuesXkjRKVJW2MF1b
         rhbs92phUBuXWaxrQMSBBnJjkyxUuHqa35gDdTiprhLkfFzYzmkA/ZQfDAG1cWm75zRt
         jmj9MYlQ8UeLKLI9Q/VSqTjWeiy9ZZXJT7VepAMLWX9zDhngUbEkf2xLVC0l8qVR1/6A
         8KQPoNMwEVPvVB/7V33/1BSF0w2HZGLXM1WugYE2z776nIbviPiCsdEmjKo+YerKyHg+
         NlhOwR2mx3kTB1F1uWLWqRGHU64EqO7UICKmegY8n57bFBeI6/bJStYLV+09y2kavoby
         lAAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KuD5r33pAc3SDjyN/D8crf5rIUn7LGhRSs0oQPcggq0=;
        b=Pj6K1QcWyKHV0h6k67/6rVmoyDr9oBx5QQwIl8FrFpCXyZlRo2tJHmoxVoB1jLVWa0
         5uQMJT/A0aByYXqHizoxN9HayBt8htJAI/rsKKVMoaFRiLMn0hXcW7iHDQqsnHCai0K9
         +O+GuSRWVlKYa8W8+yFoTJ/xb5GW+e0pyKM6+/Y2GtrHKMZiNUFq9iy59iaYph3biajZ
         w6RTGgTvfyM5QfMyeE+hPP7S/ao2SmUy2Sojf38o/9MBAxcwgl21b7cJC2/EQ/AgGt2n
         UmfYL0tG0eyt8Lnezhph+bsTrUc4fn1g2GLcm/sOzg4WQ93TaFmj27XdCsVyeRD2YCGO
         57Bw==
X-Gm-Message-State: AOAM530ZJ1MP2SZ+cz4U1zxfwNDvJD0RSEdeS5CepHoYdd1JA7wQ607Y
        LGPpq+E43nK466R3i1XisiFv4OTpTVIL8g==
X-Google-Smtp-Source: ABdhPJyPAjOkOepu6cq6HT3bRBNWSrbDJfAL8XgShwfihZeXcwFiyLcrNWSUHZuMVlA4YDc0sgQeaQ==
X-Received: by 2002:aa7:c997:: with SMTP id c23mr38319812edt.42.1624949603951;
        Mon, 28 Jun 2021 23:53:23 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:49c9:3e00:293f:8e14:7de3:8980])
        by smtp.gmail.com with ESMTPSA id t27sm7717853eje.86.2021.06.28.23.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 23:53:23 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, axboe@kernel.dk, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com, Aleksei Marov <aleksei.marov@ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next 1/6] RDMA/rtrs: Add error messages for failed operations.
Date:   Tue, 29 Jun 2021 08:53:16 +0200
Message-Id: <20210629065321.12600-2-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210629065321.12600-1-jinpu.wang@ionos.com>
References: <20210629065321.12600-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

It could help debugging in case of error happens.

Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Reviewed-by: Aleksei Marov <aleksei.marov@ionos.com>
Reviewed-by: Gioh Kim <gi-oh.kim@ionos.com>
Reviewed-by: Md Haris Iqbal <haris.iqbal@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
index 61919ebd92b2..870b21f551a4 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs.c
@@ -316,6 +316,7 @@ void rtrs_send_hb_ack(struct rtrs_sess *sess)
 	err = rtrs_post_rdma_write_imm_empty(usr_con, sess->hb_cqe, imm,
 					     0, NULL);
 	if (err) {
+		rtrs_err(sess, "send HB ACK failed, errno: %d\n", err);
 		sess->hb_err_handler(usr_con);
 		return;
 	}
@@ -333,6 +334,7 @@ static void hb_work(struct work_struct *work)
 	usr_con = sess->con[0];
 
 	if (sess->hb_missed_cnt > sess->hb_missed_max) {
+		rtrs_err(sess, "HB missed max reached.\n");
 		sess->hb_err_handler(usr_con);
 		return;
 	}
@@ -348,6 +350,7 @@ static void hb_work(struct work_struct *work)
 	err = rtrs_post_rdma_write_imm_empty(usr_con, sess->hb_cqe, imm,
 					     0, NULL);
 	if (err) {
+		rtrs_err(sess, "HB send failed, errno: %d\n", err);
 		sess->hb_err_handler(usr_con);
 		return;
 	}
-- 
2.25.1

