Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0264529DC36
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Oct 2020 01:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgJ2AWa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Oct 2020 20:22:30 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:1412 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731439AbgJ1WiG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 28 Oct 2020 18:38:06 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f99b4810001>; Wed, 28 Oct 2020 11:12:17 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 28 Oct
 2020 18:12:04 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 28 Oct 2020 18:12:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOkhYHnOIuWO0JFhnrYdAZoHACUcV4d8F1nq/IHMmHsGR9lrpQIEpGPI6icFbc1lcy9Zg7bg+o5TIThDcwGyPOGwv/Le7HAiMWI+oPfEIZcVskXs/cU2wu0iKcjusNvDGowe0BGIIRmFqL1rXqg/14KGtacmvyY2I8i7QQNicCEnQZp7dfQ87sKoel7qqIqi4OYsHRiRzgjRpGowkLD1D+lQnOPiOtH2Wz8vZ4kbY4sJxR+9c21LCSokt36a7Ue+Tv5qV4PLGzvdXgoK4XeXHLV4QrpD2Z2AbrWgDi+JH9MCTOhGr92nAoDqiDewOI7ZyHhIXz/tbeHuFTw+jq+YLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YP8D6ZRgYOROQgEGap2dMjkO7xaBPgvAutXQghKnxag=;
 b=frA83xz3whvNvGxR47LquEVAhpy75DvQKPuN5K0pc/s+9l/GeNksOHnEGNZsisLBWLfV7KPCy9weBa/I+FQUNBfuVfA1aJhlmnB3H9+PkLhzq7X2ok5v4FSPCzrn0bq3pFxrv49/tUYc1KM9rzMBAS4Yjt0NGNVEFK/vXnoFXLRpo64ZRsP2ud+428wC3fSGrMhDj977c6y63bj5ZDUejYUmoC05QYsn8ESdq1ug321UUC4kNP7mpfYfj2PHNchvyQNvgvs6gsTFOwehg9dxp4Eoy9fR2pYONkFQhYodhVTcDbEh6rip95ySkRK52fb9eIfEMre6r9rTZKOs978K/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4041.namprd12.prod.outlook.com (2603:10b6:5:210::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Wed, 28 Oct
 2020 18:12:03 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.027; Wed, 28 Oct 2020
 18:12:02 +0000
Date:   Wed, 28 Oct 2020 15:12:01 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Joe Perches <joe@perches.com>
CC:     Doug Ledford <dledford@redhat.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        "Christian Benvenuti" <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        "Parvi Kaustubhi" <pkaustub@cisco.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Bart Van Assche <bvanassche@acm.org>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH 4/4] RDMA: Convert various random sprintf sysfs _show
 uses to sysfs_emit
Message-ID: <20201028181201.GA2468498@nvidia.com>
References: <cover.1602122879.git.joe@perches.com>
 <ecde7791467cddb570c6f6d2c908ffbab9145cac.1602122880.git.joe@perches.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ecde7791467cddb570c6f6d2c908ffbab9145cac.1602122880.git.joe@perches.com>
X-ClientProxiedBy: MN2PR16CA0032.namprd16.prod.outlook.com
 (2603:10b6:208:134::45) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR16CA0032.namprd16.prod.outlook.com (2603:10b6:208:134::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Wed, 28 Oct 2020 18:12:02 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kXpvV-00AMGL-Cj; Wed, 28 Oct 2020 15:12:01 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603908737; bh=YP8D6ZRgYOROQgEGap2dMjkO7xaBPgvAutXQghKnxag=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=VpIFj4E4RElHBC7/dFZWhJ8RbR0cGzDIMN/jK3SY4IwLSUd7VWdhypm9r2oBCT8Tu
         fH8unTYK2BnwDuzuO9zo0RnLSXK2YuW6ayhcmucrB6XeBugPqiB4KR0ke5Hos+hvBC
         BBZlyTvEZRonROBZgz9LHuRkW9Fr2dEJzfDLWKqxctJ+v4Moz4knGY0dDTDGxJhXLI
         jJBZ1m+r1c62KpB3/eagGzN3CKWduOdcjTbdp4W7YTptzbUeT7F13xuUuFJ2lDbTpI
         hzeuqCG6d4+c5Qar3NDiqKPl05ZYcHRIcpfhYBQt90k7fh+Z095sN3YoHsgNEXjQhd
         ruQGPDHkdaa6g==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 07, 2020 at 07:36:27PM -0700, Joe Perches wrote:
> diff --git a/drivers/infiniband/hw/mlx4/sysfs.c b/drivers/infiniband/hw/mlx4/sysfs.c
> index 75d50383da89..fc6c98b608d3 100644
> +++ b/drivers/infiniband/hw/mlx4/sysfs.c
> @@ -444,16 +444,17 @@ static ssize_t show_port_pkey(struct mlx4_port *p, struct port_attribute *attr,
>  {
>  	struct port_table_attribute *tab_attr =
>  		container_of(attr, struct port_table_attribute, attr);
> -	ssize_t ret = -ENODEV;
> +	int len;
> +	struct pkey_mgt *m = &p->dev->pkeys;
> +	u8 key = m->virt2phys_pkey[p->slave][p->port_num - 1][tab_attr->index];
>  
> -	if (p->dev->pkeys.virt2phys_pkey[p->slave][p->port_num - 1][tab_attr->index] >=
> -	    (p->dev->dev->caps.pkey_table_len[p->port_num]))
> -		ret = sprintf(buf, "none\n");
> +	if (key >= p->dev->dev->caps.pkey_table_len[p->port_num])
> +		len = sysfs_emit(buf, "none\n");
>  	else
> -		ret = sprintf(buf, "%d\n",
> -			      p->dev->pkeys.virt2phys_pkey[p->slave]
> -			      [p->port_num - 1][tab_attr->index]);
> -	return ret;
> +		len = sysfs_emit(buf, "%d\n",
> +				 p->dev->pkeys.virt2phys_pkey[p->slave]
> +				 [p->port_num - 1][tab_attr->index]);
> +	return len;
>  }

This duplication of virt2phys_pkey can be simplified to:

static ssize_t show_port_pkey(struct mlx4_port *p, struct port_attribute *attr,
			      char *buf)
{
	struct port_table_attribute *tab_attr =
		container_of(attr, struct port_table_attribute, attr);
	struct pkey_mgt *m = &p->dev->pkeys;
	u8 key = m->virt2phys_pkey[p->slave][p->port_num - 1][tab_attr->index];

	if (key >= p->dev->dev->caps.pkey_table_len[p->port_num])
		return sysfs_emit(buf, "none\n");
	return sysfs_emit(buf, "%d\n", key);
}

(I adjusted it)

Jason
