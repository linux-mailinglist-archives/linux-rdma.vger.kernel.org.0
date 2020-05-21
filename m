Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 195831DDB0F
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2020 01:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbgEUXej (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 May 2020 19:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728554AbgEUXej (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 May 2020 19:34:39 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DADC061A0E
        for <linux-rdma@vger.kernel.org>; Thu, 21 May 2020 16:34:39 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id s1so9069501qkf.9
        for <linux-rdma@vger.kernel.org>; Thu, 21 May 2020 16:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bnFlUB/YNIU8XOguGpE8gJL2HLqtegP54ZPVenfjdqw=;
        b=eeEX9TDlMZuDewd9eG1BZ3JJvVMXC+t8TIrq56jWIlkoJXAvLJOZhds2/m96m57HQw
         iEctEEfJzVaqTNw09WO1HIHtACtoP57yHV2BvesT+JF83BspoJh2FYrTgOB4qAHnx7MP
         vtaRtvj2ybrLf1nDIYXSFq/Rx7qqOCFoloTzlqp3U61axZenCHRvGncfsPsBdXD5cCWy
         rNZ525o30iJVv3u1fV3F2WTN95FMGJ3pzhUX33F0CHRd4uoIqH0DWtx16/53mHVLgDGs
         B8lsgGUTlF2UbVHnqpkawqEIgW1NE8SoW+nZTm6BmOYB2qRRW45ZkkdaMang/rASOPtv
         fDnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bnFlUB/YNIU8XOguGpE8gJL2HLqtegP54ZPVenfjdqw=;
        b=NF1kw5OALHRRjeGGcujdNdISiCALT1KDfwsI7i0JxQi+tkG0HQkU3xR9iKU/MTkePJ
         sjbh5T2sMq7rydnLf2P04bTE/gMFRSe3X7OWqIui/UkYXx9bhiRRtXVQ0tinEeOo9qyc
         Teue/sVy9i42pnQ71jATR0FMAgfIulVqT4ZqTPUB2zbZ3HEibNeSd7UbwTjC3UgpWlj6
         VG+3d7UhB/dgYlZK06qpopgQbao+F1YMaPyHPogtmKZSRURwB+MUdYqLerr+ydUVUeP+
         NKdTZc9N5eIwcWFRb8Gbj7CiVHbSezEupY/0gzHfG+oVDOFPx3khDKzZPbnTXeUbpSJq
         UfIw==
X-Gm-Message-State: AOAM532+ksy6ygWrdUAbopiaOcs+ttn9MdeBtEgfxvJLvitjl7BTaseA
        0VpuOx3czyIwhn/r5QBqHKjsHQ==
X-Google-Smtp-Source: ABdhPJz357JzbkXgaVdCm0qsb1MemPZx1NHsdzSM1+4XlzuFeKWAFr/Q79gsl/ufjQg+4mWt8eJKVw==
X-Received: by 2002:a37:8705:: with SMTP id j5mr10958596qkd.233.1590104078381;
        Thu, 21 May 2020 16:34:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id t74sm5735412qka.21.2020.05.21.16.34.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 May 2020 16:34:37 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jbuhx-0003gI-Ad; Thu, 21 May 2020 20:34:37 -0300
Date:   Thu, 21 May 2020 20:34:37 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Cc:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>, davem@davemloft.net,
        gregkh@linuxfoundation.org, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, nhorman@redhat.com,
        sassmann@redhat.com, pierre-louis.bossart@linux.intel.com,
        Fred Oh <fred.oh@linux.intel.com>
Subject: Re: [net-next v4 10/12] ASoC: SOF: Introduce descriptors for SOF
 client
Message-ID: <20200521233437.GF17583@ziepe.ca>
References: <20200520070227.3392100-1-jeffrey.t.kirsher@intel.com>
 <20200520070227.3392100-11-jeffrey.t.kirsher@intel.com>
 <20200520125437.GH31189@ziepe.ca>
 <08fa562783e8a47f857d7f96859ab3617c47e81c.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08fa562783e8a47f857d7f96859ab3617c47e81c.camel@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 21, 2020 at 02:11:37PM -0700, Ranjani Sridharan wrote:
> On Wed, 2020-05-20 at 09:54 -0300, Jason Gunthorpe wrote:
> > On Wed, May 20, 2020 at 12:02:25AM -0700, Jeff Kirsher wrote:
> > > From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> > > 
> > > A client in the SOF (Sound Open Firmware) context is a
> > > device that needs to communicate with the DSP via IPC
> > > messages. The SOF core is responsible for serializing the
> > > IPC messages to the DSP from the different clients. One
> > > example of an SOF client would be an IPC test client that
> > > floods the DSP with test IPC messages to validate if the
> > > serialization works as expected. Multi-client support will
> > > also add the ability to split the existing audio cards
> > > into multiple ones, so as to e.g. to deal with HDMI with a
> > > dedicated client instead of adding HDMI to all cards.
> > > 
> > > This patch introduces descriptors for SOF client driver
> > > and SOF client device along with APIs for registering
> > > and unregistering a SOF client driver, sending IPCs from
> > > a client device and accessing the SOF core debugfs root entry.
> > > 
> > > Along with this, add a couple of new members to struct
> > > snd_sof_dev that will be used for maintaining the list of
> > > clients.
> > 
> > If you want to use sound as the rational for virtual bus then drop
> > the
> > networking stuff and present a complete device/driver pairing based
> > on
> > this sound stuff instead.
> > 
> > > +int sof_client_dev_register(struct snd_sof_dev *sdev,
> > > +			    const char *name)
> > > +{
> > > +	struct sof_client_dev *cdev;
> > > +	struct virtbus_device *vdev;
> > > +	unsigned long time, timeout;
> > > +	int ret;
> > > +
> > > +	cdev = kzalloc(sizeof(*cdev), GFP_KERNEL);
> > > +	if (!cdev)
> > > +		return -ENOMEM;
> > > +
> > > +	cdev->sdev = sdev;
> > > +	init_completion(&cdev->probe_complete);
> > > +	vdev = &cdev->vdev;
> > > +	vdev->match_name = name;
> > > +	vdev->dev.parent = sdev->dev;
> > > +	vdev->release = sof_client_virtdev_release;
> > > +
> > > +	/*
> > > +	 * Register virtbus device for the client.
> > > +	 * The error path in virtbus_register_device() calls
> > > put_device(),
> > > +	 * which will free cdev in the release callback.
> > > +	 */
> > > +	ret = virtbus_register_device(vdev);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	/* make sure the probe is complete before updating client list
> > > */
> > > +	timeout = msecs_to_jiffies(SOF_CLIENT_PROBE_TIMEOUT_MS);
> > > +	time = wait_for_completion_timeout(&cdev->probe_complete,
> > > timeout);
> > 
> > This seems bonkers - the whole point of something like virtual bus is
> > to avoid madness like this.
> 
> Thanks for your review, Jason. The idea of the times wait here is to
> make the registration of the virtbus devices synchronous so that the
> SOF core device has knowledge of all the clients that have been able to
> probe successfully. This part is domain-specific and it works very well
> in the audio driver case.

This need to be hot plug safe. What if the module for this driver is
not available until later in boot? What if the user unplugs the
driver? What if the kernel runs probing single threaded?

It is really unlikely you can both have the requirement that things be
synchronous and also be doing all the other lifetime details properly..

Jason
