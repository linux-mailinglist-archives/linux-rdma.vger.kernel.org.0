Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E2F70FF22
	for <lists+linux-rdma@lfdr.de>; Wed, 24 May 2023 22:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236470AbjEXUXH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 May 2023 16:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236438AbjEXUXG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 24 May 2023 16:23:06 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D16D119
        for <linux-rdma@vger.kernel.org>; Wed, 24 May 2023 13:23:05 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-19a16c8d70cso391548fac.2
        for <linux-rdma@vger.kernel.org>; Wed, 24 May 2023 13:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684959784; x=1687551784;
        h=content-transfer-encoding:in-reply-to:from:to:content-language
         :references:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wGTvyLDmo1kbzSrxWfN+Hk9b51mZ60yTkWnKC8OsEwM=;
        b=B+Ob189freoqFEnneEgy7cr2bZ5AKdx5p0AzDz43ajeI4TDjW30SZMOovV/77BDBxI
         x7L9jshvT565nVxwAZxI6kHMqOWGE9SuLWrWDWGUs6JCcnljgsmowTzFRj3qKz8+cMVg
         OTAuVdEVhPeBjVhHfMrLjKwHgChSohcqYxVQg9Ut/+QQt0vXJkFZoFOOewCt3TOReuBW
         LPaqUPM8qdTkPgcStEPswC1+EhXAJLxVchVXsE/DM+rjmWbN2h+6ejMu615AFPkVYgw5
         nM58VYuo4VMu1L5zVEh+GToGDkkJaVl8Ow2BzkcIco5XDKLFoRCRFYRUv/A/b1MfncFe
         VcJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684959784; x=1687551784;
        h=content-transfer-encoding:in-reply-to:from:to:content-language
         :references:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wGTvyLDmo1kbzSrxWfN+Hk9b51mZ60yTkWnKC8OsEwM=;
        b=fXLU7hoRjteIlu73zeWu/KCRNzUpOzcnlvxYJ9sYHnnBsITvwAg2EFoVHbKCm7gH/b
         uzfo9f9pFYNAQhfCR5M0kJwI1EXuN9+J0jCP0of9OGzSPswhDUHg11b1Nn79tXl+pToU
         g6bFXmfe4vGwVE3t/z74ee/QU1SsmDjrmXNCunhsduF2pVREKUH1x3NTQ2w35znN7TIE
         pg4Ysv0Rlw/5fRbm+97f1t6whb/yzmOA6Y9chMTDYKeMXD83f8F46gUvbAdL3GJ4XgFM
         UH/xuN8RxBkYxnHdgxcj/IyYam7uxCMxWIKTZeTffsWwEdsShy2OERUJS5BZvjXlSl/C
         3iMQ==
X-Gm-Message-State: AC+VfDxHNEVQCm24AUdPvVqwqws3ZWltI7qw02DR49KSqr7jdzBAFyvi
        GjRt1BSfl95YfViU+GUo48djAoG++X7nxg==
X-Google-Smtp-Source: ACHHUZ4Q+yyM+fLqb+HhV5E6eieuwdPMnh7gUKSNsk+VdJ5HQiJ9OxeuPy//81cbFJKjjDi1OBLdiQ==
X-Received: by 2002:a05:6870:281:b0:19e:d289:f5cb with SMTP id q1-20020a056870028100b0019ed289f5cbmr421933oaf.33.1684959784373;
        Wed, 24 May 2023 13:23:04 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:cd7c:e5fe:84fe:3bf3? (2603-8081-140c-1a00-cd7c-e5fe-84fe-3bf3.res6.spectrum.com. [2603:8081:140c:1a00:cd7c:e5fe:84fe:3bf3])
        by smtp.gmail.com with ESMTPSA id s28-20020a0568301e1c00b006af78565d64sm3867693otr.46.2023.05.24.13.23.03
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 13:23:04 -0700 (PDT)
Message-ID: <ebe123c1-521c-8c2c-5773-46e84641ce29@gmail.com>
Date:   Wed, 24 May 2023 15:23:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Fwd: [PATCH RFC] tests: Fix test_mr_rereg_access
References: <20230524201925.173905-1-rpearsonhpe@gmail.com>
Content-Language: en-US
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20230524201925.173905-1-rpearsonhpe@gmail.com>
X-Forwarded-Message-Id: <20230524201925.173905-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Subject: [PATCH RFC] tests: Fix test_mr_rereg_access
Date: Wed, 24 May 2023 15:19:26 -0500
From: Bob Pearson <rpearsonhpe@gmail.com>
To: edwards@nvidia.com, idok@nvidia.com, jgg@nvidia.com
CC: Bob Pearson <rpearsonhpe@gmail.com>

The test_mr_rereg_access and test_mr_rereg_bad_flow test cases
modify the access permissions of an MR to add or remove remote
write access. This may cause a change in the value of the MR rkey
requiring that the players in the test re-exchange rkey state
after the rereg_mr call but this is not done. This patch fixes
this behavior.

Fixes: 4bc72d894481 ("tests: Add rereg MR tests")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 tests/test_mr.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/test_mr.py b/tests/test_mr.py
index 6b97e636..534df46a 100644
--- a/tests/test_mr.py
+++ b/tests/test_mr.py
@@ -115,6 +115,7 @@ class MRTest(RDMATestCase):
         access = e.IBV_ACCESS_LOCAL_WRITE | e.IBV_ACCESS_REMOTE_WRITE
         self.server.rereg_mr(flags=e.IBV_REREG_MR_CHANGE_ACCESS, access=access)
         self.client.rereg_mr(flags=e.IBV_REREG_MR_CHANGE_ACCESS, access=access)
+        self.sync_remote_attr()
         u.rdma_traffic(**self.traffic_args, send_op=e.IBV_WR_RDMA_WRITE)
 
     def test_mr_rereg_access_bad_flow(self):
@@ -129,6 +130,7 @@ class MRTest(RDMATestCase):
         u.rdma_traffic(**self.traffic_args, send_op=e.IBV_WR_RDMA_WRITE)
         access = e.IBV_ACCESS_LOCAL_WRITE
         self.server.rereg_mr(flags=e.IBV_REREG_MR_CHANGE_ACCESS, access=access)
+        self.sync_remote_attr()
         with self.assertRaisesRegex(PyverbsRDMAError, 'Remote access error'):
             u.rdma_traffic(**self.traffic_args, send_op=e.IBV_WR_RDMA_WRITE)
 
-- 
2.39.2

