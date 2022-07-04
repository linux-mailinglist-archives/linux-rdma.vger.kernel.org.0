Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C615656D3
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Jul 2022 15:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbiGDNRd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Jul 2022 09:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233787AbiGDNRb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Jul 2022 09:17:31 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20625.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::625])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7D8B48D;
        Mon,  4 Jul 2022 06:17:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fAeFrRjsP6pztXfhKjlAWW4JOCs9xhVU119EU8HzJVEEeb/4q+OVanubxEypKek2vsF/oq7qsab9C/n2b023r7ZgMRJSyCH3Ed7gHFQwjOxRKGSo9LnO8SgI76NKWdEd0ip5OzJMKJ3wd/p60MWmRIGbz/y4jomeH1N1ZwuHvMoKcizBtmwiTOF7A3TnPNU2wCB5rbvVzTT9tvGd6nZETqEeJZKxF5TcJbkjI5hM2Jw7/uvGLxRODotdfmMDQQKcdJInDREt0wJ8yGbf5MV59hBjM/ik5sfEUcm3WJDNRyGY2xtwgO9AZerMssjVM+oCcxXBaemwrD8DTK53ipgKDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5umkHhVSSnrY8kLmOx3pIi1AbNXFA3Mv7ktaBxG5jY=;
 b=iLqOuZhmtTG5JxISplDgH03hCptAxUPmVq55w8n5O9gWJvq2/4cZTjNctollu/BRqEwVPkQPW+Mclnqrf2fUC3SxwT5SRfONwKicLjJWyCeEti8QEucCTPmJNvyRW9pTi0OzpfbYKADWlT1ZfQMlRI0uESzDvWnJTtrz2/ddlXA5sPajKd2AFeMuZ6nu3z0WxUor9IOoWDc6FRrxnsuxAbehzT/0m3ZZc1ikwLBVU8xSKbcFtuXF18GjVTllMtllj329yDuAAZokTNa7bAB/QVoeQ/CQMGtkup2ZV8jhbYtQXXBJG2wzyxWhBWVFwBIyn6fsecAvFZKcvqqUoKGUvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5umkHhVSSnrY8kLmOx3pIi1AbNXFA3Mv7ktaBxG5jY=;
 b=FHkV1fWhb6HU2TA9SpPCu5HXEthrFnOOJttDYWPg/VZ4ic2QstQHB7R1DZ+kHK7P881mmmMfDCUIpHskTggb/n7bKEnK5DlQilkDNryxPiF19KSsIpZMw1ST1hUIXSWAPiihxaclLk3yl9bHVgGR2D+OfOy/xKlQUX/mI6VejsGg0oAHljkqAm8z0FOWhMecJuDLrj+PXD04E2dXAyhdxHSt6azFBeRTEmln7ZBDgOBEtI2XeEEYYEnY4Ec80IeE0Re9HcSr4W2FRbJhCwAKTssUqB46QKH+7rSGrEGzhY55G6T/oNzL7qA5Q465wSGb9SeVw73ieu42H9J3TJnmHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BYAPR12MB3239.namprd12.prod.outlook.com (2603:10b6:a03:137::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Mon, 4 Jul
 2022 13:17:27 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb%3]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 13:17:26 +0000
Date:   Mon, 4 Jul 2022 10:17:25 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Zhang Jiaming <jiaming@nfschina.com>
Cc:     dennis.dalessandro@cornelisnetworks.com, leon@kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        liqiong@nfschina.com, renyu@nfschina.com
Subject: Re: [PATCH] IB/qib: Fix typo in comments
Message-ID: <20220704131725.GA1419537@nvidia.com>
References: <20220701074812.12615-1-jiaming@nfschina.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701074812.12615-1-jiaming@nfschina.com>
X-ClientProxiedBy: BL0PR02CA0123.namprd02.prod.outlook.com
 (2603:10b6:208:35::28) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7834d603-eded-41e1-8b8a-08da5dbf8a59
