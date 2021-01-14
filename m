Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66A2A2F616B
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Jan 2021 14:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbhANNAM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Jan 2021 08:00:12 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:8307 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728772AbhANNAI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 Jan 2021 08:00:08 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6000402f0001>; Thu, 14 Jan 2021 04:59:27 -0800
Received: from localhost (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 14 Jan
 2021 12:59:26 +0000
Date:   Thu, 14 Jan 2021 14:59:23 +0200
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        <linux-rdma@vger.kernel.org>, <dledford@redhat.com>,
        <oren@nvidia.com>, Israel Rukshin <israelr@nvidia.com>
Subject: Re: [PATCH 3/3] IB/isert: simplify signature cap check
Message-ID: <20210114125923.GP4678@unreal>
References: <20210110111903.486681-1-mgurtovoy@nvidia.com>
 <20210110111903.486681-3-mgurtovoy@nvidia.com>
 <ea24823d-c1e9-d40f-866b-6671a13c08ad@grimberg.me>
 <20210114072938.GM4678@unreal>
 <20210114124939.GG4147@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210114124939.GG4147@nvidia.com>
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1610629167; bh=b8s7Vm8a98bxKAaPzT9DXeaLUolgMIt1FYksj7bvdEI=;
        h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
         Content-Type:Content-Disposition:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy;
        b=PXOa+WeQre2jSJYIDm8tzcX+Zu9wjK/nO1Z5V/ms4F7kgK6A7qHffxHl53sODb+on
         rXeYEDJAq/qD6r+It7hy2y1lqkfPzYjjIr4zxsxbSj+TB9oAZiP5zPRLEl28/GqqzX
         p+iu22h0WTL64eNVkEpSse3KBcwfon2faxB+iX6mg08O6j/C7rnE2h0fk4XFWpu0DN
         XVh67JvFizps0mnJG1un2sbtPKlpr+lpYOJmKCj1kTaZCEOxeeeyuEG68pg6ERC8d1
         FHmSOAQXsMCTkWvy8bhNwdQYNz0cwb/yPEAt+mhS02xkyNtyR9iAKoy3Kx1kmwK2Ah
         awMYem3u4SPvg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 14, 2021 at 08:49:39AM -0400, Jason Gunthorpe wrote:
> On Thu, Jan 14, 2021 at 09:29:38AM +0200, Leon Romanovsky wrote:
> > On Wed, Jan 13, 2021 at 04:08:29PM -0800, Sagi Grimberg wrote:
> > >
> > > > Use if/else clause instead of "condition ? val1 : val2" to make the code
> > > > cleaner and simpler.
> > >
> > > Not sure what is cleaner and simpler for a simple condition, but I don't
> > > mind either way...
> >
> > Agree, probably even more cleaner variant will be:
> >  device->pi_capable = !!(ib_dev->attrs.device_cap_flags & IB_DEVICE_INTEGRITY_HANDOVER);
>
> Gah, !! is rarely a sign of something good..

You see, three of us see same code differently.

>
> Jason
