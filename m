Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36ACD2913B6
	for <lists+linux-rdma@lfdr.de>; Sat, 17 Oct 2020 20:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438674AbgJQSm6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 17 Oct 2020 14:42:58 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:1972 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438673AbgJQSm5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 17 Oct 2020 14:42:57 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f8b3b040001>; Sat, 17 Oct 2020 11:42:12 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 17 Oct
 2020 18:42:57 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Sat, 17 Oct 2020 18:42:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nRUSS30cyS+grwdzxIqlqe/OjUUDzDTdsm/7c6fjkpsSBIYo6QNysWcseOEK4Wa6644hFFZnDVIJmvrLU2Quv2Bh0vySrJNNnvxE1IIWH+3NwsnGkMITsQh9v843HoWzbI4Bj++jdAY9CFXxpNf0P4mO/amv2aVHZJLB6b7weN2ofF+A48YygJ5pdvCRvvnilEKtjSMLRTMdij+0U+MIIl62FU6eC1M3qmIPY/o+yp9ymkONEOUIZxI6xveng3Tl0QUH7c9H0VXGgDZAoqykkYM4UmPZOU2/4eeR9Xhc75Na1j+JCOxcb857wV5JxrbBo8wJkgexyhhENL9I6s7QkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KzP+htiiF4tce2W8b+TxtYwBm3IuzQ5qglaVm6eWxIc=;
 b=ZcuMJlVH0KoIwC4nTta1cVng2JWuYGkHnvQkyoFNJpbiSZb1duxZlIBEpju3c5sq9aycBHBoGPDNbTPR0olEs+v34bXQlSwEOe6Lp0dvQdg7vxaQMnv1v1CbIrxlaEY3MpTB7KngRmRruk6f6HGZ7lC/NAcVvOjsz/J77LzsGn2L56nJIMJcDCdrn3SgZgGnGd5DxOp0rkFhmrCpjHkfxs8QstZvSrkdFmKmLyZ1arUg43ydGAGP4V0c5jrzpeZ4bjRCshsoLsEWWHzivTUpuCkLfA69LovDfhoXYRj47wmp7QXG83j8bELIqz+y2g9lowixj+jCVR64Z3Q54Y/6GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4636.namprd12.prod.outlook.com (2603:10b6:5:161::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.23; Sat, 17 Oct
 2020 18:42:55 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3477.027; Sat, 17 Oct 2020
 18:42:55 +0000
Date:   Sat, 17 Oct 2020 15:42:54 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Doug Ledford <dledford@redhat.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20201017184254.GA6219@nvidia.com>
References: <20201016185155.GA233060@nvidia.com>
 <CAHk-=wijsaWEh-Lz-2_6RwuaXyRCr4SREq7HshzNCKOxKvQhyA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAHk-=wijsaWEh-Lz-2_6RwuaXyRCr4SREq7HshzNCKOxKvQhyA@mail.gmail.com>
X-ClientProxiedBy: BL1PR13CA0256.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::21) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL1PR13CA0256.namprd13.prod.outlook.com (2603:10b6:208:2ba::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.4 via Frontend Transport; Sat, 17 Oct 2020 18:42:55 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kTrAM-001gia-2P; Sat, 17 Oct 2020 15:42:54 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1602960132; bh=KzP+htiiF4tce2W8b+TxtYwBm3IuzQ5qglaVm6eWxIc=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=bYNaimiN15Z+dkc9+Ax0ftLgxJJamxk3qAfnL0cE4TfWhnTJ2BfePLpGLiQITLF/o
         15iqkLR+zLJfdBFrZMnX+N5JGlGn61A8RmCZMDCfZzL9BTZwnRBsOKRQbu40XC47GN
         0urxUD+Mn6VTKTqyHSZkaZvc89gzEz4FAmEdQOOzbsel0t4LQAIyY+AuNyodMu+hN7
         zGMS+9oSem9AGvxJZj0KD/FIg8Y2DMvA5H5eLfzOw+XSfCNc52qJ5dx89U2pbjrqmk
         smpo9KD7io0FSq6MyXzsTSPv7lXOYnol+ExCJqdQj3tKsaQ6T0CzgGpRjY+7VIIF12
         Y45dsTP0vF7dQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Oct 17, 2020 at 11:21:51AM -0700, Linus Torvalds wrote:
> On Fri, Oct 16, 2020 at 11:52 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > You'll need to apply this fixup to the merge commit (it is in the tag
> > for-linus-merged for reference):
> 
> Ugh. That's unbelievably and unnecessarily ugly.
> 
> There's no point in that unnecessary "ret" variable and the "goto out"
> etc, when all the error cases can be handled much more directly.

Yep

> So I resolved that merge issue somewhat differently. I can't test the
> end result, but it looks TriviallyCorrect(tm).
> 
> Famous last words. Feel free to make fun of me and call me names if that breaks.

Not familiar with DRM land, but it looks trivially fine to me too.

Thanks,
Jason
