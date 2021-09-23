Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7203416852
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Sep 2021 01:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243507AbhIWXKZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Sep 2021 19:10:25 -0400
Received: from mail-bn8nam12on2041.outbound.protection.outlook.com ([40.107.237.41]:23841
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236363AbhIWXKY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 23 Sep 2021 19:10:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NUKj+JknITOaIWE8FWegP8MJ8KtH0aOfNYj3I0m5UtOOtsNmdnacARu6qiX5veWozy6iKfLdiuHEQ9Yo1CxnHOdJLN8IuPzVWP8DGnl6uKN1U+9YCI7dg4CzefXPudQ4Cn+XENh/gGLt3O6efg7PR5exnQ4fmEZvJ6IEyPnoZB+Uh7VhxdPX/JHe0cYjlOzK/MY6zHBx9uvCWDND+AoqoPTHe4C9R7S/B6Hmaqi0/pH00EIENOTuY/jay61eXWV2KPlTAQ64QxIvpnn0apAFMzWc1C10T0AxsULjPaorZpyEFXOsgngagRAc0sx2mfjpa7vWbXG/JS9o9yWlXqn7Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=5WqycYfONi9CaZcJISy4lBUj0sWbuy5ngMxFYtWvaNQ=;
 b=fPQvVAnMGib6p1DlPpZ2ic5ICFeoCmnD7hOZ1YtBN4EQZ250GY0Rp9+IFIhMLkUjcVWWpgh1Y5byGgz7PKr6c3xqhV/EBMKbZT9QmxkxJn08YwiksbmtVrYUbqP6r4NPhmhZGP9DVJ+8JZvyUu4BLtbGU0XFxlWXc//fXNhNaJk4VAMKYMDONXlZcAuDkuUNoc7piPKiBgRIy1kDK2a44s28ubbJgvagxIML/eQNVfYZ1ulLjL4me71grX1Dq1pD6fnQ9jp+sJQmA/7kJizaD7/1UktMcslP5VDq9hhY23ql2xXtJOOOa7T8LCLGTMZXtrU+7OaYKK0s1JQ7cA72YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=suse.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WqycYfONi9CaZcJISy4lBUj0sWbuy5ngMxFYtWvaNQ=;
 b=nY/gVsMzTnKY7uHLDa8JUcl4x9JKPwcfi+pwtrwGXlrz9oPnmVJGhutvEXvIrWq6/Cd3UF2wSOB1/8oYqXvfBA0uXgVP2lALwW6fgAIRO748Cvwl199PYZ+GoNc1ImI0STL/YJNTaGfZ2IM9RHENCnAv1kD79Y2QJjUfsK6DRKT2gtHWUrk1mGqq/NrcFf+qh5v9U5fYyF+D0hinDY+RLBTL1z2IAMqZfcI29Xfujn1WPBZ3DXFMM7rWfR6x8pZ2Hqr0li9valAUU7gGPh1iMJIBUV2KMUS0Jx1v0ZOgUt7s7+aV8aibi2MIOV0EIj8fxLgJ2yMSJzatsvxet9U7iQ==
Received: from MWHPR2001CA0015.namprd20.prod.outlook.com
 (2603:10b6:301:15::25) by BYAPR12MB4792.namprd12.prod.outlook.com
 (2603:10b6:a03:108::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Thu, 23 Sep
 2021 23:08:50 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:15:cafe::2c) by MWHPR2001CA0015.outlook.office365.com
 (2603:10b6:301:15::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend
 Transport; Thu, 23 Sep 2021 23:08:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 23:08:50 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 23 Sep
 2021 23:08:49 +0000
Received: from localhost (172.20.187.6) by DRHQMAIL107.nvidia.com (10.27.9.16)
 with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 23 Sep 2021 23:08:49
 +0000
Date:   Fri, 24 Sep 2021 02:08:45 +0300
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>,
        <linux-rdma@vger.kernel.org>
Subject: Re: rdma-core and travis CI
Message-ID: <YU0I/VEmILv64n3D@unreal>
References: <20210923215746.GS964074@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210923215746.GS964074@nvidia.com>
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00232526-7269-42ab-f831-08d97ee71aeb
X-MS-TrafficTypeDiagnostic: BYAPR12MB4792:
X-Microsoft-Antispam-PRVS: <BYAPR12MB4792FD54544FA731B61F3A02BDA39@BYAPR12MB4792.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PuyA88IG/Y2/ijZexeGK7mru0u8/zSyrCnlN2R6d7dcID1TjsbrK9AmPXeP3v7hZFpHdWj4upnzWDLIrUP73pzrO6bmwnLGhX1HVeA/JyrpSEv3cdnzvRwMK2CJlzSwECIDemfQIq4DT61ygDYOiYBUGLfKIZChI45CbENq0PTww7sYGyTHWUwVQf8Hl/gsyuuYJL559cKLRTGW1Wn7VEOKiuceqy9iF4yMwm12RK2zUwO64eRbh9mK7koRwrryhswT9MvdNLCumnrjjce4VwPvLZUt+/Gf9AJ6sm8ficRfFFojOf4czFM2tmLHBvVgqE689hwp2v8Qyti4TZtgGKCxdundh2byTBbTgYxi3e1tTV8RU8F+LxbSupbwgs+xWWh06FsI5bG+Mjn7ASSQ9wO/rMuDNWayGNzCaP4rfDYcGx415VFpevP9JmFYfVwfPeB7h6zLCGRlmAxz0aX6ETDqCPljwJcHD7TkCi1rnukzkzggL1GIxbqBnqauIBOlozFKeC5hTAC2J4gfLMtkVIloRWvg1ZxSi0OX2jxLXD3gBf6yBb9VP79HPv0VzV2F6Oz5aFCSsYTNJfoUozcc6eZoBR6MumRzJREkgHY+CZv9N87PtiZn2GUqwXySWkDhUJg706uxebwqhMwFYct6pUS1Q7o5ZtqvAlkkag4RsXJbMXIipuWizEIq7hlkpFu+/mc3veGLqECn5NqXgP+OeSw==
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid02.nvidia.com;CAT:NONE;SFS:(7916004)(4636009)(46966006)(36840700001)(4326008)(5660300002)(356005)(426003)(36906005)(16526019)(8676002)(186003)(83380400001)(70206006)(70586007)(508600001)(336012)(316002)(26005)(54906003)(3480700007)(6666004)(47076005)(7636003)(6636002)(86362001)(36860700001)(2906002)(8936002)(4744005)(33716001)(6862004)(82310400003)(9686003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 23:08:50.2713
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00232526-7269-42ab-f831-08d97ee71aeb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4792
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 23, 2021 at 06:57:46PM -0300, Jason Gunthorpe wrote:
> Due to the security issue with travis, and the general fact I no
> longer have any idea what we had/have configured there, I would like
> to permanently switch travis off and revoke all its tokens for
> github/etc
> 
> The only thing still using it is the CI for stable branches
> v17,v16,v15 this all all 2018 vintange stuff and I think it is
> probably OK to let them go at this point.
> 
> Everthing else is using Azure Pipelines already.
> 
> OK?

When I read news about Travis CI, I said for myself that it is so great
that we are not using it. I didn't even know that we still use it.

Regarding removal, Nicolas tagged v17.11 this year.

Thanks

> 
> Thanks,
> Jason
