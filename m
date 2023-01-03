Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEBC65C075
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Jan 2023 14:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237372AbjACNI2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Jan 2023 08:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjACNH4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Jan 2023 08:07:56 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0BEBBB
        for <linux-rdma@vger.kernel.org>; Tue,  3 Jan 2023 05:07:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MNM2d5JqkGGcabKChIb1M8OCX1ypaEKAy/6qXGrAIkEjKLjiyJu2ucBcYp5p5BRQbCcpDcpg9ZuDNODzACAU9bOm3oTHWMAxFmV2aCWTrBjJ0IA2kGB5r/RN38eNf8uxn8QTR1SwzORuKXYp8CHyy1lF7kSmo0PbqAANDarjwzRGNt2UxcOZcXp7atxn90bOaP6r57pltLSEfHC+6LX1X0oN+alB6IwNNLDADDlpFlquVM5olRAnMxGu9Bn+DLcJ4qA+YWx45Z3nuMSyrLY40U6XSLJd127Z+Wv77zaTMgjGUYoC1swDIsKye8tqG4KdhYMA8BU8sy4BEmgNGOC7hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7L2E7ZZSWUIkK+aAJSmxTRZYdDsG1Vf4btLVOxN4eGI=;
 b=XpzhR661xOZ8rI46rTRqkmaxS/9Ic4ef8pWtyZEPqeTQrSm22L370BjtJudJ2k/5AAlIb9r2XX0nfHwHOgcQ20OGKIg2TQ0iDgIly4b83/SVqnBxa/TSLRV6ER48WZ8YS61AolQDlCVWWzKXc2LJsuUVad+o2Gd6NfKSWUqhadHE6InhVlGkIqCvrAOQGNeT+4cMYcXEPfoQn9Wyc+B5O7sFQZOnHd4ZCaEQL9bXu9iCXdXM/UpvwjpOX9l6bmT84ddyBP5h4iAYQJN1OHlIB7+s/p2GMHe+WjI62Dtb89ax9SNz6GH7/Vj7rDEk9dWIa55hB3ma/3qWUji/LJHXhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7L2E7ZZSWUIkK+aAJSmxTRZYdDsG1Vf4btLVOxN4eGI=;
 b=sQP1LU7BjzHLmQi9HLpciiAgDy/SmYVYHGA1bZnsQpQxuYB2Jetim/HScVqS5swzfAzGhaGUwUfgHkeAOmc9UT1krPTSTFoMbWfkWjZWIsj6rliYyGlgJPui4b04iwt1i80S4DvEUvRREf52u8PblENF1TpGtu2crQgjXdnEPv8GcIoG28U48VpNBvxSyspu9i5LvmTQTIS2afhe+tCG27jXhp1FHBgk1rLhFKceweQVjJJF1mfVVjxUWZwmMBjU6mZS8liK4mtUSQnzlrStjMyJISqJrnTO3ZUN3aATT384FLYHjfpkq7u0u2VJJ7nXFDZbVBb6qV3O+EgKqH6Gkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB6995.namprd12.prod.outlook.com (2603:10b6:806:24e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 13:07:50 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 13:07:50 +0000
Date:   Tue, 3 Jan 2023 09:07:49 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        "David.Laight@aculab.com" <David.Laight@aculab.com>
Subject: Re: Re: [PATCH] RDMA/siw: Fix missing permission check in user
 buffer registration
Message-ID: <Y7QopYj1p4eeLo5N@nvidia.com>
References: <20221216183209.21183-1-bmt@zurich.ibm.com>
 <Y5y6OaG4+6kPt9O5@nvidia.com>
 <SA0PR15MB3919045403A59EF36370173599E69@SA0PR15MB3919.namprd15.prod.outlook.com>
 <Y5zRR4KbAFOFIvpU@nvidia.com>
 <SA0PR15MB3919266C672961F49B28C7A499EA9@SA0PR15MB3919.namprd15.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA0PR15MB3919266C672961F49B28C7A499EA9@SA0PR15MB3919.namprd15.prod.outlook.com>
X-ClientProxiedBy: MN2PR06CA0022.namprd06.prod.outlook.com
 (2603:10b6:208:23d::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB6995:EE_
X-MS-Office365-Filtering-Correlation-Id: b7332c84-e18f-4f32-0a6c-08daed8b8426
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DAnHnXAD0mkAu86etb899Wcun+0v/N60GSqUJqS3iF4aZEFYXECQrHD2VE4TWoIdJintgKPljcIMjL/GrRGmaSCUvo+Gitiudm2SOnz0uVGZLy0tqGijkxH0FPiYOnmzNp/1Eq4w2RWi0Ms5BzxRI8MPL2NuhD67UB1Qz7nzb4sqiDO8GEGKYjmvnlkDYLoVvlYPv/XkFWIkDDsf3lUwZ524cQwZOfOjrkjkVVPaNEPRIZQU2OeiCk/SD67JNHFeEO+nILrYXWTy7vcXL6p+O84WGv6p4VpEYBPM7w4k29CO/ATyBTx2F3I/EEH1tWsLmmRHcM4LjIx+1iHf+2ZsX5aubb31BhoLHokNfTt1NQSJukiSR5xQHZP2dGOVQl9zRNfjl77C7sc7kbfAMfNJNQJt+i3LXWEcTZmS/DnHW+wqS0U6C+YmiQaWPdKxzW4OBomDmmCmIEWnkjqLOJpdHfzneCEgwgy1p/mt/fMzJE8ny2veT6//GStjs2xf0icqtFudKqfAPq6EdtqceARAkYIK8qi02yTm4Prp7Pko9lhhkerUZxc1h504UNo8lySvErAEgdYtdH3y+mCsvGj5n4wAu8DGyasI+UzcJmm2A6ZTPHJoddCEL5QEq0MYRLKBE8EJa/nYfIEpNykiMMA0ZInBG2MZG23I2NGMicxTXHutL784fEayr+yTHdoRReTi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(451199015)(6512007)(478600001)(6486002)(5660300002)(36756003)(2616005)(38100700002)(8936002)(6506007)(66556008)(66476007)(66946007)(41300700001)(4326008)(8676002)(53546011)(316002)(26005)(6916009)(83380400001)(54906003)(86362001)(186003)(2906002)(22166006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3ANEqFQRSSQxePFKaSryEmvTq6c/pGHvpIbj/LDz7nnLC5irfS+z53Ed77mA?=
 =?us-ascii?Q?IqspzxhgHaJf8iL16sE599S0Stz5zfuRVCIRGj2JKhIu5APTkVYn6hM5OSXB?=
 =?us-ascii?Q?DnDTG9cWR9zrKXeUW0PohtJgrCLvDxb6t9faDO5zJA678ecejYJCm07uH/nP?=
 =?us-ascii?Q?PdZkIVKuils+DwomDwiOXxIKq2nAk6BkJ+TfKiJ9uUuQMMo5ffQKMowc5TTo?=
 =?us-ascii?Q?/W0ZkBiK+Yzphs/2kPtqtNNnex931RRXmpX75eww4bKZ38GN4v/E9da1acQd?=
 =?us-ascii?Q?lXf58Dv34k5snwgHnI5KtwP36JT9UX9RePLTva3eQ/iqcBaaZfnVaeuM13FR?=
 =?us-ascii?Q?fPGl8uyqr/E7lODGZyx6YuH75WIyKhn3d+ys3ao2eL/Cwx6cr11fc72gvt+W?=
 =?us-ascii?Q?G1CAVcHC8rklEp1ZLSggQlNwXdbAovUKWCAJkayygAt7o9QCyUiYFdrGPaFz?=
 =?us-ascii?Q?KnxIeZObRmjmmHbtw3MefbMaED6T7/7FD/0AoOrgIih3AWg0cAZ8dRTbfe+r?=
 =?us-ascii?Q?j66N9wy3XsV5PsJde0L4hpI98DJ8828eX8KsTWcS1rcGQLDqk9wE+aZkeoi0?=
 =?us-ascii?Q?nlMEMxD9wquvxORYUYEyJFT0wWZjsnRp/C4pZQtGCLQyIE81OOKIbzLp06Fc?=
 =?us-ascii?Q?8PgxHvNLfNk114c6X29BXSVqwiHP8WT2YBlP00/Bocr55Tzgj2fuXL0T4eWx?=
 =?us-ascii?Q?9JCJ1Hcj/nYkYc6aZVjHGJ+VY6VobqbxW27KOQxirvlIONGgP6UAbKnzwhRp?=
 =?us-ascii?Q?CtiCGs7vGWQIdlG2arYkoR9RHAGoU3QFX5IDo+PMTM7bKVRr9O00gmYABE2v?=
 =?us-ascii?Q?MVZEHG/Bn0rqUR8aPsLvUxiWiM8tbYDngpW07G3oT67Wu8MDZiQKftJJVhEe?=
 =?us-ascii?Q?0FGK1Dm3svrkFVYZaLgf69oHCb1XCuQOypwizKHnO2Uvdv6DSzlBdeH7KEGS?=
 =?us-ascii?Q?+SX/Hv+l3q+WAKiNNwug/AaH/jYRqXEgIeDvKL6y3nixeK+1Sf7ys+hTCyTd?=
 =?us-ascii?Q?na/PUjUETX7fynZYEze1NJeCH8QwJSKwDpsq//Z90bylLHmBxWTVqkwogku0?=
 =?us-ascii?Q?Nm79sdhdLGVgAA014mYd25pp6nPvEdMMa1ROorp9O1/cMGSu2DsuexlThwWC?=
 =?us-ascii?Q?10h7KOcByBkh8ktQwZGX2zbuFnqMN/0bcM0y8rcdI+Qmyzvmx7f/rM1JFPC/?=
 =?us-ascii?Q?QmlJe/RYt3o9kOBeJv/tpk9cG5emiUAwrcnAjwI+zvhD2gT0VOqcE02CyxMq?=
 =?us-ascii?Q?wMPAZUvkeALM6apityf7fkxOsP+yoAsC5hNnMS9GHqhh0FRt6OCz3j3rhbZE?=
 =?us-ascii?Q?kdAXtDqd8NMiyVCdyemZmLqjh7McdmUpdk68POHcUU53Sw8lc983lJi+IWzp?=
 =?us-ascii?Q?YQd0nRid0oIeXJ8wpGAYxzkmbarc479KdbgR+AonQN4j8ygdU8LfrhzlexIW?=
 =?us-ascii?Q?qjS6RfIbHWpSfgR/rEzGwyJ4BPlmBQGwMK3m945s69ywp5PTc9OOKEpElgfV?=
 =?us-ascii?Q?pvC1bf4/xNZQT7JQqFFIHg1NjQB0+ehol2+VSPE0Vr5xZxlzpwoHuEkSxB8Y?=
 =?us-ascii?Q?a1xNYskyHKvJMAJhM0U=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7332c84-e18f-4f32-0a6c-08daed8b8426
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 13:07:50.1075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FQpqTSTfLpLsUtJ2M42Jh0JGA7em9ofKJmrd6j6vcu3RnLCa3di1Mocm6kvReD3u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6995
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 20, 2022 at 01:52:43PM +0000, Bernard Metzler wrote:
> 
> 
> > -----Original Message-----
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Friday, 16 December 2022 21:13
> > To: Bernard Metzler <BMT@zurich.ibm.com>
> > Cc: linux-rdma@vger.kernel.org; leonro@nvidia.com;
> > David.Laight@aculab.com
> > Subject: [EXTERNAL] Re: [PATCH] RDMA/siw: Fix missing permission check
> > in user buffer registration
> > 
> > On Fri, Dec 16, 2022 at 08:11:32PM +0000, Bernard Metzler wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > Sent: Friday, 16 December 2022 19:35
> > > > To: Bernard Metzler <BMT@zurich.ibm.com>
> > > > Cc: linux-rdma@vger.kernel.org; leonro@nvidia.com;
> > David.Laight@aculab.com
> > > > Subject: [EXTERNAL] Re: [PATCH] RDMA/siw: Fix missing permission
> > check in
> > > > user buffer registration
> > > >
> > > > On Fri, Dec 16, 2022 at 07:32:09PM +0100, Bernard Metzler wrote:
> > > > > User communication buffer registration lacks check of access
> > > > > rights for provided address range. Using pin_user_pages_fast()
> > > > > instead of pin_user_pages() during user page pinning implicitely
> > > > > introduces the necessary check. It furthermore tries to avoid
> > > > > grabbing the mmap_read_lock.
> > > >
> > > > Huh? What access check?
> > > >
> > >
> > >         if (unlikely(!access_ok((void __user *)start, len)))
> > >                 return -EFAULT;
> > >
> > > siw needs to call access_ok() during user buffer registration.
> > 
> > No, it doesn't
> > 
> > Either pin_user_pages or pin_user_pages_fast() are equivalent.
> > 
> > You do have a bad bug here if this isn't holding the mmap lock though
> > 
> 
> No, that lock is held. I was triggered by David's arguing about
> protection. I went down the path of pin_user_pages() and did
> not find a singe point where access rights to the buffer being
> registered are enforced. pin_user_pages_fast() do have it though.
> So I proposed a change in siw to use that function.

It checks it when it reads the PTEs

Jason
