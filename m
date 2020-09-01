Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1ADF2584BC
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Sep 2020 02:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725929AbgIAAVW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Aug 2020 20:21:22 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:48182 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgIAAVT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 31 Aug 2020 20:21:19 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4d93fc0000>; Tue, 01 Sep 2020 08:21:16 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Mon, 31 Aug 2020 17:21:16 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Mon, 31 Aug 2020 17:21:16 -0700
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 1 Sep
 2020 00:21:15 +0000
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 1 Sep 2020 00:21:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bAF+7/qytkHbGjOMjzpOaO1+GMzXtf1sNbFLRng8Lix59vRDiBfj8nw8GLUSZiyV+wSPHv/PEpjYeSSd5LfWNrip3frr/MF+ZPYSaKOuuPYX6H2ZHaOCLZn5P50bxE60FXPgKfRSb8X3vsh5Pn0NG9FT7vYXtOmiE5IRlfBTOyYZXCOYG/SbukwdQ+Pv9kY/534Mq4QhjPIgv+KT4DLAN9w5BpZqXnwY+Q34/yItugk23AxqAi9pZMH+n/5Ckvk37Hcwq7hWoXSFOp5LEVj0WuJ85KEDeyefBGsnCkd+/657u3yoqQVovgUIuXLTeFViPJjTJP5iO8LuaKQdVNzdBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stkS12ppjBNfZldOFyqGDVrwDiN2R9/iTnAheZzGRoI=;
 b=X/Dt+dT4mi9WQbf8r279TdPTpXZ8aNKKRGxnnHAyjdvQwXXv/75eUP4M3QoUIIO/qIMV13ekFEXuU5qjA8q/c4f/roPdTlR/eZXHqVikq/4++ZgES6tOuNIHJk2iIQ48c1tEPZ3Y3CXSqSulA3bNrR7UmV5YerMd4cUGyYb7T6nD/FCyzBblwlgeNGx6Tl2zLvP0Y8Av/Ca2bDv7SP7WH7mg4u5dGdfKRqC0389az5ROM6YkYFwpDdAbfdVIdrPMReBLcTQKb5UxRUR375vJd0+Lpxx9Ot5Ia91+I91lBnY/yL5CivXtklw8LiHhT07/XbP8zyZHk733tPvnJMLLtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4009.namprd12.prod.outlook.com (2603:10b6:5:1cd::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Tue, 1 Sep
 2020 00:21:12 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3326.025; Tue, 1 Sep 2020
 00:21:11 +0000
Date:   Mon, 31 Aug 2020 21:21:09 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jann Horn <jannh@google.com>
CC:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, Linux-MM <linux-mm@kvack.org>,
        Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>, Dean Luick <dean.luick@intel.com>
Subject: Re: buggy-looking mm_struct refcounting in HFI1 infiniband driver
Message-ID: <20200901002109.GG1152540@nvidia.com>
References: <CAG48ez2EFXnDEue=bOs6n01FHGa4rUnwET6hBVNjcKoMjR9Y_Q@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAG48ez2EFXnDEue=bOs6n01FHGa4rUnwET6hBVNjcKoMjR9Y_Q@mail.gmail.com>
X-ClientProxiedBy: MN2PR10CA0016.namprd10.prod.outlook.com
 (2603:10b6:208:120::29) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR10CA0016.namprd10.prod.outlook.com (2603:10b6:208:120::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Tue, 1 Sep 2020 00:21:11 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kCu2v-003Wq6-MZ; Mon, 31 Aug 2020 21:21:09 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11a119ef-9bf8-4157-144c-08d84e0cee38
X-MS-TrafficTypeDiagnostic: DM6PR12MB4009:
X-Microsoft-Antispam-PRVS: <DM6PR12MB40094D07D7C846BF2EB43917C22E0@DM6PR12MB4009.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DdpR5+XP4D5oaVLiLjnGKIFhsOH39FsiJ4Jmoo18I46HlIvDUSuYXSXIpOLuYIuhpprIgn/tNaBPCNvNUCqO3JoignRL7FlxAZYuEArskE8Ew2ElbhXxiygbOZ/iHU/rsTX1pKODwYD3U9lh0sl0v7697FHYpC3/Y4X8icF8I/RJwQKBpete8nIhejEEANJwTsId5v6MzlXZ9hwKtL/Csty4yoFvMQVie2GC3daKJUPzXKw/aHY+0vXOTrF+NOl5V+ExNG46JDMhGEe5ni2p3fB/UtVNMNhmR3Ym73LQe/gsEaxK9KdjVI5t7FHepx3FmMIERkTExx3Ksq0taKJy5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(366004)(346002)(136003)(2616005)(4326008)(33656002)(1076003)(478600001)(8936002)(86362001)(26005)(426003)(8676002)(186003)(54906003)(66946007)(9786002)(9746002)(316002)(6916009)(66476007)(36756003)(66556008)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 1Przz7MCREFScvCcFANxeU6UP9P73DKByqdkH+8gcsS1WtTwmMVf5HRN+1AWU6c0BjQ43JMJjfVtNZgQV/mRyY1aPzeKmEjrQ2Dw4ML6XP2ohaGsxW9jchqQhnxBS7Ymh9Fm4OmdNiocleEtrI7pksrSrm6XVe0yEZGCI2bG5Z+f88mEa/bd1Kt/b1A0FKJKOu0QwkvLjA0P93j2PPmEHPFUNS2vZQ0jP3yUh8PTovmwx8MtM5jaVpbE5KE73Xy8ypY6bpdqtWBjxKEYzaPf4hGOzUazAUe3kVAuEZmqBShfQzRXS2kx5x6aquetZfem+w5TfCkcuv0GP8lGC/Uc42ko2yySmkYzVonI1601VtBVXYhLhd4PUIqcrjeoci0S2yjs3xStO29POMXaOwCCBvvGtFSDFZfjfoYWHdKc9BiZuT9UfTqHYPs4SggborCXWnbIcibqsLzBf9uBIhUbS+9kymqeyNqVol2V9A9i33+KTZHHD1wysGaoaLwvDA8RNmn+2xKXc1qbn+FaY9kc9S8RJ34FOS7C9kVt/V9dMfwamUH2inmspb9QiYCJfWMayh0BTmFJWsakg1boUh2ZMinvHrXmzT0goLH9Ot6WQMdDpkrASya+mU9B9fa5aVD7fqB9KQRsbAYfI4ssHt4S0w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 11a119ef-9bf8-4157-144c-08d84e0cee38
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2020 00:21:11.8810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3hzzUrTGaNtQAb2UyHdzTAhP25Wqd/xQv+fdavW5bJDxLCqLUuv4g7XAhF9lRcJE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4009
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598919676; bh=stkS12ppjBNfZldOFyqGDVrwDiN2R9/iTnAheZzGRoI=;
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
        b=SKar2+Q0PBl/kAocNPCyAgSt5/X/CvYTh+OgIAXKabT23br6dTDBg3vJjKK9IYTTM
         OfkXB3BvU+WOAntUmSnZw0N6QnF9LqoqXL+0y9MVQVnI4nYHA7OCl2ikSLCmtTE/jZ
         iRHFhN5lhRYOoMricc2Dq7aKRXZzRq8MtHHjKMEOOT7+S0IMuUAqjzRyM2dffQaThP
         KMSJyMazprUQDDRNgEMflNZcuiHAjdzI1y3CRpwDVr+myokHXUFNv864hpL8tKi+J0
         dVlZaQVKZd9w/p97oeED0z4wo3XbT/uGTDCubcA+2qWzr8MF4/Kque9rO0THS7HbuW
         LojiYUH+LrXRA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 01, 2020 at 01:45:06AM +0200, Jann Horn wrote:

> struct hfi1_filedata has a member ->mm that holds a ->mm_count reference:
> 
> static int hfi1_file_open(struct inode *inode, struct file *fp)
> {
>         struct hfi1_filedata *fd;
> [...]
>         fd->mm = current->mm;
>         mmgrab(fd->mm); // increments ->mm_count
> [...]
> }

Yikes, gross.
 
> However, e.g. the call chain hfi1_file_ioctl() -> user_exp_rcv_setup()
> -> hfi1_user_exp_rcv_setup() -> pin_rcv_pages() ->
> hfi1_acquire_user_pages() -> pin_user_pages_fast() can end up
> traversing VMAs without holding any ->mm_users reference, as far as I
> can tell. That will probably result in kernel memory corruption if
> that races the wrong way with an exiting task (with the ioctl() call
> coming from a task whose ->mm is different from fd->mm).

It looks like this path should be using current and storing the grab'd
mm in the tidbuf for later use by hfi1_release_user_pages()

The only other use of file->mm is to setup a notifier, but this is
also under hfi1_user_exp_rcv_setup() so it should just use tidbuf->mm
== current anyhow.

The pq->mm looks similar, looks like the pq should use current->mm,
and it sets up an old-style notifier, but I didn't check carefully if
all the call paths are linked back to an ioctl..

It doesn't make sense that a RDMA driver would do any page pinning
outside an ioctl, so it should always use current.

> Disclaimer: I haven't actually tested this - I just stumbled over it
> while working on some other stuff, and I don't have any infiniband
> hardware to test with. So it might well be that I just missed an
> mmget_not_zero() somewhere, or something like that.

It looks wrong to me too.

Dennis?

Jason
