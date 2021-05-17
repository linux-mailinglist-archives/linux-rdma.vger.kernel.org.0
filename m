Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E9638281A
	for <lists+linux-rdma@lfdr.de>; Mon, 17 May 2021 11:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235887AbhEQJU7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 May 2021 05:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235894AbhEQJUm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 May 2021 05:20:42 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A118C06138E
        for <linux-rdma@vger.kernel.org>; Mon, 17 May 2021 02:19:25 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id l4so8090626ejc.10
        for <linux-rdma@vger.kernel.org>; Mon, 17 May 2021 02:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i04jIEHt0SHV5b8xWDkxZkH0VbzuRCFB00lLNNPbPvE=;
        b=PNCzHoQYL3wR/UWhPsKy2fzUIpgTmwsJ2/TImMiFo+YpJYjdq2FXmXwEFnoJJeCelf
         kgPaA4gRP4344Yh2Lla7H8mZBW9H4+z4+LodcNjSmlMRLdXA56vR3+jZHTZx1GuvQccj
         PWKhFyLoKzfPGxmcmqK7McsNd0n/o/ioAj07r/iS+qozRXua4LbpY6jfAQCSGHmaXgcR
         djjqicmqaDWTqJJfnKmq8JJ4WV5bbB1GV/1tJi8DLEF5Sodtkq1nKeP7APhX8XyIeOox
         mQioyIdE0RuTN9uM8ipsDeCfJjAnlUuwchfy6tkUSUqICwMTcE4KZQvRKuK9TjPozrBu
         mnLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i04jIEHt0SHV5b8xWDkxZkH0VbzuRCFB00lLNNPbPvE=;
        b=ryNo4VMFtnbk3YIVAu+Opx183sDTlAUWhPMG+sqXD3cI+2hv0ZSMUq1gVZ/8llODSL
         WBtWOq9KE6MxoxnBrIWGGBMiSo6oH24TavExlJt1hXkE+uNgoIfF/wGIQM+UequqLdRD
         LOx5l1SaC8UjrepzQ3ftOQgElBSYm0qKKgzAFeDdfQRfroZR2kNTXK+MUs+ejOvjKLvk
         vLyYUzKJZCEbKTjFCc2kCBC/oDdgWY2q2fByEo2HAI86OdIbMmD9UUWGbwpleRMiMgn+
         SbkOudc1uppEDW2Vp3RSMRTji1TPHeLrisEJfq6AmrhxBDiJfZYMGbqYaoxSbuizZ5Xw
         XA2A==
X-Gm-Message-State: AOAM533KVMMRw5HAaBfMD9yHz9spU7tIwqz/M1HlP6Ax8HOvmJ+4A00j
        NSJM+ChFXADEX5u/nqsRTOMQpU1ZHz0lVg==
X-Google-Smtp-Source: ABdhPJwzkgRuv19uObHmhS5aQvuO4ZqGiQD8P/mF339R4PBxGTkeTRq/r4C/qHBiihav92zEcnq4oQ==
X-Received: by 2002:a17:906:1e44:: with SMTP id i4mr60367937ejj.61.1621243163724;
        Mon, 17 May 2021 02:19:23 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aef30.dynamic.kabel-deutschland.de. [95.90.239.48])
        by smtp.googlemail.com with ESMTPSA id g10sm7925845ejd.109.2021.05.17.02.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:19:23 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Guoqing Jiang <guoqing.jiang@ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv2 for-next 11/19] RDMA/rtrs-clt: Remove redundant 'break'
Date:   Mon, 17 May 2021 11:18:35 +0200
Message-Id: <20210517091844.260810-12-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517091844.260810-1-gi-oh.kim@ionos.com>
References: <20210517091844.260810-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

It is duplicated with the very next line

Signed-off-by: Guoqing Jiang <guoqing.jiang@ionos.com>
Reviewed-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 1de72784e1c0..757a4394fdb6 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -655,7 +655,6 @@ static void rtrs_clt_rdma_done(struct ib_cq *cq, struct ib_wc *wc)
 			rtrs_err(con->c.sess, "rtrs_post_recv_empty(): %d\n",
 				  err);
 			rtrs_rdma_error_recovery(con);
-			break;
 		}
 		break;
 	case IB_WC_RECV:
-- 
2.25.1

