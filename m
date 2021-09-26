Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47D5B41882A
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Sep 2021 12:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbhIZKxa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 26 Sep 2021 06:53:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:45182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230025AbhIZKxa (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 26 Sep 2021 06:53:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA2D360EE5;
        Sun, 26 Sep 2021 10:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632653514;
        bh=TiMCxXYJDYAqlurhwwMOxkHecI7TK/cq887hYQ2v8+I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V88cs1FcTbaXm5LS1gj+DZjtieDy2ANuKVVFhVzIK1baMHsWWdLXgIaDjktxnjhk3
         y4Hk3uBBzsZWovO/yhMOMRUoZi9fGTyWHOdXH8Eszs0ZpXDbt4RtryV/V3HgZFgVpk
         mbURY/7pYu0rDkf70vn8YzwIBVzn1S1Yx91d6qnh7NJxc6eSZu0xjhH22is9x+sDwc
         9J4xdeGa3gDwCT9dTJJGZQpxnLRI/MaI5NocVyqwsS7hiwBmKB0nLEbue6rndLscrQ
         Omc6X4oTqX5DUJ1VjHtzFnAB4+6UTF9kyMU6EE1IPGqnsB5zycculGqcO4cy2sXw2Q
         qhaK9EzR4nf3g==
Date:   Sun, 26 Sep 2021 13:51:50 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Xiao Yang <yangx.jy@fujitsu.com>
Cc:     linux-rdma@vger.kernel.org, rpearsonhpe@gmail.com,
        zyjzyj2000@gmail.com, jgg@nvidia.com
Subject: Re: [PATCH v2] providers/rxe: Set the correct value of resid for
 inline data
Message-ID: <YVBQxpzX8SVvaspe@unreal>
References: <20210809150738.150596-1-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210809150738.150596-1-yangx.jy@fujitsu.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 09, 2021 at 11:07:38PM +0800, Xiao Yang wrote:
> Resid indicates the residual length of transmitted bytes but current
> rxe sets it to zero for inline data at the beginning.  In this case,
> request will transmit zero byte to responder wrongly.
>=20
> Resid should be set to the total length of transmitted bytes at the
> beginning.
>=20
> Note:
> Just remove the useless setting of resid in init_send_wqe().
>=20
> Fixes: 1a894ca10105 ("Providers/rxe: Implement ibv_create_qp_ex verb")
> Fixes: 8337db5df125 ("Providers/rxe: Implement memory windows")
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---
>  providers/rxe/rxe.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Thanks, applied.
