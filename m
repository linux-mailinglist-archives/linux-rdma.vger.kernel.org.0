Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7518572F82C
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jun 2023 10:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242991AbjFNIpT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 14 Jun 2023 04:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234266AbjFNIpT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 14 Jun 2023 04:45:19 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDFF1B2
        for <linux-rdma@vger.kernel.org>; Wed, 14 Jun 2023 01:45:17 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-30e412a852dso4480269f8f.0
        for <linux-rdma@vger.kernel.org>; Wed, 14 Jun 2023 01:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686732316; x=1689324316;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RyMsJrvbKosPNY/vAwwOvxxS4pHd5M9Y0nilZ5D2MVo=;
        b=qF/FZgavsPbxPKfHFAvaCjTgNcg4rmKEeDsPhpQycQbZViuEbe2bQRsjq3EWrUAlIT
         UKtKJnP1ZWNU2zTuWecdDR5/R0nT7//x+lS74yyY2+Opm/p1NnAUFlufvuaDyCQUvsUL
         oGhvgvjfYZeYht3JPBIJxldwcAvR3vP5c1tZfPfJJEe/LRSkfhX6sSHP40K++CG45Ci0
         c9phmXAZXnZ1vBE9R6PKc/i42x+CK4mlu/zqFlfVppTSbGJd9K1anPGIMlEDB94VGDu9
         okeUyoI+3Kgy7KZKlyScdDm202z60blkP6vHL3rlzY+jfCJ8QvzrmFrdRK9Wm0+jJ5pP
         vrzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686732316; x=1689324316;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RyMsJrvbKosPNY/vAwwOvxxS4pHd5M9Y0nilZ5D2MVo=;
        b=HF9umCF+8EHpKy22pvgg3oAD783Kc9FbmrCoGT5jEH/4vpHyPzgcq0HTO0PqzsBwap
         bxNAfDAl2JOjFIyFr/6eflrgA0isfJmNvb/5VS/mQWghAs8XCunqjMWiPnOZjLSPlGA7
         OJ8ejPWaii3ps79SyOUf1oYeBkTI0ArB3jlkwsL+X1yG0BsVjTqn3B26uEAcOH6wE7H4
         VWhLpZHXrx2RMXatVmIuLJK6IH4tzR3xwiMOybf7Z44JvDLD5XJzjW+Wdij1iYrDqKbq
         +C3pfe9n1Ow8703BRkIsDol867JBgfc89orIBfsaG7/buNGDbvXTGHcAY948GqpC0L1i
         ahYw==
X-Gm-Message-State: AC+VfDzHXRtkjigZBXjovfEM97XZxHeYslhu0gUAgSnB8MmTh0P/Qq7p
        Irf0oZ/ul7p1Wghv8g+P1p4CYeC3a3DPxZvdMTA=
X-Google-Smtp-Source: ACHHUZ5TzLBSnecH4B5CgmPrlBpr04x1ixw6qgAnL9QgNelafrBnbmVWNN1MvDh+9LIYEKnKeuFuHg==
X-Received: by 2002:adf:e504:0:b0:30a:dd15:bb69 with SMTP id j4-20020adfe504000000b0030add15bb69mr7198529wrm.18.1686732316212;
        Wed, 14 Jun 2023 01:45:16 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id b1-20020a5d5501000000b0030ae69920c9sm17644303wrv.53.2023.06.14.01.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 01:45:14 -0700 (PDT)
Date:   Wed, 14 Jun 2023 11:45:08 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     kashyap.desai@broadcom.com
Cc:     linux-rdma@vger.kernel.org
Subject: [bug report] RDMA/bnxt_re: handle command completions after driver
 detect a timedout
Message-ID: <35e505b9-f174-46b4-9b0d-7d30e5717560@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello Kashyap Desai,

The patch 691eb7c6110f: "RDMA/bnxt_re: handle command completions
after driver detect a timedout" from Jun 9, 2023, leads to the
following Smatch static checker warning:

	drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:513 __bnxt_qplib_rcfw_send_message()
	warn: duplicate check 'rc' (previous on line 506)

drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
    477 static int __bnxt_qplib_rcfw_send_message(struct bnxt_qplib_rcfw *rcfw,
    478                                           struct bnxt_qplib_cmdqmsg *msg)
    479 {
    480         struct creq_qp_event *evnt = (struct creq_qp_event *)msg->resp;
    481         struct bnxt_qplib_crsqe *crsqe;
    482         unsigned long flags;
    483         u16 cookie;
    484         int rc = 0;
    485         u8 opcode;
    486 
    487         opcode = __get_cmdq_base_opcode(msg->req, msg->req_sz);
    488 
    489         rc = __send_message_basic_sanity(rcfw, msg, opcode);
    490         if (rc)
    491                 return rc == -ENXIO ? bnxt_qplib_map_rc(opcode) : rc;

The comments in bnxt_qplib_map_rc() talk about "firmware halt is detected"
and "this function will be called when FW already reports a timeout.
This would be possible only when FW crashes and resets."  The
__send_message_basic_sanity() function returns -ENXIO in the case of
ERR_DEVICE_DETACHED and it returns -ETIMEDOUT in the case of
FIRMWARE_STALL_DETECTED.

Based on the comments, I would have expected this test to be:

	if (rc)
		return rc == -ETIMEDOUT ? bnxt_qplib_map_rc(opcode) : rc;

Presumably the code is correct, but the comments are confusing.

    492 
    493         rc = __send_message(rcfw, msg);
    494         if (rc)
    495                 return rc;
    496 
    497         cookie = le16_to_cpu(__get_cmdq_base_cookie(msg->req, msg->req_sz))
    498                                 & RCFW_MAX_COOKIE_VALUE;
    499 
    500         if (msg->block)
    501                 rc = __block_for_resp(rcfw, cookie);
    502         else if (atomic_read(&rcfw->rcfw_intr_enabled))
    503                 rc = __wait_for_resp(rcfw, cookie);
    504         else
    505                 rc = __poll_for_resp(rcfw, cookie);
    506         if (rc) {
                ^^^^^^^^^
rc is checked here.

    507                 /* timed out */
    508                 dev_err(&rcfw->pdev->dev, "cmdq[%#x]=%#x timedout (%d)msec\n",
    509                         cookie, opcode, RCFW_CMD_WAIT_TIME_MS);
    510                 return rc;
    511         }
    512 
--> 513         if (rc) {
                ^^^^^^^^^
The patch adds some dead code.

    514                 spin_lock_irqsave(&rcfw->cmdq.hwq.lock, flags);
    515                 crsqe = &rcfw->crsqe_tbl[cookie];
    516                 crsqe->is_waiter_alive = false;
    517                 if (rc == -ENODEV)
    518                         set_bit(FIRMWARE_STALL_DETECTED, &rcfw->cmdq.flags);
    519                 spin_unlock_irqrestore(&rcfw->cmdq.hwq.lock, flags);
    520                 return -ETIMEDOUT;
    521         }
    522 
    523         if (evnt->status) {
    524                 /* failed with status */
    525                 dev_err(&rcfw->pdev->dev, "cmdq[%#x]=%#x status %#x\n",
    526                         cookie, opcode, evnt->status);
    527                 rc = -EFAULT;
    528         }
    529 
    530         return rc;
    531 }

regards,
dan carpenter
