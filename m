Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33ED625C300
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Sep 2020 16:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbgICOmG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Sep 2020 10:42:06 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:37701 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729042AbgICOiQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 3 Sep 2020 10:38:16 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f50ebb90001>; Thu, 03 Sep 2020 21:12:25 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Thu, 03 Sep 2020 06:12:25 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Thu, 03 Sep 2020 06:12:25 -0700
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 3 Sep
 2020 13:12:07 +0000
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.50) by
 HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 3 Sep 2020 13:12:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YiCPdg4FPaOUC32wihKLxY4M0zCM8CLbhO1fGu7xmn/uETgiKUJvnv/K6peJHN1nviR8bygr1n6GvPF1/HZI3Z9QhIUZ6foNyGXRDyrQRmVI4KSWadb6UlrMQbVhjbEZLF/pg+36vmPQJew88GgAUFwdCjmYPSaWC+19mkovwk8BYoIJtlZAk3pYZUBiHI6N20cV6TQRBEqVaKzdNCh6ZqYZqr+8CUSl8+s8PlKKDNyczg2XUlYnxlpl/akm29DvpP22lh/KxcgbFYYXUqlCjJbHWPx59LHduBWo7MfPdyo15PKcSo4PKaFcs976IFZwPYTOps8iUsp4lR0Km5A0CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aA30EZTbKTLaIYrgVyaXwTBQk4z4hYNWTUuTVXN+n7E=;
 b=eUK2tLr9vydr1IEGWgZ9CAGd0oX7jr4LCYm8p34W3oali9//JDW4ENngg3Hqj4Xbi7qbR6X0jg8aoO0Nv6aq8pfsFWbGa7ISP9YqgFn7smgx9saBJYhW9htMmvhoU/cDAegJ/MZ0niPDZzK+rlcq0KXJ4PBeENfuSszL3nF/UM68Z3k3ol/XLxaX9/J0Z5Xkru0s44DxgW1YKUq6KOVkxQomfGAV+bHUd4hurdKA3r20Pv2i4bZ7hUBp6K9ejC1q253RBqBvGUfCe6DnqBnFO96fs4zDEuAalaW4YEiUVi8UfItrFYLwEzx8TFg/hMBZrlM6LAND38sKP2NSNo6F6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4235.namprd12.prod.outlook.com (2603:10b6:5:220::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Thu, 3 Sep
 2020 13:12:04 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3326.025; Thu, 3 Sep 2020
 13:12:03 +0000
Date:   Thu, 3 Sep 2020 10:12:01 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Lijun Ou <oulijun@huawei.com>, <linux-rdma@vger.kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>,
        "Mike Marciniszyn" <mike.marciniszyn@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Weihang Li <liweihang@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <yanjunz@nvidia.com>
Subject: Re: [PATCH rdma-next v1 05/10] RDMA: Restore ability to fail on SRQ
 destroy
Message-ID: <20200903131201.GD1152540@nvidia.com>
References: <20200830084010.102381-1-leon@kernel.org>
 <20200830084010.102381-6-leon@kernel.org>
 <20200903001827.GB1479562@nvidia.com> <20200903052826.GQ59010@unreal>
 <20200903122256.GA1152540@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200903122256.GA1152540@nvidia.com>
