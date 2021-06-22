Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAC23AFA07
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 02:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhFVAFr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Jun 2021 20:05:47 -0400
Received: from mail-dm6nam10on2043.outbound.protection.outlook.com ([40.107.93.43]:38656
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230403AbhFVAFp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Jun 2021 20:05:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/T3L2tVzBsfIK+ZNt2tFMMOfnjAa745wNWpeGryqe5112la/JMv6/LCqVtcz75UjIJ9N3dc9Z5N0Fx3AaBTeemflrvjNnSQSA7n0xGTVxn9qXt7JuEiMu0wA6DDju85oKPle3LpxVwS7SFfKR+eKEljX5wGJBwbY5Wz9NGnclXsijHRCy2qmysTuF5FTZjmHa5ntNx0hCGnicWPhJZZBRK00QyDJYb88kVi8gCWqMquNgpc0DtAYs1cfixqbwz+eGASyefu8n5Aeycolt97kI+eer4dC+RwBGxTiB/9zH+o/7pcasmYLtaYcI/oeOd3+0zV0CBaISRQd2i/6AMFKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ybu7EsAzZp2OUzdWBlP4VLza/VkF7qVCqvk7TZFq8Hw=;
 b=iBPw42ytpiiQuoa24z/okfi/CH1DfEMH2kELeYDeEBapsOelQTIDOREXAVtJebr/+P4ET9F5YqDNmrsH42cfcuTIiKRzYcgdKHhtm0CW4VnVZphcKlML7qFIK3ZwJ8atD98PkElwz66vOw8osHEEOa0Gj3oR+AQfMWzADvGQTwN8BwfGtYFIKXsmBqhyUoeKvHuY53vBRMQDBHo4TntrvpNMyeoLGKtnKsl+RcTSRhfG9mleEiXcNar70RRhh5JjBru7/A0N7Xw+CPnZ77ojJPKHgHBLW5M9nZ3TbxPLxsys1H+Tny+AfSx8/NyItkSoEpJpvIeZqm4IdhI+AfBfKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ybu7EsAzZp2OUzdWBlP4VLza/VkF7qVCqvk7TZFq8Hw=;
 b=Ghn4FnxZwUIuxedZgdVnQPuU8NPcuTkgxsNOoaBz/Cmvp3vAAODTibDpm2wvq+75pFlbi4Nfj9DbVBl1LLrg2EF9p/asWVVAARzaLl10ydpwQg6dG6VbQLBYhRcU3n57QZ1twoNxUvHX54KYxUE6h2z76UNepJNX5KedkWtZXlOhk4p948GsacHEcawVOob5JFd+yOk7Wre/hG2CC6yR71fPYKDYu7UgaUegRjnNLajr/syrwib9uPId7r47RTAINDVJ/LW+1oGKhaVYXvKYalyATOjb+3+i7ixMKYxz6B+hVbFB33cZ/zwtFCGaRPc4O6DHGsshwJTexKUu381B6A==
Authentication-Results: ionos.com; dkim=none (message not signed)
 header.d=none;ionos.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5361.namprd12.prod.outlook.com (2603:10b6:208:31f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Tue, 22 Jun
 2021 00:03:29 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 00:03:29 +0000
Date:   Mon, 21 Jun 2021 21:03:28 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jack Wang <jinpu.wang@ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org, leon@kernel.org,
        dledford@redhat.com, axboe@kernel.dk, haris.iqbal@ionos.com
Subject: Re: [PATCH resend for-next 0/5] RTRS enable write path fast memory
 regitration
Message-ID: <20210622000328.GA2381534@nvidia.com>
References: <20210621055340.11789-1-jinpu.wang@ionos.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621055340.11789-1-jinpu.wang@ionos.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL0PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:208:2d::16) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL0PR03CA0003.namprd03.prod.outlook.com (2603:10b6:208:2d::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend Transport; Tue, 22 Jun 2021 00:03:29 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lvTt2-009zYW-EE; Mon, 21 Jun 2021 21:03:28 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97530e56-a5ff-424c-44f5-08d935112a75
X-MS-TrafficTypeDiagnostic: BL1PR12MB5361:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5361732433C6ACB74766BA11C2099@BL1PR12MB5361.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /IUx1cZLcT7L0+RCocjFktuOs0unV4wnNlCOWoPytvoLY4tlv7HLj+swn61E1fOlWdZ/aD8pafu7+CJG6aLnMOb02YyGSYamm/qBKsnz9tAKwYgtvJp+DyEMpxXxA057RPUZJcyn9IvogUrhu5M0EhRFLWN1VSz3wgW5GPvF+osbHtsrwMpCkAqwYKfPMLE6i6sDwry1AO+PK72CxzGDmRh0zpTnyBJk2D09ICtEkvplaJ4UEE44rbbUWhS6m3iY+UrXc9DKwg9FHEdYpEceJnxhh2HUuiuVS06iGwT4C+ZqPVmPHjknAM28Z/1vers1/R1ttoRZQnvbBW8NhlCvdtXJc2f1y61G3qwkRU9LXk3fHEtyu7xLaDjzaqmUi68TRTkyWeYjdFi/f6SXgZ7HWZPUlrAD+jIfIdEn6YlFOD3u+IZ5FSmyWykvdxH6bnF47uA13a80MLQ9tawjpQyEOguUu4qJfKc67MYwluSN6QqtwIb4mAfodXaNiDuslbRYE66UNxW4SOcHXknVe092yHBX9467CAzC2hEdd+EZuVRUnKWr5/nT/f4TMJ2DuSSIaoGTNVaRHf7k05Ow1w9a6hl4W40gA6dsrawX2ap+Hq1mHuQDYRq5M7m/LahbexPtEMQ0LPKBs97mYmlwW3nIlWeevAJ4VTS4Fe5B5X1Juti8MNJ5iz7MENjlQNQE1SNZJE1qelXPt/U7bdn872wgXqyjLDAFww6xx0FFLw3ZiJ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(6916009)(8936002)(26005)(8676002)(4326008)(33656002)(2616005)(36756003)(186003)(38100700002)(86362001)(966005)(66946007)(426003)(66556008)(478600001)(83380400001)(5660300002)(316002)(66476007)(9786002)(9746002)(1076003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T4lrrZGaHFeqvWE+u+TfNFxrIXLCz/N3mQw8fKHOwdmlHKKLVaBb31xzKAQ9?=
 =?us-ascii?Q?o7GFBwAyx5sTqnj8G2Js946WWldU+JeH9EzXzT/6Z2JXsTyVvKf/wnDHqZ75?=
 =?us-ascii?Q?0y4yJwElSQVDWr69zZat3iL7uW0L2kITi2iBUh/7fDxv08qhb6chPxT+F9+0?=
 =?us-ascii?Q?+aCoM0INCfSY+WV6abt/vdzBJeWWm+hBesGaBHl4HQ+tVtyjwXcNW9IdWsX8?=
 =?us-ascii?Q?SC8ir7IqynfnXHvQedGgfvzGTsTC0AF0cBn4ofGnXziBYLJcK4zB0BumOWnJ?=
 =?us-ascii?Q?klDY9OQpILfLlo3dhW7wYobYi/TJc9sfF0+OgOm4qfnnKjIl+bOQAnFijlcz?=
 =?us-ascii?Q?u+dKzs9LTUHDsuI2p2eK2p/HDvZ6IeTCN0E41jU2X1a8cKTnZlnZg1v5a5mw?=
 =?us-ascii?Q?nCRac9mb0o6lGDKVxH63sdFs5tfkxcLsAY3YGL+6zNxcD1dlv6fEP0QCzz3j?=
 =?us-ascii?Q?e7+SR9jTFLtH1Oh2kBrc3C+eWIs3hPbXIZmHgQvCAFadoawVhelvcxvKLlPi?=
 =?us-ascii?Q?H5vJTD8MSn3Wy/3TJp72FAxwwe1ptfkE29/hs2xFmeHdQOxmqWH7ycx0cpJD?=
 =?us-ascii?Q?nNcvaal9g6gu0nIin7Ta335sVdEPLx4ItKOZnc0rDg7ex+lXFH89wTq0IA+A?=
 =?us-ascii?Q?hT3iLsi9Y/c0GPeLmnz27WJD5TLjIeW9P+NpvLuhxwtcTdeYx48sTXxmiDGv?=
 =?us-ascii?Q?ndIztZgdbdkeN4+BeM6x71m4X+QOeVeANfv96VBxQBU8pAWioxNmuHXGGX3R?=
 =?us-ascii?Q?S9yT3asfDbF4xu5HEEQMlgbklz+pwDfhFiJmPH9NzH+9zI3PUitKMhUPUhfd?=
 =?us-ascii?Q?evoooS3Stm8pctfPdlATnGJ2rZp/25qjQMNGULCPkFFjycIQYbA3b461FSAC?=
 =?us-ascii?Q?oouIASRwKXQV7ieBV1zQbTK053vZzxFKenkvXWFWIJfQMM0BAcdNRkirZeSL?=
 =?us-ascii?Q?n6wSabCKbW6ckgfsJQv1SmYWLv1HlC7k1FSDcj5XxbZBRhboduWZo7f7oCKs?=
 =?us-ascii?Q?uzY90+JaE1DryAUnnjiJd7UdVgM8xvDsz1tXC+u7JMPXGxlZ+jVQ1IOLUEJj?=
 =?us-ascii?Q?LLYfO97X/pSy/yF9KkyCoDML8t8v3S0tBZfAG/67ITb+MR2++ENLmbFwrlVP?=
 =?us-ascii?Q?HJT22MBQANUObijL78ZTr6k1aUwmBVj3tcVSQzYkzW+m1A2/eHO7cYTDtdAd?=
 =?us-ascii?Q?+ABDgCk6HRYa/Kc5GYQqPH/oTdoOR9Dvmr+0Zh4VwJqQGhfHx3AjnqVb1Vbi?=
 =?us-ascii?Q?tnqKuJU4bb70HelixkCUNqjRNr2wc1qKu8op+s8XqHIMFAq6iQgIzFVJ2p1V?=
 =?us-ascii?Q?kI+oj+nOOuD5wzj6JPcgN9ko?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97530e56-a5ff-424c-44f5-08d935112a75
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 00:03:29.4114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CBKoyE9v3KrpLnrhM/i4V/kos67G48yKJft3Rv6dP7lDz4Iq5aiF8ZtWkOuzOJs2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5361
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 21, 2021 at 07:53:35AM +0200, Jack Wang wrote:
> Hi Jason, hi Doug, hi Jens
> 
> Please consider to include following changes to the next merge window.
> 
> This enables fast memory registration for write IO patch, so rtrs can
> support bigger IO than 116k without splitting. With this in place, both
> read/write request are more symmetric, and we can also reduce the memory
> usage.
> 
> The patchset is orgnized as:
> - patch1 preparation.
> - patch2 implement fast memory registration for write patch.
> - patch3 reduce memory usage.
> - patch4 raise MAX_SGEMENTs
> - patch5 rnbd-clt to query and use the max_sgements setting.
> 
> As the main change is in RTRS, so it's easier to go through RDMA tree, hence
> send this patchset to linux-rdma.
> 
> This is a rebased on the top latest rdma/wip/jgg-for-next commit
> 7e78dd816e45 ("RDMA/hns: Clear extended doorbell info before using")
> 
> v1: https://lore.kernel.org/linux-rdma/20210608113536.42965-1-jinpu.wang@ionos.com/T/#t
> 
> Thanks!
> 
> Jack Wang (5):
>   RDMA/rtrs: Introduce head/tail wr
>   RDMA/rtrs-clt: Write path fast memory registration
>   RDMA/rtrs_clt: Alloc less memory with write path fast memory
>     registration
>   RDMA/rtrs-clt: Raise MAX_SEGMENTS
>   rnbd/rtrs-clt: Query and use max_segments from rtrs-clt.

Applied to for-next, thanks

Jason
