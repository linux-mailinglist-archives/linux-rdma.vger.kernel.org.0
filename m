Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85CF7474ED6
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Dec 2021 01:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234583AbhLOAD3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Dec 2021 19:03:29 -0500
Received: from mail-sn1anam02on2064.outbound.protection.outlook.com ([40.107.96.64]:56323
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234512AbhLOAD2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 Dec 2021 19:03:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMltZ2rQNrkanIlK0PMhCb+a5Ucsu5MU+AzfMkceRMRUE2/frK2QCoJM8SzNrubb9QvYmdesVFfAQwSTI9OgvfqAjWnQZmj1q9kn2OdhFypNRJ9WST7gemm8bHlWl8LobMSNJrfrNB0jWN9c9nwJxYXlOALsKX5YnGDXgFUhwryp0LHkbqjn+syL6YhdH5dW5yNC99DH57iyi8iUGgF6MC2zgqHEJhLh7JwTYo5YuJIBV2oy+iwIiG3eq4nj92DF1jSmd1LZ+WuiNGkhuLZzYPgAqX3DqMEL+IYyKgV0+y9SusFATVTwXG1okCHUAxdRNrBrC9my3A4cX+ShPUy//w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pbp3zaKjILU9SkD7MaRNMeuflMiyxtj7kxAjuOTA/gQ=;
 b=l01ZTKI/H11kDd63T/XzNnSp0MSEcLAx6SnUymZoLNOr0buU2jZYkPPOnav9+/3LhNE6dthjw5dE4v+2TcFIAh5UKopeXn9m4fWFZ7CHkvMFv5h2euUQ0m2yMADiHn8/KsqOpI8pTEtjINNWkrgXRjyahsyyxuqV0P1yyByNXPXhHTD9ACNgivz6vq/ZBAfY0WfTWAdtUsd+kBJ2Q27NN9i0iHE0qIceWtmB0/42g9AUVu93OY+Au4a8TaMFD0A2dvqX2uLLL+XkhQmQhziOUM6IAfdcKjFIw+aVgHQRHY0A+m6oFdUMDdOMjQSbWZpUS8wDSAcx5BfgWmpWKuSyAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pbp3zaKjILU9SkD7MaRNMeuflMiyxtj7kxAjuOTA/gQ=;
 b=J34alyLcfCnOgyHjbgi3MwXEdiHx1BOeCsWyyyB23fIjHbCaECRt1Up3FlRmAWSpx2gZYVWKVu52ci7AJ7Ue4xV27exWGbN2eT7M4vRAILynl1NqXXNFwK+zDPX3TKalL4xGs5FIDQgeJ3qpAxEcxO7bRCsXbm6KfwyIQuf8hnzsnTCo/dSNVA57RE7i4DBkYclZ08RJrk8hwKmPXhhUts0Oubxe0W+NGCtdw5EmXA2HdYi7C1u+QTmDJAosljAJ2WLlu8QhHe/dYi6qkfgqvl6zEGAjAXtyKDQ9EpZd3nO+g6ADD6dZYjmmM1BtWOkulDI1bSxEfzM3ut/o8aCMHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5520.namprd12.prod.outlook.com (2603:10b6:5:208::9) by
 DM6PR12MB5565.namprd12.prod.outlook.com (2603:10b6:5:1b6::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.16; Wed, 15 Dec 2021 00:03:27 +0000
Received: from DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::218e:ede8:15a4:f00d]) by DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::218e:ede8:15a4:f00d%4]) with mapi id 15.20.4801.014; Wed, 15 Dec 2021
 00:03:27 +0000
