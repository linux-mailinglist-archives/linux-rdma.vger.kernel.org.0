Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9983F2386
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Aug 2021 01:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbhHSXLc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Aug 2021 19:11:32 -0400
Received: from mail-bn8nam08on2050.outbound.protection.outlook.com ([40.107.100.50]:33248
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229522AbhHSXLc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Aug 2021 19:11:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7uhaQq6a2So5k2ecmu446vmhFqzfNdRcZhX3VKOgvwmLw6fefZgOcK2e8S1zhVKFUXd8QHgJ4yl15HRMuoR3AUeZx75tcS4LbyX4LqA8SFG6IK/wyoWz8/6e7BMTUbIGRQp1e1kULrmWSFMem3/jBiEfMTFdmJJggwZo3RnoDzojyEQDZf2K/JJHS+8Fl4wiZeLVTzrwjZiNhyyKZmC5GasW79SmxLUVuJm7TpCLf0jzBXyYNmNKH7VUNYPEY2GXVOQpfUSj8u6+WNkDboEIIQkMLMlqPFTuIYby9R4S7a449b5zIPjm+04RXOJrvAaWhUZ1vOQXTBdx2SmSd+lAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mlr8Hla4b/dXcAn6veg+jiLVonZTxYidZSqS/ICucs=;
 b=kIZm/Jb1rNiWIUnl0O4zVSK6B2yegU35nZG70WOG8FcmMi12wJ4SdQeCJjKJyvMrCtuyUGY4osXGy0k+pixM+gYV0hDR/n8mn+xaHw753+9eic6MRwz20kHDiSrNomxNXX5pxCo5Cc0fNt9r2pA7GqSJAYH/LgRjqy2yq+pORQjZIngTWLtxx+pBszskmfde7BOf9gvFK0ogx/livvQmmSzo+W/u77LNYXgIk3vxHOMCu10VHhO2CQxoEern8rBuac5tXn9SE9fRdFwkusOuU8QQG+mOwfwN86NndKRRYjNtg8Wd2VWWAJCeT/vU8ZVvvl2I+qs5qgkPYiDxI6y3fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mlr8Hla4b/dXcAn6veg+jiLVonZTxYidZSqS/ICucs=;
 b=k9vfDiiNXMf8LMLEhbvx/65ukNcnYUohylU261W+7pDlgCWO4Z608OpK3f7nirp0lrQdxUxXTtqCSZ02fi1ovsNfkwoVHHXp5kDw3rSzcpsiIORMmcqIin8xt56H4Reldq9laxrDoXRQCSfUuu/Da+DbX8J5jcCSztTkWVYPut+e5xoEjcrcCmMkSki7J8gdW0WSX+4m5bJrSZup9QTVVO50ok4K/Pwkcoi90jI59XRQsI6h+4neTwyaGHIYdhS4e+XOocrOjoGW+YrQ9QpgSa1fOe0x8UNqWe1aIEYY9xCs/Eb7Bk9j23pUyL9v50pHN+TaS6bAUOD+qXEgrY6BEA==
Authentication-Results: fujitsu.com; dkim=none (message not signed)
 header.d=none;fujitsu.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5047.namprd12.prod.outlook.com (2603:10b6:208:31a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Thu, 19 Aug
 2021 23:10:53 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336%8]) with mapi id 15.20.4436.019; Thu, 19 Aug 2021
 23:10:53 +0000
Date:   Thu, 19 Aug 2021 20:10:53 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yasunori Goto <y-goto@fujitsu.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH] RDMA/core: EPERM should be returned when # of pined
 pages is over ulimit
