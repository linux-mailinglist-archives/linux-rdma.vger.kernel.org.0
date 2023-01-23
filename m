Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C837678678
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Jan 2023 20:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbjAWTg5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Jan 2023 14:36:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjAWTg5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Jan 2023 14:36:57 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2046.outbound.protection.outlook.com [40.107.95.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B2030EB7
        for <linux-rdma@vger.kernel.org>; Mon, 23 Jan 2023 11:36:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NiWV8T1zIw9kbONtqeycjYWyIUU8TTEON788jVrOj+Jbs7hmDdcyhLLRqbScV8t1DQ4Zty77JubHQgYwA7vPiyts2DJ72fSnrpJR0qmSytp5rpA18x03/kK26WMAMnOQW673UCxY8ZvF28iKdmmbGY/r0P9jS9o44NddPYFgEWLZzzHgdd7iMhTC6ee5/WyescMdw5ce12U1uWdfFObW1SFCXJAOXRRij2gtlOpxbHbcFuK9I5KIfjcOEHMQaE4ro79taydh+kPXRU8sFLHR0dm2OncC5WOVtJBOGVjfqb/12zJ2Fy1HNWyWTBjt2yvpE4rDUv08LwOw93VZ0epFaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFIGJelD7ZMvJtN+iDfbqjsie2wTcYfRiusB//qSFdI=;
 b=j95/lyfZRZWC2fOrbs16YciekAdImOjkqI7JQMU/dzw/wDfebFo+j5M2RrYlB01l9b30pQyMSJFwE92EPT1KZBteKAtE3Ihjo9cdQgdscSOsYMl9rU282MEATqz+LFsyZIejHltdOEONlDTKGBmgNffcv+Z7r11KNQmZHJmVy4RFk6xcBBJMHNN23FcQ2TApVrRIOH407aLjCq2MOx6SreQmSx0LoBGN4Mx4Ge/vP0uD3cvmjXga7+NdjPJg8aYHW2ECuH5Weup+56oEA/aiC+MV3ko9tlaQ+UiVDTRJ3co9/VCK6w6+Kd7ivXCkz+431H+6LMvDCjZxyA6NJpgiow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFIGJelD7ZMvJtN+iDfbqjsie2wTcYfRiusB//qSFdI=;
 b=CzmfbFg3sp7VNVXEgEx/uXXihz6EQ5JxnJ0wx5+zp4XkycwlpAq/LEv0z19VZ936G/6MztZ/lb50SnzJwNN4EIvSBZK4pSGbwXzgzRIRscKjPbazwRaeUTyIZAdu7SK567JLTce3V0f//O2vuxY73fbt2HWxvXgvKH6g5DkSp5L1m/qTn4f4rnxVWgNdbjjJMq6LXrgmLzxXDoAL2MVgZZ29IaNBm4U3PBkS56Iu5z3zYC0hbbMQtcI+oqqVoM65cZyDDP4wjfWboWW9lKf8iCKIZ5+ejgQIhxjyvrEvgtLUBvDldyIL1zcbousZCcXhBPRQ/mHmZQTT5RNG/Y5QNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB8352.namprd12.prod.outlook.com (2603:10b6:208:3dd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Mon, 23 Jan
 2023 19:36:54 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6002.033; Mon, 23 Jan 2023
 19:36:54 +0000
Date:   Mon, 23 Jan 2023 15:36:52 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, leonro@nvidia.com, yangx.jy@fujitsu.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v6 0/6] RDMA/rxe: Replace mr page map with an
 xarray
