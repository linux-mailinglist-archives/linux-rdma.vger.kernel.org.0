Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5740A2FF171
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jan 2021 18:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387750AbhAURLI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jan 2021 12:11:08 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:11099 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388401AbhAURF7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jan 2021 12:05:59 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6009b44e0003>; Thu, 21 Jan 2021 09:05:18 -0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 21 Jan
 2021 17:05:17 +0000
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 21 Jan
 2021 17:05:15 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 21 Jan 2021 17:05:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NcIAPt9qG2269VO476dQ0EW3OXXm2c9udD6+SNygGsoAPmrwDnAqgyusnEgGwsBGM2dglNyH/SH/G5q8AXo+i4I3QyNngJx65qcFquayE5M3rCizAvUg2SkUh0HOTcZ1aPaYrJN0nCNsA8get1daQ2Y7uO30HNoETTFogOn1Xpy+kfiQahKya/NJVaUNCHmHb53rTleYvs8t6/evG1DoWeqEE8KQxr2m/dY7Ehy82QXCdNUED9/sHxvBDvkPD81hKveBnjWG/PdnkiLE0wnB1OEpubIrkTj36skCmigUFs1gzAZuEIaJo45I3d0+pQKxpZRFJU8yWp09DEZEZ+Qn7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsGOW3AnR2d2OE5vYrGwBGmiO3NtEcRC6XfXSg0Wf6U=;
 b=jj5x95rdN/n/umR4yLdDEfPAMSS6vWmhu72s/3Niv+aoC8izf3gF/Xwgt5OSNR2w54Ym2RtxFIvtIEUdywZzxr5vLFgH/LvP7KFpBt62pVRmKHOeQLCbBvWAyf2h0jmbbQcORahE3aBcSLxfsGcadMaKuM9OfnHnt1M35YO3SXwSH6a6Tx1lr8B/PQm4YzD55bUxzjhKiGUHHi9rY23JPPXatASwSmO3HfKqMu1jvrlPQRhZtMysLcqPdrjm5AbvHNpuapnUfYNXDjqOQ9hXN5YPaId72tYsKeKc+zgsLnlECMnYBBC4M36/hlni1IFdc4XqouHhRsaTvhIR+nCNeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1434.namprd12.prod.outlook.com (2603:10b6:3:77::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Thu, 21 Jan
 2021 17:05:13 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3784.011; Thu, 21 Jan 2021
 17:05:13 +0000
Date:   Thu, 21 Jan 2021 13:05:11 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
CC:     <linux-rdma@vger.kernel.org>, <leon@kernel.org>
Subject: Re: [PATCH 1/2] RDMA/uverbs: Don't set rcq if qp_type is
 IB_QPT_XRC_INI
Message-ID: <20210121170511.GA1218297@nvidia.com>
References: <20201216071755.149449-1-yangx.jy@cn.fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201216071755.149449-1-yangx.jy@cn.fujitsu.com>
X-ClientProxiedBy: MN2PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:208:23a::7) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by MN2PR03CA0002.namprd03.prod.outlook.com (2603:10b6:208:23a::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend Transport; Thu, 21 Jan 2021 17:05:12 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l2dOR-0056zg-FV; Thu, 21 Jan 2021 13:05:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1611248718; bh=lsGOW3AnR2d2OE5vYrGwBGmiO3NtEcRC6XfXSg0Wf6U=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=cwISBctkxW+QB5BTM2LLZ8vmE0VdK3xIX7mAFiHQzK57m8uqg7jyHmM2I9S4ryzKq
         CvJqx8W9ixQUif2yaeQag+S8EnFPm4fyRajALkGWn4JjbJtaBFEcsbssBU+0G9oD5s
         J7bIgbgfZJoteART6xGCWiOqrY0mRVXeaUAXaeqQEGVoeqdNeLwbPu8YzGnpMvpohd
         FF9j3OLuXwGmQDeaYGYsaHYLRAawlkiIMaaNiXx2Tdr9J3snZ66kK/feSeRex2qGq7
         8AkKoj0Y7ufL4TLx1XFHx9IbEkf33htasd0Ka4N++FmXlz5kfnUhYlrNDQA9+OGbtE
         uOPzHah6ezgcA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 16, 2020 at 03:17:54PM +0800, Xiao Yang wrote:
> INI QP doesn't require receive CQ.
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  drivers/infiniband/core/uverbs_cmd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
