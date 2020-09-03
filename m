Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C752325C0F2
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Sep 2020 14:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbgICMYM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Sep 2020 08:24:12 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:18346 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728762AbgICMX5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Sep 2020 08:23:57 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f50e0270000>; Thu, 03 Sep 2020 05:23:03 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 03 Sep 2020 05:23:17 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 03 Sep 2020 05:23:17 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 3 Sep
 2020 12:23:00 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 3 Sep 2020 12:23:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+qznbU8bHH7mEe45zibcKngSDSpCwgJ20xLPwz9apNd7CoozTLDIsF+FAn0MzR4X85RjkKLA991R79QbSsXPp5qQcuohiEymtKv7x0JXQ8rNdnazOrmF+wEv9KVf9rRphZfsyPrjfUMAfHGH8SglZKl6+oAe8QGtedu94jLPZVkgJ1AUxvv54XZGrIB15/r48ZFQ5a/tmJ4oByo9Hlg4RQROgbx6TBcpMfyloKYiTxljrs8HscEvn9TWWD4oI29NGGvECPNczVXGXBOXTpreqURmhCqe/7DI/ikeSgIc+yAqMyIWPf9aGEvLrJOcVgl0N6f6IXiOJQE4+RRV02oIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6pdMd7y6NBKbYxjjRWIGPxVbHeabEoxB8q4r61mh60=;
 b=n5uKt5gdm4VUo17wUf7SylkVkbzeviEB+9ZbaDnjUFZd0yAcgZao70cW65KwthEXmMwxBAxIPXVuNIJgqulWbn6RVlxUBndd3eMvvzVNbMeIQgeLnAwGtQz5hiSEx5PEYycGNOQ6Ja4A6fK6VEsnfhUhuBLOS3HMXlv7sXSjopyP6YyrN1iVeknzohCD2fzlRbtS0PDxWqB+EyT6cyw+IHY0tznS5us+7IB7/Vfn5dyRo9YKgBpseDMBX0nf14kGtiOgYDzUZqtATEb17F014UXLmQRqxh6Q2pSjJjryfWvhhywLDCBeJMObXHnkK57yX49iBo21rEq1JgfRRDQEQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2485.namprd12.prod.outlook.com (2603:10b6:4:bb::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Thu, 3 Sep
 2020 12:22:58 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3326.025; Thu, 3 Sep 2020
 12:22:58 +0000
Date:   Thu, 3 Sep 2020 09:22:56 -0300
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
Message-ID: <20200903122256.GA1152540@nvidia.com>
References: <20200830084010.102381-1-leon@kernel.org>
 <20200830084010.102381-6-leon@kernel.org>
 <20200903001827.GB1479562@nvidia.com> <20200903052826.GQ59010@unreal>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200903052826.GQ59010@unreal>
X-ClientProxiedBy: BL1PR13CA0029.namprd13.prod.outlook.com
 (2603:10b6:208:256::34) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BL1PR13CA0029.namprd13.prod.outlook.com (2603:10b6:208:256::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.12 via Frontend Transport; Thu, 3 Sep 2020 12:22:57 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kDoGW-006RfS-9j; Thu, 03 Sep 2020 09:22:56 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bad83f49-f1fb-4922-377a-08d850041777
X-MS-TrafficTypeDiagnostic: DM5PR12MB2485:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB24857F5D100F99CF341916A1C22C0@DM5PR12MB2485.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MfKXtqGXBhqUw6MBKJZe6uPEf8WtJapWVUjUf/9luL+1HYCLr2k1p0GDzob4xmF/N5CALYCLAYVD/ESICL+zXaw3PDQ/YK8b0ZhDQ5BPzck5Cwye1svB+P6ECYYOIIxrTkHtMxVa+qSjMnGtEQszTn4AiHca9bsb8anYPtNTLFSIo2a2wCax6E1X4Kr3UCPI7lDgBUKEyUUidsgxVFBt+cptjtmPWqGyiTU676nRR/PKiQ/CwB8nLLN5HQFNtuLqpkiEE2VaNDVIRxWYgz2HrqgxuJfoyKK2aaQWgKC/fMyBlY2WgvI+8cvboea2uNA/kK8Lq0MMhPVmYdkQGZhZ+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(316002)(33656002)(9746002)(9786002)(7416002)(2616005)(426003)(86362001)(6916009)(54906003)(5660300002)(36756003)(8936002)(478600001)(66946007)(186003)(8676002)(107886003)(2906002)(1076003)(66556008)(66476007)(26005)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ew3pGMuP1Pl5VPSGisLv0FUYcEywJv3cpm3txPXtp9rU9lQPpJDsZ6m52z9qRsg4KDAWkLwuclXi+lE6FyNl0RD+8dmgWO0D43e27MaCNuT27kmM+dNTh0Wdix5lbSGxY8FuAJzkYclBq1Ma0hW1AZH2phBHgB+uYDFBAiziMjekTsAHGhUbaEQ/wWnYDOfbjZnkbsWAXLJzNOv041MJoW5eWpHuOR/I4cwAe+xedgdH7F0e67kNBzbnr+igyV52QmDK+0UCkuys8mD38hk+bznduePd4qsP+Qu7Sv/gmfdHbb3bQPodHGW5CnEkdj9Gl6s4DOGoObOj3tkZKuGONwp93lb027rJgFbtWC6D0kEJ8ZrY4/NFl5iByw34CB3j81MkO49T7f700tU8JBPLQQQ2Pbw76s3yuRhr50pr0bF1D7fItxllNE14eU6M0N+UA06yZEb3rb0zskOP3+9IpYHO7OkfQRaCB+40WH2rukcfuxj61x8zpYSa9wH6y7elf13plN9XyI/wzaGpvArfGB2PuEWAFEAD/bFQ3DjXrRAaOeLYwpqP3lEjGBHytYOHefBk/iOTIwh7994srqlWIsZIL76j+ZWHbwj6NhPO8sq/PmyM0wUgF8Y3KO6TZDmq/bFcdtDhGaK0T9ZRajew2g==
X-MS-Exchange-CrossTenant-Network-Message-Id: bad83f49-f1fb-4922-377a-08d850041777
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 12:22:58.4870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Icfd+qWb+xwF3KkdfH+Jil1aCASwr2GrxZD/GSJyOYfF2OEvY3LKpKKEyq5hUi+I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2485
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599135783; bh=V6pdMd7y6NBKbYxjjRWIGPxVbHeabEoxB8q4r61mh60=;
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
        b=JtjMcBEZFen+h1atR5NpNOfk89Bv0mXwmQ7+8f4jxuJ7/M6KS3n/Tb9dpvT9f3TnF
         kr7NyeuueyeqV8ngyRlhfjes1O3+fEPVf8ALIW0m4rT1vFmyZs77HuRBKx2vs4iS00
         RIVni5GE20Cny2vZBx0G7b2FiAQYjwaXucFplzYjOh/LVRHphUgvebICDH9jBFB1z8
         QuaWLkj+ahf2zjcVOHDHeaFrbNjqhoJGT78IjRW4H0d615398n3KXjI8K0x19a6HEc
         t9wrrOhtMd5VT2u2Zd0idgplhjhxVy5egjYyodRvV09MWQSR+DzChl9CSESX+Gctda
         SgKQfWZsAF/cQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 03, 2020 at 08:28:26AM +0300, Leon Romanovsky wrote:
> On Wed, Sep 02, 2020 at 09:18:27PM -0300, Jason Gunthorpe wrote:
> > On Sun, Aug 30, 2020 at 11:40:05AM +0300, Leon Romanovsky wrote:
> >
> > > -void mlx5_ib_destroy_srq(struct ib_srq *srq, struct ib_udata *udata)
> > > +int mlx5_ib_destroy_srq(struct ib_srq *srq, struct ib_udata *udata)
> > >  {
> > >  	struct mlx5_ib_dev *dev = to_mdev(srq->device);
> > >  	struct mlx5_ib_srq *msrq = to_msrq(srq);
> > > +	int ret;
> > > +
> > > +	ret = mlx5_cmd_destroy_srq(dev, &msrq->msrq);
> > > +	if (ret && udata)
> > > +		return ret;
> > >
> > > -	mlx5_cmd_destroy_srq(dev, &msrq->msrq);
> > > -
> > > -	if (srq->uobject) {
> > > -		mlx5_ib_db_unmap_user(
> > > -			rdma_udata_to_drv_context(
> > > -				udata,
> > > -				struct mlx5_ib_ucontext,
> > > -				ibucontext),
> > > -			&msrq->db);
> > > -		ib_umem_release(msrq->umem);
> > > -	} else {
> > > -		destroy_srq_kernel(dev, msrq);
> > > +	if (udata) {
> > > +		destroy_srq_user(srq->pd, msrq, udata);
> > > +		return 0;
> > >  	}
> > > +
> > > +	/* We are cleaning kernel resources anyway */
> > > +	destroy_srq_kernel(dev, msrq);
> >
> > Oh, and this isn't right.. If we are going to leak things then we have
> > to leak anything exposed for DMA as well, eg the fragbuf under the SRQ
> > has to be leaked.
> 
> We are leaking for ULPs only, from their perspective everything was
> released and WARN_ON() will be the sign of the problem.

If we are going to add back in error handling, then it needs to be
done right, there is no different between kernel and user, everything
should be leaked.

> > If the HW can't guarentee it stopped doing DMA then we can't return
> > memory under potentially active DMA back to the system.
> 
> ULPs are supposed to guarantee that all operations stopped.

ULP should never trigger this, only broken HW can cause this kind of
problem.

> I don't know, all those years we relied on the ULPs to do destroy
> properly and it worked well. I didn't hear any complain from the field
> that HW destroy failed in proper ULP flow.
> 
> It looks to me over-engineering.

Given mlx5 already has the fatal error handling it seems a reasonable
way to re-introduce the error code without just delcaring drivers are
buggy to use it..

Jason
