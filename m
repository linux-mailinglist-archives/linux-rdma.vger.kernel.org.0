Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24CF3168A6B
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Feb 2020 00:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgBUXcw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Feb 2020 18:32:52 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35440 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgBUXcw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Feb 2020 18:32:52 -0500
Received: by mail-qt1-f194.google.com with SMTP id n17so2564377qtv.2
        for <linux-rdma@vger.kernel.org>; Fri, 21 Feb 2020 15:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b7kxxoYI0+NyUbP95qI0zqeVXhKMFIqoa3u3az2cSmU=;
        b=H4BCfH5BSFPNgo1m2h4YlW58BFSHedgyJxIheW5+WI5NsQPppM/6eKLjVOQUpIJeeS
         k1OQtch7qOBTck9p+44SzNAN/vVS4dd3tR9AiHPNE/yfz5GqEvuoo3/XbQ9ETmXO7ysl
         yj8Onh3MJaAd2ZmDzg2EofjWINDoOi4LUSs6t69AYhUfDD+6B6nga2F8k8iwKSMGkYvX
         eWrRxo/SvL1JCMjMLV+qvqIuVoQpQLVL5YaG1bLzRDQ4GMA9YAG9ALHItaurPqG3H5es
         QbPVkq8y81BlVjJj02UsCF1zFPAD1Cwpdhu5iEu/vVVz1/sNKu3NgMtXkd7q6IPPXQrZ
         ULhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b7kxxoYI0+NyUbP95qI0zqeVXhKMFIqoa3u3az2cSmU=;
        b=Gh6N0pemO+pOBB9yzhjZ5ZCCIG5XAmI5jalEEEOaY+My5yuOycqWVKEVROE68Bawa+
         qMKFAoiq96CHaskKlRwL8HnHv6+OmfpxjOlr1TaPGvPtNrh4UYztI1Ia63bi2gjTqcgR
         u6lqmCzuUjsctb1s4A0nTwucOs29D75gblSdpemH7ciId6ll0V4jZKoZsc44OxLYDVfc
         P2GcUniXrfv92okmQNo8hlLlXzgk0qiy7i5gVutldbmkOb4L/wtgJl7bqb9dW3kTtSC+
         7XIoE5cm1cEOmoenGVRURcE46eM7TGxpdPwulUEB7pw7+VE5wFghNsLyTvwkNlysIIPY
         LWbA==
X-Gm-Message-State: APjAAAUKFEe7kH678ZXgJf4GmLHPym0VLMm1DdiAM5FSDJW96cf8lton
        Tb5qz/iO+f2CYczdUqQmVMzAoQ==
X-Google-Smtp-Source: APXvYqw3CnV2VdXEHvTUGY4EPMwU880Y3v3XtM/KqWq2XMUTyOewWR44LVdoQxgwE/avbSINDwOcqA==
X-Received: by 2002:ac8:2902:: with SMTP id y2mr21307317qty.258.1582327970753;
        Fri, 21 Feb 2020 15:32:50 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id o187sm2261137qkf.26.2020.02.21.15.32.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Feb 2020 15:32:50 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j5Hmr-0006ve-96; Fri, 21 Feb 2020 19:32:49 -0400
Date:   Fri, 21 Feb 2020 19:32:49 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.alessandro@intel.com>,
        Gary Leshner <Gary.S.Leshner@intel.com>,
        Kaike Wan <kaike.wan@intel.com>
Subject: Re: [PATCH for-next 13/16] IB/{hfi1, ipoib, rdma}: Broadcast ping
 sent packets which exceeded mtu size
Message-ID: <20200221233249.GM31668@ziepe.ca>
References: <20200210131223.87776.21339.stgit@awfm-01.aw.intel.com>
 <20200210131944.87776.64386.stgit@awfm-01.aw.intel.com>
 <20200219004249.GA24178@ziepe.ca>
 <2c91a053-add3-a7f9-2da1-f56f4c70381d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c91a053-add3-a7f9-2da1-f56f4c70381d@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 21, 2020 at 02:40:28PM -0500, Dennis Dalessandro wrote:
> On 2/18/2020 7:42 PM, Jason Gunthorpe wrote:
> > On Mon, Feb 10, 2020 at 08:19:44AM -0500, Dennis Dalessandro wrote:
> > > From: Gary Leshner <Gary.S.Leshner@intel.com>
> > > 
> > > When in connected mode ipoib sent broadcast pings which exceeded the mtu
> > > size for broadcast addresses.
> > > 
> > > Add an mtu attribute to the rdma_netdev structure which ipoib sets to its
> > > mcast mtu size.
> > > 
> > > The RDMA netdev uses this value to determine if the skb length is too long
> > > for the mtu specified and if it is, drops the packet and logs an error
> > > about the errant packet.
> > 
> > I'm confused by this comment, connected mode is not able to use
> > rdma_netdev, for various technical reason, I thought?
> > 
> > Is this somehow running a rdma_netdev concurrently with connected
> > mode? How?
> 
> No, not concurrently. When ipoib is in connected mode, a broadcast request,
> something like:
> 
> ping -s 2017 -i 0.001 -c 10 -M do -I ib0 -b 192.168.0.255
> 
> will be sent down from user space to ipoib. At an mcast_mtu of 2048, the max
> payload size is 2016 (2048 - 28 - 4). If AIP is not being used then the
> datagram send function (ipoib_send()) does a check and drops the packet.
> 
> However when AIP is enabled ipoib_send is of course not used and we land in
> rn->send function. Which needs to do the same check.

You just contradicted yourself: the first sentence was 'not
concurrently' and here you say we have connected mode turned on and
yet a packet is delivered to AIP, so what do you mean?

What I mean is if you can do connected mode you don't have a
rdma_netdev and you can't do AIP.

How are things in connected mode and a rdma_netdev is available?

Jason
