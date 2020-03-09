Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC3217E871
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2020 20:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgCITaX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Mar 2020 15:30:23 -0400
Received: from mail-eopbgr40053.outbound.protection.outlook.com ([40.107.4.53]:48165
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726121AbgCITaW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 9 Mar 2020 15:30:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dcdEIATRC7Ff8rGHSFCpEmjhv/vFBNkJQGpGTv1YX4jKrD2iHHClaZbI5/k9+ggIXnH3/0mDrTdsUSaRrnJn7n4q+puUrMiOit+JgtfhDGScAFXGy8xohgmyxNWgeW8hTvM8+Cn8WgDWdCT5BBJKX9PRT4XCvy7Ur6j4UsDpbgT4KA4aLlSau1due5ocaBe4bdP+rCLNHqyREr3zvytgiyZ42BMWJgEkpeppWVay7rdVJrF50j19JzjqnFYF1Y11/1h1odYWnTUd3Anwv6LzA1zn2j7yv144GGCOD+6Al9RO12121GktT//W4ToeGmeOmz4VmKQ/LXxTFeokdhKzqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crJ1U728oqf3n4tdfK4wYkyt9FSSaB9S4ao/pnH+qKg=;
 b=G75iH+yh6JOCq5xQlFsU0kTiCq8iMpjfm0SoGGcl9rFpvYXyuSTnAXkLKFAgsH/k7V1WXRKFdoLZ+vS29AnvFU9FqiW6rd16lPzF43z6QiLYVarP8t/YTXrFUmwqIHSFQQvDA7mB/eb/KW6gfcEk0TAuIgz5BRLH8/lDLtFFLDvI/xtZ9anNymUIeoChAcC+HnbkviCLzIlOGYwCTRkdN60jWN66LatJimlcz2VBIBqj7A5WQvxjNiRSC1+WK4WpEEvp+mLV54xOKoSGkQBWo+AXXIZ/QUuuM7bay13vcEWkbJQOv0+WRlvWhulooGEQTFm5i2eVs9sFZwRT5hkPIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crJ1U728oqf3n4tdfK4wYkyt9FSSaB9S4ao/pnH+qKg=;
 b=oMs1eLUcpKhvnF/tsIc5pJyC3u2FW4GNqfSIzlOgj5ow1DmQYoDdrhwFgp22kwksU0LiACe+Ie/RNPA/WMfm5Hkjwf6FOmaRz9N5YhE00SRQBKQysdgK6z12ZR0eeU+ajopcx7SMCTU4TdNKUZF6YqcC8IlMfaK8BfZmgVTDZ4s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB5118.eurprd05.prod.outlook.com (20.178.11.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Mon, 9 Mar 2020 19:30:16 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::ed46:4337:c1cd:1887]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::ed46:4337:c1cd:1887%7]) with mapi id 15.20.2793.013; Mon, 9 Mar 2020
 19:30:16 +0000
Date:   Mon, 9 Mar 2020 16:30:12 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] RDMA/ucma: Put a lock around every call to the rdma_cm
 layer
