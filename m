Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67D05981B4
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Aug 2022 12:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238659AbiHRKyC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Aug 2022 06:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238963AbiHRKyB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 18 Aug 2022 06:54:01 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F2B6CD18
        for <linux-rdma@vger.kernel.org>; Thu, 18 Aug 2022 03:54:00 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id m10-20020a05600c3b0a00b003a603fc3f81so736542wms.0
        for <linux-rdma@vger.kernel.org>; Thu, 18 Aug 2022 03:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=og4NRVF3kojiVFewfuePBbw/uUDzMIlDN9CpjxEcs40=;
        b=U7wSoOU7OVFDLzzowGjwClwIUCt+XqgcJkQpCLd7EpIwWlEhQNEK7PaNaI5/rYkiD+
         8izZX6zESFu8X//TQq1uLWpCXcDP2Ku1WhrgQYDHzdKa6nS5NbT+dur2W0bfprmPVM+B
         acG3gw2KpjP5dHYUGQNhDOtcJ4NoeufXcccjXKSJ/Hj6YvKNdICTJcHXyAK0qHmMZokZ
         OBZSHaZX1/JY5DGT+bNFgfLUGo0M+G7GKMdYAjOivzKY9CPu1S6IHXDtAYDe24rCRPEC
         JPWyTFXiFxHqwugxOchmW4jVlnhPi0AOeARgnbsLbAcpIiFTsudKUUGXla6zEaTaCwla
         813w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=og4NRVF3kojiVFewfuePBbw/uUDzMIlDN9CpjxEcs40=;
        b=LtslZXojZLB4YXe4LEX4qGve1aeVNsvtYYsChYM+OexsNrrXCFvQCopV/bnQfGL1eQ
         J/IpqCSBE8c34fhCuFHMbsCvRbemBbgicD6S5qovudzwXhf+nQVW2r5nhd8P9c2TJWB/
         PUAdca3TEH8+7OXVHmlXzfuXyjLhzje8f8zBBinWdLG5vvWb394Y/ldUhYFeWIlGmsW0
         a92o903di27qy3o1/u9979x3zneYmdrC/2UI2ngVrGr4Ps3SHIkrUi+WRBdRD2n1NrCj
         QLkdNFuwy6GV1Fs7HXT4HxUgfvz2N8x96AVaFcHJeS3qJ6a56zdAVu22finCxe39Imay
         dTig==
X-Gm-Message-State: ACgBeo0HTwKFV1vj2SznREMKxX1Dmf53loaCgmLRqGCc9Oq4BLuY3qos
        30/eGEx+n1dKfb9NF9nog2jlVmW2/TlaLg==
X-Google-Smtp-Source: AA6agR4xaPjXDMqGApwHswgXOP/BIC66eCd3j2pKKrfjssQI/cP64KNp59eLFFIowoi6HUxwyk/cfg==
X-Received: by 2002:a7b:cb55:0:b0:3a5:41a:829c with SMTP id v21-20020a7bcb55000000b003a5041a829cmr4799216wmj.153.1660820039018;
        Thu, 18 Aug 2022 03:53:59 -0700 (PDT)
Received: from lb01533.fkb.profitbricks.net ([85.214.13.132])
        by smtp.gmail.com with ESMTPSA id n3-20020a05600c3b8300b003a54fffa809sm1920751wms.17.2022.08.18.03.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 03:53:58 -0700 (PDT)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     leon@kernel.org, jgg@ziepe.ca, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com, Aleksei Marov <aleksei.marov@ionos.com>
Subject: [PATCH for-next 2/3] RDMA/rtrs-clt: Use the right sg_cnt after ib_dma_map_sg
Date:   Thu, 18 Aug 2022 12:53:54 +0200
Message-Id: <20220818105355.110344-3-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220818105355.110344-1-haris.iqbal@ionos.com>
References: <20220818105355.110344-1-haris.iqbal@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@ionos.com>

When iommu is enabled, we hit warnings like this:
WARNING: at rtrs/rtrs.c:178 rtrs_iu_post_rdma_write_imm+0x9b/0x110

rtrs warn on one sge entry length is 0, which is unexpected.

The problem is ib_dma_map_sg augments the SGL into a 'dma mapped SGL'.
This process may change the number of entries and the lengths of each
entry.

Code that touches dma_address is iterating over the 'dma mapped SGL'
and must use dma_nents which returned from ib_dma_map_sg().
So pass the count return from ib_dma_map_sg.

Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Reviewed-by: Aleksei Marov <aleksei.marov@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 5219bb10777a..5d0df186e937 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1007,7 +1007,8 @@ rtrs_clt_get_copy_req(struct rtrs_clt_path *alive_path,
 static int rtrs_post_rdma_write_sg(struct rtrs_clt_con *con,
 				   struct rtrs_clt_io_req *req,
 				   struct rtrs_rbuf *rbuf, bool fr_en,
-				   u32 size, u32 imm, struct ib_send_wr *wr,
+				   u32 count, u32 size, u32 imm,
+				   struct ib_send_wr *wr,
 				   struct ib_send_wr *tail)
 {
 	struct rtrs_clt_path *clt_path = to_clt_path(con->c.path);
@@ -1027,12 +1028,12 @@ static int rtrs_post_rdma_write_sg(struct rtrs_clt_con *con,
 		num_sge = 2;
 		ptail = tail;
 	} else {
-		for_each_sg(req->sglist, sg, req->sg_cnt, i) {
+		for_each_sg(req->sglist, sg, count, i) {
 			sge[i].addr   = sg_dma_address(sg);
 			sge[i].length = sg_dma_len(sg);
 			sge[i].lkey   = clt_path->s.dev->ib_pd->local_dma_lkey;
 		}
-		num_sge = 1 + req->sg_cnt;
+		num_sge = 1 + count;
 	}
 	sge[i].addr   = req->iu->dma_addr;
 	sge[i].length = size;
@@ -1145,7 +1146,7 @@ static int rtrs_clt_write_req(struct rtrs_clt_io_req *req)
 	 */
 	rtrs_clt_update_all_stats(req, WRITE);
 
-	ret = rtrs_post_rdma_write_sg(req->con, req, rbuf, fr_en,
+	ret = rtrs_post_rdma_write_sg(req->con, req, rbuf, fr_en, count,
 				      req->usr_len + sizeof(*msg),
 				      imm, wr, &inv_wr);
 	if (ret) {
-- 
2.25.1

