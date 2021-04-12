Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8D635CFEA
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Apr 2021 19:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243874AbhDLR77 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Apr 2021 13:59:59 -0400
Received: from mail-mw2nam12on2071.outbound.protection.outlook.com ([40.107.244.71]:61025
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241364AbhDLR76 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 12 Apr 2021 13:59:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DuaCwPPTzG243As8R6qPtOYD5/qsa4aYbuHYw2Oe+ajmg6dwLKmT5txsraxD0WeRRpnfzC/jN/zYPgqQhh/7tXUy8Ox643KainXMEXSJ0ugpy5QmfgYNxEFkPWZ1XXMP2wVqTbwl/rjGPsO/0i4mOoq0rdTBNBh6p9aYeHe5V8LfBVuuCWdDkUOw9NacgqmVO/8YWxv0R8BOL8HAMBB8EIb/PjIoCYEN/GDScZG4AqZ7iFsoIbvP7GuJkqReTfP/cb3h2l3HxMyJtlO+O8Np6yiYXi5ZnlRgf8uaLRYIGYJo88DRuiYcBhnMk0UA2Kld6AwWemwhljyRqB5NjiLSWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2cug9aUzfSWnGpnwvPnsryztXrFer9SYf9pAbfSbKI=;
 b=gYQd4wv/5+XzkfsyM4FyEvIUWQAAHS9b+GWLXlHx1SmijtWK+i38mwu9CNiGcqPRnV4AdDtWeEu6PQFKByaeY6hwExdZSlTOIUUQ3EORdILaT9fY4dS/gBlt2f+2k/5B/dLVhCjBwoNy/6zAWDRQGKA2atq5yJpqbi4ydWj5ClFxORvQgySZmFcFXMBI4rru6Q5KL02tq/WbQyhcshM+U4zZMMACk3K+ZKCp7IHsfqbwgqynbkcaxV5roN7uvrFjmbNzm89glztqU9PxdpKCEjTnbhsMxKI/+DZEsORKfdlbO7b3YmQt2AV6BWRhs3VfWWCGodgDpJDdCDeRiSj8iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2cug9aUzfSWnGpnwvPnsryztXrFer9SYf9pAbfSbKI=;
 b=SJEirD3IqjjJwxesZ7/abyQrlSFoJQHouilKhJoNjPYsyVQpzZ9YWlDNtaw8e1Z82RE5Zu1gi3/XtC4Qz+/AH/755WmbMmV067a8Pu3OJetPPo8OZnnK+lGJyB5nk6U6CJLFbkSRG9ioIZfbyRIMUG1RYf4Y2r0gfggkSg+YulEfM2yZ05wRD8Cta6jnPIxhaCMzEi5pDnMgQx9QC9E1Eyznq6LVaEjDOu5OJABQaWDPX+pk3Jg6mAHWvZCSIhTkSOHx5RlOfTigrUqfNT7W98D4EQVKtLnH8QibGtyj7toZurwEobyvFontW7pC/CDzAm4AlHoqDCTCXaE5+Z3srA==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3513.namprd12.prod.outlook.com (2603:10b6:5:18a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Mon, 12 Apr
 2021 17:59:39 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 17:59:39 +0000
Date:   Mon, 12 Apr 2021 14:59:37 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v2 for-next 0/7] RDMA/core: Correct some coding-style
 issues
Message-ID: <20210412175937.GA1145318@nvidia.com>
References: <1617783353-48249-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617783353-48249-1-git-send-email-liweihang@huawei.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BLAPR03CA0064.namprd03.prod.outlook.com
 (2603:10b6:208:329::9) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BLAPR03CA0064.namprd03.prod.outlook.com (2603:10b6:208:329::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Mon, 12 Apr 2021 17:59:39 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lW0qX-004nyH-QT; Mon, 12 Apr 2021 14:59:37 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: efc41039-dc9a-4951-843b-08d8fddcbde7
X-MS-TrafficTypeDiagnostic: DM6PR12MB3513:
X-Microsoft-Antispam-PRVS: <DM6PR12MB351393D06B3CAF570810784AC2709@DM6PR12MB3513.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OE5Ta40LuC9KJpJhTaYaGwmlw5eLnvOsMpm4oHpxSf/Shl1+acvtcHR/kA8yS2IBL2ka5Hdg67xu5EfpTZq4wZcBE1WcHVfB8j6h7QA+BDY+BO/3Mn5+zIOnVQDpQZ1Rlh5y3rLVgFTLTxO4EvzOHxO3KegdFRXjlVL07wc1o3ZxeYLgEFSaTo/GK+VSUHXCLP5HpXFj9GWM16sRDhUaKezpuyZOi29e/PcU/b1kQEXdyB2IM2WHS2hS4VtYI3kw8F75XYEhtVc05h7mG7f7fIeYn1PBBJNfZNAO2cJcIbPwkKqeNz5AUmG2oJ8H5nU+bh3SD6AZIhHphmfGUvlAUBiXoowAsLspqXzi/QdOC5xUkvbvIDePXaSlCdcix8EUAqatDUQPytglbMZ1/jgyrrjEScjc8+xOW58aGxNenvzk5ntEH6EeEm4YfgFb6vfO7OgYOSZtyqS/LrKKDdf8JxHcRod5hXB1mXCag3tRFdXJraIuxppFYTvR864I3otzGwllx7y1ii+RECogV6g/3rFcWlvbtiJQNXVrXkThhajvafZUsy644SzXEONSg/yt5+XGOc7B4eKovexAOArL7EAcpuQAzS8to3Wg+fXB1EzfD066auVQCrumUkC5zVsi5hP5zlEXG/upsSEWEMIEJMFSsty9cYkqhVByy4HE5YCC9xJifTaeN17B3kXy+5YG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(136003)(366004)(346002)(396003)(4744005)(33656002)(1076003)(83380400001)(9786002)(8676002)(426003)(186003)(966005)(9746002)(316002)(2906002)(36756003)(86362001)(66476007)(478600001)(26005)(8936002)(2616005)(4326008)(66946007)(38100700002)(6916009)(66556008)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?6XKP4j3WDbci7KYXhiDIvvaO9BkJ/RExagbVn3jRSCNO1AJc71jC+QaQfE20?=
 =?us-ascii?Q?8sg/L/IAm06mW1Hoem8vSwqRWhtgWJSHn76o0MjfIS9CDyaWj62TWk6uCcvj?=
 =?us-ascii?Q?d2cS/3Xtd7NHi29tLu6m4drV9+E/XX6JXuwfVMY/IGDGKRCqbeOPBtKDZb8X?=
 =?us-ascii?Q?UskQS1cMj5YB4Tj7vaXlQ3mKdVwVKZepXCuPAN+COZCkxz8z9hCNuXgfgyCw?=
 =?us-ascii?Q?eg+xqcuXTgVQzM0zWtGgxXyuTNDM5mip6+09XebfoIH4dHghHjYFg+UhSRnp?=
 =?us-ascii?Q?49fxr4B1uhrYX3g1hF1y865eE4XC9i+q5aICVgnp52HnBu3btQQqFmhVBIzS?=
 =?us-ascii?Q?Co+hsV/5tgoQsAarT5yLUGXA9cYmIzhX+k8T9AwVZhUF4mPEHNqfd1cEJwHD?=
 =?us-ascii?Q?qui72YZlncfq9Rv7Iblw/jOw99cVXFg9GidQho8Tkpb+FpvhXwCWxRtXD7Af?=
 =?us-ascii?Q?bBsz55iSPooVj4g1xhZda107BwcKmrFdXRj5lEdVPIUl8/hahgeVn5+RonVL?=
 =?us-ascii?Q?MTWWUX42hazR02pOm65h2l5G1dLmvw7InCWcj14ELcRhAXQUDS1Ss6h08SR/?=
 =?us-ascii?Q?FeYTiTQHZy8Mik8HHPSzc9/h19mNMOUvVJzk1W/DMYSc5ePAdlqS/REWKGm9?=
 =?us-ascii?Q?AOKg6hZTyl9bO6dktKv55YcTkOYg1e1CF9Nks6fFc2MydzSdHLgo7WPBMqS6?=
 =?us-ascii?Q?h4lK3uvR3YZ7sCedSQiOt8afEQmBJHcFWoFKTqXerOTvbs87nqvKUu0ZRWF3?=
 =?us-ascii?Q?iqeSCEOi4B6GpjMB41pPfyQi9iFghJavVW94dyZEniTJexQRiBSeMArUrW4s?=
 =?us-ascii?Q?VDNZKfAl7SRVfmpTp9tRnmTesPnE9am4jf69Y0gF/tc4A/XOF1Vj1OVmSD7z?=
 =?us-ascii?Q?wLXY0vzLSy8qk0uj+2AOl5dWMW1v3RbOvgkVf0XL8qGr0srz3Zjdxh3DWOEW?=
 =?us-ascii?Q?BI2OaRk0d4Mrx8ol8ZJcK5uHOGQWQzkpHJt6iwZh73g+f307cHtOOCP29byn?=
 =?us-ascii?Q?r8sLOb19N/cPN3pkCTu6sXdhKJYVJTTGJAkQ7j0ydNRYA7WtTVp8e22wwTKX?=
 =?us-ascii?Q?ylw85ljoEBT/zDf7xotACNxTb5cEsaf4Ce6JvKsq9DwbpYWSQLmtwer1dOnG?=
 =?us-ascii?Q?wnDQaugW1nqVwDKfgDXMWPVLKGwTMu/7ywIurjABo40egZrcdm5njP4rTC1q?=
 =?us-ascii?Q?0xk2n76kiLqjkRfckpfp+yK/APfEyDdD1dMG2K5GSJkEVwG0zmOztb+MA5Hg?=
 =?us-ascii?Q?/B2UfgJaNc4/zBzrzkixqIzO1nPZnwotdCPfL6c+NXzRtMmpdngJn697QsIR?=
 =?us-ascii?Q?MdW24ER8mcFR+0iHBp75W3GqdFA5jn+qEJWdI8TinPL+DQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efc41039-dc9a-4951-843b-08d8fddcbde7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 17:59:39.5283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FfEIakOZRzyJnpA78KiL9I9tMd+akIqevKYJitfzpAKsxzGxVZC6yxCZQOBFJ7Nh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3513
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Apr 07, 2021 at 04:15:46PM +0800, Weihang Li wrote:
> Do some cleanups according to the coding-style of kernel.
> 
> Changes since v1:
> - Remove a BUG_ON in #3 and put the changes into a new patch.
> - Drop the parts about spaces around xx_for_each_xx() from #4 because some
>   clang formatter prefer current style.
> - Link: https://patchwork.kernel.org/project/linux-rdma/cover/1617697184-48683-1-git-send-email-liweihang@huawei.com/

Let's not make a habit of sending patches like this, but I will take
this one
 
> Wenpeng Liang (6):
>   RDMA/core: Print the function name by __func__ instead of an fixed
>     string
>   RDMA/core: Remove the redundant return statements
>   RDMA/core: Add necessary spaces
>   RDMA/core: Remove redundant spaces

I fixed the layout of most of the lines this patch touched as they
were still not close enough to the canonical format.

Applied to for-next, thanks

Jason
