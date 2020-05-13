Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B58431D12FA
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2020 14:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730570AbgEMMni (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 May 2020 08:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729041AbgEMMnh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 May 2020 08:43:37 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13288C061A0C
        for <linux-rdma@vger.kernel.org>; Wed, 13 May 2020 05:43:36 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id a136so8141589qkg.6
        for <linux-rdma@vger.kernel.org>; Wed, 13 May 2020 05:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RZD/vRjL4JP4zq0ATr/UrB6itjfs7V3+XY2D+agnPRI=;
        b=AR3See7nB3m2+x8ambipkcmvIwbbJ6KqZOvHs1L3vra+TdQekD81bpCs9RB4kOYmww
         HOsvDRGZvWjbX2nea0CeCcJyoHdORfg76HehApwdg33TeVAnNWPlKwEqAwsxIbCaqW/u
         F0QrGVTkGMXennq+GU4zzISuh4OVkE7e6DWJAUHBCkhV0c2sSU1IVo43kQMnNbObe7sV
         XHbbH7Y4x/6yclWX+Y5b9PN5OmdF213CnSxDo4AlQHiGMnRm1ZFdso7qAqbjMLZyZUSW
         kNwIhNElCrk9ZVEGVy3PUFim+4EizpCL/QB/eg69fz5DctisWj3gz1Lyhlv1XjryLgFb
         riOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RZD/vRjL4JP4zq0ATr/UrB6itjfs7V3+XY2D+agnPRI=;
        b=l/HbI2geCLimqGGul/BUu3SwlfQOnbxTJLg/TD5P+ewPuEg7DqqztAO9sX4mG31vze
         LUZeWamMAbuz8hg2KHgYSgxMPudPhb29DGTlBXyLmX/3SgYhLwmxQ1t8/JUrLwqDSfxv
         RpPMqUwWk60u/xqqrki3LnmnyJsuYT3d/QiwF7GEuNxFkWTDtSVAfaQZtfm7emT140yg
         2mi3EqeZM1lEqlMSWfGqYHLZuOKjvlpNklzOLKA3Kx5al39KaieLSAL+Yaf7EwrqA5TO
         XCIyYWZw873mjGpwat3LUwQVZtnHCQ8JegufwvxV5p+MHoBLCurN7333+k5nNCgQbt3g
         H3xg==
X-Gm-Message-State: AGi0Puam7WwaILnsRohtlk6fp7THHT+QywvGvu8DaVthahQ0KqLD31Gq
        VoT2GUKnf0GedfYGse04AyDizA==
X-Google-Smtp-Source: APiQypK95ZNaoMggdH8ossf9n4BFdnwdfGiWT8UqnZSki+VKDnjNS6tQ0no3FPMOsMvRA1dLrX1FEg==
X-Received: by 2002:a05:620a:484:: with SMTP id 4mr14611242qkr.1.1589373815060;
        Wed, 13 May 2020 05:43:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id 21sm13801967qkv.126.2020.05.13.05.43.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 May 2020 05:43:34 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jYqjW-0008Dg-2B; Wed, 13 May 2020 09:43:34 -0300
Date:   Wed, 13 May 2020 09:43:34 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH for-rc] RDMA/srpt: Fix disabling device management
Message-ID: <20200513124334.GA29989@ziepe.ca>
References: <20200511222918.62576-1-kamalheib1@gmail.com>
 <20200513072203.GR4814@unreal>
 <20200513100204.GA92901@kheib-workstation>
 <20200513102132.GW4814@unreal>
 <20200513104536.GA120318@kheib-workstation>
 <20200513105045.GX4814@unreal>
 <20200513111435.GA121070@kheib-workstation>
 <20200513113118.GY4814@unreal>
 <20200513123837.GA123854@kheib-workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513123837.GA123854@kheib-workstation>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 13, 2020 at 03:38:37PM +0300, Kamal Heib wrote:
> > > Correct me if I'm wrong, Do you mean check the return value from
> > > rdma_cap_ib_mad()?
> > 
> > I think so.
> > 
> > Thanks
> 
> Well, this function will not help in the case of VFs, because the flag
> that is checked in rdma_cap_ib_mad() is RDMA_CORE_CAP_IB_MAD which is
> set almost for each create IB device as part of RDMA_CORE_PORT_IBA_IB or
> RDMA_CORE_PORT_IBA_ROCE or RDMA_CORE_PORT_IBA_ROCE_UDP_ENCAP.

AFAIK this case only happens for mlx4 devices that use the GUID table
to emulate virtual IB ports. In this case there is no bit to control.

I didn't quite understand why srpt has this stuff, does it mean it is
broken on mlx4 vports? Why allow the failure?

Jason
