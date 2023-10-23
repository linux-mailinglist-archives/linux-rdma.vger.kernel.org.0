Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315C27D304F
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Oct 2023 12:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjJWKqr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Oct 2023 06:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjJWKqq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Oct 2023 06:46:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F90BD65
        for <linux-rdma@vger.kernel.org>; Mon, 23 Oct 2023 03:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698057957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vB3jHXoS16KapdNQZUIduLuNHsVuuyVYThzRJF/d9P8=;
        b=g31bGn26a2o6s6/1tLJhLmhab5ZmL+VzAWXuoDvZbfk9nVw1nCLCgla2FHa2OA7WIPddDy
        TidCHgOdO1aYcDzG3HQtxrLA+zqoD83eDYtIELkKE2X1kr42JkoOpxQ52SRLyg3Z/YyD98
        mrvGvFAor4XKkcS+fWxM18qcpoSTRWM=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-2jGBNaRUOu2nLwJzPizfag-1; Mon, 23 Oct 2023 06:45:55 -0400
X-MC-Unique: 2jGBNaRUOu2nLwJzPizfag-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5a4d04a8a5cso1748076a12.0
        for <linux-rdma@vger.kernel.org>; Mon, 23 Oct 2023 03:45:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698057954; x=1698662754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vB3jHXoS16KapdNQZUIduLuNHsVuuyVYThzRJF/d9P8=;
        b=UdsL1t4B4Ucj9CMWuJfxtTv1XGEstp79pr819zw6ZtAlCtplAnGvGvHhKZ2JLBBD2U
         5J21giL9IYji1PbbQVXo9LjlPW+EE9f/JcG4VkFYQGjph3H1yoMxMIiYGDHJCmEYw6kx
         UHBrUuoEDs0z7ov8Ng4kL+T5buTvE9fNxOuk5ju36cAtbaQ1S5D049R9DqYfiEgBot6O
         oNDl/Rbx/JmXBprb7gH5FoaQMpWtomI/cCHgVcZbaco/aeGjOlCd0od1pixDK6wAhS2l
         t2ZKtEFPWK6jtK8IUf7jq01FXg22+6ukIimcUzdnvMg+xlqyGovzQ+LSIetQcx7BN4ov
         PbXA==
X-Gm-Message-State: AOJu0Yzj8xBeLXVz0Fuq/Sn7R8teVjSvZU9le38dJot4tOJVXZ3xvRZj
        umuFlUp6A2rYsDRGtviS1DrHa7e/8T2y3MHNRsnycLTbPYJtFZGOIBV3pFae0y+6ZZTRIy9V6YO
        2Z30IkSSw5H5jMtpKMlVQ8QnmJFm7NcrgDFm4U62bEEpEszEj
X-Received: by 2002:a05:6a21:9988:b0:13f:c40c:379 with SMTP id ve8-20020a056a21998800b0013fc40c0379mr8306048pzb.13.1698057954175;
        Mon, 23 Oct 2023 03:45:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2crgPuAi+kwPKwj11yeEEB5IQRmGSwKDaOjsTTm/N7OaIHczV5B9+v8FJ0goNG3zk3xWTclfit+9tFcecSj0=
X-Received: by 2002:a05:6a21:9988:b0:13f:c40c:379 with SMTP id
 ve8-20020a056a21998800b0013fc40c0379mr8306031pzb.13.1698057953866; Mon, 23
 Oct 2023 03:45:53 -0700 (PDT)
MIME-Version: 1.0
References: <20231013011803.70474-1-yanjun.zhu@intel.com> <OS3PR01MB98651C7454C46841B8A78F11E5D2A@OS3PR01MB9865.jpnprd01.prod.outlook.com>
 <a6e4efa6-0623-4afa-9b57-969aaf346081@fujitsu.com> <20231020140139.GF691768@ziepe.ca>
 <6c57cf0d-c7a7-4aac-9eb2-d8bb1d832232@fujitsu.com>
In-Reply-To: <6c57cf0d-c7a7-4aac-9eb2-d8bb1d832232@fujitsu.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Mon, 23 Oct 2023 18:45:40 +0800
Message-ID: <CAHj4cs86fFi+1LMMAzjcdGg1g1gbQwy6QgksC0kYVmNgghLV_w@mail.gmail.com>
Subject: Re: [PATCH 1/1] RDMA/rxe: Fix blktests srp lead kernel panic with 64k
 page size
To:     "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        Zhu Yanjun <yanjun.zhu@intel.com>,
        Zhu Yanjun <yanjun.zhu@linux.dev>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 23, 2023 at 11:52=E2=80=AFAM Zhijian Li (Fujitsu)
