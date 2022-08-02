Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616DF5880F5
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Aug 2022 19:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbiHBR0i (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Aug 2022 13:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiHBR0h (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 2 Aug 2022 13:26:37 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01366DFB9
        for <linux-rdma@vger.kernel.org>; Tue,  2 Aug 2022 10:26:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a0+fCfNpLhIdS0I6H8i3jSWGjvRnaBfHI/GfbGKbBS6i7tZDJB68yps2vtoReOs20GjscB/GQHegxtbrfIYtjZ9vYjGuTW9X1vAhbL1vgoAX8TUi9v2DWqngzTYa0QpP8SgLuMWcyH/2heKzPLhTODrlEb/MJoTpO5A9RdY/CfHrIDA0Q98ytTpaJb+n6rxmVqOmfMz7FwKw6GIMZWteDcEYwxWT2MtN/FVYIHQEzKN/m9PA/sMC3hkawhGouqpKjLGEqy0hNl9rVA6+0gP/Bw6eA3E5Oz2m3gnyovtpbynBnE7+JCfAu4nJw54gaxRQAXW6jTVMue38MJyAF/X6hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YWfVu1aZKoCr3GcrbCsJi5NdvCXpZQrD260alVxtYBU=;
 b=JhztQlQXUr0OOKNYp3pydZgoem+3rUld8YIL1HX1e7eEdfyY/GIixkcjIvy8TBHN+O1V0Hyorpgo+4a09b16zMFDAaONxuastQwXeiQV1KCEexg8L2mtmX9DXDKeiS6Eo0u0QONDUy2P+u8LMPyD/n3PK8XPNiHyR4b4NW+Aa0vKT5GrlkodGftcmH8Hu2IbH6WPyXZOIRFEX3U9pavOSlQ4xuYI79rf4v4TpaXzYguBKkzvPtKTLPi6+WGdXiPwkh/huFav5Tf9+w6YkjVvf2yJHoGJONSB41NVBcnPSRIQzonbufEVtFGUbiFV2pSOuZTSP1sO1rZKgtQ3GxdurQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YWfVu1aZKoCr3GcrbCsJi5NdvCXpZQrD260alVxtYBU=;
 b=S6Pfms7k7LYnsfb6MyRItO273bKDPaBlN97crpbwd4bjVxuL4K79Y6v5EGHEEj8PSQc19HwPUFKipNVLPySH4R59wl7HxNxrsRVDrvc/z8DoVdCcGUKoi8R8KonHgCCyebjvn1DqqvCLdHMIm/13B169dzgRvzFLv48K4Qi7u5pZose16482YkZMcbhJEq9j5j+uhNR04n0GlMaeLfpJb0ko68oCWTQ3WT3mBdV2tGUAFLysWDdopsfOkCy8sVbmtiw6hqH4LXTjs5Io/eQlBZmrfqtiU0SO4tzXne6ZIEVNo0zvu2vgvPzm+TIffyTVac93gZ2qAkMp0n2b9RXWhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BY5PR12MB4148.namprd12.prod.outlook.com (2603:10b6:a03:208::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Tue, 2 Aug
 2022 17:26:34 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::4cce:310f:93:5d58]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::4cce:310f:93:5d58%8]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 17:26:33 +0000
Date:   Tue, 2 Aug 2022 14:26:32 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        lizhijian@fujitsu.com
Subject: Re: [PATCH for-next v2] RDMA/rxe: Fix error paths in MR alloc
 routines
Message-ID: <YuleSNxp9eb6ZpRa@nvidia.com>
References: <20220721202213.55061-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721202213.55061-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: MN2PR22CA0028.namprd22.prod.outlook.com
 (2603:10b6:208:238::33) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26b28176-dfca-460e-73f7-08da74ac256e
X-MS-TrafficTypeDiagnostic: BY5PR12MB4148:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AWw1EkFEZ0g3F7eM3EDeASqzsXzd6Bo4mSU2gU5J9ADd/kk5OvJyRj1qsyDqF82apJV5D1Yt4sQyrUpLCGK4sCSNVh5tTmln4K4+C7YWkw9cIw+KONwNNnJ4lsAz0L4wDyTb91sse0G+SyovyqrB1m1E04BvRUMFul9pl80wwKbiXejolDKRPSQZ9sFrcOHhFtSQsn3vd24961AhcJY8pDJJI9VMsgdctY4T+8adWZ5LRVRg+pte/NuG7d51jZgY5KAv3MJrOSwmlwxIxSQsZY4EKamQw25rtqS9czpMI9JsI4AkngTjiNOJJUk8HjAyDNf8emVuwjL2PPw/HS2gcGP503/RZpWyOpu46rWsl56uOwWqis9Ek32xyqE9XxVPbqD756RCeHtInhzdaqEQsu09wtlsGndDC4fQT/vW/x7bqOa1UO2fd3hD77RKqURRY596lw/53n0lEsbQAqfsbCJ4h9kIXrTjBCHIVMaDIDaQAxDurkJlBEgXz4r+Inm4joka5kD6qZueF13NVfH+SvxIZFYrH2MGE8jYJhGO7bPG17SQYuSrH8WmwFAglJUnNjd88+GzExcJaMZLnQZNWRVwRsbv3W/byabrXj3xZhqW4NHKwi5mUie0oy6FxjKKWjOptmoXK8xboToiBlhizGpMRU3pmTpJnqUG6L3+sU/BqecoydOTKx+u4Q3UMyCneccx0L748gQaPRfnuNQu4qOnqFxL9oduVerrTAtmf13lV2xJYh5FNGNMPGg7sxGAcLK17czU7J2sOQmsdL7V/sASVCixk16rlldA4ar3z/kO4Ca8iRWbMfJz1oqV2BqxElO8WrBUvv26mN3LwWqOwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(136003)(376002)(39860400002)(346002)(186003)(6486002)(478600001)(966005)(38100700002)(83380400001)(5660300002)(86362001)(66946007)(66556008)(4326008)(8676002)(66476007)(6506007)(2616005)(41300700001)(6916009)(36756003)(6512007)(316002)(2906002)(26005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VNfGBWtPWNDzMgEqgoFoDnasN7gJlzJaH4rSUXwGYPp3mUTOJ6yhUvv4BvP6?=
 =?us-ascii?Q?uFy5wOhxiEWJbEzRcON6oQuMOY6U7u0xLj9dLa0YI/bdIEP4B6SlmeJLBtwB?=
 =?us-ascii?Q?B2Yk7vUVSCBm4kFCtWtLH2iklEPUpkUztO+Le0xpSZD3XedgvdxXujsLFkRd?=
 =?us-ascii?Q?ArVhant6wyWskjs2IF6pdbB4rVfLiCgqfBshqL1Ukre78LViWTxbTMJ8kEFH?=
 =?us-ascii?Q?yo93h/OW4IOB72k3v7Im2QqmFbMoyg4bDd96/vDJA+exf/H8Fc1+q5e6hlHG?=
 =?us-ascii?Q?BMOOzW1154bL3x7Kkm2LjvVU+KTX4m8LXIjjxHw8wZ0iF/R8l1jb/duiZBFt?=
 =?us-ascii?Q?+GmX5opQfI2nSL9+bukuoqVI+/a8D0NYXc0y2pJh7Doo7pFZ1fyreizQ5XQl?=
 =?us-ascii?Q?p0od9CKA3H3t5A8ZbClkyQ488njxoP6bXxDjuBxv1l3AMa91iNUoK9TqOzWG?=
 =?us-ascii?Q?f6qB+oPkzyk1le28Px8R956KrgZaJi9SNX+sq62V7CtMGfSa5EEjjgETLiYY?=
 =?us-ascii?Q?QcWZKZoABX9SKvD0mFzhggW/MgfrdxhOf8UggqrsjrhVLrWUCSSwq+ongTUg?=
 =?us-ascii?Q?u2xz5+UV5uPBAtlntRqslLrv65MlmQcc1GPO7QVmQGzcnaVInF6j8ikeI4mf?=
 =?us-ascii?Q?FVjw0vxWJ2iX4z8S789GojFciDa8BiC9joFyvrFcOaLTAYgPBBEd0T8MC+Sw?=
 =?us-ascii?Q?e8G5+iGsJYEsuhSxrHjWp6XwRg6Tnrtx2ozWxPWrIcUaPvIluj4RtqWm9Zy9?=
 =?us-ascii?Q?V85sU26eZotwvmNI0xnc1OB47UwmC7OXAboyudgzOkRf2M1Vxt5EJJrJg4OL?=
 =?us-ascii?Q?AbUW7V+VtsJTWRWBPYeRL/hsVAB0B6mOLXooe4EBMu9z/YeFBF2mfjenN/ml?=
 =?us-ascii?Q?ZLgORAr5TrK30PQGKeo8ux2GUObrWSEnOK3+dNbCqohntanpp6ckHCXl6udR?=
 =?us-ascii?Q?05yodDaYyqKDIXY6vw9vgoLC3yVQbMnyivgoj+iWBGXdKkz1ehUG7VLTAVyB?=
 =?us-ascii?Q?pEcv32n+YiB1VcyWBidSHzah5KWnINhyjfXxK6kg1jmE+ob6EJmA6tgqSHMv?=
 =?us-ascii?Q?q/LTcpd+cMQJL8ssbC7JG7ssvvLidujZ4pYCnjPDZydRSN7d5LVP9ASa0Yhh?=
 =?us-ascii?Q?hLjiVg9G5C2f+eK5O6rdBpQSUzbksshCAJBkWl+iMR5qTS618AcwCAx88fJ8?=
 =?us-ascii?Q?YaH+eNw+uNpslb6o1sSzSHc+8gE3j2OGtuvl8g0vN/IsPFpyTD7n6Zpqt55K?=
 =?us-ascii?Q?yEMFd7LhkwFUTDuEPZdglJGLKwvpWcz1l7M52XzU0T6PvCmxGFctbUUZMkp5?=
 =?us-ascii?Q?GspEv9Y3pTG2bdQNv6sc+k8L7Xaxt+92FrWu8PkVuoPoUd/OOMlDlRoXSVeP?=
 =?us-ascii?Q?2HKRH7gmrnN25y9Xb7o20bq91KDw+T+Wa2+vJtznaFhneP/aUubOIrzKA6Xc?=
 =?us-ascii?Q?we3FXMvexJ2FBAlzHiXAI8c4v3i9sKLRf86gUb0brZ+7R82iPaCR0LN6LuPQ?=
 =?us-ascii?Q?y9sfg+WgUl5o3ncvzfvYfO3X99H0lJyCvROB2JWljXD58e0wxGrrTWUawRUN?=
 =?us-ascii?Q?k4Xuok5aBQ8HsZFykWFqaMfgRMLcNt8bTRhd5uCE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b28176-dfca-460e-73f7-08da74ac256e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 17:26:33.8788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: krNWu3qJ27ji6R+U8X7xgnYWQqcdPFFbx/hb29FcrVe0szYXem2xFHmoh81igBBC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4148
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 21, 2022 at 03:22:14PM -0500, Bob Pearson wrote:
> Currently the rxe driver has incorrect code in error paths for
> allocating MR objects. The PD and umem are always freed in
> rxe_mr_cleanup() but in some error paths they are already
> freed or never set. This patch makes sure that the PD is always
> set and checks to see if umem is set before freeing it in
> rxe_mr_cleanup(). umem and map sets are freed if an error
> occurs in an allocate mr call.
> 
> Reported-by: Li Zhijian <lizhijian@fujitsu.com>
> Link: https://lore.kernel.org/linux-rdma/11dafa5f-c52d-16c1-fe37-2cd45ab20474@fujitsu.com/
> Fixes: 3902b429ca14 ("Implement invalidate MW operations")
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
> v2:
>   Moved setting mr->umem until after checks to avoid sending
>   an ERR_PTR to ib_umem_release().
>   Cleaned up umem and map sets if errors occur in alloc mr calls.
>   Rebased to current for-next.

It seems it doesn't apply now, can you resend on the next rc1?

Thanks,
Jason
