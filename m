Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 135DD394924
	for <lists+linux-rdma@lfdr.de>; Sat, 29 May 2021 01:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbhE1XgO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 May 2021 19:36:14 -0400
Received: from mail-dm6nam12on2072.outbound.protection.outlook.com ([40.107.243.72]:41024
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229500AbhE1XgN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 28 May 2021 19:36:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SkkmYffu3OsyGuC3xT2vnYs3MPIOEueOpQJl2kWRLjpijx6GsPNWiXZqvbagpYJ7pb8RAoSTUbNWoKMuzgTuJ03f5V8P3qQdsxUkiIhUHN/ZaORLBpSIwPGqbUgVosX3kHrFHbfrqk23Yy/2koouWx7Uojq5pHuw+OihagxNCplWjJaiJurjcF8PcMC4gUOHLUD2iNr9tOvZf+rsYAsplm880i8hQG9fnSQvX9ADIE1Cpf1oF2aYNgUza8CobejZv12Q4NznCaYHdBzvPdUVyKGFSVrT/2v5fcWc2fRkhr1sTxHB41pWU4+dy/YRZuQ9CLyKziBOP/JUe+H7/fQkMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8z5zBQpZQXBLhm9/tHA2KnUuYFv2mdKMFKeVwP3X2U=;
 b=EWeX3pftZ7W5XlBecqnrP78IhqdBJr5ZD+1/+evISNVCKsrVqQ43IZx2Kyf+axOZDjxZtLbyF3hEYq0g2DGkIi373m40hWA8DeSNMgkY9qjutnEm2tPX5l89RXMVFWlUdVCY1fGeHgAP2o/4lOKFhlZLTr1epMzSP9gbGZpc1fhheqosgBcSNPBP/FDNwoIFXoFwRRXn+OfbDScVhXDVt4CwdAtzE7ee5oY51Gdn/Hu0XG400Vpzo0zHM9id3SuNDHNignUsnbpLvb50HC4byfIijl9sm6vG0O8i2UpzTqBqWDV40D0S+YAah5T1ie74Vd4F2Bf1t9C+q5S8cLB0YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8z5zBQpZQXBLhm9/tHA2KnUuYFv2mdKMFKeVwP3X2U=;
 b=bf8pxbjDkT4mUt+t4/yhUsssLj80YSp+R0g7jwIEirPgH+hjLjumppdSUg5x7lIcCfvUWLY/EY0m0HuDEn2L/dJHnxorpqPbj8r1sMzURxImZw5AF155v90vin0zpl9RsaDy2V79FCUEdIYA13R/AZMe0juREhL0ev/X+OHjJnze8w/XNC93gt0jqQhMYIvyT9m50acu8+/Cli1UP99rF/7VS4dyAVLxVAQhwYy8Yy3D0bmbRdj70DKMyqvh99OXN83Sod7j2gf0DSXLsWN7faCElIhiLn54PGttsqpBYy3U9Gr7jdB8vsrOvHKzXIqt26ciR/Z9SaxchLOIDIB28w==
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5379.namprd12.prod.outlook.com (2603:10b6:208:317::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Fri, 28 May
 2021 23:34:37 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4173.023; Fri, 28 May 2021
 23:34:36 +0000
Date:   Fri, 28 May 2021 20:34:35 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     sagi@grimberg.me, linux-rdma@vger.kernel.org, israelr@nvidia.com,
        alaa@nvidia.com
Subject: Re: [PATCH 1/1] IB/isert: set rdma cm afonly flag
Message-ID: <20210528233435.GA3862344@nvidia.com>
References: <20210524085225.29064-1-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210524085225.29064-1-mgurtovoy@nvidia.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR17CA0027.namprd17.prod.outlook.com
 (2603:10b6:208:15e::40) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR17CA0027.namprd17.prod.outlook.com (2603:10b6:208:15e::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Fri, 28 May 2021 23:34:36 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lmlzv-00GCnR-Kg; Fri, 28 May 2021 20:34:35 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e21bea4d-35aa-4fab-d2bb-08d9223127c1
X-MS-TrafficTypeDiagnostic: BL1PR12MB5379:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB53792D6A5807E10D68A93F9AC2229@BL1PR12MB5379.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LxQWXA1vbXXNSDfAwaqN1Z3oaRx11XIUGXRHJNZ+6JpmQraoNqTl9nuviW7fauMVJL0tU0ryLH6L17rMhTT7QKQFFEJeJ2msLYmncPCYg/l3aLoX2vIunw2M1uEfoe+I4UYr6YX83yG9+WBDvtb2WBAetthGxLHsFrQcR42zqgCv7Tfl5HnqGbgZtUkrIajAg0EOn6UF2uJf1AEZKTM5mNeI5u5PzC5lRIp6DTEsrpNp61vZGhc73ntecsbBaCVrrg04HsSI83UHpWX0VHn2S1Z9NoaHr1knec8xecDiRyRX9/wEfpEbTLlEGHMXUR5AuSADIYodBOsXg3NMkka0khw8nlTRxGVrbOQ94ruG8/j9pNzPwz2tQ6r3x9hDfw9/p9AfnHZK+5U7mphlRfUgKgElbO53EeikWJiiTn64zVIAKZRyyGMkXAm309uGfW3xmKivtDtoJnc7/xowLXV9W6XI5IMNQ/l/Wt6/MVEElLUIaqjGq8/AWfQGOukzKvTRgZq1z2lI0mAlScgowLrzrPKTcwSgfdWjefOgXBN0/2FKcJQCD7ZMPGAfyvI7a/v0kMn91N/solWdkuWnFesqhdc3baZhqNXRSxmpzYtL3eQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39860400002)(136003)(396003)(376002)(107886003)(2906002)(6636002)(4326008)(38100700002)(33656002)(6862004)(36756003)(66476007)(66556008)(5660300002)(66946007)(186003)(426003)(9746002)(4744005)(9786002)(37006003)(86362001)(2616005)(8936002)(1076003)(8676002)(26005)(478600001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?m+ua7K2SqC5PE+qwy7+tZr4mstkqIOmXrEqKQ/rtcnzJvZ5IrcWiNH6cB/jZ?=
 =?us-ascii?Q?ts4wTfGd8ALnLblDpBiQDqmUwU+N6lS9onqph3ILH96veFEjvl7kKcLbu89o?=
 =?us-ascii?Q?ZtiZi3N4Ep3Tp6NIZqrUUuzHOqN7ZrpR5eJLWAn2ULDEOEHRCMx6NfUBkRNw?=
 =?us-ascii?Q?n8vv0R1NTwip0pBISSe6EJ05q6CTa62MJMDkhQO/Ks+oQzQNOkzd6Jf8+dtz?=
 =?us-ascii?Q?3TKFJ4/kuEynX4RvBGKvsb6AhVuUVZFE1TFwz4VNaopumMgIGmhU+3E/DU+N?=
 =?us-ascii?Q?x4GM94jfHALgcHR7eJt8rFvJeyNpmhQdkG95NsrVMYONF5e/Wc+vFIW/g3f2?=
 =?us-ascii?Q?7djiE8aU9zJzzsxRC5wsdbdx6kP+wXnrfFfdMq77QiSAzxhEPUwVkfvrMvoG?=
 =?us-ascii?Q?FG6U62zYa+JbiupSLGyHfYyBQDaLjUcvVCx6AkAwakqpEfFkcAsJPRMSmDBR?=
 =?us-ascii?Q?Dw21BfZtL56ivesmbvBi1KCjX5uJLFrIlTWNq5V/8yOXKivO0JRQ+7Gssu7+?=
 =?us-ascii?Q?RjMqBLRASUfkvP+hgZ3t15iiW8jJLIq8+3+Pl/W1XGiCftctFYs8CBN/OUEt?=
 =?us-ascii?Q?s7B7GfcyA8A7yP8cxOtZhdRFqi8atj/o5QRDxUfWEkAk8X7V0slCF8G6mb5z?=
 =?us-ascii?Q?FmFmvlMQ4Tm0AppHbg52uPVqD2UBjGLMW5umhpUEY6DaY+QRksg6Kctm2ojQ?=
 =?us-ascii?Q?o11bK47oHyeEu3/8EbSsUlzeEGfC0x4CJZn31iB6e8yTeroJQUybFbKuTmNo?=
 =?us-ascii?Q?IFiZvWexz4NbW8seUd6hL7S3l5dWNi+0sAZuX1xxbm0tDiLtGoJ6By2eKYC5?=
 =?us-ascii?Q?s9wYPM/JiftcACcaPa3V8DQjtot6eZovER9YCM2Ef+aiv87mu8BkW6gJZNUO?=
 =?us-ascii?Q?akgKMfyhzxZ1HtIMDqXvt7cMqP6uoWJRkqQ0ZQ73suVhEhswSYVEtmx8lpoQ?=
 =?us-ascii?Q?64yuviNvUPsCcSUlqU6e8C5b//5ReXlaA97Q82VQiOkhlIccrcn9Wzjd/V+9?=
 =?us-ascii?Q?lJV+aShAoTdnK8K9X7sQf/z7Ll03lyGt9E8WNJ92eGCFXMuiXPgDqHYPvfig?=
 =?us-ascii?Q?InNs1QeRwyJB9cA2fxjep/2NYkLMcSlbjO6kjwzIIrLjH+v/5Tdkq6/FLznd?=
 =?us-ascii?Q?a/7wbbc8VAqUSHR24ry7OkVkMucD+GiKEP8cWTnZBmovPJAzIUscE9dCBETy?=
 =?us-ascii?Q?K8ckFvRkkrUINr8VJNAvPw8Hdk+IooJqndYTfP/EjxYvzh5hdL/wXGs5OsqO?=
 =?us-ascii?Q?NEsGwxz8kfEi+U26MhhSiDEFfRbG6Hu2vlhBCnkCh65ujDSTWKS3YhmpQDOv?=
 =?us-ascii?Q?eiaFnYCyot6TltE294ehzza+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e21bea4d-35aa-4fab-d2bb-08d9223127c1
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 23:34:36.6894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pU64KUwd3C/DG7msxf1UXZQ8UoitvZCrer0i7gQY62nnMg8d8GsqphCgVwl81wgi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5379
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 24, 2021 at 11:52:25AM +0300, Max Gurtovoy wrote:
> This will allow both IPv4 and IPv6 sockets to bind a single port at the
> same time. Same behaviour is implemented in NVMe/RDMA target.
> 
> Reviewed-by: Alaa Hleihel <alaa@nvidia.com>
> Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  drivers/infiniband/ulp/isert/ib_isert.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Applied to for-next, thanks

Jason
