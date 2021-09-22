Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13FC04149C4
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Sep 2021 14:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236084AbhIVMzS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Sep 2021 08:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236158AbhIVMzR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Sep 2021 08:55:17 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2CDC061766
        for <linux-rdma@vger.kernel.org>; Wed, 22 Sep 2021 05:53:47 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id d21so6359095wra.12
        for <linux-rdma@vger.kernel.org>; Wed, 22 Sep 2021 05:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iEwXtwVC0+ySn9BAIWSFhSoxcbAilVScX8tg212FZcI=;
        b=abzJiOLh+MIYBpuPOMHFQ7RlK/ztxnhXaz9yPA1WO/j3DswO3xaBc5QupkytwuqiAL
         Z5VBzDU9Ffow0PII8y3rtCHGpk4MQIZ+uM0PYA0SP2vqfibOCaqm9sBZgV3sFD0WF2fk
         dWh5aVpwox7eAk/mD7KFkyFKcAHoA/wxc4sXLyiKU7RvZcOWDKtFCk7db4MIU5XZvzHd
         Ot9mvLsTPvq/r0atbr6dlyFtvnm/t+TaYv6/s8iN0YBrm5gOxBRYCCeAw1Ph3cIMW6Fy
         ugSTuY+SR/zQlXbpKdBLOwG0uobTvEOiT+B3XMHDmfcldafBo/C1ddbIWASg4XP8ptpC
         7n5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iEwXtwVC0+ySn9BAIWSFhSoxcbAilVScX8tg212FZcI=;
        b=V2gP1C6ufBK38vp+N6e0WHJ6ky8vwaiQ55AymPYL+ku+pUz5Qj3j2sE/Q+kgHnICmh
         Ywo5CVVnRL35Q/johxeuIB0XPxpezDV3Q0aPHqK1LLSnVBL0QCUnCblYG/CYALdfkFR+
         /Y7LeO0caqZcTrJaJUvFlY9aNpAkgpH12kxCJzejtVVwQknsQpmMsNZkUmFBdfRJI0fU
         t1gggFT4ILyQRPp9TiUB2iVdD2TLmHR4pyk4BlaZzxTSItO23A6W0IzV5Ncg9D1lzD0L
         GBqN7cxcONrnGNSNUnMi2q3rOC+ytgpqmnNJW1TcDhtupf7KDjLFwwdD6LPL5mrDBZUB
         y2Ow==
X-Gm-Message-State: AOAM533lBNpOWAvB9BOcTS2vs95wEbWEb0JtRJE2BsQtEeQU61meaTEh
        JZLpof2Rsm0Ud4IFgRCJ6sskirQizt96PA==
X-Google-Smtp-Source: ABdhPJwTu1T3cVeGTLsX3xGRJW4chknWoZBzSH/GZ7SHDDkS3vGw2HcARVTyThOiKgegB08KV6fKqQ==
X-Received: by 2002:a7b:c144:: with SMTP id z4mr10620724wmi.31.1632315226199;
        Wed, 22 Sep 2021 05:53:46 -0700 (PDT)
Received: from nb01533.pb.local ([2001:1438:4010:2540:40a5:9868:5a83:f3b9])
        by smtp.gmail.com with ESMTPSA id j20sm2173685wrb.5.2021.09.22.05.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 05:53:45 -0700 (PDT)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@ionos.com>,
        Aleksei Marov <aleksei.marov@ionos.com>
Subject: [PATCH for-next 6/7] RDMA/rtrs: Do not allow sessname to contain special symbols / and .
Date:   Wed, 22 Sep 2021 14:53:32 +0200
Message-Id: <20210922125333.351454-7-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210922125333.351454-1-haris.iqbal@ionos.com>
References: <20210922125333.351454-1-haris.iqbal@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Allowing these characters in sessname can lead to unexpected results,
particularly because / is used as a separator between files in a path,
and . points to the current directory.

Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Reviewed-by: Gioh Kim <gi-oh.kim@ionos.com>
Reviewed-by: Aleksei Marov <aleksei.marov@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 6 ++++++
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index bc8824b4ee0d..15c0077dd27e 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -2788,6 +2788,12 @@ struct rtrs_clt *rtrs_clt_open(struct rtrs_clt_ops *ops,
 	struct rtrs_clt *clt;
 	int err, i;
 
+	if (strchr(sessname, '/') || strchr(sessname, '.')) {
+		pr_err("sessname cannot contain / and .\n");
+		err = -EINVAL;
+		goto out;
+	}
+
 	clt = alloc_clt(sessname, paths_num, port, pdu_sz, ops->priv,
 			ops->link_ev,
 			reconnect_delay_sec,
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 078a1cbac90c..7df71f8cf149 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -803,6 +803,11 @@ static int process_info_req(struct rtrs_srv_con *con,
 		return err;
 	}
 
+	if (strchr(msg->sessname, '/') || strchr(msg->sessname, '.')) {
+		rtrs_err(s, "sessname cannot contain / and .\n");
+		return -EINVAL;
+	}
+
 	if (exist_sessname(sess->srv->ctx,
 			   msg->sessname, &sess->srv->paths_uuid)) {
 		rtrs_err(s, "sessname is duplicated: %s\n", msg->sessname);
-- 
2.25.1

