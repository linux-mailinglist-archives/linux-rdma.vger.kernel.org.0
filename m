Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA412FAC2D
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jan 2021 22:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388581AbhARVCj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jan 2021 16:02:39 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:5573 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728618AbhARVCS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 18 Jan 2021 16:02:18 -0500
Received: from HKMAIL104.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6005f7300002>; Tue, 19 Jan 2021 05:01:36 +0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 18 Jan
 2021 21:01:34 +0000
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.46) by
 HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 18 Jan 2021 21:01:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nXxanMesy4Iwx6s2ZSgSAIDFEF1gOTBCLIq0XSuSt4PX+Jo2z8f+L7bdid5tcXoOBrxRNEJ4eh+UHmXZ+mCXilQmyr53+LYzWnT9fuSviddO9DKciL7Ten1ndTrd4ruN2q55+U0jIrqhmIeOsU+DbMGjf/xcgnbpywik3J+qad2lFO3MuNJ6vUHq4DDNh8l6Ji1gTWCN1oVx4yLFGmYxLZcesNF9JBNnYc5jjlWfNS9Mnm3FY9apj8+GMxPfmLYc912oJ1hZngfKhQS2KQ3f6/SP5BdmjY34zh6sRGK8ISd1w9PKnhE3v4RQz8ySwlEZT2iWg3FMr4QprINhv0vADA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0IPLrH9pz/vRSbU79iR03d24Ywg9TZF5tSzEBqOLqdE=;
 b=HA2l/pd+Ts6Vc9tGeyJKx8vXn8x2mGzClX0j0GlRtixaLvS8/jTY9w1gL4Htm9eP+oH6AR9ySETnh8YzT8ViVqcvtf5aVOpHJSdJuqGI28uYf0Y8S0f5dLvRobZ0ITTuIOiUi9nfyIGr3+L0s+ZKHwyZvadyDHnahw6ITckIof3lpdne+odtkeDZxYwWAFiBRBFL/4ZkeYD8rI+UWEuEqqWEB1ZZxcYPUdJ+XylNjW0JBrUKV5vGIylyiqmyYGFiIfqDwvcXnIfF58prSSwXxLPBsDOUIv0yGFI1Yirhjq5RkETIAIRu+zlQsEAt1tdh+TxzLa2q2dKSVk/Ymg11tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4451.namprd12.prod.outlook.com (2603:10b6:5:2ab::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Mon, 18 Jan
 2021 21:01:31 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3763.014; Mon, 18 Jan 2021
 21:01:30 +0000
Date:   Mon, 18 Jan 2021 17:01:29 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next v2 0/2] RDMA/bnxt_re: Allow bigger user MRs
Message-ID: <20210118210129.GC797553@nvidia.com>
References: <1610012608-14528-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1610012608-14528-1-git-send-email-selvin.xavier@broadcom.com>
X-ClientProxiedBy: BLAPR03CA0099.namprd03.prod.outlook.com
 (2603:10b6:208:32a::14) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BLAPR03CA0099.namprd03.prod.outlook.com (2603:10b6:208:32a::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11 via Frontend Transport; Mon, 18 Jan 2021 21:01:30 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l1beT-003LVM-2E; Mon, 18 Jan 2021 17:01:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1611003697; bh=0IPLrH9pz/vRSbU79iR03d24Ywg9TZF5tSzEBqOLqdE=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=U03450XMTksJU7PwoDvKpwfXxO6HQLxJK7Gk8BMoQbSqcIlkiSJc25iK5scAiIIqn
         /QvA3z5ZaMbqvgg45ZNyUH0phpUWs3Sa1QWN6dtCTea0KOlT85Gzu0kRy85jdgCdKN
         QKKLc6UDH5U6Ntbbzxsw7eToaFpJpSDgyMnK9XwFydptPgSJzlJ6aXU0obAaiOxSrL
         +/jsK+P3o3kq1j2GTNzczA9P7urlaGtG05tkobxrCeo1LyzCCc6WSbbCcn0ngktHh6
         ZmuZJf8DDt2b0htVvQUczF8WcgrG7b3a/c+Y0yvKVNyoIuSnxrlXztuu8rD4lppSK3
         5StQjHcaYQtrw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 07, 2021 at 01:43:26AM -0800, Selvin Xavier wrote:
> Refactor user space MR code to handle bigger MRs. Removes couple of checks
> that prevented the bigger MRs.
> 
> v1->v2:
>  - Fix the build warning
>    Reported-by: kernel test robot <lkp@intel.com>
> 
> Selvin Xavier (2):
>   RDMA/bnxt_re: Code refactor while populating user MRs
>   RDMA/bnxt_re: Allow bigger MR creation

Applied to for-next, thanks

Jason
