Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 593C4288C90
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Oct 2020 17:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388726AbgJIP2c (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Oct 2020 11:28:32 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:10763 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732056AbgJIP2b (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Oct 2020 11:28:31 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f8081300000>; Fri, 09 Oct 2020 08:26:40 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 9 Oct
 2020 15:28:31 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 9 Oct 2020 15:28:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mbvbdezxr048rIAy+R8NATwripaI/Gv6lo2/OgJctQj42HBLIs3WfMFI0sPrRDI79oOtyerPxOxYNA596bl9w9gdsqLjOm2HJMp5nBEMr8ppPNQ8FQ8G3KJdWajaBARiemAfzIMjb876tgObdeSBYmeaU5r1b2dzxtcVppFEZjSYhBnW/QWRXRbyX1JM8yM/Jv7Xmv0X3SJD3ktDwwkoLUUMEV+570cOjFh2mMJR6Gf+Q1xltZfWWDailTvqUqFD6bhE4ILqQ+0nhvWjK73r3xPJSNhlUc250ua8x44q6pcVxo4D7+uzY2qBhsf2m5cA1BaKJP51kyH7FhZSEo+qsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=et4ju5RPeer3y8aG/UnwR7P3FAOxklY+Lp2ZDoDW5fo=;
 b=k5Lfox93WprQstoBgMkaJ8K2L7rYmXnnP7coEr9PVjVMm+vzDOwAC+FmxugyJ18z3hc6+7TsiYbegtsdro/VYJen+idMEKSFa/ESFalAqDTlX+vi7ODNjj6L18v5ZN5o+WTI7J+ehvikeKKjJIMUQzGHmJl1CocSL2ZKS/uUhfJZeNIJfflTLwFR9ay5uQnVrBQJLPZn+d8ySBXWrb28tWhd8PoD88jsWxrwC4waOUSdXZsxLX8YgNYs3vDkoK9muYkfH5FHaIqLV7vZB4464fPS4ZqAXtK7com65LTydZPZd+TXlbPldsUr49fx72zykB+OP9M9Dz96jZbMk2nZoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3211.namprd12.prod.outlook.com (2603:10b6:5:15c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.27; Fri, 9 Oct
 2020 15:28:29 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3455.026; Fri, 9 Oct 2020
 15:28:29 +0000
Date:   Fri, 9 Oct 2020 12:28:27 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
CC:     Bob Pearson <rpearsonhpe@gmail.com>, <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH for-next v2] rdma_rxe: fix bug rejecting multicast packets
Message-ID: <20201009152827.GN4734@nvidia.com>
References: <20201008212753.265249-1-rpearson@hpe.com>
 <0e89cd73-e3ea-81fc-c5eb-be7521b10415@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0e89cd73-e3ea-81fc-c5eb-be7521b10415@gmail.com>
X-ClientProxiedBy: MN2PR08CA0026.namprd08.prod.outlook.com
 (2603:10b6:208:239::31) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR08CA0026.namprd08.prod.outlook.com (2603:10b6:208:239::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22 via Frontend Transport; Fri, 9 Oct 2020 15:28:29 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kQuJn-0020kf-Ie; Fri, 09 Oct 2020 12:28:27 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1602257200; bh=et4ju5RPeer3y8aG/UnwR7P3FAOxklY+Lp2ZDoDW5fo=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=NesCvCWM6x+b7TDGHObZmAuJ7fB3exnoafl1AOHQuO4a7GXLfKepSd+swZO7NDduN
         gyvIaqTIp0NEyzPdqyov4ohf6h4Wbx7FOJDVtwDyUU2nDOlhwoQLr6Y/2nMYW475LP
         XZhIlzSUO1IJOGwuMZoCFAwiX9fPZyLeri5tfZNP/3OrMBY53v1Yw0Qma2okLC6qPq
         i5byDwwsGhLIG0x0IRZcKeFOiQQvfLG2EL8z3RvdG0AUwtv1h+l2/QX1IFz5GOyeo2
         I3DF6ptIzH/S1Ug6rEJRop6cax+UvRQl968lV5tOYWnwl6t7GbQcFeD/MRYDieiMz9
         GzP+PE+sSTKEg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 09, 2020 at 11:23:31PM +0800, Zhu Yanjun wrote:
> On 10/9/2020 5:27 AM, Bob Pearson wrote:
> >    - Fix a bug in rxe_rcv that causes all multicast packets to be
> >      dropped. Currently rxe_match_dgid is called for each packet
> >      to verify that the destination IP address matches one of the
> >      entries in the port source GID table. This is incorrect for
> >      IP multicast addresses since they do not appear in the GID table.
> >    - Add code to detect multicast addresses.
> >    - Change function name to rxe_chk_dgid which is clearer.
> > 
> > Signed-off-by: Bob Pearson <rpearson@hpe.com>
> >   drivers/infiniband/sw/rxe/rxe_recv.c | 19 ++++++++++++++++---
> >   1 file changed, 16 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
> > index a3eed4da1540..b6fee61b2aee 100644
> > +++ b/drivers/infiniband/sw/rxe/rxe_recv.c
> > @@ -280,7 +280,17 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
> >   	kfree_skb(skb);
> >   }
> > -static int rxe_match_dgid(struct rxe_dev *rxe, struct sk_buff *skb)
> > +/**
> > + * rxe_chk_dgid - validate destination IP address
> > + * @rxe: rxe device that received packet
> > + * @skb: the received packet buffer
> > + *
> > + * Accept any loopback packets
> 
> About loopback packets, will rdma_find_gid_by_port return correct value?

I don't think you can use 127.0.0.0 with the RDMA devices, at least
not on the wire. The CM has special code to swap it out with a real
device address

Jason
