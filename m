Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516E95E81DD
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Sep 2022 20:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbiIWSkL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Sep 2022 14:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232893AbiIWSkK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Sep 2022 14:40:10 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4E68709F
        for <linux-rdma@vger.kernel.org>; Fri, 23 Sep 2022 11:40:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oIbq6ik6mIMZCAueaeLCLque1KL42g+nchTeFPcMe9u52+YhFBqKBpqOeftXjev3rn1nPraaDTPiFpD9DRygsperhurtKa/cPNoHwCvkPzin9HwkrRss8y26yesxdhBG0i68/Y74TF2p3UILXClh8PjJPSr28GmpAWPOSpKCxunNLGZPpTtRZzTaF256H1avk6WVf4Mz04PYFDSzCrJ83UTnpYdHr7rzEP/Mke7HQNobF7TCgeqmloo6ORBoPFC/YhR4Yva1dMmtM3QC/zaV89aJHDkjnOGIv8P9u20z5Qrjn1PZq1eO1wmzff20ZquTn/c0onX1c+3NaIWjDxciIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kI/iO912KCdhA1Oa34qxWXnJwW3GdnLtyjxtFPu3hbE=;
 b=YsiSagekVATTeREfdN/9sUTOVjQgZzrSM3JNNktu7bO4qlWNQlvfb5FHPLARpR/aq/KhvbKMXXllr0PrMRLDLsCTPdK2ER/wHTXsWgONu7T+SPw3cs9PuLXM9c4CJEZaPkcnrRNMdNg0TfSU3uH6E2PbuVzZk9UDU6qtK7wAlsqSpSZdPng4/zSJ2Ok4pVt0GALebPvjJJ/LYD0hgEacKAWFZlP7iJuq7Xlk6Lfk5mENXY3Ich448dtarNpcmqAupApF30Frz5v8VBk6WYGlkTlRlQta3HVtYzDIuLJ0NoKx6806A5KkTkyHw0Tt0BULgMnd7iGVADwipmc2+IThFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kI/iO912KCdhA1Oa34qxWXnJwW3GdnLtyjxtFPu3hbE=;
 b=Y4QGbg0b8UEXiRMnoSOO7JJa076KRf74+NuiNH/bUHs1yLlpBTIzCAbAVq64LvFAOC/ePZ4mseW3j/iDsYzteO+QAdBrYK86B6ZDRjRsV20iBSuv2WUIVHgcY1mqzgaNt2jI7DcHR8hZ8en0OkI1dqUSknDeVo8iXj6CivI/oqg0c3w/kGo7xbIsRX53cbCDIKC4K3piqVgGbzm0ZOLBiJtrOhNqK1gIiXWrKOXU0tuFyCCPs5ImQ/96BrCvlnGKG8hBBycY5t5y0dwHYaKMTnmSbiHhZIXsoQLEZ1E1ZtH34aLyiyLwzu9npn+0XBpppb0Da3noDKFAX4UvFiY3kg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB4315.namprd12.prod.outlook.com (2603:10b6:5:223::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 18:40:06 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 18:40:06 +0000
Date:   Fri, 23 Sep 2022 15:40:05 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, lizhijian@fujitsu.com, jhack@hpe.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/rxe: Guard mr state against race conditions
Message-ID: <Yy39hbAqAaKsIsH6@nvidia.com>
References: <20220802212731.2313-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802212731.2313-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: MN2PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:208:23a::29) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|DM6PR12MB4315:EE_
X-MS-Office365-Filtering-Correlation-Id: 24b8371e-7b86-45d9-6a49-08da9d93092e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jawc4ei4PqtXDWkR9Tvev4pUJEarSuX7JxH6VToIY1VNlNnUzOnn2M400Cg5qBMUyVgkygiE1F75ffOERv3eSdRJWLlcNZsw5+Ql9foIdoUZUD/6ijWegP0a4WY/NvKik4xwf2sYdqFQPMRNizwEcpr1v/qIiCt5EFzdL0vqjj9QjAh+vZtP47mSPp1bocN+TmxU/0IBt0RgItM5eAyGPH7CqotAouIQNDIAGpl8rOfcA4Z6KRV8zSvB72+ch0A1PJvqonFZO1efPDAfTH8hKzbB96BiZOw46i7cIxGDl19wQsmEaR6utr48CK0hkVwN8lyQdsjJItXD2GB/w8yQup7hVmyuO0K4S3kPegA9JUTYc4333eDze+06iREPrlCiTQw2whFK43tvl1ZPlB86afKqB1boeYLiuxaO7hbhOlxveWWBllm7YR16RCos8ZVrW2wPOf9lggrStLBCdshMas2StM75rE9vBa4SDNK9kr6HzIw+/qkl8nLXBrEgH/TOoitHcWffqwDNIH9KFVSUlMmwc4DbEBHtZ26UVMVCN0AN10MZ6R6KeKhzFWNJM44s1uJrK2ZhtRkOP/DVdgDVVX2D69TkKUxmgwlNxLUZ1xpymc1SQ3xTRxp4xbj9d2qD3AgnrJB6IaX5pLWqrqWEf/sXdWT8K/KR5dVOb1jcz+3D0yoXP6RmMv3Wqvb2wXfOg28q8OVkoTKIM9qDic6FOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(451199015)(6916009)(316002)(86362001)(36756003)(2906002)(5660300002)(38100700002)(8936002)(4326008)(66556008)(66476007)(66946007)(41300700001)(186003)(8676002)(6512007)(26005)(6506007)(83380400001)(2616005)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IdJS5Zff+o5fy7ub2TeLEDyOIgGMGODGLMa+dO+VXeaH9XPn0bXOub0u3ota?=
 =?us-ascii?Q?H+WgME8uCpnoAPL9x4Gok9/dpY6VzSKgdxX/56WOJPsIk2o2GfHjfAW0R4tA?=
 =?us-ascii?Q?H1C8UVeFzFRrTSbhcg/H9+G8LeRIbiocgx6R0F8TSNctpgTCt3QLJuAZKf2U?=
 =?us-ascii?Q?9PDr2cJymtMeZstBJ0xBJt+OvEBKXD1vhC0UK1n9WNFvmuydKJwzbgwoTAlX?=
 =?us-ascii?Q?0W49vSHdOb2UBQkRsNrWS70uKAip7MRtcgL3p92LAp3i4drZoc1L+YYvVw26?=
 =?us-ascii?Q?mmy3rjVIbGjIQXNjYz26fhL88Ty29y/DUv01Zry/dMQb8HsglLBv5NV/YO9F?=
 =?us-ascii?Q?8Pd7D1inTXKaW2ldgFKri5YPhP0HSA/nmg8ZVf3iQox85DltP6GeHV3Pb6EK?=
 =?us-ascii?Q?Qeo1XhCZvIU9931lr/2fehHt+vyaql0wfq5pUX5mmJBmilqtvDhlDcjirFDe?=
 =?us-ascii?Q?mYDZd+6tncB96uon9aEpio0w+cazHebcB04MVF7LijBi1cpgClZGFqMJDLIs?=
 =?us-ascii?Q?t3nQNVXendD9f+GuPI1settZ8PtRVa5O2SG39c+PV0WyGw1wF738JdB5QoeK?=
 =?us-ascii?Q?2UYym8an8aIOvitgBNpVGqEH984F3iurMgqwu0aKJ+gYryOZwejqJUsi6kIX?=
 =?us-ascii?Q?K2XhOYDPOy6H8V/joQ9x8x/h7WK6n4Ol31j8wJQMtcv4OTDlnJy/nMFZnCEj?=
 =?us-ascii?Q?/CL/iTkjXpGjRfjBdN2mGJmtInXLD0HSeqa8CyeMAlz9dawpx5SRAISe2Ce8?=
 =?us-ascii?Q?pkHmDaL1THCZMpiQI+a9pn/2Zrj5VAkfFNQK3/hZs7x46gP2t3kBl1bHG4lN?=
 =?us-ascii?Q?FlmcNR5vgqBY66sWGrB+3DfQI0utU0MdPW795uPUOL4y8BzbgHCwOdg2wZKe?=
 =?us-ascii?Q?981TdtIJAv/oY9T6dsJnNSL8MYe41t1YzYTa79NxZammu+GVaR3KnzTVxQGj?=
 =?us-ascii?Q?YEwWybM5tykRhWEUEzju8hghtwpjefdj3OmpsQi4+p4cMEHEZH565eFy/Fts?=
 =?us-ascii?Q?IEbufdAZprvi9RQyHKYn7ERuzbVwC59Ryvh15jGtj3xiDGAdUXvLorLzufIf?=
 =?us-ascii?Q?JyEolDxJUhjvLe4UJVB5YuRyEDQyby7uJa126MK10sX4f/SkmzyLtmefxXXq?=
 =?us-ascii?Q?Xe6YL6/WhOcF2AN+FkH7f6XzBM8i2+82FihlXTAcniH8kSY1k3ViIrOX6KD9?=
 =?us-ascii?Q?V7ZTArlVsL4BBIMYeiX9H6g5ChEbKUhTiG6w/mfzzwUfTA7UWkfDSMDpj3jf?=
 =?us-ascii?Q?kHWzNVd22iykmFi3OBIn//EOdw0KCZVYsOBAom44U8eWEYwjufVJI7aNxvoh?=
 =?us-ascii?Q?FjQFsTu1KUURy6LP9pwq87zDYkXkjd0fDnhVvt8odNo/uW+h519RuhkvmWem?=
 =?us-ascii?Q?X5f7rpkDlAinFCmBlktXeTkT/wIPqOKFylgrvur5rUQdhP2UtO9SyprQGg0w?=
 =?us-ascii?Q?OMM9YgpMflhUc2vb31PeGI98rcmpzdhnOb9/OmAIy1FFMfl0eBcwhz0YHAfq?=
 =?us-ascii?Q?m2wyaC+ajDBZLdrHHJTQx/iarjZCK0GIJC4CRaCMwGxnRlDrqucEhI09UMDs?=
 =?us-ascii?Q?axNXI4tPtFsmzuZylESco5gzCIVaGkxEfAczE91j?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24b8371e-7b86-45d9-6a49-08da9d93092e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 18:40:06.8361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vB//gtCOkwFD1RPRRpVcSrlMzSWb33kt/sAhGB8nZ3GereG1yeJh+YmC670jQrz0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4315
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 02, 2022 at 04:27:32PM -0500, Bob Pearson wrote:
> Currently the rxe driver does not guard changes to the mr state
> against race conditions which can arise from races between
> local operations and remote invalidate operations. This patch
> adds a spinlock to the mr object and makes these state changes
> atomic. It also introduces parameters to count the number of
> active dma transfers and indicate that an invalidate operation
> is pending.
> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
> v2
>   Addressed issues raised by Jason Gunthorpe regarding preventing
>   access to memory after a local or remote invalidate operation
>   is carried out. The patch was updated to busy wait the invalidate
>   operation until recent memcpy operations complete while blocking
>   additional dma operations from starting.
> ---
>  drivers/infiniband/sw/rxe/rxe_loc.h   |   6 +-
>  drivers/infiniband/sw/rxe/rxe_mr.c    | 149 +++++++++++++------
>  drivers/infiniband/sw/rxe/rxe_req.c   |   8 +-
>  drivers/infiniband/sw/rxe/rxe_resp.c  | 200 ++++++++++++--------------
>  drivers/infiniband/sw/rxe/rxe_verbs.h |  10 +-
>  5 files changed, 204 insertions(+), 169 deletions(-)

Applied to rdma-core

Thanks,
Jason