Date:   Tue, 14 Dec 2021 20:03:25 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH v6 for-next 0/1] RDMA/hns: Support direct WQE of userspace
Message-ID: <20211215000325.GA975121@nvidia.com>
References: <20211207124901.42123-1-liangwenpeng@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207124901.42123-1-liangwenpeng@huawei.com>
X-ClientProxiedBy: SJ0PR03CA0350.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::25) To DM6PR12MB5520.namprd12.prod.outlook.com
 (2603:10b6:5:208::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dfc98d8b-4ce6-48d2-ff81-08d9bf5e5232
X-MS-TrafficTypeDiagnostic: DM6PR12MB5565:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB5565833956D2F5733F09617AC2769@DM6PR12MB5565.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vp/6oWqM7DKK3KwiMGWL8UIA/bNGwMMolwGum0IoGr8pPjvRcrQJvFGe2uG9JMczZfVTf8Ip+Ona4PGxGzmZ+bNXXOnQSDqt4g/s9f9gfJ8fkT9gvP0zrUjiRh9aauwlfStvbxXvwWbixpiONR2UzwOdQjIykFJlhtmOQWqZmZ1Yjipp1LSOLHyGMbPtUNBWiBiIxxfiGf3MTPvFjRgLJBxXnJmvTNut8BDKJbYbmFw38nOlyqNjnJ0Aq5aOzgX2yaDDUAoW6VAhNr4xrEAw06ITQqRgSqQOwjXKINbaI5TVpnZyh+/rJlrfyWRW6JC5r7k9gHJf1c+IFREan4IKoouPqP4JIg0bS8AAkZBeXS50alX0tuMwJ2s9TVJcAkk/S+lYVCulhETGDOA39LICUai1UGXpRN54JIE87gJJZuLA6IuOV7V/y9KpjdReSaC8igHVqyCXdKPFFFBTFQ6dH5NIOEGtxQEoj+fF9kVLTw5rMXtqZRquE6PMWWwkDODZY6RkN9THFjXGWHWDNkf1Xn+yAJ0meIRl/pTxVlHHY4/4GRvkBavvnW4IMRctP+lpt2bnTQUIEYZ8Q3fX3/xMRlLcNeCDKr6G4Wcq3CXRSLChcsLYuNUUvhpWJT2ITCCYeFtdrgIiB7WoZ9xKyjBTvjpVbVGrKAxSFD9Q3/umpXLi3MspleuLJ/BHMhuaK7/o6n/yAIWxf7+96C27YVqzig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5520.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(36756003)(38100700002)(33656002)(4326008)(6512007)(8676002)(2616005)(66946007)(4744005)(6916009)(86362001)(8936002)(66476007)(5660300002)(83380400001)(66556008)(6486002)(2906002)(6506007)(186003)(26005)(316002)(1076003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mOIxGniaI502oO4WSRENLve1ADQYIXttuFjpITo7YC7VLvGjGw7cbV01zNwJ?=
 =?us-ascii?Q?hKOjgyki18p2EWmb0zVJg99lU5GZlRevN2oP4GD5W6cS8TqaZfUJymumeaCh?=
 =?us-ascii?Q?ys1y7eG5k5JnO9OwfvFf/pkD3qC8GynEVplJmMh80S+jkmQNSR78u2T+2Oze?=
 =?us-ascii?Q?XwaxXuAHkfpSHL6oyvjU7zPZS6xqeDHAO97qaqagKol2f5Vd+gH0L3lU6NS/?=
 =?us-ascii?Q?i1d8z153HubSblkasM4c3y6ffOuyqalNbnXsjEYuY0E9QxDX+xLAP3DeON7H?=
 =?us-ascii?Q?3jwRM+uf7o22bpLpbVGYGRDw4k2Ryl4vwBEqT23pShg+Hd7wSJN9xf++oksZ?=
 =?us-ascii?Q?phLSzqOcV0EupZ1K++KzOwJfrS2eDOq7JxwGjq//XBcsPS2DR/FANhUasXVt?=
 =?us-ascii?Q?QGVpMgL2BZTawCDHBQk7yxRFW49fw7MSea2u1hsL4DkYporzaGtdwF3OAafm?=
 =?us-ascii?Q?y/3M3kU286e4xf7rd6ZLtkdQjyN3ierg72jdm+WhLGyk/Nn9CswlYjNS/sCw?=
 =?us-ascii?Q?9sK4Isa221QRFd95aeBHwOLin2PB+NGkfEi900rVFzXSG7egyLOtMpNXCTxw?=
 =?us-ascii?Q?l/dz1qUISuJ0gpa0Auq7SZEjU0ZWSyZYUiLb/QGddfJlYMIRyOpxXR+1CpPd?=
 =?us-ascii?Q?57PS+KM7FpSEY4TIwXPbQr3RdaTS/pJjsZYl3EDyCxwSqCXISyzBy15YIrM1?=
 =?us-ascii?Q?+A6wDxGqiWrsC22/zyLXmqXWZLF0aS0Doi3rb2L0ZKzO/uEdZ3YBGYoLIZF1?=
 =?us-ascii?Q?NIMsVgcgA5pvWn4vqdqUVoWE9Y7A43zYG0cslXnf7qrweGPHRmHhXmcI5Nv7?=
 =?us-ascii?Q?G/3QcZBm2S+z/j8kAmoJllmF9MQSvDKzhfh8WLSY8QmUIk0iF2LSNS/C3Rf4?=
 =?us-ascii?Q?BOf1wDdcoRW9wlDEtLKmfe5TE6bLZXD+9RtssSR6SKlGp0+ghmYPB5oSN8Z8?=
 =?us-ascii?Q?VIOXL8uNVoiFCn/k7fv/iPj1DnPI4F2iouPBQfVerDlgUBg9jrHytNSG87KJ?=
 =?us-ascii?Q?45ib9o5coOvEpUFGJF6X3V4fKaAHpphiRtFGgTBDs+RZl+j/d0rj1Y9ldZjW?=
 =?us-ascii?Q?lTitJ9KsenXW0KxeuucRsuM1C4mHg2hc1/goxDyFeQg6h1YIPJVmnlh1QSuO?=
 =?us-ascii?Q?yAIireksRBl6VJTqszCilWi4fR++YXvFawNw5ALi8JLNoO+qANEhLtbdYQQh?=
 =?us-ascii?Q?wSAZYV6Wt8zZoM+9hRKKcSQEGmNaiZn3nNH/g6zFUAWTkWlU6YAqzc2dYxVQ?=
 =?us-ascii?Q?mG90syne09omJ3OWLxfz4D8dL3bHw7cbAGABUHf9HumOikzKLlE9gz5oJ6hh?=
 =?us-ascii?Q?yELGsGKrm5XXod0SwvU+naGYjZg5VknwwXTapwJpzfk9XAqoTkDplWxK95Gz?=
 =?us-ascii?Q?Vv7wMhp5TWBTM9QB8oa+Hnu7gBscmNs0MnWNAhxEVd4wv985fZcrXOPt9nWj?=
 =?us-ascii?Q?IRAEERlpwAYhvY+0jnCU19xkrLiiM6RRYyMJ2WbcfVl26K+WHrPrgmgUgmMM?=
 =?us-ascii?Q?L8dTWeLWNZWQN5nj0/Y/nmfhN3CXm7h1y5uqTAf+Z8hWyqM8qpgxO1Hi9YA4?=
 =?us-ascii?Q?lpZUCfXJKXbjY1SaU6c=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfc98d8b-4ce6-48d2-ff81-08d9bf5e5232
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5520.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 00:03:27.8259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uyUWXFXbXqetZNMMzxj61n/zg/eKS+vROxz8hGk/NH7RlX0GqvsRz3/9V6/M+D6L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5565
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 07, 2021 at 08:49:00PM +0800, Wenpeng Liang wrote:
> Direct wqe is a mechanism to fill wqe directly into the hardware. In the
> case of light load, the wqe will be filled into pcie bar space of the
> hardware, this will reduce one memory access operation and therefore reduce
> the latency.
> 
> The user space parts is named "libhns: Add support for direct wqe".

Applied to for-next, thanks

Please update the PR on the github

Jason
