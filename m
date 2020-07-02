Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C05212424
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2020 15:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbgGBNIV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Jul 2020 09:08:21 -0400
Received: from mail-eopbgr140085.outbound.protection.outlook.com ([40.107.14.85]:45318
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726289AbgGBNIU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 2 Jul 2020 09:08:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHJTSQySR02rpWIihnucPPdcy60NabUypK2T33YqKolGojQhlDGDMgydD2puH0LYXX9AyPelbMMJWqR8ir+e7unG79A6bJHZti5laQaH3rgWhyfVYO41SlfJRNaIB/YBGWs+0DOF/OCBLHKeUqPTQnXMzLa4m83Anivb4/p7GalF6Bh+8cfNJHvLXnq4+fzmlr+iGprua1JSrOH1XloW5IBjZlTBAULP/8rdf6ye/YvsDJ5WkDheqSSW9jxwHXmwWCvitxSCT42wdE3vyQMknwx9a+cxL/64KXP0vC+VltA0dS4mAmGyQ3wKeiFcA0qX6kUyLL9NHBndd1NBdHivRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMInviAA8cs4uNL2+Oy/Dp9w9d3NwX0J1zGCYu8nKoU=;
 b=AuM27LcMgcTU6fZ7QBJGQnQGuyB1kMnbWVW1a/HUNm9u9oMwZOHW7Jdp6n77d7kuAvxxVwP2Cvsgh6+sZFEbH8T5U+8nElWLo405/URZysPZtIum+4kHzxddSdpIc0DO4k//yYIBAzap08u0kM/zja+ybCpjwyGHVnKVWGiZ8OYe/ejTXi8Lta0zcZsEVDFdLXuyl9MRX9NPIHNbE/6NO0MV0FEiknhtiH1fHY+Di3YaUZOsVcMcXfRiOmUHH3LvhVZO1usvzJvjLhSVMYD1XJWwIAbfRm8ruKUnV3VCgYW2PIym7PMmYtFhjOZDDWsnvdBsxC5Mp2pPwe/0dPx7Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMInviAA8cs4uNL2+Oy/Dp9w9d3NwX0J1zGCYu8nKoU=;
 b=dqkOLlTBye7GpJQXrfMNaInk7CIbrdwdpwJfJxT3BUGFu+KoiyMwvyjeR6crGmJXHY+QlPAOf6htSdNNINjpiqhne3WVdg3T37JwgyYoW3b/XZZmQQQylgVyZYaxUH6jpYqedOz5x8s11I1+2zcJvOqFsEpaKBRB9UWWnlHwAQQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=mellanox.com;
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR0501MB2334.eurprd05.prod.outlook.com (2603:10a6:800:24::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Thu, 2 Jul
 2020 13:08:16 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e%7]) with mapi id 15.20.3153.027; Thu, 2 Jul 2020
 13:08:16 +0000
Date:   Thu, 2 Jul 2020 10:08:09 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>
Subject: Re: [PATCH rdma-next 0/6] Cleanup mlx5_ib main file
Message-ID: <20200702130809.GU23821@mellanox.com>
References: <20200702081809.423482-1-leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702081809.423482-1-leon@kernel.org>
X-ClientProxiedBy: BL0PR02CA0064.namprd02.prod.outlook.com
 (2603:10b6:207:3d::41) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (193.47.165.251) by BL0PR02CA0064.namprd02.prod.outlook.com (2603:10b6:207:3d::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23 via Frontend Transport; Thu, 2 Jul 2020 13:08:16 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@mellanox.com>)      id 1jqywj-002rl8-4p; Thu, 02 Jul 2020 10:08:09 -0300
X-Originating-IP: [193.47.165.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4da8e0e0-972f-4253-5a9d-08d81e88fbb5
X-MS-TrafficTypeDiagnostic: VI1PR0501MB2334:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0501MB2334089CDD6981B1813D4E63CF6D0@VI1PR0501MB2334.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Iq/IvOwWOU8zVSjr2r7dWBDOJPUk94RPyVpddFIhIHQDmFe0LeZFs2oT2rfb/AJYljmKfQ95CULOD2ZSqyBgkT7MomMPh2GhF5dAl3iiqiqyzXjekzl4PzPnVZwOMBe8hV+R66JmFm6EJdCJk8RAla6s5FT+ZRAf90FEGchhWBabUY7e2zxQMMQXOyUl+fTFDCsz0SurdV7ltEQUT14E9Hhub7ax7EibP/H6GaP1QCn1o1h+kn0WzPKn7/CnxRp719tWxfgulcVbuS2cn11RQmFwzLaNBcyo44+p9WUGYVgSazJViMZAuBMS2A9J7BYosQBoej6pUs42iR9QlN4Lpq6DumoINJSdU3VBb/2+qGA1Rq2/s4KZ26eWNcWNNGztEVL335Yt8rkApxFB9r9/vQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(39860400002)(376002)(396003)(136003)(6916009)(107886003)(8676002)(4326008)(426003)(2616005)(33656002)(54906003)(966005)(9746002)(9786002)(36756003)(8936002)(186003)(478600001)(26005)(66476007)(66556008)(5660300002)(316002)(4744005)(1076003)(2906002)(66946007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: W99Li2/HiKNDJRMe1yiIb27puQKxSfdzG3kIwOExR0gG+ccJ7GJ1lxp11PWxGoDkIj1htuwzE6RvIwVx0v2otHN/gjz450PrRJuiuvufOU93LY//qghx0lJbeVgKtase4q1lkHc5NU9YFk/2qASg55yEgUSA8vWflFZWcAWoJnWMk+6VIu7+D25176Zb7gcJoExWiHIRYziWqZp4Zu5a/jQso4o6oEZA8HUnJZf846rcFABpPBV9LxIR1AE4FqwFKN1mSltfXpYzGshiDTGw6fLWGxYr2bbnax3V/jcwi6GB8fTLXyquBNhpLyEE9WaR9OXwTWykjKtIMkEUra1PvxuDTZiR3zl63zmBm/1ILKbdxeupe/ODUpqskbUJ+IJFNsTxdN9TIIYeGbN5KL4rUxsZ8D/fSKquKYe2DJVspAEjqdcg5/GhFrH5feRI+uHMa/mQxo5VYCcddJvqtM7In4MEal21wJv5QagpBI7Af/FtT8tLnrzrbyhjAuLmRFvo
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4da8e0e0-972f-4253-5a9d-08d81e88fbb5
X-MS-Exchange-CrossTenant-AuthSource: VI1PR05MB4141.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 13:08:16.2146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7wA6zmfBaLbCc8vso6oPJ6ex6mjfwsG0eZnnM2GGcD4PXmzR6rAlc+AO0qQqA6eEeMAOiEyou4wmSqrs3d6kDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2334
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 02, 2020 at 11:18:03AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Over the years, the main.c file grew above all imagination and was >8K
> LOC of the code. This caused to a huge burden while I started to work on
> ib_flow allocation patches.
> 
> This series implements long standing "internal" wish to move flow logic
> from the main to separate file.
> 
> Based on
> https://lore.kernel.org/linux-rdma/20200630101855.368895-4-leon@kernel.org

Isn't this the series you said to drop? Can this be applied
independently?

Jason