Message-ID: <Y87h1Cl7aYXDD49M@nvidia.com>
References: <20230117172540.33205-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117172540.33205-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: MN2PR05CA0056.namprd05.prod.outlook.com
 (2603:10b6:208:236::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB8352:EE_
X-MS-Office365-Filtering-Correlation-Id: 986cbedb-697a-4aa9-dbc1-08dafd792e9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jqdDlvAUipMYWBalf1XXljgTaH7DqPYoE9LTn35DHqg9a+l42Gq+3THiHsbF27qp5Qb5VvUq2AFo6sl8xudGUmd+UvtLRTuXX4OUK8WuMZ4NFhqzHD7ZMyDE5LUHxxJx8cm/RTm+aJacQLZeffp5ObP+QdkLpdYq8gIqirwIDTvlQPA4vS2r8+3MY5CK3vFdpQf6uL3Q/0cFe5hCqXQiq1p2A7rgaMEn6DUix1MBvYsJDFXx8mf7VWaveP1T7Nbts9xxy/1NHwH0OIfRWxHsmzoLOkSD4q+NYGzu+wNMoN6g6U4EPbXI+DdWirSmbMX+dTcANhYGEP2d6FRiEGYUDIGhrlvZ4HqdBYvAMo5zGfVwaP6EYlZ6mUFQejyvJHWyBqhvx8VuGfGsHyw8x/27flzsJUJ5N/DU30y0s7J87fQujRP/U8lxGtLDqhHoC2jVKKjuQVNg/M3zVK6aJtLPHIjSSKEcUQyBqDkx+PFlR3n5d6wwmqu7qdkLrwyx7+q41y0zQKnUCNdPgHSUDQJ+XquGS5VIN7W6W0AN+iAuMEnF46GFbpVDpVT4s0sFKoK6wh10mHVsdtKlJxuPkn1F/zPMpyj55lwXjwtNhB+hlfhKoroLM6FGBvalqx49I0Y5tUQ+31E6u5ckQWQZIGBzHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(451199015)(38100700002)(41300700001)(86362001)(4744005)(2906002)(8936002)(5660300002)(4326008)(6512007)(26005)(8676002)(6916009)(186003)(6506007)(66476007)(66556008)(316002)(2616005)(66946007)(478600001)(6486002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b3IhYSN+89ZU5J6ZEhmwArjOompQQ6sRAt9wJRcotqtmwxOj4Mm0U29u3Eq2?=
 =?us-ascii?Q?lZDoDvs6gyHDwBiUM/wB6RwTY26n1fkGhJfvvqZaz2PLL56ouV+xYwDhoyPr?=
 =?us-ascii?Q?ZiObCNRHjjpUuTvocHkdWEnm1kkG7rKDlm5wgvSCmFGxF3hLpJPr6EMI3Wg3?=
 =?us-ascii?Q?AWHa1XjOV9YR6u5xcRaCMCl0v0AdjP67tJkkiLdHfxw688quHLBmsAEH39T9?=
 =?us-ascii?Q?TgK0GwumP1vCcU3mtq4q/6mtgne4/NuGp9FZ002h45RcUPJiAuzC0/CktvcW?=
 =?us-ascii?Q?gyBF8ObQtE2aE7JTvdc+jM70y1XycWmB7I0Uh3PdboyD+dQNOsFShs10UWtf?=
 =?us-ascii?Q?BoHvmtgaW3mxHZgAOsn794XB5dMKjIPzNQ/ICjbDqpoGIMQTVyjrHUnsdOpR?=
 =?us-ascii?Q?o9OX4BpCcqEXleGrQPr/ON1S6K22w3eimV25GbpF5j0b7LsiP6m9HUi7XEhZ?=
 =?us-ascii?Q?roPJzrbGxbbwSgQajy54tQJThkDpn9Q+I9pJ6ThSDbZEqwjPCOwEJQ2ZOI1Y?=
 =?us-ascii?Q?T2mTmk3xanl1qoVlTUJXGhIXIggYf83XF1J41YIHKbST/Ghbeiv89j4Ornml?=
 =?us-ascii?Q?v2qedksp5nVHCLTjSLygw3IhFVyMBpxzR0udWV5SK+yN1oErdeCw9hCHkpui?=
 =?us-ascii?Q?DnAGVKzNcYwcsXCaG5B8oT52r5yUnUpJ20kg6MUQtkCWgsfE4bEsrCHpYLjY?=
 =?us-ascii?Q?sEat0/nsK18vDRNmQZUGxHpDTcHFQNcHfsIICP7oH3cAlHGbNBVvytDKTxdB?=
 =?us-ascii?Q?ZqGeO3oc55+uqF6yKwwMAOi4qUva2HvfqEQU0h1dNFCd18M7vZNBUEsrrtG2?=
 =?us-ascii?Q?7+JRTP/its7vdg0+vlvnicBZsSp7uMWlXkBD90Xb9cVFhdYL9nsbCt9DFPr/?=
 =?us-ascii?Q?xsaVM7bcU/W1ItV+SdCv68p7VEROhi9bElyT7YlVx9D6msLIvuhR36Fz1Kh/?=
 =?us-ascii?Q?QChaQOTelyn9CZPHZ987lBJqWotDFPAktCO06QHj6pmnEtugB3bs4eOXDN1m?=
 =?us-ascii?Q?uHghyvcGyPHgCx1vT11CGFYP8rpkNuCL2tVMWUcQHRbd5wWYK9BE4lmkKiNq?=
 =?us-ascii?Q?u/zAqO4kItcPFu5VlQLyyI1mA/+Dq1YDZMTgIwzS0qhcznqAYCcVsHhYGTNI?=
 =?us-ascii?Q?rdalOkVLHXK/pq0+8FfwNWMgsj3JDTGEHp8NXHq8nzQJKqkAOn65bFO3qeBy?=
 =?us-ascii?Q?QzV6yGpIrGvW0l3xRNSDY9vxbfUy2WMiY1OVIiA1MxOmjR1up5reEXywYsgN?=
 =?us-ascii?Q?XvYL7lDBwIIApGt13GDY7Mpy5eunStbK7mRwitTcQubbDXlqK+96cp4uNlQY?=
 =?us-ascii?Q?S2MImmT+grstubAwSMHtqnen3x4Jt1dEw1iXiq+1qP133hgocGB0MhzAggA0?=
 =?us-ascii?Q?zwudkmcswb7+rnDj14XwXoF3x3iEXpbgBm+sGYR1Qk2/nVWR/tV9zOlUu4u9?=
 =?us-ascii?Q?7+f4K8VLNNkxynUwaz7HWm6OTSprjxTeqG0gr7SSzjVgZ0GM2xz3PQrOzBM4?=
 =?us-ascii?Q?aSET3IaTg+TrwISM6xA6aNHRaRyRPup0k67s4zRvYwcC2WJYETdhJSgZ7B+e?=
 =?us-ascii?Q?vdhBW/9cZAOcUWNatVAo6hasKNDJ8igmFhrQjSd4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 986cbedb-697a-4aa9-dbc1-08dafd792e9d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2023 19:36:54.2563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: agaX9twAH/HoRlHuNtHyEUraO+yvi4qfTKKiWzwgjSJ9IupyazA2VX03axkM3Ytw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8352
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 17, 2023 at 11:25:35AM -0600, Bob Pearson wrote:
> This patch series replaces the page map carried in each memory region
> with a struct xarray. It is based on a sketch developed by Jason
> Gunthorpe. The first five patches are preparation that tries to
> cleanly isolate all the mr specific code into rxe_mr.c. The sixth
> patch is the actual change.

I think this is fine, are all the other people satisfied?

Thanks,
Jason
