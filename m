Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D36E51B5B08
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2020 14:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbgDWMEr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Apr 2020 08:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728104AbgDWMEr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 23 Apr 2020 08:04:47 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28BCC08E859;
        Thu, 23 Apr 2020 05:04:45 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u127so6274917wmg.1;
        Thu, 23 Apr 2020 05:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7pzWOwtxsf/GOJdSTrWttvSQWG+r/olQojnay9bW+7g=;
        b=fZ7AsC2IwJojBrtLDXRKj0pALBcuMU0gc3Qg1+hQzeewCZsDGdRVVBCq4RU+Apu0cb
         ceZK/rvlGABb/08T1r/08kfRynVhCJrv8hxV+kU+ZLGQaDq93TmWVEaptU9QulaXURyZ
         QpynrAVNUk/l2zlyJ1uyX9ZtPT8pEd3jyg3Ins/nitXL1K66AABtc1tl7wRLLxLvnihn
         ktYa7O27l82IbpULBLwj6mQLvZAyFM3J5qOENkta8YwOgO/PHw8OKlfh8LwjbnmahGRc
         aT+Sa7aVdU8tLE/iM0FVmhp0riHUc9qoxOOnnWGwexdzeS8gqakLIxuVUTMW6FbOJjVY
         Hjig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7pzWOwtxsf/GOJdSTrWttvSQWG+r/olQojnay9bW+7g=;
        b=dlvDkxbVasLzNFtIBPWczRSYMSlBJAKPBdnGuCpqZe9Z3mSUhz+JC7PeEpwPfvHZK7
         IGg6Z/Fj86JmBQfmoJW7UFdpVh9RYvCRYcxw81dov5tPewjGSRRVwVAZ4EOntvJI5xfZ
         Z/fGcTpoMjJizEcmcieOjaIfE3YrC5xRULbX9uFUTCJufAXyHEqyFVxlZQ9ICPjszg4E
         xsT9lQB9grcAzfJ40To06/YtavW8Vhc2b+UHgty4b75K9MPwPTJoquBAYzBJuNngtBmD
         7/5uqJv06fqdoNW9rV5COVMkS4gLI2usgn6V20qykUTdSL9O69LQZXe05rqvKAEot7QL
         0kPA==
X-Gm-Message-State: AGi0PuaZzmiKZ0olVrJTUwtM2OdMjxnhEbWOA5hvunkJhA/dATUmOAfI
        SLSNmZplbrE7w1+s+7k+UWI=
X-Google-Smtp-Source: APiQypLYuV6w/fTD9Hyy7FfkqSrG9k2dll4pxQZ16rn70tPxFyw2C+RYY2W0PBwQksmoaC1llzpM3A==
X-Received: by 2002:a1c:f416:: with SMTP id z22mr3889087wma.32.1587643483498;
        Thu, 23 Apr 2020 05:04:43 -0700 (PDT)
Received: from debian.lan (host-84-13-17-86.opaltelecom.net. [84.13.17.86])
        by smtp.gmail.com with ESMTPSA id g15sm3432761wrp.96.2020.04.23.05.04.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Apr 2020 05:04:42 -0700 (PDT)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] IB/rdmavt: return proper error code
Date:   Thu, 23 Apr 2020 13:04:34 +0100
Message-Id: <20200423120434.19304-1-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The function rvt_create_mmap_info() can return either NULL or an error
in ERR_PTR(). Check properly for both the error type and return the
error code accordingly.

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/infiniband/sw/rdmavt/cq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rdmavt/cq.c b/drivers/infiniband/sw/rdmavt/cq.c
index 5724cbbe38b1..326b1e6b362d 100644
--- a/drivers/infiniband/sw/rdmavt/cq.c
+++ b/drivers/infiniband/sw/rdmavt/cq.c
@@ -248,8 +248,8 @@ int rvt_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	 */
 	if (udata && udata->outlen >= sizeof(__u64)) {
 		cq->ip = rvt_create_mmap_info(rdi, sz, udata, u_wc);
-		if (!cq->ip) {
-			err = -ENOMEM;
+		if (IS_ERR_OR_NULL(cq->ip)) {
+			err = cq->ip ? PTR_ERR(cq->ip) : -ENOMEM;
 			goto bail_wc;
 		}
 
-- 
2.11.0

