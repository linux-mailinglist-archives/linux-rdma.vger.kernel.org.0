Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71AA21BE1D8
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2020 16:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgD2O5i (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Apr 2020 10:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgD2O5i (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Apr 2020 10:57:38 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE19EC03C1AD
        for <linux-rdma@vger.kernel.org>; Wed, 29 Apr 2020 07:57:37 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id p13so1246625qvt.12
        for <linux-rdma@vger.kernel.org>; Wed, 29 Apr 2020 07:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=79qpgmDRjIWqC9U1j4XIhqJV4nHCI0S/uKYmuzu2TJU=;
        b=U/jDKxuhIURFQUk+6m1GF+g3dj6tUHO5QV2v7G1+xXu8r257sk62MvEVTRTdJiOSwA
         fnxKJRIJY2ZcY5HbIz+HF7Pd3hbKh0RkuuOABYjW1eAbkjffEb4MWbDQt1w+TPR2A1Ja
         MIERmwn6yK/sTou8hJF5sgFdclJAAetrF0U8YHqdDpM5woZ1LHKe3fnyMoxew+VzZQBI
         G1MBfVs+YFDSvmxciEOfa9L/NEjPYUYFbfa1QsBrnCIcaS7b755pssRxOfGSdyHOdZEx
         BLDT2JNrKDWf5sZGFQ1LG4Y7o3jq9wSAJ7dv38hh5ERnNUtixq2jSVJBOrvcrBJwORP1
         gehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=79qpgmDRjIWqC9U1j4XIhqJV4nHCI0S/uKYmuzu2TJU=;
        b=AeMSpml9CfOoY+4kQFNeG1AD+q2VvCbPuOPGg561/DCaz71lbLe5glHHm9dQsdSF2b
         /1srAUe74FPZCLHnmnoa/ES8RZqJqPL4XLlwmWKdPcd2uoI0Ztv2ZM4KjTn2voQmvuXq
         ukqKCv8GMZUS/STYiddQJe6eVScvkDna2f3mBFwdthsxkXaPQ7rVWz03lCPbX4KvGk1m
         AFL7dVvOKZ9B3QsGRrRBuICheuQbxMkV/BfdrX4erdkUwxuxJQgzg2P/dQ9gUcyE4Y5k
         MSbeM5azihwrcjHqQezYMgVYu+SC+f63PcXn9AwiWTUzsH0Xgfc7UGkwgTr7t+rMIlIl
         DI8g==
X-Gm-Message-State: AGi0PuZABA800zkMgjOL9tyQva9BOGtW/gSneX+yyM7+R67N3k87cazY
        EQixy6a1H2l0aDAwHJQB7XlGYA==
X-Google-Smtp-Source: APiQypL7c/klV6w0rnKrz09pJHJzC+P5RFQO+fWdKybU7tHaFViNnz/hYa8TGRwaOQAOu7Io//K3RA==
X-Received: by 2002:a05:6214:1812:: with SMTP id o18mr34296920qvw.64.1588172256961;
        Wed, 29 Apr 2020 07:57:36 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id m40sm17096803qtc.33.2020.04.29.07.57.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Apr 2020 07:57:36 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jTo9X-0005h7-N7; Wed, 29 Apr 2020 11:57:35 -0300
Date:   Wed, 29 Apr 2020 11:57:35 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     "Saleem, Shiraz" <shiraz.saleem@intel.com>,
        Weihang Li <liweihang@huawei.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "selvin.xavier@broadcom.com" <selvin.xavier@broadcom.com>,
        "devesh.sharma@broadcom.com" <devesh.sharma@broadcom.com>,
        "somnath.kotur@broadcom.com" <somnath.kotur@broadcom.com>,
        "sriharsha.basavapatna@broadcom.com" 
        <sriharsha.basavapatna@broadcom.com>,
        "bharat@chelsio.com" <bharat@chelsio.com>,
        "galpress@amazon.com" <galpress@amazon.com>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        "Latif, Faisal" <faisal.latif@intel.com>,
        "yishaih@mellanox.com" <yishaih@mellanox.com>,
        "mkalderon@marvell.com" <mkalderon@marvell.com>,
        "aelior@marvell.com" <aelior@marvell.com>,
        "benve@cisco.com" <benve@cisco.com>,
        "neescoba@cisco.com" <neescoba@cisco.com>,
        "pkaustub@cisco.com" <pkaustub@cisco.com>,
        "aditr@vmware.com" <aditr@vmware.com>,
        "pv-drivers@vmware.com" <pv-drivers@vmware.com>,
        "monis@mellanox.com" <monis@mellanox.com>,
        "kamalheib1@gmail.com" <kamalheib1@gmail.com>,
        "parav@mellanox.com" <parav@mellanox.com>,
        "markz@mellanox.com" <markz@mellanox.com>,
        "rd.dunlab@gmail.com" <rd.dunlab@gmail.com>
Subject: Re: [PATCH for-next] RDMA/core: Assign the name of device when
 allocating ib_device
Message-ID: <20200429145735.GB26002@ziepe.ca>
References: <1587893517-11824-1-git-send-email-liweihang@huawei.com>
 <9DD61F30A802C4429A01CA4200E302A7DCD54BBA@fmsmsx124.amr.corp.intel.com>
 <20200428000428.GP26002@ziepe.ca>
 <9a875620-3f11-22ee-b908-59c8e49e3b24@intel.com>
 <20200429135015.GA26002@ziepe.ca>
 <5f5e104c-00fd-d08d-f2b2-f62f5f4950ff@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f5e104c-00fd-d08d-f2b2-f62f5f4950ff@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Apr 29, 2020 at 10:33:19AM -0400, Dennis Dalessandro wrote:
> > > The issue is hfi1 calls into rvt_alloc_device() which then calls
> > > _ib_alloc_device(). We don't have the name set at that point. So the obvious
> > > thing to do is move the rvt_set_ibdev_name(). However there is a catch.
> > > 
> > > The name gets set after allocating the device and the device table because
> > > we get the unit number as part of the xa_alloc_irq(hfi1_dev_table) call
> > > which needs the pointer to the devdata.
> > > 
> > > One solution would be to pass in the pointer for the driver's dev table and
> > > let rvt_alloc_device() do the xa_alloc_irq().
> > 
> > Just do:
> > 
> > 	ret = xa_alloc_irq(&hfi1_dev_table, &unit, NULL, xa_limit_32b,
> > 			GFP_KERNEL);
> >          if (ret)
> >                  return ERR_PTR(ret);
> > 
> > 	dd = (struct hfi1_devdata *)rvt_alloc_device(sizeof(*dd) + extra,
> > 						     nports, unit);
> > 	if (!dd) {
> > 		xa_erase(&hfi1_dev_table, unit);
> > 		return ERR_PTR(-ENOMEM);
> > 	}
> > 	xa_store(&hfi1_dev_table, unit, dd, GFP_KERNEL);
> 
> That works too.

I don't understand why this xarray exists anyhow? Why can't the core
code assign the name with its internal algorithm?

There are several places that iterate over the xarray, but that
doesn't need a unit #, could be a linked list or use the core device
list.

The only actual lookup in hfi1_reset_device() looks pointless, the
caller already has the dd??

Jason
