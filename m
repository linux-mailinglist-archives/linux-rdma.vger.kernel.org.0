Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C9A5855AE
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Jul 2022 21:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238877AbiG2Tqr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 Jul 2022 15:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238818AbiG2Tqq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 29 Jul 2022 15:46:46 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5087B371
        for <linux-rdma@vger.kernel.org>; Fri, 29 Jul 2022 12:46:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bz3m3kdpuZrjiXXoH4t2AX3bGSZtP2MSSYLr/hrtQOvuPjXa6YKBrYTzam4naljJIQ6lg/qvH+K1G82ewFuJ4fpL4is7v8Ay1fzfunEVhFy8iQEHEZHt9VIy4jduY26iXOV+cTx8WqXMFrkWtvoH/QZGS0s1VeZtd4D6SNsdEfHgpTJhG42UhcXNa7XwT+xTEuQnLc/51Yaz99w2pGvpCtUtf7Biu/wnsQUn0F2sDMB/v1Iw4tdYzRaCSlptxjmqP/2tS+wQAtq6l9+Mk99qqEL4lUhmQ8tNTgBjQp7RYjFwbj8GIYudx2LzzGivkfjX8KRwrKzmDjKp8djqEHOvog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwbcBnxIO9hgfmmkiqUhJQ8XaHTB8Ems4hdmDZtp1OM=;
 b=S/EcGot7rvNTksi9bnuqpG5tUIUL3mp+qsnUlOXYfB213ZTvw3j1txaOZzUgVG/agOliFqSHWun2UiqZKbm04zadZquTIONgMi0F7ELSQ7l9qpEJZ6k7nHA06b47mAcRIcg0nxAt44iON1pM69d0gfPKZv8aYh5kwRG9F5ZmcFLjNeS+Vn0KjvmWBlctGv3wi49knml1b7eg9DcsTVaOlFHuT1qz2DlMWwaUdGKTzmaq4ZfY0Cw4aLV2eVPIVjVqgErzrhIhbdAMhIArtsoOIUSTEPhNir8tTt/cbak8dKlwc25SHycomupIL6viqzQFmdUTCYWN+i6C/ZV7r66Pdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwbcBnxIO9hgfmmkiqUhJQ8XaHTB8Ems4hdmDZtp1OM=;
 b=rWOOFcEr/oZk8ElZjofF7f4B/s7cnJKj4kQdvuX/zRq+TRp9omcZCG3go90KMnqBVsgE9NE+mD1ICtmbbGGtIfRjQ2hDj6l/lB822+t3191q+3+daRycDpcm5yAiu3Z6F0f6be+1O3z1/b3k/QInnu6P7PxoiZMXItEQbVa1TTgcJNBK8QsNs2y/KMgVL3a76R09dKjrzmqTrfU+u2/ru6ay+tK3Dot9SgWHfJp8FjbgnPBW8jY+JDfFobfAhWdMqPc0QfVsGBjkP/AQ3LOFPuRdNQ2s2zbO+ggLQB5uj33s2WhU/K5ZzmaqKvSz8wen5u53EzovJSbybrXCSwKEAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB2890.namprd12.prod.outlook.com (2603:10b6:5:15e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Fri, 29 Jul
 2022 19:46:43 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::4cce:310f:93:5d58]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::4cce:310f:93:5d58%8]) with mapi id 15.20.5482.006; Fri, 29 Jul 2022
 19:46:43 +0000
Date:   Fri, 29 Jul 2022 16:46:42 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Li Zhijian <lizhijian@fujitsu.com>,
        Hillf Danton <hdanton@sina.com>,
        Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH v2 0/3] Fix a use-after-free in the SRP target driver
