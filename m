Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB25B2D470F
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Dec 2020 17:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729767AbgLIQrM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Dec 2020 11:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729855AbgLIQrK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Dec 2020 11:47:10 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8837BC0611C5
        for <linux-rdma@vger.kernel.org>; Wed,  9 Dec 2020 08:46:00 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id bo9so3038476ejb.13
        for <linux-rdma@vger.kernel.org>; Wed, 09 Dec 2020 08:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TNCE9BUjl8LjgBBWvrzQwpmCGHe5xlvz+eb/c5dap0o=;
        b=eMwYPaUMhixxdtQV0Bc8zdEO4WF7h6ILnhRjsFfP7LGCvksv57xWUJvK4ut6YxSRwJ
         RlVEmO2JEXuVPm5SwJBq22HTsG1a7wEVkBhBjCFvXNyp5reEdtiWTNacnl3yzTrgV0O8
         J+lgLfdV9dTVMGymRDeAHahxdX+x3xrtR4daIrKb7cQW4kaQgnsJVhfkETxQx1V/48cd
         Wwmwz247vn7FDzLnx+yHMkHig+Pl3FWusZw4FRITXGmZIgc8txi4rCzbLbyEmZvRTBsl
         S1N4kVoRzlGi2ASp4mF/IagFQYpBnVoY+yiBFy1/5TzkpguFHRzEE9DXdZIN45bUSA8d
         1wNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TNCE9BUjl8LjgBBWvrzQwpmCGHe5xlvz+eb/c5dap0o=;
        b=S1+xTuCtN0YwyUcymkXK1H13LAqpUtWcPhUiPhGuAJ76sb68MUwioZacXgoEx1opo4
         fwg4TK+78JdRQ/L8jadiBKPiHADMAZx63g9SMaDYmF6KRM6mnCLQKpgqDkK4TBhFO4FZ
         uo+R6x9LtGOPWbfjYUoQ1+TCsM8XA34/miPwnmYaDF1iIQHV4wO/ZzRbURJxVGzWXrc3
         mKMdgbiEZlGiXmlM3YIGV1z52t+7NYR4lgmdHEcquygGZYmAg1vQ1Z+IdFmZBa3dim0x
         Nd7RttE3BKV6z2A8cLn86JYBWEm8LEoTN4r3XTXl+wjXSkiS3PSLWDwfydnnxqFLc82i
         T77Q==
X-Gm-Message-State: AOAM532a4B107HGv5O6ofLZkGkmWj+cPJq8w/aP124zyEQk/XEHmVT24
        zDVFx31CE6QSPUKrC7k3A4G3agDhWo/8kA==
X-Google-Smtp-Source: ABdhPJxzBpGUKbaMs8FmW9fW8JQfmtGGJdGG88/hFPXKrPoIsuMYoFbOiaKeAQrWlrffZzJTjGPMOQ==
X-Received: by 2002:a17:906:eb8d:: with SMTP id mh13mr2717951ejb.299.1607532359010;
        Wed, 09 Dec 2020 08:45:59 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:49e0:2500:1d14:118d:b29c:98ec])
        by smtp.gmail.com with ESMTPSA id h16sm1977915eji.110.2020.12.09.08.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 08:45:58 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Subject: [PATCH for-next 12/18] RDMA/rtrs-clt: Rename __rtrs_clt_change_state to rtrs_clt_change_state
Date:   Wed,  9 Dec 2020 17:45:36 +0100
Message-Id: <20201209164542.61387-13-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201209164542.61387-1-jinpu.wang@cloud.ionos.com>
References: <20201209164542.61387-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

Let's rename it to rtrs_clt_change_state since the previous one is
killed.

Also update the comment to make it more clear.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Reviewed-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 39dc8423d7df..3c90718f668d 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -178,18 +178,18 @@ struct rtrs_clt_con *rtrs_permit_to_clt_con(struct rtrs_clt_sess *sess,
 }
 
 /**
- * __rtrs_clt_change_state() - change the session state through session state
+ * rtrs_clt_change_state() - change the session state through session state
  * machine.
  *
  * @sess: client session to change the state of.
  * @new_state: state to change to.
  *
- * returns true if successful, false if the requested state can not be set.
+ * returns true if sess's state is changed to new state, otherwise return false.
  *
  * Locks:
  * state_wq lock must be hold.
  */
-static bool __rtrs_clt_change_state(struct rtrs_clt_sess *sess,
+static bool rtrs_clt_change_state(struct rtrs_clt_sess *sess,
 				     enum rtrs_clt_state new_state)
 {
 	enum rtrs_clt_state old_state;
@@ -286,7 +286,7 @@ static bool rtrs_clt_change_state_from_to(struct rtrs_clt_sess *sess,
 
 	spin_lock_irq(&sess->state_wq.lock);
 	if (sess->state == old_state)
-		changed = __rtrs_clt_change_state(sess, new_state);
+		changed = rtrs_clt_change_state(sess, new_state);
 	spin_unlock_irq(&sess->state_wq.lock);
 
 	return changed;
@@ -1361,7 +1361,7 @@ static bool rtrs_clt_change_state_get_old(struct rtrs_clt_sess *sess,
 	spin_lock_irq(&sess->state_wq.lock);
 	if (old_state)
 		*old_state = sess->state;
-	changed = __rtrs_clt_change_state(sess, new_state);
+	changed = rtrs_clt_change_state(sess, new_state);
 	spin_unlock_irq(&sess->state_wq.lock);
 
 	return changed;
-- 
2.25.1

