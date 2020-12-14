Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 605272DA06C
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Dec 2020 20:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502659AbgLNT13 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Dec 2020 14:27:29 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:10313 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502187AbgLNT1V (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Dec 2020 14:27:21 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fd7bc700000>; Mon, 14 Dec 2020 11:26:40 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 14 Dec
 2020 19:26:40 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 14 Dec 2020 19:26:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mhFWUfpXinA/pAuhPX9HKPi8UJdJcI5WzadfPpzAOWyZkIhPkYabrmeKAtzH1TjTDBzedUjcgwD6pytzr2c80pbv1TURbEU84YM7Q6ELrdOqEolUTCe1YaCjk2wZEzXxxNmgMA6LAuWmbeC0TnFyhWiL5pgYSAHsx/8fM6uEbaLqoqbDp0JkkrF9YCwfP2vGD+jJGQ9xpa4vZ1Mt5B4XNFgSVOEm+KDgVPhtJ9O9nqiEnaPcfPY3XV4XluSWWHlyGhTUF7S0gdN7Yof/0LAz2Ve3U3ohExQgwzUhHLYihqdL2kFsnPNsnq1kyB1FtAzD9Onn22p8Zoh6uPNOlZWaOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JlYNMReQYSJl1kA3NgKxsZ0pluDWNzQvskjAF1cCfW4=;
 b=PVBi0RzozWmlMCsm2OsMozzzHARF+xqMO6p+I7B8PrnXLszRYnZY520tKOhWu65WRDWu9MgejhDXGTmuEaamBmuCifOx7vlKptehq5lMJnqfnrfYOpEc2YXHDogE8Lv95MgxIEJzmdef2Xa9t/+SJojj2fulhBWAL93dulvAPWhP1WBafawYmSL3ctmaDmLUqd+VWU+qFfEwaPYgp0bEhVhHMQDzo2ujrq3/oqikqnckSHXpj1zmvoObUyq8dsFHRlWeQN2eHg9bNbN0x4SYJfkfdHieKq3Pwz5cOGhWOR+YFZGbyXOlrg0Ghb6Up5Nrxv8v7iqk5LIPh72GVrhfmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.25; Mon, 14 Dec
 2020 19:26:38 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433%3]) with mapi id 15.20.3654.025; Mon, 14 Dec 2020
 19:26:38 +0000
Date:   Mon, 14 Dec 2020 15:26:36 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        <linux-rdma@vger.kernel.org>, Parav Pandit <parav@mellanox.com>
Subject: Re: [PATCH rdma-rc 4/5] RDMA/cma: Don't overwrite sgid_attr after
 device is released
Message-ID: <20201214192636.GA2551375@nvidia.com>
References: <20201213132940.345554-1-leon@kernel.org>
 <20201213132940.345554-5-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201213132940.345554-5-leon@kernel.org>
X-ClientProxiedBy: BL1PR13CA0183.namprd13.prod.outlook.com
 (2603:10b6:208:2be::8) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0183.namprd13.prod.outlook.com (2603:10b6:208:2be::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.5 via Frontend Transport; Mon, 14 Dec 2020 19:26:37 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kotUS-00Ahjy-6y; Mon, 14 Dec 2020 15:26:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607974000; bh=JlYNMReQYSJl1kA3NgKxsZ0pluDWNzQvskjAF1cCfW4=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=dqTNeB961rtG4B0nNQq6xI1+btmOr/UkvrtGibuRhX9pvhSuNi0QAh5d0m4dRt+it
         doJOHEmy6dt2yqSZ+5VzIJ9q6aIziZrpa4tIbdmlHBmt+ZI7s0Og/m9B9U27uuPS5Q
         g8ruaxwzSfHP+Z362sZHxJcXOI9snRB2Z5VLsq1ClF441VF702U4IlCq/SWHmj/9q2
         ZtqjzS0eiBQ7NOI3fIsnRAomaOZQdt2g133G4lK4z2ZpJzoo44z/99WArLC4FlmG9o
         pWMhyuYWRkS8lcOrfqebr9//gly/uApNEcYhDRUmqbnMCDJULkjvgaru5mF3qp/Jin
         oswo0rbWhOT6Q==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Dec 13, 2020 at 03:29:39PM +0200, Leon Romanovsky wrote:
 
> Call Trace:
>  addr_handler+0x266/0&times;350 drivers/infiniband/core/cma.c:3190
>  process_one_req+0xa3/0&times;300 drivers/infiniband/core/addr.c:645
>  process_one_work+0x54c/0&times;930 kernel/workqueue.c:2272
>  worker_thread+0x82/0&times;830 kernel/workqueue.c:2418
>  kthread+0x1ca/0&times;220 kernel/kthread.c:292
>  ret_from_fork+0x1f/0&times;30 arch/x86/entry/entry_64.S:296

Why has this been weirdly HTML escaped??? I fixed it..

Jason
