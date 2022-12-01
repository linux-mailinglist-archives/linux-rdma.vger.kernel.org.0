Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2AA63F0E4
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Dec 2022 13:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiLAMv2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Dec 2022 07:51:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiLAMv1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Dec 2022 07:51:27 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4581E92A1F
        for <linux-rdma@vger.kernel.org>; Thu,  1 Dec 2022 04:51:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJZvROcLpXOMN6vDVQAM42A/N5imHiDMjcJlRBRZnoJeEv2oxuBPOxe9DnUONa02LuoOQBrh617TFAmZjd1FGYkbjMQUGXN86Gc8VVx9bgOuBb3EtMRR42bUYbrNBJS01lpvsUUGPoum2NSF69jtELPmeav+2uSSKelF5XZZ3f9KzrcaATe4Tb3yoaySklwZnRht6fa9iu/da6sf2+LCz1zz3iFdk4SpFGxuJ7y1M447Szh9VaMTurM7QDDHdtdkK21Y7Yhxnw6+L/69zlTApfQy4hI7rc3Dk1rXRDiPKAhMZ4uXro6qjf9Gry+q16Sv63QqvMZFN5CfU4LRA5321A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GT3Fmf9uExtgh3oAtovHSNJD3jI21Nm3LezrHWvdxTc=;
 b=W4/NoP53NWnK8Dl/aQC+N8HQ0vUbsIcBcXMyfgOUjoc//v3H+5Bl6Y6TxXakNknCjiDM7siphYZVZPQch4xeXmSF1/3+k/W2JQL5Cro7zwspuMj0t4nVCRZecEiIohAB7YKnZRM+dd8AdgC3TcoMxrjnFYhfHzeby+mpqKYINcL1Ni0Dbx7vrajpbUS6cb8csyjYd14x308ZbSAzhUgeaOr9JymMDpjKmZBbh6lekqsD+F6bz6Smw+fSwun9sazBghKS3ul4/8i9NjgPZuR9qWWnS95w/QIIgLysXuJMsD8Wp9VgAIOYFg8UwNaL9ppiR3ZK5d+uuuzue24XALfLww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GT3Fmf9uExtgh3oAtovHSNJD3jI21Nm3LezrHWvdxTc=;
 b=ABpsWHin0piZ7beNfPksEvwiAQR8YepovVMWf2h7y+JnOF41Do7S99vn8LGB6P9tNMECpG3YVyjOE3ApSIDIbTCLV4r3cslltFVhvNZTLojwVK12epc/2LsilZX2QXyPHPXZt2UysZtRm0CWiTrwkLMZBMON1fHVnHhN0psRR+IW31nKzWMTthFNDhzIkFRTJuCvVx9TMOR2SaKmkkX0jNc1t2FxZaoXRn9HuH6hD1EOmJ7dcSoiN4eIKb7u8TcUd9kvjhH2C1iMZcyJ/HdKr9IILW0Kis5tvxD69Xsuv1wizBaNNcFiKdwUqjbRxTGBZ+24AqyKvFND79zT/hDB8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB7872.namprd12.prod.outlook.com (2603:10b6:510:27c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.5; Thu, 1 Dec
 2022 12:51:24 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%8]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 12:51:24 +0000
Date:   Thu, 1 Dec 2022 08:51:23 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     leon@kernel.org, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v2 06/18] RDMA/rxe: Add rxe_add_frag() to
 rxe_mr.c
Message-ID: <Y4ijS0Avo3Ut/uFE@nvidia.com>
References: <20221031202805.19138-1-rpearsonhpe@gmail.com>
 <20221031202805.19138-6-rpearsonhpe@gmail.com>
 <Y3/Bqa7obMROAtr8@nvidia.com>
 <7ebc82bd-3d1c-e2d3-be4f-2e5c95073a65@gmail.com>
 <Y4fo6tknpuCveRgq@nvidia.com>
 <fd788906-6e40-8109-f6a1-5f281361c68c@gmail.com>
 <Y4fzZk7D9GgLNhy9@nvidia.com>
 <eff1e3d7-03a5-97fc-e494-f9ba93c185d6@gmail.com>
 <Y4f4NkV+4ZbubQjp@nvidia.com>
 <10cec5db-a6e0-6d02-7d1e-5aba673aa2a9@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10cec5db-a6e0-6d02-7d1e-5aba673aa2a9@gmail.com>
