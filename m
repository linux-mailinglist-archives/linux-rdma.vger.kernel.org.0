Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747967B4E07
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Oct 2023 10:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236000AbjJBIx0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Oct 2023 04:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235916AbjJBIxW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Oct 2023 04:53:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA7A91;
        Mon,  2 Oct 2023 01:53:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E83FC4E67B;
        Mon,  2 Oct 2023 08:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696236795;
        bh=vDlxMU2ggFFcgL4XVv7yaCla84NzDst78pAlmrI/LAU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=pR95+O9r6nUzq07c9kPGKb7Ab0VcY5+68ndSSzB+hZmwZYikEf3FKE5QZgbbuqjOX
         gQkhguZwdsurCaU0axfIZ2F0cJCq86v09nWDCYqoJnOhNSunu1At9WlawEgkBrEmJ6
         y18G/0sKMdEFBxdOakpL3K6ARrEuVanraUCM76n/OBLvRpO3S0uhlUJVkFeuWm+fyr
         dbr8FI1IRqLxTOLySLXMasu08oJ1w1pZXHhh4+kaXfndJ8OZR17RetwZax4Z6ehYkJ
         mIoVTZonmVbDcGCi8ny+uoSKjBM1DIy75fzJacAsTb3IqeKffbenQJRDWZ7+Dfqjc4
         7r/qhjuBtwo0A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 87B1FE7849A;
        Mon,  2 Oct 2023 08:53:15 +0000 (UTC)
From:   Joel Granados via B4 Relay 
        <devnull+j.granados.samsung.com@kernel.org>
Date:   Mon, 02 Oct 2023 10:55:26 +0200
Subject: [PATCH v2 09/15] char-misc: Remove the now superfluous sentinel
 element from ctl_table array
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231002-jag-sysctl_remove_empty_elem_drivers-v2-9-02dd0d46f71e@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1339;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=Kv0ap7oOhCIEujO7K32kNHT+ZxUGAQsjjs8+/enag5M=;
 b=owEB7QES/pANAwAKAbqXzVK3lkFPAcsmYgBlGoV+isCI8TDO6pwR+wgikdJs6dLv5S5QCOB04
 iOxWZrSGSiJAbMEAAEKAB0WIQSuRwlXJeYxJc7LJ5C6l81St5ZBTwUCZRqFfgAKCRC6l81St5ZB
 T6oTC/9qOUC9BOwrcAbb8+8X5NEMfhYEKBwZOjn0qP7z2HP9F0B0s13QbRcV+nD/AboNml1SyV1
 2bME5eSPBRhDk/FgUi2dHVoWST0piu5f+xZVAdCGk0dlm6zx066OrZgELiJpoohNDrDPt3Hw74l
 vDFg1cmFZeVWLG+9hQVfG+0ip5WPINFZL6HG5Qaf5vQovahB6Axer95+p066sCI/hydwE7wEmQW
 AaBpPNfAYpiEL3HtJ935jxFkTOmK8sqEwQTXsN1aJcHVhbXpAwOog7xO+DfU6DOBHTdb4MVBOxq
 BDdLiqegmjac+IlK2slz/WfvUKW0V+2LZN7aJ0/GqoMforwaGZwvUhwn34nmenlx7NcpDwgIKDx
 orVBtck2IN7tetdBhNLpoy3r7xDl7WRjm3f3xIxDXcUNqlOY9x1VyHKww5KiFk49KJ9UPmc8tKT
 3ACEiDi7UvwEFAfJwF4Zc34OpSkdkpY3PQGUWRU0h2+aTGNKyDRzq42XfqrCcpxTHv5xA=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
Reply-To: <j.granados@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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

Remove sentinel from impi_table and random_table

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 drivers/char/ipmi/ipmi_poweroff.c | 1 -
 drivers/char/random.c             | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_poweroff.c b/drivers/char/ipmi/ipmi_poweroff.c
index 870659d91db2..941d2dcc8c9d 100644
--- a/drivers/char/ipmi/ipmi_poweroff.c
+++ b/drivers/char/ipmi/ipmi_poweroff.c
@@ -656,7 +656,6 @@ static struct ctl_table ipmi_table[] = {
 	  .maxlen	= sizeof(poweroff_powercycle),
 	  .mode		= 0644,
 	  .proc_handler	= proc_dointvec },
-	{ }
 };
 
 static struct ctl_table_header *ipmi_table_header;
diff --git a/drivers/char/random.c b/drivers/char/random.c
index 3cb37760dfec..4a9c79391dee 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1683,7 +1683,6 @@ static struct ctl_table random_table[] = {
 		.mode		= 0444,
 		.proc_handler	= proc_do_uuid,
 	},
-	{ }
 };
 
 /*

-- 
2.30.2

