Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6C117E5D4
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2020 18:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbgCIRe7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Mar 2020 13:34:59 -0400
Received: from mail-am6eur05on2065.outbound.protection.outlook.com ([40.107.22.65]:19287
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727257AbgCIRe6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 9 Mar 2020 13:34:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OxpzD6485r7or3rhplcXYwCOAEXh36wJz7wP8XtCli4pl9ZYXBWk1CQxFXUvQ1as8GBvBe57F+AEk7nxdo3cIWLOM2SccXHabef+3tsAGmwXRQZWzsoNzitrp10XuO5jFSrfr2vzO9MjIOJBfd9XdPd38bFrkfrKxpQk3DAhEHbXBRxqmgfWzVa7OARD2HIYeSeo5ccW39OOkGa4IUFlC/NHBwZbS+J5K2rT9EgE1PBfs80OunqN/Ogbn9UOS8ntAioaJ/ffjE0YIF6rGBBc0uS1V2axzU2Stx77ntB/KberBbsKoTpSSmCE5i39OaSR/S9XypkXJGaGJS3WTgsTOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyvH6uLP1cqKFnzh1Euzle9kVCHGGGaKd2hMo+2y4+o=;
 b=Hf8NzNEpCO2rnDkjCdmqaor6ai7S4olr1SPQJPV8/ZCj32kQiwUFRlmBqWXgOak++cqafpYMCak1LZrYiYneMWzTB3gVSttMKKKRD982ToISpJdUZvMvXzL1OEpsF3d4dFku8vS8q/Rst++qRxKbomv/xzlzsEL73jPIc2WpyB5RtRY4Qw3IIrILHoTTEraWppevlwpbWmR87Zzam5Fjv2GOn5Wg5WbtXdWs54S5FYT7yhFRVb2Sfq5bS8cpghHxWGv3rzHbFlFFO1R9+ErTo/IFvgimV4u/thwsqzcMWQGqtDoo9TOKN9sDVw9s3YnEW28ozNS9ACmcGy+J2nm0dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyvH6uLP1cqKFnzh1Euzle9kVCHGGGaKd2hMo+2y4+o=;
 b=I21B09BWrRU/7yVCL173o9GXrkoujJFqwSL3mkUyDWcQev6bSMcDhH3Rv+2LB0YLqLa3yMhTIaIqRGGNE1hhTTrWXxr/TDuA0XZGn08Ji2NHKENJzuqMI2+gH2qf86sB04p5onPUZ4+uZ/q6djlLT0kvDu+jqokQnzAZzp8B9FM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB4767.eurprd05.prod.outlook.com (20.176.8.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Mon, 9 Mar 2020 17:34:55 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::ed46:4337:c1cd:1887]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::ed46:4337:c1cd:1887%7]) with mapi id 15.20.2793.013; Mon, 9 Mar 2020
 17:34:55 +0000
Date:   Mon, 9 Mar 2020 14:34:51 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     syzbot <syzbot+e11efb687f5ab7f01f3d@syzkaller.appspotmail.com>
Cc:     dledford@redhat.com, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, monis@mellanox.com,
        syzkaller-bugs@googlegroups.com, yanjunz@mellanox.com
Subject: Re: KASAN: use-after-free Read in rxe_query_port
Message-ID: <20200309173451.GA15143@mellanox.com>
References: <0000000000000c9e12059fc941ff@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000000c9e12059fc941ff@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MN2PR22CA0022.namprd22.prod.outlook.com
 (2603:10b6:208:238::27) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.68.57.212) by MN2PR22CA0022.namprd22.prod.outlook.com (2603:10b6:208:238::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16 via Frontend Transport; Mon, 9 Mar 2020 17:34:55 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1jBMIl-0003x3-Hu; Mon, 09 Mar 2020 14:34:51 -0300
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 60274afc-317a-43e2-fe83-08d7c4502e65
X-MS-TrafficTypeDiagnostic: VI1PR05MB4767:|VI1PR05MB4767:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR05MB476753266B0A3C18F3CFD60ECFFE0@VI1PR05MB4767.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0337AFFE9A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10001)(10009020)(4636009)(346002)(396003)(136003)(366004)(39860400002)(376002)(189003)(199004)(2616005)(4326008)(478600001)(9746002)(86362001)(36756003)(66946007)(2906002)(8676002)(66476007)(66556008)(1076003)(52116002)(9786002)(107886003)(4744005)(186003)(966005)(33656002)(26005)(5660300002)(316002)(81166006)(81156014)(8936002)(99710200001)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4767;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DIXsMxkf/F1WPQkDpU1znY7x2Q2jsVx9XdWSZ0i5QV9d3iWdDdd/buCL6YA5Ml+cEE4YA1HXlm7DFN7bPuezagbP4z9S7R+a8wcCn0tk+mBEwZqFg032V0G0wGCt6kq4xmuTva8VhMFnseYqkq4gtpqu0LfEfLkwh2W3OT2teqmeimfFAEfG3SoxWaKRimFbKFVYNw/zzmVmcxpRWb3/5+XY8fNGmBUh5g/ytCjQGm6VHIvSIxMI9sIaq+OhB7+74HTqwG1tT+BTNzE8z/jnndkSasJF8Yr+gUJPYbjStDe+Pr1y3t8G/S878zXDlR2uu0msgON8nSUzHYY9C7jnLP3+3wPGuYjuCgHLFVCOnIi3Lj0K8JZLbo1Y1md4A3AFjWUz0xObvJtRqtfBTNxmThTZTv6H3GzlqmQHyfUYOHguhf0tQ269dTIISSqvXl8+EQP5UVtp15m3Kh7q704TTe1W+4/dCVZ5GdsEIStS3E9d4i/kdFEIjTq6r1VtYT5Tnn9o4B8GYut7jFZFrWFIpcerAQsQZa+M7ZvQ3gaFP2VeCZC0nEZlmYvEEC4OmJqF811PpOxIvCocvyqI7cWMGD5vKGNEvpsOiNfVDDBjkaKwl2BGx4C2oqxtLj+pYNkapi9yFJ6TjJyb4b7KE53hkf9biYAU3ZNrBopTwUNA2veyfLQepGYVR238C+26W2ZC
X-MS-Exchange-AntiSpam-MessageData: nZxdsOraAVrMMyy9fvi0V+d+ODmtlFIOpz0M6fc+xes7lf9cFzQ035zL+/Ae5Bk+g+nxp4OsAUkrghptxgvV3aZTpHal68aLhwPQDiz0T+WAWnhfiOHDRmCmPORyJIg6GzlPnmwyJ2dHIR7rv9bdtA==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60274afc-317a-43e2-fe83-08d7c4502e65
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2020 17:34:55.4266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4QJ3VrWGUbBsj9pMaBeNe4gOwDe2OhjX5e8AZd3aLGzAcWNAo8MxaLEvJ7AH3wionsNnlsp9Hf0x1LuTXjTF4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4767
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Mar 01, 2020 at 03:20:12AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    f8788d86 Linux 5.6-rc3
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=132d3645e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9833e26bab355358
> dashboard link: https://syzkaller.appspot.com/bug?extid=e11efb687f5ab7f01f3d
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+e11efb687f5ab7f01f3d@syzkaller.appspotmail.com

Yanjun, do you have some idea what this could be?

Thanks,
Jason
