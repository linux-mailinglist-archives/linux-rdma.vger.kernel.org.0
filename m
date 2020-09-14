Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B90C72690B0
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Sep 2020 17:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbgINPyQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Sep 2020 11:54:16 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:16079 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbgINPvI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Sep 2020 11:51:08 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f5f90d30001>; Mon, 14 Sep 2020 08:48:35 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 14 Sep 2020 08:50:56 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 14 Sep 2020 08:50:56 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 14 Sep
 2020 15:50:55 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.51) by
 HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 14 Sep 2020 15:50:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q5s2Q7EviBVkZeXio5CtePkiBUIUukFoB7LVCeCUw2pSNBaz7gASohvL+WMoJIsOaNfbhRlegjamZxSTdTcBfZlv7fctkFw2g/1MP4dbbJpcJwsGFra0PX2Tpqy7LxwCDjfS1iVDkHJikPDFdpsI2sX15HpuLYHj8xpS+JfSVsfoS4YPxa2+zhQLfdtsNFv6W8J5rL7Z6ZvKiwTzLUI6duDVA/Dyt6JricleNy4BtSQTlgvHSMxP0rrwk4ScSEzAEXgLuPfZfGnBkTJvrPYkTzkRr44SyAV5B4jzhuwyE9nz9gRErG+vP6pfKaHIuEjQcRPHR37izMP1MqTtIqB5KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8cS3t6kj/f5e9ta0s+SIetsctK6tG+E1fg6dZnheb4=;
 b=mWgUuXcJOp0JOQqkU9Qbxi0ca/Sk082QBlhTfjoOqUK3fh2tbaAK8jnqIxm79gKIggRYXXmmr+hHpVxey1HbnYng5h2rnw4y4oIpFJBlOPBqUGNXwRlRLw6Nnyp7X8WhFYg975S96bqymUWyghhZy6QCg2KoR8jZ4OsHmekKJQt4+zrsVr/yCW+thY3rk+MPNm8xsK5+LJ8T8Y0ks5BsszUsMK0rSpySRO5mve8Ct2E5RZckuX/3xDWy7Fz05yAtp+aJPpKIvDMBYK1qvkNQ4/mQpzn0F00m1SWKMIAua7j6sjDfnLXzhpROa6QzlWLZ/hzy7rJI2Jcko12nNGQgLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3114.namprd12.prod.outlook.com (2603:10b6:5:11e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Mon, 14 Sep
 2020 15:50:52 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 15:50:52 +0000
Date:   Mon, 14 Sep 2020 12:50:50 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Avihai Horon <avihaih@nvidia.com>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next 3/4] RDMA/core: Introduce new GID table query
 API
Message-ID: <20200914155050.GE904879@nvidia.com>
References: <20200910142204.1309061-1-leon@kernel.org>
 <20200910142204.1309061-4-leon@kernel.org>
 <20200911195221.GS904879@nvidia.com> <20200913080233.GE35718@unreal>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200913080233.GE35718@unreal>
