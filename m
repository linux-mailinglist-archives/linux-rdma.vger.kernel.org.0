Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C54C66B5CB
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Jan 2023 03:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjAPC6j (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Jan 2023 21:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbjAPC6h (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 15 Jan 2023 21:58:37 -0500
Received: from out-74.mta0.migadu.com (out-74.mta0.migadu.com [IPv6:2001:41d0:1004:224b::4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E184472BA
        for <linux-rdma@vger.kernel.org>; Sun, 15 Jan 2023 18:58:36 -0800 (PST)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1673837914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PHvZ3Xq9JNC6cNLOYEp/RzF5+IOj6BQSuCEVLiWGdKg=;
        b=u3/2W/SjGQVVPMVTuSTv2Oc+ZH5l/JaTJ1ccvLsi0hUzskZ/nmhK7jaaPzbhBqmxsqkVaP
        iYNbmEPczWBu9CodxYU/0cPWF4bKvqCw3yD0i74aLWX6IFBRqb759tR/F2i9CKPXedrdeP
        uMNr27s6Ig2e1bRGlijFlRZfum65Y0o=
Date:   Mon, 16 Jan 2023 02:58:34 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   yanjun.zhu@linux.dev
Message-ID: <5bcb5acbc6d6d3339f25a0207b2c25ee@linux.dev>
Subject: Re: [PATCHv2 for-next 3/4] RDMA/irdma: Split QP handler into
 irdma_reg_user_mr_type_qp
To:     "Leon Romanovsky" <leon@kernel.org>,
        "Zhu Yanjun" <yanjun.zhu@intel.com>
Cc:     mustafa.ismail@intel.com, shiraz.saleem@intel.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org
In-Reply-To: <Y8PiQz47jQurznMH@unreal>
References: <Y8PiQz47jQurznMH@unreal>
 <20230112000617.1659337-1-yanjun.zhu@intel.com>
 <20230112000617.1659337-4-yanjun.zhu@intel.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

January 15, 2023 7:23 PM, "Leon Romanovsky" <leon@kernel.org> wrote:=0A=
=0A> On Wed, Jan 11, 2023 at 07:06:16PM -0500, Zhu Yanjun wrote:=0A> =0A>=
> From: Zhu Yanjun <yanjun.zhu@linux.dev>=0A>> =0A>> Split the source cod=
es related with QP handling into a new function.=0A>> =0A>> Signed-off-by=
: Zhu Yanjun <yanjun.zhu@linux.dev>=0A>> ---=0A>> drivers/infiniband/hw/i=
rdma/verbs.c | 48 ++++++++++++++++++++---------=0A>> 1 file changed, 34 i=
nsertions(+), 14 deletions(-)=0A>> =0A>> diff --git a/drivers/infiniband/=
hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c=0A>> index f471227=
6b920..74dd1972c325 100644=0A>> --- a/drivers/infiniband/hw/irdma/verbs.c=
=0A>> +++ b/drivers/infiniband/hw/irdma/verbs.c=0A>> @@ -2834,6 +2834,39 =
@@ static void irdma_free_iwmr(struct irdma_mr *iwmr)=0A>> kfree(iwmr);=
=0A>> }=0A>> =0A>> +static int irdma_reg_user_mr_type_qp(struct irdma_mem=
_reg_req req,=0A>> + struct ib_udata *udata,=0A>> + struct irdma_mr *iwmr=
)=0A>> +{=0A>> + u32 total;=0A>> + int err;=0A>> + u8 shadow_pgcnt =3D 1;=
=0A> =0A> It is constant, you don't need variable for that.=0A=0AGot it. =
The variable is removed.=0A=0A> =0A>> + bool use_pbles;=0A>> + unsigned l=
ong flags;=0A>> + struct irdma_ucontext *ucontext;=0A>> + struct irdma_pb=
l *iwpbl =3D &iwmr->iwpbl;=0A>> + struct irdma_device *iwdev =3D to_iwdev=
(iwmr->ibmr.device);=0A>> +=0A>> + total =3D req.sq_pages + req.rq_pages =
+ shadow_pgcnt;=0A>> + if (total > iwmr->page_cnt)=0A>> + return -EINVAL;=
=0A>> +=0A>> + total =3D req.sq_pages + req.rq_pages;=0A>> + use_pbles =
=3D (total > 2);=0A> =0A> There is no need in brackets here.=0A=0AThe bra=
ckets are removed in the latest commit.=0A=0A> =0A>> + err =3D irdma_hand=
le_q_mem(iwdev, &req, iwpbl, use_pbles);=0A>> + if (err)=0A>> + return er=
r;=0A>> +=0A>> + ucontext =3D rdma_udata_to_drv_context(udata, struct ird=
ma_ucontext,=0A>> + ibucontext);=0A>> + spin_lock_irqsave(&ucontext->qp_r=
eg_mem_list_lock, flags);=0A>> + list_add_tail(&iwpbl->list, &ucontext->q=
p_reg_mem_list);=0A>> + iwpbl->on_list =3D true;=0A>> + spin_unlock_irqre=
store(&ucontext->qp_reg_mem_list_lock, flags);=0A>> +=0A>> + return err;=
=0A> =0A> return 0;=0A=0AGot it.=0A=0AZhu Yanjun=0A=0A> =0A>> +}=0A>> +=
=0A>> /**=0A>> * irdma_reg_user_mr - Register a user memory region=0A>> *=
 @pd: ptr of pd=0A>> @@ -2889,23 +2922,10 @@ static struct ib_mr *irdma_r=
eg_user_mr(struct ib_pd *pd, u64 start, u64=0A>> len,=0A>> =0A>> switch (=
req.reg_type) {=0A>> case IRDMA_MEMREG_TYPE_QP:=0A>> - total =3D req.sq_p=
ages + req.rq_pages + shadow_pgcnt;=0A>> - if (total > iwmr->page_cnt) {=
=0A>> - err =3D -EINVAL;=0A>> - goto error;=0A>> - }=0A>> - total =3D req=
.sq_pages + req.rq_pages;=0A>> - use_pbles =3D (total > 2);=0A>> - err =
=3D irdma_handle_q_mem(iwdev, &req, iwpbl, use_pbles);=0A>> + err =3D ird=
ma_reg_user_mr_type_qp(req, udata, iwmr);=0A>> if (err)=0A>> goto error;=
=0A>> =0A>> - ucontext =3D rdma_udata_to_drv_context(udata, struct irdma_=
ucontext,=0A>> - ibucontext);=0A>> - spin_lock_irqsave(&ucontext->qp_reg_=
mem_list_lock, flags);=0A>> - list_add_tail(&iwpbl->list, &ucontext->qp_r=
eg_mem_list);=0A>> - iwpbl->on_list =3D true;=0A>> - spin_unlock_irqresto=
re(&ucontext->qp_reg_mem_list_lock, flags);=0A>> break;=0A>> case IRDMA_M=
EMREG_TYPE_CQ:=0A>> if (iwdev->rf->sc_dev.hw_attrs.uk_attrs.feature_flags=
 & IRDMA_FEATURE_CQ_RESIZE)=0A>> --=0A>> 2.31.1
