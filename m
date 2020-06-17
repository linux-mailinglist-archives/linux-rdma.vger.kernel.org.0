Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1996C1FCB83
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2020 12:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgFQK5v (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Jun 2020 06:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbgFQK5u (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 Jun 2020 06:57:50 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30281C061573
        for <linux-rdma@vger.kernel.org>; Wed, 17 Jun 2020 03:57:50 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id n24so1854777ejd.0
        for <linux-rdma@vger.kernel.org>; Wed, 17 Jun 2020 03:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O+YfS0ttnLCfsNiE+e6ILMV8mORupQjGd84VFFvianI=;
        b=hq1X9t5NU9g+T8dqEMPWoeuhUYPrzb8ZUmYbMzwy4FI4rfrVVLdlFySkqTREG3PLI0
         wNVUGKOJ0OxjUvRg2ZBUobKmc+VBEVPWS+AEHaahxXnm7ZfKSYo/th/tRNSB5XQ3NpXP
         OdxD+wllo1sBFq+bhFbwUOZwsJu4qN6icSbcUD4RFAxNUIcitmewso6zYrJCTCo86QDd
         WP8Cx1+FKbZrF1FvSj5+GrtGT04ikVSD8iUhIMaHh0SslF7y6vlJ1v6QvlwqB1BITd61
         Tu8hZ3yonJ/wHqoCc5f5iFzL64k5Y6XKW9ZRbTBq1bZdMm4ZVuPkb8E3eQimd0oqyItS
         ZHdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O+YfS0ttnLCfsNiE+e6ILMV8mORupQjGd84VFFvianI=;
        b=UTn0Kt84TP1L4iSiEsVl+rRUBTCSUTWzmhP3AExCbsfBrNVIPesUOA5FXGsUmrsXEC
         bBjXQalcu0oRo4IFqvospqPzBIR+UCyreTAGp2h1jWmRYWmaoFsNAKRj7NdIN6A9P7XJ
         PLODqxVxRjQ864RslnRx8UaoyOkoWmIU1vmPPlYPu0ghTiKE37aBY6Vaw9lPfLUchf5l
         9Dlwsc733/o15dE16VbWxVAFZPViyDrbRzVWsujtnZcrXF3UOe0MHIPLMOr/EFPN64bK
         6ir9QhKyBKetbc3FOJmQs1l2C/U1d+0DGMWJRL9TD3Ld4bGZc/0yUCLlXR78PvQton3E
         s89A==
X-Gm-Message-State: AOAM532zx1Kp3UbTwVFzu+DR4jBFb7jcxPlenYOPo+fP7XQIiQ4YFKJ4
        e3LZWUJQKt/Wji+eO7RGpL4TbyRsxSkYOR0HZv+7tA==
X-Google-Smtp-Source: ABdhPJzP5nSfdYRuYpEBQ/kGmSwqj8HneuDENIWgcYcvcj33ZChZis6j7fB5yVbc7y6wZYu1jv0Oqs9v/fPP9L+hdIE=
X-Received: by 2002:a17:906:7802:: with SMTP id u2mr7177417ejm.478.1592391468871;
 Wed, 17 Jun 2020 03:57:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200617103732.10356-1-haris.iqbal@cloud.ionos.com>
In-Reply-To: <20200617103732.10356-1-haris.iqbal@cloud.ionos.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Wed, 17 Jun 2020 12:57:38 +0200
Message-ID: <CAMGffEnQ6acML7ze2dC6PH5m3E6gy00ohsWf=cQQOFG-NNUWvw@mail.gmail.com>
Subject: Re: [PATCH] Delay the initialization of rnbd_server module to
 late_initcall level
To:     haris.iqbal@cloud.ionos.com
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        kernel test robot <rong.a.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Haris,

Thanks for patch, a few comments inline
On Wed, Jun 17, 2020 at 12:37 PM <haris.iqbal@cloud.ionos.com> wrote:
>
> From: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
>
> Fixes: 2de6c8de192b ("block/rnbd: server: main functionality")
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Signed-off-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
This part should be the last after commit message.
The subject sounds better maybe: block/rnbd: Delay the initialization
of rnbd_server module to late_initcall level
>
> The rnbd_server module's communication manager initialization depends on the
> registration of the "network namespace subsystem" of the RDMA CM agent module.
> As such, when the kernel is configured to load the rnbd_server and the RDMA
> cma module during initialization; and if the rnbd_server module is initialized
> before RDMA cma module, a null ptr dereference occurs during the RDMA bind
> operation.
would be better to include the call trace here.
> This patch delays the initialization of the rnbd_server module to the
> late_initcall level, since RDMA cma module uses module_init which puts it into
> the device_initcall level.

With the comments addressed:
Acked-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> ---
>  drivers/block/rnbd/rnbd-srv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
> index 86e61523907b..213df05e5994 100644
> --- a/drivers/block/rnbd/rnbd-srv.c
> +++ b/drivers/block/rnbd/rnbd-srv.c
> @@ -840,5 +840,5 @@ static void __exit rnbd_srv_cleanup_module(void)
>         rnbd_srv_destroy_sysfs_files();
>  }
>
> -module_init(rnbd_srv_init_module);
> +late_initcall(rnbd_srv_init_module);
>  module_exit(rnbd_srv_cleanup_module);
> --
> 2.25.1
>
