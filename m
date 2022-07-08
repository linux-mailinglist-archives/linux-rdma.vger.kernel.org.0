Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30DD356BAE5
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Jul 2022 15:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237832AbiGHNcE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Jul 2022 09:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238193AbiGHNcD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Jul 2022 09:32:03 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EF82E9F2
        for <linux-rdma@vger.kernel.org>; Fri,  8 Jul 2022 06:32:02 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id he28so27174945qtb.13
        for <linux-rdma@vger.kernel.org>; Fri, 08 Jul 2022 06:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wsa58acLb9FJR8TTPCXQeYDnsgN8lmjtz+zj1KGgfb4=;
        b=jZKVgU8jiQDqUiIu8Oe0ktu0bTi4UhnpD/oGgyWayg5eplowYzNjiuANXUZklTTdEP
         0rYOnZdG1OK4K8cH6sCj/VIfLse5j/9633cMvzbakfqDAXAaMWCPWopDv3idioZyGL4i
         uAmA8YAnzwtr/nqAI6OUitAZvjdpiiFoBEnchT1YFzY1ioY8i/LpJp0+IyFcn4B4rFd+
         V35jUq0Hv53pxBqtAhLZPn9UDfw+IKmqHeuOF3le9zor5nObxUVt2PKiJWkofaColxss
         yZjyrKyUK0GAddyQq8cyuXoUYTm4iZP5GRhT6UllN2SjEVH6BXPJcHf0inIHMt2SZ9Bc
         0W0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wsa58acLb9FJR8TTPCXQeYDnsgN8lmjtz+zj1KGgfb4=;
        b=syk/cTkaYRNgBu0+OdX4Rv0wPEAnzj5HKmlym0Ej1qYjr0EzXfvT8G/MAS8nlMQ29n
         gK5qZrzYCMpPwFqT6KBKd3vcH8CqXB98FgOGH/LHFg0VRvTC8mzJ2TaBhIhfcI6YY98c
         YBt/XXHaZO8IjkB9jAWo3t3vkp3D40MOE4qR1QUPpl+13VhZ4lRjziPPRC4VuhV5AMoQ
         IyLF2xYURyjMQZTQGAMymvPtuB+Uxvgc+sOalnXfPAp3irbLpV5SjESkKaibTNkeC+On
         iO3k6W0AVFF9oe2BizKnfC7un2jfUmTtOzxjZkAOY8PUdGFdQZ3OGktMSJBrwLlQw7OO
         SYEQ==
X-Gm-Message-State: AJIora+WAKVar3CTl4HU2+9wX0RCWNkba/x4yY+gmN+6j8YabHMjusmw
        J4PlAWqm7R3Xr/YjRjhcvCevxVqPiw8sRw==
X-Google-Smtp-Source: AGRyM1tE85dHDy3aPHNAQ23s6zJpa+hgSlvQEjzXK9JTyS2hzyVVwtdos4dY8AOCXMary/+CoGP4rQ==
X-Received: by 2002:a05:622a:2cf:b0:31b:ee23:3b62 with SMTP id a15-20020a05622a02cf00b0031bee233b62mr2935827qtx.412.1657287121203;
        Fri, 08 Jul 2022 06:32:01 -0700 (PDT)
Received: from ziepe.ca ([142.177.133.130])
        by smtp.gmail.com with ESMTPSA id n4-20020a05620a294400b006b24d912ab7sm20769692qkp.46.2022.07.08.06.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 06:32:00 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1o9o5Q-0001OC-28; Fri, 08 Jul 2022 10:32:00 -0300
Date:   Fri, 8 Jul 2022 10:32:00 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Md Haris Iqbal <haris.iqbal@ionos.com>
Cc:     linux-rdma@vger.kernel.org, leon@kernel.org, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: Re: [PATCH for-next 5/5] RDMA/rtrs-srv: Do not use mempool for page
 allocation
Message-ID: <20220708133200.GB4459@ziepe.ca>
References: <20220707142144.459751-1-haris.iqbal@ionos.com>
 <20220707142144.459751-6-haris.iqbal@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707142144.459751-6-haris.iqbal@ionos.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 07, 2022 at 04:21:44PM +0200, Md Haris Iqbal wrote:
> From: Jack Wang <jinpu.wang@ionos.com>
> 
> The mempool is for guaranteed memory allocation during
> extreme VM load (see the header of mempool.c of the kernel).
> But rtrs-srv allocates pages only when creating new session.
> There is no need to use the mempool.
> 
> With the removal of mempool, rtrs-server no longer need to reserve
> huge mount of memory, this will avoid error like this:
> https://www.spinics.net/lists/kernel/msg4404829.html

Use only lore.kernel.org links please

Jason
