Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B80F7B4E7F
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Oct 2023 11:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235898AbjJBJCq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Oct 2023 05:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjJBJCp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Oct 2023 05:02:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D4FA4;
        Mon,  2 Oct 2023 02:02:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE7CC433C8;
        Mon,  2 Oct 2023 09:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696237361;
        bh=smbdD+CUEQ4ahMF3RqsYVNHHjGroQxTTaWRgCAR/D24=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nMX+58jl6hq9UFJUHZd1tjzFPgSTOpSlydUnTfJQnD4JkBTo1W3OhKwdiqRz3OSHL
         5qGb/GMTdZ1Zi7txcN44MpKcZqjCquccKdPkeOQfVVDMci/1xfBziuQgAa/1GdsgkO
         fTB8auP7M3L0i1rXICcsdIgBp+nJtQayOSXiZzAY=
Date:   Mon, 2 Oct 2023 11:02:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        "j.granados@samsung.com" <j.granados@samsung.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        Kees Cook <keescook@chromium.org>,
        Phillip Potter <phil@philpotter.co.uk>,
        Clemens Ladisch <clemens@ladisch.de>,
        Arnd Bergmann <arnd@arndb.de>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Doug Gilbert <dgilbert@interlog.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Corey Minyard <minyard@acm.org>, Theodore Ts'o <tytso@mit.edu>,
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
        Song Liu <song@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "openipmi-developer@lists.sourceforge.net" 
        <openipmi-developer@lists.sourceforge.net>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 04/15] tty: Remove now superfluous sentinel element from
 ctl_table array
Message-ID: <2023100252-plod-user-4504@gregkh>
References: <20230928-jag-sysctl_remove_empty_elem_drivers-v1-0-e59120fca9f9@samsung.com>
 <20230928-jag-sysctl_remove_empty_elem_drivers-v1-4-e59120fca9f9@samsung.com>
 <63e7a4fe-58c9-470e-84c2-dd92e76462ae@kernel.org>
 <4d7bf39e-e7f9-f497-13aa-73718456a653@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d7bf39e-e7f9-f497-13aa-73718456a653@csgroup.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 02, 2023 at 08:47:53AM +0000, Christophe Leroy wrote:
> 
> 
> Le 02/10/2023 à 10:17, Jiri Slaby a écrit :
> > On 28. 09. 23, 15:21, Joel Granados via B4 Relay wrote:
> >> From: Joel Granados <j.granados@samsung.com>
> >>
> >> This commit comes at the tail end of a greater effort to remove the
> >> empty elements at the end of the ctl_table arrays (sentinels) which
> >> will reduce the overall build time size of the kernel and run time
> >> memory bloat by ~64 bytes per sentinel (further information Link :
> >> https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)
> >>
> >> Remove sentinel from tty_table
> >>
> >> Signed-off-by: Joel Granados <j.granados@samsung.com>
> >> ---
> >>   drivers/tty/tty_io.c | 3 +--
> >>   1 file changed, 1 insertion(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> >> index 8a94e5a43c6d..2f925dc54a20 100644
> >> --- a/drivers/tty/tty_io.c
> >> +++ b/drivers/tty/tty_io.c
> >> @@ -3607,8 +3607,7 @@ static struct ctl_table tty_table[] = {
> >>           .proc_handler    = proc_dointvec,
> >>           .extra1        = SYSCTL_ZERO,
> >>           .extra2        = SYSCTL_ONE,
> >> -    },
> >> -    { }
> >> +    }
> > 
> > Why to remove the comma? One would need to add one when adding a new entry?
> 
> Does it make any difference at all ?
> 
> In one case you have:
> 
> @xxxx
>   		something old,
>   	},
> +	{
> +		something new,
> +	},
>   }
> 
> In the other case you have:
> 
> @xxxx
>   		something old,
> + 	},
> +	{
> +		something new,
>   	}
>   }

Because that way it is obvious you are only touching the "something new"
lines and never have to touch the "something old" ones.

It's just a long-standing tradition in Linux, don't have an extra
character if you don't need it :)

thanks,

greg k-h
