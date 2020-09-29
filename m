Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29CEA27D5BF
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Sep 2020 20:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbgI2S1X (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Sep 2020 14:27:23 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:16127 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727841AbgI2S1X (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 29 Sep 2020 14:27:23 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f737c580000>; Tue, 29 Sep 2020 11:26:32 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 29 Sep
 2020 18:27:22 +0000
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.42) by
 HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 29 Sep 2020 18:27:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QnK/sebswN1w7fckgJUA72BLieZcAvkGUVSqpQVMKBRUjrkwPZPoQpRrMMx6ghHwoS1wPnGUmk+yvIGttUKTCw8RtIeU/kl6iAMnrdqWtHcTjgF/9zANqxF3aEXmbYYGWOQq786dkGCc0HnHF2b9CZtiBC226Y2pen0YeKAZivZNIW/zHp0FnN/xfrdT3phnelpSKLS/sUbwo8zSQXA/4LcIwkQqEkkxtzj2Tq+m02IA9Yf9cD7xXyvoTivZO+IdHhw+D26dJmcAC5auXZ8f7OSLORgfbm8V9YuvCm11FQhN1Nr+MJgZ4XnTOY0I3cnA1QhI6TwJ3bN5uQtgbYrHXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXf9TW99TvitNOdU0PaPYZhFVPS7mPxOg2WKFYUeVWg=;
 b=InelPVRi/uwx0iQZhqP6ihkMPr0hg7ApphDe12FAJNzabWVZbcyScDWed0DpimToJnmyYyw3B5QCH/4ofoDz2IdNNlqmODdNR6h+0lDjiQdCHvxQReW42tCat/tpE4lPFm1KnZyMBTXgxIbwHc5ki/HwFW8Whh6yENA8z8768iU4mu+uvk2WjE7lbLvdm3a0TmOIun0xWBqecnjkfzSELuSU+cshd/237nqKYObOhBlyq8L9RhFE5tJ2BsEPECuf2WG3hlyvNKfe9qr3FpqJEDr2pyX35dqYZJvC27UGI9mvuZEY/2luQVPAtAD5PsIxHld9c2HSgMoWjt58e3jUNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3306.namprd12.prod.outlook.com (2603:10b6:5:186::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.21; Tue, 29 Sep
 2020 18:27:21 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.032; Tue, 29 Sep 2020
 18:27:21 +0000
Date:   Tue, 29 Sep 2020 15:27:20 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Yishai Hadas <yishaih@nvidia.com>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next v2 1/4] IB/core: Improve ODP to use
 hmm_range_fault()
Message-ID: <20200929182720.GB9475@nvidia.com>
References: <20200922082104.2148873-1-leon@kernel.org>
 <20200922082104.2148873-2-leon@kernel.org>
 <20200929175946.GA767138@nvidia.com> <20200929180210.GA5012@infradead.org>
 <20200929181325.GA9475@nvidia.com> <20200929181521.GA8089@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200929181521.GA8089@infradead.org>
X-ClientProxiedBy: MN2PR20CA0022.namprd20.prod.outlook.com
 (2603:10b6:208:e8::35) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR20CA0022.namprd20.prod.outlook.com (2603:10b6:208:e8::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22 via Frontend Transport; Tue, 29 Sep 2020 18:27:21 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kNKLQ-003E7e-0b; Tue, 29 Sep 2020 15:27:20 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601403992; bh=bXf9TW99TvitNOdU0PaPYZhFVPS7mPxOg2WKFYUeVWg=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=fs71FX0O1DCYwZHcmCR85GsBoCgJADMwe9N/NjehtVBmDStoiqpFN8q+pAHTdz7Qn
         FwnKroxjH951IoyjcbAsNxXCHpn+JBDGa/pBf2TA4Fwvz2V6buYwtgq6nm/PzeccpM
         YDWT6CG8Rdie9+Lpv3EE5biBDY9i6NSic3CuY3Su93VdQkYO7hPMduv9hz8Yjta/qu
         idmHVKFm8QFZwrkBcv9M6OzamKOBtDLyW/cMkEoMlaeS3UF351nid5s1eoiV5opREd
         M7umg+DZzhcdYJQGifjHLGdbanL7o2Xzm6nOiILDSxYfAgrI3DqcV5P7ElXBRDCqgW
         B/ExQelfATXBg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 29, 2020 at 07:15:21PM +0100, Christoph Hellwig wrote:
> On Tue, Sep 29, 2020 at 03:13:25PM -0300, Jason Gunthorpe wrote:
> > My eventual hope is to be able to send this DMA page list to the HW
> > without having to parse and copy it like is done today. We already
> > have it in a linear array that can be DMA'd from.
> > 
> > However, the HW knows 0 means need-fault (the flag bits are zero), it
> > doesn't know what to do with DMA_MAPPING_ERROR..
> 
> I think you are falling into the same traps as the original hmm
> code.  The above might be true for mlx5 hardware, but this is generic
> infrastructure.  Making any assumptions about being able to directly
> pass it on to hardware is just futile.  Nevermind such pesky things
> as endianess conversions.

I was thinking to avoid that - the DMA related code would be pulled
into the driver, and the core code would just do the hmm_range_fault()
for the umem.

The driver should be the owner of the DMA list and it should be kept
in the driver specific format.

Jason
