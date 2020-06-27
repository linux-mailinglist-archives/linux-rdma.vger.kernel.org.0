Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC3F20C4B1
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jun 2020 00:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbgF0WZa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 27 Jun 2020 18:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgF0WZa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 27 Jun 2020 18:25:30 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCFCC03E979
        for <linux-rdma@vger.kernel.org>; Sat, 27 Jun 2020 15:25:29 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id u8so6072970qvj.12
        for <linux-rdma@vger.kernel.org>; Sat, 27 Jun 2020 15:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B7GpCtb/sR/TjCdWqWZIsoVoP3af+VvPEeIrSBxtNwQ=;
        b=ALBY/7OwEiOqs4GU7y1mMMiUAO7d8R/zMkOaYa2sunQGk6iCtyuYONJshXcxOblkeS
         ke3ez/h975geKvV03lXJdffAbEq86yU6xL4sprCC9UROXEg6951nNjyLK2CWUOa6IiAT
         Nk8mhHzaY3Z9LI1hO4V2kpsHJtqSuc8mKGy29vA5ghe7uJrf8Jj6ILMQLPQTts5WLgsl
         HFJkR/MokZhuFeZNeeg5qzOBWUzgeCVOx/lwgb4MVis3LKwqUK1Jedy74CUw26JDcAVR
         7Mi2uoaGqNfImIjzSkLJQZ8Gn6lE/Eprr2FLOXvCr/KIcFU0ehlv7WzkRjH2eAZgBJHC
         h8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B7GpCtb/sR/TjCdWqWZIsoVoP3af+VvPEeIrSBxtNwQ=;
        b=qoZhs5c1NIPBC+UKe0aFx4/tGGiOKPho+bJixzZK7PQbo6d4+JTSbeHB2UySYo//JR
         13nRQE1o+n/2yqwZNS0ZJ7etIhA5ygY3fdb9Mhi8TMnYlBmUc0002cBuR+XELKPAEopf
         DaOnTLk8fZLGN191PdCvOtCqtoEYA6mLhbGqjQcliEyj5staGGVDkcEuImpTq0Vmv7b1
         6oJseh+OZP/XItVYEtBsE672BRVhUPMhGdmkjsNsPhXfZq1/cEPU7g0IJ0tOncW7Lb/D
         QodCrZrLRnMbAQP/r2eFoVa5uFG/557fE3kzTrxs7OqO5IDC0rqJ7QsdUWy3zsWzcQMi
         KAjQ==
X-Gm-Message-State: AOAM53032PLzF9BUYWEynSHTVgx1dFlg2Gsc1oo5yQqdhKiQONueOHkF
        Q/MQld+RGWaDDuCzeFs7DOXY8w==
X-Google-Smtp-Source: ABdhPJxlXMh1W9yDUlNTSm+3IU2P2JTP2cJj/PP3kid1a5TVpbuIyOC5ajObbm4cht3FuYpwxRv6kQ==
X-Received: by 2002:a0c:f281:: with SMTP id k1mr3159188qvl.219.1593296728910;
        Sat, 27 Jun 2020 15:25:28 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id 125sm3067882qkg.88.2020.06.27.15.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2020 15:25:28 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jpJGJ-000iUW-Gu; Sat, 27 Jun 2020 19:25:27 -0300
Date:   Sat, 27 Jun 2020 19:25:27 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+a929647172775e335941@syzkaller.appspotmail.com>,
        chuck.lever@oracle.com, dledford@redhat.com, leon@kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        parav@mellanox.com, Markus Elfring <Markus.Elfring@web.de>,
        syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in addr_handler (2)
Message-ID: <20200627222527.GC25301@ziepe.ca>
References: <000000000000107b4605a7bdce7d@google.com>
 <20200614085321.8740-1-hdanton@sina.com>
 <20200627130205.16900-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200627130205.16900-1-hdanton@sina.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jun 27, 2020 at 09:02:05PM +0800, Hillf Danton wrote:
> > So, to hit this syzkaller one of these must have happened:
> >  1) rdma_addr_cancel() didn't work and the process_one_work() is still
> >     runnable/running
> 
> What syzbot reported indicates that the kworker did survive not only
> canceling work but the handler_mutex, despite it's a sync cancel that
> waits for the work to complete.

The syzbot report doesn't confirm that the cancel work was actaully
called.

The most likely situation is that it was skipped because of the state
mangling the patch fixes..

> >  2) The state changed away from RDMA_CM_ADDR_QUERY without doing
> >     rdma_addr_cancel()
> 
> The cancel does cover the query state in the reported case, and have
> difficult time working out what's in the patch below preventing the
> work from going across the line the sync cancel draws. That's the
> question we can revisit once there is a reproducer available.

rdma-cm never seems to get reproducers from syzkaller

Jason
