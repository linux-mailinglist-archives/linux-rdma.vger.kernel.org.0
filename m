Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4D7536301
	for <lists+linux-rdma@lfdr.de>; Fri, 27 May 2022 14:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240235AbiE0Mwh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 May 2022 08:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345453AbiE0Mwd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 May 2022 08:52:33 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2537322288
        for <linux-rdma@vger.kernel.org>; Fri, 27 May 2022 05:52:33 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id x7so5240296qta.6
        for <linux-rdma@vger.kernel.org>; Fri, 27 May 2022 05:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DZg9xbU9yxm1xo3qkZ8efM5ifvw3Vhad1pHzBVlG+v4=;
        b=c8rxJq9OvPEKNxx0OsdTOP5PeIHfaLQkyOrsfMAukNcx3KdZBfPHq4EHCd3GzT7EkG
         rfDaKsshKLY4QF8JNCF6rIHWwDn0keL+VmJ6HQeSnw6AUBOvRIetbCSF+G1EM2xMQLQ5
         GoERoG81+Qb9c4okmPjnZIsYQQb7ULxkg/2myXfNNp8dkb19UZc4gUfYy9urR88FDNBT
         CjrK29poJXql55I3ofCKqznBn9m752tBucxlkIkers0jEoS1gCC7sUXsMfE/nnMHfY+V
         0cnGGKfVSN+z5yYAE8p3CO+3bD5XjsJKsrdEh9EoNZr+Fp7OA+hbozFXjD4RJ1tToij/
         8TqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DZg9xbU9yxm1xo3qkZ8efM5ifvw3Vhad1pHzBVlG+v4=;
        b=O7D3Q+Bbr3DcMxWzEJip4DR3MrwIVPhKgh1eBIKyTjLxaDD6x68gicDWmLFRoD8Yv7
         m8sPrcdfgNVz4DWasM1GD66gXdGqegZr1KlTk+hqgvvvRhsavLvnrAi9vZkZYRjt8fkF
         q8px1G+HiSmIKriZ1ovBmAhtDk6G9MLlmUGdKMJZCvT/u4kbEK6w0PCkWIPVvxKM11sH
         d/JcVpv3OSfaLkkL8eZ8mFgxcjpwteDWtSNRnW8BAtZsUSodyVfn9eBKcsxolKBS89Lx
         xkXoZkXwFhEE/JUPlWAYG2h60v3qLBQAFYJ5aTOycDxu+5riVG9oq1FskFoMrK8Kfrzl
         wruA==
X-Gm-Message-State: AOAM533C5BxLHEfxKoQ6EqXeMkqx0zdqcVy76mexiXLZSc8b9i1B9PcQ
        RUrcnL3fpdSPTcwmToeVyAW9ng==
X-Google-Smtp-Source: ABdhPJy9KUyIkr0thNdUR4pH5z2yU7qc34AvvkaLcG+UoNOzPuO+lRTxBz4xqGYInakIxnK5+bG0GQ==
X-Received: by 2002:a05:622a:1455:b0:2f9:3278:e95c with SMTP id v21-20020a05622a145500b002f93278e95cmr21944422qtx.297.1653655951920;
        Fri, 27 May 2022 05:52:31 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id h18-20020ac846d2000000b002fbf0114477sm2473601qto.3.2022.05.27.05.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 05:52:31 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nuZS9-00DTV9-86; Fri, 27 May 2022 09:52:29 -0300
Date:   Fri, 27 May 2022 09:52:29 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Subject: Re: [bug report] WARNING: possible circular locking at:
 rdma_destroy_id+0x17/0x20 [rdma_cm] triggered by blktests nvmeof-mp/002
Message-ID: <20220527125229.GC2960187@ziepe.ca>
References: <CAHj4cs93BfTRgWF6PbuZcfq6AARHgYC2g=RQ-7Jgcf1-6h+2SQ@mail.gmail.com>
 <13441b9b-cc13-f0e0-bd46-f14983dadd49@grimberg.me>
 <4f15039a-eae1-ff69-791c-1aeda1d693df@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f15039a-eae1-ff69-791c-1aeda1d693df@acm.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 25, 2022 at 08:50:52PM +0200, Bart Van Assche wrote:
> On 5/25/22 13:01, Sagi Grimberg wrote:
> > iirc this was reported before, based on my analysis lockdep is giving
> > a false alarm here. The reason is that the id_priv->handler_mutex cannot
> > be the same for both cm_id that is handling the connect and the cm_id
> > that is handling the rdma_destroy_id because rdma_destroy_id call
> > is always called on a already disconnected cm_id, so this deadlock
> > lockdep is complaining about cannot happen.
> > 
> > I'm not sure how to settle this.
> 
> If the above is correct, using lockdep_register_key() for
> id_priv->handler_mutex instead of a static key should make the lockdep false
> positive disappear.

That only works if you can detect actual different lock classes during
lock creation. It doesn't seem applicable in this case.

Jason
