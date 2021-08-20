Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1F6F3F33E2
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Aug 2021 20:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbhHTSfL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Aug 2021 14:35:11 -0400
Received: from mail-bn8nam12on2047.outbound.protection.outlook.com ([40.107.237.47]:62816
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229505AbhHTSfL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 20 Aug 2021 14:35:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nodJUWAQf6N2TiwW5U9U+elhhUhSNggiMRjj4y5zeyvkQQ/d6GkGEm70tfeFvmtgqxJseMOGEUb/ozt/rXer2U1iljZqxoMVNpYVZ0o09twWbPvxWB3cGXMgdF00KdDtJlKcR5D0qjrF5wHI2tlUfgXPE6hhBHToaIPGohycsAQOBETSUBB+hk7ElZeln5Qj2mWzB395i7EvxM0N4GYImv2sR1a2zHCCJZ+r1qH0LpnGampOAhLDOhbshAKTpQv2L2YWt/Xtzu2UymnTJl8n3CehzksfNg9iJmLblIXClMQInwdffmKb+CWemHFIm5MhJexWZlz2FfID3zQ8Q4ERRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEvAvTvIM6PqMPFtbY12HLk851Bdjb/sgJnqtGS55Dc=;
 b=IS/e2liW6MlnhS2vLkA9NMzVLY82Lin8R+s0dexhE5+hgtdmsJNcF3OFxIEgnnAi32UVQFnhFau0NPOlkmNCK6+7n1jJz/itkBV76rAxuRhPdhZge1vdJiINsnkKaWUik1zUE9Wx+gOI0pR4M3ZRF2Cq+mjYokY4N7xt+0xijVvUSWpKXoiFSde+jWh2O4ZuRppqaGmSH5jsIQe470qRMDGdGlZVoP3OnrYLij5WkZcI9ZItEolySO22c85MSwEE5pL5CLMR4xTu2MSd2bpftR3raHdkW2MOWK+JAOeuQi0/iV+D8RzAQhe64zICqd23mBKFtiV7JDJUwX81/lWa+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEvAvTvIM6PqMPFtbY12HLk851Bdjb/sgJnqtGS55Dc=;
 b=JeNJmcblFWF0hnYcploPc3OJZwolHorMo3ys+KfDs9e693dMNxKWIQ3T2RU83wceXe6+RFLic/3cS3ebvj61WAWPLzDf34ERboCFOnF9tHQVXuz0sSAbIjf1ToAlzD8R5aBLPL+Un4ZlbRXAgKzaGKSxUjc96PaXGuRmQelhF7MDKiBOMzXvedRVx8T3EWdzQDX7XJ5OOfAhzBuTcaJJrnSfBjuvIqnsbi4fc2v/pYqv2YC5mDuICdL5C0aQCaLe5KY9NUvvNKOjrOmHtvI6xcZ+x4PE267zxjCtmnFK7zk4wLi2QKFgs7tykDu1bpUzTBTdaqWt1g1jTVoFzj647Q==
Authentication-Results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 18:34:31 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336%8]) with mapi id 15.20.4436.021; Fri, 20 Aug 2021
 18:34:31 +0000
Date:   Fri, 20 Aug 2021 15:34:29 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Alexander Matushevsky <matua@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Steve Wise <larrystevenwise@gmail.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: Re: [PATCH for-next 1/4] RDMA/efa: Free IRQ vectors on error flow
Message-ID: <20210820183429.GA558235@nvidia.com>
References: <20210811151131.39138-1-galpress@amazon.com>
 <20210811151131.39138-2-galpress@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811151131.39138-2-galpress@amazon.com>
