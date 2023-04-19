Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C3F6E7A7D
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Apr 2023 15:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbjDSNUs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Apr 2023 09:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbjDSNUr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Apr 2023 09:20:47 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CCD146E5
        for <linux-rdma@vger.kernel.org>; Wed, 19 Apr 2023 06:20:44 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id xi5so81568535ejb.13
        for <linux-rdma@vger.kernel.org>; Wed, 19 Apr 2023 06:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1681910443; x=1684502443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9BOf4Zg0kdc2uD8MLclq66ftf4z+xtdTTtzT11zmAto=;
        b=Bx4lVV0tvF3WZNIAelGjK2Fe+WI2d9jhv4hTkmv62eBzI9a/2SAR4dqgAn5V4KHmWy
         tUe1yBOyBENkTO1ZJZE/Wqsakw2MvM+nvhJx0OKc4NWLjxNQYJ2InIMWkPIRjXBDuKkz
         e6EtIOKn0RZ4GgricZEiFYzN4TFvkJxAFNgYkngh7m2IHhPgvCGc7ei4bWF/AvddiQ32
         99C+cJGLz/OzXEm81i4oDmgjV5e4TJKDXvxRTaN8E6jgSJiVRvtY8u/HD63urcp3w15o
         fNb42RRJXzlSYFcydYXJ2Hipv8L6jXYh73Y2dtvayKBmKN2+3VtDMAr2WVx6sKXBx7+r
         twfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681910443; x=1684502443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9BOf4Zg0kdc2uD8MLclq66ftf4z+xtdTTtzT11zmAto=;
        b=ERb6Yeib1dV3FJAleZfaCJ2vyPxM+K3lYsyH/GRnSTikVpyQwxBB8St+fbaY63TOxp
         VuCwvTcd8tSb/LRhkSgwlJiTEZYaODuL9P7vdK8qqOi3iAKl7SEDYQRElKlSWZE3g+pP
         OdqtrDFP2WwD7/qdReqo35crY4g5ADEAKBxI0CBbDQqxDgihwhBTpTpfZ4tE2rvOld2+
         Slh8qiYoWD4P5gAUtRlGmpFmt/ZzJf+jGCb+9Y4IZTodAP5hCbzHSDSqNzM9FQjIcWEK
         PT+abIUmvFYVkhVarFw0HraEyjwCBWeaOXLD+KJuOsS4GOpGkGRj3JX5Q2KREvROJh6i
         M6xQ==
X-Gm-Message-State: AAQBX9dTdFBQu0igARleYB5C+RV0GNXmoM4/g7W/YJMTW2kPBO9g2Sco
        bHyzAXgDuURn1Lt3MexxEDcvlCV80ZNJgKJ5DhdMiQ==
X-Google-Smtp-Source: AKy350ZS/VAoCFqSysya9w50kf/t7vPS6iqTROEf96vSkCdYeDzCfqM9kpC+uErEFHpSWSXH+eYquB5PBONij/tPjVw=
X-Received: by 2002:a17:906:8448:b0:94f:2d5e:1909 with SMTP id
 e8-20020a170906844800b0094f2d5e1909mr5449280ejy.7.1681910443027; Wed, 19 Apr
 2023 06:20:43 -0700 (PDT)
MIME-Version: 1.0
References: <85323eb2-cfc7-d1b8-3a75-3fa63dde29db@fujitsu.com>
 <20230411122651.GV182481@unreal> <aa43746f-77f9-8592-5370-2a5042506ee5@fujitsu.com>
 <8fe62e38-e43d-3d6c-624f-1c8ce5859788@linux.dev> <f85cdaaa-b1d6-bc89-e963-8b611ae3667d@fujitsu.com>
 <20230413132418.GR17993@unreal> <4d1cacbf-f9b2-07c7-75bf-61f34abc1841@linux.dev>
 <7656e04c-1adc-6621-0e45-e2b282e6c143@fujitsu.com> <20230417180452.GG15386@unreal>
 <0985e0a9-fe19-1c07-0da7-48ec88eb77c6@fujitsu.com> <20230418075706.GB9740@unreal>
 <65860af3-7d48-5a26-f916-50450633a893@fujitsu.com>
