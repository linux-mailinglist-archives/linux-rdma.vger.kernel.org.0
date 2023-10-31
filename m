Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7BE27DC7F8
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Oct 2023 09:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbjJaIOh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 31 Oct 2023 04:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbjJaIOf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 31 Oct 2023 04:14:35 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A85118
        for <linux-rdma@vger.kernel.org>; Tue, 31 Oct 2023 01:14:26 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d9a3d737d66so4002325276.2
        for <linux-rdma@vger.kernel.org>; Tue, 31 Oct 2023 01:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698740065; x=1699344865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YLXhBsysIEQkusOXz3I6LTdUw+0MWiE4vGcXdzvo6Xc=;
        b=GxZItLmfq5vmHzfea5f+kk+mzyiUEMpJKEcldxK3uyE19OZ5/ywZ0UDPCtCuOVnVDq
         bHhb7V1DPDHHYDuwdKtyLniX9PikGnbz35Oa81W+PLjtP0+oq+Jaq7sE79tnSCEMIwlD
         jW/akG/TnA0d2RtbUG+kYfjb+w142xRZDNUzMex6tlTWB5rhHKpOTWlNrPAItoCF52yC
         +9wt8TBZWFYK3ApZqm9FiZHdjj8vhqX1SCiukn+bTgiovh3WikYzC9cs+xJou6bTa403
         +gZLXpRDOi3DoJDpJmQd9wxz7azfXGr4uUQuOvDEnj8uDq0rb9aHw5IO+zhe2BOTIp6a
         qPeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698740065; x=1699344865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YLXhBsysIEQkusOXz3I6LTdUw+0MWiE4vGcXdzvo6Xc=;
        b=PjLinPnMq+laGHvzlSfzSP9vf7iEXs/WV1qq3nZhhci8MhSF/GGDxNU0Bt3i53IPWN
         F0yc4VDY8flJ5HEDJYWiLzcRd8WHc45GsC+2hr8MlcoROfCkdNg2x9QXnPRaS64SZOle
         CbwpzAGRoYrrkS0XZqmp0tkTDi0e2SIwz2Zuxp0q4nZ8U1oCENugq2EQyTeXjH5O537I
         3oj9k+PYijo9BPLXuSLHOc0TpY9vEtooPfpYX1IwiHewF85w4+KYUf5/in8uDjLC3Qyh
         uEBhOcO5WVeWZbFukkIIfgbIWODxJ1zkWn6HT6hGkQ4XO5Wpi6tVT3hpdYww0XIpZwJr
         fL8A==
X-Gm-Message-State: AOJu0YwvTuvNA3BQqq0ZM85j4XPtTrMYQ5wBRtpTg5QcREqbVLfi/joh
        rQhBn5Wy+AghOM89MoCDEFq8y1v/0CfanqbdKCA=
X-Google-Smtp-Source: AGHT+IGaP9qC0ZCBiNivi7V+51pcd9uI6GrMbtx+x1XEw0BjEeKDiuqaoWrfWxuEFuHpsMcaWd++MqFF7esvhGVIGB8=
X-Received: by 2002:a25:ad11:0:b0:d9b:81a2:b83e with SMTP id
 y17-20020a25ad11000000b00d9b81a2b83emr8186898ybi.46.1698740065282; Tue, 31
 Oct 2023 01:14:25 -0700 (PDT)
