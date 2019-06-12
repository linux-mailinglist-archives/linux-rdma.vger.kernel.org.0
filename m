Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60B964240A
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2019 13:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406413AbfFLLd4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jun 2019 07:33:56 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39193 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406355AbfFLLd4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Jun 2019 07:33:56 -0400
Received: by mail-ed1-f65.google.com with SMTP id m10so25224481edv.6
        for <linux-rdma@vger.kernel.org>; Wed, 12 Jun 2019 04:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-powerpc-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=TsABUyr6czjxkgVPVlQz/+LV8vXRq4YLo2VkQCGdbrI=;
        b=lqhSGRt2GPnBMZl9OHjZPdTnaGC8MuuF5RKiYHKLj+kJd0vO34ykhAMVvi3/ztrcb/
         m7s93ddk84XOaxuiJ3CZjQ+k3I/kXSCssrBrE3CD/s8IWGBLTJYHMk5AM5sJsin63LZF
         6z9sw8VObdVnzvdQ0cZT1IGNk/BA/RGUMHq0ivf9v+R37MnG0Byv+z69qfoLzB/+U0Dw
         Ofy5fV6mXIvP9G65alKRuPWQC6I82zmYPjBAsjXij0cUcTiYY7imMMkS/AuPxsEpdiD/
         I+ACUA99Jttddfz7yZBX3n7XJxHEaOPMdNqAdHrbzJ2GqITmRGg46um1E9qrfd+mdo03
         WBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TsABUyr6czjxkgVPVlQz/+LV8vXRq4YLo2VkQCGdbrI=;
        b=FL/mE7uIf38WDTqe3JiAUu7L57iMaRt+MudYBVvE4QPx+tLKjGxsiwMuU8Wm35weFq
         zcg0xvtbEGQxUvh4DAaKqRI0M5cseL4G1MvaCe4qZGVkU9nFlUOKuAERLoan+OKY9zzH
         MrACn2TTYYRpJQT5rGIHsdQVJo+VpDG+4qwErza0hQpJHSUL5GwJSZzEEkubAuSpIEJN
         fvUmSDf5TO85bvSuQ5K9Q+FIiUTNVPaTNdtE6exDDr/YOAgSo9H+4mLbagICGvD+H7Rw
         CyZV+hYeLQ+xyZ6A/ow+l/0maCvE4gmQMUSISf0u/8URm85MIFmREi2HYe7hHnke/Xzf
         hYAA==
X-Gm-Message-State: APjAAAUjZ0cMnLTzqm31YbJyVMuqKjPGNBTIe4TnnZoTrAVcgR6cJpaH
        EDX8O7uWZEG2TPPjutp8ORfcjQ==
X-Google-Smtp-Source: APXvYqwh3pugoDidWfjeiGQrMilab3hYM3dq0SIHQS9CnMI7n+pYFtoAg6OXHlsd8OjzJTtrkLadtg==
X-Received: by 2002:a50:8dc7:: with SMTP id s7mr34856137edh.268.1560339233963;
        Wed, 12 Jun 2019 04:33:53 -0700 (PDT)
Received: from tegmen.arch.suse.de (charybdis-ext.suse.de. [195.135.221.2])
        by smtp.gmail.com with ESMTPSA id i21sm2752934ejd.76.2019.06.12.04.33.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 12 Jun 2019 04:33:53 -0700 (PDT)
From:   Denis Kirjanov <kda@linux-powerpc.org>
X-Google-Original-From: Denis Kirjanov <dkirjanov@suse.com>
To:     davem@davemloft.net, dledford@redhat.com
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        Denis Kirjanov <kda@linux-powerpc.org>
Subject: [PATCH 1/2] ipoib: correcly show a VF hardware address
Date:   Wed, 12 Jun 2019 13:33:45 +0200
Message-Id: <20190612113348.59858-1-dkirjanov@suse.com>
X-Mailer: git-send-email 2.12.3
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
...

Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>
---
 drivers/infiniband/ulp/ipoib/ipoib_main.c | 1 +
 include/uapi/linux/if_link.h              | 1 +
 net/core/rtnetlink.c                      | 1 +
 3 files changed, 3 insertions(+)

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
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 5b225ff63b48..904ee1a7330b 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -702,6 +702,7 @@ enum {
 struct ifla_vf_mac {
 	__u32 vf;
 	__u8 mac[32]; /* MAX_ADDR_LEN */
+	__u8 addr_len;
 };
 
 struct ifla_vf_vlan {
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index cec60583931f..2e1b9ffbe602 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1230,6 +1230,7 @@ static noinline_for_stack int rtnl_fill_vfinfo(struct sk_buff *skb,
 		vf_rss_query_en.vf =
 		vf_trust.vf = ivi.vf;
 
+	vf_mac.addr_len = dev->addr_len;
 	memcpy(vf_mac.mac, ivi.mac, sizeof(ivi.mac));
 	vf_vlan.vlan = ivi.vlan;
 	vf_vlan.qos = ivi.qos;
-- 
2.12.3

