Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBF343826
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2019 17:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732487AbfFMPDu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Jun 2019 11:03:50 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37346 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732485AbfFMOUN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Jun 2019 10:20:13 -0400
Received: by mail-ed1-f68.google.com with SMTP id w13so31507163eds.4
        for <linux-rdma@vger.kernel.org>; Thu, 13 Jun 2019 07:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-powerpc-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l2XZf3MqSLL1068ArIZ1fX7e7BFKW+hoxEr0Z73hDYU=;
        b=wlnKxYFzVZAhVfDEKfEq/S9BWL/d8LsN46UzobezevW7QcLbccNwTYXGDAD5aPLH46
         MOzFT1yqUoHiXGSohup1c0AbXgEcyX363SAQMQuX9xbgiTRnIbSIITWv/T72CqBqOptA
         X3gCSTeS4CKUVQWiZT5ZHWXi07yFkzWl5pXXnP3O+5m20qXpBjYhfgisYlN9k5rXKEsu
         mTaGhYWGmUeHQvDb1A4kuaC779hwD1jwJmG76fEBNnn6pWraiQ7V37kAhYgFzuccNqPz
         oO/dyVZhUR3cGjr4+6x963S0e1+pA1djGSr2XVkuOid4FU9tB3w/2h/V/2S4yLKG8P+S
         GhNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l2XZf3MqSLL1068ArIZ1fX7e7BFKW+hoxEr0Z73hDYU=;
        b=mCiAQ5TwBbCcOC2fK9pnVbEm4qba3aftclEW9nHRZq1Tp7dhnIBBdnUkE9DeMfyYEE
         Ozf9ELHXS17zQpHzHlz4un/xtB8jTBKAfK3MiPvlwFvcWBXO+GOF/JHUg/UbDbZOWd4k
         jkTmx94EgqnbQ5Ie+z2lxM3x6mQwXGGEmcb+m78Cy4iwFqOhtUFaJ2vS+yDCq1N24jY2
         vTDvocSfYakiUXdj4hoYP/AyCcOlGl2b34mRNcshU32CjGHF79uLFbvhIzFjguk9idBI
         PCwtlYoMw/RCCR99x9pl5mQqvhxXI2okct3PMZ4drX7HU9sMJ+zwI0FoYgqiwkNpKw+j
         Zjdw==
X-Gm-Message-State: APjAAAXLU3/A2kHlWj0vOKUj/6B09FzIAP5++omNvZSd9x0JuGARMpWT
        F4naN+hK1tz2otm9ZgIeEcMmEQ==
X-Google-Smtp-Source: APXvYqxKWMiRpgcDCIIh/0S+T8OwFs1xE2aRwYnGai6MS2b984ArIgDAmqmX+DtQrGNYbvWsxUp+PA==
X-Received: by 2002:a50:b66f:: with SMTP id c44mr28242447ede.171.1560435611510;
        Thu, 13 Jun 2019 07:20:11 -0700 (PDT)
Received: from tegmen.arch.suse.de (charybdis-ext.suse.de. [195.135.221.2])
        by smtp.gmail.com with ESMTPSA id s57sm931939edd.54.2019.06.13.07.20.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Jun 2019 07:20:10 -0700 (PDT)
From:   Denis Kirjanov <kda@linux-powerpc.org>
X-Google-Original-From: Denis Kirjanov <dkirjanov@suse.com>
To:     davem@davemloft.net, dledford@redhat.com
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        mkubecek@suse.cz, Denis Kirjanov <kda@linux-powerpc.org>
Subject: [PATCH net-next v2 1/2] ipoib: correcly show a VF hardware address
Date:   Thu, 13 Jun 2019 16:20:02 +0200
Message-Id: <20190613142003.129391-3-dkirjanov@suse.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20190613142003.129391-1-dkirjanov@suse.com>
References: <20190613142003.129391-1-dkirjanov@suse.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

in the case of IPoIB with SRIOV enabled hardware
ip link show command incorrecly prints
0 instead of a VF hardware address. To correcly print the address
add a new field to specify an address length.

Before:
11: ib1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 2044 qdisc pfifo_fast
state UP mode DEFAULT group default qlen 256
    link/infiniband
80:00:00:66:fe:80:00:00:00:00:00:00:24:8a:07:03:00:a4:3e:7c brd
00:ff:ff:ff:ff:12:40:1b:ff:ff:00:00:00:00:00:00:ff:ff:ff:ff
    vf 0 MAC 00:00:00:00:00:00, spoof checking off, link-state disable,
trust off, query_rss off
...
After:
11: ib1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 2044 qdisc pfifo_fast
state UP mode DEFAULT group default qlen 256
    link/infiniband
80:00:00:66:fe:80:00:00:00:00:00:00:24:8a:07:03:00:a4:3e:7c brd
00:ff:ff:ff:ff:12:40:1b:ff:ff:00:00:00:00:00:00:ff:ff:ff:ff
    vf 0     link/infiniband
80:00:00:66:fe:80:00:00:00:00:00:00:24:8a:07:03:00:a4:3e:7c brd
00:ff:ff:ff:ff:12:40:1b:ff:ff:00:00:00:00:00:00:ff:ff:ff:ff, spoof
checking off, link-state disable, trust off, query_rss off

Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>
---
 drivers/infiniband/ulp/ipoib/ipoib_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index 9b5e11d3fb85..04ea7db08e87 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -1998,6 +1998,7 @@ static int ipoib_get_vf_config(struct net_device *dev, int vf,
 		return err;
 
 	ivf->vf = vf;
+	memcpy(ivf->mac, dev->dev_addr, dev->addr_len);
 
 	return 0;
 }
-- 
2.12.3

