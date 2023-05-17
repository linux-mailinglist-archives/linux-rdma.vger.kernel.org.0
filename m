Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D21707236
	for <lists+linux-rdma@lfdr.de>; Wed, 17 May 2023 21:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjEQTdV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 May 2023 15:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjEQTdU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 May 2023 15:33:20 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A49C19C
        for <linux-rdma@vger.kernel.org>; Wed, 17 May 2023 12:33:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S81qAKI4eAUIKAdRiD45ojpitPoGeF5MmL67S1Lq0J2pbKSEMSx45ZGaVZJWhgHPQR5qdX4pIwENGHpR2OakuN39cgWX7RCv1kFlas8LrkTeM0CMmpMeWJDvSVztexIPRVu3nIkEcpQFVdPnhSceA7/6CqREp9bQVPrlc2pLcnKaTYfzds3HNHVBj/BZXfqe8AxXmwsWeeq3vAvetxqm1bOXfDnPaEPrWzftgSatJARMeXq57fu+ePx5b68+2rrkm0CPPskftlw4ihxw0oLbDH1fQ5TGIYNGCfLXHHSRYaXixz12QzCb+LbLhtGaAnU4HnzqgFT+agSjUQsYW11MGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BVknVI1CfjBDjBNpZ0tIaJbwCLb/qrA5KI8NvvtjLX0=;
 b=gxbNYcabhGhk+3SOYW5aiblc+gg+L9mNdMUKcittb191VkIi5EJxeHNGlh7lQ2E3/TGeUvKBW6YqYkfoU773O9PVISmesfqyKGmEDlHGJLm4HlP1AGbapWHopb92RKHdsgTuJAAF54lvDPa4N9hlX798hsETOoZF/lHc2ljSTEn6C6iStDj/RsOlOeMaOZFUegPSvLLIhI868Gh2h3evJxWfwMxTmPAbyRMEtv93vRPBT5aCQQBUAI8LZtUucmUuNMLD2ooRXepCzVYjunY7EbL+3yEdeupfJ7020MViNHCDmGcpwsuqXeJ90GutEMShz+LNa0NUOgNNtOTvVkkpAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVknVI1CfjBDjBNpZ0tIaJbwCLb/qrA5KI8NvvtjLX0=;
 b=i5Gu2k4zJ7wenjnE+zHEmcEmCRMpL9ys08Gxra81XIy7Zy9BbR0gsQvd1Z4Oma17eeJloyg1kgipQgdpj0qayj3VHqgGnRYUvUusqHjj0n+39fObqfEODoUoRLVe2mzYROg7rfrycIPWIChT0nUCoDeXa8+01SVwM5LEKV5GDUbL5ZVzTgx09lg+S6eps2hnY1SX3nAeLEdnLaXy63EINuvCrI0UUPhTnye6X3YPG5ssxwkfXnVOzRfgznLY2haCjWgZadChomB8AThPhO2D0WLbqXQaavHGv7V0ggA8u0+7iHZi/RpWpIqCULJYQRBnvKgPFTT7eiinnnNscPgfzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH0PR12MB5266.namprd12.prod.outlook.com (2603:10b6:610:d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 19:33:14 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 19:33:14 +0000
Date:   Wed, 17 May 2023 16:33:13 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Kamal Heib <kheib@redhat.com>
Cc:     linux-rdma@vger.kernel.org,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v2 0/3] RDMA/irdma: Cleanups and improvements
Message-ID: <ZGUr+WV6C6cnuAAZ@nvidia.com>
References: <20230515191142.413633-1-kheib@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515191142.413633-1-kheib@redhat.com>
X-ClientProxiedBy: BL0PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:208:91::13) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH0PR12MB5266:EE_
X-MS-Office365-Filtering-Correlation-Id: d8b94484-797b-49ff-a620-08db570d8e6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LlTWxhzZM/m7l66OnPF8J8piYd/8lCdnqkv5dQJD2j24GZOwWG/147L6RVSoIi+fGGSIBryPw0fHYc8RMT6aDYirWZITkm80sW7K8E76D2ixIR3YyFap+iPyd3kSDICMchJ3TbaV5/G4mG7YvmSJ51LthP1krPIxws9CM9IIM84b7M4NjGQFsyUE6wC5hiBKLKoJucD0bghysQ9WnNq7P1FnFsY1KP5av/hd5iX38oG9X5wizkcOcUc/wDGWBP5cBiVNRO6KfGsgB9CFPKoIe0RG7WuVNBwQLL6kkzFIPkBnSBF5AoEHibOsERSoiNGGFYpOCYNMVtudr1SXtEXCavxJroUnc6lHPnJ5NcNszO4K1XmYSOHpe3ufrRlmnwQQJTMDJ1cYRw8/JnBLRw9wCWI2lOk/4pekQu8EFjs9Y133VQhg8xgS+sdlCaRY/j1qrRWrUWBihpsKRsUXMYSDGdYl9TZ4fC9QLmV8lk44OxXPvQOXdvSENouKSwNoS47DJef2HRu6uHZ5JuZ4LLcHQH97HshHe5hPza6IVpt+fgsCW6NR+xfO/DrWmoM2s1KnIYxFpBmrqkSkNTNYQGU7KcC/bchFiCHyoj61F3F9fjo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199021)(54906003)(41300700001)(66556008)(316002)(66476007)(66946007)(6916009)(4326008)(6486002)(8676002)(8936002)(478600001)(5660300002)(86362001)(26005)(6512007)(6506007)(4744005)(2906002)(186003)(38100700002)(2616005)(36756003)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nmMfT9GwTxiQty6y3FcQ1gemMHHKQZ6p7gli0468PpVyCiaFyfJnmzceyl+X?=
 =?us-ascii?Q?3QwJC6XYmny0R+eAnMcM4ftkXs0jhpB3OtfeeR0ugGRiBAGtkVSeWF1w1r4q?=
 =?us-ascii?Q?pN7MktD65i8QrrjutZ7i/JCb5UNElaPNWxpY0oXpIi6Wdaf5x02QJ9wxtY5Q?=
 =?us-ascii?Q?IwITbFJnmBeCvY6OFXfKZGHyJpj1FexkYUkAiS6joyk4AZcEWSt1vKFT7fCN?=
 =?us-ascii?Q?ckel8IXNA7RRZX5YHJNhEoY0M8MpP5GQt6Bl7hPpKFqe7FV1PytiMevmP4M0?=
 =?us-ascii?Q?mF6vXNfwrXiRRNa9gCTrTHAA71tF2hJs/gFiFFfHNNVdyw0WPmVM4d/8Uf0G?=
 =?us-ascii?Q?gkmPZVc5zrN6EBpTLE/Ei2hsAUw6plXPT3EPf807KZ6yYMSFpa3qwFoZmi3J?=
 =?us-ascii?Q?IUoiTiwZ/f3Ycij/yRdrgb/w4IVQfKSQJ8eWv6tVBLFt1bTti2I7+x0WHPK2?=
 =?us-ascii?Q?lssc+tySwKjBKHDGzbP7Do8UXTTMX87pDtUeMnfxygnYAGwOzRkhw40W02Zc?=
 =?us-ascii?Q?PpnhZrxwtLFiVXpTjkXE+t1DkWeDU9TBKcU0V+odZc27JpQNsA1/EbHmSZ8o?=
 =?us-ascii?Q?cxp5p46F5mkngy6CmVsi7REGAw0qb6k13swcaARXltuDW+5NJqcYY5K5Ej/I?=
 =?us-ascii?Q?5mUZ0U3gkGiC0BiaImTZ2cT+kqjQxhDaN87H/TCkPMGUDNoLTs/arJlTZfuI?=
 =?us-ascii?Q?rKaegfDv6GFwq175gSBSEzMMA+grjdPoEmvo3PCgS2xRxOb3UuwMeTWYd/Yo?=
 =?us-ascii?Q?wgw5lOAvRLEVjKd829WWfBdcoTNwu5/HTw2ne707RQEfOck7X9ZlnqVqOxWF?=
 =?us-ascii?Q?UScxAhKiAhdU/cF/tg+78oheL6k7nQZCr+gEsczf3ZuRSqQgG8xecOZZu/ji?=
 =?us-ascii?Q?NIfaiW0T9CmwB+kbv4rVb4hYIdVxJUGEiO5ZjCnHNhW45XPaTxLIYO65q+LP?=
 =?us-ascii?Q?t/nR4ddL9wWboNYJCsDSErLmwRVpQnuo+FHwCAutMLzl/Tb6LHDN8V4ARLbu?=
 =?us-ascii?Q?zYaQtfTvzoi5Tm9qdsc8aQLR8axC0THgdO6Itc/a7Cv1ylhppZyPtH4DIaa8?=
 =?us-ascii?Q?nRZ6MVjAGtmuZ1RuJ69/Bwk+xOoiYN+rKea9CnHzmcu9G2e3ervF9Bst1bGh?=
 =?us-ascii?Q?j9WpmNbOXhXkaByoAuuOvt0MaezB2Gs0smmiRNUXUF6NamC8nhBnLJMU+oPF?=
 =?us-ascii?Q?GpfgIl2LFpyLaTFjbOXqXYpIFean6PpAesbW+wK8SN0ZSISt93ymKLIv2tvZ?=
 =?us-ascii?Q?cjkRD+Li+1GQFFSJUZrKloNelbZiuauzfsBaMZhLn6P6kNK/scO4kvwVW94V?=
 =?us-ascii?Q?cvBqKehRyRDcUJbXhxKe5QjFbQ3Y5ZntkksXuXwzSD79JahfFZaQy/pi5Kg3?=
 =?us-ascii?Q?Q3WcbyNSI/EcJ3xJG7fPKUJ/GlmhlQLNJ+DQjXeahyObEcenDAsGGL3WswyU?=
 =?us-ascii?Q?mkQXClgmpQ+KpPXSCyVJjcZMcPUiZnrUI4TfYBLOnywtjARszZy6nEycchT5?=
 =?us-ascii?Q?D1G9Ld4lGst5/mGkqOyEwSy7JuCrGWpQmM1TtWP+z/dUO6h12LAqKghgJEzA?=
 =?us-ascii?Q?N++RLjsq1vhprkJahDc7L00ADQMJwqTtSUt4daQ2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8b94484-797b-49ff-a620-08db570d8e6a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 19:33:14.0528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o6nKOhVJ5OTVbKJ1V5lA0Oj5/nVzVJRdDnEkRPLn38WCw0ITDTscIh0JHO2ni/oW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5266
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

On Mon, May 15, 2023 at 03:11:39PM -0400, Kamal Heib wrote:
> This series includes a few cleanup patches for the irdma driver.
> 
> v2:
> - all: Fix subject.
> - patch1: Make checkpatch.pl happy.
> 
> Kamal Heib (3):
>   RDMA/irdma: Return void from irdma_init_iw_device()
>   RDMA/irdma: Return void from irdma_init_rdma_device()
>   RDMA/irdma: Move iw device ops initialization

Applied to for-next

Please fix your threading option, thread under cover letter not chain
each patch.

Thanks,
Jason
