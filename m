Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA72E5EB538
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Sep 2022 01:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiIZXNn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Sep 2022 19:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbiIZXNj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Sep 2022 19:13:39 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77C7B08AD
        for <linux-rdma@vger.kernel.org>; Mon, 26 Sep 2022 16:13:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T5HC57YrqkdB92E5zQFw2+U1dTWuH5DPz/P6NAm7MiRougYxcErQGVn3rWjXvs2nZaj7coYpBmZx5uIK+yT8h/v3ZIwIcux1c3+Aq4id3pfLvCYSqyPE+whOwF5HDj65pWZhyaYhzYhlijh+HnwTXO0YmmvsyNUFrMCc6wCf6HUv/zEyeABC1o+OBRiu9mk/OtoC1iTJLHO9hXjutarxt1/JtqI6Wb6+P7AfdOZc5XMhA2AuV85ZIXKOz7RCY3At+Q9JgFTlLDIRmuroXKmZXE4i4JZ4F9IA4Uq4ERA5Wxgs1hooNzXlkegz4sMbUMkQOAPpGXuO6vatPL2z3/L2xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZEFHAWCVonu6iB/oYhNv53LrPOf+tnD30j4mOkjEgo=;
 b=Pk+3Q/vW6XnCJv8htLSqtv6mqCw0CBff9kS1vbE//oiEEst7aowOpqid9+kovtYte9d3MqoAr5DQunsUgQnRALVgd8X8ymQfERCxyW/WL13M6LriGMOLlHL9+TXqJBsJM7q0mCsSA+gCkuGjmja7On0eqMKWblMMrpz/Uibm9kOSHJgGcgvpgg3hd3h2X5xCAnRhYK6Za7sLfuhwwOoz2OePT9SiKWbMH/6k/6mPAe6rG4R646pHjhano3sHmH7RmZ7aPEIUIP6iQaCrHZoN27eJkkVlmAEp0sXg/MBt+9S+Nr3nu4SrForuAKU0HAHo8LADcwacpmk/+GQT18mNLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZEFHAWCVonu6iB/oYhNv53LrPOf+tnD30j4mOkjEgo=;
 b=pcxs7bmPx4pqU8/GPHj5QIvNcyEluBkvj+Sdifgw7PKqXkGni9UxjU7XxckmVH2jsoCvdYUiNkP4wfBqmDugH09luZFD76Zz4VrHzZ6MlrzYac9XBWr6DaFui6CgBdxX6Rdtmlh4GmjJZ1iq2jSjQ9+oiAyeKrLPaLtdGirb6atdu+VNuhdCC9kX1BsTtL9NFKwQe30pfRms55KRGKv7FZJQsQUL92RpPBzWfn+gsyBNG2UeZHpQ2e9WtO2bS1Oke1+a4QHN43jOjOcNXh/ZMMMg8SVVoAbv9XDsdCtOwxlo0jXfF1iP5xEtMgC7b/72OfbIHqnKtF9K0QlJa2bHrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
 by CY5PR12MB6648.namprd12.prod.outlook.com (2603:10b6:930:42::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Mon, 26 Sep
 2022 23:13:36 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::f48b:35eb:5d46:7710]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::f48b:35eb:5d46:7710%4]) with mapi id 15.20.5654.025; Mon, 26 Sep 2022
 23:13:36 +0000
Date:   Mon, 26 Sep 2022 20:13:34 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, lizhijian@fujitsu.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 00/13] Implement the xrc transport
Message-ID: <YzIyHsRUy4gNeJL8@nvidia.com>
References: <20220917031104.21222-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220917031104.21222-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BL0PR02CA0095.namprd02.prod.outlook.com
 (2603:10b6:208:51::36) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4181:EE_|CY5PR12MB6648:EE_
