Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C282F6140
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Jan 2021 13:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbhANMu0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Jan 2021 07:50:26 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:35541 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbhANMu0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 14 Jan 2021 07:50:26 -0500
Received: from HKMAIL103.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B60003de80001>; Thu, 14 Jan 2021 20:49:44 +0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 14 Jan
 2021 12:49:44 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.58) by
 HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 14 Jan 2021 12:49:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K7qcqrGsk37/LWNs7TR5q10MDnWtzEy3yNsvxaBrtUyMIu3KFpDY8PqAK/9QchLykJSTELNtN1hVCLeiedzhNm5gDy8/xrC/i2mzM8TQ1H6YG1PXEds6v5qx/jtE7U9jP/OnxqRX0PSuHU2LZUjccnHlCtdoEicHKF7i6jd/03AfE2j70vvSVf++IAWozCzTTi3mRGrUjQPkxshllXgt4sje6RRHL5F1O65mM+iTyqwwIfbXFQS62/h8s/8hsxQv8oZuTjvJTQbNc+s0aWJ1Wan1W0I4OtUy04kMvhxSqxFTYMwzpeQSQ356h25ZBQtIX2SB4RUDaXfjbuT8YtE8gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+AtqhYXgJeIuiy0We2a1wAjoZLB0zBagjpnhG/yqOYE=;
 b=JNkUfZ29JLwGaa2OMHCkG8aA16ZKsYhLdxLTFGfQiOeE6TWmCdIXxhzwnZxf3UQdvAGVHXVS84er0SwRMxOC0FGDhE6P/m5PXVbmQoFLJ7NnQ31OuiFaRk7Zu1Xnf9fQT2mSnuUG1eQ5mIGwZ05b6S+fL2FvCEt2SpkqD5LCuf97+iqrLv4tbpLHIxKlBGLPrQN1KUZ8KEWLMml9XzHqo/hZ12lgkIkdFZ4CkClcOptE8H7T4EyOpXodiqV6ayUDlCOrUj8G/+GZze2Pu079l7NTXd9ORRn6TVd0twvBxA0eYjsf3E5azBUZt+yXCgriPrstxy6H1MbDBSsCzBzUcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2584.namprd12.prod.outlook.com (2603:10b6:4:b0::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Thu, 14 Jan
 2021 12:49:41 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3742.012; Thu, 14 Jan 2021
 12:49:41 +0000
Date:   Thu, 14 Jan 2021 08:49:39 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leonro@nvidia.com>
CC:     Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        <linux-rdma@vger.kernel.org>, <dledford@redhat.com>,
        <oren@nvidia.com>, Israel Rukshin <israelr@nvidia.com>
Subject: Re: [PATCH 3/3] IB/isert: simplify signature cap check
Message-ID: <20210114124939.GG4147@nvidia.com>
References: <20210110111903.486681-1-mgurtovoy@nvidia.com>
 <20210110111903.486681-3-mgurtovoy@nvidia.com>
 <ea24823d-c1e9-d40f-866b-6671a13c08ad@grimberg.me>
 <20210114072938.GM4678@unreal>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210114072938.GM4678@unreal>
X-ClientProxiedBy: CH0PR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:610:76::28) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH0PR04CA0023.namprd04.prod.outlook.com (2603:10b6:610:76::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10 via Frontend Transport; Thu, 14 Jan 2021 12:49:41 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l024J-000sXt-Tt; Thu, 14 Jan 2021 08:49:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1610628584; bh=+AtqhYXgJeIuiy0We2a1wAjoZLB0zBagjpnhG/yqOYE=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=Xa1WLAr3KJVLah27anA01jwwkwZk/NsXuBcho6Q41x8mc3VenXcb6Szk6VFQjnYnt
         HxYQU/ljqBbr3Y/tlulJqVxM+KFe1xRHsDWIlN7O0XWELbkfrfdeOFRJU8G1V3d4FC
         dIyg4yh9X4L+NWNFDCf5+RSO3L5HmrdFiS2P3DuIgYW/ubpDlEhnpv3jHVbN2AiT5a
         z7cwqAuGjtWBzAh8MDts6obWWhfK0Ic0w0n8weOAVbkS2nwcsTT/lWAwib6onOZ5dy
         uS++LYl5ZbAbf3GyjOSQlhVziQHtK/epq0DjvlOjeS832ydslAOIhVLVaVe57w7rOX
         WX0tk6YLc2psg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 14, 2021 at 09:29:38AM +0200, Leon Romanovsky wrote:
> On Wed, Jan 13, 2021 at 04:08:29PM -0800, Sagi Grimberg wrote:
> >
> > > Use if/else clause instead of "condition ? val1 : val2" to make the code
> > > cleaner and simpler.
> >
> > Not sure what is cleaner and simpler for a simple condition, but I don't
> > mind either way...
> 
> Agree, probably even more cleaner variant will be:
>  device->pi_capable = !!(ib_dev->attrs.device_cap_flags & IB_DEVICE_INTEGRITY_HANDOVER);

Gah, !! is rarely a sign of something good..

Jason
