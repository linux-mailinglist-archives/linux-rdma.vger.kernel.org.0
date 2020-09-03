Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47FD225B795
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Sep 2020 02:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgICATp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Sep 2020 20:19:45 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:18230 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgICATn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Sep 2020 20:19:43 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f50361f0000>; Wed, 02 Sep 2020 17:17:35 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 02 Sep 2020 17:19:43 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 02 Sep 2020 17:19:43 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 3 Sep
 2020 00:19:25 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 3 Sep 2020 00:19:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ms18eWwWJM1HeMhp58nteOUK33ViZhHNi2iOQXPHr86f6B2to7C9sUl2YDED+tll1yA7Q4RBFt2VZaa4VE24ECTBjm1I0Dt1Hs/ob3fvWDO4+ehf1PgYrnm4uEPqqp3dF/IbsjCDHmor93AQj5Drgvahkp7rWrl6NTR34SaNE2sqfPTVudLQko0/S9kuKQtDM+53zxHJWWNAtF23QkbdsX+gwTVno64PsSIsJ47U97kw97G4zdHYI+UzsNRgQbOLk9tbmsWY3m99AB3zZi27p+Cjui3ddlcd0PRS03qcd2u7TkW9uLCPfc+pnBelnxd305iIOrLIwJ3h+hTZtVKDKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qaVNNqpSjmTT6Ej6QpHegsKbsnxuNnqv0ZTWm5jFvBU=;
 b=mzd0QLPkYUdzf8GVJ71mfKPZySx6typPvCLlFe2B0L7pyoSXjo5/tmXDigrXqfq8Bbk7U3xEsCcR2HEkPZ5MIl8Wzw+LmjSvxw+PINnAg5ZExCOjnfmZP3qqaN+Vaz7DIhqO/7I30yQpFgAar1IMmxzAWnxcfvx6GG4xDE/qjgEc80LPV+ihZWoZl2fGcgBAC0j1CzD2nbPqSWG+bO1ropQtR0UVkiZdhrksThu/yu970hIZU3TB95i8ij2jRfHuz8hUydhK3TD5KvVbOOEmRMYdPorT3tp3FM2anp/KKd2kVWx77W5YWbXRakq07qGTDkfNW2QRWpMRBzKgiJv9KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2859.namprd12.prod.outlook.com (2603:10b6:5:15d::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.24; Thu, 3 Sep
 2020 00:19:23 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3326.025; Thu, 3 Sep 2020
 00:19:23 +0000
Date:   Wed, 2 Sep 2020 21:18:27 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        "Bernard Metzler" <bmt@zurich.ibm.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Lijun Ou <oulijun@huawei.com>, <linux-rdma@vger.kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        "Somnath Kotur" <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Weihang Li <liweihang@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <yanjunz@nvidia.com>
Subject: Re: [PATCH rdma-next v1 05/10] RDMA: Restore ability to fail on SRQ
 destroy
Message-ID: <20200903001827.GB1479562@nvidia.com>
References: <20200830084010.102381-1-leon@kernel.org>
 <20200830084010.102381-6-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200830084010.102381-6-leon@kernel.org>
X-ClientProxiedBy: MN2PR20CA0061.namprd20.prod.outlook.com
 (2603:10b6:208:235::30) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR20CA0061.namprd20.prod.outlook.com (2603:10b6:208:235::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Thu, 3 Sep 2020 00:18:28 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kDcxP-006D59-G1; Wed, 02 Sep 2020 21:18:27 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f60e0de-ae7d-47e2-290a-08d84f9ee1ed
X-MS-TrafficTypeDiagnostic: DM6PR12MB2859:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2859FC270B0AA7CB5F329D63C22C0@DM6PR12MB2859.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 86Gl3v+iV74LjPfKrCtJMNw5m8bj7wifJwtW0MfFwHPG3p5RVGLkHzcnzFN8vyYbS1RaL5HqNqwAXAQZoTXdHncKvydL6Cqb/sNEuSmRrlLwmIATOw5Zo4Mp/G6eZit0Z4HL0CU4R7A6NvlDr/UT8+8zqpSdz6c2TbFldWWMNaldnrReGy4J/P7ZNbfGsNAt85bcM3G5AX0PNiMSZDRMhFhtyJtO6mZtYPJxA5fqdmEs2CkwWWMEld8c4aAmblUOGqp6+QgTufyPRB2rb7EYk6Uje9517/N/zOz2SQ1ZfQnm8qgjBodmmdutkBtn10aI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(376002)(346002)(396003)(136003)(366004)(66946007)(316002)(186003)(2906002)(6916009)(9786002)(9746002)(26005)(83380400001)(54906003)(66476007)(66556008)(5660300002)(478600001)(4326008)(1076003)(33656002)(8676002)(107886003)(7416002)(426003)(2616005)(8936002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: HysH9lQfyD5RzyXTMUM/BpdF1X5+M9tq4tAbQDRFC2QroaW/gsj1gPTHK7jXCmwh2nVmlF5S25emN4Q+a8z/HPMvsBPimSUB9XN5RaMpQeH6eZoKHq6K658crQlEJi680D63ojwaPzlyBADl6YqfEkc2zUGOt5bMasP5njvxLFUh8Oj5Bkp9YXVRwABbrQykDmtis3lVphwYMyQmLdsKneZNZYAKHbvvbktNJlzwDwNBV0N9YpBS8X4DrZ4vDDa/ewLMT4d8EggGH8LbO/+a2i3D0h+yhcAU0gDd6r6ueHjaop3Qu4y3XyzbGQ27ZRSt+dw7fxSg5Hoyy7BsLO3fCAfQSgSzTPW8d4wwdLRUjBf8J1OPw0Is0EiYJqh71gsqvkbYJu4ff4KY3KbkEb3tcfv5arurdTyPKpv+2Qvhkc+VlI3C+T4IccotGfngz4EoHb7DVEaHWGajQmTtQ5ph2KTAlc1fsbhgHA6xvQm8tR7A0hTDjcjqc+qkL40jyjna2gjJFYDSVd4L1ynKOHFLmpjCZPHkLtcRsfttdem4ZoC7wVfqd7Elwx9YNES+J5FirM47JfpWdV84kI2v1uP6CPez3ysU3Ekc9OjU3749GL4J4i7CEPLQRX2JIV5ff93huJB/RpBOEuGAUhL/TGsEbA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f60e0de-ae7d-47e2-290a-08d84f9ee1ed
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 00:18:28.8987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ojSK4rzMdqWhfEu2Ev0dNtRqQDktV/foFwnbT1M3bkXQmJotaTb3Z6xl7JAPokA/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2859
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599092255; bh=qaVNNqpSjmTT6Ej6QpHegsKbsnxuNnqv0ZTWm5jFvBU=;
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
        b=WlAHS+57ZAMlkzO6g1l9TX/skSmSOA1aLa+t95BWLmb94aTr06bx57kxp65xXCpwQ
         oHVYSi4IelovRVsR7PlncHh4jcNBztXc6MbZqGMRfFHIMwjlHUGoxbHusiDK+AOI5e
         NNAz7H6ymfcR3x575Edz2MQntN5TwVI9Gz8WFTMhbt9LpB5yL2H3qEqIO0XzAojRpM
         YgYUPHE2sEipfnzhAZo5ryfajubV/mh+NfnX55cckcAobFGBeCELBF2AeMiuw4sKt6
         QwHc20D2m7doaIG0Oeh/Qde8X4TxpZQsNNdt64Ypyjipdw1hCChcGgM8l3THgqZU0V
         J3M7LI3YBJc0w==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Aug 30, 2020 at 11:40:05AM +0300, Leon Romanovsky wrote:
  
> -void mlx5_ib_destroy_srq(struct ib_srq *srq, struct ib_udata *udata)
> +int mlx5_ib_destroy_srq(struct ib_srq *srq, struct ib_udata *udata)
>  {
>  	struct mlx5_ib_dev *dev = to_mdev(srq->device);
>  	struct mlx5_ib_srq *msrq = to_msrq(srq);
> +	int ret;
> +
> +	ret = mlx5_cmd_destroy_srq(dev, &msrq->msrq);
> +	if (ret && udata)
> +		return ret;
>  
> -	mlx5_cmd_destroy_srq(dev, &msrq->msrq);
> -
> -	if (srq->uobject) {
> -		mlx5_ib_db_unmap_user(
> -			rdma_udata_to_drv_context(
> -				udata,
> -				struct mlx5_ib_ucontext,
> -				ibucontext),
> -			&msrq->db);
> -		ib_umem_release(msrq->umem);
> -	} else {
> -		destroy_srq_kernel(dev, msrq);
> +	if (udata) {
> +		destroy_srq_user(srq->pd, msrq, udata);
> +		return 0;
>  	}
> +
> +	/* We are cleaning kernel resources anyway */
> +	destroy_srq_kernel(dev, msrq);

Oh, and this isn't right.. If we are going to leak things then we have
to leak anything exposed for DMA as well, eg the fragbuf under the SRQ
has to be leaked.

If the HW can't guarentee it stopped doing DMA then we can't return
memory under potentially active DMA back to the system.

IHMO mlx5, and all the other drivers, get this wrong. Failing to
eventually destroy an object is a catastrophic failure of the
device. In the case of a kernel object it must always be destroyed on
the first attempt.

In this case the device should be killed. Disable memory access at the
PCI config space, trigger a device reset, disassociate the device, and
allow all destroy commands to fake-succeed.

Since drivers need help to get this right, I'm wonder if we should fix
this at the core level by introducing a 'your device is screwed up,
kill it' callback.

Then all the destroys can return failures as Gal wanted.

The core logic would be something like

ret = dev->ops.destroy_foo()
if (is_kernel_object())
   dev->ops.device_is_broken()
   ret = dev->ops.destroy_foo()
   WARN_ON(ret);

Ie after 'device_is_broken' the driver must always succeed future
destroys.

Then we have a chance to make this work properly... mlx5 at least
already has an implementation of 'device_is_broken' that does trigger
success for future destroys.

Jason
