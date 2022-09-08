Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A3E5B1924
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Sep 2022 11:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbiIHJqc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Sep 2022 05:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiIHJqa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Sep 2022 05:46:30 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7421DFF6F
        for <linux-rdma@vger.kernel.org>; Thu,  8 Sep 2022 02:46:28 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662630386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JiH5K/bh1ssx4GXyniEnWMY8n/bOA9lgw0McUPeg3FQ=;
        b=I1WHd6oGbopcjm4y/HdjmH8Gd1BhOd+s3udPFXq/fHDrHVrsGPliyjqmodbXmqbVQQZXsz
        swWPMPbB19YQOkENmy5N969WFKTRf2ZDdPX57pReJfgwzMHAI+H+X/8Mle2XMk7pG0P2er
        chl0Rod8Zqx6UfzYnMNC5nx/eq0H7fM=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, jgg@ziepe.ca,
        leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, Guoqing Jiang <guoqing.jiang@linux.dev>
Subject: [PATCH V2 0/3] misc changes for rtrs
Date:   Thu,  8 Sep 2022 17:45:45 +0800
Message-Id: <20220908094548.4115-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

Pls review the three patches.

Thanks,
Guoqing

V2 changes:
1. fix compile warnings in the third patch
2. collect tag from Haris, thanks!

Guoqing Jiang (3):
  RDMA/rtrs: Update comments for MAX_SESS_QUEUE_DEPTH
  RDMA/rtrs-clt: Break the loop once one path is connected
  RDMA/rtrs-clt: Kill xchg_paths

 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 19 ++++++-------------
 drivers/infiniband/ulp/rtrs/rtrs-pri.h |  7 +++----
 2 files changed, 9 insertions(+), 17 deletions(-)

-- 
2.31.1

