Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E8C1DF022
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2020 21:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730941AbgEVToX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 May 2020 15:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730689AbgEVToX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 May 2020 15:44:23 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FC5C05BD43
        for <linux-rdma@vger.kernel.org>; Fri, 22 May 2020 12:44:21 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id v15so5284444qvr.8
        for <linux-rdma@vger.kernel.org>; Fri, 22 May 2020 12:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KsaMtnJXEcs28XaPd87Bzy6KmDzAYKU9egI48v8GEO0=;
        b=V8JNgkbfW32JKqKZTqiukqLqRze5kwf34jyxMf8fwma8wxzE8jx+m511ZHLQIxJrhL
         6zEdIpLgnXxhkPG8Egg3R8aPGfteME7dKhdD8afhCZvosIkqLLi7cRKX2EN1OXxj7Ea7
         ewIalA+eTitpYEAPVSuKD+TYDadNnbN7Y77nFOyuJi75o9hMAPlfGolUS5QTO+uaWD9w
         bn07JSwciOJx10doWy+zzUnMydkacvOnyuvEbYWayng+VgF5F8uYq9XXEZRL3pPgnm07
         wdwH4TeBZGHsN3voXTkWWwwJK+bQug9zCee14a5NlenOzmsu458Kbr/5WjfyCxpmIoJq
         yMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KsaMtnJXEcs28XaPd87Bzy6KmDzAYKU9egI48v8GEO0=;
        b=kMUO1rlygqhfjPAYSP65DE5uOR8Gb7ihjHKak7M//opLLMJF0F1xrSMO80/2KGCZ9p
         qWAxTu2x78k4MCxutAgX7oBz/JxyDpRpSSA4WDm7rA19czJv+XCpZ9gL/XxqVLvsm0C0
         C8hA4sLYwhURaF7M47LBL0JN9JWIO+UV15AA+trNRE3ddGujnYrWW9vgL4x7X1l320yN
         mC2mzlEnm/Y3vw6jCh+y/ll5llqMq9ijOZB6u7seXouNRuSwsOf9lcrM3hahYfiiNC3r
         gFk6s/BuKXjRiHe4/oakDfGKj3y6T9cOhwVz0YseyMnVK3dK+hRIWd9E4Dn790eRON8n
         bIZQ==
X-Gm-Message-State: AOAM5325pkv21351ykHGQQnQaYyjbzfc62AgDcsEqP4xdDe/kxSQ5QJ4
        +DrCD6SM998gUYfnQ5vDAM55qg==
X-Google-Smtp-Source: ABdhPJx/+csjW0xI1CcTJAhJBpJ3cg4zcde+gHfTeVDpSLtpEo8gKR3IPBKMJ5NSwsjjEkVa5NMlIA==
X-Received: by 2002:a0c:a692:: with SMTP id t18mr5307746qva.56.1590176660559;
        Fri, 22 May 2020 12:44:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id a24sm8408782qto.10.2020.05.22.12.44.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 May 2020 12:44:20 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jcDac-00050x-Iz; Fri, 22 May 2020 16:44:18 -0300
Date:   Fri, 22 May 2020 16:44:18 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        nhorman@redhat.com, sassmann@redhat.com,
        Fred Oh <fred.oh@linux.intel.com>
Subject: Re: [net-next v4 10/12] ASoC: SOF: Introduce descriptors for SOF
 client
Message-ID: <20200522194418.GM17583@ziepe.ca>
References: <20200520125437.GH31189@ziepe.ca>
 <08fa562783e8a47f857d7f96859ab3617c47e81c.camel@linux.intel.com>
 <20200521233437.GF17583@ziepe.ca>
 <7abfbda8-2b4b-5301-6a86-1696d4898525@linux.intel.com>
 <20200522145542.GI17583@ziepe.ca>
 <6e129db7-2a76-bc67-0e56-2abb4d9761a3@linux.intel.com>
 <20200522171055.GK17583@ziepe.ca>
 <01efd24a-edb6-3d0c-d7fa-a602ecd381d1@linux.intel.com>
 <20200522184035.GL17583@ziepe.ca>
 <b680a7f2-5dc1-00d6-dcff-b7c71d09b535@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b680a7f2-5dc1-00d6-dcff-b7c71d09b535@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 22, 2020 at 01:48:00PM -0500, Pierre-Louis Bossart wrote:
> 
> 
> On 5/22/20 1:40 PM, Jason Gunthorpe wrote:
> > On Fri, May 22, 2020 at 01:35:54PM -0500, Pierre-Louis Bossart wrote:
> > > 
> > > 
> > > On 5/22/20 12:10 PM, Jason Gunthorpe wrote:
> > > > On Fri, May 22, 2020 at 10:33:20AM -0500, Pierre-Louis Bossart wrote:
> > > > 
> > > > > > Maybe not great, but at least it is consistent with all the lifetime
> > > > > > models and the operation of the driver core.
> > > > > 
> > > > > I agree your comments are valid ones, I just don't have a solution to be
> > > > > fully compliant with these models and report failures of the driver probe
> > > > > for a child device due to configuration issues (bad audio topology, etc).
> > > > 
> > > > 
> > > > > My understanding is that errors on probe are explicitly not handled in the
> > > > > driver core, see e.g. comments such as:
> > > > 
> > > > Yes, but that doesn't really apply here...
> > > > > /*
> > > > >    * Ignore errors returned by ->probe so that the next driver can try
> > > > >    * its luck.
> > > > >    */
> > > > > https://elixir.bootlin.com/linux/latest/source/drivers/base/dd.c#L636
> > > > > 
> > > > > If somehow we could request the error to be reported then probably we
> > > > > wouldn't need this complete/wait_for_completion mechanism as a custom
> > > > > notification.
> > > > 
> > > > That is the same issue as the completion, a driver should not be
> > > > making assumptions about ordering like this. For instance what if the
> > > > current driver is in the initrd and the 2nd driver is in a module in
> > > > the filesystem? It will not probe until the system boots more
> > > > completely.
> > > > 
> > > > This is all stuff that is supposed to work properly.
> > > > 
> > > > > Not at the moment, no. there are no failures reported in dmesg, and
> > > > > the user does not see any card created. This is a silent error.
> > > > 
> > > > Creating a partial non-function card until all the parts are loaded
> > > > seems like the right way to surface an error like this.
> > > > 
> > > > Or don't break the driver up in this manner if all the parts are really
> > > > required just for it to function - quite strange place to get into.
> > > 
> > > This is not about having all the parts available - that's handled already
> > > with deferred probe - but an error happening during card registration. In
> > > that case the ALSA/ASoC core throws an error and we cannot report it back to
> > > the parent.
> > 
> > The whole point of the virtual bus stuff was to split up a
> > multi-functional PCI device into parts. If all the parts are required
> > to be working to make the device work, why are you using virtual bus
> > here?
> 
> It's the other way around: how does the core know that one part isn't
> functional.

> There is nothing in what we said that requires that all parts are fully
> functional. All we stated is that when *one* part isn't fully functional we
> know about it.

Maybe if you can present some diagram or something, because I really
can't understand why asoc is trying to do with virtual bus here.

> > > > What happens if the user unplugs this sub driver once things start
> > > > running?
> > > 
> > > refcounting in the ALSA core prevents that from happening usually.
> > 
> > So user triggered unplug of driver that attaches here just hangs
> > forever? That isn't OK either.
> 
> No, you'd get a 'module in use' error if I am not mistaken.

You can disconnect drivers without unloading modules. It is a common
misconception. You should never, ever, rely on module ref counting for
anything more than keeping function pointers in memory.

Jason
