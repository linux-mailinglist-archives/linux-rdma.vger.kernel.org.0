Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A84C1D10EB
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2020 13:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730607AbgEMLOm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 May 2020 07:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730567AbgEMLOl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 May 2020 07:14:41 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C300C061A0C
        for <linux-rdma@vger.kernel.org>; Wed, 13 May 2020 04:14:41 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id k12so26069727wmj.3
        for <linux-rdma@vger.kernel.org>; Wed, 13 May 2020 04:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MdFy1gv1cP+vMftcl1loH6YXj71XevmKdWXqkWiU2YE=;
        b=IA4KNkiLZN9cH9IdeEZWQzKz7UdDZQkDInuhOSCpgbfbOpxf/nqHVg/iQguty+X52J
         gyTQGJ6VrPKw3wFRYcjhcNlHlH1Bb7Z5uC4h6eWO+EEaOFt1glPKOHs+g8gspaXNKl7+
         BdkNgfHht8ZYczGcqof+SIKwd6FBACHu8gFz5ollBU3MLJ/xjtPJEIRqYkDJ/C9jNzzb
         bmhkrgCDsFq5p2NsKWWfl3OI6g89pgnzWaqw7fuQf0Fn67Tn0YRyiKrUCtUnuh5btwCq
         53E0cTSpJLgWoMU7Fze0AL3EAQYRdobpLWpWO6T4s0EcXMYdLw1ktiAkDG6vqalwzy7f
         sioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MdFy1gv1cP+vMftcl1loH6YXj71XevmKdWXqkWiU2YE=;
        b=GA6G/jCZSUiMG4ulkSXOFnQAY5yI5/3ny0Z25tSlqoR9q++hEZ62jsrZ54uEhrz0Ud
         3uGWqwUY1nTQhaT6vBcP3LOEv+qF5xReVFsdxP8OjWW+goKeAWzXXrgUNj7umOGB0qjh
         cBv1FffhafQ06y5yTniPlR3RPCc4aFMRDSB+1MKkoCzZ4SLRlVqatoAwt6q5iEXtgePA
         cTcMXrgjeUBQdKT3XLqQlN5t8I7tCT/KcAXp+2maNxDDvVqgndqUazVwhfWIOUa8l9+O
         aVj7dd/uUclza3FeXR+tow3gDkRbCXRLULZKK2l2yNF6VKzIoR+NU5GyehFMEfiH05+S
         0jJA==
X-Gm-Message-State: AGi0PubisuEa6UuMIX83ycADFSFiSPW6eR+ffMOEJg9KXKyhrPcZ22vO
        Bpkg7QKfgV57oDRD0TIlTtBO+AqE
X-Google-Smtp-Source: APiQypLMa1IDUEKnLjqw8xkaLCO91rQANyZ67GvO7hcmuz9EcSe85I2iYiN/k1T0Z1crmEk8oI9iUg==
X-Received: by 2002:a05:600c:14d4:: with SMTP id i20mr44218402wmh.118.1589368479952;
        Wed, 13 May 2020 04:14:39 -0700 (PDT)
Received: from kheib-workstation ([37.142.4.4])
        by smtp.gmail.com with ESMTPSA id r6sm6529411wmh.1.2020.05.13.04.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 04:14:38 -0700 (PDT)
Date:   Wed, 13 May 2020 14:14:35 +0300
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH for-rc] RDMA/srpt: Fix disabling device management
Message-ID: <20200513111435.GA121070@kheib-workstation>
References: <20200511222918.62576-1-kamalheib1@gmail.com>
 <20200513072203.GR4814@unreal>
 <20200513100204.GA92901@kheib-workstation>
 <20200513102132.GW4814@unreal>
 <20200513104536.GA120318@kheib-workstation>
 <20200513105045.GX4814@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513105045.GX4814@unreal>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 13, 2020 at 01:50:45PM +0300, Leon Romanovsky wrote:
