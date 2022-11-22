Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534A46344DA
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Nov 2022 20:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbiKVTt5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Nov 2022 14:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232993AbiKVTt4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Nov 2022 14:49:56 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AED57B78
        for <linux-rdma@vger.kernel.org>; Tue, 22 Nov 2022 11:49:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yiligckq/pVPWvljXERIZrVyZa3EcdseliA/ET20eWwrJJE+O1Rf1jdkZLLtPR9xprWJpg8rkEDTbmUXQ7Rzy3zXd7dgelP1gHgg9trgYXa170mRbLypNVA74Hl95TsYajYZz/PkPw+pews45OM6y0kO8EiMqGz3ln5C6I7zzY+YjPysLaJlATkrzJ2Oq5GwV219lQA1Qp0PbH+bCw7p5fKwyzd8NFL6uO5k4Taypsv0R/0Gsvg8ahjM+FddEYRI3gIN18MyxIP6VR6andqQJDZiYtehMYeJHfVP5zie07aDc9Gu4t6kLibetdbZnXFd7xJBRx4hr+yY8qjvzpcPug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3z3k86orJEEVtWawgR2SQeqS6pOfAuULCVVKxpS44Kg=;
 b=A4MIZn5kaaM6VVgrDOnzKww5E2oAo2buEusjVHrtT0xyxDCS4vqme60C68mW1e23Ucv7jN3OjcNshMfqWAR/5IVkg4VQfoaWCn6ntGU+FCLh4QVvoqD0fLPzX47ITrkUftt/mGyEPP2HcIvdL1rLWE1EdnuLyFGI2NnwpKme7UFcuOdGsNL4cCOG+cW+VuV4o6uIr4Uo6ZQq4TuTuIRQoDGD85JPfkGV/h65c2s4Ygx/svCDKS+PTUUZMZCQfHrQS/QrfrgR51+QBRGdRmWbcsjNgmZfh3UAcDSRM1KvyFeG9sgHrbTdMgzxxECrQADthXkS7evEIQ7rozOrP2hC+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3z3k86orJEEVtWawgR2SQeqS6pOfAuULCVVKxpS44Kg=;
 b=e2SY0Ys+Tu7Of/EOAMDPCUf0tg6fBpsj0sVzikunYrc0GuFzxGBjinJltrdBZZGVnYZ+a4/DLRyBmewFWWMr8VAwbXO+eq/1y9bdGFWpdWJKp8Im7RrCs/jm7RC26W73qMuRrkcmm0ZKp6xsGnbQ8cL12lyh/Px9/Gr/eLIecP5ALn+vcL/31uOe4U/q+ZvfQo9B1LGn/UBCYJNRwPiBepw08YwT4E8jZmueM2yTZK5SOGThHcTGKTSXiH9MQroIqB6otu4F8YP/PPOvhifnKvyKG2BdyVxcA+JXpF1c3Wn2cUmNtO2u0IcN9YyHZnP2Tdjp8xjA+EzmfRegH5JogQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.11; Tue, 22 Nov
 2022 19:49:53 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 19:49:53 +0000
Date:   Tue, 22 Nov 2022 15:49:52 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
Subject: Re: [PATCH v6 1/8] RDMA: Extend RDMA user ABI to support atomic write
Message-ID: <Y30n4NtOepuzUhxN@nvidia.com>
References: <20221015063648.52285-1-yangx.jy@fujitsu.com>
 <20221015063648.52285-2-yangx.jy@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221015063648.52285-2-yangx.jy@fujitsu.com>
X-ClientProxiedBy: MN2PR16CA0042.namprd16.prod.outlook.com
 (2603:10b6:208:234::11) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB6413:EE_
