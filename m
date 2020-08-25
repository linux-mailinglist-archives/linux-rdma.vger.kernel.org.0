Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBF2F25180E
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Aug 2020 13:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbgHYLxQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Aug 2020 07:53:16 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:35205 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbgHYLxP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 25 Aug 2020 07:53:15 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f44fba50000>; Tue, 25 Aug 2020 19:53:09 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Tue, 25 Aug 2020 04:53:09 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Tue, 25 Aug 2020 04:53:09 -0700
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 25 Aug
 2020 11:52:50 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 25 Aug 2020 11:52:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQ+kZXbn2FSLrgtDDjT1uyfW9VLTJ36bFOUqiIcR428QRaTf/8VdRnB8T3Jne06K+LzSjWdEiZSJOgnd5Z+2Xswh0fwmQJIHK2N/aYmldctbZ0k0lzxR3/oPNQCW676JDfZeVDr0B4wxmFJAQKQybLhB8ScAQ7ojLYgFzvkqCPUqmZSqRiduxjp/4eCKP7OVEhgi1r4hquzDFDhTjMQU7J7kRxKIkssnwg1DiHNMFX1Td4n9hz3z6Qp6sdMGFFFgCPNE4semkJ+Zph5ZGE+d+a9u6IZsfj6681/ni5HytTTHHPnTYe33XWTkpSX7C93a9YlmgvVakk69swwLxhIHCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DUvLiMtTKHGoDhvtMhiI7zDWUR+y+7QPKHF9cMSeEJY=;
 b=dCKdFq0aw4qCEryhe26JRXT36jsHS74OsF9/YyV1nL/q6q0xySEki6x1EI+L+mCVe/8sr8JeR8xkeKS+9x7yAM3+QLrKmwGr9UjwWPWQed4nxNtEMFiEfEae1UR2SvjmXx1zN1e4ooqA44utvjMsprT+DHdCm7lfZmt+DKtTBBNZG7S3RtneAk5ldHFu0Dh3YAKcD+RRYpVNXa+C8mivppTqjDxtEjusNZEp/AT714puP95UXAMV9na8VNcxayG9D9kKZzV9yii6iFbnoYB0aGPlQ8G4e+cnAkZ3WLVT7zo2H1uWBnihLQ0mQ1Q799cF6YM6PRU9mVsmrlrvEN4ZDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2859.namprd12.prod.outlook.com (2603:10b6:5:15d::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Tue, 25 Aug
 2020 11:52:48 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3305.026; Tue, 25 Aug 2020
 11:52:48 +0000
Date:   Tue, 25 Aug 2020 08:52:46 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gal Pressman <galpress@amazon.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Christian Benvenuti <benve@cisco.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Lijun Ou <oulijun@huawei.com>, <linux-rdma@vger.kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>,
        "Mike Marciniszyn" <mike.marciniszyn@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        "Parvi Kaustubhi" <pkaustub@cisco.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Weihang Li <liweihang@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <yanjunz@nvidia.com>
Subject: Re: [PATCH rdma-next 01/10] RDMA: Restore ability to fail on PD
 deallocate
Message-ID: <20200825115246.GP1152540@nvidia.com>
References: <20200824103247.1088464-1-leon@kernel.org>
 <20200824103247.1088464-2-leon@kernel.org>
 <10111f1b-ea06-dce5-a8be-d18e70962547@amazon.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <10111f1b-ea06-dce5-a8be-d18e70962547@amazon.com>
X-ClientProxiedBy: MN2PR22CA0024.namprd22.prod.outlook.com
 (2603:10b6:208:238::29) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR22CA0024.namprd22.prod.outlook.com (2603:10b6:208:238::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend Transport; Tue, 25 Aug 2020 11:52:47 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kAXVO-00EWbd-IK; Tue, 25 Aug 2020 08:52:46 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85de8f13-faaa-4ec9-3a8e-08d848ed62eb
X-MS-TrafficTypeDiagnostic: DM6PR12MB2859:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB28597C246CBC2800B47309D8C2570@DM6PR12MB2859.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 96cOvXBDNsHHzKMQsoHb5K8KS331lXBCyWRUWaBi1ZRI+hoxcSFhGnflUkzZO/wbWxkH3MK0H/Ugj4Pievhv7HbjhgdAdtZbYQuB2hIjifshN561lTDSs+3xpRgKPmQFH6lqroOtEf2GqoQph+in1kJ47k9XFdPQC2IePOnfDKh0/cVZPzzFOn+ws3aUOD66c1SyTYhmms3FL/47zcFwEsJE/hrtw59bfa9sRBU9qMJhsLrXdhGzUlqDNR1E+7zI5ig49JIPXr4xmjfvxza5Mp4nC8UEEVojTytGmfcNgzWEfNld6Jmf+JkxILB8gZU9fbfm6XZLnJICSgMzWo06+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(316002)(53546011)(54906003)(83380400001)(4326008)(6916009)(2616005)(33656002)(86362001)(2906002)(66476007)(107886003)(478600001)(5660300002)(186003)(426003)(36756003)(7416002)(9746002)(9786002)(8676002)(66946007)(66556008)(8936002)(26005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: A93+FeackMcNQhwF/hNWXS0cZxphCgqFh595z42I5kaekqV9A/HuE9b4yLnAPQgUVhetbLXwo7q9QgJEmacHEGWpZyxY9R0ve+QHvQHGUOVGgir7uNFHSSL2qftcZuLOGWNiZc2p15R/qD44pkzYSramWVu/MtpnJiGgI/98qVtXAcNRTp2eg1nLbP9o9ri58q2RLWec41Zz+dR7fTwm1FhAZHFZtT+L6S07j0aIGLa47HeNLXAvz4coqjXNcbva4akdb0nVrw3DjWh0FQLeAlfTHtF8sxOZnjOs30Gljh42JbbkY9Hrr2jBzNHKBMqu08S5tvhynCpwQ/hgT2tzn2lE6L+7cVbuvj3lxOLcyFE+H00Lxe6kVYuGnxdRiRIYeUSRyejmTVUlpWQG0/ndxEjthUSUlAYikx7E4euqJO6CXdbCphbYz5iaUQ11kgrgfjpit3llxINlntM2P/Li3ydu6NGEENN44PohJxdELEsPHgmQD0fh9KkjS5zrgpQnqsOX5Kuf+ZHwCxQeyUhegT/Su6c7Bd/WXeo91sDMZBnisK0p7wFa1kt8xXk8KtK4CNAsHM0WrgZiV1bc0fUqlKQAsOwc053/7TKO4q4pI2u5TnUWvzJjf1Lw/EVH/dCqBD3vYNHhFu7HOzXEv4VxOw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 85de8f13-faaa-4ec9-3a8e-08d848ed62eb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2020 11:52:48.1174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OgQxLenDVFcx1nhIvf6rcmliL0inEkbtausdTin6qYo0zEpcjqEP8OHO4y48LhSV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2859
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598356389; bh=DUvLiMtTKHGoDhvtMhiI7zDWUR+y+7QPKHF9cMSeEJY=;
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
        b=r71dOqdv1vFWKYzA7H+UhE4iKguYe8v0nlzpGfjJFS7tbyqKYwuWWJzzyyLKploEC
         TpSASxt2cYVbL/3ZyFSkQJeoQXwDFu8PVI/CYEeR/aqRfV3mqNccvLcAayo6BpYHdG
         WsAwwlT17tFnBtkAu8KPxD9HyCNW0Ik0ldBYb5n5K+wC2KuPKNtWT1S34KnnneVg7z
         VS2tpFMHj4+qEfmJSw7GmEbz1HK9jxRkdbK707nnIHavUisUnMdgS4/MJT/EuUVV0X
         MpwKmL4eABWkihVjTMs+Q4pfMiriT7AeTe4lZ2mGni/WBpujvRqGMVh98AkkQSmN7z
         HqwdwSeoC1EIg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 25, 2020 at 11:13:25AM +0300, Gal Pressman wrote:
> On 24/08/2020 13:32, Leon Romanovsky wrote:
> > diff --git a/drivers/infiniband/hw/efa/efa.h b/drivers/infiniband/hw/efa/efa.h
> > index 1889dd172a25..8547f9d543df 100644
> > +++ b/drivers/infiniband/hw/efa/efa.h
> > @@ -134,7 +134,7 @@ int efa_query_gid(struct ib_device *ibdev, u8 port, int index,
> >  int efa_query_pkey(struct ib_device *ibdev, u8 port, u16 index,
> >  		   u16 *pkey);
> >  int efa_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata);
> > -void efa_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata);
> > +int efa_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata);
> >  int efa_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata);
> >  struct ib_qp *efa_create_qp(struct ib_pd *ibpd,
> >  			    struct ib_qp_init_attr *init_attr,
> > diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
> > index 3f7f19b9f463..660a69943e02 100644
> > +++ b/drivers/infiniband/hw/efa/efa_verbs.c
> > @@ -383,13 +383,14 @@ int efa_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
> >  	return err;
> >  }
> > 
> > -void efa_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
> > +int efa_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
> >  {
> >  	struct efa_dev *dev = to_edev(ibpd->device);
> >  	struct efa_pd *pd = to_epd(ibpd);
> > 
> >  	ibdev_dbg(&dev->ibdev, "Dealloc pd[%d]\n", pd->pdn);
> >  	efa_pd_dealloc(dev, pd->pdn);
> > +	return 0;
> >  }
> 
> Nice change, thanks Leon.
> At least for EFA, I prefer to return the return value of the destroy command
> instead of silently ignoring it (same for the other patches).

Drivers can't fail the destroy unless a future destroy will succeed.
it breaks everything to do that.

That is why the return codes were removed.

Unfortunately there are cases where future destroy will succeed, so
here we are :(

If the chip fails a destroy when it should not then it has failed and
should be disabled at PCI and reset, continuing to free anyhow.

Jason
