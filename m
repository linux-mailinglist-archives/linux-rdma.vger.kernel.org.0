Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1640855A50B
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Jun 2022 01:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbiFXXsE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Jun 2022 19:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbiFXXsD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Jun 2022 19:48:03 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C4D10FF3;
        Fri, 24 Jun 2022 16:48:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P58mx/QxscRvOf7/MQz8NXH9blqaAYKBjYcUnIGvqAnWIgB/COnluGJ49g4AhcUE+10aCByQpfa1VHznV0N66uE10bzmPo0Ym+mgkEa73Q5zfMgpvsEtGGjwhArD2TPAjOHgyNM+ogFnQLVJW9Nwohoxf5jc+OK61CayLSCbMpXBsBVgagoDZjq2o3BiQ0oHlC7VAk9uK1LTxS631KmRgGzMznWDjLX+0sg86dWiW+ndE3ou2aM/vtfaajEoDSfd7fk33IcEkClMt9g+iT6zlLFHEsAtGw7cQTWEQ7N1lWw9wU0+IcShzpcK7JHCp2GNvWAwQe0MgCSk69LvjrOlGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cjnuR4clkZPihHeLF6xwxgcVEc2H+UZpxar+JRNbxRQ=;
 b=JI1LLmvC6+s8cICijX6GGP7Ns+O7CIjwLGuuN+w8bKcprJYqlPDDhhxOl06wTaXKFDDFNoG8YWQ3e1bKMNCxaONG6wtBDgj4nwZ/iUwOUsAQ6JtxAC0oSVEo02X/MxBcBCKTG5mpiM+V2I68bS/SCTd59jVZ2w6eVbdH9hAeT/07O5KYx2VDJw/W91fyUpJREjE428TQH/DvUILrfEoH8sJhfylNIb+eEDhJ5A1F3FCa4qLHhfY8Z2vpE05H6pGpxMG0Eyi2eYbvzq4zZxxYjQi9HO9MJ92t7cXDp9IsdkW3mA4458/Wy/wOnDu36N/ZyJLsXiE/zDhnBFvDCyj91g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjnuR4clkZPihHeLF6xwxgcVEc2H+UZpxar+JRNbxRQ=;
 b=FCHxUWhJAwRZuA2m8OfgSTIOMy5v0XdW9k19CP8fLwPxWVmjr69cV47Srgfd+3tIGMZtoxr9jFsERonYZbFbtpbctGSqqqbmeGi2/nuR0mMSP87osLdiVCPrXXC5ffujFNgtxTFyZw5G22EYopUGCs6PLSPhpiQAaqnwP/mwBgJLjbBngAzMzlciROAJyyzv5jxSIZCY7alcuYXDWbcXGwSVEWLyjNPvhwz1vIoeUzTDuv+1yxnZyTR/lWA9wDHZLccKA3a5NX1WqwEyyxbx6CJLBdO+wbam0TcBzoX8CcFUmm5wjpIPTO7veETHwGXlQBzvgMmnP1Ft1MqfJD+M4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BYAPR12MB3431.namprd12.prod.outlook.com (2603:10b6:a03:da::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Fri, 24 Jun
 2022 23:47:59 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb%3]) with mapi id 15.20.5373.016; Fri, 24 Jun 2022
 23:47:58 +0000
Date:   Fri, 24 Jun 2022 20:47:57 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Li Zhijian <lizhijian@fujitsu.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] RDMA/srp: Fix use-after-free in srp_exit_cmd_priv
Message-ID: <20220624234757.GD4147@nvidia.com>
References: <20220624040253.1420844-1-lizhijian@fujitsu.com>
 <20220624225908.GA303931@nvidia.com>
 <5a4a42fe-c5c8-63fe-365f-e6c74a279cc2@acm.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a4a42fe-c5c8-63fe-365f-e6c74a279cc2@acm.org>
X-ClientProxiedBy: MN2PR12CA0010.namprd12.prod.outlook.com
 (2603:10b6:208:a8::23) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0b448ee-4b30-491a-6fa7-08da563bf7d4
