Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07E9C2931A5
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Oct 2020 01:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725800AbgJSXAW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Oct 2020 19:00:22 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:10552 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbgJSXAW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Oct 2020 19:00:22 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f8e1a790002>; Mon, 19 Oct 2020 16:00:09 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 19 Oct
 2020 23:00:21 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 19 Oct 2020 23:00:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nc/ry+ghSckELZUHsN5OWEvlPXI+lc7iaRGVweLO9f9tKDxZPCzzrhggC2Y431wsy3iI8+5vr1PjNskmtTJu6o2orMGb2ydUIuoyuUWuP7wyrWi74SzgGe3pVaPdp0hZRHXYG394MSC9LmW/oEzjllUAzsCbut++h6CC22JNC6ZdgrKJRatgSPVC4joiDDPxxFwQzj5Jy07ytZjVMErvrzu1VmkJdA1EKyMRj1EOYj2kl9UFHV6iGpIfhBGuNxTe+UC/u0Sx6MvN8KSoTbI8lFzuZKX4oAu2tSIUy9CJIJyLX9/ZR8d4mbXodkjJ6NW7zOwpW9MiLao98olAI0TYag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qkAnmxst6KqgQfHlMjBvPxPM3l4VR922qbxiG9JvGD4=;
 b=IaGxOA1v0syIjDkR0nmk/guQ0/AQhgV28O0w198oo44KIERwmPPJeO68ha2q0ubNn/oiFeC5MWAfgIutWcaHkyzSyWgjYHLhYp/JOFON9/XWFrfDRAUm5OBLOt/V3xo3olXbdOcCN0AA6fmUK2C5vXaAWSg0HPDzxywItvBd28L101CDs9QfLJMJOHgNRZBproS6dxTmiWtqqpNEqGnYtK81bcBJWYYqbg0ZOTrbopzt6yZul5QumHdW8we/bRDtHxlVsiBhTG98jcSoyslpvxaXhO84c3uW2zhu6GvBD4T+anuMEfYQX81l4CiWfJ2cYgOmzzHJVCtWqufanCuKiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4546.namprd12.prod.outlook.com (2603:10b6:5:2ae::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Mon, 19 Oct
 2020 23:00:19 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3477.028; Mon, 19 Oct 2020
 23:00:19 +0000
Date:   Mon, 19 Oct 2020 20:00:17 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
CC:     <linux-rdma@vger.kernel.org>, Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH RFC] rdma_rxe: Stop passing AV from user space
Message-ID: <20201019230017.GB6219@nvidia.com>
References: <20201016170147.11016-1-rpearson@hpe.com>
 <20201019185348.GZ6219@nvidia.com>
 <c8e69967-12aa-6f8e-18c5-96fbd9f1dc2b@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c8e69967-12aa-6f8e-18c5-96fbd9f1dc2b@gmail.com>
X-ClientProxiedBy: BL0PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:208:91::14) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR05CA0004.namprd05.prod.outlook.com (2603:10b6:208:91::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.8 via Frontend Transport; Mon, 19 Oct 2020 23:00:19 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kUe8X-002hI7-Ij; Mon, 19 Oct 2020 20:00:17 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603148409; bh=qkAnmxst6KqgQfHlMjBvPxPM3l4VR922qbxiG9JvGD4=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=mN0AnpQ1CaobejxYe2P82Z7CqBLUoxTGLd1+k/4x13+oa8ikgXJhXuxU8TPVqQNQM
         1iknQ0ubT6E3kQEJXhW+LVywyPnmCmHs+WWvKyXOOZmiH80Xj/gsNecISGNO9QmBXE
         kMFrOMNExTq1d6QrwJRMawpPyxUNHfuooqxWo9zW4VQ4M7Bf7ehybFLkCDsxJpOM0f
         4BRIpuYtaxFSZYxYLQms35/VYDt1bLsn5c8CUAfXCaTJGkBdCNXAI5Tci6kc9lkhvj
         OqdHJ2fWME/kDcg7q1L/yqh03GK53nhMaAoUNAkMw/J3IdTYeGw1sB+e/jzsLQovFL
         CmydEax47ZRfw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 19, 2020 at 02:06:30PM -0500, Bob Pearson wrote:
> On 10/19/20 1:53 PM, Jason Gunthorpe wrote:
> > On Fri, Oct 16, 2020 at 12:01:48PM -0500, Bob Pearson wrote:
> >>  
> >> +static struct ib_ah *get_ah_from_handle(struct rxe_qp *qp, u32 handle)
> >> +{
> >> +	struct ib_uverbs_file *ufile;
> >> +	struct uverbs_api *uapi;
> >> +	const struct uverbs_api_object *type;
> >> +	struct ib_uobject *uobj;
> >> +
> >> +	ufile = qp->ibqp.uobject->uevent.uobject.ufile;
> >> +	uapi = ufile->device->uapi;
> >> +	type = uapi_get_object(uapi, UVERBS_OBJECT_AH);
> >> +	if (IS_ERR(type))
> >> +		return NULL;
> >> +	uobj = rdma_lookup_get_uobject(type, ufile, (s64)handle,
> >> +				       UVERBS_LOOKUP_READ, NULL);
> >> +	if (IS_ERR(uobj)) {
> >> +		pr_warn("unable to lookup ah handle\n");
> >> +		return NULL;
> >> +	}
> >> +
> >> +	rdma_lookup_put_uobject(uobj, UVERBS_LOOKUP_READ);
> > 
> > It can't be put and then return the data pointer, it is a use after free:
> > 
> >> +	return uobj->object;
> > 
> >> @@ -562,11 +563,6 @@ static int init_send_wqe(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
> >>  
> >>  	init_send_wr(qp, &wqe->wr, ibwr);
> >>  
> >> -	if (qp_type(qp) == IB_QPT_UD ||
> >> -	    qp_type(qp) == IB_QPT_SMI ||
> >> -	    qp_type(qp) == IB_QPT_GSI)
> >> -		memcpy(&wqe->av, &to_rah(ud_wr(ibwr)->ah)->av, sizeof(wqe->av));
> > 
> > It needs some kind of negotiated compat, can't just break userspace
> > like this
> > 
> > Jason
> > 
> 
> 1st point. I get it. uobj->object contains the address of one of the ib_xxx verbs objects.
> Normally the driver never looks at this level but presumably has a kref on that object so it makes
> sense to look it up. Perhaps better would be:
> 
> 	void *object;
> 
> 	...
> 
> 	uobj = rdma_lookup_get_uobject(...);
> 
> 	object = uobj->object;
> 
> 	rdma_lookup_put_uobject(...);
> 
> 	return (struct ib_ah *)object;
> 
> Here the caller has created the ib_ah but has not yet destroyed it so it must hold a kref on it.

Drivers are not supposed to keep using object after it has been
destroyed, so some kind of interlock is needed to prevent/defer
destruction here.

The uobject layer does not provide something usable to drivers

> 2nd point. I also get. This suggestion imagines that there will come
> a day when we can change the user API.  May be a rare day but must
> happen occasionally. The current design is just plain wrong and
> needs to get fixed eventually.

You can have some cap negotiation to switch the mode AH mode in the
WQEs - 'Use WQE format 2' for instance. Most of the HW drivers have
multiple WQE formats the userspace selects.

Jason
