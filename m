Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D20672F616C
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Jan 2021 14:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbhANNAt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Jan 2021 08:00:49 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:8395 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbhANNAs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 Jan 2021 08:00:48 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B600040580001>; Thu, 14 Jan 2021 05:00:08 -0800
Received: from localhost (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 14 Jan
 2021 13:00:07 +0000
Date:   Thu, 14 Jan 2021 15:00:04 +0200
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>,
        <linux-rdma@vger.kernel.org>, <dledford@redhat.com>,
        <oren@nvidia.com>, Israel Rukshin <israelr@nvidia.com>
Subject: Re: [PATCH 3/3] IB/isert: simplify signature cap check
Message-ID: <20210114130004.GQ4678@unreal>
References: <20210110111903.486681-1-mgurtovoy@nvidia.com>
 <20210110111903.486681-3-mgurtovoy@nvidia.com>
 <ea24823d-c1e9-d40f-866b-6671a13c08ad@grimberg.me>
 <20210114072938.GM4678@unreal>
 <20210114124939.GG4147@nvidia.com>
 <686825c6-1ec3-4939-edf5-c2dbd47fc8c9@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <686825c6-1ec3-4939-edf5-c2dbd47fc8c9@nvidia.com>
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1610629208; bh=n/OwLn2qSAvXrdbYi6hDFhqLMpUnQeV+fYgPRYZaH5w=;
        h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
         Content-Type:Content-Disposition:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy;
        b=jq4TS+g7tEHBxb72KyWPhYmy3vwH3trdbTiiXmi2d7Wrah/C+NrW0njKRfwovxJGI
         vI7ELFIO5ArOQ/RTBSmKcEjGZh5Bf7RiVACrEha7ZsL7i0ChHqHBpo+sOt9WZg8ftx
         DvDIzbm4ohXUGp2RaEYXr3j9HKMYPxvkoDaRW4+oYPnvmhlD9xzZ5D9IhH4KwX4DeS
         MHi0x/0dp+5e3+QHMkjxYY62xWKw5VQnV2fdvF3qWqmFhitRQrtai3euifOvCIjZ8t
         bNRoj7DQxuR+cYfUosw/3qvnsZW/V/6uRsm5C+dlSyF9WZox3fzAo9vzrKbTiKM+Zl
         9mKZSYbwfBQfw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 14, 2021 at 02:54:29PM +0200, Max Gurtovoy wrote:
>
> On 1/14/2021 2:49 PM, Jason Gunthorpe wrote:
> > On Thu, Jan 14, 2021 at 09:29:38AM +0200, Leon Romanovsky wrote:
> > > On Wed, Jan 13, 2021 at 04:08:29PM -0800, Sagi Grimberg wrote:
> > > > > Use if/else clause instead of "condition ? val1 : val2" to make the code
> > > > > cleaner and simpler.
> > > > Not sure what is cleaner and simpler for a simple condition, but I don't
> > > > mind either way...
> > > Agree, probably even more cleaner variant will be:
> > >   device->pi_capable = !!(ib_dev->attrs.device_cap_flags & IB_DEVICE_INTEGRITY_HANDOVER);
> > Gah, !! is rarely a sign of something good..
>
> can we take the series as-is ?

Of course :)

Thanks
