Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E38182D19E7
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Dec 2020 20:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgLGTmf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Dec 2020 14:42:35 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:5526 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgLGTme (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Dec 2020 14:42:34 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fce85820000>; Mon, 07 Dec 2020 11:41:54 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 7 Dec
 2020 19:41:49 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.50) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 7 Dec 2020 19:41:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AtZ9aPoiaB7Gv2iSE+H4ZA4LEC/zk26inv0m6OdHxt/Z7WD6igBRe18YFvXwPz1VeKg5U8xz1QCf9P7xuJ4r8B524SWLgLRx7R86IdiyQOgN9Pwc8il2ci5y7fzov2Re7AbqwVzeW1Wt4tyY33qvoueVixkpMztbJAdzU8z+VTGi3BGTaolJnUMtnU/0HP13zcjKVcb0IspNK9fhkpVswTRzzcQMnN6bh3hCa0oysxwQ/i37fh1kGXcopU6f8GC7Ywy4H0NrzrxaswfAmbsNoJAvCy9jTVy5TP6mD7XyydBiiGmIg/bWccNC/AoJhUMSt5N1Zf7FEwVYiOIOwCynHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqTy8dDKl7SjE0J6RfNFvzfdvO9nKXmsOrzBKAZzcws=;
 b=NGWaZRqmICN8bwJsaFwRKcS1kTn279W8+OgS59ek7LFylIEm87hg3UxaUEesqx057YPQU185Wtm8oZ8/myuqdmgoy/1jhHbfpzlWvsIhIPnJsl3rTKwD2OZpFCw5sMQqN9YXITJI9cQJVZzQ7g4hh5qR9BzKNDQfbdyPnLUb6QiE1RmH8cmkZNPRqrso9BAJPrfPa8p6DftkmE8njJV1ln+pCY7FRcpl4ixjEQB6Dak3wthN5Ldqn11qDNhO7plHribOT7mIJoHTDbx9C4T5ZAJzurXF1XH6e4xy3CYzjoA5SB93hhCzT10W3FxhEWrCUCeYLFRLVksv7t6mNy8VmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4010.namprd12.prod.outlook.com (2603:10b6:5:1ce::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.19; Mon, 7 Dec
 2020 19:41:47 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433%3]) with mapi id 15.20.3632.023; Mon, 7 Dec 2020
 19:41:47 +0000
Date:   Mon, 7 Dec 2020 15:41:45 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yejune Deng <yejune.deng@gmail.com>
CC:     <faisal.latif@intel.com>, <shiraz.saleem@intel.com>,
        <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] infiniband: i40iw: replace atomic_add_return()
Message-ID: <20201207194145.GA1769554@nvidia.com>
References: <1606726376-7675-1-git-send-email-yejune.deng@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1606726376-7675-1-git-send-email-yejune.deng@gmail.com>
X-ClientProxiedBy: MN2PR20CA0064.namprd20.prod.outlook.com
 (2603:10b6:208:235::33) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR20CA0064.namprd20.prod.outlook.com (2603:10b6:208:235::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Mon, 7 Dec 2020 19:41:46 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kmMOH-007QMT-PM; Mon, 07 Dec 2020 15:41:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607370114; bh=HqTy8dDKl7SjE0J6RfNFvzfdvO9nKXmsOrzBKAZzcws=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=qUoiEuT5KXvtWCQ2XTdfcr25c/4kVJLIZ//HXs44cxUlRJV7G6HC/3XfL0TT0HWjh
         lfx814mn8DMknwRLUqgvhHe4WJK9d4Yr2+p+FpEGWDdxv9TZaOapTf5aaNKZenD37L
         aImORiXo9cbYmTVR5KGxIgl/zboTrfmlzhjUg8OhTC5xZeQIysfb+CUe3nFbVxiIFR
         uCczNIitL8aUMFeC6ohyHJg4zRXxiM/+VDko4E8S6gzQu8TMzWOC3QfqWZrG3Acop+
         qvBcxSfw5nLLcnnTLaVVj4ypvyaYr7+JektEJLID5m6HzxHAd6ccqLkQ0iQ6s/IAbA
         8TsW3Y6RW5Mfg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 30, 2020 at 04:52:56PM +0800, Yejune Deng wrote:
> atomic_inc_return() is a little neater
> 
> Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
> ---
>  drivers/infiniband/hw/i40iw/i40iw_cm.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied to for-next with the note from Shiraz

Thanks,
Jason
