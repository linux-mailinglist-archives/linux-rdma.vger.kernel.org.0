Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6297630C695
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Feb 2021 17:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236437AbhBBQwo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Feb 2021 11:52:44 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:12632 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236818AbhBBQut (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 2 Feb 2021 11:50:49 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B601982c00000>; Tue, 02 Feb 2021 08:50:08 -0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 2 Feb
 2021 16:50:06 +0000
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 2 Feb
 2021 16:50:05 +0000
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.58) by
 HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 2 Feb 2021 16:50:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPgy4XIP4+YzZk7eHN2047nrAkzG9Lab4cr5QbnO0om8QLl09oqd9n004CXRvsQr4lxc9um6yer5cGROT/FxNCdlxw3MTQrSi0fXunRbykSdZtVN1R3VP5Aq41g7XHxl0Weo1gmbggw2fbSjfMxfLrE01EzKO8zeZiZwRBsRoetcZOIzGnenxD3/fGNvV49GBkew3/MVwI1b415eEy1j/icwLPtEGgmc55SRVhq8s6JM6BjuQ7cWGmvMjIPYpUmcJH15GOG85sWLW3vydmXoWiFpn25akhOMyq6qGq4f8r+TDcKTq2FkzdnIrHYXqEiBIfcDnnSlkoCCW8CJ4FA8Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdLWo5gDQd4H/IIKoC2e/PGrY/jOOioqEuOc8jx1Gig=;
 b=lLn6DzIOZaB+tv+c569WE8NLyfQgzlPn18oqxIPflbYoSlypP/pCjyte19+Iro/r5Ak4/wdxcwopH+YlLzdIHooUqo0vU1v7RI5aMmPO6uOGDsb1eDdXBfQZ90HOk4qdRfwCh21bcZkmKSPxUqPV9VAwNwhz+mSeTKY6Dixwq+LutTc34y7ljHQGn1ElDujc/G6oOvtwtAQmqQcz+TlLKhTn5jD7GdAU3WOa9y8lbkfE4vbqf8UTc/9JPAB4YN6TN9omUIpwjPWrNCuBVdtufY11gJ66qu1r6SaJmQ3A7pQTxLat1mV5LMP/afY3hyuciVSrNUTsDm5CAet0wina9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4546.namprd12.prod.outlook.com (2603:10b6:5:2ae::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Tue, 2 Feb
 2021 16:50:02 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4%7]) with mapi id 15.20.3805.025; Tue, 2 Feb 2021
 16:50:02 +0000
Date:   Tue, 2 Feb 2021 12:50:00 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Parav Pandit <parav@nvidia.com>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next 05/10] RDMA/core: Introduce and use API to read
 port immutable data
Message-ID: <20210202165000.GA621786@nvidia.com>
References: <20210127150010.1876121-1-leon@kernel.org>
 <20210127150010.1876121-6-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210127150010.1876121-6-leon@kernel.org>
X-ClientProxiedBy: BL1PR13CA0144.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::29) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0144.namprd13.prod.outlook.com (2603:10b6:208:2bb::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend Transport; Tue, 2 Feb 2021 16:50:01 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l6ysK-002bw3-NC; Tue, 02 Feb 2021 12:50:00 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612284608; bh=fdLWo5gDQd4H/IIKoC2e/PGrY/jOOioqEuOc8jx1Gig=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=PLY6Fe/olrzTWAyTY76zDge7saLCUwTupJoaw09DXD8Lgrtw88dtE6z9oQ43mBiyg
         F2GEMU2V6JedhwwBZx6oND8By1y1g2X7ZiakzKYRM9wIQoP1SrRczf+m4RJ5QLaF2Q
         TggsS4GzwdHCV7lyhnPQ1x+wlsKnIQmDesdi4OYGtcbOmEeAKjUhSdLKBocQZYDa/3
         XZycd9AXmJaoBAq65ehl2VIOvsQ6WwnBsQLBROa3UkZdAcVjPEHeI8JdfShcGuxQDr
         TOFtubQwXlDf0vsi1ip3O2FNNrQEbuzfYzx3ZiGeZDtbAozrlGoSfp584I5VOdgytC
         +QBuF0+UIO18w==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 27, 2021 at 05:00:05PM +0200, Leon Romanovsky wrote:
> + * ib_port_immutable_read() - Read rdma port's immutable data
> + * @dev - IB device
> + * @port - port number whose immutable data to read. It starts with index 1 and
> + *         valid upto including rdma_end_port().
> + */
> +const struct ib_port_immutable*
> +ib_port_immutable_read(struct ib_device *dev, unsigned int port)
> +{
> +	WARN_ON(!rdma_is_port_valid(dev, port));
> +	return &dev->port_data[port].immutable;
> +}
> +EXPORT_SYMBOL(ib_port_immutable_read);

Why add this function and only call it in one place?

Jason
