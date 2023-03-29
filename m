Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB0B6CD24A
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Mar 2023 08:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjC2Gsl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Mar 2023 02:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjC2Gsk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Mar 2023 02:48:40 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C244B1722
        for <linux-rdma@vger.kernel.org>; Tue, 28 Mar 2023 23:48:39 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r29so14490043wra.13
        for <linux-rdma@vger.kernel.org>; Tue, 28 Mar 2023 23:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680072518;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LCSMUS6axtrcSTW2+KFEd+GUCyWv4kyb1ALKODCeiHU=;
        b=bGKZbtYplbjzePfjJCi8NtlV9UhFbiwIa3/SJGVqk2LRinmVZ5Z3RCVdRY1VSanZ8g
         5myGDE3v9syfggCiiKabx73ablQI61VJiCfGTLrN/Dgk+e43u6sOvj8AgJ9ZP5ZXiTS9
         6RZedvPDUcLqMrIVqDx8Oi9eIPLPYMq41fiLW1CtyRzjS//ozFPdAdxbQqI/VZMztULl
         1pSAR+2T8LSttv+Y0DFpa9WXW37DPwZ6tPTy3+QaV2ayqIH4LpnCU7qVth2FHT8vkce6
         CYdH0hqesgtrjxB9uZXz7sgh6fAhZPqgzFX9ldW7Mi/2nsmVdZfwUmo4siafVOEaC6MV
         TmEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680072518;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LCSMUS6axtrcSTW2+KFEd+GUCyWv4kyb1ALKODCeiHU=;
        b=4T6MMmU0R3DoTy1mmIURAXsrPxAh23QXHTIl0I8p0SXZnNO9iUZbnxW6Vz1aUBIu5Y
         cl2fkhL4RI2gx/txIDgXX0tTSvjFPk0ehNpPmN0WiYMoEeK7bBWDVxS6r24VMeaXfjX7
         GaioOkpc9iP4utbEZdcXJCc7r5SfxgOEdaH+FdLIzTH08FGAJaiAVluAkP1Ib7GzpYcs
         8iSkBeAkGWDzAKSbxdICzSvEHjM+41VbVIiULAmzvGeuCZ4hvU+g+HR5tNbIpsLjlhCC
         dTbD6AfdWOAEWHUWZ/6j07534o1zaLwUD5MvA8aWxymX2Sx94USl5fDOwYoZbXCL90/E
         JFSg==
X-Gm-Message-State: AAQBX9ckCGi1izhAkTpua1PZ9qOX5uJ75gyiF4f+eAciETKOnPzjIsac
        PHiOlC6Qws3/l1e2MhaioAs=
X-Google-Smtp-Source: AKy350ayS5lFUlaC1Mk27awZSZMjktEXKfL4bEEhXBsmUF6/5jLu58PqW4yJNBofX/LiJUSAogNs8g==
X-Received: by 2002:adf:ebcc:0:b0:2c7:d7c:7d0 with SMTP id v12-20020adfebcc000000b002c70d7c07d0mr861770wrn.22.1680072518274;
        Tue, 28 Mar 2023 23:48:38 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n30-20020a05600c501e00b003edc9a5f98asm1075814wmr.44.2023.03.28.23.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 23:48:37 -0700 (PDT)
Date:   Wed, 29 Mar 2023 09:48:34 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     rpearsonhpe@gmail.com
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [bug report] RDMA/rxe: Rewrite rxe_task.c
Message-ID: <8a054b78-6d50-4bc6-8d8a-83f85fbdb82f@kili.mountain>
References: <480b32b6-0f1c-4646-9ecc-e0760004cd24@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <480b32b6-0f1c-4646-9ecc-e0760004cd24@kili.mountain>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 29, 2023 at 09:27:26AM +0300, Dan Carpenter wrote:
> Hello Bob Pearson,
> 
> The patch d94671632572: "RDMA/rxe: Rewrite rxe_task.c" from Mar 4,
> 2023, leads to the following Smatch static checker warning:
> 
> 	drivers/infiniband/sw/rxe/rxe_task.c:24 __reserve_if_idle()
> 	warn: bitwise AND condition is false here
> 
> drivers/infiniband/sw/rxe/rxe_task.c
>     20 static bool __reserve_if_idle(struct rxe_task *task)
>     21 {
>     22         WARN_ON(rxe_read(task->qp) <= 0);
>     23 
> --> 24         if (task->tasklet.state & TASKLET_STATE_SCHED)
>                                          ^^^^^^^^^^^^^^^^^^^
> This is zero.  Should the check be == TASKLET_STATE_SCHED?
> 

The next function as well.

drivers/infiniband/sw/rxe/rxe_task.c:49 __is_done() warn: bitwise AND condition is false here

regards,
dan carpenter

