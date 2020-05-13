Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEB71D134D
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2020 14:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbgEMMys (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 May 2020 08:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728313AbgEMMyr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 May 2020 08:54:47 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09925C061A0C
        for <linux-rdma@vger.kernel.org>; Wed, 13 May 2020 05:54:46 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j5so20774962wrq.2
        for <linux-rdma@vger.kernel.org>; Wed, 13 May 2020 05:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WsGW+BcapDfAt0upcHEJqwAxG4BGPPJOO76I/YUR6sM=;
        b=HuG5ZpcB9J1+lh33ZfEBoitaCQ4uQkjRT9Z6FCFbyK1U8GztmBk4AQN6TIs2FKx1dk
         20dZ2uhfRF9R+S4W379y4w0yIAl3c27466jKJCrI6Qatbp11n+ZTUC3kNOy9stS10w9U
         +NK9EiAVl9fBCNuoVFrrD9/vXQn92ZHhHfqGH25Lp0uuU+nj0b34fBknwye9bzlWoBYS
         +PAcpTyhEaeIyQDj92fN3aWFhw4/d2yAoda1DTZNtdh2xHpnN7wOSbG/jyMzkBsVbLod
         1BTRj1hFPJ24mDKzbe6sHEcSp8quRoB1hLvV/d/Mz27QrZeSRmvyGBb2u93ZUxKAVR4f
         0Qhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WsGW+BcapDfAt0upcHEJqwAxG4BGPPJOO76I/YUR6sM=;
        b=gGRTrfnBF5RQH1Nad2/7ASIhDHNt8Xaukf0/OJz4Qi5JByse4OySPwEJgK0A4y6Fzm
         VsJBSCWpz36BV9tqdepHgOzZnjnQU6OUUlW2OM85Kh96j4zG6yTHLPZY29ke5HqEBmL3
         2PqBTpFemaxu8VylXFSWWdV7zSMswW054hart3j8dpZXUO9OQdNQIwpvuEXx61vqRLwp
         /+cNaQSpm5fv5NdrSVo+5SrNDBgEVMGUMJqGAvHGiw7dILpDgpkegoslIN8j0Xcd7Syf
         I158ZVDzaaz39+SpRY4mn1iWQ+LorslPuO16ei/cl77Hznj+kmFIrSN6BCHmxSJ6HvGH
         LSrQ==
X-Gm-Message-State: AGi0PubxdOE7QONK84V/6e6rN7GguUtNGgJrXcCwhbKebGhnMfrW3JNf
        kunmueRWNRc/iuAeQG4gtUU=
X-Google-Smtp-Source: APiQypIhLJGzjs8ev0tceCB8O2tj4xSj7UmAM9exEfy7hTmkJvdI0y75Icj2LsNOaJffmL4ZapZKcw==
X-Received: by 2002:adf:e50d:: with SMTP id j13mr17893199wrm.383.1589374484770;
        Wed, 13 May 2020 05:54:44 -0700 (PDT)
Received: from kheib-workstation ([37.142.4.4])
        by smtp.gmail.com with ESMTPSA id s14sm33899576wmh.18.2020.05.13.05.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 05:54:44 -0700 (PDT)
Date:   Wed, 13 May 2020 15:54:41 +0300
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH for-rc] RDMA/srpt: Fix disabling device management
Message-ID: <20200513125441.GA124733@kheib-workstation>
References: <20200511222918.62576-1-kamalheib1@gmail.com>
 <20200513072203.GR4814@unreal>
 <20200513100204.GA92901@kheib-workstation>
 <20200513102132.GW4814@unreal>
 <20200513104536.GA120318@kheib-workstation>
 <1e5e1e3b-7e18-50a0-6133-db76c39985be@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e5e1e3b-7e18-50a0-6133-db76c39985be@amazon.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 13, 2020 at 02:59:21PM +0300, Gal Pressman wrote:
> On 13/05/2020 13:45, Kamal Heib wrote:
> > On Wed, May 13, 2020 at 01:21:32PM +0300, Leon Romanovsky wrote:
> >> On Wed, May 13, 2020 at 01:02:04PM +0300, Kamal Heib wrote:
> >>> On Wed, May 13, 2020 at 10:22:03AM +0300, Leon Romanovsky wrote:
> >>>> On Tue, May 12, 2020 at 01:29:18AM +0300, Kamal Heib wrote:
> >>>>> Avoid disabling device management for devices that don't support
> >>>>> Management datagrams (MADs) by checking if the "mad_agent" pointer is
> >>>>> initialized before calling ib_modify_port, also change the error message
> >>>>> to a warning and make it more informative.
> >>>>>
> >>>>> Fixes: 09f8a1486dca ("RDMA/srpt: Fix handling of SR-IOV and iWARP ports")
> >>>>> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> >>>>> ---
> >>>>>  drivers/infiniband/ulp/srpt/ib_srpt.c | 8 ++++++--
> >>>>>  1 file changed, 6 insertions(+), 2 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
> >>>>> index 7ed38d1cb997..7b21792ab6f7 100644
> >>>>> --- a/drivers/infiniband/ulp/srpt/ib_srpt.c
> >>>>> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
> >>>>> @@ -625,14 +625,18 @@ static void srpt_unregister_mad_agent(struct srpt_device *sdev)
> >>>>>  		.clr_port_cap_mask = IB_PORT_DEVICE_MGMT_SUP,
> >>>>>  	};
> >>>>>  	struct srpt_port *sport;
> >>>>> +	int ret;
> >>>>>  	int i;
> >>>>>
> >>>>>  	for (i = 1; i <= sdev->device->phys_port_cnt; i++) {
> >>>>>  		sport = &sdev->port[i - 1];
> >>>>>  		WARN_ON(sport->port != i);
> >>>>> -		if (ib_modify_port(sdev->device, i, 0, &port_modify) < 0)
> >>>>> -			pr_err("disabling MAD processing failed.\n");
> >>>>>  		if (sport->mad_agent) {
> >>>>> +			ret = ib_modify_port(sdev->device, i, 0, &port_modify);
> >>>>> +			if (ret < 0)
> >>>>> +				pr_warn("%s-%d: disabling device management failed (%d). Note: this is expected if SR-IOV is enabled.\n",
> >>>>> +					dev_name(&sport->sdev->device->dev),
> >>>>
> >>>> The ib_modify_port() shouldn't be called if it expected to fail.
> >>>>
> >>>> Thanks
> >>>
> >>> OK, Do you know if there is a way to check if the created ib device is
> >>> for VF to avoid calling ib_modify_port()?
> >>
> >> The "is_virtfn" field inside pci_dev will give this information,
> >> but I don't know why it is expected to fail here.
> >>
> >> Thanks
> >>
> > 
> > Looks like there a more trivial way, I mean checking if
> > IB_DEVICE_VIRTUAL_FUNCTION cap is set, probably there is a need to make
> > to sure that this cap is set for all providers when the IB device is
> > created for a VF.
> 
> It's not, I think this bit is used for ipoib stuff only or something?

Yes, this cap is set only by the mlx5_ib driver for the IPoIB enhanced
mode.

Thanks,
Kamal
