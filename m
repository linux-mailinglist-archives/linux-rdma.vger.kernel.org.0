Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59C5A4217E6
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Oct 2021 21:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234020AbhJDTvF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Oct 2021 15:51:05 -0400
Received: from mail-bn8nam12on2060.outbound.protection.outlook.com ([40.107.237.60]:51169
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233919AbhJDTvF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 4 Oct 2021 15:51:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XRftr4M4BUwYbIs7lqGFmTAVJcy8ecdSkHtdd6WF+RtRJWTi2kGN4Rv+G+Ecyk8u5Py303T1z3zVLrorHiHqGHFjfqSKVKtgzbAWca8MUwSVn4NELdOTNHY6jp28v82M8QWX4DC+Xm1sKjqxM1vxu9NFjh968sCYLk0ZUTVgV23wF8FeXuSlivRkJY7Ld7MpmmK90nMDqAm9cCwGX2peKl+KbbZm83INj07cpvia/Xbn3CXO722it9DpYbpCwEekCAUIMAzcGlvp3IefZumNdVKtwMr5pJ8qsufFqOTs6HuyrHcLSxlmuK2Hwi/L9YE8NxePas1JC1JNVqXHTWL2dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/pYuC+1UichvgOJUEabh9+Ye/PiGKcDztd1K0adz0A=;
 b=JaTWfLcqIWmIBxWkmTwC/RJejSS27FvuoDwZuwqTBdGFvwt7tRLUBrzSf/pHep5U1Adfs1jVdD+cWog+7DOzAOLPu5TsHnW/vXkQmKJZefQL0ISkgPTTY9Ljh/nQC9uLHAfOTpGJghuGk+pgToimeBCSuhfhvtb8xm4tXr/32/M3TMeeS8YFg5OsGyFtdUsL4B9UXOfzkGLmnY5Cq0f4G92cr5wflygvBzg82QaBzQ+qduKXYmNA1/UG2wYh0NmesKUM+Y3WUa62r/YCIJirf1qPNp4LLnJ5tAQdtCfs2aeQp89/0iCxWQzRMyRVOWbLhXBpiQ+Opc0BaOkaqbiu1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/pYuC+1UichvgOJUEabh9+Ye/PiGKcDztd1K0adz0A=;
 b=ttOcRFUH0eN3bjqBw4VDXcRuM4AFrbKAEoOHDMYI5DFC2nLhoQjb+xHwY/DtXVanqgPrUCFwxOM8vlIbDvGf7+UxBOh8PO7AV1N/g0FIqWONxwncdP33EgxP013ih4gGNRtE4vzeVfBAA4qAi9dDQs/eoD6vTr9vyJkE6ZGF+7SY4wLU9EJ45TISITTLdmeLg573GtHN1iFrN92Hjx3zUXhGB4GeJdo9+KGTdVgRLVRNr1NdFvus4ppaIdMGNOGmiWTfFE2xRDk3mGuroMNX1225v5EAxr4zenUEp4IsHCCUCZDXzLh80GDwNBLEnLcyp14Ze+fwWBsOjL22ECpCRg==
Authentication-Results: ionos.com; dkim=none (message not signed)
 header.d=none;ionos.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5077.namprd12.prod.outlook.com (2603:10b6:208:310::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.19; Mon, 4 Oct
 2021 19:49:14 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 19:49:13 +0000
Date:   Mon, 4 Oct 2021 16:49:12 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Md Haris Iqbal <haris.iqbal@ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org, leon@kernel.org,
        dledford@redhat.com, jinpu.wang@ionos.com
Subject: Re: [PATCH for-next 0/7] Misc update for RTRS
Message-ID: <20211004194912.GA2575899@nvidia.com>
References: <20210922125333.351454-1-haris.iqbal@ionos.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922125333.351454-1-haris.iqbal@ionos.com>
X-ClientProxiedBy: BL1PR13CA0277.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::12) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL1PR13CA0277.namprd13.prod.outlook.com (2603:10b6:208:2bc::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.9 via Frontend Transport; Mon, 4 Oct 2021 19:49:13 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mXTxY-00Ao7X-6m; Mon, 04 Oct 2021 16:49:12 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c501b2b-f343-4367-56a7-08d987700a82
X-MS-TrafficTypeDiagnostic: BL1PR12MB5077:
X-Microsoft-Antispam-PRVS: <BL1PR12MB507728980006079F60B7CCB5C2AE9@BL1PR12MB5077.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LqwgM2080Ch+FVLiykPJEpKkdpl4+0dTZOWnmK7lW45x7A1Ztk20GhCtnLsOVZBqRDTpn9t/U6z97Cl5Hx9463A9Zr3MtJXyF4zn64yzUsE5iUJESQPBRBZfwoe1URQWeOoo4S2nmeCCXTAfazIzFSVix2kNB4xm8UvwAqzL5CsqgCaAJ7Zp9k89NrZt8qaj3/sFo+XBXirm+MUyz/5pNo2a6cx1apzAjW8Zn8Y/OUOiqV6SixffnlDZxoVNFbWBZdN2n4ZmpvfR/U5w+GeBJeC16C/KW8IMhjzTWI/MfiW1cnWWKC3FTm6ptP+ezxA7W1cSThgYJbM3WiDZooR44ZjFhWGC7wmh4eq7zdu43VBLE6e8sVMya34oJMleZJ5xeWu3wcWqzmrWREK/e/IKAXVPnRye824//UZI47xpnNR9yyRRyuSQH9yTb28rHjF6HzzLqohr8/fRs3AJfPG4QjOKVVh9EFmW5GArXWMshGKtGOoqu/eAT8uZ8G17VSCUGBSmL551lJg7V6EDPxb6fsBJ8mSz9Ja0fCg25GsdNRTPC9ZGNr4M+QrPVMbzCRTNh59XI7bCbDv/BGYD+qj25V6uNdtXlWAWNf0H4mAPUlzHkjzopJQLX1kHLnytrxwY6rRwhoCIlnaZOvx5cy4xDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(2906002)(66556008)(38100700002)(4744005)(186003)(6916009)(1076003)(4326008)(8676002)(26005)(66946007)(8936002)(83380400001)(426003)(36756003)(86362001)(508600001)(5660300002)(9746002)(33656002)(2616005)(9786002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mLlFYDLZ8lLn+Lg/gQqcreH5dbP0+Q9oC1/XVEJZ2I58dKI02IlZrDylHvNX?=
 =?us-ascii?Q?A75ffyiAsQHqqqfv+z5xz3QFJgyEUBWTBq67dfjukG5DvOYqGUiSlCUsp28y?=
 =?us-ascii?Q?QqSHZAUH3ukRcQqTSbZoW1bdSDHRJmpFA5YijV1XZf+g1ddFgU6PtW1joEMx?=
 =?us-ascii?Q?zqj8u35N9NFBOvJNHdbyXETtEn4a9AohBcz7N+OK6EeMVQnJ5h55rK5E2Qzb?=
 =?us-ascii?Q?KADmWP9+ZDUo67Z1/3bZIHOdpR6V0vGbp0O7PAF9pMO6/JOrNQf+ELbfuthV?=
 =?us-ascii?Q?mQuK8cGu5YWd7Eik7ZIwvvLw83rQWJQvngQ73nXGJVroF5lKP+oLcZPBQDnd?=
 =?us-ascii?Q?FM/B/42Z3ymQdMmsufoKcIWyinw8lUPUALRGiJKA0/eDjIXaSKITuC3AQWgy?=
 =?us-ascii?Q?u/lcX6O+rtsUb1bVeNcnLx8MhuP3zgp1ZPOFCc2RJ7/DVaw+7W9TXiteuPBm?=
 =?us-ascii?Q?zmrIn6AAyvFpzEeCOyZ6ENEKOpKX0BuRsVCwhEPnFEbisbVXlE6g1aZmIMtq?=
 =?us-ascii?Q?zzHBj/JiREzOAYlsDDMnldalUpKU/CzdxpuWW6YNHGUmMwk4oHZ6QGxMSxrA?=
 =?us-ascii?Q?HnC9pmj4LuTj51SWaLT7W3SJg7tSA8QNsCRcari+m7vVvtiFXweDqgid/cWQ?=
 =?us-ascii?Q?GrgvZ8QuYyXXBRwoDEiM4uMWi7VSjYrxRFgfviVVU3+GR9U4tbHPnMsbsn7C?=
 =?us-ascii?Q?B4NhaRCc7V1G9gF4Ualp2weCOrdPgJ9yF8/Er7fARU9UMxhM4HR5ZS36rs0u?=
 =?us-ascii?Q?rfZpFX9+IniLEzQrLJSC5oHdNZxfqE8o0dTMlXEyHHAvXN4d2+eJFMjqqRWx?=
 =?us-ascii?Q?pA87J5D3hjO5MqvhNRqADgaqFLtTPTOtZqQ9CwRxmEra/lcupXWA+X1IMvjw?=
 =?us-ascii?Q?783uGegwDaR2iYd03DQGiw/d/l+nMFBzoVLLji2UcqKNqLa7WhaTnF7IKs09?=
 =?us-ascii?Q?jZNJr3x1Xw6Ln298FUGTmjdKiwzRsN9R/CRe0Z3E6WkU98eCc9JayVN7nnyu?=
 =?us-ascii?Q?OK9TIkkHwivtj74DC+fMRqke9eCRDxVM2BuUoc4JYHFD28nZgU0pSKfCwXKX?=
 =?us-ascii?Q?vsLiQxTfTqyLYfSAbQUJyicxtssYoPE+JYY3+E789v3NfookXpQV4hdBMo0w?=
 =?us-ascii?Q?0OxNyp0vbleuSFW3qmFNdGyeFx2MlCeSM9xLKGwbhOFxMslTMrLR9BOQYfkz?=
 =?us-ascii?Q?NnR1MQytONlg4rTLXeBM4ijkHxUKjebC7kSV+lHA+UHxC7p/9EaV5qRXZbDI?=
 =?us-ascii?Q?b0/p1XjbX3wUhWPIyNp6wTjGcx/VdbtnDsZaxOyMpAdt5P65NWE+mAElk/Mt?=
 =?us-ascii?Q?rz7hMOImH2PhsXQ76J3nN0C+RMIbdo2P6h7dwwknwtZflA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c501b2b-f343-4367-56a7-08d987700a82
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 19:49:13.8827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nvou71GUv+gS7JKZZvMW37aw3Aio+NUJ1C3IcAlAv8ZiqtVRYRESYcrkHt57Yll+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5077
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 22, 2021 at 02:53:26PM +0200, Md Haris Iqbal wrote:
> Hi Jason, hi Doug,
> 
> Please consider to include following changes to the next merge window.
> 
> The patchset is orgnized as:
> - patch1 sysfs_emit conversion.
> - patch2 remove len parameter.
> - patch3 Fix warning with poll mode.
> - patch4 Replace duplicate check.
> - patch5 Introduce helper function
> - patch6 Disallow special characters.
> - patch7 One entry one value for sysfs
> 
> Jack Wang (2):
>   RDMA/rtrs: Fix warning when use poll mode on client side.
>   RDMA/rtrs: Replace duplicate check with is_pollqueue helper
> 
> Md Haris Iqbal (5):
>   RDMA/rtrs: Use sysfs_emit instead of s*printf function for sysfs show
>   RDMA/rtrs: Remove len parameter from helper print functions of sysfs
>   RDMA/rtrs: Introduce destroy_cq helper
>   RDMA/rtrs: Do not allow sessname to contain special symbols / and .
>   RDMA/rtrs-clt: Follow "one entry one value" rule for IO migration
>     stats

Applied to for-next, thanks

Jason
