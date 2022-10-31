Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74946613552
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Oct 2022 13:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbiJaMHt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Oct 2022 08:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbiJaMHr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Oct 2022 08:07:47 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671715590
        for <linux-rdma@vger.kernel.org>; Mon, 31 Oct 2022 05:07:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9xt+/IxHSYEr2fn2tH0tWUu1KI//T1Hk7COF4NwDmQSb+90R+9zxvasxyEItSZuG6QZkgRfhHz1tlHgRALnsT157OGx5uyN2tB6jl1I4EmZ606bLb3wtPBhPZYC2S5goTdWDh7xR5ZbmNEsPGZcOgVz6Ay5qQFPCe16rbJOlkSJB7UFDVM6tP+x60Q+TupAOXtugQTiOhPa1yhZmkzUyaHOHxozIaZdFq5nppwk9qd4A5ZvA3DyrdW1AQrROjbMHQN1ccUkFSVq3RRJYp32/DoWhBtp966nWKu8o3UsGZ/r0x4WCwtJ8TuyzX1GhbSvFfgMHaZhJbGBnP3X5ZIGvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qsYFG2n0UJU4yAevtu8NsYAP/AvcuLwy41PxbVFtDX0=;
 b=eoGLWmMgarT0CMSwYIZhnHyvfdIE+LGDe44/B5I/AMNt2W/1+3b9UoK816aIjSRPZiPwcLIHSm/Gt6HHlM8dUTd88HpWeCBrqS6tC0chb2M8Sg2Y0ogofgBn2oqC61W/vsYLZuwGvXbafR61npCRlLK9MbqNGCrObeHJInRbs2k8zZsyFjAJBhsK5sEsGu0b0yimR9BneVq3dx5YPh0U4pm60Mt06CNTkbREHpP+8Hq/JodQN2MzX1bNSx7fOuW5lJbR5vO2BQXdjONS/XUUgfi0mAjA1Qs3xSuXb/uG3Avom75/qoJouG09R0Fm5ezjbaSS0tIdVki+IefxYq55+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsYFG2n0UJU4yAevtu8NsYAP/AvcuLwy41PxbVFtDX0=;
 b=L0edg/2aBStdX87xvCxrfQldhzCaglYRLLzKGyvRQBUa8F0ZC1BqM6bieilX1RLunGK3QkQFl+b6NjbxqGBHUR0xMMLxVW8FPuEyN6CtdqC83cXu/rcaDFTDiDmze5kzxsyiqj45RqnEhJHBxmu6CmjFkYTR4F4SyhK24VhJiEMkVL0NPy8nKFht+x8euna7UGdczkNRcOpQL0DaKlj6mZ9np94xwifarsBRMh3OCSYU2tkn4p5qOYQT5QX3V8haiu/H553TDyv2kWxUFuixvquuDQSjgu7pDgHcwuoxG3uOxDk5YaDue8L5OqDngZvxsf3MfDQW9GO/7hwfBHAJaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6302.namprd12.prod.outlook.com (2603:10b6:8:a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Mon, 31 Oct
 2022 12:07:44 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5769.015; Mon, 31 Oct 2022
 12:07:44 +0000
Date:   Mon, 31 Oct 2022 09:07:43 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "xuhaoyue (A)" <xuhaoyue1@hisilicon.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH v2 for-rc 3/5] RDMA/hns: Remove enable rq inline in
 kernel and add compatibility handling
Message-ID: <Y1+6j7KwbG9ls/25@nvidia.com>
References: <20221026095054.2384620-1-xuhaoyue1@hisilicon.com>
 <20221026095054.2384620-4-xuhaoyue1@hisilicon.com>
 <Y1wF68CgChG+hM87@nvidia.com>
 <9b50dae1-e448-047b-8a54-489ff120f00c@hisilicon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b50dae1-e448-047b-8a54-489ff120f00c@hisilicon.com>
