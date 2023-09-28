Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0942C7B1DA8
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Sep 2023 15:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbjI1NUn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Sep 2023 09:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbjI1NUm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Sep 2023 09:20:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9C31AA;
        Thu, 28 Sep 2023 06:20:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BED95C193E8;
        Thu, 28 Sep 2023 13:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695907236;
        bh=nAi5VbjqEwCdzEJp+fv2i3DZ2flYuZxXsPFVaGvUXhY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=OCqp5Ov4BuszVW/bn2+B72ZJ/xR3YaoFzsxv1aU/Z/A6Yiz+vQBMRZYu9gRm50imR
         K11dYBBDgVq7Y+4mkAEjfyc9Mr2Vddg80rfjalPbMOLCeYjxvJUtGTGjCtMsQDIyZG
         69ACgpYY7cXbxiYCo8BeXxnyR6MXKMP9H8DMEu8plDx2Klk4byrQhBa6ZGR4w53klP
         15pmoFTU9JD5o+tjgr5bW2Ty0Kf+493NXvptiLCb5TLwX7ifpFHe46htbDlZMKsRft
         zFi2JB642EhNoMROZ50HGgRbYl+dJbDORovyFGMJkDrtkq9P9uVJgrhrn2mVRPayZD
         w/mbiY4QoFQhQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id A3DA3E732D1;
        Thu, 28 Sep 2023 13:20:36 +0000 (UTC)
From:   Joel Granados via B4 Relay 
        <devnull+j.granados.samsung.com@kernel.org>
Date:   Thu, 28 Sep 2023 15:21:32 +0200
Subject: [PATCH 07/15] macintosh: Remove the now superfluous sentinel
 element from ctl_table array
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230928-jag-sysctl_remove_empty_elem_drivers-v1-7-e59120fca9f9@samsung.com>
References: <20230928-jag-sysctl_remove_empty_elem_drivers-v1-0-e59120fca9f9@samsung.com>
In-Reply-To: <20230928-jag-sysctl_remove_empty_elem_drivers-v1-0-e59120fca9f9@samsung.com>
To:     Luis Chamberlain <mcgrof@kernel.org>, willy@infradead.org,
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
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-serial@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-rdma@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-hyperv@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Joel Granados <j.granados@samsung.com>
X-Mailer: b4 0.13-dev-86aa5
X-Developer-Signature: v=1; a=openpgp-sha256; l=964; i=j.granados@samsung.com;
 h=from:subject:message-id; bh=ZdDGNSOnPHmccRg9DswRbcjrpwllnv7treH59axwgKs=;
 b=owEB7QES/pANAwAKAbqXzVK3lkFPAcsmYgBlFX3dFNTsUUB9JSBv/bi9fMcZELcv/Pd6Ielps
 Tv0fYg6ZTyJAbMEAAEKAB0WIQSuRwlXJeYxJc7LJ5C6l81St5ZBTwUCZRV93QAKCRC6l81St5ZB
 T86TDACD/olsUJCMaYNGhUK8fOC4ygULgoETxczjsUrJ3FqFvf/W9eYaJd8QqGpcMOYjw1h96ab
 o9zfYcNrx79mUCqL0BoqwuQuu11iB7mdcubin7N6ctOUnQ8WGw8URbiLP3jjYc91vkQPgtLk2Mk
 wvNRnAFG9xEe1DMlr4I7VrAIvMnA/9NYZ+Qw9UvC2pl8wNvR52krqU2VCn6kBWoexdWZws8BTQi
 jxm4KCrIsTy+GCeGsGQLYA2bO8Hc1og/PrMiZ0UzRkQAqsoVN3pdMsPMw9cbOYg+DdC9+C1sfp6
 Bl28JzSUEdBKn/gw5xOg2CuQYrwFvPIIKyQ5PxT7cnZcGIF8XtUJLAhQ8fbQ+lGxfqRvNEJPWpK
 FkouzOuPr0ghUqJ7B4QCGC+U0ubZrPdVrUHvniAcEBtCff5KXZJOiMn45G46hZB4ZKH91Egk66L
 7ibjw96S82RLY88IHUBdKyX4xWoP14f8vilMOHLoR27kPe4oc4fVlOZcjQtA3ARSiai4o=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
Reply-To: <j.granados@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Joel Granados <j.granados@samsung.com>

This commit comes at the tail end of a greater effort to remove the
empty elements at the end of the ctl_table arrays (sentinels) which
will reduce the overall build time size of the kernel and run time
memory bloat by ~64 bytes per sentinel (further information Link :
https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)

Remove sentinel from mac_hid_files

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 drivers/macintosh/mac_hid.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/macintosh/mac_hid.c b/drivers/macintosh/mac_hid.c
index d8c4d5664145..5a228c7d9aeb 100644
--- a/drivers/macintosh/mac_hid.c
+++ b/drivers/macintosh/mac_hid.c
@@ -235,8 +235,7 @@ static struct ctl_table mac_hid_files[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-	},
-	{ }
+	}
 };
 
 static struct ctl_table_header *mac_hid_sysctl_header;

-- 
2.30.2

