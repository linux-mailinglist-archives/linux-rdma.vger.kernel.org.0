Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA46518D5DF
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2020 18:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgCTRdq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Mar 2020 13:33:46 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38392 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgCTRdq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Mar 2020 13:33:46 -0400
Received: by mail-qk1-f195.google.com with SMTP id h14so7719074qke.5
        for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2020 10:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5ycq5RmtBUTlaCvnY0x79sixu+ZR8/7hTMQWf9AVGI4=;
        b=TFkmudOo4QHbiWMKioQTT8pZD++Kn3KsDNOGkSStrAb3bDjLwDWj/LvZJUgWGZ8FBv
         UnqT2pABT/5yZhyIpFn3Tm5ZkmBBXwqCyOqwW0z6S0pQzrxQPr3RifoH7BPkkrCn/X3h
         FvRkxoH2thbH7qzZ9I13kkUhINFh6ddrDfp4t/9UmC/XV8JDHv01fR+Bta7vR+Bh+1yl
         NN5aFJ6rvRr3mWBN5LIC12ynL0HHP/eqo7OZcsAK4nVyJhdcx4X0P4UaTNvuLV3HuhIz
         9FI5PULa+B3ie9LjrCdiqmW257UnuKu+qeehwfflew0sf72BXYmyu68kNoBFNuceuptm
         NINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5ycq5RmtBUTlaCvnY0x79sixu+ZR8/7hTMQWf9AVGI4=;
        b=eFWS3oRUX/DDxAs6wMn3b9N8ub+NLNP4+ah3L2MVf1VCHhKWJO4Tq0XqMxP+CEMNNS
         fxIRRcZoSEainGOtaHejohT4jJ9TtO5qKskWbbLf0QPzHbBDSHHGDxdTadZoPcL7o/11
         tX2WnaVjIiz6zDcGN8kFLHhDIiO6s+KC8u7aRtAtBv1jvurJmyO2BTDXULSE9jPEDooT
         CzF/UZP7Uk80kkAnP6Xjh5lYGq+ylA3EaHel15WR14vZU/sCoJ0MNHX+vRQsNUMkgsQy
         azOs4hA42Pu7oILTWWwh0zbBYC6JDpXQ+Otz83ACinMPIhZYIM10QOd/6SHR0gnr7joF
         uiow==
X-Gm-Message-State: ANhLgQ0GRVYFMHqrRx1vvydwMR39i6kRkgKDliO09aywS6tOO4/nFfnG
        U1qGhrVd4eQJINhlRb+HKAhr3A==
X-Google-Smtp-Source: ADFU+vu5Xk6z4kV7tKXAjlHhHDhT6Zxuev/MCac1F9w3wl9Aex1B3BlUtEM2aqT5uWCub+EydfZvSg==
X-Received: by 2002:a37:4901:: with SMTP id w1mr2545356qka.427.1584725624496;
        Fri, 20 Mar 2020 10:33:44 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id 16sm4753354qkk.79.2020.03.20.10.33.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Mar 2020 10:33:43 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jFLWh-0000rf-Bv; Fri, 20 Mar 2020 14:33:43 -0300
Date:   Fri, 20 Mar 2020 14:33:43 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Wan, Kaike" <kaike.wan@intel.com>
Cc:     "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
Subject: Re: [PATCH for-next 3/3] IB/hfi1: Use the ibdev in hfi1_devdata as
 the parent of cdev
Message-ID: <20200320173343.GU20941@ziepe.ca>
References: <20200316210246.7753.40221.stgit@awfm-01.aw.intel.com>
 <20200316210507.7753.42347.stgit@awfm-01.aw.intel.com>
 <20200318231830.GA9586@ziepe.ca>
 <MW3PR11MB46651022C7EFD74C856675E1F4F50@MW3PR11MB4665.namprd11.prod.outlook.com>
 <20200320163227.GS20941@ziepe.ca>
 <MW3PR11MB46657936C2E8286A3CB2234CF4F50@MW3PR11MB4665.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW3PR11MB46657936C2E8286A3CB2234CF4F50@MW3PR11MB4665.namprd11.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 20, 2020 at 05:30:40PM +0000, Wan, Kaike wrote:

> > > If this is not desirable, we could keep the current approach to create
> > > the struct device dynamically through device_create(). In that case,
> > > all we need to do is to clean up the code. Which one do you prefer?
> > 
> > The issue here was parentage. There should not be a virtual device involved.
> > 
> > The hfi1 user_class device should be parented to the ib_device, look at how
> > things like umad work to do this properly.
> So all we need to do is:
> -- Change user_device from struct device * to struct device in hfi1_devdata;
> -- Set up dd->user_device properly including setting its parent to ib_device;
> -- call cdev_device_all().

Yes, but keep in mind that putting multiple krefs inside the same
structure is very tricky - be sure to do it right.

Jason
