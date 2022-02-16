Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B54A4B8FD4
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Feb 2022 19:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237400AbiBPSFE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Feb 2022 13:05:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237393AbiBPSFD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Feb 2022 13:05:03 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99A6293B50
        for <linux-rdma@vger.kernel.org>; Wed, 16 Feb 2022 10:04:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQC7t5MyQgXl0MGSHgFYX/ipEn1GlIHy6WYCz3Q3KTHrqCKUDceknLA810wSXMIzjwYYs6gzD5cg+gn78G1TACisJmxvM7LnMIXS8UrQyQFwUko6qjhYn1NII/+VS7TUnR+sFdAV8DREnxOW6GT2BCPVp/N4fxLok8BRR3Dkm5GCkWr4AORp3d7bObo9THKI7QlxLlV4/hfiPSmadpaZVYwWSje3PkwLeJ2nW653yGoIoRwAlhrF1NrwOff1y7mGCLXuuPjr5URSGsYo4VYmPzag1dufBKGaAKG2cdke2gvISoXp4KgmjwK7QxWON/PnvXCodrDKwKsJXuDB792k7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g9tQ50HbfLQYc9MuU/qOoH98xmMQxlY6Xh9ZzWZpB9k=;
 b=OjsqZ9U0KK2MWAN80tyrZ589UEg7milUx+shqNFZjzu3PVe7a0wyEHtUX5COS4snotxwwmw0VuX/R4PU92s6LL23tPjCA91PiYllkMg7LYSmz+Fmoc2fcfZUqb/zPXk6HcD2ipo/XFsRyg1M+u1901t911wdrQEYuCmmHehkwVNiTIbraMmfm4wYyyT+xy6kK5awgTiH31iZFL0PavN07xNpmDRk7+OVhoqztbsaJkLDgvqkhHBB0YW3lLptPgDnetoX+Pj06zJcftmvkliWCA5/X4JKi9iuQ+s6Icevts9yuO4+Lw0XlXfeu+VK5NT0tKKdc5wrgbSkjuA2ULKqDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9tQ50HbfLQYc9MuU/qOoH98xmMQxlY6Xh9ZzWZpB9k=;
 b=RLqf+gJgBIKsYeumyj9/HDCpCdiE8BgviXLTSkRbW+KHz0u5CXrGNdE9A1KTlBD63uD1jitFFCMTox8k4wpbG4B23eLDCftcbpvuRqzNoyHQDZGYktFf7RWfZkd30vjYeUhEvVzGOE+H4tZkI+S3D4Ekd7JdnJJTN4bJUmPeoYwgBUlOJe2+n/+SOvzRCAv2jvLiJzx9G9j/lse+1hR04/gNuxLeQIS0nI9gZdo9bnn1STMcKg7AklOnP9XHy4fdO+51nme8NaKFK9pWR8WOnEAy3EaqIe8MiM26wOwAtBot9/fbkb6nH9K9OzT0htM43JarT5iOsCqBl7y361QQ1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB2905.namprd12.prod.outlook.com (2603:10b6:5:181::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Wed, 16 Feb
 2022 18:04:48 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%5]) with mapi id 15.20.4995.016; Wed, 16 Feb 2022
 18:04:48 +0000
Date:   Wed, 16 Feb 2022 14:04:46 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Md Haris Iqbal <haris.iqbal@ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org, leon@kernel.org,
        jinpu.wang@ionos.com
Subject: Re: [PATCH v3 1/2] RDMA/rtrs-clt: Fix possible double free in error
 case
Message-ID: <20220216180446.GA1270953@nvidia.com>
References: <20220209151425.142448-1-haris.iqbal@ionos.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209151425.142448-1-haris.iqbal@ionos.com>
X-ClientProxiedBy: MN2PR16CA0061.namprd16.prod.outlook.com
 (2603:10b6:208:234::30) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64d4520a-de36-4e53-8d8e-08d9f176d1e8
