Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46D8A1539C4
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2020 21:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgBEUyF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Feb 2020 15:54:05 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45370 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgBEUyF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Feb 2020 15:54:05 -0500
Received: by mail-qt1-f195.google.com with SMTP id d9so2692195qte.12
        for <linux-rdma@vger.kernel.org>; Wed, 05 Feb 2020 12:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jpNZkKrQMsJuyLB3yJaSO9CnTPBSUu1iNjMZP5YGSBQ=;
        b=U7UL09TLx3Njf6IiW0dBeIYi2cvA0W7mrR1kUdupa6x9gDzYd0Tbe4VrnhlTNmOgmX
         vfRVEdVhPea5IHBXydbxb92Jk8Ttmkc4KYjUOhcF3HhMVDh95/jIy/ZAlmu9r1nwLJjT
         iRyohL08VxyVUMRaIgzy4gdbrs7/Nc+uJF+gsPo1idlwQP9BY63GTN4D9J7Fe631B0Ym
         ve84bc2urSWKC4/Io3N6aEpbyVPs429AuADed9hNgurjuFb20GuMNE3pO5rPM5DSrfi/
         og3MXBZEzTXEaQWKLpPivcqp1i1gGZ3IAORQqn5gmT60quIkrqZu1isTUA9Vyp44JIzH
         r7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jpNZkKrQMsJuyLB3yJaSO9CnTPBSUu1iNjMZP5YGSBQ=;
        b=UMYvfQsrI+MuUBwxDtdGyLek6tWJucqF9Vl6t6/g7v+m7wlzV5mI6UrycfaTOWqStx
         WPUWg5TeM7KOTLcNLMMa1dgReGjVijyb14eU7OKDRwVhbCxoxMeYr/PrWnyqdzrA/qnF
         AB91Zt+kHxzFDyXxNhIT8u2SnQjf5dl5CkVVoOYWXcCDwbyxZ+LjIKRlUbqyYma8MwAU
         hiZdYJXgk+tICgiYxtbtDUA7H3/JJ23kP+FVUoqau/tEzqRMAwm0mdQ0HtWffZqlrtGs
         05R59QJYj5M3eS/Xm5tlqlzDhW3mv1GMd41YAnekLK35mKllUz2JeK5K3M0aT96L8n1T
         75QA==
X-Gm-Message-State: APjAAAUY8uoI0iVb9kXn5U1MrT8SURkb7Kxv4fSBqyVnrPgYfZW7aBDl
        3Id2ew44elMve4twu27OGSQCNg==
X-Google-Smtp-Source: APXvYqyd0SCB+F+XWraAVA+x3buj5dHM+ay9zScR/7UWy9PfZCMzIrBwHP1pTBxzqGqhDmWIefiq4Q==
X-Received: by 2002:ac8:4289:: with SMTP id o9mr35192341qtl.277.1580936043828;
        Wed, 05 Feb 2020 12:54:03 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id i28sm527464qtc.57.2020.02.05.12.54.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Feb 2020 12:54:03 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1izRgQ-0007ti-Oe; Wed, 05 Feb 2020 16:54:02 -0400
Date:   Wed, 5 Feb 2020 16:54:02 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     "Goldman, Adam" <adam.goldman@intel.com>,
        linux-rdma@vger.kernel.org, mike.marciniszyn@intel.com
Subject: Re: [PATCH] kernel-boot: Do not perform device rename on OPA devices
Message-ID: <20200205205402.GC25297@ziepe.ca>
References: <1580824520-38122-1-git-send-email-adam.goldman@intel.com>
 <20200205191227.GE28298@ziepe.ca>
 <daa60df0-04e1-d33c-fdc9-5a3fea2688cb@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <daa60df0-04e1-d33c-fdc9-5a3fea2688cb@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 05, 2020 at 03:35:13PM -0500, Dennis Dalessandro wrote:
> On 2/5/2020 2:12 PM, Jason Gunthorpe wrote:
> > On Tue, Feb 04, 2020 at 08:55:20AM -0500, Goldman, Adam wrote:
> > > From: "Goldman, Adam" <adam.goldman@intel.com>
> > > 
> > > PSM2 will not run with recent rdma-core releases. Several tools and
> > > libraries like PSM2, require the hfi1 name to be present.
> > > 
> > > Recent rdma-core releases added a new feature to rename kernel devices,
> > > but the default configuration will not work with hfi1 fabrics.
> > > 
> > > Related opa-psm2 github issue:
> > >    https://github.com/intel/opa-psm2/issues/43
> > > 
> > > Fixes: 5b4099d47be3 ("kernel-boot: Perform device rename to make stable names")
> > > Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
> > > Signed-off-by: Goldman, Adam <adam.goldman@intel.com>
> > >   kernel-boot/rdma-persistent-naming.rules | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel-boot/rdma-persistent-naming.rules b/kernel-boot/rdma-persistent-naming.rules
> > > index 9b61e16..95d6851 100644
> > > +++ b/kernel-boot/rdma-persistent-naming.rules
> > > @@ -25,4 +25,4 @@
> > >   #   Device type = RoCE
> > >   #   mlx5_0 -> rocex525400c0fe123455
> > >   #
> > > -ACTION=="add", SUBSYSTEM=="infiniband", PROGRAM="rdma_rename %k NAME_FALLBACK"
> > > +ACTION=="add", SUBSYSTEM=="infiniband", KERNEL!="hfi1*", PROGRAM="rdma_rename %k NAME_FALLBACK"
> > 
> > We are moving to the new names by default slowly, when wrong
> > assumptions are found in other packages they need to be updated and
> > their fixes pushed out.
> > 
> > At some point the major distros will default this to On. People using
> > leading edge distros can turn it off with the global switch Leon
> > mentioned.
> > 
> > This is the same process netdev went through when they introduced
> > persistent names.
> > 
> > If I recall, hfi was one of the reason this work was done. HFI has
> > problems generating consistent names for its multi-function devices in
> > various cases and I NAK'd the kernel hack to try and 'fix' that.
> 
> So are you saying you won't take this patch then?

No, this is not a longterm solution. The point of upstream here is to
highlight what needs to be fixed so leading edge distro can fix their
stuff.

> I guess we can work with distros to get the right rules in place outside of
> rdma-core so that things continue to work. 

I would actively block an attempt to try and do an end-run around
upstream like this. rdma-core is supposed to be the defacto
configuration, not be modified randomly by distros as before.

You can request distros delay enabling renaming until psm/etc are
fixed.

The distros know the users/cases where renaming is needed and can
decide if they are more or less important than psm for default
enablement.

> You are correct someone tried to put forth a hack for the flip-flop name
> thing [1]. However even if this was used as a solution for that issue we
> would still have the same library looking for hfi1_0 problem.

It was always a bad design to hardwire strings like this, that library
needs to be fixed up.

Do you remember when I was so annoyed that HFI1 created it's own char
dev, and told you not to do it? This is yet another reason why...

Why isn't psm keying off it's own chardev anyhow? There should be back
links to the RDMA device in sysfs from there.

Jason
