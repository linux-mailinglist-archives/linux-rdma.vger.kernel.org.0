Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80AB146AEA6
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Dec 2021 00:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377696AbhLFXzy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Dec 2021 18:55:54 -0500
Received: from mail-bn8nam12on2047.outbound.protection.outlook.com ([40.107.237.47]:31937
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1377669AbhLFXzm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 Dec 2021 18:55:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJISAZFWY3WmJ1pT3agBNIbfN+DSI3caxiXPKmBaG6st94Xjmw9GHBVudVD56+nXDSt18ZJE8a+LkeTEvxEkVeRKaj1/teOe+l1vrIP0fiHH1/K8ZYiDHfNzj8BqSGLwEH0rYNgFn1l6LQ7t9tvXkE8U15c3cQYd60ab7DFcF3jufdZ291QgPzt6NmXEZ2APvpJcNFiJkoIZAwOjBbG1LWhIKuIiSzHASucFtgaBNA94mhGit+PObX453jhetwDP336G/IaMOutctep5ov62h9jymKo/pamvk2+lYv1Vsis/pBVLF2UKDW7Y43tBKTtmdgrN1CsYBiytuoGC5R6Thw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9gP6bA5GUR1LGWcjK9HGQFd3xLoIujyi5dERmBjz9M=;
 b=csnek72DvmCdl01moOLd+ga9l3liHVALn3DqtZUVm6l9iKznmcUuPnvQNqsbVSP9hWnkK90GevcFdIIBc+BZE/6kgiaSR1WEMSVAp+JNwhEYROvy7Q/vQ3MpQPasJB0Id6oiBX+ZwoHh6UxVMEK+0NLACP75qxchg6R0eszvd5FHDe31h9g265PdpRfmCdshOygem0Sh/ucyOdT79kq5fSgif42EBil0JVLkKdsj/F+0DAT6DK/+L361HHevcfbKvk8T6urLl1yrAXY9XifPASNz78116JiJMhcYW1tnMwi1GkhEdzmLHmY5MQSlFhphiWhDBQiENp3bf+mYABaMZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9gP6bA5GUR1LGWcjK9HGQFd3xLoIujyi5dERmBjz9M=;
 b=KScAdfuQQVU0UefKHsDCngT7epwoQFNdZZKfNw+lSSHxr11yd6pN/b63LZlS1U7xdVlkv9gHVuU0pruEW+dcD4H7nfSMQw8XPgO6w4cJ6Ct/RiP9yOS3GPw8V0EY+yAEh4CvvmxN8Ta7GSX3+z37SW2RNVU6+57aPgp2P3xcptjRbckSgGEBLFEJAQgf+zQT6bq9fmjNFFr7GQnU/qPuyPT/zZfTABr6+dYdHCTEalrkuic3Z+GFsN79jNbdvCLDyNYLgjIEaR0J4d5lgZYMakqw9UBZ565dypOz1Tr3XoOlKS/FaB2WWXatvEbHYyXLZ3O9xwnwfMoDEaOdsGZCJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Mon, 6 Dec
 2021 23:52:12 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%5]) with mapi id 15.20.4755.022; Mon, 6 Dec 2021
 23:52:12 +0000
Date:   Mon, 6 Dec 2021 19:52:11 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH for-next] RDMA/hns: Modify the mapping attribute of
 doorbell to device
