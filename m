Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA2EC292DCD
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Oct 2020 20:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730809AbgJSSxw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Oct 2020 14:53:52 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:10123 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727681AbgJSSxw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Oct 2020 14:53:52 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f8de0b30000>; Mon, 19 Oct 2020 11:53:39 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 19 Oct
 2020 18:53:51 +0000
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.55) by
 HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 19 Oct 2020 18:53:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OVBQrIetkRL42p1hGchfu3IXwr0PmZoI2YsZU++vQa2DOQifUGTztdWZHvn4yDdIKBkN1YxKuXPvwgNHSa9m1ZudazXUAXOUq7ptMbuXtZk6VNf6ZMGx1EnhtL2CeaYyUsqaqKsdyPIufP3LfJ9x89T/DbaZmFqidb+zelG9Z9pB55ZFSiTqlvhNJAm0VXMguEFHak3Vil6OC6qtPDo2zdO263m05QqDNlZVoPlXhtahxT3me/1zoqZ9I5neHFdO/D+HM3n0lQzz8BS0DwPXH0OODYq0Q6lCtvMNufstu1Jit/oZRPxfRe4+Zu7Kb/2TIOr2PkDs6sRfsXUBXIxpdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFac+d161dO333s9a+vYPzaUEXie59FLGGUGjw1mD+E=;
 b=PT7c4CGLYoITS+7gOqzoA/63EbXtoZj5gs8XUT4P2rFeutuzURkybGBVZoJg9p3B1Cvc75jyE3s4DjlQ5OSD+7PlK9QVT5VCp7VX7wqrceTrdE5/QG2GMR1SZu15RLD/mc6ZHNmccx2pMzfUlt6NKrsZ3HYpMkHYhuVEPxthmUhpX3VQLMJk+jQcZfvaITeh3vXcdUwWJWhlcXkzfvYc/tf5RfSbAxFQarwvenQn4DqLKFeHE+caVO+WU+zZCeReWFzjJ3ZOAsjxf8ylZR1A6Dw22Ni6s93D+RRqO1V/pC9YUAMc4Gsr/QlBllyAmmG6VQ0Z1SJcsv5o8GLMnQ8NFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.28; Mon, 19 Oct
 2020 18:53:50 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3477.028; Mon, 19 Oct 2020
 18:53:50 +0000
Date:   Mon, 19 Oct 2020 15:53:48 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
CC:     <linux-rdma@vger.kernel.org>, Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH RFC] rdma_rxe: Stop passing AV from user space
Message-ID: <20201019185348.GZ6219@nvidia.com>
References: <20201016170147.11016-1-rpearson@hpe.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201016170147.11016-1-rpearson@hpe.com>
X-ClientProxiedBy: MN2PR13CA0030.namprd13.prod.outlook.com
 (2603:10b6:208:160::43) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR13CA0030.namprd13.prod.outlook.com (2603:10b6:208:160::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.4 via Frontend Transport; Mon, 19 Oct 2020 18:53:49 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kUaI0-002cvR-9k; Mon, 19 Oct 2020 15:53:48 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603133619; bh=EFac+d161dO333s9a+vYPzaUEXie59FLGGUGjw1mD+E=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=Kl669+Z2ZYq5uf/ESaSrTTOBBVdhvVJG40mUADoWxe/b2m/Ow93taKJ8E6c8eIVSn
         1NNpaRw6IbUc8wjb57dVN5rVUXEpvSilV6v0QLjv9qdphERX0MiLCb9+dW8vIT7Qmx
         4g6d+5UlEhpHfF7aOkp5JA99g+m7UKSFSYFm1bjYJcuxQY63TCkpN1wogL2qqJ3lVx
         DL5vVZImlZ5Ql133IBELIntwsT905beFeR321I/lXMhFYuU++EAYJWEHJOETIP3T8i
         F7oir1wY5QInCugGSmjCzxQcWMFGxPIsqn3199ru0+oCH8Iqv4gKfEAFPfBi6ycJ16
         pP7XgLcfn+7FQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 16, 2020 at 12:01:48PM -0500, Bob Pearson wrote:
>  
> +static struct ib_ah *get_ah_from_handle(struct rxe_qp *qp, u32 handle)
> +{
> +	struct ib_uverbs_file *ufile;
> +	struct uverbs_api *uapi;
> +	const struct uverbs_api_object *type;
> +	struct ib_uobject *uobj;
> +
> +	ufile = qp->ibqp.uobject->uevent.uobject.ufile;
> +	uapi = ufile->device->uapi;
> +	type = uapi_get_object(uapi, UVERBS_OBJECT_AH);
> +	if (IS_ERR(type))
> +		return NULL;
> +	uobj = rdma_lookup_get_uobject(type, ufile, (s64)handle,
> +				       UVERBS_LOOKUP_READ, NULL);
> +	if (IS_ERR(uobj)) {
> +		pr_warn("unable to lookup ah handle\n");
> +		return NULL;
> +	}
> +
> +	rdma_lookup_put_uobject(uobj, UVERBS_LOOKUP_READ);

It can't be put and then return the data pointer, it is a use after free:

> +	return uobj->object;

> @@ -562,11 +563,6 @@ static int init_send_wqe(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
>  
>  	init_send_wr(qp, &wqe->wr, ibwr);
>  
> -	if (qp_type(qp) == IB_QPT_UD ||
> -	    qp_type(qp) == IB_QPT_SMI ||
> -	    qp_type(qp) == IB_QPT_GSI)
> -		memcpy(&wqe->av, &to_rah(ud_wr(ibwr)->ah)->av, sizeof(wqe->av));

It needs some kind of negotiated compat, can't just break userspace
like this

Jason
