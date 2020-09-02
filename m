Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 355A625AAB2
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Sep 2020 14:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgIBMAl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Sep 2020 08:00:41 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:30673 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbgIBMAb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 2 Sep 2020 08:00:31 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4f895b0006>; Wed, 02 Sep 2020 20:00:27 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Wed, 02 Sep 2020 05:00:28 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Wed, 02 Sep 2020 05:00:28 -0700
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 2 Sep
 2020 12:00:08 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 2 Sep 2020 12:00:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ye4GoGFTjGs5qallah9biivsJHulrV5j6SgsvjP/QUKckWYe6hHKC9B1OBnZF5CssLGZjYGsx/Z2Gkof9pcbuDqICexcvEgC7NdydFy2Dq4kzeKXUyO/MrVC+sgkUPTq+NrZd0OeZ3zFDZZ2HcycyvmxaqISqhpstVT9CDL/NSOGwVRuDa1jlmCA48tDR2J/cd3Z1DqmgYarLDPf6Ier/rLls6QKYHixinTkffxg2p6Oukn9vRpC+82ROBXGe7gzE0f3u26XaOJh+dMVg38f6f3lyXS9BueWVMTsajMsDPXMZyVLwbtqNeLxZ6sxzCBPk0CCpwceKfOtYel8CZiv7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHnolvIHDr2+7PATgT3sun4ZMV3NoFxjsxx8KyvUapE=;
 b=FVVNJjNeDvFcV6w65Oj5kcJkuwwBKLvnukWwwEruZean4EHbVqzJ9Wyt1+qMIqksg/qbH4dqXfHHx33k3T3ORWfGMzKUsX0MztHyjxFlCkKTfwniCVAWP7+8kq9YGIyUxzvzIFq5p/Rf8Dc1XkjIWm3FHRzlpFJ/AoiQOwvUtOVWI56MVEaGnpeyJBfTT7aN8tRnCARzQXKxWcMuMuFJrUZMYsc8MpYxw5TArtIVH6fivaJK1zQOAJSCszwpEyOOX+z6wVfKmkMba/U18S+aBFawVbMcOkGUgP7sxu7fhKG+asgCVNH/nhi+ZOoCNGeO48I7ZgEuhLMVIO3IW3vbOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2486.namprd12.prod.outlook.com (2603:10b6:4:b2::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 2 Sep
 2020 12:00:06 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 12:00:06 +0000
Date:   Wed, 2 Sep 2020 09:00:04 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gal Pressman <galpress@amazon.com>
CC:     Adit Ranadive <aditr@vmware.com>, Ariel Elior <aelior@marvell.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        Faisal Latif <faisal.latif@intel.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Leon Romanovsky <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, Weihang Li <liweihang@huawei.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Lijun Ou <oulijun@huawei.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        "Selvin Xavier" <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Zhu Yanjun <yanjunz@nvidia.com>,
        "Yishai Hadas" <yishaih@nvidia.com>
Subject: Re: [PATCH 00/14] RDMA: Improve use of umem in DMA drivers
Message-ID: <20200902120004.GR1152540@nvidia.com>
References: <0-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
 <8bb0555d-b2d4-8046-5e1a-5393d502adf9@amazon.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8bb0555d-b2d4-8046-5e1a-5393d502adf9@amazon.com>
X-ClientProxiedBy: MN2PR18CA0015.namprd18.prod.outlook.com
 (2603:10b6:208:23c::20) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR18CA0015.namprd18.prod.outlook.com (2603:10b6:208:23c::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Wed, 2 Sep 2020 12:00:05 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kDRQq-005cZ1-EZ; Wed, 02 Sep 2020 09:00:04 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71980a6c-ac09-46d0-62b5-08d84f37bb3b
X-MS-TrafficTypeDiagnostic: DM5PR12MB2486:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2486BEABFC1CEE1C6B094171C22F0@DM5PR12MB2486.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HYDFZGAAieeHLS4EtGSsX2vxIHKml1TFhJLGEt1uWBFDMVhZQBKmK30ltp+3ks2ayaKoZAYVFI5S9uJwi9AVaSzOsM78TKEJLMlYjlmhxDcZN0T8Dkvk32Hzt8tciGVEdLxJvTJuLp6pfiY35UgS69IbSzW9gnQO38wELkTAOaFZDfxADNO1tI+x7gvowZ0bNgP3So7fPOrp3TipwnPNLZVSR8dv6/pdXV7JBntQmv87eB0J7JvdEoZn7/hob+5TqFZYyhiSfReq0LlwtzElyrjpi2qEeJ1tGhAherDaYdRm0HdAVsCnuUbjFItVKbI7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(8676002)(4326008)(8936002)(1076003)(9786002)(9746002)(6916009)(107886003)(26005)(36756003)(66476007)(33656002)(66946007)(86362001)(5660300002)(66556008)(186003)(478600001)(4744005)(2616005)(54906003)(316002)(7416002)(53546011)(2906002)(426003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 8xofna9ZMapTd/xbfPxAAuL1zBCyblSU81pFsUEK2l4i8majI+5CnOYnm0l7GfU6Bwt78oxs2RK6BBvvaDqZ7n1/0s15uk8JUYzxjZ6ngDIWgaY4QSKh5bL9icvVm0tnFZhdGeUEAwXwvjz7XeT7U5fvRzz9uzXUyP8uIMJhQjXcttizuGdOCCtLXdQZixSl1l4A7ilH8IfLofOaVyHb3OXA98B6RfHdoAMBNWZSrKK3Y46MQIbpA+q23tGCC5/5cKSl2kmNm6wIAR56jj4UiRjkhBYhsxiW9FhaQLzUkHQtwolro8+33jqwGnsqLC3yA8LOmPJta3hnN+5dQuCtuLTPg7bl/Waw8Hcpx6/j+x9orhuvwp1zALAGOnjbaDZAxO1asdlvlcvhA3hv/E25+cehGOEwmbgdb4cpue9S2pkuRMJgdRIYI+Z6KoSbdxy8SsR23kmqHd8l1u/nTf6YFLks4iKT1cq4AeGzwlqWgvqCqFdhYn0G5fzM+MH0llqBmigmWcC6Dpox/3Y9UgKQuCiEz0FSs5FWv1wfIiqtwgNcnscZJ+5nrMCOcYp6ZAuAF9SP/K+g/ZOaQXSmKAfoTxuUugvbv2yq3qJ4+el550e8DS/u6o2wR8IhHYJIZq8101X3fcOS2XpdTmEABsBnRw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 71980a6c-ac09-46d0-62b5-08d84f37bb3b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 12:00:06.0869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xZD2k0INTJvwQHNhYlemWgRR+wcW2ADaCnmusMnEsKz3UofnILRQ0w0r9CQGa55N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2486
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599048028; bh=XHnolvIHDr2+7PATgT3sun4ZMV3NoFxjsxx8KyvUapE=;
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
        b=hLjCWUAQYCsvkJTs3t6OwEWgx/XdfasCRpVbUNpHSdyqrfReM2Yv25o6iInNIQpHT
         C9YaEUWSekja/9ZtNGKfNpWeYNlC73zw4pJd3wTyGdt3GVnlyJSk4N6xa242rKVyud
         92/WRnVf3PhAPW6qQPYxdqiupxGgYDwE6W2TilUYujtmBgi8n0aUE1dpEdh8gaS/k2
         3L+rM1l56SuEp/az+KjC/Qgo4bM/LF+bn1ZH0YxmocYpsat3q2w/mrSWDB04F4M3aQ
         VV9REhnyZOjpwjFVAopWJqRSqyxEd5XclHAxrfStoH1Jfj5VOf3d+WoWxBzR41op2i
         EjXqZT7cCTLKg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 02, 2020 at 12:09:41PM +0300, Gal Pressman wrote:
> On 02/09/2020 3:43, Jason Gunthorpe wrote:
> > This is the first series in an effort to modernize the umem usage in all
> > the DMA drivers.
> 
> Can you please explain what are the next steps? What's the final goal?

DMA drivers should not touch the umem sgl directly

Jason
