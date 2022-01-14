Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B676748E727
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jan 2022 10:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbiANJKk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Jan 2022 04:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbiANJKk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 14 Jan 2022 04:10:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64616C061574;
        Fri, 14 Jan 2022 01:10:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0623661B76;
        Fri, 14 Jan 2022 09:10:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13CA4C36AE9;
        Fri, 14 Jan 2022 09:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642151439;
        bh=BgnqRXbrYCJ6e+fKoAFI5d8seqgDU4hUCDIJZkCHAyU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rGhk3dkQsvSwSp8qDpByiT/eUlS0irN3IKnqbz1mCPN3NoDNZYhhpYj6fIZRJc/A+
         GZMSuDlhtzKEDTd/7bHBFod+VATdQ4/Dbt4NcFpR2EhfPramX2faDPdleLo0gfJ9P/
         vT6rq7RbYAK9PQjSrgyRim9IVRE3RCwtFBXCLkLVp/m1PG5/wgNXkxy6K9bIdyPKhf
         pKF2+dcrm/0Tp5NIz8Eb8Gw+AnDNHvZYcw9jxD8It0hiRACtkZg67ARBXG2DMo/0MC
         4KBC60YYOZX2STT5lFkDgX9zVeITiAjXIsl6/pRB43iFeM+OPJvvgeIpmCbdhUiIUZ
         6ssr5BJ57jRUw==
Date:   Fri, 14 Jan 2022 11:10:31 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Ryan Cai <ryancaicse@gmail.com>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: mlx5: memory leaks
Message-ID: <YeE+Bw3IoAIZZZ/h@unreal>
References: <76193B8E-6A8B-4FF9-B6BB-A3A17FB74A61@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76193B8E-6A8B-4FF9-B6BB-A3A17FB74A61@gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 13, 2022 at 12:37:10PM +0800, Ryan Cai wrote:
> Hi, Kernel Maintainers,
> 
>     In method mlx5_ib_destroy_gsi of gsi.c, there are memory leaks when ret = ib_destroy_qp(gsi->rx_qp); returns true? I think, ib_free_cq(gsi->cq); kfree(gsi->outstanding_wrs); kfree(gsi->tx_qps); should also be put before return ret before Line 180. If this is a real bug, I can send a patch. Thanks!

The ib_destroy_qp() is function that destroys kernel QP that in our
memory model shouldn't fail. The patch that converts ib_destroy_qp()
to be void is very welcomed.

See ib_destroy_srq() as an example of expected function format.

Thanks
