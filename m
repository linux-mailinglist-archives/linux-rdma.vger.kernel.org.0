Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA5C56572E
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Jul 2022 15:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiGDNbN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Jul 2022 09:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234667AbiGDNaw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Jul 2022 09:30:52 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2080.outbound.protection.outlook.com [40.107.101.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE19DA1
        for <linux-rdma@vger.kernel.org>; Mon,  4 Jul 2022 06:24:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UWTFLeZ2DMd8/57/5AdOCmgWltoxHjmKaUp7fvuovbkY22DySd27fjDXGosDOaCrKbn2EhvXb3j5QZRt2FhBqoz4Q2mv7oUrrdrgRy+nAZNB9UNrz+tZUxcEbHje+RjLqaZNeDle/GBqRlhbrnJPOqyq88USbesrsGwoCc35CHr3GWL4VfJTiVJZYM6+4Bg+SIxjgjLI3iSpCjbNQdVswJQHakIeyvY+HpRiiMyN8fZ0fbmW4owq2LQuuWm2Yi79H4m047X1PFRxlmlCt8dvlZNzkb0JEQL5XqeyV/h7zExMMvCw4VZaCFtSqT9nbcWOeq7IqnY6Y+GS7pgWBkh/3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=au1h/A3OV35wdechCK6/nfn1an04bw/9amEgHI9afZQ=;
 b=PY0imUFm/Bz/4158wJkEXTZEL2RUvBL/UGsdxeR2ftmSFjDhbQmy9eLLvRMZ/Mc+e9ruBH90Mav7KMJzufzSdw3KtKW0uuFEARAzHb7KD0SAPzv2ErGmiAvOGnwnb2VZRfctlxIOaEQfqiHFnw7B5YUqKO3/7GKv3f+OxSI0SyfJUWB4PUToNQTC1k7lEuGqsPAuUHxV9cEYn7T6LyKh7bSxynSreVtqF/cIWJ8aQptcK/12fwE/fT2VPJw5oDagKaxrq1UN3Gddo/y63b2ZjbFb0SR+Kyrp1l7PrXU9AMVQCMW9G/lLvj4HjrvwpWMGdFBAPLvr/lc0IdnaNzFdyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=au1h/A3OV35wdechCK6/nfn1an04bw/9amEgHI9afZQ=;
 b=TIqah/TbP8fGSNErnGn1auL/IUI2cpqfG3kT7wMY7SAgx6iV3LCqtvxNNdVMsUUj7OwRTDKXkEO4dpgEYXgI4VCDXyPzqsoppJ/CBjfgUKqxui0F0vT0JFhkgfuIbC5ulcP1g7QsXDqG3uiKOfFC1rSkaZakDwou60peTJoB5LnyDFkx3OkoUoDWy+G2i00GC7J90TQDnR/oT2lJP2VFrRLNC7QCaYoEpkBSMWGxMcerN+svQmfzptgVAzR8jKg3VxoIKwcYZ/Ouvr+8G5iO2QZ1EK+KKW85CeKXVdOVsvFUjNnBr9Z+05kFvMdexNgw5F+osxNuJjba1EQwiOEiQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN2PR12MB3614.namprd12.prod.outlook.com (2603:10b6:208:c6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Mon, 4 Jul
 2022 13:24:51 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb%3]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 13:24:51 +0000
Date:   Mon, 4 Jul 2022 10:24:50 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     edwards@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-rdma-core v2] pyverbs: Fix wrong rkey in
 test_qp_ex_rc_bind_mw
