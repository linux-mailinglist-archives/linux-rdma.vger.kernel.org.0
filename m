Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8039627092A
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Sep 2020 01:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgIRXaP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Sep 2020 19:30:15 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:15304 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgIRXaO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Sep 2020 19:30:14 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f6542ac0001>; Fri, 18 Sep 2020 16:28:44 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 18 Sep
 2020 23:30:14 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 18 Sep 2020 23:30:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QFMAqdam/8ftOHU2AW+sLhRUhJSYEz5D7cCS0CewQTp0SHq8tO6VtTRVjg0/it04KgRJC3uXkRe4JgtPOKfc4EYWEichfSGnZB4aHM0nsuTy4dEe6xo/mUkOLdPyuE7uJHI/a1YT0HVm0G45gDjqpedbxD3itRA8mCkrBOTnwBehLeBXrLV4yV0NMY5fBdP9FB+GRSKGOvL3ar1DE9EYX39z1BRwArucVhQILRzyMVpzG1hEpP1GMVgNUkTLOXaf9ioZTTqWNKMvjxtXHjptO0moEVcWX4OP4ar/ajdzu6ZnxaJIMho4LiCEdQGJhW3LK+AbYC8lxK5txLrCHLD86A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUFSc2PlB53N/dbAqnt5tS+dYOJsUJpCjJtuXr+ks4E=;
 b=jhGDIqTyo9TBRgX/nsmGumiwD8XM3WVcv/o+NIQgPDesIOUbE06kwflnM9U8pGMsaKQp/BcF8DNxTXiZ6iVj6RlXDbvKaUZ5mq4tcA1gc5PMYMviZSwOk8X6X1algJ/a8GJKxYJCMk9TFHMOOHZoRUAT8/iKZl78iRyokls7mFBkO3jqcBeyS7zmG1ho9NdKFobGiMSnJU8i+tb/6iqb4Smj8K7zPAkntMMV79zIrFW3QMs+a3dQCPzI+WHMKpaBvn+menpaaH8Th0ImF40mwQ9yCj/KjWZdA3IsLkH1XABxe2g6lyFBaXmsGLVTKcu9oNsdA/63VvT4EhuHAWnU0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0203.namprd12.prod.outlook.com (2603:10b6:4:56::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.15; Fri, 18 Sep
 2020 23:30:13 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3391.011; Fri, 18 Sep 2020
 23:30:13 +0000
Date:   Fri, 18 Sep 2020 20:30:11 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next v2 10/14] RDMA/restrack: Store all special QPs
 in restrack DB
Message-ID: <20200918233011.GE3699@nvidia.com>
References: <20200907122156.478360-1-leon@kernel.org>
 <20200907122156.478360-11-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200907122156.478360-11-leon@kernel.org>
