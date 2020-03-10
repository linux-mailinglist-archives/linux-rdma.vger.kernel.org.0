Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8505C18009C
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2020 15:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgCJOw2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Mar 2020 10:52:28 -0400
Received: from mail-eopbgr20055.outbound.protection.outlook.com ([40.107.2.55]:16366
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726466AbgCJOw2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 10 Mar 2020 10:52:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=moxMBAW66ST2tY39s+GQFg0MTXDv2dCjIra+QBZ9O84CTsCUdaflQL/wP4d5VkWXVxUwe/R7NNCB2vQstRwUNAuQMk63UWBHNKABoihLu0pGKTPHQcT8b7z+Vmsqj/9zY5n8nx+1/ud4XwR/Jxh6Y00YYb1Ea2BGRcdDnsGLZ2n6d/Fm2JWpEcncWMfmuHHtASAyQvjxiBBzUJ0lohj91gTNiNEtxoD4KWPuyMtNVupA/MzO+q4bqLluuIWMniLg13BPX6oiqMNquAS9GjMvAcAuBWjwywocX9MASr05lYpuUb5Cqz4Res6NunJPAtibr2uo0qub9Js3sjNNTPcM9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+ME1ZThUL4lzFKeT4mNEwRunQD3ANte3sD1BGPc6xg=;
 b=cwg3zmB7w0k+ilWJde6za5TNj6vhDTcN5rlHcV6GTXKr4ks+QGdQPTozcAy3PKCoCdEJd7V30gagG/xUQeFc2+Vv4kM3gVC4Ft9ziZXYbRd/4bj4DwPeBwKnQKMWIViIi1F5oCQMHVhgXWSW5u9mZ0Tos74nz/nLv1Y6Gr/Ohr+D3e3JdNXB8aoREuac92BjAi8PHSc5Bb7mexsAHQTmFOjMCUHfnDw+LZJ5HWq3cdyDZY9A6A0DCI7vWpnyQoNPtSqi46eo35sFNj4UCyeImVgtHbeen93YZu2IeFG/VHVHEu3oWkRbjA920yHm3KLAjiyeArHZ+OJAigYHnnxRAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+ME1ZThUL4lzFKeT4mNEwRunQD3ANte3sD1BGPc6xg=;
 b=IV3UK/WKR0d71SSiJSQw7WA4V+s18YTFwyGaki7TbxZe5Xlj2BGutjYqiLkK7hLYPRzTgqKSBpahdMkjVEyGpqb6vdjHB1bRUF9yECYkWyiMpmgea9WkzdS/SRBMj9M8wjBs1w899GZpU9ZyHa1yAUPuK2wdJ4wTI7rFv+PDHTw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from DB7PR05MB4138.eurprd05.prod.outlook.com (52.135.129.16) by
 DB7PR05MB6154.eurprd05.prod.outlook.com (20.178.106.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.15; Tue, 10 Mar 2020 14:52:24 +0000
Received: from DB7PR05MB4138.eurprd05.prod.outlook.com
 ([fe80::fc73:62c6:1b2e:2168]) by DB7PR05MB4138.eurprd05.prod.outlook.com
 ([fe80::fc73:62c6:1b2e:2168%7]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 14:52:24 +0000
Date:   Tue, 10 Mar 2020 11:52:20 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     syzbot <syzbot+e11efb687f5ab7f01f3d@syzkaller.appspotmail.com>,
        dledford@redhat.com, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, monis@mellanox.com,
        syzkaller-bugs@googlegroups.com, yanjunz@mellanox.com
Subject: Re: KASAN: use-after-free Read in rxe_query_port
Message-ID: <20200310145220.GO13183@mellanox.com>
References: <0000000000000c9e12059fc941ff@google.com>
 <20200309173451.GA15143@mellanox.com>
 <20200310073936.GF172334@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310073936.GF172334@unreal>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: BL0PR02CA0015.namprd02.prod.outlook.com
 (2603:10b6:207:3c::28) To DB7PR05MB4138.eurprd05.prod.outlook.com
 (2603:10a6:5:23::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.68.57.212) by BL0PR02CA0015.namprd02.prod.outlook.com (2603:10b6:207:3c::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17 via Frontend Transport; Tue, 10 Mar 2020 14:52:24 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1jBgF2-0002dA-HK; Tue, 10 Mar 2020 11:52:20 -0300
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 544b3784-f5b6-44ad-7c30-08d7c502a4b8
X-MS-TrafficTypeDiagnostic: DB7PR05MB6154:|DB7PR05MB6154:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR05MB615472954B2365B314B19BB2CFFF0@DB7PR05MB6154.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 033857D0BD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10001)(10009020)(4636009)(366004)(376002)(39860400002)(346002)(396003)(136003)(189003)(199004)(8936002)(8676002)(81156014)(81166006)(86362001)(33656002)(9746002)(9786002)(1076003)(316002)(4326008)(36756003)(52116002)(2906002)(186003)(5660300002)(2616005)(66476007)(66946007)(966005)(26005)(6916009)(66556008)(478600001)(107886003)(99710200001)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR05MB6154;H:DB7PR05MB4138.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dLm5eTP8Z3EnLCJwHk90EtdwH/NxYPFB22emRcfMkh1sP3y3E/JTrhGE9MBEk2OKRQV+D76bedJrwbuPm397nsliB6BCks/CRxIhNZW68Y4wAdI4iDNPcBMgunu4lcD2jRuQ2K9gkmtREA0awoSZcme33xAAl46pPBAHOj7xp2kgMq44okBbqC2/A9C8eiX1EJEYcjrkKKce2vvqixU/q5uaNiV6YjgGNr31gII4GDZ2aSxdEfD52twLvnQruJZAQw2dtqaWORRJxXwymipdTi1SdsTIlYCKvc1rX6yNR5uvI6gc+x6dCcKruwGQ99TBVk0t1IsN80WJi6/HuGNIqqm2mmF/Ghs1s3z8bsrwJZb3OyDS2JpaRX81tCRoxjK9PTaI0NDfPdn7G0SzGmtsBXYjnuCHoU7nrXlEjauXmZF6opRKdRW1kU6ebZ5r3fEe3Uob4H2jOez72sJK+fFaRt3Bsjlp//yND9rt2SQrgz0TyKRzHi4tyFj6YsKYgnTxMzSdO277yPlKQidkFd486NDiousXsJr/GoD9kanJvOShl3TTji85HsvuAs1SBGRpsWUVcNfPmdtrULGEp/6HxVmeoK2dtEyhIsPegGgstTyZO3JAR8qpgW042yaavXlCNIiklolYDp7apuIIogNuehFPWyCGatpytHef6jvL6DKcNOWa30FZo6tTWuPW/v6f
X-MS-Exchange-AntiSpam-MessageData: rat2OMOveop4jrbDlv5XissyaqpDnd9Yal/3/troosx+hECjHsgeG4cx9pYwl44KPLvqYgfmHNr5YMajnVDq/GosckL0e2eU7qmKXTKusLT76lZBnUMyZ/ffm4pAeEXaYGVdTgD/IlPbpp2eAJEulQ==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 544b3784-f5b6-44ad-7c30-08d7c502a4b8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2020 14:52:24.2403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ALAI7l3M/229KDln8nDmwVpJTU813VGGws/MJ1gHkRwAS+RfKXBKn43Isg0V/1LbCENlFy88AC1abE/yNCUww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB6154
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 10, 2020 at 09:39:36AM +0200, Leon Romanovsky wrote:
> On Mon, Mar 09, 2020 at 02:34:51PM -0300, Jason Gunthorpe wrote:
> > On Sun, Mar 01, 2020 at 03:20:12AM -0800, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following crash on:
> > >
> > > HEAD commit:    f8788d86 Linux 5.6-rc3
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=132d3645e00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=9833e26bab355358
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=e11efb687f5ab7f01f3d
> > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > >
> > > Unfortunately, I don't have any reproducer for this crash yet.
> > >
> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > Reported-by: syzbot+e11efb687f5ab7f01f3d@syzkaller.appspotmail.com
> >
> > Yanjun, do you have some idea what this could be?
> 
> See this fix in the net mailing list.
> https://lore.kernel.org/netdev/20200306134518.84416-1-kgraul@linux.ibm.com

Yes, seems right to me, that work is calling ib_query_port().

#syz dup: WARNING: ODEBUG bug in smc_ib_remove_dev

Jason
