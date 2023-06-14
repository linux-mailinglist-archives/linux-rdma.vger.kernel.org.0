Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636B273061D
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jun 2023 19:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237043AbjFNRhD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 14 Jun 2023 13:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236991AbjFNRhC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 14 Jun 2023 13:37:02 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BBDE43
        for <linux-rdma@vger.kernel.org>; Wed, 14 Jun 2023 10:37:01 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-3f9b1f43bd0so22179901cf.0
        for <linux-rdma@vger.kernel.org>; Wed, 14 Jun 2023 10:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1686764220; x=1689356220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6xKYAVP07Oz5iNqFwrvChWX0x9KqNqzcHfZ87gRJIy0=;
        b=EFJht9OKXXkYEP6jiolKvTqooMqXGCXLo2fud/j7t1KIVuTyPnStmr1KED9EgWmWDu
         5TNM4dAgaxemVJmvTgb/fSLe04YSu+Uw4KvrqgFW7JsqiJ/YZQKNvP7QNSClxsX2gVyT
         18EYvRlEDOmKgqS8eB4k4H2B2KwdAdGUshuesOcaXOPGiZY4qeIxaakwOZx8MlT/9ovr
         KUXO+6zQ8HL3UH3VRGxwZukBv89hX6eHr5FWqg0vj277BcnAUrajdhIcO2pDT2M8hbkp
         vTkKy4EOlIf6D/CgtV4GCO9oGSkxtegvcHUWJB9nS0EMFQrnVx5JLFftktUNutU6GT8H
         mz5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686764220; x=1689356220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6xKYAVP07Oz5iNqFwrvChWX0x9KqNqzcHfZ87gRJIy0=;
        b=g2MhCu3HhppzUDUCnfffcDus4jEuqLL4zqAALWyMN4HDPMedQwOGL91qM2doHWIHVS
         Y0DSKlkgwXUkDRZRFFvE02MXhgzksUBq0LrXMy1wjZWYfa15A++uh/+V2cOBP3LoRe2J
         JRykKeczdb92ZvmyWM+tZNCQL690XE3QcgtRYSnKMXSMFCQ7NYPFAXyf6irrjXeHpkez
         SsMc9inbz28eQw9PKMfm7AP/0N+zmsbUiszPkOhqiwFSiSKiahRpLMn9J0Fm9+jw1R01
         wX3IbtWcmth5kwJkYq6uPwRMGuEeHpKQn+/cHqG1xSytvCenPy0Znb/R3VV/7Fq5Pzpu
         fWzw==
X-Gm-Message-State: AC+VfDyHKYZ2KhFqgMmQxdTKAG/AgiaF3yCAyTjvKjwAxK9YA3tMJpYn
        tznyan7grCsrlhL+HExrG3GOnCvN3lOKjhIQ6Rg=
X-Google-Smtp-Source: ACHHUZ7E6ew2spjGbbhhB2SkcgvtaRZpjTLV4B/7F4iM53sx/zHT6e4DdwZyxrhamPyQRgQ53AZ7tA==
X-Received: by 2002:ac8:4e44:0:b0:3f4:cfed:96b5 with SMTP id e4-20020ac84e44000000b003f4cfed96b5mr2497106qtw.59.1686764220144;
        Wed, 14 Jun 2023 10:37:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id k14-20020ac8478e000000b003f543cbb698sm5187921qtq.23.2023.06.14.10.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 10:36:59 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1q9UQU-005AyX-Vk;
        Wed, 14 Jun 2023 14:36:58 -0300
Date:   Wed, 14 Jun 2023 14:36:58 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v2] RDMA/cma: prevent rdma id destroy during
 cma_iw_handler
Message-ID: <ZIn6ul5jPuxC+uIG@ziepe.ca>
References: <20230612054237.1855292-1-shinichiro.kawasaki@wdc.com>
 <ZIcpHbV3oqsjuwfz@ziepe.ca>
 <3x4kcccwy5s2yhni5t26brhgejj24kxyk7bnlabp5zw2js26eb@kjwyilm5d4wc>
 <ZIhvfdVOMsN2cXEX@ziepe.ca>
 <20230613180747.GB12152@unreal>
 <iclshorg6eyrorloix2bkfsezzbnkwdepschcn5vhk3m2ionxc@oti3l4kvv4ds>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <iclshorg6eyrorloix2bkfsezzbnkwdepschcn5vhk3m2ionxc@oti3l4kvv4ds>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 14, 2023 at 07:53:49AM +0000, Shinichiro Kawasaki wrote:
> On Jun 13, 2023 / 21:07, Leon Romanovsky wrote:
> > On Tue, Jun 13, 2023 at 10:30:37AM -0300, Jason Gunthorpe wrote:
> > > On Tue, Jun 13, 2023 at 01:43:43AM +0000, Shinichiro Kawasaki wrote:
> > > > > I think there is likely some much larger issue with the IW CM if the
> > > > > cm_id can be destroyed while the iwcm_id is in use? It is weird that
> > > > > there are two id memories for this :\
> > > > 
> > > > My understanding about the call chain to rdma id destroy is as follows. I guess
> > > > _destory_id calls iw_destory_cm_id before destroying the rdma id, but not sure
> > > > why it does not wait for cm_id deref by cm_work_handler.
> > > > 
> > > > nvme_rdma_teardown_io_queueus
> > > >  nvme_rdma_stop_io_queues -> chained to cma_iw_handler
> > > >  nvme_rdma_free_io_queues
> > > >   nvme_rdma_free_queue
> > > >    rdma_destroy_id
> > > >     mutex_lock(&id_priv->handler_mutex)
> > > >     destroy_id_handler_unlock
> > > >      mutex_unlock(&id_priv->handler_mutex)
> > > >      _destory_id
> > > >        iw_destroy_cm_id
> > > >        wait_for_completiion(&id_priv->comp)
> > > >        kfree(id_priv)
> > > 
> > > Once a destroy_cm_id() has returned that layer is no longer
> > > permitted to run or be running in its handlers. The iw cm is broken if
> > > it allows this, and that is the cause of the bug.
> > > 
> > > Taking more refs within handlers that are already not allowed to be
> > > running is just racy.
> > 
> > So we need to revert that patch from our rdma-rc.
> 
> I see, thanks for the clarifications.
> 
> As another fix approach, I reverted the commit 59c68ac31e15 ("iw_cm: free cm_id
> resources on the last deref") so that iw_destroy_cm_id() waits for deref of
> cm_id. With that revert, the KASAN slab-use-after-free disappeared. Is this
> the right fix approach?

That seems like it would bring back the bug it was fixing, though it
isn't totally clear what that is

There is something wrong with the iwarp cm if it is destroying IDs in
handlers, IB cm avoids doing that to avoid the deadlock, the same
solution will be needed for iwarp too.

Also the code this patch removed is quite ugly, if we are going back
to waiting it should be written in a more modern way without the test
bit and so on.

Jason