Message-ID: <20200309193012.GA13183@mellanox.com>
References: <20200218210432.GA31966@ziepe.ca>
 <20200219060701.GG1075@sol.localdomain>
 <20200219202221.GN23930@mellanox.com>
 <20200307204153.GJ15444@sol.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200307204153.GJ15444@sol.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MN2PR19CA0036.namprd19.prod.outlook.com
 (2603:10b6:208:178::49) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.68.57.212) by MN2PR19CA0036.namprd19.prod.outlook.com (2603:10b6:208:178::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.11 via Frontend Transport; Mon, 9 Mar 2020 19:30:15 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1jBO6O-0002hp-86; Mon, 09 Mar 2020 16:30:12 -0300
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7d72de7a-df73-4ad7-c5f6-08d7c4604b81
X-MS-TrafficTypeDiagnostic: VI1PR05MB5118:
X-Microsoft-Antispam-PRVS: <VI1PR05MB5118456CBD1F51518100D2D2CFFE0@VI1PR05MB5118.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0337AFFE9A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10001)(10009020)(4636009)(396003)(366004)(346002)(39860400002)(136003)(376002)(199004)(189003)(66946007)(26005)(33656002)(36756003)(1076003)(4326008)(81166006)(81156014)(66476007)(8676002)(66556008)(6916009)(2616005)(9746002)(316002)(2906002)(9786002)(966005)(8936002)(5660300002)(186003)(52116002)(478600001)(86362001)(99710200001)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5118;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FkjgTkN9JtnfCgWAHCIRdzyv4JIulmbFJa4GScYLQKqK+n0wu+N3geUhNdGLB0cCpf6+c1sMhiFSwBYaZe+I5IDyTRsecOKRmtf5ydjbo5ZEKOfY0JSXyzIbYAaRZEB61tuZzY3Ai5rSCXjA9ol9xg0YE3HK19NPJM3z/GAV/HIgRsgUhHRZdhDS2lr3gukrF11iviqDl6VpaLZ5QFyOnzQSPZEiu+BxY7opq5RM3Yn5nVS9jrC4W5i3Q9sMyfxskRDY3nlTbcFG0ohicnpoY6aPuet8NOIMNWoltDVJP+ASejVlxRDIJadH2MSSOrFLcBij649o9HeQD+1ltP7TGNrm6PmgUPX3C6SU1owNXpBbfZqo2X4o0ELHacOTdGXsDQzN0G9gicXvY64waH0yITy4jJPHvE/d3WLnQm9sD8chKLvNWcTIttvB89wZDsc9Fudk1iSSo4HIe5SuTmHh+qU0Cv1sU0c0hYqTgOJomJ1tW3cc2zf++WRm6Qyi3ZIYCyVcfDERyUVWQJ9bxT9QJUnipZlKWb0nBGUBcOQ1I507eRe3t0Qkk33/2aAiDEeWAMe67JlqX6FdE4jHj1etgaRG/pqu8ZezFDeDAfIt/Wns5FEN8IqaX6hXmv296/8SyhdlpITyn/DTCISQySatGHC4AlolGZ0xa/Y/hxaMJPp+Y87Z4ZXAu2i0RzGfEYw5
X-MS-Exchange-AntiSpam-MessageData: DlLZBc/V1qAqAhOvDZFaSxOr4aDBsRfzwIzUpq8ZfArf5sJG6QyYPxeddnKZpfTXMSuk9jaFuMk38jOz+zZucSO5qsb4ye18DT84kepXdPaODbeGxMRwQn/mq1rM+7oYGUUrWYzzOqs7jadaQOtFEQ==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d72de7a-df73-4ad7-c5f6-08d7c4604b81
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2020 19:30:16.2602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TMGcJfWR1XF80ymmWKMQtZVRLjAu9agjcEUg9CmgmHBAM482DZHOBEz0NTBoLajEvBYgNnlOMZOnhuOT8fUWgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5118
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Mar 07, 2020 at 12:41:53PM -0800, Eric Biggers wrote:
> On Wed, Feb 19, 2020 at 08:22:25PM +0000, Jason Gunthorpe wrote:
> > On Tue, Feb 18, 2020 at 10:07:01PM -0800, Eric Biggers wrote:
> > > > these 11 lets include them as  well. I wasn't able to find a way to
> > > > search for things, this list is from your past email, thanks.
> > > > 
> > > 
> > > Unfortunately I haven't had time to work on syzkaller bugs lately, so I can't
> > > provide an updated list until I go through the long backlog of bugs.
> > 
> > Ok
> 
> Here's an updated list:
> 
> --------------------------------------------------------------------------------
> Title:              general protection fault in rds_ib_add_one
> Last occurred:      0 days ago
> Reported:           12 days ago
> Branches:           Mainline and others
> Dashboard link:     https://syzkaller.appspot.com/bug?id=15f96d171c64999196ac7db3de107f24b9182a8e
> Original thread:    https://lore.kernel.org/lkml/000000000000b9b7d4059f4e4ac7@google.com/T/#u
> 
> This bug has a C reproducer.

Looks like this is fixed by Hillf

> --------------------------------------------------------------------------------
> Title:              INFO: trying to register non-static key in xa_destroy
> Last occurred:      0 days ago
> Reported:           11 days ago
> Branches:           Mainline and others
> Dashboard link:     https://syzkaller.appspot.com/bug?id=c0a75a31c5fa84e6e5d3131fd98a5b56e2141b9a
> Original thread:    https://lore.kernel.org/lkml/00000000000046895c059f5cae37@google.com/T/#u
> 
> This bug has a C reproducer.

Fixed in v5.6-rc5

> --------------------------------------------------------------------------------
> Title:              general protection fault in nldev_stat_set_doit
> Last occurred:      4 days ago
> Reported:           11 days ago
> Branches:           Mainline and others
> Dashboard link:     https://syzkaller.appspot.com/bug?id=1fbcb607cf49d8b5a3c8e056971f045f9bfa34f3
> Original thread:    https://lore.kernel.org/lkml/0000000000004aa34d059f5caedc@google.com/T/#u
> 
> This bug has a C reproducer.

Fixed in v5.6-rc5
 
> --------------------------------------------------------------------------------
> Title:              BUG: corrupted list in _cma_attach_to_dev
> Last occurred:      2 days ago
> Reported:           6 days ago
> Branches:           Mainline
> Dashboard link:     https://syzkaller.appspot.com/bug?id=067b1e60bab1b617c1208f078cd76c9087f070e0
> Original thread:    https://lore.kernel.org/lkml/000000000000cfed90059fcfdccb@google.com/T/#u
> 
> This bug has a C reproducer.

