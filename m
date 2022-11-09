Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDEFA62320A
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Nov 2022 19:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiKISHm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Nov 2022 13:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKISHm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Nov 2022 13:07:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD39AAE59;
        Wed,  9 Nov 2022 10:07:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C26D61965;
        Wed,  9 Nov 2022 18:07:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B142C433D6;
        Wed,  9 Nov 2022 18:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668017259;
        bh=7lOwH/bvhA4LymsetIwUKnFn32htLcX3QCLc6elGqCM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kDYRY1D4ADbbJQegUJWcFVkysFqcEo06K3PKeNPPFJds3PvUwipkpP6vvU3wttQT6
         cvQdJFThPikDfSJ22fQt87PeBAQ7+50KYxLrkY67vDN+h1yzXpESJZYxpBAb5VeGAu
         tCl5kzzCwm8ou78KjFqylUsZ5ZTmY4T5Q2E/UnkNtsSJbaZIwPjFJ2t8RX+VXjQZRX
         rUD1SGsatbclA0jdFOkCVVwv9yNK2pvYOkClwE0JYPKJZwqZs5PgSnbzKwoyfEcqO5
         tG5wjuGQVZ9/rE0eFZgrwE2Xzy4v0uUWZ38bZrowgg5vnm1S4sdibjC96CSXDY/pZ+
         0p+0tCeWyfSrA==
Date:   Wed, 9 Nov 2022 20:07:35 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Haoyue Xu <xuhaoyue1@hisilicon.com>, jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 for-rc 0/2] Fix sge_num bug
Message-ID: <Y2vsZ+qPWJI/R94M@unreal>
References: <20221108133847.2304539-1-xuhaoyue1@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108133847.2304539-1-xuhaoyue1@hisilicon.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 08, 2022 at 09:38:45PM +0800, Haoyue Xu wrote:
> The patchset mainly fixes the sge_num bug relates to sq_inline.
> 
> Changes since v2:
> 1. Move the refactor rq_inline and new CQE inline patches to go 
> into for-next after this bugfix apply.
> 2. Change the commit message to better explain the bug.
> V2 Link: https://patchwork.kernel.org/project/linux-rdma/cover/20221026095054.2384620-1-xuhaoyue1@hisilicon.com/
> 
> Luoyouming (2):
>   RDMA/hns: Fix ext_sge num error when post send
>   RDMA/hns: Fix the problem of sge nums
> 
>  drivers/infiniband/hw/hns/hns_roce_device.h |   3 +
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |   3 +-
>  drivers/infiniband/hw/hns/hns_roce_main.c   |  18 +++-
>  drivers/infiniband/hw/hns/hns_roce_qp.c     | 107 ++++++++++++++++----
>  include/uapi/rdma/hns-abi.h                 |  15 +++

Jason,

I think that it was you who asked to send it to -rc. Given the amount of
changes together with UAPI in second patch, are you sure that it is -rc4
material?

Thanks

>  5 files changed, 125 insertions(+), 21 deletions(-)
> 
> -- 
> 2.30.0
> 
