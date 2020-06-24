Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C85A6207C57
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jun 2020 21:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391327AbgFXTp4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Jun 2020 15:45:56 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:19542 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391324AbgFXTpz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 24 Jun 2020 15:45:55 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef3ad160000>; Wed, 24 Jun 2020 12:44:22 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 24 Jun 2020 12:45:55 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 24 Jun 2020 12:45:55 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 24 Jun
 2020 19:45:45 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 24 Jun 2020 19:45:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dTepn0XT70CWJWxF4kaianoXMA2WuqSdc7K1PVW57u/p00GZZu8josAYj+mB06GX5Asgmeh1X02pUEj9945K92vAkkvV4alVKJxdmbOHuUeo89a8l/o1F5X/nWx1IJ59V2X7ocMHqXiN+9S+zcV2N7J/SFyg2Y4Xte7EKme9RPuBcd3LA1y6ObYKVuitE97LfsWyxARsVtNO7wCiGHHfl1RE+FeO/Q0aBspNWMF11TlYRhq55Dn5Z4nRpzL1AuqXly4VDispPpGwNbUGZ5kMeehQUY+AJi2UDOc3mfYVpknWpsNt8/464Dqruu6A/kSJjP//mx09hiW7hiTNuLelIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kuPI2Di+DIDffUlKG6VcYk+ZjS4AkgZqfOBzWRPFDMc=;
 b=BaKx3md7UBiV3O2ucZcr4jkhDk0P0WBuS9l5eVCj6A/bMEZ84l/W7wnjf5hnkhdETWnfYncl3+ZyPDwrzbHugBUPgC47nvJ5lTPE7NAQ8FIi+H1x0EP7nVsiAEi/dVWHzmA+Bv6yrBijRMo0/eDEXM1rYBcwhyEjejepO1qOhvb7Zz2LPvmQPpzv2DmMd0yXSVffwqeyjT6/gx5yFD/058JkgddAq/L6Lu9rt3yFhDPwKJXhnhxfg6TVP3YVGoS0q9nkH3QJIvSU1BEpT0aknjMXsaJVJv3L9kYHK4mAS9AtgJSBmPn4ObxQOkNpkCpT6F3qSRsSWgvr8L9TKKPgAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3516.namprd12.prod.outlook.com (2603:10b6:5:18b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Wed, 24 Jun
 2020 19:45:45 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3109.027; Wed, 24 Jun 2020
 19:45:45 +0000
Date:   Wed, 24 Jun 2020 16:45:43 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        Maor Gottlieb <maorg@mellanox.com>,
        Shay Drory <shayd@mellanox.com>,
        "willy@infradead.org" <willy@infradead.org>
Subject: Re: [PATCH rdma-next 0/4] Bag of fixes and refactoring in MAD layer
Message-ID: <20200624194543.GA3280695@mellanox.com>
References: <20200621104738.54850-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200621104738.54850-1-leon@kernel.org>
X-NVConfidentiality: public
X-ClientProxiedBy: YTOPR0101CA0065.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::42) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YTOPR0101CA0065.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend Transport; Wed, 24 Jun 2020 19:45:44 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1joBL5-00DlT8-8c; Wed, 24 Jun 2020 16:45:43 -0300
X-NVConfidentiality: public
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8eebcd84-9c9c-46c7-95b1-08d818772f68
X-MS-TrafficTypeDiagnostic: DM6PR12MB3516:
X-Microsoft-Antispam-PRVS: <DM6PR12MB35166BF10E3C77CA7DACFD1FC2950@DM6PR12MB3516.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0444EB1997
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E93bixFcY37KqdF0N/6RE2TyWbb7eNA+olQXVIcQ9MMajwALHZYOirwQzBIN3FOB2m+OSceFQaR6nJoaGh9i5uWBMroFZ5mmnddBZ1mVOlNg7/vtU5ATfqd7Qn+2DLtB5fK6zzSZlcENsqGVQpEH5Fb73YYiwphoekwqSgD78dJO8yJEyVCt4qrYMAptvQTYDtuLvD1PVPePhMLhfEfRXxmag068S+OxiPaRkeG6nR7pqxEEzs+v5iSkUstFZFSB5AeI6aKNAHI7UpXYHXWAJe651c8d0tItRn+zvZVeiykmT1fkVudkGwsfNGG/xn3CgK/4C3z0SMOj9x33YMN1uw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(346002)(366004)(396003)(136003)(376002)(6916009)(66556008)(54906003)(66476007)(9746002)(66946007)(9786002)(9686003)(316002)(8676002)(2906002)(4326008)(478600001)(26005)(426003)(4744005)(1076003)(33656002)(5660300002)(186003)(8936002)(36756003)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: r9ymiJU5KuqF0ht9X3QNgJwFpfIfV6cAIQnFMP6BWpjux24pYc1oxHXXgcP2bO2YmTUZDomdM2lqmlh7gGsiMuaXqYBYO8ERYmuDCyBKngvHKvY/NYsXRKt/fPGzajPLOVJ3qH6rIOJpM1NAlxz7JxUBV96B0KQ9sTHdKhxTzoNr+lAjB8oSkeh9VeFtD9BUid8TekryQ/TgF0w+MS/cN4olERJb45GTvb630OGNOV+wtB+b6PbzPNurtmcLkpIkY7norszjiUIdnnbJSDSxlhCcU+dS4ws7cswraWtlFozpHm4rpyEUbl1U5Sl+fMW5DjUjJVbhLBs7rusykX7tFMegpBiRNPlFBze7wonWI0ylxzz02mJgPnxTNJjWAPQz3sa3cnn7omeVxMmXBsGYumTVo/aV1jiYFqojQnKEmg59qivK9Oxffn/YhLwsc1w45rAd41BXB8rcIr83GQBrwsESQyBEXA+usQ5DlcI2LHng6nhXnaEy5syT3EeB5Qg/
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eebcd84-9c9c-46c7-95b1-08d818772f68
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2020 19:45:45.0702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RZBHNhEAItubY/vZl7uXgCl+uopfnJhXbNUTKWxDxRbq+bTZ1Wx0yL1f6qLfKDPX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3516
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593027862; bh=kuPI2Di+DIDffUlKG6VcYk+ZjS4AkgZqfOBzWRPFDMc=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-NVConfidentiality:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-NVConfidentiality:
         X-Originating-IP:X-MS-PublicTrafficType:
         X-MS-Office365-Filtering-Correlation-Id:X-MS-TrafficTypeDiagnostic:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
         X-Forefront-PRVS:X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=S21OQMOj+NVBdljvEtfbdqCJC1mb4GvHw0Z8s6mWQAns6MuXqbNxI1Rt9vxvTqnLl
         HNxQP5kNwKGrPCwYQeyGZE07t59Y3TQguGxiQXqSNTukNp/P1+Am/z3VlfYWWE3L4/
         Qf2b3CDlWpRPlZhmXP8S+uq/bQwjCcxjswbCfd56RNROhjLd6/qC7XwNH1m5Zk8c1R
         Ixmg5Lx3NmGVXSJCgUwPVTFBy4o2PMVmDwSDM/BVkfZbHlHvIIJ3TZoBVgXk2Ersjt
         Af1qo7lS0N8R8PiCbydAf4PqMjTIJJMb96VSVOQ+QH3b8yPR8ZXlOACP8FjzS8ojZ2
         aE3fauEJbU1DA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jun 21, 2020 at 01:47:34PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Hi,
> 
> This is combination of fixes and refactoring in MAD layer. Because
> everything here is "old", I'm sending it to rdma-next and not "wasting"
> our time in attempt to separate fix patches from refactoring ones.
> 
> Thanks
> 
> Shay Drory (4):
>   IB/mad: Issue complete whenever decrements agent refcount
>   IB/mad: Refactor atomics API to refcount API
>   IB/mad: Delete RMPP_STATE_CANCELING state

Applied to for-next

Thanks,
Jason
