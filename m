Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C4A7B4E12
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Oct 2023 10:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235935AbjJBIxV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Oct 2023 04:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235920AbjJBIxT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Oct 2023 04:53:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6DBC4;
        Mon,  2 Oct 2023 01:53:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E058EC433CA;
        Mon,  2 Oct 2023 08:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696236795;
        bh=t9nUnlsUSGSA6KXDG9eIUL8NkaKGhkaZ+k9zMU/msOg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=aZC8ob0hBMVk/wW7CrMfHJAbHgX2r4sD/N1pYyMgeZPSD986C/6LQvjoHrLdt9uo/
         AvWc8ItdH5zANDM/BWHExhTO0vMgN4wZUbYWLFbxL0fLqvO3sdGIen+rLKCRM7HalK
         WdxkvK2kIchZghqnMFEV1uotHf/kI6qDyNQo5vyOcl9EPWFRLmXc30qj8QCOU00u/K
         a5COzI0S1cShOdJCYZILXR2eqvaAir/yUVEohOvIFqlLF0kSv9ZkZ5rthTWWEaobE/
         2xOp01TTELGSZ87Lfr38Nudyjn+xoH5tZ2P7iKWsnwLFrEJLkYT90+yOhMifOOt3CP
         9rey/67aYTa8A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id C92CBE784A4;
        Mon,  2 Oct 2023 08:53:14 +0000 (UTC)
From:   Joel Granados via B4 Relay 
        <devnull+j.granados.samsung.com@kernel.org>
Date:   Mon, 02 Oct 2023 10:55:18 +0200
Subject: [PATCH v2 01/15] cdrom: Remove now superfluous sentinel element
 from ctl_table array
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231002-jag-sysctl_remove_empty_elem_drivers-v2-1-02dd0d46f71e@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=892; i=j.granados@samsung.com;
 h=from:subject:message-id; bh=HP9sX3Yq6no3LIGS7gxj0QQAPjl1kSKLH9YGL6vsrCg=;
 b=owEB7QES/pANAwAKAbqXzVK3lkFPAcsmYgBlGoV7aj+83oYeqb6g5LqMcPrlSYA/sw3XNVtGi
 Tcihv7W1e6JAbMEAAEKAB0WIQSuRwlXJeYxJc7LJ5C6l81St5ZBTwUCZRqFewAKCRC6l81St5ZB
 T11zC/4isu/2elcU5kFo1V5OSm37bxnkesh8BXCmqaU8pLDmABQPsaVAjhuaMiVbkWywdosML0J
 eP1RbZREtG8tHA6hHvcQsiGPfV9VY7ZBY1izxZ80Omx6lGmNThQ7JKoH4eUk+fXenQGzJg0YCEg
 uQ2ICUEUTlPKK4WMlEPkh3fpxrqROwTV+otJdR6avKiRPLM97uCNupakiOCqOcB/6BG7kOTc28W
 OAeIilC+3jn3ceUirFEqPijJ1Yqs0aSvHBRf+OWKgMo9rakMo0He0gazX1Q9tfIeInipcs/syO3
 HiRA8VyEZDMGLd2lcOxrko1eA04kSPUHzQSOTNTnId65w/EiSv9j0FKxPT4p5qwslYQOxp096rZ
 AKmZAryXj/h7R9EAQxxgUpLxsuEpRs8NFX9A4t/zM/kyoNJGM92xl/pFHdARq3GMzxTYav4Gl30
 ydelfjzMw2s6dE2Vc3Qy88S86774JSBNoouXG9eJuxHPAZlvzjhxjH+oXYvGmyGX71VrY=
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

Remove sentinel element from cdrom_table

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 drivers/cdrom/cdrom.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index cc2839805983..a5e07270e0d4 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -3655,7 +3655,6 @@ static struct ctl_table cdrom_table[] = {
 		.mode		= 0644,
 		.proc_handler	= cdrom_sysctl_handler
 	},
-	{ }
 };
 static struct ctl_table_header *cdrom_sysctl_header;
 

-- 
2.30.2

