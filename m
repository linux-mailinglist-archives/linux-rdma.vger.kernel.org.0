Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 020E036B3D5
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Apr 2021 15:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbhDZNLw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Apr 2021 09:11:52 -0400
Received: from mail-bn7nam10on2070.outbound.protection.outlook.com ([40.107.92.70]:58432
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230250AbhDZNLv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 26 Apr 2021 09:11:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPSFifDgQ/ldCw30FKXmIPLZxtcdkC9HWQIPeVF5B1SmJMEE3FDlAbDW/gfy7V7/V97g2/jmiT70T8xM2LydDwYruu9Wli5tQQhB0IliJOBberPyM6dLe3ivd30dM2tJQzgI99Ywqb5Li5IUGjzgDBZhjp3UAIh9EJQqGgFrALcrePp4u0rmA6LTkU0hTT5EJFiZlNRLZmVIxZetuNo4TZfpwnH+gy+PZ+D9WhaX4wpX85oiAiNl+6OugvZbDOWlldOsu96dULFDpzWhcRyXe5PvjtV6BtyM8u/KYA23sv6C9tjqzIWPd06Aaz/YhtOFlaeMXFVLtCqTJAxxrXF/cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1D1sCyOkWuMQ8iw0abGyYSzGOJnbIFBy1VEHh6BG94c=;
 b=dn3+k6JJzU2NfSqzrnO6Icjf+WNdAU+g5NHUUVlTOLfWRVp2sUQo1SFJ4TzYj+AVzdMrWVymQ/xte9Ygsq+uadqHY+YCeKBTVbg/o1UGaUjjpl49/F+VysMygL1LlDrThEUSNYfRdrlkAV+0/rzJxTYQb0S8o9jzYbYaxCNsAvOqv+hvgCil69XHmLeKq82SNkXi9SG2mT0tyvtmgCx/DQXR3NbZ0r82nv6s4X7r2VEYexO39FczMdnmalBukbm3cMF/9TacGK5o7zJJRuSkjX9mwZC/dOLSl1/EM7HGzETUNp+o2jScNLoy9RKI8hDPbTk9Y/BxdqEZ2rQhGDz0xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1D1sCyOkWuMQ8iw0abGyYSzGOJnbIFBy1VEHh6BG94c=;
 b=DGke+cNFEneWJnr7/+9FdE2Wat9nMRV3uQVwJ53Imle9EGQDfch2Dvj4GHsTS0Et2+Xhhzjtfc79ycRYWrfj3+Wz7y+lxZPXgdZhlFuWyqp+hgTbjYZpqtmS5eFohy24hQvxwO9scBDjLymbnOwwLff6+OUYxaynMZLbhkNUVipJitppjnjmdSMO4pgNEHhGc0fi6PNaZyN23l/WSukBwp9TVLFYhDeJNJ2H0usmWOYpcAmSg0Tb6S39XYKYNPkH6BtsK8ynMprD9HpnKLypnTWtkh1GUu2bTY94b1mpzl/HdZB8t+YurGGifQzzHzyTTV2bpg+EzukSGRqv26JNjQ==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2857.namprd12.prod.outlook.com (2603:10b6:5:184::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Mon, 26 Apr
 2021 13:11:08 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4065.026; Mon, 26 Apr 2021
 13:11:08 +0000
Date:   Mon, 26 Apr 2021 10:11:07 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>, Shay Drory <shayd@nvidia.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/restrack: Delay QP deletion till all
 users are gone
Message-ID: <20210426131107.GR1370958@nvidia.com>
References: <20210420152541.GC1370958@nvidia.com>
 <YH+yGj3cLuA5ga8s@unreal>
 <20210422142939.GA2407382@nvidia.com>
 <YIVosxurbZGlmCOw@unreal>
 <20210425130857.GN1370958@nvidia.com>
 <YIVyV2A0QhUXF+rw@unreal>
 <20210425172254.GO1370958@nvidia.com>
 <YIWpMbUg3VlT3uJy@unreal>
 <20210426120349.GP1370958@nvidia.com>
 <YIa7WtlYono4wP5T@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIa7WtlYono4wP5T@unreal>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0201.namprd13.prod.outlook.com
 (2603:10b6:208:2be::26) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0201.namprd13.prod.outlook.com (2603:10b6:208:2be::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.16 via Frontend Transport; Mon, 26 Apr 2021 13:11:08 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lb111-00D2Ku-2e; Mon, 26 Apr 2021 10:11:07 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61b0b5a4-b97a-47fd-f24a-08d908b4c16e
X-MS-TrafficTypeDiagnostic: DM6PR12MB2857:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB28573BBB21C27FC5DE829684C2429@DM6PR12MB2857.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YnVbJaSeCTzkMVg2JSEWX9+3Mrm3A5AcY7G8s0X//r74NJri6hIuDOeBPlttvQ8i6Jg2gjjhcls1v4bU0KFu+N8Cz1AX83/JAShBIYFgNWLon4hvJuZ4tuW2rnxSIXdywqJXmGVi0WFS3jxKUKGA1ceQrnHkRy98O/BYPXF9j8LovFr9diVoH1JBOM+fYVjjnmLSf66K6qI47D5S8dCCRcpvDF68jYhkJPWo/buWy1HuQZF53ezQ4OyfPdzM0SmvFXeamwnoX7LFAtcTz4VcG5BRud6KNTIxYmlVGuyJSXLwuNPeGxBCRiq0IlL2PUcK1zo9bkLTdSB648xYTqFqV05TBK2JWGedZvmakKH2nfOngYzpvIB0mLOryjZZkS1dvcQog6UoQhDb0xbcVUqDXHfGnHNyvyhw7ZPn+dO8FQKx+YQsdgszpgUF8zlBUU8O/q5JBi7CzH3AFbO+w5OBUQwBibxHpizfx43ow2W0b+lcahvCbLfa55Wsvli04RWzqYHob+sL1t0Y4pOGVnZzfWe+o1fxwfHbYWvKhU0yd+n1aHVhcCqOPihpYhz1av4t6i7FlzWY2/XWPIm5AYL22HZ3r3wGxA46HC5uaBhuidY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(6916009)(5660300002)(9786002)(8936002)(9746002)(66946007)(36756003)(66476007)(2906002)(186003)(426003)(1076003)(86362001)(54906003)(33656002)(66556008)(316002)(83380400001)(26005)(478600001)(38100700002)(4326008)(8676002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?KAbYSeaRNMdSI3umtbDd5nPEC64DJ1ZYXkEBLXl5CPWkOVNP27dBtRcQ7xbg?=
 =?us-ascii?Q?ZBp191Qoqh///kUNH6PTN89cxodMs4alboqjaXYcvVj434/a2dBmypuAEKva?=
 =?us-ascii?Q?yutSos4y8zOn9EZptYFMhJj2+sO6OwRI9J8MhywAAcQB5iq1LbA+wqfJh2xg?=
 =?us-ascii?Q?E/ye9GTLkG3DW6xtcwPtmzwDfPf6Rm/QGcLPnqARptnt79vRjqyk0Xa6ROVJ?=
 =?us-ascii?Q?Uct7rBhkG1VeFtucpvtEvBMaawaLV4UHy6TtWZrf7KbTQ3LrOqgxH757Xwt4?=
 =?us-ascii?Q?R+a2fwst1MEwu87Kh46H1uWqyLeqpN1BiFDG/HiltJYY16XzwLQayJTwE7Y4?=
 =?us-ascii?Q?EnTeRCdxSYK+F2bNDmhVP0vmcFpYS+28baW+u8dw7mY6+LVUMlB2niKD0Kku?=
 =?us-ascii?Q?/kKcd8IFpBhiC88wcGxMtuMqxpYJO5twFYft9+J61LB1CemNgbhhLlgXVP7s?=
 =?us-ascii?Q?+bJltkMXyHH8VagdMZA7xMpnMtbVQdsg7xYZb7Rcu9mOSoCWLbxBiJeSdN0t?=
 =?us-ascii?Q?CK8MeXfrKblXpkcIYq/cRP3wlHOzqKCsX8gI9ZmYI5obRVoL257WwozBSz93?=
 =?us-ascii?Q?eHguFjPBQgaNCxt9bjG9E55cxobf7+iP4xcucmdq+/o3EllLeXBWd1iJy06T?=
 =?us-ascii?Q?4ZaeGNzWQom02YlVHKmekniSUsg8z0ZTHfzPHYGDBhcX0r/UuuFRcS0Degp5?=
 =?us-ascii?Q?HZ3ZXNlWUnSUwstuw77ubqOVmdAfD/yFChXGc067Iw051DfsD5y52o/fqKB7?=
 =?us-ascii?Q?3DeVGUK/1/MPa7Ub8dQIhAaLDeaoTVu4kLIgazB/R97FS1YtYolP4tdWiDQJ?=
 =?us-ascii?Q?T0BpRqNASw+3pnTBxaaEHsYpZJ/lHgyC526fHO3D3ydVAddxKkXd454aaHCT?=
 =?us-ascii?Q?q/FaSJ7nZihDw6lub0J5FVY60qiyXiNWaNCxgWNT5v+wLiaDkHhXcUnN5qPl?=
 =?us-ascii?Q?XTVZjVzsUpTQIzB75m7AgsIvtThJSyoa/ly1ZVBpcpYBH98lcTvvaP72jrXA?=
 =?us-ascii?Q?pQoxms0K18oKw6DDJZK3fWXVtqGSFhx9lzT1tZaUVAglO8qTNnB1zDXjipZS?=
 =?us-ascii?Q?0Eb/Tuo/KPM5nTuDbLv1quCkPWlz7PljGf0cq7wLtC6cNTRP0UZyRFUBoQeA?=
 =?us-ascii?Q?EqNRrBWZSave60YF2Y6l7YeJh0g7e6yomqTzOuZuGfCDLo5lUxyfSDef93Dj?=
 =?us-ascii?Q?Rsh6WhJFHVxNUDS+WNX5OC7R4pkCj5RHFL9ybFBVUvcXUCga+p42FKnPvQ5o?=
 =?us-ascii?Q?dwVJvjO31tedYU+mUmsDRilqqChPn3BdNEEDsK8V8BSRxZIfbYoy5cHQXlWI?=
 =?us-ascii?Q?YrstIzkj/F6d5pQHa8C2mFck?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61b0b5a4-b97a-47fd-f24a-08d908b4c16e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2021 13:11:08.3514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oh333SrflX4xfzF/qkLLIOFDDbJbZeKcvhqGPDIRUe4VQ4iFT1EBZmYhNQBjO/95
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2857
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 26, 2021 at 04:08:42PM +0300, Leon Romanovsky wrote:
> On Mon, Apr 26, 2021 at 09:03:49AM -0300, Jason Gunthorpe wrote:
> > On Sun, Apr 25, 2021 at 08:38:57PM +0300, Leon Romanovsky wrote:
> > > On Sun, Apr 25, 2021 at 02:22:54PM -0300, Jason Gunthorpe wrote:
> > > > On Sun, Apr 25, 2021 at 04:44:55PM +0300, Leon Romanovsky wrote:
> > > > > > > The proposed prepare/abort/finish flow is much harder to implement correctly.
> > > > > > > Let's take as an example ib_destroy_qp_user(), we called to rdma_rw_cleanup_mrs(),
> > > > > > > but didn't restore them after .destroy_qp() failure.
> > > > > > 
> > > > > > I think it is a bug we call rdma_rw code in a a user path.
> > > > > 
> > > > > It was an example of a flow that wasn't restored properly. 
> > > > > The same goes for ib_dealloc_pd_user(), release of __internal_mr.
> > > > > 
> > > > > Of course, these flows shouldn't fail because of being kernel flows, but it is not clear
> > > > > from the code.
> > > > 
> > > > Well, exactly, user flows are not allowed to do extra stuff before
> > > > calling the driver destroy
> > > > 
> > > > So the arrangement I gave is reasonable and make sense, it is
> > > > certainly better than the hodge podge of ordering that we have today
> > > 
> > > I thought about simpler solution - move rdma_restrack_del() before .destroy() 
> > > callbacks together with attempt to readd res object if destroy fails.
> > 
> > Is isn't simpler, now add can fail and can't be recovered
> 
> It is not different from failure during first call to rdma_restrack_add().
> You didn't like the idea to be strict with addition of restrack, but
> want to be strict in reinsert.

It is ugly we couldn't fix the add side, lets not repeat that uglyness
in other places

Jason
