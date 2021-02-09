Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60DA5314501
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Feb 2021 01:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbhBIAl5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 Feb 2021 19:41:57 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:7126 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhBIAl4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 8 Feb 2021 19:41:56 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6021da2c0001>; Mon, 08 Feb 2021 16:41:16 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 9 Feb
 2021 00:41:15 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 9 Feb 2021 00:41:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JmRH4HOYKQimZ1FvxzDhL16Djf+weBst6mg4mftLmrPVd42Nzkk93jFyHJx8U1p+rmJI4e4wDpXpQdpGj0f5zHTHN6kjPs53gxM9gDAJh42+LNkQJ37anL0tefY8h9YsOi1dA/Oqg3hzsB+W8B55uvQXPakpyhUxwIU2mm511GeBbEwZqltYhkzGRuoHxzT+FBp7U61O1sUxEWf7dRxKrSkcVt5ShcUhyHrW/8dzbAmC5v1+dNiqINdFeHv1GP03q38LWbK3QPKGTAcR5xcfm6/Sfzn0hEYoTP4Q5X//5cTINo3ML7VrQYYRdq5A4k0HgRvevQQ6FyHENi+R345a+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KaVNKLH2eCqVxqUPxbSNNWoCcDgkWitJlPPhA5PArig=;
 b=ZMGyjbVzXBbi+TwOuYXDaQszZmYhQFggqgfIa9EdAqqQpxSkmH5AqOTD64olTTqnhxyDMuIriq6iSalI6qdHix3B6vBJsMAyg0G4HNmi2+DurJizRMUIyUJkL2IE5XCwjsIH7RT6JYc0ocVaBpi0C+nVDz8JmIdud9pXCRAu3mhej4P0Tqmc2ZppVnosN6ymwXuWo8YjUEqgxyHQWlBAktF0L49tD2nw5sWpegJkez+Eq5zFiA/EewFquNgeMDGYb9EO/g5D2IJ4LeFqSs9Fv6WaK5qz9Ey/79ukNVd/QBuOgx5kY5fzVUrfYfzKYMgj9Aw76RF2mQhTcp2l4CZDGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2811.namprd12.prod.outlook.com (2603:10b6:5:45::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.30; Tue, 9 Feb
 2021 00:41:14 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4%7]) with mapi id 15.20.3825.030; Tue, 9 Feb 2021
 00:41:14 +0000
Date:   Mon, 8 Feb 2021 20:41:13 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
CC:     <zyjzyj2000@gmail.com>, <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH for-next] RDMA/rxe: Cleanup init_send_wqe
Message-ID: <20210209004113.GB1248548@nvidia.com>
References: <20210206002437.2756-1-rpearson@hpe.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210206002437.2756-1-rpearson@hpe.com>
X-ClientProxiedBy: MN2PR13CA0030.namprd13.prod.outlook.com
 (2603:10b6:208:160::43) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR13CA0030.namprd13.prod.outlook.com (2603:10b6:208:160::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.11 via Frontend Transport; Tue, 9 Feb 2021 00:41:14 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l9H5d-005Eop-CJ; Mon, 08 Feb 2021 20:41:13 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612831276; bh=KaVNKLH2eCqVxqUPxbSNNWoCcDgkWitJlPPhA5PArig=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=gTXBkAKl9DC8SoYsJEQtfFIhBz0ya0LCy0blFk7VYkeJZpn4KZ3gLK6L8el+yE6AM
         xFT5/W4kf0fBpTAQ/crACCgijfsv9UvpvNTzpWA5y85uDLXYNtsKXy/et2ipaVPzYg
         0lI4SyyTury+J3Nr+loC8mh8J8hsrGzBl6t4SJ6f/Um4GrC3acYNHOZs89LIhTbfBM
         1Ua0i3xnNToo+J9e6poFIrhqfMI+c7JWaS53tdBf7ENNoBcUY4ItncsXMWU0Fu0NLB
         h5WtWfTg43xyexDDZHRwdxJguogQCo01rzJaMaZ7XHPOf+4A9O+fcTQajGH6/QtH2r
         VRajQEJrjkVeg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 05, 2021 at 06:24:37PM -0600, Bob Pearson wrote:
> This patch changes the type of init_send_wqe in rxe_verbs.c to void
> since it always returns 0. It also separates out the code that copies
> inline data into the send wqe as copy_inline_data_to_wqe().
> 
> Signed-off-by: Bob Pearson <rpearson@hpe.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_verbs.c | 42 ++++++++++++---------------
>  1 file changed, 19 insertions(+), 23 deletions(-)

Applied to for-next, thanks

Jason