MIME-Version: 1.0
References: <20231013011803.70474-1-yanjun.zhu@intel.com> <OS3PR01MB98651C7454C46841B8A78F11E5D2A@OS3PR01MB9865.jpnprd01.prod.outlook.com>
 <a6e4efa6-0623-4afa-9b57-969aaf346081@fujitsu.com> <20231020140139.GF691768@ziepe.ca>
 <6c57cf0d-c7a7-4aac-9eb2-d8bb1d832232@fujitsu.com> <CAHj4cs86fFi+1LMMAzjcdGg1g1gbQwy6QgksC0kYVmNgghLV_w@mail.gmail.com>
 <1ffaeaa4-4ac2-4531-8e0c-586e13c14c97@fujitsu.com> <366da960-6036-49c5-ad47-3ae3f4e55452@fujitsu.com>
 <8f705223-6fde-4b29-880b-570349f40db8@fujitsu.com> <4a19ae90-cc0f-4ace-862c-1251b6d98c3b@linux.dev>
 <CAEz=LcuLCe7bhUohh6BcHdJ1_ocJdZq=eu07vWb3Md5_ZOGDBg@mail.gmail.com> <CAEz=LcuQ6fFpHqBPT1oTUgKABAHFJqYDC-AHidE-+n6OtzmCPQ@mail.gmail.com>
In-Reply-To: <CAEz=LcuQ6fFpHqBPT1oTUgKABAHFJqYDC-AHidE-+n6OtzmCPQ@mail.gmail.com>
From:   Greg Sword <gregsword0@gmail.com>
Date:   Tue, 31 Oct 2023 16:14:13 +0800
Message-ID: <CAEz=LcsWtPL8tZ1z_2=mUp=Hc1n2W5JFtBeRHu4Us51QYyXssg@mail.gmail.com>
Subject: Re: [PATCH 1/1] RDMA/rxe: Fix blktests srp lead kernel panic with 64k
 page size
To:     Zhu Yanjun <yanjun.zhu@linux.dev>
Cc:     "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
        Yi Zhang <yi.zhang@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        Zhu Yanjun <yanjun.zhu@intel.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 31, 2023 at 3:53=E2=80=AFPM Greg Sword <gregsword0@gmail.com> w=
rote:
>
>
>
> On Tue, Oct 31, 2023 at 2:03=E2=80=AFPM Greg Sword <gregsword0@gmail.com>=
 wrote:
>>
>>
>>
>>
>> On Tue, Oct 31, 2023 at 9:40=E2=80=AFAM Zhu Yanjun <yanjun.zhu@linux.dev=
> wrote:
>>>
>>> =E5=9C=A8 2023/10/26 17:05, Zhijian Li (Fujitsu) =E5=86=99=E9=81=93:
>>> > The root cause is that
>>> >
>>> > rxe:rxe_set_page() gets wrong when mr.page_size !=3D PAGE_SIZE where =
it only stores the *page to xarray.
>>> > So the offset will get lost.
>>>
>>> It is interesting root cause.
>>> page_size is 0x1000, PAGE_SIZE 0x10000.
>>>
>>> Zhu Yanjun
>>>
>>> >
>>> > For example,
>>> > store process:
>>> > page_size =3D 0x1000;
>>> > PAGE_SIZE =3D 0x10000;
>>
>>
>> page_size is 0x1000, PAGE_SIZE is 0x10000.
>>
>> Is it correct? page_size should be PAGE_SIZE.
>> That is, page_size should be greater than PAGE_SIZE.
>> It is not reasonable now.
>>
>> The root cause is to find out why page_size is set 4K (0x1000). On ARM64=
 host withCONFIG_ARM64_64K_PAGES enabled,
>> the page_size should not be 4K, it should be 64K.
>>
>> So Zhijian's commit seems not to be correct.
>
>

linux-rdma not reached. Resend it again.

> Because rxe splits everything into PAGE_SIZE units in the xarray, so it s=
hould only support PAGE_SIZE page size. WithCONFIG_ARM64_64K_PAGES,
> PAGE_SIZE is 64K.
>
> But from NVME side, the page size is 4K bytes, it is not 64K.
>
> In the function ib_map_mr_sg is fixed SZ_4K.  So the root cause is not in=
 rxe. Before rxe is called, the capability of rxe should be tested.
