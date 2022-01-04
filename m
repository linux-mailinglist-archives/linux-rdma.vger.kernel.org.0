Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 717A2483D36
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jan 2022 08:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbiADHv7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jan 2022 02:51:59 -0500
Received: from out0.migadu.com ([94.23.1.103]:48519 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229757AbiADHv5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 4 Jan 2022 02:51:57 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1641282716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yTi34kMvV8JQvl34SNkjcd+by0Gz0kkpJiBHVg9xyxQ=;
        b=ER4gKW8sJl+opaVTSL2vcpGwbdUC8Brdpsx6rzJkr5CkX2owwWbjWwCEpSX54uNpSNPF2+
        iezospRky29v3JbMT71R/MzDtgZpYIw+5YVDjBzaN2k6QHFi3GCYqlDAY6N0+ZD2/2BsSt
        sSIc3yH0pNBJDfnFEzdVvJvCRUv8PtU=
Date:   Tue, 04 Jan 2022 07:51:54 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   yanjun.zhu@linux.dev
Message-ID: <b5c7448edd6e87faa448236fcf99d650@linux.dev>
Subject: Re: [PATCHv3 1/1] RDMA/irdma: Make the source udp port vary
To:     "Leon Romanovsky" <leon@kernel.org>
Cc:     mustafa.ismail@intel.com, shiraz.saleem@intel.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org
In-Reply-To: <YdLGIs6LQLIooiIn@unreal>
References: <YdLGIs6LQLIooiIn@unreal>
 <20211221173913.1386261-1-yanjun.zhu@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

January 3, 2022 5:47 PM, "Leon Romanovsky" <leon@kernel.org> wrote:=0A=0A=
> On Tue, Dec 21, 2021 at 12:39:13PM -0500, yanjun.zhu@linux.dev wrote:=
=0A> =0A>> From: Zhu Yanjun <yanjun.zhu@linux.dev>=0A>> =0A>> Based on th=
e link https://www.spinics.net/lists/linux-rdma/msg73735.html,=0A> =0A> P=
lease use lore.kernel.org links. They have all chances to outlive spinics=
.=0A> =0A>> get the source udp port number for a QP based on the grh.flow=
_label or=0A>> lqpn/rqrpn. This provides a better spread of traffic acros=
s NIC RX queues.=0A>> The method in the commit 2b880b2e5e03 ("RDMA/mlx5: =
Define RoCEv2 udp=0A>> source port when set path") is a standard way. So =
it is also adopted in=0A>> this commit.=0A>> =0A>> Signed-off-by: Zhu Yan=
jun <yanjun.zhu@linux.dev>=0A>> ---=0A>> V2->V3: Move to the block of IB_=
QP_AV in the mask and IB_AH_GRH in ah_flags=0A>> V1->V2: Adopt a standard=
 method to get udp source port.=0A>> ---=0A>> drivers/infiniband/hw/irdma=
/verbs.c | 14 ++++++++++++++=0A>> 1 file changed, 14 insertions(+)=0A>> =
=0A>> diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniba=
nd/hw/irdma/verbs.c=0A>> index 8cd5f9261692..31039b295206 100644=0A>> ---=
 a/drivers/infiniband/hw/irdma/verbs.c=0A>> +++ b/drivers/infiniband/hw/i=
rdma/verbs.c=0A>> @@ -1094,6 +1094,15 @@ static int irdma_query_pkey(stru=
ct ib_device *ibdev, u32 port, u16 index,=0A>> return 0;=0A>> }=0A>> =0A>=
> +=0A>> +static u16 irdma_get_udp_sport(u32 fl, u32 lqpn, u32 rqpn)=0A>>=
 +{=0A>> + if (!fl)=0A>> + fl =3D rdma_calc_flow_label(lqpn, rqpn);=0A>> =
+=0A>> + return rdma_flow_label_to_udp_sport(fl);=0A>> +}=0A>> +=0A>> /**=
=0A>> * irdma_modify_qp_roce - modify qp request=0A>> * @ibqp: qp's point=
er for modify=0A>> @@ -1167,6 +1176,11 @@ int irdma_modify_qp_roce(struct=
 ib_qp *ibqp, struct ib_qp_attr *attr,=0A>> =0A>> memset(&iwqp->roce_ah, =
0, sizeof(iwqp->roce_ah));=0A>> if (attr->ah_attr.ah_flags & IB_AH_GRH) {=
=0A>> + u32 fl =3D udp_info->flow_label;=0A>> + u32 lqp =3D ibqp->qp_num;=
=0A>> + u32 rqp =3D roce_info->dest_qp;=0A>> +=0A> =0A> I don't see too m=
uch value in these extra variables and extra function=0A> that is the sam=
e as get_udp_sport() from hns.=0A> =0A> It is worth to add new function t=
o ib_verbs.h and reuse in both drivers.=0A=0ADo you mean the following fu=
nction should be added into ib_verbs.h?=0A=0A"=0Astatic inline u16 rdma_g=
et_udp_sport(u32 fl, u32 lqpn, u32 rqpn)=0A{=0A        if (!fl)=0A       =
         fl =3D rdma_calc_flow_label(lqpn, rqpn);=0A=0A        return rdm=
a_flow_label_to_udp_sport(fl);=0A}=0A"=0AThen in hns, rxe and irdma, this=
 function is called to get udp source port?=0AIf so, I will send new patc=
hes.=0A=0AThanks.=0AZhu Yanjun=0A=0A> =0A> Thanks=0A> =0A>> + udp_info->s=
rc_port =3D irdma_get_udp_sport(fl, lqp, rqp);=0A>> udp_info->ttl =3D att=
r->ah_attr.grh.hop_limit;=0A>> udp_info->flow_label =3D attr->ah_attr.grh=
.flow_label;=0A>> udp_info->tos =3D attr->ah_attr.grh.traffic_class;=0A>>=
 --=0A>> 2.27.0
