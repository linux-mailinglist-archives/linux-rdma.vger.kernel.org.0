Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3D87B2102
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Sep 2023 17:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjI1PVL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Sep 2023 11:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbjI1PVK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Sep 2023 11:21:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2A0EB;
        Thu, 28 Sep 2023 08:21:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D63DC433CA;
        Thu, 28 Sep 2023 15:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695914469;
        bh=5QGsjlLA6+fSdsYbT2wgVXCyV5RBnz+gCDO8qtKxudM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RI64Z/ulZuV+NXvyr13D2r3WHJHjvYSEBhhBuHPNVt9kRWrPnmiOgF6ordWF6ikFR
         xgtdSFzrXqfJBZ5kkT2lmvoB/s5AbaPtBp/tnANflqyoMu0vA4hG+/6XSSId9g12q6
         KIYQ9idMZhFhYNIT33lFaQWWQ7LAYSXQCODt0fs3+ZcZjnlILWt1TgJuLubdaAGUFf
         pPbIcFQgW/we/P2hsbBFA0b+8eMvcO7guEHDNRQNPbG/MNmCgntCxM58JaxdGUeun5
         x06+lzhwwWzX9K72+s9pnzD78ZB62/lme4WNkHldmaYNuNQwSl3mlzfexfOEF6/wbI
         ZAR46SSqA5oOw==
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40651a726acso8223865e9.1;
        Thu, 28 Sep 2023 08:21:09 -0700 (PDT)
X-Gm-Message-State: AOJu0YxuxNKOgC4u1ePiFMlqKCEMP/zddERIvPni/8kcjiybUUC91JLy
        RSxD/21B6vHM6Qp+/MI+x+UR1N8BGIs6V0/bc2U=
X-Google-Smtp-Source: AGHT+IFGxnL1jLxRJ82JHSkotXT+AJQbGwcj+NsBF8Wdz/LihQ1gwaw7yDfPbhv4CL9qBIGKh5TUPhf228x9wFIkjTk=
X-Received: by 2002:a05:6512:1595:b0:500:b828:7a04 with SMTP id
 bp21-20020a056512159500b00500b8287a04mr1542995lfb.18.1695914446757; Thu, 28
 Sep 2023 08:20:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230928-jag-sysctl_remove_empty_elem_drivers-v1-0-e59120fca9f9@samsung.com>
 <65157da7.5d0a0220.13b5e.9e95SMTPIN_ADDED_BROKEN@mx.google.com>
In-Reply-To: <65157da7.5d0a0220.13b5e.9e95SMTPIN_ADDED_BROKEN@mx.google.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 28 Sep 2023 08:20:34 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6WRen7Udqc+O+haAH8PZXH2jYdpUj1X7UCuQYngVWxoA@mail.gmail.com>
Message-ID: <CAPhsuW6WRen7Udqc+O+haAH8PZXH2jYdpUj1X7UCuQYngVWxoA@mail.gmail.com>
Subject: Re: [PATCH 13/15] raid: Remove now superfluous sentinel element from
 ctl_table array
To:     j.granados@samsung.com
Cc:     Luis Chamberlain <mcgrof@kernel.org>, willy@infradead.org,
        josh@joshtriplett.org, Kees Cook <keescook@chromium.org>,
        Phillip Potter <phil@philpotter.co.uk>,
        Clemens Ladisch <clemens@ladisch.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Doug Gilbert <dgilbert@interlog.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Corey Minyard <minyard@acm.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Robin Holt <robinmholt@gmail.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Russ Weight <russell.h.weight@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-serial@vger.kernel.org,
        linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-rdma@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-hyperv@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 28, 2023 at 6:20=E2=80=AFAM Joel Granados via B4 Relay
<devnull+j.granados.samsung.com@kernel.org> wrote:
>
> From: Joel Granados <j.granados@samsung.com>
>
> This commit comes at the tail end of a greater effort to remove the
> empty elements at the end of the ctl_table arrays (sentinels) which
> will reduce the overall build time size of the kernel and run time
> memory bloat by ~64 bytes per sentinel (further information Link :
> https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)
>
> Remove sentinel from raid_table
>
> Signed-off-by: Joel Granados <j.granados@samsung.com>
> ---
>  drivers/md/md.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index a104a025084d..3866d8f754a0 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -304,8 +304,7 @@ static struct ctl_table raid_table[] =3D {
>                 .maxlen         =3D sizeof(int),
>                 .mode           =3D S_IRUGO|S_IWUSR,
>                 .proc_handler   =3D proc_dointvec,
> -       },
> -       { }
> +       }
>  };

Please keep "}," as Greg suggested. Otherwise,

Acked-by: Song Liu <song@kernel.org>

Thanks,
Song
