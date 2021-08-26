Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07E6F3F8B15
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Aug 2021 17:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbhHZPek (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Aug 2021 11:34:40 -0400
Received: from mail-mw2nam10on2044.outbound.protection.outlook.com ([40.107.94.44]:54984
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230203AbhHZPej (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 26 Aug 2021 11:34:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eIWElVhr0bpa0Yoxuvdzy3rIWyJKd/C1VYzVZOxjzyMkMTaWqaG/BK2j423kCRZtnSwnQyUj+othqKij71YMnU+mk1sm/WB+3nqIuH8yqnW9HUxgDrOB2S++yYgsAGSQfQ1DT1rJRj/EShC8pI4BQi+uQSmIw63avCcqwQccVIncMhiZkqBQkY3ElQ1fNR7ADM+FvblBi/8uE+chSISD89fCFLzK4UljZ5ozuIKnm9HkZH+QuTrj9cC/OmvPJDdv0hg87AQbyGUB8jCWmBEllhjRT3iU7EVzU2RD8kMwEXwcT76z1z5eu5y5/TfhcyJi0o/xZ3QsYCJ2N4BWrDZmVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHr57WVSx/Qd1Aihpm6vGtU4JdXroihVXTzkcAi31RQ=;
 b=GnsT8jEGq4VtdgTKeb47Hkc69gtfr5HhFFF5T/iWefC+jj+3PqahDfT+GH6VuDcVsLw0s4H9NbG/Pvu18pGez4oHqrf1C+wLQpj+5TlxRboWqCsl7aDyHlU718g3SiOloCcqp6cfZKITXmMgSt+xcK2zz6nvZfyuSV9tM+zn0kvOo1E5Q8AQOWHKhdVeSe3ega/WQqwjkskKdpZQdDJkxzUeZsQXBQ9tf03uQimg1CSiVn7vp51PHTAhkRgNv5PgDEC70NOqmIGCQu2N9ka+pJbIaZOQ3SWFbmKxcEjxbOV6MF5tf9IXiQdeyTiSIy0pxUFkTfKI/F8Tw32Dsv9G0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHr57WVSx/Qd1Aihpm6vGtU4JdXroihVXTzkcAi31RQ=;
 b=apboSWuqSeavama9p6sP1n4x87vQZXHHDk1MsMlsA11lCrlbbzV2S/AOBUfI6lG8FH6cAVKIJGyK2NO26PjHxGvw4xOuodK7x5c0w55SpU/Ub6SV38wdjz74j80jbw7G9acx0JE91xJEYDEHqg2Z+yrNk7I+BKCPEBquXHGRJMgnAejMWu1gJs8ErSgTpb0T0JzuJP8qsX3kKLFlbJTwkiRDzGMrlmuuX0j5j7fGONyI3Yb829lYpk5TIj+HmxCJ1ZJ41eMyb17gheHJ0ru7OBGmIN1U3+S3eSRus+vfC5aSqfQw0Rzn5C+YxE9TLBABQOwxRnusFQ6tt8yq3qz5sQ==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5317.namprd12.prod.outlook.com (2603:10b6:208:31f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20; Thu, 26 Aug
 2021 15:33:50 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336%8]) with mapi id 15.20.4436.027; Thu, 26 Aug 2021
 15:33:50 +0000
Date:   Thu, 26 Aug 2021 12:33:49 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next 0/7] RDMA/hns: Updates for 5.15
Message-ID: <20210826153349.GA1286901@nvidia.com>
References: <1629985056-57004-1-git-send-email-liangwenpeng@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629985056-57004-1-git-send-email-liangwenpeng@huawei.com>
X-ClientProxiedBy: BL0PR1501CA0013.namprd15.prod.outlook.com
 (2603:10b6:207:17::26) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by BL0PR1501CA0013.namprd15.prod.outlook.com (2603:10b6:207:17::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20 via Frontend Transport; Thu, 26 Aug 2021 15:33:49 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mJHO1-005OnJ-0y; Thu, 26 Aug 2021 12:33:49 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ddf7357-49c9-4942-8487-08d968a6e705
X-MS-TrafficTypeDiagnostic: BL1PR12MB5317:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5317690786F59CA8AD9038ACC2C79@BL1PR12MB5317.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WTqLrISMCI7l5ipLdKXAlfZ6ApdLuVDOQrj3ja/2T0uD9Z+hJxxvmRRvugvpBiGVQlJrFMTLcUL2PF5Q92krtwpsEY+XAzGbJcxIqNXlM3ktHKFwb9jkBgoENtzJmrM4J6VTKlMxfQoQKTsrLjNwYIdlap0o4zyS1NzsuXZX/qcovBr3ohT69qEV78fHOGVh0zd0LlcRAk1cO8L6nubani2pKOHRfM7YTqcUrvQABNXbxUHbPyQeCEiu57JINqmnn2kNTegZY2Yuwsm1sY82Phgh1VBuT8z6RCREhItjxhaAPOgFM1SUSzZ1t5a3yb/vFEou63W8eNhwMOV0JzyvV+LFCTgP6OVCC8SOdt6MWseoNAo7s0nEUl+dBFMYIEy4++EsNWHslLSZeLytfXrL1k4vuOHq8gsgHsBBJ7DQEV3FALEPp/O7+enKvl6LV1ui176QZzt3S/Vs/YGu9U2Vatz0hOMBlTrUT5mWh1l3ZUrJT0yj6QNiAPAKGV4bWiIPvxt6UY/JmXpZxduT3puFu6xATBWMzk09bQsrj336dMPYjnHm5mTZQDAV67pJ6eJH+nloByy7hU2ShSVnTYPHCsOnj7cZr7Spa5BXtxwCgBeLOh/N3nXlJycVn3SwxSwEwQh+KORtaiDFAlYPyNDM7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(6916009)(4326008)(2906002)(8676002)(9746002)(9786002)(1076003)(2616005)(66476007)(426003)(66556008)(8936002)(38100700002)(478600001)(26005)(66946007)(36756003)(186003)(33656002)(4744005)(5660300002)(86362001)(316002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nhRKA4AX2ogNvj/wLizhF8ASn6Z+3MZvig9gO7UBVo/ykjWHs4uAMD0zLKe3?=
 =?us-ascii?Q?upHQJnQecGKMUdOhPzjRvnmG10PjTFjkm2KvF3SNFu7Isqo18YuOQKvnaaKQ?=
 =?us-ascii?Q?ZPA09tJ6c5Z6jIhKo4k6+5TjQuIFZsWNw6SbQPE3vbaHfH9ZFyIBaqz3ZDaT?=
 =?us-ascii?Q?dOl9cD1fmZkbs3diJLcGwgilwy3HaSIcgyHILZGKUI0Cad3WDtBe/ESjIJUw?=
 =?us-ascii?Q?f6p9lTy0r37F7kn4OxW0oeF7fS1nm44P5pwLE/E+zJjvtrw3wFQMB1rN+YSi?=
 =?us-ascii?Q?E7badVg6PMJOvBq8g6opKftKig6NQ0x4LwRIdHoJBljj/VheXGFcBsAxYN+f?=
 =?us-ascii?Q?GQ2AS/PKDCDadTQSALBtkf9JrDXY1yswBzzDQFL/zdVvtAWZj3eWkvgpMqUr?=
 =?us-ascii?Q?dCZ3cCcSDQI0atlv0MLgJySaZBuTeP+2lekDYXDm9Q0khr6jGTZmqtp/c8kc?=
 =?us-ascii?Q?kVngZcigPBDXHwZPCnBjoX5fcLxFrcEeQpVgLFpe1+7UZk/utMpvr/1u8X7J?=
 =?us-ascii?Q?f8oQpUfkRnPnqvmmKhrnsucSft7bAztACN3qA5mp9NlJr+vaYC6+LMgd6TsP?=
 =?us-ascii?Q?YZptGLtHm491wcCdvwhRdODebSQL0yTGLFw/dEMby8jvTFKAFcpBSUBTuSdB?=
 =?us-ascii?Q?hBz+2rilX3q2Xi6+1KS1ASs0/Gt6ChLH3VUpUv+Ddn1Rmbb4o4LjJF86v8C0?=
 =?us-ascii?Q?vGYUObucbNZqcwb5lPVHfYSzD0s5QSwXKPZcImkL59WF22+lNuic2uTez3DE?=
 =?us-ascii?Q?6OIzTrWW60TMO5xKAJwe+jpG14oy6DfKIN5lu9a3CWH1RsN5Iulgqlm0X7Cv?=
 =?us-ascii?Q?mIoRetPlxIxZjCDtQz/tIs5f65ImS2xBufjRoQuztEExbNpnV6P+Pi8OHrB2?=
 =?us-ascii?Q?EZ9NhD+CngxkL6M2c4uYisWGn7k7V2sVUsk+ba94dV0Q6RiFiQIv7oNwrgy9?=
 =?us-ascii?Q?l7HMBSwbP8AZKmbaEznJ/drbc1/XTR4F2MKzBThp/tsJqABp7yuPI76vpn2a?=
 =?us-ascii?Q?LKZ9jDcJP7flQiWBSETHqCDw7T5bEsMIJ9Meg0G8bx5vvd1VeP3SqlZDpIov?=
 =?us-ascii?Q?O+j9Fh9VbtwaE48SCloWRs+APkWMgj9n4fjYVl6N2dQPhJwDY1B0llOEQQPy?=
 =?us-ascii?Q?iiTeOfCONTbLLddxaqT4L/HIbN53rh5uN+X6UDDxZtD3wiXm641V7EsyiH1X?=
 =?us-ascii?Q?fnXGNZ19ugn9cM+nAsIMLbkRFVjhs1w7uBvf3SbtmDdrF5/auysDFroyEKF/?=
 =?us-ascii?Q?XNBVVFZhez/hj5sv4qYGhT3LIUE9TEPj7YfVdc68pRX56rldKRVPZr60wnyk?=
 =?us-ascii?Q?wnTLlvG3H8BV54+u2Avnp/wm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ddf7357-49c9-4942-8487-08d968a6e705
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 15:33:50.2510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q/VDPqHJ/vjdh7ZWVzxaIYDbbkUvCSdtkfhDkqV8tcOgDGNpi4HCyHW71OsZACyF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5317
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 26, 2021 at 09:37:29PM +0800, Wenpeng Liang wrote:
> As usual, this series collects some miscellaneous fixes and cleanups at the
> end of 5.15 for the hns driver:
> 
> * #1 ~ #2 are fixes.
> * #3 ~ #7 are some small cleanups.
> 
> Weihang Li (1):
>   RDMA/hns: Remove RST2RST error prints for hw v1
> 
> Wenpeng Liang (4):
>   RDMA/hns: Fix query destination qpn
>   RDMA/hns: Fix QP's resp incomplete assignment
>   RDMA/hns: Remove dqpn filling when modify qp from Init to Init
>   RDMA/hns: Adjust the order in which irq are requested and enabled
> 
> Xinhao Liu (1):
>   RDMA/hns: Delete unnecessary blank lines.
> 
> Yixing Liu (1):
>   RDMA/hns: Encapsulate the qp db as a function

Applied to for-next, thanks

Jason
