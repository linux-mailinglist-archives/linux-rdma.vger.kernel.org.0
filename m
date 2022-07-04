Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF405657A1
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Jul 2022 15:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233872AbiGDNpX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Jul 2022 09:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233559AbiGDNpW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Jul 2022 09:45:22 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151582711
        for <linux-rdma@vger.kernel.org>; Mon,  4 Jul 2022 06:45:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vg/I7z2eXQcapnINGj4BK4agrmtnu/FET0gX3xTLC7bQIRpEZCF6ZVbyrauGk3CbKITotedqf5tocLZQXVKVRq7fIYIRzsCkSodYZ1t0e2Zmh0RmEv0Bu9fmvB6iZhPcq9aUd9/oT4kgga8k3Rfet/pISgUuFrp4aT1qjoAlrCET7vQzDfrEPzllYrci8ndvo1idE6iytKh67BjTxla6/ymmOKuZp6TD1fTX2G7tAmvfMEytzNWvftQgz99Mc5v1u7uj1Cqk7BsMqWgdPcPOCOAyzUEcpsihyjGpxVhmoFqlLD7Qx5FD9Sxmu80Ag+IhVt8GZF1felNmkV4lNUnIDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4tGXdAJy043fg1k8E52oHSxYC+GUuJtIAHF0kBToaOE=;
 b=EXJNcNlfN8thsc749zYORXJOc74UG9guCBnbMDSHXBoMN2fIy+yVZKLaNPDyVvoWH42z28A9PUEyYzq/C36buN5+b/cmgxr8oDTH7kNkEgN4uIo5zRsP8paCFZiwuVjalIfj2ecgCSt59RuXx9ZHifbFItGcUCBd9jUwQN07uH1gyfGfctTS4zULcpLswEXeTMS+G+7XgpacnPsc6I+zXFgV+6v8QWDGUG/wgCudjRCzLkB8kBgUKI/UZMjlbKQIBv5/yxOu4WbsdcDs5OSfjyhiL99ivb+cz6uGapo0FJ7xRLW1jdD9+Z9xxTu35jGpzLW4HrtLs65xEo9mVyK2Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4tGXdAJy043fg1k8E52oHSxYC+GUuJtIAHF0kBToaOE=;
 b=KJfVuEVGqXkUyh5hfui3vhJqvCTBa9VEtzz8pRyfBicxDPj5bA6D9p6nFu6y5BxszL0CMvDPDpzv0/cLG+WNOQjRMO0/9l0oERgWEfVw+Tp/4NnO3kk9Dfs5VNk6ubDSymLV69YehJK5jn2/PWZiV7QwKlsewKfnWc56pzlrF9bZ+b2sd2kL4Kh49mZnS0RsP3vjsSPGYPEtrgquhY8J6Zwy0aoZ86j8PQNYDDGXroYs2DyAqmAu/atQ1hYzgrcW4Y1wn7Ghzog4Pxl34VRKogbSJXD1w2gPTIIItjxwtGCMrX34M9QNupLgzfEgnTB7g05C9wOmdlgvP1nCoKnroA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BY5PR12MB4919.namprd12.prod.outlook.com (2603:10b6:a03:1d6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Mon, 4 Jul
 2022 13:45:20 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb%3]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 13:45:20 +0000
Date:   Mon, 4 Jul 2022 10:45:19 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Xiao Yang <yangx.jy@fujitsu.com>
Cc:     linux-rdma@vger.kernel.org, yanjun.zhu@linux.dev,
        rpearsonhpe@gmail.com, y-goto@fujitsu.com, lizhijian@fujitsu.com,
        tomasz.gromadzki@intel.com, ira.weiny@intel.com
Subject: Re: [PATCH v4 0/3] RDMA/rxe: Add RDMA Atomic Write operation
Message-ID: <20220704134519.GA1422582@nvidia.com>
References: <20220418061244.89025-1-yangx.jy@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418061244.89025-1-yangx.jy@fujitsu.com>
X-ClientProxiedBy: MN2PR02CA0023.namprd02.prod.outlook.com
 (2603:10b6:208:fc::36) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc3da6a0-d460-4367-4180-08da5dc37011
