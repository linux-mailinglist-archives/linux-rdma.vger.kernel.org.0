Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B16B226228
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Jul 2020 16:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgGTObO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Jul 2020 10:31:14 -0400
Received: from mail-db8eur05on2064.outbound.protection.outlook.com ([40.107.20.64]:63744
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725815AbgGTObN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 Jul 2020 10:31:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=evRcjtgrGKRRx3qG8OmL+qC9R2uA+t8KDsz8ja+SiXM0Xby801QThOxFcDz3WA1/n86iFdakrLrL2WQ8c21tNOZnay4q8gGl1yeSm1IXlpsuLN1c9Qn6J7uTUxYXyPR7UdfsIDEOdUlPJjkQ8cmNiq++KdsL34KUuvg8gZTXSIdhz0B/mB97rzwLL2ToLRPCLt3UT7vk7lI9zFW7H2WUN/O/ZIwpqSrKuCHz2xTZ2dOlAVAw4NBjmsKwwdEwH1DbjN8ujz0XzAH62jEb5062noUErceM3EgB42deRbRAYAR3sIBQVafETfqRa/J73Bs2RioS5NAVnlKr5WycKZRVXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIkX4lJQGsV0qm9q5tmC59LhDCGFlRXPetNdzofCzFc=;
 b=QB5+h0GK99a6x8/w9P25tdJvHuyRRvES4YBzDAf4mfysk3Ekd1ndRmWh0crQWcApR37ZlSeKIhOw/1mgpZLTn9gZxOc7DoIdItN9F5bTmBPun78BaQTvRGoDTC1kKOtaXVEh8UMzOhbyRq1ebVqxO0CKhYB/CSH9tRvB4txGDcB46XyZkqil3spmTomBTwyHcbJrgm32ln0dGbEbvaDMJtGljG1xuRLhMIbDtt8B/5ly2OFwL2jtPQmgl6z+Qz6F69+J+o3g8C77ASRyFITnHJmNXbmcXsna0ilk+ySotVS83OYyAtY0JDbFw6nGKL+b4TYTCyDG0IYdr9ZkoosceQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIkX4lJQGsV0qm9q5tmC59LhDCGFlRXPetNdzofCzFc=;
 b=g/N5olPCmZFeY2y1mSZGPx19weIT/lWKqssC1+NIO/rTwJbNtK+OjdEG5JnnpQmXa9FNTjp7KTV51BZg1sYOWeI5Ej8+wA5rE3zzC5px1XWsOxY+51mpCwQG0/mSmRgjj0GEpZ1MxyTbZV1P4vZc1RNDIZiZaO12kvx5Pg9dW/c=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=mellanox.com;
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR05MB6141.eurprd05.prod.outlook.com (2603:10a6:803:e1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Mon, 20 Jul
 2020 14:31:10 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::252e:52c7:170b:35d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::252e:52c7:170b:35d%5]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 14:31:10 +0000
Date:   Mon, 20 Jul 2020 11:31:05 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Add missing srcu_read_lock in ODP
 implicit flow
Message-ID: <20200720143105.GM2021248@mellanox.com>
References: <20200719065747.131157-1-leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200719065747.131157-1-leon@kernel.org>
X-ClientProxiedBy: BL0PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:208:91::25) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR05CA0015.namprd05.prod.outlook.com (2603:10b6:208:91::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.17 via Frontend Transport; Mon, 20 Jul 2020 14:31:09 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@mellanox.com>)      id 1jxWor-00Cb2T-Vs; Mon, 20 Jul 2020 11:31:05 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d0786224-f3fd-4f4e-ebbf-08d82cb98bda
X-MS-TrafficTypeDiagnostic: VI1PR05MB6141:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR05MB6141141232F5626230B6BEAACF7B0@VI1PR05MB6141.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QrAXow3aKrgkJWcwddf2xQyeOgwAvbumEOvlsRANBLQdxlgGZAoESkxbkVUhD8qNLaqunDO0cQjX4kHQWr4Y23dw9PG/pKKQZhiePwFuL9yNMhr4QhXjqS9mbn7om+ZXBInTw79crKLJ2Fd4rdnIfrTwZVzAZqZUhyOups/uToDFQtL2kEq6lmje51anWOd+dgsNwFigNTRYU17Tey/OxI9WPsWJ+A6qyTifFa9XeRST4W9Shel9+MF5fjpag5dVDwsPYj9As448GIrWvMGMQyejNhOBg8CgtNYq6CTD8faayQHwp7xpcRjliTP3l2xc8Eso9setmz+QPakIVlJguA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(26005)(478600001)(2906002)(36756003)(8936002)(6916009)(66946007)(5660300002)(66556008)(66476007)(86362001)(9786002)(426003)(186003)(83380400001)(316002)(1076003)(2616005)(4744005)(8676002)(4326008)(33656002)(54906003)(9746002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: YSwGESc1JJfmvb2onj4NBalX18PhrB+lU2jbL3iySKbqnFU4RoKu67/pepTr7YoLLs+G/ddmuZkieMNKtbBGSN/HFY/r9FTSJQeEG45BilcZHBv9xyb7iVd9U2cPQX1gx+EZr4Lsm7j+Q4QB6xRcKT3s1cHMhd5w6X2n2pnTuTbWE86Jb6MbaAiLtuZIrIuet4APn3cjeyoRiCoHPdAF/oj2GtXd254afkwwVAmHNdcJVMm6y/Lx+UkYeneczIEJZgCLX7VS21n/oZgf6Y1YXG4KJZwUIZ6/Lj/vhhGzcMhnYQjSKuBEKwb5ewaQShEKY3F9EYurdmSw+l3VB1xofQtYar2qSVjOU7SWU6o8+JKCh+3hksJpFlZ+i2OizyYUR3byBO0XvfGM1YNEE9S4rZNZYeXoKFaoFN4UIeZ3z7v4gwkHYc2tjuwazGLmJeSZOMRNveP78jaEANNj9fb3xQ3eQ9wnA96NPMGSFgWjgro=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0786224-f3fd-4f4e-ebbf-08d82cb98bda
X-MS-Exchange-CrossTenant-AuthSource: VI1PR05MB4141.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 14:31:10.1726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jP6xAEzVgZMPL7lSqmYUAEAmS11wS2jCwWJkSGRcuqLy4PRG+kRd51xdb2zCLrZyZAhw0CGFooJGLHspZjBxCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6141
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jul 19, 2020 at 09:57:47AM +0300, Leon Romanovsky wrote:
> From: Maor Gottlieb <maorg@mellanox.com>
> 
> According to the locking scheme, mlx5_ib_update_xlt should be called
> with srcu_read_lock().
> This fixes the below LOCKDEP trace.
> 
> [  861.917222] WARNING: CPU: 1 PID: 1130 at
> drivers/infiniband/hw/mlx5/odp.c:132 mlx5_odp_populate_xlt+0x175/0x180
> [mlx5_ib]

Why do I keep getting patches with oops reports word wrapped??

Do not wrap oops.

Do not include timestamp in oops.

Trim useless informatin

