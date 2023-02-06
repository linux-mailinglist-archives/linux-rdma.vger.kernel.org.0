Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD0168B68F
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Feb 2023 08:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjBFHmd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Feb 2023 02:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjBFHmc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Feb 2023 02:42:32 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3045818A83
        for <linux-rdma@vger.kernel.org>; Sun,  5 Feb 2023 23:42:31 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id bp15so16345768lfb.13
        for <linux-rdma@vger.kernel.org>; Sun, 05 Feb 2023 23:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=82B4t599f/DpDL7YZ83i615XP1XlvUU4CYMPr+rZYv0=;
        b=OROMYiqd8ZNZJ3vW3WLZQKrTMAWrr7jPFoRqpFkGh3hHpb03kgW5QjHxiPPFS+aAqG
         53VL8ZybUKEYwINwDt7vwtyjzPJJGzYxF0i1j+q0h5y7zHlsStaZNeuhbnu4/HK8v7mA
         TtfA+wNjxCZVWnn5/vfydEkbaw65y+Zz4eXK9OGcA+SrxJK7LjkOplpFel+D8umWU7aX
         kJJeW952HmlM8CAstBsXCYbZgVYdsFSqb/y3hxANh3MeBp4KqnDLJrNjuNd9170uoeud
         DtqrMTokw6eATPQHuyMW2JNx7rEFxg4kEA3hTgCMLhpieY8o81BwNxFUMGFEcf9boF0L
         gC4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=82B4t599f/DpDL7YZ83i615XP1XlvUU4CYMPr+rZYv0=;
        b=0kCW0e3ikiZm4BWeuTVaGZW6RADGIxEahEObawJqRBPXiMK7VakykkA0zRaevai12+
         s5skycOsuoLrkuT5N0LEoOMK0bADhIpYG6/QnS/VCZ5uNGh+9wkQ31Twn4Mk7wPWNZ6/
         7wLoCBaD7cHt1qvP8M/wS9KoSckYqnCHA1ZvQ6jnedMo7kx7C1uMQhL2JYJkD+Sup6TL
         mcDO0trxSqT4iLM0fH/DZ2vB2tfrYpG3iznXN+ESd2CNbyihUuSn2r2ychqPx+o+zXI4
         Qkui6kSomwg8epRiN7+1J0Momq3QFKFn95hNy4caXtOFGO1/t5BmqRRLw1yIYenkymt7
         ncGQ==
X-Gm-Message-State: AO0yUKVZuXO26mmiJLPTF9kndl1u3/M4PIwaT2ZjCbXAF5C2HrTZ/S3B
        yHDg2kfnOOBE3ZRNVqYEO2YEwG2GNlf6vpAPWvNvlA==
X-Google-Smtp-Source: AK7set949yF1OIh6bFIfShPVIKefdWTkltsAHpaYlBRRyDo6WH+9FCS4M/DKlTbhxGgJWuiUyELpLyIpplAlbv80GlI=
X-Received: by 2002:a05:6512:374c:b0:4b6:f2a8:884e with SMTP id
 a12-20020a056512374c00b004b6f2a8884emr3259859lfs.191.1675669349169; Sun, 05
 Feb 2023 23:42:29 -0800 (PST)
MIME-Version: 1.0
References: <1675332721-2-1-git-send-email-lizhijian@fujitsu.com>
In-Reply-To: <1675332721-2-1-git-send-email-lizhijian@fujitsu.com>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Mon, 6 Feb 2023 08:42:17 +0100
Message-ID: <CAMGffEnqyq83Z-33Kj6PBL6o95VDCz2Q_D1TFjzZkV7QTnqC2Q@mail.gmail.com>
Subject: Re: [PATCH v2] RDMA/rtrs: Don't call kobject_del for srv_path->kobj
To:     Li Zhijian <lizhijian@fujitsu.com>
Cc:     haris.iqbal@ionos.com, linux-rdma@vger.kernel.org, jgg@ziepe.ca,
        leon@kernel.org, guoqing.jiang@linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 2, 2023 at 11:12 AM Li Zhijian <lizhijian@fujitsu.com> wrote:
