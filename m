Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E306466B5D3
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Jan 2023 04:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbjAPDD7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Jan 2023 22:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjAPDD6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 15 Jan 2023 22:03:58 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764E935AC
        for <linux-rdma@vger.kernel.org>; Sun, 15 Jan 2023 19:03:57 -0800 (PST)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1673838236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nd52o2w56ABzGZHrYoJ9SSlxfmwkqQqfBIlqt0p7idk=;
        b=tLc6HSxPNerq5hJaMRGeYP2V0UoZIzOh0l56iAQ7qcYIZK1BBY5WqKw80TeHJUaQxGAKVt
        Ji3gWGeQdtKKisRcTYF4oQ98sl2wweKhhjiHs0wZQNLq18a7E9TYuhlWgMsFEXlKhtc2my
        mw/v1YIL8qtmBol30pxgf+weSpMnlmg=
Date:   Mon, 16 Jan 2023 03:03:55 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   yanjun.zhu@linux.dev
Message-ID: <a3d9e71659d80d619923b092e229b968@linux.dev>
Subject: Re: [PATCHv2 for-next 4/4] RDMA/irdma: Split CQ handler into
 irdma_reg_user_mr_type_cq
To:     "Leon Romanovsky" <leon@kernel.org>,
        "Zhu Yanjun" <yanjun.zhu@intel.com>
Cc:     mustafa.ismail@intel.com, shiraz.saleem@intel.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org
In-Reply-To: <Y8PjTUxb/9HJ7XWH@unreal>
References: <Y8PjTUxb/9HJ7XWH@unreal>
 <20230112000617.1659337-1-yanjun.zhu@intel.com>
 <20230112000617.1659337-5-yanjun.zhu@intel.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

