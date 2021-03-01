Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12F36328B3C
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Mar 2021 19:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239891AbhCASb1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 1 Mar 2021 13:31:27 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:2094 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239922AbhCAS16 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 1 Mar 2021 13:27:58 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B603d32060001>; Mon, 01 Mar 2021 10:27:18 -0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 1 Mar
 2021 18:27:17 +0000
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 1 Mar
 2021 18:27:15 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Mon, 1 Mar 2021 18:27:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AeKkRTN9/CXMCjawB2iqDS91guC2Bj9ySq3FAY/XYzb8nJw7Bwf2+JdxSss41bgf52WrmxIHTDoCGq4phE+MqhpLv0BCwoqJt4XAcQLAC+l2Z3dsvTNocmo3YxARwY61gjrFyaCLMn9eQ9d4ixa7N4jS919k3VrWWS/muvLVwWc4rwRtnwj9s3KFgLsyN5+5t5x2LACSYrUp2+8+FMDzMWIfvScBasYmXJTf08pc8LDuF+feS/j7VdIU142fvaWQEdrHxSe8rL6J9KI5o2tAzB1xmCv+FbCtnppDl9LxMtnNnXx76H6XCWl8pMEOt6Eh7VC73su5L507nyLoBBq+QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7aGhcikp684oIptTYjis3hSQ1OIAUzJJi3H8nHf2fLw=;
 b=Tgk6NRKimEOv/XmKXhGZxdi80iUXdf7clqqZAB9mCjnfbX9J7HR8+wB1BDjpaWvRbsWD4ZOm2+HH+aVl8BkiW4azkSACXOdZLtip7kyYiUjk5kz5ijHt7qbNFfGuuz2fmtaHB6yVckWnyoets1JqSVeeqEo7zJZjfM8W2F5syMjOcYQ+gQ3ubAaKr5kGHR7wB5qwQ8/Elu5MMeMLWy7R0ELaAGAvNto4DQITcTQU/bGMrBvUmxZcy5MJFMTS/Y/ykvNcIdT2VoRv6k5Nu/qABbYNxnEJGn2N1LOYbKV9oSiP7cwC+Wuk78AZuCx51eV51VlbbMB6Sb06JR/RFKn5IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2938.namprd12.prod.outlook.com (2603:10b6:5:18a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Mon, 1 Mar
 2021 18:27:13 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3890.026; Mon, 1 Mar 2021
 18:27:13 +0000
Date:   Mon, 1 Mar 2021 14:27:11 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Pearson, Robert B" <robert.pearson2@hpe.com>
CC:     Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Zago, Frank" <frank.zago@hpe.com>
Subject: Re: [PATCH for-next] RDMA/rxe: Fix ib_device reference counting
 (again)
Message-ID: <20210301182711.GZ4247@nvidia.com>
References: <20210214222630.3901-1-rpearson@hpe.com>
 <48dcbdc5-35a3-2fe3-3e3d-bff37c2d8053@gmail.com>
 <20210226233301.GA4247@nvidia.com>
 <3165add7-518d-9485-fa12-6d7822ed9165@gmail.com> <YDoGJIcB6SB/7LPj@unreal>
 <db406802-25a8-bda8-6add-4b75057eec96@gmail.com> <YDyWqLuRw33mU63D@unreal>
 <b1fec0dc-6b4a-8364-2b90-a4ef5cd839c6@gmail.com>
 <20210301173540.GN4247@nvidia.com>
 <CS1PR8401MB08218976C89D1C7B20394B4DBC9A9@CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CS1PR8401MB08218976C89D1C7B20394B4DBC9A9@CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM>
X-ClientProxiedBy: BL1PR13CA0201.namprd13.prod.outlook.com
 (2603:10b6:208:2be::26) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0201.namprd13.prod.outlook.com (2603:10b6:208:2be::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.9 via Frontend Transport; Mon, 1 Mar 2021 18:27:12 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lGnGB-0034hJ-HK; Mon, 01 Mar 2021 14:27:11 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1614623238; bh=7aGhcikp684oIptTYjis3hSQ1OIAUzJJi3H8nHf2fLw=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=E6V8qNVKf3DoRMI5Q3fwQk+4ceCQ9v3CMSuTwzlmQby68EAVCk1OhkqleLBh4VMiA
         /lGiRTRvdFc9pW0iM597IOnnAEvTc5iRudebp9eYKZ3eXNtlFNGa4qee3iwz5cgFNx
         RMj3aTvUGjXPadIg1PHpsKSUi378rFWrYx3gP8UTrYGp+0fqsF4wF56f9gVGRY0hEV
         AOi+9tnj1s1SyZ3DDSoQJWUF2nxuY0yEn9gFNs6m2XEkqCLOl9t/RAOzpmWIGL3C7t
         I1T76klMeLEYNE1inz1YqKUsiVDz300B465l8IfhoFYjOJp2MaJDrvcjOfu2ZqT7g0
         H/BQYyMyymq/A==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 01, 2021 at 06:20:06PM +0000, Pearson, Robert B wrote:
> > On Mon, Mar 01, 2021 at 10:54:21AM -0600, Bob Pearson wrote:
> 
> >> I agree that ib_device_get/put is attempting to solve a problem that 
> >> it not really very critical since ib_device is very unlikely to be 
> >> shut down in the middle of a data transfer. The driver never worried about this for years.
> >> But now that it's been put on the table it should be done right. A 
> >> data packet arriving is completely independent of the verbs API which 
> >> *could* delete all the QPs and shut down the HCA while it was 
> >> wondering around the universe or worse yet while the packet is being processed.
> 
> > If driver shutdown can guarentee that all pointers involved in
> > multicast are revoked before shutdown can finish then you don't
> > need this refcounting.
> 
> > It was only brought up because the API that returns the ib_device
> > from the netdev requires the refcounts as it is general purpose
> 
> Unfortunately what you ask for is exactly what the refcounting code
> accomplishes and I don't see a simpler way to get there.  This also
> applies to the non-multicast packets as well but all the debate has
> been about the code in rxe_rcv_mcast_pkt() because it is more
> blatant there or because I haven't been able to explain how it works
> well enough.

Usually in the netstack land the shutdown of the device flushes all
this parallel work out so all the dataplane can happily ignore all
these details.

I'm not so clear on all these details and how they apply to rxe of
course. You'd have to look at the full lifecycle of this skb and show
that the kfree_skb happens only before any unregistration finishes.

Most likely there are other bugs if the unregistration can pass while
the skb is still out there.

But, I'm not clear on how any of this works in rxe, this is just a
general remark on how things should ideally work.

Jason
