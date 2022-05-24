Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F25532C3E
	for <lists+linux-rdma@lfdr.de>; Tue, 24 May 2022 16:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238220AbiEXObi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 May 2022 10:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238252AbiEXObe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 May 2022 10:31:34 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B0311A2C;
        Tue, 24 May 2022 07:31:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LV8ED4zHTyXqfI5OsKhYAgJNFjHj3u666dptN1EqPbFFwW7+b3RXvsIX/CDsF/2sDg+6Hid8dlTKNowBZOiYFIQPk2YudQWiJetrAZ5wIybi5OrobLO/n2F+wBYWcbNd98Y72a2qp7g2SQQDfKfJ17j3HE3Fl0pM2YWChZ7TO6Gy9U0eqlO0kXj8yfaVIq6u+3Pcpd4lqV9/aF8rythKXB1SLFXwL1eK6meQH2Na/PV4mhfq2QYyzLqaRS68guPEp75F3AJ4xxZj7u2QrNRN/L9hRHT011cCKppKHOhgE/r6QjcyKY/WUk1rnBW0oCgBOVWC0UxG+2UtMJa7oj+7Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30YDrPDMk9MgQkSXgmaXtRbGoukzLev7VZDpwnia9Bk=;
 b=MsiOgokcrpkkifW7Hg5G+um6mXp3RlquXJGGFfPXTWqL43Pp0NDeQZm2DJ+CD4dBm5vZ3ueZ7X0c4vjbcBBhemizJwEplDk+cvtIo5arNranwC1oxWtT7/G67zqChzp3ItsnHLF16RhaTiuhfhgOWpS0qodQ8HfNFVBRBy4kSgcl292Pqj/5EuRbOo8ailif1ge/bFst0D8Ee0JHaJptI0ZQAUBr4a7PCvzjcZ4CpNxf/C7qdAZ9spfEGBF08mBW8526d2AaFglrQGywoceepHRaDI0elj9YPy4QsaxPaHhSbnFLLPrD1HP9wLC0Izh4fA4+8GyhJ+gH0Tgpnhx+vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30YDrPDMk9MgQkSXgmaXtRbGoukzLev7VZDpwnia9Bk=;
 b=fZdgfkX1ZNZtSiHRYS0aSS1E8CNJ6+8TDnXy+KYYrMjak5EVER4F6V8y20W61yhouqqpMriLy94vt4sV7S8mUdo5JdsOf61qdQGdQtOuzL3/CkAHUNW98qITrjrImGEh/UjliVA9Jo07phXO/w3TNrok5v5ErVTqnt9OFRELFpcmNhK40g4GT0TyCYtHUNsIIIRfQgI8bWpsLgVey1qSprQV5vjS6H7DJxkvc85FgZNWhSWB2YL0nh9/gFv7AGlrKyfJv8OzIsFWeUsZCmUI4jgrlzPPYvcVf5nY3WSZ4h/Cx2Pq7Pp8/54kiTxd96XXuyefoFgRr+nQDONAKhzC9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN8PR12MB4594.namprd12.prod.outlook.com (2603:10b6:408:a2::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Tue, 24 May
 2022 14:31:29 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5%7]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 14:31:29 +0000
