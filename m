Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 481D1248BAD
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Aug 2020 18:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgHRQdc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Aug 2020 12:33:32 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:15090 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgHRQdZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Aug 2020 12:33:25 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f3c02640000>; Tue, 18 Aug 2020 09:31:32 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 18 Aug 2020 09:33:25 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 18 Aug 2020 09:33:25 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Aug
 2020 16:33:21 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 18 Aug 2020 16:33:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nlnptnv9XalTbnBL6cziqPaQP9x34/2mb/7VAls4GjZyFJAg01Yat1Zc8gbQYFHyS1gNWnlhMC+LL8jxk4GWlEcSA62im5/UHNtZsTdbfsNCNRdmOCBvdP50rlPW5QBY22G4QCKJ1nhQ/8yiQwz3CUDHtw8ZWYMwsipolnzSCq6GXYghDxeVJcQ2U7uNYEHX8a3B1Tpvu6CcuDZO3ceEYZI23u/S2HHFKBTmA2Y5UOZ5Gl3PY6HRldKhinkzVvW8CYhKQAzFlKoHApY5T+WljfsZmmqz1aJKiZhXm550W6pmu2+ptyR8ZxMqm5axMRpbhnQ9XGZge0QjbNO7ADBShg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKmQx42WH1jtTAWWauDXsLN8s7Mh1FeQqP9jKSOJACk=;
 b=iBKBrjC7jqffknIJS/TiPQupsocGj+0U5qHuvsZB+2NJluEHaz2w3fb/3wV7lxkHvPb5jPMCDoZ/Zebkf83TKZ+JjoBgfd2hYUy/Qx9oetYe3KPp0AUUm+TZDkVXn4TIkTLOtmkKD5E+P4anMpeOTvYPc0avrS0S25w8bmYWQt5HzwA4v1s2YcsPAl9IasiCf3WxfnDNUUpue7QG2kO02CIMw5w9KIhsXi5e2eP4JsaebyQlljJtAFPN3VDejd+NwIIdSzNeYKtXFbrHnCphf2A0g9nzdKDRqyG21Rmpp9N9AyysZtITMNrJrdXjDr4h0YHm+RHrV8/bSzXdVSfFDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Tue, 18 Aug
 2020 16:33:20 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3283.028; Tue, 18 Aug 2020
 16:33:20 +0000
Date:   Tue, 18 Aug 2020 13:33:18 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Colin King <colin.king@canonical.com>
CC:     Lijun Ou <oulijun@huawei.com>, Wei Hu <huwei87@hisilicon.com>,
        Weihang Li <liweihang@huawei.com>,
        Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RDMA/hns: fix spelling mistake "epmty" -> "empty"
Message-ID: <20200818163318.GA1990081@nvidia.com>
References: <20200805141111.22804-1-colin.king@canonical.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200805141111.22804-1-colin.king@canonical.com>
X-ClientProxiedBy: BL0PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:208:2d::41) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR03CA0028.namprd03.prod.outlook.com (2603:10b6:208:2d::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend Transport; Tue, 18 Aug 2020 16:33:19 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1k84Y2-008Lig-6F; Tue, 18 Aug 2020 13:33:18 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2aea7959-8d5a-420f-92aa-08d843946a74
X-MS-TrafficTypeDiagnostic: DM6PR12MB2939:
X-Microsoft-Antispam-PRVS: <DM6PR12MB29398E1FEE291CEDE62BCCB5C25C0@DM6PR12MB2939.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BRcwj9ZR+JfyVt0o/Eu1uG7FKbPvCNQMnid8zaTQI/0TosyFwKRw/dngbchcOLVsIMnogBYmJmYY3fHZfgO0QnMUEfdRDIlFk++sUFO4Jrv/QgScAIDye0WXDbU2jKF3ZvXdBOKSyrmcfH+m1A8J4HACVWGkyTWs+QNwdg9i6G4ucWWZwzvabl9JLP4ABYZyhePTiU+ameWcbtNZl1utw3Wa/D8T3DtUpgTA/9wgs5/lPIlthMNShMSy0TVUXc69dFW4SycvjpJBsW4x3aRCuGVmOO74xrgfXbEY+YjmeOshubZzC2YmciSTQiLKGJhF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(66946007)(33656002)(9746002)(9786002)(83380400001)(478600001)(2906002)(8936002)(426003)(2616005)(6916009)(316002)(8676002)(186003)(66476007)(66556008)(1076003)(4744005)(36756003)(54906003)(5660300002)(86362001)(26005)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: V2yLjsBIpOokAzqLlezeCChCKJibMATFwAnByHestemyOINKXh+bz8HBMnOWOQfXvNf3FFEVgh28T2tJE4DFxca0drtm1nSwxI733ZuMtU/5oPvT5uXzwmcrox4maaqtAAW5k/qVj/SO1bubg3asTzxNdjy0R9+U9wjdX59LXFsiypt3sTcFaBGhNGJFkuQUb5add+HjFK2Ba7WAnF8BxjcwEdGHRk1NpnCzesoJ/bZj8SSmOBtNhlrmsagzSnE9/0a0VBrZVsKvUKNSXvGMaBAPGadpVtyrydSMsXA7wXSIaOEWFwABNljy6og5eX5n+mZJQuE3aBSBq5B2XCpyHhyZSNHMeA403knOL4fb5wr+XbKcx0hpljfszlgwi118WAPRXbzycTced9iwmhnBn8Lo8HRaRVbIQab/jEYu/u6ZqnZ6+Rt9VuNUOJDqvn9//gjhCBAGgCWliNk4ugL0UABbhloNzTaaXzDBPU7ThsV2fM3hRrD6pYXGDruRrdUPACo6IgPUwKo6kiQVUSGThEomiM4JFGum3L4boALG6ZwWEsOLD6/IrJVaCr1nrv24qS6VRPhMzEdbRgjFX94IFZnmw5FID68mspDFxoXoQU1ktLLWDZQCEl8jDSlp24pVqh1bl3Bssgl88pftC7mPXw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aea7959-8d5a-420f-92aa-08d843946a74
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2020 16:33:20.0046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SiNPu4/WYh3Xrwx3O9oW/y3ZK7j+mNiRK3Dm6H/J0mY7pnvk6YVXod4IcDag/MQa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2939
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1597768292; bh=tKmQx42WH1jtTAWWauDXsLN8s7Mh1FeQqP9jKSOJACk=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=W6Q8Ev9m85vO+H1AA4prGTukQj0WMM3b7qqF7LGs5lJ284lzhzPNY/eZO0nF1rMhs
         sFaTMgQkwHNIQVbiYurQpmO3gHyAV72TBSwZ6BTEOtSjZ6R6vb43l7IcO4hf6pJaSE
         noz+XbFw25UiBcZTBqcWskCFkfdEMVYnYv30ksUkNHzAEoiSnZzfchR8pd2FE+Qk/Z
         kBTHQ1S+E2YqB2HClvqmEXBXXiU9chb6qHb60iGSSUEsxfJi3vE6QhWo2KSW6sOM93
         KOahu0UAPIJyFPqg0P5e12GcVsQt5Hx72cFA2D3jNKdcyEcbS+rSHywWL63joAdeVD
         OdQddSxkFO6xg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 05, 2020 at 03:11:11PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a dev_dbg message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-rc, thanks

Jason
