Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F32213F1A2F
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Aug 2021 15:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238396AbhHSNTe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Aug 2021 09:19:34 -0400
Received: from mail-dm6nam11on2065.outbound.protection.outlook.com ([40.107.223.65]:46944
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238371AbhHSNTd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Aug 2021 09:19:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HOlCvcapT/4CDJq8yaw4jaymMcuRbrOM34MPD/mYpGMQ1Q1jcV4nWDTSnto2k0jnhz+1s5F323bE0V8MBK4VFFJA22GLYjguAorc54Di/Bd1hDY/iFS2yjw6USe3zhGfxqPT1Inr5zXXbTJJWSdj8evJjSUi+V967w8R2LLaQlnS4YWrTGZtwylP6myN6B7R3rrLdQZRIG7jIbwZC+2SR/MtPNdjVo8dQLVXfmKo8FsrDdnkxQYnd2RgCh7co7MJOS45Fyf+VcWL2+SVJ8qYiQFxGZsEDXuPGSGe/+5PBhbmmhSEdrfvK0y6v/H1Q29pWAil4t/Ml82obTi4ONJKmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUJFIt7M9p0fKd1hrZ4aXKVay1qw3A1nq1zMoY+OrII=;
 b=HgteDS4xVIcRIoBUPijweqiUsOBbLtN2Fg+fg93YJPYHzAEbje/qrCiSnnkElbZDRhRZVEnpxjCSKKL3jof9kAX/1vIcd1RAjst7rp0yC8u1xENV//xD+4AbRwEPG8nH5VdZB0vhZ5fjC9Mw9yXYzru8aHVqHWn+4WMeoYK1SD+0KmrhHki4bSCq3TtZlGGZmzPL15Hk10MWtKlAS/fQlZU+Hz1aSHFN6xZhFdzh1hEYZA/rF2xputGgK7mutnA56Y1AW0DwF1QR5DABxtaH3LqkUHJ9yvaWDfF//msmxzJp6QYi7CA3pJiGP0Cq6oCe6BNryjyqNAamsF7WVAOgaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUJFIt7M9p0fKd1hrZ4aXKVay1qw3A1nq1zMoY+OrII=;
 b=kjnQGec71oQL3aPWOsyE9Ra9QXIR6JC/SS8cipNn7oPM/A38u8r65hJ9khrLU23i2wbl8NP3BAuosqBYYg5Fg8BuKTyKBYKiofLicG7XaWsYDxNYDnn5KhhuwBZVbPpp5FVvF0VZ6Q7Td/7fX4QRybiAtvbYUyvW3DYM6jI1UMV0wu1NW7Ckzra3V/keXdiD0sTsHK2v6ts5nvtsrxWe2umGkrGo6kMgKN5nDPAtaks/vParttTidVLG99DGSc8TQkx3lNPUbjfup/KKzO+EvmVkIha99St1QerKpbPH2KlNxh77ywnAVf2DujwSehmPhigYLZAr00btlpj+vadbkw==
Authentication-Results: broadcom.com; dkim=none (message not signed)
 header.d=none;broadcom.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Thu, 19 Aug
 2021 13:18:56 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336%8]) with mapi id 15.20.4436.019; Thu, 19 Aug 2021
 13:18:56 +0000
Date:   Thu, 19 Aug 2021 10:18:54 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>
Subject: Re: [PATCH rdma-rc v2 3/3] RDMA/bnxt_re: Fix query SRQ failure
Message-ID: <20210819131854.GA275255@nvidia.com>
References: <1629343553-5843-1-git-send-email-selvin.xavier@broadcom.com>
 <1629343553-5843-4-git-send-email-selvin.xavier@broadcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629343553-5843-4-git-send-email-selvin.xavier@broadcom.com>
