Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA44C2D6C6F
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Dec 2020 01:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388776AbgLKAR2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Dec 2020 19:17:28 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:49107 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731957AbgLKARL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 10 Dec 2020 19:17:11 -0500
Received: from HKMAIL103.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fd2ba590000>; Fri, 11 Dec 2020 08:16:25 +0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 11 Dec
 2020 00:16:24 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 11 Dec 2020 00:16:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4NOg2kYSueRWvorbctCQfxPnOt8svQUomsvL0srmqJaM1gjMySwtJmcEpWV3/R9V9g/1QO0gfkbCfnqafucPg7tKZsAkJsUQbomEl6cpqyu/WXaYUzfYgHReNU/o9iUOqMx3hat9BKZUqhtYL6r2WEsZ6ZooSStva1gW3xo4rL54qVavx7GHL8zRoFaEP/a3LHf7flvDFMjSLv+lljhOdYsJL0wQn/Zq56h1cTswaWS9GkUbywi54WQFXY9VODT9x6MAY1Y938eipqZo6nbn1ND6YV4u34TL+cLvQUHPbtIWKXOiyT3Avi/91wB3xEwPv5UhNYQVjd5xJzHU4sR8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwPtauTLJOVuEAmfrSJeIwR/Ikwux4PSkF8z6Y6zsU0=;
 b=aBkzXLMOzSY3YuaIvumlSdcC2+CCDf6XOlt9krqPK9YFby26NkFKgPGfRFILPyEGoh3+bpwHJfW6cMTc7QXISYXGdDStfxR69XAFdMkxlBz/LIYqCMrqtxlUpAtvo5uJqWzkQkPPLKYtq54+utKuRQU8ZenhTSqNlSX6qawt3UOYiCjk1inkQpZ6F23d0M1WWoyp80ARI6ddm9vQE4OmJPvxFS3Sj2/cI8dmXyc2gw5anLygBmwt5hO3Cu110z5YvAHsxhZoFcd9cqstHUz5miAYfF2lQmzk83ogQ4fqd1PuPBAJQbH7/wZNBDE4xI2NMYeIlFS/yDGib/S7uUf48A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0105.namprd12.prod.outlook.com (2603:10b6:4:54::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Fri, 11 Dec
 2020 00:16:22 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433%3]) with mapi id 15.20.3632.023; Fri, 11 Dec 2020
 00:16:22 +0000
Date:   Thu, 10 Dec 2020 20:16:20 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH v4 for-next 00/11] RDMA/hns: Updates for 5.11
Message-ID: <20201211001620.GA2159051@nvidia.com>
References: <1607608479-54518-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1607608479-54518-1-git-send-email-liweihang@huawei.com>
X-ClientProxiedBy: MN2PR08CA0004.namprd08.prod.outlook.com
 (2603:10b6:208:239::9) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR08CA0004.namprd08.prod.outlook.com (2603:10b6:208:239::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Fri, 11 Dec 2020 00:16:21 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1knW6e-0093gI-9B; Thu, 10 Dec 2020 20:16:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607645785; bh=am5L+y3U76pSwdvrC44x45tLJnB+9DlD6F63fyMn+ZM=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=RHsuZOWMcor+bVp3RoRIrglSUADed8/6DdegcVmfNNjkMhj1OAK6xBzZFHjZJ6HNr
         8GreOzB83Su+Ge3luKpsFeZkAC79sYM3gePwYwWl1i4kcTpWlpPqnKA/5guiYdayZ5
         xC/QFd8gtF2nBHQ80j1XCEpryCm9l8DMVK1keoRsznambBf9Y2+u8Qed28svdX6I5j
         WOXeruGY0S+hQ4tBl9wtWHPhfe1kUWwezkgQ2eo+kNuC1RcBUS3mf3kdu1kZrCkdGB
         IPBuighVp6WuHMuNq4gceBoz+hl9ISeqKcS7o+p4nU5rfc08DyMggfjogVWQTs1EzL
         Ae62C3ECodq4A==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 10, 2020 at 09:54:28PM +0800, Weihang Li wrote:
> There are miscellaneous updates for hns driver:
> * #1 fixes a potential length issue when copying udata.
> * #2 fixes the unreasonable judgment when using HEM of SRQ and SCCC.
> * #3 fixes wrong value of Traffic Class.
> * #4 and #5 fix issues about Service Level.
> * #6 ~ #11 are cleanups, including removing dead code, fixing coding styl=
e
>   issues and so on.

Doesn't compile:

In file included from drivers/infiniband/hw/hns/hns_roce_hw_v1.c:40:
drivers/infiniband/hw/hns/hns_roce_hw_v1.c: In function =E2=80=98set_eq_con=
s_index_v1=E2=80=99:
drivers/infiniband/hw/hns/hns_roce_hw_v1.c:3606:42: error: =E2=80=98struct =
hns_roce_eq=E2=80=99 has no member named =E2=80=98db_reg=E2=80=99
 3606 |          (req_not << eq->log_entries), eq->db_reg);
      |                                          ^~
drivers/infiniband/hw/hns/hns_roce_common.h:39:49: note: in definition of m=
acro =E2=80=98roce_raw_write=E2=80=99
   39 |  __raw_writel((__force u32)cpu_to_le32(value), (addr))
      |                                                 ^~~~

Jason