X-MS-TrafficTypeDiagnostic: BY5PR12MB4919:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O3DaYa4/UsG9g2PlT0YRlsCdd/uyro/ru6wWQPSs+yVtsfT+7kHygr8jzlqoEr+Pka+Eo5aS+izcxd0XS0mMpg3OOlGN0GJQ71fvebgTMJN64iAwXCaikz0wl/H5IE6fU2+e6eXC9saGLUjRbj6GFmOog7MUM5RR2/Jn4aRwfiuS82Qkb73yKgyBxcDptaJzYtvY7QlZbzqOaZoL30QjMDoVLHJzZI1P+pFZA7zdM1K7eODMwYjdIpxGEDgq2MMDXeXHUOgy+aAa7sVMamm+pRryk6Q2x8/3prlrACzizuRVOs+a8k9wJj4/VhPKTZtyhipX5Cd+QmYQt6g11jzNUWAENpHfgxim3DoXMeUsBCRMt/iizR1f0dlW36iJpBNDrt8TYYlssfca6fm5ye3REA9XoiTbkZfeE9wYChTOqrpNzyj3zalHKrXg343UHSpPuq0c0KiBpHKTjp2Toit1o0VvVE14MXWvIuTV3L1EqKqu2rKNFSY/fYT8y3ntL/zja4ZdfXM31HYuEGHD7vrCpJaDNAjzXTPBtlHyIfdfUNBPxLyfS0NZHlrpL1M1C+k4RJEBjmXPwe+LbxPrYRfOr+0893rzON0Z4nc00sp3x42TkqQmph8UvaOLXBAMK7cRf9QxYEGFrcG/ON7QsocrSqk48ZbmyrG3l1FtkEThy5/r9fIkfoHNVVAKBr29cPHWyK0tH3H+PnmKpTGJJ+gAupoD6RJicvhl/qFefBwydnXFcOWDeP4mx33Rsa1E1Irz9FStrWlQZeyiUTXcXpE7sg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(66476007)(186003)(4326008)(66946007)(316002)(6486002)(8676002)(6916009)(66556008)(36756003)(26005)(38100700002)(6512007)(2616005)(5660300002)(8936002)(86362001)(1076003)(33656002)(478600001)(41300700001)(2906002)(4744005)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BU/0diCdDzSFvTuiH0iViOc14A4+IOXrHXcbqU730g+Hm7GmyLOqIEhI9LdX?=
 =?us-ascii?Q?X4Xzjd7Cj8SJ1WwvooBHFAinvqgGBwImRkeErEIlV9GvfH5XBVJWyWHkZbl3?=
 =?us-ascii?Q?QDvqzsDr/bhaw5qyvc+LHZ5eAnvzcWltqOY8dIFM3H4ws3TqI1Vz69RKYq9g?=
 =?us-ascii?Q?L1Nfaa8h3aGiGlVccIa8/i526pRwxKUvqAZfYZLHd6hx8bNLL1HiMgmVUg7s?=
 =?us-ascii?Q?FOAMABOVSL3/NWCTk8QPZj7JB78d2Dkgc6uKZNLrJWd/sb9V1+MzKfhLajSl?=
 =?us-ascii?Q?X8IRSbEhbVfQ7K9FEMSt65DgRtpsFIsaRV3QcSUbnWEGECO5ICt9Yuua7u60?=
 =?us-ascii?Q?0UvCSlxBlD2+0nme9pKk1QNPxoVMGHtJkBbP/E0Xqj3OisL5umJI2zXheqDX?=
 =?us-ascii?Q?krJrQBXCRBz8PHHm1j9O9iCC1Z1SRV3QT8P/owUXcBXPICxVJ7yo2OLpnGwM?=
 =?us-ascii?Q?n+Lms1qqJBwxI2zi+m9O63qasiu7d9xSy/VweQ15HQNREheH2p9604G25GwK?=
 =?us-ascii?Q?nnRchrrQoHMXxEeSwVBeobWuuIuxMf09JiUnBe0vrahHn2EVzYHUQ83BoMxI?=
 =?us-ascii?Q?GKsV4p6Fa3rkZtrmHi15dcYX8dYMAKunrfD+18WaEYEmgRIYp+WSFTsS6ePN?=
 =?us-ascii?Q?98J7Cmj9tLWEkWFQ7uGbw2b47Z/Ex70LEisaEoh1UuyU36ZEE7Kr76GXh8y6?=
 =?us-ascii?Q?eqHYccDJ/Sk+fWLgxUQ9zlpSQjnZUjtpidcdJ64qVl70DQLAh89RYQReRCu6?=
 =?us-ascii?Q?HV0eBbb+edfieRFwOHstTzBh5FOtSbwDABauwqj+BUVS39SXL6wQT9BLa+Uj?=
 =?us-ascii?Q?Bhwpd8DXcNRn1umnWXxfi+02P3SMOSH+di/vttVsN7ROsxQMbeYIkSnuMp0B?=
 =?us-ascii?Q?GorhTDD1nIecw8yvuCeR1fo4AlQ0GEJkm2XUa3s10zixJHV0bdMgRP2s//Br?=
 =?us-ascii?Q?EdkGTEUnjQeIPa4IxSX0JXqAEwQ68tJRQEUB9AkkinjxOt5lnmrRLjFhJ3T+?=
 =?us-ascii?Q?5qLfgO8es7JRSxazpCIFlZv8bCgBh2njnvYE/MDXVnKdi2mFV6VXFFASiimM?=
 =?us-ascii?Q?Yg/oe9AYU/Y99Zo+RrymNDiDOOEp7FQovvaoBFSJ/lhXv98KochJIJ5+cLu5?=
 =?us-ascii?Q?c7wvRJRND+zXNQsEJUj5z92d/Z7qFqDKNUrOKWAi571jGXIW9CJ4FXRky4qW?=
 =?us-ascii?Q?XEEKetyX5NwmXkMGHL4L4ydYs0I5aQZMB7sfncDnmHA5FmTzUI1i8wFA7E0h?=
 =?us-ascii?Q?aZ6x6yNtKNF0A9U6jCMt4Nb+Z/5QPHunh0hQthbLcJUsn9hlHah4kIhukCgv?=
 =?us-ascii?Q?+djbGswMW4f5TWI5c6zzsbbVSHtbeHJKYLIMnoggyhhyU7lO5ZbCYX3WXg/G?=
 =?us-ascii?Q?odMPCTCBnpbnacppZHmlEB/UfSAcdKyDUGG9LZJgOpjsFAgMD8KiyWJ5vEsO?=
 =?us-ascii?Q?Y10mYfLmc/gdTvNtPfExYe7r/pZhYB7CW/qiJ71whvmVTm4cl6/G1fKqzJgD?=
 =?us-ascii?Q?ya7BusNCze5ULJ1TqqgYtxDYG5wR7KxYhPyjA9mlTrKNG4scTHk52ywwQD/6?=
 =?us-ascii?Q?3n5sIexmoVMt/wR5OqHXvsvS7/cJ3lx56Q6hHu68?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc3da6a0-d460-4367-4180-08da5dc37011
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 13:45:20.7625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Sn+mWl7/NeP0yz3qtUcww8ORfKblFBlCS1J7uPRnkhJrn7cmX/KmQlMX6a6rDdi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4919
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 18, 2022 at 02:12:41PM +0800, Xiao Yang wrote:
> The IB SPEC v1.5[1] defined new RDMA Atomic Write operation. This
> patchset makes SoftRoCE support new RDMA Atomic Write on RC service.

This series doesn't apply cleanly, please rebase it and re-tet it.

Did you make pyverbs coverage for this?

Jason
