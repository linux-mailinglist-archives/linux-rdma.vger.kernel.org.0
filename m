Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF344D9089
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Mar 2022 00:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbiCNXpP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Mar 2022 19:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbiCNXpO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Mar 2022 19:45:14 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2044.outbound.protection.outlook.com [40.107.100.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04580140DF;
        Mon, 14 Mar 2022 16:44:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YA0fLTotffon8ahalBinwDWvINdHRronrAqat4Psj8/nZhIVnR6+qnAH3+XaTc5cBj+v1zpfjou+OZpF+g2F7F5GG88FJxq2XyDu6etaxKM6/JFjmefYU1kPyuAG6KEYtTn2Bvq+xAvZi74vbel89xQHfSXEyyLvKTdz3CwjAif9XDNYjQbS9IbdsDOihEm2/AwpLmK9ssMTkFqnPdJMzsXiqj5MhsisUwwYuA5CLa9OfkkR1+VIq+rglD3znUxdUm4tEZwr60ODjZagWl56k8q/xcNSYZuSQyKtIemjJEirKgazg/AT+dNyRaS+u8S/cdZe6gjgN7EsgZ/6elRqMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8YyY5n+0mFpvici13nWHk7nfhonx62HwCzDC3oTXBtU=;
 b=XVtMih1NQPDi0ksUFBgp2wcfltxhzujByq4Xbx5AQUUfaWnQZqH86zhDN/Iw/hQdgQH24kUZuR4pkb3bO7bcMbowVbKjlPp1/R+TAp0rZ6tj9UoZJl/UrB0aPwSiyI4kgKOi7daQtthNDlTS5bxLgY/c/lTKksJICB0HUcBoaUdKJCVOOFIQ3IrorF7rvROJS7wHpbtx2AlXnLCauZ1PUrTkOVdB6q1JLGYkCjOX/04IhqMjVjXLqeIu+Td/ZJhBUt3D4hdN+s58k4rgpNvBkWA/zAirICMudEYTA+DqhO2FzWsiJpJN7JAT4+hboSm98HP5344AFLFTM2Whyraa6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8YyY5n+0mFpvici13nWHk7nfhonx62HwCzDC3oTXBtU=;
 b=ZILoc8YRP+B38e7euGM0xNtieuQBElcqwh1XtpZB/bRvm2IxUcB9vzn13CL001GmFysiIQr2jp29+NFse9X1jJ6QoPsKf1A/IjHhBsT+D30oXtKIL/P78JTLdyYiFmLGkY4CcX9x15BKBF9hn6GYaBCgVNFH+uCHbS6XfSjyaGf+xbDynoWEAteKObTdfz6nRZv0iX+tO+qQTQ3i9SlJgmAt+Z7RtqnhyVMlujCbAk9INhmJYaH2nZ67rs1g9SJ7quB7NJxJ3lDbqc3ZphTp5A39JDKCAde14Fm8geKCENew6/1HxGcf42II22qjtTuLiCGpWkScG7vtO1h3p+7lCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CH2PR12MB3702.namprd12.prod.outlook.com (2603:10b6:610:27::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Mon, 14 Mar
 2022 23:44:01 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::51a0:4aee:2b4c:ca28]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::51a0:4aee:2b4c:ca28%4]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 23:44:01 +0000
