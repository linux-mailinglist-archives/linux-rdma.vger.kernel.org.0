Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 583F5222BBD
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jul 2020 21:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729341AbgGPTRT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jul 2020 15:17:19 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:11272 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728541AbgGPTRS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 Jul 2020 15:17:18 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f10a7bc0000>; Fri, 17 Jul 2020 03:17:16 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Thu, 16 Jul 2020 12:17:16 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Thu, 16 Jul 2020 12:17:16 -0700
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 Jul
 2020 19:17:16 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 16 Jul 2020 19:17:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZLKqUr3P5lJjWWvkX0PEvgTg8SouxjFZezrHKf6TkPbkzdvEw65d40bMLwDLcH+E+P+OSVo2Zer8snUY/T/Rj2FncdDxQkYSBG1d4Ovc7rOmARD4/N1pHWkW2E4Ln8Z7DeYSOdTPEnNAFMQdA2yj/4JSSrbAdo+kpEqKyaJS0HAXe45nrD7IadPLhgcuqIVlz6ku9PUm/c99sTLSSCYGaPio67RT/Bjr78EZ7vit/gkNOQQKi5KZ1I1nGvulLJ0tWblePqD0oM9SLlI0Id0t2DCkCnCA0AYz0kvB4t99K4x4vHCq4ikFxWtm51OLIAS85s1b/fWmHkyCBmkeXKBUhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMUGpRrznbe73UXR8ImmaXLu5JVEaY8aHOvmQowRDL4=;
 b=UlOCdyGcdfNl8QeBMJjmG4s5qcETZZFu2raGmVE64D8bSSnTQSsOVpaOOALXGxYCy5nqclueSuPdMC5qwCR0EPZOAJxZe/RWCw142DQa2mdp4xhHjUV7fGBbYmLT2CyQLPs+z5HA/sTJiVqpfd8+gUk+pUcYF8pROp9qkrkkhW8BzEtsNsYiSLT7+0+miUfbPMCAMMs5a74EsL7OEhatxcD3o+COTpXjd3hbvzmYD5FwkaoZwX9MxIop7TBtuBbOdtEH8qZf6AlcWiw1X//f3u+M4kP8GVPIrUjnWq2AAw5dHrjISztjNfDBl7GO1jwNSRUBLmLa9zzY9rNsHHptWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: yadro.com; dkim=none (message not signed)
 header.d=none;yadro.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2438.namprd12.prod.outlook.com (2603:10b6:4:b5::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Thu, 16 Jul
 2020 19:17:14 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3174.026; Thu, 16 Jul 2020
 19:17:14 +0000
Date:   Thu, 16 Jul 2020 16:17:12 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     <m.malygin@yadro.com>
CC:     <linux-rdma@vger.kernel.org>, <linux@yadro.com>,
        Sergey Kojushev <s.kojushev@yadro.com>
Subject: Re: [PATCH v2] rdma_rxe: Prevent access to wr->next ptr afrer wr is
 posted to send queue
Message-ID: <20200716191712.GA2687753@nvidia.com>
References: <20200609125411.13268-1-m.malygin@yadro.com>
 <20200716190340.23453-1-m.malygin@yadro.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200716190340.23453-1-m.malygin@yadro.com>
X-ClientProxiedBy: MN2PR05CA0060.namprd05.prod.outlook.com
 (2603:10b6:208:236::29) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR05CA0060.namprd05.prod.outlook.com (2603:10b6:208:236::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.10 via Frontend Transport; Thu, 16 Jul 2020 19:17:13 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jw9NY-00BHEX-Ft; Thu, 16 Jul 2020 16:17:12 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc6cfbcc-e9ea-4269-8fbb-08d829bcd8be
X-MS-TrafficTypeDiagnostic: DM5PR12MB2438:
X-Microsoft-Antispam-PRVS: <DM5PR12MB243830419D30914453F21A00C27F0@DM5PR12MB2438.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 92rzlrgp1RJBelW1jO+89Wl7lF/UyNHRR3TFKT7ZZu37OJ54Qce/sFS8j1P7hbvT7MX9h3vowC1LRQ9r53iWKhDMS74K8HPM3ARoDIsnhjKh345ufENpjeC3MzNSUH/RXBQOSvOVWOqI/V63ut41xdZ9PfjtGztPjNrVRRNfKO0w0AVe7WPdQiySH2USQ673l24L9F1/Fqd/mFxMEeesN3VGFRUN6RgmiZPIn0A/N+r7kp1MuqDlLfx9EtHVTT45cAi94ePyCWM0E3CPcL8Gqagy9S9FqGxsZmjM832wx5SIz4cvh78sgWtQO0RxBVKc1ogmT11/Tg2ZoReAE8b0/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(376002)(366004)(136003)(396003)(346002)(9746002)(316002)(36756003)(478600001)(4744005)(426003)(9786002)(33656002)(4326008)(86362001)(2906002)(2616005)(1076003)(8676002)(8936002)(186003)(26005)(83380400001)(66476007)(6916009)(66946007)(5660300002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Ud+4hPv4RKyp2p4Ct9j8TKkf+H0J8tIrHU3hJoGYg+nDx1gssJDXgS8wABBkaVWHx6NWg5F8HbRM9VJr89HBp+jBVKLQXuDIY0WI4vvY7/uIk8SRMIPfjRhD0ZXsiHm0OCbDexQHBnXPE7Oo5OhHAnnrmCwBqpqR3JNZBF9Qmn++AhwpfeI6cjj9ughScZL6G+WM2sEcrN9tzV7hZM/0Te0cQElSMNRWQ56eXIjxISBa9JYbhlnPrD3zyzKYEOI8kvwR66/VLIC7FX2LkIcsGmxykjo0HuejP9I66IBEiQZB9uqDqpXD4r9hJUCpY7wDo1y/E/n/qkARLgNrpGfTmwcprVfauZ+FmNXS4vGHI8pbrerV0Nzj9vPPMU0AQkms3Xis3CXC83Ohc6p6h5hPK4u62IdkjHdOw+Z0M0lqN8c7mAd9wEFjoO9kGaYAeK5pW1VS7ha+FYMdInyI16pLyyrpC8+xLlVinOfx6y+KwpY=
X-MS-Exchange-CrossTenant-Network-Message-Id: cc6cfbcc-e9ea-4269-8fbb-08d829bcd8be
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 19:17:14.1342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o2zA1FG8T2eCD+PfsnIFruRKsBfO+FvGZEhnWBzaOAZKhkM829q/UhnjVPHPdx4k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2438
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594927036; bh=aMUGpRrznbe73UXR8ImmaXLu5JVEaY8aHOvmQowRDL4=;
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
        b=fVzK1iSGMaOBL0+znKeJmLmTyLCZusA+RSzpuT/SnN9gBveJJSd7FKfvV/sdf3bUn
         /Nq0vidubrY1xXLkWh4aBK9F8zc2UdxVbBkuaEfXKTL2TJgoNmPzX67UtDjq4WQwT9
         MzxPY8ec2g3D6Gce6Tnx6ECBMB0F1zotQRmLFvOW4LsXLUnHUPLbyzHujSi9zc+KAE
         CufbA75U83EuMrzdx9x1qndZunvrWJC3RrlHfwXd8/garZ60uIh1YA0neZItU3QCgO
         OWk1eJ8DzDLXcT265PzUolm/TtgPom32yxrB/oZOi8vM5d4JoP+JnNalCxDJIf20rM
         kB5p3i/aQ6mNg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 16, 2020 at 10:03:41PM +0300, m.malygin@yadro.com wrote:
> From: Mikhail Malygin <m.malygin@yadro.com>
> 
> rxe_post_send_kernel() iterates over linked list of wr's, until the wr->next ptr is NULL.
> However it we've got an interrupt after last wr is posted, control may be returned
> to the code after send completion callback is executed and wr memory is freed.
> As a result, wr->next pointer may contain incorrect value leading to panic.
> 
> Signed-off-by: Mikhail Malygin <m.malygin@yadro.com>
> Signed-off-by: Sergey Kojushev <s.kojushev@yadro.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_verbs.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Applied to for-next, thanks

Jason