Message-ID: <20211206235211.GB2170341@nvidia.com>
References: <20211206133652.27476-1-liangwenpeng@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206133652.27476-1-liangwenpeng@huawei.com>
X-ClientProxiedBy: MN2PR15CA0048.namprd15.prod.outlook.com
 (2603:10b6:208:237::17) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR15CA0048.namprd15.prod.outlook.com (2603:10b6:208:237::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.19 via Frontend Transport; Mon, 6 Dec 2021 23:52:12 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1muNmF-0096cj-4Y; Mon, 06 Dec 2021 19:52:11 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92d4228f-e348-4861-b3e3-08d9b9136c54
X-MS-TrafficTypeDiagnostic: BL0PR12MB5505:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB55058211A78431BB86B5990AC26D9@BL0PR12MB5505.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M0pAYl7O9rZBAdNwDBXSCPPKg5kvqltnnMohQVPWCd+KHmowrPaARk5Rq4MinFtDT214VCOqViRnGqEWbRiIpDpHQCx65P1RV8ugrDEOQi8+dIonAxSWVr8KvOo7CFtOc185RthHJvA8UoNBVYCp6qp8UetfMBEvRN/JkRsRT4NJFUbzARp86jh28AhYC4oHaBjDXEwk9gGpyHal4e2/VwsFAUckx/U26EVYDHDcK9Hj+aahX+zpBgEXmWlDlxZTNIT7qlbfK7Q2aUWSfwCP2Z+fHghVLGxSoE3Juv2xaQne/xCAWrs4VVrXzcJt60PFWiN5c2AjaFSk/A0xDysiBbYw0LnzaV3u351uV8OTikBrVYlvD62P33BuV6/LFnbrhJHCYeudrpXIaOpfA7YFBHJRYaHZR9wZjIyggieJT4Gs5fFXovR/16A2iG4yMJDw3cPRG4pXHZ6tSDgWevx9jpwQexRXwQxekUEuAGEx0tNWQ4JuoGXK4oWzG1jvuwpXIbLe+o8zQVFfETljTqmzQKdvbC3TQxMweV+MBmeqJbsvex4s4NJJrJ/EdlcycSigFtQa6OQKbWLCog+8gUQe/ab0FT4Qp1h6Yu1wnB8XXu6cp3jWqgHmTQ/aXdJfsoadYHNa1ZESlogkRmh9T995PQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(426003)(38100700002)(186003)(5660300002)(6916009)(83380400001)(2616005)(33656002)(4326008)(8676002)(26005)(36756003)(316002)(66556008)(66476007)(66946007)(9746002)(508600001)(4744005)(86362001)(9786002)(2906002)(1076003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ERCmZT3v2bkvRzcnCrqaDGPFoSZm9iC+4dJkH1QWa5DN/U9mnsZoIO8sDhJC?=
 =?us-ascii?Q?s01psZWUARwr6ZW/HFdLGLRmrmbCdaT0P/qqqpMmshZYNoIuRzRHprbJSu3X?=
 =?us-ascii?Q?Pp5Yulc3wfkws7749UYWOUgEkzA+b/f3AP04EKjFevIthUlDuVPRj84JP8ER?=
 =?us-ascii?Q?ub+T2X1qqE7LgRxSeS+tXPFGSniqpQVuswro1qHnj2ISOqw7V+WMExKXQXyJ?=
 =?us-ascii?Q?G4plW4aMUDBNtG3csi8mIrPWCflG3jVlRrihcmsiiq6HlbRpbdmy0VTAUnR3?=
 =?us-ascii?Q?MRU9wKldYNVNKDDKzWKRl6Hg3NtwJC6QCCHFb3epbQywG8433iszT96OQnsD?=
 =?us-ascii?Q?PS7HazsiTO+Z3IdSjs6IyfQC9kQthJgozmldvyE1YFiu0psshHFbp/trfWJ8?=
 =?us-ascii?Q?Pg6kGwj4uIUYQIkhB263+OZTNLhKU+Q2vD7Jh7CWApawxwIixZhEhqgJ9NUk?=
 =?us-ascii?Q?bq5SGtbE1mVfRJOhWUbhZrOlXKZriFe/f84+Uh0CXQ7WLPK0Nu8TXZTyUNnI?=
 =?us-ascii?Q?1CujBHMx+S7bP+lkt9J4dMZOex4pi1V1NHsuD7bjBOpoyB5DopPUts++PJqr?=
 =?us-ascii?Q?9OD4n0PFfypmHRru2xzK3B0P/jyWyS2FL8A8MoRl8tp1nsofbWqGKTTGoJb4?=
 =?us-ascii?Q?2iZn8lbSOnj2wYtzoCAo5ffqJ8/d3fstSaNmmPpQj2RUO0EKn0oIOKggFdtw?=
 =?us-ascii?Q?fj5QqsIwzco15fdri1OXqQzTRwlGgmdxY3ykXfQIUcbvOVCmDt7HHcGej7lU?=
 =?us-ascii?Q?abwrBISiB8XCAckq82nCNYdX5Sm1TIXTdQGPO0y9fefEabmKfvy9e2dko0fi?=
 =?us-ascii?Q?IeOsOqNDAdvwGgKM1a1rdvtvqiceGbNfujclhsW/uGn/HE6kQeat81EAb6N9?=
 =?us-ascii?Q?//P2nhbG21H1BFbNVxtzuc72ZwRWwq+d/1DyR/6QOn9vXkx3Dw1+V6j43GSH?=
 =?us-ascii?Q?23tYYz+aOWTfVS3h1z6qGYCMSNDX1jdfiD6sBRv/VmTqnOnmeKb/Vb42Vxm1?=
 =?us-ascii?Q?Sy+Nj8XS1ZGeXI8VF9NQZnQE3LZ3yo7KeAUCB0A/mZVC31W/pdp1ww+75Qcu?=
 =?us-ascii?Q?eYn2/dxqw7UFvtECPvq6m5kxlSzFlnpm8bqENlylirifipN9Z5rAi8weLHcg?=
 =?us-ascii?Q?JMUgBUyH7Bu4a6lgz+fp5LfBuNO2XQ12KMKUiPFHyG0lQWF5iTtJW40uNCYt?=
 =?us-ascii?Q?Ca5ZvDqcYRcX087AQEa/OxcKzbnUy3QvBV80eVDxRayTRhglw74yEZvk+skq?=
 =?us-ascii?Q?On9tItKRypv0dPHVDP7nCvHE2Ki1Mm9P2PrKUU7gLGZ8DU/spVG4d/7WzjxV?=
 =?us-ascii?Q?N8UR6sHt0tGRLnlbEnCI/CLBVCEKcMAKvNU+q6js1OrxDV7PsnX60MRBYot3?=
 =?us-ascii?Q?AUnMbN1a0eOKQ5IAFe1tQ3eAWC0XsMhtjLrFJWkt1zcHwuU2RqXTIMsnqIe5?=
 =?us-ascii?Q?YCGlguklpf3wwvW3i/zz3198OlaTSShFoFl0I2S4/WB/X2DuNCw+i5MQ1qAc?=
 =?us-ascii?Q?L0mrw4bW2cLyZOOCbqCY4wodre2yPvXeJg36jE2mnjz9H7q135sGE5KBwRQW?=
 =?us-ascii?Q?EKTO3xX+VbYj+IcILU0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d4228f-e348-4861-b3e3-08d9b9136c54
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 23:52:12.3736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l8Te7J+RQ0UyZ+/Cr+6JjqhKHC38XTsO+Km/8jW+OvFkxwMXrHvOieHtK7meXHH7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5505
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 06, 2021 at 09:36:52PM +0800, Wenpeng Liang wrote:
> From: Yixing Liu <liuyixing1@huawei.com>
> 
> It is more general for ARM device drivers to use the device attribute to
> map pci bar spaces.
> 
> Fixes: 9a4435375cd1 ("IB/hns: Add driver files for hns RoCE driver")
> Signed-off-by: Yixing Liu <liuyixing1@huawei.com>
> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
