Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B6B699957
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Feb 2023 16:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjBPP6h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Feb 2023 10:58:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjBPP6g (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Feb 2023 10:58:36 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695A54DE2B
        for <linux-rdma@vger.kernel.org>; Thu, 16 Feb 2023 07:58:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZS8ottJeYKVi4K6mL/ZeyuKPh/CaMe4evr9StwaWrszi43KgoOb7RfVOI3w1D+jEvV+KVe/IonngqRhDZY2r4krQFlM2H7ZallfMBGGQxw/7tEBZoJQp2BmItPx+E7ZwGfOVomC7In7LmKR7YVTLPiHjFMT+Rpi4pMw3kIC+l+/iCTnJ/N12tm3Sple9zsBF/p2LNkdloH7nrIveEG7wwfeqyn1g9ZpQqbJNfktdfmo6hqMkoNMFbcUrU40o3U6hXP3mL5TvBNJ2jZDQGpbb9LFmuIfrG+DA3XhvdHWU/7e5OJW+0nYnFK07peBxfSfSTMvZbt0yKZNOwXwXZfqs9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wa7toraxdnHITah91XD3AHBLC7Lmor9NX4BBeih0GHo=;
 b=dXvrIW95TTCW8jLLkypDw8vTVQ0m7e/a9e4ubvj0C9J5NAgLsoJMfHxg5V1tXxtr8IGP8eX/J0KwprqQwTv7sjj6qLr7SMw9O4MUHZvAA9zm/F3dHB5Z7VcC0Ll4uQTjqrvD8alKtAjXg58ro/nVSzlb9+192lgl2GtHXx3ZXGibApZGLnbwGuID/gO40h+PkL7V5uEfwF3z69/UGzgj1d5mIuIWSBUxcskPLqWS3hF15EkQaLSlEjD9JP9hzL3gsBhWzSUhO5ovazrCyWzw/LLTHBLxwp2gwJ0h+XDZfmdvRyY2bJNpU6qzjJ0GoyMBfwf5sZfRGfMa81nFewpXfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wa7toraxdnHITah91XD3AHBLC7Lmor9NX4BBeih0GHo=;
 b=Tc/kzJkgTinmXGkQ1AACKroRxOCBaNZhGZ45vgvJosfcZHWsbt3Tm1WZe2mcX+KtdR1+LPbF1cE/fE6uJl4Yo11a+h8XvLMOr0eO5Gx2HKh/AbsiGNGgxoKYBQdhZFnwpKD6Rz83y5nC8nsdtNvFETb47Mul58H2SUvSx9sVcOMJ6NsaEfNn4qGNlUEUGfd4IuYJl11xHXIfDh2En6zYZ6qhxg68MJouil9faL+kHG8piC64eUzqJVFQnbxLD25hWbUua6o0K4Jdgh2NBFS6IGd8ZJmm3i3y1iLNJRvDik9N/k4ewKIoyFHx7X+hYJIZuL0VuTBVGr8pHfepuuZk1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB7754.namprd12.prod.outlook.com (2603:10b6:930:86::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Thu, 16 Feb
 2023 15:58:33 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6111.013; Thu, 16 Feb 2023
 15:58:33 +0000
Date:   Thu, 16 Feb 2023 11:58:32 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, leonro@nvidia.com, yangx.jy@fujitsu.com,
        lizhijian@fujitsu.com, matsuda-daisuke@fujitsu.com, tom@talpey.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v4] Subject: RDMA/rxe: Handle zero length rdma
Message-ID: <Y+5SqKC85AagX10A@nvidia.com>
References: <20230202044240.6304-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202044240.6304-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BL0PR01CA0001.prod.exchangelabs.com (2603:10b6:208:71::14)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB7754:EE_
X-MS-Office365-Filtering-Correlation-Id: d245d956-4937-4e86-3fe6-08db1036a7d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KaDktaNszRhCf8VtPD+JBUyqL35EkabG8j8gmjuH0hOAlHO8Oc8m2J7Ni0wAxtZnmVbhSjh5gh6/6LcpQdbtRYrGAe/U+JGwB02PJcgXVb9PnaTC4hGKz8mE1+lbrTAtf+j8qkMpl5m8PKrQ43suCRyzy6HHMvs6mFEFePpr5DGsaSBehMZ1XJo2JnndYUDxd3Qqzq/056fNIibp4xXQmJaj5aLsCsBK/loCufJEezUO5SbH36FpXRvEOcM25Y5moCbkfD7/mV9xmXit339entYtMhp/31x8EjTCTjTtQqijvaNVxsUSyWs/0y4LVWLC1UZWDKtS6E3lwEo7F7lh8wJleHRviZgvVwzDHfzSZuN64/hFq/9fpgGzvzYgV12PaG8ziknR6uRNt7aDCcuUGrEV6Nep6LDObL++5HUaaC66izGtdvN4639Ceo7IPhux2r/Rky0Xh2VJ5Vd7Sw2GVh8B/kWZ8XjGzsZUmwjLTYA+uIprdW/p98uhJbkkRx7VCrmYdVMVDo2LC1A5l5XxGdB1gdNL5dws8/tHswV1kSxSW9GgY6f0d+1O3okY8lev8UkTmJapKmca8jBX+8bG4GadDHIIq0ayZGeK7VwVhM/egjxuTvJ/LAJVQAeq5Kgcv8qGHnigELWiyA/+wRmpGowp5b+GfN8/iwOYsw4srKrRRtZaC18hc7JOttFQGgCM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(451199018)(6916009)(8936002)(41300700001)(66556008)(66476007)(316002)(66946007)(5660300002)(8676002)(4326008)(2906002)(478600001)(6486002)(6512007)(6506007)(186003)(26005)(2616005)(36756003)(83380400001)(38100700002)(86362001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LzkUBredfn0q6HRdvtak1wxDFhmF1ct68IVSYTGLOP/fr5McmKfCkTh5JYLf?=
 =?us-ascii?Q?6SR2NJGZP2IlkdtJTkdtcReUq6ONrHayw52moCbUit+xlM6cu9z2pV8wLLrq?=
 =?us-ascii?Q?110vbEUmcde3/A3k5GBIxN1vAQvajCWW5Inh10StaG3qtgw1kWB+1VDwaAT7?=
 =?us-ascii?Q?Qmka6v/cWHM3ZB+UoOM9Ir3LHJFsFQaIHPu1B+BazqClNoTfc4GIhN1QDmFM?=
 =?us-ascii?Q?mMbjZJnkev8btnpkWqNQgD3HnDgmwVeN2xnVb3fYgg3ClYp4nH1nOsmEwM3n?=
 =?us-ascii?Q?275oh0UnSfma5vGZHmtMBqbT9SVhFq6PHIZtUi4WDmEeSwJAGWEATRzbMHvf?=
 =?us-ascii?Q?klLMqnGPJwEattFyeSiipK2ijYvXGJQf+61YKHIbpON7ZPhx+sYb9EHQKqX1?=
 =?us-ascii?Q?az503nzciQe+fOg86TrLLqHFzuaXNMNS3TQonGRaNqMc3mHKxQ/2XHwTxb0p?=
 =?us-ascii?Q?Bwfxha0DYfyZZ9L9BAu9cVsteimxpKYlrcuB8WDOVZ8nTza/b21hIUSaNJes?=
 =?us-ascii?Q?uG8zHYootWx8MlcBrnrBeeai8auoZ4ZX/8Y2wD3kqkfVxbRWDs1TMyPMNJ1S?=
 =?us-ascii?Q?YWYAxoxI2m9C7LJxU8TIb47p7uUV285tEMWS6jlw95YduWO16+dZnerAU1nT?=
 =?us-ascii?Q?wTBAajUM/x80GQ0jeT0iQKl72wcWbLEs9YdszczynlSonJe6/PUTd3/FRcHy?=
 =?us-ascii?Q?0P1NqKD1PAvTInWl933X4JFcSWUbERGWjuAJgiCps6KAk5X+s2UL9WajoIAd?=
 =?us-ascii?Q?9lj0FYz4Nbt0/aCgS8VzSHaRL73YaGdTS7Ks4/6aknBTuO9ZvC7FURjgz/y7?=
 =?us-ascii?Q?gqK607mXDCKnj2AFqETIwFu2oYKPuQ7cXyJl7KWPIeRw8l7Zeo40ISWdeMVO?=
 =?us-ascii?Q?Oc8bh2Ks27CT0mq+IlDq3QChaGM2sHLznELt5oGOp2SpV95uOXjP7MWu/CbP?=
 =?us-ascii?Q?uhCzlH3ediTtb2VtvUCAi10k4zpBQEOEUeK907O++wFfbqvapJtJnO1auE36?=
 =?us-ascii?Q?plvLclnkeol76m0kFYRdAmeURP99UT0EHm3goCm7Lptwti1FYNmRk+KDt5CA?=
 =?us-ascii?Q?qyAGtGz0x437l/bXESIYCUS47bKLPe0tzv1awm07IEF1Ym+konSP6N6klERR?=
 =?us-ascii?Q?gvlrfdwgX7PmXCWOVf/yqbIn+0nAvxWYVlqCeVPCq2Bs47NtLMqLau1vpN8Q?=
 =?us-ascii?Q?hR77T4HgpJ/TM45LZvblpboPbrG8422yPPCrvkYI/1AU4FvXOUQT/Ou/SouJ?=
 =?us-ascii?Q?+GA6mBvbK/UoLrMNeg0CILa24AHxQFhPZX2dQUDOC7V6bm6fft/EmEoXBWQt?=
 =?us-ascii?Q?+Mj0+ve/t/W6B3alHbsyeGTItYaJFHlOryKZnV6Q1gmjqhIumhn9Ib5FtorD?=
 =?us-ascii?Q?kNuQ2+3dxqLNZGqMounDBOEAhilgBOIFN0Y9DtFUSTwIebU5qXceMwnAdvGs?=
 =?us-ascii?Q?ksR7PdvvM958WKK6BiQx7THPn6tnFNMmyu2Ki5nVLgz4YvoZFJ4OOpvHm69n?=
 =?us-ascii?Q?4cIeIyp3vFSN/hTDKeyc+WtaibT4jFXbzjob++9Al/8wOmWhY59tek+F7fR2?=
 =?us-ascii?Q?UaDucBUEZoiikyE7tl+Jr/dUNnJ6u3IMs4guz52b?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d245d956-4937-4e86-3fe6-08db1036a7d3
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 15:58:33.4849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dT/lAmsOejnS2eqS3o2FRsJGt5o9Ey2+OfqLeBqJdbRhw8xkTOiUDyutmHd8UTxi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7754
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 01, 2023 at 10:42:41PM -0600, Bob Pearson wrote:
> Currently the rxe driver does not handle all cases of zero length
> rdma operations correctly. The client does not have to provide an
> rkey for zero length RDMA read or write operations so the rkey
> provided may be invalid and should not be used to lookup an mr.
> 
> This patch corrects the driver to ignore the provided rkey if the
> reth length is zero for read or write operations and make sure to
> set the mr to NULL. In read_reply() if length is zero rxe_recheck_mr()
> is not called. Warnings are added in the routines in rxe_mr.c to
> catch NULL MRs when the length is non-zero.
> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> Reviewed-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> ---
> v4:
>   Fixed a regression in flush operations because the rkey must be
>   valid in that case even if the length is zero which maybe the
>   case for selectivity level of the entire memory region.
> 
> Reported-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>

Applied to for-next, I added a fixes line for day 0

Jason