Most likely fixed by this patch, syzkaller is re-testing

> --------------------------------------------------------------------------------
> Title:              WARNING: kobject bug in ib_register_device
> Last occurred:      1 day ago
> Reported:           12 days ago
> Branches:           Mainline and others
> Dashboard link:     https://syzkaller.appspot.com/bug?id=805ad726feb6910e35088ae7bbe61f4125e573b7
> Original thread:    https://lore.kernel.org/lkml/000000000000026ac5059f4e27f3@google.com/T/#u
> 
> This bug has a C reproducer.

Oh, this wasn't sent to rdma, yes, obvious rdma bug, made a patch

> --------------------------------------------------------------------------------
> Title:              BUG: corrupted list in cma_listen_on_dev
> Last occurred:      4 days ago
> Reported:           4 days ago
> Branches:           Mainline
> Dashboard link:     https://syzkaller.appspot.com/bug?id=e8fcdea4e5a443c597c94fb6eda7d6646eafe6a2
> Original thread:    https://lore.kernel.org/lkml/00000000000020c5d205a001c308@google.com/T/#u
> 
> This bug has a C reproducer.

Fixed by this patch, syzkaller confirmed, now duped to another bug

> --------------------------------------------------------------------------------
> Title:              KASAN: use-after-free Read in rxe_query_port
> Last occurred:      0 days ago
> Reported:           6 days ago
> Branches:           Mainline and others
> Dashboard link:     https://syzkaller.appspot.com/bug?id=f00443e97b44c466dc75edc31601110bf62a6f69
> Original thread:    https://lore.kernel.org/lkml/0000000000000c9e12059fc941ff@google.com/T/#u
> 
> Unfortunately, this bug does not have a reproducer.

Perhaps Yanjun Zhu will look at this

> --------------------------------------------------------------------------------
> Title:              WARNING in ib_free_port_attrs
> Last occurred:      1 day ago
> Reported:           6 days ago
> Branches:           net and net-next
> Dashboard link:     https://syzkaller.appspot.com/bug?id=4ec089798f282f2d2c3219151e420ed1ba10120d
> Original thread:    https://lore.kernel.org/lkml/000000000000460717059fd83734@google.com/T/#u
> 
> Unfortunately, this bug does not have a reproducer.

Parav and I looked at this for a while and couldn't figure how how it
is possible. Hoping for a reproducer

> --------------------------------------------------------------------------------
> Title:              INFO: task hung in rdma_destroy_id
> Last occurred:      3 days ago
> Reported:           5 days ago
> Branches:           Mainline and others
> Dashboard link:     https://syzkaller.appspot.com/bug?id=e89b86960c3636f57dbb16bb25a829377ebdf43d
> Original thread:    https://lore.kernel.org/lkml/00000000000059e701059fe3ec2f@google.com/T/#u
> 
> Unfortunately, this bug does not have a reproducer.

Most likely fixed by this patch

> --------------------------------------------------------------------------------
> Title:              general protection fault in kobject_get
> Last occurred:      6 days ago
> Reported:           6 days ago
> Branches:           net-next
> Dashboard link:     https://syzkaller.appspot.com/bug?id=f8e0f99b310558dd489cc7427711a640c10b93e5
> Original thread:    https://lore.kernel.org/lkml/000000000000c4b371059fd83a92@google.com/T/#u
> 
> Unfortunately, this bug does not have a reproducer.

Really surprised no reproducer, this is not a race bug. I wrote a fix,
it is being tested now.

> --------------------------------------------------------------------------------
> Title:              WARNING: kobject bug in add_one_compat_dev
> Last occurred:      8 days ago
> Reported:           10 days ago
> Branches:           linux-next and net-next
> Dashboard link:     https://syzkaller.appspot.com/bug?id=f8880fdc3cd0ba268421672360cf79bfa7fa4272
> Original thread:    https://lore.kernel.org/lkml/0000000000005f77d6059f888f2e@google.com/T/#u
> 
> Unfortunately, this bug does not have a reproducer.

Hmm. I wonder if this is because 'dev_set_name' failed and we ignored
it? Is that possible with this log? Lets fix that at least - I have no
other idea how we could get an empty name.

> --------------------------------------------------------------------------------
> Title:              WARNING in srp_remove_one
> Last occurred:      9 days ago
> Reported:           6 days ago
> Branches:           Mainline
> Dashboard link:     https://syzkaller.appspot.com/bug?id=16a5827f8f6f6ef0967e6492ffb2e2ca54c8c0fb
> Original thread:    https://lore.kernel.org/lkml/000000000000144d79059fc9415d@google.com/T/#u
> 
> Unfortunately, this bug does not have a reproducer.

This looks a lot like 'WARNING in ib_free_port_attrs' - I don't have a
clear idea how these sysfs errors are possible. I wonder if there is
something strange going on in sysfs land during net ns actions?

Thanks,
Jason
