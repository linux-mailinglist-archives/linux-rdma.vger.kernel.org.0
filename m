Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872CC60B582
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Oct 2022 20:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbiJXSak (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Oct 2022 14:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbiJXSaD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Oct 2022 14:30:03 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::61f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C492A79DF
        for <linux-rdma@vger.kernel.org>; Mon, 24 Oct 2022 10:11:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aaESgCg/NectTmigVv8Z/9tOpWpaXIWd4GLKffcxRfrKsQ8Q2wV9jJj0YV66ldsmVoQVchMZgYTkbPRoC0WgrSkLsLsKThKrjMKg72Mu5gF36Md4NqnIWVaQeOdk6k8l6VY8mcYC9aWGjHEAcDlcnPtqDlWGD6CiyVQM3IXodV76jLQWMZrXS1EOMSM/IVPFitDxfVkpkc1qgrKtsffwMvbppOBhmV6RKLtPenOXWdaTDvV3SCNYvmc/ZNsx7UFhV8lw6OL4Af7Xw5NJzd8tPuRg2td4Hu+Qmf9Y+DqJkliIalA3ApnFWI6HDiEJl5T3a6Ou8tDHn8Yl5EbbdqHnWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHpT3nQ0TvPCLcpKhv+Acdx3RuSty4BOMClGP7dQxdc=;
 b=XyGD+CRdngxi+y5Hf+x7YfMxYJ64tyVBbShsZ88RFIOavFG4m6Zh5ZHNmXyzfiyJGFRLlkCKOq0Iwn/S7pIo9Nqhlnrk7vAnVqBio5HX9DZEstujLb7MWojWD137gO5+pxts1+Y27SC6MBy2SFUM2UBn6/03ZaRn7Cmj6jETX81ape5dFHsVlfjY2EvNBTRxf8AlyXURFbQd7G7bEcq0qIp0URVyl5sI6YXzQnUgxI5OkPXZedxaZdS68s86AIab3az4GfDa2Z5heupzJ1zOGH0CWfCjPYtXuNcT+rOWvT9dxt9lRRPoIzzVNbG08UG4pG+qKuF904rGDtf2gxW/Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHpT3nQ0TvPCLcpKhv+Acdx3RuSty4BOMClGP7dQxdc=;
 b=n/7ZuULxQ10NQyUm5HaXbFE5zLcxDWctrwrXbh6529Gx7LHr/pjIySLcr2hWY3jaNsTqfoAPCUbTccXiLUhXSRaX4SyyY/WBDto88NFG4EroFyIEGPFD7PKp5Pygxsu8vpw5P5itzSVQVkPu5oTnRSIkxIgzXyoRIGjXJUPjL91iDVUFsq8GioigPe2MfpKeVy1QM2lorxn6BVY/5GhPQs+AdjlqKxog9R7V+pl3jHSKbk/55qTKTrWfcbjbvB/VPva3xH9G03E9ievQLQBzZgWOF1Y8tkb1KKu7bi+kxXKHDkFocZgRrp9lLufeKlLXlyR6qMoCWbZl1XZDEjmRsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW3PR12MB4396.namprd12.prod.outlook.com (2603:10b6:303:59::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Mon, 24 Oct
 2022 17:10:10 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5746.021; Mon, 24 Oct 2022
 17:10:10 +0000
Date:   Mon, 24 Oct 2022 14:10:08 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Cc:     linux-rdma@vger.kernel.org, leonro@nvidia.com,
        zyjzyj2000@gmail.com, Li Zhijian <lizhijian@fujitsu.com>
Subject: Re: [PATCH 1/2] RDMA/rxe: Make responder handle RDMA Read failures
Message-ID: <Y1bG8Brl8EK7C0qD@nvidia.com>
References: <20221013014724.3786212-1-matsuda-daisuke@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013014724.3786212-1-matsuda-daisuke@fujitsu.com>
X-ClientProxiedBy: BN9PR03CA0751.namprd03.prod.outlook.com
 (2603:10b6:408:13a::6) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW3PR12MB4396:EE_
X-MS-Office365-Filtering-Correlation-Id: 1876f9be-b064-498b-7d1f-08dab5e29b2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gp4Fh1WLBDq6uSHt1RQusqvqs+FvYcl7svgdBy6DLT37AjzDgPnFzMW0Uh3DG2KC0KA574iHMUCAW0wEgX4PJufMeF+sTunRdzQuouSxEQrCRpRW+pys7hlnay1fL2CrBUUv9YmbnR9GSbxxy15o/jRFWoXBml8Y/3AbKYSRfzF3OjFBulfed2KqgDtN/FLl3qviyzz16a8vTszmefXnypvuOHqHJva3TH9TqtcRnk8JFUxj4VvNIbf1JFQz2rhvXJ1bCLCkE3GNJNdH5jeSmDSEW/QliRIlkpn4R/6QUA3G1GAl6Es9JVlr6m5QvR/1nnKbgm+cKHu7KxAkBgA8YjYGKL+paTUARiBKvym1ufl8cx6TiTGvb0/GLQ3tnAjJ3BsqiP8ZjWZ3oXY1gA712DERKIbaoYb1i4Y9iFiiSswCWclBcqYFGgUkSNgIcSWkCkO+lO/ETu9A/qcOBe5RyhrEqtvuLZwuhqt9SgSKd63Wvwp2CZ5Q/vDSMqkU1kR61HbBgMlsbsd9ZT7Ng74hcR/2jFZOxqDrv2CSSvcporlphEDQrC+w49JXInNhLS6x7FtOEPuRNGr9zuBneF0GGvmj0F5JbBkqn9l8XTJ0xoNJ+kqBEmDSq8DUw5HVYqjaGc9B4x5WvJ1ipOlWKf7rJua80/8XhMNGOyF1l4QCPBMnr36loZhJ2x7YJ+DJ9AYFenSruvVWEYbMnI0CYnGSOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(451199015)(8676002)(4326008)(6486002)(4744005)(36756003)(8936002)(66946007)(66476007)(66556008)(5660300002)(2906002)(83380400001)(186003)(38100700002)(86362001)(2616005)(6506007)(6916009)(26005)(6512007)(41300700001)(478600001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UMlBkYcp1guyaC7yzf4El/SeMrdUVA39nSf/PFG3rpsbaFDrA5M+AksN+pMu?=
 =?us-ascii?Q?Mkued2MUSHIsn7pfhoif86/bhMXQDt8MyLiZrUpVZkQ/5ryGUeFP2lgStkUn?=
 =?us-ascii?Q?aK+oWgupkAXjcH3Bcyd8NZ9EFolq/XxTtxSBHZmx1MlDS40jIDdYKoqY+nTa?=
 =?us-ascii?Q?gdB0zLhUB0Wf6bxJP8OdvCHzfUNv5WAiamyzQhd6iNoqbcdFkxGPi0Qery4l?=
 =?us-ascii?Q?RCdDXr/Q95j9V1Yn/QwFqeXdRzssV4iEqoVCcxRSoFnr10+2V6tKsUzsz3Ll?=
 =?us-ascii?Q?eFJuJaC0A0Kg1bXQqFKXcFDwzT2Bh3ZQbQgZ3BBlZTxNEaPN2oQCa+F1i0cu?=
 =?us-ascii?Q?RN37MGlH95VGyZBJBGpMWYVdoywosKFwiPdPgYvDWGblE8NiUOLn0FNNaXqv?=
 =?us-ascii?Q?VN373o2FMGrIkMVMgEXb+r62NCL0JRNz2Wfvev5NDgHava+CA0pILFViyzbO?=
 =?us-ascii?Q?gvlNjY3BEAxPrPiIaA+d2vodsInk0U+aQYQr6t1adGaJMwWnjICl22SudN2w?=
 =?us-ascii?Q?TKLw4aLH0zdOv6qg9wAs1rOSJzNRWcx6YtX19dGO+Uo6VqNt+yM6UmiZ/uP/?=
 =?us-ascii?Q?Jwmv6d+yRJ2HT/DHOnqEE9/b1JQ1yS94vowWeGxzeMtqAX2mauqPUhBxWpNO?=
 =?us-ascii?Q?4a9VTZoclmsicNX9vebtIb5SC2GQxe6DyWVX1iX6WJUpysfrd5Gbg4OJl9b1?=
 =?us-ascii?Q?oqpvrzNTYAGM5nmsMjW5uPduii8SKCY72y1mz4ib7JVJWXpbVpzxrKRElhJl?=
 =?us-ascii?Q?/hgkgnubZTiBSVoCUa9qhSwro6Nx5XT0a3li0iVZ6x/62MNf/Gfn5tWVge4W?=
 =?us-ascii?Q?osQzBVE57En9c6X++JJ8TBgwitXNMCk0Z/Bx0xDtSxLeL/osq6ZrMQjNMQeJ?=
 =?us-ascii?Q?EEEnwsxa+0g2FsXboxFNento+tRYDMoHblmxs7g1nX9+fKmJWxUudPxlfFte?=
 =?us-ascii?Q?IwjXYOEuC/qd93wSJ87kfELydsbUYX/SO8Y3hBrzm08lTGyvjaBpO1Ym9QvM?=
 =?us-ascii?Q?Fx89qCMv3hP0Qdp2a6PuBBdQg3khuFMramhAlE6ix5Tz31jZqzD8nhUzvmIN?=
 =?us-ascii?Q?QAvCmNScLuqOD/0u1/TKW7Ppd83WvuhuN30nBayDg7usVIb9HO5+BFUkvJtF?=
 =?us-ascii?Q?OzozsOfaNASgGWXbEP4xLesD3m4wgCGLzQyC208Gbsoc9CgVZONKQYgcTgvu?=
 =?us-ascii?Q?ZAf3KEWYQ09wtcifFNcqoGAYAoef/WHVIGqDUUS5wlraCLasgngkKkNsnmz+?=
 =?us-ascii?Q?M/QVQIN3vqOiDRmZnxDu2KWqE4mO2xk910DrrgZp+H4As/IyYa9s1imiLk7E?=
 =?us-ascii?Q?4h7PimPofHEhsbS7DuyE2rZ9xd8q5UQzDljBjQiJUQW/LZRH/PI44/I4kO6e?=
 =?us-ascii?Q?oTRhP8NCg+gEK6vQql9/C1JY/tB6QePbe5Si2h5uKY8fAH1U1z+HkaEzJNEX?=
 =?us-ascii?Q?j4PKkZNp4X3V/RDnkvnLmrZCdJ9uLt/pT+FCj96q6A0KpzFnyVWaWbadilXA?=
 =?us-ascii?Q?tWq9ND9I53x8jtKZg6hZOAOYnx4/Zbs5k7CRTCu11XDOHQgtCuVFnSDxoZwU?=
 =?us-ascii?Q?TroHtq91VOcbu9Qoadk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1876f9be-b064-498b-7d1f-08dab5e29b2e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 17:10:09.8816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ATP9RvnBYfrdZJwz+LK4Uapiv7C0BRyO2Id+FgcXrfIQajY8FxG70lOc/EutrXpa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4396
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 13, 2022 at 10:47:23AM +0900, Daisuke Matsuda wrote:
> Currently, responder can reply packets with invalid payloads if it fails to
> copy messages to the packets. Add an error handling in read_reply() to
> inform a requesting node of the failure.
> 
> Suggested-by: Li Zhijian <lizhijian@fujitsu.com>
> Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
> FOR REVIEWERS:
>   I referred to IB Specification Vol 1-Revision-1.5 to make this patch.
>   Please see Ch.9.7.5.2.4, Ch.9.7.4.1.5 and Ch.9.7.5.1.3.
> 
>  drivers/infiniband/sw/rxe/rxe_resp.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Both applied to for-next

Thanks,
Jason