X-ClientProxiedBy: YQBPR01CA0020.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::28)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YQBPR01CA0020.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Mon, 14 Sep 2020 15:50:52 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kHqkk-0069iJ-Mr; Mon, 14 Sep 2020 12:50:50 -0300
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dbecac89-de60-4a24-dc34-08d858c5f566
X-MS-TrafficTypeDiagnostic: DM6PR12MB3114:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3114ECDA512C071BB8FF1DD8C2230@DM6PR12MB3114.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x7zwDkFqMF/mdI66oWGS1/IKGUq5FkbK3l7cRfChcOId/K/+nJ5srpHSBHQqE4zQyU8tyQ4EbuJIrXjo5be6/KzSFXB1jwb+YmW5Z2IcSws5w3jJtuMVn93tSL7IQxbdabclXrCshai+50ttlTSHPY2Y3VR/AhGziXDDfSxzLa2bqr5sLY09LlfbXiV7xg94YMbXelA+36073pBNZRdTpB5aWLrtHfOFJunA/yIeTcaU2OpEaNU7/DWWb0Y4/Gl3pBWM4qDwbBUVPBJRs8fn2WJPCpIzSaIO7UwSMEI6mmxrNHYr3eFmXIUL8SjPSpvMqDE7I25KFfDo8pmVh+HvAA9s04ZTFA0XSyQek1uZTPwS+Gdws5X9CL1JGxxWPxok
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(5660300002)(186003)(86362001)(54906003)(478600001)(4326008)(9786002)(9746002)(66476007)(66556008)(1076003)(2906002)(426003)(2616005)(66946007)(316002)(26005)(33656002)(83380400001)(36756003)(6916009)(8676002)(8936002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: GH/eELjn6i27dLJBF7oJTEGArKDPVgimN6ozWoxxemVUjep2GhitSKPq0M9V1zZNVj0y6Wnk7w4VZeBM3TCnwj7ThzZT2Yf3GVZC3C2Kseu6txaJsQJzxXqSNwHyVn0itLf8+89QciiaUwDEuy/YXcJ0FruMrJsA5BXTB06dP4+Bnpu/YSOwMg9EvFtJLewR9LVtGd7nWsk/d/KLhUDB3+HVm4k9itHx1R8oz9FuYp3D+bFTIT3XzITt8ZDsqppVmb7lmy3GyvDFArPsgKuAfIq8Dbg32u+L3Ybuun3SNrcp9BvoEB1jvsevtr6SfmeKRPK3b19kHjAb4Xz2FivfYZf/JGmppp4VJKP6fsYw9zvEIJI0sD0kygfz+DyRPI0QYwY0HfWQVl+Ie0FmbbrYSdVLcXrTxXhh8nsbC01XTBBVBmgFseFw+JhjX2cLpIzksAp80M8YSaHa9HCxxC1fhDXU3R56N4asK+ECBd1ihLzG4pmwXoGgLjC7O6Ksrt8ipvO9wpyjMLkDvP60uLP71BW0wmuDkDmkCYMyCrOmr9VFzcBTJDJ3EADqaxXG888Qfuzxvxi6laL4ZDtnJcuE1013Y3RNSnVj/xAJTE2oOMLS8gyIyMOejsPIAkg3QzLj5DbtLssiEyyJYYxCji4cuQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: dbecac89-de60-4a24-dc34-08d858c5f566
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2020 15:50:52.4694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6yv91ZgXTr1TLawRVIiNFtuRI7e3dshSa2lpVrRbS/KmqhueHHp+x0BFUw3ZKfb5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3114
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600098516; bh=X8cS3t6kj/f5e9ta0s+SIetsctK6tG+E1fg6dZnheb4=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-MS-Exchange-Transport-Forked:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=jf8zhHzbbKl8qflyHTX3ts2P65OQu6C/ovfCjd1SsK2xAMy8t7Y802jqBMiswberu
         +njClKlmk6o2P0CkmOV0cYhHDuh1t3tbcAPc8WDWQSO+6JtkXdlZNtsXYiqIxJpXGd
         5aeGSyEBIKTpPpZLPKUvWaOsyILpfc8pYVFA20ozTS8oCxHVD0ThfXArhn7SFBLv9q
         9F1tYR3cRKbdF+xmyF0RCNl714i1+ZLcECbzZ26sUz1IDuEusoEa6zkMcd4k9CHPi7
         S1B9ypNs2yZs+DoMNjo+l72J6rgoiVlCd6Mrl46XG8Qs5Ta8jTeQ68QP1g8OrTTzlM
         UPInHK3TIh3bg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Sep 13, 2020 at 11:02:33AM +0300, Leon Romanovsky wrote:
> On Fri, Sep 11, 2020 at 04:52:21PM -0300, Jason Gunthorpe wrote:
> > On Thu, Sep 10, 2020 at 05:22:03PM +0300, Leon Romanovsky wrote:
> > > From: Avihai Horon <avihaih@nvidia.com>
> > >
> > > Introduce rdma_query_gid_table which enables querying all the GID tables
> > > of a given device and copying the attributes of all valid GID entries to
> > > a provided buffer.
> > >
> > > This API provides a faster way to query a GID table using single call and
> > > will be used in libibverbs to improve current approach that requires
> > > multiple calls to open, close and read multiple sysfs files for a single
> > > GID table entry.
> > >
> > > Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > >  drivers/infiniband/core/cache.c         | 93 +++++++++++++++++++++++++
> > >  include/rdma/ib_cache.h                 |  5 ++
> > >  include/uapi/rdma/ib_user_ioctl_verbs.h |  8 +++
> > >  3 files changed, 106 insertions(+)
> > >
> > > diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
> > > index cf49ac0b0aa6..175e229eccd3 100644
> > > +++ b/drivers/infiniband/core/cache.c
> > > @@ -1247,6 +1247,99 @@ rdma_get_gid_attr(struct ib_device *device, u8 port_num, int index)
> > >  }
> > >  EXPORT_SYMBOL(rdma_get_gid_attr);
> > >
> > > +/**
> > > + * rdma_get_ndev_ifindex - Reads ndev ifindex of the given gid attr.
> > > + * @gid_attr: Pointer to the GID attribute.
> > > + * @ndev_ifindex: Pointer through which the ndev ifindex is returned.
> > > + *
> > > + * Returns 0 on success or appropriate error code. The netdevice must be in UP
> > > + * state.
> > > + */
> > > +int rdma_get_ndev_ifindex(const struct ib_gid_attr *gid_attr, u32 *ndev_ifindex)
> > > +{
> > > +	struct net_device *ndev;
> > > +	int ret = 0;
> > > +
> > > +	if (rdma_protocol_ib(gid_attr->device, gid_attr->port_num)) {
> > > +		*ndev_ifindex = 0;
> > > +		return 0;
> > > +	}
> > > +
> > > +	rcu_read_lock();
> > > +	ndev = rcu_dereference(gid_attr->ndev);
> > > +	if (!ndev || (READ_ONCE(ndev->flags) & IFF_UP) == 0) {
> > > +		ret = -ENODEV;
> > > +		goto out;
> > > +	}
> >
> > None of this is necessary to read the ifindex, especially since the
> > read_lock is being held.
> 
> I see same rcu_read_lock->rcu_dereference->rcu_read_unlock pattern in
> rdma_read_gid_l2_fields(), why this function is different?

It doesn't hold the read_lock so it is using rcu to access
attr->ndev. With the read_lock held attr->ndev is stable and none of
this is needed.

Jason