X-MS-Office365-Filtering-Correlation-Id: 5914b56c-a6ab-474d-d5be-08daa014bd27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hchJwqbLDqzac6Q3Hd+xeS2PkNXpG1qRC6uQyQuPuVEUwGVmSo7FFHWeg3Cu5PcVcKxGS1SWnuemf1CpZnhbFyzCkXaNNhasSwZuTE9MYNUqNGlOpEh5wyhPuudi5dassfXErfZspoAWOwpny1VzN2TEa+v3wQpIIE7swS+YGt9VswlzOf8RZMcPPMJcYgiTipfSN3NSRdXBBQq6TupEMJz1s/8NQzYCjiLRWn3XTR45CkJ4E/CdYnICgemD+HtPKRP4dy0l6d49WAhdt1MIJI87hNibRHtouPVxWiOQ6C1b0rrIYqtlrlGgkX1jomMP6LWBqFVVRlig5ptQN6IG2GtfxgIf+vfvfSvwvc3iUMg5r8a5Sw904dVuekrc1SMOjlLU6Maf29H23Zm5x7h8wQQcemI3uCBIo46mf9d25saLlDCWAJXhDyrQKkrEOaxZbzeg4HtIzIiclIOplBdLArJsx+kfU0VcsVo9aE9j+UmXDsh/lNCRZzRLjcgbn0MixqTFYY0EnZYDs2HtPqA3jv1k7NjrZiMuTkepbwnx7d7i1i6cOdf8mJNqhOhScVZ9t35PLit/PnDtYXkn/mimd7PehCsvLvWZzb7IkpxBl1yatk+QY/kW7QJQazRanQicf+LL1J6+wv3PGo4LVu9ZsYToO2TqFJJHQhbJWyIV0Mz3vBgH+Nxp+g8/RrGka6/HLU2CuxzmgEoEdqFsO+p8eA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(451199015)(4326008)(26005)(41300700001)(6512007)(66476007)(66946007)(8676002)(66556008)(5660300002)(8936002)(38100700002)(6916009)(2906002)(186003)(36756003)(6486002)(478600001)(6506007)(83380400001)(316002)(86362001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jftvVowbGu2rnvo+wXXvS4mAi7e1vHkYcKt+nhq2mbk24mtuFB9nWjCBlqgq?=
 =?us-ascii?Q?Akb3RMAF1XOyW3BjuYPtiYYFA0M3zMj85p2DyOCSC/SEQ5aMoihBv02ODMJR?=
 =?us-ascii?Q?xenl9SyjkvcWaX+f/A4v7YWkLetGiTZwrLvd1LV/nHNZjr8NwEnoqLyOWIW+?=
 =?us-ascii?Q?zncibGHEOM8T4GfYmwdC7x7EnxPpb6K4vcxBvNutd8x7QhuLPBsGy7OyNx00?=
 =?us-ascii?Q?ac/Xbpqe2WRN0UgL52wwmXKr1bu4VOaU81CWFywvJ5UUdwqrd46OKNeBasgi?=
 =?us-ascii?Q?mToMvyrwek1EyDCuVLkBIe/9EXGAe3N9butXwief2FTxF2XgWb/CAsjshYtj?=
 =?us-ascii?Q?3d1CmBN7sVRBLStYfy1+D7iLP9GUpNnbKaKaU6lixHqCXC2QJn9CI2cDobXh?=
 =?us-ascii?Q?qud7hdn0zvfo2t8LDsHjDhxh6ZpwwedsRO25ccBecmYmwZ6EDAtS2vc3dplc?=
 =?us-ascii?Q?p8rexykSPWPr1L6pbjSNA/RfPzrLVZOhh8nxkC/O4x8BGGA35b3FRoXZdH64?=
 =?us-ascii?Q?oGFkFPDggczUBmrz/qm0pcruQ3PDKkMDl7fn6NYi115QgH5VHbURuso2AYLK?=
 =?us-ascii?Q?Xm/rkK2KDqzbNDy3LrQugCB4U94pBDhcQlaS/N7jbunhYTSSne5wxfJheZVk?=
 =?us-ascii?Q?Awvo0Ho/GS9gU5AkpQDjfdHpnLcrNOTZpQnoHuTHWzJzwBM/YF+NFVqIdgVV?=
 =?us-ascii?Q?1nPRbz6noQBnDqAik1zBJ3oOA4PLVn7ldAuPG9qv8BES1B0hHc0lQzUpSbyg?=
 =?us-ascii?Q?Wq3PTIlUa9rcdsvzTR6urSKjvsxXGuoSuHkc92E3Z64Ef+ZoTJRbesyRdPtY?=
 =?us-ascii?Q?4rUZexw2y/IScDI6bS/BYolZIrMK7JR65b95ATV6tkshNnTwaGo8DCAQjYTB?=
 =?us-ascii?Q?+wBvxJ5xl9J0FmgtCoAYo/iILpjBo0oZx35ALN23fykJ0UgNkXSrdYn7TMy/?=
 =?us-ascii?Q?pa4LTGT1kdNCKLEeO4EtxyKM0QeUW/wgwZUrmJxjkrWAmJo/6vxNe1rxocIJ?=
 =?us-ascii?Q?1zO/A65tLhJ//Vgculo+Zm8tSUMBYNNcSRP290N8iGcWz+ehhPzR7hzzIehv?=
 =?us-ascii?Q?/dRws/9VQz2p1cTZLYIc3x1szmJxgS3V4Q+jp3uhx8NS4dD2Fd6ALOh1LBg4?=
 =?us-ascii?Q?+h3a4QAcOoMQUhKm8CIt3jof6gbIAc7beGMowOaFPWzBy0eaJdKaAJzipu+a?=
 =?us-ascii?Q?rQoHGXaR3sO66sRJbpZsBpaou7zSgSmA8xTNH6aW4IRlfwyc0MAHtqla+FQx?=
 =?us-ascii?Q?XZwFTMpKuI+aB6UEFvoHfA6CaYxN9c/JEYf949wXAYhFyAnbGhOFyIRVqFaI?=
 =?us-ascii?Q?QAmQ4rtuxIGbk2UkPrsqQuSo8tBjllT2faMzbFV9TX11m1UKl0AYvEF9VWOn?=
 =?us-ascii?Q?kPg2LnrQeWsy1wBVcKp8G9SEsh5BIPe+vJGEZn6HJ0r/3VXED+uGhqFKqpyc?=
 =?us-ascii?Q?jAYZz2CWOPpoWPCMBe7A6dB4Ym84jZclZ+qx3EfjyLfItu9OhTPOFV3biGNY?=
 =?us-ascii?Q?QMot5xJ7o3ZofdsgWKpaZkC8QgU7QgMniCAAP5eBrp2dVWw9GBewcyeKFbw+?=
 =?us-ascii?Q?TG6MK/qVoweCfR0eOBZ9A86XasIoiJ+MVH/xdKVW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5914b56c-a6ab-474d-d5be-08daa014bd27
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 23:13:36.0734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WSjgqy3fxkXM5HU0TcrFCB51Qg/y3B/ED1JT/AJgJA2gRDvXr4VdHMymbojo9Xar
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6648
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 16, 2022 at 10:10:51PM -0500, Bob Pearson wrote:
> This patch series implements the xrc transport for the rdma_rxe driver.
> It is based on the current for-next branch of rdma-linux.
> The first two patches in the series do some cleanup which is helpful
> for this effort. The remaining patches implement the xrc functionality.
> There is a matching patch set for the user space rxe provider driver.
> The communications between these is accomplished without making an
> ABI change by taking advantage of the space freed up by a recent
> patch called "Remove redundant num_sge fields" which is a reprequisite
> for this patch series.
> 
> The two patch sets have been tested with the pyverbs regression test
> suite with and without each set installed. This series enables 5 of
> the 6 xrc test cases in pyverbs. The ODP case does is currently skipped
> but should work once the ODP patch series is accepted.

The ODP patch isn't even on patchworks any more, so it needs
resending. I can't remember why it needed respin now.

I'm inclined to apply this without really looking closely at the rxe
code. If someone has other ideas please chime in. It looks like it
needs rebasing, yes?

Jason
