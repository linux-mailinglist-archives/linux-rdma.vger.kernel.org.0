Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89A67D18F3
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Oct 2023 00:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjJTWRd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Oct 2023 18:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjJTWRc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Oct 2023 18:17:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0400F1A3
        for <linux-rdma@vger.kernel.org>; Fri, 20 Oct 2023 15:17:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22565C433C8;
        Fri, 20 Oct 2023 22:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697840250;
        bh=nKh6RC/WY9O6v8edPMPDMCHMvRheg0KMbRcWGehCASg=;
        h=From:Date:Subject:To:Cc:From;
        b=Tgaa6hTJqtOlQWrQ/+CAHlBXOu2jmobC3NuJRFzQzIoRWleDSGR9UTducyZ0xYwIH
         32VhauR6G0UGLjuTRG4v+xGp/HYM9TyvwaeUoPhf7TPdTlS1OpfG+vZ8FcrSuTLr/3
         oH9kv7gq4s/qNMEda727SdtVJDCcUp88BgD/D5lI3I56z+AkTuuaiI9o06eqJuZdnf
         dj5I4B83JtKuOsBAerx3kptllriWc7ry9O96cQ0lPvzfBzbwED7BaZzq4/N8BJ010Y
         UP+gtOP3tIoHLZak8Kqg/aEszRZPdlmQdusg47szXPDiIiu9z8Ogw88zyPCI+aayX3
         g6NQwCH5tlnpA==
From:   Nathan Chancellor <nathan@kernel.org>
Date:   Fri, 20 Oct 2023 15:17:02 -0700
Subject: [PATCH] RDMA/bnxt_re: Fix clang -Wimplicit-fallthrough in
 bnxt_re_handle_cq_async_error()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231020-bnxt_re-implicit-fallthrough-v1-1-b5c19534a6c9@kernel.org>
X-B4-Tracking: v=1; b=H4sIAF78MmUC/x3MQQqEMAxA0atI1haayjDiVUSkOqkN1CppFUG8u
 2WW7y/+DYmEKUFX3SB0cuItFmBdwextXEjxrxiMNg1qo9UUrzxKyeseeOasnA0he9mOxSv3adG
 2+EVsJiiLXcjx9d/3w/O8hUaLj24AAAA=
To:     selvin.xavier@broadcom.com, jgg@ziepe.ca, leon@kernel.org
Cc:     ndesaulniers@google.com, trix@redhat.com,
        chandramohan.akula@broadcom.com, linux-rdma@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1780; i=nathan@kernel.org;
 h=from:subject:message-id; bh=nKh6RC/WY9O6v8edPMPDMCHMvRheg0KMbRcWGehCASg=;
 b=owGbwMvMwCEmm602sfCA1DTG02pJDKlGfyrvuuw7xGYk+pCx962oRFgE80Gb5O2/ea7ODEs/t
 2EW93GmjlIWBjEOBlkxRZbqx6rHDQ3nnGW8cWoSzBxWJpAhDFycAjARox8M/8uFXplXX5p1KHh1
 sP2x51t0GliWvewROqx0yK1jycOva48z/I97H3QraXZ5ieueWxMVjZalubVr6x/elFWeHJcU/fH
 cWgYA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Clang warns (or errors with CONFIG_WERROR=y):

  drivers/infiniband/hw/bnxt_re/main.c:1114:2: error: unannotated fall-through between switch labels [-Werror,-Wimplicit-fallthrough]
   1114 |         default:
        |         ^
  drivers/infiniband/hw/bnxt_re/main.c:1114:2: note: insert 'break;' to avoid fall-through
   1114 |         default:
        |         ^
        |         break;
  1 error generated.

Clang is a little more pedantic than GCC, which does not warn when
falling through to a case that is just break or return. Clang's version
is more in line with the kernel's own stance in deprecated.rst, which
states that all switch/case blocks must end in either break,
fallthrough, continue, goto, or return. Add the missing break to silence
the warning.

Closes: https://github.com/ClangBuiltLinux/linux/issues/1950
Fixes: b02fd3f79ec3 ("RDMA/bnxt_re: Report async events and errors")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/infiniband/hw/bnxt_re/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index bd3deb254a85..f79369c8360a 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1111,6 +1111,7 @@ static int bnxt_re_handle_cq_async_error(void *event, struct bnxt_re_cq *cq)
 	case CREQ_CQ_ERROR_NOTIFICATION_CQ_ERR_REASON_RES_CQ_OVERFLOW_ERROR:
 	case CREQ_CQ_ERROR_NOTIFICATION_CQ_ERR_REASON_RES_CQ_LOAD_ERROR:
 		ibevent.event = IB_EVENT_CQ_ERR;
+		break;
 	default:
 		break;
 	}

---
base-commit: 45cfa8864cd3ae228ddb17bf2316a0ab3284f70d
change-id: 20231020-bnxt_re-implicit-fallthrough-f581a817113b

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>

