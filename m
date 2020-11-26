Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA9A2C5CB1
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Nov 2020 20:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404880AbgKZTpd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Nov 2020 14:45:33 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:5024 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729363AbgKZTpc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Nov 2020 14:45:32 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc005e30000>; Thu, 26 Nov 2020 11:45:39 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 26 Nov
 2020 19:45:27 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 26 Nov 2020 19:45:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZYY+3HtTkFhXjh58AJFoDYPFdI+2m9DWAaVg2mkhKa0miVWGAsK75wHMLjrbtWUe89QzYKl7rZh858ujPCk4F2YFDjOzw9KjO6FJfRM9kzzQ9IMr3QmogIzvQ888VGYS+v41uBD5VGBagd3KzkU/H5YZrDaIQHZquafKuba7YI8s2RjimGp72RzOshAj0J9HWk/wZIEQJCdt+CFQPj96HgMNGaSnKjVysp0fKEJ6c7dkWQNDpBf9vqfdvz9IDkNamxHoSRTsTyezlEHJjYRe7Yl3v5glD+7rLVycKh+pqIAZSJzpus4byGLrQn/mX1lyY3Z3deAXSACU2b3kunRpPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VXoMSpWoyecbXz5foy0wBn/JuxEoVo3lKFm1R9ptS3A=;
 b=Ti4+NEgBb1MuPOgNufdw2ho7DVv7qamlVJuxdSW8LvClopIUACMH4iH8MwjqOs5rDRVSUghJpmoCbNaYKbV61pOFz6CIj0D3dfWHFyXyHNxKd8upYYpcZF5Z+LdZxvBQidQtggrtqkZXYf3y0ywUVzlCOHCrWMOolC0PcEHx/vanemR8CEwQCQ3uEQYyNdCEnkbaBbeTOu3b9FE8TqsJ62ucgbezyT6nmiGuC4v7LcOH1U0YPTK6C6wYK8nCoH0dgDvKL2mzpRBXODMSCZAaQqarLeho5jViyHiokUiqjL00vmW0MgWdQcy3DSfOiSEODIJCOwx+kQk9wLVB2t7hdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4578.namprd12.prod.outlook.com (2603:10b6:5:2a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22; Thu, 26 Nov
 2020 19:45:26 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433%3]) with mapi id 15.20.3611.024; Thu, 26 Nov 2020
 19:45:26 +0000
Date:   Thu, 26 Nov 2020 15:45:25 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH v2 for-next 0/7] RDMA/hns: Support UD for HIP09
Message-ID: <20201126194525.GU4800@nvidia.com>
References: <1605526408-6936-1-git-send-email-liweihang@huawei.com>
 <20201126194441.GA552360@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201126194441.GA552360@nvidia.com>
X-ClientProxiedBy: MN2PR06CA0005.namprd06.prod.outlook.com
 (2603:10b6:208:23d::10) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR06CA0005.namprd06.prod.outlook.com (2603:10b6:208:23d::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Thu, 26 Nov 2020 19:45:26 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kiNCn-002JjM-2u; Thu, 26 Nov 2020 15:45:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606419939; bh=VXoMSpWoyecbXz5foy0wBn/JuxEoVo3lKFm1R9ptS3A=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=Iub/mGl/uC8g7XmkWmAQzMG05FWCCY/bMPB4D8S95UWYzXWWUDEjSPUkAy7dhtfTh
         7mNiOy6ZfFzStAdM2qYWtJ287YLiwwGGTx40glDGqPPcF1BxuoUq73seMTGoFIAbDm
         eGSrCPtb05W04SYS6QamTo3lT2/irLgpqIRS45rE7RfVCi3EmdXztXjLSaicoqVVMf
         CrwUu07dqeNpPAh6gZzfImpJ71Z9Msuws05VRvPElMFflCllqg7/MyTv1+0rnavsnO
         0BlzgKNS/5uYm5zkM14j+NSTKsgL4dx2t0mm4l/VdG5R+KCwxKLu05hhYxxo6hWBDj
         H80fqzytLtOcQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 26, 2020 at 03:44:41PM -0400, Jason Gunthorpe wrote:
> On Mon, Nov 16, 2020 at 07:33:21PM +0800, Weihang Li wrote:
> > This series does cleanups on UD related code at first, including removing
> > dead code, adding necessary check and some refactors. Then the UD feature
> > is enabled on HIP09.
> > 
> > Changes since v1:
> > - Don't allow HIP08's user to create AH and UD QP from userspace and add
> >   .create_user_ah in #6.
> > - Drop #4 from the v1 series which needs more discussion about the reserved
> >   sl.
> > link: https://patchwork.kernel.org/project/linux-rdma/cover/1604057975-23388-1-git-send-email-liweihang@huawei.com/
> > 
> > Weihang Li (7):
> >   RDMA/hns: Only record vlan info for HIP08
> >   RDMA/hns: Fix missing fields in address vector
> >   RDMA/hns: Avoid setting loopback indicator when smac is same as dmac
> >   RDMA/hns: Remove the portn field in UD SQ WQE
> >   RDMA/hns: Simplify process of filling UD SQ WQE
> >   RDMA/hns: Add UD support for HIP09
> 
> Applied to for-next, thanks

> >   RDMA/hns: Add support for UD inline

But I didn't take this patch since it seems to be dead code

Jason