X-ClientProxiedBy: MN2PR01CA0055.prod.exchangelabs.com (2603:10b6:208:23f::24)
 To BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR01CA0055.prod.exchangelabs.com (2603:10b6:208:23f::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.18 via Frontend Transport; Fri, 20 Aug 2021 18:34:30 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mH9LZ-002LEV-8S; Fri, 20 Aug 2021 15:34:29 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db894720-7abf-406b-e1e4-08d964092621
X-MS-TrafficTypeDiagnostic: BL1PR12MB5112:
X-Microsoft-Antispam-PRVS: <BL1PR12MB511245E687B2998014234C11C2C19@BL1PR12MB5112.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZqqIvovakY+ocT8TYrQaHHKXxnuASUr8D6zUpIy5QE1n59aYMvNYsHDrvHqBXwzuc0f0j9HXgSYRzUlqa0Y470wr7p7T+1r94dbaQu8hnqUstQKq1Yqc4Qc7VgZMgsGAR8dgYJ7ZHQ/dPP5JKeB5cct94sthIyOD7ennl/91cYBLwR/k6iVve0Zh6biqliOFjPTagBkmb/ZY/P/B6WWX3cybN2wMqhsVPRmxDhByvpmlcMPDicy2rjVIuIqxJHhhRzG0gPB9LKLG/T+cje9zo96pLlKQEMj6tjemWxyYVtmDDephpSd6dIThMWA298S4N1FSiYGSs4uLgx+ZWv7CxfHGstsrwO45In8i2q/NeetjlmkqTHs9RU6J/153sMEba/LeHbkLTsQ6e8cJdENxD/Xtjy/zrkZe7cuMJnCF8FWiOPPVe7Khb4NhJW/l+MXjn2PFZo8XWjWfCLRrggqK1BljnlAf6QusuMiyr2Qo4BzyHRSgcT1ndzw35+DJ+f6js1AQ47mjMLE7RXLny9LyWNUn9c7nfvvTsZ1D8SsmzSNuZuz3HDOebFKJabePdKgT7sBIIILz+r7izOMkqhu3jRP+8WLrv37Qgt3lrSxNP+8kVvPbYIpwZ17+fS2fS40hMigJ3hsnunXrJj2E+5pumvbQEA2cP1CeM9ojmPTCTkSqJo89W/q1Ttfs2nCiL8BDrn2dqL7pePaksaYc8Jg3+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(9746002)(9786002)(508600001)(5660300002)(66946007)(2906002)(316002)(66476007)(66556008)(4326008)(54906003)(33656002)(26005)(8936002)(426003)(8676002)(186003)(6916009)(1076003)(2616005)(86362001)(38100700002)(36756003)(4744005)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CYgKAzbJJrE8KQGhs+Lkzrfcvo1Vqa5SoXF+w+iPCjRWuySwhhqGim/PSoMb?=
 =?us-ascii?Q?rRnu0tgu92Y9Kr0dCzpt7zabBEyZZjesLinXQEstIbPfTarZYYLZhVAWa+M9?=
 =?us-ascii?Q?NByqXsZ45vwARr0BGIuJj/wSEDsI95mBtnd7GVCzE8RjkHDHZwp7sEELnKRP?=
 =?us-ascii?Q?wg/+qgMRwxMJAY6ZN2rwMz1KD3OMvM9FH0TceeOmFj21m8FPu3uT9fMifYRf?=
 =?us-ascii?Q?1xnqcdmax1l1CJuw6CH3CKV4QGi5mTcpYdtCAlGB7iWmr6JQYsESu4Jd+nrc?=
 =?us-ascii?Q?z2o7ERDhpLDvvj9DgP82Fke1mNjB7e/tTqA18eRG+toHpl+k1U6yUmn5n7F4?=
 =?us-ascii?Q?IyhcAUfYUnNEO14pOhOCdBQNXkw10wTOOh6q+5VZmkjZfIn2+3cg/yas4aPs?=
 =?us-ascii?Q?iIYih79XmCUu3vdaBMVDGL+D6931htQJ91MOwPCfWhBIEXBA/V3CAkxxFEBc?=
 =?us-ascii?Q?T3qgv7v5S58QAb29VF2tPBQkD2lXGgWMUA0PbjjARnq19CUlhCroDb1qmACr?=
 =?us-ascii?Q?y2zt2DWsw5oW0pWrVAwK7DllURY8BoXVGASb2b9qnRV9BTJl7bLq8govqSPN?=
 =?us-ascii?Q?MsxB/dUOT8dFk3rNw6ZnmQ7POTqrwzKUPOK+5j6s0rvUEmEkOfY9sBOctWc3?=
 =?us-ascii?Q?PaePN5WinBJoN/QjICIM+4n55VPAWA1c4gbBU2sNxs+mLDPXMyXhX160wMFu?=
 =?us-ascii?Q?N9hxkyfaKwac7Dd78O7tLM0dy8axzZr9vRqhgbntq8Bvpd7+eu1dPzgt7waJ?=
 =?us-ascii?Q?bFuKnujyi9gAQQJPlnhrZl4bEE7XGnAIH4OF3RrgU+QnVypli1IP8fImPz6D?=
 =?us-ascii?Q?qqrG+G+xkgk//ZI63ZukmBHOvDXtkP6gk8wAiPB+sdIDrvjIxl/vmgGRc65A?=
 =?us-ascii?Q?JUcH23Vn0N3saPWAAHNjPYzVVTCllUkO0gPwXJqIadI56BvVP8atxv1Ls3pN?=
 =?us-ascii?Q?f0VI+CMBuNbkOmeGUi2s0dFAMwNTY388WlRK471EyCn/Zuhg+9t5LaocrqHp?=
 =?us-ascii?Q?cGKOLuvVZk7qkU1RcSP/ue11FtXvynFZ57Xm6ZOaBT8OC9WA/nIxe9bcjxDq?=
 =?us-ascii?Q?OXmLSX+VQjwJvmNiglz+8rtYgoTOUwu+CwS/TLuVGGldIJZwmqNiFznDskYw?=
 =?us-ascii?Q?ilaCocYQs+nGooP+J73h9DLiP69/tjhUg+Ph44cSFsFYMKtx0Y30sTrTjnzH?=
 =?us-ascii?Q?6El7G1d9Yc+qjrHHaaUdM94+0L6vLSsz3B6S9xhWQqoCoFmIw4eOghkD9IDe?=
 =?us-ascii?Q?4YqE/NDb39aeQ6mkVUUUsY28SqX6+8jIJU5cDNNGWTOQkRHX146/EjhT7s7u?=
 =?us-ascii?Q?smNnYc1C5lg00QJ7Gy/j/6bx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db894720-7abf-406b-e1e4-08d964092621
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 18:34:30.9830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: trmMCp/gB2vkTXCd9UM/kDINZ4bmYtWW6bXdgTQ4lB6yl/3At/V5HcTQXma6p+0J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5112
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 11, 2021 at 06:11:28PM +0300, Gal Pressman wrote:
> Make sure to free the IRQ vectors in case the allocation doesn't return
> the expected number of IRQs.
> 
> Fixes: b7f5e880f377 ("RDMA/efa: Add the efa module")
> Reviewed-by: Firas JahJah <firasj@amazon.com>
> Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
> Signed-off-by: Gal Pressman <galpress@amazon.com>
> ---
>  drivers/infiniband/hw/efa/efa_main.c | 1 +
>  1 file changed, 1 insertion(+)

Applied to for-rc, thanks

Jason
