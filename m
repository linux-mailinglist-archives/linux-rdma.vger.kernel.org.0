Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8669C484FD6
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jan 2022 10:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbiAEJNe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jan 2022 04:13:34 -0500
Received: from out1.migadu.com ([91.121.223.63]:39436 "EHLO out1.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233496AbiAEJNd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 5 Jan 2022 04:13:33 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1641374011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7zEOKREcGrkoHdu6CBODaqgUUX7OznYkBPQqZDurajc=;
        b=JHSeeGIiaTgTSfYYRqTjUkiika6ah9h0PyuCJnnR0ha5lBsCJC2Jn2o+xzAm/HtzhogbNm
        ET4FUN1anZ/+RFmWS9yt8Qt4PhdPkO2FiIUBRpOvU11ijPXHTr9qFlrMkDbbes2h8+yEwT
        t+lGicHvXOo6ml+0y0mT/ijWYhPN+7M=
Date:   Wed, 05 Jan 2022 09:13:31 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   yanjun.zhu@linux.dev
Message-ID: <377b2cd0762ee3137efcfb545105564a@linux.dev>
Subject: Re: [PATCH 4/5] RDMA/rxe: Use the standard method to produce udp
 source port
To:     "Leon Romanovsky" <leon@kernel.org>,
        "Zhu Yanjun" <zyjzyj2000@gmail.com>
Cc:     liangwenpeng@huawei.com, "Jason Gunthorpe" <jgg@ziepe.ca>,
        mustafa.ismail@intel.com,
        "Shiraz Saleem" <shiraz.saleem@intel.com>,
        "RDMA mailing list" <linux-rdma@vger.kernel.org>
In-Reply-To: <YdVc5BMAaOh2aO2C@unreal>
References: <YdVc5BMAaOh2aO2C@unreal>
 <20220105221237.2659462-1-yanjun.zhu@linux.dev>
 <20220105221237.2659462-5-yanjun.zhu@linux.dev> <YdVONs32Ue7R0kk1@unreal>
 <CAD=hENeUv_7GjgDrZWr5wUmECtGY8=a=sPmbRanmh4zxLWzecA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

January 5, 2022 4:55 PM, "Leon Romanovsky" <leon@kernel.org> wrote:=0A=0A=
> On Wed, Jan 05, 2022 at 04:27:38PM +0800, Zhu Yanjun wrote:=0A> =0A>> O=
n Wed, Jan 5, 2022 at 3:52 PM Leon Romanovsky <leon@kernel.org> wrote:=0A=
>> =0A>> On Wed, Jan 05, 2022 at 05:12:36PM -0500, yanjun.zhu@linux.dev w=
rote:=0A>>> From: Zhu Yanjun <yanjun.zhu@linux.dev>=0A>>> =0A>>> Use the =
standard method to produce udp source port.=0A>>> =0A>>> Signed-off-by: Z=
hu Yanjun <yanjun.zhu@linux.dev>=0A>>> ---=0A>>> drivers/infiniband/sw/rx=
e/rxe_verbs.c | 6 ++++++=0A>>> 1 file changed, 6 insertions(+)=0A>>> =0A>=
>> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniban=
d/sw/rxe/rxe_verbs.c=0A>>> index 0aa0d7e52773..42fa81b455de 100644=0A>>> =
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c=0A>>> +++ b/drivers/infiniban=
d/sw/rxe/rxe_verbs.c=0A>>> @@ -469,6 +469,12 @@ static int rxe_modify_qp(=
struct ib_qp *ibqp, struct ib_qp_attr *attr,=0A>>> if (err)=0A>>> goto er=
r1;=0A>>> =0A>>> + if ((mask & IB_QP_AV) && (attr->ah_attr.ah_flags & IB_=
AH_GRH))=0A>> =0A>> You are leaving src_port default and wired to same po=
rt as other QPs=0A>> without any randomization.=0A>> =0A>> Hi,=0A>> =0A>>=
 I do not get you. Why do you think I am leaving src_pport default?=0A> =
=0A> Because in original code, you randomized src_port without any relati=
on=0A> to mask flags.=0A> =0A> qp->src_port =3D RXE_ROCE_V2_SPORT +=0A> (=
hash_32_generic(qp_num(qp), 14) & 0x3fff);=0A> =0A> After patch #5, if us=
er doesn't pass "proper" mask, you will leave=0A> qp->src_port to be equa=
l to RXE_ROCE_V2_SPORT, which is different from=0A> the current behaviour=
.=0A=0AAbout the "proper" mask, please check this link https://patchwork.=
kernel.org/project/linux-rdma/patch/20211218204438.1345160-1-yanjun.zhu@l=
inux.dev/=0A=0A"the udp_sport is only set when address vector and dest qp=
n (IB_QP_AV and IB_QP_DEST_QPN) is provided."=0A=0AZhu Yanjun=0A> =0A> Th=
anks=0A> =0A>> Thanks.=0A>> =0A>> Zhu Yanjun=0A>> =0A>> Thanks=0A>> =0A>>=
> + qp->src_port =3D rdma_get_udp_sport(attr->ah_attr.grh.flow_label,=0A>=
>> + qp->ibqp.qp_num,=0A>>> + qp->attr.dest_qp_num);=0A>>> +=0A>>> +=0A>>=
> return 0;=0A>>> =0A>>> err1:=0A>>> --=0A>>> 2.27.0=0A>>>
