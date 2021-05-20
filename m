Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCB338B267
	for <lists+linux-rdma@lfdr.de>; Thu, 20 May 2021 17:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbhETPEE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 May 2021 11:04:04 -0400
Received: from mail-dm6nam11on2080.outbound.protection.outlook.com ([40.107.223.80]:4161
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231286AbhETPED (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 May 2021 11:04:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lnf1uzsHHsNbuPbLFcahuqK3EN4/fDTPJxbfWxNKMcC+sGJiFdhUA8qZltxS3w6ESympglna/w6Y8/87myZzKKQMZg2BUjqrtOZKcAmgwv62gmq1f41MtIPiLu0fcPUXbt9fVnLryhItpWR+aemh4okJ2VKvfKZF+8IlPeJFBkbt+ebfTsr5OHeAxQkGYiKpYHXOaOu/fiH3oMiKi3Dm/6Qdj7r2H/uyUx0Gb/hU2lOz9aWE2PHJ/zOSJkKloxA0kMHs7xyOdJWbySjbtG2X3urjsSDfeLAnZurE9LXIBixGTekl8nU/Ajs+YwEsJLshdyy/6hIm6sbFjm9wk8cm2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+cf9Gou52XWZLGYqgzJMRK8UlP9egqE+G7UEDnwlAuw=;
 b=dJ6EIL7AMeLwJ4ZqfUz0f9ZoBtt4gZp+BbtkAPL9ZLEvIxUbT1GaVRg8P734MBaVndR6+ruDOq8QJP/CrPYG0i/SltEO+iEupkXAdlsOa8z+3/zzvCCi1gtLDCLUbSnwfOsi8YtV8h1UxaLO/m+s3TzIMzTwu4Zjh1fyhYABKybAP7yKYh1RuVdiuNPkgbsdQZPSScH+hiwAWAtTSPdoYOJDC/wLiVrBuhxzFpQED5X/ztVMWgeXb0t5G/lFOoD0E8gBNdshqfntbvronwCtYcJPd0/uL0TplTSuDZNpLhaVfgFPPblMmqQIR77b+etsOQ8H60CC1iF0lXvyD+Sm/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+cf9Gou52XWZLGYqgzJMRK8UlP9egqE+G7UEDnwlAuw=;
 b=Q14RHXIzxYYd7OTm19U9Zm9bG3umw16MK/jrkUCjWaCR0hPesqcR0jPhM/FZq6mCoZf9UI+7U8aTF/EKLVhQ242hDnPEgi7hQFy7sP2lEjkTaTI+ibj/UWt7v99BeP7lm4Vr3xJ9Q+jyvWknFna3Hm6zWufXVtpo1n0TCEf6wzAsIjq+AXue+u9hreM8/CesCSAFd5HCQJf4J2Z11f3KT4Senu+R9La/OkzUNNZ7KktYu9iEnL680kIci/jRaTM3u30hazzfWHyDzOQmAX2sjImzs63iMEQivcqhG+xEGL24YvFY8sKdFdRVm6jxZRo8gFf23ZZ2JVu9Q+4eNJnb+g==
Authentication-Results: roeck-us.net; dkim=none (message not signed)
 header.d=none;roeck-us.net; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1434.namprd12.prod.outlook.com (2603:10b6:3:77::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Thu, 20 May
 2021 15:02:41 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4150.023; Thu, 20 May 2021
 15:02:41 +0000
Date:   Thu, 20 May 2021 12:02:39 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Selvin Xavier <selvin.xavier@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/bnxt_re: Drop unnecessary NULL checks after
 container_of
Message-ID: <20210520150239.GC2734122@nvidia.com>
References: <20210514153606.1377119-1-linux@roeck-us.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514153606.1377119-1-linux@roeck-us.net>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR06CA0028.namprd06.prod.outlook.com
 (2603:10b6:208:23d::33) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR06CA0028.namprd06.prod.outlook.com (2603:10b6:208:23d::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend Transport; Thu, 20 May 2021 15:02:40 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1ljkC7-00BTIX-Q8; Thu, 20 May 2021 12:02:39 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08647ee0-8e30-44a0-2105-08d91ba0507f
X-MS-TrafficTypeDiagnostic: DM5PR12MB1434:
X-Microsoft-Antispam-PRVS: <DM5PR12MB143474B91BE2138E7201C92AC22A9@DM5PR12MB1434.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:556;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pxS9lESLek7KW1sfDegOy6uIEDA99aKm352ADHGC7+ESz7faol3nqrlTAX7qEVOLYjQOPNWhnDmTC6OXMVz8J0K0ZyY8M2uFjM1Yn5WoYIc4kxlL6r47eivm9whtzuAGUOldenATpA1P6iCWHuE8X+dLl/e0+dzg1QAQj5UZ02JbFhUQWdZ01gfyZu1+IJX9AJMMijBGcTDG244EtyDdlMZ38tMRN0F4Lw/o6SNkO/h9l5f5aJl4o6GuzxV6Ui7tHs6Yk5hxKGiS1aYEFuC2XxU7ZhhXaJZQMhl9Sxc719TwfjcADjIiWVtg87cJVe87IW/T1wjUF9qgysAv+kYuOldGh+Gk4ufhKowMOPOLel4yF1n3Q1++1Z5Mvf1muQXT9RneYmCL9McP0E41ZuLMHR7lsjx47uvMZ7xHTWce2xvVRv4+GLe5wZo1ma+OLXxAhcAZz3gvbSSQrfCMucb65xZk4DrrvIP1jsS3Gb7jvVzHAZEGicHU8l9T3zd/bXeXeHHmBMTUi/JkZk8vPeGqzIqd1iw9ayqDKP36o6zZ5O+oEoggXJZj/wePoSmiTDm8NFqGZkm5JrgE0SAKZ7ojfhay3PSR9R8TD8f1CrTv5YQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(54906003)(36756003)(5660300002)(9786002)(4744005)(2906002)(426003)(1076003)(8936002)(2616005)(33656002)(478600001)(6916009)(9746002)(83380400001)(186003)(8676002)(66556008)(86362001)(66946007)(4326008)(66476007)(26005)(38100700002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ty8nA4JaZ5AuRG7SDfN7A3yzYpfcclscZtwY291Qx/tMLc6DAL2z+H22xEWH?=
 =?us-ascii?Q?n3sAV6HWjzk1tyGG7HIkQkV6WuUR/afamJzOZcN5+wgMeAs4rrIlTqbBn2KY?=
 =?us-ascii?Q?+eQk2EB12WXOQAHejx1uEjbwP+xQpLG9Gocz+q3OoDJ3Y5Eocef9Z2RqWq+c?=
 =?us-ascii?Q?YQLH2IgS6ySv0Luhfm0dzy07wdpY/oHut3iA4jOHa9pEIHk0Uha6QrVBRG2D?=
 =?us-ascii?Q?fTd4AIIlkDwH3KPFwpxohQ8L1DVmLqsbreVC6aMpTOLGEDC8wc79THBmtE3J?=
 =?us-ascii?Q?9NGurDYGeA8dVYeTMYV5ei7Vey9+jxQVja//S7CX3fzhjrJQfc0u9g9thuAv?=
 =?us-ascii?Q?htTyX8vUal4wndrqnrbeDOiMYblsznJ3csAtSUuGeWuic2BwxegIxlJUV374?=
 =?us-ascii?Q?pwgrtL+3J1Acl9Fs6jDwDslHw4gfFrMjMIylT0fnRwCFI24pfeHVX3OPszIP?=
 =?us-ascii?Q?0SQ/dyoFbr7NvQMgk6NrgePH5HaRnK4nFhvr+NZwJpsfwTshlzB9mj5Ak8/u?=
 =?us-ascii?Q?2ESjNFl57NXcIpDQmid0TgML6d3ofu1RVXG91KRcMoUMjZwO9MOqJP+ByoO/?=
 =?us-ascii?Q?onaigmJPv1RzCZ8FpKTdnXmD9SRPfrmboP13IZLuLvCR5QnQo08zpFHVMOrh?=
 =?us-ascii?Q?WH8PxqmTIDav2GUlQ3jzEyZ+qDkYUGNj4rtfoxgTTCMY5DezvobUvRwepMKj?=
 =?us-ascii?Q?GoGu5WawKo1qmFxaOSCa6nbkncgK8d8askIsu3nKHdArR9pd5rT3CWvmOouv?=
 =?us-ascii?Q?In7Zwl4i3qhs6DPM7KQLs51hzp2bxkBJ3NNpWr6VNeTseNgOzfX8PjDH4MUM?=
 =?us-ascii?Q?Egi8Qf7NspITvRJeioApsxhIQ2QXFUTXK0qwDqO2D+r0+so+K+OQI0BhoQtc?=
 =?us-ascii?Q?GlN7cDLDPwU0vBxV6Rs4o2O0/Ft+NEdks47JjSXjj6lo/bTijgSaprojs/a7?=
 =?us-ascii?Q?Vvx0bK64PK4aVA38nJABVkWbWMt0lPZF9OSfHzPlYXI8sIYNXB7NOEwnM/wN?=
 =?us-ascii?Q?M5t1ga6oWVsvGegzwKKrJ2RVneyP0wd5FvN4QCcBz2K2jH3FOFaarQpzjVHH?=
 =?us-ascii?Q?tWiLg7PnCPvajaJs4lDKRo/aKwzpxiO0uic04nL2lDKmCbWUnwl13jEOxmzR?=
 =?us-ascii?Q?jVKnzIdsKmUvgiIWM9Aaa+NZYomnh3QbLDidamyF5rLWKWochBtiRjUH++ra?=
 =?us-ascii?Q?vEIJI5jETz0awlEPAPEoYuNEswWG9AgXSbwEEc+OWntGvYSWS+mr02izhNAs?=
 =?us-ascii?Q?c4wGD8dxOhLCXsWa0uUcAIPLF3tw0iufA1FxJnMt8l2foa0ysQQNHwki/rWH?=
 =?us-ascii?Q?Gnah4tqMpnQlu1Yw9kn5zW2F?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08647ee0-8e30-44a0-2105-08d91ba0507f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 15:02:41.0870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ls4K/ehSfqVSztZVWP/0cD4NpMbRLjTWsEUrdze3xwR0DY8kdtq5e0QyPU5KKVXo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1434
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 14, 2021 at 08:36:06AM -0700, Guenter Roeck wrote:
> The result of container_of() operations is never NULL unless the first
> element of the embedding structure is extracted. This is either not the
> case here, or the pointer passed to container_of() is known to be not
> NULL. The NULL checks are therefore unnecessary and misleading.
> Remove them.
> 
> The channges in this patch were made automatically with the following
> Coccinelle script.
> 
> @@
> type t;
> identifier v;
> statement s;
> @@
> 
> <+...
> (
>   t v = container_of(...);
> |
>   v = container_of(...);
> )
>   ...
>   when != v
> - if (\( !v \| v == NULL \) ) s
> ...+>
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 18 ------------------
>  drivers/infiniband/hw/bnxt_re/main.c     | 12 ------------
>  2 files changed, 30 deletions(-)

Applied to for-next, thanks

Jason
