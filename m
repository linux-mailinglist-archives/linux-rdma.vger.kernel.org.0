Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28DD359F8D8
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Aug 2022 13:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236821AbiHXLvc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Aug 2022 07:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236272AbiHXLvc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 24 Aug 2022 07:51:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CA882D17;
        Wed, 24 Aug 2022 04:51:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0C8161965;
        Wed, 24 Aug 2022 11:51:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4146C433D7;
        Wed, 24 Aug 2022 11:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661341890;
        bh=MQHLAPHxwZoEhShjrCExL3cR38x99rl36T1mPKu0zhU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h0f2U2vXy/wN1zi0LZtjUj3FFYhDdW9gLLo3g1UcG43kc12LsZq9uwOL6O5fOdjPI
         wkSaQrnmRwKbbqgraDjzpPnUrlbc/MUlsD1VSYSrFtjAynUSw0gcitLC0SQZETzIKy
         d/jvdT0EDTDLEVvhGr+h0UNVGquXdBz3BOzxZcLapK2ckEXZ6B28Z6GhkCaAgU01G5
         r15/p1wHQ94rr7J+xetUmCkxwwNfmU95trB8+pih/YaKboNjrA3r8qajm5JiosmZAS
         mkrLPeazuAFwgvEo3x4s+MoJG8eYe+CZdLQOEiwCBDokgZr28uLF+aW5bBvKJ/5frl
         RMiLv7uB/9mSg==
Date:   Wed, 24 Aug 2022 14:51:26 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Niels Dossche <dossche.niels@gmail.com>
Cc:     cgel.zte@gmail.com, dennis.dalessandro@cornelisnetworks.com,
        jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] infiniband: remove unnecessary null check
Message-ID: <YwYQvm48ReVaFQ0v@unreal>
References: <20220824080503.221680-1-chi.minghao@zte.com.cn>
 <1ce29a1e-2db7-2953-b71e-c0408559ecff@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ce29a1e-2db7-2953-b71e-c0408559ecff@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 24, 2022 at 10:15:56AM +0200, Niels Dossche wrote:
> On 8/24/22 10:05, cgel.zte@gmail.com wrote:
> > From: Minghao Chi <chi.minghao@zte.com.cn>
> > 
> > container_of is never null, so this null check is
> > unnecessary.
> > 
> > Reported-by: Zeal Robot <zealci@zte.com.cn>
> > Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> > ---
> >  drivers/infiniband/sw/rdmavt/vt.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/drivers/infiniband/sw/rdmavt/vt.c b/drivers/infiniband/sw/rdmavt/vt.c
> > index 59481ae39505..b2d83b4958fc 100644
> > --- a/drivers/infiniband/sw/rdmavt/vt.c
> > +++ b/drivers/infiniband/sw/rdmavt/vt.c
> > @@ -50,8 +50,6 @@ struct rvt_dev_info *rvt_alloc_device(size_t size, int nports)
> >  	struct rvt_dev_info *rdi;
> >  
> >  	rdi = container_of(_ib_alloc_device(size), struct rvt_dev_info, ibdev);
> > -	if (!rdi)
> > -		return rdi;
> >  
> >  	rdi->ports = kcalloc(nports, sizeof(*rdi->ports), GFP_KERNEL);
> >  	if (!rdi->ports)
> 
> I believe this patch is incorrect because "_ib_alloc_device" may return a null pointer.
> Note that the first member of "rvt_dev_info" is "ib_device", so the check on container_of effectively checks if the allocation failed, which is necessary to check.

You are absolutely right, this container_of() and check later are done
on purpose. It is open-coded variant of ib_alloc_device(...) macro.

Thanks
