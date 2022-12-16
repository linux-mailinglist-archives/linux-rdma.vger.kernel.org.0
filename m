Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1953C64F22F
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Dec 2022 21:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbiLPUNA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Dec 2022 15:13:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbiLPUM7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Dec 2022 15:12:59 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419156150E
        for <linux-rdma@vger.kernel.org>; Fri, 16 Dec 2022 12:12:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DYlAyFe70IT3gRaAyThR7HgItlNjENW1hLyac0enRz3XywGCoCAcA3IPNmHwUJTmWiLJWmtaQJGqHg/6HmrEFEy6hLnG2+0vcAUQdCsOXfOgyXQQF/uJLv93qQNyLyUIQ5dgfxyuvg6SLEld1xwne+WiupJV5L+XH3xNj04nQL3C5D+V5HKyU+9794G1lsbd/FQB7tIxv7O6PHjZldcqH/xuqH/BgHXYHslLSGRc7zYaSBiKWTafilYfk3dho/gu9UdlmLn1o5Vb2a+rJni3xVON6gHCrK7e7EtGSD/HrdwwmfhlcpgI4WLcB1359k8YzeG4YSyAhsr1xi4FEKG50A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mh3p+NG1E0PdBAYdD6UXxSibe1sLt3es9W/GrgXCz5o=;
 b=Qigozeg7hLapMRAMFLv38akIVBbcw5C2OMma/hr8/zWiDWrfKzfOzo6Tjwao2p9pc7N4OcWNxMCu5E7zh979S+bsDIZG2GOUo+mys+2usxcfhLW6Qi5w9gnPvBmo+9O7bJczSuhc7AwULra6nMcAFh/B4XjyTbkViRVGV+t6e039uX7c+2r+PVi1ddIjh84ONcUHYQt4rmr9oOEQGVamrJaXo2tC5aFqodvTpNGKS58my9a5zqOvpuMUF951unyUEbVMrubSOs+6VqJufE4p63VPI63K0t+GJVftlJJsg0k79HAYeMq97RtSPID9v4WqlsDkAoDFiEf407N4W1HgDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mh3p+NG1E0PdBAYdD6UXxSibe1sLt3es9W/GrgXCz5o=;
 b=RyoAr4+VdJvmXuZ3HBnnUl6T6GJuJLO7hXzpceamaZdwngU4bU4tLdm3VEDCSD1MZQSqp8JdXna9AISnovqicUgHquXY6GEDj2y6Cld45tqtjPxDLkgU8VL5qUs5Pp9a3AV5qC2gp70OSDYTVAzoxLP32ZNdblNIDHrP4i54+nL4kdnjWp1F4ZaujPVdM1ib4WtHaFK4+2sI957RjlgvfluR+DO5qnIyITIe4QWY3PyCBj8LrqSK90fqV6jUo+tJBIAONZjblsdj1YhS0eyaUBkTDu1AQ0wTfYY7JxwVhfWSXDOI65KgHd39AC7j5iYBDbVLz0i95XZr0xOXcAotFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5859.namprd12.prod.outlook.com (2603:10b6:208:37a::17)
 by DM4PR12MB5844.namprd12.prod.outlook.com (2603:10b6:8:67::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Fri, 16 Dec
 2022 20:12:56 +0000
Received: from MN0PR12MB5859.namprd12.prod.outlook.com
 ([fe80::463f:4cb7:f39a:c4da]) by MN0PR12MB5859.namprd12.prod.outlook.com
 ([fe80::463f:4cb7:f39a:c4da%9]) with mapi id 15.20.5924.012; Fri, 16 Dec 2022
 20:12:56 +0000
Date:   Fri, 16 Dec 2022 16:12:55 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        "David.Laight@aculab.com" <David.Laight@aculab.com>
Subject: Re: [PATCH] RDMA/siw: Fix missing permission check in user buffer
 registration
Message-ID: <Y5zRR4KbAFOFIvpU@nvidia.com>
References: <20221216183209.21183-1-bmt@zurich.ibm.com>
 <Y5y6OaG4+6kPt9O5@nvidia.com>
 <SA0PR15MB3919045403A59EF36370173599E69@SA0PR15MB3919.namprd15.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA0PR15MB3919045403A59EF36370173599E69@SA0PR15MB3919.namprd15.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0371.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::16) To MN0PR12MB5859.namprd12.prod.outlook.com
 (2603:10b6:208:37a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5859:EE_|DM4PR12MB5844:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f55160d-b7a6-4ccc-6ef8-08dadfa1eba6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W9R/opbhiMG4X2Ff58z46upWhNiYiDCM+R3dgWIP0mQ4CTLocf7R5VCzTIAcXUaV2YodEsHBSkig707f4V+o5e8rHYFecksekIQjQz1twd9mDvmGfkCw11mtjpxHLRNKmc4xqWy/c0XyEY1Lwi3cgTbSY/V4UBBh74deSuisimY5rJp08iGmIY6Ab818q1Bwp7Rh/o9zW++MEFg3tx7RhgMDSaWq2eBodjEfFwV7XJBBShSmSMfz8PhoHwGW16pjtwuNPwmYUiCIBOZZtc1OvJ3NvEBpMKkSaFnba06rBE8T/8iUs4FmzwtuZZt8QSjL7f0OEwZEJVOdbK/xDQhpzn3GwxMPl4CfHFT17EmJAe7sWYpNITOFOSxWntmB7yUUC9SVHVCCbJsVfEhyTwQcjFSPO2mSm3xNvPxTX82Ftv2VUMPIq42gtYoJjcq6MvR7ybe1SwrNaSCogJcGSrRXRr7f5P8g5U23sKRzg5ySwKSDDTTdmTxYkSCCSAOuFt45ppAniCxSDkwxFwACbwo4dbf31aZhCM4Or0wF2xxvxw7xLeIuYsgsJfiyMVoX6eWVg+LGxNV2kC1OLtQzBAE472BSR4alYy1OWSeDHGlB+mtj6g82WMZjpvWDsdmWsedHN6M9yCSCLTreeH2VmnlrNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5859.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(451199015)(6506007)(478600001)(6512007)(53546011)(26005)(2906002)(6486002)(186003)(316002)(6916009)(54906003)(38100700002)(8676002)(66476007)(4326008)(66946007)(66556008)(2616005)(8936002)(41300700001)(36756003)(86362001)(5660300002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vn1FgJTdEeLfCOtACywBxepmfkESA9RrlkpTE+oinIJHLnn0NUHAWuLBr/2a?=
 =?us-ascii?Q?h9DMXPNBjFp+A37mEbHUlIvbA8qIqFps3yWNoXV64ixAvVvmzCY2R1fwgc1R?=
 =?us-ascii?Q?MHmQ8ZZEudkPOmTyaORvOG1eeaDk+zQDi47InznPNUMfevkVju75N+we541x?=
 =?us-ascii?Q?bo4atgQKJSlAllDsLSbXb5BHBEC4yR4hwXrQflavQtQqVp4wYSLBJyohrPvO?=
 =?us-ascii?Q?wWtUrScMu28/iQ7L5XUctf36clwTVclhmoX3am/6GVSYkC1MiMFE71CwUMnd?=
 =?us-ascii?Q?Od6oj9zzk7KVVNDZDvbeWgsKFam+QfZAuH4M75YrbxWu+taintupPkJVU37V?=
 =?us-ascii?Q?ev452f8gdnr53q1x9IV8AW/gGyHZ45EzKNCEvTYO/koC7Z1GkJ9Jf+FmdWSO?=
 =?us-ascii?Q?8RV/LcNm6zgfULpJc4p0QO0Igy0M9zsH2D5sIAT73CaUSTlz7J2Bc3tqi24F?=
 =?us-ascii?Q?3IRCsj6AdnaxEZs2ux8Ma/yUr/I+z5Cmk4EZw3tPCnYyaSLN3vBdDH58YZgY?=
 =?us-ascii?Q?lNkAD4iM/Skd1YbRYXdAXM4TZye+7rOinFfR++JJHtQJZCsBnYr0JsfGoKXh?=
 =?us-ascii?Q?iUCkXssk81G6OGyRtzYm7iBL7usEcRh9LYxWLk+9wMHZX/daWgA0I8uC9erY?=
 =?us-ascii?Q?Za4euWI7QqQApTshcSv6EssWzPKKzuceD/tMJSdoSxrz7kS69ZDEbpZk4s1i?=
 =?us-ascii?Q?z6+ClZtMVJOp4/yfoQgmSADy4hMAKOimX3niB5LBiqi1+ATy5spZBS4tjm1k?=
 =?us-ascii?Q?BxEfi8heG/Ne4D/78jnGMsJmyUH6HmOuvgtvQwEPAosTOnIRnmCBMRwwhqAN?=
 =?us-ascii?Q?JK+Aq4j5ZFEgZbG4c1jgdKueTABEsXivFFyLlfkTj9NP+L2w8in7db57oram?=
 =?us-ascii?Q?5i5QFLaqNeKavnWZ7GLnqnLcPuoCnlIop0HXKWeiblj/LrXUUt2wLDxcna2W?=
 =?us-ascii?Q?VswoBSTOijyF7VjNG4krtu/uXpI/KT3f7ZeXWKYET8iOfgUMqR1sofFI3Gl0?=
 =?us-ascii?Q?ExT73zSyMVRqIaXmkFKk834J9SZWd7DqIrNmLuBlPDZRZwt5oX4RUqF0eOdg?=
 =?us-ascii?Q?YaJhIBt83baLr5wn1LGiwkOabI+uuQXtcgVvuStdc7zsOHuRctDAe/vo0azo?=
 =?us-ascii?Q?iZ9ZMkQYyD3/LcwUwDhEL3zFZuQzBwr9xdra39ZHSJwnl01B77pQTjVT6sIj?=
 =?us-ascii?Q?DuvKuQBDf9QjImW9J0iXEjkVTNAabvnORNcXHxBGBG5ERd+UUzOUNpNr2D+N?=
 =?us-ascii?Q?rWBKzAJa604UUYc1GJMsslH63WHbOCFU1cO2TLH/A02xzuGPd4Q/5+nljUfS?=
 =?us-ascii?Q?KSInOEISyky+eSJAnpJVEfvrTWxuWGgI9rLAzPpsHxi2meAFeCEZJDlMW8F5?=
 =?us-ascii?Q?YE6WE6zctkmz9q5cFWt7KQ0EGfqMWLjqL8EOFfGYl6WmUzLwBmovV4/tR4cv?=
 =?us-ascii?Q?z3mmm6BtRO8Igt8EF23cAkMtFUXjOBpF1mYY66VuN/j90YMgOoL5S1AwHeyu?=
 =?us-ascii?Q?vfT5yiOYB01i0y5n/yK1+TivkiQ8aCT0GQwW2t6ug+P5ZIDJI630SGTOFIns?=
 =?us-ascii?Q?PyLkj39K5GdT22RUzZk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f55160d-b7a6-4ccc-6ef8-08dadfa1eba6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5859.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 20:12:56.4034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GrNMTz7S1LQpPDJBuJqlT/Dx88nQPGjvBtwAlMoU9yqlKCgXkOlC3I9neL74rHjW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5844
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Dec 16, 2022 at 08:11:32PM +0000, Bernard Metzler wrote:
> 
> 
> > -----Original Message-----
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Friday, 16 December 2022 19:35
> > To: Bernard Metzler <BMT@zurich.ibm.com>
> > Cc: linux-rdma@vger.kernel.org; leonro@nvidia.com; David.Laight@aculab.com
> > Subject: [EXTERNAL] Re: [PATCH] RDMA/siw: Fix missing permission check in
> > user buffer registration
> > 
> > On Fri, Dec 16, 2022 at 07:32:09PM +0100, Bernard Metzler wrote:
> > > User communication buffer registration lacks check of access
> > > rights for provided address range. Using pin_user_pages_fast()
> > > instead of pin_user_pages() during user page pinning implicitely
> > > introduces the necessary check. It furthermore tries to avoid
> > > grabbing the mmap_read_lock.
> > 
> > Huh? What access check?
> > 
> 
>         if (unlikely(!access_ok((void __user *)start, len)))
>                 return -EFAULT;
> 
> siw needs to call access_ok() during user buffer registration.

No, it doesn't

Either pin_user_pages or pin_user_pages_fast() are equivalent.

You do have a bad bug here if this isn't holding the mmap lock though

Jason
