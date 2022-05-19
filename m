Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A9152D9AE
	for <lists+linux-rdma@lfdr.de>; Thu, 19 May 2022 18:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241615AbiESQBS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 May 2022 12:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233730AbiESQBQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 May 2022 12:01:16 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77F619FB4
        for <linux-rdma@vger.kernel.org>; Thu, 19 May 2022 09:01:14 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id i66so6956211oia.11
        for <linux-rdma@vger.kernel.org>; Thu, 19 May 2022 09:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u4VzUhRj5PjDhVWkQM1NeOIFv8HEnxEx5drqAGII4zo=;
        b=Vr/gg7FkSDwfPOqCrf2p64MzVNWKYUzRQv/+2qlgVKhGUg6ak6xfaJspfnZRHL1L6u
         83J0bg2AKa+R7JclqSl3raNHqPZr56gV87WT5+nV14prmFZtn4YKJdga47lKD/STGZ11
         soxgZkAUhA7NIB/tyboe3J84+tCslW2NtFHpdRIziaBKpEHrwrrGg19pu0dWSXFd8xok
         YCAdUVs09TeTqlIIaeFcciqAk7S+IGzJaKV7vaed+cqNkwScdvGuMTFCO5uVfHf8Dreu
         7NHexSzBFkLjlfqcsPk+XH/iCr0RvqsxpohDPXfnjpnBFkzYxQDjrV/72s4n4ZUIz3wP
         UXpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u4VzUhRj5PjDhVWkQM1NeOIFv8HEnxEx5drqAGII4zo=;
        b=khdvdmZktMM52x/q0zeZ5hdxeIxjEzE2TswJ/RUwvMSl4OW1ircfRjStcX+XppdGNa
         3Tqr4UqAWpFGLKt/LcZ1LC1AgmJ3fAkXx+ffRJERznHdV9KTP+ZTsGimTgbHSNPgJ9uX
         hxXKu+JXC6disSbkZyk8dkwJxQblmi0gF0CLfbC7bfTdQszVHMpNCY2F8OGWClnEq7Oi
         NQD5GzlYMbK8ry7U1teeAThzeCp5om9VRFLlCqBpEdwSGofZzSkPQrMf3YCGTo1B1UC2
         hCH1JXVMaiEfya86tVjVZV4XXm6O2oxbfZQjCZhvsgPWzEVyY/00ypdc3QoE2WAVzvYo
         4Yig==
X-Gm-Message-State: AOAM530LKutw7vPKnv0/+G98KJoj/jRNqFqZ8nTStkBEkzFfom+SjaPe
        slWv0Ux4zeUmNtjUby1wtGA=
X-Google-Smtp-Source: ABdhPJyxO9AiEtE5OBAkm6R4gv+N28I3SBJgtxDTfbL1KuRyWakwKjqsFwnFmRbbdU5ntsVflROkDA==
X-Received: by 2002:a05:6808:118a:b0:322:35d7:77f2 with SMTP id j10-20020a056808118a00b0032235d777f2mr3077655oil.79.1652976074200;
        Thu, 19 May 2022 09:01:14 -0700 (PDT)
Received: from u-22.tx.rr.com (2603-8081-140c-1a00-0362-65f9-e686-7b3f.res6.spectrum.com. [2603:8081:140c:1a00:362:65f9:e686:7b3f])
        by smtp.googlemail.com with ESMTPSA id d13-20020a4a520d000000b0035f498be272sm298690oob.13.2022.05.19.09.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 09:01:13 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     edwards@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        jgg@nvidia.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-rdma-core v2] pyverbs: Fix wrong rkey in test_qp_ex_rc_bind_mw
Date:   Thu, 19 May 2022 10:58:11 -0500
Message-Id: <20220519155810.28803-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The current test_qp_ex_rc_bind_mw in tests/test_qpex.py uses an incorrect
value for the new_rkey based on the old mr.rkey. This patch fixes that
behavior by basing the new rkey on the old mw.rkey instead.

Before this patch the test will fail for the rxe driver about 1 in 256
tries since randomly that is the freguency of new_rkeys which have the
same 8 bit key portion as the current mw which is not allowed. With
this patch those errors do not occur.

Fixes: 9fca2824b5ec ("tests: Retrieve tests that generates mlx5 CQE errors")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v2
  Added a Fixes: line per Edward. It is the latest change to the test.
  Changed the subject line from RDMA/core: to pyverbs:
  Changed for-next to for-rdma-core per Zhu

 tests/test_qpex.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/test_qpex.py b/tests/test_qpex.py
index 8f3f338e..a4c99910 100644
--- a/tests/test_qpex.py
+++ b/tests/test_qpex.py
@@ -300,7 +300,7 @@ class QpExTestCase(RDMATestCase):
             if ex.error_code == errno.EOPNOTSUPP:
                 raise unittest.SkipTest('Memory Window allocation is not supported')
             raise ex
-        new_key = inc_rkey(server.mr.rkey)
+        new_key = inc_rkey(mw.rkey)
         server.qp.wr_bind_mw(mw, new_key, bind_info)
         server.qp.wr_complete()
         u.poll_cq(server.cq)
-- 
2.34.1