Message-ID: <20220704132450.GA1420265@nvidia.com>
References: <20220519155810.28803-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519155810.28803-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BL1PR13CA0327.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::32) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2734f733-85e1-4b8e-aad2-08da5dc0930d
X-MS-TrafficTypeDiagnostic: MN2PR12MB3614:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tBktCZ2wSJmAt71qmg6MASenvEqcCGSrgyYumkrge0wl62Ya1OpmWiJGWXkw/GIwNWqQmAlEtIGtchTtPtlUKigsZ2IVLfxY7R/ZmNyEdvU3azGtBohwsx3km4i52HshkQlOouhSUglJNwl7svGaj+0V8RySpVVED2ynKVbQnaHoeQbtwvIwG8p9Ru9ofyOC/CaCVn/nMe/CDSB8LA04lvtdjCsPSq1Z9rMLJs5KMzOgMLy6X7U2aiyPZy0YQ8Ghkpmx5Pt4m6tYHk7QsMXtwtd6y1ytlmJEY5sAFQOzJiM3wik5Ij10O6tkhhS8bi6ArRqJW3CDynRmUL7bhQxZpn0pHCBlO4JKJWylYqatOs66RQSpzFIboEhQX/52LPnksCA7yzcVDfQC5pp+SrsO2aErEHoacUnaqa9bG/RaOhI2WnHskkWv+gMizGkmPbWtk28KgPRyI+hBCY6k5PiiDfEIbaPoF4VpSHNwoLzOwn6ZwxRKYZbX44Uu4FCUe7iEEqZes37Lpg7rtlQPqSIUi9M1pLYTHVME71pbvEmDpQHT04Xn75skYrHeUVgRgKRVs3ysYHyEPSJvn1abHh29wGm91xxIUnwVt0lsfB5CKD/HK0r7d2/vKDUHNpOSyP7lm+oytfnfXBSWJbSgsAsCAqolXaSE50Rex9U8MTXByLg0UiJbVn3SbC3OJqgptd2B/yy6C8rEwQ3EGbCFU1wQOs4ODcv1tUnH0cUKPtpa71keg3bWDx38syx/VMSsPB3xF2cAg2AOeaTXJCtekMRqiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(366004)(396003)(39860400002)(346002)(83380400001)(186003)(1076003)(36756003)(41300700001)(38100700002)(66946007)(316002)(6916009)(478600001)(6486002)(66476007)(6512007)(2616005)(86362001)(8676002)(6506007)(8936002)(4326008)(2906002)(5660300002)(66556008)(26005)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ogqB2xqc1UiLzcBpq7MKUR/z3CJWgvxNPeikByBIIlMquz59bTMMdort7rJS?=
 =?us-ascii?Q?PmOLo47ewoXMjgSGi7uiGK+RKbHl0bMYjnR3UTlrnnUl8igFtjeoiiIOB81M?=
 =?us-ascii?Q?K1WgwzTxD/5n5ItA6Xn8et5NwukFWfEZGEPCQfzhp4J6H3Yx/QmzNYe0++4K?=
 =?us-ascii?Q?BzNE0pyBkpjSPROySwW10EbWWysCYqLw3DZzcQT0DNXmQotimPwAay75K+qH?=
 =?us-ascii?Q?HAaGVvwrbX6Zw/uDAyChZV7d8Kkbkss3a38Y8r8wbx6Ga2N7j+P1tiBbPFjk?=
 =?us-ascii?Q?gRrW/JsM43eqdmGrZ8YToWupn8b0ZGwFPLxp8wyfdZ2wLolgWnXdjGFL2xC0?=
 =?us-ascii?Q?JoPBFPXEXwk/ekAZHG9PS4H0dAej4fwneyLM/Rv31RIzU9Ld8HBJdnI870RU?=
 =?us-ascii?Q?/0Y+xzWMJeqy7kdu5cXoV4IkY07So+gG4KzIqfQ8ZNCWUjydDzzroYxsCHT3?=
 =?us-ascii?Q?4YnjUm8X24o/I6yeNCbWPg/AWH9O6wT49wUn2bhWNDiwsjF5tLva3EhsP6ju?=
 =?us-ascii?Q?MZ8bPnYcVECeYuAKBbuTbEBg3wgU/aedpCu3qQonSR+foeWLdswdhSeYhEDZ?=
 =?us-ascii?Q?ogwKTIAYQruOFGyz9r0WYBEOLj4nXFWYKd8QSzfdz0/5CPfImsU3Txq0IkQo?=
 =?us-ascii?Q?mJ6Y7fk/rDkdwkpiDEP6wKTFvntRf8aNnL9mkkJqBQ3XtWujclnfzFagf4NV?=
 =?us-ascii?Q?uKj7oIlruSP6h3fWZqjrYEYSXg/znx7OUU5BdM62lzcJqnIEMiSye5dNggON?=
 =?us-ascii?Q?zYDohE4n9AwXAoazOmDHuKyf1+KBQKlFFkD9paMyxCnhXaInMJjCjIe0AOze?=
 =?us-ascii?Q?tqFEBm4o7lkGACAsFJI/i7Fc0f7EJhztHowHgy5V3VoR192vPFJhhiii9gmp?=
 =?us-ascii?Q?ZUie+9eMwg8895vAVKb5QHSAg0BN8qAcYOwhFExqur1QZ33epFa96rRDepFy?=
 =?us-ascii?Q?9K75J6Q/+4ElMYRfXZ57BRw9TsyOjNlH5omqrduzruwTITNCLXexKBSGrJJ8?=
 =?us-ascii?Q?9/ysAkLv0vNVdp0McLZGrEZU5YpWFsNiLQXPz1z6ZDk0EadZtvc4OyVT0fd+?=
 =?us-ascii?Q?xPvDzT3fWcnM9/DZsD7D7yAFGLM4cma4FhJQslJzpBS1k8Url+6MeC+iCjN/?=
 =?us-ascii?Q?3e1ejktL5pAPh7SWliCu5wSfNz9+SU1Y+bKG0ji6OZuB2Exm4pHdUcG/hQWW?=
 =?us-ascii?Q?FtSBNRWXNcD8KZLdphZMWU0f7lXoda4PMgXrgppHLE3ZUwhinvMpTVlxTeiu?=
 =?us-ascii?Q?9ujMVEuASGqBF8RmN9mTpHlEZGKORYUMzjPNfA/FF1Jl2IYSoXe/fu/R470K?=
 =?us-ascii?Q?B8aw0OUmU6Fq+LJf2rRyoC+r4kehhfLt1tFhL6sBErW7xRDnTKzuC6SxkQEj?=
 =?us-ascii?Q?QeWwCFxsN/gIH5TshI+fVeBteem3DAf3fYP3TZiY1ivQrmgb8SrjMcMOSvKj?=
 =?us-ascii?Q?Lj1fAJY31rkPZLN3Q8X+xCJWemzL66nVl86RplJ5ivEe7G7XA1MqnlsCyP4e?=
 =?us-ascii?Q?oudA6StUHI79pYUxeyl/2rEqSsCdNaCeTlW1fwk3o0xgAYPAokJGYgdA2mQo?=
 =?us-ascii?Q?1J3Qcu3grQID2k/h0KEWFUZ8K8/HmAyCtlpSfjb+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2734f733-85e1-4b8e-aad2-08da5dc0930d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 13:24:50.9690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eXXNtD3ekLmyH9x/3mkMXzenSi//sLA8z9NhjXjqi4yGsQToiQD9atEO0nAKAy7c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3614
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 19, 2022 at 10:58:11AM -0500, Bob Pearson wrote:
> The current test_qp_ex_rc_bind_mw in tests/test_qpex.py uses an incorrect
> value for the new_rkey based on the old mr.rkey. This patch fixes that
> behavior by basing the new rkey on the old mw.rkey instead.
> 
> Before this patch the test will fail for the rxe driver about 1 in 256
> tries since randomly that is the freguency of new_rkeys which have the
> same 8 bit key portion as the current mw which is not allowed. With
> this patch those errors do not occur.

While this patch seems correct, I don't understand these remarks.

IBA says:

 After the bind operation completes, the R_Key must consist of the 24
 bit index associated with the Type 2 Memory Window and the 8 bit key
 supplied by the Con- sumer in the Post Send Bind Memory Window Work
 Request.

Meaning the bind should only be processing the lower variant bits in
the first place, and there should be no condition where the bind could
fail since all varient bits are always legal.

Bind does not allow changing the upper fixed bit - only allocation can
change those. So if rxe kernel side is changing the upper bits it is
also buggy. IMHO it would be appropriate to fail the operation if
given rkey has unmatched upper bits.

Jason
