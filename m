Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C8364C474
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Dec 2022 08:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237440AbiLNHkj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 14 Dec 2022 02:40:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237539AbiLNHki (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 14 Dec 2022 02:40:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D4D19283
        for <linux-rdma@vger.kernel.org>; Tue, 13 Dec 2022 23:40:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8018CB8161C
        for <linux-rdma@vger.kernel.org>; Wed, 14 Dec 2022 07:40:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93507C433EF;
        Wed, 14 Dec 2022 07:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671003635;
        bh=EhhzGiWTQ/U6Ns1ANiOxYXj8OjsStAgYCTUm9j3egKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cnmJMylPiVZknX8qh5Ps1U0CU4rM7IvhXseF2VDdwHw7w/kruehZ5n9ExUm2TkP7o
         bS3qddG9S71B3J1GTmq8W9LKATSdKQe4JxN/KQcvoGfMFNUV2gow8RX6nB0Vz2CaDp
         +5XGRdzSXsydLuvjb3zXrSHJzVqfvtPB/lU0IHSAupFVfOvF3RMNP8vCZgAN8wb1QH
         g2KFK51F1W9c1mS15usJnEpfkx5cmXtJAeQT91oA71TIG3Gm/aRAyx4r/HOFq3vsvf
         5F12j02Gk8BDNWHld0jKkdnOaD4EtdzcHEiEE0rHsqJlgE4GB0zs94mYTO0ap32mCr
         BLJyiFHuotATQ==
Date:   Wed, 14 Dec 2022 09:40:30 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Yanjun Zhu <yanjun.zhu@linux.dev>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <Y5l97q27hU5d8pU2@unreal>
References: <Y5jpKmpwhTAf+r8B@nvidia.com>
 <7601dc11-f1b5-5488-727a-13b4016c8aa5@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7601dc11-f1b5-5488-727a-13b4016c8aa5@linux.dev>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 14, 2022 at 10:23:29AM +0800, Yanjun Zhu wrote:
> 在 2022/12/14 5:05, Jason Gunthorpe 写道:
> > Hi Linus,
> > 
> > This cycle saw a new driver called MANA get merged and more fixing to
> > the other recently merged drivers. rxe continues to see a lot of
> > interest and fixing. Lots more rxe patches already in the works for
> > the next cycle.
> > 
> > Thanks,
> > Jason

<...>

> > Zhu Yanjun (2):
> >        RDMA/rxe: Remove reliable datagram support
> >        RDMA/mlx5: Remove not-used IB_FLOW_SPEC_IB define
> 
> I do not like this subject. I still like my old one.
> With the old one, it suggests that IB_FLOW_SPEC is not supported in MLX5 in
> subject line.

Right now, mlx5 doesn't implement this IB_FLOW_SPEC and define is not
used. It doesn't mean that it is not supported.

Thanks
