Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E96BF3077B8
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Jan 2021 15:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhA1OM0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Jan 2021 09:12:26 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:14281 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbhA1OM0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Jan 2021 09:12:26 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6012c6210000>; Thu, 28 Jan 2021 06:11:45 -0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 28 Jan
 2021 14:11:44 +0000
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 28 Jan
 2021 14:11:40 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 28 Jan 2021 14:11:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z82Fs7sna6DUAWfqm243w84RGB7pANCz18fUYtxbtWLpc41fXI0DHtcPZxtLZohIWBZmLVBG0D0ePF5TDb5Ku1Tv4gQpt2fgGyuww5kqQzUM8UTcyOx+MYExbt6ahAEtEUuq51Dm4wBbXC/qoVKFA6pDmdZBHGBSH4Ebqd4fwl1qviCaqd/FqmL6tOKYo+wfz8Y35LVtRoXKEgUyNxY7Mz2YFwVdNvkeZQHsmRkOpSRSfcaLLpUZqToBu4F8j67JkKGGf7q8CNV3WX+RCJ9Gih+jIuw+/GB7oDEdbQIIshaYJYppmSABEwoe79aTm03yM/zooU1O5elNQUluwAPDkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WgySkcusqlZZTz+ajiuIe/AONk9ppoW2PO0GF/CaDAQ=;
 b=OKGHKmKwSjeatt2lLzVe05hPXV8BY29eIqixLsKTpm3BSdlTZcl3hX4li5zlegNJ02vRYCXNeT7NylqAEqt1ItKlClvBAvuf8iMikGUwW+LoAdjXZgedu4ROhS5ItVKs0VWzN4iQR4BhaILZTvdQbir6PVSjozU2PGdPz1NsZQo39E0EdXlWcOjp7iIMoGy4iFmMM6cId2ijlcxndee2xwu5ZCtBKFbIVg0aoK0bbCramWRBUJpwycMCal0Ur+ii7wmn4PF+Bp+M2tNTX8t/l98Jq3zN1QcmyCfmLpdc5vP/GvePze+MkvqgJ+HI3fMm8kkSpVYy/5Hmj6zhce5K6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2437.namprd12.prod.outlook.com (2603:10b6:4:ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Thu, 28 Jan
 2021 14:11:38 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3784.019; Thu, 28 Jan 2021
 14:11:38 +0000
Date:   Thu, 28 Jan 2021 10:11:36 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     liweihang <liweihang@huawei.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: Re: Question about the mechanism of RoCEv2 VLAN validation
Message-ID: <20210128141136.GF4247@nvidia.com>
References: <ff917571dbae45fe9c9d840bac400404@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ff917571dbae45fe9c9d840bac400404@huawei.com>
X-ClientProxiedBy: BL0PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:2d::40) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:2d::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17 via Frontend Transport; Thu, 28 Jan 2021 14:11:38 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l581I-0003pW-P9; Thu, 28 Jan 2021 10:11:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1611843105; bh=WgySkcusqlZZTz+ajiuIe/AONk9ppoW2PO0GF/CaDAQ=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=EADnMOeS5R7lZHyLAGVTjDN1fRbhB/7BRR0b0FLk2Cqiz5gwxU0L4o3/mW3hDrpDU
         FrlenWGQt8nkzXlrJnSRpAPrJBrFwoN1IH3I939Pt6z3c8dog+gqBVV5Ddv0ZVbb5f
         SshgCnfvMY5h6P314cVydChOz98ooFWevUmd2Hhg7wC7Eb2xndLZ3x8IqDdWZBY0mV
         N58gkrioAgfgRxUspYRVlmXHuCYmLF5ca30cykvQyxGb1Pv6JFNPD3a1qeaXdxaLe/
         z98GYJGU/U+hAm2Gym8R3fYOPfJOjiPPPmdzgA7frNW2G3fpfxn/rfJdygmSalIV02
         J3INOlfIPt2ag==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 28, 2021 at 02:08:21PM +0000, liweihang wrote:

> UD is connectionless-oriented, an UD QP won't record VLAN info in it's QPC,
> so how to achieve the checking mechanism? Or a UD QP should just ignore the
> unmatched VLAN ID?

Right, UD QPs recieve all packets for the entire device that match the
UD QPN

They indirectly report the incoming gid table index they were matched
with in the completion and the first 40 bytes

If an app only wants to look at certain gid table entries then it is
up to the app to filter

Jason
