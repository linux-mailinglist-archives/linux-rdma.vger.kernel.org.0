Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFCC66A752
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Jan 2023 01:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjANABR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Jan 2023 19:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjANABM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Jan 2023 19:01:12 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2075.outbound.protection.outlook.com [40.107.212.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6628D38D
        for <linux-rdma@vger.kernel.org>; Fri, 13 Jan 2023 16:01:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IrvjDJGuBw0GwhXXD4uVRXiCKT0/D2h8HshV3DFbs+lEdpkeg5mfIQg/y/u9uFJ6Cutw6QqMpnWoEroGTcCOj5Hn8B9NwD1d1xreKkGSR/6jvI5oL9RiBYbRnOIzkZJK9XleOD2sQoIPMVHKtP5SRs1zro4oO5ZQYgxZlI91UFjcGnDV3nN4dGB7v78j9ZZLiBwfWg7E6+6E3f4Rblg60YXd0saxrE6NjeWAi373OQAW9RGaZdPK7Hff9K1X+DF9ICBjQa4GhkYFdU3Ir9ykg397to+Vc89JriTWuiarEfpAvBvSZN+zsDbSvqKh4i6Q4J0v0wpQydP3l+ExuVBfYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tS1DioHJIRevhfgwMjHdQ7SK6D277KS8T8iF96nnXRU=;
 b=cfexE0J3XFRBmybZrGpScF+ODNup6906rvS8B7a8NxQFUIC+OWv4d7/H5tVhuIjjHy8iYocgYtf/+hugN6bA9qiVEGMHNlA/AZ1BqYMHxul8qgqxetcd/eEawnknoyHV1/mL9aIuE56Ey9lUyUkyamrgHTyQtLjLXZ6+WSPrj5RnVa/CyQrKDKSfUlXkJE7FXsc0C9cLlJiM9syyYiopjnoJeChRaBlhjelZQAyiFPG9Wz3ggovQVEbvYBew7fov7GakWJyzWfyoJxwyD0HyovjjUJz9gSFWB7FtrHLeGPhVFJDk+BF/+IEt1Uc4wElXKT80lcRMocZKtEf4o0xe5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tS1DioHJIRevhfgwMjHdQ7SK6D277KS8T8iF96nnXRU=;
 b=Cm6HDZQGgyL1kmw+P53VuVKI+uIBjf5cRh/wOetcw2waDeXIuCCCQpynIpfxD5Tm1zuYP5PGnLVLR8o2aUUwdnHlHHe+ObzCDgrdt1wsI+u+FJ4yS+CeQxoCZT0VdMeMo4GxuyhjfW/xOZUBbe8xi+V0HE+R2F+OSI563R4QCgJ+s8ZtHUXVy+VO0a+ywr0J6DI4f+VyIHEUPNq8LMYV8zU/DSHGy/bi4W8T0lv2Skq/Rt65ehUr9KE65j5tGfrnfhSVOvUQN3YT+HZmyfez69r772Or0hHqQlY4mmqsiw1MLXtl+niWixY+M6zFr0Z2iIXV/UFtfue2VQyFikUgIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB8287.namprd12.prod.outlook.com (2603:10b6:208:3f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Sat, 14 Jan
 2023 00:01:09 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.6002.013; Sat, 14 Jan 2023
 00:01:09 +0000
Date:   Fri, 13 Jan 2023 20:01:08 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Saleem, Shiraz" <shiraz.saleem@intel.com>
Cc:     "Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>,
        "Hefty, Sean" <sean.hefty@intel.com>,
        "Rimmer, Todd" <todd.rimmer@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v2 rdma-core] irdma: Add ice and irdma to kernel-boot
 rules
Message-ID: <Y8HwxFUb3/NWE1xE@nvidia.com>
References: <20210823161116.GO1721383@nvidia.com>
 <DM6PR11MB46922D3AE92E34B4E1D3AC9FCBCE9@DM6PR11MB4692.namprd11.prod.outlook.com>
 <20210902154003.GW1721383@nvidia.com>
 <DM6PR11MB4692517FBBC9AFD046990DCDCBA09@DM6PR11MB4692.namprd11.prod.outlook.com>
 <20210920232330.GH327412@nvidia.com>
 <DM6PR11MB4692B56B4C7D1E790B50888DCBB89@DM6PR11MB4692.namprd11.prod.outlook.com>
 <20211014233644.GA2744544@nvidia.com>
 <DM6PR11MB4692B502C54F459A2EF9E79CCB399@DM6PR11MB4692.namprd11.prod.outlook.com>
 <Y2uu4HfKADHiCzGx@nvidia.com>
 <MWHPR11MB002952D469591FEF43EBC6F6E9C29@MWHPR11MB0029.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR11MB002952D469591FEF43EBC6F6E9C29@MWHPR11MB0029.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0081.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB8287:EE_
X-MS-Office365-Filtering-Correlation-Id: bda724d1-cc87-4d0e-5fe5-08daf5c270ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: COy0qXBAyh8NUc+3W47g35ZRRunOckK4aIElhdWGn8qDXYUfBLxel+uaV8g0FzVA2HVbgT0Knr1/hoYHNDJsTt2WXBAMHvXqts2Dmj9AODwhQKCwGUUdXErf+gql2ERmyy6iGA3Clwo65FSSJn5waky2sWXnFERUgrjAWKjQ0BY4dUOIMxDYhDgxWYNDkHngiAHRrpxiUu9WBu8gf8IqGxj+a8tBtExF7ccKnBjgbqHZ7cDSRT54wLOPymB8MZlXVW08XzCbKgETsAFGeb/Czgx4RZQ2rPJWQNxgw3nvUy7WK+rcLHN++xyPW1bUw0AzIOWqXsviEV9hb2A7Zi/puBmciYm1rwsjoFQB9zP7DV0a+qgouJ0rqrGNAMiXRTEjRqlDFwGw+GaoZ9ccsZcUKDgAAP7QgvMYZhsqlEcDHjV1YJWX6Q1ZpmeuT51N+akbmD9vZcT2vGIgVklNMYZmbwJ7m69+fu55d6ClSRcCK3SW5jbbCh34AO1bKHit3n+9gzahNVtOWAmhG3eKmAGe+KpcyDxVt0YH+sVhIzmNKxlX9OsdC6nhNHuplD0vcKVAEviUHfU8zWSSzQHaPtIGj70KS5C7frouR2m/TAYoUuKHU4+q+Fbk94bxoF1vWHKEu21IbcuWh6pJElCaaXTdXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199015)(66946007)(8676002)(41300700001)(2906002)(8936002)(5660300002)(36756003)(316002)(6916009)(6512007)(54906003)(66556008)(478600001)(6486002)(6506007)(66476007)(186003)(2616005)(4326008)(26005)(83380400001)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e4NbWM2SP0Wul9BLmuSeC7Yw2FrUCaV4BeJyrPeAnJSWYYfhGWLULxH2L977?=
 =?us-ascii?Q?X3TG6KCtytsQUYBI0OgaV3yshR/2UB5/ElwqpZYhPJAgWRd36LCKBYme37km?=
 =?us-ascii?Q?9qeUmlD1nt9RLCUdtzpU9Y2UKIgYERvsDoXDOO4MELiyRfQ4ieLpA1XwQ5Pd?=
 =?us-ascii?Q?8nSW8TC6UH/u26qf8iPfjASNkgNETcMZoenlZnAfeltqlA7GByaO2OAz5er6?=
 =?us-ascii?Q?tbMc5rFdfSaem46phWSSimaJDuUWAdoDfCPe4d4HUp2xOuZnRdpdfANvPUwY?=
 =?us-ascii?Q?VbEcsIXTdBiNyGvNpJEyzv+tZ0CPIkn+lvK9K1fnmeFm0YNHvxbJxrvWSkTp?=
 =?us-ascii?Q?BlTnZ0oOMv2gvTyLS1LoEiKD/8344JEfkZJwOwmS3jkHYCEvPf1qgXQBBMbU?=
 =?us-ascii?Q?mdCrmmEg2vcZN2bO+Ugw+pxAnLSJKzCjp/kD7fu78AsXUUFdDQUIjyPWyj5G?=
 =?us-ascii?Q?suVKB8ayXLZYoFVtnz04O7GsxD1B7u1ewy6PnCRK8uaIv9WWdpqbByJQfEcp?=
 =?us-ascii?Q?NqQ40RZ5Lk4t9H8m/c1+f1xhHWrnbCCpQIqQgil3cpGTd0J+KYUhOhU/eKyv?=
 =?us-ascii?Q?c4RS6yKZPyqUz7gNlSzUIrgYN/TtygVW6W4QCZwrA+xd2ZZKccS+G5kLvrau?=
 =?us-ascii?Q?1Uzjup+yQ/kfeRY3oUEDxyVP5dPW/s0Lv1PtljfUq/l5EdECrN7c4ne+/5/i?=
 =?us-ascii?Q?dCIohzknoHGdvLyYfH/cwCCn614TEZuIkFB5yJ5eVeNtY+5datYG9vEtCjae?=
 =?us-ascii?Q?6y5zpG52hp4xQ5L0Jz1MAhCjubFNYA+ceTHg5xSD9FtMNZ22J9xV8BsYqT+m?=
 =?us-ascii?Q?uKI0YatQ5mK8AUzO+o9ysxT70h/D/NE08ZE/qyplDExb8PfPYuhGZR5SmkFN?=
 =?us-ascii?Q?xeyPKEJ1QIUznUsDMew5Dq+WLJmQZi5IMSCqztDNZOKIV3DuDiCjqMeN1QWs?=
 =?us-ascii?Q?ilMda2Mig72MbtTWNuEUOAS6mdwZqTNephiGZxAQJDuimm5cLVnL0dbTC7iB?=
 =?us-ascii?Q?q/kTFVhaF0DF/f6hngjx6mvASxYdY+GaqFjuvjKt7Ro5unrP6Bx8vSwUr2MZ?=
 =?us-ascii?Q?pZzddXGxvnuZbR/dm4Tt9vQomURGoS111Sj0Gasu69nwX5WHIgO0Y76TU6C+?=
 =?us-ascii?Q?pots5NHzGgtLv8B5y4jdMiNKgZ3BqMd+fB0lZdsGVM7WXtUqVyR764DUWNR3?=
 =?us-ascii?Q?cGMyPwb7N8pjK/GEcDNo7+aK59hLdLfvePCIdE3x43mzPx4TvR8SxOhYk1Wi?=
 =?us-ascii?Q?uTPTgrvbZbIHWqIXbSZCVPJNQzx+blbwkUnaYh2PB7AiOrft2oQZR/OWyXn9?=
 =?us-ascii?Q?KiX/qKDpopPZAfHhYEQEmCnNOA7afjh8c/Av1PYDCKAWXjHIxtACjW6vUX1e?=
 =?us-ascii?Q?921Y3kLq3GtDiTk/TVxmpT9jxjkY1cv+n+ebFMwVLDsMiHtRYFve24GMILp+?=
 =?us-ascii?Q?1p4QbFW++ZsRwYbZujp7boWYYkukilvdaZijFokw7bs6oJXTKk66g6MsUmAg?=
 =?us-ascii?Q?8LVeS6qfcOgO1Ws9Zy2n5BUHV/HWhdnS69fr0dgyLXSZ7MD+ejGeMNCLMD/H?=
 =?us-ascii?Q?C5+DFXCrn/ZFO+oHOJ63seDlfPo5P4Pzcs5hP75e?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bda724d1-cc87-4d0e-5fe5-08daf5c270ef
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2023 00:01:09.4792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UQ2vWE7gaINdE3n/cxlnrrmRUblpT8gVlY/uOfdR5Ddq5PAgUIZDGGJyPjkh+70d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8287
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jan 13, 2023 at 11:57:33PM +0000, Saleem, Shiraz wrote:
> > Subject: Re: [PATCH v2 rdma-core] irdma: Add ice and irdma to kernel-boot rules
> > 
> > On Wed, Nov 02, 2022 at 04:40:20PM +0000, Nikolova, Tatyana E wrote:
> > > Hi Jason,
> > >
> > > I know it has been a while since we discussed this. Based on your feedback, we
> > are proposing another solution for the irdma kernel-boot rules. Could you please
> > review it?
> > >
> > > > > udevadm info --attribute-walk /sys/class/infiniband/rocep47s0f0
> > > > >
> > > > >   looking at device
> > > > '/devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/infiniband/rocep47s0f0':
> > > >
> > > > This looks like the problem. For any of this to work the infiniband
> > > > device needs to be parented to the aux device, not the PCI device.
> > > >
> > > > mlx5 did not due this for backwards compat reasons, but this is a
> > > > new driver so it could do it properly.
> > > >
> 
> Hi Jason - This also impacts us in terms of backwards compatibility.

This is a new driver, it by definition does not have backwards
compatability.

What you are talking about is drop in compatability against mlx5 which
is a very different thing.

> There are current applications/customers who are looking at
> "'/sys/class/infiniband/<ib_device>/device/" for sysfs attributes
> like numa_node, local_cpus etc. under the PCI device.

That is just wrong assumptions for how sysfs is structured, sadly.

> i.e. assuming the PCI device is ib device parent.
> 
> With parent change to auxiliary device, they won't be able find
> these attributes and potentially resort to default configurations
> that are sub-optimal.

Introducing new stuff often comes with an ecosystem upgrade as well..

Jason