X-MS-Office365-Filtering-Correlation-Id: b26bf5d0-90ad-47bd-db47-08daccc2b993
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pe019Gi6SIC7ZS/mcD2Qv6H1cIOZluy9Le4xzB+9D6CzsWBYyxj0M5zIuCWgyFiG8+rZlS40X595OxLpoV9DegzgZvupHTw2vZctpn430Zeap6WHt9wdFxn7yU2g/V12IotQZd9Cz3uS9ghMWjrwQMFdgmbGszDqnKJAeyiXM3jf1D6fnSbnWkJCLKUpKNkh5rxoXZ/aFSQHDU7jotU822C+RO9/WRYjEg5EEw5JSJ3YZynUQMopJTbRI8mztP9rV5A/rImkuZH6XUY8MsGeHHUceD7wJ1twg6ztELMtLZGej2c9epI4FN7ySApspqDss57NXU+6V9vqRjI7NFEUeIzRQhgDnMFNdXkvezvb4tt3KnMcaf0pQ/ankW7+xjhObTrm6Y0Q3hzkMpfNR58RMAx5sYN67G/8ZPJw3CkCSK5Ih4LnVnYv8kZM83tlyIB2/dzubnFHi9/bWsEPe/krOojwkZc8UMrM5C4G96anMofLaf9Z9QzMrux09fRMbjL37hLdvl7apKkJGNyyejqiaELL2lL+6VXggrjcnT5VIUEgPoqQjB+iOASbeS1fVg9vaBKQM/JoqLRHBtvRtBoJMMHhxujPfRpICfei9NEcSl7SOb6sHx8taknpiRaeikM62NfEabd8KCNnZARoIun20g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(136003)(366004)(39860400002)(346002)(451199015)(54906003)(41300700001)(36756003)(186003)(66946007)(86362001)(2616005)(66556008)(8676002)(4326008)(5660300002)(8936002)(26005)(316002)(6486002)(478600001)(6916009)(6506007)(6512007)(38100700002)(66476007)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wIc+jCkSldNmzxerT00hEeXwppu6frJA0qDf5Q9BileZBTsAupU7GhReHL8o?=
 =?us-ascii?Q?DQcjMN+0ChAvUkrEuVvM4VrytlCTa1lHI4o5zGn+3ockc7ARTNxddTqvHqOa?=
 =?us-ascii?Q?2Cq+qd7NdRBeq8U9NndHR0f7NvLVeIM3B3OMRAFLp+GPUEBJjPS1RMSbsqZJ?=
 =?us-ascii?Q?wkCVQENbZohUe9jXQJnSsK0mGjLQlSfvpV/AOdwq5SS2BiOvHjtFCXszkeqN?=
 =?us-ascii?Q?lKix5T6qpzolojx/g6IlYmssbaOzTkop0Hep7ghPJQcYDJGqeKgHSEZXAjA2?=
 =?us-ascii?Q?pyEwThEfvtQBBnrJzAgqjHxjeffEzBr87CqQ8uXKnFJtgh/vLF9Z8ygDfqEm?=
 =?us-ascii?Q?ducKg+SNOhCTF4cJAZe4keU/NtjOo4BoTSJkGoZEUQE0BnZC+skGoFZQK0jn?=
 =?us-ascii?Q?357T17nTUGMHSNgoqPkMMx39rCZ4Z4VYxcXMGsLpI7d2PQ4o4R3iipRpwlLv?=
 =?us-ascii?Q?Fcuxje4bcIqHwsRjrynRZiNKvVjD0/GlbbzC9F3TX2ssmyKqLmikG299+UYx?=
 =?us-ascii?Q?XqRPT64SRgIIUOCRGvjNsdiwovnrOBnEFvBX7iBZt5xqJVSZmXcGP/HbI9fn?=
 =?us-ascii?Q?IIVL0RL9zCL9JXoD0Yil+6UM7RPz5+tiKg40m2tO6WvX8qkG6qMjib0nBVfI?=
 =?us-ascii?Q?lREPnIaZvsOoVv6DHDT2UmqdLrWGXWw4fsDcEEJLoO6AqkJEF08aj+G+XwH9?=
 =?us-ascii?Q?OcI0WzKBp5sat3v2HSRAeA45NJtVjwVt9L7O0I86QZo/wC7/soLAQZRIFBtm?=
 =?us-ascii?Q?3+euXmAfQ7P9FBX8kcK7isZXFYhIcIcIswzL5DW0yTBcQrFmEIPybYgmBn4N?=
 =?us-ascii?Q?riZHcuRTqZPjAKCw5vwKvHYAh9NZaBQrPOwY7ko8a+in/n/rvxNLKJXMyBXu?=
 =?us-ascii?Q?2iRmMBsuKIgvuY5DjNqfMRFkxoknzr77suqpykyTf5Wno5Lwo3uM92VLRbxB?=
 =?us-ascii?Q?y3xVezGv01AmpZIiEUXFFL3HzR6estSZvoe3/l6jI/nJXTe28F3jsiAc6c5t?=
 =?us-ascii?Q?aGAERcfsttsO+PLWHZB4NOxTMH8SxAdECJRt7HtZUowSh3IYFjjj3v8l9xVh?=
 =?us-ascii?Q?4JsVYmQgi/zxWxe/Q2aSBdgXWlea/O6QpFaVZwu0d6JeYEnalMQ62iYa2Tg1?=
 =?us-ascii?Q?5SB4Hm78X+0DDGVfXusv82b1/i2cWWKW9xUSSogCQp6g0gL4YGE7Oh7wmowo?=
 =?us-ascii?Q?4wDxAY1mRRTK3e5np+4M1gJnfwg0rLQAReQdhzZhN2YNYHZ9u1qupPOM5/QS?=
 =?us-ascii?Q?kn1hOv8XjiKYuBAiajGYucAK+YY8Ay+Sw0arBrd+qSfW8pPCTb3v5lHjnHJe?=
 =?us-ascii?Q?v5+zq2wZYrbLY45zkRpxllBUV8mEn29xJlxZdCcYh5qC+yEo2NfO27ZRELlP?=
 =?us-ascii?Q?uaOnvojbUR+uIRfsEst7OArqsJG/UwRETXmmtFgGovriQEIE6PHckiRfIIPo?=
 =?us-ascii?Q?RuscD21oS23XSrKx2R8px/DHiuiK/cnFYGkYRHB/897onf+TlITm+Ad69fDy?=
 =?us-ascii?Q?58M6bYpFyf3Rq6qdBVlxJvQIqsxSaLG8vm3yfpUnS9FQztGF8vfBnacOYv4I?=
 =?us-ascii?Q?2Upxu7P6DVBMzOTqDls=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b26bf5d0-90ad-47bd-db47-08daccc2b993
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 19:49:53.6636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TFnQ5SAssNyuB13kZUBhWDSVNpqgOJlnPu18WhQFpPCx3w44cXR0vxQli9AVzw2B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6413
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Oct 15, 2022 at 06:37:04AM +0000, yangx.jy@fujitsu.com wrote:
> 1) Define new atomic write request/completion in userspace.
> 2) Define new atomic write capability in userspace.
> 
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---
>  include/uapi/rdma/ib_user_verbs.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/uapi/rdma/ib_user_verbs.h b/include/uapi/rdma/ib_user_verbs.h
> index 43672cb1fd57..237814815544 100644
> --- a/include/uapi/rdma/ib_user_verbs.h
> +++ b/include/uapi/rdma/ib_user_verbs.h
> @@ -466,6 +466,7 @@ enum ib_uverbs_wc_opcode {
>  	IB_UVERBS_WC_BIND_MW = 5,
>  	IB_UVERBS_WC_LOCAL_INV = 6,
>  	IB_UVERBS_WC_TSO = 7,
> +	IB_UVERBS_WC_ATOMIC_WRITE = 9,
>  };

