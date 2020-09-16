Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C11C426CE0C
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Sep 2020 23:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgIPVJN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Sep 2020 17:09:13 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:58921 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726350AbgIPPzv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 16 Sep 2020 11:55:51 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f621d370000>; Wed, 16 Sep 2020 22:12:07 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Wed, 16 Sep 2020 07:12:07 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Wed, 16 Sep 2020 07:12:07 -0700
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 16 Sep
 2020 14:12:07 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 16 Sep 2020 14:12:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUK51VH30THYG+PGlW38ktQ0ZomjF+fFncCamgk/gzpoZ9VP1ji6vTviQNSKD7BpPiPQ2/R684bPMm2dTp/c9wk9uwRDzZmGAwHFCESJkSEOLdEAR4pOcSjPlB48aO10sCLluWfsfpQ+qfwbtrZRqS3ixARiAZPmb84r99yNSIyf21Bg1PyF90NBXWyGDHHtsTcscfS6O9nVxdaeIwkuzwj7Wy3UkKjPX/v3heqLF6XZz2R6XoQ4p/bwh3YTe5F/wcgSpaWsBuu4u7bgKns6KM+GJI1xHm/TqfgcJs9ok5q/gBQ76i8Jfc2z2QhNaFyNHgIMlGKnvKKXalHaUSCZsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ikTGbApEfRIwx7KcbfV56VLaGEsYfZ+w2PaDJeVcfw=;
 b=bd+QLw0cIErBpVP+/04wgbgExYaf6zzeMgmz23MScI18CTwRuNTvgmIsCBmsfufPDLQ9QMR9ELuNXrAUc1lq+6n0PVzqOui+lbm3ol7ajqsbNcrTFNRCczuGBrAiZr+WyIA7kQemHPzsOw4V/K3EKZEpLtRV7Mbs54MMKamPaAnLIinZl36eIAXLv4KlKNuTMf0ol9A3/DQbTgKZwEASQddfARYmMa+CCLuTmPFfjgD6N4hB6crrHO3iVawnX3PeFCrm9cLdIr4pwA78BU8tJQ5JuO5shtSySL59HjAKKoXXZvz0VHme+tXBJ/Rne6As9PmJNjO024ZZXo/Q4HWMBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 16 Sep
 2020 14:12:04 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3391.011; Wed, 16 Sep 2020
 14:12:04 +0000
Date:   Wed, 16 Sep 2020 11:12:02 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Avihai Horon <avihaih@nvidia.com>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next 4/4] RDMA/uverbs: Expose the new GID query API
 to user space
Message-ID: <20200916141202.GA3699@nvidia.com>
References: <20200910142204.1309061-1-leon@kernel.org>
 <20200910142204.1309061-5-leon@kernel.org>
 <20200911195918.GT904879@nvidia.com> <20200913091302.GF35718@unreal>
 <20200914155550.GF904879@nvidia.com> <20200915114704.GB486552@unreal>
 <20200915190614.GE1573713@nvidia.com> <20200916103710.GH486552@unreal>
 <20200916120440.GL1573713@nvidia.com> <20200916124429.GI486552@unreal>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200916124429.GI486552@unreal>