<lizhijian@fujitsu.com> wrote:
>
>
>
> On 20/10/2023 22:01, Jason Gunthorpe wrote:
> > On Fri, Oct 20, 2023 at 03:47:05AM +0000, Zhijian Li (Fujitsu) wrote:
> >> CC Bart
> >>
> >> On 13/10/2023 20:01, Daisuke Matsuda (Fujitsu) wrote:
> >>> On Fri, Oct 13, 2023 10:18 AM Zhu Yanjun wrote:
> >>>> From: Zhu Yanjun<yanjun.zhu@linux.dev>
> >>>>
> >>>> The page_size of mr is set in infiniband core originally. In the com=
mit
> >>>> 325a7eb85199 ("RDMA/rxe: Cleanup page variables in rxe_mr.c"), the
> >>>> page_size is also set. Sometime this will cause conflict.
> >>> I appreciate your prompt action, but I do not think this commit deals=
 with
> >>> the root cause. I agree that the problem lies in rxe driver, but what=
 is wrong
> >>> with assigning actual page size to ibmr.page_size?
> >>>
> >>> IMO, the problem comes from the device attribute of rxe driver, which=
 is used
> >>> in ulp/srp layer to calculate the page_size.
> >>> =3D=3D=3D=3D=3D
> >>> static int srp_add_one(struct ib_device *device)
> >>> {
> >>>           struct srp_device *srp_dev;
> >>>           struct ib_device_attr *attr =3D &device->attrs;
> >>> <...>
> >>>           /*
> >>>            * Use the smallest page size supported by the HCA, down to=
 a
> >>>            * minimum of 4096 bytes. We're unlikely to build large sgl=
ists
> >>>            * out of smaller entries.
> >>>            */
> >>>           mr_page_shift           =3D max(12, ffs(attr->page_size_cap=
) - 1);
> >>
> >>
> >> You light me up.
> >> RXE provides attr.page_size_cap(RXE_PAGE_SIZE_CAP) which means it can =
support 4K-2G page size
> >
> > That doesn't seem right even in concept.>
> > I think the multi-size support in the new xarray code does not work
> > right, just looking at it makes me think it does not work right. It
> > looks like it can do less than PAGE_SIZE but more than PAGE_SIZE will
> > explode because kmap_local_page() does only 4K.
> >
> > If RXE_PAGE_SIZE_CAP =3D=3D PAGE_SIZE  will everything work?
> >
>
> Yeah, this should work(even though i only verified hardcoding mr_page_shi=
ft to PAGE_SHIFT).

Hi Zhijian

Did you try blktests nvme/rdma use_rxe on your environment, it still
failed on my side.

# use_rxe=3D1 nvme_trtype=3Drdma  ./check nvme/003
nvme/003 (test if we're sending keep-alives to a discovery controller) [fai=
led]
    runtime  12.179s  ...  11.941s
    --- tests/nvme/003.out 2023-10-22 10:54:43.041749537 -0400
    +++ /root/blktests/results/nodev/nvme/003.out.bad 2023-10-23
05:52:27.882759168 -0400
    @@ -1,3 +1,3 @@
     Running nvme/003
    -NQN:nqn.2014-08.org.nvmexpress.discovery disconnected 1 controller(s)
    +NQN:nqn.2014-08.org.nvmexpress.discovery disconnected 0 controller(s)
     Test complete

[ 7033.431910] rdma_rxe: loaded
[ 7033.456341] run blktests nvme/003 at 2023-10-23 05:52:15
[ 7033.502306] (null): rxe_set_mtu: Set mtu to 1024
[ 7033.510969] infiniband enP2p1s0v0_rxe: set active
[ 7033.510980] infiniband enP2p1s0v0_rxe: added enP2p1s0v0
[ 7033.549301] loop0: detected capacity change from 0 to 2097152
[ 7033.556966] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 7033.566711] nvmet_rdma: enabling port 0 (10.19.240.81:4420)
[ 7033.588605] nvmet: connect attempt for invalid controller ID 0x808
[ 7033.594909] nvme nvme0: Connect Invalid Data Parameter, cntlid: 65535
[ 7033.601504] nvme nvme0: failed to connect queue: 0 ret=3D16770
[ 7046.317861] rdma_rxe: unloaded


>
> >>> import ctypes
> >>> libc =3D ctypes.cdll.LoadLibrary('libc.so.6')
> >>> hex(65536)
> '0x10000'
> >>> libc.ffs(0x10000) - 1
> 16
> >>> 1 << 16
> 65536
>
> so
> mr_page_shift =3D max(12, ffs(attr->page_size_cap) - 1) =3D max(12, 16) =
=3D 16;
>
>
> So I think Daisuke's patch should work as well.
>
> https://lore.kernel.org/linux-rdma/OS3PR01MB98652B2EC2E85DAEC6DDE484E5D2A=
@OS3PR01MB9865.jpnprd01.prod.outlook.com/T/#md133060414f0ba6a3dbaf7b4ad2374=
c8a347cfd1
>
>
> > Jason



--
Best Regards,
  Yi Zhang