January 15, 2023 7:28 PM, "Leon Romanovsky" <leon@kernel.org> wrote:=0A=
=0A> On Wed, Jan 11, 2023 at 07:06:17PM -0500, Zhu Yanjun wrote:=0A> =0A>=
> From: Zhu Yanjun <yanjun.zhu@linux.dev>=0A>> =0A>> Split the source cod=
es related with CQ handling into a new function.=0A>> =0A>> Signed-off-by=
: Zhu Yanjun <yanjun.zhu@linux.dev>=0A>> ---=0A>> drivers/infiniband/hw/i=
rdma/verbs.c | 63 +++++++++++++++++------------=0A>> 1 file changed, 37 i=
nsertions(+), 26 deletions(-)=0A>> =0A>> diff --git a/drivers/infiniband/=
hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c=0A>> index 74dd197=
2c325..3902c74d59f2 100644=0A>> --- a/drivers/infiniband/hw/irdma/verbs.c=
=0A>> +++ b/drivers/infiniband/hw/irdma/verbs.c=0A>> @@ -2867,6 +2867,40 =
@@ static int irdma_reg_user_mr_type_qp(struct irdma_mem_reg_req req,=0A>=
> return err;=0A>> }=0A>> =0A>> +static int irdma_reg_user_mr_type_cq(str=
uct irdma_mem_reg_req req,=0A>> + struct ib_udata *udata,=0A>> + struct i=
rdma_mr *iwmr)=0A>> +{=0A>> + int err;=0A>> + u8 shadow_pgcnt =3D 1;=0A>>=
 + bool use_pbles;=0A>> + struct irdma_ucontext *ucontext;=0A>> + unsigne=
d long flags;=0A>> + u32 total;=0A>> + struct irdma_pbl *iwpbl =3D &iwmr-=
>iwpbl;=0A>> + struct irdma_device *iwdev =3D to_iwdev(iwmr->ibmr.device)=
;=0A> =0A> It will be nice to see more structured variable initialization=
.=0A> =0A> I'm not going to insist on it, but IMHO netdev reverse Christm=
as=0A> tree rule looks more appealing than this random list.=0A=0AGot it.=
 The structured variables are initialized.=0AAnd the netdev reverse Chris=
tmas tree rule is used in the commits.=0A=0A> =0A>> +=0A>> + if (iwdev->r=
f->sc_dev.hw_attrs.uk_attrs.feature_flags & IRDMA_FEATURE_CQ_RESIZE)=0A>>=
 + shadow_pgcnt =3D 0;=0A>> + total =3D req.cq_pages + shadow_pgcnt;=0A>>=
 + if (total > iwmr->page_cnt)=0A>> + return -EINVAL;=0A>> +=0A>> + use_p=
bles =3D (req.cq_pages > 1);=0A>> + err =3D irdma_handle_q_mem(iwdev, &re=
q, iwpbl, use_pbles);=0A>> + if (err)=0A>> + return err;=0A>> +=0A>> + uc=
ontext =3D rdma_udata_to_drv_context(udata, struct irdma_ucontext,=0A>> +=
 ibucontext);=0A>> + spin_lock_irqsave(&ucontext->cq_reg_mem_list_lock, f=
lags);=0A>> + list_add_tail(&iwpbl->list, &ucontext->cq_reg_mem_list);=0A=
>> + iwpbl->on_list =3D true;=0A>> + spin_unlock_irqrestore(&ucontext->cq=
_reg_mem_list_lock, flags);=0A>> +=0A>> + return err;=0A> =0A> return 0;=
=0A=0AI will send out the latest commits very soon.=0A=0AZhu Yanjun=0A=0A=
> =0A>> +}=0A>> +=0A>> /**=0A>> * irdma_reg_user_mr - Register a user mem=
ory region=0A>> * @pd: ptr of pd=0A>> @@ -2882,16 +2916,10 @@ static stru=
ct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64=0A>> len,=0A=
>> {=0A>> #define IRDMA_MEM_REG_MIN_REQ_LEN offsetofend(struct irdma_mem_=
reg_req, sq_pages)=0A>> struct irdma_device *iwdev =3D to_iwdev(pd->devic=
e);=0A>> - struct irdma_ucontext *ucontext;=0A>> - struct irdma_pbl *iwpb=
l;=0A>> struct irdma_mr *iwmr;=0A>> struct ib_umem *region;=0A>> struct i=
rdma_mem_reg_req req;=0A>> - u32 total;=0A>> - u8 shadow_pgcnt =3D 1;=0A>=
> - bool use_pbles =3D false;=0A>> - unsigned long flags;=0A>> - int err =
=3D -EINVAL;=0A>> + int err;=0A>> =0A>> if (len > iwdev->rf->sc_dev.hw_at=
trs.max_mr_size)=0A>> return ERR_PTR(-EINVAL);=0A>> @@ -2918,8 +2946,6 @@=
 static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 =
len,=0A>> return (struct ib_mr *)iwmr;=0A>> }=0A>> =0A>> - iwpbl =3D &iwm=
r->iwpbl;=0A>> -=0A>> switch (req.reg_type) {=0A>> case IRDMA_MEMREG_TYPE=
_QP:=0A>> err =3D irdma_reg_user_mr_type_qp(req, udata, iwmr);=0A>> @@ -2=
928,25 +2954,9 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd=
, u64 start, u64 len,=0A>> =0A>> break;=0A>> case IRDMA_MEMREG_TYPE_CQ:=
=0A>> - if (iwdev->rf->sc_dev.hw_attrs.uk_attrs.feature_flags & IRDMA_FEA=
TURE_CQ_RESIZE)=0A>> - shadow_pgcnt =3D 0;=0A>> - total =3D req.cq_pages =
+ shadow_pgcnt;=0A>> - if (total > iwmr->page_cnt) {=0A>> - err =3D -EINV=
AL;=0A>> - goto error;=0A>> - }=0A>> -=0A>> - use_pbles =3D (req.cq_pages=
 > 1);=0A>> - err =3D irdma_handle_q_mem(iwdev, &req, iwpbl, use_pbles);=
=0A>> + err =3D irdma_reg_user_mr_type_cq(req, udata, iwmr);=0A>> if (err=
)=0A>> goto error;=0A>> -=0A>> - ucontext =3D rdma_udata_to_drv_context(u=
data, struct irdma_ucontext,=0A>> - ibucontext);=0A>> - spin_lock_irqsave=
(&ucontext->cq_reg_mem_list_lock, flags);=0A>> - list_add_tail(&iwpbl->li=
st, &ucontext->cq_reg_mem_list);=0A>> - iwpbl->on_list =3D true;=0A>> - s=
pin_unlock_irqrestore(&ucontext->cq_reg_mem_list_lock, flags);=0A>> break=
;=0A>> case IRDMA_MEMREG_TYPE_MEM:=0A>> err =3D irdma_reg_user_mr_type_me=
m(iwmr, access);=0A>> @@ -2955,6 +2965,7 @@ static struct ib_mr *irdma_re=
g_user_mr(struct ib_pd *pd, u64 start, u64 len,=0A>> =0A>> break;=0A>> de=
fault:=0A>> + err =3D -EINVAL;=0A>> goto error;=0A>> }=0A>> =0A>> --=0A>>=
 2.31.1