X-MS-TrafficTypeDiagnostic: BYAPR12MB3431:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +saHGIOFqU0nF09KBdlQ4zrRlI1PzM4mq/+c0cC7gpfksHVU6p0rRFGT4xku8QNLcBT5OZRKOJU2lTvvJpF0lUQVHRYRjmwpYJSGTekRj7HUjTWD7/BITHx1UanbVoRFCBniZU6yfecFqS2Fh4r5XofA434y23BHgK9RK5Y+i0l3nNo1VnIisN3RkMUCQPDv98SwbSDU59PVJtte1zpl36+gBqkcCK5eLOKXfKUV1mMGKH8VFN1eSNqvPMI7bRxdY0FpTphoXu+X2Q3ikVrmjJu3GbMeFNSlHkAfOxpGxVUzw1IKMBrWOlt/4HEpiw3ZZ26FQSpI0S9vk1B2UgCxRTsSFPg19MrlcXab56mY2uXPS6uScUrVQp7aWSXzJ9g+rnaFjq+gDFnY9g7D9tKvIrkNXLOoJtYaeNqDYnDV55j2IKiYunxIjDbMDBXYVLZwVc++wJN13tKjSmAlV99UKGTTSpi7WQ7BPOct9zUTcL4+O4jSaSi3+gGwLQdzY/WevQRY1zu9LlIhXS7yrTSdDGL0pQje/cgYHBmWnqaKM3x4YEh4la3k87mD9iebVogYjEDf/xFd5ykyGxhbzyteP6JPSgmhYM5gZCxLLetVaPbW1gZ5INOfzPx6C5Uzn4sEZZdzu7sX51xK+ppfDKNHPpbZhGqk6nc09+UOYdhVZfyWiE9hQ67hWjSJHuUKsXKQbb7RXUK+UpaVZqnS4F+M5rRN7e0T2qJfW3zOfff7LUI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(39860400002)(136003)(346002)(396003)(86362001)(66476007)(53546011)(4326008)(2906002)(66946007)(33656002)(6486002)(6506007)(478600001)(6512007)(8936002)(4744005)(26005)(38100700002)(5660300002)(6916009)(1076003)(186003)(54906003)(316002)(2616005)(8676002)(36756003)(41300700001)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TuRmu/b1eSr0mA5GnD2NdgnKfJRXQBlVlHDhU6PkBXVohsCJ4bIP15J2kPDg?=
 =?us-ascii?Q?F//4coGIRcy78IDurGXuBW9Uoby+iH+mKUuBf8IsFMG/ibJW67QaLEwDpRCb?=
 =?us-ascii?Q?qOU0axo7Gk6u91egDYqN8x4/Uzs16jbtPo1ehD6kJH97rO+WMRBA4qfI6ayP?=
 =?us-ascii?Q?WR7JKw0HWV9/mnHRGAMHqmEEedXkW6G1YmsV1HKpsUHOKDdOSf3S5gZZYu1b?=
 =?us-ascii?Q?FVUIhyvtAbHn82LVvEg/jVcOLkq0NZJCbcQCBpdCzGqJa1LoOloBnVZcpASy?=
 =?us-ascii?Q?hKK9NMW8++373WViVOMn4B7Nlygsz2l/mSvOgslZP2X6tMsCg60AsdQsQfZe?=
 =?us-ascii?Q?beFFFxfgEt8ye2L7GdFNemu7LYTdIQlPAXmZQw9aSvXYRtFk2g7UyAf82Do3?=
 =?us-ascii?Q?6tboCappw6D4xFWqNJiQnTK7+j1KQgyq4e4yau1oKROvzWyXdMC+DRFRVWsF?=
 =?us-ascii?Q?yKji0g6NsWvnC72mm5B+kQU2lcCmxtbGwuZmkVVeETkbCdrPqJ78P63C5uDu?=
 =?us-ascii?Q?khdDYorwaiwlrsOs55wcCb6HJPcWiiJiLYo+1SR5xWe6orPFP8v8/nOmK55X?=
 =?us-ascii?Q?AsEF4zkLeAAKA4u+MKQiEFlkZxcr2rKRgYOS3CYK3yAtexYnE68k35KLePe7?=
 =?us-ascii?Q?zsFveLZBfV8loFxaYsR6Lsa1hanfzMBqf6IBf3dPq4k5W50YYV10poFO9gtj?=
 =?us-ascii?Q?YMAzOvBpY4PfPB1M6XLebZSSSP8PPCxn4Da2Is3WHOd+CQ5DFYwGaB0Pw1tj?=
 =?us-ascii?Q?0AGGXRnSY1KJG9oF37Piwvk1OzmetLKS+YX6Ii42O12Sb+QMNmi8puNyCbZM?=
 =?us-ascii?Q?pHSLeWuR/FokjJt8tLc/vxfOavS3G74d2sK/Wj10EvYhZHFWMa7KGkeVwvFy?=
 =?us-ascii?Q?JCD4Z+6tvQWBRKh3NwG7yiOejNzzYNJp8hsmmEnRwT1rTK8Jn3BF6sT6W2Vf?=
 =?us-ascii?Q?pny2TEPpXpmB1Sl9Atpwbcm24kxrADCDmYDqD9DiIh6VOa4mEOERgC1u3Lge?=
 =?us-ascii?Q?qT6tJmgcGB5Qu696TRMT7EgmVS0/YCI2I6kpRu6u/ECktqayI0sKeh99ZvBp?=
 =?us-ascii?Q?ttOOOG7YlQyM8CSKNhF+CTyNDa25Ig0H7jxOWutRFyFnDPPHy5/pD7N683cM?=
 =?us-ascii?Q?GuTw9Wnqt6C9SVCXzDnMZ+zqGW7c1NCsn6UmaqNc0PeTTHAS9tnWDsQ4X3H+?=
 =?us-ascii?Q?F0OdeG/BjSgGvNUh2TTe0ngP3YcOzbxGOpuTQZ6dBO/7zAsJ+EQWqOvMvUri?=
 =?us-ascii?Q?cZq8FeC25lwOkkshxI2ohujJe+WpLPxVCqxK4PoHUUU8UqVxEOxtilAO0Pv+?=
 =?us-ascii?Q?8X362CO9DRjMXqugPpQdX30mEQW/EYYorCf3TBIpHnxUk1U901AOJpMPkywQ?=
 =?us-ascii?Q?q6SFrrwST9tna3GO3a/2eK4ZmcwIWdRudZjuWTz5r9mdr2m9x+iid1RibhNa?=
 =?us-ascii?Q?nlPm6ZSrmCeFT0Q8drGZ7lW3H7TPptFt3NEE05pmdqHFazndOGNdIEpMyQMg?=
 =?us-ascii?Q?bG9ud6na9injwJbngYRZnoHtwl2HkPpooXypPy6ZAGu/5p3gUKJc4XxzxWCT?=
 =?us-ascii?Q?wFUvPMNEftGiSQ2vB/arC1qSvp+u362yuNDW82z+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b448ee-4b30-491a-6fa7-08da563bf7d4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 23:47:58.8849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ijMDAfg3dz4z1wrdtG2XbJ0LANjY8Bej/a6xHHqCW2S1Fn3dlgY95OvEEM+anxvS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3431
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 24, 2022 at 04:26:06PM -0700, Bart Van Assche wrote:
> On 6/24/22 15:59, Jason Gunthorpe wrote:
> > I don't even understand how get_device() prevents this call chain??
> > 
> > It looks to me like the problem is srp_remove_one() is not waiting for
> > or canceling some outstanding work.
> 
> Hi Jason,
> 
> My conclusions from the call traces in Li's email are as follows:
> * scsi_host_dev_release() can get called after srp_remove_one().
> * srp_exit_cmd_priv() uses the ib_device pointer. If srp_remove_one() is
> called before srp_exit_cmd_priv() then a use-after-free is triggered.

Shouldn't srp_remove_one() wait for the scsi_host_dev to complete
destruction? Clearly it cannot continue to exist once the IB device
has been removed

> Is calling get_device() and put_device() on the struct ib_device an
> acceptable way to fix this? 

As I said, I don't understand at all how this works. get_device() does
not prevent srp_remove_one() from being called.

Jason
