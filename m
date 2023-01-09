Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5081466291D
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Jan 2023 15:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbjAIOyF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Jan 2023 09:54:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234907AbjAIOyD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Jan 2023 09:54:03 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833B4B89
        for <linux-rdma@vger.kernel.org>; Mon,  9 Jan 2023 06:54:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bi60L9/9VBvGLuC0jqriOC0AeSJ08q7G3W3gVOheqv2zU+wTtTI4QNsFH8cc8uFjPsHPT+S2j394ySZijQcRoMkG7OwWALriF9HSTdiFpMwvC8CoQWkjy2zt3KlCa7saCCsZJeLCkvAq7rUy+e6MK5TdjvpAE7zrVawCwk62/wzIvDiiU6j74/A40LCu5cysfE9WNQUulJa58ZpKKx0sC9B+Luo4lSrmua4IMo3pLilNwuwUrb9DdEKWt/whPFZnm6OSewryF5JtEpgNclQ9l4BihUv1buN552fsggvYt8eBb3kZdh1VaVBeLLQZZ+Lrozm1m0fsaxtwQwwPuShR5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bh2z9EVlfeTlArVR2UtS6epAzfk3X9rqFsiMglaXcoU=;
 b=SYdoWg/M5+xVLEbzG1f803Npb5/pWefl5WtI538dkIK2dtO8JRsBP3WPOW0wTRqLYMqQrqZrEIR4g50GKEz7GzJwx7WnSx+jgsay3B58gshHdqsXkAv7lCi8zqZ989sk7jkP78Gs7FgA++szpN2ivWLgaP/b3PbmqOFkGtGITxv6cVOtTOw5LOLrZOfk4PUoIl4teCzN9z5WC2bzSj1McG2faaLQOOxtl4/l09Bqowg/EnBoQ4j0os2iTFt6R7J6MJfeWgbrPE7BSZ10Z2PH1N0g1ucnXWQSZDkqrI+vK+3NEDWUPC6WglL+IoPoQ30FQbeggABfERuvZ/kvYzRZkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bh2z9EVlfeTlArVR2UtS6epAzfk3X9rqFsiMglaXcoU=;
 b=IFj6pFpV/6XCX4wnzXPHMgMm2OpTVd1wE49/aV+O6egRI2iaoFkp9lkM7xvykIcGwWHxh/inA74PsJ9e1g8rFutAoC+j9PODJISG9a0ZZg7YFTM44Ae6/yGfkTykv9MSqUrVExsxT3cR1brw5ym/X7xX0MyvN0kQC8o+1NCZ16zG5s4BZBgvgDmbPhveVnxTZtbLbTlUYRMbkGpSMMt6EAXLalOlBQTNBYUAnNgS97F1n+wFaT4IDQoSXZMwBhWGAbxhiCRnIxZpeHEw2y42OOxXF6fjlg60lqILQuGwW53TfM4cgSbNatoIbEGoaKBjxKj8cy9ChZHw4OjnM1MIJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB7161.namprd12.prod.outlook.com (2603:10b6:510:200::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 14:54:00 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%8]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 14:54:00 +0000
Date:   Mon, 9 Jan 2023 10:53:59 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Cc:     linux-rdma@vger.kernel.org, leonro@nvidia.com,
        zyjzyj2000@gmail.com, rpearsonhpe@gmail.com, Rao.Shoaib@oracle.com,
        lizhijian@fujitsu.com
Subject: Re: [PATCH v3 1/2] RDMA/rxe: Fix inaccurate constants in
 rxe_type_info
