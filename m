Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F364776C09F
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Aug 2023 00:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjHAW45 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Aug 2023 18:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjHAW44 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Aug 2023 18:56:56 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A1810FB
        for <linux-rdma@vger.kernel.org>; Tue,  1 Aug 2023 15:56:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMXI01Wg99mpOXP3Cz1WDxaAqghPxB756+tn5FXVlsH4G+v3wOGmKim9HtFhNT3QaaeTx9yqM7SNOxrAmmu3xCNKfXtmnY8BQ6ESktZ6KFJhFmtAcmHrSYLl34edoT+tjxyI2kyZibXy7mjjYmPJwBGio4h89bXW0p2+L+/f2X8ntnB10rVVUmSAbbJ9xIlZSIBrwn9JFkY3PBVxhII9tWee0KLXEJaFc4ozsyd/Z7A716J9nWrUH579qf6xRFdP+ziHm6Dvr6LWbv6G9TFqmZfFPz/fiXqTSOj3lah3n6nvhCMv//JCrceVaH4slqfVf5PPtz7cZ+s+wfOWBVAayA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/DVaY2dSU8filE0I6VqqbkCFqF/KU4YhXEZfp7ZFsU=;
 b=D0EzeM6UEvmMebUtCZ7DIWyKusXn03YeMM03K7BhKiN+cwSFgZhFA0OeOzaUcVb1wTPqEy07BN9hDKW42H1WMn2k/tRPETMpzGw6GDchnzlE8NBHphlfmUr1SN+zY/R/NWcxLRmv/+cIhw6Z2eAmoTyvtdKaahcILKT3uD/rL2WC/+r5IbCFRajIHZSHO710Y0f2Q2KYiGjlkVNZ9oAJO71urQvSmedhtN9r3dxFQ46ERD1efifKff41gy9G4FlPbMNwgBzrd8r4p5qBaJb2XEi9fcsWFw4YxeKLvBROlnCcbuwlaYA79V22akB/H6EUk6DzNsDZvoefNgGuh4S7mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/DVaY2dSU8filE0I6VqqbkCFqF/KU4YhXEZfp7ZFsU=;
 b=XF680h2YCr+5Sd2IgM7StbXNYSsAjhjob/Ncn5vz94f7Buhtc+5ti1/2AAl8ISDXDL0mSM7XawKhbYp27Rw3FcBDqZwvDcEQ+KCwwCv8TqscibgO7G+v27c77loXiU+/PSxq4LwmO3AEZtcmiptzO+oXTwZfMXKU9d96UFUq0WbAgMbIdN1ClZezEhebXhhS4+Sla6E5x0qzLLpl9/t/fUSFiJsJaIL85Tm/R8czMfUm8jnzQK9KTFob8a4ShFE/y9iwwSKKty7BYLN8/O8wl4Jxyi6H73oZiO+RQzUc3+yM+aQes+SGAzBvWidaw48MpjxDQ+wLQcwZvyYXhgIwQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BN9PR12MB5308.namprd12.prod.outlook.com (2603:10b6:408:105::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Tue, 1 Aug
 2023 22:56:52 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 22:56:52 +0000
Date:   Tue, 1 Aug 2023 19:56:50 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     leon@kernel.org, zyjzyj2000@gmail.com, jhack@hpe.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 9/9] RDMA/rxe: Protect pending send packets
Message-ID: <ZMmNsnJeyGcTeNNp@nvidia.com>
References: <20230721205021.5394-1-rpearsonhpe@gmail.com>
 <20230721205021.5394-10-rpearsonhpe@gmail.com>
 <ZMf6xkpicBpXr/B9@nvidia.com>
 <1ee51a2d-3015-3204-33e3-cfcfaac0d80e@gmail.com>
 <ZMf+ILKLjW+09Hhm@nvidia.com>
 <3156272e-91e9-8253-e09d-8a93af3f3258@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3156272e-91e9-8253-e09d-8a93af3f3258@gmail.com>
X-ClientProxiedBy: CH2PR10CA0001.namprd10.prod.outlook.com
 (2603:10b6:610:4c::11) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5308:EE_
