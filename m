Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0518F20376D
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2020 15:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbgFVNFa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jun 2020 09:05:30 -0400
Received: from mail-eopbgr80040.outbound.protection.outlook.com ([40.107.8.40]:13126
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728345AbgFVNF2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 22 Jun 2020 09:05:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iDoQuz9XtzmKVyExKMYM6bVVpp820eWlEcPiKSeDHAmoDYBJyf2SfyUGi8uK1DAoHW0X/lK8jdKJuaU6c4TXR/onP68WBRQBYUzPJUCeQJSodVcAfci/kZjijocuVMGGIAFnGa2TDrEFutST4DFwWtqbm24tH3VsIOHqCJ3Lq32zAasB1eq2OdJLqSKBoicJ21fIccn0s4xtB/uWptBzGGIsWoS+ByFeIzSg9sF9uoiIvWYTAUf887xkb4Wk//QNuZLeHN88F11iwU7vsAiGJnpAPhPg7ljrKaaMJgey4NI3G+/Kt9pPzZn0GrBJeoF/rzBptNaNJXse252JXi1otg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bZsNVA3jBUfmlhRU+BfcTB3UbBnqdW3eXLeWkb7p3LI=;
 b=f65pyDr8ud1jn+Xk2yayfpvBgJjhR8l3Yled1GqVNRlNR9LJUajOdTfO/GNDtF7uNzZsRvMrcDQVmj1qGt4pRAxuMV8qVYBvZOUR2MD5RGY3J0WDsLJZ7tYJb7HCOPuNvxS8L4MSI+/dd62kwKzVBKOxuVVcwNlRIPtVrlpYv+FTXXE5urPXGP+sjFKgMe73PaYzW2wv5tH7R8wyM58JE17nJVBDoEgPcPpZQyIn5oaPgRadjGaCgZ2hT2Ls2W1TDgTYPNf9iS8qHOplf99hoJpEBgrAR/rWl85KtqCN1PEWcUe4yI4oh05sbgMfwyIPm/Gyy/3xC4naXqv2FELDDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bZsNVA3jBUfmlhRU+BfcTB3UbBnqdW3eXLeWkb7p3LI=;
 b=VwOfiMnR6IGKvj/GYokNIDiAp4BRjpuN4E+vghS4CWaoPhx0RNjuiled6BlebWGqvRhJ3i7pI7ouL76O5A1CB4ArPMikHNPEFAc8j/YDOgbUGbVBPI2ueR7BlMXZPWOVzGn1l9/IX9vt0tB1CfHlkgeRJyCoRtkPJIM8gvPBkTk=
Authentication-Results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=mellanox.com;
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR05MB3486.eurprd05.prod.outlook.com (2603:10a6:802:1b::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Mon, 22 Jun
 2020 13:05:25 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e%7]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 13:05:25 +0000
Date:   Mon, 22 Jun 2020 10:05:20 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Maor Gottlieb <maorg@mellanox.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next 2/2] RDMA/core: Optimize XRC target lookup
Message-ID: <20200622130520.GE2590509@mellanox.com>
References: <20200621104110.53509-1-leon@kernel.org>
 <20200621104110.53509-3-leon@kernel.org>
 <20200622122910.GB2590509@mellanox.com>
 <3ee325e8-6872-22a8-4f2b-e1740d15a194@mellanox.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ee325e8-6872-22a8-4f2b-e1740d15a194@mellanox.com>
X-ClientProxiedBy: MN2PR22CA0007.namprd22.prod.outlook.com
 (2603:10b6:208:238::12) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR22CA0007.namprd22.prod.outlook.com (2603:10b6:208:238::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Mon, 22 Jun 2020 13:05:24 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@mellanox.com>)      id 1jnM8W-00BteR-LD; Mon, 22 Jun 2020 10:05:20 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 161f7f13-7aa6-4654-7bfc-08d816aced58
