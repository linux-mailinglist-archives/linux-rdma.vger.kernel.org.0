Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082F86CBDD6
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Mar 2023 13:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjC1Leo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Mar 2023 07:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjC1Len (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Mar 2023 07:34:43 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C51D59E9
        for <linux-rdma@vger.kernel.org>; Tue, 28 Mar 2023 04:34:43 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id x8so8851104qvr.9
        for <linux-rdma@vger.kernel.org>; Tue, 28 Mar 2023 04:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1680003282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OSfwlUZYOoz8n4I0WLOBkvY1LHmUdAXbVHIvUT7be14=;
        b=Uab/ta7+bMAUBmhH+T2jwfXe1aoDUVIJW7NjIazSbZTfY+XpG/Smbai3B1nEB11C9D
         3ceRhu3ZAwxbyNaHhGv/OIXRitojsCftiSPJhUEfpq0dngbgCl5FiG2Gg+v6o1kCYla/
         9qKrpodu5OVWNmlDWRu7VPgSODS0dUsKwC7e9V34HQL9GnpKfNMHHCDc1iyMHRh/cSaI
         iXXTdnobIPsxd8L0TYzYdmj3VHBC+KrgLY8QXpwu2XK+WQ8y2+czcKKSEJRDGK6vnMMu
         RXKV9usecXLlkVyAnLOqmigHfDpiqmfaZUg99b+TZs7xxoQRM/0af8Q1UQeHye0Y8PT0
         8Fvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680003282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OSfwlUZYOoz8n4I0WLOBkvY1LHmUdAXbVHIvUT7be14=;
        b=1tOXXqfmvyfKzBsu3EeltsTtZd4ZYsDNWOi4iFDz/REpjfatUerQ1pzn5omiHgGfbM
         3w3BinMZMmOXXWVaju6pXO8fygsDuYlbsHwyyDx79sjvO9bH5zTR84N+AXo239eqfuHl
         2HLFvuf6/DsC9Ajj2iUGHnBeW0IdpVS34bLwe4EpBTnmFz8C86pQr3njTtJyVqo0Atzy
         gEy9TE2d3ipHSnXZHh7lYNBgYpafNvc4mYa2ELL4y7/giklpwTzmjpnaweIkIVnj5VGd
         GIKC+bDwee0rFJVn3qEOupaO/DzU9qpmwHbosJ2n3KtVFT10eRQL9Eq81RhOXCArNURJ
         2uWg==
X-Gm-Message-State: AAQBX9cbygB+pdbimInaSWLDLsdVDVj/gvSi75yvWJ+w0vTWLjXX/TIG
        y8gIOQmGFUYbtVqifagX6BTpYg==
X-Google-Smtp-Source: AKy350YwSQgfFcVackswaCg6JjhyDlAfgP+/Sz6yCpRBtScWxRy0f0EjPPpjMVYajD9efCCg+dzuEw==
X-Received: by 2002:a05:6214:ac4:b0:5a1:d44:79a7 with SMTP id g4-20020a0562140ac400b005a10d4479a7mr27710700qvi.20.1680003282094;
        Tue, 28 Mar 2023 04:34:42 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id mb4-20020a056214550400b005ddd27e2c0asm3107387qvb.36.2023.03.28.04.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 04:34:41 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1ph7b7-003j4K-2j;
        Tue, 28 Mar 2023 08:34:41 -0300
Date:   Tue, 28 Mar 2023 08:34:41 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Bernard Metzler <bmt@zurich.ibm.com>,
        Leon Romanovsky <leon@kernel.org>,
        Ursula Braun <ubraun@linux.ibm.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] RDMA: don't ignore client->add() failures
Message-ID: <ZCLQ0XVSKVHV1MB2@ziepe.ca>
References: <0e031582-aed6-58ee-3477-6d787f06560a@I-love.SAKURA.ne.jp>
 <ZCLOYznKQQKfoqzI@ziepe.ca>
 <a9960371-ef94-de6e-466f-0922a5e3acf3@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9960371-ef94-de6e-466f-0922a5e3acf3@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 28, 2023 at 08:33:21PM +0900, Tetsuo Handa wrote:
> On 2023/03/28 20:24, Jason Gunthorpe wrote:
> > On Tue, Mar 28, 2023 at 07:52:32PM +0900, Tetsuo Handa wrote:
> >> syzbot is reporting refcount leak when client->add() from
> >> add_client_context() fails, for commit 11a0ae4c4bff ("RDMA: Allow
> >> ib_client's to fail when add() is called") for unknown reason ignores
> >> error from client->add(). We need to return an error in order to indicate
> >> that client could not be added, otherwise the caller will get confused.
> >>
> >> Reported-by: syzbot <syzbot+5e70d01ee8985ae62a3b@syzkaller.appspotmail.com>
> >> Link: https://syzkaller.appspot.com/bug?extid=5e70d01ee8985ae62a3b
> >> Fixes: 11a0ae4c4bff ("RDMA: Allow ib_client's to fail when add() is called")
> >> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> >> ---
> >>  drivers/infiniband/core/device.c | 10 +++++-----
> >>  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > This doesn't make any sense, you need to explain what "caller will get
> > confused" actually means
> 
> The caller cannot perform cleanup upon error, which in turn manifests as
> "unregister_netdevice: waiting for DEV to become free" message.
> Please check https://lkml.kernel.org/r/710ef3ef-cd0a-5630-a68f-628d123180bf@I-love.SAKURA.ne.jp .

Describe exactly where the "cannot perform cleanup upon error" is.

Jason
