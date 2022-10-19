Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718406045DD
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Oct 2022 14:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbiJSMvG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Oct 2022 08:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233438AbiJSMuM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Oct 2022 08:50:12 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238561ABEDA
        for <linux-rdma@vger.kernel.org>; Wed, 19 Oct 2022 05:32:32 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id 8so10552646qka.1
        for <linux-rdma@vger.kernel.org>; Wed, 19 Oct 2022 05:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WtqGhN2x31LMvoAGlLXDx0UOPEjQMsNNUFgvnCFlu4g=;
        b=Qzk00Wu8aHMAi15aYjXcq+/hg5WG/vRa5y9sESfQ6+nIlneGVWeLs62z31qFPFh6Ox
         6eYjPYWEr6Xh79UJ3T4PbKjnKaj5kGzU9ByfoN6bq6wJVRhCwmxZgVtReHDhxt1Qa6EH
         ipEpzQv2MFixUWQ3EhsymwWe3+MFJ4q1cB3TGdF537KBJnyRlenKnI5ymSEUuzXcZcb9
         Wn+y5AW+dcbmXqWHBqRoExf+vmPxfJCwcVZno7oIgy6eMFbxhVvLvxgE+yGNkJTE0x4r
         aBahC6eAW1pNtif3I0m55d2Q6+3FTpNI8d95blZOxQMH8ZjfDwOBj9hpfO9FNYLmbW38
         QpIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WtqGhN2x31LMvoAGlLXDx0UOPEjQMsNNUFgvnCFlu4g=;
        b=iujhAX2g77Y2AbwURzoQw9bH2ULA1lVmyf9Tb/epJC4mSj923p/PtuD5FDUJgCZWBF
         mjR9bWJSwRTvDF7K0ePIj212rTHCZ0r3h2jBtyF48IcMFpgStzoh2LHz3yKOABDh+khu
         SYkGOmg86SXfitAi2jh8aPIAzuBL0Is0c2eBYrtPaNSjGv/IHTyipiy2B5vO155UIMN2
         CyHZz0Lu48JmQtTPSzEKErhV0c7j0D0EN5LKEX2/WWgBzMf4qYc3ZR+bKPP9xNg1jHdU
         55NTeaXk5j2otyQUErTL8qA9fgY3rCOkgzcwtTdafAmgR7kXfvqwU/cYnHF1CcvYzNFq
         VTCw==
X-Gm-Message-State: ACrzQf1yW0JaLvWNCTyTbgEihdGK1ZN0MgqbRWPoVM7w0TC1AdD38E56
        4KkNNLJIh+LZR73hU/FF6A1bibKR0P592w==
X-Google-Smtp-Source: AMsMyM6ac17ghMxYAeQ2BR+MEIe+BFo9U8R3l+l7TN5b7C17ylqS4rVh8U0pbqFf2omljNgG3Utv9Q==
X-Received: by 2002:ac8:4e41:0:b0:39c:f205:f954 with SMTP id e1-20020ac84e41000000b0039cf205f954mr5925568qtw.134.1666180539099;
        Wed, 19 Oct 2022 04:55:39 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-122-23.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.122.23])
        by smtp.gmail.com with ESMTPSA id ch8-20020a05622a40c800b0039cc82a319asm3851804qtb.76.2022.10.19.04.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 04:55:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1ol7fc-009VD2-RQ;
        Wed, 19 Oct 2022 08:55:36 -0300
Date:   Wed, 19 Oct 2022 08:55:36 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     yanjun.zhu@linux.dev
Cc:     Leon Romanovsky <leon@kernel.org>,
        Zhu Yanjun <yanjun.zhu@intel.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/1] RDMA/mlx5: Make mlx5 device work with
 ib_device_get_by_netdev
Message-ID: <Y0/luHd1OEZsyGWI@ziepe.ca>
References: <Y05iy+/0BUvbwp5z@unreal>
 <20221016061925.1831180-1-yanjun.zhu@intel.com>
 <556e07a6c331d68845f86e9e0e7cb0c7@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <556e07a6c331d68845f86e9e0e7cb0c7@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 19, 2022 at 09:08:14AM +0000, yanjun.zhu@linux.dev wrote:
> October 18, 2022 4:24 PM, "Leon Romanovsky" <leon@kernel.org> wrote:
> 
> > On Sun, Oct 16, 2022 at 02:19:25AM -0400, Zhu Yanjun wrote:
> > 
> >> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> >> 
> >> Before mlx5 ib device is registered, the function ib_device_set_netdev
> >> is not called to map the mlx5 ib device with the related net device.
> >> 
> >> As such, when the function ib_device_get_by_netdev is called to get ib
> >> device, NULL is returned.
> >> 
> >> Other ib devices, such as irdma, rxe and so on, the function
> >> ib_device_get_by_netdev can get ib device from the related net device.
> > 
> > Ohh, you opened Pandora box, everything around it looks half-backed.
> > 
> > mlx4 and mlx5 don't call to ib_device_set_netdev(), because they have
> > .get_netdev() callback. This callback is not an easy task to eliminate
> > and many internal attempts failed to eliminate them.
> > 
> > This caused to very questionable ksmbd_rdma_capable_netdev()
> > implementation where ksmbd first checked internal ib_dev callback
> > and tried to use ib_device_get_by_netdev(). And to smc_ib, which
> > didn't even bother to use ib_device_get_by_netdev().
> 
> Thanks.
> 
> I read the function ksmbd_rdma_capable_netdev carefully.
> Mlx5 and mlx4 do not call ib_device_set_netdev to map net device and ib devices.
> This brings a lot of problems. 

ULPs are not allowed to use these interfaces, they are for driver
implementations.

It is an error that ksmbd_rdma_capable_netdev() calls it in the first
place.

Jason
