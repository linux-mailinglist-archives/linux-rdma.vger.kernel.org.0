Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 034BF351EC7
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Apr 2021 20:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237526AbhDASqw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Apr 2021 14:46:52 -0400
Received: from mail-dm6nam12on2060.outbound.protection.outlook.com ([40.107.243.60]:63748
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238342AbhDASou (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 1 Apr 2021 14:44:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZy7iUkyzHohJiLxLKlzNuBUqH6WmvfvJEbNSwsr2StPxxzFs35S/thALLCTNxd/13oysQjm/4ffQHluOJt6aa120p86BYG4uFFIg15UGHYV8hWLDGIfvn9YuHrAKnoxi3cc7cN1qcbuxk7P8fXoOaYdasnlicyhS1Ww0eSJglzqMWQB02yuiu+UXegjUYVOyWb9dB15wAiqn+69XNEjPqDjaSf/4vnpuiHlFHL8HpoBXvAsB/cKbiVPXKXnK2f1DR1JlUiTIzv4/q9E2Rhx8lU6xIvM8JetvIeHgutYsDvA5Bx3JCRIGmZiZKziYbQvbiS65I4BEO/aNOK+v6LcdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+wvIMq1jc/7OoMpKmYyl00NImh0rHn4eTQG4l64t48=;
 b=Fyyu85ZQ4ifdrCTaaSSGf4aNNgKQhQmKQId9i2UTcLoSQ65YzTCHZBXWUFVZmOlvbWKUxdX3jN1W1R4Ggwdq2H+6UmjWBWK14INcRTaTi1yLLmTpiGA57os8amayKJuWRB+eknlWMMUo3rwx3c/dCiNJ//9ICOE6tRmrz4lP7Zj+H0Usyma/uku4n69Nzswa+LIDhWaIe/QZwkmsftvJg1GnW9P5AtMJefg3KD1G//2/IslfbRELlc8/reXINjs96IugPbBLJgAr5rxuksQlQenqzdqeHQeK6E3YFN0FjqwTOYyfJUGOaNiMKDOVeKDdOzh2zW6JI1uHMX5FiK0grQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+wvIMq1jc/7OoMpKmYyl00NImh0rHn4eTQG4l64t48=;
 b=X+pCw8xHT2oZMsAHjuamf3+1leUkKBU1D/iZWY5kwMv65cpeF7pAYuNne4NlA4VzH1MIEJcHsvKXhHqHkZ3zVBV6Mz8tbyl8KKcc8QlPvXVyJlK7xbtsoaarbDIS9TmFQpYMHElWHb+4FxhPVUNeCvL1T4yf/b2d7xonPQK6RJOEdNnNgg7CUcdM17WWSxm7X91f9jb8t3fEsfez5Elr1QfUpubVyGg9N/AOFS0be1ZxYdzSzQjnF35mGAj9e2ecNvpUM4aqsHqpiSbcYBbwB/RaNrVko/iurAt2alz4WjuSsufx4XOAqQBm/OJ6CmNQRtGN9LrVw8OWBgdYSsB2DA==
Authentication-Results: ionos.com; dkim=none (message not signed)
 header.d=none;ionos.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3514.namprd12.prod.outlook.com (2603:10b6:5:183::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Thu, 1 Apr
 2021 18:44:49 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.028; Thu, 1 Apr 2021
 18:44:49 +0000
Date:   Thu, 1 Apr 2021 15:44:48 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gioh Kim <gi-oh.kim@ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org, leon@kernel.org,
        dledford@redhat.com, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Subject: Re: [PATCH for-next 12/22] RDMA/rtrs-clt: Check state of the
 rtrs_clt_sess before reading its stats
Message-ID: <20210401184448.GA1647065@nvidia.com>
References: <20210325153308.1214057-1-gi-oh.kim@ionos.com>
 <20210325153308.1214057-13-gi-oh.kim@ionos.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325153308.1214057-13-gi-oh.kim@ionos.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR20CA0002.namprd20.prod.outlook.com
 (2603:10b6:208:e8::15) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR20CA0002.namprd20.prod.outlook.com (2603:10b6:208:e8::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28 via Frontend Transport; Thu, 1 Apr 2021 18:44:49 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lS2JE-006uVH-A5; Thu, 01 Apr 2021 15:44:48 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1502858-8a07-410c-bea9-08d8f53e3aae
X-MS-TrafficTypeDiagnostic: DM6PR12MB3514:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3514C4F9977F556647F0916BC27B9@DM6PR12MB3514.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: etKR2IFofui+LaBc1UK4NYta5z5aNuvMeL8qB+GUGSbkhhRR1DlDUKCeSp1ure80NEz66xbDFtI9F6aBMioY5UhG/Ej9oe3qbCjdQQyDoJ3HX/4xqLX1EOv1OpuB0ONDLoz4mTUuMs/jCBtqihIShKSOU4uUAM/h5ywGELxclpaX8dLB6fnh+3NKWXJQ57hao4l1wneuujOgvYIicTtkwjxiZ+lUmuS4KliQJcCrbKt43uxMOcajHgYE9z1Yeeu1LRWgC7nPBUtMYYDUR6xIGAvVPsoQnCTlhrjgRgxj4afo1Vgi57kJQYKZO51OjKqyoZTNlS7/2A2hIWdZqbfQMmBhwq3ibIu39OwYRIwAzPkvwDEu9ugFgW3AQC3ASCAQKzk7fnf5b3LxgHJRA06rgNQjRLd9zHEgMkmBlfbO1uarGplDDtUH4AnarMQVFH7MspyRp1m04YYl7f89hR25q8ZxMnaDxrAfrWUqJadiagCfC+Id89hdIS0gqXZ6vqMMPBLuBL2nCHl9pe8CzgRRFQlN3F46ZpSL8I6z1u24gCx7JfeN/wkYmwDVcqX2EiuD6UybDlHpU4/5rvogSNBKRy7RUjFaHAcUqyQ4AXCvOAJC5RYE0nX61u3bC9tAlu8gK/44y2vtpO6997Z+E0OEaux5sTHmZMNEaDgUlFCm50Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(366004)(396003)(136003)(86362001)(8676002)(6916009)(8936002)(83380400001)(9746002)(9786002)(36756003)(2906002)(38100700001)(26005)(66476007)(5660300002)(33656002)(66946007)(316002)(478600001)(66556008)(186003)(4326008)(2616005)(1076003)(426003)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?qPfgCgzkzQ+UBXLKRSZ3Vh6y3Qfej0SErF6rJZUzz2cs3vVQlKDafZLsqwPv?=
 =?us-ascii?Q?in3CMuz/0go9PUXY0o4JUQDOxcNa6nx8/sqPMs6MQ8JmTNAcFnJRlJN6KOjW?=
 =?us-ascii?Q?f5x13ryFM26CK4YqoGjLAciS23ckvG+m+gVoXzMNifUOvia+xPghYW8YtKmM?=
 =?us-ascii?Q?KLI0L4XAZfp1mRy7c7r67b+l75KdyQZ8Is9BcOQ1choiSfTn02PIpN833DnB?=
 =?us-ascii?Q?ykjUSDkheOM+ZF4gqERptqESXwNDK3lF4zjZ0LFQlcOz8jz0fOCKWJ9ib+qo?=
 =?us-ascii?Q?5cgdoMsNj0dErXXdQ9wyfGNRFzSZwRf3EZS/2kpRtVnWXdlYuXf/OxRlsqsy?=
 =?us-ascii?Q?MGvEz8n968B45myF4tnOU8h9iGcRpb+G03aa33CDi4BWc+obszK+LcMBw9M5?=
 =?us-ascii?Q?PbuzWjOsU8BHsuCu1AVL554CgYHLSJhbe0n7XN9+qZ5rtHTIJG/RSxBG93o4?=
 =?us-ascii?Q?zpNTA0Zclp+k6Ojdxf0oxH+ZP4IJBZf1l/9cY62ohzIZTpN4GV2BRfXjbsrN?=
 =?us-ascii?Q?/w25YzVDIetmdMHxpq61EtaoOsYAtoH1vIOSo4/f73XLQ5roTj+wIoNVEM7T?=
 =?us-ascii?Q?+yYipYPIX9CnmWI6EGxgvihxumj7Wx1OdpYpnrQ+bGyW+tip3Y5Rcjk3iGBy?=
 =?us-ascii?Q?1OCZTkgSQIz16sOQYzjyfuQ9aSaqoUIy1qSnVV5JaB4ktjUCv8bVx4cLus27?=
 =?us-ascii?Q?Z8/BSHyzaUaNMv9a3cXjK2WDrSD1g3jm5fG1vAXz7z8GlEUuhSFiJCycIrQY?=
 =?us-ascii?Q?KylVzbATgtjqTKmmkYjQBsa+QMQQf+KBeNeZZZtyWkgtdC5cVn1p1JyGQKhx?=
 =?us-ascii?Q?Myu9LcWLgWiKrbGoqigEnXNfGIxmZB/01L1DLspFXxSxCq8oiR+niYd5rZB5?=
 =?us-ascii?Q?fLJ3kqScNz/na9sSXmbIS6jpzarcuFCY0Bf16CaZoOoVNfLqHhZz+VvRJpMT?=
 =?us-ascii?Q?PRppN8O0sHSCk0qK2PpHaK8oteOthQAtrErmF7zhYkjXZ92+qfSj12IqVyDm?=
 =?us-ascii?Q?h6f/8noSJ/QWiIQOCyb7jpihOQaBYP/MYC3l109ec87NBUbFqQkcFkqlFQfl?=
 =?us-ascii?Q?Vxqc3wASInYioGpMnQ3hz/0rtu8VlvrHYAcdYdyMvJiXYiPWb7TloY7kFZvN?=
 =?us-ascii?Q?/7sED+wL43kJ7+BNQ+RJSXN0rOhUUSRT92dyFb9vZwYBkfMbckkKslgiEMAV?=
 =?us-ascii?Q?JsKtkKoLgMqJ/fWCH/bE8QdtuPr/AZAS7ehRs3f6VIfATpJTgmZ6w45jNvbx?=
 =?us-ascii?Q?sK311G4j5Z6sl2H733TNEyRMlAg34ufwALwY3TCkNOiE8revXt17t+T5odS2?=
 =?us-ascii?Q?WdP7UmHQnlb0nCr6GlwOgx2tfdRvsNjtnLgy5ttCD4WG3Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1502858-8a07-410c-bea9-08d8f53e3aae
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 18:44:49.7081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n+kKbWki8Yzigj8HX7ND6iXQqiOm/vVt5SrqkRfLIgRElrv6ZiNX/qSb3ZG9oidB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3514
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 25, 2021 at 04:32:58PM +0100, Gioh Kim wrote:
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> index 42f49208b8f7..1519191d7154 100644
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> @@ -808,6 +808,9 @@ static struct rtrs_clt_sess *get_next_path_min_inflight(struct path_it *it)
>  	int inflight;
>  
>  	list_for_each_entry_rcu(sess, &clt->paths_list, s.entry) {
> +		if (unlikely(READ_ONCE(sess->state) != RTRS_CLT_CONNECTED))
> +			continue;

There is no way this could be right, a READ_ONCE can't guarentee that
a following load is not going to happen without races.

You need locking.

Jason