X-ClientProxiedBy: MN2PR01CA0008.prod.exchangelabs.com (2603:10b6:208:10c::21)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR01CA0008.prod.exchangelabs.com (2603:10b6:208:10c::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend Transport; Fri, 18 Sep 2020 23:30:12 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kJPpT-001tSE-Ss; Fri, 18 Sep 2020 20:30:11 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: edcf6e92-e557-4240-df6e-08d85c2aca7b
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0203:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0203DB54F7FBC579BDD0071FC23F0@DM5PR1201MB0203.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dLx5gRs1jmUSozulnzOct6t8jhn5PIQ6WLEIRmXJQ72Ki+Wa/vhMPbj0qXexqZ9atZrjcLWwy4ioj31wsgDCShDMuZJOU6aGIBsfapLA1Gu6oP72n6km2hH1c54vfU4ua7dmdqMlTEPyrF+rh4jRSGpcI8Eq7tIct9F+RmLnL3eY15HmXc5Q+bMBMbhdlpZjjSsqu+0Z2gD3862o5UxzWfu40ND5//LGf9GNOmNxWuYVAIedbXNxpGFaDkNo7AdTJvKJeMa2+JMK1e7AFVOmiP/gjLuW43DN98pv7tX08rCmJMtWLU3APTaCiud8tqy7Pview9snJ6zWjPlUTeZLDxFbT31Y8S5KSK88k2KmOimfmdCv6u82aoVYMDFkffT/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(66556008)(36756003)(6916009)(86362001)(478600001)(316002)(9786002)(8936002)(9746002)(8676002)(2616005)(2906002)(4326008)(66476007)(66946007)(1076003)(83380400001)(33656002)(54906003)(5660300002)(426003)(26005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: dZ4ikL6fP+DyXwyD/DDiHAKJ86mN58Llnpqdul0QJnujrkGl5UP6hy9pFex7xzf4826UelCsuiuEu+0UTo67t9uJxk3Nu2LQiMWhgM1wG7mgapTcK7CzLaxOMV8bdQ04rzjOQPjA11q/lRMeNYx7aAp90Rp+KCJGLKNTMllxNtwcPwp9T8cawj9ObEaOq8EroA2ELD/u0bsT6qKZlvoT6tWmhGE3t0rHpu70AB2O3CsQJJobFkJKFFXHQSpCKxs66LjPozdZxFES4s9Ed1ZaISgCzPLIa/PIaLzcTS6BupsDfDuhPZiBIvMHTA3i5vJSiuPHPRiJDTQ4mozJfkBlxbQ0DqHXvvsp8rdu4y0eqXubaoM3eZlnxHqxyQLdIU35FDuyf0LG0T5l+nb78e7zIG/ON7pvAwUTOLeT1A4ZlXuGPaoEtwPT9jF81WwtIW0rSlBtOgpSbzV+CjT8bXIy37zuglfzpLAHMEzMXRY/K6YAnFJyVBnq3eXK/Bd8uJcAm4DA6cuDQjuRMyAKKmlasSIHABZ2H40mn7KlOth9Vo33XbydcAR6WBtVfmlrH+wlNVAJwDfnnbSZ+B054D1gyaXhHPR0d67SyTFz31LTWXOlC1v1ISVnYcwNhbOt8zckuYPyadYicIddCDbP8fCaBw==
X-MS-Exchange-CrossTenant-Network-Message-Id: edcf6e92-e557-4240-df6e-08d85c2aca7b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 23:30:13.0011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Czck4BA2hyd3fQem5SOYQwq0de5MmK5RGyh3fXqvhlm07KUwl3qcG29FB9gzEvtE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0203
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600471724; bh=hUFSc2PlB53N/dbAqnt5tS+dYOJsUJpCjJtuXr+ks4E=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:
         Authentication-Results:Date:From:To:CC:Subject:Message-ID:
         References:Content-Type:Content-Disposition:In-Reply-To:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Exchange-Transport-Forked:X-MS-Oob-TLC-OOBClassifiers:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=ilcsqDwFdcY8R7f0ha7NqgE09R4BSKznWNvquMh525X3dqk1KoPTo+/htmh1UjcVM
         7/4OjKwSF1SCQyVsSZwqkyJqsy9n5j3bC2/OTlbIbtYiqZ+QI2Wf5hI6HB2CifjJbe
         vy0X1f20VCZT+UF7WsjrhKUhnJd5pA509JFIO7qbGXX8bGzoXcZmkRtCwLwL4L6lmr
         Cs+0f/6xY1xryEk77t9nV5ZGbDP71g+6ffasXioub0W3A2s2pALtnVMli8aioJeLxS
         H4QNp+P0tGejK5+7WChzYDbmeHO4fOxdPtoAE+acARgZJhTAKtRQTmxvaJ4gvgeNiw
         t2y2I86m792jw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 07, 2020 at 03:21:52PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Special QPs (SMI and GSI) have different rules in regards of their QP
> numbers. While all other QP numbers are unique per-device, the QP0 and QP1
> are created per-port as requested by IBTA.
> 
> In multiple port devices, the number of SMI and GSI QPs with be equal
> to the number ports.
> 
> [leonro@vm ~]$ rdma dev
> 0: ibp0s9: node_type ca fw 4.4.9999 node_guid 5254:00c0:fe12:3455 sys_image_guid 5254:00c0:fe12:3455
> [leonro@vm ~]$ rdma link
> 0/1: ibp0s9/1: subnet_prefix fe80:0000:0000:0000 lid 13397 sm_lid 49151 lmc 0 state ACTIVE physical_state LINK_UP
> 0/2: ibp0s9/2: subnet_prefix fe80:0000:0000:0000 lid 13397 sm_lid 49151 lmc 0 state UNKNOWN physical_state UNKNOWN
> 
> Before:
> [leonro@mtl-leonro-l-vm ~]$ rdma res show qp type SMI,GSI
> link ibp0s9/1 lqpn 0 type SMI state RTS sq-psn 0 comm [ib_core]
> link ibp0s9/1 lqpn 1 type GSI state RTS sq-psn 0 comm [ib_core]
> 
> After:
> [leonro@vm ~]$ rdma res show qp type SMI,GSI
> link ibp0s9/1 lqpn 0 type SMI state RTS sq-psn 0 comm [ib_core]
> link ibp0s9/1 lqpn 1 type GSI state RTS sq-psn 0 comm [ib_core]
> link ibp0s9/2 lqpn 0 type SMI state RTS sq-psn 0 comm [ib_core]
> link ibp0s9/2 lqpn 1 type GSI state RTS sq-psn 0 comm [ib_core]
> 
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/core_priv.h |  2 ++
>  drivers/infiniband/core/restrack.c  | 11 +++++++++--
>  2 files changed, 11 insertions(+), 2 deletions(-)

Isn't this a pretty good stand alone bug fix? Add a fixes line?

Jason
