Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2521773E181
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jun 2023 16:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjFZOEA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Jun 2023 10:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjFZOD7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Jun 2023 10:03:59 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D32210CF;
        Mon, 26 Jun 2023 07:03:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrIBj5jGmQc6XsXeQmYG6XEzPNayeJ7vIxxx+r+hR7/u3rBgo8C4uRqJ1YakojuYRblwfycySUUFd22NsrLRXSJM9QB4MJZPCMKFQ38sO8k9O63+fYXogGURwP4Xg/4GI7/YnCYP0dOwrC0v+edG18x04vIvOuaOS3HiI5VjhTegEtT4iiF8OGyq22cv2D3+LKERnzU4qRfkwSXQ+B3662lnKN7LrI179L7KJyQWftptz7C8yiYM3gfaOSfK5x/X0n0GOY3SGV1jaT7hlL4nrSncg/2TnAlVKbSTNkkXoUlEbqfPXr5BWi3drmlYEKly8ebfHQKC4yG/65qu4EN44w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=63QUoBMYMMbinQTTjhbAxFd7dFpTMI8zOiWiMElMeuc=;
 b=YMGmLn8mq7ucJINyejRNo9eQopE5GofdllNtm3S/svxsHkELmInYhu9bSRo/D1UxlhHG1pkPbC9dY9tnH1bLRLqeM+Vx7758PymMh3riNUOmC8r57dsqEx+kfyYtULkmTHERaRIBwIZd5EWFWt0wYMJYMWCgJwc4LNJYItElI67KgEXdEzyo1knjqm9SdR8zGs+JgLgxEnA76XXMdZwoR+C/KPbXCjq2jcHO7RYnEFd5L71dNsqsscZeQShwKemT/SYLabNMci4xCriySqLrZdFb7QsmreC9p0zze6WpH1wbRIB7H3nubYkN+kKAIxadrsacWOAoFEvm1UdHghWiZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63QUoBMYMMbinQTTjhbAxFd7dFpTMI8zOiWiMElMeuc=;
 b=fW8Nqz9ELr+wQoS2Jeicn5miP6qSMXWBJwCynIz76F1T6VTa8w0kiA5Cfbotif0ViugBVVH6bxKQuHClq0oMfFfWCdLAMVKI+YKlSy3LpLAmObMLBpKpWB0FL7rpaqGHKjtPzuqD9vwGcHCXbWtdW9D7CBpk8CUc5pxTN+ZiuijdhZDyndFSnYtWIeJOV8UQJlv7ogzEbGNiW95/6Yztj+7DgjbArM0wHcZ5x0hCAGSS/6o6hUZ4Bh4eBMdlK0IdDOR9Pys0zE6X5TSGq02d8CVEaESN5MgVnFDbsxm9R0/J6n8NyZ1DCr0i9WRosrRMKQHZjpVKLL5oF3rpliUdzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6089.namprd12.prod.outlook.com (2603:10b6:208:3ef::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Mon, 26 Jun
 2023 14:03:55 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%7]) with mapi id 15.20.6521.024; Mon, 26 Jun 2023
 14:03:55 +0000
Date:   Mon, 26 Jun 2023 11:03:54 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Selvin Xavier <selvin.xavier@broadcom.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] RDMA/bnxt_re: Fix spelling mistake "priviledged"
 -> "privileged"
