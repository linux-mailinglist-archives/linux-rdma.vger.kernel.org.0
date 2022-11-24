Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F36B637F7A
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Nov 2022 20:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiKXTPO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Nov 2022 14:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiKXTPF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Nov 2022 14:15:05 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDF38F3FC
        for <linux-rdma@vger.kernel.org>; Thu, 24 Nov 2022 11:15:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CAPdEtRLXjB3kZVsGaFaI5MDHaQZQ+sviuK3UiSs72MOoIcGRovR5TOaFlkQpPVLnRCeHFXtTeVB7Vw8HgqfNCRwAnPv9gGguRyIyiuNipDk92Uq640srRplBALCf33gT1v8KfieO5FvnTV3fh+FnKPNEdKOGy7FT7BCtrN+z2DmllhO5ihHYQHPehCnc8IH2HJLLvXvNhLwQxJe9bd70UU9/3L8DhbZ35lBfY7mP4mS6UQDVXleiZZgVt4XYrHfj5z2ASLWXo4FshvNtyLAL1sEZpK6JrcmqBt1k3hlurmJmX8jFbit9jX0jP/Cmrz4KNy1xbm5zN4OmpLxmg6NFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDC+qqbuzhYHnDhVlHjStCyl6J27yGGfe7xYoMbUhH8=;
 b=kUc7Sml76vwPZxbHc0/g3m2KPF54A6uHFfFNwAQvqcqlfBuRCElDfrvTSp1OXKZwRdqk3AT45yeadGmsG9ojnPHDJASGwJlCiB4KRqayUyyOsWcaMf+6ADixniU2UMrB8OzTu19jO5vQ/ym3LJ/hjId52ggAJR9z/jmlclPYTdxnQIqU1yDR14WN6omiqxfx/GFg1xQmH8qFcbH1I+TF8A77g9vzKgpIX22mhPstMQzkGhb1so1o/ULCgNR0J1PzyF0rH4WAtbpjO4WSAjJL+ujZas25jCw+FGahCWI5jeDahrCowtDmAhdvFzm/X1vmC6iR/ZPftfDHX9urXjkljA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDC+qqbuzhYHnDhVlHjStCyl6J27yGGfe7xYoMbUhH8=;
 b=inEY3MvuMidTSeCOeFr/TObbRUBVcysb2mIrjpyMtJyDNxtZuX5AMrn7stnaJfHzvXgo92LMkeC6kBF9AhGVbaskwmoTn7d1VEe+5/opsrJaFNvP5IKFoLpAW2TJ38tCWbYK7rHRwOzcMa1ZdTFiOQ0uU4mhOPR4G4XC4IPLhgTaNT+Gh1ZQJDDHOMTa8NLP9wDuyZk1qgi06KK0Fc5HdB1+ciyrHsB1HZtPTzkg8q2P4ETvdf6PBzsgV7ynTkXM1a2ev7DTs3/EXEF7ah/yRblFs0KFSZ2hGiZ9QMmnJRgnCRv88rhnpZ2hBXG99fOQJYZrZe15K0AhCtMrWbktqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB6487.namprd12.prod.outlook.com (2603:10b6:8:c4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Thu, 24 Nov
 2022 19:15:03 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5834.015; Thu, 24 Nov 2022
 19:15:03 +0000
Date:   Thu, 24 Nov 2022 15:15:02 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     leon@kernel.org, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v2 07/18] RDMA/rxe: Add routine to compute the
 number of frags
Message-ID: <Y3/CtnII3jfjEfRA@nvidia.com>
References: <20221031202805.19138-1-rpearsonhpe@gmail.com>
 <20221031202805.19138-7-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031202805.19138-7-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BLAPR03CA0123.namprd03.prod.outlook.com
 (2603:10b6:208:32e::8) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB6487:EE_
