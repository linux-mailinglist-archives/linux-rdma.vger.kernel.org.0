Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0D61D9967
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2020 16:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgESOTc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 May 2020 10:19:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:55700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729321AbgESOTc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 19 May 2020 10:19:32 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D018720829;
        Tue, 19 May 2020 14:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589897971;
        bh=sEoPkILyG64/WP+s/pAV7BNWiw76O/7gtsuLaZgR0A0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wtoldMsXvB4rjfaeaMqh1oJWkmvgH2l3zejzaqJ5OyX43ciE5Mn4JN321R26PjxvA
         z684C7hpT410wCo+TQuNx7X+jOV7AfAbrvM7F+4f67jRkD1WCQFpvenBzQosAuXyAa
         Ys1+vNgef8u6cq7Sl7ZRrubifMqx2pOv5fpFWFrM=
Date:   Tue, 19 May 2020 17:19:27 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Max Gurtovoy <maxg@mellanox.com>, bvanassche@acm.org,
        linux-rdma@vger.kernel.org, dledford@redhat.com, sagi@grimberg.me,
        israelr@mellanox.com, shlomin@mellanox.com,
        "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
Subject: Re: [PATCH 0/8 v1] Remove FMR support from RDMA drivers
Message-ID: <20200519141927.GR188135@unreal>
References: <20200514120305.189738-1-maxg@mellanox.com>
 <f2efe2df-14db-4e15-3807-f81b799cc0ec@intel.com>
 <20200518181035.GM24561@mellanox.com>
 <03238a7d-d3f3-7859-deb9-dd0a04fbe9ed@intel.com>
 <20200519135352.GV24561@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519135352.GV24561@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 19, 2020 at 10:53:52AM -0300, Jason Gunthorpe wrote:
> On Tue, May 19, 2020 at 09:43:14AM -0400, Dennis Dalessandro wrote:
> > On 5/18/2020 2:10 PM, Jason Gunthorpe wrote:
> > > On Mon, May 18, 2020 at 11:20:04AM -0400, Dennis Dalessandro wrote:
> > > > On 5/14/2020 8:02 AM, Max Gurtovoy wrote:
> > > > > This series removes the support for FMR mode to register memory. This ancient
> > > > > mode is unsafe and not maintained/tested in the last few years. It also doesn't
> > > > > have any reasonable advantage over other memory registration methods such as
> > > > > FRWR (that is implemented in all the recent RDMA adapters). This series should
> > > > > be reviewed and approved by the maintainer of the effected drivers and I
> > > > > suggest to test it as well.
> > > > >
> > > > > The tests that I made for this series (fio benchmarks and fio verify data):
> > > > > 1. iSER initiator on ConnectX-4
> > > > > 2. iSER initiator on ConnectX-3
> > > > > 3. SRP initiator on ConnectX-4 (loopback to SRP target)
> > > > > 4. SRP initiator on ConnectX-3
> > > > >
> > > > > Not tested:
> > > > > 1. RDS
> > > > > 2. mthca
> > > > > 3. rdmavt
> > > >
> > > > This will effectively kill qib which uses rdmavt. It's gonna have to be a
> > > > NAK from me.
> > >
> > > Are you objecting the SRP and iSER changes too?
> >
> > No, just want to keep basic verbs support at least. NFS already dropped,
> > similarly we are ok with dropping it from SRP/iSER as a next step.
>
> So you see a major user in RDS for qib?

Didn't we agree to drop it from RDS too?

Thanks

>
> Jason
