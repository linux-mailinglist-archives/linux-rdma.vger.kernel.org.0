Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C743A3680DA
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Apr 2021 14:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbhDVMwN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Apr 2021 08:52:13 -0400
Received: from mail-bn7nam10on2061.outbound.protection.outlook.com ([40.107.92.61]:64640
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230005AbhDVMwM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 22 Apr 2021 08:52:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hx4J8PF/kYM/5Wnfp3nMG87mGQivIDeJsMiwRlu2sy83STqawaCDNhKz8+UQp1RYORqCWsQziWPlS7G6SFrvNFkZ67xirgWpdjnKBAgbtgDqkb/Dkto0+xySSXhq6ifvOwbOGikQDBDsXzh0q8ysDWOKJmNJhpulhnH6TLrl9R35++Ml7Xiw2uhw2rR2ON+F84+gVJyLhmh9XFQzax55sNuPVZ9y79qXDqf/Z/gsyulKxTEGCD8JrnhYRVSkTQ5JbbcRSwOCb4jOGHcB/XG/Zp9xPAtLO38psZnDmRGErBcuDmXkKyoYkvJ6jquXROc+eho9mFnsS9rQQgxiHifOqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJMhLdMbyfsf8bfUO1jzHBLQfJ2L+0+Gflpj+HCsQX0=;
 b=kvIbe/bquteL8jIExa7a387w/6YXBoNAzys3u/j1qleFlhBUDAXufm+J1E7BBL50GJTXjMUwJXixrxqRJmqWlXrdlqrnoBysaxSTYlVUwhUbY6SS7QLEQA/EBXxxRFxcrvdFLkA0HTARGuXOoBS4zvXw6BTZkspPjm7ugFds5iCceUHAnDbrhlSMPnEzVmcLM8GeE+dlKM+knsMg6zJAjHixNpVtIvyFfdQnFuYunFEwgX2u6uizj1sOTrFTCzW3VEU70BZ24FFYPDf2koDXZCSYxSN9HECxcRaEyzGvGrl71BqC7vZ2tHJRTL6VmjnfBxNDXm8rrXJf4HRgGQMwtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJMhLdMbyfsf8bfUO1jzHBLQfJ2L+0+Gflpj+HCsQX0=;
 b=TrFFrDma0zTuOekQsCcXYUZFf5qu+EOzhzucIcJHOl+9OiIulnwyqqorhMC6fKE/LcYCan1XHyfkl/all4cOZVb5Iex5YFWuPf4s36XJPVwRFBm5aCRJWtoXUzhYYBm3rSCIDkqyl+nS5Y67/xYs4AJWGblDqEfYFcZZWdmcuQ/1JZl18QJEUNbOE4I3ZROViy9bDQwnGgen/FTytOC0d1XSHASYXAKqhTHb9UY4zcwxbaPM56mq8P3quG4OFnSAs3zWW+QQcRH7QvEDruVuY+bh8Al5pljEHBH8IifCQOx1NLRKwhUi2eUfmtOxBJ5y8C+UGpDfCsxzKx0C/8rvWQ==
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Thu, 22 Apr
 2021 12:51:37 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4065.023; Thu, 22 Apr 2021
 12:51:36 +0000
Date:   Thu, 22 Apr 2021 09:51:35 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Shay Drory <shayd@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Krishna Kumar <krkumar2@in.ibm.com>,
        linux-rdma@vger.kernel.org, Sean Hefty <sean.hefty@intel.com>
Subject: Re: [PATCH rdma-next 2/3] RDMA/core: Fix check of device in
 rdma_listen()
Message-ID: <20210422125135.GV1370958@nvidia.com>
References: <cover.1618753862.git.leonro@nvidia.com>
 <b925e11d639726afbaaeea5aeaa58572b3aacf8e.1618753862.git.leonro@nvidia.com>
 <20210422112802.GA2320845@nvidia.com>
 <1fca1133-8cdd-8b21-42cf-69d610b4f8f4@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fca1133-8cdd-8b21-42cf-69d610b4f8f4@nvidia.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR01CA0043.prod.exchangelabs.com (2603:10b6:208:23f::12)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR01CA0043.prod.exchangelabs.com (2603:10b6:208:23f::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22 via Frontend Transport; Thu, 22 Apr 2021 12:51:36 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lZYnv-009xju-E7; Thu, 22 Apr 2021 09:51:35 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0f83dbc-eabb-458c-97e4-08d9058d5d7b
X-MS-TrafficTypeDiagnostic: DM5PR12MB1753:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB175302B48F6C8477EE962657C2469@DM5PR12MB1753.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cnaLz5PzApKKTKHAxQNX82HNz4K83jzGZP4vm0K8GZ1fy4sztizawmmh9tiJUoclpTomoQzMR0usjEaOEvCZx1X72UYFFychR6knZmcfnMEurn8hzmZYMfdOjsSSGYJECntzRskMTFd165mPuU/GNBfUdtaf3RE8UpF7/mvLjAAZ44yBt084ba9w65PpBQleWE3BGfSu9fjm1NdtrGR6+RdH0lV3e+zb9kdT5HdmUqC6JPCDez0egAPIABY0naWePMADinb3BfxY9KjzkDj+jth5Tb82xRb/iqh8/KR52LNN5PyBwh45n0NQ36glSPcm+8/4xropwrudqhHXGoldJ5LMTE11N0aScxHPWDXjgGj4/Bp0sskkypBQ5DZi1VoCnel3z537ZzyjVv/TrfSrc4PFAecZeGvSteyjR6UgL/hyNj4CB2HBwzqCLTiqqBI0tpYn686ScswLjuC6d4gIh2vwxTVstfuKMj9FXzDmYsa6qu6hnIT9XT8eR3X3KvTkZplK1VR0cIWCxPeI/iyBOMnKOpN7Hwxq0Qmd9bOjjygis5yubjLjUaAb5aZ31kAeEc/7uzXxq3d2uJrMU003BGW89iEwx8J5oAnY5VwRnQI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(136003)(346002)(39860400002)(5660300002)(1076003)(66946007)(6862004)(53546011)(186003)(66476007)(54906003)(36756003)(33656002)(8936002)(426003)(9746002)(26005)(9786002)(2616005)(2906002)(316002)(66556008)(6636002)(37006003)(38100700002)(478600001)(83380400001)(8676002)(4326008)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?lCrmEnlviSCrhBCjVadkJZzojYqH+H8uSauk/fwLXC01zBwtyLuAMZLRPyBg?=
 =?us-ascii?Q?4/AHSeIdEnZBU17DS5jnQvSberuZtBLiw7DZb6H2WSU9P07QrTs6n9ZjjC5c?=
 =?us-ascii?Q?+P5XTp8JOhhRLHiiLvenZ1sggfYWmI43TpRXlgvrWmVAnLVLKdeipGZieUF7?=
 =?us-ascii?Q?GapzDlKNzjUeCx7iy30kmQAVRfGcE3/EcLF70azGCtINiK2aoOLRKaJNCiGS?=
 =?us-ascii?Q?IEHpQLDIemiWRCGTgYYB6lNf8WmV1fwUPWOqpegDJNJLz8FkEuuFT4c/N26c?=
 =?us-ascii?Q?x/3m3HjVhBPcOSI1+OxDMNtUPV08gFPE22YbX0v4ayDaAE95CE4+FKFnoRRB?=
 =?us-ascii?Q?7xJimfXASPDwgy3X5EOz1STaWRheoQ8en3db1bhTpHhVoCjbDC3k6SOYZoSF?=
 =?us-ascii?Q?+zVUI/TW9feU34YJTwuOAjtJiUnwN1EAnTlzwKgEMIoSgDX4lTYPmV06o+XI?=
 =?us-ascii?Q?wC+kPAK2qMru8uHiC1okn0hXdUZW2Azc0oX7J4P7jbiRaxE0xaTb6j+hmGU5?=
 =?us-ascii?Q?0Pg8Ryr6S3od/SJQlbi8Y4/IXlHgGODUQp0qL3gdwDib7K31BTG7lUuCYtYP?=
 =?us-ascii?Q?p339ULBoHGsSfyRwLSXljQTdJYXGRCpEu4JHfI5YwfRth6fyilckTuLCJYfp?=
 =?us-ascii?Q?xEqrVAdxgMBwTNzm9iTaRvFbchhqJGuhwfk4lMn4/IJoqZCQ158gJGJyzQxR?=
 =?us-ascii?Q?ALvM5/ywC5lu+wwrAYBi8fAMZ8IhDOUH0ZLImr8zQ4Gc0NZQSuFtKom4tHVv?=
 =?us-ascii?Q?eM00PHfinWBMt/BkcciPM7jOQdHVuJPwhJfcmQAsBumhDWNuVu6L+uxwl6Ci?=
 =?us-ascii?Q?RFZgMdXuMXOMJLaDkVr38rx/cvfcG7vtYIfW997bmSO+/mbDtKdQW6pASJkf?=
 =?us-ascii?Q?wc7vpZXqkIqPYKTgW3D0lMRwswvJ4dKyAOqA3dnqhoQqNyrRG5kEyBkaVx+r?=
 =?us-ascii?Q?W6gZo1TvGunc4MfPCt/6UkjK0PkrD8tzgcYpUwsepfxUYLDmJySkZkOepzzU?=
 =?us-ascii?Q?R/rBnOuByg2s4m3x4yAZ8kOOU4BCuDLimkq7RX5Vb1d5cHxszBBuegxVkyjx?=
 =?us-ascii?Q?EFMxYQDoO0EycvOY3OnaB+c/mg+h0PTQEcvLiFKsEFg+jND9CEibQOk0qPsY?=
 =?us-ascii?Q?Vf5K+77rpcg4U0+Y6ofOkh8NA07IoZLt+iZ8K/6Tp1ri4HnbYWbNaesCoNBk?=
 =?us-ascii?Q?fYqPmF01+kNESly8qFRUhs1wDMu1R+s+LOCVZUOhe1/PNDTZlTWUr5e/AXJg?=
 =?us-ascii?Q?VAd7ig33228m5d0KtJV6+VJyi8kzuDkx9CKo+q5HaxZ55TXQaIzCoc6qYdyi?=
 =?us-ascii?Q?dVwBXUi8o/hoSS89aqmKZgM0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0f83dbc-eabb-458c-97e4-08d9058d5d7b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 12:51:36.8583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jSEetYxa1muocKHHtuORLI9NVD6NelcGe2W5md/0kSgJEnB/K3oFz8ft8fS1S6AK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1753
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 22, 2021 at 03:44:55PM +0300, Shay Drory wrote:
> On 4/22/2021 14:28, Jason Gunthorpe wrote:
> 
> > On Sun, Apr 18, 2021 at 04:55:53PM +0300, Leon Romanovsky wrote:
> > > From: Shay Drory <shayd@nvidia.com>
> > > 
> > > rdma_listen() checks if device already attached to rdma_id_priv,
> > > based on the response the its decide to what to listen, however
> > > this is different when the listeners are canceled.
> > > 
> > > This leads to a mismatch between rdma_listen() and cma_cancel_operation(),
> > > and causes to bellow wild-memory-access. Fix it by aligning rdma_listen()
> > > according to the cma_cancel_operation().
> > So this is happening because the error unwind in rdma_bind_addr() is
> > taking the exit path and calling cma_release_dev()?
> > 
> > This allows rdma_listen() to be called with a bogus device pointer
> > which precipitates this UAF during destroy.
> > 
> > However, I think rdma_bind_addr() should not allow the bogus device
> > pointer to leak out at all, since the ULP could see it. It really is
> > invalid to have it present no matter what.
> > 
> > This would make cma_release_dev() and _cma_attach_to_dev()
> > symmetrical - what do you think?
> > 
> > diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> > index 2dc302a83014ae..91f6d968b46f65 100644
> > +++ b/drivers/infiniband/core/cma.c
> > @@ -474,6 +474,7 @@ static void cma_release_dev(struct rdma_id_private *id_priv)
> >   	list_del(&id_priv->list);
> >   	cma_dev_put(id_priv->cma_dev);
> >   	id_priv->cma_dev = NULL;
> > +	id_priv->id.device = NULL;
> >   	if (id_priv->id.route.addr.dev_addr.sgid_attr) {
> >   		rdma_put_gid_attr(id_priv->id.route.addr.dev_addr.sgid_attr);
> >   		id_priv->id.route.addr.dev_addr.sgid_attr = NULL;
> 
> I try that. this will break restrack_del() since restrack_del() is
> using id_priv->id.device and is being called before restrack_del():

Oh that is another bug, once cma_release_dev() is called there is no
refcount protecting the id.device and any access to it is invalid.

The order of rdma_restrack_del should be moved to be ahead of the
cma_release_dev, and we also can't have a restrack without a cma_dev
in the first place

Jason
