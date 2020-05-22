Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEFE61DEAAF
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2020 16:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731375AbgEVOzu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 May 2020 10:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731271AbgEVOzo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 May 2020 10:55:44 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A44BC05BD43
        for <linux-rdma@vger.kernel.org>; Fri, 22 May 2020 07:55:44 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id n22so8422050qtv.12
        for <linux-rdma@vger.kernel.org>; Fri, 22 May 2020 07:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QJ37phwO+Zm3dA3dP+dCln73OoFdmwI2wd+G4MSZ9eY=;
        b=LCg1FTqhmjkzGkPZ7IuQOhelRkUABkUmGIRl3tyS1ElD5u1+JVoUQ3rTjeME25qjSK
         WehnVfGuvT1BkKU7rMspHg4j2MSykHh1X6ql90soNZhGDwJuaR4p/7lLoaLyANeC6Zun
         WL5GC1SPSPiMerr2NnmbEPwAmJ/2zJYXrATYUdsGyMxi6+1cus4mnRX9ROMTROfXRgg1
         yuBFhxJhAPf7OduQj0BVWXMk/0LeWy4GP+lVSvw98lzfmMMyT5doKAZDdNYaFjorn16l
         ziygSgzFJekR/thDfe0ckQvBqY02UTPGX7xkpt/JOcfVWwDfyI6EK7bol308v+bMMo4/
         S9YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QJ37phwO+Zm3dA3dP+dCln73OoFdmwI2wd+G4MSZ9eY=;
        b=j6nLZ72ycDY9q4mhgI91/H93GwDJGkUAu+i419+KCmNnQi1EWlmIHxbVqw4mhMvA36
         D1HIAxPO2rZ16CG/txuhvcwFINpr01UmUoGnaPSnC/+3WNljmjr8+nHbn+e+oxuh0Lqb
         rLAOn9lWEjxJORC/TtMW4zNP0f2xFf5eK2WJJEo/p9g4zbeVfA3MM/kcxCd0EjhJ9hXz
         SWZWNWtc2rO2VDWTBJ07vw76GG6F3Gbeug5mvQ/3oHnaNLH5cctTQooLZIvsolySo8BP
         NQUwo77uVKW6OFTvFnLlzglkb0pQzjOQllJnkLYTqjxbo1QxHEUXNVKTXPjcAERoL66t
         4sVg==
X-Gm-Message-State: AOAM5307KoyQi6GqAXjvpY1/hk2RBOiTfT/2QFg3szZOR5mC+oHqtoHn
        ootI1r5ve6YbH3U/JOAe9khd8w==
X-Google-Smtp-Source: ABdhPJzIuVul3rsjIIpmrUHnLzd/o8ZLk2HG1kUBSnA9rmWUVRqYZSwm4RYSHXC4yNQJaNQzMI5hKA==
X-Received: by 2002:ac8:6f5a:: with SMTP id n26mr17164573qtv.303.1590159343523;
        Fri, 22 May 2020 07:55:43 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id o66sm1963579qka.60.2020.05.22.07.55.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 May 2020 07:55:43 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jc95K-0004qa-KL; Fri, 22 May 2020 11:55:42 -0300
Date:   Fri, 22 May 2020 11:55:42 -0300
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
Message-ID: <20200522145542.GI17583@ziepe.ca>
References: <20200520070227.3392100-1-jeffrey.t.kirsher@intel.com>
 <20200520070227.3392100-11-jeffrey.t.kirsher@intel.com>
 <20200520125437.GH31189@ziepe.ca>
 <08fa562783e8a47f857d7f96859ab3617c47e81c.camel@linux.intel.com>
 <20200521233437.GF17583@ziepe.ca>
 <7abfbda8-2b4b-5301-6a86-1696d4898525@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7abfbda8-2b4b-5301-6a86-1696d4898525@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 22, 2020 at 09:29:57AM -0500, Pierre-Louis Bossart wrote:
> 
> > > > > +	ret = virtbus_register_device(vdev);
> > > > > +	if (ret < 0)
> > > > > +		return ret;
> > > > > +
> > > > > +	/* make sure the probe is complete before updating client list
> > > > > */
> > > > > +	timeout = msecs_to_jiffies(SOF_CLIENT_PROBE_TIMEOUT_MS);
> > > > > +	time = wait_for_completion_timeout(&cdev->probe_complete,
> > > > > timeout);
> > > > 
> > > > This seems bonkers - the whole point of something like virtual bus is
> > > > to avoid madness like this.
> > > 
> > > Thanks for your review, Jason. The idea of the times wait here is to
> > > make the registration of the virtbus devices synchronous so that the
> > > SOF core device has knowledge of all the clients that have been able to
> > > probe successfully. This part is domain-specific and it works very well
> > > in the audio driver case.
> > 
> > This need to be hot plug safe. What if the module for this driver is
> > not available until later in boot? What if the user unplugs the
> > driver? What if the kernel runs probing single threaded?
> > 
> > It is really unlikely you can both have the requirement that things be
> > synchronous and also be doing all the other lifetime details properly..
> 
> Can you suggest an alternate solution then?

I don't even know what problem you are trying to solve.

> The complete/wait_for_completion is a simple mechanism to tell that the
> action requested by the parent is done. Absent that, we can end-up in a
> situation where the probe may fail, or the requested module does not exist,
> and the parent knows nothing about the failure - so the system is in a
> zombie state and users are frustrated. It's not great either, is it?

Maybe not great, but at least it is consistent with all the lifetime
models and the operation of the driver core.

> This is not an hypothetical case, we've had this recurring problem when a
> PCI device creates an audio card represented as a platform device. When the
> card registration fails, typically due to configuration issues, the PCI
> probe still completes. That's really confusing and the source of lots of
> support questions. If we use these virtual bus extensions to stpo abusing
> platform devices, it'd be really nice to make those unreported probe
> failures go away.

I think you need to address this in some other way that is hot plug
safe.

Surely you can make this failure visible to users in some other way?

Jason
