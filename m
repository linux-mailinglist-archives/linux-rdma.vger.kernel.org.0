Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC29962F8C4
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Nov 2022 16:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242064AbiKRPDy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Nov 2022 10:03:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235327AbiKRPDT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Nov 2022 10:03:19 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC07F976E7
        for <linux-rdma@vger.kernel.org>; Fri, 18 Nov 2022 07:00:59 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id bs21so9635300wrb.4
        for <linux-rdma@vger.kernel.org>; Fri, 18 Nov 2022 07:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L+6g7LDbOggoA49OprxaF4UaX30Eo5/HcGQ0G66tllQ=;
        b=ilftcP2zqQItLaZWEO2S5v1mKv4UTU8z+dXZdc1ZAtc7Dh8nth39gZ+5SXbmVFB+U/
         B3mgdTL4ga5zKaiVSi8GWOq4e9EZ2X+3wOyloTRTylRrfB5QRzr1w2GPi6ydZuaxTPHo
         +ioSLkwCFjXqFzrsV+BhN+BFgIU8eoioB88/6O5JcIWqF3lwtmcYLUHVyj8vpRJERgl5
         uykZoqpr+NhaNW434lh5RQdsSxlltxO2WLpOBQjmlTVGmnt9+nr2OvPlRQuLQ2GCpj0C
         zdfVd7SnkkzPfg4byqgtJopExMWJnQLcbRHMwTahSUlAik1JAnvNWiuJsLMsvulX7Shh
         ZFCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L+6g7LDbOggoA49OprxaF4UaX30Eo5/HcGQ0G66tllQ=;
        b=dq7COm9B+43IuyDTGBA1gpV5AKOVnumExjF+3KonK38+3skQusjgANKJHBP8val7XW
         NKrb2TLnK/GCILDBRfbry1DVrJ5jBHe2pXGxlW3PXY+yzQaLZ32LvIuNSsnZpTJqfs8L
         UgBZ8wtaAtqRloYfgLxEA1gz9Bn7VZytnkydX/aCjTT+/LKT9dOlO1wOzXvsv4TJyeVC
         TCoNaS27kVHB2Hmz7lB/eoihz6q34zVkH8uLysBjQMVLjHjs+C1saLGOtAN82m8SKcj1
         yrFHBvQS7+tSIt2Fsbc4YejSiEpVMIBQnrV405YZ95NzGRtpz5McjIXNRQvy0Vn+c6XW
         jF2g==
X-Gm-Message-State: ANoB5pkbkHr0SOFQzlom7fXF5cQ0NpaOuNZ6uIHd7dQlGuvwfEW0/57D
        jFIZsugapYnbBAv/1h9xe4w=
X-Google-Smtp-Source: AA0mqf7oX09D8GtN1uQukrwwHKQsmem60pzXF+e/fWciK0/jmg7AJ5XFX5H4vBXlpy9Xop0OK+8AzQ==
X-Received: by 2002:a5d:4844:0:b0:230:55fc:5de1 with SMTP id n4-20020a5d4844000000b0023055fc5de1mr4400264wrs.500.1668783658282;
        Fri, 18 Nov 2022 07:00:58 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o9-20020a056000010900b00228692033dcsm3682177wrx.91.2022.11.18.07.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 07:00:57 -0800 (PST)
Date:   Fri, 18 Nov 2022 18:00:53 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     rpearsonhpe@gmail.com
Cc:     linux-rdma@vger.kernel.org
Subject: [bug report] RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_mr.c
Message-ID: <Y3eeJW0AdyJYhYyQ@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello Bob Pearson,

This is a semi-automatic email about new static checker warnings.

The patch 2778b72b1df0: "RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in 
rxe_mr.c" from Nov 3, 2022, leads to the following Smatch complaint:

    drivers/infiniband/sw/rxe/rxe_mr.c:527 rxe_invalidate_mr()
    error: we previously assumed 'mr' could be null (see line 526)

drivers/infiniband/sw/rxe/rxe_mr.c
   525		mr = rxe_pool_get_index(&rxe->mr_pool, key >> 8);
   526		if (!mr) {
                    ^^^
"mr" is NULL.

   527			rxe_dbg_mr(mr, "No MR for key %#x\n", key);
                                   ^^
Dereference.

   528			ret = -EINVAL;
   529			goto err;

regards,
dan carpenter
