Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27F56D1237
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Mar 2023 00:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjC3WhX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Mar 2023 18:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjC3WhW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Mar 2023 18:37:22 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB36E3BD
        for <linux-rdma@vger.kernel.org>; Thu, 30 Mar 2023 15:37:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGk1AqZRDSC+93ShspyfT4CA6Nbv7kLcGIN4v9uPNzc5zdi0NoysRPOx+yN/VNm5+A7NoxfdRdKk1GA1DtbiBoTRFAZ9lSDyzVCnnyPfKTN+wFozmLSiYyzZS6CvOvKHQzMIwU0pb0ASK0nN9w9dGPdpNrbPR/aqStNZzL39l64YeId+JgmlGBQJjNqs9B0cZL2VrSbFNa2YdkZkOg4suiMAryIOELUaHixfrrjZmGv+9TzVTbTkcuPLXay/A3i5D72NLpus/unQ4R2nRBwVGBZaeTjdTvGDVRAExKqsMSfNkB09+b96S1QNl4kPMfaDfvBjaETpl/N8x79gQxdoHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8yra3jUzil5K49Ltmn/vCHf/FyAJYTOjod+b+/NOaJY=;
 b=ZN0jB9c5/QfVbfnq2frJfJibdsmKn2FJ+z1+5PROGSBFU9OwKTd/SSl14q9GwqELvny6NPq4yasRpD9jrk5WkQvOZxDvaNpIb8o3sX8PWoGcQ+wlIjBUB4lyv67hg6lOAP2imCoDgzQtKyf8tCF1QRlWA+bpIwZGfJEvb+U3EkMEssVCiBl+X7HAJn1K3on3HjsXfoGs5/IK11D0eGBP3Kggg66+WNEKT+MSs9RshDqo1z3+hjXkRv45YcKyuxwViQ6Z6uXrqhtcb+KgUuReP86qjwIp3zum1WkaP18Umre2742rGXw5ycI8TeGoloJDlEVonCh5l9vMoTxDUpubzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8yra3jUzil5K49Ltmn/vCHf/FyAJYTOjod+b+/NOaJY=;
 b=hezoPRv2fFV1wDjDW7LPxSewxGTn4U5poehVVDuKiySwcPYshnacSG/i1wmEvlJ9pSXCFofNKmOfKqJrQpwRqn1lcmxRnSwR08u7t26BxDlGiz3DbSN+UTJjChX4+DzIIF2zagzlEr0Uxn21LszEEFjHapCOd+8Zybfq4hIjuCbhL/U+yJcRsuy8QcFlY7sw1L47r19zbo8p3sN3mT04IRbOknphVzNiEJD9pe15XLyA0cSVaUVyUQBKvYVtboMLfu/kRFXMI3wTD5rYG2a32P0k2FPynseCdhx1qlI/dI1ukMUC3vYralGeTfFd8XUDrAnRcGn6b8QIOEPyKQpIow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH2PR12MB5018.namprd12.prod.outlook.com (2603:10b6:610:6e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Thu, 30 Mar
 2023 22:37:19 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Thu, 30 Mar 2023
 22:37:19 +0000
Date:   Thu, 30 Mar 2023 19:37:18 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     kernel test robot <lkp@intel.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] RDMA: Add ib_virt_dma_to_page()
Message-ID: <ZCYPHgV5riNGE0rS@nvidia.com>
References: <0-v1-789ba72d2950+2e-ib_virt_page_jgg@nvidia.com>
 <202303310254.tmWyQaZG-lkp@intel.com>
 <CACRpkdYpob6Si2ghXHqSD=6f_PO_gPbJhE_u4jNEcu1VbxO4pQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdYpob6Si2ghXHqSD=6f_PO_gPbJhE_u4jNEcu1VbxO4pQ@mail.gmail.com>
X-ClientProxiedBy: MN2PR08CA0030.namprd08.prod.outlook.com
 (2603:10b6:208:239::35) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH2PR12MB5018:EE_
