Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9373E296B
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Aug 2021 13:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239256AbhHFLVx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 Aug 2021 07:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbhHFLVw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 6 Aug 2021 07:21:52 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1DAC061798
        for <linux-rdma@vger.kernel.org>; Fri,  6 Aug 2021 04:21:37 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id k9so12551474edr.10
        for <linux-rdma@vger.kernel.org>; Fri, 06 Aug 2021 04:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EPPC0qPxQm2RVeXTcf5DSgy0cE/ml10ixvbWjvwhb50=;
        b=P7mVbGVwQwU3susj8tABbbaxvjmiot+ncHz8ieQBbrIeQHgR9EZqZG8UvZTizfrKxw
         xLdjK8plsvcVGZo6by1pLF1a1BVY0GfOu+K1RD9r6NGu9BrLToBGb7+2pHhON4H6GNOm
         NPVFg0opMBQrShKtiV5lxihilL1TxCRrZXKUieA+RPtsvZOLFzLVrxEw+VC32q8+aJ4w
         bjhAoH4PfAEjoyE9gOhmHMNhbIgWZWACa2HF8T7+8DMOLqhBXlwuwvtFSOCvUfZme2Zy
         r78jfr4dtQbSpszm+O5cuQeBisWgbynXaEz0x59hJee42eiGGR3y9jEAjzCnrMcrfBJM
         V5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EPPC0qPxQm2RVeXTcf5DSgy0cE/ml10ixvbWjvwhb50=;
        b=fnHvUAMC9gGWOBD2dny9x301vlAt9mwPyI3bCaQLD+vvNGW1cyxMhdBLOB6AiGBdfJ
         L2afojKfUZSwI4Xe74Lee9hXz7I2aNQp7MGR2XepbnvGRLG01kTn90pER2UALwDsGeg7
         doLB/HA94c8fmNW6JmxxOPCSP8Pl6ewmtztSKD8DJoUuzmcSy4cbb5RipqDUi79vrSfZ
         jO5Kv+/6QrGP7WOMvvpGbdk7iF0zzypwTCC3Qo71+BP6u0kh3ELAz+RAu1zPTXvE/eTM
         9b6BzBuGmicVpt+mAMgMle2tIBhe+x6zH+MFdq3QjOiGjFUXHB74romtvv03E+ZUDBUB
         QrTw==
X-Gm-Message-State: AOAM531JHtnFfY43px9Uf0/b64NOmqs+mYDiM1U8I9WanbUuaRiy+/cl
        0Jghf6BkGw70zL3FhTAs/um9o1Ok2rRjmQ==
X-Google-Smtp-Source: ABdhPJzmngPBVjNpICGFB2gTukcQx0ulHHAnOqhdJkzIlWIriSdHFzkU54glZzO7+pvxQvKto8Qsag==
X-Received: by 2002:a50:ce45:: with SMTP id k5mr12200480edj.168.1628248895643;
        Fri, 06 Aug 2021 04:21:35 -0700 (PDT)
Received: from nb01533.pb.local ([2001:1438:4010:2540:9e61:8a1a:7868:3b15])
        by smtp.gmail.com with ESMTPSA id q11sm2794729ejb.10.2021.08.06.04.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 04:21:35 -0700 (PDT)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com
Subject: [PATCH v2 for-next 1/6] RDMA/rtrs-clt: During add_path change for_new_clt according to path_num
Date:   Fri,  6 Aug 2021 13:21:07 +0200
Message-Id: <20210806112112.124313-2-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210806112112.124313-1-haris.iqbal@ionos.com>
References: <20210806112112.124313-1-haris.iqbal@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When all the paths are removed for a session, the addition of the first
path is like a new session for the storage server.

Hence, for_new_clt has to be set to 1.

Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index ece3205531b8..a7b450715eaf 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -3083,6 +3083,18 @@ int rtrs_clt_create_path_from_sysfs(struct rtrs_clt *clt,
 	if (IS_ERR(sess))
 		return PTR_ERR(sess);
 
+	mutex_lock(&clt->paths_mutex);
+	if (clt->paths_num == 0) {
+		/*
+		 * When all the paths are removed for a session,
+		 * the addition of the first path is like a new session for
+		 * the storage server
+		 */
+		sess->for_new_clt = 1;
+	}
+
+	mutex_unlock(&clt->paths_mutex);
+
 	/*
 	 * It is totally safe to add path in CONNECTING state: coming
 	 * IO will never grab it.  Also it is very important to add
-- 
2.25.1

