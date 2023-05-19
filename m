Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98AF6709C49
	for <lists+linux-rdma@lfdr.de>; Fri, 19 May 2023 18:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjESQV1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 May 2023 12:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjESQV0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 May 2023 12:21:26 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7803FB
        for <linux-rdma@vger.kernel.org>; Fri, 19 May 2023 09:21:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DRTe8G6X2npq5Nl2D6VKvfFTgAR6XTfmrfUgV/0LJFUpNUEugKCZQJ7bGnrj2Fzkvdi61ZXrp8z8eQ04/1hsHFDsOlV37FSWklOI43jkrKPdhdJ0aznJzsHvgFNxXnRfjmPGNy35SPa7Lt/UCXVNOFz2PMuMcY7+INBX/nKAVkjsWiJreNtucvHoyWS7aZwfxU6bungXKzyMuOaxnkJvmXmLv2yO4WL/N300D4ea7C2RAbeYUAUcam02ABp1oLFOLgQHZOS7Ezp1FaGQhg5DLIl1BtbBUsacPEnd4DJDyrMrw+byELyb50zefAfXXr8Crr+l2i2hR+EbDFqg08rxVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NmmjQlcu0aP4Ex/zqnlg16q2ImU+SrAjJyuwhXNWwuI=;
 b=MLZM8a1GxahRkKOzbbbnJMMTjd/rccRQj6skO9+5vhCA6/CSgUEFbwXDZQyjNp+6H/2DrRiJutaGIVleP0ibNDWEQw813KenJehX6qttIqN93s/DWh52tfIq0MbntHxaGk9tOSJoJdWz7OL32vauuF2/j083es0BQGK2jjShUIV2VAoGlMDGHQ1E1tCzSHmsWV/3ORqXlzyvhIVdxMwzEiGs+/0Yrbj8RAXq757xKOtxo4wGL0HZf6IVzboddkGLsOrluob84l78Di8Xb8T9YmUcY+ExC1o3MPWeMoKM/BfoSDYXKK+jjZ6+GbSfAPNclZTMK0hZVAmzJT75xPK7wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmmjQlcu0aP4Ex/zqnlg16q2ImU+SrAjJyuwhXNWwuI=;
 b=ZIhe3BbVl4KyuSUGHt79t1eIPtOZTbXuQhTkQtTCoeN1nWqf7Kvc3313GA0bau1S1sTOv34OiDHgsfmGkmGUrEJC+6427iwZEd2Z+DR9/S7hwIcW4+aFHtm2yZg5vWEtDQRmyo8OPcZdaWWq+PNlF0jM+cbPuDkPCoRdVSnNopYfiGSwCDZMjwwLGgyED9VVhmDCMlpQ+oXwKD1XOmIbt8CllTZGF4Pwm8Kp0OiHEX+WQTxabcsWEOxnkxAZ5e7DjiARcQjLNfhWmw8NhajHEDDasdlQMFWIqucVdEQPKHdd4WHPpjpRicobQPQNd9Rj6WXRgz1637LcvwnT0ALO/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ0PR12MB5662.namprd12.prod.outlook.com (2603:10b6:a03:429::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Fri, 19 May
 2023 16:21:20 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 16:21:20 +0000
Date:   Fri, 19 May 2023 13:21:18 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        andrew.gospodarek@broadcom.com
Subject: Re: [PATCH v2 for-rc 0/3] RDMA/bnxt_re: Bug fixes
Message-ID: <ZGeh/r+2I90fKbbe@nvidia.com>
References: <1684397461-23082-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1684397461-23082-1-git-send-email-selvin.xavier@broadcom.com>
X-ClientProxiedBy: BLAPR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:208:36e::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ0PR12MB5662:EE_
X-MS-Office365-Filtering-Correlation-Id: fe695afb-d935-4071-0173-08db5885143a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mtjsD3et/Nf90AStNJsvyNURxZ/nhnNpagsnnZz6bTAY4K8I3MVpnNC2bCrdo6QjapFGGpvCn9J2NeBm34qBwjiSfHfGxTnOm0TpHoJYZtL2lxe+G7YUcPGhdW7mxqSYa3/uySYyeEvUZPrG7XHujcVCR8dEbnJ5FcY8cgFTaEoChLYbLH1F9qvEAdLvwbDjH2DOZRKz3vRE8nZQo0UDyTTxn267g13x9gK39rBVFflJ0pgEJzEFwhtiJzHbKKj8wgBNkA2awgyAnOeEnjZ4KgfuIhVWruNGxRRMU0qK4gmk5pXBcROwPRNDjftWe9XFoXVkpecl/g+cL6bF6Avixndz88KlJURqhgwJMX4d3jvjY6kv0am6OQ9F68KNb+qN4su44Y72AHA3VsOpBThSX/uY462fCDDdBaG/KX1zjDk84+QTvjHW6/uVu58IQ7254JVmEEbFoLs735GnI08SiK/1jE93b4MEMh9+mxnLbyIREDLrkirIBrq/1/hooBsAy1OZw1RtETTbwEpw3Ou4VRS1epV4jG14rxhq6YsbBoZMrIWsHmutJs32VpwQ72ES
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(39860400002)(366004)(451199021)(6486002)(6512007)(186003)(6506007)(5660300002)(26005)(8676002)(4326008)(86362001)(66476007)(6916009)(8936002)(66556008)(38100700002)(66946007)(316002)(41300700001)(2616005)(2906002)(4744005)(36756003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dPhOrlZ/FQMjyoASccUp5TxuxaP18zbWUUQY1xqOFf7ofXNQoD5KsBsJKpQx?=
 =?us-ascii?Q?1kv3//PiNRIkhn6EMkvb2TXPKtH2IvXozlCKsqMINgn0IAvJAOj56l0A/vPL?=
 =?us-ascii?Q?jJyqCcisztpHhRsVuUgpEAnvaVAAGf8SGsPA8+kNGCfqCEJdGKL1Lzyin5zs?=
 =?us-ascii?Q?ROAjlRSnoSjeJKV3FGJq93syvLCCVK0vp37wY8p24JSyJf3KT1MDL2nG5Rrf?=
 =?us-ascii?Q?KBPwtcxYofWYulOSiU9iJj6ITOCRGkL3ZIHq6+sj6yeJYIgGM/iYowoyLecq?=
 =?us-ascii?Q?Cy8u1HW5yBY11v7g9YupF2Uuv2D+k7Y+kgt1MxEjAADmlcRmo/d36q1qb/zl?=
 =?us-ascii?Q?/rxqmMLidayNFU4HTRfqqjXDxcxItXpw2Zx7rPRtaKYUs7l2grmyzuNbOCnt?=
 =?us-ascii?Q?LwaijEpveJSd26MadJ5Nrdl5+FLxiJs+TDZEfGIhipTwfLIRyI451nlX4ewT?=
 =?us-ascii?Q?+T0IdWwzwkRJQsvD2n9yc+TU7bnGwbNXJVX8uCCB9wri/Yv580Bj5jusn7wg?=
 =?us-ascii?Q?cE1St3KslR+clxWCDIJtqqlGgz1rfg+rh0aIYQ6ioYy4uy5RwCACfii6nyX4?=
 =?us-ascii?Q?ywmQkTQwWT6J11wFShiyY5/H/AGut7wFmuw3W8VooxTmerWp76UEaZvN1mzP?=
 =?us-ascii?Q?b/P5YfomNBiIEi9tj+n01nWVqkqUhFMDCS3I7cywX6D8eV80MHDUesLaIx9F?=
 =?us-ascii?Q?Pf5zvy+i8LtgIXyixACkLjXqGYIp/drSNY8LpEEFAyK2jfuhK1Z60Gti4/eL?=
 =?us-ascii?Q?zrCkn4JKZCob4/OohwY/Px9bBRgIfmC/PuHk+pc5Kp0021r6tY0K69+/xKmW?=
 =?us-ascii?Q?4UsPaTtZ8FahJxhEfUu11F9ifYgmaB/j049yn0rSmNjR07/oz5+pdKvzc/kA?=
 =?us-ascii?Q?CN4sYIDWHoBhtUbZUehGVdnlaWSv3AQSDyh5HpBdDKyiC5DBfLjCA0L0tla9?=
 =?us-ascii?Q?CiVZACLek+3nGlyjfbKvSel14Kp1tEVB4DLzODGYH4Ap5zXq2gFDnk6IIQz8?=
 =?us-ascii?Q?vw/eeE7fZj0Gz6D8TslKBVNMaoKfY5R3W3QeH7Zq0tFFFnv40eDlMjzTXTk4?=
 =?us-ascii?Q?qyCFiw8P3Waq4/lvO/hzXDy+UM/Fl7ZABy0A9XkEjtbT2ApKHlYjez6XRdGX?=
 =?us-ascii?Q?LoWmAszdXsxNDsZZNCJirKVnALyfVOJd5cAQ2Iz6X6SG8IpRb73GN8/QmhvQ?=
 =?us-ascii?Q?Q8WwiobCHmKofgOJRb2Wvh5V77Aqd8bSQRjDRW9xNU9HaaEPf9ZI5K37Il59?=
 =?us-ascii?Q?r8OuF65AxfGwBitp2HK9uVzJomhzdA19RXSMMcxKi36f3AhcupltWobKbbDw?=
 =?us-ascii?Q?TpNbgKnlQEaW2lmzqKqgMa+DFaB4K4cnsb8YKfBLvWomQkBgiBnsU0s6SYaB?=
 =?us-ascii?Q?90KmCptvdreut5bYu1pUD58v07+IyTjhteelUh0b+t8LPcG5BXZi3ABUp4pt?=
 =?us-ascii?Q?QLh5vwL6U52+T6KTTgJtj2UPxTIDOZgJmSB6nLs5ZbFEsCQOmehhUfSG23iU?=
 =?us-ascii?Q?kJsa22iqCBvCaCe266bbIa/DuKx3MjjU3eeCC+EnsMkOYb0lhKUNjGNRBqWa?=
 =?us-ascii?Q?tgJT80gemFBOVlHcl9+zE9UDjtdYmXt9mn6ja1KP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe695afb-d935-4071-0173-08db5885143a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 16:21:20.0440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 77RNGZKHV3mrdmCpx1hdLwu4+HAAGQ28UEh5Ny0uLYfa/gmnKXkJxGsKfE05DD2C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5662
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

On Thu, May 18, 2023 at 01:10:58AM -0700, Selvin Xavier wrote:
> Includes some of the generic bug fixes in bnxt_re driver.
> Please review and apply.
> 
> Thanks,
> Selvin Xavier
> 
> v1 -> v2:
>  Dropped 7 patches from this series which
>  will be posted against for-next branch.
> 
> Kalesh AP (3):
>   RDMA/bnxt_re: Fix a possible memory leak
>   RDMA/bnxt_re: Fix return value of bnxt_re_process_raw_qp_pkt_rx
>   RDMA/bnxt_re: Do not enable congestion control on VFs

Applied to for-rc, thanks

Jason


