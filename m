Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6767674330E
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jun 2023 05:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjF3DT4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Jun 2023 23:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbjF3DTF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Jun 2023 23:19:05 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE9B35BC;
        Thu, 29 Jun 2023 20:19:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IvjbI9w5tE4HJuNF8KZ4WfqbXb7bLy89Iw+3pejOrSJd9Syj1RgGn5HrzmLIwfOT/cb+BmUcfpDrob3sfgG9ISPzgnWJ0JrFP8T3/raRlb0jaURXB0eOIRS2ycrxqgsw2B5ZjNkllguFsq5AIBEyCA2gu8fmRCcFLFc1w73LfGEI5t0GvtjpRyP+E85C4mlHUnKLSxBhG/4kimNdpqNyqrfkSsxzEtJ4sZKMSVKT96KoNRktw21R5+F4fhOKnvFz0CTEMjdY88+aB7Ar1qMsoY0EDfYmGw2LQeL3+oYvxXAHe82LFfrJJotyJfE5sHOUjwzcIEAki7GAPf/M/AimZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hN2JOPWocReP88Tpflr8ZM6WJQMvsCrk7WpDE1bT2ss=;
 b=ZF7UJmYyLnf4ZzNtpALwm3/l3rNA3JvagRPRNizaN9X1PAieYGois0gmkoZvvUFUp4X3QUrWJ+Ueh1ufKmzEKJEQX7FZ6xeKg77BrJGnFanFrhop8MAXrpUoPLQn3tg2nPztebxoNKXfeJ9B9eKk6NBVWPXAV6zoipawFilrbinUO3nzhi5HAx77rRL4RPRKVEIZmRLpFWEDEw23j8OQRJQ5Lgk52VZcRvczHQV+cgC1F6GCO2N18e2iWRmGtL/uygRRl22xe8L3p8QrFqS8zCsOwVaihqmcQ+8s9+equQkxbd1APmL8URxwmGuT6Bwt8Twpae26ndi5NBlJvr/u0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hN2JOPWocReP88Tpflr8ZM6WJQMvsCrk7WpDE1bT2ss=;
 b=uVNvGDjt9KGFiW8mM3jN+/Btz2fGeBbMz3CrCzXhabFQ8EiH4xB7pJ66m6Mq52vtQDBBT2INq13GJqS6uJk2CbtQVlxyZv3CcrzcNlNzNRPEqz00JFxWzhq3UEp9YQ3t9x0n69+++jHyNM/L4FrvOSaQgF4pUlFcL4UU4bBfXfTlBoyPrLj9Qe9Ywg5OiKiUbMl4qtWndGqLfhg1PONNjDX7GAEzLHENnjo2tSV3VxMUwc2VDUbEYn6FyFRxKni1iUFeg+Hl/chF7pchZr5C+ok+0CRuwmPx9mjaMIP85T05u5PIxWOCjLobxjG20sTzqVlEJwAhwhi0U14+dIpG1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by DS0PR12MB8563.namprd12.prod.outlook.com (2603:10b6:8:165::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.15; Fri, 30 Jun
 2023 03:19:00 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ecb0:2f8e:c4bf:b471]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ecb0:2f8e:c4bf:b471%7]) with mapi id 15.20.6521.024; Fri, 30 Jun 2023
 03:19:00 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     Zhengchao Shao <shaozhengchao@huawei.com>
Cc:     <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <richardcochran@gmail.com>,
        <saeedm@nvidia.com>, <leon@kernel.org>, <lkayal@nvidia.com>,
        <tariqt@nvidia.com>, <gal@nvidia.com>, <vadfed@meta.com>,
        <ayal@nvidia.com>, <eranbe@nvidia.com>, <weiyongjun1@huawei.com>,
        <yuehaibing@huawei.com>
Subject: Re: [PATCH net,v2 1/2] net/mlx5e: fix memory leak in
 mlx5e_fs_tt_redirect_any_create
References: <20230630014903.1082615-1-shaozhengchao@huawei.com>
        <20230630014903.1082615-2-shaozhengchao@huawei.com>
