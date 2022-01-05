Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74702484FB8
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jan 2022 10:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238696AbiAEJDc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jan 2022 04:03:32 -0500
Received: from out2.migadu.com ([188.165.223.204]:34443 "EHLO out2.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238734AbiAEJDc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 5 Jan 2022 04:03:32 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1641373410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2nLN4ESWEUKVmUl9nk05Vcs05FZ50uO+NSQ3MfaoCz0=;
        b=OG2H5ZVMqOjXruzYyrqVbNkjnqiasJUhvYC210P6w6gc/RXDG/Tafd3XkDMglHsCzlgMPZ
        +8Fv+5c4zp2eC7p/IUcD1HFLc15rtoohCwNPX0YpLiuMTifkuA+v7UmhBXc9/+6jI1t3Iq
        JVt1M/aDESMPYM8lOV824KBuO2fQNAc=
Date:   Wed, 05 Jan 2022 09:03:29 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   yanjun.zhu@linux.dev
Message-ID: <571d68ebf5b25df8e1c6667da8a6ea8a@linux.dev>
Subject: Re: [PATCH 5/5] RDMA/rxe: Remove the redundant randomization for
 UDP source port
To:     "Leon Romanovsky" <leon@kernel.org>
Cc:     liangwenpeng@huawei.com, jgg@ziepe.ca, mustafa.ismail@intel.com,
        shiraz.saleem@intel.com, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
In-Reply-To: <YdVdKU+jr5lHVaI3@unreal>
References: <YdVdKU+jr5lHVaI3@unreal> <YdVNi3EK2tZsywk/@unreal>
 <20220105221237.2659462-1-yanjun.zhu@linux.dev>
 <20220105221237.2659462-6-yanjun.zhu@linux.dev>
 <aa57e98b2ba3b86da11367ab13d4a96c@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

January 5, 2022 4:56 PM, "Leon Romanovsky" <leon@kernel.org> wrote:=0A=0A=
> On Wed, Jan 05, 2022 at 08:42:03AM +0000, yanjun.zhu@linux.dev wrote:=
=0A> =0A>> January 5, 2022 3:49 PM, "Leon Romanovsky" <leon@kernel.org> w=
rote:=0A>> =0A>> On Wed, Jan 05, 2022 at 05:12:37PM -0500, yanjun.zhu@lin=
ux.dev wrote:=0A>> =0A>> From: Zhu Yanjun <yanjun.zhu@linux.dev>=0A>> =0A=
>> Since the UDP source port is modified in rxe_modify_qp, the randomizat=
ion=0A>> for UDP source port is redundant in this function. So remove it.=
=0A>> =0A>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>=0A>> ---=0A>=
> drivers/infiniband/sw/rxe/rxe_qp.c | 10 ++--------=0A>> 1 file changed,=
 2 insertions(+), 8 deletions(-)=0A>> =0A>> diff --git a/drivers/infiniba=
nd/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c=0A>> index 54b871=
1321c1..84d6ffe7350a 100644=0A>> --- a/drivers/infiniband/sw/rxe/rxe_qp.c=
=0A>> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c=0A>> @@ -210,15 +210,9 @@ =
static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,=0A>> r=
eturn err;=0A>> qp->sk->sk->sk_user_data =3D qp;=0A>> =0A>> - /* pick a s=
ource UDP port number for this QP based on=0A>> - * the source QPN. this =
spreads traffic for different QPs=0A>> - * across different NIC RX queues=
 (while using a single=0A>> - * flow for a given QP to maintain packet or=
der).=0A>> - * the port number must be in the Dynamic Ports range=0A>> - =
* (0xc000 - 0xffff).=0A>> + /* Source UDP port number for this QP is modi=
fied in rxe_qp_modify.=0A>> */=0A>> =0A>> This makes me wonder why do we =
set this src_port here?=0A>> Are we using this field before modify QP?=0A=
>> =0A>> The commit d3c04a3a6870 ("IB/rxe: vary the source udp port for r=
eceive scaling") sets this src_port=0A>> here.=0A>> =0A>> The advantage o=
f setting src_port here is: before rxe_modify_qp, the src port is randomi=
zed, not=0A>> 0xc000.=0A>> So after/before rxe_modify_qp, the src port is=
 the same value.=0A>> =0A>> If the src port is changed in rxe_modify_qp, =
before rxe_modify_qp, the src port is 0xc000, after=0A>> rxe_modify_qp,=
=0A>> the src port is randomized, for example, src port is 0xF043.=0A> =
=0A> I'm asking if you use qp->src_port between this line and rxe_modify_=
qp?=0A=0AThere are only 2 udp packets between this line and rxe_modify_qp=
.=0A=0AZhu Yanjun=0A=0A> =0A> Thanks=0A> =0A>> So when the new method is =
adopted, I removed this.=0A>> =0A>> Zhu Yanjun=0A>> =0A>> Thanks=0A>> =0A=
>> - qp->src_port =3D RXE_ROCE_V2_SPORT +=0A>> - (hash_32_generic(qp_num(=
qp), 14) & 0x3fff);=0A>> + qp->src_port =3D RXE_ROCE_V2_SPORT;=0A>> qp->s=
q.max_wr =3D init->cap.max_send_wr;=0A>> =0A>> /* These caps are limited =
by rxe_qp_chk_cap() done by the caller */=0A>> --=0A>> 2.27.0
