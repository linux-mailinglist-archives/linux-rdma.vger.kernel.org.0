Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBD57A82FA
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Sep 2023 15:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234824AbjITNKn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Sep 2023 09:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235048AbjITNKm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Sep 2023 09:10:42 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2042.outbound.protection.outlook.com [40.107.95.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABF7AB
        for <linux-rdma@vger.kernel.org>; Wed, 20 Sep 2023 06:10:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ayd1PmMQy2eM7taVf1PYX8ylZDBLzE/293erozStxYGGc6vbB8WsmK/Tw75ej+cC2VHwfnC96xpAt8SpWAo4LDfHfLeQeNtai/XWZrwF012n/4+yQC3EYAqus3KJp7yV5jANiXGcazfNRjhIhW2iPLA6A5MP1wZxtFggHLG/t3MwLZFx0UU6DKcV6dFF/iIO6e9OcI5GK7bp2ve2KJoiMw6FlKHFYxRZyEdqPmYp8/+MnYPbFGzwIvl0+arGEfDGj/+R/aI9rzvx/Z3lfKjPXdKdtLxxYwl2ttnN5ZRsHP8fSGEvW2FUfm6tzQsl0+DUpxTW2KxQU+7esKjiPEEfEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Nxt0jB/u070XkqL58LeZQjZ/8DaR5Cq9hhqPRA4zK8=;
 b=gls5p0kgl2gVdnluNj4ee4pdHLcKOy/v66cE531UQuwWEezTaxMVUm80PoLJZQ+2NXL6eM3shbK7Ln/elZqpVcuuSvYB6PavRDfVHv+5jGrBR7kCIa10muDDHVRQQZsLdWbY06Wskc+IRFYhlrUVHBkzFDL6Dc1XrLBiz1AoKj1CvCWCTRz7BUWzinR5pEgRwTQNWDbhJ8tareTZILJ9/ZK41dml7eNBaWcjFT47SCTesy9ssX4I+i97nUQyWioEfq8qfGMQzWc6cCV3ctSE/3A6rpSvwaGdfpAy0lwAS84IQnvgbzG66t36ydlR4MuhZcnm7I+YbqNeSFIVKLXexA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Nxt0jB/u070XkqL58LeZQjZ/8DaR5Cq9hhqPRA4zK8=;
 b=mCLOugEZetdRJ6CoC4RHFrdz1acI/jiiBckvdZyfuar0no6gBKz+ooeIj4OVpinc8QxEhzUFVMCgaFcsx0ONvriT5iqzPnS8rvCww5n7nO/OGM6lW6B855nurPSnBUH71Kzjg+viRpIey5zzJqXIB2a7tvTTaf4lyEd9HSmuxsOiJUSMRhcOg/KpWXM/6mX9qK98uDOLhR5qCwLN0RDof0t8YvuJV2YY+aMHK2cfkQZUuHYhUkfZFaoD2gBEgkt5vWuI+6q+b7/eiudk2lxoIeDAe761O/dcXXSzXFG5oXd/FXtWTtlD/SrtUSZJu1tVlOAQNtjV+mcc2RYvSfWU5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CYYPR12MB8991.namprd12.prod.outlook.com (2603:10b6:930:b9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 13:10:35 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073%6]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 13:10:34 +0000
Date:   Wed, 20 Sep 2023 10:10:32 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Vitaly Mayatskikh <vitaly@enfabrica.net>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        linux-rdma@vger.kernel.org, David Ahern <dsahern@kernel.org>,
        Roland Dreier <roland@enfabrica.net>
Subject: Re: [PATCH] RDMA/core: use rdma_cap_iw_cm() in rdma_resolve_route()
Message-ID: <20230920131032.GY13733@nvidia.com>
References: <20230918142700.12745-1-vitaly@enfabrica.net>
 <20230919072136.GB4494@unreal>
 <CAF0Wxh=YhKCLbOLZ+-b+_rmzRoWQtqoBGn6Bo9X3zR308Vm1zA@mail.gmail.com>
 <CAF0Wxhkxa1Lk76nnkTQbNL6_v_4amczVd=wodPt00iOU2WB6+w@mail.gmail.com>
 <20230920054452.GH4494@unreal>
 <20230920125507.GU13733@nvidia.com>
 <CAF0WxhkuN0J3K5tUw0rb3-v=zKPKTh5YcCGSciaBXx9yfN-GEw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF0WxhkuN0J3K5tUw0rb3-v=zKPKTh5YcCGSciaBXx9yfN-GEw@mail.gmail.com>
X-ClientProxiedBy: SJ0PR03CA0293.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CYYPR12MB8991:EE_
X-MS-Office365-Filtering-Correlation-Id: 3804bdc6-e7e9-4611-3270-08dbb9daf9cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y6fGE6+VKSMshsac8TiUu68s25ODjNygrQAqvYMc5+n3RpVhZ11RRowi+DJRuJiYKMIn62fiP6iRm3zOB7GfTrpgYiPdrGBA1wnCXwYvEwS51l5DYb7UYSzcokhSE9GztGTYv7/q3t9mNQMF5zXdBI+N/AVVseixRvBAmFoAM+TNbhbGpzW+KSfL9Kxo/yfAWj2zyHdz/YzQqVkTde0yLc1nDPivz7S6L0eRmZ6t5TCulHmRuLKHeKC+NOfaVBrddgcPWEJbdjsnNzFQsb3S/bqr2jMBqRfbWiL46sOoC++rAuFNwLkWN6+w/ytJbYbQdsjQSsFrBeDO/D4U9U9+t4igdJFfQdkCwptLT0eAD32a/ly4zzBetCNJBvVK93inMnDdTJaRW7N/YHUWTeQ66zmRT7YVqKOgTbmqWu8oJNy1WGWUuZM4WDZAT4OKByZDFkUdNHqG8s0PDt7LUPLNpzZz9hVtqBBehQ/HbSwif1g5hIVxNNKH4ok/K3XpAMRAoYrCwuQYJI9anQ3z9Laj9pgsxbW3PVVODQCKpKLBbd52Qf5sdr2pETKHsRKJvi6S
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(366004)(39860400002)(396003)(1800799009)(186009)(451199024)(2906002)(33656002)(36756003)(86362001)(6916009)(38100700002)(316002)(6512007)(54906003)(66556008)(66476007)(66946007)(41300700001)(4326008)(8936002)(8676002)(2616005)(1076003)(53546011)(6486002)(6506007)(478600001)(26005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFdxSEVxSU1SREJBR3dyME1leHEvUTAxaDhJR0tRdEhOY2tkMnRuZDJwN0d6?=
 =?utf-8?B?QkxybDZZM2QvaitpRHhzajQ3SG02elJMMmhtMmdnRFFkZFBMRVUzc2VnaGhB?=
 =?utf-8?B?ZVlJemFXUUx6M05Sc3hQdDgzRGdUQ0dsMUxjbFNKcS9ld0c0Z2Iyayt1NmdS?=
 =?utf-8?B?S3dmQ1BtaFNQa2J4UW5rNFcrT3FsYkJlaDk1cmE1bFkvaTVJL2pFR3NCdW96?=
 =?utf-8?B?VGdZZU5KWmJUeE5xdTdyQzBkRHY1VTJuUUhDcERqS09RZkJiWXZJOENhMEJx?=
 =?utf-8?B?SGZBeEhYTGp6QzdlUjZLL0RPU3ZFUHBTV3JSRVJzdm5FSUI3RzhYK2RnSzFX?=
 =?utf-8?B?RnZjSnIxdWJFNEtuTENNQWRseTJQYUUvblY1TWhHQTlSL2JsVHFCMUVZRmxC?=
 =?utf-8?B?RFNlRHFGV3JOd0xqMVp2N2tJYzg3bXZablhjd1UwUUhoREdoUUhkYnM4K3A5?=
 =?utf-8?B?ZHo4czF4VFVHK2Jkd1JBYmFycVpVS0NEOHo2dm9xNFB6Z3podkN6clFOV0E4?=
 =?utf-8?B?aDk0QVUySFJhR013bXBFYno4TWJYZkRIajhiZ2o1TFp0c1VGOE9EZ0ZJQ0lX?=
 =?utf-8?B?alhncXY5UlladFgvZGdmU2plMVpmQytISk9JSktCYnVYOGRtUVJmWjNwYmh3?=
 =?utf-8?B?dkdZc3hvRGVFdThRZmp1WEtLcldQeVFCUkJQbmVNYW1ZWHYyYk9pNTNJZlU3?=
 =?utf-8?B?MzF4M0hZUloxSjhQT0d5bDZZaDNxVk1jYkJpdVR2NmZ1a3ovWnNSOTdtb21v?=
 =?utf-8?B?aFl1ampLYmxsYzlPaTRnb0cyZGFmcSsya3E2YVlxR0doa1lBQ1dBSFQwN0c3?=
 =?utf-8?B?STZqV2o4Y3hYTlE5MUNDVTBRelY4VFlvNTJTejBrcndROWs3S2dtMXMvbHBj?=
 =?utf-8?B?S1REdHp2RlRMbDR1eCtKNUpGR2dOanIzZnJ4dDFjUFROZ2J4QXdDZi9RVzh1?=
 =?utf-8?B?RTRZQ3JHYmRpZGZyd1gydXdEYzdiZDFkcVVjQjZTdkUvaEY3UlVrek9HRko1?=
 =?utf-8?B?NzhhWG05b28zQnVPTjZNbGtnVEVSR1dTQXFyUzNaRnpITk5tNVNHb2Nhak03?=
 =?utf-8?B?eHJ4UUcxQWJ6SUladHdrSHpuSlBmdXBpMDN5NGVTdTAzNDJkMUM0NGtFbjNp?=
 =?utf-8?B?ZFJCeURSNWlKak44RE1Wck9CcFRJcnhSVENacGMzU2Vlc0NGYzdMdTFDRnFE?=
 =?utf-8?B?a1FCTThNM0cwU2Jhc21qR2R4Yjg2T3NqM3FxYkN4aW10SktGdmJOcUFndXc4?=
 =?utf-8?B?Ky9udFREc2dPdktUd2E1cnIwczBTWVI1RkxnWHBnVitBNDR6N3NlclBvSUJP?=
 =?utf-8?B?ZDkxb2w3OWw5dDJZNUM2V0M4WFY4ZEwwMVFGalVQaWdIUkxBbm40M2NpcFpG?=
 =?utf-8?B?cW1ya2RmamJvQWNvc3FDVklhNUlDWTNSa0s2L09udXh4ZmtHR3dJVG9iaEMv?=
 =?utf-8?B?bGNYU1JHSXFkTk5vL2tKaWkvMEtVTWprS3h3YzZ6MkJGOEwrUmZKN25wYXNI?=
 =?utf-8?B?SDRQdWdtRWdnMVozcFEwQzY1MDdaZTJxb25PUlFPYXRUWUFXYS9aZ0t0VElr?=
 =?utf-8?B?ZXFCWmZYQjYvamQ0UFBQa1dDQUdmVi9TZ0JjTVVWQW1xYzZGR1ZiOGwvOGJa?=
 =?utf-8?B?cHpyaHhEVFJ1Q0U5RWJQa29sMDMxV21MdnVLa2RoTFplZGIxZWlVRjd1NUlk?=
 =?utf-8?B?NFVHWVFROWs2VUJ5cE9xbFlvNDhiYm1sa2FWaHNzaHJ6M2tONUZ5RW91YnJn?=
 =?utf-8?B?MmpPMXVTVXZCWFNCWlMydXQ2TFM5TDVOblFDYmNWQkdhMitoNGUrTFA0dEth?=
 =?utf-8?B?TGZEcFkrRC81d3Jld3FXZzJmWkkrVEtUMk9TcXhyeVAvNS9MUndGUXhFWHRT?=
 =?utf-8?B?VVpsdDF4cFZBM1VSaE1TSEpoQW0vU1JLNzZ6cTBrWDdocTJZamJNREJuR2RE?=
 =?utf-8?B?aHA1V2JabW5VL0dsbCsyU09vc2lTcTN1MUZybFhwNjFvSXpuM2lkSHBhRnQw?=
 =?utf-8?B?UXFaWW5lUjBsc3E5RWNISXhYTnNLODI2SU16aWw3Z3phR2lJTFVQUVhmYnJ6?=
 =?utf-8?B?ODJZcFlEZCttRXpyRDZwRGpoTXpLMWgvMzdJQmFFUEVDK3dHRXB0bEZNMndv?=
 =?utf-8?Q?qEius4RkCvyzod3wCw5QvOYRl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3804bdc6-e7e9-4611-3270-08dbb9daf9cd
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 13:10:34.9081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r91W/9iJ4ZR58w8bDlX3Icnx5hDKRr/WcJZtQsPfRoHK9ABHqGgq6wJXAmuxkq+z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8991
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 20, 2023 at 09:07:44AM -0400, Vitaly Mayatskikh wrote:
> On Wed, Sep 20, 2023 at 8:55 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > > > > Our driver does not support iWarp, but implements IW_CM callbacks. The patch has
> > > > > the only fix that was needed to make it work w/o a full blown iWarp.
> > >
> > > It is hard to say without having driver in-tree and seeing the result of
> > > ib_device_check_mandatory() in regards of kverbs_provider variable.
> > >
> > > Does any existing in-tree driver require the proposed change in
> > > rdma-cm?
> >
> > Yes, lets see a driver first please.
> >
> > iWarp CM is tightly tied to iWarp, I have a hard time understanding
> > how you could have the CM without supporting iWarp too.
> 
> Yes, it is coming. Not sure about the timeline, but the intent is to
> opensource the drivers. I'll defer the patch till then.
> 
> The IB driver implements ib_device_ops->iw_* ops and cq/qp/mr-related
> kverbs. This is sufficient for CM to work with the device in
> principle.

But is it iWarp?

I'm not keen on seeing people abuse iwarp stuff for some non-standards
based thing. iwarp is already in a disused state, there isn't enough
community energy there to police something non-standards based.

Jason
