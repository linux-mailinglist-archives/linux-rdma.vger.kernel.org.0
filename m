Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA8452A570
	for <lists+linux-rdma@lfdr.de>; Tue, 17 May 2022 16:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235474AbiEQOzt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 May 2022 10:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234363AbiEQOzs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 May 2022 10:55:48 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD026450
        for <linux-rdma@vger.kernel.org>; Tue, 17 May 2022 07:55:47 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id x9so14478230qts.6
        for <linux-rdma@vger.kernel.org>; Tue, 17 May 2022 07:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IsDT96uuhf7nyppj8zvugtjw7RG1HmI2I830Jo/moK0=;
        b=g/ddfIx/M0XAQNAp1RuI5PG87ottgVTx7WiAGzn6F/qQ626tihkSifGyq5YsO/poH9
         JPeu6w1MYifi5hxoxfBOwIy3GN8KASPUEXzwRepLH8Z/I1Km4SO4bJAQOlHp89FnRSQ3
         jhFFAlbiIK9dUCGvjuK9ME5vIW4hxuircI/GS8M+zGTyIqSEE7HOpegwtCIPBtRvgGYG
         kPfavV4QBZASM8upBbykoV+SOMHQtLu1VvBtWBsTQkSKnzt79Um/Lw1hpxsJazDlpGLs
         Ywr+XnLXKSnPSWMYjsor+pdQB4guxC0XNlIVS1iTmxS3RN9uNXpXTYOJn7Q8ODgYPc6h
         3f1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IsDT96uuhf7nyppj8zvugtjw7RG1HmI2I830Jo/moK0=;
        b=kzZmLLiGeUBwY1NcfcWFSTdkLxXYMreXxIkFnioQHS5BPdyr6uzs/FxCE2ZoBlq2E3
         gfvdj35oEsmxTUjpiTn5xN5ZDbb6kUpZWI5P9ZpuVQEgQEzi1MOH39clzbY3Pr88NsN6
         QZSE7JhU6bURnASLJPlySfkmVuZGg3g/50MtAMxglJyDepJSkAD2rmCAnbgLV7z48Mb7
         jHpee0RLmDN/D1MRmVR6JvdMcjcbiSfGVReJ5LGvpCPyXPx4fBdvrLWzCDFeHFx9UE+B
         wRltrmRGK4VkBPxv7UoCOLq3ZJChjehvOj9xOoFkxe2N4B2tyFJD7lFaKtq4GWdydw/D
         iBYg==
X-Gm-Message-State: AOAM532/tbByti8tRUCTWP04DC66lVfGJh87JKlXtT5dabHo3iqs2gZr
        57MqaHdG0ExSwlVdNsw7esYseQ==
X-Google-Smtp-Source: ABdhPJwnuRPQ9aBY5WpGgpS3X+QlkHSlu6b4kw53iHNXlxB5IzPOdarGJkcg2AuR7cjVn9GHCh1+tA==
X-Received: by 2002:a05:622a:1ba6:b0:2f3:c49f:49f9 with SMTP id bp38-20020a05622a1ba600b002f3c49f49f9mr20222453qtb.586.1652799346612;
        Tue, 17 May 2022 07:55:46 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id cg5-20020a05622a408500b002f77a8bc37fsm5207986qtb.51.2022.05.17.07.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 07:55:46 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nqybx-0084Pi-7W; Tue, 17 May 2022 11:55:45 -0300
Date:   Tue, 17 May 2022 11:55:45 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     yanjun.zhu@linux.dev, leon@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/1] RDMA/rxe: Compact the function
 free_rd_atomic_resource
Message-ID: <20220517145545.GG63055@ziepe.ca>
References: <20220517190800.122757-1-yanjun.zhu@linux.dev>
 <c9e99081-f6aa-0167-77ff-57533b107e90@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9e99081-f6aa-0167-77ff-57533b107e90@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 17, 2022 at 09:51:44AM -0500, Bob Pearson wrote:
> On 5/17/22 14:08, yanjun.zhu@linux.dev wrote:
> > From: Zhu Yanjun <yanjun.zhu@linux.dev>
> > 
> > Compact the function and move it to the header file.
> I have two issues with this patch.
> 
> There is no advantage of having an inline function in a header file
> that is only called once. The compiler is perfectly capable of (and does)
> inlining a static function in a .c file if only called once. This just
> makes the code harder to read.

That is only if the function is static in the compilation unit, in
this case the only call site is in a different compilation unit

That still doesn't excuse putting it in a header file, but it does
suggest it could be just moved and made static.

> There is a patch in for-rc that gets rid of read.mr in favor of an rkey.
> This patch is out of date.

You are resending that with some fix?

Jason
