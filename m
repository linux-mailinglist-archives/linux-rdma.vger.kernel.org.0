Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0099F4D1AC7
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Mar 2022 15:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347582AbiCHOlg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Mar 2022 09:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347684AbiCHOl3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Mar 2022 09:41:29 -0500
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078D74C788;
        Tue,  8 Mar 2022 06:40:17 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1646750415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=crqwMMTNOSKHYaBrxgvxgUTnJtcMqnjf+ixRD/vZc/I=;
        b=oZtgJ11K8PdsA8zO0V35HKeFvEyIDUeGsboOOLJ8phGhQqFlYJT7NXB2H7T6+LmY59Arwe
        7FMjkF20LUBj4QU0EsbvuubITKRTte5SIkBqq2WJSlAYl1G/Wr3WG3YXsB6UbG0ZWTHAyy
        PFveE9alIeDOp0A7ABcwMtK4Cf7vYDY=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     jgg@nvidia.com, selvin.xavier@broadcom.com, galpress@amazon.com,
        sleybo@amazon.com, liangwenpeng@huawei.com, liweihang@huawei.com,
        mustafa.ismail@intel.com, shiraz.saleem@intel.com,
        leonro@nvidia.com, dennis.dalessandro@cornelisnetworks.com,
        mike.marciniszyn@cornelisnetworks.com, zyjzyj2000@gmail.com
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH for-next 8/9] RDMA/rdmavt: get rid of create_user_ah
Date:   Tue,  8 Mar 2022 22:40:00 +0800
Message-Id: <20220308144000.3406111-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There is no create_user_ah in ib_device_ops, remove it.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 drivers/infiniband/sw/rdmavt/vt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/sw/rdmavt/vt.c b/drivers/infiniband/sw/rdmavt/vt.c
index 59481ae39505..951165f1eae7 100644
--- a/drivers/infiniband/sw/rdmavt/vt.c
+++ b/drivers/infiniband/sw/rdmavt/vt.c
@@ -335,7 +335,6 @@ static const struct ib_device_ops rvt_dev_ops = {
 	.create_cq = rvt_create_cq,
 	.create_qp = rvt_create_qp,
 	.create_srq = rvt_create_srq,
-	.create_user_ah = rvt_create_ah,
 	.dealloc_pd = rvt_dealloc_pd,
 	.dealloc_ucontext = rvt_dealloc_ucontext,
 	.dereg_mr = rvt_dereg_mr,
-- 
2.25.1

