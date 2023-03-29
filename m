Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA5C6CD212
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Mar 2023 08:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjC2G1d (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Mar 2023 02:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjC2G1c (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Mar 2023 02:27:32 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB1819C
        for <linux-rdma@vger.kernel.org>; Tue, 28 Mar 2023 23:27:31 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id j24so14515821wrd.0
        for <linux-rdma@vger.kernel.org>; Tue, 28 Mar 2023 23:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680071250;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3CfbpEIIrvOiPUvNg+LdcKBr1JjimTbsMfXYo2weXHM=;
        b=NRfjVWJIZHAh05aNQW03LmMsXp/Djazp/gXGuFEU7ArUeRjxhL0VEbZfyHP/I4VMai
         5H/daducjaEkEjuCN4GfeigeLIJntFqOKOegSmu3fr62qv2G/KKsrtbymDLMXvwHU+gJ
         kyya2o6HWDRNTbsGd+rffrcD0PSEY8YOVDGMTUtqaHatZGt915uI5bQBRzCBk73d9aQN
         1W1/NsKbIsq8gLkUqXkME1m4jHmjP4oTYcO+0JSj5u2zFU0wBqnER6zIkvQViNLtNfUQ
         rPOj78kSPYPLt9P4X+jqTI+svJDCZ8Yqz0IFPAHVs4IRZQsQSfuU0N35x5UWt2rbCKqs
         b1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680071250;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3CfbpEIIrvOiPUvNg+LdcKBr1JjimTbsMfXYo2weXHM=;
        b=ZmyYSiggflRJwPetAFqc+mhYa4iIdiJtS//LWRKnpM3kO86Xpam+u9WrAVHoGrg1ds
         +mZ0bPu+Lz6fDsOZ4J0RF66+JRAUQVTxtoU8xotCVo2Bf8rQmUr0WJXLFYAi2tOPU602
         Efj6PcDuU4jXHI2YDqQEiSPf8VGzZ1Xj/1slW3egAmcRB4j6lI81pZRn9oGgzB0Z92vT
         9g3BUs7OIGXOEJnK9qHBSEMKG0S257wLPX9jC2VKV1QS+V0iLn0m5fd1c8H6HUIjEZX+
         /FelYH2MCF9uApsmjj//ZD9WD1TDUjoI8Ija738JUBwCRD0S2J3dGBjFOaD37tjz3jv1
         amQQ==
X-Gm-Message-State: AAQBX9dawrEqFXqg2MMNiA4Ll0R+swrkAj/aYz00Bp9LjGZuA4OQLUpO
        Bvd6VjLvVli12IQvRJu2j3yuu5ar7VmCI33h
X-Google-Smtp-Source: AKy350YBRy0rX1kECZzV3izDuiX7nUns+BAMOWb55/R8ImdJ1DF4hrZydxlYJ72HEqh7f/IoaZrGqg==
X-Received: by 2002:a5d:4a46:0:b0:2d4:766d:e02f with SMTP id v6-20020a5d4a46000000b002d4766de02fmr14397990wrs.59.1680071250053;
        Tue, 28 Mar 2023 23:27:30 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id c15-20020adffb0f000000b002c6e8cb612fsm29129462wrr.92.2023.03.28.23.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 23:27:29 -0700 (PDT)
Date:   Wed, 29 Mar 2023 09:27:26 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     rpearsonhpe@gmail.com
Cc:     linux-rdma@vger.kernel.org
Subject: [bug report] RDMA/rxe: Rewrite rxe_task.c
Message-ID: <480b32b6-0f1c-4646-9ecc-e0760004cd24@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello Bob Pearson,

The patch d94671632572: "RDMA/rxe: Rewrite rxe_task.c" from Mar 4,
2023, leads to the following Smatch static checker warning:

	drivers/infiniband/sw/rxe/rxe_task.c:24 __reserve_if_idle()
	warn: bitwise AND condition is false here

drivers/infiniband/sw/rxe/rxe_task.c
    20 static bool __reserve_if_idle(struct rxe_task *task)
    21 {
    22         WARN_ON(rxe_read(task->qp) <= 0);
    23 
--> 24         if (task->tasklet.state & TASKLET_STATE_SCHED)
                                         ^^^^^^^^^^^^^^^^^^^
This is zero.  Should the check be == TASKLET_STATE_SCHED?

    25                 return false;
    26 
    27         if (task->state == TASK_STATE_IDLE) {
    28                 rxe_get(task->qp);
    29                 task->state = TASK_STATE_BUSY;
    30                 task->num_sched++;
    31                 return true;
    32         }
    33 
    34         if (task->state == TASK_STATE_BUSY)
    35                 task->state = TASK_STATE_ARMED;
    36 
    37         return false;
    38 }

regards,
dan carpenter
