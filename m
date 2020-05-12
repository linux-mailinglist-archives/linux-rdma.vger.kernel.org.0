Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBFF1D02DB
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2020 01:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgELXGe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 May 2020 19:06:34 -0400
Received: from mail-eopbgr80047.outbound.protection.outlook.com ([40.107.8.47]:19682
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727104AbgELXGd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 12 May 2020 19:06:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WKhiFhrt0BgOCPIN8tSVMaiYENNWE589fU2N8JfeJjnCmHVdXS6mvLvNZk7sDd82Tpa0PKxt+aN5Tag39WflHXujOMEaWTVCOfurNtsZTmY140I4WPQmMLEAV1L2dGvOIpLBkMkgY3VrhsPG2OaxcJUXbRwJE9t9g973XznNJE1uxY8zGcV/n6cCN6EI5o5vyZX5vXYNCgRUmeBYEyaqlHokdgrfhN5fqmnGOzit+VPTvZTT9diY7JLs1iH3F5tyW498AeFrO2sQrTRVQA0EFM2W27NrgihRPQw91XvuSebi9cU4c6nAs2La9d3LQZBC1Q3us1rGPsWFLryHi/KYUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fpH7qOvpxVkzmNeNxkg6bMIfHmb3BWODN+k2GHO+/8E=;
 b=i2g6RhC4fjAXLb0/m9T6stB7VZKQlQhB7mbxPYXhjRksS6yb2r3mRshH7GhbQu1LUQ4xXjCwIJpYY28zIpjROm18XDU7W7+BDdM1zXjYrspiKPzVZOltgIBfNuQ/HjKxBv5xmsIthhRwi7bfB7t4Nqb74wzlKZfUb1Z+2vk3u5hzYKrLZtapA3QBudxLqmVsTN7eSoiNVz58lt+InX/LR3pezQcDJLpF8P+3x7TwIRzZB0gDU4dGaDGWlc2CiY1ceG2CBTVn6LIHwJVH4psd2DemlSp5+gaBKtt5vuG5HVZA3n/2MtmSNfGNc+fOrZJuulkmKgkCHB3AKEsCMNv4CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fpH7qOvpxVkzmNeNxkg6bMIfHmb3BWODN+k2GHO+/8E=;
 b=jUOEGbxhhDzILJdCc0AZ5fARMAIx2MeU599hO3XKeXc1ynx1fqJF0cSd9jswPTU2rxWIPw2HG7385/d0SNP6/HdVaHC35Fhny7VkHU3yTkB7q64MOPm2hp/3gHMzHrXkDQs2BtyzkLElgof1+LiNveYLo78c38xodCppdVWbQoA=
Authentication-Results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=mellanox.com;
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR05MB5023.eurprd05.prod.outlook.com (2603:10a6:803:59::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Tue, 12 May
 2020 23:06:29 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::a47b:e3cd:7d6d:5d4e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::a47b:e3cd:7d6d:5d4e%6]) with mapi id 15.20.2979.033; Tue, 12 May 2020
 23:06:29 +0000
Date:   Tue, 12 May 2020 20:06:25 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Israel Rukshin <israelr@mellanox.com>, sagi@grimberg.me,
        linux-rdma@vger.kernel.org, dledford@redhat.com, maxg@mellanox.com,
        sergeygo@mellanox.com, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH] IB/iser: Remove support for FMR memory registration
