Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 340431FD449
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2020 20:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgFQSUv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Jun 2020 14:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727805AbgFQSUt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 Jun 2020 14:20:49 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76C1C06174E
        for <linux-rdma@vger.kernel.org>; Wed, 17 Jun 2020 11:20:49 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id b7so2553287pju.0
        for <linux-rdma@vger.kernel.org>; Wed, 17 Jun 2020 11:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/F7REkPrgeXXvQ0zNlTC/5dXxmcC09g58BpZtoxKLoQ=;
        b=U0/zqPyi/8oXSh6aamKeKQiCjOZ0AvF6r5lpUqnkBgYEk0dlOfa8cDYUhk3i2PcXB3
         cAcSbtsS5Ma6bpU4S6hqmeoFc1Mzw09KtWIfZ6xWs+zBKVjaMlF3/iaLr1N8g4ZOwoSB
         kiKijZzdBxPDdAN69Vxks4XVwMCrfI/x1lWfUhdq4n79BVcYbGpcrrUFjiQ7eUi/dK2t
         5RrcXJ9cX5DuwStBATY92eUjTl7EFKKquMJ2HPo0IF9tpeQT2oKFzeXYZXwSeAQE284l
         GbYY44PzQUBy6uu+h3mOAID+o3AvhEhQT1Q60MXKB91PjjsyFZnopnlzbaS28P+5KsqL
         puaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/F7REkPrgeXXvQ0zNlTC/5dXxmcC09g58BpZtoxKLoQ=;
        b=uPNGx7j7Y6DI63NuitTdSNhTKeidlojxW2KFvRnxgP4FtzmdpYdSVhHUKx/Rx9hLO7
         PZu7NUqi1TXAgiXoGkTaLbpI+/tlCs8nz7K6MGPInN6yuRFg3y/mbRBT/XmXYlWJXsRe
         Rhqy7tDB7X3waDDqiVuofOs7HXGaHmIwfciC1Qml6yM602fOuBgX1qMgx0SJcRGV2v/j
         DDjqj60ltiRGdVDulHU+jBEp1gXOsy5EqYX+siJMIFN8KFzABDlAaITgzggQbqDJixf6
         TZ0NyR0JLfOX6ad8LO8OeGW/UqhQVjK5itO89SKPGP4Cf3gznG6jnphWClsdQ4rqtXEk
         dKrA==
X-Gm-Message-State: AOAM533r+LPmrqDcqUI6iv+HvU61Km0Ih3n8LM4LydXe+0FESALaSOtE
        UiLA6c8wG/1aqdkjle92oIAWnw==
X-Google-Smtp-Source: ABdhPJy5Sbz1FV1SOlfn4yS8ZBiNWRRiJ9tN4izIrjMQpz9k3iJyajwK1iRNPVVbokwgydvo6yR7TQ==
X-Received: by 2002:a17:90a:65c5:: with SMTP id i5mr301551pjs.155.1592418049249;
        Wed, 17 Jun 2020 11:20:49 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id u14sm527381pfk.211.2020.06.17.11.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 11:20:48 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jlcg2-009iGN-Nv; Wed, 17 Jun 2020 15:20:46 -0300
Date:   Wed, 17 Jun 2020 15:20:46 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     haris.iqbal@cloud.ionos.com, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, dledford@redhat.com,
        kernel test robot <rong.a.chen@intel.com>
Subject: Re: [PATCH] Delay the initialization of rnbd_server module to
 late_initcall level
Message-ID: <20200617182046.GI6578@ziepe.ca>
References: <20200617103732.10356-1-haris.iqbal@cloud.ionos.com>
 <20200617112811.GL2383158@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617112811.GL2383158@unreal>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 17, 2020 at 02:28:11PM +0300, Leon Romanovsky wrote:
> On Wed, Jun 17, 2020 at 04:07:32PM +0530, haris.iqbal@cloud.ionos.com wrote:
> > From: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> >
> > Fixes: 2de6c8de192b ("block/rnbd: server: main functionality")
> > Reported-by: kernel test robot <rong.a.chen@intel.com>
> > Signed-off-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> >
> > The rnbd_server module's communication manager initialization depends on the
> > registration of the "network namespace subsystem" of the RDMA CM agent module.
> > As such, when the kernel is configured to load the rnbd_server and the RDMA
> > cma module during initialization; and if the rnbd_server module is initialized
> > before RDMA cma module, a null ptr dereference occurs during the RDMA bind
> > operation.
> > This patch delays the initialization of the rnbd_server module to the
> > late_initcall level, since RDMA cma module uses module_init which puts it into
> > the device_initcall level.
> >  drivers/block/rnbd/rnbd-srv.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
> > index 86e61523907b..213df05e5994 100644
> > +++ b/drivers/block/rnbd/rnbd-srv.c
> > @@ -840,5 +840,5 @@ static void __exit rnbd_srv_cleanup_module(void)
> >  	rnbd_srv_destroy_sysfs_files();
> >  }
> >
> > -module_init(rnbd_srv_init_module);
> > +late_initcall(rnbd_srv_init_module);
> 
> I don't think that this is correct change. Somehow nvme-rdma works:
> module_init(nvme_rdma_init_module);
> -> nvme_rdma_init_module
>  -> nvmf_register_transport(&nvme_rdma_transport);
>   -> nvme_rdma_create_ctrl
>    -> nvme_rdma_setup_ctrl
>     -> nvme_rdma_configure_admin_queue
>      -> nvme_rdma_alloc_queue
>       -> rdma_create_id

If it does work, it is by luck.

Keep in mind all this only matters for kernels without modules.

Maybe cma should be upgraded to subsystem_init ? That is a bit tricky
too as it needs the ib_client stuff working

Jason