>
> static int nvme_rdma_map_sg_fr(struct nvme_rdma_queue *queue,
>                 struct nvme_rdma_request *req, struct nvme_command *c,
>                 int count)
> {
>         struct nvme_keyed_sgl_desc *sg =3D &c->common.dptr.ksgl;
>         int nr;
>
>         req->mr =3D ib_mr_pool_get(queue->qp, &queue->qp->rdma_mrs);
>         if (WARN_ON_ONCE(!req->mr))
>                 return -EAGAIN;
>
>         /*
>          * Align the MR to a 4K page size to match the ctrl page size and
>          * the block virtual boundary.
>          */
>         nr =3D ib_map_mr_sg(req->mr, req->data_sgl.sg_table.sgl, count, N=
ULL,
>                           SZ_4K);
>         if (unlikely(nr < count)) {
>                 ib_mr_pool_put(queue->qp, &queue->qp->rdma_mrs, req->mr);
>                 req->mr =3D NULL;
>                 if (nr < 0)
>                         return nr;
>                 return -EINVAL;
>         }
>
>         ib_update_fast_reg_key(req->mr, ib_inc_rkey(req->mr->rkey));
>
>>
>>
>>
>>>
>>> > va0 =3D 0xffff000020651000;
>>> > page_offset =3D 0 =3D va & (page_size - 1);
>>> > page =3D va_to_page(va);
>>> > xa_store(&mr->page_list, mr->nbuf, page, GFP_KERNEL);
>>> >
>>> > load_process:
>>> > page =3D xa_load(&mr->page_list, index);
>>> > page_va =3D kmap_local_page(page) --> it must be a PAGE_SIZE align va=
lue, assume it as 0xffff000020650000
>>> > va1 =3D page_va + page_offset =3D 0xffff000020650000 + 0 =3D 0xffff00=
0020650000;
>>> >
>>> > Obviously, *va0 !=3D va1*, page_offset get lost.
>>> >
>>> >
>>> > How to fix:
>>> > - revert 325a7eb85199 ("RDMA/rxe: Cleanup page variables in rxe_mr.c"=
)
>>> > - don't allow ulp registering mr.page_size !=3D PAGE_SIZE ?
>>> >
>>> >
>>> >
>>> > Thanks
>>> > Zhijian
>>> >
>>> >
>>> > On 24/10/2023 17:13, Li Zhijian wrote:
>>> >>
>>> >>
>>> >> On 24/10/2023 16:15, Zhijian Li (Fujitsu) wrote:
>>> >>>
>>> >>>
>>> >>> On 23/10/2023 18:45, Yi Zhang wrote:
>>> >>>> On Mon, Oct 23, 2023 at 11:52=E2=80=AFAM Zhijian Li (Fujitsu)
>>> >>>> <lizhijian@fujitsu.com> wrote:
>>> >>>>>
>>> >>>>>
>>> >>>>>
>>> >>>>> On 20/10/2023 22:01, Jason Gunthorpe wrote:
>>> >>>>>> On Fri, Oct 20, 2023 at 03:47:05AM +0000, Zhijian Li (Fujitsu) w=
rote:
>>> >>>>>>> CC Bart
>>> >>>>>>>
>>> >>>>>>> On 13/10/2023 20:01, Daisuke Matsuda (Fujitsu) wrote:
>>> >>>>>>>> On Fri, Oct 13, 2023 10:18 AM Zhu Yanjun wrote:
>>> >>>>>>>>> From: Zhu Yanjun<yanjun.zhu@linux.dev>
>>> >>>>>>>>>
>>> >>>>>>>>> The page_size of mr is set in infiniband core originally. In =
the commit
>>> >>>>>>>>> 325a7eb85199 ("RDMA/rxe: Cleanup page variables in rxe_mr.c")=
, the
>>> >>>>>>>>> page_size is also set. Sometime this will cause conflict.
>>> >>>>>>>> I appreciate your prompt action, but I do not think this commi=
t deals with
>>> >>>>>>>> the root cause. I agree that the problem lies in rxe driver, b=
ut what is wrong
>>> >>>>>>>> with assigning actual page size to ibmr.page_size?
>>> >>>>>>>>
>>> >>>>>>>> IMO, the problem comes from the device attribute of rxe driver=
, which is used
>>> >>>>>>>> in ulp/srp layer to calculate the page_size.
>>> >>>>>>>> =3D=3D=3D=3D=3D
>>> >>>>>>>> static int srp_add_one(struct ib_device *device)
>>> >>>>>>>> {
>>> >>>>>>>>              struct srp_device *srp_dev;
>>> >>>>>>>>              struct ib_device_attr *attr =3D &device->attrs;
>>> >>>>>>>> <...>
>>> >>>>>>>>              /*
>>> >>>>>>>>               * Use the smallest page size supported by the HC=
A, down to a
>>> >>>>>>>>               * minimum of 4096 bytes. We're unlikely to build=
 large sglists
>>> >>>>>>>>               * out of smaller entries.
>>> >>>>>>>>               */
>>> >>>>>>>>              mr_page_shift           =3D max(12, ffs(attr->pag=
e_size_cap) - 1);
>>> >>>>>>>
>>> >>>>>>>
>>> >>>>>>> You light me up.
>>> >>>>>>> RXE provides attr.page_size_cap(RXE_PAGE_SIZE_CAP) which means =
it can support 4K-2G page size
>>> >>>>>>
>>> >>>>>> That doesn't seem right even in concept.>
>>> >>>>>> I think the multi-size support in the new xarray code does not w=
ork
>>> >>>>>> right, just looking at it makes me think it does not work right.=
 It
>>> >>>>>> looks like it can do less than PAGE_SIZE but more than PAGE_SIZE=
 will
>>> >>>>>> explode because kmap_local_page() does only 4K.
>>> >>>>>>
>>> >>>>>> If RXE_PAGE_SIZE_CAP =3D=3D PAGE_SIZE  will everything work?
>>> >>>>>>
>>> >>>>>
>>> >>>>> Yeah, this should work(even though i only verified hardcoding mr_=
page_shift to PAGE_SHIFT).
>>> >>>>
>>> >>>> Hi Zhijian
>>> >>>>
>>> >>>> Did you try blktests nvme/rdma use_rxe on your environment, it sti=
ll
>>> >>>> failed on my side.
>>> >>>>
>>> >>>
>>> >>> Thanks for your testing.
>>> >>> I just did that, it also failed in my environment. After a glance d=
ebug, I found there are
>>> >>> other places still registered 4K MR. I will dig into it later.
>>> >>
>>> >>
>>> >> nvme intend to register 4K mr, but it should work IMO, at least the =
RXE have handled it correctly.
>>> >>
>>> >>
>>> >> 1293 static int nvme_rdma_map_sg_fr(struct nvme_rdma_queue *queue,
>>> >> 1294                 struct nvme_rdma_request *req, struct nvme_comm=
and *c,
>>> >> 1295                 int count)
>>> >> 1296 {
>>> >> 1297         struct nvme_keyed_sgl_desc *sg =3D &c->common.dptr.ksgl=
;
>>> >> 1298         int nr;
>>> >> 1299
>>> >> 1300         req->mr =3D ib_mr_pool_get(queue->qp, &queue->qp->rdma_=
mrs);
>>> >> 1301         if (WARN_ON_ONCE(!req->mr))
>>> >> 1302                 return -EAGAIN;
>>> >> 1303
>>> >> 1304         /*
>>> >> 1305          * Align the MR to a 4K page size to match the ctrl pag=
e size and
>>> >> 1306          * the block virtual boundary.
>>> >> 1307          */
>>> >> 1308         nr =3D ib_map_mr_sg(req->mr, req->data_sgl.sg_table.sgl=
, count, NULL,
>>> >> 1309                           SZ_4K);
>>> >>
>>> >>
>>> >> Anyway, i will go ahead. if you have any thought, please let me know=
.
>>> >>
>>> >>
>>> >>
>>> >>>
>>> >>> Thanks
>>> >>> Zhijian
>>> >>>
>>> >>>
>>> >>>
>>> >>>
>>> >>>> # use_rxe=3D1 nvme_trtype=3Drdma  ./check nvme/003
>>> >>>> nvme/003 (test if we're sending keep-alives to a discovery control=
ler) [failed]
>>> >>>>        runtime  12.179s  ...  11.941s
>>> >>>>        --- tests/nvme/003.out 2023-10-22 10:54:43.041749537 -0400
>>> >>>>        +++ /root/blktests/results/nodev/nvme/003.out.bad 2023-10-2=
3
>>> >>>> 05:52:27.882759168 -0400
>>> >>>>        @@ -1,3 +1,3 @@
>>> >>>>         Running nvme/003
>>> >>>>        -NQN:nqn.2014-08.org.nvmexpress.discovery disconnected 1 co=
ntroller(s)
>>> >>>>        +NQN:nqn.2014-08.org.nvmexpress.discovery disconnected 0 co=
ntroller(s)
>>> >>>>         Test complete
>>> >>>>
>>> >>>> [ 7033.431910] rdma_rxe: loaded
>>> >>>> [ 7033.456341] run blktests nvme/003 at 2023-10-23 05:52:15
>>> >>>> [ 7033.502306] (null): rxe_set_mtu: Set mtu to 1024
>>> >>>> [ 7033.510969] infiniband enP2p1s0v0_rxe: set active
>>> >>>> [ 7033.510980] infiniband enP2p1s0v0_rxe: added enP2p1s0v0
>>> >>>> [ 7033.549301] loop0: detected capacity change from 0 to 2097152
>>> >>>> [ 7033.556966] nvmet: adding nsid 1 to subsystem blktests-subsyste=
m-1
>>> >>>> [ 7033.566711] nvmet_rdma: enabling port 0 (10.19.240.81:4420)
>>> >>>> [ 7033.588605] nvmet: connect attempt for invalid controller ID 0x=
808
>>> >>>> [ 7033.594909] nvme nvme0: Connect Invalid Data Parameter, cntlid:=
 65535
>>> >>>> [ 7033.601504] nvme nvme0: failed to connect queue: 0 ret=3D16770
>>> >>>> [ 7046.317861] rdma_rxe: unloaded
>>> >>>>
>>> >>>>
>>> >>>>>
>>> >>>>>>>> import ctypes
>>> >>>>>>>> libc =3D ctypes.cdll.LoadLibrary('libc.so.6')
>>> >>>>>>>> hex(65536)
>>> >>>>> '0x10000'
>>> >>>>>>>> libc.ffs(0x10000) - 1
>>> >>>>> 16
>>> >>>>>>>> 1 << 16
>>> >>>>> 65536
>>> >>>>>
>>> >>>>> so
>>> >>>>> mr_page_shift =3D max(12, ffs(attr->page_size_cap) - 1) =3D max(1=
2, 16) =3D 16;
>>> >>>>>
>>> >>>>>
>>> >>>>> So I think Daisuke's patch should work as well.
>>> >>>>>
>>> >>>>> https://lore.kernel.org/linux-rdma/OS3PR01MB98652B2EC2E85DAEC6DDE=
484E5D2A@OS3PR01MB9865.jpnprd01.prod.outlook.com/T/#md133060414f0ba6a3dbaf7=
b4ad2374c8a347cfd1
>>> >>>>>
>>> >>>>>
>>> >>>>>> Jason
>>> >>>>
>>> >>>>
>>> >>>>
>>> >>>> --
>>> >>>> Best Regards,
>>> >>>>      Yi Zhang
>>>
