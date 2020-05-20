Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14C401DBDC5
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2020 21:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgETTU5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 May 2020 15:20:57 -0400
Received: from mail-am6eur05on2077.outbound.protection.outlook.com ([40.107.22.77]:21536
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726560AbgETTU5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 20 May 2020 15:20:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jNSDtEy+lwS4BNMNJXsQp2nc6tPyCV1X2C6Rno3KSi01O8KLd575mwbUOn8htMaSWl0Pe3RBAgGyPv6+O0BP2btGcSlgXDBTJLB2tUaWZQakvIgIzEDGHboZLIh7SGiYlNS/qYHuphe5jfouTm9yrqVaCHOwVU/S0I6oWMIp4ACY9MXDIZUglvCHfEuHS/4u1ym1v+gB+JC80GINNwl75GK2Ri6HkGyP3U3ghssXPeGesFdq8dH1NknzB2mrvwdwGV+zi0JF+dSHb1sing8amRsl40ls+tUawxc89+o6UAaeGdr22Xfe3hHPztXoDX3yDguw9XFuRH7SFo42x78P9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DpHga1b9hlnqaD9DdxXUavNSazqvvE8Js34+GDqtxoU=;
 b=lpUupBj3+IIyaXoHGz2Jqfy3KfoX2+ou4C4oRwrMaOg1f38C6hfNgynWWXthBQ2b0jkrXWqcPQYkOrapN29QN8auN5gYJaASZqeBySD5juagcIqoMEmuAz9xBsKGP0F3EpfoJMYT5S7r3CaGqaLbIOabLH1XWDuN94y7SnynQiZsW8weBOgqTE8pAXoyqfHkwmKm6PNhjD1wNkCJ8iwZm2dCOpgWXHaqs+j/kT4ptIiyG3i/1GkCDmuBYYrCVggA1mMn7bo0Wdwj78W3qdftvtKbXpprnmSum8/+Xmocipwd8jrukdYEGmaRKQiQygJcGX65EAekqZMmbfUwURq9Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DpHga1b9hlnqaD9DdxXUavNSazqvvE8Js34+GDqtxoU=;
 b=dn7zeTdtjLGf619P56Lo01Dq4h0+M/SHLEmx0BIWfjrmwt/P71ppYOkS1Z88QRC9EV9a68D6+3HQCvZlo2aI7aFxqfvcP12Ye5lnaNK3cre0P1EjKuBYSJnimt10QuyJ0hfXppGwFezhoROZZoz0TA3IGLTS26LCfSQpcz6osLo=
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=mellanox.com;
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR05MB7149.eurprd05.prod.outlook.com (2603:10a6:800:18a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Wed, 20 May
 2020 19:20:52 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e%7]) with mapi id 15.20.3000.034; Wed, 20 May 2020
 19:20:52 +0000
