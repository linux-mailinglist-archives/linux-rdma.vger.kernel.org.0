Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB724B2E2F
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Feb 2022 21:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344057AbiBKUE6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Feb 2022 15:04:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349567AbiBKUE5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Feb 2022 15:04:57 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD140CE9
        for <linux-rdma@vger.kernel.org>; Fri, 11 Feb 2022 12:04:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCPoeS+BpudJzeQq19B5OgsyzvclOY8vJI0FD1xaQ2KDHk+gIDy8eYT1Ph5vf0a9DJVlSBj1fDPhQhsbxT9om0nst3mQN4cE7FmPVQYAOb8a7QEpmC4mR7O0cvqB9T4BfA5Z7/KVs1NMQzheYuM0mMUUQYxAf8EhgdUsQNAcV0VBevxCCzpQNCjTQ2s50iXXL74Os33b7cNH0+zQ+ih83fOQNCSq1FpRBYOTTadML+vJZit/ncCYiyILMAAupWQ5PrPPDBnAZ5H0B5mCSUjI0aC3mVmMqTdWTU3O0db1WGOe2dJOx+KCB3+QHBUbign7I5xqyfI8BokeGwpTKQj2Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fAWpddiRBINNC7IdlNl/EEEhcl3Xk2gYwMkkjS/8hr4=;
 b=DxWT0Q8e76UDOd7OaM5A/aun8rhXHXGb8NUn+PJl3Xm5Knsp4dHbtZm8iy2zuYezXkNLV80Mx3bSJFLitt4G15sgrCaWHRnCrNGHYKY1eefT4D3dqOxmfZ8IzZMpLl9q090BpYzXl4sMHc3cYWgFge4J81is1o685ok51Kvm3afNPSNdsDune97d8v5gOjYopLJynFQacjxGu4Z2O47O8E4VnxfqUmafs00G8Qyjvhx11KSUaLJ1iCh1XfYjz53COjSrWM+2ckaO1hgebHqbdWOcMvxz9Kjj9sOSTJKCWh7/UTuEHnhJlKX/E7VP23hI5zEIzMbX0+HCel0Wwh5odg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAWpddiRBINNC7IdlNl/EEEhcl3Xk2gYwMkkjS/8hr4=;
 b=lYliJWt5Xq+wdDyQ2LbrhkOpguxjIAw3v/R2sm5ew9CDpb24ZDO0FaiX534+xLKzbpW6dG9pWCbBjpjJ4xZq8APvFjWEABVsmSB4y8EeliAlx1hReywn/wM7absqS/vajQPEUwYGnMEmA4BDCCajkTCumC6kTob5qDDV1yxeKBUHvaiZ7uW9AuRm5G0jPmpx4JSWa0QnWYasL+c0zHY4l4+rksJq/kdQLsZ+UtKwv7d96ydM6DuDyGjrFGZobC8bN8xoPRL1xK6XuSnFFTEXj7HGc3EcdQ9PiHuvIfzoUw6e1lEsenzw/R7Pp0OY6632duDpKw8N4j3MFGADn8T7VQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN6PR12MB1426.namprd12.prod.outlook.com (2603:10b6:404:22::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Fri, 11 Feb
 2022 20:04:53 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4975.011; Fri, 11 Feb 2022
 20:04:53 +0000
Date:   Fri, 11 Feb 2022 16:04:51 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v11 00/11] Move two object pools to rxe_mcast.c
Message-ID: <20220211200451.GA669613@nvidia.com>
References: <20220208211644.123457-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208211644.123457-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: MN2PR07CA0005.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::15) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57887f1e-fab1-4ccb-ab13-08d9ed99c471
X-MS-TrafficTypeDiagnostic: BN6PR12MB1426:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB142662B38950C395E0C44E3CC2309@BN6PR12MB1426.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F+1R3XrwHdpGdMACkAde8h7hU1FMtvu+E8dNDyc2a1mkma+yoFlwspWz2ShL66L1MaA5vsVZQXRW/MJukSvp2FR0cYWfg4bB3YJjP1Stj+ksTT5oPQmY7ftogj2uDCLx/j0rgGJR2HPjtJwZl0pijhTBykidpSzzfHVqrirwCc7qZeV89Ew5wiDHX9Cdb/14Mql2HJYw52ojgQDyEH5tq3rQMBeJXsNGFQLYkSN5cPGyBO9aO1NFM+E1SJ6LTenyz4FbJmtyMoXfZhLErbEiJ0C3M63d0a3bTFi33cpuDFSYpoDwfrzkRQkdiqKTc/YzC8/zczLFFxDefxt1cqkRsuPX13Kn9p+yw5r5nWBTnaA9toi+2DdyuV/sMgm6nT8VqD94B6uJFiRw9j+yQuDyqxCtQRekTuFEgQ3/QPY1BOP/k0kWChaqGruf4119YpQOSRX9O0yX9zhNHUopd7BcrWWD9/UmHAvOlvmpnoTj4ncHZ865oKaeZCE3iZ0IQeaLpVDgOih8OxDTEza523/iN8SgmLonGZVGOe0cHwqYwX9fu6OIiH6sHyXnH/v7B6/QhQddRaNFMGPZsXtig6KpZNvT8uL0hQmoIZHoLJAbnyhQFUtucbgnrtf66WcALnw+sBnd8SFxpafKQwxtPlAXCQRS39DXxT1ZXymhTNP4jq0+IAY+sxIMY2mVuqXVuiAi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(83380400001)(36756003)(26005)(6512007)(186003)(1076003)(2616005)(508600001)(4744005)(66556008)(316002)(33656002)(2906002)(8676002)(86362001)(66476007)(5660300002)(66946007)(6486002)(6916009)(8936002)(38100700002)(4326008)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8S9Nhn8QDinRTrxy87PBdLY0tM8/SqMiwtey8sG4tETvhWVLwiewnQ65yoKm?=
 =?us-ascii?Q?QtY3oHBDHpgp4gUfNqHkdABIiVeOzCT/gk+yZqLEwpSXqxvWEoFSUBtu2bDD?=
 =?us-ascii?Q?TqotTIkW1B6lJevzQcLF3p2uqcsgIsVw+zAFqI2qsqMiKMnSUZu1jo3dLj31?=
 =?us-ascii?Q?EwgJjmr2Y9I3Rnlug49KOA+pmkts2GUwhvnCF2ZN56gXezNkAHg7vBecpRxx?=
 =?us-ascii?Q?LLXan1P8kZLdK4hLd4Z0xBVucdpP9zGJ9IhQZfDefXXn4KfDvbvzlEnBZRbL?=
 =?us-ascii?Q?6NIstwVxbOYwK7ZicXhlHEuNcl5Gni8bJ8CfqHttAvIxJDmqeiwXFyRykR0T?=
 =?us-ascii?Q?t+x1MREPK1lBAzRqoqW2nFjJ81456eIDFhzzkQlG8j2d7+S3DJjg+kW8gEyc?=
 =?us-ascii?Q?R19B3tKx7A3s72COj8RUghWNHt9DLYO96d6tnnjdzhJfgcfau9KZVQu3L09c?=
 =?us-ascii?Q?YrShCsVerJld0EI40IPH+ex9b0J+YPHHAY9mVO5dxarwaHnoQBPV85vj0Po7?=
 =?us-ascii?Q?RYUpRS3sV/t1gSaqBJpBeh+2AZJ6uOjBbpE+czhviH0yNDQSmhn5DUysYk2k?=
 =?us-ascii?Q?sVjCYeZyAyEuwQPUvfp7uZbeKob+luogSFURpnO/CxICZZmSbDXMnkz683Eq?=
 =?us-ascii?Q?vfKTZIGRjiGYnq7iA1H8qUJF3SoaxaT5nGsaTBX8uVJLVMPsspzxB3qwFiQj?=
 =?us-ascii?Q?3ydhi2k4Oq8ijDNDQQUTMfwdTptcA6cZJa5f3DCvwRO3GbwkDfbf2v9v8/A/?=
 =?us-ascii?Q?4VI+ny1dkysH4LGk1LKEBmdsKixwnZbrqT71G0i93mbW1t55aIkn/R2kCnuB?=
 =?us-ascii?Q?9Rdq+eJsSHuurxBelOVApj316vBVMzD4w3Z6cghP9nBy4vCfJSg8m/e0uFN+?=
 =?us-ascii?Q?Vi5zz9qT0kwytj3PxAuql24PMrsQcfjPm63MIVGvRKEUaiIwJrSViUeY095G?=
 =?us-ascii?Q?FIEML8DmLqeQC28EsbrLd6r3n/VLKUnuxqTzb/5z/F28Lsz7kV4xjQUU3SdB?=
 =?us-ascii?Q?UJRylMempyG9dtjKbf/N02K9AYkHzsyc2ep1YW6W45Sew2tdcP5f0LOs5SdZ?=
 =?us-ascii?Q?pFgTNpk7kGCfCMBCYLUNkoEotgLYXl35VJ2vUZ9ctiu4lMxpK30wng++u4D3?=
 =?us-ascii?Q?3QpUsrGaioGEKSihNj617DTp7f4wEkC/DMHGGzxS4pQO/5dAWmm5WLIK/q/I?=
 =?us-ascii?Q?pLYp1nNIJPqHYnY1C4l7UZWkK+XiJGoR0gidB3hQipc1skV0i+gYOT9tdNJE?=
 =?us-ascii?Q?Zr4JsDj8wIuvRDK4w8Apv2Q83kmi3czZkMVlSOJjeWpH7/Nm9uZ+R1xHhDV7?=
 =?us-ascii?Q?Fgpu7QvgSpEWeCXpsLJ1WOBjUZQ3yL96CRsgkyAiFJMyhOg4L5xz9VVwODs+?=
 =?us-ascii?Q?0GYTfgLdB6IflsF5kELPcleNGJ6nooervKLKumWkeu1VVHZwpkCbd3TujI8C?=
 =?us-ascii?Q?wFy9UKLuRdaQ9DOylfSGxMIRsmEyTn1VXU+J2rRwK2t8PQNMvE5BSrLDrBs0?=
 =?us-ascii?Q?+ZIAPVvOQnGjpYHANGD4hoonrGBzI8H8QIcnh/Nc9I78cDm20Gex6+uQSKg3?=
 =?us-ascii?Q?/ryA0BeQs0X13K4P1bA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57887f1e-fab1-4ccb-ab13-08d9ed99c471
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 20:04:53.2760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: urROLFCUSAJNvscpur7Bbfza6JXQCJgRqDK8uXL/kFLSnv4HwQeq9cIuKRH/2vyk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1426
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 08, 2022 at 03:16:34PM -0600, Bob Pearson wrote:
> Bob Pearson (11):
>   RDMA/rxe: Move mcg_lock to rxe
>   RDMA/rxe: Use kzmalloc/kfree for mca
>   RDMA/rxe: Replace grp by mcg, mce by mca
>   RDMA/rxe: Replace int num_qp by atomic_t qp_num
>   RDMA/rxe: Replace pool key by rxe->mcg_tree
>   RDMA/rxe: Remove key'ed object support
>   RDMA/rxe: Remove mcg from rxe pools

I took these ones, thanks

Lets keep looking at the other ones

Jason