Message-ID: <Y7wqh4fGumFEr3bI@nvidia.com>
References: <20221220080848.253785-1-matsuda-daisuke@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220080848.253785-1-matsuda-daisuke@fujitsu.com>
X-ClientProxiedBy: MN2PR19CA0010.namprd19.prod.outlook.com
 (2603:10b6:208:178::23) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB7161:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bbae1d4-65bd-4027-84d2-08daf25157b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mNdWCXaV1BQn6i05hIkSvhRbSWrr4jDNfFDEW5wFZvkdP91YyzQ+PCoos/FPFNJ3ostmMbNW2xobVfEkCFy0GNFt9ZFQwWmIAaa6yrIx3CiCx4flVEO6A0ez4qJdEoomVKgyOda/5BA8y3sjZRyVbCyDd3/iav8jMw5fsD+ft3FNBOvn7qCnemYCgtEJEUZ6KzOEqbcbjGhzW4XVuhGv78Gq5u0uUEgGLfrkr6he8g0D1eH22/WwhElWNorbX0RzJCHxF9VAe0GeOGw/sA509Q180j0pmp9F7hGgursDTgDn9t7cyI8hLWhRcuaXDGizzOHngNHMoDYCfiReiP8mehQm0Y5If73h8WpPY1nelfBV5EIN74iCmgKy7YJCyM1wJ71HxcTpneRAfs/GRGEbY72GdBJW0DFOOFp2MYko/8JMEc3m3WMT20yiZKZHOA6oO+kpidhI78nzoGpKHXT/35FXzUnO3gFdaMS6o0E3MRr3C2SO5uT+yyLqY7sNbknpKxolEhvLhtebkYpnm42WjUIJE2ASDkXaTxcgr8MurWd4HVqLTVUFQMVS6CoB//7Rxx9yaUJi3fuoithVZn3koaJAlixBU+h+kowlo+FAL/AyruX74P7LBkCzAFLWL15wqtfAhVG8gHDNJJe+pFvRDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(396003)(376002)(366004)(451199015)(36756003)(2906002)(316002)(86362001)(38100700002)(2616005)(6512007)(186003)(26005)(6506007)(83380400001)(478600001)(41300700001)(5660300002)(6486002)(8936002)(66946007)(4744005)(66476007)(6916009)(66556008)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HLawgCWlqSHe0x+mtQ/5idoMhrXWX8yulGlzPXUpfNWTghdud7Ef+ED+6eVr?=
 =?us-ascii?Q?Y10yUrBLrISMZfIjaxEpaTXdCA6UjQN3ZJbabDXsK6eur9kv5yHyy1qeRsXA?=
 =?us-ascii?Q?cnCY5kvJa3KHbyA0I7hPw9C7jcpe4C+/uv1LOsJhUeKvVJATTtTbLgTuSFES?=
 =?us-ascii?Q?8/VUoVZ0X8aqOOmC52E9WPz10b96yR5PLCtXHK9MrM+ACbByWlA+vh0jSnYp?=
 =?us-ascii?Q?NKR525itjULWRgm0zuX6InCAO+EvqhGa524LTAnOK1x+gPJnYV30ZKyfE4is?=
 =?us-ascii?Q?tzZatNqOFFIiA6b9TEccYJHqxCrvQbgKrU5hyexP1kezW7t8GYwkdfVs9aw1?=
 =?us-ascii?Q?Iz24EBmwDEBQumyEC7alNG2sbJYe/xnq7/1iZc/cYCO7hlf3mwGvS6Mk8Awv?=
 =?us-ascii?Q?mqqz2KsL4+r7Ps+Gq3TwW2hzI+JiYsBCYNoi5LNqzEEeYtcKe9lZvHRg8RtG?=
 =?us-ascii?Q?TEy6wzHs7yGlGJuj99sm9E2oEXiCDQrq7B2h9ooYutihm91tyhXae2902tIr?=
 =?us-ascii?Q?4BnAdXJTxAMByCESHd3vsJ4zWocDv4Knp+5BJi0PBMdClAJrL9QTI1c1aNPS?=
 =?us-ascii?Q?FoSkfelZEOPuvrBWW2Dx2M6kAPHpK6noR3Oo0p7Jq2e4HmUHQUrLEoQH5KVn?=
 =?us-ascii?Q?mGouSKjjTzn+8tz1DPlIjKWyPMp1CaB6tbzsW2SQ90tLzV+yrkx094D0SNc5?=
 =?us-ascii?Q?aoUHGAThGqjYz/41jC2Dg6OpwHfY+hJY7qc8zPQnxg6fQ7I+qTjQsYPvtX3l?=
 =?us-ascii?Q?SOisfKvsMbAo6o4CZGRTgtXKSRGSCjA2E1lbZ+yTH+Ix0L9MSo6y/xHjiOoi?=
 =?us-ascii?Q?o+3s70jJ0YpCubSBA0IWFSgwjwNxQMiK17+T3Z6UJyXlmjleliyrZfKMkCe1?=
 =?us-ascii?Q?h+XYex7yMBwz6F3YqatbS0hxSMgdzgoLXooMc+g2r5rxSdjDlgpvJZSsyiXm?=
 =?us-ascii?Q?WsRm5f2G3xxHN1MFLRgsejmURd/QHd7TxstDKWbeCFzMaxkKzPE5hr7415XB?=
 =?us-ascii?Q?yVMpzTGXzDL7d1wH0qKtPonHLTQbIkLqvbiTUqFtnusMvb3Z5jAj4E+04O3x?=
 =?us-ascii?Q?S7Rjh4rRskIbkgK4Vf8tLvG779Csao5NcYKlWJFHVLA3zoT8CjZqfIBvlNEa?=
 =?us-ascii?Q?EKL8Nsmb+8LLXD8LCIs9igK8ZlEWuBqy2KxDSq7YIpQwN4d42+CLiOeMLrI6?=
 =?us-ascii?Q?2tvnMStpabbPWLNDQ6DGMEWYd1DUdztqVUZA59ERnEXff3TGI0+05Kl0Wzz0?=
 =?us-ascii?Q?8YPnnCim8oxeUd3trFUvkm8m3PxiKfUzZ/0/lvVtbgZKUjv7idWEmudbX2co?=
 =?us-ascii?Q?gd1kXWMxSZb0ppRkDYW1wsUDO3Mvnq1c8bQg8ihEm6uZXSdHTQA3H/uk89kB?=
 =?us-ascii?Q?l5JzRoNZGLjr/pRKBeTOafTCuZ1Gc2Pc4Dyz8shMr8sJI9DIEe5/u4wA6Wgn?=
 =?us-ascii?Q?HILV212cEP46pqbZFx9EGaghhyWrBKfnRqDsIHIgA1iq9iAQYk0WgUOWYgnk?=
 =?us-ascii?Q?fWsVSHNJJFCJyAZBnJeM9hIG3qs58OM8PKMBhIsUTwHV3V1JFG1NlH3p5FXc?=
 =?us-ascii?Q?ajNgL3Pnc4Pzc51u47MASUgMw00QtTpJw/wZRlaI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bbae1d4-65bd-4027-84d2-08daf25157b9
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 14:54:00.6092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NbKxh4WhAlIgVhHs4TzKdKjbH7OMyNIp1n0fg3ZB7RX9ldzcWZGtxnOeXB9UQLdn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7161
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 20, 2022 at 05:08:47PM +0900, Daisuke Matsuda wrote:
> ibv_query_device() has reported incorrect device attributes, which are
> actually not used by the device. Make the constants correspond with the
> attributes shown to users.
> 
> Fixes: 3ccffe8abf2f ("RDMA/rxe: Move max_elem into rxe_type_info")
> Fixes: 3225717f6dfa ("RDMA/rxe: Replace red-black trees by xarrays")
> Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
> v2->v3
>   Added Reviewed-by tag from Li Zhijian.
> 
>  drivers/infiniband/sw/rxe/rxe_pool.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)

Applied both to for-rc, thanks

Jason
