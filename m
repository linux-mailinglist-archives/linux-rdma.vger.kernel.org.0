Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F457B1D96
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Sep 2023 15:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbjI1NUl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Sep 2023 09:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbjI1NUk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Sep 2023 09:20:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BB61A1;
        Thu, 28 Sep 2023 06:20:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A18DC433C9;
        Thu, 28 Sep 2023 13:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695907236;
        bh=+p+3vHCOnUcUaEzZMikCulI1IPUTmdWXYayvngQD2c0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=mzqRR96IqOZqBV5Yb0dgWU0g+ijF3CCcgQV8S2BnNG36CqililXyXW37lordws2Vw
         bNf6j8BwbWRDMeAcl1HJOdx6hI377pUARbrjgx7ob7RjW3rDK9yC8WDNFe49rBrihM
         SRax7GlmUHTBCuaX68KoMbgdJpg1g29quUvtPBJM71IxEEhlfArNI2+MLgFFFhp6ut
         XGt2pYmn3y+gLvv0J+hT8UGnuqIt6mca8/uqCZe0Hm7ts6AedSzrn1CEAb/tIm6X7K
         frhHjXYWRlVVztapw0snIidTYgTTytN8HP2qM9OzocYqcnEp6AZflrO0g9MJuc5r2A
         6HJCN2L6WD34Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 330D6E732C8;
        Thu, 28 Sep 2023 13:20:36 +0000 (UTC)
From:   Joel Granados via B4 Relay 
        <devnull+j.granados.samsung.com@kernel.org>
Date:   Thu, 28 Sep 2023 15:21:27 +0200
Subject: [PATCH 02/15] hpet: Remove now superfluous sentinel element from
 ctl_table array
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230928-jag-sysctl_remove_empty_elem_drivers-v1-2-e59120fca9f9@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=923; i=j.granados@samsung.com;
 h=from:subject:message-id; bh=Cw9ABMFpnyv2zFyB+i4J8EYtdLPON6S7im56m99/UHA=;
 b=owEB7QES/pANAwAKAbqXzVK3lkFPAcsmYgBlFX3cZP4/W+a6sX+4Mbxog+vl7vqsH0tWzrKp3
 dRTfVbxK26JAbMEAAEKAB0WIQSuRwlXJeYxJc7LJ5C6l81St5ZBTwUCZRV93AAKCRC6l81St5ZB
 T9riDACUD/Jre8jcU5+OvZKiBvH9XjdFMaKU0co+i5vm3FNZOXTjdH7XvrWf6kbuzCSiDyCiJkt
 FfwX7rwRlRjmiTOkycbkZJcqJagqVg7uxyKIGWg3P79nnNJnjxx9YOiegks9BtVKXknXd9MO6Ux
 PleMQagWbT5PrsWC+oMdYZNVsHntVjOY0lE3WjXs/ZjSvYBZByjEuLvDehTeCxmCs2m5jgfqdq7
 Fnd8lWtAAQY+Um+ElRHzadglJc3Akj6O3oGUTjhj1ZgmfGw8oPgW4JfezIFSMZo+AJDJGk2b9HZ
 8j7uwkNQgJtwaH/Ty6v0XoEFtMcHHgmQFyzMoZzJfoIL5FTp4SB105XILABtwkECic2YKTT09QZ
 Qn5wS4xu4MPLFa4Jl6c8dVu8oH0XW2vZwYzLxsCAns1xaSjTneTH8mzdjL0Nynb1mzwEKekXUwd
 rquzFSuo8rALGrUnmLnGnAeyuf3mXIjz59ACyQlZQwNAgoxYbuktFTrpIxa5wy4CngcnM=
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

Remove the last empty element from hpet_table.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 drivers/char/hpet.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
index ee71376f174b..11f466fea5ed 100644
--- a/drivers/char/hpet.c
+++ b/drivers/char/hpet.c
@@ -727,8 +727,7 @@ static struct ctl_table hpet_table[] = {
 	 .maxlen = sizeof(int),
 	 .mode = 0644,
 	 .proc_handler = proc_dointvec,
-	 },
-	{}
+	}
 };
 
 static struct ctl_table_header *sysctl_header;

-- 
2.30.2

