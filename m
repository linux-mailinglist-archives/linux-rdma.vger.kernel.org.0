Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74EA01DD80D
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2020 22:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729914AbgEUUKL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 May 2020 16:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728091AbgEUUKL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 May 2020 16:10:11 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B50C061A0E
        for <linux-rdma@vger.kernel.org>; Thu, 21 May 2020 13:10:11 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id x12so6533951qts.9
        for <linux-rdma@vger.kernel.org>; Thu, 21 May 2020 13:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oNL6vUVBE5i1Fy8LRbQUDDCfW8tsfMHNx5GWuJIt/tQ=;
        b=AiGUnC/PBOl4xztPC9gqmUjkmX9dt8uaS/hxBzl2d+WY0v88QTDUx8wOhZyOCAsmyT
         NQKOBFv0Y/Sl+pMGcbK3Dvg25jpRWMxv3VR9Qq2wUAlymnpCJ/jt4Nd9D9Ci7lCY6+/a
         ZgXWzIJ7ME1dULFd1bd3Cc/FGKDVOvJ5s+hWN0HonCK5Nb4mNCTSV56R8JbfP27l2v5G
         HSKP5n7FkJZODCG0dvc+iEhK6gEDJ2lSBVeuHY8ThEniASzf6JgET21RXNhnYf3t0oYB
         wUGvmg15p8WRrvbHvCDzlfwbDatYXTuUFJxPTZ8ZtesAuI1LwysLBSVdn994DNOEoufX
         WcQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oNL6vUVBE5i1Fy8LRbQUDDCfW8tsfMHNx5GWuJIt/tQ=;
        b=s/DVSxBx0gom1sx9XjWV+bGIbceER2hYYOHT5B7mW2LdKPoXnLjn74T9XjmUBTJ1q9
         KfpwplO4vharsA3N4QqWviPJ53zZEZpL0C8GOxugr4LAwJ3+aUURcAppqizbGZDpKDqV
         qsMsOfJPTWsKjCPtNyK7XHC18yMx6DhVb0kIK61ls2G4v1rAdw2ecllXEEHJAW607yYA
         8cCI2+jwqvP+Totm3RJsLwxZm2p1SHRZJ4sEx8lBBrHX1W69+jdNle8CPajM9Ni6J6uU
         TkWVOkSPGboDwye/nwYcDLQ4dw9TeOcareQd7USckiDK5qbAGBK6pssFbm3ITUaEIDjb
         AMZg==
X-Gm-Message-State: AOAM533XJyUW1k8Nk/YGqVieaEJzrUkXpMGVG1TJwe5bFLRFRPX9X1Xn
        WOffd4ovVrNkTvTeu2V0LvQAiw==
X-Google-Smtp-Source: ABdhPJxm0Z6qKWwJxy3srpt+zRDDny2jtc/AiIm9UnLxX41M70JLS1kjB9a/grF6briZFiZhDVDrKw==
X-Received: by 2002:aed:23d2:: with SMTP id k18mr12628509qtc.224.1590091810367;
        Thu, 21 May 2020 13:10:10 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id g1sm5974495qkm.123.2020.05.21.13.10.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 May 2020 13:10:09 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jbrW5-00045I-Hj; Thu, 21 May 2020 17:10:09 -0300
Date:   Thu, 21 May 2020 17:10:09 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     Parav Pandit <parav@mellanox.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Dave Ertman <david.m.ertman@intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "nhorman@redhat.com" <nhorman@redhat.com>,
        "sassmann@redhat.com" <sassmann@redhat.com>,
        "galpress@amazon.com" <galpress@amazon.com>,
        "selvin.xavier@broadcom.com" <selvin.xavier@broadcom.com>,
        "sriharsha.basavapatna@broadcom.com" 
        <sriharsha.basavapatna@broadcom.com>,
        "benve@cisco.com" <benve@cisco.com>,
        "bharat@chelsio.com" <bharat@chelsio.com>,
        "xavier.huwei@huawei.com" <xavier.huwei@huawei.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        "mkalderon@marvell.com" <mkalderon@marvell.com>,
        "aditr@vmware.com" <aditr@vmware.com>,
        "ranjani.sridharan@linux.intel.com" 
        <ranjani.sridharan@linux.intel.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        Kiran Patil <kiran.patil@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>
Subject: Re: [net-next v4 01/12] Implementation of Virtual Bus
Message-ID: <20200521201009.GD17583@ziepe.ca>
References: <20200520070227.3392100-1-jeffrey.t.kirsher@intel.com>
 <20200520070227.3392100-2-jeffrey.t.kirsher@intel.com>
 <c74808dc-0040-7cef-a0da-0da9caedddd9@mellanox.com>
 <20200521174358.GA3679752@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521174358.GA3679752@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 21, 2020 at 07:43:58PM +0200, gregkh@linuxfoundation.org wrote:
> On Thu, May 21, 2020 at 02:57:55PM +0000, Parav Pandit wrote:
> > Hi Greg, Jason,
> > 
> > On 5/20/2020 12:32 PM, Jeff Kirsher wrote:
> > > From: Dave Ertman <david.m.ertman@intel.com>
> > > 
> > 
> > > +static const
> > > +struct virtbus_dev_id *virtbus_match_id(const struct virtbus_dev_id *id,
> > > +					struct virtbus_device *vdev)
> > > +{
> > > +	while (id->name[0]) {
> > > +		if (!strcmp(vdev->match_name, id->name))
> > > +			return id;
> > 
> > Should we have VID, DID based approach instead of _any_ string chosen by
> > vendor drivers?
> 
> No, because:
> 
> > This will required central place to define the VID, DID of the vdev in
> > vdev_ids.h to have unique ids.
> 
> That's not a good way to run things :)
> 
> Have the virtbus core create the "name", as it really doesn't matter
> what it is, just that it is unique, right?

It is being used like the compatible string in OF. Look at where
"sof-ipc-test" appears in the SOF patches.

So it has to be a compile time static, and it has to be broadly global
in some fashion since it appears in a mod alias.

I don't think the name "sof-ipc-test" is particularly good by these
metrics.

Jason
