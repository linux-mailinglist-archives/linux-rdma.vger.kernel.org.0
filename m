Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30816484FA6
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jan 2022 09:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbiAEI4V (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jan 2022 03:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238711AbiAEI4O (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jan 2022 03:56:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312F2C061761
        for <linux-rdma@vger.kernel.org>; Wed,  5 Jan 2022 00:56:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C348C6162F
        for <linux-rdma@vger.kernel.org>; Wed,  5 Jan 2022 08:56:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62BB3C36AEB;
        Wed,  5 Jan 2022 08:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641372973;
        bh=hAkecnQfjieFJ+aK988gHox1jayP9xwyqntzIlHEGzE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nRKQePemqUEld8Ks45ml+0UUVgVkCeRCoUiSTPxNsJnMTw66+I0nKqYKbaXV584QN
         JdfVFXzt+YsBYhg7Zhq2j3Sr++UsSs80xLPEwo8T/DZ6uiG8p9tsk5NYARaDCEtKTo
         71kt+0+OnA/9xYjzv6AStSiMMkPDkW8TDwwgFl6esxxf2vNI77XGqKF8OxtwTBBzrR
         TE4n2ymkt1/AgFXqX7RtJmuNuw+QrsTr6KIadUXKbzpeIOgAGxVBFdKswFTXr1EKQs
         Oe/TnEs5KD8aULe6HNm95hTUtZu2JJ5or0nCkDs2oVMZ4IiOWEZ0o15u8XHCwWQzwz
         mhLPlARO9totQ==
Date:   Wed, 5 Jan 2022 10:56:09 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     yanjun.zhu@linux.dev
Cc:     liangwenpeng@huawei.com, jgg@ziepe.ca, mustafa.ismail@intel.com,
        shiraz.saleem@intel.com, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH 5/5] RDMA/rxe: Remove the redundant randomization for UDP
 source port
Message-ID: <YdVdKU+jr5lHVaI3@unreal>
References: <YdVNi3EK2tZsywk/@unreal>
 <20220105221237.2659462-1-yanjun.zhu@linux.dev>
 <20220105221237.2659462-6-yanjun.zhu@linux.dev>
 <aa57e98b2ba3b86da11367ab13d4a96c@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa57e98b2ba3b86da11367ab13d4a96c@linux.dev>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 05, 2022 at 08:42:03AM +0000, yanjun.zhu@linux.dev wrote:
> January 5, 2022 3:49 PM, "Leon Romanovsky" <leon@kernel.org> wrote:
> 
> > On Wed, Jan 05, 2022 at 05:12:37PM -0500, yanjun.zhu@linux.dev wrote:
> > 
> >> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> >> 
> >> Since the UDP source port is modified in rxe_modify_qp, the randomization
> >> for UDP source port is redundant in this function. So remove it.
> >> 
> >> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> >> ---
> >> drivers/infiniband/sw/rxe/rxe_qp.c | 10 ++--------
> >> 1 file changed, 2 insertions(+), 8 deletions(-)
> >> 
> >> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
> >> index 54b8711321c1..84d6ffe7350a 100644
> >> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
> >> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
> >> @@ -210,15 +210,9 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
> >> return err;
> >> qp->sk->sk->sk_user_data = qp;
> >> 
> >> - /* pick a source UDP port number for this QP based on
> >> - * the source QPN. this spreads traffic for different QPs
> >> - * across different NIC RX queues (while using a single
> >> - * flow for a given QP to maintain packet order).
> >> - * the port number must be in the Dynamic Ports range
> >> - * (0xc000 - 0xffff).
> >> + /* Source UDP port number for this QP is modified in rxe_qp_modify.
> >> */
> > 
> > This makes me wonder why do we set this src_port here?
> > Are we using this field before modify QP?
> 
> The commit d3c04a3a6870 ("IB/rxe: vary the source udp port for receive scaling") sets this src_port here.
> 
> The advantage of setting src_port here is: before rxe_modify_qp, the src port is randomized, not 0xc000.
> So after/before rxe_modify_qp, the src port is the same value.
> 
> If the src port is changed in rxe_modify_qp, before rxe_modify_qp, the src port is 0xc000, after rxe_modify_qp,
> the src port is randomized, for example, src port is 0xF043.

I'm asking if you use qp->src_port between this line and rxe_modify_qp?

Thanks

> 
> So when the new method is adopted, I removed this.
> 
> Zhu Yanjun
> 
> > 
> > Thanks
> > 
> >> - qp->src_port = RXE_ROCE_V2_SPORT +
> >> - (hash_32_generic(qp_num(qp), 14) & 0x3fff);
> >> + qp->src_port = RXE_ROCE_V2_SPORT;
> >> qp->sq.max_wr = init->cap.max_send_wr;
> >> 
> >> /* These caps are limited by rxe_qp_chk_cap() done by the caller */
> >> --
> >> 2.27.0
