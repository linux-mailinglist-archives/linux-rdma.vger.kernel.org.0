Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B113D701163
	for <lists+linux-rdma@lfdr.de>; Fri, 12 May 2023 23:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239538AbjELVd5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 May 2023 17:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239554AbjELVdz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 May 2023 17:33:55 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5949E66
        for <linux-rdma@vger.kernel.org>; Fri, 12 May 2023 14:33:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mcb8xg1KcW39n3tH8xIml4+MtVRtCneSA/EXoG73eEMJ9XhqwSft/o7ZynX1zZJ4A3QVbFoByH36wbQrDtDkWPUqq9b3W1ke/jFhjtePmdUEuueFb23WxhzOWw8Cv4rs+wBY9CM+83/XmvwTAwZGLnWbnFs7/JgTAgVlgwXtGFQIKBsZ4fvbk3obdogiQNidsV2JjzVKY4c6nNiwAWNQDYmAfZErRZIsxet66cPpk8Fw40FsPea97vp+I48yY+KWvC40TICSf2FEn5N0YmokZbiI8HzuM1oDmdmLWPPcJwdbFu6r9xnFtVYsTPkr9raEoonf5nx1joyTFgy8NW4vYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=78K4nIScDoeUFFaN28hMG5b6APvQvBY4o6R4Dug/YKE=;
 b=K3hfS4kSPuqLyKoum2bNhOejNqDcr42N5YOVXq/ZrgQzwOJqdYAdLOGedr9dY8jNQzlObvtk+sDZkDTZI84booLqIKV5/soygjVD75c817fkAFt31cOoQptvp2AieUF9h+OQsScvHVQkQAE8lT4zaPwRiILq3izbFaqizaM8jnmxcBfyErr7YLCgLeS7UaBmxwuZJa/kbqaeJcR9MVN0CcbVgV/7uJwHYD1YbA3H0H1Xm0TpZh9HCbMfu7Tzl5a3Dg+BNRoBJUB/OEXmNGbPh8vj47PNeNH2GNwN/BJCQvDRlJehKDDdkhIa9a4gVwhwWKjwRGU6/SNcZtDtTVV19w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78K4nIScDoeUFFaN28hMG5b6APvQvBY4o6R4Dug/YKE=;
 b=TbbRs8qDXRXVoKfswujvUJUjmRfGLlG6O9v6xh/hev+/IrNfqWJyy6OYzcs1h1iUd/2TjuozfxOiWxARVCLB++PGPg2uk18GGOGDIOOsLK4wGRo35bMLa1soIxl49A0zPSV+FGlXBAj9Cd/Bi7GNBF19d3f8ZPiF70TcATCRLTdMdewswm1kqLwEvHTR0eJRj+Z75qUoXZTp6Q5VUkOoHdWr+3hXXf5utldT9DIuVTobFmQHOqAYVr0AAFNGR69POdTfjTBOFdMxc2ef6lSVusaDsPUNGK13xoaYDxvlmQvHhGyguwP4DSGaB1ZcJ5kf0qbfbGZxdvJCx9PnuQIPTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5963.namprd12.prod.outlook.com (2603:10b6:8:6a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.33; Fri, 12 May 2023 21:33:01 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6387.021; Fri, 12 May 2023
 21:33:01 +0000
Date:   Fri, 12 May 2023 18:32:58 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        andrew.gospodarek@broadcom.com,
        Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>
Subject: Re: [PATCH for-rc] RDMA/bnxt_re: Fix the page_size used during the
 MR creation
Message-ID: <ZF6wilKJPBM9vBbr@nvidia.com>
References: <1683484169-9539-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1683484169-9539-1-git-send-email-selvin.xavier@broadcom.com>
X-ClientProxiedBy: MW2PR16CA0066.namprd16.prod.outlook.com
 (2603:10b6:907:1::43) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5963:EE_
X-MS-Office365-Filtering-Correlation-Id: d87768db-5ce1-4197-1366-08db53307606
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kvXuBF/bDCz7jud3sSa3EwpX9Wpb20ZubWn3h0NcmAwyWiVgxWXuLcT5f64ehQQCcr+HvPJSPGLK//4NsZzMTwAlfwyVXwtmncuWs20BfA7CCzkbmgieSDIkT2ELH8OFTSii10hFiAmXtYYGiRgHPzFGTJx6oEgCgw4aY4aOfA9uFKIOBBGq2VN7f0VIU20JmNRCUfIOaLfOAiZwRJJP/4KiTjq6TPIaiwjoU4FOk4izPGebQvFfa/d//Ecq6kTNyhM/EDPR/dvpYf3WTeN3xLNLyHQ9RsQuC3Cbo5IJG+EqbB6f9f/vsMMwMVpUklaQ08suHmV9BFj8PpapnII/dFOeIM6n0x+QoIHy/q4x/cSDMqeWt/uvVXkFU5z80VyrQHodZ3pscxMpS92+WZYca7y66ur2N1gqXdFHN7Dqd+Wlx4FSkvieXvrblH/p4zJO3o5NC9uDKXn6EwCqcYPiSfeCLVGhhv8IwWrLQLxEYFkrFPwBq/V7YFi1AD8PuJ5wcOf4wr2U2NewrGP2SZ5nvKnuFPv8oOKUBhMfn/CAv6OQRIYeyFhVl+NtPjBnV+97
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(451199021)(36756003)(6486002)(478600001)(2616005)(83380400001)(38100700002)(6666004)(6512007)(316002)(66556008)(66946007)(66476007)(26005)(86362001)(6916009)(54906003)(6506007)(5660300002)(4326008)(8676002)(41300700001)(186003)(8936002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VXFoPeI1sQqVcxtDqHkrDme47sEJ+Ir8pNuN37S2pDWIkI+7ygq6s17//7WC?=
 =?us-ascii?Q?ee59raBAQbUuCDb1xv8FZYW0mZBzjaTNEWhG0jcGlsUHcH00Xhlwy+1X5h54?=
 =?us-ascii?Q?wAAYy5NgtB6Fcae9HIpq1CGlrq3sj5NkdWd5j5fnLqURIpRKqOHMS9xnSLl+?=
 =?us-ascii?Q?CO1LV48+e5mS9GsUypev0GQSykWCQiDuElzHkvqVoNCjrM7QW+HzLIysBFmw?=
 =?us-ascii?Q?bqCJBMz473lYyb3204dXG/px+sBJeBECqoJZK+WpJmVU0c3CPpNGPaZ1HWna?=
 =?us-ascii?Q?LjxfDaKELZ43ILrvUfonVjMPFVtduevp5UqJoau4PQG3amp0hGdvC3RSSdFP?=
 =?us-ascii?Q?QS4xVV00JadBaG95TOlNwyWvmfWkek6AWdFbrfZrrpFFmLXHIcGAi4oYa6+g?=
 =?us-ascii?Q?AxrqZQHToCfnB00u3tNIaM5g/93/Uz9FTpuIrncwlIVA4adoFTS5nzqOqjng?=
 =?us-ascii?Q?fZr+vKCqRW+zbYCEndR5+E7TZLozMq6FUCvDVWE4F2q19h2kJN+YaKnqfa41?=
 =?us-ascii?Q?5vdY5hvlMxrFVr+Bj7rdwmzJwhCnhlJUU6JCD5Ojr1CQNnC1s5cWzqVjQ3Ok?=
 =?us-ascii?Q?AQnSNAe75KtrspHsrc2lCDVS+WWG3DOZ7H3rE7SRMz5GLr79Ma0gybBvki8G?=
 =?us-ascii?Q?KK5tqPnAVlpaz7XlwA2jasv1xvz41Lq1Sij54Oe/WJBHaOG1z4bDgvPlzxsP?=
 =?us-ascii?Q?3CnY8R6yjorE0XB5kO4cJ2DRWJsn8+5GqRuyw0VNhIZtSoDJN6YM2yqy6O8l?=
 =?us-ascii?Q?hUSJereTcxC6A2TDVLqpxL1n4CkEXjaonuEaBHPcEu6bbTC4brCbSLgltxMC?=
 =?us-ascii?Q?ljfxSrejIS9l2AwDrc9IKFaplDtcCheSdjsNLOXcZILa29cNXRMIrvwyeoqk?=
 =?us-ascii?Q?ReqRy/JE3zovA1IgYcJBAp6l5qHEfSb/scu9oS67n61nwUhOSgvv8RlZQgff?=
 =?us-ascii?Q?xW/KE0x4wo2fRWy0vSJHEUJ/zHvrAFH7e6S1LhImni0Va9qaKAWRU/rBGwsm?=
 =?us-ascii?Q?SbEr7LIDh+7LYsAxMLyhLNCSacaQrax94tXrreor5YA4UyjNPt5UFnjetqa6?=
 =?us-ascii?Q?xalyF416zfl4CVT71nBXuGC6/7GbABOnh+p7A7uXgecriKsdeyS6JYBMCwsa?=
 =?us-ascii?Q?V1wQNzRWVhUmd/UXlBg8lc661PFwRzFqv6zXI7ALr36cESw+PB9EVXVwXeZj?=
 =?us-ascii?Q?YUlC6jdKxt0qOjflyf/i/u4n/6XdQdPvPMX/IOGniFvJ+ud+K9V/fkY6KBfP?=
 =?us-ascii?Q?jwOcenRwhvw2oEooVbkVgo8Ghc24mrohgjTsOpEbrcFLTTHBGtxMILSUoj7j?=
 =?us-ascii?Q?ie/O9iCUiFmn9b9XQkb/PLmeV06V9Au/8Q3VMWDzJmy5qNwlU7V3Q1/+9nW2?=
 =?us-ascii?Q?RpAXc7dAsk30/jzX4pu2h/mh5KN8ItS7OLjjCenhjaJgEMU3XQgOtUZBByDB?=
 =?us-ascii?Q?XqBs3pBbhJLAsg7Ls7FF8l4WfD6fcIiKwDvjbqf66H6trmiUwjupd716twhp?=
 =?us-ascii?Q?QIvdXh/VwgTL6J7rYzNTNUZy74g4IOe1yuAZ8hSbLuRTmvVO7q74R+/1nYnu?=
 =?us-ascii?Q?eK/rxFiI1YkOuvT3KhnY08ouLdWJq0EBpCLi8mPu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d87768db-5ce1-4197-1366-08db53307606
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 21:33:00.9592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JZIBFTzXvcM5PuIYtja52kC2gEU9P96IfOptIS0ALCjEpihioSAKwg4JoGIqnO0W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5963
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, May 07, 2023 at 11:29:29AM -0700, Selvin Xavier wrote:
> Driver populates the list of pages used for Memory region wrongly when
> page size is more than system page size. This is causing a failure
> when some of the applications that creates MR with page size as 2M.
> Since HW can support multiple page sizes, pass the correct page size
> while creating the MR.
> 
> Also, driver need not adjust the number of pages when HW Queues
> are created with user memory. It should work with the number of
> dma blocks returned by ib_umem_num_dma_blocks. Fix this calculation also.
> 
> Fixes: 0c4dcd602817 ("RDMA/bnxt_re: Refactor hardware queue memory allocation")
> Fixes: f6919d56388c ("RDMA/bnxt_re: Code refactor while populating user MRs")
> Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/qplib_res.c | 12 ++----------
>  drivers/infiniband/hw/bnxt_re/qplib_sp.c  |  7 +++----
>  2 files changed, 5 insertions(+), 14 deletions(-)

Applied to for-rc, thanks

Jason
