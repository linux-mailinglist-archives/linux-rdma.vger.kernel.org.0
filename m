Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADCAC485CA3
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jan 2022 00:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245565AbiAEXzR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jan 2022 18:55:17 -0500
Received: from mail-co1nam11on2068.outbound.protection.outlook.com ([40.107.220.68]:24001
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S245676AbiAEXx7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 5 Jan 2022 18:53:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hdXXsZlx1Ron4/b7rUPPa0wDln07Hk3FU80dOvt1VEIPosrGTr0JqjbwrnEHmyfwSaC576ILhTAl/V8ZevihruFmK6wBf4H+n+0zLkWJiqKxeZr7lCc7hoZkbUzj0YRf1YcXSIBasuuxD82eUbSrkSsr+vje1HQby+R+9nY226Ds2B5RBU9tuLaNOQXayxTFb/inoDoUkl5ad7cb3CUsM3LzjBWWU8W6XHwTFYhN3rIYpxzIBqnJnGaIUtPFGyghLSfrYhYc5oBLVU1xyNvIT2p1d4+7IUK0zUqtoh5E+jL+XDIVSNzqXJi0eNLfKMml/XlcfPb2qYcLyqPgmoIuPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/4q+8/721T3jsE8nyyNKrkIF5LBzUBiwHIOCLwRN38=;
 b=HC2uht6qyyVYoAmIRMy9KSUA2beVRNxtRlb1gItjvCwwN/I8ptCUZMF2HZONIrmKcV+LJlz/pFfMA8XOfmHCQgLRXSgOtT9iowx3fViJntXlKBx2Jh1FE1j0uT5GIL8mUPH1QEatG5+c4XD/AFg+ug8OdTvDr+7cNrfieDunHLe3urwoNHpIAxcXO6Rj5iYFAhdEKW54K9LjQ79UJeqvJr8LO9FLnoIsXonbhdN1NDfXAtokWMlvSLtXTCLyuqF2JO4m6blNejMTj5MLlylTcDsBSF9lAkN7yRMUIMcuGee+4NgDLeX3E5xyaqDGNPk0zFzSdQJwg1QLGk7+dw4+Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/4q+8/721T3jsE8nyyNKrkIF5LBzUBiwHIOCLwRN38=;
 b=EUOObGmP7IKoliHfVy3rWAzwvcfoXDjtrbGe8ld4Upl+uIPCDb2pLqquvxxLGUAs5ZkSTfwTW/1ln8WLLjPm6ie/NkUBHRdHbH7xLJGPp8r9CkwtXkteAvJFmJytE6EhGGGe/pJT5Nodyrr606YveQekdPqZi3lKBmlMr8SWURWljqKpGKfUtg9oAs/y943kXolJN99cIDpjWDwqE7xNvyo3RzH32w+NNQBzpqvf7F5rfVY+aRUXkOtlsu2lTmOqXV1DvO+Q5QNOmpFD2WoMU0hdJeaW/p98HOWl6VqjszAZpvMUgoiJ0UXRxAz7QKHK1dbYWTNIFOilzxKL/Mhu3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5350.namprd12.prod.outlook.com (2603:10b6:208:31d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Wed, 5 Jan
 2022 23:53:57 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af%5]) with mapi id 15.20.4867.009; Wed, 5 Jan 2022
 23:53:57 +0000
Date:   Wed, 5 Jan 2022 19:53:54 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tom Talpey <tom@talpey.com>
Cc:     Xiao Yang <yangx.jy@fujitsu.com>, linux-rdma@vger.kernel.org,
        yanjun.zhu@linux.dev, rpearsonhpe@gmail.com, y-goto@fujitsu.com,
        lizhijian@fujitsu.com, tomasz.gromadzki@intel.com
Subject: Re: [RFC PATCH 2/2] RDMA/rxe: Add RDMA Atomic Write operation
Message-ID: <20220105235354.GV2328285@nvidia.com>
References: <20211230121423.1919550-1-yangx.jy@fujitsu.com>
 <20211230121423.1919550-3-yangx.jy@fujitsu.com>
 <b5860ad7-5d5a-76ba-a18e-da90e8652b08@talpey.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5860ad7-5d5a-76ba-a18e-da90e8652b08@talpey.com>
