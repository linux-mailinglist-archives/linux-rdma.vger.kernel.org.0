Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD39973E0A1
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jun 2023 15:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjFZN2E (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Jun 2023 09:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjFZN2D (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Jun 2023 09:28:03 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BE71A2
        for <linux-rdma@vger.kernel.org>; Mon, 26 Jun 2023 06:28:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b0HIJ22pXNKMzdj0FhTDdBPUx53x4wKJywsOJLOpiVrrMFK4mQeLOjDBYz0ePQT0V75CSbYCbN7wmvzjRHco2RBU/NoGSbIY7k/0MPfqZr8FetuJl55yBOnt66D3L4IWat+f8aoOl7mBCzTOf0wWIgQ3mTq9rCxL0MI9+oTs4ZL75blu4TuACWxaScDPgMvynAoNm0y80icyZ5lPTamD6yxEUD0aYeX6ywhjApINszScutUiMyDsf8HBKL9P9ynVFikG9Li7iJQWaPPbT1wC4WTNHo0ylcyx3Nqukuz3CcAlPG2LUjnq035NRSsw8ajJ4v3UAeE34OzDekUebYqbzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BhQmw/JlRbW1DhZ7VDdSUPU0PDRxDjGmmdR1Akxjaas=;
 b=YJcnJvuDhnl0pWiVs+bqcnyMNYSVhsQmqAZN7Bc32RtKKiPy17JU4KIN0JI3w4SVcvw+dkf8rPkPmEYO+0O7I0e9SRZANorusAjQOvYc1W4+T/vp2MvlOZZqNV3ImduozSGGUv+E70sf2lyagjXjqp5c4ixxGQg+dXb+v8hBYoLCbVup9+e85UrT3Rm++cOQ3Pk9JE4CCCqCFGtQB9TRaqdEjrBmxWmNUg+4TGF6ZDYxeInVPAWRxLNW2B/53jjTRkO1mKU4iOIGb/M839Kj9DDqxabvSo9EpPJ3jahRcJ9RjnY1488cS7z5GI9H/GhWTMOnTcK0FSPbYTMFJnXsEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhQmw/JlRbW1DhZ7VDdSUPU0PDRxDjGmmdR1Akxjaas=;
 b=srq+F955I8QyKfWhqjGuaV8x9Q7zzD4TpOvkT7/vppWdEGj5Mj1+6jj2t6rFDFOdqeLFioXBviRssldiY/aLx3MPR7yTe5kFkDJDkkJRAwy6TDP+XbFk4b2wMXsx+IKnc962BPvrqze13UURXNHCzk5riW8E/5YVp2Ysz5TVaIZKgfnIky5jGtpdcjeNJvCuhzKU19Vnxi+nB5Zv3c+cfh/rkyIWax/qwvoWScIP2ndiMD2LV83m1YEwJC8foKa/9e5hH9ALr4w1DgRRQz/U+5yHjb0YImW5Q+ntqvxOLDcDN8fveIJRQm6F07ITbtbJ/6sTFwQdtpDcJBWb4UWrNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BY5PR12MB5511.namprd12.prod.outlook.com (2603:10b6:a03:1d8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 13:27:59 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%7]) with mapi id 15.20.6521.024; Mon, 26 Jun 2023
 13:27:59 +0000
Date:   Mon, 26 Jun 2023 10:27:58 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Kashyap Desai <kashyap.desai@broadcom.com>
Cc:     linux-rdma@vger.kernel.org, dan.carpenter@linaro.org,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: Re: [PATCH for-next 1/2] RDMA/bnxt_re: Remove incorrect  return
 check from slow path
Message-ID: <ZJmSXiQyi9wbbdVP@nvidia.com>
References: <20230616061700.741769-1-kashyap.desai@broadcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616061700.741769-1-kashyap.desai@broadcom.com>
X-ClientProxiedBy: BL0PR02CA0066.namprd02.prod.outlook.com
 (2603:10b6:207:3d::43) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BY5PR12MB5511:EE_
X-MS-Office365-Filtering-Correlation-Id: f6057b72-c55b-4c33-1eb7-08db76492892
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hfoTx85JHpfXSCemrzP8VHpmlk5ET1NOtGGvFfXeoZnP3jpcHB3TNqRgT0NC9fwMp0TdJFT0YiE8CAoNFrlLD/SuZ8T02SuRkZrddykdkXIfsNHpAPIRbIdMIQkPJloVIA5VM9N3tNwCvcLhfRjTUS5cd9pK1RbujBjbq6UCtHf7HVdQ2ItzopBeJrvYPBybgzJ1rTqFnGJFH6M3PaAuagi7XthB7cCs5wHQjEkELKj8a/1nuWfwGg0x/K44hj+UYIwfQ1T9qydfFuiX2/asCJ9YrNlZ1UiuWNT75J9Jxv0pCvTANleVlGF7sQILQib1roXLr+20VfMN27Z/fz+S2vM9/x5Rofmm5509+h61EQ2OHgTPXaiL8DUhvATBQ8Hg/Yht/HpquPElQQK3MN/YZTmNJw44VaBWi0yjWcjuOgL3DgXOStIRgUYDPfbupvU6QO2Bjr3lQjyq9pL+OExqLoiZ+MFSFdmeMO1uqLEisrzvKlfn6SfdTq1Wjv6FHQWiPvLpJvnYPll+9dgl8ymaYfPDxFMmTJtaXhmBBzrYSIoQfD/U778WFHUqVP43gE/+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(136003)(366004)(346002)(451199021)(2906002)(4744005)(186003)(26005)(38100700002)(2616005)(6512007)(6506007)(41300700001)(83380400001)(66476007)(66556008)(66946007)(8936002)(8676002)(36756003)(6486002)(86362001)(478600001)(4326008)(6916009)(316002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zG9AXfUclDpYhdB/gapmDPgr3SnDO8WeFUNKp4ojkOaJeR1QOVX+zW63H7n4?=
 =?us-ascii?Q?XgEecErHoTq9F27l+yk5F25/swjh3xsRZ7OARe3ApMp1IwxkKfNnOuLUvZ32?=
 =?us-ascii?Q?RTspTk5kx3k3U5kLkLa6exxW45tx+0lZaojqWM5XT3IWZxXpySJZmGCslr97?=
 =?us-ascii?Q?cNeQo3fuVGmK/d7+oT11kzcF0Ma0tEz/9G3XatcvwE2pmfDiVPz1UdTYi6Q/?=
 =?us-ascii?Q?L4yleyxSfneewbHaNBkCqyjLZE/Wj0yj+NY88w6dYmwjzZHEVT+b5nea9i5Z?=
 =?us-ascii?Q?3yzYfU3yD3hQCwjiu5AKMw13wwhuDpiE1y/g4Z+RzCNCb/5zzpAqj18i+afA?=
 =?us-ascii?Q?D6XmvTFQ3GRgHt87GfbKnV5dkBoeGQX3rcDLLH/E6rsyn6FpgHgJ0cuFArDL?=
 =?us-ascii?Q?tmUbW3ZDH5I/F4ize2zl73rWSCsDF7BODYp7VA4LGjHtdxiSxh2jIj8MbjJD?=
 =?us-ascii?Q?cQbOjGzktZXE3tIjXXkIYacA+3YEJHEftSBA1ehawy46YBESV6MtlCYa3tBF?=
 =?us-ascii?Q?U7fkGF3DtkTmtIQuknS7a2HlEWKMyz0GKz97pLb1W+2hrCzmjLdSyvisizm+?=
 =?us-ascii?Q?X09+655gIFpETc8ZTMe25L0VBHKQl3opK+LH+9dObZ9wqzcgMJlde/6UDySq?=
 =?us-ascii?Q?m3o6Bh/Dvd3BB0NMR8pM/TG1qIaLzP7NYCNYcPWeQQIpuIix0eBRw4vDhXSG?=
 =?us-ascii?Q?VHyMyQPevKJCPuwAOh8p+Rey2IeyzaC/GZstO/+fidljF3gXsghvPIF1QS9o?=
 =?us-ascii?Q?H0aQ8rwS8/S/WgzkKt9awFxmfIvM/F8olCIqLXffnAGqrlZOYnPF02jfIW03?=
 =?us-ascii?Q?SFQvLf8CwpjoF9UANdoCsYxoLivGQuSfbSZnMDQ+635B8kYnEXP9tNnwmc6y?=
 =?us-ascii?Q?E3EgZac5/TPMC/A3offsZTBC6M70vP+vpMPmX3kloTt1Y+4eWBjVORTiNxsL?=
 =?us-ascii?Q?4Pr5qhdqzHRusKb5WBcbXJ13FPUooDeZtkhGHSzGHMmY8Im67Uw4VBA5YCa4?=
 =?us-ascii?Q?WNdt5YHaUYjJ0uvig8MmsMtjD3K0Gto6RY9j4mKfY3c4W4+fXXpaMhFsxtx7?=
 =?us-ascii?Q?nhiExi9ec9TAMMwXylhUEH1coVLq4vpINojVEEfWEf8QoKaYCUVfIHzeEwlQ?=
 =?us-ascii?Q?6qkZAUPBpG8dh7HsyrGX5L6yVUTab2aMY1sESYbJHIyN1QO0OSdVwEvYpqgs?=
 =?us-ascii?Q?4MUCAAIgXw9NG2QaDFpWlSUyziwfiCyy9sOY4fw+3RsjZM/N2jlPWEOISJ9t?=
 =?us-ascii?Q?vlluA7EUsc2NjxEySQz95jVCMQWSfMzNcKjTqdRdYPdiVIBTQsykWBI8si7s?=
 =?us-ascii?Q?Tj4HrZRdLlHMydYyP6qN3BX1cFMgmNSB0TIi3n2Anh3mvBqvkvbkW9rvjIAo?=
 =?us-ascii?Q?mRGWX/lRMEcNeQoF6W2Mvd2pyo3tz7mbqICKQNzDsHXALECmXx4MTQmd+yN4?=
 =?us-ascii?Q?LnKyTnjZb/Xw/YbJ8KgWbAZvXb1ne7/kb2YygRyjZOEMYOwNXyTIIjZwDlaI?=
 =?us-ascii?Q?qUHB5i01faECGZjFhxDK7NoAUAeTJKHjZ7OhWsl/2fXzithdx/FGXVyIhAdA?=
 =?us-ascii?Q?p+wktk5Mdl1w9nqIcCPi8ryoCDNafjYSOg7vdXpj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6057b72-c55b-4c33-1eb7-08db76492892
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 13:27:59.2423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YerqloQeI2o3tS5SORa0UvA9AN7kU+hrF1cmh9lhuoiO3wmzLp4B2HOGpGbIiH4M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5511
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 16, 2023 at 11:46:59AM +0530, Kashyap Desai wrote:
> The patch 691eb7c6110f: "RDMA/bnxt_re: handle command
> completions after driver detect a timedout" introduced code resulting in
> below warning issued by the smatch static checker.
> 
>         drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:513 __bnxt_qplib_rcfw_send_message()
>         warn: duplicate check 'rc' (previous on line 506)
> 
> Fix the warning by removing incorrect code block.
> 
> Fixes: 691eb7c6110f ("RDMA/bnxt_re: handle command completions after driver detect a timedout")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 6 ------
>  1 file changed, 6 deletions(-)

Both applied to for-next, thanks

Jason