X-ClientProxiedBy: YTXPR0101CA0047.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::24) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YTXPR0101CA0047.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 13:18:56 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mGhwc-0019cU-3P; Thu, 19 Aug 2021 10:18:54 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b8807f0-121a-4832-12c3-08d96313e600
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:
X-Microsoft-Antispam-PRVS: <BL1PR12MB53363BD09E87BEF29662F927C2C09@BL1PR12MB5336.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:534;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mniEBRpOzg67PnmAa2EGj1WNDLQI/fIOiwLbIVt4vMTXos337pTC3NHRWJlvVoKEJk1J6ThSrAe83zAuEWXet+Zy1chcYRN3a0E/ZeCg75/pEwy423IQB+tFgxDoqmnHddgx+OZLqrFGg5Ws4hueDpmtbqz8eNyoY8KoKNxTo/be1V3MgvCxs+Fs1tCKCyc3LAFN21tqI2cvOgGQ2EuHdVMGkFqOScO/ByBLMgdMHLSoqRpW9C3DgM5PTdGw2EEEvGTvsuqBo3uRk37vH2goq02ZXn4wwpfTuUGKFila/YqNDkhFEQYfZimxa8bksXWIUOL1JUF2wGxiCGJAN5+FdGghPl8SSuoE2RwVkt93BhPnhyApcW2PX57OxXWNGKibJyHOu3frnyFiv4UO2Z/2T3BpkQcPfQti2rJK2b7wdt/6PMm5wgfO4KHUXAGgqjWOT0+VSeba7p5W5dvoVNTcnRYJZQj3mR6sB1pEL3HCKFwBKNM3FDBDUB/4sxVolnK/6uDX+r79gnmiySoUjf+JUTwHB52epgaIdMqmR8yKBWLDpUbzoOuJT1b6Bs1iPnrTeQjTUenQi4uSlVCI7rdOfkwrpoV0BfTDekaOxMvgj+Z2Qgh1vU3hHqOWIgB1f+N3O5bEmdk9Z9VJprV9SyDw9tEiX9x9qDjrUrRTEUdNOmrMipTGiXIHUxVJvAbyOUCq67965TVo87+xOBbShZhS9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(36756003)(83380400001)(4326008)(2906002)(38100700002)(478600001)(6916009)(9786002)(33656002)(8676002)(9746002)(2616005)(1076003)(426003)(316002)(5660300002)(4744005)(26005)(66476007)(66946007)(66556008)(8936002)(86362001)(186003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MRF8YGRvW80u9w1QUthl4+/q5e9P2kGjOxkvmUEVauxMNdIPRFapvNzjaswH?=
 =?us-ascii?Q?FVTWFrFf9gX3qZVV4zU2Z/IEdqhKai/FLdDxQqQtLujRVRgsHgpZkxi8yYDY?=
 =?us-ascii?Q?NC3R7z3W8Df5vw2NbTTIXv3lyQ4vN+oMNWgThXTILK4sDxnHGLLAoqAuTE0J?=
 =?us-ascii?Q?xoBw3PIYhXjMDGwbcKDe3AP+BUaXVImE6Aab91kr6l55UR0ik1+VEJPR8fU4?=
 =?us-ascii?Q?Qz3Ual42Z9DNoaWqgELNNtraZbLZF1lfsycAze1nJSRDoojvIo9f3pJVayxn?=
 =?us-ascii?Q?6HObEbBcYQGhRQZ1NpCGPUsw6Rhh9RYRZdFZBLFlQqOqMcu3dcilEVAZrxRA?=
 =?us-ascii?Q?FdfDjIBawuJm9CklaRblt/EzIYg5bT4Jr8Tm3yxCUp23BDkqFmW3tTdFm6k4?=
 =?us-ascii?Q?xbCN5EmZxop5dLlUmVKTKlTzru0hWkKc3CYJdsHnn5x0nhcgD5ZkJgsHqzMB?=
 =?us-ascii?Q?OJbBOR6eCG0zSGFSi3UMEeimfpyho7LK8iaYsSOF7T4qgK1NFvdMqPzmv0rr?=
 =?us-ascii?Q?qRLbCVg6MU675bDSMPk1Dp3xCWtd0bq3uUOylLEQC35jXJQDt7dVoxTI8sZM?=
 =?us-ascii?Q?DAsdY/JGsb74xv4nUj1riudxGKbqbgGoW+yomx3pUahfcek2kKxJi+2MpxtZ?=
 =?us-ascii?Q?gvaoCHjzeoGW7y6+diUJ8DgEtRUJKtcDQdmrsIlWQw0xLJ9xkFWrA2bJNoOZ?=
 =?us-ascii?Q?aK3+GNtxvEo53k20MgHVz4avCtLycSKNFAzXXOXrZbT3ALl+30PdgjXWCriY?=
 =?us-ascii?Q?yMe/uoXTz3y37wvmLjoEKa1CsBEJcHBIak2jyRc9Z97pP2y2f9uzgbx2bkPQ?=
 =?us-ascii?Q?OllivpX/T1t6TobeWbbJSIIilbQzit9HQL6DZWbrGHurkDcmqcJLNqtGNSFN?=
 =?us-ascii?Q?R/wg62Ugg6nbK8IpTdRrVWSihToQFUPVxSlhxhlS3UGu3es8Hd7J5yVJiZbF?=
 =?us-ascii?Q?O0h/esJV1yC5wG9cpsH/rwWdVBeFJL95cazn16obW/89eoI6NvwDdoFFsStF?=
 =?us-ascii?Q?+WHMt073pcDaMCHx8a+OArXkz7wfx9SP+ZSN4TnQDoQUEmbrWfNDfSivf88v?=
 =?us-ascii?Q?wu2N4LEw1K4fU/XtlD/QePJSefRqwN5guF0NBd4uvQYvhAVSZwUAEBKyH2aO?=
 =?us-ascii?Q?oOycLkTD519K4fqrK8eHOoOq9vDILa9U0lO+h15a0bqXv1yDE6I4Kd7wgzcf?=
 =?us-ascii?Q?HdPMkWHH5WDisGDojJYp4Lam5HG9l+VtLZ9JxLLHz9KVlhx3DX9OCR6Wrw3u?=
 =?us-ascii?Q?gsZ+1a90VlypjQvXmHCKBf95LVtJj4y9cbQj+N/vOt3r6Fzh6ZVefrA/GonC?=
 =?us-ascii?Q?IBXDm3Hip/hfaqo+g8NUt4co?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b8807f0-121a-4832-12c3-08d96313e600
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 13:18:56.7214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WfphZm68Gu/CAxaD+qJLm5urRHj3xb6OHWkisFkQUfg1lgoVrMNLr8nxBnvfnwLX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5336
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 18, 2021 at 08:25:53PM -0700, Selvin Xavier wrote:
> Fill the missing parameters for the FW command while
> querying SRQ.
> 
> Fixes: 37cb11acf1f7 ("RDMA/bnxt_re: Add SRQ support for Broadcom adapters")
> Signed-off-by: Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/qplib_fp.c | 2 ++
>  1 file changed, 2 insertions(+)

This commit message is not good enough for -rc, especially with a
fixes line so old. 

What is the user impact, how did this ever work?

Jason
