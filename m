Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94579411E3F
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Sep 2021 19:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244449AbhITR2T (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Sep 2021 13:28:19 -0400
Received: from mail-dm6nam11on2051.outbound.protection.outlook.com ([40.107.223.51]:6497
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1345178AbhITR0N (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 Sep 2021 13:26:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6wWUNHNX254+OxEWItk7QGjOSVLJ5DsgLDR2GoSvb8X60WzolbeZWhZCCfCdgohSFEcfwvsHAJk/0/iaCa3lFwtSPRKCmAq8lvnMMJiGUtf2YCbHJ+wYZ5HAEuBNXpVZe7BeLhe/I7PAoxg+z3VYJMA3tWEhSArbbNt9YkDnVPdQiixk0al9lDzxHiFvfwd+eKzXEGVx4JZJc9E+VZsJ8GpCTsj98uih/+SkCOKIgbI0z48tPn+l83cy0tfAdhlWLYHn5Gxv24/3e07R7Em08EQzXwOI5E0NMoD8Jfh4+M8JBoVUF6GGdu513qz+0jncakBYPkvsaFx+LvNp47nUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ERTk4PgWIYPdAkkDLsf0Mg0s5heHPg+dJoKtkqVcFC0=;
 b=akAsml39lHv9eH65V0pNjUE0ShLfWyC/M5rvysPm7kf88E/hdLOJyGooUbOGgQKV+53Y3eBs1Y5O2b8mma0RGsdVd3OMl+UFj9zJx1M4jzX5yxs16LalYvK9Sb5uR3gbEhnfiJwkjBBtH21rYnJrxMH819Ju6PxM7O2ovLpq3HINcYADzL14GfMuzf2yftZKBMOaZnECMh6b2oPwVlhkOsauN7L/ugzJ8Iz/PAp5jwf8fthZ6QEx3a0S3rLI8GEr+HdRRma8X1lVw698PgIy2VZL2+LWUsABrmFm/rZ5ybdbFaHB4APYT/2s+KnfEKaGNQby6oNpZ/oARZFSOejsZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERTk4PgWIYPdAkkDLsf0Mg0s5heHPg+dJoKtkqVcFC0=;
 b=mBfL6I4CSgqFKIvC+k0i5AWPWYF7NA8OUfNRjDEelIuRZRCBgTExoPVw4Ql0nPZjTU1I3zeN3dHiDF2xrXXmZEA0WrWlfi9vm3tiCAMgKihGtU1eW18aS1InHfs3m2MyzIO6NN+hn4TEDFbb9NjDHyo1cPEkUnGnztKsH4c22uOtHCvawXOSwZeLPEiBwSxNrWTyT5d7FoQucza/mXmnDVkBOxFX0leqEr9NeIQd3Kk3d9mCSuj8nS9BOSNchmSTGsMU62M1lvoJ3G8QhN2CWdmGbDe15l+SBpU2F2fJdBGOB5Lm2WF7vlIxcrDNLke/cmiGcTGmBqaW2aAjYz1n3w==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5080.namprd12.prod.outlook.com (2603:10b6:208:30a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Mon, 20 Sep
 2021 17:24:45 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4523.018; Mon, 20 Sep 2021
 17:24:45 +0000
Date:   Mon, 20 Sep 2021 14:24:44 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Shiraz Saleem <shiraz.saleem@intel.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc 0/4] irdma fixes
Message-ID: <20210920172444.GA727209@nvidia.com>
References: <20210916191222.824-1-shiraz.saleem@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916191222.824-1-shiraz.saleem@intel.com>
X-ClientProxiedBy: BL0PR02CA0060.namprd02.prod.outlook.com
 (2603:10b6:207:3d::37) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL0PR02CA0060.namprd02.prod.outlook.com (2603:10b6:207:3d::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Mon, 20 Sep 2021 17:24:44 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mSN24-0033CU-1z; Mon, 20 Sep 2021 14:24:44 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c03b26c-b74a-4b3b-b0a3-08d97c5b8a0b
X-MS-TrafficTypeDiagnostic: BL1PR12MB5080:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5080BCA0202E7B8129D1DAB8C2A09@BL1PR12MB5080.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MnrFPYgDmyScL6AJkqflvhqhF3S8F5TvzSgSgLebh5kkUiXvVt2xDW1b6ZA2CPDS2CK1ImZE18sWTGbDB63jPZXyhlQtnGL8eGFwdoANK8lEPWTF5C7jkO2lksQfVmlAUR8ZmckenmQzV3EOVYAh9+TmoAZhDIBiJDh3a5E+8+k+iv4CLLRG7iUoqB+twpKAOUFRPK2uz0Tm4bQLMwW+Cy4f28Q6+gXWwFsQPAVpov4GU2siIldrQdNfdMhPUQXz8eJCydQHuE9Yw1p3qce8JGwawuRFfeZgjOoNd6oAsZ+tpZC2RaBUvLix+qnLD6pxw0hUtZS9RpfsVkHTu+v0w1f0VGynZe5MJUDy1tCefxeu+20ndDuSRUE333+9jqEGEtyyWZIbfZ+rPY7P4RKHBsAgS4TOLpl4XVaLgzJKoue7s7bWA37XbgRgMRgAVkJZfqph60CGk9tAClDVf2RdkQvUjwDG7UTTNkJJEYTougZMX9WjCNNVZXLnTwDLsSo/Y1k/k5QkCIchC0/rs3P+3lPLoX769m8dNVR2bFKIxq8zQtaP5H0scD82qFCmINsEv9hc+cmZ7tq9LfSIQ8WezfaIaRE7Nkh9LK191Z28+lWZAvtfk5uvk6zsxcuTvNtDkTB1klZHfYbPZNzSHxK45quXMzFUQtTebnHcx1/I2k5nS4xoY19NaV87L53fc1GQE9lueuKzvSP6mT7o/UoVMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(8936002)(66946007)(5660300002)(83380400001)(66476007)(66556008)(186003)(33656002)(4326008)(9786002)(2616005)(36756003)(1076003)(426003)(86362001)(26005)(316002)(4744005)(38100700002)(8676002)(6916009)(9746002)(508600001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KHP6PRoi5W2Lt2DCwSookXxjH6H6jJQq5gdD8b6w8m0YVaWvz0y+lAOSGubk?=
 =?us-ascii?Q?bN49Oe1PkqS1XRkZROSljRn9Yql92MxGel8EaPckTkNhzjQ/2xjt1b2DdWtA?=
 =?us-ascii?Q?lGk0I8gZPnr4/koVf2RGZqzuDws3lDrt5MJyignMbKP5oqd80HYdQekCR2my?=
 =?us-ascii?Q?X2rke+KefG4egFeG96G8zEPBrMmW/0+YzK0E9/gSxlxfU/IJN/VWqwvtB/JO?=
 =?us-ascii?Q?PQ1vjCAQlBSvO6fNL+ggRoCUbPYZvxVMuRLNDKbzdeFopjMZB8H46ZCXHhsW?=
 =?us-ascii?Q?y1xvVTnHSNRAQlGimLR9uns3F8D7Sj72Y1bwtFmMJn4XPPO8MYjsW3G9C0zZ?=
 =?us-ascii?Q?7if31Ter3uiRAGpMVGhscWtAQdeu2AiJ+7A++Fi9xdMIa5kweRlEzjvF23ym?=
 =?us-ascii?Q?0mvO5F0Y6NSOhx/coT4vYwA2Efumgyj/3G3Dn6mDFYBEyGixWaofw6LsVuBE?=
 =?us-ascii?Q?xrtqA+uDmKlks0G4ueTSpDoTU5WqIFirTz7f35fRbcSQ6DiOeZNRQ54YcMSI?=
 =?us-ascii?Q?RA+KgHDu3upUQQVMPtpB9xMG3kdsOHnkoMshZkiS4EE9b3kUtwY5HGPLdkgw?=
 =?us-ascii?Q?YOU9Q+pRdaYM4fXFdzm2TaqwwDugnmTJBA6Uhv+8Gg0KFa6Jd/rFYFnzVs3O?=
 =?us-ascii?Q?0ABpi8DKZRe3a7gjBKHvPJc3hR7CupalR5AO+a9zpYbwfznhrMO0usTwxWul?=
 =?us-ascii?Q?IIvDeEtEZMMLYEspEH9lB4IzSBH8SNcSOAFOl9qc2Z9CdPZJnfzwpC73xWdW?=
 =?us-ascii?Q?ptBJ/qZwm7jcgL+QmhsImSbQ+msQxEfQ7RgqV9xqpem68rxTt3wxAhX+ktPQ?=
 =?us-ascii?Q?ynUL/SnxJKc6SyPAt+z4eNnp6Y5klkC4MdNcGorbr1pCKUjB/473SR2H+qlp?=
 =?us-ascii?Q?E6EFFaezCI89HpVMPfdBa2YXJXEXXlCltQ8GeHI8Mnk5lh2Se5Kp5PJ6d31f?=
 =?us-ascii?Q?SQBgZvPirAut1HyXT2gpwZ+D009tDK04QCI8ILjLcYp/ByN2eWZbHnHPdKBk?=
 =?us-ascii?Q?Y5xHkR3uPQ0D/85AD7yoXY2GUXsHpTbxFtEDKh2MyxJETkz0Ck3SGDaovEu1?=
 =?us-ascii?Q?8HbMUdd/DrcC+whe1wfJzzP7MPNTMtkt8Ca1s/wvoe1PNF00Re62mk/9Xl8d?=
 =?us-ascii?Q?w6vN7bjBPHIa8ovcs5fhH/TDcImU6GTSzMgz+mt0D1voUy4cqiQw51PCyu+o?=
 =?us-ascii?Q?APZeXkhBIgUOL1+ldQj5cKoZNu36p1e1gWXR17y7iObZRA6mUfyZZrJTH7jJ?=
 =?us-ascii?Q?GtQmK1p+k0GwYNwCo5M8FJBDX5Q8btCr/Gsu+ibIR++E8O8yl6rJGVpsYPKo?=
 =?us-ascii?Q?Ubj/kWIAba9p5kKp4MNFW+10?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c03b26c-b74a-4b3b-b0a3-08d97c5b8a0b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2021 17:24:45.1377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3INjFq63UKO61tge+AHu0kwlAFqeiQRVFkGIyboJxZOEuX9jeIU/cD6vMCG8693k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5080
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 16, 2021 at 02:12:18PM -0500, Shiraz Saleem wrote:
> From: Shiraz <shiraz.saleem@intel.com>
> 
> This series contains a small set of irdma bug fixes for 5.15 cycle.
> 
> Sindhu Devale (4):
>   RDMA/irdma: Skip CQP ring during a reset
>   RDMA/irdma: Validate number of CQ entries on create CQ
>   RDMA/irdma: Report correct WC error when transport retry counter is
>     exceeded
>   RDMA/irdma: Report correct WC error when there are MW bind errors

Applied to for-rc, thanks

Jason
