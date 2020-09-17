Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF1D326E586
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Sep 2020 21:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgIQTyZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Sep 2020 15:54:25 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:3120 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbgIQPOQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Sep 2020 11:14:16 -0400
X-Greylist: delayed 332 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 11:14:15 EDT
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f637bd40000>; Thu, 17 Sep 2020 08:08:04 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 17 Sep 2020 08:08:16 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 17 Sep 2020 08:08:16 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 17 Sep
 2020 15:08:16 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.58) by
 HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 17 Sep 2020 15:08:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A0AxxSLESq3QCuulZ711c/wPu5436Mg+KsPmOV212lQe3DFt06JV3IpjDjKb5HleTZ9k32JTZyzxhHS/i3+Y+49SkqcN/Smzn01P/7C5gPnHVN8EEtDzYHsuauSDOfg6g6/V6aRBF/RlmbkZOWXB9gMv+JMJAzBxPy0p6KdGY8NEfBAOUeLgfjoDzrDxXZtHVEXVV4YgXrPsR7DlRupEY8sDezyVkHWbvOGh1wWfyQIwkjn/zNtCQSx7xCv7nfU0FnrXM8lD3BvLtdUoVRsalZ0bLTbMInsF0G1s2seQDl8Jk+G6P2xEAhmaPfR1gOwE34YHm9b4l6/mDSYaiLPFjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MY7F/ezpMHcNE/qrWu6POgwDN0bVfPwFYTDLmj3E2H8=;
 b=U7sJIX2yz1ZoWZG7D3gYtOg+UhnLKoDtGP0boB8e+n/0irSe3/VL1WBLYKhg5/25eQiCVjeHd37Ntz/7uMZ3ngEOf/A7cPAs9o8s5ZUODEntfmRCP21FY8xAqaRtDhskQur2x8GHfWWLtenJNXy7Rf7IDQflwdx5X5YTF7ieVyDM9rr05VEXgT4gXViWB1PREAr7uolbpv+8xWCn73//BWwmIdzOv/vbjNxHMWmVOVfEOk8pPyMSsN/TxN3NP7yBomVorpZma+N8AZcdpPxlxpa025GUGvKX+p7rnpN9ll8PTPRIJy/MVfBXQwcWqPAnzVkiVo6ZOXyDC9zS2Wuk8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB2491.namprd12.prod.outlook.com (2603:10b6:3:eb::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Thu, 17 Sep
 2020 15:08:15 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3391.011; Thu, 17 Sep 2020
 15:08:15 +0000
Date:   Thu, 17 Sep 2020 12:08:13 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        <linux-rdma@vger.kernel.org>, Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH rdma-next v3] RDMA/mlx4: Provide port number for special
 QPs
