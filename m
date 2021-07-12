Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D4A3C43D5
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jul 2021 08:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbhGLGKn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Jul 2021 02:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhGLGKm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Jul 2021 02:10:42 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F70CC0613DD
        for <linux-rdma@vger.kernel.org>; Sun, 11 Jul 2021 23:07:54 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id i2-20020a05600c3542b02902058529ea07so10650454wmq.3
        for <linux-rdma@vger.kernel.org>; Sun, 11 Jul 2021 23:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KuD5r33pAc3SDjyN/D8crf5rIUn7LGhRSs0oQPcggq0=;
        b=GpIn/Cab0kMhkyTAg8Rts3nKeIAjqaYhOBDzCD7QarLzEgy4N6syl8TV7KdxqJoJ2M
         gQYUeEavY8HfuUNdasdj1TQ9JacNOX87x3/i+0EQcSbNtMQN65dtypAQI8IaoI9Y6uWx
         d5F5T8Ua8GFsyTH+YeI5V/gI9HXICEHMkAZ5xAwr8lLCCnC8EhHJzOhcxnfkXnAlTDKM
         abwpu4+ZFUO08nNz665hNsHlCTRbPcac4LBQE0ZkH9TIcfebU9390N4YiyBLMVF74tmY
         i5yjiRP1PAdKsxjBgFglGlyZla2V56vsaEu25yE6JCtdEFtdXNdBmEqQnOXIVd1FnZRO
         kfmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KuD5r33pAc3SDjyN/D8crf5rIUn7LGhRSs0oQPcggq0=;
        b=iIhRMoPefEep2SKC2QDX3GqjzTxg4F1wS8oY4NyjK/rxA5iKRjbNOMfZ7bjfkUBHYc
         bkUORd6Wvs79pe2PC+w6xcwv2L1VwxwLIIIoUZLGpzx7Q814eWDBza3TtzdLJ1nWVwGk
         6CpokslaMpWd00lNCxA/UpTLhHP7jK5D21wY48c0HOp7SJ2rckZ3nnBOk5ryRBfToePw
         VRjmSHKrCNzX3qDo6BEK0zUQUw3kaxB+azw77ch7DAFXom22hvkDO9P+mE7ot4bADjzf
         2w89i2bfDXc9JjJ62iCZNcZlXhiGLXrETtP0GRBbivZxxVPYPs476jnCdPpgcc/m2Tgw
         TWSw==
X-Gm-Message-State: AOAM532hARzMBiyjoehc1PoCZgOmDx0wyVyxQ27XwTqzLUttkL2r8809
        b+RG+70TuaNmpd+OY1QkideYS0xENNNUgg==
X-Google-Smtp-Source: ABdhPJz3D570pvvsqIcjnBl+NmUwUyHNOnb78y4jQNT7FBBohyNEUzuTG/lrA6AJbBCxbe7yY63kxg==
X-Received: by 2002:a1c:143:: with SMTP id 64mr14646772wmb.187.1626070072685;
        Sun, 11 Jul 2021 23:07:52 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:49bc:8600:895c:e529:e1b8:7823])
        by smtp.gmail.com with ESMTPSA id s17sm13344245wrv.2.2021.07.11.23.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 23:07:52 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Aleksei Marov <aleksei.marov@ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv2 for-rc 1/6] RDMA/rtrs: Add error messages for failed operations.
Date:   Mon, 12 Jul 2021 08:07:45 +0200
Message-Id: <20210712060750.16494-2-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210712060750.16494-1-jinpu.wang@ionos.com>
References: <20210712060750.16494-1-jinpu.wang@ionos.com>
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