Date:   Tue, 24 May 2022 11:31:28 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     kernel-janitors@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/core: fix typo in comment
Message-ID: <20220524143128.GD2679903@nvidia.com>
References: <20220521111145.81697-86-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521111145.81697-86-Julia.Lawall@inria.fr>
X-ClientProxiedBy: BL1PR13CA0431.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::16) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 540bba66-be30-49ab-23fa-08da3d921731
X-MS-TrafficTypeDiagnostic: BN8PR12MB4594:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB4594FCC049C2076A73E0D519C2D79@BN8PR12MB4594.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LtCukRwc58+2Lp5rqXJFS7/cMysekhshELisT73wdbBgRtiAbnGiA9y3x2LJMj66NlB/k5PI5Bjb7hdpos6Q9ADeNE+CGeVuyFXHnzLgajMvwp7vdNNxL+GfyaTshu+GIcqm0+3OTdgrNVSzW/bPd13dufljJspruJJRuzJoommfrw5lBdVOoBhNA3qtsUQx3EUrH4MIGSyKX+5KTJjuABCzGmhP3SvG3BNFJ5i4aPclB23xo3NYIU7G1tgPLJdYN+cJLufdvGY4lWQ222D8N8Eg7mLjNnARcLMTLnq7a8CLbKnMingQAM+NIeIXXzJf9BTnExuXAnsyEP0JryCROVfrK9n52OkyUo/inEh6UoWCQz7n5uq0hKSOLGlk/h7nb+wAqD+pAMAcztwV+I4xCZUtua54d+4zbC0TVwq3e/gxcgF4ySVo0hMYn7nNZOYrPn6DEhFxjRaQdAax9lSzFji74Kc5Ad+6M6spWUele0ICPwkHa2EoUc6KChOMOG/z0P4Yt/nuEOuWE0pq4F+oY5LSsTtB1GBGnlnkrGmccDx2jyQ1/tZfmD8TFIY7+1mo2hbH78YRl1qzINlBaMl5dU7Eoo1bH5ABVbjd5XQDV/looLMOf0rRVDJ2c0hrcdHAG99a7pK4hJBlIxsPNCvCJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(6486002)(8936002)(86362001)(4744005)(4326008)(33656002)(38100700002)(2906002)(6916009)(83380400001)(8676002)(2616005)(316002)(1076003)(508600001)(186003)(6512007)(66476007)(66556008)(66946007)(6506007)(26005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zP5mOp3UxPgp3IFawPuhqTwFluvDd7BDirclxvgEyj90DJyllVgOUQRS+QzD?=
 =?us-ascii?Q?rmGEFQZ885btwx04mg43Wopn8jbZMRdsk9d3AMkdr6CW8b0kI1w9XXRfYvK3?=
 =?us-ascii?Q?AZhl/WkUkENlA9B0jsq2ROwFElWh4IbI3+DDPb0Ut/CG2/rteELScEbcaVLQ?=
 =?us-ascii?Q?Cj4RCTP0wOlTrUMyFMYoLTw3HTjASdPQCkgRg8c2C5bQ7xFDNUb04bHiD0X8?=
 =?us-ascii?Q?XkDDTRzjN3ypeeHSCH2Afv1NgWg3qCMwMYeDV1wUmh/QTZ8MMjPLhQcSzQeG?=
 =?us-ascii?Q?HHFBNqvS+CX/U+Da6zL5FoBCC3t+eH0jZQ5B9UvtFk7U11r5TpSSOeIPppZ+?=
 =?us-ascii?Q?5rcvXgzO4t9Uu3ncu115Np9I6rxCn7uHxoxn86/F9k1UdosPIrJLTTC6WB8G?=
 =?us-ascii?Q?BkTPGaaK1Yvi10uYPSkq+jsYZHZ+YV/SIOAU1HFFrlUgXprs4w/AGt/5sCWU?=
 =?us-ascii?Q?XZpc0RfJMRf3a2M2x0PgUs0rJiHBIMY7tqZysvbpgUrY8FetVkAPwrjya7EX?=
 =?us-ascii?Q?M3+dOFke0uMrvTrhU4puAfr3+syxvTCpYFSKjFAGt25D4vb97XTf9YwBLVv/?=
 =?us-ascii?Q?Z8T+MJy4pcZsefR4dv/TblEpbz1+Snyr0D75PXyIw3RY4E0okP60apNMWcKu?=
 =?us-ascii?Q?wfzpEFXhGRDywCdffs7lmze5LG92jICmULPUkqqBmtP2EhNdOd87huA45AdB?=
 =?us-ascii?Q?eIvpzGc6HvbWl55dEny7BsITMZHGu6MbD3Ll1sMOzzWeyw1uNwpnDiMVsK2a?=
 =?us-ascii?Q?lKewWqPwD1gj0lUSaSHnbDAXQWAR3GqSdSfW5FlPh3fuLruh/dO++K4OrxPA?=
 =?us-ascii?Q?yDgYcCGizdJTYay267EhSQz5jYey+pNfRQKt2AXz9vSNw8OOAnnAs/tTTK1+?=
 =?us-ascii?Q?Iw057z+I+eoAc/nmYqr+P9FRv+bbicC1a9QpY+qXIGjaDHdkoRo0oie0aKNg?=
 =?us-ascii?Q?s1aR6M4w/tLdJ9NlIT9u/0fhVpjyp+1+5EnFiKY295cemP5q4u7Bh9aPSgkG?=
 =?us-ascii?Q?3ekD7cv9Tvx57LE+FOxXLjJbrPGuHU3HAlhCGEBwuRm27AUzVdJ8AvpXcXur?=
 =?us-ascii?Q?1aX/kxkrmzUK3GvkhvDxBjGxgwCE21N4uAa8YU2Q09JIhIA/LmmFAlv9KfbG?=
 =?us-ascii?Q?xalZchoMtRI0kN1GjIZSesV6NL50uoYU0unGU1YRFn2dY4bGkpNVcV82db02?=
 =?us-ascii?Q?eG8VDV6Su/4DxLtAPijya6MxqHZCmOq4F5Ml+lvZm0jNJxEXbVWbaUDRBae5?=
 =?us-ascii?Q?c7Pm4veeC35pWpA+pwc0Itjt4EBxGNNBQbG00LxX+f3lJ6YkGhnmhooCZXIK?=
 =?us-ascii?Q?YbxTT2+OwNVhwkHTp4KPOvWxTP7CVCJ/w2dDxwAKpBtevcLWhNab8qsaC/gI?=
 =?us-ascii?Q?GR3mJ9EU12izoltEksmEQuH6y7x+R0rf/6bjgW+Lcx2jlIbwXt/gDZM694C5?=
 =?us-ascii?Q?xcZbiGIKDF7dOoukenT9ubKqFmMUcfLx0j14fLuevsv/VTZQ+5GeOhJhN9EM?=
 =?us-ascii?Q?CvHfKvxRwdFf8VCn/ge/HPPCLWaJ6LsRfD1DoCelrHhID/f0Y9trlUAijGSC?=
 =?us-ascii?Q?fwCCPIg7k99pFzudONt/zK3D9piHmiLa58acO+ZeRjoigivMVOgQopUgfdbb?=
 =?us-ascii?Q?0UB8Fzh7fzk4lBcC7Fu4KPeTUUeUtnA9uOzev302wOfU1LGESLNhSE+PVlWg?=
 =?us-ascii?Q?ihnlOUe2FOnXQnhGNThmU6DBJg/4xpJFZYJ36SXHxY4ae9f17UFbBVqgXZtC?=
 =?us-ascii?Q?GqpRdFJ2Tw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 540bba66-be30-49ab-23fa-08da3d921731
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 14:31:29.1056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DhLdepO0AZrjHlAynP0jIicRdreP7B/uHeHinAig3bMjiRaTvot1ZLJX/d06CthD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4594
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, May 21, 2022 at 01:11:36PM +0200, Julia Lawall wrote:
> Spelling mistake (triple letters) in comment.
> Detected with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> ---
>  include/rdma/ib_verbs.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