> On Wed, May 13, 2020 at 01:45:36PM +0300, Kamal Heib wrote:
> > On Wed, May 13, 2020 at 01:21:32PM +0300, Leon Romanovsky wrote:
> > > On Wed, May 13, 2020 at 01:02:04PM +0300, Kamal Heib wrote:
> > > > On Wed, May 13, 2020 at 10:22:03AM +0300, Leon Romanovsky wrote:
> > > > > On Tue, May 12, 2020 at 01:29:18AM +0300, Kamal Heib wrote:
> > > > > > Avoid disabling device management for devices that don't support
> > > > > > Management datagrams (MADs) by checking if the "mad_agent" pointer is
> > > > > > initialized before calling ib_modify_port, also change the error message
> > > > > > to a warning and make it more informative.
> > > > > >
> > > > > > Fixes: 09f8a1486dca ("RDMA/srpt: Fix handling of SR-IOV and iWARP ports")
> > > > > > Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> > > > > > ---
> > > > > >  drivers/infiniband/ulp/srpt/ib_srpt.c | 8 ++++++--
> > > > > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
> > > > > > index 7ed38d1cb997..7b21792ab6f7 100644
> > > > > > --- a/drivers/infiniband/ulp/srpt/ib_srpt.c
> > > > > > +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
> > > > > > @@ -625,14 +625,18 @@ static void srpt_unregister_mad_agent(struct srpt_device *sdev)
> > > > > >  		.clr_port_cap_mask = IB_PORT_DEVICE_MGMT_SUP,
> > > > > >  	};
> > > > > >  	struct srpt_port *sport;
> > > > > > +	int ret;
> > > > > >  	int i;
> > > > > >
> > > > > >  	for (i = 1; i <= sdev->device->phys_port_cnt; i++) {
> > > > > >  		sport = &sdev->port[i - 1];
> > > > > >  		WARN_ON(sport->port != i);
> > > > > > -		if (ib_modify_port(sdev->device, i, 0, &port_modify) < 0)
> > > > > > -			pr_err("disabling MAD processing failed.\n");
> > > > > >  		if (sport->mad_agent) {
> > > > > > +			ret = ib_modify_port(sdev->device, i, 0, &port_modify);
> > > > > > +			if (ret < 0)
> > > > > > +				pr_warn("%s-%d: disabling device management failed (%d). Note: this is expected if SR-IOV is enabled.\n",
> > > > > > +					dev_name(&sport->sdev->device->dev),
> > > > >
> > > > > The ib_modify_port() shouldn't be called if it expected to fail.
> > > > >
> > > > > Thanks
> > > >
> > > > OK, Do you know if there is a way to check if the created ib device is
> > > > for VF to avoid calling ib_modify_port()?
> > >
> > > The "is_virtfn" field inside pci_dev will give this information,
> > > but I don't know why it is expected to fail here.
> > >
> > > Thanks
> > >
> >
> > Looks like there a more trivial way, I mean checking if
> > IB_DEVICE_VIRTUAL_FUNCTION cap is set, probably there is a need to make
> > to sure that this cap is set for all providers when the IB device is
> > created for a VF.
> >
> > With regards to why it is expected to fail, as stated in the commit
> > message and the in "Fixes" commit message there is some devices (VF)
> > that don't support MADs.
> 
> So shouldn't you test that device support MAD instead of testing VF cap?
> 
> Thanks

Correct me if I'm wrong, Do you mean check the return value from
rdma_cap_ib_mad()? 

Thanks,
Kamal
> 
> >
> > Thanks,
> > Kamal
> >
> > > >
> > > > Thanks,
> > > > Kamal
> > > >
> > > > >
> > > > > > +					sport->port, ret);
> > > > > >  			ib_unregister_mad_agent(sport->mad_agent);
> > > > > >  			sport->mad_agent = NULL;
> > > > > >  		}
> > > > > > --
> > > > > > 2.25.4
> > > > > >
