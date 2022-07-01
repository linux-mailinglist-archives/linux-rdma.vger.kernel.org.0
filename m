Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CFD5627AB
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Jul 2022 02:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbiGAAUi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Jun 2022 20:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiGAAUh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Jun 2022 20:20:37 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2069.outbound.protection.outlook.com [40.107.101.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D6742A03
        for <linux-rdma@vger.kernel.org>; Thu, 30 Jun 2022 17:20:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6gf48DwTlJWQp8Lfd02AwqJUnsi9LYaRqbvCYNSx4bdjuarj9uwLvri3EooD72YWGwSjULa7o60mX0dnYuoKDb6Kyg782jE1CQYr3A30sefJi/lIZNJF1OU392RSXGlz8i8xB9cZMuMZJ12UzF1jYV1eAIux1qdkzkpkzLVhriFGS7ydLyF97cKV5sE8Dt0dL1bhvrSHlw4qyB/rQSq0qtGiXsApysJiPFDBupPvrRARLzxPI2h7FSODWCTTPdqNIlEHE4XQoi9E2K2wgV3VUVHarh9plpKDu0WXPpnGa3Hc3LVNqAJ9IcYLNQEALTzAKcn4CsP1GRycb/hKvy8Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kKkAbzHM5xdcOeptOMUoWYML2MpOHSvysbtBi50NOd8=;
 b=Pqn031NDDEWyLKC6DTO7Mw4D5bUtfsp+7ESGglH2tvnzzE/I4kH8oSVAukHyVkIv495utfpHqJU4YNutFofNw24mkVVa16L4yzKVLRpLVxM3VNg06JjnmHpIvXnqH2jQXrISnFw7ekedkabxwqcW8TsLyvbJz8jJyiUzaX3Jmn5n8QPXdKGdHPbQBSrPQqTsWSKfyfBw8diXZtmCf8VO79rbuMhAuAk0dswXUJi+urMLGL2ENZSfn5S2vlAJ1P1wjVV667hlbTBUvV3/NdpfkDkziL369LnUqQii6xkmM4edkgPy5WwHMRiiNBGIHwQPOeoK1t9pWouEzx8vvHBFWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKkAbzHM5xdcOeptOMUoWYML2MpOHSvysbtBi50NOd8=;
 b=oU6DOapvocrZ9hOH+IcyDpr1cGpKinEI1wmLRDsGjDyizvjXodQby/HTpueYwLoqSLjmnuMFDOnoHbo/0dyVOK3fkZL3JE0UDX/bCxXtrdJXLegcenBEK6CJkYFCWaZv0BYGZN6RoWiQWfzX/cbB8ypXMLi51qRdMtYAmri87FfC2ugyxDywXCX1lmxShKOb+ccr3kkbBh/qxCg3sOF22mHOw3aGw5HQ56bQsHmfgmdes4IByfMOo4NsYWJWNNiA9AfkfcdJ6JPTNAOxNjDaRYREZSBpimPrqB2UE/578u+tYFgFskWjTTGagszlKoJq8TY7pi+Kh0PdWm5iwqmNhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Fri, 1 Jul
 2022 00:20:32 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb%3]) with mapi id 15.20.5395.015; Fri, 1 Jul 2022
 00:20:32 +0000