Message-ID: <ZJmaylUKX53Q03dH@nvidia.com>
References: <20230626083535.53303-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626083535.53303-1-colin.i.king@gmail.com>
X-ClientProxiedBy: MN2PR02CA0016.namprd02.prod.outlook.com
 (2603:10b6:208:fc::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6089:EE_
X-MS-Office365-Filtering-Correlation-Id: 57d21f7d-eaad-4782-4d65-08db764e2de0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jmaxx/pRsCqiOfOxW3KBFhIJdTgTeWpXZsneO9CuA2VWfIMRb5xwEZHmrltJq2nSG0e0Kl+wD0UpMqnyFL6PrTzVAsH+0yj8kwajLXbUuXgiEniPT2gNJ0Kv4rQoRw/j6eGRQRorA2xA9BIkVR3I+LO1GjmxV0pppxbB9bUFB5OOUvEPZCKzUavkwgg+2UeyXZ9UdBDC0HtbwTBwun7GfwvqQTwDP74Q/XxheK3POY6k9WxeLrJMgV/rxBVnWTn4Ci0bkfSoxZlKD8EQmuqfysYXZ5ab0/1HTQufa/RMtmutyC2T01O0hnF5h1Or+JZY+3EhQyhmHv/UDbSbluIJ7Xxtzv4bM+AtcFFbU5zE0H2o+11LW4aPweFH+uh9nP3X6gREiwyPxSjjQLFzd01JYe6n+a7QXcqlUP22J5Z2Zcrqa87XKyjUBlfAy+mqmTXQbcLI3jrpDdswuOvro1zqTJ6DCs6G7HA2ZIpLDvsnG4HfgL9xQq3K8Q5Zcg1zuCOs+0sUrcmVQ4St9tXsDN3iroGqgEtUMDlQLmwgWr8cRJSR8XRx+qUXGZOUuUV35q8q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(136003)(376002)(366004)(451199021)(36756003)(5660300002)(41300700001)(316002)(86362001)(66476007)(6916009)(8936002)(8676002)(66556008)(4326008)(38100700002)(66946007)(6486002)(6512007)(26005)(6506007)(2906002)(4744005)(186003)(478600001)(54906003)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UBbUsJSIP6+ehVk18SaGkTO3MpGnjBXaE/q+PB7tkq55UYwNpbCp+WfcUeQ1?=
 =?us-ascii?Q?6aig1wNTKmL+FFFAHwZv8LtMcKNqKTIvf6PEN42lec68GDt1RllDxcN0LDdb?=
 =?us-ascii?Q?AoF0u21whjAA0X/vmxzU3LWZJM89x96xrBGDjY9dEqxVxYGrji52sj602hhU?=
 =?us-ascii?Q?7bTCIihlp552uZjJCzuS1Ed3tAMOIwZ3NQ+o/yXkMvQMylfnOyeGW+tNhfYF?=
 =?us-ascii?Q?2MNHIr6X/sRACsFqvbcKLOAMVfzhW6rTTprI/0dR1pQp827WFwUjpeyqnWHl?=
 =?us-ascii?Q?fGABCoWsWMOT77GsVE8DrmGxPsHoFM43v7jMmKj2a+2u7Bu02myyehYVc2Er?=
 =?us-ascii?Q?8McmlhZkqoLwOlnk4BGKw5VJ0JUyFv1T8daFWU7WYXgtT0U6bKI+54VDCXre?=
 =?us-ascii?Q?M4SAE7NbrEQJQhRHJOW8cI6O7qP9ANxkY3aA0MHhE69HNqiVUotBYqEbFAib?=
 =?us-ascii?Q?xrxhmFlxuyYINbMr8DHjsCVhJd4GExHluYCR647uYVylzBTF4PUywr3cucsx?=
 =?us-ascii?Q?A+ANfg1TbCXp1GDW9sWTHCStAtivef4IrdbcFqWoSSOEO43WzhAA8VlcKSUc?=
 =?us-ascii?Q?wybKWu0j8g/63YgcRvMBiJLE8Og0zKw+zJ+RcjYP/7SIrk6wgmEaipR8cX8P?=
 =?us-ascii?Q?LhkyjFkD1o0z51MCM7UnlClLHl9+8yhN2PYmhzbKv2TQ5CMGMD/g0EukCnG0?=
 =?us-ascii?Q?OsBbOZcFAmWosErBshB7dAcIVUYJMTIbfQXmCSOtLoeZOWxY5y0SJjEoJPYk?=
 =?us-ascii?Q?ibbsPh7FjQ+QXSkV6wk5gX+kSKd8Rrs180fl2YAQRCgXrZtbFCxvlv7vbN6b?=
 =?us-ascii?Q?k+jmdA5aVmZn5W5DRQ8C5EAiv6n6T08h+E0vsb+slVA3M4RiMlqa++ZAcvN/?=
 =?us-ascii?Q?Y2FxwKu1XWlRvYz9m5gzJcldQQpCuDu1WITwWwlY2nbOyVhsaWcGh93wvrXi?=
 =?us-ascii?Q?Ag2hdMoM9dLGd0kfjjoH3nH4AKxPTBRJGg5CV7JvuYlMxF8NdPBtKEdG2rvf?=
 =?us-ascii?Q?4rMgpUgB+CbkJB9zalqwP0G41VKbHBao68VysIIk1qRv7cghDnHr2IbGPGcc?=
 =?us-ascii?Q?dxsaDBAQQdnqPrNOjL8H9zWTadXOCQTM+V3b1LKw39k+4fIJZ7oLfixsXVOo?=
 =?us-ascii?Q?dDUN5kVPCINQTLFxIaPZCgQHxC+PraNvJ7ErW6OCHN9oCHVTzrEMOKgQ4tel?=
 =?us-ascii?Q?6hlxiVNCYfhR7MLB6V8tCWmv9m8/Gq8vmoI9XpArU0cZ3bZRDi/TmM8PLMK0?=
 =?us-ascii?Q?BdrSus1fUA1q2Fp8DNilA61vxgS1ZaZuy8el64pysmd2vC8zCL3K/oRkyRgi?=
 =?us-ascii?Q?n+31RqZs7A+lHc6L3A1JWfCOY+DTikAi3ZX+2UQo41KBNCTVhNKpJMD51Xmt?=
 =?us-ascii?Q?7BVY9C7af5nxLqVHWJgVDDvmGXs6eEJKwxZSeyQm2+EjPI/9s8aAr1Akfp7a?=
 =?us-ascii?Q?eI8SZYoUmvJyg/UUjyjD5jjNVQiHx6SKY5THhinQH08JTBC56/5TVCiy0jjt?=
 =?us-ascii?Q?fAYHzFjUkuLfnY+gzjwSer0h7wsAjbII7wyIieUBUkYOGZCmb1z/2Ged68g4?=
 =?us-ascii?Q?+YsJ7BHdlI9Vz34o1uhmZ6QZmp0PqSmAoYzXS7d7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57d21f7d-eaad-4782-4d65-08db764e2de0
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 14:03:55.4932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zZTGSPvfB1OxL2RidWR+aOJGpbTHPRSz5igicr/+2B88fWQ5Wh//+1/76JZZPmmm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6089
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 26, 2023 at 09:35:35AM +0100, Colin Ian King wrote:
> There is a spelling mistake in a comment and in a dev_err error message.
> Fix them.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/infiniband/hw/bnxt_re/qplib_res.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to for-next, thanks

Jason
