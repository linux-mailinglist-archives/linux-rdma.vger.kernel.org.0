Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF303E2A64
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Aug 2021 14:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343612AbhHFMKn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 Aug 2021 08:10:43 -0400
Received: from mail-bn8nam11on2040.outbound.protection.outlook.com ([40.107.236.40]:63095
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1343589AbhHFMKm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 6 Aug 2021 08:10:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e9BDeGPDGzjrGeVldy9rrY2ePTYbWxnpMrm3cHpwH7qfmZyR+KP2YS5UBRJa3Hz/o2e1zjN09qhe9iFjv47Jchuymy4VeybYTl5Rmc/5khzaZIjNuDRK9enNtT1csOOhTJc75B+Z94mz/LfmYBUrXo+MgFtYv/91i2JMhkzn+zPq1Kqy4ENUbQZfznaJZRd+2e8if5wsZB/DQrJtN0AcPK1a1g+yLJIDqyPB6xRZqSlXbbkWoFpUUHb+OnrNXlvy4L7VZzN6Yjk1yD0LldWHEjGF+xObXSUGixWW3Vmbvh+hTWu+GO0oV2m53Y11VMtsqYmIChTnlmc3j71DShDUIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jTlZmhnqgPusjbSgBMIS6GO32f0+K/VnzAfj5VRh5o=;
 b=OqPvrQ58rkltCP7hLPBulRlYdwd5y/jLZuGRyUssB8byqAH1T2HKTQUSqJTEthtu+7JXmFCLVPB6L0v+AGgU7ZhnwDIMH919a9KxiOwbS8T/6YL8VBhVErRxr6U2j8CGoj8u3EIqt6MeasEJY3rIwiVOtTuycAQjsqNI9SZYjB8BcSzg2SgYalJ+nl1aaLx5MRr3sHA3qoE98pjAXw77hYooFtyYbkM4Q+Ue8orLPM3dAnYAVHaxetYnqpqOnxkIoDHdv/qaQZ93nsWzi1zBRC3E4hfsg2lbUmBVPsYL3MF0w3WptT1iioKst3xUjBSTSTBf6vn0p1dTOPkelEUuoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jTlZmhnqgPusjbSgBMIS6GO32f0+K/VnzAfj5VRh5o=;
 b=UtCzD9xiV+iJRimlBlKxQoxarf5GQ1hwMCW/NkMpF0sNVoJaQLh2wv3U56fIfAR/RM89gNkVK+f31EuU6ijc8yNsqrG3+GFed0F1MNRUPcSj0kOQW6tyZW5YJhpK55AinrEj1lAq0grLIaxTl1/dKNFzM+ZNJFNSU3myIV5JWdRMJi0sHtgX3oSGX6dJnjaSc09b4zu9Xk0C6inOkwu/6eeGJXhSkfsaJ7ttsZDi+a7Z0rVC+cNEzYCWuCVlZsp4lFR4YCQ0/ejqzEqid4yZAAYSFkvIzcB8LqqMFAGrRCNsIaPABfA4ZuehPqfhUzICSV0shaj+LCEaC8xMebUyjg==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Fri, 6 Aug
 2021 12:10:25 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336%7]) with mapi id 15.20.4394.020; Fri, 6 Aug 2021
 12:10:25 +0000
Date:   Fri, 6 Aug 2021 09:10:23 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tuo Li <islituo@gmail.com>
Cc:     mike.marciniszyn@cornelisnetworks.com,
        dennis.dalessandro@cornelisnetworks.com, dledford@redhat.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        baijiaju1990@gmail.com, TOTE Robot <oslab@tsinghua.edu.cn>
Subject: Re: [PATCH v2] IB/hfi1: Fix possible null-pointer dereference in
 _extend_sdma_tx_descs()