X-ClientProxiedBy: BL1PR13CA0015.namprd13.prod.outlook.com
 (2603:10b6:208:256::20) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL1PR13CA0015.namprd13.prod.outlook.com (2603:10b6:208:256::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.6 via Frontend Transport; Wed, 16 Sep 2020 14:12:04 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kIYAE-0002lo-SS; Wed, 16 Sep 2020 11:12:02 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c218726-df3b-4201-1c6c-08d85a4a7cc4
X-MS-TrafficTypeDiagnostic: DM6PR12MB2939:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB29399791702F9960BD07D802C2210@DM6PR12MB2939.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YcgDxt+RhAHxgFEi0BuI5cRJGVCWJq/Xz6IFaVaC/1XxPy1rt21UPeMUVTBfAzoVqhplVA7GfFkVyqE1b/oSxztKUdNvdJ+2g9NWd7SHVdeg1iG+e6tigu2+UfV/N0UXmmOyZR4onsXoN/gbGZ3+fwxWWnRVxt0waeHTkp5g5p+D30j74DfnEJO6PBceN0RETwNcMaXdmqhFVUgf8xejZo8GevTk3zTHoX5YFFkfZl4W5d55tBP50nKzItaJpSOQ12R/F5aphBIgpzoxuzfpnwNN5N+BrhvpQK3H5XhkHUDabwLLUTzMBFc4ookt/EidCYTbA2nFHeh9TptaU5rgM93Hw/ijh8IY0ADx1Z52eseqJ24evjtsNcCH2eJnt5k5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(366004)(346002)(39860400002)(26005)(4326008)(2616005)(1076003)(8936002)(478600001)(316002)(54906003)(8676002)(5660300002)(2906002)(36756003)(66556008)(66476007)(186003)(86362001)(9786002)(66946007)(33656002)(6916009)(426003)(9746002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: jFhooyn8QDnZiupng10fOUTIz8naLLGF5B+QKTPMLZHcJXcjzXcyr4DA/7MmRluGhg0qahQQ/9ogBwh2HkR75H4pIShZiaGmPOQzafEoNjPVuh2OyDb6k28akO2CAaMNpbiOLai9FHnBnEQRKYmn7Is2Vy2X/U2CSTUPbRjaEMSvpHVaZwNwan7uRyOjOQjWPRTR7Mb/5tnRtuFIC/L48OLvqWiwO86AZ0gJWnyBMOJ4kyq9lmxFMdCVE25BKChSI5ab1N42hoGhLOnVisDuHkzi3KzVAw5zOyP/F/t8gY5QZvOB/2Neyu0w8/mAk6ykrvJafDK4WNGCWvgsE/DQBe7+usVcc+6icPuQzbhM/ZnbiBcMf/yAVCHmTNGK+M2hwyD+Uoj9RsDrrLaMhe1SUsw2gUqjJhE0r95fm6RkcS6xxqUi9/OSypGuudB6lFhfOF/Y7KDtGme8CVEEaLRtQEp9RoisDfFIAhj3P+LeSWE7d7rqCKcPG9i0erOIAF7Nh5Cgxa3A0fKZaMmtfPBsYjuwvuxPlnvWr53BpjdH7S9Aj1Pi7+MmXoJH8c4YLFeKlQZ1JWiOFDhbjVcBV8mrcroXd9O8i/UjZkNLN9O8ZpBUL8mCRFReHmxY61qZ5AMIeTkHsRGHbn4BvYQT0kIb6Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c218726-df3b-4201-1c6c-08d85a4a7cc4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 14:12:04.2560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sOT/9auakPg68qXsJdk+m4AS929ORNGQKqeztBE1DAb8/dFIOQEAQfE+PvIIKhd1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2939
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600265527; bh=5ikTGbApEfRIwx7KcbfV56VLaGEsYfZ+w2PaDJeVcfw=;
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
        b=VFGj4kwk1Kj8hNg2J6EMzIzC8pzvcyhf+x7l/1MSERiGvFmdMQ4OdFpJIOn6BcPt5
         SaV2pp9uqvWnNQFjuvjUrKY6z6OuK/JCQxids4bbyRdSNHHwcFfbvtR0oRSbmcPPAP
         ATrEjhg5ozv6CEHsGsANGWCD6JOB/koyw/xUW2FMDUoXnY1iUEHkwSUmcDQUbPeCpw
         1yKAzqrD6L6VOQK5aBTnvZDd2S4w0ybYv483CmUrNV5q2cHKvwlLVi0ki8FlWmCQzJ
         NxZ0D76avLaj3v1K1eQ/yDS6vJhyjLfG+pXP6iXVaPF+/pKYlkLmuh7vCO+20ppjNw
         Ks5UhVcTmdGyA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 16, 2020 at 03:44:29PM +0300, Leon Romanovsky wrote:
> On Wed, Sep 16, 2020 at 09:04:40AM -0300, Jason Gunthorpe wrote:
> > On Wed, Sep 16, 2020 at 01:37:10PM +0300, Leon Romanovsky wrote:
> > > It depends on how you want to treat errors from rdma_read_gid_attr_ndev_rcu().
> > > Current check allows us to ensure that any error returned by this call is
> > > handled.
> > >
> > > Otherwise we will find ourselves with something like this:
> > > ndev = rdma_read_gid_attr_ndev_rcu(gid_attr);
> > > if (IS_ERR(ndev)) {
> > > 	if (rdma_protocol_roce())
> > > 		goto error;
> > > 	if (ERR_PTR(ndev) != -ENODEV)
> > > 	        goto error;
> > > }
> >
> > Isn't it just
> >
> > if (IS_ERR(ndev)) {
> >    if (ERR_PTR(ndev) != -ENODEV)
> >         goto error;
> >    index = -1;
> > }
> >
> > Which seems fine and clear enough
> 
> It is a problem if roce device returned -ENODEV.

Can it happen? RCU I suppose, but I think this is an issue in
rdma_read_gid_attr_ndev_rcu() - it should not return ENODEV if the RCU
shows the gid_attr is being concurrently destroyed

Jason
