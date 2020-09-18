Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5BD270144
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Sep 2020 17:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbgIRPpL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Sep 2020 11:45:11 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:5146 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgIRPpL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Sep 2020 11:45:11 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f64d5fa0001>; Fri, 18 Sep 2020 08:44:58 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 18 Sep
 2020 15:45:10 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 18 Sep 2020 15:45:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YhrZApcxeJYOBIYthyQl2avEweq5lDCTJ5NUjJ0YmzuuBALso6ei4W6IS3bwISR2iRvl0JvUcT3YxRDtYYE2750gWh9UtCO9le2YvYzDhudZj32ALkemN0vNw9VTtqd0tYwOF/Ob5E+cqsSS3FeLIT8hedWA6sWkiQ/DN5sFW5dQ32DM43uLFVdmx4xNfxioFK+uFOMl0IWVf6KkQJ/5B5wYETNJEIR156VwoTr8LHHrobe1cb650m/WA1rhvxQDFaW8h3HrB7vhcafxDG6503moreEGyn+YphEstpmOaACob4Nc5+hOPUwwmbiRdT4ijsTh0Zlqssqd+YUOK+yzEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWSuhceMCjvEj3uQbJFE1KKVHNQTyjjh4JAK7zAn7AU=;
 b=FLPjd+z29LlL9cMBAy+n/xup09s0n1CVsm3p6yRsB9ixxlyv/gQvsKVIz1jQzsfx9W66tRIOyb1hzxNWVieyYyRWYH+0wR8J5bF4oFzDdMtvPGcy5tbBDdqSMbgvKdfVmPJOGCJzvhXgXUd6phDZ+e0oweAfXkWJd6QjBY4hGgrtts81zvHlnWrCjsJ7qKNaw8iQrmDi4ZbWdiMvymmUvaq5+8rUqXnJsA0de8ylvBSCk2Xvhk63k3/7fncBnaskluvoUemAen+JO3ltd9h+iBsakLNoHtB7zBWrx3TLNDOwkUjjRUQGqyHP2RmBQyp5nxB2bc6MtDiBt6XdraSG/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: chelsio.com; dkim=none (message not signed)
 header.d=none;chelsio.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2779.namprd12.prod.outlook.com (2603:10b6:5:4f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.19; Fri, 18 Sep
 2020 15:45:09 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3391.011; Fri, 18 Sep 2020
 15:45:09 +0000
Date:   Fri, 18 Sep 2020 12:45:06 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Potnuri Bharat Teja <bharat@chelsio.com>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next] RDMA/iw_cxgb4: disable delayed ack by default
Message-ID: <20200918154506.GA314917@nvidia.com>
References: <20200909153707.2795-1-bharat@chelsio.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200909153707.2795-1-bharat@chelsio.com>
X-ClientProxiedBy: BL0PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:208:2d::32) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR03CA0019.namprd03.prod.outlook.com (2603:10b6:208:2d::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13 via Frontend Transport; Fri, 18 Sep 2020 15:45:07 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kJIZO-001Jw5-MB; Fri, 18 Sep 2020 12:45:06 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5898a021-2371-4865-81f5-08d85be9d1dd
X-MS-TrafficTypeDiagnostic: DM6PR12MB2779:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2779334D25FA8A8EB23DE987C23F0@DM6PR12MB2779.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ewWix7RDKtCF/1fPjN+ExpYizwoumTWOeB1BplwaJtSFBkiEABRyV+k/Z9i3rnXAdCLsRL373UicTagVgf1ayiM/Z1H5TJ1X+dKCBI+p45U4OA2q0S5H/w1Ll+zyFO10KjiVrWpFfkOiuYtYVBPkVhxc0h+14XWinZeDqi4jv7cQricl+Gf/xeqmeqBxt+PDT8FbaAQQOuuNMPD/op3UVSvdde/kLg+m2VmaqVOtRp4fqtzYlWEThJWGaRtj3BEWpnyVG4u/1T6fkWeMettJZYExU72ehBYbU1O+k/6XGQ2eiL25ncrM0ZV5IekGfvsVZCeNi9S2pXAT6snN0Thmuz57LOeBAypG0lOi7gNW5M487qM2LWMTwebfxtRYUzbN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(376002)(396003)(346002)(5660300002)(8676002)(6916009)(4744005)(66476007)(316002)(8936002)(9786002)(9746002)(66946007)(66556008)(478600001)(4326008)(2616005)(426003)(36756003)(1076003)(26005)(186003)(83380400001)(2906002)(86362001)(33656002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: SgCvM1Nyq4vCwnniIU+Oy2hkEdviHVWdaY0lVKHY/EFeHNY8SeDUub9Py4nP83uh8vycvqYnu9+UqC8l48ywjtmYxJgYMq6u3vqqT5sV+jwXZRfJEODd6wbkarp5E3iTRl05/sRFeo+9E/FAiK/eZfk8ZP6UA+Ov8KHCoOCOXHD7ABJYtd+mK/SJ9PkqRkE4jozNAxEaDrISsB4XR3nxFR/+h0EcuDoAVt6zzATAy7kccHDLpx26iaMiMsgLpsdNsJSuwGuK3zMV3+Hp7jt4jogBjm9k8wTt9JjTs8goQogTjo7LxuhFHTJmesKlFpbcJoS+fEHqxpt2A8iUiIuJV1CwdvVYgniSQ0CSe2G6oi+FSCWBkHZSx55X+sed1+VVcXxmGtZCc3lvtXP+iUHc2Pi5QhZTe1RLTBmo7vE+riPJDz1U0rBXSXYXdHkvhCeBC2GV2qt5kiLubEilRbnPEPsUBWrV+JcGM+5KPpO/N0aRntmX/gORiLufMImqYb1idyg3xLs1oll9M/KhddqzkFaH+/1wGU9pU0bPlA04JruYHP+RzuPLYj3xdXeBcpShzo/rEgMVVkEaMbCk3aE2hLPegB8lXPR/dZBHi9fnRamPx37zBbtk8eHJIvXNkWFw8RrCfIlB9xcCnjcI9muUDg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5898a021-2371-4865-81f5-08d85be9d1dd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 15:45:09.6188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T3FFY2UJqbWaNIfLQfUePO8MTFfz2kXyZeW4A0QSqLbpm+Rk3aPcEoANtty0FrPN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2779
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600443898; bh=tWSuhceMCjvEj3uQbJFE1KKVHNQTyjjh4JAK7zAn7AU=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:
         Authentication-Results:Date:From:To:CC:Subject:Message-ID:
         References:Content-Type:Content-Disposition:In-Reply-To:
         X-ClientProxiedBy:MIME-Version:
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
        b=JatNbfhsYh+VZbeAxiaNY3ozaYzAgrVWV8Vprf2wcjczfCVeMUaQ6DPK+57vKFsdy
         RtOJi1puUGLdD1z95W+XLlCpcfx5BQ0ZYRFTJysq7Wy8CyyQd3WOI7iZz8upAWLDXt
         KCG7r76bnKwpO5UEl1et9SBLJ4haAyte2YhFT7/q+dIv8CDZ/z1GkaiyrXxiCpAeYZ
         GsO4jgOyvrvTgWLwQ5CQlL1A1p3oxTiroteguFCeeX+lnyTLVhSiczAWeUQPq3+MCb
         bhdTcr/BzwVecZRtRTDjuybUXaAJ/kuvFnU2VrBxA/zcjn3Bn/gt6u3wnElNTJFlEd
         PObqvE1l7KLPA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 09, 2020 at 09:07:07PM +0530, Potnuri Bharat Teja wrote:
> Receive side delayed ack mode is needed only for certain area networks/
> connections. Therefore disable it by default.
> 
> Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
> ---
>  drivers/infiniband/hw/cxgb4/cm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to for-next

Thanks,
Jason