Date:   Wed, 20 May 2020 16:20:45 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     nouveau@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>, Ben Skeggs <bskeggs@redhat.com>
Subject: Re: [PATCH] nouveau/hmm: fix migrate zero page to GPU
Message-ID: <20200520192045.GH24561@mellanox.com>
References: <20200520183652.21633-1-rcampbell@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520183652.21633-1-rcampbell@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MN2PR15CA0063.namprd15.prod.outlook.com
 (2603:10b6:208:237::32) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (193.47.165.251) by MN2PR15CA0063.namprd15.prod.outlook.com (2603:10b6:208:237::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend Transport; Wed, 20 May 2020 19:20:52 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1jbUGj-0002WS-9P; Wed, 20 May 2020 16:20:45 -0300
X-Originating-IP: [193.47.165.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c6bf6bce-6380-475d-2153-08d7fcf2e927
X-MS-TrafficTypeDiagnostic: VI1PR05MB7149:
X-Microsoft-Antispam-PRVS: <VI1PR05MB7149C0DCDB79701BBAB0F37FCFB60@VI1PR05MB7149.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 04097B7F7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jsLVu38Mawskz1eDLCTC4CXWBBl3mwLHVUb4gGZIeWFzYFCyvB85PTJJ5bs7MToDm8GMnRfvYu49S1VXSc44DOj3S7wuY8Wa138NdBBcQTsSsqoe7YpO5q/QKkrf58Cig9ftxQ89FCNgeZ8PYbvQWckcHuFFj6lCNw1mH0DB13K+8cSXdPxotqSntpdFLaSBjAmvJmwjzRdCY7LODMGvHIj3QAhLMp1y2HZbEBwBpoe6r6M/e9PgToZNcv0oAKHwIBjhmUZtRPIgQOTvDfOorZQXoOK9tBtvQZsj9Hi64eN8Amk7CBTtAdbiQv778kiwKgE8PEnuaDBXc4oE6nxuz0vssaiGDTUbDGFnPGDRS4pNQiBN5xQNftajVuZRS9WrKgRwAHNwXTgJTZ5H1Qe1tYpnSLzG1VR6752aKtv7gqrFvJGXPjUN6ueppVlGzat5PcBjADYWxDryxtSjym9MxTsxtW5QXh51b2cdiuCG6RX98zzqRpfy8kKhsTVUWMc+RGhBhibpkoIZNO0+9tiRTKwpZNkFc4V/3lUzfufXi/+LWyovhvpzD7cf3X5w5Z0VfZtJEhLTD4xcQOrOQjNbqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(396003)(366004)(39860400002)(136003)(8936002)(5660300002)(186003)(8676002)(9746002)(2906002)(9786002)(2616005)(66946007)(66476007)(66556008)(6916009)(86362001)(478600001)(966005)(52116002)(316002)(54906003)(4326008)(33656002)(1076003)(26005)(36756003)(24400500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: CJgYeE4MCcSUXPQaI6vSlUHHUc7I050YaHiXbbJSLftohbcWvPObBmII6tlqvy6jMEJZIhSnIw0rscpMYbnQeo0fOMH+4GCHjrTmWSOIeNAngg4wcCBfwaUnV7ACQKXzSC38M+sBtwJFoHXrhfCQEDyLU50bqNMVWj/lYLSoS3VVXaMq+6f8BSzpi5ntUTy3oCbS/CJnhQT2p6zdOtBnf69UdjfRUK0Oe933wIbkgcAqkPwa0q+Jcg2PR1zABYYDpxlk3H4aREilhOnqf83kKj7OcW8KtGImokNhFEzP19ebBIXU1TgoEjofji3dki1NfZoDv+HwAcjCVzF07Bgxcok9CAbqaQKoidyQPF+Zj+sQKEFVZ0BxCyij+jB4zZDaUe44H0S1PzDaHAPyShKDgJZ+KW7hc2xCTOUnMAK3mpUqxtd5/0cHrFVtmu5bwAhT8QHZ/QvwaFV9RH1agF3gmaXRih71DiE2/AzfaEGHLR+/U4+G/4zBOFYVtDw6NAvY
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6bf6bce-6380-475d-2153-08d7fcf2e927
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2020 19:20:52.4243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FMCDGT9dbnds2JBarraEuGLr6+ndcY1FCJyDXzfsT5N11XVCFbRRKeyrGKY4g0dBPnlUG4eDNwVRw4h3h8GloA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB7149
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 20, 2020 at 11:36:52AM -0700, Ralph Campbell wrote:
> When calling OpenCL clEnqueueSVMMigrateMem() on a region of memory that
> is backed by pte_none() or zero pages, migrate_vma_setup() will fill the
> source PFN array with an entry indicating the source page is zero.
> Use this to optimize migration to device private memory by allocating
> GPU memory and zero filling it instead of failing to migrate the page.
> 
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> 
> This patch applies cleanly to Jason's Gunthorpe's hmm tree plus two
> patches I posted earlier. The first is queued in Ben Skegg's nouveau
> tree and the second is still pending review/not queued.
> [1] ("nouveau/hmm: map pages after migration")
> https://lore.kernel.org/linux-mm/20200304001339.8248-5-rcampbell@nvidia.com/
> [2] ("nouveau/hmm: fix nouveau_dmem_chunk allocations")
> https://lore.kernel.org/lkml/20200421231107.30958-1-rcampbell@nvidia.com/

It would be best if it goes through Ben's tree if it doesn't have
conflicts with the hunks I have in the hmm tree.. Is it the case?

Jason
