Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00BDA423D08
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Oct 2021 13:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238241AbhJFLny (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Oct 2021 07:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238201AbhJFLny (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 Oct 2021 07:43:54 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C8AC061749
        for <linux-rdma@vger.kernel.org>; Wed,  6 Oct 2021 04:42:02 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id j10so1623892qvl.13
        for <linux-rdma@vger.kernel.org>; Wed, 06 Oct 2021 04:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J86TuZ4G3iVJIsVauEFT8+kXi2wVJzDmB5U5QLNUL0A=;
        b=Z2LVqyyTR45/BiT7lotfv4icWapfnHzCPjTRcgJQpKIVj/rwOUNNyu9s7+CGdCb+Zh
         stkyoee3j+VGDefRiIKonL4IF0WrXwdtFGdfpywbnPMLe5XVo8XJkvzCuUxWhi8BulVe
         3Vrs1gZLwL1aWSCNajrPQvO0C61uxfbCBkltZ+jjix8z8o/JOCrSBK/k4vYA7CoKFcAM
         VGT7cgf5BQRj7tzxXG/QEw+RUVhsiWVUev8OCQtf3nnf5OFv00lw4gaD82q02zouSzOw
         etKDfAKfs1Pm+1fVLJU4CtAhGUa0RoAc0j5+bJ2nbWHl5drrHXA7SXduXqKr5dVL6NhB
         Votw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J86TuZ4G3iVJIsVauEFT8+kXi2wVJzDmB5U5QLNUL0A=;
        b=A4AI8IMBomcBwQxQW3yU7/WdxBHulWnqtiQ08xdu3j7+jcf3KZBorXr+WdMsrYVM4s
         Du6D+HtyQB9uTpQcmCBClcfuiI3wRjYnidZC29fAcNaPj7rhIHh5i7ZJA8b6usGmhqJC
         /iaIITDksl0MvR4Winda6e9zj3eWnHUOBoC6M2iUJctIYtcn7YjvAFQ+w8reHM3J2YhO
         D3JWOnwE+lx899LhflgWEQkkfQZnab8ouwco/3pS69Pf8C1ocOEf0PaWwkzQO0CM5gGL
         nEfrIR1GSkXxDusJuENXfptCLNlYpOE0piL+V1QCAhJvEMXtNgiO/oskwWW+zryNFp5a
         9QPQ==
X-Gm-Message-State: AOAM531OU005UvPp6gRpc+eq3wEgsEdVYvE4aNS4CAs4mvGmpiHSKJWH
        68CpOydVuSRd0VBjjpgtrZ/JhKLRh0zBNA==
X-Google-Smtp-Source: ABdhPJwPNIvPjpNbUbkDe5ZUZ+/p3TvX/Wg2CR+OPAHD6AhPhgJBOj8tPSL6nGvFuzVzLqIcI/bD1Q==
X-Received: by 2002:a0c:c1c9:: with SMTP id v9mr32898787qvh.31.1633520521408;
        Wed, 06 Oct 2021 04:42:01 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id p19sm225759qtk.20.2021.10.06.04.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 04:42:00 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mY5J9-00BRWH-W4; Wed, 06 Oct 2021 08:42:00 -0300
Date:   Wed, 6 Oct 2021 08:41:59 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+dc3dfba010d7671e05f5@syzkaller.appspotmail.com>,
        dledford@redhat.com, leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Aleksandr Nogikh <nogikh@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in addr_handler (4)
Message-ID: <20211006114159.GC2688930@ziepe.ca>
References: <000000000000ffdae005cc08037e@google.com>
 <20210915193601.GI3544071@ziepe.ca>
 <CACT4Y+bxDuLggCzkLAchrGkKQxC2v4bhc01ciBg+oc17q2=HHw@mail.gmail.com>
 <20210916130459.GJ3544071@ziepe.ca>
 <CACT4Y+aUFbj3_+iBpeP2qrQ=RbGrssr0-6EZv1nx73at7fdbfA@mail.gmail.com>
 <20210916162850.GQ3544071@ziepe.ca>
 <20211005032901.1876-1-hdanton@sina.com>
 <20211006031800.2066-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211006031800.2066-1-hdanton@sina.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 06, 2021 at 11:18:00AM +0800, Hillf Danton wrote:
> +++ b/drivers/infiniband/core/addr.c
> @@ -795,6 +795,11 @@ void rdma_addr_cancel(struct rdma_dev_ad
>  	 * guarentees no work is running and none will be started.
>  	 */
>  	cancel_delayed_work_sync(&found->work);
> +	/*
> +	 * flush is needed if work is queued again while it is running, as
> +	 * cancel waits nothing.
> +	 */
> +	flush_work(&found->work);

The _sync() above does the same, cancel doesn't return while the work
is running

Jason
