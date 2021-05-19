Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA777388F6F
	for <lists+linux-rdma@lfdr.de>; Wed, 19 May 2021 15:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239919AbhESNrY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 May 2021 09:47:24 -0400
Received: from mail-dm6nam10on2056.outbound.protection.outlook.com ([40.107.93.56]:36064
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239757AbhESNrX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 May 2021 09:47:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UkUjPEEqSSCzlGshoF8CELAeHlOgjeuypcFswMjVixc/RHkG/mvjq7WXshtOYLcsJmSjBzmNKREhRe2x1Bl20g7vdVXraTq4bksu0/rN+K74IIhqQse27GBFnSLuEY1385F04cC3y4+nLFHN39CwhuoQhQv63phPSO78slQwqUR1Rng9kJ+SAsZbeFCaxGa/hWB00rcGYFPf2Nkjz9fu4P54xB7gjkDWYqhoWI4aGwAx6JRfzqu6oBV3Jl2aa3cSWGsiQOTGYG6SpSFdZrvotw1LyY6rFl9AhrumA4+AjW25G7tfH+DLbGGdtiwHGHmTCR9ZAMxPgF4zIjrrA5123Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3JRTw/uif9vuHbLa305dSEqqBqnMBilP3IBndAyd5w=;
 b=ej+ZjzdDlU07Kv/vVyfVWXBlunKAT9qGnswx5bbFXOGF5HgdKDzcHACk/Oy9JtQgIUHIK8RMq8YShWWB0ExYat8UfZq9I0Q9+FjvpzKtSnefQy5TFKe2fNSojgePtMJ1+Vl8J5uXBwa3dm0wFjFVzeG41+s5Pi+aA3cRG4S3JLzwyeuDefncr2wdX9NGuzIYo73+cOXiQ4U2l+iTKweoxgyRMEiuf9iTB1jeQ91KJRS8ibf+lEblCp0D265W4P70U4xjNINwJi0f0EgNccwHHt2VVbmTmymtxcVYu5w/lIAnsGx+7BljDb4pDCUB+Y7oPiQozDM4Yyno2IKgJqV8Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3JRTw/uif9vuHbLa305dSEqqBqnMBilP3IBndAyd5w=;
 b=f6e4dFICcwwXze1eR2Y46B6Zz2cOl964Lp/JF6PsM7JJVrL6f50ykpNsjLZdwSBy2sRXRCWn0fGlidG6w1anTG43VaEZsWOJO6HGBzhlmTVOJvrbPQQxyirgX3bjip/uK+vh03AoiAvRRHqwhdz3RrqOUEF/+1PLZTBvJmuiT/whErhXO3CDk0GUnFv7mwKdBA1QjfzIun2ONT86Tv0piLfz1Zw2lRrVNgYiyKwO5UZdUUL/KA9JlfwDOzja00NamC4305GJfTSJmiRgvRdaWD/p8uzcvff8Iu6jqpkXDZTGEsScUB2rQRvHFuiQrJY6VGm+L7UrvV7Pz6kk7gYlVw==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1339.namprd12.prod.outlook.com (2603:10b6:3:70::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 19 May
 2021 13:46:02 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4129.033; Wed, 19 May 2021
 13:46:02 +0000
Date:   Wed, 19 May 2021 10:46:00 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Potnuri Bharat Teja <bharat@chelsio.com>,
        clang-built-linux@googlegroups.com,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Gal Pressman <galpress@amazon.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 00/13] Reorganize sysfs file creation for struct
 ib_devices
Message-ID: <20210519134600.GM1002214@nvidia.com>
References: <0-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
 <34754eda-f135-8da8-c46f-3ef45a08ea11@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34754eda-f135-8da8-c46f-3ef45a08ea11@kernel.org>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BLAPR03CA0094.namprd03.prod.outlook.com
 (2603:10b6:208:32a::9) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BLAPR03CA0094.namprd03.prod.outlook.com (2603:10b6:208:32a::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.33 via Frontend Transport; Wed, 19 May 2021 13:46:01 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1ljMWO-00AiT6-F3; Wed, 19 May 2021 10:46:00 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de18f955-9f47-4a8d-84c2-08d91acc70d8
X-MS-TrafficTypeDiagnostic: DM5PR12MB1339:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB13394A6096C309000C4A7ED6C22B9@DM5PR12MB1339.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: veJG0aWtmdIZ4iOto4NV35ucLp+6DEW1A5xgrDrlPOyB1dOwRF9N/W2LL5lzdDI2VeTsySNa72IqusO8M1rWm4PT8QIDVsZ1gD+mbdCw877bWnxMCBMcXhpuxIrUbc3xK+0J+4snjGbiF9/RWxCb/RyzNIMIVEFtXmLNcved62UyXrJtF7d3D/EKueoiwGMF6HQ51jrvaarX64HdUNDh1KC0j3WpmgPmgpbHzLVJVQzyF2F2PM8q2lPhhsmUMVEOXMvA2+5prjHt+fb9vKv9M1ITdTjmHCRENEHfLagrbDWoDqFxH3ogDGbmZ+ZjddAr1XMwtDqg8+Z9hPL6IAW9iyqabPza88cCQMD2vXCTGTM8IUrjsFDZGRs7Xz4newQwLMww56AnCfmEPG+GeUJXFX5/ggnCKULBNFuva1xdIdTpJOBlXzWwRIuQn/OEkyh3YzXHSQ+SqkzaGKQoPXubl3rBhM0Hs5gWZpbptP1twJ5sdPiJV/ombdgPlOm3JRkm4oIIXi71vqzwWqzVBxMh9vLQjUnB0AjodvKpIJ1sdlhi8dLKz0wYMDDfnZmK/JgT32j9vatoJ+SFSVqXI6CYF/LXE8BYKOAeLGt5GGDaXQM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(8676002)(33656002)(7416002)(36756003)(6916009)(86362001)(9786002)(8936002)(2616005)(9746002)(83380400001)(2906002)(4326008)(54906003)(316002)(478600001)(66946007)(5660300002)(38100700002)(66556008)(66476007)(1076003)(26005)(426003)(186003)(53546011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?GYPxGx8ggiS5cURrlrzpcjzJDLT8578w5uoh6vk3D0CWMEfckLXjoEg+9KHK?=
 =?us-ascii?Q?7gje4u6im9XM4MYKjAsWxanup5VPMdQovr+mG6lj9m/cwqqx9crqWfdK6JeY?=
 =?us-ascii?Q?/QweZgtOSNkxh0lVoPNMqDuBGgds4wR7rNsrANU1zX8x0Yo0Yaktw5urgD5k?=
 =?us-ascii?Q?DHMdL50raFB66ufr76k+6j+B2YyRf3GecHg+pJuAc5igEO/D8pKGtq3DqzrF?=
 =?us-ascii?Q?0GzU1K6Ju6W3LJhzO/YM62/2w5CiU9u/5QuxO779RMsKI9lz4k9qPEEUxbqd?=
 =?us-ascii?Q?ZdcGX2Qy4jN0eRb9xiiULpRdlKr4mpg92KN9DbYWg7opMyIQpCyzND2conGR?=
 =?us-ascii?Q?STFWs2k4uDEFyAnF30l+tHKohJiyiLVgwRZ7LzEXnLJ0NwRby1DAf0gLALs2?=
 =?us-ascii?Q?3hGYGttB2qomJutECz7GJ+vU2pH+Zc1YXzYTQ4V/7dS//04ClYb2G4ePuj61?=
 =?us-ascii?Q?9BF7k2JdG3CPXj2tD3ybu77nI71M9fdaNerGkJvEJ+viyKq3yHNNEth8AjtG?=
 =?us-ascii?Q?f5WVTSedknEGdtoN22FhoZTWGvQ72UUk2kpx5bfC1/GEHGiPRdQiG55gA6GE?=
 =?us-ascii?Q?v3Y8gXRJimb6s9WaBIPzrqD1Eg/mW/0cfK84sWU2S75O5UFEIIhaP/4fdslK?=
 =?us-ascii?Q?qtkMgS9+IEk9JSopHifieKLdvhjJKgT2pq5I4yNzqGVL0wJlTvaEZMwMxVec?=
 =?us-ascii?Q?LTLzUT5QLU/0PM0JSzwVd/h1oncu4H5ZdiSsuiiqrXu67ADJXFG1pLUjC6UN?=
 =?us-ascii?Q?/MHvsQjU/OBaYKwJMqJppl1Lr5Ho6m1xLq4C4D18/h25vb8+bsc2GPgO/FH6?=
 =?us-ascii?Q?HtBpZFLde2s2spgpVNkf3w9mdfgcW15+pk2EpudECulwcr4QE0naeSrPTKgp?=
 =?us-ascii?Q?VRthm1rwXJ1ItMjgfBMm7MganGFdPg0/MxCvfhoIWvxaLPE70gNJ54pl2t0T?=
 =?us-ascii?Q?fbqQcc5ZbE6cBWd7sDFcRJ0yO/81k3VY+qS5N4ktXcMa+oL/rzkzy3SoLoa5?=
 =?us-ascii?Q?IuUuXATvwp0Sf9vltHE/1kKGW4TpFXiMwfiN9KEDoh5FK+g/8F0DE80clsgB?=
 =?us-ascii?Q?9i1ofxzt/xcQ0R6XjgpjthJcWkZ/l2pjFe7NelE+UxNIaZF3ISoSbxxKyN/P?=
 =?us-ascii?Q?BEVIP/iFUpycjvp8CU03clAfoa4FST590BVPhOx5CucHK/8A9zHOqC8CLDyi?=
 =?us-ascii?Q?Rrtjia+yJV+gah1FJBiOocQd3hhGFrCJntSREHI7nmfhil6JOs3a2Hnk9ojj?=
 =?us-ascii?Q?ywkZradeTS8bR15HeFt//P6PuFYZPx7q5yS4TclN/YrvnsixFppBbbOipdtP?=
 =?us-ascii?Q?+2vqrsO64oWFseoKqvB7N5A4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de18f955-9f47-4a8d-84c2-08d91acc70d8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 13:46:02.0353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: odTVcIOeWJEmAV1vpJU6/L1tuxVazdYT/rIptRlbEC9DeZwDSK9SHkkAznJX+v2z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1339
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 18, 2021 at 04:07:49PM -0700, Nathan Chancellor wrote:
> Hi Jason,
> 
> On 5/17/2021 9:47 AM, Jason Gunthorpe wrote:
> > IB has a complex sysfs with a deep nesting of attributes. Nathan and Kees
> > recently noticed this was not even slightly sane with how it was handling
> > attributes and a deeper inspection shows the whole thing is a pretty
> > "ick" coding style.
> > 
> > Further review shows the ick extends outward from the ib_port sysfs and
> > basically everything is pretty crazy.
> > 
> > Simplify all of it:
> > 
> >   - Organize the ib_port and gid_attr's kobj's to have clear setup/destroy
> >     function pairings that work only on their own kobjs.
> > 
> >   - All memory allocated in service of a kobject's attributes is freed as
> >     part of the kobj release function. Thus all the error handling defers
> >     the memory frees to a put.
> > 
> >   - Build up lists of groups for every kobject and add the entire group
> >     list as a one-shot operation as the last thing in setup function.
> > 
> >   - Remove essentially all the error cleanup. The final kobject_put() will
> >     always free any memory allocated or do an internal kobject_del() if
> >     required. The new ordering eliminates all the other cleanup cases.
> > 
> >   - Make all attributes use proper typing for the kobj they are attached
> >     to. Split device and port hw_stats handling.
> > 
> >   - Create a ib_port_attribute type and change hfi1, qib and the CM code to
> >     work with attribute lists of ib_port_attribute type instead of building
> >     their own kobject madness
> > 
> > This is sort of RFCy in that I qib and hfi1 stuff is complex enough it needs
> > Dennis to look at it, and the core stuff has only passed basic testing at this
> > moment. Nathan confirmed an earlier version solves the CFI warning.
> 
> This series still passes my basic testing of LTP's read_all test case on
> /sys with CFI in enforcing mode. If there is any more in-depth testing, I
> can put it through, let me know. I'll continue testing the series and when
> it is in a mergeable state, I can provide you with a Tested-by tag.

Thanks, I think you can probably ignore the following versions,
confirmation that the approach and root cause is correct is much
appreciated.

Jason 