Date:   Thu, 30 Jun 2022 21:20:30 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v2 0/9] RDMA/rxe: Various fixes
Message-ID: <20220701002030.GA1088701@nvidia.com>
References: <20220630190425.2251-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630190425.2251-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: MN2PR02CA0026.namprd02.prod.outlook.com
 (2603:10b6:208:fc::39) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f04de209-8352-48b2-0a30-08da5af7827c
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yjhzzvZf+VT9ns08rhBSzYxSfo51OwSjDexfdni5zppD+edcG+XigYm0nsB+iWK3WD1pzAnYiomkP99s+G5kk6ufTZsTyIwn149pYKHzkWFfyUf1d/fxKLSwlhZBBO5WKbqZ6d9wNg0sVVjXFFWJC4kbAOLS2J/bg/KyuzeBjopEhAXeP9mH4BOqA5/9+B5rDm3pgbAfdiY59qy7J3DWzBmOTahDeOJCtQuucS9qLI3ftIyKC7DLDJ1CJOmrN2wn6CZtHq5653gtGvSv3JPCfkx46SKB+qz2a189P2dnN7xSv7i3qsEMYpI5GS67pBGg2/W0eqgdeLDQWIUS1quaCrF4FtXb1B4kwmUrrOVVQw+qcA2/9JJPYo1hCto4j7AoTm2N3kl8vzH8i6g05E52PAelupB/iNTEOA7iyNBLIhgXB6KGB9Cu//rzBQojrDnYg2LmzROMODvOPsiGhOESCJkUEgWgp7jdWCc/QtqrdjWjTlloofads6jnrqM9z+zy0OiSBpa3tAwi94dWr0NL4NlrAfKhMDVtkDvPGMTcw4rivCenmtliPRnzuiywpYeyeNwDn0aCAK/eqScO5vM4iek8ztAlaceekGTFD5/VWxO4PbakKkUP17GKLCBcs2cTOzzPHF91+HBkXvQ06o5ya7vuOBF+fjY/A9la88eatndf3B1LdSLq2Wu7NF1CWKxIUZLyh0EXlXL4RjRrPwz2A45UFFu20Row8NXZ6rhHg+2M6TuAg2AFWIzevvLHwGjg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(39860400002)(396003)(366004)(346002)(1076003)(6506007)(186003)(6512007)(2616005)(33656002)(26005)(41300700001)(86362001)(2906002)(38100700002)(66946007)(66556008)(66476007)(36756003)(4326008)(8676002)(478600001)(558084003)(5660300002)(6486002)(316002)(6916009)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?esXkdc0kqPLFDUEvrmGFAp+ssZaLswAJumMe1J57Kpd7BuSF2R9FPddxGXvO?=
 =?us-ascii?Q?YwkSnayzS8vUhk2siNLL3TDovjJNxL7Ejmj8+Vje6fLnH15l/WNlz+vNFV/s?=
 =?us-ascii?Q?R/b/TxDViCHUVCI19NyBdt9xCPkZ46XE0tFSU0MqnMqVhT4UNkczyblSXi8J?=
 =?us-ascii?Q?jqd+md+ZDmDA5nNkrhc9jLspW75V1B+5yLWUnm9jqZWfNopERGtXSJb/E7Lj?=
 =?us-ascii?Q?mWXZPQVgLTUcdcPMEv4PL/F50pb5zZNC9C1mzctStX0asVzteYPE1DmMgtJz?=
 =?us-ascii?Q?qd+j5l2YA6smPKvOtpfq1GFwVLXOlcCfsNTCET7QEXG7oGwz1L4dRpH5H7AX?=
 =?us-ascii?Q?9ql45ak0ZUYb8/+rTx5QK3IDEXl3dJe9VD34h1NEB1AfdEFMRfEF88UAy1SF?=
 =?us-ascii?Q?nBRPfJgOb8RBzlKAEKZenfPEbHfODTMLfzHBr5bZrB3WVJEx/3zsompK3S9g?=
 =?us-ascii?Q?zjySWkH7+UuQiODaaLUSrOu6kUj1ocqcnnDHly4oQIg/ZG+t186rm8IAF4Z9?=
 =?us-ascii?Q?pmUG+ouEjsZXxvRgj00LnNKQrqOiohhtAdiMAGUBAHFpuEBV/SHYq9dHp6DA?=
 =?us-ascii?Q?+sM+oYZ8CUDLCtpAWNzOTOwQ2gtPaZI2T8DT8EvLV+6mWU7IHrWUHuMKtlWz?=
 =?us-ascii?Q?YyWXGHjQ555Ly12JinoK4ctxGdbVzt8zOwmdS6zUbYYNBlQkry9L/e9uo9TH?=
 =?us-ascii?Q?ea0oj2mUJJ+FWwfFHpVktmMYE66cJFD21XXKg9K9ip574hmURkIt+QxiPWnw?=
 =?us-ascii?Q?bowlODd+FAqwmcEHG1HXbAJzh5HGPp/MJYi+yC8WN05Zz6j6z5UN2rungfqi?=
 =?us-ascii?Q?IHKe88KuRALJIVWtfDzeV+KTeN0fBrULzJ5MvI2ZOabbSgIW6yd8jj80hBes?=
 =?us-ascii?Q?JKcRBaNnhMaOkU1Hw5WywALWCaM8thNOHTEYwSxAMy6lVAemmTJkdzV5U8ZC?=
 =?us-ascii?Q?xqlBgs5ZpPaBTZeEZ3RVTCT4b1ltvwa3UQN1tiGHnLtEnjExYLzNYJDvYeA5?=
 =?us-ascii?Q?og/vyzZrGfdYqWgLAcbwuVz9aXTHuW63TsjEkXHJSfjAPOyGBLu+N2EXRuJU?=
 =?us-ascii?Q?9mITSjxBB/IxgVjDs79tyrtfzv7wCYJ4phBtxeOcQmt+SGxjne8l3YfI/M/l?=
 =?us-ascii?Q?f5kfjsRHYxYqdCqEz+EZnnYnOWXcHjwBnIx4GgYcxzCSUp7N3B1uwF791vKn?=
 =?us-ascii?Q?ilIPqm5dSAerdp0HG4gdGPgzH7UJzIGNbjVt95WmqJpIPuIDqJxzzgFFlerJ?=
 =?us-ascii?Q?+oqIVkO9DnHZP1WLsnSo7TCYwd0nSYNsNtufvw/+E1mz5a+Z6CG8p8G2No9r?=
 =?us-ascii?Q?hnzgPZdo6WvogrtYGP+Fjm6OU2ISidBnoK0gshzninJSGoNOu/u0unpOjkQm?=
 =?us-ascii?Q?rCWDtB0BGe+5NBrCs0IRpw2Crv3cWRSMOfVTcHKYxeDWSOjVfsGR7BHBlgD8?=
 =?us-ascii?Q?UDbIpUwb6PIIKT44eKESwI7i+XljbeEk0we9DPdAnhsSJJ+Wt8p5ZtEwa5l1?=
 =?us-ascii?Q?XYLCSAKcMOcE0wictRI/qqQRh6RRLbM244MS/iyjrRG+cDNLkPrCO281Ud9Q?=
 =?us-ascii?Q?nU5AuqN409lFmsbxvM9oQjZnOoYMgE4Czotjw5X/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f04de209-8352-48b2-0a30-08da5af7827c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2022 00:20:32.0029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y7vj7oblUcsGa4+VlmjtcMqcrHP552txWdT3qp1ex7qF6EeXQanbicOnLJV47Kg4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5179
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 30, 2022 at 02:04:17PM -0500, Bob Pearson wrote:
> Bob Pearson (9):
>   RDMA/rxe: Convert pr_warn/err to pr_debug in pyverbs
>   RDMA/rxe: Remove unnecessary include statement

These two are trivial, I'm going to take them right now

Thanks,
Jason