X-MS-TrafficTypeDiagnostic: VI1PR05MB3486:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR05MB3486D91BA0E1107C98174840CF970@VI1PR05MB3486.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sFIbzuDLsL0Bxa8TuAvWomqMgSKyW2HBzV2yPWNXI9lrScn7a1I3EzRoWOeOXH9Q3YolptTtyTQBmoU3sQ0QfNkdT1w9XEz+QMLk2AYy2uitd1EraCBszDarg04rowLCqcq+uAueBzbTd/YboHCBrjRwU6xHO0N5OFYtYj3bvyrf31qY+awei+IisxlL0ZF+2pldqgD0oQtfNcayF6YFDJK5Dr+IWM1X5Dnx3uFSvRzJZVwmy8td5CqoWVupkfqDOhDDem+39GMPOlcudSs7wJNrdR6KnD3ATK+FuK7/I0H/6T/+TM9+DdKG6zfMAutFeYp63RAit/nxRBo1dr8OJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(376002)(396003)(39860400002)(346002)(33656002)(6862004)(478600001)(1076003)(4326008)(37006003)(26005)(53546011)(186003)(316002)(8676002)(83380400001)(8936002)(54906003)(2906002)(2616005)(6636002)(86362001)(426003)(4744005)(36756003)(5660300002)(66946007)(66476007)(66556008)(9746002)(9786002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: P9npKMQajmBaM6kYIj8P0St25XNd8X+oYmVuXqbXSPTWpPeGNlZPImFS8vJc5j/cBukX2Ep0JhYksDiSQTf3Cxp/dJT/bpw/fly+kLuo5GO2nRpb7tM6vpXWndpv2QA6RVNT6gqgDq3g60obVSuFnDFT+/QQd8tdDYKqgboE/aPLMqdS8FsyZIWvMnSKiWcXua/rRRo/XQNedsBJErLlFH1LljGPq8OjyVgaW/bxs904UrUiHadZwNNHyvOCQqvK4gLFYVjH/vwTeSYDXoXcbhIGxrRX34aFWrH4Y2EclDpWACfwloMx/EXk6Z5+9hxFDeOlQuEKqp3zgog7fm1huHwPYpbmcFSem1cjt5mE9vCzBBOB09sEW/9zyDAA8XSZlteXs71jZBpZE57P95bEy4c1OcJo2NEYau4/2XcUdqbF43Egr/B8QtRcIHhAX/GaQGyXp3nWJiJALEhrvg3zFZif7Jmq20F+zTksTudckc8=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 161f7f13-7aa6-4654-7bfc-08d816aced58
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 13:05:25.1216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dEIhMpk3UKmkV6PoT5t9HpzJYwV3Vn+d95AWt9ecuzXH+7FEQxkE+m6PyQBYLdfIxby1JIlhT8DfYaFVMxlqDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3486
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 22, 2020 at 03:57:29PM +0300, Maor Gottlieb wrote:
> 
> On 6/22/2020 3:29 PM, Jason Gunthorpe wrote:
> > On Sun, Jun 21, 2020 at 01:41:10PM +0300, Leon Romanovsky wrote:
> > > @@ -2318,19 +2313,18 @@ EXPORT_SYMBOL(ib_alloc_xrcd_user);
> > >   int ib_dealloc_xrcd_user(struct ib_xrcd *xrcd, struct ib_udata *udata)
> > >   {
> > > +	unsigned long index;
> > >   	struct ib_qp *qp;
> > >   	int ret;
> > >   	if (atomic_read(&xrcd->usecnt))
> > >   		return -EBUSY;
> > > -	while (!list_empty(&xrcd->tgt_qp_list)) {
> > > -		qp = list_entry(xrcd->tgt_qp_list.next, struct ib_qp, xrcd_list);
> > > +	xa_for_each(&xrcd->tgt_qps, index, qp) {
> > >   		ret = ib_destroy_qp(qp);
> > >   		if (ret)
> > >   			return ret;
> > >   	}
> > Why doesn't this need to hold the tgt_qps_rwsem?
> > 
> > Jason
> 
> Actually, we don't need this part of code. if usecnt is zero so we don't
> have any tgt qp in the list. I guess it is leftovers of ib_release_qp which
> was already deleted.

Then have a WARN_ON that the xarray is empty

Jason