Message-ID: <20200512230625.GB19158@mellanox.com>
References: <1589299739-16570-1-git-send-email-israelr@mellanox.com>
 <20200512171633.GO4814@unreal>
 <5b8b0b51-83e3-06c2-9b99-dec0862c0e5b@acm.org>
 <20200512201303.GA19158@mellanox.com>
 <98a0d1aa-6364-a2f1-37f6-9c69e1efaa0b@acm.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98a0d1aa-6364-a2f1-37f6-9c69e1efaa0b@acm.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: BL0PR02CA0069.namprd02.prod.outlook.com
 (2603:10b6:207:3d::46) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.68.57.212) by BL0PR02CA0069.namprd02.prod.outlook.com (2603:10b6:207:3d::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28 via Frontend Transport; Tue, 12 May 2020 23:06:28 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1jYdyj-0007kX-M9; Tue, 12 May 2020 20:06:25 -0300
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7992b945-4ce4-4259-0fdc-08d7f6c91a66
X-MS-TrafficTypeDiagnostic: VI1PR05MB5023:|VI1PR05MB5023:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR05MB5023C28F9DFD49FBDD77D832CFBE0@VI1PR05MB5023.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oqB3+tC1f4PMr00uHfw9KqvlBuCbnqEkTNamERDjJ1yNBZbhEDHtZvXHC4bZYsYZkBc/Q44IGtfmQ1ydv+fl1Kd2FVj/H6npEVLvXXK5KKFHo307t4cGZcVZOQGE5RxfLcITtYxBOGCYh8bzpEs6OYvltOv5lZyDbWtqQpXO3t2wLy8ST6VjccGt8wqeFtuVCo3k3xzhoBLaBlNjvkAdD3oH44+wvYjDHy96PpT/YxGTv92fg1rMISzNlqNI4b0B5Apw/5XNuvJpv89Mr7DGh3U9nFMOlNeVrc3kf8Boq3U90jhEam7HEUDeyTU6WQoZ8zdycYxIgl2tMh/FZwgZjW7kRf9z2wUaCbvV9Ti+9g/WkCn7PSePkY37UJX4U2gpI7hp/jiI1+Y7O2JBsEwKUXe+I2tpEYF6JIOy6rrPmfUGGjbkxhGPbAmU1/HmlytZuzBz36CSA/VFIhGj/f8PaNDsl68uDTghk1a2y4+5K0v5M57nbkWBHgyktowTqGvJ+MlbMOw9M5BNKWSTJb2ST7lCC5TxX3+l3DH3vxo6MoQufP6a6qiUGPQtGuKcnQZV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(366004)(39860400002)(136003)(396003)(33430700001)(66946007)(66476007)(52116002)(5660300002)(53546011)(26005)(66556008)(8676002)(186003)(33440700001)(8936002)(9786002)(86362001)(66574014)(9746002)(6916009)(478600001)(36756003)(2616005)(2906002)(33656002)(1076003)(4326008)(54906003)(316002)(24400500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ZC81pYt2y7mP5lpXILYh495vGHIfNQZyk6KhNu25ZJDsFlrKDXpPx7w20vO/FtMF8gwKTBnjY3jofGxDdiDmXenbdXY/QnzLhgDMlXO9QqUXxFIyYgrmjkXWeqRYS5GHMUEUu4PsMdTnH6kdyU2VnoxqwYEQz4NZlnhW4ABYF2NHe51CEcnrkIR8ZL73BiIz75+Z1L+ZGml1I3FwFwsY9tMjjOdUIsce9Pfv21k1mgq/AZURNZ9s4EmDvhmFNRp+4BsyOpz+FTx1PESqM51aCBxtpr/l332FVDheEnHbqONoPBrRGi/ADAsVnLucszyInC5sMwnFrrGY/Pcx4rbbYs465ROok9nsRld2yJUNVXCDiWO+bQPQ86v+UM1WzIgvG+8/6DqSrfiAMT8hff0JAFY8ib9GIoiX335PzDg/VsudsJ6iphIBQkj1Wz6CdLHIl0O91zbz1B+/1FEOrh+KvPfS+tWB3FOXIhT8x70VFbMP5Io/fKGOINlciGmaA9Ea
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7992b945-4ce4-4259-0fdc-08d7f6c91a66
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 23:06:29.0968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qdV4Y7QaweDZSRaMwEgfffH36qhu2MuCise1/HhhiGqpZssgOkqrouXKrKnhzJ3tUxK+m2GpU/tVuZWS9rnXAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5023
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 12, 2020 at 01:27:18PM -0700, Bart Van Assche wrote:
> On 2020-05-12 13:13, Jason Gunthorpe wrote:
> > On Tue, May 12, 2020 at 01:09:02PM -0700, Bart Van Assche wrote:
> >> On 2020-05-12 10:16, Leon Romanovsky wrote:
> >>> On Tue, May 12, 2020 at 07:08:59PM +0300, Israel Rukshin wrote:
> >>>> FMR is not supported on most recent RDMA devices (that use fast memory
> >>>> registration mechanism). Also, FMR was recently removed from NFS/RDMA
> >>>> ULP.
> >>>>
> >>>> Signed-off-by: Israel Rukshin <israelr@mellanox.com>
> >>>> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> >>>>  drivers/infiniband/ulp/iser/iscsi_iser.h     |  79 +----------
> >>>>  drivers/infiniband/ulp/iser/iser_initiator.c |  19 ++-
> >>>>  drivers/infiniband/ulp/iser/iser_memory.c    | 188 ++-------------------------
> >>>>  drivers/infiniband/ulp/iser/iser_verbs.c     | 126 +++---------------
> >>>>  4 files changed, 40 insertions(+), 372 deletions(-)
> >>>
> >>> Can we do an extra step and remove FMR from srp too?
> >>
> >> Which HCA's will be affected by removing FMR support? Or in other words,
> >> when did (Mellanox) HCA's start supporting fast memory registration? I'm
> >> asking this because there is a tradition in the Linux kernel not to
> >> remove support for old hardware unless it is pretty sure that nobody is
> >> using that hardware anymore.
> > 
> > We haven't entirely been following that in RDMA.. More like when
> > people can't test any more it can go.
> > 
> > For FMR the support was dropped in newer HW so AFAIK, nobody tests
> > this and it just stands in the way of making FRWR work properly.
> > 
> > Do the ULPs stop working or do they just run slower with some regular
> > MR flow?
> 
> I'm not sure. I do not have access to RDMA adapters that do not support
> FRWR.
> 
> A possible test is to check on websites for used products whether old
> RDMA adapters are still available. Is the InfiniHost adapter one of the
> adapters that supports FMR? It seems like that adapter is still easy to
> find.

I don't know - AFAIK nobody does any testing on those cards any
more, and doesn't test the ULPs either.

I know Leon has pushed to remove the mthca driver in the past.  At one
point there was a suggestion that drivers that do not support FRWR
should be dropped, but I don't remember if mthca is the last one or
not.

There has been a big push to purge useless old stuff, look at the
entire arch removals for instance. The large RDMA drivers fall under
the same logic, IMHO.

Jason
