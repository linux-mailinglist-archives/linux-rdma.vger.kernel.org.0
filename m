Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBEA474EB9
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Dec 2021 00:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238282AbhLNXrI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Dec 2021 18:47:08 -0500
Received: from mail-mw2nam10on2077.outbound.protection.outlook.com ([40.107.94.77]:12833
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231447AbhLNXrG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 Dec 2021 18:47:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6VFTsp+oISeVvKc76WY3um816OFnJzy33I/Xw91DZFcuZ9p5Sc9dGh2+SnFh6+IhMs7yx4ehav3IrPZbRLaSSF4WVCFrBbS2BxntCbxoff65W/3aj3ZesryRwVEt04n+X6f48thLJfph0b9CNrdwF0SAyqwMTWVcD24nVOkGdj5dUNbZzKC8NGSnblk3fj81Xdpgn4FyFukLcBY92yRgfq5KuUGAysRyZZ39T7zN2Q9wSLNx/NQldKpwBZ4sORbWeOML8l+GBI21lfyaoEGD54dfaVeyjYOzEU8mefumdi3j+6O+0TteVLeaHcSFBNmZ4meR44iQ8x40p9w3w4ObQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FR470PGO3G20yqBeUL2uvloyO6D8i5vhQ1BDRLuWyN0=;
 b=Ihe7zBXOUquCpHmHmzb5ZDULFLZnl0z9Jxc6EeWS2J5+YUY8buuTDhkOJzEKZDsT2mMvNoyAd6St2yckgqw4LUaVnwO2zsmS6hUugotUmnzHu4vt75sjT1LmfqnYbpaLKR614QzlIqKivmAfY3XjwPt7T2si520lfdq06yRRyoreYzyMbNMu/mO+vc24dM0kJjJyzcnpuURzFhZ8wzDQBkxwDpWmv21kr9BKiEs0gX2pmSa3cFdUVyVhGQFnohenkcNnXXRJ4/mlXqoC7Tu8sLA7wQ0JVN4dn0TbxCFykNc3lhBSABJNorHyyJsyQDav/V4aSVrK6GZwO1g8QDRhXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FR470PGO3G20yqBeUL2uvloyO6D8i5vhQ1BDRLuWyN0=;
 b=nT/Sc170WM0XE1PDOBx8+uH422FxuhHD+MaZQXHi+CsOlDcv4Hme/YX7LqZkr5hbzO4dRF2ESWI2ZKXMNgUp58dZgUldkrW48+bDLbVDxtTcbe6E1v265LzhvdFyG4YruUW8a2ZATMBnOsowzDacWWeG2AmSsllkphPoPTfbWSmsf3BRE76nXDpCby3BgNCiQ10RHS7cIfEatjX85mZGGfrdgRbJcC6f/VhBS4B45SWjDDqXM2NgY8FMBpMz4IhK8pAyGXQadv1XyFtimHIZtcH0fll3S/3KN0f/vcFiBS5zy9ZZXzQhcW5l/8haCVVjFG4W6fFykNq08g87LPcxDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5520.namprd12.prod.outlook.com (2603:10b6:5:208::9) by
 DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.28; Tue, 14 Dec 2021 23:47:05 +0000
Received: from DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::218e:ede8:15a4:f00d]) by DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::218e:ede8:15a4:f00d%4]) with mapi id 15.20.4801.014; Tue, 14 Dec 2021
 23:47:05 +0000
