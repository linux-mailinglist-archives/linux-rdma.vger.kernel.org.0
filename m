Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567C56643D8
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jan 2023 15:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238745AbjAJO6N (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Jan 2023 09:58:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238497AbjAJO6L (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 Jan 2023 09:58:11 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FCE5930C
        for <linux-rdma@vger.kernel.org>; Tue, 10 Jan 2023 06:58:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BqfeYGkgEcL7HfsEwbK9BtldU0gKrVgXJKFkXDUcak/da4udwXT2NleD2bsMMottSaG80GbBZ3Z1MONpZ7UR2UeMRRMthLA3VZMV9G3JLNj51uPXxwk144DpmWb7v0Y6lO3kjyG7QjpPYCl0/2+/wGh3AHWla9Cea3H55ePFBdGCZZgve7Equohk0+fYk+qVzjJ8jj7cVPCXwLCutosenNxwZnlZQKfzgKpIQx8N0fLXm/5SsAWAEPPXPELaZoysMijYyZUT7DJe4J/N6sUYC1nbwIo+mBS55nGciafRjhczym99FLw5hT8Gh+IuJpOj4zVOiF+ReQ89uTOfZP1oew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FRRidUy+lqMjg8bhl9+7G3jpSV28ga6kRwHgNooliJo=;
 b=Noc44IuEP/I3hF+UIedh5IkaKI0rCnMstgAqCF7HJTGz6zZjIn/WVkUD3AXBQa67K7MB1GswdNZ+Zoda6ilcjSy30almOCxoyqUEmK8Z33qCQcReTSJjzUIJ0Zn7GUzbEkfxD/zFmMAl3U37M01CRS6dK/DbLI5kC1uInyyAsH/kUJ1vWcnm2TbNduVhRunAmgl/3/GPsFlaHQ6P84fJvMRKlc5g2f/gyeVmZma/pach2Mfr7p0Sggarx2BCjoH6B9ugfpOT4+H6woScXuUDMpT+tZ4iaZTw2SqgD96mu/lVZyXIGqYMuGVptTnZ1e0LQGT6swbTbw2Bwrsa3WhbaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRRidUy+lqMjg8bhl9+7G3jpSV28ga6kRwHgNooliJo=;
 b=hU7FOvQj8Rr3oc4z429U9stsrNOjmyC1qiEXNkMeGRKYTOMDK8vehBZoI8vZ/uo3SsAage6rintDqkCFa7Cbzn5EeQYRm3izs90IAb50Hq0NhmjaTd2excmxaXA9r5mIeESvM1IyuKed9dpyKjcYJO018PsZnVCHKACspZ4egYyo0nxY8kNkhtzKzFVe0nJAFy0uw0KyDReBUdmTfeGimW+a6I/GIIOHsVI9y6Ijha3vVBKPFZXjGp7RAgHNvh9nUsyOt/4YgDVy7ACutf8gyTaoDYT9n8LO15ZznFG6JWIkSXLYPa+IsdZxOCntpkQvONy1Il3r+h8rOpjdkoq+ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BN9PR12MB5356.namprd12.prod.outlook.com (2603:10b6:408:105::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 14:58:07 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%8]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 14:58:07 +0000
Date:   Tue, 10 Jan 2023 10:58:06 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     leonro@nvidia.com, Dean Luick <dean.luick@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 0/7] FIXME and other fixes
Message-ID: <Y718/h2uSTYq5PTa@nvidia.com>
References: <167328561962.1472990.9463955313515395755.stgit@awfm-02.cornelisnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167328561962.1472990.9463955313515395755.stgit@awfm-02.cornelisnetworks.com>
X-ClientProxiedBy: BL0PR02CA0050.namprd02.prod.outlook.com
 (2603:10b6:207:3d::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5356:EE_
X-MS-Office365-Filtering-Correlation-Id: bdf5ca09-e7b5-4007-f1f4-08daf31b1574
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fCGusUgYXuAHwko1lRPrrAzcVCgpA4MvxFKQRh122S4CsYX38Koqu24g6Xn3ywPdIh18OOHL6OWWtG97T10Q8YNpyVMkRPwbcnhLqFxNlG6SfO3EnMC480pomw9glMcG4aF1pWE6D3wqII5a257e1lE21WTWPNhj+io6tRrOI6Ena6+Qd8uyNs+FraI5Ta5GePqz4eTM7ZkSdWY7j6AFVtOf5HxqRdIohDVIAWschyzAsGcXzXMsRRU3WanrLyx6gdWIxp9GYwz/yzqeO72yWmQQvTqDEV87Pud1RiQ+RlLboB3w82EJ3Qo2dHllS6bMOM6rzZbSShqLHHnf+KEIhEjVDsx3e5y8zeWvX5tlQD1hvKvw/LQNUSAIuhyS6EtJjRvM+fG9UMa1nUabHWpjZphqIiFdoPYwQ6itD6AQzMlgUFt7TrroTgOKGoztc+gVQOL7qWx45nAgyuctNqEHuzqYf0Bbixz287UkFpG8U3yRLt3mPAt42q/z8fC1zMgDU28nAimfCV3ELYDtyO5cLuz3B52Y+etcY4uC9YmE+zkzbMfC+zWnKYdwjWRHN/SASyVEYaxFZJA3SyK8VH72xZB9Mg4G5q9CnEW5FXxuf3EcMZO9MDf8+88X/wWWnXrehC0zTnYUwsIH4aJIkEFm6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199015)(558084003)(6506007)(26005)(478600001)(6486002)(186003)(6916009)(6512007)(2616005)(66476007)(8676002)(66946007)(41300700001)(4326008)(316002)(86362001)(38100700002)(66556008)(2906002)(8936002)(5660300002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vMhhxG/x+gPTHtWQRLm9AC14fQhaY/aQOCK6IycAMfNWIyDY3glmtLMtmf8Y?=
 =?us-ascii?Q?PPxQKLyozLRetKtFeM8DxpHW0pu0LgZGAKuGF6ZTDwY2/DlsdnLQeUAotuAy?=
 =?us-ascii?Q?d9liBn59SxL/DMk8qJI8UjBxIeg+GCtivgllAD2unryiOCQ0kpRkRWUCeZHG?=
 =?us-ascii?Q?I5HNKhvFImACHm8oCZG1pUSY9ntzG71/6smNPcIxY8SVUtKTz3JUEOdUIH4l?=
 =?us-ascii?Q?MJZKHaO9Ix81awQAdzSF8WhuTeIMYELMLbtpRpT5+6EQ2CzTtdoyDFqisnfH?=
 =?us-ascii?Q?TZ01KmjjUik8J7NggvLl9hXl8/kMZ/uGDIIjGkGdLKQQjXPxJATurDo0jG4v?=
 =?us-ascii?Q?5GESF2OHgyTPaTfhiTk2f4lu+Dm0uDkhvtfofTUJBUCoub9+QbKWyD8wPERE?=
 =?us-ascii?Q?g4JDEaNSrC5hgubbQRzdXb0XFEBa1kJETn2xx9f/rz1KNdYULW4rmOxv4Z6/?=
 =?us-ascii?Q?RD0n9bclqqK0DTL9Fpofm8gZA9eJhGAgmbFZ2CSym/SMBpTCaLx6NXtgwa08?=
 =?us-ascii?Q?qxoYqmPDzJFjFU9scQzQGxQgs0Xf9KDndT2+5H+afNvITCDqFHaQHSBIvcUd?=
 =?us-ascii?Q?/9JuGgqNyoiy50cDOdk5h8B+rRHLOXyQqcGuwnWiwbWW4tdUA2R9MFD1NRAs?=
 =?us-ascii?Q?XE6wlRr9VziviXXUGmivpF+hhlRu2j2+XCYALW1r+M8AI++rDOcObyfwP2eF?=
 =?us-ascii?Q?BKBvcdTpygDiMZqEh0Gf9TLRxhPYsjMIuN11XXvgsdKlRT+VzbYQCQrrwTv7?=
 =?us-ascii?Q?T49JJooUU8lT5L73z7DG7Z9S+HVGvEhy+8TvKB8YiO7yBFxuinFc5Qd38/DA?=
 =?us-ascii?Q?64Z0vwCkgEfMRS3YEJq5LmFZWjcgCYA57nHQKLCVL9Bw86iB3k/i7AiVu15y?=
 =?us-ascii?Q?2Jy+TnucXyOh8Lofm5aL0kLWmOOpqWFNUjlL1PFKmKxU5y6cdchh7834IGqk?=
 =?us-ascii?Q?k0S/yTBwoQBPrkUPBLvUPv7fKHmLEViACHWovSXFipJQGUp5KCTdH+mf/kl+?=
 =?us-ascii?Q?Z675LS7pjR3nB36dDSqywkI+yNBKqPHqIZ20i+iMOzWo9WlTixIBDLlZFND2?=
 =?us-ascii?Q?Ig4L/3v15imF/Yia5RJaM35MRVm4qhqCcqn5pwbc5Fc0p46MHAfKMuOEYtF4?=
 =?us-ascii?Q?8BS8JrdlbDPdGeoLj7/HJBErYk7lgwSgujCiWydzKF54I1S6Fb3ShWgViGre?=
 =?us-ascii?Q?rlbJ2lCEZPrFsd22Y9w8DtfNzZlLuTzmlCxtjEefsT3Ioi0R6qFfoFtg4VEp?=
 =?us-ascii?Q?eXduzPOwHsxlAMPWW9+edaduSK6WL8aggBFLFuVfv6S5XyQgMppGxq5v9qUC?=
 =?us-ascii?Q?z7y1Jcwb2HazzDq4bk0FgkM5QQtpg607OWsX7bXkVVZoZWP8+CfBp6elIWNA?=
 =?us-ascii?Q?ZGA9Cs4bVLABe4n6lM+B9JYI+cTjXhLTCEotvzo+emcYlI92GniEdEVNkH4M?=
 =?us-ascii?Q?vWmF3AcBD7p0ngI9zpSeJCVijwa9vMOin5nyUj0u31fMl3pBhY9QRkHkzeTG?=
 =?us-ascii?Q?/a3gpv24lar2Dy4/LRgIflLesyqmMmBGxX9/eSYmne54arl+Na8omDINB0B5?=
 =?us-ascii?Q?p0DNuJt+U4aRM+u7EkID8+oO2DgkXaeQoRfvaGLZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdf5ca09-e7b5-4007-f1f4-08daf31b1574
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 14:58:07.7717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NXEhvyqftqgV+I9JdIBx5qsi2C6ak55oS2yNBWQOknHOxH9MF6WglFnsBlQz9qES
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5356
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 09, 2023 at 02:03:58PM -0500, Dennis Dalessandro wrote:
> Dean fixes the FIXME that was left by Jason in the code to use the interval
> notifier.

? Which patch did that?

Jason
