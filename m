Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A4F3AEB88
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jun 2021 16:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbhFUOkP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Jun 2021 10:40:15 -0400
Received: from mail-dm6nam11on2074.outbound.protection.outlook.com ([40.107.223.74]:5217
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229747AbhFUOkP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Jun 2021 10:40:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mB/QLMHvURV7GFheJaU3bWR+ajasDl/5FBXvyYALUtNqI2VDiazMPHlrUSPsIw5fejG8oFjXTzeDg2fbFgFYmulw2D4YiZzq0P/va2JXfao8191Z+ZcuEHCB8RdywxMIT/StVp1XgkP/kbNcYFeoSbPamBX9rf9DvzrsQ2C/4ZH43A+uSLfpY22L0GCIA2tssjWOSA200fE6zb8B//oy47Chk5MX0nIvwo/mpdxO1LGwD7a7tW8BKXfGRKpI0zCYvm6CZBLalOyklau33BYzQN1cDkqFM/NGgqyPke7kOLoPy2hDWFtYtQz3N2M82wGhG2mZrcbjN2oS7AqI6R4LAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ApDlmN+zAgILT5kH3ElwVnMjJcPvg/Vs9hza2MO02y8=;
 b=F46Bvn0xY0xQqtxRxogISxNkqnP6cDQYJojwSFXpXnNkwSizdpW63ter5bfrgSabICxKYSw5/h3Jlhdqr8CpwRhYtmB8ObClvyLTSVbZHCGBUJH2fmfrhqTNkmgr/lbsD0SKpK2p7h8pPjUvsJUyl4Udo0g3jKS6mdOXPqqppAc9/kdEuaF0o+O5Rg89vu+BxN9uZq3Y92Fjcw+9Bap9EaAfQAag0/wTHO+ngflp8x0j+Wi/BXFvVf5EDaLyU1qTR8hEGVmhvgzQPEdVCdT64aXqxh9WMWtF1b4AG3jhvc3Y2WtOa/+QK3AnXBuoJOPsq1OBKmEN2h/cEAuMBEZPHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ApDlmN+zAgILT5kH3ElwVnMjJcPvg/Vs9hza2MO02y8=;
 b=IoVwFB/p4+22PFAUNOVHkczwovUzpf8Jr7nYHpvpjJc1H7TgYE2Sn+vidS8pUlXZUvX6PIZMCQAUrCCYSIvObWA4eRzogLspb9VcK91K3Z0c9FfkbYpizF9we7ona0f4ywaXmTLmWNHaw8vXFyuWcDCUtt5/H2MZEj6DqIMdvrg4sWE/+sV5HMUpa5lNjUXZXKHjzqRdlt8mJcNes3d5lW3pwOcbxX/V7glm6PiAwo0SdCV8c7x2G5PTzWzpHHyt0iXithwzJPJ61zN3by83wPZedjZ9MlL74M06GXfsR9NnEGJrSSHUiaTc4E8Eo88AjZrNwh2stYC1WRl05EluKw==
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5351.namprd12.prod.outlook.com (2603:10b6:208:317::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Mon, 21 Jun
 2021 14:37:59 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 14:37:59 +0000
Date:   Mon, 21 Jun 2021 11:37:58 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Haakon Bugge <haakon.bugge@oracle.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        Hans Ry <hans.westgaard.ry@oracle.com>
Subject: Re: [PATCH for-next v2] RDMA/cma: Replace RMW with atomic bit-ops
Message-ID: <20210621143758.GP1002214@nvidia.com>
References: <1623934765-31435-1-git-send-email-haakon.bugge@oracle.com>
 <YNA7ZnKIKC217pCw@unreal>
 <C8E39F1F-14D5-4DBE-ABE0-2EFC20353D83@oracle.com>
 <YNBhuZNjGvUsJHUy@unreal>
 <FB3E1A32-A1BA-48B8-A20D-99662CDAC921@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FB3E1A32-A1BA-48B8-A20D-99662CDAC921@oracle.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL0PR02CA0048.namprd02.prod.outlook.com
 (2603:10b6:207:3d::25) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL0PR02CA0048.namprd02.prod.outlook.com (2603:10b6:207:3d::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21 via Frontend Transport; Mon, 21 Jun 2021 14:37:59 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lvL3m-009X5s-Qt; Mon, 21 Jun 2021 11:37:58 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78e8ac37-9894-458c-0b09-08d934c22ad0
X-MS-TrafficTypeDiagnostic: BL1PR12MB5351:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5351C62E3403144157A9A852C20A9@BL1PR12MB5351.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:357;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GuLAZMjN9rALuCFE7dAdYDIhi9vhoTHsb87V9W05QOIi2lmh+5un6JCnhFuAz8P3QMAlw0taVUI0CyuWzYh/ZEg5xyf/67mYKtq0e/gM9YhD/qAqJYrvX9S5nSA6Z9+ceXPbZ2RmKYw6AqwHGcAHO81U/BakJBIfBWxENLSRm+pGJF3ZAJvrsuMGUSyCtXZ3hItWnNhqjkzgttH4SPvDoMWdpBSqNFxDmDNa1OJdIHMTgS/HR9PI/DiBoJLSbpYWGO150l08NdLevzPn0EY1C4hNTzzmaM8RHTwIOiZ70LsWn8ppV2nkkmBprF5Efi4EkPbQd3qcgu2hBEBkZJfDzNi81lKXjxkAbkzxR/trwA9HfditfGQNvwS+dLigEIF/uJ8zzGlFD6qTySrU9Hbr/4sphfv0qvBoarCex51XLCH2XpsJr/HrM0O9E5TU5Eiby+Y8E2r64+X5GkXCTcbtGGmEEcZWbUDevBgavgLqvwoeGVS3n4oQpm0ECTXZgroSUvjx50o2H+HcQ/Zxlu3Ny2nOAJDiafTXkyY8WzxPnp7ZcZlOMz8SEB923nib0w19/AoupPqI8XgWeTA7nA+KEIk0Y8Jfr+eto1TZFN+m9hJ6aOFN+iHN7+ivo3uY9dlsFyuNLYQ3VCRiHvf7F/ymStZ3aQnLs0SzEMvgQED9Rtljlz8DbH2IiNrK6yjzwa0v3rpb8sfQS5nUdjIEXWfp+yXE4wr/jAj6McDK9sXMWk0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(39860400002)(366004)(346002)(33656002)(478600001)(2906002)(4744005)(26005)(83380400001)(5660300002)(966005)(186003)(6916009)(8676002)(66946007)(36756003)(316002)(9786002)(86362001)(9746002)(426003)(38100700002)(54906003)(66476007)(4326008)(1076003)(8936002)(2616005)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZzGdIhi2d8hkV9q1HIgIRUk4rLlLC+jr6ofiVUZWv9TZBvQNOTrGa3yY7oxw?=
 =?us-ascii?Q?UhiCqJv107VZ+u+0YRLDq+BtAZLaQYXqD1A8cM/iN7nv0KXPEJGbekuebiyb?=
 =?us-ascii?Q?qitnls9W5d/psrMhEFD+OZWlkyZUNMJltcjpp5N0UX+LFaKJpzDLne0Hi2bG?=
 =?us-ascii?Q?F6xgLSMIj8mhT74pmm8DxEs7q8a7TJlTu5bZRu+trWr2F8NY7SNzS+zHpWtc?=
 =?us-ascii?Q?87+jhTRT39vkCUWCs0KvcVcbh2VM2SemmbKYGXOcz+mq+s5gKbyMfgnl1wRC?=
 =?us-ascii?Q?r5zWHJgrgUAJaKuoEzpeZS1Z/HEOvEKfNvMbacD41+V8DjHFRn0pu7n9+zdI?=
 =?us-ascii?Q?ftOGA+rqGBEAKIXkmxXrn6NkzI3cTLxRU3QqCZAUQckfiONcGqsqC8A1DGso?=
 =?us-ascii?Q?KWpVb6hhJi4mj8NLxHDaOZXO7opuB2Q92/e846Hsy9CsJskBk4ni5IzLBOWj?=
 =?us-ascii?Q?n7li0mXOqSwCRn2Z4x/5OMmrFMfszpamig8NQCoJxpnmXjTpo85e/FAyfEHO?=
 =?us-ascii?Q?T8Km+ePBnY1lWUGGOpqwejImgXvOf3SZjP44CRVJZdRvULu32oP+VV9uQOx/?=
 =?us-ascii?Q?tzGW9lDXL3li2myPkhw4caNU0z7M0Szb0tOVPAGaTfZeR7HZak3cBvquqxY0?=
 =?us-ascii?Q?gLOyYvBrfiTdI/GjxTHXAT0H6qBwtvK9d8MDOrKR94xnArVDLzCOrun4iXD8?=
 =?us-ascii?Q?XBxOMgQaDqXS+nxRXwQZ9jBSm2qByaEjsPT17C5KE4avqE5KMuiUOGUP611n?=
 =?us-ascii?Q?6Ax1LjBOlx4rh1JXSlEsZUwxULfGW8luvdlyU7nmUbtDg8poZBOlVTQrmyo1?=
 =?us-ascii?Q?xCPyc+OmKDbYWEemYH7QP2PbOqUMaK0Y4IdTaF8V+MJCLdkyk3wIMTNP7hNC?=
 =?us-ascii?Q?5P6uSZE0Qknsz5jTnMYlT0CDwUQlVhGxdJgDf25+/8FPSdNms+rveMtEWaJE?=
 =?us-ascii?Q?H7S+ZK4kGRleGFq+fxDLYVOnOYkJf+MuTsNrdXsprnX579hMcsGRZh5x5pJZ?=
 =?us-ascii?Q?kKk7xKemvncEgPm//kDi3ExUYS3ZtcYdnsn3qyONXN2qraOe9XC7X4v7qGkP?=
 =?us-ascii?Q?bsKX0pzJiCvE/d+QHJ/9BL+CUzThgjHD5W68STVB9Pd2Q2bYNz3emV6LQo0z?=
 =?us-ascii?Q?OhuvGb9SIgZd29XK+WmEJE3F+04se8tHeLTa4qnG6MSocHOMq4zhJ7voFnFZ?=
 =?us-ascii?Q?oDMFTzGcK9CD9yhb9jRqxgubKoN235wEsTwoi5pUFA5OLTZnTuGcoGi3B3T7?=
 =?us-ascii?Q?7N2C3wBv0c5CkBP/D7vQjOf/NxiE7g+zvkKcp4vp/+WoqbLCq3KTz78ORIoN?=
 =?us-ascii?Q?5nuMXs1tp54XDxpn4ZT8tb3r?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78e8ac37-9894-458c-0b09-08d934c22ad0
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 14:37:59.8054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QN10MsmKoYcaq5L84RCblHnrkPceCba39U40/w1sTQQdtyduB/1o8oPuQjibJPSF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5351
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 21, 2021 at 10:46:26AM +0000, Haakon Bugge wrote:

> >> You're running an old checkpatch. Since commit bdc48fa11e46 ("checkpatch/coding-style: deprecate 80-column warning"), the default line-length is 100. As Linus states in:
> >> 
> >> https://lkml.org/lkml/2009/12/17/229
> >> 
> >> "... But 80 characters is causing too many idiotic changes."
> > 
> > I'm aware of that thread, but RDMA subsystem continues to use 80 symbols limit.
> 
> I wasn't aware. Where is that documented? Further, it must be a
> limit that is not enforced. Of the last 100 commits in
> drivers/infiniband, there are 630 lines longer than 80.

Linus said stick to 80 but use your best judgement if going past

It was not a blanket allowance to needless long lines all over the
place.

Jason
