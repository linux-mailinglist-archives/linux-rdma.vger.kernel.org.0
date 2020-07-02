Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA002122FE
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2020 14:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbgGBMLv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Jul 2020 08:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728847AbgGBMLu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Jul 2020 08:11:50 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F034C08C5DC
        for <linux-rdma@vger.kernel.org>; Thu,  2 Jul 2020 05:11:50 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id i25so28693763iog.0
        for <linux-rdma@vger.kernel.org>; Thu, 02 Jul 2020 05:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Eko+gn0fkmzl4T2A9QdkZYyOUJF1wHLJbPljdEltVCA=;
        b=R2v8R1eV5f5iZFqO/jR3pPAVbXcWdQ6FeiosC78q3cOfexYhLL8OcMLS9rxsBo4CLK
         y5pUbReiCH9H51dEGxWSju7nkQdcyn3d2ZTw59pjkKl1EprczM0wGfqww+XrwozCLRTS
         Vb9CHuoTLJlGYFVK2dGb6aLjeNXsV7RTeTBHEHCOCV0PcANW6j4NlqhTBkD3mG/TLfp7
         5CrrwfAPo0M4c55r1Co2jye5jkh54mXg1dT0Ju0ozehQzRiF8wAvA/tN2MaFM9TKS4O4
         gSHTr5f1Wjr+5gd9wqq2Jmj3blWRmMWaP9VOjWk7sDVIym91exPVpvSjVY5MTtwaC2As
         Trpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Eko+gn0fkmzl4T2A9QdkZYyOUJF1wHLJbPljdEltVCA=;
        b=uEn5YZa7vcE/GPjJGVnJLLY0Yzs2XqFbT+sCKTEAGlLVpRYOaFf/iJ7Yn1y84+Rf2V
         J2Iq7qt/1Gl5JzgBjzCfG9uV3iNrKlvJ24EC9PMXjP+dboeI2/IgIk5U/rtf5MDmAXSP
         2ESw6KZBZvZ/LU2lCn+Mdb16nizdSsZVcTzZJx/AuPnfrfcvh9j1GbaG29ckbZPQPoN7
         rjTfdOuT1ZuvPxgw0M8UPwxKiU+ti5hUlguHcxyUTH715n6raRpT7ty1PN8jzDOsdB0+
         MiGy2M5/ma2ExlzozX3CtG4mCZZoNAmnGpP9VWugXUkCP6WzQm1N/nLHi2gArlPD1l1i
         A0rA==
X-Gm-Message-State: AOAM532hqDFpTiZwRkj13kS4898Hbb/U9sNgZJTMYTaskTX7BcVVufo9
        AmjM5QdFeHXKRj+hJGJFdUFx/g==
X-Google-Smtp-Source: ABdhPJy/shl/mAgwE1EfUHmMNq2s5flqydDJz4n59Pooo5wlRJyXvKvt1jDoIhOQqX0FClsAuNVGmg==
X-Received: by 2002:a05:6638:2172:: with SMTP id p18mr34514093jak.63.1593691909301;
        Thu, 02 Jul 2020 05:11:49 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id a20sm4943502ila.5.2020.07.02.05.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 05:11:48 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jqy4B-002qcB-M8; Thu, 02 Jul 2020 09:11:47 -0300
Date:   Thu, 2 Jul 2020 09:11:47 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Mark Brown <broonie@kernel.org>
Cc:     Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Takashi Iwai <tiwai@suse.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, nhorman@redhat.com,
        sassmann@redhat.com, Fred Oh <fred.oh@linux.intel.com>,
        lee.jones@linaro.org
Subject: Re: [net-next v4 10/12] ASoC: SOF: Introduce descriptors for SOF
 client
Message-ID: <20200702121147.GQ25301@ziepe.ca>
References: <20200527071733.GB52617@kroah.com>
 <20200629203317.GM5499@sirena.org.uk>
 <20200629225959.GF25301@ziepe.ca>
 <20200630103141.GA5272@sirena.org.uk>
 <20200630113245.GG25301@ziepe.ca>
 <936d8b1cbd7a598327e1b247441fa055d7083cb6.camel@linux.intel.com>
 <20200630172710.GJ25301@ziepe.ca>
 <20200701095049.GA5988@sirena.org.uk>
 <20200701233250.GP25301@ziepe.ca>
 <20200702111522.GA4483@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702111522.GA4483@sirena.org.uk>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 02, 2020 at 12:15:22PM +0100, Mark Brown wrote:
> On Wed, Jul 01, 2020 at 08:32:50PM -0300, Jason Gunthorpe wrote:
> > On Wed, Jul 01, 2020 at 10:50:49AM +0100, Mark Brown wrote:
> 
> > > Another part of this is that there's not a clean cut over between MMIO
> > > and not using any hardware resources at all - for example a device might
> > > be connected over I2C but use resources to distribute interrupts to
> > > subdevices.
> 
> > How does the subdevice do anything if it only received an interrupt?
> 
> Via some bus that isn't memory mapped like I2C or SPI.
> 
> > That sounds rather more like virtual bus's use case..
> 
> These are very much physical devices often with distinct IPs in distinct
> address ranges and so on, it's just that those addresses happen not to
> be on buses it is sensible to memory map.

But platform bus is all about memmory mapping, so how does the
subdevice learn the address range and properly share the underlying
transport?

Jason

