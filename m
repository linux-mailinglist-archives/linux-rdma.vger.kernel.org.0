Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B0E65F6D4
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Jan 2023 23:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236068AbjAEWcy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Jan 2023 17:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236192AbjAEWcf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Jan 2023 17:32:35 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEC213D5E
        for <linux-rdma@vger.kernel.org>; Thu,  5 Jan 2023 14:32:34 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id g20so18176569pfb.3
        for <linux-rdma@vger.kernel.org>; Thu, 05 Jan 2023 14:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RMspBu+uWa9sfLmLyUJ/wSTZmKLpqqXkwp6DWYRYmTM=;
        b=ZzyGzoeKKvZaoMdQYk9/JEb/R0fTMTl8jdxKSg3s6JKyfR79CnB4sS8bEQ0ONL6UQB
         YBcEnGw41a+iNz23j6xzSeW7vrD1JAOeqwfntUXzII3h4d96KHoVSc/4Kb16WiQKOAvq
         HUM40kmHERgBRNXvQuc2zDBkmB/8ypXu6eaE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RMspBu+uWa9sfLmLyUJ/wSTZmKLpqqXkwp6DWYRYmTM=;
        b=TsmXOrUjlxCCK70oE9i4UK5eKnBhaFacJy7NR9YT2klxYXMxaGDrVyOGEfGwsXfp2b
         u9ijFRFjRUMSx27C9sqbrzQnyqm5TcvVs4p3XEiURrMfedFYOq1HrA+hpTgAIq+hvT4b
         oDQcMwOf9jk1KIZT7oNv49C8GCSsJqIz3vKIXiagMio9ViY2TvhJAMYJwSKxQklWkmvO
         KIn8DYVT0I7ZFEwQCstHi1BoUD2sn/jODu+8MIRjp9iGxk+1FDA3xDilM8tv/6EXOLBL
         dvK42WtsrLL2bAAXUiLiPhD9BJMmOisyUd5DrBEEZ8jWOTMjxfoa7M0vaFWYZV+CtDxY
         gbQg==
X-Gm-Message-State: AFqh2koE+a+Gn4dNI067IreJ5NoXGtrdR0D+2SQ6b162QNGxnh4uBhXF
        1zzv88CuEHpND7UMiHiE+o02Dg==
X-Google-Smtp-Source: AMrXdXsqq4Mi747oUWhsFhMpsCCbXt0HvHTAJ74J9uJiiSUwowl84oG/P6DbQxUEysWYLcBj9mSczg==
X-Received: by 2002:a62:1a51:0:b0:581:d46a:343a with SMTP id a78-20020a621a51000000b00581d46a343amr25696694pfa.18.1672957954467;
        Thu, 05 Jan 2023 14:32:34 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x74-20020a62864d000000b0058217bbc6f5sm11470796pfd.215.2023.01.05.14.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 14:32:34 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Potnuri Bharat Teja <bharat@chelsio.com>
Cc:     Kees Cook <keescook@chromium.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] RDMA/cxgb4: Replace 0-length arrays with flexible arrays
Date:   Thu,  5 Jan 2023 14:32:32 -0800
Message-Id: <20230105223225.never.252-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3478; h=from:subject:message-id; bh=dxMDzsMc6oaxPr4Do5C0Wr2AT/H+H0SzXI+dU/p0IOo=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjt1AA6TRACNi/UTQWnJlFJAmhMJxt1Q/q61h8WXc3 5MfFzMqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY7dQAAAKCRCJcvTf3G3AJjVaD/ 9JTizo/XmwroMPtX6agewL84FuMweJSgXJ/ngjmZqAvjA4oSofA1pqyp6qjaTkS7Ffi97TBUNKh731 qz9L0CmgSdP0hBnpfosBkNgfM5pO2u+ag48S3IfVZeg7VsLTTVZp04S2OamHaMqESexB39eRz0uIh8 dcGypx0LM5c6nxKDc5xRL6BnMUiCCiJeHtd/IVQuOZb3yNZoxeIUsHHQoreTaxorIm52+u5eG0bAEJ PRqXLoHf2rbQR3MuRnvASk9NxmIXnL1X+uNshx/DDixHa47N5acBqgPOzz68JBvXVP9SBUCjpjgQce lIuze1Nl9AJB8B4D8ldabt89DnJM7+SHgdm1MWvoi6CRqdzNtvdez7GI4P0pduHVryotdSUjkXjGfQ uwBdIPmBsiE06weLdk1sZD6/sDbB2Ly/8MZBG0ZQqMicHPkJAbuKPgLcOjUxNrpMFemTcWatisk3hH O9d2LDnrcdn3ruLoUyvN5XhiuxK9qdoY0JKyLNfcxBgnHtvN3IZOyAADW13W1hQOZ9E3MtrGwVG867 8sGHv9T6Ph6OtZJWHdcwvI762jAWfFy55Cg2OUCBlko0lKcrVCANTNU94drHuN7dBbFHV3PF16DS2U TikaXuZ026+s1VSX3/FrNaVB4vyaK2bjIONqe8znqyMKfK0n+l3YFgm+IKtg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Zero-length arrays are deprecated[1]. Replace all remaining
0-length arrays with flexible arrays. Detected with GCC 13, using
-fstrict-flex-arrays=3:

In function 'build_rdma_write',
    inlined from 'c4iw_post_send' at ../drivers/infiniband/hw/cxgb4/qp.c:1173:10:
../drivers/infiniband/hw/cxgb4/qp.c:597:38: warning: array subscript 0 is outside array bounds of 'struct fw_ri_immd[0]' [-Warray-bounds=]
  597 |                 wqe->write.u.immd_src[0].r2 = 0;
      |                 ~~~~~~~~~~~~~~~~~~~~~^~~
../drivers/infiniband/hw/cxgb4/t4fw_ri_api.h: In function 'c4iw_post_send':
../drivers/infiniband/hw/cxgb4/t4fw_ri_api.h:567:35: note: while referencing 'immd_src'
  567 |                 struct fw_ri_immd immd_src[0];
      |                                   ^~~~~~~~

Additionally drop the unused C99_NOT_SUPPORTED ifndef lines.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays

Cc: Potnuri Bharat Teja <bharat@chelsio.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/infiniband/hw/cxgb4/t4fw_ri_api.h | 26 ++++++-----------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/t4fw_ri_api.h b/drivers/infiniband/hw/cxgb4/t4fw_ri_api.h
index a2f5e29ef226..1f79537fc8d1 100644
--- a/drivers/infiniband/hw/cxgb4/t4fw_ri_api.h
+++ b/drivers/infiniband/hw/cxgb4/t4fw_ri_api.h
@@ -122,9 +122,7 @@ struct fw_ri_dsgl {
 	__be16	nsge;
 	__be32	len0;
 	__be64	addr0;
-#ifndef C99_NOT_SUPPORTED
 	struct fw_ri_dsge_pair sge[];
-#endif
 };
 
 struct fw_ri_sge {
@@ -138,9 +136,7 @@ struct fw_ri_isgl {
 	__u8	r1;
 	__be16	nsge;
 	__be32	r2;
-#ifndef C99_NOT_SUPPORTED
 	struct fw_ri_sge sge[];
-#endif
 };
 
 struct fw_ri_immd {
@@ -148,9 +144,7 @@ struct fw_ri_immd {
 	__u8	r1;
 	__be16	r2;
 	__be32	immdlen;
-#ifndef C99_NOT_SUPPORTED
 	__u8	data[];
-#endif
 };
 
 struct fw_ri_tpte {
@@ -320,9 +314,7 @@ struct fw_ri_res_wr {
 	__be32 op_nres;
 	__be32 len16_pkd;
 	__u64  cookie;
-#ifndef C99_NOT_SUPPORTED
 	struct fw_ri_res res[];
-#endif
 };
 
 #define FW_RI_RES_WR_NRES_S	0
@@ -562,12 +554,10 @@ struct fw_ri_rdma_write_wr {
 	__be32 plen;
 	__be32 stag_sink;
 	__be64 to_sink;
-#ifndef C99_NOT_SUPPORTED
 	union {
-		struct fw_ri_immd immd_src[0];
-		struct fw_ri_isgl isgl_src[0];
+		DECLARE_FLEX_ARRAY(struct fw_ri_immd, immd_src);
+		DECLARE_FLEX_ARRAY(struct fw_ri_isgl, isgl_src);
 	} u;
-#endif
 };
 
 struct fw_ri_send_wr {
@@ -581,12 +571,10 @@ struct fw_ri_send_wr {
 	__be32 plen;
 	__be32 r3;
 	__be64 r4;
-#ifndef C99_NOT_SUPPORTED
 	union {
-		struct fw_ri_immd immd_src[0];
-		struct fw_ri_isgl isgl_src[0];
+		DECLARE_FLEX_ARRAY(struct fw_ri_immd, immd_src);
+		DECLARE_FLEX_ARRAY(struct fw_ri_isgl, isgl_src);
 	} u;
-#endif
 };
 
 #define FW_RI_SEND_WR_SENDOP_S		0
@@ -618,12 +606,10 @@ struct fw_ri_rdma_write_cmpl_wr {
 		struct fw_ri_isgl isgl_src;
 	} u_cmpl;
 	__be64 r3;
-#ifndef C99_NOT_SUPPORTED
 	union fw_ri_write {
-		struct fw_ri_immd immd_src[0];
-		struct fw_ri_isgl isgl_src[0];
+		DECLARE_FLEX_ARRAY(struct fw_ri_immd, immd_src);
+		DECLARE_FLEX_ARRAY(struct fw_ri_isgl, isgl_src);
 	} u;
-#endif
 };
 
 struct fw_ri_rdma_read_wr {
-- 
2.34.1