Message-ID: <20210806121023.GA3391878@nvidia.com>
References: <20210806083953.193278-1-islituo@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806083953.193278-1-islituo@gmail.com>
X-ClientProxiedBy: MN2PR14CA0007.namprd14.prod.outlook.com
 (2603:10b6:208:23e::12) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR14CA0007.namprd14.prod.outlook.com (2603:10b6:208:23e::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Fri, 6 Aug 2021 12:10:24 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mBygB-00EEOM-32; Fri, 06 Aug 2021 09:10:23 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e2a48bc-0354-4365-685f-08d958d32be4
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5336707E6D6B12AB47E51560C2F39@BL1PR12MB5336.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mUOHMW/Rkto0dSS6+RDgkMxw7R7UvRO2MBJ4qpkrpBzn1FuQAsi5G/5x/+EQ3LISVqAbzziswPxDJ6SP4EHdQRnqO/QxJqD8d4VZv98YqSyk3r9fkb5UQOly9BPx5U2Ee0jrryCAOcw2jzYWLkjLQWOErQHhwPgWEMwwfhIjDuBDcFqkoQ6nTo8Tb3N3nUSdJxZfpXX/wB6u8Jb6vNRCgPy38Zr02FkjuyWpNo45ITcr/1aSdTACcQEQiluSzVfxPIkus1Qu1bEYcFVJ1HrIO9fgb9isrJ2A4qlQ6PEOrqcIosRJw9vXQ43MI6NnMru0jhkg+uh2hHRLG47ri6iQQSbSTR7S3v1X+EwnDcq+F3F3fGKzyOOp+OXL9k+6iR/pi67f8j4rIGRTCnkO4Aw3g96VhRsl2Eqlxuy4QnfGm/3KVTGAku2+eKgxDMR4DQlfTkZI3Db8fY6Nm6yY0/g2Kq5zpreUzFZTSgfvD6pllPnkKJEAnb/wZha9zbgAcEG79yKmvS8ksOPsmFdiYBZv3A3ZVy5UvVCbZR3RwHox3RNYk0iDlTKuFKL5Rxh1445i1YTkYVxWqVaDr4bMQ9IJ+3Y0AalQI4FAU62YaCRhAELlQG/xJkOMq+ArAh48z8i+WtIVnrqFRc4Mtmc1QvwvjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(346002)(376002)(396003)(26005)(8676002)(66556008)(33656002)(426003)(66476007)(86362001)(36756003)(66946007)(2616005)(38100700002)(6916009)(4326008)(9746002)(4744005)(478600001)(8936002)(83380400001)(1076003)(186003)(5660300002)(316002)(2906002)(9786002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d1UK5Yhyvhf75qfmhpKBJ8XPesOzX2Fo4Jz8z3DLSEI4rYrxuOu+T++s3UVT?=
 =?us-ascii?Q?tjN20IyZl1VCRySPDPvOfUOss16oW5ITBhHPnx5OQfPCb6mEB1acEZjpGz+9?=
 =?us-ascii?Q?R9c6Zc64L3fUrps99RizcIKh5UiiKDpKXqMfS8u5vehop5tMfTaZSBI/YoWG?=
 =?us-ascii?Q?ITvUF7hPBSJcSTkNwpPKf58u8glIXm/6if7XbqaZCBTCls7Nv1lL0mKVTofK?=
 =?us-ascii?Q?Jt8MrtZ+pRvMZs7CeaHq3fxw1ljrAlQkiaX7lSKyk7jANTVKvJtqaz/xYNum?=
 =?us-ascii?Q?yj/xZDfW3/+kgst5uRCsAmDqagMWz8BlFDV8f2k0F+tZ167yEHh8+a8xT+iF?=
 =?us-ascii?Q?TBYQzI2cBwaqjwqKX+xNChV9/aqJrV4tLoNaOWQDmDrykvuL8r8yif+/9vHl?=
 =?us-ascii?Q?DGMIDtBLlbw1Kw6Qey4XFvgpdnxkJcKqPblQ87+P7YIZIsxjYP5fbzk23/MY?=
 =?us-ascii?Q?YJjSBZY2cIhQjUyvVNujQeLOauwe01eC46sfHcGmrs41jiTXfCYVbSdM7UQG?=
 =?us-ascii?Q?wsCatOBuDe6LoAA3cSYT5woq+jj2ggIbHNdyEKm4jVjVFlJ4HeMVbjSkd1oB?=
 =?us-ascii?Q?HNi75790L0iuDOOVOtfMveSruOsewt7n+SueVay0kpcyNRtQ2wnj0awLobZ4?=
 =?us-ascii?Q?fdF8ud58xLrRDF8rbcvVzzPrKJ6bRaPffXF2uHME1/xu0TDsT8BfUpgBlyHk?=
 =?us-ascii?Q?SltHAMOORHchZ81956MSyxxOZYqZ1iaZMvwqizaQ7OL8xbANP2HNXVYaOVvT?=
 =?us-ascii?Q?fiyWKipmEAKMIamRxo4+jcDlwG6Sxrd8Dk+qDp41kwNHHbMWO+a8a7LNNmEc?=
 =?us-ascii?Q?XqFdNVO14P+OQzaN1ears+G8EOJtJFlU6LntyPTabpu4srkDEeoIWZdubIis?=
 =?us-ascii?Q?DEAfhXWx/pnCToxXJlXcrsnToDfjz46WCFsMxRFkoblIcbK3cf7kV5ZYB/2B?=
 =?us-ascii?Q?qm0I+U26JrqSU2Cio0fb13HcqP/ICAFABW6nlq8mPRIAZF9UO4gHXv7FfJlF?=
 =?us-ascii?Q?vRFb1jdaXb/qJjJTwyBFY9qRrKbilG/r0mZZErqnKwOUaNuEdY5KgcgfyUNY?=
 =?us-ascii?Q?4iah0odOkyo88dgCd7TysWpHQyEstpzzPR3Bw0OqzCMzK9Lq0vll81gV2pjw?=
 =?us-ascii?Q?UUIopuSzP6rP3ipZD9fjWJwzuAyHyAtOckspQyDSKZX/5Kv4t2mjpnKrgk4L?=
 =?us-ascii?Q?N05M+7ucijIQJKmZo5lNmTSTQMfSFqdzgVW9NcXV+uT3O2phvmVha4K1vNpX?=
 =?us-ascii?Q?+suSIvAaFZdWJY4HpypM7Oiy9KH/c9xDuH9jnOsuhCjGbGHrbyc1poKfdQps?=
 =?us-ascii?Q?TUqlgPs4BpGJX1ab6OErsUAM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e2a48bc-0354-4365-685f-08d958d32be4
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2021 12:10:25.1679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 54yLbvb7HjxdUoNjIDxPZhByQhebDEcdp/yBkGuYiCaH+onQ0Ced/KB95vg83Q95
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5336
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 06, 2021 at 01:39:53AM -0700, Tuo Li wrote:
> kmalloc_array() is called to allocate memory for tx->descp. If it fails,
> the function __sdma_txclean() is called:
>   __sdma_txclean(dd, tx);
> 
> However, in the function __sdma_txclean(), tx-descp is dereferenced if
> tx->num_desc is not zero:
>   sdma_unmap_desc(dd, &tx->descp[0]);
> 
> To fix this possible null-pointer dereference, assign the return value of
> kmalloc_array() to a local variable descp, and then assign it to tx->descp
> if it is not NULL. Otherwise, go to enomem.
> 
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
> Signed-off-by: Tuo Li <islituo@gmail.com>
> ---
> v2:
> * Assign the return value of kmalloc_array() to a local variable and then
> check it instead of assigning 0 to tx->num_desc when memory allocation
> fails.
>   Thank Mike Marciniszyn for helpful advice.
> ---
>  drivers/infiniband/hw/hfi1/sdma.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Fixes line?

Jason
