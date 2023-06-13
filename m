Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40F972E8DF
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jun 2023 18:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234604AbjFMQz7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Jun 2023 12:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234522AbjFMQz6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 13 Jun 2023 12:55:58 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D70E183
        for <linux-rdma@vger.kernel.org>; Tue, 13 Jun 2023 09:55:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NhY9CsCMP+S5xbktDoPvjorsmVgtYVa2pKsV51wpID7RHkdkIk7trE3mbdyrK9afMJY9GnkufQg4zQ96vDUcH5q9Ponm9uGqsCRDhUJQNfRmOVWsYwoBlx36/43yW+wQIhbHbyEQ5aTjjrIto8OGRWXw+FWZxI/pd6pLp/akSNLblUChWumfmRQJndS3KQsh5ElQhlGV6N4Au7PXbIGUCPspwAYtsiThZ/NR07JH254kZwIkw5JAtPPr4sz3Lr3ZpY9ToBWXtNBlUB44f6Jld3v7JDSv3EYxqZ98OapWbddunH0QMgPnq839/c68TbvJ+o2cqrul00KurgpKANyWWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLq336NSrbIsQ8T9LyzhJbBe50VjhOq07U1ClEwIIP0=;
 b=Vs92tA02r9GUROvMk0+sGZecXVINibYHijWB1k2XAs+RM568J7d1uzagGJXEMq96USAcUNTUGLFB2p5ScVws8pu9WQS29pbrQ/IScC9vV5B/oPsvFjbkDMJRm0Zy+pLvOfEgO5BBj0QI4aTPkaDQlvolGCaEs8qyDWBhKGK1Me6gSQ4wAjNtztT18h35lgBApmTs9vDIf8QEu3qF44YdvZJjQ76QDZBjJRfvv7ySJ4WAeBJGZ8d9HzKqxjrBtLpqyoZNYLNkc1FVBWcTj7k3YEDUWcp1uDuBGnyyVvG3zM/K7S9AYzzPE8cjf4DMy+d6ykOHjz0F22eqNR2wqgyKbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLq336NSrbIsQ8T9LyzhJbBe50VjhOq07U1ClEwIIP0=;
 b=Dtuuo2TzqxBqZq4MBRkb83XTbtIdDgVUrgmUN6MhcwPjExFXCgMt4MB5L7Ienn4b9LPBKNqhgB/XFRL5/p+SUtGRNs1Zkbq/NWjjrg2XMmhRUhhXwDdy0ZIkrwIQGCoUGF/iuHuCVkec+TWzi7G5tje7mcevJjKebrd/frtlIJvBJygnZPuENUNDXv0xuZNyAjnT30ljsbpgmj/MwnHCHJEBbkYZiFsNa0llGonuhIA3zkI5v8fzaKJEmHqrny192Q8kkHOXydaD7kdvzK1OHl6rU3ff+TqBrsIU0AVmNwVC5ECD5CUwUAVf8IRWXSQhl9xZFXHgJU9gdoxbOLvZRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB9058.namprd12.prod.outlook.com (2603:10b6:8:c6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 13 Jun
 2023 16:55:55 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6455.030; Tue, 13 Jun 2023
 16:55:55 +0000
Date:   Tue, 13 Jun 2023 13:55:52 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: Bug report in reg_user_mr in exe
Message-ID: <ZIifmHzwnvn3YVbI@nvidia.com>
References: <80328b20-9c5d-afe8-0ff4-a7eb05c8fb4f@gmail.com>
 <ZIieuVnhnGP8RGQw@nvidia.com>
 <2c854bc5-40c4-aea7-c220-981938a01b6e@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c854bc5-40c4-aea7-c220-981938a01b6e@gmail.com>
X-ClientProxiedBy: BY5PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:a03:180::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB9058:EE_
X-MS-Office365-Filtering-Correlation-Id: a6585c18-23f1-4b8f-9c19-08db6c2f0df7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wF1gceN4wXeoJh4tiCEttSutx09AektKHuaRlAb3E2YUO/53oBEZz+w/k+k/0hK/cCkNv/QanrN5hnsmjIJL8xG39jb4FvzymHVZWPoI1HhpHLGw13/AVMbPTyOw8gnIvLh4MYQow8NTTLNWHK2jACx9lWqU7aoMk1ZTgaYvEwkbrufacmwwOGPYDISkb4LTMbguxNB+8ogrNJghuOCz9YpbWUJu7bABNc9qkqXG0HqQ7enlqwCrYTpbh5pVIePxoqJ4VH091/OY9P6d84siRNqOQeb7lJLyEUvhCDLdbYaYZR6h2/6qMMkCQ8DEqDQvAvtkHDpKSvaykY2vOpJQNxCJ+CwVWQhTXS/0OrhoXhBL05IP9msvqMGzMxX3S9DYoP4RUSVloWdarriwLbdBjz/7JdK1IR4RXEMI1Uk+t80mNcpz4cvto5U476B6mnag9GgEbeH8I3QE2HAa7iFxFsQKmBDBVIfbOiZ3wfgYEULSqQLhVwld03/x/N10fVWmCMhBWQk7djsdzZIUgHsgDpjhBFIorC+igULHjgccGwAtKgDoM5ztSOhf16j2+csk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(451199021)(66946007)(66556008)(6916009)(8936002)(5660300002)(4326008)(8676002)(316002)(86362001)(38100700002)(41300700001)(478600001)(66476007)(4744005)(2906002)(186003)(6486002)(6666004)(53546011)(26005)(6506007)(6512007)(2616005)(83380400001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BbtlNhh3FMBtAOaEygIO4r28MojQCouEvNIg5py76z9P9I0xwKziGRPV7zZ9?=
 =?us-ascii?Q?l/EnXqGzvmkFaZt2b0nw/MwL9hn1Kp6i1ElfwBQHrQ0OEECogeg9Lj3rQjkN?=
 =?us-ascii?Q?uJ1feedeOOfkOvqzMIDnV+RuMMq7T3hdi3WWCwgjkTRKvAZ2o0c23hOYIzw1?=
 =?us-ascii?Q?2qlMVjoU2BQdpYNzch2e7veRxypZ/Udhxq7xtdVBJtue6o/ZL9MigksxkgfJ?=
 =?us-ascii?Q?1t2cgDoBmYJQwWLdilDc/UdCgr7Ar32XYx9FfNWEBTY5ELTFAvNNuIQwgX2C?=
 =?us-ascii?Q?aZkwJFRbuMbC6ZrtVqWKmZCWto2FOCGeiDG+1wBiwIBbOc26t1YKbARIj/VU?=
 =?us-ascii?Q?cTuOtCTd9u8lNWhx/qjcMIjnNTuUzBQ9AE8QPxUttbyubdnqFZyFBoKdINIm?=
 =?us-ascii?Q?rcWDvSjk523XSEnPhqeEuTxOas0wMpZAZBAMnPTYFzCTTS/HvHgWStrqYbfd?=
 =?us-ascii?Q?/i6YKwY8DANyoVmucAE8+R7WmE9fw1rhKVDoKlUV57ezpCgIpPukOH3NFpCf?=
 =?us-ascii?Q?Oc61lFNRN1xnHr2BLUOZ4Tldea5pzNN07dDti52BkrPUCYe3RlR8dlBD/Wwj?=
 =?us-ascii?Q?Ny/drMYa82sa1cYOsHFyvPV25FhpuM9iFqK/n/gJGOhIS+Y11xAh4rWvJFF+?=
 =?us-ascii?Q?lpmXOlJIYinoXviQt///OVrAX4O+W/LQJqWtRutU/QKgqvaSq1iSDVfX56Wd?=
 =?us-ascii?Q?psmWrvE1JBQxUaupIU41gk72WvexakidYTfp48JcQv+Q0y6QUruWXH2wBniS?=
 =?us-ascii?Q?+BVQ391EkKgvgkrPPh1ukyQqcVJqMB2jAulkW14v0I7DiXhxrGqBy0Cw1H8G?=
 =?us-ascii?Q?bsXL837IJotTLPUXlgdclKVxg7aP5cgFwCdkRKrSMkZe3vdkP+UY66/6PZJF?=
 =?us-ascii?Q?IGMigy1cDAMMwnL+iHqcQUHPLlc5t3/ZoAkuum18Uen3Nhwkfiwj7wWZklnU?=
 =?us-ascii?Q?YP/BDdEOUeVcptJUsI6ODVespE1eNji90ZxcCGVRnCyS03RBjGPqPP/NdWNO?=
 =?us-ascii?Q?B0ZdLRXs8NfRn1Q6Vhjc8Q6C2KhQKH3y7PJ5zYB2HyTXfQA/SJ79eLKskrN4?=
 =?us-ascii?Q?l/ZZgdfuUzyMQtILHsLqqXn98dBgx+sBeo7Swi8oQO48nJtztBwAYdyvFhoo?=
 =?us-ascii?Q?sEpc+c/prryjYwg/vpgXjIkY43zsbmr9YtdNLqBbCesGL+yjhFEZzVIS8YUJ?=
 =?us-ascii?Q?iZH5GjwfJm3BUkXn9n1yEKS+WxYnWAJm917Kl2suq3Dh6lJp4Jvb+RY3D+nE?=
 =?us-ascii?Q?mtb8I0/i2ZTox7zntD7lzJObZNhALokGCTzGqVFCJLN8EQ2V9Wq4wvxgYfJb?=
 =?us-ascii?Q?ddFlnXKyM3wBgDeQ6YTO9U+Oz49vVNckpFZOCyxtQDdtMQwSgpgVprsztqWb?=
 =?us-ascii?Q?5Mp/bZyiDPkPEN1xv6K2G9rKBkVGYv1p7DAX2QadEieByABHMhwxC5+cOtPM?=
 =?us-ascii?Q?YpI3W97s1sMLZ6ZyC3n6TAkXZOkYxTf7v+eKquVu86cFuLE37/ZUMXQcv2/6?=
 =?us-ascii?Q?IokhUjfTMRnhZPa+/5ZwqnFSn59VCbhOTqKLe8zS1EsoNyVlChbPk05RHFsc?=
 =?us-ascii?Q?9+3wZIf66ckl9BDL2otXr59FinhZLq3CGuKoZBo5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6585c18-23f1-4b8f-9c19-08db6c2f0df7
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 16:55:55.7674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Zq1CpKVEFlApawWQvcemi6xoTnqTWrqiFK+W4ogXRBn1dFL6nMWaBrE2BVbWT2o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9058
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 13, 2023 at 11:54:46AM -0500, Bob Pearson wrote:
> On 6/13/23 11:52, Jason Gunthorpe wrote:
> > On Tue, Jun 13, 2023 at 11:26:55AM -0500, Bob Pearson wrote:
> >> Jason,
> >>
> >> Recently the code in rxe_reg_user_mr was changed to check if the driver supported the
> >> access flags. Since the rxe driver does nothing about relaxed ordering. I assumed that the
> >> driver didn't support that option but it turns out that this breaks the perf tests which
> >> request relaxed ordering by default.
> > 
> > Sounds like rxe is checking the flags wrong, there is a set of
> > optional access flags that should be ignored by the driver.
> > 
> > Jason
> 
> OK. That's easy. I'm just embarrassed I broke ib_send_bw.
> So mask off the optional ones and check the rest?

Yes, there is a constant for it too

Jason