Date:   Mon, 14 Mar 2022 20:44:00 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/irdma: prevent some integer underflows
Message-ID: <20220314234400.GA172564@nvidia.com>
References: <20220307125928.GE16710@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307125928.GE16710@kili>
X-ClientProxiedBy: BL1PR13CA0269.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::34) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f079201-7ade-422f-b929-08da061483fe
X-MS-TrafficTypeDiagnostic: CH2PR12MB3702:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB370251CD75CDB16CB0C97B5AC20F9@CH2PR12MB3702.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L9MMxDnF6TU3/ie/EEzaguCCZcNcr7zFL4nHQQceLVUcogKOMeibXNzeeN4iAOABz2gI2LTREMQesDMV/IyP+WuJIAVsSpGHE5B6DzWm5Yb3XHsbaiPiKoM5CBV32rS8xlmxDPowknjmKyETsFfD3kPKwOOYI8cipV8tPl54WBVHZLuAuelfu6XdlsQrhmauuLsjYyDntECcvw3+eqUOAgkUVYRTCOryIvwKnMWQoiyMgm+dkOifBLdQGHcQ3PO21jOwqIG8Lvv62AnbZzEwq72h2ClI11gRgOkGg41BIQHIXcOCEcQKFvS6INsYnKBFviSiaZYk7p7//Uv+BG/e0yEri+mqzGn0ZK1cKdALZgkLumNi8xNdumViw51a1CxNxnSg36dC75FEpwqXaMJ2O1BcLGl+3FRXbda8qANMpsnDSzlHUuVv+X1TXwSv+x2UtBtC6vHSyIS40tn1Gs07W9zD3ClrhxQ6kS8GG1yFgO8ffaJtB5IxB2IO7yrl6yJ7Yl1d7qKbWj+lNW3yVDWk9DOU7234m9WEWBfcjOUi6oAVgIapn6XroAzHztb2NMVqDkpwJe87jojhGbt4MIiHeeRMf5Ty2pWvUEteDCQOGpKcWpi+DTKLnpNzxy10NjsbK/OnMRAlbdToDRlIZlRqQ8Jn4GVG3zM01TA4qdt3ij919PwfolBA0gjiWGugHZOigq8yQkDx/K/1tH6II0lc3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(38100700002)(316002)(8676002)(26005)(186003)(83380400001)(4326008)(6916009)(1076003)(6512007)(86362001)(54906003)(33656002)(6486002)(2906002)(5660300002)(4744005)(66946007)(6506007)(66476007)(66556008)(508600001)(8936002)(36756003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h2452XouyEVurTd7qt1/OIGLeIBGMU8e95L2z4tR1c7e0zO8VrbQH2kAH2y6?=
 =?us-ascii?Q?7INIrvTlMy4IIJlcyscu7GG8GqXO0TEicshbzW8EZmU5aHGD1mn1GTM8ykP+?=
 =?us-ascii?Q?Prw44IsNuv4FfhEfTjkvF3RRGYAOL9TXbzK4HtFgGKbK8cEmZhcPPSkrJAAi?=
 =?us-ascii?Q?ldvAG/kmhIERGVg2RFz0LFdxuVgNyeXb7Ct7Nm+gAnWyBnBw5sc8WF1Zx5cP?=
 =?us-ascii?Q?KQqzFM5v8Gnc7YJNeqnSJK+MP241/o3Pxt+ZvzLrm3yGxMKVofHtuOUmzN8L?=
 =?us-ascii?Q?9mveCRpKAg1mAhYRj+CbD4oP1muh2QfglGKTcAg4OP7tEkli0CSpFd/BBAuy?=
 =?us-ascii?Q?EpOyNBAdXWifsenib1th4oIr+caB/iG7trM289AqxmD69AAxpWcEBmVxVzNe?=
 =?us-ascii?Q?jqMwXjD5U5KZoc5+avBxVIHsrVMtOfrkS0g3z58CFXXs3O00obCuofLytbC2?=
 =?us-ascii?Q?s9V8TdIDWKLXkQjVlivtg+LsJyzYdvKe6BPhGVOboOM0P4iv+tl+uuul13Fd?=
 =?us-ascii?Q?RmIHM7h9EdR5aOWUPSyy96N87eG+83k8+yz9qFv2wn5HCGgSzFTZTo8QaaSv?=
 =?us-ascii?Q?o/vqBGep2XGucdm215xDxjAE9INAT4nL0wt4zUUoSHJU+TKQqeHl9w4Ku0di?=
 =?us-ascii?Q?iKp4Lkr4UahxXVLMV8zqkKeks40+o0NuqVoI3ax07/1nqUNHAu1wzTrnRC7h?=
 =?us-ascii?Q?hBttxLQSdnmwV8M/g3eSSTcl6HXr7Vz4BmhAqAq4QPCY30x0JdzdGzB/CrEw?=
 =?us-ascii?Q?nhknBS/5E8nwnheM+T3vWnjq70/bMGuotAQRhxXR2pEWmkIrcbqqEPXR4LD8?=
 =?us-ascii?Q?v9Hzqc8jVnU39osRajyTKOPU/p2x6mUe6r1qV06+AhmWLS9Rnp7BQNNefiyE?=
 =?us-ascii?Q?ULwZLe7mbf4XQHoHtjEhSm53mgxzKUl3O84yq0QKfh+3KzETG7uX44NBpvr9?=
 =?us-ascii?Q?seWzRjdJs1sSJw2Kj6J9/ZMXFRJ14Ih85zSQah3OW/lZ9Jk/E0vbeam+UPCD?=
 =?us-ascii?Q?g8/8HbyU7ViJlfBz5K9CTyRrGLf7FpWWk8sKeOpfKi6Ne40UT0Mon8qpPH6K?=
 =?us-ascii?Q?t9nqu2nhfIje5dWVG7S0zKp3iZOgqJIVq7MU/GcaqsWehgLob013wPe/CHmM?=
 =?us-ascii?Q?iecqhIZ43RlkQTZP8NEybrS5b+80Iw19PfSw85KPKg0lVeJgM8NxK1DCGAAo?=
 =?us-ascii?Q?MdNMCE1DzVLC6Lbwm2sOo7WPaSWQQ8lYTkNCfFFrMew0mUUg2ZmxUS3cuquz?=
 =?us-ascii?Q?RNkQqOWpfxoaX4rQUrj+qxtVzDch9UxXOjSbQJtCMPejaUanTy950bxYuX79?=
 =?us-ascii?Q?lpUIZWVT/0J4cZbaSlPvEwlsTQQDFoOWx/LtkQNwOYcwEUqoxKsnRMdQA3Iq?=
 =?us-ascii?Q?zbqNKVxmNdEeAUIMREwXTZLuDO5mvRHe95AMKcnIzoynGy+GL4Ig45DG2ikQ?=
 =?us-ascii?Q?4GVIfAQE8BfLb4+LrkILOCnqui6JgUKo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f079201-7ade-422f-b929-08da061483fe
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 23:44:01.3092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cbmTwQcS/kPIB3I7DmaQxeXH3VfMUfpYr8OSfh8VhhsBLRdrF+yUV/2Tjo0hms6a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3702
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 07, 2022 at 03:59:28PM +0300, Dan Carpenter wrote:
> My static checker complains that:
> 
>     drivers/infiniband/hw/irdma/ctrl.c:3605 irdma_sc_ceq_init()
>     warn: can subtract underflow 'info->dev->hmc_fpm_misc.max_ceqs'?
> 
> It appears that "info->dev->hmc_fpm_misc.max_ceqs" comes from the
> firmware in irdma_sc_parse_fpm_query_buf() so, yes, there is a chance
> that it could be zero.  Even if we trust the firmware, it's easy enough
> to change the condition just as a hardenning measure.
> 
> Fixes: 3f49d6842569 ("RDMA/irdma: Implement HW Admin Queue OPs")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Acked-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>  drivers/infiniband/hw/irdma/ctrl.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Applied to for-next, thanks

Jason