X-ClientProxiedBy: SJ0PR03CA0286.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::21) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6eae1bd8-a3f3-49d6-9503-08d9d0a6a313
X-MS-TrafficTypeDiagnostic: BL1PR12MB5350:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5350FD4008F3A32ED1C734F9C24B9@BL1PR12MB5350.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XMG+wPkO1Jnh1Ac5Fy7pxv2Jw5Fj/ybbLWtzyO1bgahuCILS861QyMNdsHG5ToXJMw+s7R5W3cme1Cw/KpL/FLeB35w0HYe4nGcX3yEfdC9xraoFYeXaL+L6z44Csh6wK5WYWI3NreYGP8IRcw7G6KDhEdGUXukWzZ2pZbjBT8tYg+nFtfijs1Gb15FTA5aGQniMqM0KV7W56O+OPL+ZxLDifongseZ9p3gK3iz2bfEJtf9wwPD/qAtEhev8TrHsbaSAY7UAUBPWouJzX2Arp3qOArIg/Y8aczHKU3MwIprnwLw1TJME9SgVOUTmmcDHhwzgonpWDqCFAI5r5zaFZnXJJMmiBXsFgWesiV3IvU0+sZHAQjxYJTRcvkwoA+q2NxS7lfkkLY5b9MTNt55/ivXJ643sIwd3zpvKerTtzaGMQFvFWLYXEM/1BfxHLQa1hr/lqFPW/Z/O277AlHGuxfNBPUEaAH7AK3SosGOv8FchP1ZVCYSbSglrqoXfwayz2t3flIv0xySOPcK/4yPVHiK1qqAKzyJxl9OIzbBBojwnAFrvGiNBwZFHiHdzJkqG5aICOsVIrMGB7ZisOx8jeHBi8QAjt/3NvBcYTh5IFmjpbRTl33PwfZg9RlB6nesLb/5Ne0pNoK5YfrDDvl5uHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(508600001)(6666004)(186003)(4326008)(5660300002)(2616005)(6486002)(2906002)(6512007)(86362001)(4744005)(6506007)(36756003)(8936002)(6916009)(66476007)(1076003)(66556008)(66946007)(316002)(38100700002)(26005)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?11GSoqy1I33hi+1RDTEBUnqfk3yn+vtBF7kxWDe3SBAYaypK/X35jWTxmwsL?=
 =?us-ascii?Q?2feIGWg/pj7Xibfqn1TKfJY/5pxLINjC6zRwNzGi/pepC10TTA7wyufC2CUL?=
 =?us-ascii?Q?/j5GXrtqAnpMq0e45Cuza78pQbUDhkkW5W8H0K5NZOyLzQx+9saEDJpFZEnU?=
 =?us-ascii?Q?IBwlZa5WQKoikgrUxTx6rncRC9ldW2/2yA55KMdLa9yalFWO8ZFSDsWN2zQO?=
 =?us-ascii?Q?by49rCt0xrsLL1mpF37KJUCMJ6nzzpZ1qQstjeAi4svKhNFvpDkY0hdbg8HZ?=
 =?us-ascii?Q?H5Wcw7ZlQpeY87KQPW3ayeeFCFSv8T4O6DKimKxomHDLsQY7I9yHE54DbRNY?=
 =?us-ascii?Q?X3QehK6gS98+BvC0n1dysSN6Svi5+AgjyPrCi5aNmSkMnSSs3egN75dh21uQ?=
 =?us-ascii?Q?GAxgjuG9D56gsEyIpYNK8YdoKSDm/z7RBvrOzzyQDJPP9d/D4KSkf/4fjSxq?=
 =?us-ascii?Q?9F558/j/SixT0GLMl6/z8Y4YmDzVJO+BmyumH+3m2Kr9vlqdFqaU4WSypbnQ?=
 =?us-ascii?Q?2hhffTJsYllouVeVGr5JpqpPzbyK9dTZtYMo97AzgMD32wTK0McH3IaR64Yv?=
 =?us-ascii?Q?i66f/dHrbLAwm86vLle8HiMNXn2+m0tMpNqOCP6YRgEct3oMeUU+HYsXBB0n?=
 =?us-ascii?Q?6/mUU5lrDEuXZZc0TLodfh7heefwLHtjVnI86/3XQETFuQN/GLAPQXmFalL4?=
 =?us-ascii?Q?IRQ/f/UVRG2dr4iW2dRy4FFJrl9+SX7ZUq1xMLcMevXpAt5TdS/QvEJzuiQc?=
 =?us-ascii?Q?D1XGy3Hxxn9UaiNg3kNB1w3n9WZKxmNNshT/4bTAXrB7gpp2pDaxK314AMVB?=
 =?us-ascii?Q?qPxvHE89mBYChfO9L8h3oR57HdAi1UcS8R+6a0CZOBZuaSir1U79PxPeLhmT?=
 =?us-ascii?Q?QqOihXSbycSounInkJ9AvmReZbqB4SMxXmVzuJxY5oJzzYi2kKaQvfiMKnD8?=
 =?us-ascii?Q?GyeNoOL5lKneTs24u+M9+k/sEiq7IrIIJ8KjKtjg0SQY7M/N+M4bcb4MXTB9?=
 =?us-ascii?Q?Mzd8VRcc6N8m93GbGokJcaxe0nQ9O/CWOTgkUcQJQJ4+MOYWYPLtDrjt2s7w?=
 =?us-ascii?Q?yQN/5bGnsVZWC8ySYTDYcZjK9OjzFykh53UtG0LPQBRXVmysIVLpx0aDrArC?=
 =?us-ascii?Q?tvZA6OkA1iDIaICvRbZ7uIICV8xBHrLMQcHXSHprCtrIqnD4R1tdYzZpdA22?=
 =?us-ascii?Q?lznzcCzFUohjB0JG38QP2TM08irwKcqhr7IK+rEF6ci1SEjy3WSru4lAKfOt?=
 =?us-ascii?Q?bIF4LKcHUAsXlnS/5lvmB1n979R/eETtIdnFI1iSjfhj9MCy7ZHF8FRRerxn?=
 =?us-ascii?Q?k5EYUFrJD8Jighx/cMm9HbtFNvhG3Fx1EzoPY13OgEGd6GAirgN31N1k2pOg?=
 =?us-ascii?Q?Whb2a05VUPLyA+d777nxsAzxxweaKS6g9vXQaOwrYoOboWU7OsJK+atN2pRp?=
 =?us-ascii?Q?llMtzFcH+CdmBoB7/3YDEwrDmvDeUrEkESxEodfZc58tubQqV8zajBRvba3a?=
 =?us-ascii?Q?gzC2WuHQr4Hzd14RG236P4eIi5xApQ7i5jMvaRkgV4iFHSDdQROlC5tUqtqH?=
 =?us-ascii?Q?OwPqQ1mruhhm/tAQrbs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eae1bd8-a3f3-49d6-9503-08d9d0a6a313
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 23:53:57.1722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eSNQOlGq+7NTPnlNR3UwiOLv6zEj5Kvxmg8lwAVPAM8dJvsTq5Tn88o0cdr5wKVM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5350
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 30, 2021 at 04:39:01PM -0500, Tom Talpey wrote:

> Because RXE is a software provider, I believe the most natural approach
> here is to use an atomic64_set(dst, *src).

A smp_store_release() is most likely sufficient.

The spec word 'atomic' is pretty confusing. What it is asking for, in
the modern memory model vernacular, is 'write once' for the entire
payload and 'release' to only be observable after other stores made by
the same QP.

'release' semantics will depend on the CPU complex having a release
dependency chain throughout all CPUs that completed any prior response
on the QP. It looks like this is achieved through tasklet scheduling..

Jason
