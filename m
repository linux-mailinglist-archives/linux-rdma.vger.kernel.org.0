Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E3666B5C8
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Jan 2023 03:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjAPC45 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Jan 2023 21:56:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbjAPC44 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 15 Jan 2023 21:56:56 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C4072B9
        for <linux-rdma@vger.kernel.org>; Sun, 15 Jan 2023 18:56:54 -0800 (PST)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1673837812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a0yhBnUVMeC6PvbGEO9+6HCmemAf7rJvwalmPLRJxJs=;
        b=X2pdbrcEeKigiNWYCLQ3itpXmhp7Njzj7L3M0twhn+swtEtpGX2B3LjDdn6YFF6iF6ow2Z
        btA2gXaoHhjN8TgQhnY28vHBEUnKsXt97Yf5Wdz1B9Soyvzg0NiOVtn4UYMBockdHp5Xg7
        bYZ6ckJYBC3jGskpOP7M5IvRvM/12yw=
Date:   Mon, 16 Jan 2023 02:56:52 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   yanjun.zhu@linux.dev
Message-ID: <d1982dba14b26e7ea048cbc89eb18dfa@linux.dev>
Subject: Re: [PATCHv2 for-next 1/4] RDMA/irdma: Split MEM handler into
 irdma_reg_user_mr_type_mem
To:     "Leon Romanovsky" <leon@kernel.org>,
        "Zhu Yanjun" <yanjun.zhu@intel.com>
Cc:     mustafa.ismail@intel.com, shiraz.saleem@intel.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org
In-Reply-To: <Y8PhY1RAcTmnPdPJ@unreal>
References: <Y8PhY1RAcTmnPdPJ@unreal>
 <20230112000617.1659337-1-yanjun.zhu@intel.com>
 <20230112000617.1659337-2-yanjun.zhu@intel.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

January 15, 2023 7:20 PM, "Leon Romanovsky" <leon@kernel.org> wrote:=0A=
=0A> On Wed, Jan 11, 2023 at 07:06:14PM -0500, Zhu Yanjun wrote:=0A> =0A>=
> From: Zhu Yanjun <yanjun.zhu@linux.dev>=0A>> =0A>> The source codes rel=
ated with IRDMA_MEMREG_TYPE_MEM are split=0A>> into a new function irdma_=
reg_user_mr_type_mem.=0A>> =0A>> Signed-off-by: Zhu Yanjun <yanjun.zhu@li=
nux.dev>=0A>> ---=0A>> drivers/infiniband/hw/irdma/verbs.c | 81 +++++++++=
++++++++------------=0A>> 1 file changed, 49 insertions(+), 32 deletions(=
-)=0A>> =0A>> diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/=
infiniband/hw/irdma/verbs.c=0A>> index f4674ecf9c8c..b67c14aac0f2 100644=
=0A>> --- a/drivers/infiniband/hw/irdma/verbs.c=0A>> +++ b/drivers/infini=
band/hw/irdma/verbs.c=0A>> @@ -2745,6 +2745,53 @@ static int irdma_hwreg_=
mr(struct irdma_device *iwdev, struct irdma_mr *iwmr,=0A>> return ret;=0A=
>> }=0A>> =0A>> +static int irdma_reg_user_mr_type_mem(struct irdma_mr *i=
wmr, int access)=0A>> +{=0A>> + struct irdma_device *iwdev =3D to_iwdev(i=
wmr->ibmr.device);=0A>> + int err;=0A>> + bool use_pbles;=0A>> + u32 stag=
;=0A>> + struct irdma_pbl *iwpbl =3D &iwmr->iwpbl;=0A>> +=0A>> + use_pble=
s =3D (iwmr->page_cnt !=3D 1);=0A>> +=0A>> + err =3D irdma_setup_pbles(iw=
dev->rf, iwmr, use_pbles, false);=0A>> + if (err)=0A>> + return err;=0A>>=
 +=0A>> + if (use_pbles) {=0A>> + err =3D irdma_check_mr_contiguous(&iwpb=
l->pble_alloc,=0A>> + iwmr->page_size);=0A>> + if (err) {=0A>> + irdma_fr=
ee_pble(iwdev->rf->pble_rsrc, &iwpbl->pble_alloc);=0A>> + iwpbl->pbl_allo=
cated =3D false;=0A>> + }=0A>> + }=0A>> +=0A>> + stag =3D irdma_create_st=
ag(iwdev);=0A>> + if (!stag) {=0A>> + err =3D -ENOMEM;=0A>> + goto free_p=
ble;=0A>> + }=0A>> +=0A>> + iwmr->stag =3D stag;=0A>> + iwmr->ibmr.rkey =
=3D stag;=0A>> + iwmr->ibmr.lkey =3D stag;=0A>> + err =3D irdma_hwreg_mr(=
iwdev, iwmr, access);=0A>> + if (err) {=0A>> + irdma_free_stag(iwdev, sta=
g);=0A>> + goto free_pble;=0A> =0A> Please add new goto label and put ird=
ma_free_stag() there.=0A=0AGot it. =0A=0AZhu Yanjun=0A=0A> =0A> Thanks
