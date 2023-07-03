Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE94745B16
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jul 2023 13:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjGCLao (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Jul 2023 07:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjGCLan (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Jul 2023 07:30:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B64E59;
        Mon,  3 Jul 2023 04:30:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2462E60EA2;
        Mon,  3 Jul 2023 11:30:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11974C433C7;
        Mon,  3 Jul 2023 11:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688383835;
        bh=fnwln6CemjKCbAI2pkk0HZ5h53bpzKYZ/+yqxY7jdyQ=;
        h=From:To:Cc:Subject:Date:From;
        b=sELuPoj7mXoP4GnvJwiI+sewkmpy+2EIT/+iXHfI64WaqMa+pL1k8yLHKBFU11NSk
         8GGNwbQfDWg4YYHcHSoIoY86NFgqOG8k2NBEzIiJDQGqF1Xfsoaqj2CjyycF8xbdFV
         c+A6AsAgO3leH2yLXGKoVYtYVgomIyeq+D5WUF3vUf/cnh+hBYjw2E40109lrVuH6E
         q+o4X/WoKCbH7Sduba3ZCgv9D0XgGKgt/ZN9vD0viumNWaXfkE8H+Uu2ehkZLKgxGm
         9qB+BEqiMxmcx4N/dFvodx7cYXJVzxm1o5VZh3zFjGS/sqihPbvXLHQS7/CUmIfXrk
         aRjghhFRwdyFw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA: fix INFINIBAND_USER_ACCESS dependency
Date:   Mon,  3 Jul 2023 13:30:06 +0200
Message-Id: <20230703113025.356682-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

After a change to the bnxt_re driver, it fails to link when
CONFIG_INFINIBAND_USER_ACCESS is disabled:

aarch64-linux-ld: drivers/infiniband/hw/bnxt_re/ib_verbs.o: in function `bnxt_re_handler_BNXT_RE_METHOD_ALLOC_PAGE':
ib_verbs.c:(.text+0xd64): undefined reference to `ib_uverbs_get_ucontext_file'
aarch64-linux-ld: drivers/infiniband/hw/bnxt_re/ib_verbs.o:(.rodata+0x168): undefined reference to `uverbs_idr_class'
aarch64-linux-ld: drivers/infiniband/hw/bnxt_re/ib_verbs.o:(.rodata+0x1a8): undefined reference to `uverbs_destroy_def_handler'

The problem is that the 'bnxt_re_uapi_defs' structure is built
unconditionally and references a couple of functions that are never
really called in this configuration but instead require other functions
that are left out.

Adding an #ifdef around the new code, or a Kconfig dependency would
address this problem, but adding the compile-time check inside of the
UAPI_DEF_CHAIN_OBJ_TREE_NAMED() macro seems best because that also
addresses the problem in other drivers that may run into the same
dependency.

Fixes: 360da60d6c6ed ("RDMA/bnxt_re: Enable low latency push")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/rdma/uverbs_ioctl.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/rdma/uverbs_ioctl.h b/include/rdma/uverbs_ioctl.h
index 9d45a5b203169..06287de69cd29 100644
--- a/include/rdma/uverbs_ioctl.h
+++ b/include/rdma/uverbs_ioctl.h
@@ -436,8 +436,10 @@ struct uapi_definition {
 	},								       \
 		##__VA_ARGS__
 #define UAPI_DEF_CHAIN_OBJ_TREE_NAMED(_object_enum, ...)                       \
-	UAPI_DEF_CHAIN_OBJ_TREE(_object_enum, &UVERBS_OBJECT(_object_enum),    \
-				##__VA_ARGS__)
+	UAPI_DEF_CHAIN_OBJ_TREE(_object_enum,				       \
+		PTR_IF(IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS),	       \
+		       &UVERBS_OBJECT(_object_enum)),			       \
+		##__VA_ARGS__)
 
 /*
  * =======================================
-- 
2.39.2