In-Reply-To: <65860af3-7d48-5a26-f916-50450633a893@fujitsu.com>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Wed, 19 Apr 2023 15:20:32 +0200
Message-ID: <CAMGffEkyNnSXDfwuzCQ_ERZ-53OnoJ7gOF4eL1MAPYc74V43iQ@mail.gmail.com>
Subject: Re: [PATCH for-next 2/3] RDMA/rtrs: Fix rxe_dealloc_pd warning
To:     "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Zhu Yanjun <yanjun.zhu@linux.dev>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Apr 19, 2023 at 11:53=E2=80=AFAM Zhijian Li (Fujitsu)
<lizhijian@fujitsu.com> wrote:
>
> Leon, Guoqing
>
>
> On 18/04/2023 15:57, Leon Romanovsky wrote:
> >>>> Currently, without this patch:
> >>>> 1. PD and clt_path->s.dev are shared among connections.
> >>>> 2. every con[n]'s cleanup phase will call destroy_con_cq_qp()
> >>>> 3. clt_path->s.dev will be always decreased in destroy_con_cq_qp(), =
and when
> >>>>       clt_path->s.dev become zero, it will destroy PD.
> >>>> 4. when con[1] failed to create, con[1] will not take clt_path->s.de=
v, but it try to decreased clt_path->s.dev <<< it's wrong to do that.
> >>> So please fix it by making sure that failure to create con[1] will
> >>> release resources which were allocated. If con[1] didn't increase
> >>> s.dev_ref, it shouldn't decrease it either.
> >> You are right, the current patch did exactly that.
> >> It introduced a con owning flag 'has_dev' to indicate whether this con=
 has taken s.dev.