X-MS-Office365-Filtering-Correlation-Id: a3c84efe-1f2e-4174-1d87-08dace50305b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kw2GYl5PmvZMHTNay1ozca3G1yNZi8OV1vVudz+iqlWzKzoInUmM1IhXQSQgXCpXvxGjkKZREWSWJtI7TS1OvSR4RX9ecxb/U/SH4KqBOCGASHXr/rpeAk9/4cWlUApraBCKIh+xqsGokCcreXr3yWVuIaogjJTjPIPW8wdCUb5I9PgnXHsrJAxwY2RnLpeqdYaaSA7oKbySYMJDjVx9+HnUUunzwp5js6guQf5fGsC0z2Kh7/r4ELh7o4w2s/0tOZrOtn342bMhXCePEtJTI7Ojoghlxro2AY7pZi4TDvHUyoa5i8JC2184hMyh04rNvas8nwE2MuTANZLcYU88sycmkPO6t9mgptzZoFkzEiMrOXjvy57oPaxent5VW3HJ4u3W4QuvtFxel7e52SvjCSojby7cUewpjJ5GHKTfpWsFml7owwdFc7/UHnsWb008pE/e8BwlEBoz29BpZgwDXJirEBsrjzKk1kbLod9GU5Rsm1YvUQnmt83KPfYGIad+PwTV5yTNfoh/DIRD7xpv9KWO5GteTyPcEi1iCsy0SBy5MiK4IW7rAiMh9FoNCuEmOs1iQdfPn6gzN279fNkJxqSVd9nezYKEVDD5EWBQC6U1SUxbhhmKr7fOht37eFlgY3iWHvqtgYI+zKjBRs25HA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(136003)(346002)(366004)(451199015)(6486002)(5660300002)(8936002)(478600001)(6512007)(316002)(66476007)(26005)(6916009)(66946007)(6506007)(36756003)(41300700001)(186003)(86362001)(2616005)(4326008)(8676002)(66556008)(2906002)(83380400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lGI/YEO9CKY1tRFzw32mzet4faa3ViH0vbgbPh/LQeM2rMdr+qja/vjevyYi?=
 =?us-ascii?Q?jjFNjefh6Oc3Cr2Rw3mdajhB90RBKkiYZ+AtHa4lVdfdK6KmDyIY/uRgC+6g?=
 =?us-ascii?Q?LJSRmstLTDH27NMzqlmvFaglwyp6ZXkNzxMpgZV0I7x4rBBxV5lKJmXrWYRV?=
 =?us-ascii?Q?/4Gi33pg/y8f8osrCOWP3knAoUojjIZiyLM4JF/9PFsxvDyocriQ8lGkRUYV?=
 =?us-ascii?Q?99ZZVrTXwJUZVFYkWBJ5suT6iHC9UXN+KEYhy6FYTDAvy3uv/XsVzEGJCsJz?=
 =?us-ascii?Q?YMsCpSGm9vUVuvv4qg9PXyNjg1QMp5P7sOWcAaA1xVE9MIGxuw5bG9t8FCKf?=
 =?us-ascii?Q?mrYC1txajqH26Qe0vCX9fUnqPFfTK02KWFZJF0r78s90wLSI0YtzWzJsyzvZ?=
 =?us-ascii?Q?cjmb/6Vqfs1CpU52/6ycCwQbVSiYc+hvPR1miRG53XwsKoC/JHunRMd6J4nX?=
 =?us-ascii?Q?pOvsdqbmzt/M9rjZgRK3WbN+/g9drmUt+wbEIHmuudLZhl6WrNrGLQ3HGxCx?=
 =?us-ascii?Q?Lu7p9nmwIVOK8RXVEKtt5b6Z7tpC8/zeYA9guVY3w7etnaNIKP9OuIQZg6yu?=
 =?us-ascii?Q?yMGBtdiwLptEC3up9C3RigzyQd+1ovja1zWxyxPVGkPOC+7hsFLrblh5arGO?=
 =?us-ascii?Q?j0wYIi6HF7cdeqoKPc4QRE+E6NQwkr748HTPtjLn9O2UBI0SFFm3l+giAdBd?=
 =?us-ascii?Q?GODZn46e7xSsV4sca1eFog0cF3blLvvlBc8k+TQ+1A6YZk03+VSlTxO7al9R?=
 =?us-ascii?Q?CTGNVOMSVd5CLT8nVxVvLhpcib+fn4I7T0U9h6L8+CeG4r1h3oy+MfK8XN+K?=
 =?us-ascii?Q?4ZxkiPmdh504thQapbTP4Xq6tA7uSzYT5Z9a/ADkeMsTdVX4Yd6dlVrw7NbY?=
 =?us-ascii?Q?Z4tRPWU8Ws5XQ6bah7M0IrPKi/SsXPCHs50S9YN+mesakVl4/F26kD5BUhEd?=
 =?us-ascii?Q?h+KC0O5dR/5UL9Uok4a+C7fJeNoDtghYTHX6VWhD/jwRXEv21SenX/dtGKbM?=
 =?us-ascii?Q?EBJNWe8PnhHyYyLQHAgbzlWdpEx5v0hriN3rcHYRAWbg/tPl/5RZ1zRhz3HA?=
 =?us-ascii?Q?xZPR8OkCnoLZ3KCpvgv2fCOTEB2Scs8Gn3qwULku/aXumR7j1xrBOb0oYEEy?=
 =?us-ascii?Q?FySSlEslVaRQsWwN6R71mWFE+Pz9isaqEJSIaTHJSojn51AP5sH1l+1HUMw3?=
 =?us-ascii?Q?bV/gDOX1y8P18RnRu6S/YhkncHeCW99YAS9Gm+b8DAPCuDh5QO3ntQI/QoIT?=
 =?us-ascii?Q?uEQDifQhnlyTPm9AZ7REWDJUDzRt8ux18Dm7QFWq8hQJlxG5nhN2mSKWEwF9?=
 =?us-ascii?Q?mjsOpbGCI1CbN1EVS3HiUwqnfPPEM2ziXtsAPSnbmB2KGkWGQm7M1j/ZSHu4?=
 =?us-ascii?Q?yvy9/b9OofZJddn/vcgtY5k8TWcF1OSTrJZS4PkyT7Q68C0MA3vSYQr15WLF?=
 =?us-ascii?Q?7rtjZAAgC/9115iAtC3UYSZwrL7QK/gN7YC5A9jnQ923LzOd5ZWnWYPml/SR?=
 =?us-ascii?Q?bbidrYXXO1/A+BtNhqTCSScpXqeD/4f0mVplEJr3gU+0IUngNlZ3kTKDyyWe?=
 =?us-ascii?Q?npNh/WgNntrj1qNKCKY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3c84efe-1f2e-4174-1d87-08dace50305b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 19:15:03.1423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2r16kr4M9RuGynK/8iYRXTOzq40dFtPPgS25LoIppt1zRfEeAbbmgPJlcj5VpfC8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6487
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 31, 2022 at 03:27:56PM -0500, Bob Pearson wrote:
> Add a subroutine named rxe_num_mr_frags() to compute the
> number of skb frags needed to hold length bytes in an skb
> when sending data from an mr starting at iova.
> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_loc.h |  1 +
>  drivers/infiniband/sw/rxe/rxe_mr.c  | 68 +++++++++++++++++++++++++++++
>  2 files changed, 69 insertions(+)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
> index 81a611778d44..87fb052c1d0a 100644
> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> @@ -70,6 +70,7 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
>  int rxe_mr_init_fast(int max_pages, struct rxe_mr *mr);
>  int rxe_add_frag(struct sk_buff *skb, struct rxe_phys_buf *buf,
>  		 int length, int offset);
> +int rxe_num_mr_frags(struct rxe_mr *mr, u64 iova, int length);
>  int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
>  		enum rxe_mr_copy_op op);
>  int copy_data(struct rxe_pd *pd, int access, struct rxe_dma_info *dma,
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> index 2dcf37f32330..23abcf2a0198 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -320,6 +320,74 @@ int rxe_add_frag(struct sk_buff *skb, struct rxe_phys_buf *buf,
>  	return 0;
>  }
>  
> +/**
> + * rxe_num_mr_frags() - Compute the number of skb frags needed to copy
> + *			length bytes from an mr to an skb frag list.
> + * @mr: mr to copy data from
> + * @iova: iova in memory region as starting point
> + * @length: number of bytes to transfer
> + *
> + * Returns: the number of frags needed or a negative error
> + */
> +int rxe_num_mr_frags(struct rxe_mr *mr, u64 iova, int length)
> +{

This seems too complicated, and isn't quite right anyhow..

The umem code builds up the SGT by combining physically adjacent pages
into contiguous chunks. The key thing to notice is that it will
combine pages that are not part of the same folio (compound page) into
SGL entries. This is fine and well for a DMA device

However, when you build a skb frag you can only put a folio into
it, as it has exactly one struct page refcount that controls a folio
worth of memory lifetime.

So, eg, if the umem stuff allowed you to create a 64K page size MR, it
doesn't guarentee that the folios are 64K page size, and thus it
doesn't guarantee that you can use 64k skb frags later.

The best you can do is (after the xarray conversion) check what was
stuffed in the xarray and decide what the smallest folio size is within
the MR.

Then this is just simple math, num frags is computed as the number of
folios of smallest size that span the requested IOVA.

Jason
