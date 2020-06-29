Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C13620D642
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jun 2020 22:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731809AbgF2TSg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Jun 2020 15:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731869AbgF2TRm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 Jun 2020 15:17:42 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2062f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1a::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E73C02E2F5
        for <linux-rdma@vger.kernel.org>; Mon, 29 Jun 2020 07:30:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8bO3zB+JzXUbZaKkSTXYwyU4NvEgf30XndLx4T+Cq+E6jB3ZJ0pLBAV/jPf2qqatwkreoJ3qwc3h8CRa4mZ5HmvV2bOWoRS027f8hTFWh0kzPOXorTDnT1FFW9LMkX6R6Bu767S43eo3fmQMtza3l1DlBIn3TvNwyuk3kzw80U19Ox6dF+FD4F0KTPU1GgwKMpFRCHQf+1N4gUMtSdLUnJ0qna8a0sOIiRboi9zca0zhBtTIancDAv33ozK5pzgpasQRv/o4jq0bFL3jCGsOXWgreHG/BoSS6jHrRb7g3pOYtcGQfcgCBKfWeEnQUr3tCt4U688d4wl1iwD9iW5jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FM274cJFTNqdiSZzZUEQHO8nw0eVfTTdJT8BWxrojtM=;
 b=H3M9Gb7BBU3cBnr3Io7bnLEimUnqwl5Bxb9+fpPFr08YYPEkiO8qlBAz1/VLq6iQAPJeSyzfue2OFW14qHVl3vKINQGsDfNaHUxoWNL2jtWGTf8on2jMNRA+va9yfeLqd0r5w2ko0pr5qBcGU27fvXKtaHUOnt8UWBYBIeh+Y6/vPzJs11xxaQDNHNJvFe/mbIOxRo5iKckpCLvoYP4cSVdK/q5tTaa/Lp1LLxRsX1LyQPbCkJjk5LLJuGLoAeYNCBWUCEuS1zaSsWTepKLVpEYIjrf2k/6nO0HHpAFZgTiMmgjkGm+QlE5YEv+7cOqDqZgDbwhC1Gqc+lu/VFjO5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FM274cJFTNqdiSZzZUEQHO8nw0eVfTTdJT8BWxrojtM=;
 b=JTLeF/uDZkejdN30ISFHwzuLvA4gQhj54TGofJ0q4zrxC39HQiIjDOXPUkBHDQzXQ+SfOCa4KE396sd3x/hgfZXNb6vVkCakgazXS56nXRXWC2DLY+IaGbPr9p7OwaVw9LA/JrGJyZBhGtfhyNCmfzDtWcGWl+UwmgO1cXXxc+E=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=mellanox.com;
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR0502MB3696.eurprd05.prod.outlook.com (2603:10a6:803:2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.24; Mon, 29 Jun
 2020 14:30:16 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e%7]) with mapi id 15.20.3131.026; Mon, 29 Jun 2020
 14:30:16 +0000
Date:   Mon, 29 Jun 2020 11:30:12 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] RDMA/ucma: Put a lock around every call to the rdma_cm
 layer
Message-ID: <20200629143012.GH23821@mellanox.com>
References: <20200218210432.GA31966@ziepe.ca>
 <20200219060701.GG1075@sol.localdomain>
 <20200219202221.GN23930@mellanox.com>
 <20200307204153.GJ15444@sol.localdomain>
 <20200309193012.GA13183@mellanox.com>
 <20200627225734.GL7065@sol.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200627225734.GL7065@sol.localdomain>
X-ClientProxiedBy: MN2PR10CA0016.namprd10.prod.outlook.com
 (2603:10b6:208:120::29) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR10CA0016.namprd10.prod.outlook.com (2603:10b6:208:120::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend Transport; Mon, 29 Jun 2020 14:30:16 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@mellanox.com>)      id 1jpunU-00174n-9V; Mon, 29 Jun 2020 11:30:12 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 457b5813-0a2d-4b26-afcf-08d81c38f11b
