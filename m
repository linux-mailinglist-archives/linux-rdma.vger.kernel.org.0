Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78795261706
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Sep 2020 19:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731772AbgIHRXv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Sep 2020 13:23:51 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:3456 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731763AbgIHRVf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Sep 2020 13:21:35 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f57bd690000>; Tue, 08 Sep 2020 10:20:41 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 08 Sep 2020 10:21:31 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 08 Sep 2020 10:21:31 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 8 Sep
 2020 17:21:18 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 8 Sep 2020 17:21:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7mRZQPUrYusJl2K3uT9XeHHxZH2UtTX4ZL2ZYqCTWQSQQiCkUfp27r3oL1rtAwqfsSn2nCaC/HfxfFMqUe0z86ZO+soNY7fb/myFD2F7slEMUkiEYANNIK4aWU92K2m7NSZh5N/pcGQt5tPHEXfIttY+X5f8OubNHBqG2nfLeAiRuGElJvbx+s++e1awL1hBkjxw9urZu0BrNeA61XyyJZX+MZDiHRxbnnp6pfFanj0DFooniPQdjbtiXML6qN8MXGlt+cIfcBkYRIF/TVeI5iNYV+frWZHV4pww8x2RTpe74MIQ2ad8FJYlmwzK1p7uJrAlSSGa1qXYZLvtO5AaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDnvhk+AVhxjy/Pj60+Xoso//ytzwvLCcZGUl3pZKfY=;
 b=mkDy15oHp3Fk0iIWC1AFF6eSla7FitQR52xu+heSJaP1rM1uhAtPCpvWzWsedfPMQ8YfnXXy6O6Pyes+5EZj0KjjXW6jxDr+rUNt003kLtu/4sI8hb4eVFORPxy89pELKIu5UfIgiwBTpjwh4xZqWJNSdP4UhuThrN6RwGQiYcnizFMYooEZ3EU0iDvn+X8pGsmrTKUopPCN0OzwNqHLI4lBPdFoKedH7tZbIoFFio4lszQFBWiEyf93d9c+jtypabIZP3t/ORRGdgeVZ2dNI0yzQsSP8jdiOCg9Wzj/K1aNICuoDtP1hMWny0RojA/iSefTtEcCXEcf4yzHPMtQDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BY5PR12MB3746.namprd12.prod.outlook.com (2603:10b6:a03:1a7::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Tue, 8 Sep
 2020 17:21:17 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::445b:111e:a091:66f9]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::445b:111e:a091:66f9%6]) with mapi id 15.20.3348.019; Tue, 8 Sep 2020
 17:21:17 +0000
Date:   Tue, 8 Sep 2020 14:21:14 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Aharon Landau <aharonl@mellanox.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        "Dennis Dalessandro" <dennis.dalessandro@intel.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        <linux-rdma@vger.kernel.org>,
        Michael Guralnik <michaelgur@nvidia.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        "Mike Marciniszyn" <mike.marciniszyn@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>
Subject: Re: [PATCH rdma-next v1 3/3] RDMA: Fix link active_speed size
Message-ID: <20200908172114.GN9166@nvidia.com>
References: <20200902074503.743310-1-leon@kernel.org>
 <20200902074503.743310-4-leon@kernel.org> <20200908141924.GG9166@nvidia.com>
 <20200908142651.GE421756@unreal> <20200908142756.GH9166@nvidia.com>
 <20200908144205.GF421756@unreal> <20200908144646.GJ9166@nvidia.com>
 <20200908150427.GG421756@unreal>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200908150427.GG421756@unreal>
