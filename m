Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9C426AE69
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Sep 2020 22:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbgIOUGQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Sep 2020 16:06:16 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:15820 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727909AbgIOUGF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Sep 2020 16:06:05 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f611cb80000>; Tue, 15 Sep 2020 12:57:44 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 15 Sep 2020 13:00:06 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 15 Sep 2020 13:00:06 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 15 Sep
 2020 20:00:04 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.57) by
 HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 15 Sep 2020 20:00:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ippngpFmprHZwgJVMfPPGyi56SlCUzvUbk6yR50bVXCSIlF5O6hnLRIrjm+i3jFKzIsemcWEgNz+/q2lFBU0yhXBXQ0PYy50M1rKqAMKGpTn55Xo20TMZYCUYs0WrYqh7O9vo90A+29PAUF19AWd7oV5CBRYDzPP+JmnRDBoLC17/pGCCrNPq6WZPRM6tWm5gEK2Zq7U59xYBdsiDKWNp9PUBRtF6UAEHTFqaxvSEuxmf4gZu1COEDMZXlQCc2LuGJgAHiJb0tJixwJG4nVRVNip10VnYL6yr9n0Jk6hgZA09Ys0C7K6qwpNBw5MI8lwmOMTLqDS3k6DySucxlGRfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AU74w4KsKToEhSgjaqFS1wIkoIDlp8pwroMHx+Jkgqs=;
 b=C9Ookur65Anfo1oOCm8kXVo+7QTeB6IWoViJ9bZ4tozW4+OC71Gs635UyPHe6Yavov4M23gHYUgfKmx4qjvHuFR60ybnL+IiHJQ1TGq/thqoPCpVOI7ZfP9LLbw62SS/Bb7JAOmImXsgHzds4AKsvE9AG18Sd6MHwGpi7nEN1KdJUFmYJLzWL9ehrmvh1GeEUKP2pOKTNSDArw1RdUfmr48EBhPuKZe0aQgKD7XAShPKCq7orJPjH4H0UHV7FhM0e+3kjOqcaxvlSjZFtwgVhxG14Nq9HT0dMvfX27osXgaROJLr2MqvUcIRhCEJOc37Gp2c3SQJTuFh1a7ZnP697g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: marvell.com; dkim=none (message not signed)
 header.d=none;marvell.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0105.namprd12.prod.outlook.com (2603:10b6:4:54::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Tue, 15 Sep
 2020 20:00:03 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3391.011; Tue, 15 Sep 2020
 20:00:03 +0000
Date:   Tue, 15 Sep 2020 17:00:00 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yuval Basson <ybason@marvell.com>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>
Subject: Re: [PATCH rdma-next] qedr: Add support for user mode XRC-SRQ's
Message-ID: <20200915200000.GA1592368@nvidia.com>
References: <20200722102339.30104-1-ybason@marvell.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200722102339.30104-1-ybason@marvell.com>
X-ClientProxiedBy: YQXPR0101CA0067.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::44) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YQXPR0101CA0067.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:14::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Tue, 15 Sep 2020 20:00:02 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kIH7Q-006gI4-Iu; Tue, 15 Sep 2020 17:00:00 -0300
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1245aebd-1b7d-4fea-306a-08d859b1eecc
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0105:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0105AF5627C83E97A4BB770BC2200@DM5PR1201MB0105.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WKeRFqzDi+OkHnWYynrJfasq6g1MhoABOO/J3GyU/FTd0kKV8bN2qAopR41ccQ3LfmtHHtAIJl3poFndJ2oPSNfBmqBeW/EYU9av7kWX8jAR3ekCYPrfpYo83zWbFktx4TFyERt+E8J+aZOHo3Xl3QaDVsxd9T0l5c6U+BxWpJymasVLDvsmh2KqNRANziEhDVTj7nd5nFiWmDXEiOi7HqhhTEyWy2HAi7AcRU6lVp5gwab3EecUvUH39+fejOOuIejxsgvHZ+AW4/PN3nR0E0m5H0H9czemeJdRqQiJgPouHa/X7XZzWzb/q5nUnwy2nuQaT9tLsdqofFgbvPq3ig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(478600001)(1076003)(6916009)(186003)(36756003)(4744005)(4326008)(426003)(26005)(9746002)(8936002)(8676002)(2906002)(83380400001)(66556008)(9786002)(66476007)(66946007)(2616005)(5660300002)(33656002)(86362001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Kh834gRzDoX3nm3i1xTHSZeYkYBe7Ilt7mHeXR+fRU1qhjFmsdh4daK91B5Wyv7nujhsJyNNc1sMRW1r20aMk+7cNCFX29AYADzXIc7Az1ANgMLd8xMt+eC7dYzuOTYs+6H8fid3QRaS9mWNkcO8FSkeKAvptF2tHH7BL/uy9545QtjgxNhe6VE+H+VyTJ13XcwCWbh+F/nHP3Idik1XqF1AQMELdYdP+cPWi0PEZfpj4Uz8U8BXXUYck9nlv+mMD+wTgHma1hoE7shiXn7kEANOUsJR8TAnrAzoKBU6kW/u+Hab4Uc9U0wefVLCpNvxECHIp/AUCVAjOpGcAs6V/NLAL1qPOtHJoLLzoynXhg995UGvtvPYW4hOLFqEjIw0DaKWYvNfmw+aZuivlF7MpSPc8amy1OMaL2x1wrKMmMDqXMTlqq5iP7T9ShXo/KobQcG6rZ5HQOkU2jP4tCND30NIiDT33vmyngdcu6319ss5Zys6ld+jl4NKY2fcy1Rx1KF/pfS42BMNkVF3ylqMtN6RaIojKuoQB2RCrek12uVgzXQZxzI572mJg/lghfvTasAbRyDvt5eDU7Kw53Y5h5+dbvXRfliRNJha+UgHGRiAhJ2DkRpWsHqIGFvGMP6fY4VbDhybwvtNIbtCk5SJdg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1245aebd-1b7d-4fea-306a-08d859b1eecc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2020 20:00:03.1173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x4+aduHOfo9jVn7/bYFJa8Vfii4UB5rBeNO88h6av066xJOJ73jxI/IZOrf6sVii
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0105
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600199864; bh=AU74w4KsKToEhSgjaqFS1wIkoIDlp8pwroMHx+Jkgqs=;
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
        b=UYjyhPvds3gTGxkKCNzbDMD3qGEnIBQ0OClzSDW3Fxo1cQcfcY0QdVCMQOpBBmFWe
         A0zOwTJ8r/bYfXf/766O1jCrzqYVZjNkyDomkVLhdBqQp43n5T48oycRXZ7rZ1dhs3
         0dOehrsyt8OVrvc5WQAvl88XYvbI0fin2gQrUl+A792qC4bDRtgKxOlnIyz0yDiI2p
         3fN8yJEWK52VaQzr3/3QPSbYPX1RC1hEixOOKC0hTlVqUYoa0S3TERXDv+5z+sk+jS
         mg1nazcW5ptENDTLhyvAcfDFS6PFU9+67YZVjS4aG8naPttYS0Dml3xrV89ymFq6Ie
         6tTvNZmt7RYpg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 22, 2020 at 01:23:39PM +0300, Yuval Basson wrote:
> Implement the XRC specific verbs.
> The additional QP type introduced new logic to the rest of the verbs that
> now require distinguishing whether a QP has an "RQ" or an "SQ" or both.
> 
> Signed-off-by: Michal Kalderon <mkalderon@marvell.com>
> Signed-off-by: Yuval Basson <ybason@marvell.com>
> ---
>  drivers/infiniband/hw/qedr/main.c  |  19 +++
>  drivers/infiniband/hw/qedr/qedr.h  |  33 +++++
>  drivers/infiniband/hw/qedr/verbs.c | 291 +++++++++++++++++++++++++------------
>  drivers/infiniband/hw/qedr/verbs.h |   4 +-
>  4 files changed, 255 insertions(+), 92 deletions(-)

Applied to for-next

Thanks,
Jason
