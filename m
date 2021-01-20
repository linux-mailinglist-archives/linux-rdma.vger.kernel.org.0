Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B3F2FD476
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Jan 2021 16:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732804AbhATPrF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Jan 2021 10:47:05 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12554 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391034AbhATPqZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Jan 2021 10:46:25 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6008501e0000>; Wed, 20 Jan 2021 07:45:34 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 20 Jan
 2021 15:45:34 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 20 Jan 2021 15:45:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PqQ94H/5vnxxB3ga2J4LLowX6fNKNBfT9leRlyrqfwWWR1CpXrq3hGYs1bYo1rEbZ5ooBzHPGLhBDHPMYoxTHMxRt3sb1RPBJQipNTHcdIXWMvUaY7rfM9tuo9XsIvXuiKxKVrWkrF1XTDAx8tLEuEAgF/KwKXyTSj6QcN9lbVaAnZ4zlxX9sFATNUH2VqbJCbAO+83l1sWvIm5ouHzaAklvkNuGEE2MKkk21053S/+1wiFmbpdQQnuoiQwB3fmw6PUMSoMGKRoWr3pQA4n/0o7yD3wJWyBznv8Dg9pSiBa+x+cBy3EHgHpM2FbHyqHRueRqQVW5i544E4AaFAndSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d2mIA4xb5lFFhnyqB1O/RonWpUnqTc4aplMJP04G9iY=;
 b=oghqpHI5yDSt+HfsC/4BArj8ARUvLV/Ak38Uux/sV2N7LOMXr6OQnVjVnKwsu2+KrG2DraeajiRrdffK+3aIjUZOYc44AfdYRVPR11AjFrRR0+4sZE3rSL9etUCfK0+Ysom40gh7k3PcytEUqwMMQjUh5MpkTWf/ChKMPu7UFA6OA0RYg7Jquxp9an9SVAmH+3ot559QugOeNG/dbNxTfdawuUwzEakN9ofawHBlmxsBL19J14mEF3zxFHns0aJ14t5IJS5hS8MbZyT0gnx/M5Soli+USSJ0zsgaGwTz86N2Id1pkuKk1GVbs24GxjpOZgtgsTsgxjLRRZ9qleQxAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1243.namprd12.prod.outlook.com (2603:10b6:3:74::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Wed, 20 Jan
 2021 15:45:32 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3784.011; Wed, 20 Jan 2021
 15:45:32 +0000
Date:   Wed, 20 Jan 2021 11:45:31 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Martin Wilck <mwilck@suse.com>
CC:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Mohammad Heib <goody698@gmail.com>
Subject: Re: Revert "RDMA/rxe: Remove VLAN code leftovers from RXE"
Message-ID: <20210120154531.GU4147@nvidia.com>
References: <CAD=hENfPfgZpcs+JER9qijyo-D16n1X0q2oPqF-qo88GLkkBXw@mail.gmail.com>
 <411ad58698ea4fe8a6b80758de0039e98ba6a316.camel@suse.com>
 <CAD=hENfCoW9pqM3ACWyLaZhw9NhRr-yJz6LLqbwW2psz_SuWHw@mail.gmail.com>
 <3c3c52c5a19beb1a22c0b51af8fd14297187e82c.camel@suse.com>
 <20210120151920.GT4147@nvidia.com>
 <9ae3161750dfc8500b68b68c94a092d10ae785f4.camel@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9ae3161750dfc8500b68b68c94a092d10ae785f4.camel@suse.com>
X-ClientProxiedBy: YT1PR01CA0079.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::18) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0079.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend Transport; Wed, 20 Jan 2021 15:45:32 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l2Ffn-004Z14-5Q; Wed, 20 Jan 2021 11:45:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1611157535; bh=d2mIA4xb5lFFhnyqB1O/RonWpUnqTc4aplMJP04G9iY=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=eXU39twpNu0hIIsuJZWi9jMR2psqb9kfYyXZ6BfTwI0gx0WHmtF2Tbnp4iW2HKHOm
         DOT67dwUi9lEIQyY8X14lP/48ti7hep4weZbpsESp63Lg9ySfEVJWvVQOdEX+o3Ogy
         /p4dlE9rpB34M/grV00aZ9/GUUO6nFxecVb6DH2dBriwqIEdjVcBBwDjhbeE+9UQ5a
         CIYAeVieP3xr9biE/kBVYY6kMdUt9YU3cZ4f9uuFaBTCw58XyReUW6Y1sZylTOVfYp
         /27Q5DpM3xOcFO2UXAL8x17bXUy+ShLzHY201Kbwe+lHxe0ldGxuyNuGLce+611Fn6
         oLvP+9xWGCfWA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 20, 2021 at 04:28:43PM +0100, Martin Wilck wrote:

> > If your use case that work was creating a rxe on a upper vlan device
> > and relying on the tx of vlan layer to stuff the vlan, then the
> > problem is how the core code manages the gid table.
> 
> My use case was creating RXE on the physical device, creating VLANs on
> top of the same physical device, and create RDMA connections over these
> VLANs. This is what used to work. 

Hurm.

So, since rxe never touches the vlan on the tx path, I always thought
it was busted here.

But, it extracts the netdev from the gid_attr and uses that netdev to
tx the skb, which does stuff the correct vlan.

And the rx path, though it is hard to find, does check the gid table
with the vlan, again indirectly through the netdev

So the removed hunk in do_complete is OK

The hunk in rxe_udp_encap_recv is finding the ib_device to use from an
uppser, also OK

The stuff with rxe_dma_device is wrong, just delete that hunk
completely.

So sure, lets apply this - with the rxe_dma_device() part removed
though.

Jason