X-MS-TrafficTypeDiagnostic: VI1PR0502MB3696:
X-Microsoft-Antispam-PRVS: <VI1PR0502MB36962DA3F5F32E9385B3D1EFCF6E0@VI1PR0502MB3696.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 044968D9E1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8vcPNTwLxylNk5F7Ti9E5GdgS0/MV3KUnmBx+y3VI75JRRLKm5T83OQ1cJTclMpf1GjTxCFbC5uD56NSTgGwdxLNfhL1QKXdWrSWqT6217DVXSwHZZYoiqXGvViFD2mdHvEaMNBFqQ55AwegJxfTXpIUjYDjH1rZVHgn8PHRia621z+46bt6iUR5IluWFuUzjdMzxrevOZ4t2JVaXUD4UKzh2TYC+9c1MYzLxk97KzvDXXMogtmYQ712nw+0ZOZAWOuTIY0K0CQ062SAYaayYD/n/vVm1DvTLiqotnMow3lKHdHzcBgJcylpPN+W448TGWneH/5nmr2geQC2TQXJav/73ug/ZZbeNn5X7/5vt/lQ5xa07ozW+4e5fm/4keyYK+qLr9xPKMk6VOFhSp4iQnr7Cgyf2iS2utfS2MhebBCUbOGwAvUjyTW36SYhP/L+HXc+TN9tNCZ5SL59PMl2Pw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(9786002)(9746002)(4326008)(2906002)(66946007)(478600001)(186003)(966005)(66476007)(66556008)(5660300002)(26005)(33656002)(1076003)(36756003)(83380400001)(6916009)(86362001)(426003)(8676002)(8936002)(83080400001)(2616005)(316002)(99710200001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: S6E2pnuvjSjOQo16HeHwNhTXexryke5MX0alHkRdsB4yYmvxK386HbT/oDFrMVqjGS+Nt58wwK3zMZZ+ptnNHgJafCt+S4z0BfGqI1fLfTzUlKAb7S6GGDMZXihLVPsMlFYOpQCmpH5Lb8i8/2hTmpXeCd2RC88ZT280+yeyCXBpzGgSU0+gXy6syB1nDFrlvosfcccuf1Qw4yr+R3ZrJUOXJaiaYez1MCxkO9INWKYWQEhK6H8gJF0AtJJTxaZQPBW5cw+DFqtWfx8wBmPwDMlhP3NYr1Jejv4c5VY7p2R+6YScdQGbix/7CVVPOC9O87m/djJMXoz1YRn25enDHgPENb556Il6ZD0uAWDXPWXAVaJzc/2Y9KC1FiwRmBn8lf0YCjITA40rYGXJ+mUaoH7i8hdNyMCN51oMPHfvDNjGufuphZLIQD4RUi2zAcidu6dXnTNAsvXM7SxVg9zVyX2O5Wm3dzUaZY2hk1hXUFA=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 457b5813-0a2d-4b26-afcf-08d81c38f11b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR05MB4141.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2020 14:30:16.4973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NoHdTYbGAR13JiOw4r62uQsw6X83Wljy3P4KDQhvgbibv/RSos+qtjfU+MgTuXu4p3cW0o64DSgmGc8Ox8OZ/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3696
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jun 27, 2020 at 03:57:34PM -0700, Eric Biggers wrote:
 
> Hi Jason, here's my latest list (updated today) of bugs that are probably in
> drivers/infiniband/:

Thanks, lets see:
 
> Title:              general protection fault in rds_ib_add_one
> Last occurred:      1 day ago
> Reported:           124 days ago
> Branches:           Mainline and others
> Dashboard link:     https://syzkaller.appspot.com/bug?id=15f96d171c64999196ac7db3de107f24b9182a8e
> Original thread:    https://lore.kernel.org/lkml/000000000000b9b7d4059f4e4ac7@google.com/T/#u
> 
> This bug has a C reproducer.
> 
> The original thread for this bug received 5 replies; the last was 117 days ago.
> 
> If you fix this bug, please add the following tag to the commit:
>     Reported-by: syzbot+274094e62023782eeb17@syzkaller.appspotmail.com
> 
> If you send any email or patch for this bug, please consider replying to the
> original thread.  For the git send-email command to use, or tips on how to reply
> if the thread isn't in your mailbox, see the "Reply instructions" at
> https://lore.kernel.org/r/000000000000b9b7d4059f4e4ac7@google.com

This is RDS, Hillif and Santos were handling it.. I pinged the thread

 
> Title:              WARNING in srp_remove_one
> Last occurred:      0 days ago
> Reported:           118 days ago
> Branches:           Mainline and others
> Dashboard link:     https://syzkaller.appspot.com/bug?id=16a5827f8f6f6ef0967e6492ffb2e2ca54c8c0fb
> Original thread:    https://lore.kernel.org/lkml/000000000000144d79059fc9415d@google.com/T/#u
> 
> Unfortunately, this bug does not have a reproducer.
> 
> No one replied to the original thread for this bug.
> 
> If you fix this bug, please add the following tag to the commit:
>     Reported-by: syzbot+687bc62a84a6a2a3555a@syzkaller.appspotmail.com
> 
> If you send any email or patch for this bug, please consider replying to the
> original thread.  For the git send-email command to use, or tips on how to reply
> if the thread isn't in your mailbox, see the "Reply instructions" at
> https://lore.kernel.org/r/000000000000144d79059fc9415d@google.com

This is *probably* the 'sysfs problem'

I have a good guess what this is, but I really need to see a
reproduction on it before trying to fix it. I can probably make the
odds of hitting this much higher with a patch, but syzkaller would
have to chew on that patch for a while to find a reproduction..

> Title:              WARNING in ib_uverbs_remove_one
> Last occurred:      0 days ago
> Reported:           99 days ago
> Branches:           Mainline and others
> Dashboard link:     https://syzkaller.appspot.com/bug?id=7d092a26c44ac45dc0a59a1a0474be064db8fa66
> Original thread:    https://lore.kernel.org/lkml/000000000000c3a75205a14cb8c9@google.com/T/#u
> 
> Unfortunately, this bug does not have a reproducer.
> 
> No one replied to the original thread for this bug.
> 
> If you fix this bug, please add the following tag to the commit:
>     Reported-by: syzbot+d3f37b9458fe8281d078@syzkaller.appspotmail.com
> 
> If you send any email or patch for this bug, please consider replying to the
> original thread.  For the git send-email command to use, or tips on how to reply
> if the thread isn't in your mailbox, see the "Reply instructions" at
> https://lore.kernel.org/r/000000000000c3a75205a14cb8c9@google.com

This is *probably* the 'sysfs problem'

> Title:              WARNING in ib_free_port_attrs
> Last occurred:      1 day ago
> Reported:           117 days ago
> Branches:           Mainline and others
> Dashboard link:     https://syzkaller.appspot.com/bug?id=4ec089798f282f2d2c3219151e420ed1ba10120d
> Original thread:    https://lore.kernel.org/lkml/000000000000460717059fd83734@google.com/T/#u
> 
> Unfortunately, this bug does not have a reproducer.
> 
> The original thread for this bug received 1 reply, 116 days ago.
> 
> If you fix this bug, please add the following tag to the commit:
>     Reported-by: syzbot+e909641b84b5bc17ad8b@syzkaller.appspotmail.com
> 
> If you send any email or patch for this bug, please consider replying to the
> original thread.  For the git send-email command to use, or tips on how to reply
> if the thread isn't in your mailbox, see the "Reply instructions" at
> https://lore.kernel.org/r/000000000000460717059fd83734@google.com

This is *probably* the 'sysfs problem', but not as clear

> Title:              WARNING in ib_umad_kill_port
> Last occurred:      1 day ago
> Reported:           82 days ago
> Branches:           Mainline and others
> Dashboard link:     https://syzkaller.appspot.com/bug?id=4ecc18c71d37b62b131aee8184a642ae5d2d21a6
> Original thread:    https://lore.kernel.org/lkml/00000000000075245205a2997f68@google.com/T/#u
> 
> Unfortunately, this bug does not have a reproducer.
> 
> The original thread for this bug has received 8 replies; the last was 79 days
> ago.
> 
> If you fix this bug, please add the following tag to the commit:
>     Reported-by: syzbot+9627a92b1f9262d5d30c@syzkaller.appspotmail.com
> 
> If you send any email or patch for this bug, please consider replying to the
> original thread.  For the git send-email command to use, or tips on how to reply
> if the thread isn't in your mailbox, see the "Reply instructions" at
> https://lore.kernel.org/r/00000000000075245205a2997f68@google.com

This is *probably* the 'sysfs problem'

> Title:              KASAN: use-after-free Write in addr_resolve
> Last occurred:      20 days ago
> Reported:           17 days ago
> Branches:           Mainline
> Dashboard link:     https://syzkaller.appspot.com/bug?id=e0a96faaf6799220954d5f5d8ec6fa0c386f85ac
> Original thread:    https://lore.kernel.org/lkml/000000000000eb293205a7bdd19a@google.com/T/#u
> 
> Unfortunately, this bug does not have a reproducer.
> 
> No one has replied to the original thread for this bug yet.
> 
> If you fix this bug, please add the following tag to the commit:
>     Reported-by: syzbot+08092148130652a6faae@syzkaller.appspotmail.com
> 
> If you send any email or patch for this bug, please consider replying to the
> original thread.  For the git send-email command to use, or tips on how to reply
> if the thread isn't in your mailbox, see the "Reply instructions" at
> https://lore.kernel.org/r/000000000000eb293205a7bdd19a@google.com

I think I have a fix for this

> Title:              KASAN: use-after-free Read in addr_handler (2)
> Last occurred:      17 days ago
> Reported:           17 days ago
> Branches:           Mainline
> Dashboard link:     https://syzkaller.appspot.com/bug?id=cfd37bf8b5d2768b6b87e7b4c3a588a06ea6284a
> Original thread:    https://lore.kernel.org/lkml/000000000000107b4605a7bdce7d@google.com/T/#u
> 
> Unfortunately, this bug does not have a reproducer.
> 
> The original thread for this bug has received 2 replies; the last was 20 hours
> ago.
> 
> If you fix this bug, please add the following tag to the commit:
>     Reported-by: syzbot+a929647172775e335941@syzkaller.appspotmail.com
> 
> If you send any email or patch for this bug, please reply to the original
> thread, which had activity only 20 hours ago.  For the git send-email command to
> use, or tips on how to reply if the thread isn't in your mailbox, see the "Reply
> instructions" at https://lore.kernel.org/r/000000000000107b4605a7bdce7d@google.com

Probably a dup of the above

> Title:              KASAN: use-after-free Read in ib_uverbs_remove_one
> Last occurred:      33 days ago
> Reported:           30 days ago
> Branches:           linux-next
> Dashboard link:     https://syzkaller.appspot.com/bug?id=f1a3b9d9350867a50d642b8e2cee217569b8adca
> Original thread:    https://lore.kernel.org/lkml/00000000000095442505a6b63551@google.com/T/#u
> 
> Unfortunately, this bug does not have a reproducer.
> 
> The original thread for this bug has received 2 replies; the last was 28 days
> ago.
> 
> If you fix this bug, please add the following tag to the commit:
>     Reported-by: syzbot+478fd0d54412b8759e0d@syzkaller.appspotmail.com
> 
> If you send any email or patch for this bug, please consider replying to the
> original thread.  For the git send-email command to use, or tips on how to reply
> if the thread isn't in your mailbox, see the "Reply instructions" at
> https://lore.kernel.org/r/00000000000095442505a6b63551@google.com

Couldn't figure it out.

> Title:              WARNING in ib_unregister_device_queued
> Last occurred:      51 days ago
> Reported:           62 days ago
> Branches:           net
> Dashboard link:     https://syzkaller.appspot.com/bug?id=979c332b27ca869bd26c337574ef068908c1da3c
> Original thread:    https://lore.kernel.org/lkml/000000000000aa012505a431c7d9@google.com/T/#u
> 
> Unfortunately, this bug does not have a reproducer.
> 
> The original thread for this bug has received 2 replies; the last was 60 days
> ago.
> 
> If you fix this bug, please add the following tag to the commit:
>     Reported-by: syzbot+4088ed905e4ae2b0e13b@syzkaller.appspotmail.com
> 
> If you send any email or patch for this bug, please consider replying to the
> original thread.  For the git send-email command to use, or tips on how to reply
> if the thread isn't in your mailbox, see the "Reply instructions" at
> https://lore.kernel.org/r/000000000000aa012505a431c7d9@google.com

Fix sent

Jason 