Why is this 9? The following patch does

@@ -985,6 +986,7 @@ enum ib_wc_opcode {
        IB_WC_REG_MR,
        IB_WC_MASKED_COMP_SWAP,
        IB_WC_MASKED_FETCH_ADD,
+       IB_WC_ATOMIC_WRITE = IB_UVERBS_WC_ATOMIC_WRITE,

Which corrupts the enum.

It should be like this:

+++ b/include/rdma/ib_verbs.h
@@ -983,10 +983,10 @@ enum ib_wc_opcode {
        IB_WC_BIND_MW = IB_UVERBS_WC_BIND_MW,
        IB_WC_LOCAL_INV = IB_UVERBS_WC_LOCAL_INV,
        IB_WC_LSO = IB_UVERBS_WC_TSO,
+       IB_WC_ATOMIC_WRITE = IB_UVERBS_WC_ATOMIC_WRITE,
        IB_WC_REG_MR,
        IB_WC_MASKED_COMP_SWAP,
        IB_WC_MASKED_FETCH_ADD,
-       IB_WC_ATOMIC_WRITE = IB_UVERBS_WC_ATOMIC_WRITE,
 /*
  * Set value of IB_WC_RECV so consumers can test if a completion is a
  * receive by testing (opcode & IB_WC_RECV).
+++ b/include/uapi/rdma/ib_user_verbs.h
@@ -466,7 +466,7 @@ enum ib_uverbs_wc_opcode {
        IB_UVERBS_WC_BIND_MW = 5,
        IB_UVERBS_WC_LOCAL_INV = 6,
        IB_UVERBS_WC_TSO = 7,
-       IB_UVERBS_WC_ATOMIC_WRITE = 9,
+       IB_UVERBS_WC_ATOMIC_WRITE = 8,
 };
 
 struct ib_uverbs_wc {

Jason
