Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAF07A9EDF
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Sep 2023 22:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjIUUNr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Sep 2023 16:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbjIUUNe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Sep 2023 16:13:34 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B465AAB7
        for <linux-rdma@vger.kernel.org>; Thu, 21 Sep 2023 10:21:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pf7ysej91FHJfbauQkSmEjlDuSpgfTiaZwlYS6uyuAbM4OZak3qUC2AsCDy/yoUwa7M5ZsF0ltBmgXsoeH7J49iXJqTeZCAauimpEqifhijiwoWizArUBF4H8Wtjv0gcpVb1GamnXYZfkl01Z3JWiYYm7zxJtiAjJal9pveXifECAuFKnSW1psHM+4SMZxfjs8BCEQV6KmNpzcWCLnSRphHv3hMt2bvDEuk9LUdQKnqJ35b/iBkfZo6AU/7MUkOGa9ztfu/g3ZpmxOSjbMZpiwp9fz0ywYSGRiNAGMMNKNcD2RwLQ7s2o0M4ImbZtWu4+UP9vdBkaPV3zmKeTox72Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/uWFZlOo8kke/9QUopbg8t+aI2KRqJPgc77Zc2M5b8=;
 b=GkSjvT1NSdUfYHMUb+fSkpCFQa78HzJkLzGXkl2nqP4ajiTKXDaNI2Sq7MsJ8GwtoqVPFhwPoVTD50fFfIsWueHZm+f1QfBIO88nufk6ARRxZTibR4Ob+RT2wIeHpXQMHkJxc+r2kPj2YYa/rw2G4It3MdXPSJTaectpfZHwcaST7QhP10z4JetXp39C0qBoQJNfM+KjIJm9fP5l/XNr/2sC3H/6pnGHQg9gkxjOhe7O6O35o3FA35vNQg0ddd2ZGxU7SReP7KIL7NC2kSu6oMiqllYFGmXHFrZPLlEkDVG3W6PcdKTM5wQT+JcAfuMB5W5MmKJYv9BhPl5saVK5uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/uWFZlOo8kke/9QUopbg8t+aI2KRqJPgc77Zc2M5b8=;
 b=izTn3zEisW3IkHkgdSxSCKHtYNhdGMM71nTGei9vVQqn8nQTq8tWQoa6Q/EXuRltdQ8Oz0xEI07o5jPAq5jnMR87MHwtcen+6sffCmR0KqXp44UWl+u89jKPu64xC/B/+vDfHaGbbaRt3vBqM6rvEggFI2Ia3D5OXHxPy57bD7ZW7vZ6cGb84vf/fmdw6sPPUXtdUn8cAGigKcq5Pf7IywMM0WB27ggeVM51Q6byQzUXulFlBd/ik68J2WuidXGNUqoox4pzLA7xMmyGn5NJ4OfS3JWkUoROJMEeBrLg9AF929DrLeAiZDqryJzIehcxsyDrRnOlNQx7uwzymmgXDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB6630.namprd12.prod.outlook.com (2603:10b6:8:d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Thu, 21 Sep
 2023 12:00:33 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073%6]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 12:00:33 +0000
Date:   Thu, 21 Sep 2023 09:00:31 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Shay Drory <shayd@nvidia.com>, linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Fix mkey cache possible deadlock on
 cleanup
Message-ID: <20230921120031.GL13733@nvidia.com>
References: <2c0452d944a865b060709af71940dafc4aad8b89.1695203715.git.leon@kernel.org>
 <20230920140112.GB13733@nvidia.com>
 <20230921082716.GC1642130@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921082716.GC1642130@unreal>