X-ClientProxiedBy: BL0PR0102CA0021.prod.exchangelabs.com
 (2603:10b6:207:18::34) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BL0PR0102CA0021.prod.exchangelabs.com (2603:10b6:207:18::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Thu, 3 Sep 2020 13:12:02 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kDp21-006UOZ-KK; Thu, 03 Sep 2020 10:12:01 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5652c645-ffcc-40c6-4a74-08d8500af2fb
X-MS-TrafficTypeDiagnostic: DM6PR12MB4235:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4235643E5014CFE4164BDE5DC22C0@DM6PR12MB4235.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uC56djz+b3F3riYgz46mNzWDmepNfyA0RTfPAQZ6zwRIJXXtQody5rZmWh91lMC7rZ7fdI3Y64GMTicxdt2gLCVxRQQXRvgcxAFj7in8iWt7AYCIWLG7vCFWM+2+QZ3B/0Rt2D54DOtzoTHXRPC13n8iQ+rKFTtPQDZjrZ/b0Qz5Vn7Fr4lFYGD5dBI4PqvzWpiSjwmRtn2zcQfRbtC/SnVdEGW8SZ2hou1TjHt9AVS8M6wiBSRnJ5T+pawLdQBPQmWFXhAEBhsVfPK9fI/ZOI4/0ffmbFnYeoJFclfkdwpxLPLEChLlZ2/5ubuftsVPQiq1Lo7cyJt1g7SXyKqSLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(8676002)(6916009)(26005)(8936002)(9786002)(107886003)(9746002)(186003)(478600001)(66556008)(36756003)(1076003)(66476007)(86362001)(5660300002)(66946007)(4326008)(426003)(7416002)(2616005)(316002)(54906003)(33656002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: sP5YzNA8dwBcxbgn3r4ZiVSWVmy91wTPRenDYrsY3avPHzUrKXbL8K8ucmHoAOYEfpQc/PJ9A42C7C00c4xzXfo+yv5m4ByyRx0so0g4Mx6k5aH9dd2cA5O7bYDODLSnofHVcP/NYZ2uvuPxJ+MJfUK02XQwwppy5VzjcY90P0qrRJN1xTyjg+HaV/aBWyNel/kxMit5sg2DhHsqsHJoktsuw1G1OEWt+HVS/OP1S4WfB5lP8JJqnsBRvOEkDIr8chP1OkQZYLc3xGjBnh4Ymdj0ppRbTADfDCZLB7ePk5wa2cxupqASobz9jkPjWL1BVRQzr4AkX4D6wWSSb4RRClu2n2qEZ6v0whLi90lwlKS93WnfXW0PXXpSynbS87eywntf7/uK3IWU1Q+gOwNpYzSa8ivHE/0iKnFOzfrwBmuxj0GQKYUW1ee8oovmmImwA0KrL2urwMkBdQzXbToy0/iTDDRJxvynYecOpR93XksDrLoXcE42BRTAf6MtvwqpfkxsQt+b/E3L/QVDaM0ZDYSRbNP8zSPuHLU38Ag4MlpTw3GKPY6UzlHNiql4LR5Me9wqLIs/vI7SDEHGViCZQaqMoP8c8zxT6yHrEtRy9gmQaAa35mqqo1Dy2S7qFMb6+80G28yTrsTuPPF6HGJHrg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5652c645-ffcc-40c6-4a74-08d8500af2fb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 13:12:03.4871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nmZH12YQ/ngLe9x4cBJ61V7ybs+vx4YXZJy3buVrwoPTxY1WFUSXkdsi/kfWbNAB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4235
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599138745; bh=aA30EZTbKTLaIYrgVyaXwTBQk4z4hYNWTUuTVXN+n7E=;
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
        b=Cl5oz6vMv4Szast/bJB8v4usxym+dWG/JGxZcK6W/zIa9dko03oY2wN5dryQ11qBf
         cbaKJ8UVNkNycnsqfUvoVq3Nyy/lOoDSt3r1LhxHpcrlbC4Q40MtaYCXqf0Qu5T6jr
         kPAjMS4yI+NiWvbg94ZMfUr5lEwPNkhWC45vYbtCBmuJggwZP9pNuQFqt07V3+apM5
         Xj2CRe/PKoN5B/XCxdkiNoD2khEZ8PhtCmUeqUPtpvexZMgod5HUpIUwTSRslxPDwV
         c29nVTQs2EahzYjcfLYThsp8u/wuFGFg/pyoZseuab0AB5zAVoSaVcWNp+gitY3BGO
         jDwFqsZmEHjSQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 03, 2020 at 09:22:56AM -0300, Jason Gunthorpe wrote:
> On Thu, Sep 03, 2020 at 08:28:26AM +0300, Leon Romanovsky wrote:
> > On Wed, Sep 02, 2020 at 09:18:27PM -0300, Jason Gunthorpe wrote:
> > > On Sun, Aug 30, 2020 at 11:40:05AM +0300, Leon Romanovsky wrote:
> > >
> > > > -void mlx5_ib_destroy_srq(struct ib_srq *srq, struct ib_udata *udata)
> > > > +int mlx5_ib_destroy_srq(struct ib_srq *srq, struct ib_udata *udata)
> > > >  {
> > > >  	struct mlx5_ib_dev *dev = to_mdev(srq->device);
> > > >  	struct mlx5_ib_srq *msrq = to_msrq(srq);
> > > > +	int ret;
> > > > +
> > > > +	ret = mlx5_cmd_destroy_srq(dev, &msrq->msrq);
> > > > +	if (ret && udata)
> > > > +		return ret;
> > > >
> > > > -	mlx5_cmd_destroy_srq(dev, &msrq->msrq);
> > > > -
> > > > -	if (srq->uobject) {
> > > > -		mlx5_ib_db_unmap_user(
> > > > -			rdma_udata_to_drv_context(
> > > > -				udata,
> > > > -				struct mlx5_ib_ucontext,
> > > > -				ibucontext),
> > > > -			&msrq->db);
> > > > -		ib_umem_release(msrq->umem);
> > > > -	} else {
> > > > -		destroy_srq_kernel(dev, msrq);
> > > > +	if (udata) {
> > > > +		destroy_srq_user(srq->pd, msrq, udata);
> > > > +		return 0;
> > > >  	}
> > > > +
> > > > +	/* We are cleaning kernel resources anyway */
> > > > +	destroy_srq_kernel(dev, msrq);
> > >
> > > Oh, and this isn't right.. If we are going to leak things then we have
> > > to leak anything exposed for DMA as well, eg the fragbuf under the SRQ
> > > has to be leaked.
> > 
> > We are leaking for ULPs only, from their perspective everything was
> > released and WARN_ON() will be the sign of the problem.
> 
> If we are going to add back in error handling, then it needs to be
> done right, there is no different between kernel and user, everything
> should be leaked.
> 
> > > If the HW can't guarentee it stopped doing DMA then we can't return
> > > memory under potentially active DMA back to the system.
> > 
> > ULPs are supposed to guarantee that all operations stopped.
> 
> ULP should never trigger this, only broken HW can cause this kind of
> problem.
> 
> > I don't know, all those years we relied on the ULPs to do destroy
> > properly and it worked well. I didn't hear any complain from the field
> > that HW destroy failed in proper ULP flow.
> > 
> > It looks to me over-engineering.
> 
> Given mlx5 already has the fatal error handling it seems a reasonable
> way to re-introduce the error code without just delcaring drivers are
> buggy to use it..

That said, it doesn't have to be done in this series, however lets
just keep the basic principle that if destroy fails then the HW object
remains untouched and fully operational. None of this partial destroy
only if in kernel mode stuff.

Jason
