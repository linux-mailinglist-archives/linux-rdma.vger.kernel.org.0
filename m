Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B675293C4A
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Oct 2020 14:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406689AbgJTM5J (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Oct 2020 08:57:09 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:24102 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406609AbgJTM5J (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Oct 2020 08:57:09 -0400
Received: from HKMAIL101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f8edea30002>; Tue, 20 Oct 2020 20:57:07 +0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 20 Oct
 2020 12:57:02 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 20 Oct 2020 12:57:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rdyhzew2dJTwjMeM9RrmdD7HB8HpKKqP0dOoTdHBfQWcg8wTtkwtf605obFiNrQFEuuYSdFW2RIjgWTC5LNGto9Un7Kt7LfoEIwYqKc11fBfu/p6UKyvYWaD7RWEDJOvPtJSb67jKUrarKiELbL4MtIFERNEvtLwnoz/As6F4EoYwrPStnb+gy+cAgXGru1VWqiYZ0BffxNDcD+Bx8juldj4BygkgjcupLucgL7IsW8yV3E9++kgIyBQbMLS76TtsqvYQgXBUj02pfKLCQ+rwzFUtWQ0UawzfwIBWbMWgjpy8jpPf5oGCDlTyBmGX8lS3TcosUhXZc+VLQIDsw3uag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lraAEVFi4EcGFMJN7YCPfjqp8I5sMWA7yF6iQlaJDWE=;
 b=A3R4ocryyMvleERpdyTyEPr7nrWusg8AiYWV9Icx5V6l2jqIosmhZ+e1g/NvMVoRECAJQCpBDk+w363OoQWmeljk6nmwPYfupcsACKB39OylAzLbFeuJcHeHQl/ZML4ZuMRNyBqZXFa85m4if4RbCiY0ryvbGDxHWYpWrNdIZUhU2yMMbitOFH6I4gwKNSbafbRWa5MwWWEBa479lT0Myp2KcMjHwEN8rV9x7v1ZnlPoQuWhRbkQ/kc9CPip2wY9R2JNtxMmIH/XEd3TorDJDjymGSIpz4GhoeD0dZO936hw4bpYBsEiH2tB8QAh+hS1s9WjAXU5tCApz0Mjf2Ow3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3836.namprd12.prod.outlook.com (2603:10b6:5:1c3::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Tue, 20 Oct
 2020 12:57:00 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3477.028; Tue, 20 Oct 2020
 12:57:00 +0000
Date:   Tue, 20 Oct 2020 09:56:59 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
CC:     Maor Gottlieb <maorg@nvidia.com>, Christoph Hellwig <hch@lst.de>,
        "Gal Pressman" <galpress@amazon.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        "Leon Romanovsky" <leonro@nvidia.com>, <linux-rdma@vger.kernel.org>
Subject: Re: dynamic-sg patch has broken rdma_rxe
Message-ID: <20201020125659.GD6219@nvidia.com>
References: <20201016003127.GD6219@nvidia.com>
 <796ca31aed8f469c957cb850385b9d09@intel.com>
 <20201016115831.GI6219@nvidia.com>
 <9fa38ed1-605e-f0f6-6cb6-70b800a1831a@linux.intel.com>
 <20201019121211.GC6219@nvidia.com>
 <29ab34c2-0ca3-b3c0-6196-829e31d507c8@linux.intel.com>
 <20201019124822.GD6219@nvidia.com>
 <03541c89-92d0-2dc8-5e40-03f3fe527fef@linux.intel.com>
 <20201020114710.GC6219@nvidia.com>
 <c64bc07a-ed95-f462-a394-4191605c05b9@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c64bc07a-ed95-f462-a394-4191605c05b9@linux.intel.com>
X-ClientProxiedBy: MN2PR17CA0003.namprd17.prod.outlook.com
 (2603:10b6:208:15e::16) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR17CA0003.namprd17.prod.outlook.com (2603:10b6:208:15e::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend Transport; Tue, 20 Oct 2020 12:57:00 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kUrCF-002vQu-Fq; Tue, 20 Oct 2020 09:56:59 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603198627; bh=lraAEVFi4EcGFMJN7YCPfjqp8I5sMWA7yF6iQlaJDWE=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=XYQMlfGByOuE0fTtfHsdUOdP0UT5da4M05VADrXJz0xExz0Zy7zDUsOr2ddQWpjB9
         8b4JGJWGB8QIcTNqzo7el7CICrJ09Zvv8XAnyGSaBAf0w8ROj8YxHOVNGUxJDZ/4Lk
         +9appPe6T7OsZG3CDYxvjmJm/jqG0wSSdniXJ2UhtXy625r+/JuI9OryPLMucPBypj
         FiLnqsDvvbBAFqPjw+xQr4bMNtbQWF9zXf98FFJgd9ZoK9sG+4THb9dffOd2USXQw0
         XbgIr+RobFh6ibp/P4ORXWJ3KVt1Mt4YbqxHGRPk4V99uxsLjzFPAQ2Gf2jAyyg1kP
         InPcpr/bUa6iQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 20, 2020 at 01:31:27PM +0100, Tvrtko Ursulin wrote:
> 
> On 20/10/2020 12:47, Jason Gunthorpe wrote:
> > On Tue, Oct 20, 2020 at 12:37:05PM +0100, Tvrtko Ursulin wrote:
> > 
> > > > Why put this confusing code in every caller? Especially for something
> > > > a driver is supposed to call. Will just make bugs
> > > 
> > > For max_segment to be aligned is a requirement today so callers are
> > > ready.
> > 
> > No, it turns out all the RDMA drivers were became broken when they
> > converted to use the proper U32_MAX for their DMA max_segment size,
> > then they couldn't form SGLs anymore.
> > 
> > I don't want to see nonsense code like this:
> > 
> >          dma_set_max_seg_size(dev->dev, min_t(unsigned int, U32_MAX & PAGE_MASK,
> >                                               SCATTERLIST_MAX_SEGMENT));
> > 
> > In drivers.
> > 
> > dma_set_max_seg_size is the *hardware* capability, and mixing in
> > things like PAG_MASK here is just nonsense.
> 
> Code was obviously a no-op non-sense.
> 
> So the crux of the argument is that U32_MAX is conceptually the right thing
> which defines the DMA max_segment size? Not some DMA define or anything, but
> really U32_MAX? And that all/some DMA hardware does not think in pages but
> really in bytes?

Yes.

The HW has 32 bits for a length field, so U32_MAX accurately defines
the HW DMA capability

Jason
