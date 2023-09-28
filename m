Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEC77B1DCC
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Sep 2023 15:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbjI1NU4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Sep 2023 09:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbjI1NUk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Sep 2023 09:20:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E49199;
        Thu, 28 Sep 2023 06:20:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8CE4FC4AF5E;
        Thu, 28 Sep 2023 13:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695907236;
        bh=8o6Wkw35mSCVhnOKFt6ClknFvPUd13GONPb8bhwpADE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=HIlWOSKnflZYvel5mQyGeX+gmJJL1K+LilMXYd6IzuwCYD/pX0XE7cmHV9c4nOI4A
         G/mkwjoUMxgPO9uLZV65HoYUoBxIiALIDd0v2EKOMEFnp5AOGGZpQFUJcruJ22uEaK
         6hZ/DjT4HKVs4Gn2aq0Qzauo+hlbISOX5wXlDc4/dqdkKwmBrrv64aJxB/7ayPmA3u
         SkJc3jtqdOhQq7fmfr4AfTJYsZ9nSQh0GwQ3B3bM6Ss0AJ+E8yLi6VkYwl9SjIv0Nk
         dbDndA8ukr878p7LrXNVzfNdGRORSE7mwMQVaG7cGntwej+ICqVYE0DUR7BraOIYwS
         zpRNDsJdBMXOw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 7596BE732D0;
        Thu, 28 Sep 2023 13:20:36 +0000 (UTC)
From:   Joel Granados via B4 Relay 
        <devnull+j.granados.samsung.com@kernel.org>
Date:   Thu, 28 Sep 2023 15:21:30 +0200
Subject: [PATCH 05/15] scsi: Remove now superfluous sentinel element from
 ctl_table array
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230928-jag-sysctl_remove_empty_elem_drivers-v1-5-e59120fca9f9@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1435;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=AA2i2ffT9doWEzIff4Zajp6KzJDIS2fsOGTMhAaBzPI=;
 b=owEB7QES/pANAwAKAbqXzVK3lkFPAcsmYgBlFX3dBMzSGGCPjKqz33CWWmIlVPmX0ZG079rEE
 swyLW78XdWJAbMEAAEKAB0WIQSuRwlXJeYxJc7LJ5C6l81St5ZBTwUCZRV93QAKCRC6l81St5ZB
 T7GeC/9Fj9+4xEMnCkTQFapmBGFCFKtx2YJeRuHAo0GBWLACG0DDu2Bq/aeCqY5a1VRczUgy2iG
 MrB6KcEeBrzNF65Rwq9n3LkqKtvhqBlEjpL5VUDRytrhp++LB+9uWq7GBE9kSvsg2iFVLzL5Kf1
 vukcj20IN9ZHg5L7G6S1rf0Qme59NiTfQqPWrtQhBlLqQpUQFOyIwb4yWxeEK8uNy1IYuvqQ/E3
 wpfg3TIxo1KHtVLm3h8zqAlW+Pf7n9Y1ojT4DscU67RqIoN6p133XKh/Uq1z4e72TMkqH1aD5Qi
 l2C+Ecc0DO8jdIHFP+hmPcu5ZurChtUCC6BrrPHZRCo3loAWnJ5rBX3dOF4MCrvRNX6wOab8Flg
 pn8K8Ewtqr7MP+RrGIXSz9pUu0EjBHk0kMBzENIu+m0ePrG3gpz7NpW2WUBWjZiSiw4buzxgKzz
 ZFP6ljJZXft/+hBDXWcJJ+AnT99TNDZeD3fJ8/6bRGsWAUGQQuzNNpVq0vK4U47NfOCGI=
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

Remove sentinel from scsi_table and sg_sysctls.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 drivers/scsi/scsi_sysctl.c | 3 +--
 drivers/scsi/sg.c          | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/scsi_sysctl.c b/drivers/scsi/scsi_sysctl.c
index 7f0914ea168f..c74da88b20d3 100644
--- a/drivers/scsi/scsi_sysctl.c
+++ b/drivers/scsi/scsi_sysctl.c
@@ -17,8 +17,7 @@ static struct ctl_table scsi_table[] = {
 	  .data		= &scsi_logging_level,
 	  .maxlen	= sizeof(scsi_logging_level),
 	  .mode		= 0644,
-	  .proc_handler	= proc_dointvec },
-	{ }
+	  .proc_handler	= proc_dointvec }
 };
 
 static struct ctl_table_header *scsi_table_header;
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 0d8afffd1683..22a59c5e22eb 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -1649,8 +1649,7 @@ static struct ctl_table sg_sysctls[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0444,
 		.proc_handler	= proc_dointvec,
-	},
-	{}
+	}
 };
 
 static struct ctl_table_header *hdr;

-- 
2.30.2

