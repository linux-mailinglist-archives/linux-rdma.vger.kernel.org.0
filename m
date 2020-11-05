Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6742A81F1
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Nov 2020 16:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730721AbgKEPPZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Nov 2020 10:15:25 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:9977 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728371AbgKEPPZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Nov 2020 10:15:25 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa4170b0001>; Thu, 05 Nov 2020 07:15:23 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 5 Nov
 2020 15:15:25 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 5 Nov 2020 15:15:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQpi248m8RmnJ9AQSvzpI6JJ+9JBNVLVcO2iRF7lJabknxC6Ha/Wkri0Jw6ZoqKxkD9m6+AfGCArpFBNkVe4Y61fAChv3sawls51TakIq+mHzrd3SZp1utewGaMOhNFTCV9Hygo/z/7zGA6ggtkGyjU5ni9N5RiSOg2K3G6kGiroEw74HERwikEuyL9Bl3vYEqgqkd2csbFWIzG+K3yTYtY3SjPI4U621eRhJGZkz4K1uMYnqNTom7WHl+NGo5tuv/y3Ot3VUTxwiqmHQHngQRSFbJRt/yhX90ZrF96k4eY1i9QgK2zGYYXDveAbp8RjZKt3K2NXh8nRaB/bN6JiHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmydzCqihVs0qdCz7t6dach8iMthA3p6n1TXPm4xSyM=;
 b=j89iI3CNwVZDw6+pElGbikz/ul5uvOEXaHq7m/PHcV3QQ1qU4j/NPFudR6lPCmr2JNe2bGfg7AAMnJSI06JXiUEGfayXI+jvxN/KCKs/RwJFMRlD5E6XtqIqYN/xi+u2Uw0/mXdxtqJy6Ajt04yDkC552mCUVWgRvWWQ8auaNvCvwu8emZN/WGqk9A/Xgfeuke3x/PJ3u6t4ULEQTfNJEIGGCym5OCVdU2Gb6JgYM43dg8prVoohBSnPjrm7yjjBgXH35TMQSlVC5vcN5NB2lUOEVP36+f98UjuzknNyhQ4XNijp9K9prWgCi8w+YBZow5/eopViW6kcI+hKkCVYzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4042.namprd12.prod.outlook.com (2603:10b6:5:215::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Thu, 5 Nov
 2020 15:15:24 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.032; Thu, 5 Nov 2020
 15:15:24 +0000
Date:   Thu, 5 Nov 2020 11:15:22 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leonro@mellanox.com>
CC:     <linux-rdma@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] RDMA/cm: Make the local_id_table xarray non-irq
Message-ID: <20201105151522.GF2620339@nvidia.com>
References: <0-v1-808b6da3bd3f+1857-cm_xarray_no_irq_jgg@nvidia.com>
 <20201105085231.GP5429@unreal>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201105085231.GP5429@unreal>
X-ClientProxiedBy: MN2PR16CA0050.namprd16.prod.outlook.com
 (2603:10b6:208:234::19) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR16CA0050.namprd16.prod.outlook.com (2603:10b6:208:234::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Thu, 5 Nov 2020 15:15:23 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kagyw-00HOfF-E4; Thu, 05 Nov 2020 11:15:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604589324; bh=cmydzCqihVs0qdCz7t6dach8iMthA3p6n1TXPm4xSyM=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=Ukhz/6VCvqSiXIc32Uy9ko7NNWlQ40yUv+3eBniEO1+1l2nwzxoMh2wLIQt9TEAud
         X9fdZL63KwA/0gpnZcfAWFRGKX2QLtWoBwv1d7K5SF+iv2L8Lm5wCPJiqNVQA2gSOL
         nytTIXRYa0t99/PMcIW5Cqi3kwkj1PJxg1IpfW0a0LUT4tiK9HRMikp9ckniFxstTY
         S8I4Bs3r6iEfSc8xqG75S1aWmnYaUJY8qKMSS0sgJhjTlh0ocZUxDvpTBZ7SFhjbNL
         GM9eTcLZkVrGr2csTDvvoMSyd+6YXba1aPOSgbn7EQXuTr348MbmGJKgGIozfkJYBd
         /1U+4soZL3TQg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 05, 2020 at 10:52:31AM +0200, Leon Romanovsky wrote:
> On Wed, Nov 04, 2020 at 05:40:59PM -0400, Jason Gunthorpe wrote:
> > The xarray is never mutated from an IRQ handler, only from work queues
> > under a spinlock_irq. Thus there is no reason for it be an IRQ type
> > xarray.
> >
> > This was copied over from the original IDR code, but the recent rework put
> > the xarray inside another spinlock_irq which will unbalance the unlocking.
> >
> > Fixes: c206f8bad15d ("RDMA/cm: Make it clearer how concurrency works in cm_req_handler()")
> > Reported-by: Matthew Wilcox <willy@infradead.org>
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> >  drivers/infiniband/core/cm.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
> > index 0201364974594f..167e436ae11ded 100644
> > +++ b/drivers/infiniband/core/cm.c
> > @@ -859,8 +859,8 @@ static struct cm_id_private *cm_alloc_id_priv(struct ib_device *device,
> >  	atomic_set(&cm_id_priv->work_count, -1);
> >  	refcount_set(&cm_id_priv->refcount, 1);
> >
> > -	ret = xa_alloc_cyclic_irq(&cm.local_id_table, &id, NULL, xa_limit_32b,
> > -				  &cm.local_id_next, GFP_KERNEL);
> > +	ret = xa_alloc_cyclic(&cm.local_id_table, &id, NULL, xa_limit_32b,
> > +			      &cm.local_id_next, GFP_KERNEL);
> >  	if (ret < 0)
> >  		goto error;
> >  	cm_id_priv->id.local_id = (__force __be32)id ^ cm.random_id_operand;
> > @@ -878,8 +878,8 @@ static struct cm_id_private *cm_alloc_id_priv(struct ib_device *device,
> >   */
> >  static void cm_finalize_id(struct cm_id_private *cm_id_priv)
> >  {
> > -	xa_store_irq(&cm.local_id_table, cm_local_id(cm_id_priv->id.local_id),
> > -		     cm_id_priv, GFP_KERNEL);
> > +	xa_store(&cm.local_id_table, cm_local_id(cm_id_priv->id.local_id),
> > +		 cm_id_priv, GFP_ATOMIC);
> >  }
> 
> I see that in the ib_create_cm_id() function, we call to cm_finalize_id(),
> won't it be a problem to do it without irq lock?

The _irq or _bh notations are only needed if some place acquires the
internal spinlock from a bh (timer, tasklet, etc) or irq.

Since all the places working with local_id_table are obviously in
contexts that can do GFP_KERNEL allocations I conclude a normal
spinlock is fine.

Jason
