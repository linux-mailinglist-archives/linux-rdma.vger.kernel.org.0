Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11AF5283C5B
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Oct 2020 18:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbgJEQVJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Oct 2020 12:21:09 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:2190 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbgJEQVJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Oct 2020 12:21:09 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7b47be0006>; Mon, 05 Oct 2020 09:20:14 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 5 Oct
 2020 16:19:09 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 5 Oct 2020 16:19:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+dRdE9b2Z6SGzgL7WM1UDxLsPJnXMrEzV8Go2PoPNvfGXGur8qXyURUwp0joTRfXK9/5P5jKrEeBI6g9A8aELFpPf9HiRSjYwXqdeEw3MGuRMPd5gVxss+PRN2rnbpApdkLCbBNSygY8i5wiBHkJJ7NrcOAdtB1EKk8M1dD2iyF/A4r5Q3umY4E7BDiVG1kU/Pgw+ZYNubzSu57v9VcmHs8a7Q9QUlTaMYOltMWY9CcHR7sPowgUIG+7ZCijVSy04nX5/T0sP1fu0oCT8zAKYp/cw6qVZkTlzy2EANl5KK/RxAUmBE1PzYezaw2OBwZ48zEkYdqWhv9amX2Zdo00w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8FPyXzEl5Tm8JT9pYI9dD/XDnWy3oUo9YxmoQwb03U=;
 b=Yx8j6vMUOtSDMBjs6vdphzQLPGlSCJOCXK7wgjyG0xLbIskjqd6df6ml9I/1o5ayTo9PZyuq4v+wTKOk8OGCD4otn0D8CTqiKCBriKD8pc6CsAIP5t2Ku6fOnT+xNbfbwtSXqHOzamwXBBu/T8jaxN2UUf1KgiAqAabnLhrro6IIZhQ6rNZu0TpJQ/q7HvxdtAP5xwWZbmDhEnBZMGh9xla49RXFYQ3Kv7EffTS9VgSlwo+P2rc/gfxeqQxQTSnXNFlWWvBJBvJO1N06M2GuIg1Ma2u4GPhy8P0r5IjUe8UBj0WSPw+nxe9mJx+ofpSyouQJDLs7HQnKMAUby23gqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1146.namprd12.prod.outlook.com (2603:10b6:3:73::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Mon, 5 Oct
 2020 16:19:07 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.044; Mon, 5 Oct 2020
 16:19:07 +0000
Date:   Mon, 5 Oct 2020 13:19:05 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gal Pressman <galpress@amazon.com>
CC:     Adit Ranadive <aditr@vmware.com>, Ariel Elior <aelior@marvell.com>,
        Christian Benvenuti <benve@cisco.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        "Dennis Dalessandro" <dennis.dalessandro@intel.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        "Faisal Latif" <faisal.latif@intel.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Leon Romanovsky <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, Weihang Li <liweihang@huawei.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Lijun Ou <oulijun@huawei.com>,
        Parvi Kaustubhi <pkaustub@cisco.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        "Yossi Leybovich" <sleybo@amazon.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Zhu Yanjun <yanjunz@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH 06/11] RDMA: Check attr_mask during modify_qp
Message-ID: <20201005161905.GY816047@nvidia.com>
References: <6-v1-caa70ba3d1ab+1436e-ucmd_mask_jgg@nvidia.com>
 <06064431-fd1b-463d-c022-31f035b697bf@amazon.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <06064431-fd1b-463d-c022-31f035b697bf@amazon.com>
X-ClientProxiedBy: MN2PR12CA0019.namprd12.prod.outlook.com
 (2603:10b6:208:a8::32) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR12CA0019.namprd12.prod.outlook.com (2603:10b6:208:a8::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34 via Frontend Transport; Mon, 5 Oct 2020 16:19:06 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kPTCb-007h52-OL; Mon, 05 Oct 2020 13:19:05 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601914814; bh=X8FPyXzEl5Tm8JT9pYI9dD/XDnWy3oUo9YxmoQwb03U=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=auIiY3dZnOvLtowsEB7gCiACWm1SR6kRgVhWkNsuezUCjTdW/+KHEuJ9rOl+g5BgG
         8Ifftq5FobYv++JGywCNQb7fTg3LrV57KqvziVTm0Dl1YeiesvpFNZjBXFdy+fR7vT
         PDccKCF3m9h02+4VIrMvksDq4xk95MxUP/vLGxsrunuDHj+f7l9eYUH9MWs40f8EA/
         fzYatoqR5OohOXDXRCwL9W/RDP6oEoqDVTazZOk26eyfX+6uKPHo1o2/s8mUSmK+RN
         TiKbbjmUZHE1D9UWnsqNgtaxMLxdYhWHfFxp7h1FRJK99SQqhOlgeThlxptsN74iTo
         hk1Ui4Z/7ZhSw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Oct 04, 2020 at 02:02:52PM +0300, Gal Pressman wrote:
> On 04/10/2020 2:20, Jason Gunthorpe wrote:
> > diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
> > index 191e0843f090c8..e3d9a5a5f4d992 100644
> > +++ b/drivers/infiniband/hw/efa/efa_verbs.c
> > @@ -917,6 +917,9 @@ int efa_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
> >  	enum ib_qp_state new_state;
> >  	int err;
> >  
> > +	if (qp_attr_mask & ~IB_QP_ATTR_STANDARD_BITS)
> > +		return -EOPNOTSUPP;
> 
> This is kinda redundant, we have a more strict check in efa_modify_qp_validate.

Okay

Thanks,
Jason
