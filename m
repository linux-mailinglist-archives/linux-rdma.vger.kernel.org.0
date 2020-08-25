Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52046251A07
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Aug 2020 15:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgHYNqT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Aug 2020 09:46:19 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:3454 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbgHYNpj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 25 Aug 2020 09:45:39 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4515d50000>; Tue, 25 Aug 2020 21:44:53 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Tue, 25 Aug 2020 06:44:53 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Tue, 25 Aug 2020 06:44:53 -0700
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 25 Aug
 2020 13:44:34 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 25 Aug 2020 13:44:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c1dTRnqxjNrWC1fC1QkWTczBBGYc7a7XMRelRG9cUR/jGa70K9qF9AiHkulQsJuWaYcRZ2g2e6F5bhhU/1nxw5XE1PKGMT4eBPHbjKWIYwYiiP4rB5Y10NTszubYj0DV5OJLrY2UvnDjMRDEavOUH4Msmk1DDWm0RDqYKKGaVZVprE5azqIQiJTp1zZngNLEMO6Ie579QEhTLrGnVNZyg6RuJHr40RmuOBPhlsIeuRWFZK7WFseaeNk9E+q2U4ZVVdWdfn4eqaiYOzg+ifRN29jORh7DWFZ+9z79IIzHH797YOq1y/h57gCztlR3hItkIDR2vErg8RCN7GekTWB2Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5OjwVZPe7YgGzeTyQl837pxqIjV3LvgzxUa1sNXqIe0=;
 b=DpL6+qsdKAQox6gyxnEg38NHkL+sY0+3gczMe50lD3O8cSeMVlK1Tb/M7wdHjE3jxbVDeBwF37NXDV8eiwfHgcIr9KI2pAjDNBROyeO/NPCJQWHcatqA+zF21rGBeVU6fKWLiZOvgBYpautibwRFc8dRHfa1cXwcHwrJEU4IENFmWwUGoMcjoVAvHcOotr3AHvItxxXANupIhduv5aQxWZVuNBXYpQ9t4a5xqcZyKlmbeh094fa1IpkZ2RZtxYBpc892x38IuK4hCsTXw+nt0Ba1UMlauMhaPdsCzGD5G0JF9GWPdNLeJsI7f1nevHssGHWf8KVuQ7ecrRPHdiE2xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0108.namprd12.prod.outlook.com (2603:10b6:4:58::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Tue, 25 Aug
 2020 13:44:31 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3305.026; Tue, 25 Aug 2020
 13:44:31 +0000
Date:   Tue, 25 Aug 2020 10:44:28 -0300
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
Message-ID: <20200825134428.GR1152540@nvidia.com>
References: <20200824103247.1088464-1-leon@kernel.org>
 <20200824103247.1088464-2-leon@kernel.org>
 <10111f1b-ea06-dce5-a8be-d18e70962547@amazon.com>
 <20200825115246.GP1152540@nvidia.com>
 <110cc351-f8f1-8f88-3912-c4dae711b393@amazon.com>
 <20200825130736.GQ1152540@nvidia.com>
 <74f893e8-694a-17f0-dc49-05061a214558@amazon.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <74f893e8-694a-17f0-dc49-05061a214558@amazon.com>
X-ClientProxiedBy: YQBPR01CA0079.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::15) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by YQBPR01CA0079.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:3::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend Transport; Tue, 25 Aug 2020 13:44:31 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kAZFU-00EYgz-UE; Tue, 25 Aug 2020 10:44:28 -0300
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d11222e0-5b32-424f-0bf1-08d848fcfea9
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0108:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0108A65047AE44CBB3671FC9C2570@DM5PR1201MB0108.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QjO9Zo0skIZvQP2u/WV1MP3yJia/PETHNV856usESPyHpf9jKcU+4tYDAH3SPBfUuo25SpJnL2PubbEgwLY2zYfZBZOQo/LSHKp9bQ+g8NZg3nrfcjADo8qogA4hxg5etmK8ivjS1C69uqnHGxY+kCRCyiy6dDcYlgZSq6FNqegcvBsh1xyzW4BxmsdIBhCoifOjwOF4xOtVu9z9UbivrAnrX5KpgFaHITpxYaUzkLxuaQPmvk1/FU24GbDgGDyn877IMBhh4DYn5mqL7CIgpQICofS5yEEQQRlIp7F4f/Mq660gX1rpdlnqB6H1+svaCrZ+3X6padzUnFeGBMb9qQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(376002)(136003)(366004)(86362001)(66556008)(2906002)(478600001)(9746002)(316002)(107886003)(66476007)(2616005)(9786002)(4326008)(83380400001)(66946007)(54906003)(6916009)(7416002)(1076003)(426003)(26005)(5660300002)(36756003)(8936002)(8676002)(33656002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 5/g3fO4NUuAQ3TxVzVyhZziDqDQEIO7h2LQkHp3SzIGEC3DKl4eshqPLzCcDW4vCfd8olNtlN8aq3FCRDS3CuQPAkCQFpsBOis8wXWeG0fXF3wTeeavvITnOAoUWEtGmq1Ue5ltmpXQDnDgSrHSupemGMe8RuoRBLkvi8DCOR+KGLX3X9o6E3cRYG3mi7iEzCQecxpJhJK0EAajm0/qRIvoZ3ZPanRW02dvzXQ8R4sQbZueI4Hfl3dXthuhTsf2PzVTU1/tatZcCWAzgyJf6YjaJMS3mcSn4l2TXEOm4bV758RpQgd1/Lm1l1+WGHQCo1rJQ6oGXI/hymauesb9kJXdm8nFT9k8NKT553zRW5y0QTpRmS7jYr2hRRlOIzOeSb9M22D5f2X3l2xGRRVDEJ5c9nQGonzkyF70lcP0ITdp0Hi8A81wJVm8k0yAGb/LoOxmUqAz/OUF7cgGn17nC9ASNfQwSij+R1qFji86RFsrhOq0iE7258JRmf3Fn9pwg9lQkJa5XIB2AJGZo8ZGv87ckbKanEXnjkQhKmeuE9bCtWjXyJ+orcOmBu1f0RFWRXhAJjGdjgzuDmhA42f5o+1IEs0AgsLF7n6KQAlQEErqTnpP6JNCvm3nJ8fYPV7aTZe0oDcFqc4YELwfpbRhF6w==
X-MS-Exchange-CrossTenant-Network-Message-Id: d11222e0-5b32-424f-0bf1-08d848fcfea9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2020 13:44:31.6294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iHGln0rQ7WgnMtsTPlK8GYaukDSW6g4LConyT9l4LF9JhYCBS3sbJV2Igg5WCHZl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0108
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598363093; bh=5OjwVZPe7YgGzeTyQl837pxqIjV3LvgzxUa1sNXqIe0=;
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
        b=IPJP/JMN0nMH6WAWRAwABnexK7iOw421F8zfQwKjxMY9W2zEjGBlZnYPi3PQKCnuU
         OEUp2ICtqzSt0G6upy4G3KBjPioldjZw2XTuOkKL7qp00Mrk02xK8WK8AaLkHHJ+d5
         ZGLLmg+dVvQ03s77uz3OIPlHSI1kCvzhmuiB40kEKXsg0Azwej3JDPV8A1FCbtXRMV
         IY3K1j1QOUMjXbzXO0Doyy9gOK7UhE36qhBJOcXHF+KpKAsBnqmYIlV7c2qyiYmJqC
         7ZIKnkm+1IGSp+5CsRZFswJbJNGsYR3CNYG63GtG6OMWkrLp2E6ciJi0uNPYJD1C0S
         kDk66DyRUI59Q==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 25, 2020 at 04:32:57PM +0300, Gal Pressman wrote:
> > For uverbs it will go into an infinite loop in
> > uverbs_destroy_ufile_hw() if destroy doesn't eventually succeed.
> 
> The code breaks the loop in such cases, why infinite loop?

Oh, that is a bug, it should WARN_ON when that happens, because the
driver has triggered a permanent memory leak.

> > For kernel it will trigger WARN_ON's and then a permanent memory leak.
> > 
> >> I agree that drivers shouldn't fail destroy commands, but you know.. bugs/errors
> >> happen (especially when dealing with hardware), and we have a way to propagate
> >> them, why do it for only some of the drivers?
> > 
> > There is no way to propogate them.
> > 
> > All destroy must eventually succeed.
> 
> There is no way to propagate them on process cleanup, but the destroy verbs have
> a return code all the way back to libibverbs, which we can use for error
> propagation.

It is sort of OK for a driver to fail during RDMA_REMOVE_DESTROY.

All other reason codes must eventually succeed.

> The cleanup flow can either ignore the return value, or we can add
> another parameter that explicitly means the call shouldn't fail and all
> allocated memory/state should be freed.

I don't really see the value to return the error code to userspace, it
would require churning all the drivers and all the destroy functions
to pass the existing reason in.

Since all the details of the FW failure reason are lost to some EINVAL
(or already logged to dmesg) I don't see much point.

> >>> If the chip fails a destroy when it should not then it has failed and
> >>> should be disabled at PCI and reset, continuing to free anyhow.
> >>
> >> How do we reset the device when there are active apps using it?
> > 
> > The zap stuff revokes the BAR mmaping, it triggerst device fatal to
> > userspace and that is mostly it for userspace..
> 
> Interesting, is there a reference driver that does that today?

I think both mlx drivers and hns do? See
uverbs_user_mmap_disassociate()

Jason
