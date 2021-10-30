Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF014440701
	for <lists+linux-rdma@lfdr.de>; Sat, 30 Oct 2021 04:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbhJ3C5v (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 Oct 2021 22:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbhJ3C5u (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 29 Oct 2021 22:57:50 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800ADC061570
        for <linux-rdma@vger.kernel.org>; Fri, 29 Oct 2021 19:55:21 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1635562519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5nXIs9d85YvUriooiiYhQ+zuEmnRGY78BItKZMKCcso=;
        b=xLS2vPHgCqcBnsUotjZNKShMULhb+7wY0/1trmyhOTeA7k+uENFz/s5yUaOUTOSamXM8/r
        1pZ6vOdCOEvUPPcGDVjmQTp3CPShUUJD6ozgObKIx+0c4/vVx+aNNnb2ZChp5FlAR42Sd/
        3u93EyPJVzEgbqAgcLOAOkqMcccxKjc=
Date:   Sat, 30 Oct 2021 02:55:18 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   yanjun.zhu@linux.dev
Message-ID: <2b15fa90db74b2c4d200e058de3d9710@linux.dev>
Subject: Re: [PATCH 1/1] RDMA/irdma: optimize rx path by removing
 unnecessary copy
To:     "Saleem, Shiraz" <shiraz.saleem@intel.com>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>, dledford@redhat.com,
        jgg@ziepe.ca, linux-rdma@vger.kernel.org, leonro@nvidia.com
In-Reply-To: <731072121b4245d2beefd07ce1cb757f@intel.com>
References: <731072121b4245d2beefd07ce1cb757f@intel.com>
 <20211029162340.241768-1-yanjun.zhu@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: yanjun.zhu@linux.dev
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

October 30, 2021 3:53 AM, "Saleem, Shiraz" <shiraz.saleem@intel.com> wrot=
e:=0A=0A>> Subject: [PATCH 1/1] RDMA/irdma: optimize rx path by removing =
unnecessary=0A>> copy=0A>> =0A>> From: Zhu Yanjun <yanjun.zhu@linux.dev>=
=0A>> =0A>> In the function irdma_post_recv, the function irdma_copy_sg_l=
ist is not needed=0A>> since the struct irdma_sge and ib_sge have the sim=
ilar member variables. The=0A>> struct irdma_sge can be replaced with the=
 struct ib_sge totally.=0A>> =0A>> This can increase the rx performance o=
f irdma.=0A>> =0A>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>=0A>>=
 ---=0A>> drivers/infiniband/hw/irdma/uk.c | 38 +++++++++++++------------=
-=0A>> drivers/infiniband/hw/irdma/user.h | 23 ++++++----------=0A>> driv=
ers/infiniband/hw/irdma/verbs.c | 41 +++++++++--------------------=0A>> 3=
 files changed, 39 insertions(+), 63 deletions(-)=0A> =0A> Thanks much fo=
r the patch! Minor comment...=0A> =0A> [....]=0A> =0A>> a/drivers/infinib=
and/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c=0A>> index 02c=
a1f80968e..7ab9645d6f18 100644=0A>> --- a/drivers/infiniband/hw/irdma/ver=
bs.c=0A>> +++ b/drivers/infiniband/hw/irdma/verbs.c=0A>> @@ -3039,24 +303=
9,6 @@ static int irdma_dereg_mr(struct ib_mr *ib_mr, struct=0A>> ib_udat=
a *udata)=0A>> return 0;=0A>> }=0A>> =0A>> -/**=0A>> - * irdma_copy_sg_li=
st - copy sg list for qp=0A>> - * @sg_list: copied into sg_list=0A>> - * =
@sgl: copy from sgl=0A>> - * @num_sges: count of sg entries=0A>> - */=0A>=
> -static void irdma_copy_sg_list(struct irdma_sge *sg_list, struct ib_sg=
e *sgl,=0A>> - int num_sges)=0A>> -{=0A>> - unsigned int i;=0A>> -=0A>> -=
 for (i =3D 0; (i < num_sges) && (i < IRDMA_MAX_WQ_FRAGMENT_COUNT);=0A>> =
i++) {=0A>> - sg_list[i].tag_off =3D sgl[i].addr;=0A>> - sg_list[i].len =
=3D sgl[i].length;=0A>> - sg_list[i].stag =3D sgl[i].lkey;=0A>> - }=0A>> =
-}=0A>> -=0A>> /**=0A>> * irdma_post_send - kernel application wr=0A>> * =
@ibqp: qp ptr for wr=0A>> @@ -3133,7 +3115,7 @@ static int irdma_post_sen=
d(struct ib_qp *ibqp,=0A>> ret =3D irdma_uk_inline_send(ukqp, &info, fals=
e);=0A>> } else {=0A>> info.op.send.num_sges =3D ib_wr->num_sge;=0A>> - i=
nfo.op.send.sg_list =3D (struct irdma_sge *)=0A>> + info.op.send.sg_list =
=3D (struct ib_sge *)=0A>> ib_wr->sg_list;=0A> =0A> Don't think we need t=
he typecast.=0A=0AGot it. Thanks. A new patch is sent for review.=0AIn th=
e new patch, the unnecessary typecast is removed.=0A=0AZhu Yanjun=0A=0A> =
=0A> Shiraz
