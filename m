Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B93149FA1C
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jan 2022 13:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347994AbiA1MxY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Jan 2022 07:53:24 -0500
Received: from mail-bn7nam10on2076.outbound.protection.outlook.com ([40.107.92.76]:57952
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348660AbiA1MxV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 28 Jan 2022 07:53:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VNCWY5rqrkSGZ4Z8VqGxic/0unWZCglbYVpIJYzlAJ41NUkuIfkA1A2vF/X/57KcFYvGSzoYShxALZhIXFE7kg73voY2wljvx1s2bPMO/IomV5FI71ql+2L1TVajm78YoStMQhRyEGGjXyPztdl1V0knM+wnIn74tVhImHd5l8vkQXsbh/f6DUDGQcD0lORrdd86R7994zZNf0rO4vKKVVEVvIe4ImSyBWwP9Px8BndDeLv6i7TtAHBm/idcwPRmQM5V8P9B+kf8Vds4TYYkE8aLyAyvfSGDl4zfqvdBS7vihcn0e07wJAb2z3P/J7pSmyAO2SpA0phbDRWEiEEWEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Up4/M3ph54ZXQANNipmRTJD8scDFpxsa2onMPer+MRk=;
 b=Ve0qBUXb8dkcneZOnetNi3Q6hNDAtKuausGFq961wZYTItlpfKq4mxzjzec/7gSfLZ5tK18E1BsW0XATYk0+V4EDMLj805EHAcca3LxsqFASQXfcfIDH+LJulTiw09qwyEc6hUCZ1ZPdCk25ymP7DorlMk5hh+EZ/ZvJ8WURjhsF3rE9ZK8S2c0J45uIOpnAHCnfpxakW3eAFr5sp0YVqlXZvk0iJF5GvZpi7X8aklS8nelqZKLc4wWRAk925XS06gJd811/hW40GEdk64DS1LUJY77NUXeJmNvvqCZlef6IUT8Mfnqm+jFqdM2RrdRqtARuY4xqpVaq9HCy0AsvEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Up4/M3ph54ZXQANNipmRTJD8scDFpxsa2onMPer+MRk=;
 b=ReDtab+a29/WUwY6uKhTrr/krP2HRFNLCJ3HS8vBSTJbgX5xRPp9fLeso1gT7tCwZ8DZWgmYjH+ER1jtuUIbtqziFlCGjhAsLQyj2WEV9OetCmXcxJ59L0tG7aoz9+4WX8i14yLjeF596gww3UW6j2LP7nOj9KiskPGqo2P9pRYtQIIooDpgkcl0gZuW1nBwaIdPemC0A8YNNm6KjerA9iYN0K4WpTbDDyVMgoLRylfUwt4tNa0ewKyDL/YVk/7vPSsrcTEMjhN//DXRdkxOtx75iulPNdUfBithpBSCX2OAC1SB3BCAGFGGq92HmWAkYGPp7yfsh2QzfaeWLbpX1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CH2PR12MB4327.namprd12.prod.outlook.com (2603:10b6:610:7d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Fri, 28 Jan
 2022 12:53:20 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4930.020; Fri, 28 Jan 2022
 12:53:20 +0000
Date:   Fri, 28 Jan 2022 08:53:19 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [RFC PATCH v9 04/26] RDMA/rxe: Enforce IBA o10-2.2.3
Message-ID: <20220128125319.GC84788@nvidia.com>
References: <20220127213755.31697-1-rpearsonhpe@gmail.com>
 <20220127213755.31697-5-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127213755.31697-5-rpearsonhpe@gmail.com>
X-ClientProxiedBy: MN2PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:208:c0::36) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8446502d-f329-49b0-a371-08d9e25d293a
X-MS-TrafficTypeDiagnostic: CH2PR12MB4327:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB43279A74C1CDA060B308236DC2229@CH2PR12MB4327.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: smZh1z5ZQs6V04w/85Ngkj8EL+cAAVsyUtn0Refi7VNAuABYNaMg44IE2VedEnvVHrhARq2cGohrJapAl8m1TXjF0COdxCpMX7U+rD5MI60TQ3w5N7QVBAn5xQVbJNGfbCBQc9bcjKGVgzEuU7EaWGnvNJ8BlaQyFDmVJm4RO8W0LKJx+eEV1ycr8PI8KWKpNJnMXLqy8tM0SMYTTw5VUGUZVnzdRP08rII8mraLSRQ3UQJcPLIHJsPbTMBcuvzdKIzFLtjbQuAlbvYCNw/GALNwZSVvhwBzzQNWE5GeoFyTajWvdmdjiNSggxA4QzA5bz17KlCh8c1DNH0EDwwudOCmw3uAMA3MkcxbWpWo+l6K2Ar2tVGzqaPE3PODfmdt69wku1t4CjVFjeMhZNR2UGFSS9u7l7rCygVfINvQytX6x7/zBJwsDT5ooMxpV//eS1mkDpxNzQyQgJToLRW+gVsZY0pUzK4+PDNMQUOE8So6t8rkDk9Fzrpz/ftVv4IkZzoieHu52BoSHOL6Okfj9x1/dreD0XRiDKY1Ueqw2CPPGAwahgO6md8KxbxMkPKyQ2Qx4CiTXCLgYJTjJESjUVdB+EzDuyHMriCkrJGauB5NICeyL3mJ9I1arkza8Jnn5RsXOuWp/sPYE0FEzZV9PQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6916009)(38100700002)(5660300002)(66556008)(66476007)(66946007)(33656002)(2906002)(6512007)(1076003)(8936002)(8676002)(4326008)(83380400001)(6486002)(508600001)(86362001)(316002)(2616005)(186003)(26005)(36756003)(6506007)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lRIoB14uOuHoNYh6/cyKWfgthYdjzoQaONKGagCYHz6eu5s4NIBMsbHG1Ty6?=
 =?us-ascii?Q?wHYwKB1X8J1urPywPkH0hkfE7iUpb3nrQzmkA606sH0kgLUKxaDxcLKfkKFE?=
 =?us-ascii?Q?FiG6DLQDVDmOEgZrgjmU1DlEiG7e7VWKAowna17KCsL4bFkCzOFE4CjnWvuX?=
 =?us-ascii?Q?tG0LbNtDDWeITQyuG8iKBKCmevRUfwNe0dRItgNq2IkqB+W+nz42RiSxsZNO?=
 =?us-ascii?Q?XcZA/khKvm1MVBHBXSgcu52zLiKiUlgeLcZO82FiimoPrSvhudwP2xUSHIiR?=
 =?us-ascii?Q?UqHpUhaOhnWYPEwj3ZpaBAqBRszFFrXQ0mDNu9GCHwpPcpwfszjm767P3iVr?=
 =?us-ascii?Q?9q82iYBgmjQ+RBDFvKX1WsTpcN9C1QqYiDD146HQaxw3o6cH4X9clN78VQdQ?=
 =?us-ascii?Q?XW55l5ARJm6rfjyQAcbvb87vYggs/e/jQ6nTE08opkanQ5B/mYyq98e1DAeS?=
 =?us-ascii?Q?PVHKoLstUeLzA4gX0hn+pBHu5BvWwQ5K+WJAa0mxhv7plZFmp36/UCsAKrlm?=
 =?us-ascii?Q?tQ2XKR0oeStKDPUIw3SJPBFBePOncrBl77VuWITYFD4NjqjB/XjoMyYDRIed?=
 =?us-ascii?Q?7GHYIQUh4YtnSi+lANCF8BzIcS0DbcZfMqLq054zSdDBgWW1ikLfOmfF5CSz?=
 =?us-ascii?Q?fJvEIxgiSXz41fwhb7kVij41Ngf+wimOC2iTXfKfWGiKf7QTho6MBwsYjY8q?=
 =?us-ascii?Q?l41nI31JF+Z8k7QlGTXC5YzcbasjBRzhI/n/LE9TlzRSSkn4zUcvQTc12GWM?=
 =?us-ascii?Q?LrtnsGNoAjn5AghQw7vqG+egrg0M5up+MOV4RmgDs7KaYyf23oFchHUcsb7K?=
 =?us-ascii?Q?6AWX8yy7j2iOOd+/HrlYJqKkAV8Ns/gqNsm9vijaA0x9TIbjqSFciQ9uLZxO?=
 =?us-ascii?Q?le2N3MdRdy9hzL+FnnAsvjj489I87WPrX3MwkRUQJixpP+7DbfIt1XKEvWed?=
 =?us-ascii?Q?bwmx6asr31Mxh7tQDTf4m4KO5sJUE9aptegVmVCVYAm+uWbLy3wyovtWr3HC?=
 =?us-ascii?Q?B5BrpUQSgLGTouEeQt49ElQQnT65LzX6CD3ftLzVcZLs/gDySfch8VqyoCbe?=
 =?us-ascii?Q?y18i5wJLRMDAzmL0TAqKL7LOCLkbZReKsQmRSn0fBujxpyJZf2pX38eHDjGy?=
 =?us-ascii?Q?kWzAGqPDwOske7URQDaAgpvJ0cJ7RauZN7tsLc6AKhPYWCnFa+iOcCXNHJzQ?=
 =?us-ascii?Q?wavw4GYfj0vJjM0GOOg4/BeLrv7jga+XPB9qvHNJp3BTv9KBpcgX0O2LfCLp?=
 =?us-ascii?Q?gO0K3aKRzFgwnjga/BFh9ocacnYNK0jrJSEPRyteykA4JWhL0lnnf46SGZDK?=
 =?us-ascii?Q?d98BBI6guDrYXCG3TyzpSZnn7AYnzU5sCXGC5qPf+YrazyS4vq2tpuhVva8L?=
 =?us-ascii?Q?uwi7QPFv8P2+R1OQhq1Ff8QvhC2bYA0QpeGpt+LAqu1fmB8IEfDvyd334WEL?=
 =?us-ascii?Q?qLvETNL1CtUyJi31aU0811uFoyrYUy66iPK3M6QraUGjUcHvkXb7gvJbvwNX?=
 =?us-ascii?Q?DIZsuu8+nmZ5p9nM/ANspOulMK+zLNofuEt3XRP4js5+RgRcN8uwqSjFp8JT?=
 =?us-ascii?Q?5U20NcoLxB9GdgHIsz4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8446502d-f329-49b0-a371-08d9e25d293a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 12:53:20.4461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X4HIRgEkVmNBthJsJgx9XgTfR5IYsttMmCBznC2UZKqHywyl76jV5lhlx00pegh3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4327
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 27, 2022 at 03:37:33PM -0600, Bob Pearson wrote:
> Add code to check if a QP is attached to one or more multicast groups
> when destroy_qp is called and return an error if so.

The core code already does some of this anyhow..

> diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
> index 949784198d80..34e3c52f0b72 100644
> +++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
> @@ -114,6 +114,7 @@ static int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
>  	grp->num_qp++;
>  	elem->qp = qp;
>  	elem->grp = grp;
> +	atomic_inc(&qp->mcg_num);

eg what prevents qp from being concurrently destroyed here?

The core code because it doesn't allow a multicast group to be added
concurrently with destruction of a QP.

> +int rxe_qp_chk_destroy(struct rxe_qp *qp)
> +{
> +	/* See IBA o10-2.2.3
> +	 * An attempt to destroy a QP while attached to a mcast group
> +	 * will fail immediately.
> +	 */
> +	if (atomic_read(&qp->mcg_num)) {
> +		pr_warn_once("Attempt to destroy QP while attached to multicast group\n");
> +		return -EBUSY;

Don't print

But yes, I think drivers are expected to do this, though most likely
this is already happening for other reasons and this is mearly
protective against bugs.

Jason