X-MS-TrafficTypeDiagnostic: BYAPR12MB3239:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hr2jG/hy6LBfQ1JEHvHrQyuBN9/YfI8oP5hM0tbfJzAyUdOaRYypNkB7vjrtquWhjwO1yZo4pu/LEFbQpNPanGdnqTCo4eWA2dWzg3fU5x+CjeGRlL4xPqdnwAD6Bi10HhRJF+9v0gvNl4B0PaBEjfVCsr1j0KUAe9AyX/+xG/Qbthhhm+mXL3mGib5oLxpPJf9V8nhJcK6H/ETnq97r77JhdJ0b+M7JFvPJUh9Q2qabitc7gycI/fAU3DmhfR2oNkCaWSeUBdPnPL/YKUnGS8c3NJhkCm4vBGbgThwFMziMLUfgqHzBogh42lh42VLtYp1wfPq3u8XJh93VHfQ00cUl1yu+aOYsJaX/VSGTfDwnhExuAb02/GEhd6btin7Zlevr7Hwndg+Xzdnp4i5sjw1/wQNj/rpkGN/pTrghKI/tk6oqAP8h9fd650WdvHm8MGD9OMc0isFwbWvYOPUoac5cdO66VHERWJZ4CGhlXMI0RIN//DLmGfX2o7PLUqF6A6TZzzuepl/yZLKtxOARh7uAzPOff+PO7QaA2Zt2K4KgtLL+7WtXds/Do4dZwnov09/x5DQeSnlgxwrnroN9wpaEEH3BxLVGARUchTUn8kTSMF44Xyn9iVC9n0PhW3a8/CbzZ7oEaeONOUXL+2a7e05S0fxfIOm8QQE8UouGZKhz+Okr1YGIG6pI3wsVffsyDCHDvkTYdUbi7V7NezRvJkHRo6pVHXCBc9pJhOiNmmxuEcwDDffGbwws9/loX1oZblQJpvDGAHcmzqCLrvcI+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(346002)(396003)(376002)(366004)(6916009)(8676002)(4326008)(5660300002)(66476007)(8936002)(33656002)(2906002)(66946007)(4744005)(66556008)(316002)(36756003)(83380400001)(86362001)(38100700002)(478600001)(6512007)(26005)(6506007)(6486002)(2616005)(41300700001)(186003)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I4KLWVX1qkk26cAC+GbQkXTgrZ3AjNREWPEXnViwOAJpU+KV5SfzFe3T1U36?=
 =?us-ascii?Q?x0x5ce9kAA+zvnI69s40zgcnWEXghIETiAWKTLLm7wdU18644+fLHdYONBgJ?=
 =?us-ascii?Q?LIr8wFDF5evWBTjQ+2motJxlBlO9gMd5Pk9J1toZXId4uc0tM2zAAHfHGTbi?=
 =?us-ascii?Q?mHaKM7pcy1la+9Z8LuFM44BIWrvu7KmS/y+xwIuf+5UuH9znEYVTg7UAEYjs?=
 =?us-ascii?Q?p77SY9RSTu3azeSQK9ufRfd08Tbt56pjYt+yfHWbMgr3JUgCupUQ635/IdtV?=
 =?us-ascii?Q?wj+F0ABO01HKKH7TlBoCL338Hz9Du5uZnxYSYwDwznk2hfGc1papS+UwVDKq?=
 =?us-ascii?Q?/LyITWC7Gx1zBpsU/1lWL69UJpYUKLN9UEQkhFalCJDOzQ3qIw4KpG95T+ro?=
 =?us-ascii?Q?NddDAvua1eRfIFYJlLXRooFB52yjRkfQiMAOGL6N2diuGAe0EW9csoFnBfEo?=
 =?us-ascii?Q?4OqscyO7CuUXa8VWMewvIToSt7IbO5FWg3fwyZTDH22Ec6ysnTCu8ZZK2bw/?=
 =?us-ascii?Q?ZYBw62gCPEAC5/pWoX+N7fboNWycEHym88sczr6F58ZXZLsZ+dh5MVEvyQUN?=
 =?us-ascii?Q?w438UIELX+ZfsO5l3vS7TcfkW7WyTeSFRSUMAJNBLZzjAnJPKHbJf4RNd3X5?=
 =?us-ascii?Q?PRGZbUyMw8grGNMu7tG468eiUq8bCHzhyWyRvgzr686S+WBoFi6QrlQYegDJ?=
 =?us-ascii?Q?1HJuiZIlnzUwE7X8Ryix1KukgKFPhfWzR2hme7x3cvu58yAib9JrVPi4Ydoo?=
 =?us-ascii?Q?rHjEL2yQ+ZMNtK5qL0HKcQtmUlD4vKdqQzM17DZk/+SVW5lIDmh0Yc0cF8CV?=
 =?us-ascii?Q?yv2h6z1ASHsdYE34CB6klsv08M3pzYqK9EPAd/4W2Hm6T2w2B9jbilTrZNH+?=
 =?us-ascii?Q?x/GNQgd/P0pfucZiCsABk7llnms9VpR8AKkoIXks9cuZYCHXBFtqRIeXnhB2?=
 =?us-ascii?Q?JP+JJZHNoQ+dkVP+3pv+i/d3TXLG6y5DkgXGyxlv0zLDEIDSVTNK/kCamULC?=
 =?us-ascii?Q?UJ6EmfMzNcmkBGs8dsrgtWQNnp9DRLESF9r8IeL/txDe/z5aQ4kuaU5I1Rej?=
 =?us-ascii?Q?euc7AjKg6CrtEPCfEcYe1JAhtIqskF09c3kvABQUXEdPLtMsnL1TiWLN8zO8?=
 =?us-ascii?Q?5NcZ0FzUDOOsmWeXhcONGHdij80Wn3ESixXDQ4uHwXblGHPAm83m7BAhHG4N?=
 =?us-ascii?Q?cryx2rmjbW7Gk6rB+k4GnNINnQzti7NrfUPIVpDwvMakLTYyjvJvxwZfBGKE?=
 =?us-ascii?Q?WIdWHmkDeANsnnyVEuLYwWRqjYORGpcnSDPmgUGrtBqubLVPIKnWIR/8LF0x?=
 =?us-ascii?Q?rB/IYov8cRCNRfNozn1c2HLqYp/+JRQArz+QhGKJTMEXdrhoPjEosYPsuIND?=
 =?us-ascii?Q?c8W5GfNex8z0vJW4yR4NFlUErogvtpmYLo5JiEQg8RwIKCM2l50UmlvZZoQT?=
 =?us-ascii?Q?Yr7OXFC9L6tKJAmZomYO5jf/HeaB2qgHc6sbKSRndhZs9wbX8YgDL/LgA1Q6?=
 =?us-ascii?Q?VtP9K5kaTcr0b/1dKVDDGltEiu9wVFO12y1NFvFgkjwM22nQMgum0zhZYLkT?=
 =?us-ascii?Q?yWmlShIc3OTBzBbv5FyPez3CIszv1X0PTU8jNrHL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7834d603-eded-41e1-8b8a-08da5dbf8a59
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 13:17:26.9169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yPXdXPKVWG0lfp2idC40tvbhYXpRy+dpUKwpwy2tkcGz2We1kZ1elv0Vi+ByYNsk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3239
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 01, 2022 at 03:48:12PM +0800, Zhang Jiaming wrote:
> There is a typo (writeable) in qib_file_ops.c and qib_sd7220.c's comments.
> Fix it.
> 
> Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>
> ---
>  drivers/infiniband/hw/qib/qib_file_ops.c | 4 ++--
>  drivers/infiniband/hw/qib/qib_sd7220.c   | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

I squashed this and the other one and applied to for-next

Thanks,
Jason