Date:   Thu, 29 Jun 2023 20:18:51 -0700
In-Reply-To: <20230630014903.1082615-2-shaozhengchao@huawei.com> (Zhengchao
        Shao's message of "Fri, 30 Jun 2023 09:49:02 +0800")
Message-ID: <877crlbpt0.fsf@nvidia.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0235.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::30) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|DS0PR12MB8563:EE_
X-MS-Office365-Filtering-Correlation-Id: ca4cb537-9454-47a2-bbcc-08db7918bf59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CV9t6q06Zt0YUfr3WqCPOBd5pIyZuD7LL0QnEa2dBnLNIhU/vurDHNUcZ4r5PIdTT43KAWigjmtaCvj1/l/c++6iXy2GX7hsiZVqVmXkZ5FzVtE9pRWkPvTCL3rI5iY+ESfexUwTg9K95y0Ff0xOVGPpZitFQpEgftHRFDBs5m0lqmDrioe/4+2DpeSZuunKQSihpKiqyQudB207f5AfLGmgkOntKa0l8p4Yl8iItwrJX+8RpQNEZ2hhPa2YbNToV+9fxvCARiXgQIUn1XHNBTjEcBklYavomvqPZRGBb2saBRrcb2scmGMwlPavbtvnIXUzT1cBsPO6lfs4hS4ZTx7dfnq+ISf3hvGfI44fkxmo8J2Liz5zNWk44T3qy51w5WPgEtbcs4717UnY+S2HxQgdNh686BthUnDVomrglp1lRzSsDRGL0NBB5ROUxF3QrDaAGikHxmoKB4wl/ttB8AzZQFHacnEd2TLeaHJWVrquCj3it2yub/OWCkTFjusOHfJEQJvovmn6cLe51WrLAP5w/IRRszmGOCPdGHzka+7C3ilpzthBjarjK1vdtGu9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(39860400002)(366004)(376002)(451199021)(66946007)(6916009)(83380400001)(2906002)(4744005)(2616005)(186003)(316002)(6666004)(66476007)(54906003)(66556008)(4326008)(5660300002)(8936002)(26005)(6506007)(7416002)(6512007)(6486002)(8676002)(41300700001)(478600001)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/bxA21nnhkrIpssL3Gj192pWSn9dcGGwSCdGH4+89/3T2XKaFcfEGi+OFDy3?=
 =?us-ascii?Q?rrbJof+KQhh2HojwUM8C/gzyT1m+hFXQgV39arThHyk6bNIo1FdOJVuzbZBz?=
 =?us-ascii?Q?C3SIZtJAeWbpmpplZYF4bZf/mH28FYZzXL/E2VMIFlBDgN8cgDEHiKiCaj+P?=
 =?us-ascii?Q?UA/kw7P3n/TZvflQj4Fsy+1VFqRaZNzFwgu24PD7hVkSJx3ztFeT2qGmTFv6?=
 =?us-ascii?Q?Gi71AN2pYdwwKoQbLto902JOI/Vb4KTzKK8EKzvH4OoYFZWCUkT3Ws11YeuL?=
 =?us-ascii?Q?Wmg2rCesLy4Sgc7ZU7ppshm5YDCEsF6cEqWKbxYpuDqkSFe6QOnWvleAYGB6?=
 =?us-ascii?Q?T+XxEDrVt8FNpKR8nm0aHHNyW9bZbsJZqDQwk4U+zGfnMJzq46EnAhSuEPne?=
 =?us-ascii?Q?NtPIAEgUCIpSYUUGrOZGXp+sKn6/h6fOzUci3Lpx+1DO/33V4BB0VSVWkkpu?=
 =?us-ascii?Q?9jOozTnb4O9+tWtv3R5PBgWFb46PijL+pOcaYhc1Eaxy96IvDVi3vzIUtewa?=
 =?us-ascii?Q?9LyMC3eOYSKuuMrp4h6zhhsHk5a5eJDle20zpbUklZLSLHh5mcQu13Xtvbf3?=
 =?us-ascii?Q?MhYjH5cehu0afvbBbO92H7YAayoaJQ/abCJ80sNrBGdFiMJS78T+ykfBDglf?=
 =?us-ascii?Q?4QFH5IDp26cO+9A/ANS5vwX94DSYbKhP1FB/43xBtSu51VlbMwjDtn+gxmDA?=
 =?us-ascii?Q?m6ynPnPbCiyA54OwIVBXaIBxUrU2Z2AgJuafgk4/2lQjFT6l0xNbkyyRI2n3?=
 =?us-ascii?Q?LlCAHTEKhFW9emlYZftbaaqgLAMjGaVZJ8xlkSqNyUkjImlSlEJsMJAFtoIR?=
 =?us-ascii?Q?z9DUAKTNUb+LemX8ECZkcgeWCrdgrqhAopc3kNASmpK11ua00xejR3/lRYzx?=
 =?us-ascii?Q?OHatx7F61c1jHjwK1vVjZcjn4N4gUa5jbR1xcjyxspwWXi9rvCNInb5/54vM?=
 =?us-ascii?Q?XjmkzWhQI79eYaxTSmxO4pHvO1yj1K8nOsjPFG7VJepOKwdL0jsKpqsx91d3?=
 =?us-ascii?Q?xkucrplKpGI3zxCZ1DpgIjowa/xqh78yALZmeqfuAU6D6K0Io3+8+Vh3dMeh?=
 =?us-ascii?Q?owcPjZXlXVz2NdX2DGnTqPyT3onDnT+sCND13U3DDJXLG5wrEb+SaT6ZAai/?=
 =?us-ascii?Q?aKNl5Oji+gCvVnfhPQ7Qg9SuPrcTYpCWCoZOYWP9EC8c/sblnz4uCknsCxpk?=
 =?us-ascii?Q?w89u9p68YUBsqEwOqPc2QAzsrnpaqlhgx8fHtJ73ba4CjOd7qAsVWysZSzZG?=
 =?us-ascii?Q?s54xXn0aP36awKva+wFe6FvT987SXfvMKgYhvuHAIL9+RTicKmZNTm3vVs+b?=
 =?us-ascii?Q?9oiaN64O2E+wwBjE/cu8BUg/chEaQPhtU9wfm1Dd01TNYT1zuF93KM27k0Df?=
 =?us-ascii?Q?7HVQNdOzmrlisO2VfNMLgXR2XcioGz+xtswpu+tdVCi87WpAL4A6nIm1f2YQ?=
 =?us-ascii?Q?1EiI3jfyIGUtdxBJ7piGrnFrw1AqHLfePU8WKsIni9K//SNfpGlLqycc4gSh?=
 =?us-ascii?Q?Wyjmm3dea2MFSCn+fK9DR1h/mVPGoipr3Yi+7XY9mUTNa5IM98YCwhDKCHKN?=
 =?us-ascii?Q?7yvjN18YZjtNxX9qEkkl2lQSs6zdrPOhe3aB1Yh6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca4cb537-9454-47a2-bbcc-08db7918bf59
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 03:19:00.1378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mh6YWW9zPlfJOIyewSQValtl5ymo1ABts3ukHxCXzaFimiuBUEJSqWzLNveXPRwH3D6jB9wSeBhpf9cbR6nI0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8563
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, 30 Jun, 2023 09:49:02 +0800 Zhengchao Shao <shaozhengchao@huawei.com> wrote:
> The memory pointed to by the fs->any pointer is not freed in the error
> path of mlx5e_fs_tt_redirect_any_create, which can lead to a memory leak.
> Fix by freeing the memory in the error path, thereby making the error path
> identical to mlx5e_fs_tt_redirect_any_destroy().
>
> Fixes: 0f575c20bf06 ("net/mlx5e: Introduce Flow Steering ANY API")
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> Reviewed-by: Simon Horman <simon.horman@corigine.com>
> ---
> v2: update the 'any' member reference in fs to NULL before free fs_any
> ---

Thank you for contributing.

Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
