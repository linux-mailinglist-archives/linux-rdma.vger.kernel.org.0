Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA47B40E96C
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Sep 2021 20:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345330AbhIPRyF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Sep 2021 13:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357670AbhIPRwH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Sep 2021 13:52:07 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32FF0C06115A
        for <linux-rdma@vger.kernel.org>; Thu, 16 Sep 2021 09:28:53 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id z12so4503827qvx.5
        for <linux-rdma@vger.kernel.org>; Thu, 16 Sep 2021 09:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Fdwa28QkrUk+ZMzYhJSldQN0VGRLNdcL9nebtWVtzLM=;
        b=E8D9bW787M1G4AJpW8OuL+X3ihQtbTfv0+KAkq2GaHxXbm58syya4/spFNQre1Y+nO
         Wd5iiVyl9haMfICfAqFi0lkL1HHDZ05Qz+MyRAL6IyNI05FjbltxRQsyXRLM0K2R43SK
         gNCMqIqf8IxTStJ2owd7dWzkBEy4QHY5YCyAVCnT3QCZkkTmpHphZjO3jpE9apbYvFBM
         RBXGBBQGCFnmc1y1YNwVOyPQFZSaEact8XLmstmR0q9obkRjeRKnzcCHCgc+29DlKv/H
         R8/+slepQNIuFIQL/FkmaSjqRDeCeeF9EERoZlTJIXn//KBdq+2eew9qPrWB+NL4dpGZ
         F1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Fdwa28QkrUk+ZMzYhJSldQN0VGRLNdcL9nebtWVtzLM=;
        b=fsfU60V/gBHyESth6AxEQTnfAuBg9gHmNeqjwiDjD34Va4uiBDYLaJooayj5n5fL6L
         z9ys1vcCnk6jF/Nu8QSkq/zr4JjkjmXbfycijvF6AFQL0OYzJuzeyKy9DZ/kl7EmpGLA
         izWxTcByCX62PQHH1JWVC0gGgpkMDlEKJPQGldvZHA2ZOI4eKMxgQx6jorn5VA4OP+ta
         tLVy+uX2UtXXhwWl8VpsH/6M75IHyQ04TQj0U9gnUo65C8bL0oBgv73XWIpGBNmpkTuF
         IYhGJYszDCrW7S2Ch4ffQjD+RwHl7VqdsTGb6fvLqHErEFtTmqGxL9Wh9N6WlxcfSul6
         6XDw==
X-Gm-Message-State: AOAM532c6KcwRN6BZGvX2WVtIoIcOlnhHfkJAVqyJSloWoEeBc8LQBwR
        fw5EsYtKRyQc1nyo/Gp6jSkL7g==
X-Google-Smtp-Source: ABdhPJybK6E/HepS1UuLw+FCS5jvfsBeslO2m1O08/qfO7f1wUmVEzQQ0rRAEfwv0BFo/nLtA+YRkQ==
X-Received: by 2002:a0c:f047:: with SMTP id b7mr6193496qvl.15.1631809732392;
        Thu, 16 Sep 2021 09:28:52 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id g13sm2752589qkk.110.2021.09.16.09.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 09:28:51 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mQuFn-001niQ-06; Thu, 16 Sep 2021 13:28:51 -0300
Date:   Thu, 16 Sep 2021 13:28:50 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+dc3dfba010d7671e05f5@syzkaller.appspotmail.com>,
        dledford@redhat.com, leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Aleksandr Nogikh <nogikh@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in addr_handler (4)
Message-ID: <20210916162850.GQ3544071@ziepe.ca>
References: <000000000000ffdae005cc08037e@google.com>
 <20210915193601.GI3544071@ziepe.ca>
 <CACT4Y+bxDuLggCzkLAchrGkKQxC2v4bhc01ciBg+oc17q2=HHw@mail.gmail.com>
 <20210916130459.GJ3544071@ziepe.ca>
 <CACT4Y+aUFbj3_+iBpeP2qrQ=RbGrssr0-6EZv1nx73at7fdbfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+aUFbj3_+iBpeP2qrQ=RbGrssr0-6EZv1nx73at7fdbfA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 16, 2021 at 04:45:27PM +0200, Dmitry Vyukov wrote:

> Answering your question re what was running concurrently with what.
> Each of the syscalls in these programs can run up to 2 times and
> ultimately any of these calls can race with any. Potentially syzkaller
> can predict values kernel will return (e.g. id's) before kernel
> actually returned them. I guess this does not restrict search area for
> the bug a lot...

I have a reasonable theory now..

Based on the ops you provided this FSM sequence is possible

RDMA_USER_CM_CMD_RESOLVE_IP
  RDMA_CM_IDLE -> RDMA_CM_ADDR_QUERY
  does rdma_resolve_ip(addr_handler)

			  addr_handler
			    RDMA_CM_ADDR_QUERY -> RDMA_CM_ADDR_BOUND
			    [.. handler still running ..]

RDMA_USER_CM_CMD_RESOLVE_IP
  RDMA_CM_ADDR_BOUND -> RDMA_CM_ADDR_QUERY
  does rdma_resolve_ip(addr_handler)

RDMA_DESTROY_ID
  rdma_addr_cancel()

Which, if it happens fast enough, could trigger a situation where the
'&id_priv->id.route.addr.dev_addr' "handle" is in the req_list twice
beacause the addr_handler work queue hasn't yet got to the point of
deleting it from the req_list before the the 2nd one is added.

The issue is rdma_addr_cancel() has to be called rdma_resolve_ip() can
be called again.

Skipping it will cause 'req_list' to have two items in the internal
linked list with the same key and it will not cancel the newest one
with the active timer. This would cause the use after free syndrome
like this trace is showing.

I can make a patch, but have no way to know if it is any good :\

Jason