Date:   Tue, 14 Dec 2021 19:47:03 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH for-rc] RDMA/hns: Fix RNR retransmission issue for HIP08
Message-ID: <20211214234703.GA968962@nvidia.com>
References: <20211209140655.49493-1-liangwenpeng@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209140655.49493-1-liangwenpeng@huawei.com>
X-ClientProxiedBy: BYAPR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::14) To DM6PR12MB5520.namprd12.prod.outlook.com
 (2603:10b6:5:208::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f76b4872-1088-48d7-d4da-08d9bf5c08af
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB50708376CC8BF6E08C8DAFECC2759@DM4PR12MB5070.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dqzd5LXajGCbcorwoDaf9TCzxJs9LDdPWr2lZp4m0NsD5ZAMGGA7DtP+n85naEmaEFzI9/ZFd9ZM0st0TVxzT/kFKvmjmpST/5v5Jh2YOm3KA7WUvrc08Xt77SNJAquoTauxw+S7iab2Sos+YtDfBVvUXuH6PpY3oUwYYO269v9jqRR5q2gp0XzwMjKcwKn/6sxYxEx1WRN7P4fTLWMZhGlbCdE0viHjf3RPlfgoGI36VW+dJ6vT/BH7ZeyRRyMEkB2yUHEOc1OcARFKQ2DMQxY7xuA7rfNXHWxpxt8nkmh8hMc9U6G7V+qZEvNBtMNLuVOw2L9P5TmP3vMS3cfg1laS2UJrBOb1HCN0cjNR4fv9zDMhpylliBQ7FPenRAU1rnPaINB9BZ+6Pt6IWoAK9ZZKMUUrjQy+T5eScrko6vwb0AIU9W0CJ9Tx3/XVAz6crPVitnI/5g+ebTcFMB8kzaReKHRgkTyCzrEecaC5MYMEWKtJk4IARfeZAtggyOIxRvZ67Srm1MUdKjtF9bBpj7QVsy84wa/qupFHxY3q/7B36e5o6Zr98m6JqQsZizQnJw4exAJ9qumr6zkmb53LtNOsJyeDQBIX723v7O3rB+ACRW/OgRxxS5d/8FEBpk4p0odmq9EkfdqBXvZTJM+g26LwtDJ8l+LEppurmLYatRn3KsHCS6zQhF/qAQKotU2fJBBr2fx8MsHP4YSdiTEhTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5520.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(316002)(66476007)(6916009)(6486002)(36756003)(38100700002)(8936002)(66946007)(8676002)(66556008)(186003)(2906002)(83380400001)(2616005)(4326008)(6512007)(26005)(508600001)(5660300002)(86362001)(33656002)(1076003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+Q4nzwwXORWrvvW0MUjb/bwP0HvKnCciEg58KQKbub7g1XurVcc6Rea1au8h?=
 =?us-ascii?Q?IkqLced6+mld850TPeysE6E2nbdqVyU55muQhPxtaLtADdhRIdhGt5hz2qPq?=
 =?us-ascii?Q?C2LsGug0u0RN36ZNQ1I9mk/7BoUf/gH0tBjHZGNLRK6bkGy+k8+J5eAHWY3V?=
 =?us-ascii?Q?6FZLwJV3NX8yKfSVIyIhIirTFD1P3C0ASKzdiIP0UvaAGZLgreNh1PW8guKd?=
 =?us-ascii?Q?zvNJItkVxGt57cu2KBABpW/1GGX+wbSqF9cHgARpMxNSHc+TY+iYPOsrU2rA?=
 =?us-ascii?Q?cffm8xfCmrhx/o8uBlPMQxXW2CHkRvWSmY/L3ELos33UKjxXEJHO4Fm8Evc+?=
 =?us-ascii?Q?YCkPasF3BMjEYMPwbkpqagrwUAAmSxnlYT0XB7KSpl/zGq5EU68slMH8UBcL?=
 =?us-ascii?Q?NAnTztUN5NEjppUUSAxTmFJnG9Gke4aDh77TDaOL7W1gYbMT3g7vfscv3RYc?=
 =?us-ascii?Q?CrIfzsrGRxjJVAurW8/JAzmoU6u2nYwB1TGPK2E23e3MDAmpAMSQWqtf1jKx?=
 =?us-ascii?Q?+Y9yWI3JSgIGhK58MOFqEuSXP6NhTdZNAhrY9AqndaHqCpVXNTU7S6eXl/U3?=
 =?us-ascii?Q?+daP6PhN0VBrrQTvf6PtDW8NhmUFwuXSPx+eSIiCoH86jJ8432R3WGkgGlrl?=
 =?us-ascii?Q?mLgHFnZab1fJbUDz4a93gKc6r+3OqQzzHs3rL9gpqUiWTgsWa3RaFw9oguyB?=
 =?us-ascii?Q?i3z6T9dYBuLGJYJs8rVCuOgOVP9gvv9DxvZbpbckTNUG9+t8Ew/Rd0fTxUw0?=
 =?us-ascii?Q?whDXD67PLcYXzK/0Yw9/wAZwxPDZAtqkFhCayJrxnwcdoVh0wxHjN0kAKagI?=
 =?us-ascii?Q?IZLF0zqKVjJA+Vusl+gAOnXroAYuC3+yHUTuoDUm33jyhIoxa+jWDtBvIHl+?=
 =?us-ascii?Q?44igyDts2thiR0Mz/Wv3Jt20iNL3XVH1AsCeKRBBjynq3mGCnDqd8BYw9q/a?=
 =?us-ascii?Q?XqhkimywxID/HyHHI4FApKEmGCsxHXb2QJtcje9y46Rb27C6Y7LIU7+SalJk?=
 =?us-ascii?Q?/FdnZ7poPQ8bZwp70vOI0kyuzliA/P0zZZffOkWQSTS0ZmaQVKXZdkM5p/oK?=
 =?us-ascii?Q?9dy8x63BMS9/z14Ux8pO9aP9PBsfF71j4Tnwoj0/BdY3qv2agJ9d6AdxwLjj?=
 =?us-ascii?Q?GInxOn36eqfVazIednlpe0LBkCglVKg7mdC9CfwJPaEvNkmzZZ9Ay7qxmRWT?=
 =?us-ascii?Q?GHvenNvcR16nc4Vc6qcFOkRJFjf6YB13fo9No6hYCD/nMDvU3aC2e5sQQyDo?=
 =?us-ascii?Q?FnVNpyA/PmmRZTy1mqA+HZiCGtZg5fYE6v1V9/vZy503G76PSYNd+rMNiO//?=
 =?us-ascii?Q?OzAlmznDymO/jb74m1Ko0Gb04c5nfgKDTkBNDpN6E/24dbYGe5E0aQLXscWC?=
 =?us-ascii?Q?DEeBUbDwZUBkO4zOc2ntVha0RAQRFSb1ASHDVj1APfawtlBZqhVjykwuOMuR?=
 =?us-ascii?Q?yl8VIkgfTzjr7qDlNmmRjXO45L22Ju22RcqgIPWPfiRHo5NUvSkSrRuXz3jg?=
 =?us-ascii?Q?mwB4OB/oRqPMJ/QqywbbBhbxIyI0ETK40v1i3/7su8ddlSYLqLK2GxqvhCUC?=
 =?us-ascii?Q?Na9vnaVT7nFUcb3WDZI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f76b4872-1088-48d7-d4da-08d9bf5c08af
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5520.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 23:47:05.4989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JROMSvTH8xGRA1e2q2DrznS3o3V1sgpBwLO5RmtOzXE7XGFmUhH2K239TfBa7qZR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5070
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 09, 2021 at 10:06:55PM +0800, Wenpeng Liang wrote:
> From: Yangyang Li <liyangyang20@huawei.com>
> 
> Due to the discrete nature of the HIP08 timer unit, a requester might
> finish the timeout period sooner, in elapsed real time, than its responder
> does, even when both sides share the identical RNR timeout length included
> in the RNR Nak packet and the responder indeed starts the timing prior to
> the requester. Furthermore, if a 'providential' resend packet arrived
> before the responder's timeout period expired, the responder is certainly
> entitled to drop the packet silently in the light of IB protocol.
> 
> To address this problem, our team made good use of certain hardware facts:
> 1) The timing resolution regards the transmission arrangements is 1
> microsecond, e.g. if cq_period field is set to 3, it would be interpreted
> as 3 microsecond by hardware;
> 2) A QPC field shall inform the hardware how many timing unit (ticks)
> constitutes a full microsecond, which, by default, is 1000;
> 3) It takes 14ns for the processor to handle a packet in the buffer, so the
> RNR timeout length of 10ns would ensure our processing mechanism is
> disabled during the entire timeout period and the packet won't be dropped
> silently;
> 
> To achieve (3), we permanently set the QPC field mentioned in (2) to zero
> which nominally indicates every time tick is equivalent to a microsecond
> in wall-clock time; now, a RNR timeout period at face value of 10 would
> only last 10 ticks, which is 10ns in wall-clock time.
> 
> It's worth noting that we adapt the driver by magnifying certain
> configuration parameters(cq_period, eq_period and ack_timeout)by 1000 given
> the user assumes the configuring timing unit to be microseconds.
> 
> Also, this particular improvisation is only deployed on HIP08 since other
> hardware has already solved this issue.
> 
> Fixes: cfc85f3e4b7f ("RDMA/hns: Add profile support for hip08 driver")
> Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 64 +++++++++++++++++++---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  8 +++
>  2 files changed, 65 insertions(+), 7 deletions(-)

Applied to for-rc, thanks

Jason
