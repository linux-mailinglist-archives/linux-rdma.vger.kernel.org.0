Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B04507B9A
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Apr 2022 23:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357478AbiDSVEV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Apr 2022 17:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239065AbiDSVEV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Apr 2022 17:04:21 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DDD419B8
        for <linux-rdma@vger.kernel.org>; Tue, 19 Apr 2022 14:01:37 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id y129so6560543qkb.2
        for <linux-rdma@vger.kernel.org>; Tue, 19 Apr 2022 14:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5r7SFgFNzA0TC2wrx6HqDe0Mw1oqSt6xZdRykTYjQBY=;
        b=hgoPHYuB64XSYeKpkbMd6670P7/04BcnEb/vtIP06l9suF8IilSu3JXadzqnaa05ui
         2Bm34T0rhiLbJYQIjaJs0nnL/p4oGjtx0x4uNzWWhi+R5/1DK1qF3UGJJixOAczvXVli
         Z08Mi9yLlODE/8+hQPcmVHNxoxQ7hGBnsA+0S5Zjo2geP431RJqhSHltUZeBHgFJdxwp
         TZbfUllADXklXVpvDH5lVZzy1vatOlEzyQR0uElNKogQHvdlSmShW05NcZYeOFLZD9DY
         OOZ+bSD21z6eoV/soQWz0fj6ZWNY9weBB5IEsijBiAzL9BQnmc/EViGbQotT86xJyl3D
         hSjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5r7SFgFNzA0TC2wrx6HqDe0Mw1oqSt6xZdRykTYjQBY=;
        b=XjQmQfFaGJOiYYNcn6WoNpFY2aCG4EVj4CxeDD/7yUMhTYPlcw1iK2jPhLJ4WFfw/3
         WRiOemZKNI3psPSxAAKAhi/6YJNPuCSAlLCVbaOBCfoXehOoiMXxtcWv6Dd6jeA4G3BJ
         yn/Z9PJrFFLQTzN9AeOqFMFk+lm96SP89mY+oXe5eGWKX2zE5Tx7ZDgBP7HTukPY/Am1
         UtKDwNIpXXGZFPet62bYRcuxwBJeStYrB1nRRcva9pkHLUdymPzd1pX5uKvp2rudw6IL
         rt0EAUGMCcgDKmGEN8RvHWSDzZbSgSWILUGbjYsqiTrB1knn9ciirLEKJ4koFUadnLh3
         ky9A==
X-Gm-Message-State: AOAM532DfEJSeZGSM+Y1V8MT7EWfbvzX6uyeQfIhvyGlnQu6f27kV2KE
        HDQq00EZpXG+cg2NHnSoBb+jvw==
X-Google-Smtp-Source: ABdhPJx39xxUTCxY1fnO1aEHSG71Fnq/W9njLvqcyQqB0CuwJ19H2C0i/OUmABE8etXNvXAgV9UoMw==
X-Received: by 2002:a37:a8c3:0:b0:69e:5f25:3e60 with SMTP id r186-20020a37a8c3000000b0069e5f253e60mr10904173qke.58.1650402096769;
        Tue, 19 Apr 2022 14:01:36 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id c20-20020a05622a025400b002e1dd71e797sm728547qtx.15.2022.04.19.14.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 14:01:35 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nguyc-005gHQ-61; Tue, 19 Apr 2022 18:01:34 -0300
Date:   Tue, 19 Apr 2022 18:01:34 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Leon Romanovsky <leon@kernel.org>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] RDMA/core: Avoid flush_workqueue(system_unbound_wq) usage
Message-ID: <20220419210134.GO64706@ziepe.ca>
References: <0fadd34b-21cf-3a0d-a494-bde7b8dbc3ed@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fadd34b-21cf-3a0d-a494-bde7b8dbc3ed@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 18, 2022 at 10:30:47PM +0900, Tetsuo Handa wrote:
> Flushing system-wide workqueues is dangerous and will be forbidden.
> Replace system_unbound_wq with local ib_unbound_wq.

I don't really like this patch, the whole reason to get rid of
flushing the system_wq is due to unknowable interactions between work
on the queue. Creating a subsystem wide WQ is creating the same
problem, just in a microcosm.

The flush_work exists because of this:

> @@ -1602,7 +1604,7 @@ void ib_unregister_device_queued(struct ib_device *ib_dev)
>  	WARN_ON(!refcount_read(&ib_dev->refcount));
>  	WARN_ON(!ib_dev->ops.dealloc_driver);
>  	get_device(&ib_dev->dev);
> -	if (!queue_work(system_unbound_wq, &ib_dev->unregistration_work))
> +	if (!queue_work(ib_unbound_wq, &ib_dev->unregistration_work))
>  		put_device(&ib_dev->dev);
>  }

Which fires off a work that must be completed before the module is
unloaded.

It seems like a big waste to create an entire WQ just for a single
infrequent user like this.

Is there some other solution?

Jason
