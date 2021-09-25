Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB174180F9
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Sep 2021 12:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241912AbhIYKPn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 25 Sep 2021 06:15:43 -0400
Received: from mail-mw2nam12on2064.outbound.protection.outlook.com ([40.107.244.64]:43629
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235805AbhIYKPn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 25 Sep 2021 06:15:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mEADE7td2pLSV+2TxPdxCglIpVlhag6wBheYB0QiU3HIow5trqB4Uqomg4Cp9wgvJF+36n3n3dGTrpK3hoxvHXsO5FyyqxwNP0NjTnsikOm12LdfCJSroyAH9JGbnAynBfJn/jt6br4GTkqClYPc9iPzlpihczMAmJInTNeA5rKRdYHnQJ1kt/8rU4aJ1br5Z06lRIdQECaO9H6Y9fae/lrY1hdu6lkAQmf0P6ASRrzV7fKG4FL62B6J020/XjA11iLOXWfBf5wiHB+9eB7Q6Eb8KPTna9EzG1Lqnb1fwHaLWu+NVj10FgBZKzkOpZzb84mH45T4V2N+vfqfNkZMgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=WPlhY/KzKHXNnIRdhVSBUbeRjxVyLBUb4WD3eWiPvxw=;
 b=R2KJS/YxVW09SsFOlsQUpgmAUj0aoAFgtq7LIUh8CB7g+4zbCsthkomjZUPDHyekHy1kOUqU7EcSnx5JtVkyFeL97Z/ZESQoSI6nlxlg1SowxKLVtAD32g+ZgoZHapBcbkQiOYDLfgxi4yNRgbOWG03DHi/dBOFnqjbtpSMIdiKvct4MSU0pHA8zQrlngOai/mlJgiWp1gSRXukEfmg45iiSd8sYhE9JvhyU3lDe1ziWXvlBOIijF+bav9t+YzprCewA8fPvNcOxRX0VF/O7KTZ5kIIRksTF9abXw+38tfK05HB4olYXrbJjouJaLfR7O46A3KmwxVSnSZ1mKuJweg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=suse.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPlhY/KzKHXNnIRdhVSBUbeRjxVyLBUb4WD3eWiPvxw=;
 b=sC4SkzAzBZh0qJvnf+5DSmmSbnAzOIpE56o81LElz7SAZbTEACF+Ejeg7+K/qpgocTdGfI/S6swpY23L7Sg84mMbejTFgmJ1dyVFAfhileQZcYfqmmx2ZlsEaWYG1zcWG+qN9tfRiwnqCyci7wXlvQI08LWwOQIhNXJS35JLbgHFHMZUFTY3je5Sbcpxwn6Y8FcUV7hFmlqq8iIyFJKMEI1/MuwmZUikJMb8buhMGRBd1ZuxMNzfQp2RmxGLDuCp2QBLdFm42uj84ksDWG4YHvsqdCokRAXxEy+zDanSSZxnlZITJQHO1UmFKywqmYO2JDEYSAFbLslvdX+mRTYWbg==
Received: from BN0PR08CA0001.namprd08.prod.outlook.com (2603:10b6:408:142::6)
 by BL1PR12MB5318.namprd12.prod.outlook.com (2603:10b6:208:31d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Sat, 25 Sep
 2021 10:14:07 +0000
Received: from BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:142:cafe::13) by BN0PR08CA0001.outlook.office365.com
 (2603:10b6:408:142::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Sat, 25 Sep 2021 10:14:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT049.mail.protection.outlook.com (10.13.177.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4544.13 via Frontend Transport; Sat, 25 Sep 2021 10:14:07 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Sat, 25 Sep
 2021 10:14:06 +0000
Received: from localhost (172.20.187.5) by DRHQMAIL107.nvidia.com (10.27.9.16)
 with Microsoft SMTP Server (TLS) id 15.0.1497.18; Sat, 25 Sep 2021 10:14:05
 +0000
Date:   Sat, 25 Sep 2021 13:14:02 +0300
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>,
        <linux-rdma@vger.kernel.org>
Subject: Re: rdma-core and travis CI
Message-ID: <YU72ald4CCMHnslo@unreal>
References: <20210923215746.GS964074@nvidia.com>
 <cab3a248-717c-9b6c-28b7-c767d7fe5f15@suse.com>
 <20210924114549.GU964074@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210924114549.GU964074@nvidia.com>
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3cd544c-89ea-4158-9881-08d9800d35c8
X-MS-TrafficTypeDiagnostic: BL1PR12MB5318:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5318D9346E56332CA337AF1DBDA59@BL1PR12MB5318.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /FRK2SB7F+ULdoJEj0sMWYwU+8L558f/XgdYTP8uL+0MPFSw87IvcY+VcSfyyBcqHLjzRtRtornvaXvli5Vzsbi+TjBtblvvDvjFRPKv6YmaZ/2GiBy0roJynTnrlrCUPDAGXG4U1zj7nzoMBQxVLxDORKHCRhARyzV+WFSlELTxj1Ui6tDeNuqyWZs1oyh5uNaYf8wddV0Ua1h9zwp9wJf+RNE70lwCZfmZfC4jVLm/73ioHyQizTnZrY6ulW93W7EfLkZysQ6eM0nqSQdQ7ejUDNiZDLLPfgwYpBtBsONhFvZO3U2Wf/LFZ33/Ae4in5EfVyVBFEdsL8mS/hDOrXH8yOvKD5SS8G9+laF6vwx05UwYd9GL8RkcgNpd/5I++wSr/v0hqfibk2g0MoSTDJePrpsXbEdRM19vQPRahpgrZ4CoTbKMtRzSwA7ryE5g3iQViXxoiG+771I3FdO0wuDmpW98Iszt4ik7gTkrPmUErX/k+xXRsmF94biC8VLc+zKZssuFx2RESYpIILaQ2wHrzju4JdWwCWregg4wvifo0amb+yhm9TS4+eTQF2sWNELN4Z3aI4lDZNmOgpxdupAUYryDJdeZ0xSEu1zboZFzGSVcesze/aHKk2ReRJNigDA/I3P6djsqV/NxBE5zO/icpqH5D7Bz7ArzeZzsigmYlpPUOoPX0NMOqLmha9m87Z5YcxzF+fBY0sjGoTLPRf00xj4aemYc21fWA8WNXJJHsGqxD/Leso2/ZfsNPmQg619vp2d5/X/dynbaXuWgMXrFVow7VkjaBsjQGx/xE2o=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(7916004)(36840700001)(46966006)(2906002)(8936002)(33716001)(6666004)(5660300002)(53546011)(966005)(6862004)(86362001)(6636002)(47076005)(3480700007)(8676002)(36906005)(26005)(82310400003)(70586007)(83380400001)(70206006)(316002)(36860700001)(508600001)(9686003)(356005)(54906003)(426003)(16526019)(186003)(4326008)(7636003)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2021 10:14:07.3225
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3cd544c-89ea-4158-9881-08d9800d35c8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5318
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 24, 2021 at 08:45:49AM -0300, Jason Gunthorpe wrote:
> On Fri, Sep 24, 2021 at 08:02:51AM +0200, Nicolas Morey-Chaisemartin wrote:
> > 
> > 
> > On 9/23/21 11:57 PM, Jason Gunthorpe wrote:
> > > Due to the security issue with travis, and the general fact I no
> > > longer have any idea what we had/have configured there, I would like
> > > to permanently switch travis off and revoke all its tokens for
> > > github/etc
> > > 
> > > The only thing still using it is the CI for stable branches
> > > v17,v16,v15 this all all 2018 vintange stuff and I think it is
> > > probably OK to let them go at this point.
> > > 
> > 
> > All these branches were retired at their last releases:
> > https://lore.kernel.org/linux-rdma/046b9cdc-881c-c02f-57ad-f929a5b8803f@suse.com/
> > 
> > So yes everything is on Azure nowadays. Feel free to drop travis completely.
> 
> OK, Leon can you cancel the travis accounts? I think you have the
> login..

I revoked access to whole linux-rdma organization.

Thanks

> 
> Jason
