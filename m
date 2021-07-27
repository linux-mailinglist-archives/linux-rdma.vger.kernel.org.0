Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D862B3D7D35
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jul 2021 20:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbhG0SMf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Jul 2021 14:12:35 -0400
Received: from mail-dm3nam07on2045.outbound.protection.outlook.com ([40.107.95.45]:7425
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230435AbhG0SMe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 27 Jul 2021 14:12:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vyv2SosNk9n0kGZ3XiGM/Tc1303w3zWnb3HawF6Kyng7/x4Ry9QzjaLycD81oOCYJrjdDaK53F0MoQJZk1Q4C2NXdYxjjAHEzUrpW+DtAuNeFQ/lgkhHRC3hv0ufM9/pVMgCrwginWe3L9tc+XOM1dwsPlZTLZY8o7y4usuNWXtH3DgUDUfmz66Zkuvz+j21o4guAJWTuL2GmAnHRRTKEs470POO8gPWIzhOoFmdV0t+K2UCBaBDrqbUtcui8eP819RlioKLAi2oN3+f1t6qBS+UhA2vpbi2lfASWeCbQk5fDWQTaz/grGZPYG3ROClPOZQOqobQTaOVW11qt1h1dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylAgVCk+xDpUHPFs9mf1J92exo3xKAB70qiUbpRLsrQ=;
 b=Cgigg7mSCyCFW1G/K1VCXVuSxGM5g+9SlZT5WW4yNDW6EYvF5m5S4Zm9L6w2mMdBreM3L4nDGhl/hrwKtqw9eyd8+5udLEkMRXBAxSs/JvcEekPF9w3eaAMRv6VCkUNzLsSI6elO73cMJ44sainDt7efSY1xCf2KfNHVlEmglWCFLLcgpj/qxNniBv8F8IAyCJY40m/Oyziosq83qj2aWrteepGnTOcZIN0WNLR9krjh+TsVKoPev4QS/Hu+uBLivKVfvspRC6xm/TFlY/RvOWwck7jD1q8H0lGRM7ECTOX76Wi0tSF+OAyiNw1ABzaKDISOOm6u+jVtXrFrEdE0Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylAgVCk+xDpUHPFs9mf1J92exo3xKAB70qiUbpRLsrQ=;
 b=FHlqtjL77w7n+wu6tFzUJMyBgGQooZFSFqo0sj6PamxlG3NgTTZScNzIHNuUQ1alwHSlvccHJ8Zv3uavtDQwkS+T0HiIgtbgTtMI9wwdv1oDH8MWGYyAK6Rym5GPWSkepMNkbLiRxROyriqb3hYgYydsbxEqqu0nZ1mgv1H9j3ba7qB2UE5Q/r/B/Mp1aWMdvRysGf7t4j4kfaQgtSywIY+6/c73pIaO2EuHmsaBptPWpwhGAUcR/fXDmuJsbZO6Lss0a80i6ofjY7Hhr33xqRL7BfMvBM4U8e63ti0KpqZuH5MHGiwmo3QDCEwH0fu1dXlsdshMSl3U4u1poHd+nQ==
Received: from BN8PR07CA0007.namprd07.prod.outlook.com (2603:10b6:408:ac::20)
 by BN8PR12MB3633.namprd12.prod.outlook.com (2603:10b6:408:49::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Tue, 27 Jul
 2021 18:12:32 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::94) by BN8PR07CA0007.outlook.office365.com
 (2603:10b6:408:ac::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26 via Frontend
 Transport; Tue, 27 Jul 2021 18:12:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4352.24 via Frontend Transport; Tue, 27 Jul 2021 18:12:32 +0000
Received: from localhost (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 27 Jul
 2021 18:12:31 +0000
Date:   Tue, 27 Jul 2021 21:12:26 +0300
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>,
        "Chuck Lever III" <chuck.lever@oracle.com>,
        Haakon Bugge <haakon.bugge@oracle.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: NFS RDMA test failure as of 5.14-rc1
Message-ID: <YQBMigidEF1QfqAo@unreal>
References: <CH0PR01MB7153D5381BBC3D1D0F146E8AF2E99@CH0PR01MB7153.prod.exchangelabs.com>
 <CH0PR01MB7153166CD64AE0097B72608CF2E99@CH0PR01MB7153.prod.exchangelabs.com>
 <CA7DAB52-ED96-4B47-A49D-88C3B8C6F052@oracle.com>
 <CH0PR01MB7153DE8406A68B049FC81EB6F2E99@CH0PR01MB7153.prod.exchangelabs.com>
 <20210727173857.GI1721383@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210727173857.GI1721383@nvidia.com>
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35f27bf5-fbfb-4225-210b-08d9512a1a7b
X-MS-TrafficTypeDiagnostic: BN8PR12MB3633:
X-Microsoft-Antispam-PRVS: <BN8PR12MB36333E1D85AD39809ABE2B43BDE99@BN8PR12MB3633.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hh3T3SlorL8oM/SyZFSds62+PIfJZEqgGLbHYjcRXNeZdlGeGimXmSbL2BV67LIkhOxcbn2tOg/8RKf46rm1RmCSZoEDvYd0ehCRc4UiSICStDtkjSEySeNU6D2ITt3+D568Nnqlpp723NxcZiRT9gmjRqUcJRS902tlxMDs6ogrKp0mZAc+nlJQr/+81E9w/gjVJEx6w/d6/0zKJqJ12nxaqhVqSAW9/pe9rRZhYtmJe73EY3XMD2Y7OPQLDDn09BDL6sPwu1ubYZh4O+aFHOkrXWwpXopEPNww0+AeYXRMqB7B3bfrxMm4SfShk+CN34kag6HFkzgkZq/vWVdOxz5ZSrkXckAreD+WsBDk7ySGpARmWx8a9u3iRdGqkzkZaiW554rY+WHTcGUIjaYWlpeEWIhrJUcW0yMy+q9G637AZcu3hWd93c586ayTwg0JR8OKURBSF+ks+bKcZ5OnUoZ7oNruNGNWJKq1JHuYefiZs33PNc+0U8j6mub4yNOjGGbM6uTkjp6gBr5Bs6rWs07G146uNIg1eEm3BQvXsigsNU4IdinIYJdHrH6aiEHkinHqO6N7/rTW6haYVsRz0gbjKiMevKVYmgmo2BNwuly9aZIz++nx93OjPW2gCiOhe8WlCOwb37vbdxfiJi8wqdrhTzxpKB3NwNGV4n7jFCDw2d7AW5TnK7HBa0v4SUa/ZlGg53m2Z8dVHFqFMkVQgA==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(7916004)(4636009)(346002)(396003)(376002)(136003)(39860400002)(46966006)(36840700001)(6636002)(478600001)(356005)(9686003)(53546011)(336012)(8936002)(8676002)(86362001)(316002)(36906005)(5660300002)(47076005)(6862004)(33716001)(426003)(6666004)(16526019)(70586007)(82740400003)(4326008)(82310400003)(36860700001)(70206006)(2906002)(26005)(54906003)(7636003)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2021 18:12:32.2740
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35f27bf5-fbfb-4225-210b-08d9512a1a7b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3633
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 27, 2021 at 02:38:57PM -0300, Jason Gunthorpe wrote:
> On Tue, Jul 27, 2021 at 05:35:46PM +0000, Marciniszyn, Mike wrote:
> > > > On Jul 27, 2021, at 1:14 PM, Marciniszyn, Mike
> > > <mike.marciniszyn@cornelisnetworks.com> wrote:
> > > >
> > > >> I suspect the patch needs to be reverted or NFS RDMA needs to handle
> > > >> the transition to INIT?
> > > 
> > > If I'm reading nvmet_rdma_create_queue_ib() correctly, it invokes
> > > rdma_create_qp() then posts Receives. No
> > > ib_modify_qp() there.
> > > 
> > > So some ULPs assume that rdma_create_qp() returns a new QP in the
> > > IB_QPS_INIT state.
> > > 
> > > I can't say whether that is spec compliant or even internally documented.
> > > 
> > 
> > This from the spec:
> > 
> > C10-20: A newly created QP/EE shall be placed in the Reset state.
> 
> rdma_create_qp() is a CM function, it is not covered by the spec.
> 
> The question is if there is any reasonable basis for ULPs to require
> that the QP be in the INIT state after the CM creates it, or if the
> ULPs should wait to post their recvs until later on in the process.
> 
> Haakon's original analysis said that this was an INIT->INIT
> transition, so I'm a bit confused why we lost a RESET->INIT transition
> in the end?

When I reviewed Haakon's patch, I saw that all accept/listen/e.t.c.
events modify QP from RESET to INIT. This is how we lost extra
transition.

Thanks

> 
> Jason