X-ClientProxiedBy: MN2PR12CA0003.namprd12.prod.outlook.com
 (2603:10b6:208:a8::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6302:EE_
X-MS-Office365-Filtering-Correlation-Id: 79c10eee-d043-4bf8-31e8-08dabb3884bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +B6x2CzQpVpO0yY2kbXObqiid9Ob+J5bHkNB2OwlPNa8w+S2O2arq5zA8+9vkXeRyytBOzzapuLR5ozfeLgFWlv12Eg4YPh50qvVibZSygfYzpHJOLyQ9oi8kKP64f9jD5qVSoqpJ/otrCWgTNCmkghEVOU2pC5jfj/ku7OYofMghl9I7wQsppxT2tf2I/Pm29QonGk/NZc9MhP7ecUx65TkYKuZtDvRUkonX7hpTY7UDg2cc67x24rPOExoG09hAvhMQfXft3Gplrwot4KBbQ4QvfDFMac8WX/4Wkzwpl4ek+xzfPQSkDJ4FESqEm2waEYMYFPC1wDN/+aTT1ExDrAloyn145BVAlj/eS1yJWD89fifuHVQKn+R2S3XcFYVv8GqY2NEFmZsfvq5OY/J5hPc6cH6QtoD8aBdoscWY8KnWOS6POk6O8UIMeaPsddZvPpURfOgw3BH95MK6mP4pDR1VTycb4a7iDqxE+DYqGbo7EQ95AcdXyyrIc1uZ2sNytlVQXGrzsuxVu8jqx2vYqqv/qIis1FtM2psFgLWmU/ibaZLgFNxRHzapDk13XXcrwyWmdSPdH3KlJOt/CADyV8oQNb9cNy89qkao4i9GyGNYWqUcTZHl7qHtewa8PDOFZk5vSBUUMeh81GdmMFuDDfFzHjDzytjaVfuhkqGO+3OGSreoHNd9ySJDXgbck9NXPznidlAtghXgyPVFPUrBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(451199015)(86362001)(36756003)(38100700002)(2906002)(6506007)(6512007)(26005)(2616005)(4744005)(478600001)(186003)(83380400001)(316002)(6916009)(8936002)(6486002)(66476007)(8676002)(4326008)(66946007)(66556008)(41300700001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a9lpLO/EwKEZqZdDK9fOvMKrDc62lybXSxdqbQDqRH3BrlV+91PigTr/N2L6?=
 =?us-ascii?Q?QOvKCqlD3G4flAPkzW2I/6A2Hx93Lh22ZMc6yx/UGDE9uFelx6T/3HJC6Y7k?=
 =?us-ascii?Q?CxOog0VPdtPw2+7sHWHvke1ub0vBtghUbrBG7dARhq5O8k82JN3s0PnRilb0?=
 =?us-ascii?Q?IOrd94/x4l9eZEyllNLjqiD4Ji5dpKC9haDGgT7kH9RmgW66H/0HJA5hklqM?=
 =?us-ascii?Q?JIkG1718Frpq4ehQekpN/SkfSKmmdoVqpy/0VeKOY13ZVKFkesQmFOTCKXqh?=
 =?us-ascii?Q?Gmvmk0wGeiWzBoCg0a42b9jVzVkai+fEqpwDrpUR0JwgRbmYz7joHRuYmEhe?=
 =?us-ascii?Q?8s4EQ1dNCFFu75WL3LxXaOjsptScYLsSE/AmS4sbP+7l5CqXhJ1aOkI+CDd0?=
 =?us-ascii?Q?4lACRM8mCGLgKM7hOmVyrcm/UesI4ZaL7KmNiBLeF5Hrec0d1sqD9lNgO4mt?=
 =?us-ascii?Q?9wuR2+rk35ZE5ZcdsbzWroIywkwkbqR7XDTu85C7T7rLffUw6m//vmUkuSep?=
 =?us-ascii?Q?nCb8TT9pH00KdPvyP5gsTdOeT0gq67yEQJHy078OhsJsN/3VrziN6w9A0d8+?=
 =?us-ascii?Q?e6tzMww0lY/UOXY5p3bqejb/a0SLMdQbaeCi5i92P+YQbJJx5JbTHS5WszRW?=
 =?us-ascii?Q?KFh27GR9dv78HiD0fDaFvr0nxEEViUs/e7KkeLYnBfPB/QUj3nCZRC+QS8kz?=
 =?us-ascii?Q?9mZrwSK2e6uWQZUoskj9Eua28fxu+a5k7cDTYaTJ4M9MZ73fik0KI1UDDzlX?=
 =?us-ascii?Q?oDZ0sFfrEXzIedwHznCAIG2dJbkx75YNKPMKDJNQHKrkavxgABGn1H0gXnBK?=
 =?us-ascii?Q?tVAljX9r9++b3rYHC+dRSNletaVkan7oFRh46cbAlSdJNfs6v7xxfmHEYk5k?=
 =?us-ascii?Q?hyJZmKWmkK/HhSyg4pB9whNFnG4N/+UPNvPPCfcPhf6TBYubRbUZYKvt9UQo?=
 =?us-ascii?Q?DOIfqLweXBf0y+0qODRje1VVrssWoAtsTbTT7116QOcVXMfZO/KkJ4ireZ6o?=
 =?us-ascii?Q?hXg9kZVebo7VTSDb5HCg2+zqNgbK7yHX1RNcJycLy2jfPe2esUCq6LQJOaPQ?=
 =?us-ascii?Q?AGh+NrsLbKw19uTO+NpgrrEJUfC99/Hveo37tASCw+YLXeuB+qVwwrkdBpXq?=
 =?us-ascii?Q?cp3Yy8axpLaySc1TURx8iYW66+TDbIprWePYAE7xDOZjTo4I8lXquEzRz1tf?=
 =?us-ascii?Q?P602QI7QKSOi62k+JyH8DmwABd3Qnux1vzqHQnw04Fn3H1wvK95ufRaomGom?=
 =?us-ascii?Q?KQJM/NCfovpLaTqrc2bcRtP32cbEVF+wAcx7WzEdUwCT+hR/YRQGcEeTTKRz?=
 =?us-ascii?Q?NjUvAjOVdp9MC//8VXzIgVSP0N21qpWdA3P7pas2/4KOkyYRQLyBCVZSGoJJ?=
 =?us-ascii?Q?WGg7/EmbXewW3877ROFBiPG7Vf1hOOyOJ0xfkCbJz6VFGwzBfvlZ5qUxP+oc?=
 =?us-ascii?Q?aYSpEjWQz1fGRGaHEXlJOAK9IZJ8m9H0EWQN5F/FKbV7y2FAGfJClxKpg0qA?=
 =?us-ascii?Q?jgruex56YJYIuOEKSQggWlENelztqhwY3COxuM5pHwhPz5zz4OMrE8X3y299?=
 =?us-ascii?Q?H9ZtyDsYs32Z81d29+o=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c10eee-d043-4bf8-31e8-08dabb3884bd
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 12:07:44.7619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aB0YBipOimg4jDyRtpl1MMztGdBGQhbS3LIOjksoRU+wgkwoqGnhGAzBJpsbFKCT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6302
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 31, 2022 at 04:23:14PM +0800, xuhaoyue (A) wrote:

> This bit is used to prevent compatibility issues in the old
> kernel. It is not for compatibility with userspace.  It should be a
> bugfix. I will separate this into a new bugfix patch.  I will change
> the name to __HNS_ROCE_CAP_FLAG_RQ_INLINE in V3.

There is no such thing as "compatability issues in the old kernel"

If it is used then name it sensibly, if it isn't then delete it.

Jason