>
> As the mention in commmit f7452a7e96c1 ("RDMA/rtrs-srv: fix memory leak by missing kobject free"),
> it was intended to remove the kobject_del for srv_path->kobj.
>
> f7452a7e96c1 said:
> >This patch moves kobject_del() into free_sess() so that the kobject of
> >    rtrs_srv_sess can be freed.
>
> This patch also move rtrs_srv_destroy_once_sysfs_root_folders back to
> 'if (srv_path->kobj.state_in_sysfs)' block to avoid a 'held lock freed!'
>
> A kernel panic will be triggered by following script
> -----------------------
> $ while true
> do
>         echo "sessname=foo path=ip:<ip address> device_path=/dev/nvme0n1" > /sys/devices/virtual/rnbd-client/ctl/map_device
>         echo "normal" > /sys/block/rnbd0/rnbd/unmap_device
> done
> -----------------------
> The bisection pointed to commit 6af4609c18b3 ("RDMA/rtrs-srv: Fix several issues in rtrs_srv_destroy_path_files")
> at last.
>
>  rnbd_server L777: </dev/nvme0n1@foo>: Opened device 'nvme0n1'
>  general protection fault, probably for non-canonical address 0x765f766564753aea: 0000 [#1] PREEMPT SMP PTI
>  CPU: 0 PID: 3558 Comm: systemd-udevd Kdump: loaded Not tainted 6.1.0-rc3-roce-flush+ #51
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
>  RIP: 0010:kernfs_dop_revalidate+0x36/0x180
>  Code: 00 00 41 55 41 54 55 53 48 8b 47 68 48 89 fb 48 85 c0 0f 84 db 00 00 00 48 8b a8 60 04 00 00 48 8b 45 30 48 85 c0 48 0f 44 c5 <4c> 8b 60 78 49 81 c4 d8 00 00 00 4c 89 e7 e8 b7 78 7b 00 8b 05 3d
>  RSP: 0018:ffffaf1700b67c78 EFLAGS: 00010206
>  RAX: 765f766564753a72 RBX: ffff89e2830849c0 RCX: 0000000000000000
>  RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff89e2830849c0
>  RBP: ffff89e280361bd0 R08: 0000000000000000 R09: 0000000000000001
>  R10: 0000000000000065 R11: 0000000000000000 R12: ffff89e2830849c0
>  R13: ffff89e283084888 R14: d0d0d0d0d0d0d0d0 R15: 2f2f2f2f2f2f2f2f
>  FS:  00007f13fbce7b40(0000) GS:ffff89e2bbc00000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 00007f93e055d340 CR3: 0000000104664002 CR4: 00000000001706f0
>  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>  Call Trace:
>   <TASK>
>   lookup_fast+0x7b/0x100
>   walk_component+0x21/0x160
>   link_path_walk.part.0+0x24d/0x390
>   path_openat+0xad/0x9a0
>   do_filp_open+0xa9/0x150
>   ? lock_release+0x13c/0x2e0
>   ? _raw_spin_unlock+0x29/0x50
>   ? alloc_fd+0x124/0x1f0
>   do_sys_openat2+0x9b/0x160
>   __x64_sys_openat+0x54/0xa0
>   do_syscall_64+0x3b/0x90
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
>  RIP: 0033:0x7f13fc9d701b
>  Code: 25 00 00 41 00 3d 00 00 41 00 74 4b 64 8b 04 25 18 00 00 00 85 c0 75 67 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 91 00 00 00 48 8b 54 24 28 64 48 2b 14 25
>  RSP: 002b:00007ffddf242640 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
>  RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f13fc9d701b
>  RDX: 0000000000080000 RSI: 00007ffddf2427c0 RDI: 00000000ffffff9c
>  RBP: 00007ffddf2427c0 R08: 00007f13fcc5b440 R09: 21b2131aa64b1ef2
>  R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000080000
>  R13: 00007ffddf2427c0 R14: 000055ed13be8db0 R15: 0000000000000000
>
> Fixes: 6af4609c18b3 ("RDMA/rtrs-srv: Fix several issues in rtrs_srv_destroy_path_files")
> Acked-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
Thx!
> ---
> V2: Call rtrs_srv_destroy_once_sysfs_root_folders in condition to avoid
> a 'held lock freed!'
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
> index c76ba29da1e2..5adba0f754b6 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
> @@ -312,9 +312,8 @@ void rtrs_srv_destroy_path_files(struct rtrs_srv_path *srv_path)
>
>         if (srv_path->kobj.state_in_sysfs) {
>                 sysfs_remove_group(&srv_path->kobj, &rtrs_srv_path_attr_group);
> -               kobject_del(&srv_path->kobj);
>                 kobject_put(&srv_path->kobj);
> +               rtrs_srv_destroy_once_sysfs_root_folders(srv_path);
>         }
>
> -       rtrs_srv_destroy_once_sysfs_root_folders(srv_path);
>  }
> --
> 1.8.3.1
>