X-ClientProxiedBy: BL0PR0102CA0066.prod.exchangelabs.com
 (2603:10b6:208:25::43) To BY5PR12MB3827.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR0102CA0066.prod.exchangelabs.com (2603:10b6:208:25::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Tue, 8 Sep 2020 17:21:16 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kFhIw-0033RX-Sl; Tue, 08 Sep 2020 14:21:14 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ffe0d34e-9680-46e0-f89b-08d8541b9833
X-MS-TrafficTypeDiagnostic: BY5PR12MB3746:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB3746B292D90489D1A7E05811C2290@BY5PR12MB3746.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I40ahoeDMMebU50pU60MVRxzOG+5rq45qtZR2AGr2rVN8uieRAjWZfLXrWqoWqdvi70WT4LGj/8zXNNb6PzjNz7Y9Djoflq4B8Y7a1xxI04z5KZtQfN1sfaDlFaVVXuiEiU6XEE61gTSZ2cxj1/wksyF0sHKlYa0jj7njTDzk+bWbp+1qjHrHGWqUgJpmamWcmyBcaPkfewChDxdJf9u7J9q3DzQ94BD9HWK+hc1mQPNTwpQVqfnJ8Bet5izPl5z3L4BwjFmy9bmqPayeVy/T4+aoE3gT6X2PBfTuQT77Dd9Eata5gmp3pskf6UQsD1V
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(376002)(136003)(39860400002)(396003)(33656002)(83380400001)(426003)(86362001)(2616005)(1076003)(66556008)(66476007)(5660300002)(66946007)(478600001)(7416002)(6916009)(186003)(316002)(26005)(2906002)(9786002)(8936002)(54906003)(36756003)(4326008)(9746002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: aURhZxMVyRBloMTLRz1JUpTRtPmBDkI8p84pShtMEa2OMwnyCmRUqSSf5HRlFi84YWDUz+q8p5p6WLgoMgaJA1KJqpSwzN72ku4RVSuap53V2qRtuf8H5Gi7Cq64EJ8Qlxv6zFujelzLeJNqOAnBa3rE9B/nWGdksoronHOVaEjPqtDrUDaN+0p5igzVKNHJzD0HL44gNcocQO2gGGjLTvWqQ798gQQPGgphhgNKjoJuaYvS8dCVyBUwjz+iF6V23OwzVJDK4tNxSE8yezlzdhI/6jACAv2wzr/EEMEyMK/mOPHcjAgdAq8AdQyrNLv9heK7DNXoJEmOS/ixXwAHsZhFjel9o7S60S7LF3f1FwuTkq9/IvbQp+f9Lkk8zgBUsnrpVZTzcEJM+R6coWZU52+0u+yWZXdo1Gs6ywKgG2zvya26cfScf+sQDMVUbcmYLLCrR2InMj43AZ1Njrt2ZbwbBxarnzy84pjaVRnS5XHt15zzTtJ3HWKqfOvA5kaD/MbFo6XZhlnmFY3lnM+KW+yskrZe6GaUcLx8gGoelr8f7XBTAkZkWxhKEWeRAcNG+B5Oz7eIYkNWGWBq5OVt1WOxYK+hkXQwFkpr1sAJvr4uZKVs630FiyELo71XSO2umyOA8BPjCQzF7nzybJM5cw==
X-MS-Exchange-CrossTenant-Network-Message-Id: ffe0d34e-9680-46e0-f89b-08d8541b9833
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2020 17:21:17.0956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 85aGe8dLQAZelVMr2of5cdS9zrelNTJB2EWLvwlb0+MHkQQjoPyVu6DC4dg/y7v6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3746
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599585641; bh=dDnvhk+AVhxjy/Pj60+Xoso//ytzwvLCcZGUl3pZKfY=;
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
        b=MwyxL9Ab9yQqMsY93wsF68Hfcp/tANUnha97RtaBoevwOkpSwcLj9PyXvxe+ah+C5
         xNpTdCmWKWA/TQQh5t1SJzcXTA0/HMejF4GJDfkJS13fJcsabePM/XZ5sXcxDXCMvp
         5cLvFZYOjKNzLb5uBTe2X0Tf/6cS6DFLCXBe4wflxQmBBEaCaWWCvgLr2csxUZA9WY
         Mx+KoVvR+ZV/MQWBo1NKKgGl3LylhCe+WL9y6WNAkhPLpbVri2PLAzudEG396Fm5Ma
         nIlt3poARNUA4S19JDnf+DnvgcFU8LfQ7BL++y9RsfX5oL1+TZCe1/PYzEioqNpfKK
         xnXSZ8ZAe+Sxg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 08, 2020 at 06:04:27PM +0300, Leon Romanovsky wrote:
> On Tue, Sep 08, 2020 at 11:46:46AM -0300, Jason Gunthorpe wrote:
> > On Tue, Sep 08, 2020 at 05:42:05PM +0300, Leon Romanovsky wrote:
> > > On Tue, Sep 08, 2020 at 11:27:56AM -0300, Jason Gunthorpe wrote:
> > > > On Tue, Sep 08, 2020 at 05:26:51PM +0300, Leon Romanovsky wrote:
> > > > > On Tue, Sep 08, 2020 at 11:19:24AM -0300, Jason Gunthorpe wrote:
> > > > > > On Wed, Sep 02, 2020 at 10:45:03AM +0300, Leon Romanovsky wrote:
> > > > > > > From: Aharon Landau <aharonl@mellanox.com>
> > > > > > >
> > > > > > > According to the IB spec active_speed size should be u16 and not u8 as
> > > > > > > before. Changing it to allow further extensions in offered speeds.
> > > > > > >
> > > > > > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > > > > > Signed-off-by: Aharon Landau <aharonl@mellanox.com>
> > > > > > > Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
> > > > > > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > > > > >  drivers/infiniband/core/uverbs_std_types_device.c | 3 ++-
> > > > > > >  drivers/infiniband/core/verbs.c                   | 2 +-
> > > > > > >  drivers/infiniband/hw/bnxt_re/bnxt_re.h           | 2 +-
> > > > > > >  drivers/infiniband/hw/hfi1/verbs.c                | 2 +-
> > > > > > >  drivers/infiniband/hw/mlx5/main.c                 | 8 ++------
> > > > > > >  drivers/infiniband/hw/ocrdma/ocrdma_verbs.c       | 2 +-
> > > > > > >  drivers/infiniband/hw/qedr/verbs.c                | 2 +-
> > > > > > >  drivers/infiniband/hw/qib/qib.h                   | 6 +++---
> > > > > > >  drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h   | 2 +-
> > > > > > >  include/rdma/ib_verbs.h                           | 4 ++--
> > > > > > >  10 files changed, 15 insertions(+), 18 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/infiniband/core/uverbs_std_types_device.c b/drivers/infiniband/core/uverbs_std_types_device.c
> > > > > > > index 75df2094a010..7b03446b6936 100644
> > > > > > > +++ b/drivers/infiniband/core/uverbs_std_types_device.c
> > > > > > > @@ -165,7 +165,8 @@ void copy_port_attr_to_resp(struct ib_port_attr *attr,
> > > > > > >  	resp->subnet_timeout = attr->subnet_timeout;
> > > > > > >  	resp->init_type_reply = attr->init_type_reply;
> > > > > > >  	resp->active_width = attr->active_width;
> > > > > > > -	resp->active_speed = attr->active_speed;
> > > > > > > +	WARN_ON(attr->active_speed & ~0xFF);
> > > > > >
> > > > > > ?? This doesn't seem like a warn on situation..
> > > > >
> > > > > Why? We are returning u8 to the user, so need to catch overflow.
> > > >
> > > > We need to have actual backwards compat here, not just throw a warning
> > > > at the syscall boundary
> > >
> > > We don't have fallback and don't have speed that crosses u8 limit yet.
> > > This WARN_ON() is needed to ensure that we properly extend
> > > ib_port_speed.
> >
> > Until we have some compat story I don't want to just increase this
> > value, it clearly renders the device unusable, so why do it?
> 
> Because IBTA port speed extension was already approved, it is just
> not published yet.

So there should be a compat story. It can't just WARN_ON here.

The u8 active_speed should saturate at the highest speed we can
represent in the u8, and this will have to be updated somehow to pass
the u16 version.

Jason
