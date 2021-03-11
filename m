Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3F74337C61
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Mar 2021 19:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbhCKSWc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Mar 2021 13:22:32 -0500
Received: from mail-mw2nam12on2084.outbound.protection.outlook.com ([40.107.244.84]:60321
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229469AbhCKSWD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 11 Mar 2021 13:22:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G8UgQELgaIAGlKN4B7nTa9AkvXmPqltxv9EOkmYBC8SEagiVI+1gU7XRKbgKXrQW+jHfL684nA+0+m7x8tngA/AMdJMYj9/wZdN4bwgM9kXQEMg2GMC38GWUqa/RfGSYUxIXU+kCyGwBsqg8CWybvfPSUZ3gu56vJfzZv0DH14LWWSOzM/jf6nWyvL8t7mffyp2C5ekMuOjONrrrQlkdNbth2AF5N+gg7cuV6r45RRyuFQZhmeHgeh8j02a9qb7NNBisJiVFyVAwQ81riDGi5ewNwAO6FIUjCZ53D+mBo3p0XtmJ9aLYATgXOwP5xhssVJA/0ITZcpvvBRafJhaYDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zaDFYElogILa9dszkzMDmQtw9LIReHEXY6Z/Kz6aY40=;
 b=MH8c+o/K4VW/s62nfljWVIidbVkZNQrp2IhxMbJ/0+t9L7ic0tjCXYo4zBVNKtkSzBWQIUKBedc8cAzF5NgDlqrIkzn8UjVzR74J5PyWAvNrvhmv9zBt9HKPQjiQXfYRQWfjHPdqPjtqKfxjt56wk3mZkMj+Mj/zWPnZHGJ1Imn79UKCRR6q8I6rHhI2imUEOF3bSTXzZbqXi54zDhyQBjRCxoT0yzg7jxfrqaip+sTb893BFkORBd+WsXmAiMkJzn6l+HOExVPJypEc6B4OpUSfdFzT2M2lK28C1HRRS3QvvaWczPZNqTk2iU/gglUMVoKfDEauKBpjlj57CS9KrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zaDFYElogILa9dszkzMDmQtw9LIReHEXY6Z/Kz6aY40=;
 b=uh7VCzp7wUKTlPu2cyLR7L6INBZwjhAbcg7oclYmc29osT5g1U7saFruJKyXVWOsRQP3g4MOD30ZZ/KZRg6nobrvWvLh1jnD35LqiWIgBqrUoludCrEhDoftqJgpZPeNCySzGuze6U11TR3+HGqZF6JxuAwohVLFPFOLOdCCsqVKpFoXKQJvGL/b0dwydnRItaudzRR8KblW0d97uLlaMFVvF1uI2evfcyR1pby3hX9SPwJk6+yF+OrmD0/6P8x+4oBjSqcQG9l8+l+KSkWdsLx9QikkAlueGIfMOczNSLE1wGTPPEwT2O2lJC45setqetObyrCDxRZR9Bo3WEdjAw==
Authentication-Results: mail.ustc.edu.cn; dkim=none (message not signed)
 header.d=none;mail.ustc.edu.cn; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4042.namprd12.prod.outlook.com (2603:10b6:5:215::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.28; Thu, 11 Mar
 2021 18:21:17 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3933.031; Thu, 11 Mar 2021
 18:21:17 +0000
Date:   Thu, 11 Mar 2021 14:21:14 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lv Yunlong <lyl2019@mail.ustc.edu.cn>, shiraz.saleem@intel.com
Cc:     faisal.latif@intel.com, dledford@redhat.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] infiniband/i40iw: Fix a use after free in
 i40iw_cm_event_handler
Message-ID: <20210311182114.GA2733907@nvidia.com>
References: <20210311031414.5011-1-lyl2019@mail.ustc.edu.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311031414.5011-1-lyl2019@mail.ustc.edu.cn>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR11CA0004.namprd11.prod.outlook.com
 (2603:10b6:208:23b::9) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR11CA0004.namprd11.prod.outlook.com (2603:10b6:208:23b::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Thu, 11 Mar 2021 18:21:15 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lKPvu-00BTIT-A8; Thu, 11 Mar 2021 14:21:14 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d694e699-30c2-4c8d-f056-08d8e4ba756f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4042:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4042A97CBA02D0364CFA2103C2909@DM6PR12MB4042.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oF8Uo/ZXH/b2JzU5DUtD8cjXoamnSkU8RPufi25kae0xeI7yWiThsSh0zEaEKCkDkC/kUgUrx7A4+MXWtSUOJFlchnNYFvh2dwGeKs5Xdi4So9WC+zKvHfzlGs7clDugRcxLvKUGxVIqwEYKuoNAZUjWrZPS3AHSA40JntxVT6ZecylG85Uuq02PP+fCXeQ5jXn9l8/ymE/Iv5a2jPpkYjGTsjcyy7NlRg2A0d5buyIZIR7e2Hdb1atpzEkgFGYqDugMQA0lyU8gZE3PGxKA2SC7z+ERmVneVRgCRsEU6visXbyQdRMRm5aYQfJoxGaFHrPgU/YG+cfUz/Sx11RzNp82MF4qumdY4d894Eu3xrS57h/uMeDVEkeS3Cy+0qzCVN/3ekJxKWQ5YX2tCwr7SMQ+jspLmOZsiTnQqYc9uDVPMY1nH9cNvt1OHfzjxEpagm0KPWkqi9nZ8k7QHpjgL9gHoK4n2CSsiDU8WnaOGz0XsNXD2Otfybwom+OPTmhPXpzzsXIqA+2j5dzFD6zhRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(478600001)(66476007)(66556008)(1076003)(4744005)(26005)(36756003)(5660300002)(8676002)(66946007)(186003)(316002)(4326008)(9746002)(83380400001)(426003)(33656002)(2906002)(9786002)(8936002)(2616005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?5xfDhkYRtxoZbEZGU0mdgfv/qoFROeBzQBS6YsAU2phn6lGuQkdVb8Bz63yK?=
 =?us-ascii?Q?zh3+EAJan0vrB+GKhs9alheRCeru1hwQMvMjqayih8NIyZADIC1PW+PRM7Tm?=
 =?us-ascii?Q?Ob8v0VKHTvb/q7GS2jfyOWWfRQ3r5jUx0m5wfTiWp3/JpDVfu0h2zxjMrH+o?=
 =?us-ascii?Q?51Y9EFMu2De+mECTn0szNn8q8PGw1aAuEGmywzu6RewvQr5CtVB7V6iCkkcs?=
 =?us-ascii?Q?hmBNa9Z4lwndL98wAQQbooBjReD07asX/23i3f2cDlH4Nz4PNtxa2Dny9MM/?=
 =?us-ascii?Q?dKztG0qT18km4YJSlo03dPwlNXJx6xmWwX58OrAjn6+gkAOWB9d2nw+4dXOO?=
 =?us-ascii?Q?yp/ArcIxzUXIUmb2u9dYrQBQEVpuwr4qMW9I9jjXx1cItoT53mh6gSpitqGU?=
 =?us-ascii?Q?qUDPWzVE7nvQjsmUAtGI2doROasVajkQnT08U9/YaF/JQKg7bS+x2iShGQ+A?=
 =?us-ascii?Q?VzzxoyCd6SsGff/W0jc8eeCM79FlE3CApd/TFcNXqlUvIXbU6C6ONIDIpDi/?=
 =?us-ascii?Q?701ghgYnmM6KvthUiBndujTg7FJXt0BZuow09RxlFEq9SBOwSH8M9efRUOmJ?=
 =?us-ascii?Q?39Bh/LwsU1XbBq3BUEVCz4/QO02H6yN/cRJg2Zk1DLt+196giAQYCEFr7WNr?=
 =?us-ascii?Q?IEw+kqd8j/vdKztUGkwfW/6H013I3owAFh2tQmeqZ1lyVg/lTRTAFuxwhxDc?=
 =?us-ascii?Q?rvS1tbEpV2GG7WvMVOX4JVS3tJiTa7mWpzeN6YhtBhtEem/SmqucmlK8MDBW?=
 =?us-ascii?Q?HXKC/qgrz6oPrBdP5TV9OMzsw1XzAA0H8njQucTnGR5hUviB76poDlCuae94?=
 =?us-ascii?Q?klSa7cenNzen670vRJmOUXPINl+DEbbH1S2MKnQ6vi1JbgmxiKhkRq3BwRnA?=
 =?us-ascii?Q?rl/AGI5EBXZQTxr62154pD5v4xlNCI6mnwnOBqQelQB+nkdZI2d7sBW2c1ny?=
 =?us-ascii?Q?ZI7X3BA0/XS/OCPYMFWYeX/oGw+MT0rFxM3Qu8/owIH/FZCwyNGE2Dv+YP0l?=
 =?us-ascii?Q?0mG6/Q+uPqE94zOaobHvDAeby5Q6Aw3FYjwZoFmdHpfRMw+CYOhkhvXpd9aX?=
 =?us-ascii?Q?oGEzgrABg5J61jCyZtrgOcBWpKoiYmkM58kjct2hfH2tJ+WTcF7l5CGX1IEf?=
 =?us-ascii?Q?ThUB0XeBK9j9iWoOcjYhmIVpRLK65OETBhD6wJWqJs41B2S9W7NU3qzce06E?=
 =?us-ascii?Q?09gLcUGKQc4g+oPQxBZVns3IgqeoGpAx3k3IDpAsffmCFqqHkEvwEgxoPMST?=
 =?us-ascii?Q?xZeDBsayvovKRWLtw80HNROYEUvgaqKFSYGx0r2kKO62sdgHBhlnkyEcz32h?=
 =?us-ascii?Q?wm+q0eJVxKV73HPkc9TMGURNSF5rw6p5e2VmaGvfe3S1fQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d694e699-30c2-4c8d-f056-08d8e4ba756f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2021 18:21:17.1567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y7sWOP8goWl2xANinIx3H5JPswpM9Vdx/nK7o0S3FbSRBRH8M51R8uiShfbowRqO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4042
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 10, 2021 at 07:14:14PM -0800, Lv Yunlong wrote:
> In the case of I40IW_CM_EVENT_ABORTED, i40iw_event_connect_error()
> could be called to free the event->cm_node. However, event->cm_node
> will be used after and cause use after free. It needs to add flags
> to inform that event->cm_node has been freed.
> 
> Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
> ---
>  drivers/infiniband/hw/i40iw/i40iw_cm.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

This might be OK (though I don't like the free variable), Shiraz??

Jason
