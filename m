Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 933051D8597
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2020 20:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730724AbgERSTr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 May 2020 14:19:47 -0400
Received: from mail-eopbgr20060.outbound.protection.outlook.com ([40.107.2.60]:21894
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730192AbgERRxx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 18 May 2020 13:53:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LLQzL0GmpD7H2Jaq1uu7csEfWdtCqDIPzFgk1+jxu9bd/o8563+kNmlwHxY+QluB9Ww5w/z62xwm05W7n0Qg6K7cmgqUYRy7oZNZrbWPj8IjQ9r90qnbZ/0KLAdrt+h/sx7ziYW13ISvjkxwS9iHVMhp3JIx4+P0ugoiviCej2XgmqKcEdlTOpc9pxRVNDyFy1WcYyJ5o82JsCzAtIYTCFD50zLp+Zd4TH4ysfnT9GSBPMU63X/TG4YshQO+0qTe9RtL9wl9e7GyUiKJJuWyNVaZ6JQCOm0bP9ps4ttWXDtoXpVkW8njaF/iOTL8DcTKBOHkQwCbQUE8eX/0x1pg0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=baeltpstGcEOxXCIFPIFLG+d5di6lCN2vOGMgHSM0go=;
 b=KXuSRvTY308JSxUWXiVV/g9wVkF/dBkfc7mugPIDbGM6P9kKchOvNd+upHsUfo5CioY8WA4TzlB2EQuKH/paYVu3cbKMuzfj8i4ZnFMUiTBSevv6W+ZA2CXWt1HGvRO3mHxzFE6MUkT6cI03lR1HLXwzEb4Ea6puWJrgXDcNFOhkxIHZviitgxfk1IJLE5G4BencHvyPFr8V2+av2Rik7HUkoCNwtcf8xTncsZpOaMwD3xV3Xvyn+Evw0wFScDA1drfv34QFXudrehFyP0ZfMLgPgUbmlK8X/PCOIHZmamh4EgfrbTXbfbxevE0qHlo0qhRpMinjvTvnRhRhkJa8+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=baeltpstGcEOxXCIFPIFLG+d5di6lCN2vOGMgHSM0go=;
 b=ZyuvUMBLdTjoO0HsxCGO9icFIXI0zu8C8nQxkpEJQ7VCnWESDE+hYf10BuhWi74aUBYL0Xzt3SelAgFswD4xDigplSOIzedJ2IhXJa6OvAi5cPt7ObLnfToIkOxEl+YiwU4R5Z0KSNQLUOIOPWF0Cf8llGRXWS1+Dj68bH5V50Q=
Authentication-Results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=mellanox.com;
Received: from DBBPR05MB6409.eurprd05.prod.outlook.com (2603:10a6:10:cd::18)
 by DBBPR05MB6283.eurprd05.prod.outlook.com (2603:10a6:10:cf::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Mon, 18 May
 2020 17:53:48 +0000
Received: from DBBPR05MB6409.eurprd05.prod.outlook.com
 ([fe80::187b:a21e:e583:7418]) by DBBPR05MB6409.eurprd05.prod.outlook.com
 ([fe80::187b:a21e:e583:7418%6]) with mapi id 15.20.3000.033; Mon, 18 May 2020
 17:53:48 +0000
Date:   Mon, 18 May 2020 20:53:45 +0300
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Yamin Friedman <yaminf@mellanox.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>,
        Or Gerlitz <ogerlitz@mellanox.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH V2 1/4] RDMA/core: Add protection for shared CQs used by
 ULPs
Message-ID: <20200518175345.GC188135@unreal>
References: <1589370763-81205-1-git-send-email-yaminf@mellanox.com>
 <1589370763-81205-2-git-send-email-yaminf@mellanox.com>
 <20200518075416.GA185893@unreal>
 <d8e19d4c-897c-25af-5d67-399238cda781@mellanox.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8e19d4c-897c-25af-5d67-399238cda781@mellanox.com>
X-ClientProxiedBy: PR0P264CA0245.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::17)
 To DBBPR05MB6409.eurprd05.prod.outlook.com (2603:10a6:10:cd::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2a00:a040:183:2d::a43) by PR0P264CA0245.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend Transport; Mon, 18 May 2020 17:53:48 +0000
