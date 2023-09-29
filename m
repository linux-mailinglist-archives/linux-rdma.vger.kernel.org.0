Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B44F7B399D
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Sep 2023 20:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbjI2SFR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 Sep 2023 14:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233845AbjI2SFG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 29 Sep 2023 14:05:06 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88986CEA
        for <linux-rdma@vger.kernel.org>; Fri, 29 Sep 2023 11:04:34 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-692a885f129so10367253b3a.0
        for <linux-rdma@vger.kernel.org>; Fri, 29 Sep 2023 11:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696010674; x=1696615474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sk2AIw2pt4hARdmfDz+pJbA65TQJu27TBdJQsR6YVso=;
        b=jbPktZ7pq3R5vQZkDKPITPCb0VWyGBYip46/QkIIxuajAsGyY4AZapz/t64rlgA9VO
         6ihBTOllHCUaBUnDzfPJY1Wc8Eh6FbTJBslHt+zm0OrmdLm7eYPgsVidUtJtQuWF80bY
         PXawxC1fIDXDuUyNyAf/SfByF0NaKGuoGce+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696010674; x=1696615474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sk2AIw2pt4hARdmfDz+pJbA65TQJu27TBdJQsR6YVso=;
        b=FdnvwmITNooRE06DVCazuuwQKxUP/h/7WTOrEOpkY5Hhh3YAkYsyI2UGUouSBi97LJ
         sSEwwMCvtPnksl6or5VS9yDHxvWFHJ8ckHZFeIhevnlT0QEJ6j/sJty81emVQAR5XSNe
         nCnYBLuK/DRxjx0cuMWoRAnjx8b1yyw1pG1emrQD4Oe6r8e533IuMX68x3ZtHauGRrBX
         3hz+VmPE1reWJckDNKFEDCOFs1qVfHgU38q/CE8jvbNptPvTLC3C6ebkDGkSvs9zyyu9
         szUyZb+byZLAnnHeDsZQIwlaDCLzr/aOx+l74QSfjQWltSM5LfPwisY7MkRSKZORRUaw
         fe1Q==
X-Gm-Message-State: AOJu0YzkYQgzvy6Xvq7bs0FmCdEe8r85nvIXOPIeQsVfkiT/F2Ko/ktL
        QBYqxQE8cIE3nKem3x9z088QXKaVkimIm2+kGko=
X-Google-Smtp-Source: AGHT+IF52bKA/fkpG//8ng6o8+pByKARjWnzC4wFfcw/5B8Vi+BbgRJtb1w+TaWQ21ul0/hLPN0rXA==
X-Received: by 2002:a05:6a00:1589:b0:693:4a43:1c7e with SMTP id u9-20020a056a00158900b006934a431c7emr5259056pfk.29.1696010673936;
        Fri, 29 Sep 2023 11:04:33 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s196-20020a6377cd000000b005789cbd2cacsm14718511pgc.20.2023.09.29.11.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 11:04:32 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Kees Cook <keescook@chromium.org>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
        Avihai Horon <avihaih@nvidia.com>,
        Anand Khoje <anand.a.khoje@oracle.com>,
        Mark Bloch <mbloch@nvidia.com>,
        Christian Benvenuti <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Patrisious Haddad <phaddad@nvidia.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Tom Talpey <tom@talpey.com>,
        wangjianli <wangjianli@cdjrlc.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH 4/7] RDMA/siw: Annotate struct siw_pbl with __counted_by
Date:   Fri, 29 Sep 2023 11:04:27 -0700
Message-Id: <20230929180431.3005464-4-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230929180305.work.590-kees@kernel.org>
References: <20230929180305.work.590-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1176; i=keescook@chromium.org;
 h=from:subject; bh=8TFS+r6rwfEZHwFvOLksc3v8PZIOUrROKrYJlwQtijk=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlFxGu773COsQ9qpU+8QNaYwhfW/LhcAaSb6gVg
 FWhje/hPFOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZRcRrgAKCRCJcvTf3G3A
 JoKwD/98GIMcp1DtQPrGoXgjgRKK4LtdowIapfABsa34RZm6dmv5HgM9bCb+SlhpMQ0LbdOmLDi
 QpNAWZz/IIMNujaAkdZNQoGNvE4WXfkmDvsyLByCirVuOambsysBvy7ZxEKX78YWT4Fgr/BIkt7
 YQTLgXeEGLUz3pXd5DV/UOkYEaiOocsWiEjNJgQezzsRjk080yecZE8Uuofk3lBnLmHXVVlezDE
 1F14N790wyRyXR+1F2EnBtHDBb3SzKoTUm5ZzPfi8o3eZmhR+/Qgk8yqXcJuVQ1lGxbIkGZE4HQ
 k4FQSCvpLBWvQKmC9iS9CWs5w4uPGbAUgX2De3P5wtipK4ahcpgWianBFJ2lfoVUTX4QVWBGpqr
 NZ9XSnhMyXywgMW4Vn8fI8po9Bnrty6JCNekXPpquacZOz0arMq/32cCWmetdys0Qi6EODNhALD
 /ABu3vViC1ZK5pViwpHiK1JtFlum9I/mp4gUrbpn9VU8skPh3dyUH9VWlq2rAV4BK83IlPVw02P
 4pmkldLl63CWi/d7mvhfPtgmc1Etz33xHDSk31DEEBvqh4AQ3kmn1G6+2RtoBsV9QPV3qkjhH9H
 V3wP50SqbitWnN107wLHRygD085ais4LIDR4xdFyC4K6FmyxVY1CJKjlPyiLCPKJVA8KV1TGqqz pSuxYgQ0Gj82THw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct siw_pbl.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Bernard Metzler <bmt@zurich.ibm.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/infiniband/sw/siw/siw.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
index 1c78c1ca7d7a..cec5cccd2e75 100644
--- a/drivers/infiniband/sw/siw/siw.h
+++ b/drivers/infiniband/sw/siw/siw.h
@@ -137,7 +137,7 @@ struct siw_pble {
 struct siw_pbl {
 	unsigned int num_buf;
 	unsigned int max_buf;
-	struct siw_pble pbe[];
+	struct siw_pble pbe[] __counted_by(max_buf);
 };
 
 /*
-- 
2.34.1

