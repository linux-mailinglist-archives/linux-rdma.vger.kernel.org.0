Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C267D1DEF62
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2020 20:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730854AbgEVSkh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 May 2020 14:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730810AbgEVSkh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 May 2020 14:40:37 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCB8C061A0E
        for <linux-rdma@vger.kernel.org>; Fri, 22 May 2020 11:40:37 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id f189so11697125qkd.5
        for <linux-rdma@vger.kernel.org>; Fri, 22 May 2020 11:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jdVwYaklIjGoiltaEcYPwDBaF17z8bbprjyYiuZhteU=;
        b=U/4b3mSXSUjf7DG7hZr+zQ9t4uNZ5ui1gYKzVDLkTHifjtv/53cc9yCejqmKhg4VTI
         CJRY28SKAm5iBLKtT72VOnzpV1dSFNIn0nx4xP5bKd42/LGbcUP4mGI87nSIS8wvu2Hs
         uZ9osWzR2XJrjEcarIx6Pwuve9rbF/okG0oEW/wXouOV1HromYl23hx4yVI6MFTunAsb
         HgU+3opISvM7MyE6C3tBFAQi+NAbcU1mQlI2/LjA6oSgBqtAyqOQfiBWKR+RuCLy7VnY
         OfRwGKA/tuwBePXB316nHqR0Dbgq1rVKu5dLfALXG6rGyPRocxjiyWzkmv599wf+tkm0
         irXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jdVwYaklIjGoiltaEcYPwDBaF17z8bbprjyYiuZhteU=;
        b=HJK/pualJujq/v6YfYzvRxey62ca/TZxBbyHFgrWcG7KZ0GOx5weAslKPII3o5Q5m2
         jvyOOX2PmgdcGbEwZW6O2bXR7cw24EkNeR5al9BZYFYqW03bUesITXXhEWdl0+sApk+8
         0DZ7WNP9Zx8AoRfBbNYDGxVuT+ZCyuhHDmJh9AHy7XF4plVIpqn1J6Fzk5ypTq9jeCCf
         8u3oi0LeVhRox4p2FJFc12ftgl8Nk1UmTrkGu3GUW/uqveTgMX/U2sSTI6JS8XFVx9JT
         ZMjpS/i/rSWx9J+g6aaswRRzVxXQ23+8K8tEK6PeITSjM9BgbaC4oiYYwzu5PXCUfQvM
         oB1g==
X-Gm-Message-State: AOAM531Xmb4jvqRz6WCD2zp+ly3WMyh2nDv5OieRRSMIj7QN7xTKowDc
        2gHzYKtyGnsFZ6dYEYjyaxnKLQ==
X-Google-Smtp-Source: ABdhPJx1XCsol/Ewjzi2BwXZV6K88STn3RGg6C79ewHy2E7lX1Urekn7lHUX5dmVhhtz0Gn1ELE5FA==
X-Received: by 2002:a37:9606:: with SMTP id y6mr16488601qkd.269.1590172836266;
        Fri, 22 May 2020 11:40:36 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id 70sm4563581qkk.10.2020.05.22.11.40.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 May 2020 11:40:35 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jcCax-0001Jx-Ae; Fri, 22 May 2020 15:40:35 -0300
Date:   Fri, 22 May 2020 15:40:35 -0300
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
Message-ID: <20200522184035.GL17583@ziepe.ca>
References: <20200520070227.3392100-1-jeffrey.t.kirsher@intel.com>
 <20200520070227.3392100-11-jeffrey.t.kirsher@intel.com>
 <20200520125437.GH31189@ziepe.ca>
 <08fa562783e8a47f857d7f96859ab3617c47e81c.camel@linux.intel.com>
 <20200521233437.GF17583@ziepe.ca>
 <7abfbda8-2b4b-5301-6a86-1696d4898525@linux.intel.com>
 <20200522145542.GI17583@ziepe.ca>
 <6e129db7-2a76-bc67-0e56-2abb4d9761a3@linux.intel.com>
 <20200522171055.GK17583@ziepe.ca>
 <01efd24a-edb6-3d0c-d7fa-a602ecd381d1@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01efd24a-edb6-3d0c-d7fa-a602ecd381d1@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 22, 2020 at 01:35:54PM -0500, Pierre-Louis Bossart wrote:
> 
> 
> On 5/22/20 12:10 PM, Jason Gunthorpe wrote:
> > On Fri, May 22, 2020 at 10:33:20AM -0500, Pierre-Louis Bossart wrote:
> > 
> > > > Maybe not great, but at least it is consistent with all the lifetime
> > > > models and the operation of the driver core.
> > > 
> > > I agree your comments are valid ones, I just don't have a solution to be
> > > fully compliant with these models and report failures of the driver probe
> > > for a child device due to configuration issues (bad audio topology, etc).
> > 
> > 
> > > My understanding is that errors on probe are explicitly not handled in the
> > > driver core, see e.g. comments such as:
> > 
> > Yes, but that doesn't really apply here...
> > > /*
> > >   * Ignore errors returned by ->probe so that the next driver can try
> > >   * its luck.
> > >   */
> > > https://elixir.bootlin.com/linux/latest/source/drivers/base/dd.c#L636
> > > 
> > > If somehow we could request the error to be reported then probably we
> > > wouldn't need this complete/wait_for_completion mechanism as a custom
> > > notification.
> > 
> > That is the same issue as the completion, a driver should not be
> > making assumptions about ordering like this. For instance what if the
> > current driver is in the initrd and the 2nd driver is in a module in
> > the filesystem? It will not probe until the system boots more
> > completely.
> > 
> > This is all stuff that is supposed to work properly.
> > 
> > > Not at the moment, no. there are no failures reported in dmesg, and
> > > the user does not see any card created. This is a silent error.
> > 
> > Creating a partial non-function card until all the parts are loaded
> > seems like the right way to surface an error like this.
> > 
> > Or don't break the driver up in this manner if all the parts are really
> > required just for it to function - quite strange place to get into.
> 
> This is not about having all the parts available - that's handled already
> with deferred probe - but an error happening during card registration. In
> that case the ALSA/ASoC core throws an error and we cannot report it back to
> the parent.

The whole point of the virtual bus stuff was to split up a
multi-functional PCI device into parts. If all the parts are required
to be working to make the device work, why are you using virtual bus
here?

> > What happens if the user unplugs this sub driver once things start
> > running?
> 
> refcounting in the ALSA core prevents that from happening usually.

So user triggered unplug of driver that attaches here just hangs
forever? That isn't OK either.

Jason