X-MS-TrafficTypeDiagnostic: DM6PR12MB2905:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2905607287490070FFCEDBF3C2359@DM6PR12MB2905.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v71IYl7hlri8zh82C5VjQ301zCnAGC6I2i+TvR+lY093O0+751bhXbzszcuyUvj6yOW3RA/LnnoEMLnHlBZqtMCrz2HjP4uU8jtCywPnq6Ovff1TA7UDP3ZjyrJpKiflh5IeiAKFT483vzxsqNdUQxJHV/TL0/plSQL0wKTx90O502cFVF8iqA12Kp8oCIYP/K1XVs5ims1vtsRSFiooqJyW80grtpTHKPJ9sVybWQOaP87RBsbRy+lHPsy7Ce28GlbTWs5TZxqaW72G9MbEnMI/0O3Fci8c5ClFZC8eLVo6Q7Hz1TfPnUFKPdW8YHM1NFuSZ+hPl7jAxAYPdWl85XHpriu64+Z9EPIjdBo+6q+4Ijc+Pqkgq7rv7jY5pyIbA0UlW76beg6WbbNh+tAGJ1uC/Iwq8mqO57j4xZMgjdD6N0vAI2fh0wn3cK41GIJwPvIacJfehHJdTtaKAF0WD6JtUicrdWr9le8QR237mXWT6N928iHQmGF3q4DRsye1N5rdgeamw3h6y5bofm5kvCCnoFb9b3/sGgw4RJC8nRuQjYuADOICuL0DavNupdOtvMxZFcWalajDdcR9KR52+9PRiD4XZ4GDSo7qyhvZdda8wI3SV4JmABljoMqAEpDOWsls6j90cN4Mg6rQgyHLnw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(66556008)(316002)(508600001)(6506007)(186003)(66476007)(6916009)(2906002)(8676002)(33656002)(6486002)(86362001)(1076003)(36756003)(6512007)(66946007)(26005)(2616005)(5660300002)(83380400001)(38100700002)(8936002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OLGlGOwHYEiWYhuCA6n7hJjPjWgR5naCYoFEpb+9s725YKpXpRgIhP2wfcK6?=
 =?us-ascii?Q?soZMfkYflexOQnbysV2Wn5ALifmAdkrgLH1gDLxqRnXbMZXCNrTQdyyyNE2q?=
 =?us-ascii?Q?zkN6OQyHlRbKLq47Cy8vUDDPC4Wlj0/K1MIKFhLzjSzAyUKLJ2C3aorrKK3f?=
 =?us-ascii?Q?+SZC4MHJn0P00huzuzLgZVdGo4rN4grKnboeq2Vduz1F3EXeDV9SDpVn59a1?=
 =?us-ascii?Q?55xMCw22RvmTJyVv+qzyqFDCiUoNPvG9EVkFulnTUts40BCp5FtjA1OCCJWF?=
 =?us-ascii?Q?juziHdjwgFA06ju9LfM7iIhgWU6LIcLxLE7GxqeRPfe4hKg8hJfp2c4nonco?=
 =?us-ascii?Q?QxrjMNtwP3ph7OkR+pDwpxSxpvqlovRycKJRPMC5oKPGfU+hoySMW7LyHZzL?=
 =?us-ascii?Q?dXI367wQFY8agMP08JTSXW0eo7SyxFDszMQ/SWLMedihUwAC8srKMA140tjs?=
 =?us-ascii?Q?HIkTqfg+nKDfc5/o7P6R9nChbFcMOJNtwxzBkNgDgxh8N3uPjRLZYz2zRgtB?=
 =?us-ascii?Q?w3IV9Jh+XiEYIUBW0GXNcT4n8S563iFZdwQRMKrDTRqbmZOQrE0jxtTQoW6+?=
 =?us-ascii?Q?EHjp5TYpeAxaiFyS9LBiiuNdmRGxsrzvuNI0eIYgsbJb1pjJCeLqniKYMCCK?=
 =?us-ascii?Q?e8pAyl99xp4xC8uR5T48WSnAdAeIcv6X2cA192bxnFcBCTapbRFdIYntIigG?=
 =?us-ascii?Q?4DUJd0/9xOH4Qch3yugJquoENEAJh10k5QIbmzLYT4oQDtbHlJre2UvlR3BF?=
 =?us-ascii?Q?DnXxXFyvHHZDEXcZ0uuedYv/oNAAfDlHPUCva0Z+mVPfJ4Al0a2ymaVkCvu7?=
 =?us-ascii?Q?ivqvg64y0GD5/dr5oORw6O2heG8cRwuK63VmVfOza4ElRz5u998hTSZhD0Ks?=
 =?us-ascii?Q?Z3GuRjc4+1ZvowkD0YvDIwiSZklA1EdHYluGDyUWjZl0zbtGoZvXT82G/weM?=
 =?us-ascii?Q?Y0l180wWhXEpqWBDZe9pNLeWiFrcJlFOl5y9sWBTJEwsSpNW3FUOLWDJB0L+?=
 =?us-ascii?Q?/hnVLe/321igLg7o0Cyu/NlGcbzK/GZcYWBMRHtjWf+LzxTH5KTzcl+7PmyD?=
 =?us-ascii?Q?NWy2qXiaV9foRsKf5h7oHLdGj/dJinuoVi+oVJ+EBJqDW0R7QFCrsQiU3LJS?=
 =?us-ascii?Q?yHrIXiK42MwOnW2YQd0UWm03guRlhowITys3xMxQSb8dZ86HSuaKEt7fRtPz?=
 =?us-ascii?Q?aiSyRs/5hUkji+9ZD7g8+KyzJTxlJVimC1g9XdnhKuzLkTKyc2+liX0g/jJ5?=
 =?us-ascii?Q?5VMKrZ8DLRqMFuwT+0638LDipIqV+Za7HXlcrX23P8GiSXXTyat2B0MbQrsD?=
 =?us-ascii?Q?8KYWnEZ6YhRlhZPZXbwvD9j4LA0kE0suqVsAaOA9Ma8vDZxTrGJ16nR1cK/s?=
 =?us-ascii?Q?eD9gTiKQcgshOJZknq4kw0AA7kITKiOkgYfNP7aPo1CbwCEzMfiB7shF27lu?=
 =?us-ascii?Q?delzDMMqkYsiUOuKh3x0CT+nQ1Fxg3R2meCIaISZ/foUjKHwiRNwsXV0uqgs?=
 =?us-ascii?Q?n/LtgcPHKHjhklFRyYzs968uGYLMxQSJ/ZjgnCBKlObRT+gjZzP6AYHCz4Z8?=
 =?us-ascii?Q?mIeLPXCKbuMKd6kpXP8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d4520a-de36-4e53-8d8e-08d9f176d1e8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 18:04:48.3980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kaayH5B+esH6MCiQYiQd5zc9qzHPORWEU1PBGCuJf96xbeQ+v9eMHZNnfjhYsuGI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2905
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 09, 2022 at 04:14:24PM +0100, Md Haris Iqbal wrote:
> Callback function rtrs_clt_dev_release() for put_device() calls kfree(clt)
> to free memory. We shouldn't call kfree(clt) again, and we can't use the
> clt after kfree too.
> 
> Replace device_register with device_initialize and device_add so that
> dev_set_name can be used appropriately.
> 
> Move mutex_destroy to release function so it can be called in alloc_clt err
> path.
> 
> Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 37 ++++++++++++++------------
>  1 file changed, 20 insertions(+), 17 deletions(-)

Fixes lines for both patches?

Jason
