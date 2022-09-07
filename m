Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21B65B05BA
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Sep 2022 15:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiIGNvw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Sep 2022 09:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiIGNvm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Sep 2022 09:51:42 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67630A59B5
        for <linux-rdma@vger.kernel.org>; Wed,  7 Sep 2022 06:51:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOvctKbWEKylBLbZg2yNXIUudpVVnzQBkqFhA833AyGoAwAiAIlmS+feqxsWooqv7JVD2c4NKjMnTOyd2CQMVCA4MGxnElXf9zCAbVx5yybiyCC2wHb84IyDrLB8p9vRHkJokfeXwoaVNqqQ5rdbL3dLoJhMY8GzbcyVioo/UmRfNF3PXuR/7a/hBYaWQVM02U5g3QL80knH3p0a7MnW58LoSPb+90r60yu9H2FjXK/YuvNThLrYIoqqlKGfI19H0hwOrq1asPBFPPJKWV3vTzh4ASp14frViWtWN1AhSX8dGfThoSm0q0CI5Sd3BCqgapR120kgw1qcGUL4nxmxoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mt/mgdab0PbsrkGlA9rY7S9BDj2SPhQ0UbGXSm6CApY=;
 b=MXDuSbYLbf9y5jyhRKGNwDnDqpWI++yDa6N/STIIQzoDVt9lJvLhsNM/eSY5Ga6kq9EpPF3pbomrm0y/fSLciXjAQ3Bhbp5RSdY/WjLOi2r7iNrZBejANaAjlASMqlOLzoY+jZJgY81kGLBwaoeSQyPhTs+0QUWs1OfVS1CpAoZ5Ksne1u6OrbZoubbfDWCFFGxZ7CF31/gPx6NDY/UtoUuftyanKYm0yICaAtIp6tW93noj3b5qPl2190rK/5gVfW0X9W6xClwBWfzhnEz63jedh5GJxUhAH1xh4k/kx4jNXj9ps10iS7zWwL3sF3NqgEVvdgTe0Bx+cbUe9vwo0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mt/mgdab0PbsrkGlA9rY7S9BDj2SPhQ0UbGXSm6CApY=;
 b=FbhIwsJ8Z8vWJ4Gx18d9xNZFZ4wk33m05nC+ttWRekXAY5HopeDrrfIE+S1uHQ7uk6mbo+QELheKpo08AWmaPDRZzFro6peYQ4p5yVeZRfHzdky72eqIux0vDJ3+K+Zkm9GB+FPZi9Ei2eemsfBcUfQFRVXUTA98oHiCSanldm6J8kFcqp2lxW7QJWMOofIy2gpGa9EgVRaj7ETnav6u/q9DK+w/QuzUFKhnpTHEGEjeKVN1kOxtiQEQXSBE0m11Dps7kVe/pvlcucgQxktaTNsugmiGwh7j3waLPvKBxkBoM7qXProL1BYQNKqB6nQyCcLT4G+t6bhireMVjTi+FQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DS7PR12MB5959.namprd12.prod.outlook.com (2603:10b6:8:7e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Wed, 7 Sep
 2022 13:51:25 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5588.018; Wed, 7 Sep 2022
 13:51:25 +0000
Date:   Wed, 7 Sep 2022 10:51:24 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tom Talpey <tom@talpey.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] Add missing ib_uverbs dependency from SoftiWARP
Message-ID: <Yxih3M3rym7Abt0P@nvidia.com>
References: <4e7574d7-960f-9f92-e92f-630287f1903f@talpey.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e7574d7-960f-9f92-e92f-630287f1903f@talpey.com>
X-ClientProxiedBy: MN2PR02CA0022.namprd02.prod.outlook.com
 (2603:10b6:208:fc::35) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eea72b56-6478-42de-1785-08da90d80e1e
