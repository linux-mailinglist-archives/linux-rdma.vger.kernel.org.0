Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4048A2A04A8
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Oct 2020 12:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgJ3Lrk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Oct 2020 07:47:40 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:14591 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbgJ3Lrj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 30 Oct 2020 07:47:39 -0400
Received: from HKMAIL101.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9bfd590000>; Fri, 30 Oct 2020 19:47:37 +0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 30 Oct
 2020 11:47:37 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 30 Oct 2020 11:47:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FnVxFIvVt1t0HAvUYFEmudhNT7Gq9ns6mGkNPo10bgacdNEeTsApsmQNdeenCEe3Ip+yOKVM37UnGeKUHhJ8gI9mNuIEe7Q/C/cTRXUKtxReaAFqt3vvsvlSbtUcg1PiaBa4p1bBcJi4l+Yk60EV0LkA1813Yw08oRYnROKLxNX8S5vw6Onu6PV68MEfK1+09PZ+oN2nA9Xsbb6qiBOVHiXfOxZfSwUTe/H037AaSNnaXmlaJbkyLDog+85/OlI9ZUoFA0BH/IE/udRCZSlUe1D0sTB7iwKF2a/rWY63ZQn4HcGpRIabR46NUrBbTPUUO9a5WQdlXwmqEpmNfoG/HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yEj98RiKUedCvIJLRq5PRwXY4N+xgposVn0nq8rSQRE=;
 b=SPQ7FRUt7o2U6fE1g16MSKQa63ZJuhR72G4BccC03ZM39z1EmCr6inIMQGGXxF7YRXT/4mI4Q+ezE8EbF7bVdIA7uJw2PI3Lc7tpnZKhqVP1BUWdaa42pt1K/W7UW0S5BU38mITvO858mNloqzh9OvpuxjJETNubWh4Ikpbens/NnXZxNQkNqKfgObJUJBtahxwORLlRLWQdMVSxaERNPoadjhEtMgcYeIZ4ERMmJNroudGs6v9zV1Z6yLdLS4y+REwfBgwuGlvSF5bi+35JF0gJOxFIFSlAN4mFPbsupLMyjY+l2r4QzgfVrQ6Ftqi8SR7NAxFZWVlydMFQhiI5hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4780.namprd12.prod.outlook.com (2603:10b6:5:168::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19; Fri, 30 Oct
 2020 11:47:34 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.027; Fri, 30 Oct 2020
 11:47:34 +0000
Date:   Fri, 30 Oct 2020 08:47:32 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: another change breaks rxe
Message-ID: <20201030114732.GC2620339@nvidia.com>
References: <32fa9c9f-5816-7474-b821-ccccd4cb5af0@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <32fa9c9f-5816-7474-b821-ccccd4cb5af0@gmail.com>
X-ClientProxiedBy: MN2PR10CA0013.namprd10.prod.outlook.com
 (2603:10b6:208:120::26) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR10CA0013.namprd10.prod.outlook.com (2603:10b6:208:120::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Fri, 30 Oct 2020 11:47:33 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kYSsW-00CwHt-OG; Fri, 30 Oct 2020 08:47:32 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604058457; bh=yEj98RiKUedCvIJLRq5PRwXY4N+xgposVn0nq8rSQRE=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=gaHMJz3fodpzMlqvVq4QdOvcJHrPa7FbsfYg8ooQmY+/6sxsjFDKTnvfhB2i/xjS3
         knYvNko2TJeNdJBasy9ATYZZUcw892j4PlDcMl/VdJfovA9C9a7pJKglBF3TrbgeCe
         pmp2YM+ekOwVxywXNjXlJFDfrqalOjZhoYrKjPPPI73ov9CDNFiq0noM3+4ow2qgev
         rmqNIsIKKT4E0szqes2XWhA7Olz3c8WGRR0xfUQlZhK7j62FjFkSb44SCQkWXIK1yY
         Xdege3NNwWJJIMApOJZ/CRryZRxbsxq5qKkkWVnLU+3UoBVXSjN3wRCyrJt+w9E74A
         cGzlblMldwWug==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 30, 2020 at 12:41:12AM -0500, Bob Pearson wrote:

> breaks rxe because it does use IB_USER_VERBS_CMD_POST_SEND. rxe
> posts wqes to a work queue in shared memory and then calls
> ibv_post_send with zero wqes as a doorbell to the kernel which uses
> this as a hint to go read the shared memory.

Gah, siw and rxe are open coding this stuff (wrongly!) in rdma-core

This would be a lot better to use an eventfd

Jason