Message-ID: <20200917150813.GN3699@nvidia.com>
References: <20200914111857.344434-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200914111857.344434-1-leon@kernel.org>
X-ClientProxiedBy: MN2PR17CA0020.namprd17.prod.outlook.com
 (2603:10b6:208:15e::33) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR17CA0020.namprd17.prod.outlook.com (2603:10b6:208:15e::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13 via Frontend Transport; Thu, 17 Sep 2020 15:08:15 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kIvW9-000VeF-Vd; Thu, 17 Sep 2020 12:08:13 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e44457e-e6b6-49a9-032b-08d85b1b8084
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2491:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB24918433A6DDB91BF33E02EAC23E0@DM5PR1201MB2491.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6ATAWdnWmUwTq9XtVsJLDxFZew3eDZeUtLFkEPw2uiwZJWk91Ue0lZTgPr2aDX42XDG1JgM8Eaw5//3fPrF8/gS2Gl0pMrFWu8ZnBy63gVYKJJSgCUpExKepFHBtGGw/gHtNpokXC3mKvf8Y6tN1G4/1bYtwQ36JHrxMVRO9AnRVliDn6F+PdemIypv7i1ZL/WbiGmmRjpmJFEYqB6azAFQ7qVK2JJhZGH3jThXfuUC/qyHc8aL48/IYX/ntHYaITRLp7aQgDqTKrK3SFhPMg5YjGV1nvBR/gu9bg6QJD0Y4YBDOvNaEe9tUZLj3JncH6Jzuz6WzbwUx02iw24mdaeLFyu/jdhtTMmfuTVDobS8wqKHa+gFlM8wwpoiBH/vDj1b2+h1gxzp5HNs+K2Wvjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(2616005)(107886003)(83380400001)(4326008)(26005)(478600001)(966005)(426003)(9746002)(8936002)(316002)(9786002)(54906003)(66946007)(36756003)(66476007)(6916009)(66556008)(186003)(86362001)(5660300002)(2906002)(1076003)(8676002)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: yzLigdbYhKlLM6BrmydGBc3vcKnPTyRx/Jsv2CPBHJVuc8eBTq4Wj0Ow3UAsJlNh0zJ8QEktBTjZqIfvjmpLH9oLUTKiWHlj0pZyZuJHmQZtNxwE+K5XA/Nsr938my8Y60jkszdKn/PaW3TbG1dBJ+cZNtAjHYKBB9mwBWAGMVF4pW5ndHhH6P7eMBPfvEVWkdlLCEkLPMbNiSs4E0BoKgEvmwQQSczTZ5j4GkZZgl7hgABnaGsI/OeJQKlV+Q3hpY/ZvteTnGMT8C0yulnbX3oy9rv4bccyp2HkbWSXlAwFxpCl9Ec63EKu7ZNpSkRWDFAE1gxlcQuc5G1UAgxvoSQDVuvEVrWwY0RCtbdF4PRARJsK7zSenxDmDb3rdZAtXBPZ+S39JHMGeHJvU0F0n8O4rjrMrRD9jCsUcCL3y+fRvnMj3PzeVq5Lk2OV98zGZEU7kEJP0WJfXbJmbps+BcaYvuvjCmyyO1T0VMEqSwTHNdmngxEbLXd8OoAQUT++hjBRCRfokJ2ZOiHMh4DZXT8kVvGQT0cBfH+SqRTGq+tLnsNQhlI8pKN/3sMa4Zi5lhXx4CmakUPT87XFDArCRW4wkSuBwL52IxQupucjYZlwTLwohxqDSTS4Q0uNv0dDe2aGEMK+2c70QgbcETCtVQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e44457e-e6b6-49a9-032b-08d85b1b8084
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 15:08:15.3093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l+Wor1F2S6WC8sGtAwPwtlXFkB70eq475fyjYhn1/Z0n+FYjJrE279FmT7JbwS+N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2491
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600355284; bh=MY7F/ezpMHcNE/qrWu6POgwDN0bVfPwFYTDLmj3E2H8=;
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
        b=qJhDoArz26NkixWSR+sluPIQ2jj5yx9zlfeegkS0iEiiBZdQBR8fcL53RWeGIzl3h
         T+rW8cp+kWnQup50ACY+EdkkseGQj2tzSJnGttOQhNmGsfvVl/fO4v/3PMhxcUx8VI
         bz6wkaKsa9jI1/qnVNB1fm6XtpkaDOKeSgZ0lfKiTDRuy93AR4kjsG+zFpuUV6jPIL
         ng9LmWCrZQv2zi23DbJoYb0vIHCKTHGNANieTuVgTA6k6SEJEywg/lCRdr6WLzG6Bc
         KwqsrtoppAFmfFmv8IvGpLKhehJoV6tiFJ6OjxbLAdw7MQxy61XVBI0kedYs5965Jq
         sANSuVNM1Zkwg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 14, 2020 at 02:18:57PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Special QPs created by mlx4 have same QP port borrowed from
> the context, while they are expected to have different ones.
> 
> Fix it by using HW physical port instead.
> 
> It fixes the following error during driver init:
> [   12.074150] mlx4_core 0000:05:00.0: mlx4_ib: initializing demux service for 128 qp1 clients
> [   12.084036] <mlx4_ib> create_pv_sqp: Couldn't create special QP (-16)
> [   12.085123] <mlx4_ib> create_pv_resources: Couldn't create  QP1 (-16)
> [   12.088300] mlx4_en: Mellanox ConnectX HCA Ethernet driver v4.0-0
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  Changelog:
> v3: mlx4 devices create 2 special QPs in SRIOV mode, separate them by
> port number and special bit. The mlx4 is limited to two ports and not
> going to be extended, and the port_num is not forwarded to FW too, so
> it is safe.
> v2: https://lore.kernel.org/linux-rdma/20200907122156.478360-4-leon@kernel.org/#r
> ---
>  drivers/infiniband/hw/mlx4/mad.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

I didn't understand why this was in the restrack series, and the
commit doesn't say when the error can be hit

No fixes line?

Jason
