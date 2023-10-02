Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085EB7B4DCA
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Oct 2023 10:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236034AbjJBIx3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Oct 2023 04:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235951AbjJBIxW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Oct 2023 04:53:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F650EB;
        Mon,  2 Oct 2023 01:53:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 475C9C116D2;
        Mon,  2 Oct 2023 08:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696236795;
        bh=9jkWNrvkT+0LBek9ukFJf+FP4eXJDtJ7tqddCAk457s=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=mHarItBj0kfOKDXhcHyRTyxtdqNbek3gy9DO+yrzNTUJjpLPxU5bKRqHCkdOW17Ie
         xkjq0jUNKFsuFS2t19rNxjW1x3vXKYkakaCdWfIuYHrFXtHrvD/4bfnm6FDLdjwnlo
         5voc1dkLeKWe49cuL/zomKRMH9j951bKZs0iByI9rUHpEQ4xmK+7nJPykI4XyrFMGp
         hBVWTvg03Gy3ikCGWQykcvc5t0tV5Mq6CMkTLxGhqPmcMmS4/zmnuv2Cu263JvWv+R
         BfgcskbdW/nGJdhxW0T1YjF8PrpchaPtHg/O8IdSlvpoENpmGsP0W51gKChlgqBeIv
         qAV34DsE/M6Vw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 29385E784AF;
        Mon,  2 Oct 2023 08:53:15 +0000 (UTC)
From:   Joel Granados via B4 Relay 
        <devnull+j.granados.samsung.com@kernel.org>
Date:   Mon, 02 Oct 2023 10:55:23 +0200
Subject: [PATCH v2 06/15] parport: Remove the now superfluous sentinel
 element from ctl_table array
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231002-jag-sysctl_remove_empty_elem_drivers-v2-6-02dd0d46f71e@samsung.com>
References: <20231002-jag-sysctl_remove_empty_elem_drivers-v2-0-02dd0d46f71e@samsung.com>
In-Reply-To: <20231002-jag-sysctl_remove_empty_elem_drivers-v2-0-02dd0d46f71e@samsung.com>
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
Cc:     Joel Granados <j.granados@samsung.com>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-serial@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-rdma@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-hyperv@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
X-Mailer: b4 0.13-dev-86aa5
X-Developer-Signature: v=1; a=openpgp-sha256; l=3837;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=NSvTJ17Kcfm8DYFJyM6YVk1PHDjvaSDbIrsd2Gse9YE=;
 b=owEB7QES/pANAwAKAbqXzVK3lkFPAcsmYgBlGoV9bbHfdufy6tsLcPXDVXR+WNMz7RSAH58f9
 kFGXPJsJcmJAbMEAAEKAB0WIQSuRwlXJeYxJc7LJ5C6l81St5ZBTwUCZRqFfQAKCRC6l81St5ZB
 T2bgDACMcQXXhS/ofH4DCGI9Yfly1kT6RdmG9Sur8hjxuooeorZgEl/aCXeisvwUQFj4lOt8Hx0
 +gdjKSn0uN4Y8DF0k6dnFSA+h9NhuFNA65F6Wain093IqXcKXimz7qvzMw2nopuTQ+X+N3zQ0vJ
 absXFp0jssl+QlKi1hDVQz8mDWpkmDNx/bOPRh4QErCHilM/maVTlO5Fq7neDfmeOfloV1U+qLi
 dmmOgFxn9jpx2A+HY0D568WeEcE52zMiP2tSiVYzTXfI69odUkdpXAR5mAiC8wJwCKdEkveF5fD
 iBpWx5t50vj4aiid0chdBpPXmAcdBlYTLYFlwVqccnB7XAefYcefrfLqQyhwfzR7SjZj8yCcjn/
 zKe2EBbcfrFa6tHzwtj6dbrIRnfMMIjpjwrb+QsvwLtgSt9qqv9W/qEZDyl3+79NQu2Squ9v1Bk
 /EewjeRY0ixUgWq2yB2PeOCI975SunWYb3QfV1aFT07wvTzBKt9k6lYWP3VItXPoWT9RE=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