X-MS-Office365-Filtering-Correlation-Id: c9f973e6-7668-4674-bab0-08db316f5204
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UiFTfb9MeB/az5ftHWFhJBPOA9xq/vlzNbR4RC2lXjb8GD7A3VJQQ31DX0JqdGc8Ron2YDL13NYG6IKRvDGEB0vhDYaCiCC8hGeIFbJj282akbGArhL4nmlkZGuTk8Clq2iINb5WbGuQFdXrMJ1GFLBPYEnGrWevwXqkLVPU+ZoRD1hlXzaJg6evGGxGS8sksSGasRRriadWhcsP8TzQ5akdZvVbMNv88sC0xRqTgMGhheoYd+u110mDE+FxTktaA/Bt/3u7WUuw/4dzXvoum0qvGpVa6zqUWNTbUuvbRbcVjG2R+c/DkuzeThlU+Ul0lA8zAmIS7/kv6E4j/d9BEr3DtyB4tRdaO2ze9/c1Akxutgjny4EdGpHtBz5/attlDPBr5JM8kaVOnwzg02hemhlzV7dKUt9O+DheIfKkEexZVRVxpegYwMVNzOTVmA3NG6PzY5y3u412zwQIESVFRU/FHfkT67QlKIK72DUaT4nb8kKHJts2hcUOm6sosg9Mr9h0yMnTWMhtb9QQN9ebLLzUjfFwwpummEp+KyJVWlYlWhf9PM9vl9zKU67jqI0H
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199021)(66556008)(26005)(53546011)(6486002)(38100700002)(186003)(2616005)(6512007)(2906002)(5660300002)(8936002)(54906003)(66946007)(36756003)(478600001)(316002)(4326008)(41300700001)(6506007)(86362001)(8676002)(6916009)(66476007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGYvRDhtd2VDRnN1OENvd3VLSjJNUUZ5b3NtRy8vbW0wa0lWTUIyZ0lNdUpR?=
 =?utf-8?B?V0J4eVFyZTBrRmxWcnJHeFlHRXozSTJWSHhSc1d0Qi8rODYrc21HdEhLaDc3?=
 =?utf-8?B?QnJ6dEdXbExRTWY5SnB4cGhSV2NJL0dTN2RNN04xRWtqRDVQdkdINUU4ZUpp?=
 =?utf-8?B?My9sUGIwSjVESmE2QnhuUkdiV1lPNGtONGlFOG5GTTBTN0E4eGN4Uk9tSjVT?=
 =?utf-8?B?Mi9PV1BRQ1FVVCsyc2JrVm5OTmFJSmsrZnJnekE0dXdlY0xhU0ZCSmp1TStu?=
 =?utf-8?B?anR0eTQ1M3hpQW9UWjI3aFF0NlJKT0gwd0wySzI1SExxcXJveGJaaGtOdUlt?=
 =?utf-8?B?cmJ1MnYya2tRRENTR2twTEtxcVlFOVIwV1JDQXArSktZZXZwOWV2RlY4Uzh5?=
 =?utf-8?B?RnV2SHkxL1o1YUtETi9RV2o2Y3hQYU92d2dTU1NQeVljeDcxY1RvdzJiT1A5?=
 =?utf-8?B?cy84cjZJRTBkOW5uSEJLbHZERElWV0dYaVpBTEV4SFYxMFo0cFIrRy96QVd2?=
 =?utf-8?B?QTFWZ25SSXRvcWVtb0V6ZjBDbkt0NGNJMXRvNlRQK1BoU2JNRVUvU1lQZHRj?=
 =?utf-8?B?RzR6Wi9INHo3T1lUbnRscElScExZbXh6R01iaXBBT0xWN1Nva09NcXR0WCtI?=
 =?utf-8?B?cGUvMjhHcFlyQjREMlFKOWVHeWxRaVE2WHlLYkdDZUd3VnovUXlDRmdjUkg4?=
 =?utf-8?B?TG5ZZXorSE1KNUVlc1NKaWszOFl2QW1Hbno2c1lvdUs5M283UU4vbndpYmVE?=
 =?utf-8?B?Y3hDSmZTcThqd0NyS0ZMOTdFVXk2aDhtQTk2NDlIWGhzRFQ0Yjl1UkZDUmlP?=
 =?utf-8?B?U1NhUVBacm1UMFY1WEFta2luYXBYREFsVndTdGI5aERsbUpTN1BXdlBVQ0d2?=
 =?utf-8?B?QVhVcG9xQ000VDVZNFNMWFEyTEp1UzBPR1p2T2ppbUVzVmFzR3hGMkE3Um1P?=
 =?utf-8?B?OUR1WHpuMG5XS0R4aThNVTZpSm1laGxjSFlsOGladmYwTUdxclhUQXBEeHRX?=
 =?utf-8?B?N0QrNnd0QlJEa2JkOW5IRHBHOXRhVkVvMXhKVkNldmExK0FBb3l2Zitsc3Rj?=
 =?utf-8?B?WFB6NjZsVXkyTTg3bDhWVHNqYSswNDJQWDhoQ2Ryb2YwOW9oa0xod1pEa2Rm?=
 =?utf-8?B?L005TXMrVFV0cFRmcGpqbkt4NFBsRmVDMG5nS2FDTVFpangrc3cwL0RYd3NI?=
 =?utf-8?B?K3VDSW9lcllYU041Y243OHlJNFZxVW5rVXloOXg4RHZOQlhTK1BGN1BJREt6?=
 =?utf-8?B?dDNqaDhLSEpVZERRMU5iVlBQd0Y0OUVUT1FCWVc5QUNTSEczSmZSVWVUKzNW?=
 =?utf-8?B?NlVTak84bEpSOHF3QUZ6d3ppRVJSYm5IY0NuckpCT1Q5OGprWnk2dWYvZ1hv?=
 =?utf-8?B?bG80V3p3YjRaZ1B3TG9YbmVzZzA0ZHo2RVFrWURDZ3o5Tm1ZLzAxZnhNcFd1?=
 =?utf-8?B?ZW5zaFJlM3VybFhHTVVQa2JEeWtLOXdQL3pvVkhJaUtRVk5TdHZzWXFITzNh?=
 =?utf-8?B?VVpzY2dOdGhaaFNyZWtjcVB4N3pxMHh5Qnh2TVhkREVYVG1DaTdxbzAvQjc0?=
 =?utf-8?B?M1lHQ20yMjF5TDlvbmt6K1MvVFdRMkdtRWdxSkZRYThRSzZQMFBKaTdxVmdT?=
 =?utf-8?B?RTBHMFBWeVBLbEt1Z0ErNnpKR0dqQ3MydlpNMTZyd0tTN21kVXNZM1E1b0sr?=
 =?utf-8?B?U2xMa1YvRlRZZEl2VVUrNzdqcVlrY1Z0VDU3ZzBhS1NCcmxCeHBpZng3aVdr?=
 =?utf-8?B?Sng2NzNicERxaFFrSFlxZHNGR1o5UzhhYnhCMVI1OTZEV3d2aWs2MWRHUWE5?=
 =?utf-8?B?TkU4Q0lST3V0VjVUMnpqVXo0UVptVGg0ZlA4ZHREYVFVWXg5MTVNYnd3M25B?=
 =?utf-8?B?cWVKbDk3Zi8vK3ZSYlhuM253ak1HVU8zek9tQWhNeEVsSkw1dWsyNmhaZ1Ji?=
 =?utf-8?B?bFdwMHE0MHo4NS9oQU1BdDBzZW9JQURHSWV2M2Z1YnNwZUVlQjMyWTlCeWMr?=
 =?utf-8?B?T2tseWp1UmhXZmJJd09McUxwcjdLQjBLd0grNEh6aXFKTUcxZmNmdlBLREJW?=
 =?utf-8?B?c3VTbW5ZcFZCWHh2bytXRjlDbEUvUXQrSGtQd0dSR09RY0tmNUFPWWdCVk9P?=
 =?utf-8?Q?lOxdEuyZ2j6rbcexp7tJHqovD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9f973e6-7668-4674-bab0-08db316f5204
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 22:37:19.1791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SuGsDC4swNL/Z7/9PP8JcOs1r4msN5lv9I/bOM1dW7tic/NEgYnZGZpRJ8l3IYZU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5018
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 30, 2023 at 11:53:52PM +0200, Linus Walleij wrote:
> On Thu, Mar 30, 2023 at 9:02 PM kernel test robot <lkp@intel.com> wrote:
> 
> > 0d1b756acf60da Linus Walleij   2022-09-02  536                                  /*
> > 0d1b756acf60da Linus Walleij   2022-09-02  537                                   * Cast to an uintptr_t to preserve all 64 bits
> > 0d1b756acf60da Linus Walleij   2022-09-02  538                                   * in sge->laddr.
> > 0d1b756acf60da Linus Walleij   2022-09-02  539                                   */
> > a10308d393288b Jason Gunthorpe 2023-03-30  540                                  u64 va = (uintptr_t)(sge->laddr + sge_off);
> 
> Oh now that becomes an u64
> 
> > b9be6f18cf9ed0 Bernard Metzler 2019-06-20  541
> > a10308d393288b Jason Gunthorpe 2023-03-30  542                                  page_array[seg] = ib_virt_dma_to_page(va);
> > b9be6f18cf9ed0 Bernard Metzler 2019-06-20  543                                  if (do_crc)
> > b9be6f18cf9ed0 Bernard Metzler 2019-06-20  544                                          crypto_shash_update(
> > b9be6f18cf9ed0 Bernard Metzler 2019-06-20  545                                                  c_tx->mpa_crc_hd,
> > 0d1b756acf60da Linus Walleij   2022-09-02 @546                                                  (void *)va,
> 
> Then this cast needs to be (void *)(uintptr_t) again.
> 
> Not very elegant, possibly something more smooth can be done.

It needs another similar helper function to from dma_addr to kva void *

Jason
