Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 173F535C5E5
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Apr 2021 14:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240812AbhDLMFH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Apr 2021 08:05:07 -0400
Received: from mail-mw2nam10on2083.outbound.protection.outlook.com ([40.107.94.83]:47361
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240815AbhDLMFH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 12 Apr 2021 08:05:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GIhLxHMwU3Wq2/uEIWP1tIvUhfDc7saiA8FRZt5itCcO2D9nK8vwZnlF43S7BPgAbFUe3GobCc/J6Aj1fpNYCPDdKia9pGC0tMG0DPZlOZC+SZxUHe8mvfZkWP0F/De5Vipqk6ONyat7WqOMrgokdSiDkhLqxsCBJbTOwDl3gg3pnh73ZZLJ5XnBKj3ZwKdEJezw/qb4vAXUV51qrrsv4MnsMRnUzim9YAh5DmP6VG4EJGQARAn4/HtauXqyDD7YlVgcL0/dVUGvgozs/hyOV4FmxJhdvTy47QrSN1gH0WfKpby3BjeQKhw0zZuZukq3WkeXXP3H5BRMNfBhLOLHcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jm85uc6dv3HAb/9/6VJvM9ep7I1+HMZ81iXoFZRPluE=;
 b=ivY89WHlqdUT8OD2VMM1vhNJBv9yXx7pVJL8/LHJqXGj7jMWgGBxCPhohzaJ1GJrn1ireX3GmT5ztxW82wYycIzS7CSD0D9vonuHul9aeUqEULCiL12FEZ3CVldRI+/dGQQhAn6XpthhuiB9buV0nyNA7KhUmQqCzM07K8s5XMqzfIEX8vXVS8neU0tQUgZK2B551lxmX+Yq1OlWXFR0cwqVb8p4EgSmn63UA1fwTIJhCcZ/s4yGONNACBsegGXc6C+hyztwXYiwyw2lOm/biE6xxU8VcqaSSLDqgr/kLp2TKB0N9NvRUwB7GbyM8rHZ2aH4DXLttH6fGY2EIOfAyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jm85uc6dv3HAb/9/6VJvM9ep7I1+HMZ81iXoFZRPluE=;
 b=BvCpAQIrLGqu80A/l9y6LggNg/eFcpqQiWJl1/O4omLtv/1HgQZS3BXumugt9IofwZDswQnBGahz9gCeo4soiLw/wOf1L6Do3OMWpSKMId5/UiA7MsFnTxPpy0oKlXEywHXJJE+BL1xHAtV9a6izPmf9PYOnd/ZY48LyqxI/BxNFNblkpVr2IpWRjYY2B3wGu+gcr66s4geuk8PSDhmSNei5Wyb1gvYWR1+g8RfizkWofumXrXMnf3VIlGCMeycwTlrMqKbV235Vx52ZZaX2qKnSHDOcBdJ2deJIKK9QiijEJeVG1vacGVh9I6Vpj3GcD5IZ35QxmUyHraGmXYHimw==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3308.namprd12.prod.outlook.com (2603:10b6:5:182::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Mon, 12 Apr
 2021 12:04:48 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 12:04:48 +0000
Date:   Mon, 12 Apr 2021 09:04:46 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        Edward Srouji <edwards@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: I need help with the rdmacm tests
Message-ID: <20210412120446.GE7405@nvidia.com>
References: <bc01d5dc-4d2c-81ca-0fb3-337d6a160b94@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc01d5dc-4d2c-81ca-0fb3-337d6a160b94@gmail.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL0PR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:208:91::24) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR05CA0014.namprd05.prod.outlook.com (2603:10b6:208:91::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.8 via Frontend Transport; Mon, 12 Apr 2021 12:04:48 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lVvJ9-004Q4P-0P; Mon, 12 Apr 2021 09:04:47 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b8f7329-d665-4633-d001-08d8fdab2b5e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3308:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3308DB9E78626D1000F6CFEDC2709@DM6PR12MB3308.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7xuyJTa6CGTOkkgqjPbvaWQGSyn84Lh6mXw/mE29BJuIcKDnjN3BBSVvdHCiO+bX1xVdiDUupDArXXo/7Z/Ax9uqmS8KSXuD6s0AJCIcufk4nilNxXS2VIPIb+szOwHlKgaqertROambvNTF3mCAYBTRbkhQi+lRAUak4bgMVPY2G+AtmzZY4RB6uQyj2Lj+Yi9CbFcZqGq1JTf/MoiV7CXVPSd3fYhG4jsKnLp7iGiwfY6Lg0Z2AuzyA37W5t+ADTa5tqP/aQGNI5BsAN/mDiwIm+QlnyZrhY8brXK+SrGBMJS+tZNEUk62wUsE/VlSiX1wy28S+so29lyl0tLd/gSbl2f2mDF+pmekEW253mPqlyN2FIJQXSvmHbU7BbOuOXumti1K/bLsybiCnkdlDkLr2Ow8RTbZ/0eGVI0OYt6rzyg4XKiN0WB5fbLZTSHD4khX/E1c+cXkzCODt89HEWnlNGm5FDA7X+oEKLWf4Kpcde0D3tm5dD03MG+xD/b5kHjSA1PIL8YN0ruUzN9BXEr8qGwPYpFUl7VfVuF0Yt8v+flvWIYS3WGIFV3nmbFNlF5X8ZJIAsdx5liUH9aQGmlQVVXZxzI9KmER+nyC278=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(376002)(396003)(346002)(8936002)(86362001)(8676002)(38100700002)(4326008)(2906002)(1076003)(66946007)(426003)(316002)(33656002)(4744005)(6916009)(5660300002)(36756003)(9746002)(2616005)(54906003)(186003)(66556008)(26005)(66476007)(9786002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Z08I5SSZuLm37irIhCEwPKBOHxJNLA6U2eUUkbuXn2gWNUWE/swO7J7pzOD6?=
 =?us-ascii?Q?HJyOPftZwSz/HZTyrkPHPqObrpd5O1aUN0JVaXe3uDGdNmxw7iMlH/ONkJOJ?=
 =?us-ascii?Q?+iFO0HYd7Ht2OHXsdkly4Ovy6WPYlmEf7ms48zs4nHawjknMvwCyDDPDZ+5z?=
 =?us-ascii?Q?qLZZ5JpgFHypjnvfqjB7FmrvTDN/4c4JF3sqzwxnRACBOTlZLVLzBl+yth6j?=
 =?us-ascii?Q?WJpdWPIXLuBp3nHu9bWNFPKABYSIO543fsng9I9yrB5PasT/fX6oNPRQUy8B?=
 =?us-ascii?Q?RmGPGTwQAmZajelfBjAFQuR+fFfDz5jbFTZko4K3I9WhOUewW+28eFnaVFKq?=
 =?us-ascii?Q?7vSnpYGmG6Pn7Nf6Hhy2ak4V1Q/HA6VRhq+evr6yV2mf6M++9WPvMDK3GFGv?=
 =?us-ascii?Q?W2HTGiSEbxxfUpGO15TTtn4Ij0fkdlWPGbqNfPwRIVM+9JH1+VZeIMBvp0Vl?=
 =?us-ascii?Q?PhQ0QSf5UzjklCC3KeiDyQW43BZGqdHKovts5yl+KVgE9Ujae2nDzmcHZSZX?=
 =?us-ascii?Q?Q/zCg3mrcUnT5LKKo+fFcoXSIYY7k64QRRFDAUrfK98s0VKlw184rhmjZmtH?=
 =?us-ascii?Q?9cBOr6eTdIW+JQavB66wCVc8YfsBZb3DT0WWUywEoqQwEt65SElwtOxJ7kf+?=
 =?us-ascii?Q?g1uYMrtY2Fyi2Me62Jt7kXhtFmcFqvi1+KHc9iUacrwOUFE2dk9lS77UjyC+?=
 =?us-ascii?Q?H5WEsFJlM6MsxC3uY4vyaL3YrnIo3FA06yc1Dp5CO4/7Q3VPbDfWLoIEm+dw?=
 =?us-ascii?Q?SFjDhF8QiCTlWFmSu9GdhJ8IY/v3HOFRb1QWW+L2Y70jV4oF8DtdPazbgYTs?=
 =?us-ascii?Q?DHh2/vzk+7kfIv4RqAsDz/Ch2QIl32GyCW2OhhOOIsSpzVGMlanm7z99cZRC?=
 =?us-ascii?Q?mD2U/HSqoaWFDPd/rNj4cTg4y4V21YeVz0OvlGzB1W0MEp62u1N+fuC0DEj7?=
 =?us-ascii?Q?IFke6LFZRzhV5ms+sE2zB0ZfbWsziIkB2I5YKzvXTwz+vmEU56c3ujXhATpY?=
 =?us-ascii?Q?JgsKiNWbGh5Zopv7Lml+F5SLbwtxJDPifHFOHl8zdUcaIuZq4BBUlv8aCglq?=
 =?us-ascii?Q?lV2/ozZRIe0Koa8BCvII3yI8VsaSuemyYzsCVfP5Vn6Lf78sSoVMfJSY+fvy?=
 =?us-ascii?Q?QC506GLe5HAwcxYlXQaUv1sV+3cv56J0tU75Mo6fpxC27J09dA709uTOufE1?=
 =?us-ascii?Q?7LvXDVKRZu7sUhk7yXqfWfUhnlDTQY870S0WXfezEN/Oh6qap6V92h+PRKCn?=
 =?us-ascii?Q?Ae5DvJPcrQynz+BdpCpqiIhrYu7qfNOpRYo2LSMnioz/h4Qt2wUwf8URpLdN?=
 =?us-ascii?Q?vSy+cnuMJIvOB2nqSOMMfCys?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b8f7329-d665-4633-d001-08d8fdab2b5e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 12:04:48.2853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N3lOZFjLwKYzi9vHevVC2LyUAlrHgqFaQ6KlSw70HEMEeH/g2K1Bq4Hpkxg0VwmD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3308
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Apr 09, 2021 at 05:50:01PM -0500, Bob Pearson wrote:
> The tests in tests/test_rdmacm.py for rxe are failing because they
> are not able to compute an IP address for the rxe ports.
> 
> The python code depends on having the directory
> /sys/class/infiniband/<IB_DEVICE>/device/net present. But rxe does
> not have this directory. 

Oh this is a mistake the tests need to the use APIs to get this
information not muck about in sysfs.

> I can figure out how to add another way for the python code to find
> the netdev for rxe.

Yes. netlink and the gid table reports the netdev for all rdma
devices, that is what the tests should be using.

Call ibv_query_gid_table(), put every ndev_ifindex in a set, then that
set is the list of every netdev index affiliated with the rdma device.

if_indextoname() will convert to a string name

Jason
