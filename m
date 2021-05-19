Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6355938998E
	for <lists+linux-rdma@lfdr.de>; Thu, 20 May 2021 01:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbhESXCO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 May 2021 19:02:14 -0400
Received: from mail-bn8nam08on2048.outbound.protection.outlook.com ([40.107.100.48]:49154
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229465AbhESXCN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 May 2021 19:02:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sg1Rsq8IkCknBw7iRFuoYknxutoDpALOmdI60ELvQTwEBeGyDWci6FxDd+7+FlcQTh+k9gvGScP4t0Nmxp4K5MedEfbMAtDjSbQoyRw3JXNA8ysnXD8caSD7vJGJ0RNh1RmMXXQ6v4U1LxWPcJZguGC7NTAW490Sh9XwDZA9EOotFwitXV67HQ7gfeyM7cRipjJ/2SJPxtAAOjn2y/au9+vuYmD10JM0/ZcY1dfAeBQuoDap9Rt+C8ZmWHgrUoWekvEAg1X+liuatD4jrbbJUevE3y3UOjZhD4yX9XOvjlBGSOD5Mi2x/3DJBdoEKz4Pdd7TUKWPDrBl6M/IzVLzpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMgCm7iRaFnTYPuNmW2Xn2+kxkhKKUPJuMlHRYJGliw=;
 b=egTAKE8Ld1uibzfO6/UhIJgQZust5uMtoFt+KMDjEhPezkh2UceyvH02CjT6I2P26C05Um+T/VQop+x7sICpcq4r+Ituy3nPlIu4WEusuOElI3JosZVqwFPjYmztfBG7hS0xpalv1REXJF28VIPPNS7Sc73d1Z0Kte7bf8lyJkFAAY2lqAMOpjlBsBHby91GQc6GXztRmqJdoefdPzGEXCPLRUt2tbYzvYbEoucmehucHViGL8eyIY2clR/rETyX/lK6y7uys7pwfdidSjkjBLgRgZ+RoTxE65M5RZxmp901NJUZbrO8kD5fR3poGXC91T1EDRsAmwUmdvbuQlGTkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMgCm7iRaFnTYPuNmW2Xn2+kxkhKKUPJuMlHRYJGliw=;
 b=QWHo1CchQy73l0MVS2AKjhjWtP6P+PxwuJCEAtONK+RnFSrbdrS7zv3/E+KpAUSaGngLSqZ6ZVML1FMGUE2uxz7yaibzQEPc52Kk1G+mWMOhgEW+EPF+6eo/vGX438WH2zhRkytItgW7oii8wUgWc8eQHV+j6A7lMBJWLUbMAkYiW7eY3W+qgb3m9qiKs3KsXfZhj8f5qNWMtLP1LtFsabFwe4WRFeapLanp/Yr/QSPKEyfdNyf91krVVOosBh/OX/eZf5g+olF+drvck00hUSbjR60qmMOUzRdGHo4YRtmyZp+cMLqNECAs2/CH7pIZKHeR+eDbKyD5iNqRiU9X/w==
Authentication-Results: broadcom.com; dkim=none (message not signed)
 header.d=none;broadcom.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3115.namprd12.prod.outlook.com (2603:10b6:5:11c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 19 May
 2021 23:00:51 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4129.033; Wed, 19 May 2021
 23:00:51 +0000
Date:   Wed, 19 May 2021 20:00:49 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Devesh Sharma <devesh.sharma@broadcom.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH V2 INTERNAL 0/4] Broadcom's user library update
Message-ID: <20210519230049.GA2608398@nvidia.com>
References: <20210517133532.774998-1-devesh.sharma@broadcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517133532.774998-1-devesh.sharma@broadcom.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:208:23a::33) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR03CA0028.namprd03.prod.outlook.com (2603:10b6:208:23a::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.33 via Frontend Transport; Wed, 19 May 2021 23:00:50 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1ljVBJ-00AwdL-DO; Wed, 19 May 2021 20:00:49 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80ff1262-0aa1-4122-eb52-08d91b19f29c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3115:
X-Microsoft-Antispam-PRVS: <DM6PR12MB31152C147150752C750BF3B7C22B9@DM6PR12MB3115.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5zZJ6tD9VZo6HaFWL/5lk74mQ+VNgbvFa+Da98JL6mY0Tf7k2FwbLs6wckOGJqv9Y/1nqgVIzGbJupYpiK7HFoXC0/eWQmJ9BSISBZQRNchdPwRAYwcxiue2KthxxCP3vZqC831LGuYinwOsMHfaHrFP5DSgDuvp7S7IjcNo+dV+X6890tF4sbZW1CWzKxzW8FLPKXNSuoIHDHPW8P9BAGs/5MXPfDBVN+aJoNs1jkPJYPA9rWpD/5K4drJNgZ1r6hP82GMJ4BDT6ozci9EQpf5LzcIZdWCRu7d/7kiN+oByaPLwUFAPeuJ3IFZtfU1xno1AnDLMiAHxjZNl2aeqiIjfTqFqHy4OSJ0R26E0StIdAQxQA5VwdF5UXJ0x9+x1PQZOCeEC8ia/Gk7xEq10PULlWILpUAE3E8JgEme7abghm1Mp6ZN6LYoWaO7DDMWlx9/4oFZSE4bM0OE0Qkt94HyUyf94fC+R+q9FIVgsaefoSgKChM7Vd1aPznznPth3oR4wG3qT52EVXBE1Zs33vceLNYJJ4Jm2MkRZzR2GvpDIqMD9oICKWcBS5ALx/Ux3YnoWlL0KhOak59FL11zj52TBGWrux83JCjerWmHz4oQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(376002)(136003)(39860400002)(396003)(558084003)(426003)(66946007)(4326008)(33656002)(186003)(5660300002)(9746002)(478600001)(8676002)(9786002)(38100700002)(2616005)(66556008)(6916009)(66476007)(1076003)(316002)(26005)(2906002)(86362001)(36756003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?bevL4kxJFFBvyhDLH9Qp3NMleXjReabz8UcfrmWp3XJhoJJcQKqKOGGziFD/?=
 =?us-ascii?Q?Ioct9RFVirGJIaY4B5HRHgGBIwTjMWUMvfN7wyG+Vbk2au7BXyzmjnHJ2/jl?=
 =?us-ascii?Q?i3hmjNyXtPsBQPiq8In52YUGo79vdZRQrcMSHretOvzGLZopQbeP6x3DnNCa?=
 =?us-ascii?Q?/JP11Ur/sgwgQn8AFpqS4XCpXo6ZRzru57j1Ux2diU3uX8XRr3wZ2DBhB8Qh?=
 =?us-ascii?Q?+q5W41wnNg+Fg5bvPj6x42+0mxR3YSsGd9ckLhijf0t+hfkn/yTFFsVY+sjf?=
 =?us-ascii?Q?Q4n76wnH1jn3x0Sh+171a6qJMFC4mt3j5HSaDOtWDmQZyB4s000B+JpCcSWa?=
 =?us-ascii?Q?imWNIlgYbl0FN9CnPOVVKzds8/ZInJ0xh8NLEEyCXeNThKZ0Wq77/gCJBDpm?=
 =?us-ascii?Q?QcKyjMl32EL6qq35DvUD6tC5bkpYQK2V8TmL96tPGUIiI0wGC8FUdk1nMhr4?=
 =?us-ascii?Q?0uiBFfX3OFWUpVY0QK9unSODYbe9r4jsFlw4sjbPM+7ROiBuRASIIomFxky1?=
 =?us-ascii?Q?WLQLEUaBhdynNarBeWPdy+VBLU/91BHE2giqX864NKkJfygyXNbnrZHt23Cm?=
 =?us-ascii?Q?DJkyNbR+l6CsK6v6EDfz1u3JoEY4n8hTVSSGY/269lZjj1FpLprik7wNL2fI?=
 =?us-ascii?Q?qvdB852L+BpOwfU82pOXLKBSPcdHF2eUxXCOjguevuotbrbBI8fKsxOXsoht?=
 =?us-ascii?Q?ryU6/xlywlhEr78tfUWuBEfDHjgssr/wQYtGiga9SFVs4hv6xDdk6jxaSh3f?=
 =?us-ascii?Q?VlmK8tQymKq8RGPOrw6clGgL5RNzecfhkl7BODaIPRtgjQvrya8tSPAtbIR+?=
 =?us-ascii?Q?1iIiwIITDTDOD4ITsGE1ifVSNjdwfntOxKDk1IftVkvv0FGkgB5aud4Nh9Ot?=
 =?us-ascii?Q?XDfbEVO+6qoknAtfEfU0zMnG3Z5CD6m/YN7XrzkRMEr7oM0neh+ycdTapKY6?=
 =?us-ascii?Q?FBYZ5oXocnfKrFiZlUCoX9cdfsoomvPY+oFdfvrowgwo9M7dbwfGVWPC1nII?=
 =?us-ascii?Q?2xDHgsWvWVjn66aXpT6oWHj+HWuHJTf/zNEkw3oImEK/yQER9HUeQmTs0Tj9?=
 =?us-ascii?Q?8lkp5GzYcm6VBktLzthgGe/jLsk0Ki0/WBKjjxlAb11ClkUXggzxUf5PdGRj?=
 =?us-ascii?Q?MnW99ngLuYrbQZMov4vNeVoeSvOzuSPPriChBgmYle3I6PzXyf1gCHIG6N0q?=
 =?us-ascii?Q?Pf6g3ZcmlcBlmcB17t5MGuXbdz7HNsO75NfMg47ec/PGMZl7Nq+CfyEazhyE?=
 =?us-ascii?Q?zyHrpoYl/uzgN6b4jdDv2xExNrKcMAiROuJ4hbh6XiORz2dv9lwee/yuqOm/?=
 =?us-ascii?Q?H9jaHbhjGteKXKtSwXSbcWkb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80ff1262-0aa1-4122-eb52-08d91b19f29c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 23:00:51.4394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rLgFHuTJo3ErBKc+Ll/2Np36FvyLUSu9CDb/ARiAJzC6scBCgzXcgPon4KKs/jj5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3115
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 17, 2021 at 07:05:28PM +0530, Devesh Sharma wrote:
> The main focus of this patch series is to move SQ and RQ
> wqe posting indices from 128B fixed stride to 16B aligned stride.
> This allows more flexibility in choosing wqe size.

Did you mean to send this with "INTERNAL" ?

Jason