X-ClientProxiedBy: BL0PR02CA0002.namprd02.prod.outlook.com
 (2603:10b6:207:3c::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB7872:EE_
X-MS-Office365-Filtering-Correlation-Id: 22ca535b-fb19-4982-6f25-08dad39ac10f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A71DGAkWWWn7nQNlpUfzOE6EKSWcKE+SRfMgTjcVtUqyAJJynHuCtIU44b3fTnxpCbUMZ1wKubwN3CRm6DLLSih5yd98Gf2Y3I/ui9bmzdgDcMxnC05U8VbMPvWzkqplhaJqMpjmejOZ34qU8icLHDDVdcrtZ5UXVrgb3sv/gOWFvLyCwG2LFpoZDgUA34iyVIGZH/o6GSxOvxD05nk+k1pDsajZEKnVWkElm8AOtA5Y+Qj3GnHS7uDT486M8Vmq1FXnPycOpDEysamoyYfGPgWL1nNKrfkvu1W9Hb2T0LTsuL7QZOEwZ7PwsL5xcrBog4Ee0H0VG/KTFl1NLoNVQJ3i/hldrdP2spS6y6NB/VGXLsBootlAOXVzm6loKr4o8NwsK6CYwrcMojtGXS2hjDhf7HDCZxPmo2fwe67MXnco8wP6DDtOATfLuEtuzXcuEjEi0u80foiz7C+qMfXjRQxVRTc9WgThcdKL2EUR9RpArC6RcJAoJlSCKx3JfsRNrnHXNwn7/lpQasivcsPjOXEEdqYIAxEGTTRvlDi/iNIbCa25D7RJdAWeb7RsVll0d1U9DhoxThtFnsLxhdJ1pop041U2WvmwZ7Xdhs6NHZnxzfjr4KYR9Pwui9Ncz5govqClCc/85N1hW0USx510pw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(451199015)(66899015)(2616005)(83380400001)(26005)(6512007)(53546011)(186003)(6506007)(36756003)(41300700001)(4326008)(66946007)(66556008)(6916009)(316002)(8676002)(6486002)(86362001)(66476007)(38100700002)(478600001)(2906002)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vupmg2abkdBPXux1UwrRWfg9MxPpfhCgCcUl7c6sGKr1XMThE8zykG2GKeG9?=
 =?us-ascii?Q?XaQy1lkyOvQ5nK1bMUz9/wW80Dg4NWfM5tMDrqtY1V0sV2FGBlB0DwLFQcbX?=
 =?us-ascii?Q?mw8NgulBchjYHkLzg8Y9Du4wm6x8jTgPv/BjRcQmoWyoQRCIm2H10MhMUIjU?=
 =?us-ascii?Q?YHjMeFsX7eIb6jN9ZnIKQ9etDig1I9zkB6xAs/dKt8ek3jycvwWhMJqU3wlQ?=
 =?us-ascii?Q?oXVbDqfgRiA94b0xJQPq/Yeg3FMPtEQDUCAZbjleWPjVrNo9HFYCGrO2bafA?=
 =?us-ascii?Q?pDH2N2WjtplQ4+ssa02BtTNoTFUXp2C+G5oY0cSLIdQiSznxQ2xyxnfHRkaf?=
 =?us-ascii?Q?/HNDWTgaQI6eIqtdom4qNF5QVfQyQsOWA0C9UtI9aH+2CVmHhqTM1z7s6wsf?=
 =?us-ascii?Q?HiSCKlgVrzBinAtIDhdUONEcxHwa+otHmJdr3/VH5zFaDotSAKGEx7+SKogl?=
 =?us-ascii?Q?Jkq8mQ94EtWc6Xi9HbToKb+J6t/T2SAP0EjHTeeVuo2Su4cUrDGSFjiVn8u4?=
 =?us-ascii?Q?EPo/j8+xyjL4mEwTyTNwJu/8XCUI9o74bUcufFeIc8MRQO48B0KSMGjyIWF2?=
 =?us-ascii?Q?eLxOVaOkm/pYkdDG5V51F6jNuZ3Y9Dyr9oPCHflL7LyJblUTUY8WVbf6fugJ?=
 =?us-ascii?Q?q/QCE6FsMGzU7myZmj37VCVLALU12dG94vWhlYRccqFNJ9YB33UoqE+v3qj5?=
 =?us-ascii?Q?nZ9/aiRUerycir9yZ/0b46Upeqz9a8Z0wqsMf9rGOIHiO/szBkyN/DoCNUYZ?=
 =?us-ascii?Q?KrUBK88Yw8InsaJGvBsHWY75ToXdIOhR6cFjviDB8/D0cqP4ih08clDvdpt7?=
 =?us-ascii?Q?2ScRBnyGp6Rcb1LQloLUKYdakwDw5qE6nZQgGk8AfXWBDdvJgI6VnzdvGfT7?=
 =?us-ascii?Q?kJ6P0eE8j52Km9Ix461RWqh6hPAUEIz1X4qelihWZc0/hKBgmsFGLzgJZn96?=
 =?us-ascii?Q?ZZtBxDek7w8EUtdNsObvRXJyiMC+lwJWzmpxg1QCKfIMLYJOQXmmWWNWhLDU?=
 =?us-ascii?Q?BUMopSv+pk6U/rnrW84s/rb7cOgnYKwyD8oeogqo2jXTzA7lFLjpuN9J1eMM?=
 =?us-ascii?Q?XqwIpI/mJyACoJ5W+QWm988QKh8WEBAT7fb7EYoB1jaiYagz05Gj/cPIyooP?=
 =?us-ascii?Q?KoJUDL4wyjnZzFKduN5VlFf5EEClDUEHm+TyOvNg3eCffrh32+hdBGfO7Vqz?=
 =?us-ascii?Q?jb3Fqz36xbnhz2H9owKIwiaTYMeXtfAebCKIezKwrgZorCCJlI0/Dy9KsFH+?=
 =?us-ascii?Q?hQhprsHM4gWismqQONs35AqU8ItiBQ9j4NwjnXXojxjFlzjIHeWXoCt8WYSw?=
 =?us-ascii?Q?AxbSmARgD5gImyg22FRHWDkAWpED8vhBiVt6pG0mM+lV+u2nt7TcOF5aAnzs?=
 =?us-ascii?Q?eKWKvcBOKW8XCf2VhrupVHVEnEqGYLoUH+QhWAAi5rBQYkw9VrU3q3y9jUo2?=
 =?us-ascii?Q?4V71h8jIvANJctVL5vue6w+pIqTkFhGKatwrDpLaaFf8DLOJHE/iRwdgeMAl?=
 =?us-ascii?Q?R3jD577SKRFe7GsjXYg7H17jbQVtcW89FFXYpjYDDBrWYXnqu2b2aqbsIein?=
 =?us-ascii?Q?DRH/o2ofVZPdDnMtsyk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22ca535b-fb19-4982-6f25-08dad39ac10f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 12:51:24.5191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZoXO/O+uyaOCZVx96pbKR5DomyvI/p1yhcku72t0FYxbqW40R5zGILdrRTpuwN1k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7872
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 30, 2022 at 11:05:04PM -0600, Bob Pearson wrote:
> On 11/30/22 18:41, Jason Gunthorpe wrote:
> > On Wed, Nov 30, 2022 at 06:36:56PM -0600, Bob Pearson wrote:
> >> I'm not looking at my patch you responded to but the one you posted to replace maps
> >> by xarrays.
> > 
> > I see, I botched that part
> > 
> >> The existing rxe driver assumes that if ibmr->type == IB_MR_TYPE_DMA
> >> that the iova is just a kernel (virtual) address that is already
> >> mapped.
> > 
> > No, it is not correct
> > 
> >> Maybe this is not correct but it has always worked this way. These
> >> are heavily used by storage stacks (e.g. Lustre) which always use
> >> DMA mr's. Since we don't actually do any DMAs we don't need to setup
> >> the iommu for these and just do memcpy's without dealing with pages.
> > 
> > You still should be doing the kmap
> > 
> > Jason
> 
> Does this have to do with 32 bit machines? I have always tested on 64 bit machines and
> dma mr's are always already mapped.

Originally, but people are making 64 bit machines require kmap for
security purposes

Jason
