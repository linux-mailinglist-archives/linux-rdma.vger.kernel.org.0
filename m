Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6469F226EFB
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Jul 2020 21:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgGTTYa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Jul 2020 15:24:30 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:62079 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgGTTY2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 Jul 2020 15:24:28 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f15ef690000>; Tue, 21 Jul 2020 03:24:25 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Mon, 20 Jul 2020 12:24:25 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Mon, 20 Jul 2020 12:24:25 -0700
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 20 Jul
 2020 19:24:19 +0000
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.55) by
 HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 20 Jul 2020 19:24:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KsN95BOHzGvBv0BlHEEN42+19DTi/XrbmFN8HaaWhWpjhC37kUEb0nOb0/Im7klecYHF+xDF59eknJPQOOOBzOjYa0AOFJMEtZKkzWn4z4gr2IF3OCO0SJ8w2DMzpSMb3aXX9FsniAzRi5ynJDpHchCqQarhZ6NUOTa7361J6qIGaoEL+oSK54nwmlvmks2LI7BJPsxCPV2PuIpXpdhmudI/IqV6Y4q4wfNJB4pRZp4KRFfLGwSHCJUHE9eMGeJGkBZ8BBSkQExjK+mbz+EKIqIqFoSSmSoBrHxENaIYyo3HJ6V9+g2YaoWpkYImGHXQ0gqJjVW3iP7kztTgRKVq8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5FWVf8qK0i6bTGN38K08USuycBJ/hCwcY8v59r02C1c=;
 b=RjdnlvNEEbCP3qPTa8g5IOYKu3sCF2R7BtwoS1hsoXmKAIjGJY+p4ImkYA9lf+R8V/3HAVvPxrjXaKr5T1oOIn+e2vh6EfSZgTqhuDGi84vCxyfCN2bKfqZwDYeAVysS+00RjhD0yb1Bcm1HMnOrL6wIJnZtzwm643AI6J4K7LysT5F+4MpuloFKHwhy32ixbo62/i2QWTqEVDzSAOCuUHGrdUxYL5/CmKva07NZES3KN3eoMI06YZR0v/SrJeCjSuDdWpnpyIwGhLy+ooIES/JQe347D982FwvSN1oGttsK6jyQQYrK9XPil2jOtSdluRKUHRQx26o5sRHOdDXUwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0106.namprd12.prod.outlook.com (2603:10b6:4:4f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Mon, 20 Jul
 2020 19:24:17 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 19:24:17 +0000
Date:   Mon, 20 Jul 2020 16:24:15 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Kamal Heib <kamalheib1@gmail.com>
CC:     <linux-rdma@vger.kernel.org>, Doug Ledford <dledford@redhat.com>,
        "Michal Kalderon" <mkalderon@marvell.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Bernard Metzler <bmt@zurich.ibm.com>
Subject: Re: [PATCH for-next v1 0/7] RDMA: Remove query_pkey from iwarp
 providers
Message-ID: <20200720192415.GA3037999@nvidia.com>
References: <20200714183414.61069-1-kamalheib1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200714183414.61069-1-kamalheib1@gmail.com>
X-ClientProxiedBy: MN2PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:208:23a::27) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR03CA0022.namprd03.prod.outlook.com (2603:10b6:208:23a::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend Transport; Mon, 20 Jul 2020 19:24:16 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1jxbOZ-00CkL8-Fr; Mon, 20 Jul 2020 16:24:15 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29e44faf-b8cb-400f-bbe0-08d82ce27e85
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0106:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB01061EF1B052726D28918F0EC27B0@DM5PR1201MB0106.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gdFOLHAN5jLxq3BEo7+c2tqE8TKxgpi9Pm2ezYW48XVVjAYJyB7b0F7YIlMiM5dlpGQx6Mpt18zJYIfsxKUk0mKyd4447GkgixM1krOptkAUHDYMcqmMAT5d3fuSIe6y4jWicZI9377BIq9buug2Bs+OdwEDo7Bc7/pxeQlPpguFbfOpBIIKzpzTWxVnjRWJqA+ZYa0hg6F+YadcvIn576B9K6ZH/PqrUsLU4jD+bqGUHmxb5Bxs4ioxnY4GriRCtmp11Y3EvdEh4IMnRC3N5/lzht3e/X7/TrOKWCmWB/Dt9Hjy9V2n8c9dme8WdbSTBiRr8a1LPhy7UOan3qkViQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(86362001)(4744005)(426003)(8936002)(186003)(2906002)(2616005)(5660300002)(478600001)(8676002)(26005)(1076003)(66946007)(36756003)(6916009)(66476007)(316002)(54906003)(66556008)(33656002)(4326008)(9746002)(9786002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: dkxEEvqyzRxLHxbn12LmziETFCeOBUXmYWTAnvQKsEL+4QEPeXVV2enLx+Z9yKyzhIfP1e7kzH0lR33dqQ2H6lr4H1C1wCd+Y6ZgThr+u52gg4mSdB9Oa10hmsY4kGDU+j/KlisaTvT99ZnX+25tyB2kzby87fQDoqi6UFhahAp9wjIndvNCoPUajN0ybGNLwIzAA0vNKUIgDhSh23BYsheE/vntUCqV8uzbo6ZFgwnKqhPwaqRvEZZEmAviqsbSH74U/bECsyA++aFH/8BTfmspYQMJEBcMOpuNGxXYNphUtnsWqS6t4LK20sgaLzw/66ydr+xbBRxotdc+RDw8fdxe2HJsbvGEnTF+N4Eda//gc0aN7DwiZqcGEQac7V+E7CaaldKEDzgempWXQDpFsJ/K3r8WwdK5o5bx1DSV8mnXbS3X/6V2KPSwhn/HDgglGsWhnjOsajc3rB4+MQl2YZr5JtysWpzUiRbQ/Bl/t3k=
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e44faf-b8cb-400f-bbe0-08d82ce27e85
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 19:24:17.2248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0+Xt5lpSErIeUmXFc1Wmrj2SMF2+zrcSsOMXsw0bHQH1+tbd0F9q9FQXIQTLZEkX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0106
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1595273066; bh=5FWVf8qK0i6bTGN38K08USuycBJ/hCwcY8v59r02C1c=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=VAN4Uudd9lrwepOjHSoACyflQM4oJ7D8gHCoskm21X9zcdu2hiLFRggWJA6w4SGHc
         pZAoP/JWLhj2kISk5AXHfG60atsVuMPNDUtcFfZ/R7fk3Kf35PVHIWn1IyayhvZF8e
         unBXbXhDMPA9LXSziGJlZKhv0IxMe5PZC++QTX6gZQHM1J9uvo1DEN/LTR908ecfhY
         wJ9eEgqfV7y7OkXLvIJ6loQsmC5mAYv9leg3fxra72bazF8S9ZNietijyvFEK5zpIj
         FadiXyCQ5fTmFK9fY6byC6iPhHPBnJKMuS0v1rj7v1EFAY/x3tUQqdsB3FBH5Q5H+Q
         ZCpnxuKQN71Gw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 14, 2020 at 09:34:07PM +0300, Kamal Heib wrote:
> This patch set does the following:
> 1- Avoid exposing the pkeys sysfs entries for iwarp providers.
> 2- Avoid allocating the pkey cache for iwarp providers.
> 3- Remove the requirement by RDMA core to implement query_pkey
>    by all providers.
> 4- Remove the implementation of query_pkey callback from iwarp providers.
> 
> v1: Patch #1: Move the free of the pkey_group to the right place.
> 
> Kamal Heib (7):
>   RDMA/core: Expose pkeys sysfs files only if pkey_tbl_len is set
>   RDMA/core: Allocate the pkey cache only if the pkey_tbl_len is set
>   RDMA/core: Remove query_pkey from the mandatory ops
>   RDMA/siw: Remove the query_pkey callback
>   RDMA/cxgb4: Remove the query_pkey callback
>   RDMA/i40iw: Remove the query_pkey callback
>   RDMA/qedr: Remove the query_pkey callback

Applied to for-next, thanks

Jason
