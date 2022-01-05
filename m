Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C088C484F73
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jan 2022 09:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbiAEImG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jan 2022 03:42:06 -0500
Received: from out0.migadu.com ([94.23.1.103]:65490 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232259AbiAEImF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 5 Jan 2022 03:42:05 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1641372124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FoV7zWOu97CMcrf/g6B1VlK9RjTf/jYtIBkaW8QmUik=;
        b=JCrqRknB6nwhifKYu54tvlVml8ez81+jqO92tIycmnh61zOt0B9Z0Fi78P//ADxbFODIGl
        5Pe3rw9ybzXCgltv5Nj42AhAZxn8pKjd9y/5D25AbtcA0o0nRVmlUwzOtIQcQ7Da7t1W8/
        opoi958qDF9fP0WfxJ8fCfp1OVMRcNQ=
Date:   Wed, 05 Jan 2022 08:42:03 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   yanjun.zhu@linux.dev
Message-ID: <aa57e98b2ba3b86da11367ab13d4a96c@linux.dev>
Subject: Re: [PATCH 5/5] RDMA/rxe: Remove the redundant randomization for
 UDP source port
To:     "Leon Romanovsky" <leon@kernel.org>
Cc:     liangwenpeng@huawei.com, jgg@ziepe.ca, mustafa.ismail@intel.com,
        shiraz.saleem@intel.com, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
In-Reply-To: <YdVNi3EK2tZsywk/@unreal>
References: <YdVNi3EK2tZsywk/@unreal>
 <20220105221237.2659462-1-yanjun.zhu@linux.dev>
 <20220105221237.2659462-6-yanjun.zhu@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

January 5, 2022 3:49 PM, "Leon Romanovsky" <leon@kernel.org> wrote:=0A=0A=
> On Wed, Jan 05, 2022 at 05:12:37PM -0500, yanjun.zhu@linux.dev wrote:=
=0A> =0A>> From: Zhu Yanjun <yanjun.zhu@linux.dev>=0A>> =0A>> Since the U=
DP source port is modified in rxe_modify_qp, the randomization=0A>> for U=
DP source port is redundant in this function. So remove it.=0A>> =0A>> Si=
gned-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>=0A>> ---=0A>> drivers/infi=
niband/sw/rxe/rxe_qp.c | 10 ++--------=0A>> 1 file changed, 2 insertions(=
+), 8 deletions(-)=0A>> =0A>> diff --git a/drivers/infiniband/sw/rxe/rxe_=
qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c=0A>> index 54b8711321c1..84d6ff=
e7350a 100644=0A>> --- a/drivers/infiniband/sw/rxe/rxe_qp.c=0A>> +++ b/dr=
ivers/infiniband/sw/rxe/rxe_qp.c=0A>> @@ -210,15 +210,9 @@ static int rxe=
_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,=0A>> return err;=0A>=
> qp->sk->sk->sk_user_data =3D qp;=0A>> =0A>> - /* pick a source UDP port=
 number for this QP based on=0A>> - * the source QPN. this spreads traffi=
c for different QPs=0A>> - * across different NIC RX queues (while using =
a single=0A>> - * flow for a given QP to maintain packet order).=0A>> - *=
 the port number must be in the Dynamic Ports range=0A>> - * (0xc000 - 0x=
ffff).=0A>> + /* Source UDP port number for this QP is modified in rxe_qp=
_modify.=0A>> */=0A> =0A> This makes me wonder why do we set this src_por=
t here?=0A> Are we using this field before modify QP?=0A=0AThe commit d3c=
04a3a6870 ("IB/rxe: vary the source udp port for receive scaling") sets t=
his src_port here.=0A=0AThe advantage of setting src_port here is: before=
 rxe_modify_qp, the src port is randomized, not 0xc000.=0ASo after/before=
 rxe_modify_qp, the src port is the same value.=0A=0AIf the src port is c=
hanged in rxe_modify_qp, before rxe_modify_qp, the src port is 0xc000, af=
ter rxe_modify_qp,=0Athe src port is randomized, for example, src port is=
 0xF043.=0A=0ASo when the new method is adopted, I removed this.=0A=0AZhu=
 Yanjun=0A=0A> =0A> Thanks=0A> =0A>> - qp->src_port =3D RXE_ROCE_V2_SPORT=
 +=0A>> - (hash_32_generic(qp_num(qp), 14) & 0x3fff);=0A>> + qp->src_port=
 =3D RXE_ROCE_V2_SPORT;=0A>> qp->sq.max_wr =3D init->cap.max_send_wr;=0A>=
> =0A>> /* These caps are limited by rxe_qp_chk_cap() done by the caller =
*/=0A>> --=0A>> 2.27.0
