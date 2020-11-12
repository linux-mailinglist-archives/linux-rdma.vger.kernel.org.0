Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90E712B0CA5
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Nov 2020 19:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbgKLSac (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Nov 2020 13:30:32 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:23614 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgKLSab (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Nov 2020 13:30:31 -0500
Received: from HKMAIL104.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fad7f450001>; Fri, 13 Nov 2020 02:30:29 +0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 12 Nov
 2020 18:30:28 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 12 Nov 2020 18:30:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jnKvLpjFEnQ/zZ6q9dmaFBpO+RD79wiPUzgxFvGnxWJrtfXy6+D0PvBTD70AX0bPpMbmJY8j8eoTao1bEhPwREvdaJleG+FKItvOeOmuEQSIoFPyvDNGL/7hKoKrWWRyLY3wDB09VCHneENyVrenQCzKp3ZJnw7c9DX7V/l4PTkvgBdbbTT5wY6CDPJwADY5M7P9/Yuwb/yFfSBtLSHyqrCscFvfUpFEQqrmyhZBq4L3ht5bkoAnn6fyKdaOCwHpnXxjLFH01U9Dbeg21C+J9Y+6wLIXjfjyENwwD0Q4ig1TIIhyXBsY2bOzQyFd0BnUMFmMvaMPVeBA4ji4sk+sgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+lpMfkomTSa0aFeezrHssGhBPCHSZ86NONmAxbWk+k=;
 b=myJf8XQCwh/4KNiLMks5W6+bAoAgUniWOrv1Y3PWNFKqPV74cDrBPEB1EN7xZSeTjkc+X2Kjo2wWFKrZVR04bH3AYyK2Oz6+w38ZLylEGtZ0P3Y5R4J1LpD7jIZHi7/swh2JQzn8VQmYrtNRaVY8L1NlWlw312ZHfdoe2wu/TJXPpLouAXIjNEiFk1fyn39ZED0SM+dC/Z6lHR9Gvv16MZsjs4VElYE0sV+JDrhREqTWfoXOdaruNpxesPYUjC08TVB6okbgZNxwZg6t3nbYqUMv/GbBizIJKXnkEv/bbPGO7UvAJFuDO06pXZIFIUDl1mubZb+bkiyhLH5Rnbxp0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Thu, 12 Nov
 2020 18:30:25 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.032; Thu, 12 Nov 2020
 18:30:25 +0000
Date:   Thu, 12 Nov 2020 14:30:23 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     YueHaibing <yuehaibing@huawei.com>, <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>, <target-devel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IB/srpt: Fix passing zero to 'PTR_ERR'
Message-ID: <20201112183023.GB917484@nvidia.com>
References: <20201112145443.17832-1-yuehaibing@huawei.com>
 <20201112172008.GA944848@nvidia.com>
 <c73d9be0-0bd8-634a-e3d1-c81fe4c30482@acm.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c73d9be0-0bd8-634a-e3d1-c81fe4c30482@acm.org>
X-ClientProxiedBy: BL1PR13CA0298.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::33) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL1PR13CA0298.namprd13.prod.outlook.com (2603:10b6:208:2bc::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.24 via Frontend Transport; Thu, 12 Nov 2020 18:30:24 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kdHMV-0042jQ-Ot; Thu, 12 Nov 2020 14:30:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605205829; bh=o+lpMfkomTSa0aFeezrHssGhBPCHSZ86NONmAxbWk+k=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=UBzxnA9Bm40zYg/M00ls6xCMPE0dFEjecLM/7eixNE+Ddi6VlrIPD+zgDHtzYycFY
         Zlhhu2uDtz6b3PGRV6bwYWkhaMPqW4l62FAELXYNvEAtQTnMmiHjfqA34fov7n8/SP
         W2aU5g8VhHrV9vYdpAVRtBr3Rg9s8DzaZMDn3u1JJYLLn6oFVqcYRL9nMEwK8ClS9Z
         lj7tnNAIjWEgs0IS+aNzMcUN02sd1Ugrm/oO4q87KrmVdXnyUvfJeIt6LqaYXlvVcA
         CpsOv93YSsLNy2RspIV+V7jT9ljAOvMPS0vxVzSb+eyrhfLGl31/1pKzh2fugMN42d
         wbSl8eMQmYPGQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 12, 2020 at 10:25:48AM -0800, Bart Van Assche wrote:
> On 11/12/20 9:20 AM, Jason Gunthorpe wrote:
> > I think it should be like this, Bart?
> > 
> > diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
> > index 6017d525084a0c..80f9673956ced2 100644
> > +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
> > @@ -2311,7 +2311,7 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
> >   	mutex_lock(&sport->port_guid_id.mutex);
> >   	list_for_each_entry(stpg, &sport->port_guid_id.tpg_list, entry) {
> > -		if (!IS_ERR_OR_NULL(ch->sess))
> > +		if (ch->sess)
> >   			break;
> >   		ch->sess = target_setup_session(&stpg->tpg, tag_num,
> >   						tag_size, TARGET_PROT_NORMAL,
> > @@ -2321,12 +2321,12 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
> >   	mutex_lock(&sport->port_gid_id.mutex);
> >   	list_for_each_entry(stpg, &sport->port_gid_id.tpg_list, entry) {
> > -		if (!IS_ERR_OR_NULL(ch->sess))
> > +		if (ch->sess)
> >   			break;
> >   		ch->sess = target_setup_session(&stpg->tpg, tag_num,
> >   					tag_size, TARGET_PROT_NORMAL, i_port_id,
> >   					ch, NULL);
> > -		if (!IS_ERR_OR_NULL(ch->sess))
> > +		if (ch->sess)
> >   			break;
> >   		/* Retry without leading "0x" */
> >   		ch->sess = target_setup_session(&stpg->tpg, tag_num,
> > @@ -2335,7 +2335,9 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
> >   	}
> >   	mutex_unlock(&sport->port_gid_id.mutex);
> > -	if (IS_ERR_OR_NULL(ch->sess)) {
> > +	if (!ch->sess)
> > +		ch->sess = ERR_PTR(-ENOENT);
> > +	if (IS_ERR(ch->sess)) {
> >   		WARN_ON_ONCE(ch->sess == NULL);
> >   		ret = PTR_ERR(ch->sess);
> >   		ch->sess = NULL;
> > 
> 
> Hi Jason,
> 
> The ib_srpt driver accepts three different formats for the initiator ACL. Up
> to two of the three target_setup_session() calls will fail if the fifth
> argument of target_setup_session() does not use the format of the initiator
> ID in configfs. If the first or the second target_setup_session() call fails
> it is essential that later target_setup_session() calls happen. Hence the
> IS_ERR_OR_NULL(ch->sess) checks in the above loops.

IS_ERR_OR_NULL is an abomination, it should not be used.

I see I didn't quite get it right, but that is still closer to sane,
probably target_setup_session() should return NULL not err_ptr

Jason