X-ClientProxiedBy: YT3PR01CA0028.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::34) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB6630:EE_
X-MS-Office365-Filtering-Correlation-Id: 98d7a15c-75f2-49a8-1209-08dbba9a5bb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9hRpSLX+BrqFxmcsp7KexR7/zcU1EWluvrlwZYAU7P+IGNTy7iLTlisrHFcfsi3BXP3NJ5sXcgw/Wl38JmD5Pi9Rc5uiBF4WC6ulYHEs9ZdzD49w1+H9CMvY2HKe4S5JkgvH0c+jrQWaUky5c1ZEgaeSWk74wveS15NX47IMEmCLtKayPN04P82nOkGNeMYVwNF6hLKtySzl/+EvWTGno2C2whoKA1Cqq3oIP9BSWU3REgG9DT+4QwkDWvGzYUUGsgImA0VKHQD0BWyy4SXL7IgAZey77LEH75BqGvrMl2xLVfJNFcmv9tLCtYsKBbnoP4s6QnZ7FDiSk1L4M3q+G+AKvYTWlh4p2EpUOvIihl104+DUycJI+oF7t4pE1c0NKFXQ74N3YxJ8P05GxIJ8/iG2gf0S2A1sBuPvOCc0LES0vKtSvKZMaPXgmL6XjTCZOVnpOD/ca9XokbGSefMZk/PStxL4PHxwiraPewlotE7lIV8ZME6KOvmrpnMNuyc193IqKSTLo9GUg0orE5PuYEhRRFMQZbph8XsweoymPddHCcwxfRFLQ+5bOmkAXOEA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(346002)(366004)(396003)(1800799009)(451199024)(186009)(6512007)(4326008)(6486002)(26005)(2616005)(6506007)(107886003)(8676002)(1076003)(8936002)(83380400001)(2906002)(38100700002)(36756003)(41300700001)(316002)(66556008)(66946007)(54906003)(6916009)(4744005)(86362001)(33656002)(66476007)(5660300002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cU7SGXr4RprgD9QA+Arg3TvUIb8IG29AhsAWWLD2bSOYJEqOUfoMMbrd9BWa?=
 =?us-ascii?Q?8LdEKPW1jaw+q0fxgTnNNZzdmgEvInyml0MWuU5LtRf4SZ/j07860TYqdOFN?=
 =?us-ascii?Q?qqFaqW5QsSIrg+EXudb9v4MhJNv6hsrVJHkPxjFFfG2D44bEdS1XkayGDeb3?=
 =?us-ascii?Q?Gl2ovQKDeaqLl2zHz8BNEf2ZXUAwFCv+OiNHoHO0ykIYV1tVZLFkjvo5NPNT?=
 =?us-ascii?Q?d49al1Z6mH5qOwDH9qO6wWv9qTMW2WvydJ27pvJUV79ONxdkHPpI4rzSO5RW?=
 =?us-ascii?Q?GZUVy4beS6lTArwvW07WvJb1bBFALgpL+ey+WHcIrz2qNYOvdsIXpo+LnqFj?=
 =?us-ascii?Q?+Cp3GG54nJ4SpOtVH4zV2IlUfEFV7wzSiWBcopUXuso0fAOaw5EbbxCJkkuu?=
 =?us-ascii?Q?lnnV82xhlaOtKLlvZXlLpWUujCYn2CnZsaxdBHYOzWX3vdnpamefYNOXz+F9?=
 =?us-ascii?Q?Gi5nAMf5xO+10dvS5yRZ2QrACI1Pv2qoFmFbg5fY1Bym1Fn8rFIh/BhlSAua?=
 =?us-ascii?Q?GcPOl+ngAxQhliRMSalgvwV3sWTp5FHd5VINhEOp0v4gyuhOaHyJzLof+yy+?=
 =?us-ascii?Q?6Qt4BQDFCJj2XTaevCo8lJhzpNEEWxm5i3LJFF79gnt5e3hmCoCw3BZAFQJ8?=
 =?us-ascii?Q?J9Tp3XrJWBUyZq+fBQ66arQN9nwUp6JSFZi2ER0oacgFdg+m+/6GSD96C1h/?=
 =?us-ascii?Q?fTv/H47rkyMrehKte9mD30dtF5s1b20T5yI9gaZdW13j5JWz+jFGTaMj5YGv?=
 =?us-ascii?Q?DGCM+oJJ5YprKrvWW7/gc2QJBp6RP8wra+JLPtEqm8bgl4E9TucOWrDrqaKz?=
 =?us-ascii?Q?Y4qKiiXlGHaUeWwREPs69ZKxprAbRL/NwanFPbjh1qDpY8db964EXq48PpRJ?=
 =?us-ascii?Q?CogM9P1JpvLuC0H5F+n45mvv1LtKTWkeQmcghD//dORNusRpLU44QP2CdymJ?=
 =?us-ascii?Q?LhlKvta1+1FRze7QF10hHGamseFdk5E1Q5uuxTo0ckSt+0yvEePnZGjI4rzS?=
 =?us-ascii?Q?tgFqcYJ5T9ir25G60sER66jy4g5Jc/r6iPUebSYq7hTEsZaX0RiE10Ve5/CJ?=
 =?us-ascii?Q?2LFhxacaQNrNtjQIz20UObJW1tQNcY5HvqFzZoUTQw68w7pibbLg8R+4q3Vq?=
 =?us-ascii?Q?Xd/t5IXzmmWI+mKcI93iO+J5GNsuvjD9rh0Ukzxm5ULmPMiUG5NW+YqY7vTG?=
 =?us-ascii?Q?IksuhCQ2NiJuCDqnCCb+EYmov/b/MZNT2OvbXmIejMvR/Axpz/39vo9ZoL2j?=
 =?us-ascii?Q?OXCM5QSKX/6LJAFykyAMbRKyYNSVEPZhBoVj+Y/7U+ECoS/IszM2rhz9rPIb?=
 =?us-ascii?Q?fVWHqWIJqntb0HVaGHdIO2BVZDYFfrgMOy0lJKNBA9vLZiOXoIpNJoNhIzvs?=
 =?us-ascii?Q?7d4bVaZsGKfQHRet8116iUGNm6Y43DJvHioJomXrQ6FKbAbvWwMiReoWNNoX?=
 =?us-ascii?Q?kNnRNbKOZAvfW0Mg7CnNPYuTl9cwtcnTqgjjCjV1t5lInTPCGqvuhuDrkWBn?=
 =?us-ascii?Q?u2BdH3vmZmTfG5Sb/gVLZh456hQWX2Hw8o/c8DAP78wPeU8n261NiW2ICyqQ?=
 =?us-ascii?Q?Nl41togIVthTlDmOu/95/RPqDPsYpStEjBvTI2H6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98d7a15c-75f2-49a8-1209-08dbba9a5bb1
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 12:00:33.0780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LZiGDZF+ecpwDDC3bPXRLtm8vvb4ToW3H/H2CM5vVCJjrYjXOxBQvMvxBUL11nQk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6630
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 21, 2023 at 11:27:16AM +0300, Leon Romanovsky wrote:
> On Wed, Sep 20, 2023 at 11:01:12AM -0300, Jason Gunthorpe wrote:
> > On Wed, Sep 20, 2023 at 12:56:18PM +0300, Leon Romanovsky wrote:
> > > @@ -1796,6 +1804,10 @@ static int cache_ent_find_and_store(struct mlx5_ib_dev *dev,
> > >  	}
> > >  
> > >  	mutex_lock(&cache->rb_lock);
> > > +	if (cache->disable) {
> > > +		mutex_unlock(&cache->rb_lock);
> > > +		return 0;
> > > +	}
> > 
> > 
> > I don't get this.
> > 
> > Shouldn't we just initialize the ent->disabled to cache->disabled if
> > we happen to be creating a new ent?
 
> I'm convinced that new entries can't be created when we are calling to
> mlx5_mkey_cache_cleanup().

That's a better answer

Jason