X-MS-TrafficTypeDiagnostic: DS7PR12MB5959:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oaiDRHSVsWVtYud4Q3uY5YanMQfmrfntN0TRsNG0yqW151U/RNDpAaoVY09rw1zfvgFJbFxu6KIzFxGrko/jX7bIV2J+B2Nx3ixT1SG/VeukRLLLQftvCUd7N/RFHDR5K0KN4Qj09EoNiozPtcJf7o9J+maI5JIjAxqRea3fnlN/JBQvi9TCBWeSstWIKjSqo+/fJdH2HOUXLu9QhVjTg5MSAFbEN8g6MlieO1dJjdB2W2RmUTomWumLDM8Pe5ZUd9TTg0befGkcOKmCIu2yS4TuDb2kPoTzoGrrpIvyXMw2U2eiB8Lg5Vn9hb/NsfVuHKaLQ4miw7q4jcc3W6Sxk6CvIm5XMI3eg79u3SIOEtzj5JtHfLJ1anfErrvlH8ohKhRlFsdWBCZ6mvL/s1GQmIpl1b98RB4L06fRgjN5ytWrJBOB/zmNFNg4QCOP1ChID4qlLDTE06KNB9LGhfBHBfMEkGHjZeZ1mMUpTdpEWzdkQ18jgfZI8z52Qbl9jL8r+a9IJEq2eC+od1i7Dz7eELiZlS15IGkCN4+EwsTwvEuKND9b5nwWt3MwBL9fc840/LqKrEeDIqXef2Z/XMQMFqZbsKRaIUsuel4ZKraYiXbEe16Q5Mph1OOcu9oSBD7liwmvTGiTy7vc2EvOsBPhQf2vNkzE3spvSS1uljR9mkh6z1QcUS1e3COWwrmxImaY1l0EUct9kzGX1YHMiimnlw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(136003)(396003)(39860400002)(366004)(38100700002)(2616005)(54906003)(6916009)(186003)(36756003)(316002)(8676002)(66946007)(6486002)(6506007)(478600001)(66476007)(4326008)(6512007)(66556008)(86362001)(5660300002)(8936002)(4744005)(83380400001)(2906002)(26005)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xis5IXCEk/GhEuk6Oyfop5KHcyO3AvO9ZXQluT6C5xWcbut6pdQXUTioDoYe?=
 =?us-ascii?Q?ItLaKUcfTb7bTgK5yDK2dk5aNuo44kAYNthj//gxdqmSHJArbpoW8OTsZby+?=
 =?us-ascii?Q?iUzKUl+S5Kgy/Zmcfjnknk1pJt+xMh1YoLM+AzbNePWsysSgd7too87RxfgD?=
 =?us-ascii?Q?GjXhDv6jg5kbE1WyetuyaTTjaE9voy7dV5OstRzLYpkah33gcZq9sNADM5W8?=
 =?us-ascii?Q?k2Ul15U2HpyIasSJWsCg2kWM91iNKZ0sYsKRczzVXCojXCBkiRxJ88ChyN4z?=
 =?us-ascii?Q?CqAjHOzxNKewcVfvIngM6rJPohUBMRm0z5iD+jmQXuv+EQyYAnTC3t17QjQJ?=
 =?us-ascii?Q?QY9k/IOdKW+P83j4LcV2BaKbep2htzCVnqwjmGzbGwIzLhim1yHveIcnwqHX?=
 =?us-ascii?Q?Fkn6/UcKAgItJlCdyvLGr+gEDiCY1ue82R94ZROrht9StizIvWqKQ3e3IRC8?=
 =?us-ascii?Q?rA0AoIEviCT6xZsrJ8LCEDHXxPNveJg13hhCQwmTk/q3d+hT4Uz3yNm85cxc?=
 =?us-ascii?Q?FGKG43ow4k2uXCLGnukO/mfp6DinecgH4RCno+BS8VdVGyjmDUqSpQIHpkde?=
 =?us-ascii?Q?8XDX9Zzb3qz+kygjewYpDEf53Y5FCY367KR3xyhP/BoShG5mPeAI0HLYfIJI?=
 =?us-ascii?Q?DUzQXGX1E4iuUioopE/tTtaNdjsiNgozhZ/3D1PuwT9lovkzq7pGoNT8V+4s?=
 =?us-ascii?Q?LQ64bWYnGI7n6EJabe9SZAc23W0UbvrYnubuu6Y86cwpzfibmm7qSWfclvi8?=
 =?us-ascii?Q?3N1HDLm8srA92MGh7AaElFlYdqN5zBwJN+MjS4yJwFwn1iewUzDGOut4aPk8?=
 =?us-ascii?Q?Rw7DUnZ29zFyqgep/K+rOVQI8BfMaFN8RF8r+ni3GyeFL1kuq6jzgmOxmAq9?=
 =?us-ascii?Q?Vbq9Y8EGuMX9W8zBEAFBwZ13KJMtbAx7uFz2lO8D1zc4fRckTrrYqAJuT4AV?=
 =?us-ascii?Q?J9iQftsthbab9oNymo+YyUpJUUkCuQbBlNjNiAuyqKo1uwo5cyRsM1U1gzVD?=
 =?us-ascii?Q?mLLh9b3BsSsrv9k6ZEdCLzpJ4voksyCwMaAYqy8c1n6RPx3QFiVUBWnbbD5B?=
 =?us-ascii?Q?Wqs/SI5r97KbCFffHu8PPGqbx/MIKJ4PKWYfIWlHc3mee4gUo1vlBZSaeMtD?=
 =?us-ascii?Q?jKykIWqS4eeKPEyi1g4J7M6LCbcsse2moN3sNCCXmlyIW2uSVveif7qTjlSV?=
 =?us-ascii?Q?ycb5LWncC7DPhqIsMzLEX05KFNmjgrvZZ2kxtp+kIHhYU1UnTq1UIEyFnwu4?=
 =?us-ascii?Q?4BEe8lmvPBDNXGyZZCnvyxAkJvSCqLOH8zXm80fA/IRfChtuqfMR4TnDICoh?=
 =?us-ascii?Q?Tw0rTNAaej1p8UnC7nVLmj3VI1AM2QgAkpfQ5CgtFB0rqLqmfCbJX6IOfSnZ?=
 =?us-ascii?Q?jfb7cnoB3JFtrdYJ+HmSxbiox79jHwMWbiLiPni47wRVQgSC0/ImoLOITfQj?=
 =?us-ascii?Q?FDKrWMcStnn1bPu0yL0cMnhwpEEHXv0FvehTnw3fZvJkmYxTFiH9rE+sot8W?=
 =?us-ascii?Q?Kjz+YdLNLN1MhpHAsDzcZz2o4YMXv5xjGkB7eZE7Wr7f7+WZ2b/hoJp6ZpcL?=
 =?us-ascii?Q?c3H5Hs0s53PSAIQaXUr6QtsjKelr08mjvHDZx7S9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eea72b56-6478-42de-1785-08da90d80e1e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 13:51:25.1785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0jZH9KdLbRoCZbdqLKOCfVzaDKGhoAclXQMe2hglITLV9+bmI2MoG4rWfQkNBK2+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5959
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 07, 2022 at 09:45:07AM -0400, Tom Talpey wrote:
> When loading the siw module, ib_uverbs is needed so that consumers may
> access it. However, siw references only inline functions in ib_uverbs.h,
> so the kernel linker can not detect this, and the module is not loaded
> automatically. Add a module dependency to ensure ib_uverbs is present.

No, that is not how things work.

Modern rdma-core will auto-load uverbs when something uses it, we
shouldn't have things like this.

Jason
