Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5280781DFC
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Aug 2023 15:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjHTNyG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 20 Aug 2023 09:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjHTNyB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 20 Aug 2023 09:54:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9DC310C4
        for <linux-rdma@vger.kernel.org>; Sun, 20 Aug 2023 06:53:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 547C360C85
        for <linux-rdma@vger.kernel.org>; Sun, 20 Aug 2023 13:53:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F791C433C8;
        Sun, 20 Aug 2023 13:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692539601;
        bh=FdRSdW1ydryxJDKhvkfqJFH8EF3a7vwz35zZR0K/Vks=;
        h=From:To:Cc:Subject:Date:From;
        b=XDHV9QEDLwiEaxBrXAi+ZZy5pQnSENmzQgeBnbio9rcL+iiCA8oWyuOCAC1vU9yMd
         yQwTLHE5eFGIhBHupCV8HGcjDa3J0s0m3m/z+pIh2u/9ZLQqDGVMhjeadZVSbwg8y1
         /XHSX1IhgH8edUvaik9syfq65ctEG+PYfb7AmEvhXRmGjc/IRM/Vce3oQ0ns0/+fwA
         tFHMl5BUlBAATXVZqaskHAEVWiRe2SZXFzc3u79LXfg4HtU57dLQd1oshIKshRZXgu
         ryQamzOM9i7USCZZqr5JkmQWW79xQyU6ddcGlhkOyT1LGwMX7OUw/DRC93UOjyQ6Fg
         +4oZU9JEaWTVA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        kernel test robot <lkp@intel.com>,
        linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-next] RDMA/bnxt_re: Fix kernel doc errors
Date:   Sun, 20 Aug 2023 16:53:15 +0300
Message-ID: <4b22c385f1b68590ace8f82f2985d14b20999432.1692539554.git.leon@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Fix set of the following errors due to use of wrong kernel doc format
to describe function parameters:

drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:68: warning: Function parameter or member 'rcfw'
	not described in '__wait_for_resp'

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202308180600.oOnkIAQV-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202308180401.iaj2ktTc-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202308180214.Lt9NAhbM-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202308180055.6zM4AK6V-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202308172136.ipx1wvs6-lkp@intel.com/
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 30 +++++++++++-----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 287117ec50ee..524a5ff58872 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -55,7 +55,7 @@ static void bnxt_qplib_service_creq(struct tasklet_struct *t);
 
 /**
  * bnxt_qplib_map_rc  -  map return type based on opcode
- * @opcode    -  roce slow path opcode
+ * @opcode:  roce slow path opcode
  *
  * case #1
  * Firmware initiated error recovery is a safe state machine and
@@ -98,8 +98,8 @@ static int bnxt_qplib_map_rc(u8 opcode)
 
 /**
  * bnxt_re_is_fw_stalled   -	Check firmware health
- * @rcfw      -   rcfw channel instance of rdev
- * @cookie    -   cookie to track the command
+ * @rcfw:     rcfw channel instance of rdev
+ * @cookie:   cookie to track the command
  *
  * If firmware has not responded any rcfw command within
  * rcfw->max_timeout, consider firmware as stalled.
@@ -133,8 +133,8 @@ static int bnxt_re_is_fw_stalled(struct bnxt_qplib_rcfw *rcfw,
 
 /**
  * __wait_for_resp   -	Don't hold the cpu context and wait for response
- * @rcfw      -   rcfw channel instance of rdev
- * @cookie    -   cookie to track the command
+ * @rcfw:    rcfw channel instance of rdev
+ * @cookie:  cookie to track the command
  *
  * Wait for command completion in sleepable context.
  *
@@ -179,8 +179,8 @@ static int __wait_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie)
 
 /**
  * __block_for_resp   -	hold the cpu context and wait for response
- * @rcfw      -   rcfw channel instance of rdev
- * @cookie    -   cookie to track the command
+ * @rcfw:    rcfw channel instance of rdev
+ * @cookie:  cookie to track the command
  *
  * This function will hold the cpu (non-sleepable context) and
  * wait for command completion. Maximum holding interval is 8 second.
@@ -216,8 +216,8 @@ static int __block_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie)
 };
 
 /*  __send_message_no_waiter -	get cookie and post the message.
- * @rcfw      -   rcfw channel instance of rdev
- * @msg      -    qplib message internal
+ * @rcfw:   rcfw channel instance of rdev
+ * @msg:    qplib message internal
  *
  * This function will just post and don't bother about completion.
  * Current design of this function is -
@@ -374,8 +374,8 @@ static int __send_message(struct bnxt_qplib_rcfw *rcfw,
 
 /**
  * __poll_for_resp   -	self poll completion for rcfw command
- * @rcfw      -   rcfw channel instance of rdev
- * @cookie    -   cookie to track the command
+ * @rcfw:     rcfw channel instance of rdev
+ * @cookie:   cookie to track the command
  *
  * It works same as __wait_for_resp except this function will
  * do self polling in sort interval since interrupt is disabled.
@@ -471,8 +471,8 @@ static void __destroy_timedout_ah(struct bnxt_qplib_rcfw *rcfw,
 /**
  * __bnxt_qplib_rcfw_send_message   -	qplib interface to send
  * and complete rcfw command.
- * @rcfw      -   rcfw channel instance of rdev
- * @msg      -    qplib message internal
+ * @rcfw:   rcfw channel instance of rdev
+ * @msg:    qplib message internal
  *
  * This function does not account shadow queue depth. It will send
  * all the command unconditionally as long as send queue is not full.
@@ -534,8 +534,8 @@ static int __bnxt_qplib_rcfw_send_message(struct bnxt_qplib_rcfw *rcfw,
 /**
  * bnxt_qplib_rcfw_send_message   -	qplib interface to send
  * and complete rcfw command.
- * @rcfw      -   rcfw channel instance of rdev
- * @msg      -    qplib message internal
+ * @rcfw:   rcfw channel instance of rdev
+ * @msg:    qplib message internal
  *
  * Driver interact with Firmware through rcfw channel/slow path in two ways.
  * a. Blocking rcfw command send. In this path, driver cannot hold
-- 
2.41.0