X-MS-Office365-Filtering-Correlation-Id: f6e16875-38a5-4139-b877-08db92e29857
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tqb4B9lI7Od2ZhafuzOWK5ua35RY1qcwRyzhWU9EvEVoLQow5UsgR+Wj3/MCtIn4taMGPRMAxAndg8o5kruDM/t+GTP4QQPA6WuUo6mYMjwJP3LwOyi+Cgm3mtqY1gI1pA5AbXIBv9TtaFiLfJL7/IE+jyzcMMpowzRqBN8uFy26IDv3odHP/xrWdPc2gcRqGG6JlJ83QTT4wfJbFCvOXX0Ta6IUyIt43qIhpT77P9xhDz7owV3Ig4oUvnNLt0Lsscia2jWXniIPSzN4Ip1tKApcyozq1Vgg16Z4+15yN+z8a5EcxqOIkx7KdC/2munKBIKNuyFb0BO9+9HYDC9YsDk440VPyIwGK6xtkTPuA1TnUJv5CsKK1tZCzkVKPJw01trDvDwggzlxH+yQLqjtSYUHOBL0BD8vE9vEgXe+Yc2C+BVH8V0516DaJQJzl2nvMFtsQnpbWAASXxCTowV68IRiFllovD3m7H08nBGlAqAgjngEEagFWpB+Kwm/8ZtEWk9qE8FXk1TXOfKOYf+TzWcEPICNrOjFgG9IOFrDFzG1qdPqG1vskLBZ+b/EjA/h
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(451199021)(2616005)(186003)(36756003)(6512007)(316002)(86362001)(478600001)(38100700002)(66946007)(66556008)(66476007)(6486002)(4326008)(6916009)(53546011)(6506007)(41300700001)(26005)(8676002)(5660300002)(8936002)(2906002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ULGfgKRMjKN2Y/w99b/dOGPyYhGxTMgka2BDH3qdESQu3JA6UJXDdp098rqp?=
 =?us-ascii?Q?HBIkn9bfBEVDaI6+CtKsEPrrsvFVH+doIm3DKuXkALT6lraOC1S6QgN/Bkhc?=
 =?us-ascii?Q?YCe84QOlmdTUYaNJ5R0uEVx3j3qn+rWnGDwOCu2IbUM9+nEZEXvT6OrageAV?=
 =?us-ascii?Q?DxPKeiGyow1x1SKGqUlqaCcVap7mn20x+NUDTLWoWwDbUvvwERDXz9+dOB2w?=
 =?us-ascii?Q?9b3u1yPSwDkxraFcRqFItt1qnfQ/P+AjGTBNQAPf4oNFtzUp/SHkJfduYbuR?=
 =?us-ascii?Q?mpT2PWns9ds6QuBAo1RKoqUKFuHK2c3kEZzkx6M079sqXku0MeORggLd6tgT?=
 =?us-ascii?Q?JXR4DhTGY/hna6kAmcuBm7PhmLYimofQsl+HkmBMIrfw6x/fzhW8ygbZ8SSs?=
 =?us-ascii?Q?gpvjmexUpbWBSpzCBdglwhXv8T6ZUc94hx9e5Sw6FjAgdeCZMFnhcrlNRE92?=
 =?us-ascii?Q?kXYSjCvUVXq5bzp68iW4m63hSVmc2ZswHC55GxZUmLi3gcY+5ztSAECIv6Kc?=
 =?us-ascii?Q?gN3cNyFOT5Yx+wERXEPboZQLjlwnXSbDRvp7tNGXNbiFnCEk3WFOtH+q/v0E?=
 =?us-ascii?Q?2H23LuxkcxrNq4bHmf2t8/hXGW78W3511T1p0B4DK/ePyxtrITTLi4Laq5EN?=
 =?us-ascii?Q?p3gf44WFAiYe8YnX+nAXBmER11Jr+yBfB3DakCob+cUF/JRa9H8Xyth9njL6?=
 =?us-ascii?Q?1bnetWC0t7PfNCUsaDDahLLV3Vhfp3T/NS/xghFI0TMIDLJ2IDGMNKEVkTP/?=
 =?us-ascii?Q?uQZH8ove3tAm+av59kcXSJAcEZfJE1ZD3BQNnPnebkVOQXGB3RZmFYv2vC10?=
 =?us-ascii?Q?mCWTqNdNVAEfHahklOqEl80kVNn6bPDkiqxQnwogtz2nE0vlnwFtxt7//suD?=
 =?us-ascii?Q?/lme5Ni7/zoQrkoiTA3QPdPIRiVd7NfF61894WjfV5HBiyeb4XL2DKLJXTuk?=
 =?us-ascii?Q?J1CHBwAx5VsQoBM89vNzeLf7XDKc6Xs0k8WOijY8KXD7eJH+ILvWuEycr+IS?=
 =?us-ascii?Q?9KQbtI2qTtFlIsKf7gcArd3jfvYA78rgpDRUPld+jssC3UMRwknHgHL+jS90?=
 =?us-ascii?Q?NygbEF5gAYR3A3Qa+MpCvu5Icso1fGyHmbo8Ct1OjSLjvYm40dTBrQAVJkXZ?=
 =?us-ascii?Q?ky7Rzj562u/zMtPdkImK4Ta5mfnxTJmPmlqXaOq/hvEyASu96+A1DwR+XgoX?=
 =?us-ascii?Q?tlNfJU79ypwNZxUaa71p3A/nLNHGDunxZrhq/I9sxMS7UfFkxrnpH/YkBkNA?=
 =?us-ascii?Q?nXEN14boHgAVwAIbu0kGLGrtFeA7YfTrtppKVLitNqMmVmzWoGKooIFcjFHG?=
 =?us-ascii?Q?lvv2g0k2283ngz2OYYnO7+m/6NY0u8i3IEZlHGCuNy6i7a+LpMSiaRuqtkm2?=
 =?us-ascii?Q?TToD4I+ReDqfEyokrPVVZWFahHAtSnRzRTlaRyc31+H2TmK5E/PqjItOhry0?=
 =?us-ascii?Q?GjrcVZQtkVgutBQhRZHOtjv0cK5fRVNpAPgzTyfK7DFFHvx86VnbVyOfC01P?=
 =?us-ascii?Q?pW2CKCcqw9IbqtkZwB7QTX8Y7a1B/jofHlS/3oFo8AAlSD54JX6sDYzHG8bb?=
 =?us-ascii?Q?wiYxOGAagMTG9MtK4VPEYclNT3KEB86KL57ESHyu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e16875-38a5-4139-b877-08db92e29857
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 22:56:52.1859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /69ed12Mpnxy/EvdX8Yv9OnqQg1e7W7ipCBY/eKnfM9YywrI9u6lrOKkXqs5MJiJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5308
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 31, 2023 at 01:44:47PM -0500, Bob Pearson wrote:
> On 7/31/23 13:32, Jason Gunthorpe wrote:
> > On Mon, Jul 31, 2023 at 01:26:23PM -0500, Bob Pearson wrote:
> >> On 7/31/23 13:17, Jason Gunthorpe wrote:
> >>> On Fri, Jul 21, 2023 at 03:50:22PM -0500, Bob Pearson wrote:
> >>>> Network interruptions may cause long delays in the processing of
> >>>> send packets during which time the rxe driver may be unloaded.
> >>>> This will cause seg faults when the packet is ultimately freed as
> >>>> it calls the destructor function in the rxe driver. This has been
> >>>> observed in cable pull fail over fail back testing.
> >>>
> >>> No, module reference counts are only for code that is touching
> >>> function pointers.
> >>
> >> this is exactly the case here. it is the skb destructor function that
> >> is carried by the skb.
> > 
> > It can't possibly call it correctly without also having the rxe
> > ib_device reference too though??
> 
> Nope. This was causing seg faults in testing when there was a long network
> hang and the admin tried to reload the rxe driver. The skb code doesn't care
> about the ib device at all.

I don't get it, there aren't globals in rxe, so WTF is it doing if it
isn't somehow tracing back to memory that is under the ib_device
lifetime?

Jason