Reply-To: <j.granados@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
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

Remove the unneeded ctl_tables that were used to register intermediate
parport directories; only the path is needed at this point. From
parport_device_sysctl_table we removed: devices_root_dir, port_dir,
parport_dir and dev_dir. From parport_default_sysctl_table we removed:
default_dir, parport_dir and dev_dir. Reduce the size by one of the
ctl_table arrays that were not removed

Assign different sizes to the vars array in parport_sysctl_table
depending on CONFIG_PARPORT_1284; this is necessary now that the sysctl
register function uses ARRAY_SIZE to calculate the elements within.
Remove the sentinel element from parport_sysctl_template,
parport_device_sysctl_table and parport_default_sysctl_table.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 drivers/parport/procfs.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/parport/procfs.c b/drivers/parport/procfs.c
index 4e5b972c3e26..532d5cbbd344 100644
--- a/drivers/parport/procfs.c
+++ b/drivers/parport/procfs.c
@@ -259,8 +259,12 @@ PARPORT_MAX_SPINTIME_VALUE;
 struct parport_sysctl_table {
 	struct ctl_table_header *port_header;
 	struct ctl_table_header *devices_header;
-	struct ctl_table vars[12];
-	struct ctl_table device_dir[2];
+#ifdef CONFIG_PARPORT_1284
+	struct ctl_table vars[10];
+#else
+	struct ctl_table vars[5];
+#endif /* IEEE 1284 support */
+	struct ctl_table device_dir[1];
 };
 
 static const struct parport_sysctl_table parport_sysctl_template = {
@@ -341,7 +345,6 @@ static const struct parport_sysctl_table parport_sysctl_template = {
 			.proc_handler	= do_autoprobe
 		},
 #endif /* IEEE 1284 support */
-		{}
 	},
 	{
 		{
@@ -351,19 +354,14 @@ static const struct parport_sysctl_table parport_sysctl_template = {
 			.mode		= 0444,
 			.proc_handler	= do_active_device
 		},
-		{}
 	},
 };
 
 struct parport_device_sysctl_table
 {
 	struct ctl_table_header *sysctl_header;
-	struct ctl_table vars[2];
-	struct ctl_table device_dir[2];
-	struct ctl_table devices_root_dir[2];
-	struct ctl_table port_dir[2];
-	struct ctl_table parport_dir[2];
-	struct ctl_table dev_dir[2];
+	struct ctl_table vars[1];
+	struct ctl_table device_dir[1];
 };
 
 static const struct parport_device_sysctl_table
@@ -379,7 +377,6 @@ parport_device_sysctl_template = {
 			.extra1		= (void*) &parport_min_timeslice_value,
 			.extra2		= (void*) &parport_max_timeslice_value
 		},
-		{}
 	},
 	{
 		{
@@ -388,17 +385,13 @@ parport_device_sysctl_template = {
 			.maxlen		= 0,
 			.mode		= 0555,
 		},
-		{}
 	}
 };
 
 struct parport_default_sysctl_table
 {
 	struct ctl_table_header *sysctl_header;
-	struct ctl_table vars[3];
-	struct ctl_table default_dir[2];
-	struct ctl_table parport_dir[2];
-	struct ctl_table dev_dir[2];
+	struct ctl_table vars[2];
 };
 
 static struct parport_default_sysctl_table
@@ -423,7 +416,6 @@ parport_default_sysctl_table = {
 			.extra1		= (void*) &parport_min_spintime_value,
 			.extra2		= (void*) &parport_max_spintime_value
 		},
-		{}
 	}
 };
 
@@ -443,7 +435,9 @@ int parport_proc_register(struct parport *port)
 	t->vars[0].data = &port->spintime;
 	for (i = 0; i < 5; i++) {
 		t->vars[i].extra1 = port;
+#ifdef CONFIG_PARPORT_1284
 		t->vars[5 + i].extra2 = &port->probe_info[i];
+#endif /* IEEE 1284 support */
 	}
 
 	port_name_len = strnlen(port->name, PARPORT_NAME_MAX_LEN);

-- 
2.30.2

