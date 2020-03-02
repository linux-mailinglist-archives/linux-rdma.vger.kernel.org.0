Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7C37175DBD
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2020 15:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbgCBO7S (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Mar 2020 09:59:18 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:38183 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbgCBO7R (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Mar 2020 09:59:17 -0500
Received: by mail-il1-f196.google.com with SMTP id f5so9562282ilq.5
        for <linux-rdma@vger.kernel.org>; Mon, 02 Mar 2020 06:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sYkZC+H0cclejhwnu9ybKgEGURqGTDULgNJyOMe/aZs=;
        b=HdCEra2IzdfQAQEBA7Agqn/vJJa/CGaerdl9UrJGEi6izanHXQsrt/RuKJIkiac1Fv
         HHd8gPxzkzeXH35TOn9AZmvG/5Wm7jriHCBv0UW1Pdtf/MfhPRUoUvsK5h98tL1HH+JG
         lIV5MmCsnF4XFf37ufrpmKTXUH+sMeFx7a8/4EVc4Ly7vciXfDu0t/ijOk19sEWCrb3N
         gbmC6WcQ1zDdA7t7aeYbuqG20B+IEjmXmGQF9h4rF6e0vG9UfWudYWRxR5AMLWa/D2LT
         k45gtvTeizB7XsVpx03CAs9rrqV7AT9Tqcame9BMBcW4ApIp77OSIF/4jsmBWJylnu9p
         csaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sYkZC+H0cclejhwnu9ybKgEGURqGTDULgNJyOMe/aZs=;
        b=Nuzcdj3EnqbHgZ6CjcM10/X4geo4BIVEOI/lxZuG3pNsQR1Y+7BASEv4fjpz1/oq3a
         7StX+uRZSA6XEdLuQZzhoeNItgYHbeZLkwqfqz/y7lnCpg8Zt33C2aOIWRfy/5sclBNk
         qFry1GLKTY/lltfs9nTDOyIgj2J1+j4tQGCeDr40xGO6kc+Z3DZ/JViaT/vdnVsMbTvj
         rBvAg7pcUDsKfqSabwkhMaZz7aR6Cqltmf1oH/9IcAch3MEsnRSItXFFG3XKz0E9AKfh
         dmWKNolcwPvaP7PLO2cha1Sg2xbstMNjN/tmrZs+3ppG/iCzlJcNkiCKpVMg41g5wGcA
         17sA==
X-Gm-Message-State: ANhLgQ274rSq/QtiMC6UwvyoASUf11wNbymRvpcSTwECkCCDKP6QYbMb
        /TQ9QjU1l9fT/QXZNP098cwrb+nFN6QnSfYG7V2iKw==
X-Google-Smtp-Source: ADFU+vumyIWWKcoN+ffBvEV/Func4aa1zUSwHnUK9EmvZwaPhmcivVqZOJ/95Vk7oLaIEuf0IM/h35yvLCdVyAU5ywM=
X-Received: by 2002:a92:811c:: with SMTP id e28mr69574ild.22.1583161156724;
 Mon, 02 Mar 2020 06:59:16 -0800 (PST)
MIME-Version: 1.0
References: <20200221104721.350-1-jinpuwang@gmail.com> <20200221104721.350-17-jinpuwang@gmail.com>
 <6aa73b1c-b47a-c239-f8bb-33a44a3c4d97@acm.org>
In-Reply-To: <6aa73b1c-b47a-c239-f8bb-33a44a3c4d97@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 2 Mar 2020 15:59:06 +0100
Message-ID: <CAMGffEmSg_hdWjHSYREo4b_aESbwby_dTEMRVs6YBTbXSOEK5Q@mail.gmail.com>
Subject: Re: [PATCH v9 16/25] block/rnbd: client: private header with client
 structs and functions
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Roman Penyaev <rpenyaev@suse.de>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Mar 1, 2020 at 3:26 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-02-21 02:47, Jack Wang wrote:
> > This header describes main structs and functions used by rnbd-client
> > module, mainly for managing RNBD sessions and mapped block devices,
> > creating and destroying sysfs entries.
>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Thanks Bart!