> >> so that its cleanup phase will only decrease its s.dev properly.
> > The has_dev is a workaround and not a solution. In proper error unwind
> > sequence, you won't need extra flag.
> >
> > Thanks
> >
>
> how about below changes
>
> commit 61dba725384e226d472b8142d70d40d4103df87a
> Author: Li Zhijian <lizhijian@fujitsu.com>
> Date:   Wed Apr 19 17:42:26 2023 +0800
>
>      RDMA/rtrs: Fix rxe_dealloc_pd warning
>
>      con[0] always sets s.dev to 1, correspondingly, we should let it to
>      release the last dev.
>
>      Previously,
>      1. PD and clt_path->s.dev are shared among connections.
>      2. every con[n]'s cleanup phase will call destroy_con_cq_qp()
>      3. clt_path->s.dev will be always decreased in destroy_con_cq_qp(), =
and when
>         clt_path->s.dev become zero, it will destroy PD.
>      4. when con[1] failed to create, con[1] will not take clt_path->s.de=
v,
>         but it try to decreased clt_path->s.dev <<< it's wrong to do that=
.
>
>      The warning occurs when destroying PD whose reference count is not z=
ero.
>      Precodition: clt_path->s.con_num is 2.
>      So 2 cm connection will be created as below:
>      CPU0                                              CPU1
>      init_conns {                              |
>        create_cm() // a. con[0] created        |
>                                                |  a'. rtrs_clt_rdma_cm_ha=
ndler() {
>                                                |    rtrs_rdma_addr_resolv=
ed()
>                                                |      create_con_cq_qp(co=
n); << con[0]
>                                                |  }
>                                                | in this moment, refcnt o=
f PD was increased to 2+
>                                                |
>        create_cm() // b. cid =3D 1, failed       |
>          destroy_con_cq_qp()                   |
>            rtrs_ib_dev_put()                   |
>              dev_free()                        |
>                ib_dealloc_pd(dev->ib_pd) << PD |
>                 is destroyed, but refcnt is    |
>                 still greater than 0           |
>      }
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/=
ulp/rtrs/rtrs-clt.c
> index 80abf45a197a..1eb652dedca3 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> @@ -1743,6 +1743,15 @@ static void destroy_con_cq_qp(struct rtrs_clt_con =
*con)
>                  con->rsp_ius =3D NULL;
>                  con->queue_num =3D 0;
>          }
> +
> +       /*
> +        * Every con will try to decreased s.dev_ref, but we should
> +        * reserve the last s.dev_ref for con[0]. In case con[1+]'s
> +        * cleanup phase call rtrs_ib_dev_put(clt_path->s.dev) early.
> +        */
> +       if (con->c.cid !=3D 0 && clt_path->s.dev_ref =3D=3D 1)
> +               return;
> +
>          if (clt_path->s.dev_ref && !--clt_path->s.dev_ref) {
>                  rtrs_ib_dev_put(clt_path->s.dev);
>                  clt_path->s.dev =3D NULL;

I run a regression test in our test env, it triggers a warning on

1681                 if (WARN_ON(clt_path->s.dev))

[ 1333.042633] ------------[ cut here ]------------
[ 1333.042650] WARNING: CPU: 8 PID: 559 at
/root/kernel-test/ibnbd2/rtrs/rtrs-clt.c:1681
rtrs_clt_rdma_cm_handler+0x864/0x8a0 [rtrs_client]
[ 1333.042651] Modules linked in: loop rnbd_client(O) rtrs_client(O)
rtrs_core(O) kvm_amd kvm input_leds led_class irqbypass crc32_pclmul
aesni_intel sp5100_tco evdev libaes watchdog sg k10temp crypto_simd
fam15h_power ipmi_si serio_raw cryptd ipmi_devintf glue_helper
ipmi_msghandler acpi_cpufreq button ib_ipoib ib_umad null_blk brd
rdma_cm iw_cm ib_cm ip_tables x_tables autofs4 raid10 raid456
async_raid6_recov async_memcpy async_pq async_xor async_tx xor
raid6_pq libcrc32c raid1 raid0 linear mlx4_ib md_mod ib_uverbs ib_core
sd_mod t10_pi crc_t10dif crct10dif_generic ahci libahci
crct10dif_pclmul crct10dif_common crc32c_intel igb libata usb_storage
psmouse i2c_piix4 i2c_algo_bit mlx4_core dca scsi_mod i2c_core ptp
pps_core
[ 1333.042737] CPU: 8 PID: 559 Comm: kworker/u128:1 Tainted: G
  O      5.10.136-pserver-develop-5.10 #257
[ 1333.042738] Hardware name: Supermicro H8QG6/H8QG6, BIOS 3.00       09/04=
/2012
[ 1333.042752] Workqueue: rdma_cm cma_work_handler [rdma_cm]
[ 1333.042758] RIP: 0010:rtrs_clt_rdma_cm_handler+0x864/0x8a0 [rtrs_client]
[ 1333.042761] Code: ff bb ea ff ff ff e8 db a5 24 fc 49 8d b4 24 10
01 00 00 89 da 48 c7 c7 40 93 5b c0 e8 4b 47 21 fc 4d 8b 65 00 e9 15
fe ff ff <0f> 0b 4c 89 ff bb ea ff ff ff e8 ad a5 24 fc eb d0 0f 0b 4c
89 ff
[ 1333.042763] RSP: 0018:ffffaff68e57bdb0 EFLAGS: 00010286
[ 1333.042765] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff9eddc00=
51420
[ 1333.042767] RDX: ffff9ee4ef716e40 RSI: ffff9f14ea288f30 RDI: ffff9eddc88=
db240
[ 1333.042768] RBP: ffffaff68e57be50 R08: 0000000000000000 R09: 006d635f616=
d6472
[ 1333.042769] R10: ffffaff68e57be68 R11: 0000000000000000 R12: ffff9edde13=
88000
[ 1333.042771] R13: ffff9eddc88db200 R14: ffff9edde1388000 R15: ffff9eddc88=
db240
[ 1333.042773] FS:  0000000000000000(0000) GS:ffff9eecc7c00000(0000)
knlGS:0000000000000000
[ 1333.042774] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1333.042776] CR2: 00007f0ac4ed4004 CR3: 0000002b5040a000 CR4: 00000000000=
406e0
[ 1333.042777] Call Trace:
[ 1333.042790]  ? newidle_balance+0x25e/0x3c0
[ 1333.042795]  ? psi_group_change+0x43/0x230
[ 1333.042801]  ? cma_cm_event_handler+0x23/0xb0 [rdma_cm]
[ 1333.042807]  cma_cm_event_handler+0x23/0xb0 [rdma_cm]
[ 1333.042814]  cma_work_handler+0x5a/0xb0 [rdma_cm]
[ 1333.042819]  process_one_work+0x1f3/0x390
[ 1333.042822]  worker_thread+0x2d/0x3c0