X-Originating-IP: [2a00:a040:183:2d::a43]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5c572a83-d7c8-4da7-2c3d-08d7fb546ac7
X-MS-TrafficTypeDiagnostic: DBBPR05MB6283:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR05MB62835CA4285F10238CB71B98B0B80@DBBPR05MB6283.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 04073E895A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ifjOa4xK6bLSjZWqC32g9Z1Egl1s67unRQmAed28CU3tFbSUQujTvOXRe3NUtu16Q1+ZsOiGOg/g1ohrTuQ5GZj2aARto6uvXVHOb7yi9ZY7kdCDiF55yR4R5v8HqZnSreL4NVCjNc92MIiwZTXBPWdb4abX2rVvIdfMEv0PcULdPli1M43CAL9vMpw3cRiBqV9WQuKH1KK/W2ikMkDgmMce+lEl+YQHST2IFEUcyYaCr7kFSCqL+WqoXvN3aZC6rlr9gaxM8StWuaxwLeEAACYVeb3ptAvbif7PYx64u8w/sChI17Gn4XEr9cy+bnJwDXwJagFVFIlQvQ43kj3svXRrlY9NRWWL5hel5pfLIeO8aHP99aqDzBlpWe5zFhuOR7j3dW2A1EjELyjh+SV/9wxiXuixM3ONYSx06/fkLbdzPI1XY/TgvLtHMseihapn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR05MB6409.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(7916004)(136003)(39860400002)(366004)(396003)(376002)(346002)(33716001)(86362001)(316002)(6666004)(66946007)(66476007)(66556008)(52116002)(6496006)(53546011)(186003)(9686003)(33656002)(478600001)(8676002)(54906003)(16526019)(4326008)(5660300002)(8936002)(6862004)(2906002)(6636002)(1076003)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: OI0NyMQMYxo8yZeUkslAQR5V1fk/jlrCa9FvlA5R9jtOCkecB7fKuw/3JsRdE8c4eIb46etOnzc4C5hrayNMuLeMsrNSY7hJcKB2TDxaD9as01WKA8LmC9AGwl8t1V6V4JP97F6CKcmPZjd79f+/GG97jrwJxwfT9ZhfTME70z88v01BULDUx1CN1k0z2uEFh04yiUe5w/nhzzm3ybGrTFQWp70UHuZ2Mqr4QYprGa6c8reuTAUAAZOUmXYW/hgYV90BgDJvmsRO0J+0uVVYGneY6/Q+1eb+XXVPBNO6qZdewpbHAS2gN8JhPV1TUdXlZbI3Lnm8zNzmI1saQny82QqZAP7KSJLBKa2bVD989azliSvkYG0EtDRh5PV/xky90taUfRt8gcd4Z3SQ1iqGQMuPnAzPbz4WnyxJ5S48Bgr6WRV8rnN53fx9BvOjXcH1UXBnxSqDwI9TWvlBBz9ZWu8+QJ6ExIk6TTNtgF7wEqTaoZ4yhCwamaFvLNACROl6wGYH9Y7Y6aUGX3eTppwWNQ==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c572a83-d7c8-4da7-2c3d-08d7fb546ac7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2020 17:53:48.5555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R8dwkFuqaMYcvC4xV5Gf/Xa5SeDp2Glp6efIXThQxwhyni7cGdV71AS/RmegQkfwW9Nas7OZn4FkYaVQnQaR4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR05MB6283
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 18, 2020 at 03:58:19PM +0300, Yamin Friedman wrote:
>
> On 5/18/2020 10:54 AM, Leon Romanovsky wrote:
> > On Wed, May 13, 2020 at 02:52:40PM +0300, Yamin Friedman wrote:
> > > A pre-step for adding shared CQs. Add the infrastructure to prevent
> > > shared CQ users from altering the CQ configurations. For now all cqs are
> > > marked as private (non-shared). The core driver should use the new force
> > > functions to perform resize/destroy/moderation changes that are not
> > > allowed for users of shared CQs.
> > >
> > > Signed-off-by: Yamin Friedman <yaminf@mellanox.com>
> > > Reviewed-by: Or Gerlitz <ogerlitz@mellanox.com>
> > > Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
> > > ---
> > >   drivers/infiniband/core/cq.c    | 18 ++++++++++++------
> > >   drivers/infiniband/core/verbs.c |  9 +++++++++
> > >   include/rdma/ib_verbs.h         |  8 ++++++++
> > >   3 files changed, 29 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
> > > index 4f25b24..04046eb 100644
> > > --- a/drivers/infiniband/core/cq.c
> > > +++ b/drivers/infiniband/core/cq.c
> > > @@ -300,12 +300,7 @@ struct ib_cq *__ib_alloc_cq_any(struct ib_device *dev, void *private,
> > >   }
> > >   EXPORT_SYMBOL(__ib_alloc_cq_any);
> > >
> > > -/**
> > > - * ib_free_cq_user - free a completion queue
> > > - * @cq:		completion queue to free.
> > > - * @udata:	User data or NULL for kernel object
> > > - */
> > > -void ib_free_cq_user(struct ib_cq *cq, struct ib_udata *udata)
> > > +static void _ib_free_cq_user(struct ib_cq *cq, struct ib_udata *udata)
> > >   {
> > >   	if (WARN_ON_ONCE(atomic_read(&cq->usecnt)))
> > >   		return;
> > > @@ -333,4 +328,15 @@ void ib_free_cq_user(struct ib_cq *cq, struct ib_udata *udata)
> > >   	kfree(cq->wc);
> > >   	kfree(cq);
> > >   }
> > > +
> > > +/**
> > > + * ib_free_cq_user - free a completion queue
> > > + * @cq:		completion queue to free.
> > > + * @udata:	User data or NULL for kernel object
> > > + */
> > > +void ib_free_cq_user(struct ib_cq *cq, struct ib_udata *udata)
> > > +{
> > > +	if (!cq->shared)
> > > +		_ib_free_cq_user(cq, udata);
> > > +}
> > >   EXPORT_SYMBOL(ib_free_cq_user);
> > All CQs from the pool will have "shared" boolean set and you don't need
> > to create an extra wrapper, simply put this "if (cq->shared) return;"
> > line in original ib_free_cq_user(). Just don't forget to set "shared"
> > to be false in ib_cq_pool_destroy().
> Makes sense.
> >
> > > diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
> > > index bf0249f..d1bacd7 100644
> > > --- a/drivers/infiniband/core/verbs.c
> > > +++ b/drivers/infiniband/core/verbs.c
> > > @@ -1990,6 +1990,9 @@ struct ib_cq *__ib_create_cq(struct ib_device *device,
> > >
> > >   int rdma_set_cq_moderation(struct ib_cq *cq, u16 cq_count, u16 cq_period)
> > >   {
> > > +	if (cq->shared)
> > > +		return -EOPNOTSUPP;
> > > +
> > >   	return cq->device->ops.modify_cq ?
> > >   		cq->device->ops.modify_cq(cq, cq_count,
> > >   					  cq_period) : -EOPNOTSUPP;
> > > @@ -1998,6 +2001,9 @@ int rdma_set_cq_moderation(struct ib_cq *cq, u16 cq_count, u16 cq_period)
> > >
> > >   int ib_destroy_cq_user(struct ib_cq *cq, struct ib_udata *udata)
> > >   {
> > > +	if (cq->shared)
> > > +		return -EOPNOTSUPP;
> > > +
> > >   	if (atomic_read(&cq->usecnt))
> > >   		return -EBUSY;
> > >
> > > @@ -2010,6 +2016,9 @@ int ib_destroy_cq_user(struct ib_cq *cq, struct ib_udata *udata)
> > >
> > >   int ib_resize_cq(struct ib_cq *cq, int cqe)
> > >   {
> > > +	if (cq->shared)
> > > +		return -EOPNOTSUPP;
> > > +
> > >   	return cq->device->ops.resize_cq ?
> > >   		cq->device->ops.resize_cq(cq, cqe, NULL) : -EOPNOTSUPP;
> > >   }
> > > diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> > > index 4c488ca..b79737b 100644
> > > --- a/include/rdma/ib_verbs.h
> > > +++ b/include/rdma/ib_verbs.h
> > > @@ -1582,6 +1582,7 @@ struct ib_cq {
> > >   	 * Implementation details of the RDMA core, don't use in drivers:
> > >   	 */
> > >   	struct rdma_restrack_entry res;
> > > +	bool shared;
> > Lets do "u8 shared:1;" from the beginning.
> Not sure what you mean "from the beginning".

I was under impression that you are adding first "bool" variable to the
ib_cq struct. Having u8 a:1, b:1 notation allows us to save memory without
sacrificing "boolean" nature of the "a" and "b".

We will use one byte of the space for eight booleans, instead of 8
bytes if we chose to use "bool" in the struct.

Thanks
