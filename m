Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5FB2FF34A
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jan 2021 19:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbhAUShE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jan 2021 13:37:04 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:5239 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728889AbhAUSgs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jan 2021 13:36:48 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6009c9630001>; Thu, 21 Jan 2021 10:35:15 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 21 Jan
 2021 18:35:15 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 21 Jan 2021 18:35:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aDVAEYV4Agmn6MEj8NM5SasQHdZsekWfNdVvf06X5rLXnx8GdFdBvXQBFzvVXJIoqsJ8SEt3yOZzxoi8jDCOpf7vaQwno5YozEtGUEraFDSArp298Duo5Txp3D+jFGFCDh5i8cvp471fAm4s7qmrBoHnb4hZRf+zVdjvcWXHnhGOsaxBhnZKn9vofbwxCYdQqIu33denBwmS+aCrenJaXNo+6oIgN2zikq4mICkmiljD2LbCCTznjZjUSl5wDpi1ZyikBjrV5NeuIvl0lpsia0EY47zKGlstuvYcHDMFvuNOQjUb8RBET+zb6IrE6v+OIuH93s/6bLEx/I6ht9RRGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCs/C5l+rHeqd/OtESVisc/BSAKXtCBrHg79u5/NNyk=;
 b=YVBTsDmXK2MyNiHT2P0CxsB3W6XHxvXsWxH/vkB4+J5oqhRg6m8EKI3rGiUXnoaLvJ2UJ6zpN5f1us51aTKv55MCzysgGT17RagLmlkzJgP+/6B0VG53cWjY0nJ5SmqM9r4URy7UCy0MmPAP1VVadfBrndDs5F31AYcAZhZh8ffFXMjUgkb0jrdspbFCIrQlnbmDbzKrUA4mt0ccTczcQjzXTW5gDSr5LeixMVu5DxXx3XjWXN/yea/ynWkqkzBWI3w4zMSv85fX84Hj5WWl6yTU0U4zWh+nPu148vmElJrEuzp9uMyX3ectb4JK1B26uk6wvxF1aigKOl9ewSUj6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4973.namprd12.prod.outlook.com (2603:10b6:5:1b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Thu, 21 Jan
 2021 18:35:14 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3784.011; Thu, 21 Jan 2021
 18:35:14 +0000
Date:   Thu, 21 Jan 2021 14:35:12 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gal Pressman <galpress@amazon.com>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>
Subject: Re: [PATCH for-next 0/2] Host information userspace version
Message-ID: <20210121183512.GC4147@nvidia.com>
References: <20210105104326.67895-1-galpress@amazon.com>
 <9286e969-09b8-a7d0-ca7e-50b8e3864a11@amazon.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9286e969-09b8-a7d0-ca7e-50b8e3864a11@amazon.com>
X-ClientProxiedBy: MN2PR20CA0050.namprd20.prod.outlook.com
 (2603:10b6:208:235::19) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR20CA0050.namprd20.prod.outlook.com (2603:10b6:208:235::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.14 via Frontend Transport; Thu, 21 Jan 2021 18:35:13 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l2enY-0058yt-Ld; Thu, 21 Jan 2021 14:35:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1611254115; bh=qCs/C5l+rHeqd/OtESVisc/BSAKXtCBrHg79u5/NNyk=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=rYHNwxokzhxDo6MInOCIRn2leWBNjR1tyyMQrWZHONhVoVy4VoEjAPaYs8Xlcyx1E
         HCw2Tx3/+zMP6NMtADi14gXdTgo0LKczxoBUogYuZSyXKSc4gOPP47zmWZ0+W21pL7
         kV4U70C3DnF+pS2C08fK4VqxaFDe2eZ8MbaNpI3VgrwqqgjtQw/LpqFZUGnCIA8cyP
         Bav1TfFrnQQLdIUKPI45bR0tOE+UZcjc7NS51VJisU5LLl2qI83B3jhGmSSrImj2/m
         o4U5ENBuDlgBiIp3CxjcfhN6RSFMpLV6koMa4KGUuKjfZiYNKfvLRFBDe+OMzWCFLc
         VLTTxpM4PZuIw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 19, 2021 at 09:17:14AM +0200, Gal Pressman wrote:
> On 05/01/2021 12:43, Gal Pressman wrote:
> > The following two patches add the userspace version to the host
> > information struct reported to the device, used for debugging and
> > troubleshooting purposes.
> > 
> > PR was sent:
> > https://github.com/linux-rdma/rdma-core/pull/918
> > 
> > Thanks,
> > Gal
> 
> Anything stopping this series from being merged?

Honestly, I'm not very keen on this

Why does this have to go through a kernel driver, can't you collect
OS telemetry some other way?

Jason