Message-ID: <20210819231053.GA390234@nvidia.com>
References: <20210818082702.692117-1-y-goto@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818082702.692117-1-y-goto@fujitsu.com>
X-ClientProxiedBy: BLAP220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::21) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by BLAP220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 23:10:53 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mGrBV-001dXZ-54; Thu, 19 Aug 2021 20:10:53 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5cb45645-fa24-404c-5378-08d963669804
X-MS-TrafficTypeDiagnostic: BL1PR12MB5047:
X-Microsoft-Antispam-PRVS: <BL1PR12MB504749C5CE2746984E661F04C2C09@BL1PR12MB5047.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SSfWaNkJDUt4Ykh7GSdHb1y4Ui7WJFxM0eyqLFy/1tJcgbcSmZW9C4DZCU9Zuysedye/JnGWe82nN1NArbqeUXTh/A8w0d3s0VAGMDg94nFV7JGkDnXuEYEYDpn6FTMUzGzTDfjP6Mch531r7quYMFaYgAo2xvwi5pDItvxa+67A6mQ9RhlO0RwgCDcFWgdDPa93QqH4XkzC/YwWDl7GVX7DmnlyLY3/yfgUFhK5NsOtZhGXzaQljuBqeEOC4kM2NZdDMuQufZGe+MCy6G0SdqJKXjK7j0oJ/63D1kPVgzHQMDF7NlHoX71pNHR0rbYcC/1pVbf0V0TepnORAJMbe8nZUnVNS/ffUZvFfjaHnw/yEVazWMk8GjyOWF/ehJ1TaQ4q+hkr03ivQBWXZNBdS0/hVEuYwq43jkIvWqaVY9BnnXBLVOkAOndKwu8YnTN3RHp6e6rD35CYSyjc2I38jLm6wvMkeJIWKW4ty7mjlRrhks6sANs+BfXy+jylPWI+PKqyy9KXkLcgnHJb2phfIv7f4fyBVrm5OkWfc3wi4Snq3mCs3qxp0xsZw5UR+xFmyBr2UoITat1FLQLIjvEUVqHG6bKOGMU8DQa07gr0K+Tyxhoc9kgo7mX+c0F3dfGJN7ndbQCeR1dz8h0z3x1nCfQ6y0y2Rk6e9eZSSJSBmlb1XuYDEdBUqpfjgTXg/+P9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(396003)(346002)(136003)(376002)(86362001)(9746002)(9786002)(4326008)(66476007)(33656002)(1076003)(8936002)(66556008)(8676002)(66946007)(2906002)(316002)(2616005)(38100700002)(5660300002)(478600001)(426003)(36756003)(83380400001)(6916009)(186003)(26005)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ULY02fAbNa9s/ZktIjd1Y4LoA5mF8Wu6SXUuMR5IHhKqX72qq7jkk1j8MnXR?=
 =?us-ascii?Q?0V8bCrQZ2HlHVvlQM7Kf2IwcJTVDpOZ4WV8gpNm6J1Id0MhfMd762WpQf7tr?=
 =?us-ascii?Q?yTmi+AesnncycxoA/WiNDiAJFAU/Xct+GLPs0adb11Z3uMp2RAmc1uExhNJi?=
 =?us-ascii?Q?73FKBPQYssIafGnFSNSOsB/5hJoMPuD19wub6XYPokZJSfPsZq/dl9SnbCov?=
 =?us-ascii?Q?aUI2alZO1oHnefkN96WJwVaJXJHE+HmLhqTc0pSfRKE5DUd0O7/u4164IVrD?=
 =?us-ascii?Q?dd784mT9nWUTqHQ8pi8DIC1kEy5fNpBbFrawM9ejPbFd79oS4PEVk1AakTnw?=
 =?us-ascii?Q?2gpA+csOlQd/SFVWcTBpyLKqFJwLG+HAY6b13I2a4cjYRoORjSj4lgOelu2X?=
 =?us-ascii?Q?ezUragBtUJVElAIH7QZCBfv7Shbpw2teZIlNeVtg0H/R/rnReNz+0mrG7u4i?=
 =?us-ascii?Q?6hbYANcKug2ii+A1ABnGx1S0LmBcXl2wCVLU4lkiZwpfUi/sKeKP2aekWOiv?=
 =?us-ascii?Q?tJx8DFCkOzNILJW/ReiNocoi0HaOaRLeqWdwk25+JL1hQbK5NDtValDxamR9?=
 =?us-ascii?Q?oUXCYQAKICa04zWoJd8rAcZCn2hm2AmazWFTh6//NyA6n2shRbsWxlhIJ7JB?=
 =?us-ascii?Q?2wjSXTvDOhOCpXmHSLUQ3qavNTW6wecnZGROyz57afjawPVRtbKZruktmsdE?=
 =?us-ascii?Q?nGDNHr89E5EQ/ffTrLcD/hbjdvNRrhLr7U5CRWE5le7hKC/LD+aCtqK0EbOa?=
 =?us-ascii?Q?+ciYBJwRO0NEE52ifqmNjgiY0RgseWnNkFce9GrKoJpcaNtdRVQv29qJOnr9?=
 =?us-ascii?Q?tl1DR+o6GNZmFtkwjxSfCPBG3DucJJdect11Xx3Hgg8Bb25pQYTfKpgZOh6O?=
 =?us-ascii?Q?lAXtX6IpxXLgP9WS1Aq+E1v65Z5CHwoX1Q386JiGGAy57Zc/6zf3dcZGLdME?=
 =?us-ascii?Q?YZeXlpQwZpkdWNRyL6lWMvnqy43hZ3mUrgFaYjavEbKnN9PYKpfrXyffQW1J?=
 =?us-ascii?Q?51xYG9GHpzG3+uxWc4SDbcE38bwY1e7WAuLkMvaJctO82BdDiToBeYIPdq+7?=
 =?us-ascii?Q?vpC8vfkZz0vlJZCecQoq/U4h+GhogeqQFQb59JVeeu/1T9inJ/L+zO7epv6D?=
 =?us-ascii?Q?5rskK7WHE+FgGYtnnVX9MG77OJwnUGaCMvEXjuCCuxfDZ5nEqKysWOlxLI/o?=
 =?us-ascii?Q?VrjG4xDngMNytRvLsz+VbS/Lv4cAVJxd7X76t/1bW+cNz0g5bD6lTD+WZr+j?=
 =?us-ascii?Q?PDsqIp2LSKnUwEO1GvFnt1FIyJqV22PPo9phOszyYQAR2vcoRdjUVf2/XHV3?=
 =?us-ascii?Q?OtubH+O2zBly4yCS89+XaCe6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb45645-fa24-404c-5378-08d963669804
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 23:10:53.8865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ohzL+F/0ONloI040FXy2QT9AzmqWyOVuXYAVayPgg5fC9mqHiouBl77LYOIObKKI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5047
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 18, 2021 at 05:27:02PM +0900, Yasunori Goto wrote:
> Hello,
> 
> When I started to use SoftRoCE, I'm very confused by
> ENOMEM error output even if I gave enough memory.
> 
> I think EPERM is more suitable for uses to solve error rather than
> ENOMEM at here of ib_umem_get() when # of pinned pages is over ulimit.
> This is not "memory is not enough" problem, because driver can
> succeed to pin enough amount of pages, but it is larger than ulimit value.
> 
> The hard limit of "max locked memory" can be changed by limit.conf.
> In addition, this checks also CAP_IPC_LOCK, it is indeed permmission check.
> So, I think the following patch.
> 
> If there is a intention why ENOMEM is used here, please let me know.
> Otherwise, I'm glad if this is merged.
> 
> Thanks.
> 
> 
> ---
> When # of pinned pages are larger than ulimit of "max locked memory"
> without CAP_IPC_LOCK, current ib_umem_get() returns ENOMEM.
> But it does not mean "not enough memory", because driver could succeed to
> pinned enough pages.
> This is just capability error. Even if a normal user is limited
> his/her # of pinned pages, system administrator can give permission
> by change hard limit of this ulimit value.
> To notify correct information to user, ib_umem_get()
> should return EPERM instead of ENOMEM at here.

I'm not convinced, can you find other places checking the ulimit and
list what codes they return?

Jason
