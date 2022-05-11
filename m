Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6AD6523CEA
	for <lists+linux-rdma@lfdr.de>; Wed, 11 May 2022 20:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346487AbiEKSy5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 May 2022 14:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbiEKSy4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 May 2022 14:54:56 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FAB1FD86E
        for <linux-rdma@vger.kernel.org>; Wed, 11 May 2022 11:54:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=evix4yLF1fq6bOkqt8TpJeXgCaVUmmd8+QfBo0BCb2IAVNl6ptUO/QzueEQIpQY4lF2o0NwBclFPvcCME5pyccZ+frz6xvGZFUCbVg1bmLQXmYh4QOfYxmc0G8lVrmAFhLNHzbaLLaCv2baeL/Y586+9TPw73cWm7ENdegf8c8cEwYNgoZIzFzH1h/18dciYJipWl2fWKsjH+NHxqePMrAwz5Q2437NmjvgLHSB+Z3vEbqMnrj9QprowDSnE2MIlPCmN1V33Ec5AsxmK9cS3Vh0GnCrTims80LVFriVSTDp2qSmEeDdPRWvW5av76arc348G7NHwuYBWi5vC/6HJ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JkHlA/Azd1VxHj2lOL7aOc4kHFo9uEijKHqdUF8cJoI=;
 b=LYGomMIlTMMPjko1cYWavU9aKWLQNg0OgxueqG6GRAA1Ua6CmWBoM4AuMHnf4gBhB0quv8RmaXGObMuDCcgRJXWzVL1N5n0wW6tWtVgJwiRaaQ8+mpUJUNxV+2AHRFGeV3BoyjkLtIufKNc+D5myAwYGo6P5qsCbNT5OO2XGqA9o6BUP4Mc18nLKMrsWm56Uey6vCJYXDAC0icKKb/mi5zzgrS57GSHisEqLFdKH9XNYmfkIhO8bHyDF9rj9wsnzqfmiEh27hlPNPzO/0yrJelqdcCASHCYqswqJHrhzEJyYINiZ4dvmL3loykOa9OQdA0h6Ik+MtTh8Uuy9XcE4DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JkHlA/Azd1VxHj2lOL7aOc4kHFo9uEijKHqdUF8cJoI=;
 b=M2TN8pFT5knN4Y69aIhQA4aoG5YiEXmhbAx1jjqQEl70koEnyj7MlJRuX67EXqSocRt197Wui46GXL8ts/A8M6PrPbZUx2WbuXh4Q/ccEuTIqXuurmJA9VOI15ET8g0+hUzJA0+/mkZbOwVPejhrwG/TTJ5AMIjelNQtSKCbvdcQFlvQcx+KdFTZ8HqLcQmT68REPosJn4VhHTeXcdXPIVd6+wIEyHequTOxv4Tds2doJnMqKukbOcMXCiCCAaqhdyU7dxB4n7+VZ+h1pHazmCt2wzUn9x+cKg4PoPqmni8UpBoz1QEcrEu0QOGG5fOYZiPH2lnT/nJ5pBun3AHZHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN6PR12MB1121.namprd12.prod.outlook.com (2603:10b6:404:1c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Wed, 11 May
 2022 18:54:54 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5250.013; Wed, 11 May 2022
 18:54:54 +0000
Date:   Wed, 11 May 2022 15:54:53 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, chuck.lever@oracle.com,
        leonro@nvidia.com
Subject: Re: [PATCH] RDMA/siw: Enable siw on tunnel devices.
Message-ID: <20220511185453.GA1256916@nvidia.com>
References: <20220510143917.23735-1-bmt@zurich.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510143917.23735-1-bmt@zurich.ibm.com>
X-ClientProxiedBy: BL0PR02CA0142.namprd02.prod.outlook.com
 (2603:10b6:208:35::47) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 195fbc9b-27c7-41f0-4b9a-08da337fbca6
X-MS-TrafficTypeDiagnostic: BN6PR12MB1121:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1121E1FB795ABEC704F39685C2C89@BN6PR12MB1121.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Aw6Qnr3oSG3PjvT+2QwP4GERnMOOYr6wkfZT+CESmc8cFx1tCyvZWv8hbraloExOGbHoax68PKUHtre40ngDxcPHO6EsrRdao5UFQNefXrzM5x+rO1/ZfUVslCxovJQhY3sCd75JkKQV4xckQSSf/LiP7r9jK3ZMjcQvWWhiWErYQTDe15ENrwtflbizLTH5XOAgW6rMCEsH3dP8s5hxqr84eXup/LtRXp5s0OkI5O4YWf4s619oQouYpmZHwmm0NG8JwlQbyANbciuZlhJfhlel41WHSqM1YBJpszSgiYiA0xgMLAKkQ0cZ/7jfQbiRJRse9G1Rv7LBXL91XMolCCs4J+N+M5xeZkopdp2C6sQh+Uj4B0GLrv442v/vt2rxoe+E8Qg5t5DJ1gHt/7/eKnda9/V18UNUTkOKRGtC9kJJERaPXAdXhrlApItqMuYd9CFNDZjqwlvnn1SCHSLR4bG+Ily1bD5Uss+IAnDldCHXfoD4u7WZYR2lOC3tbYzOQPaGWgT3WTuY+McC2jQKiH8OxCwBvVvQaMMEfg0z4APnsuD2L8CnK2Cg+MGybc2YPIIyWXwApvc+Ckw7+Xl6IVUyu+byLJBnqbVw4mc0FX7v8V8sJqljur3kiX8k6yjanBml41pY0nChryXzlV1mng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(83380400001)(508600001)(2906002)(6512007)(33656002)(26005)(186003)(5660300002)(4744005)(1076003)(2616005)(86362001)(6506007)(8936002)(36756003)(4326008)(8676002)(107886003)(6916009)(38100700002)(66476007)(66556008)(66946007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RfPs7H61VSnluqvXi+m0OGIIm/v1uKIOUQskru1WNDcFwki4ua2pYamTB8NG?=
 =?us-ascii?Q?pCCQELK3zcRQndeO+yp/2COfrl8sBrpiqTMz/zY5qmDMWlkWmZwbEHlgVThK?=
 =?us-ascii?Q?OLTPTnH3hz5GR4vlqs9n50U7ax18KtSEcG5cyHeRQuW4ik7E0Mw3mwv+1FiQ?=
 =?us-ascii?Q?Szb2G0NhhDJydOqUxvcpZTr4tD4NdSQOANhFUS/1guJ/7z6shlYtdbDabZmU?=
 =?us-ascii?Q?Z+mopzDdGIIN1NpNS9PMdcl2CP6kIg+zcZfg/9iPrAg+E8fGt5El7lK/ooO2?=
 =?us-ascii?Q?NxN6ET16CoY9KjshBnirzCEAzTsY4j5NSCIt2lIFEd4MUex29piGZHiO19Sy?=
 =?us-ascii?Q?j156H10TZcxSFoRtnWvVHRhpjn7CHqdzoPBSzTRfcFLuR2xp/M/vsYNKYdo3?=
 =?us-ascii?Q?W5pVUnylr5qF3YWE/pHmteJrAK1S0L4AOzSuhS6PPJ+hYY2I0KF5OQULFYaZ?=
 =?us-ascii?Q?JmWa5z8z99IX/xMPYn/fiPteIKjR9toSueu6G2EubhFfDk9Lr+jJ6ETZaPFi?=
 =?us-ascii?Q?7F/l0H8U/spi9nP+KGbZVKAMzopUSNFE1h4jKSMCHd3oWd4CHpH8ZFpmRexW?=
 =?us-ascii?Q?EOZHoOfKdesz3WrpFZU+xrAnV9xKJGRGn+MC+r2mWz9PaeUhRBebB7/0bg4t?=
 =?us-ascii?Q?SDBTbUJ+3zz4tIYMRAFvGd1thXKpJlpIWM9pW1t7vohjmWUvT/C7t2ohW3UU?=
 =?us-ascii?Q?lYe4V18sQF1dLJo3WqxJtz56nVUFcwLgRZnLvlakzmNXBsX2mbrc4a4vNTR3?=
 =?us-ascii?Q?U3HjagPOrATwoPOuRmX4i6bVUtXHd3TsdSVirKHfRtj2EeM3+jGQmaFXLDVJ?=
 =?us-ascii?Q?C5KYLXOp1J5QecEJyd3NbzTWJ0+z8e3CFS7LfWUWDUREU0c4ddPnU7RaB/UZ?=
 =?us-ascii?Q?pEWpgcz5hYVXmkCpcPaLcMUjE+SgoI5wRsBqHSofdG+p3vDkZji/qjV+XIvN?=
 =?us-ascii?Q?xNfVlZqBIRAgaFQATEbBAo13Yd93gpzJ7bpaH6AAd84VwK8WooqBrAumCpUN?=
 =?us-ascii?Q?ik5wezKinnnZP5VN5zgMVYHl4lzU4qMuLQsRwNSqpg08UiXd2gKw5ObkwzL/?=
 =?us-ascii?Q?HNTB2+X8oNGGYKQiweQ13/caWG+dAm4A3hoOeBZQIccopKuUXOWQcZ+8MlgP?=
 =?us-ascii?Q?K3vIVcYzYkMuFj1rGyd2cGxOfn7RweloYkkNaKzESXjcZUVy/JsumIEjAQkM?=
 =?us-ascii?Q?uuuxxE50AKTsWKhiFN9hH4nCbrBo4AdqkjhDSk9U9cyXi6Q3ofWXWWinZHqI?=
 =?us-ascii?Q?D8o9817PlqPa2V59OfWQ760EEG1AGxWzoOYAp4oVLlvZRMUN9QWcIVciJe7J?=
 =?us-ascii?Q?StntMPQbKC0Yg2mKooSCSnz0OHfCqlG9VFGkAUiPr0AWx+dLYXqwIxiTB8Xn?=
 =?us-ascii?Q?NFs7KwMgJvaDuiacoKNxSi1BAlwPdwW70lvZ8pIlI7K8HRzOexktorU4KoT2?=
 =?us-ascii?Q?nbdrlSkTBOtiPhRUTXrpZTjIOlI2QPfW3thHim/XpvdeUzRwXtvscT2xRG8f?=
 =?us-ascii?Q?/RL0zb30A76iKwQHFN5VGvm+wEKCp/rsa947gq4jQ/AMuHG2Vb979xBmrWCT?=
 =?us-ascii?Q?pzHGrmnfsgq03JIWGFWTn7t+VRW5ScA+xglIoBw4bMZ2mht2aPgp9EO5XUwA?=
 =?us-ascii?Q?6zMIJpNxrEQNG8rRpPCsmjifmLRY8ZX338IcRuvtvcMykRc+proId014/VOQ?=
 =?us-ascii?Q?CnMLGG8rwnjv9ttMtN1kOCpvQo8QxvD/3o5SiL4nZr3NjlQ7gwACRQSZkoHq?=
 =?us-ascii?Q?oUGBPgB91g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 195fbc9b-27c7-41f0-4b9a-08da337fbca6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 18:54:54.6318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dy8Ac2014Euyx375ibQmvQncVzy+2RD5gE9HZSCPvMKu+FeopgWf9Co9Il2GJgu7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1121
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 10, 2022 at 04:39:17PM +0200, Bernard Metzler wrote:
> Enable siw to attach to tunnel devices,
> 
> Tested-by: Chuck Lever <chuck.lever@oracle.com>
> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
> ---
>  drivers/infiniband/sw/siw/siw_main.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Applied to for-next, thanks

Jason
