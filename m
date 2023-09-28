Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF117B1DC9
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Sep 2023 15:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbjI1NUv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Sep 2023 09:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbjI1NUm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Sep 2023 09:20:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB181B1;
        Thu, 28 Sep 2023 06:20:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3C10C32779;
        Thu, 28 Sep 2023 13:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695907237;
        bh=5zO7s9Lwosi7QmmL2WLVnIc8u/uJoPITOshfrd6dPWg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=OZuf7hMNQH/6jfPbtQZPCoyl72bn87/HT1LPJ3FoDxaF5e08+Voy29HA90DNmKOoG
         K8KTyPsT29Q26moP3JUFagj7TAexacVLiF290EeK6+rY62iPg6ZyRTx4ilgv7E7E8F
         DvR4G7zQgEsTokMkNy6lVyh3stCdclTnVH5Vp3bKDcYTPfCdpzizojbvyyoPPS5pjd
         Mq7h9q+sOBnZ7vG+kASbLG/sVqWDBGgHfd0LO7kF40frLpwZuwHCNu4vrFnpG85OVQ
         lokojtHlhEBwQcvtiHV40wjfGBbAImHeFyFCmXQ0lP4q6HD2l3RILeABD1jxtaSzcZ
         GfMvBEvqEdDYQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id DD06BE732CF;
        Thu, 28 Sep 2023 13:20:36 +0000 (UTC)
From:   Joel Granados via B4 Relay 
        <devnull+j.granados.samsung.com@kernel.org>
Date:   Thu, 28 Sep 2023 15:21:34 +0200
Subject: [PATCH 09/15] char-misc: Remove the now superfluous sentinel
 element from ctl_table array
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230928-jag-sysctl_remove_empty_elem_drivers-v1-9-e59120fca9f9@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1462;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=tCD6uUjpENwGRI1wSieFMxVn0HaUdToj9oadXuH2mRs=;
 b=owEB7QES/pANAwAKAbqXzVK3lkFPAcsmYgBlFX3e649I8iEgCQ+8jvmfVnSbEH+5cM+/uGjHp
 +7sMjQufCiJAbMEAAEKAB0WIQSuRwlXJeYxJc7LJ5C6l81St5ZBTwUCZRV93gAKCRC6l81St5ZB
 TwJnC/0dPQEskd6EkB4tfpnbwc2TgKq0dfoj8tKncz1G9fyLn3o0DNocpaZy1J4AYL6xD9M4XOC
 kb8puBCX15k3E5sE5lbIupq0uxghhIz2QY6VgfmuomBSGqMVmc8v3gckB2sJCJ0z5cPwmGU9LLM
 wq7K6pONMby24XwTPGt/fPbLT0WQ6y5WkunD9VwmNnFA7zmxQCtUqfY644ugivFOBW5pgclR9hM
 C5jdw8MqjkddlipW10caCiPkzcMV+kSoo3qs3wHncPTT7vISH2e6tkmI2Xy75z1budS54vtamLX
 QwV6V1xjrMUdchaAvkfWGb/tMSrwmBFOgQuQ0mmvFwoQ26xpdGB0iMIQEopG12V2aUFxEI1/vaJ
 8Q6aXtkcH9hwbAp8iR1LbVAzPoCeivNtsvq9A8ogh/og192Qwas7QVtFgbNNcPKSovvljsGIJ6c
 iM6sGTzKbWd6JxxlKEyGZw2u6ept3Ng28GdM6XTYEcyB8nWkVSiKcpqhOpbwekS5ZZmaI=
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

Remove sentinel from impi_table and random_table

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 drivers/char/ipmi/ipmi_poweroff.c | 3 +--
 drivers/char/random.c             | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_poweroff.c b/drivers/char/ipmi/ipmi_poweroff.c
index 870659d91db2..b65ab51bf9fa 100644
--- a/drivers/char/ipmi/ipmi_poweroff.c
+++ b/drivers/char/ipmi/ipmi_poweroff.c
@@ -655,8 +655,7 @@ static struct ctl_table ipmi_table[] = {
 	  .data		= &poweroff_powercycle,
 	  .maxlen	= sizeof(poweroff_powercycle),
 	  .mode		= 0644,
-	  .proc_handler	= proc_dointvec },
-	{ }
+	  .proc_handler	= proc_dointvec }
 };
 
 static struct ctl_table_header *ipmi_table_header;
diff --git a/drivers/char/random.c b/drivers/char/random.c
index 3cb37760dfec..4040715cba19 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1682,8 +1682,7 @@ static struct ctl_table random_table[] = {
 		.procname	= "uuid",
 		.mode		= 0444,
 		.proc_handler	= proc_do_uuid,
-	},
-	{ }
+	}
 };
 
 /*

-- 
2.30.2