Message-ID: <YuQ5IiXeVEQJ6H16@nvidia.com>
References: <20220727193415.1583860-1-bvanassche@acm.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727193415.1583860-1-bvanassche@acm.org>
X-ClientProxiedBy: BL1PR13CA0344.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::19) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed1d30e5-33b8-4bdd-82fd-08da719b1066
X-MS-TrafficTypeDiagnostic: DM6PR12MB2890:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q3nckI7voEiK+Kgohk560Akh8XmlfqNBCYiCOQpiTZhgXUX/RXHMGZ0VZAoENz6sEMzDc2Fl7lrfn4mXjEuYCMUTbn1EZiAwefp34nhUdBCFTcPFZ3tCdyMhtAO6tjU3bLYsOe32UIgGdzBcTQ5OQZBP90HIJf60UgwPIy+4qV9nQ5xZVPgXcPNdeZWhjmEPMX1fIKhI5HBIN4IuzhlAkqcPoBtZ+9bo7qyXHH/80PaCiqx7d0UM9m5yt6Xcru4j2rPdbK/N1Qu0IAMhAzmipAt68dCtwefQKWpev4K/8OxOJ4VWHafiePSsfusa1nguOkvP9U5+PKIuiRvSccr5dH8RVO/UYfCq/FG3OkygpOwa42bf5vkurr0vqxm0FerFTsh5Oi1OmUD72BA9i7IIcv4xkImKYvymRgsb5gHqKovd4uBY13aCmZaDdpngsZEw4GrX97lxGylDzRT90s7gsvzDiDjXQGVsomr4zI4/sjTEeRaX1B+qSeCLNwz5tNf2oey4zzvGPGV/etFZIgISVlKAEUECyhv+kHq/pmS2nIdwmWosG9eZ5FJ9Dfi+yJE0CX2JWQDYE2p6yb19bcByzFDP1dIG+llw9Owm+FjpwsGUTePomUMxuPOTPs0VjGyMLV317slIMkIO8iIdgSy8Ank8Tt40pCk7ghteX4zh7ovf7YRcaAT+eGjOkWyfZLBHVBfqh+5DRcBVLMEQye5XU5R8KRjdcfS9Kp8naiFs9yvn2xoVXKu/H++gYyIfKN0y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(66946007)(66556008)(38100700002)(4326008)(8676002)(66476007)(8936002)(478600001)(5660300002)(4744005)(41300700001)(2906002)(186003)(6486002)(26005)(54906003)(2616005)(6506007)(6512007)(316002)(86362001)(6916009)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8KKTZ2/o8p2IfaoN1AiUq+fN2tAzx1Vl2G3OqvH6z+iA+pnUVaR4e5vvSY4z?=
 =?us-ascii?Q?vmLNxB2ynmTMhXrueQ1rybh3wFvY85BP/HlNRVJLkMl0Elh9NkfZbVzz2aQW?=
 =?us-ascii?Q?XVwoy+vLLpA8JxnQ5Y1OuBVMYKeLvixGkodzfB37816V8B81KzboKFur4rA2?=
 =?us-ascii?Q?yaFFblXBZfyF7CELybGZ+xdjHqVr2E/6/K6aD5oVLcsTc4yy/sH/xcIhmC+v?=
 =?us-ascii?Q?iQf0piB0Wt7d3k7ZSUMfVPJN9L4wsO6n60OKhyZuWYJSdff0f8o2AnjlCGUV?=
 =?us-ascii?Q?bfgGZZKcMHcT+hJ3rEp0ap4XcNooYRAy8GHDxQE9n/0vDfz/+EVxDhawSrqZ?=
 =?us-ascii?Q?7b2dShyY3HwYsN/2QvzlRffp9tfRe0Lf6YytN9OgIoCfxpOPggEZs9Sm1xOo?=
 =?us-ascii?Q?80CiqhE24zfYOgZOw8qzha2y+hd4Dd0cn0vtvJAYR/hUog7v2kmWrxB/Fqh3?=
 =?us-ascii?Q?QvO++lvTesvuQjy3vPjJlx7hF77xbgDOZ/n1MGwKBVkQE/DwIzx9SsDCBqSM?=
 =?us-ascii?Q?4x7gDmFrI99NL5txSfTgmmlSRb1lxzlvl96pO9ZRJ7WIj2oIH5J3NLx7YoRR?=
 =?us-ascii?Q?wyaBJoeodimmRt5VaLYKjdzZ3ZidsqjgQA8/TxjrkuhNCngFc7goKu1+/p4z?=
 =?us-ascii?Q?vy7+DH8GPoQOfF/6374fXU0jVgozxglkBZ5lQ3rw8CbPrUc5SAA1Yx58/Lf5?=
 =?us-ascii?Q?27Fc5FHfg+pU0Iofj5D0bsydibb5d3cEdZEqiUTq7aUVzD0cVZz1+RI7kVuK?=
 =?us-ascii?Q?uq+sxjoN3n+ndTXvoAjV5rRkPUk96+u9qshvJXwTc/4l8QD6Qf9m34lgY7UI?=
 =?us-ascii?Q?9/Lpl9nuiQYAPF77e0ONZ1YTQsd/sq8diGniNsz0CDeRFcg1wznjy43VYICi?=
 =?us-ascii?Q?eIF7ybnvlgA11WjzoXTjrFhmVfjUzxiaeacKEGe2XuifGoiBwtY0C0NyXrbK?=
 =?us-ascii?Q?zBq/Tefus0Xft7Zke6D0ZRBoeLrypYnRs+5eDx4zQRQj+TBK0bND6/ItNsqR?=
 =?us-ascii?Q?5KxGe7bJIcXBKzZ8tjpe8Boy0B0Q9PMJ8lnPvKsdQcfqtAwodp9IkSLMsBwm?=
 =?us-ascii?Q?XM1S5ygE/qJnk26Ss5mrkb1WpJBQAPfnev+RVOHWRHiLyKV2t+S1o/K5sENe?=
 =?us-ascii?Q?6hNsZymhGDtTRv7qzS7c9e8hUgXZxrOxv1W9J4qaKiVHCrFJ4JpDmJDMVc+e?=
 =?us-ascii?Q?ENYdxi6ayvth3DEemzZre4iFDvZIbYCdpKiZLmFbqLpj8KVXgcFufB93vyo+?=
 =?us-ascii?Q?BQPwhFWUvcONtzItqeU62JcIBsw5WGLuiAt4033eAoTot9XPdWw6RUkdpiXG?=
 =?us-ascii?Q?3NHCDTkeKlcXSXDG9CsXZx8Xs2AwzouEapmTemAJjMMqLtyc9/xkHzK44bQo?=
 =?us-ascii?Q?ccgK79nGSkXTcCDCWqiWltvjUj0dUpuOo7M6NXzctfR/15nAOcgAPoyNeRC7?=
 =?us-ascii?Q?ZZO/5Vw0CvkAzVokiXJ5ckB1Lij3kaY1M5ZtdT2QdwyM2qaU3Shy5InIMMHs?=
 =?us-ascii?Q?ozSxy+e4OzoWquhxSLys1/Dc/+DMYFfvgQC9q28792EGxlIZ5gSzGMbZcClz?=
 =?us-ascii?Q?VaBydF6AK3dsavqZtidp1BFHragkQ0Azv1lCEzT6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed1d30e5-33b8-4bdd-82fd-08da719b1066
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 19:46:43.7556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jh1P6FQeTXa7loDiujWhugBfkVGlltlOJKqK58duh8qn08DcbocjmE3V8TS1Fbjh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2890
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 27, 2022 at 12:34:12PM -0700, Bart Van Assche wrote:
> Hi Jason,
> 
> A known issue in the SRP target driver is that a use-after-free is triggered
> if an RDMA port is removed while a LIO target port is still associated with
> that RDMA port. This patch series fixes that use-after-free.

Applied to for-next, thanks

Jason
