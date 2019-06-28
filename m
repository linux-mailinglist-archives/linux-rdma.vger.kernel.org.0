Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA3C2597F7
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jun 2019 11:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfF1Jyf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Jun 2019 05:54:35 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33999 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfF1Jyf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Jun 2019 05:54:35 -0400
Received: by mail-ed1-f65.google.com with SMTP id s49so10211680edb.1
        for <linux-rdma@vger.kernel.org>; Fri, 28 Jun 2019 02:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-powerpc-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=zijQ0vKQpmmSMmIBGOngMYzVjH1lavH3ZmuxMYJW1/c=;
        b=mQPTFiYjDFtKzEr5716YLZ0/EE6nic8xb5a/zvCQ12XlOYE5pGGTQ7nvQO1sh1WOHY
         /CCGFuwcusRiflLm2he0DAN+/2mPZJJR09RF8TtORWtnTlVPPwnsfP68d8945FQqIaDA
         vqOju+uG/LVCzTOXQFFtoJJmJ3wZ+Yau0YX+EZWJ/kQhoBrYx04WZVmMEl4o4aCMEEnt
         5x1rupEj4050iSx6DOLunrpf77iTcXZ5RF5HFqP2DeW3auj4kJnprX0TMNZYFRd8sW4d
         ayAVJqr02GORZJSu6bIsQxOYTSr+W0qGcF8gx1yUjvugh1NAGjRnpC1tF6c2iaa4MRrC
         0aGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zijQ0vKQpmmSMmIBGOngMYzVjH1lavH3ZmuxMYJW1/c=;
        b=mmSdYx+AV0vOuOPUCEZG1ad70w+vtnI4yiTE9fmZ8QMMKZz0H9wVuo0sajgywVOeF9
         +niApMyk+y3lV6nKvuy3uH6WNVsIQhy5cZzphd+TXtDgxjRgEaRidbn0AHb9q29F5KT9
         BIU/+BCOdz6eMyOLo9UkMFvGq9rnfv4dVBTOZE1KWADFWoOI8pSaIBeR21GAKOnR4EsG
         qyW93EKpZnfmP7lNy0XfwjvnCeyDIwE+SP9xitwDEaMUZCbytIbqHGY+Zw8GPnYHW7lY
         sVXcf6w7xrxrx6Nko6N6YsfPRDEt3tWZ8ZkVAif14/QtjOJU2dNM5ZPgf6DRwAhMF0PF
         k8HQ==
X-Gm-Message-State: APjAAAV5+gdfsypmq40YG3gEt2YJH2Ew8lJYZgwO8cLz04plPsa0NrCA
        8iXgxjFUiissLaVynkmbcG01jg==
X-Google-Smtp-Source: APXvYqz+g13oSCgKrIbcw3oziJsTT303AgVBuLRsORpmG//aPzwD5Vl3CfnKYjr6OL6Fx5UQGU10jA==
X-Received: by 2002:a17:906:9410:: with SMTP id q16mr7758263ejx.90.1561715673351;
        Fri, 28 Jun 2019 02:54:33 -0700 (PDT)
Received: from tegmen.arch.suse.de (nat.nue.novell.com. [195.135.221.2])
        by smtp.gmail.com with ESMTPSA id e12sm536721edb.72.2019.06.28.02.54.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 02:54:32 -0700 (PDT)
From:   Denis Kirjanov <kda@linux-powerpc.org>
X-Google-Original-From: Denis Kirjanov <dkirjanov@suse.com>
To:     stephen@networkplumber.org, dsahern@gmail.com
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        dledford@redhat.com, mkubecek@suse.cz,
        Denis Kirjanov <kda@linux-powerpc.org>
Subject: [PATCH iproute2-next v4 1/2] ipaddress: correctly print a VF hw address in the IPoIB case
Date:   Fri, 28 Jun 2019 11:54:25 +0200
Message-Id: <20190628095426.2819-1-dkirjanov@suse.com>
X-Mailer: git-send-email 2.12.3
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Current code assumes that we print ethernet mac and
that doesn't work in the IPoIB case with SRIOV-enabled hardware

Before:
11: ib1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 2044 qdisc pfifo_fast
state UP mode DEFAULT group default qlen 256
        link/infiniband
80:00:00:66:fe:80:00:00:00:00:00:00:24:8a:07:03:00:a4:3e:7c brd
00:ff:ff:ff:ff:12:40:1b:ff:ff:00:00:00:00:00:00:ff:ff:ff:ff
        vf 0 MAC 14:80:00:00:66:fe, spoof checking off, link-state
disable,
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

v1->v2: updated kernel headers to uapi commit
v2->v3: fixed alignment
v3->v4: aligned print statements as used through the source

Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>
---
 ip/ipaddress.c | 40 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/ip/ipaddress.c b/ip/ipaddress.c
index b504200b..741b8667 100644
--- a/ip/ipaddress.c
+++ b/ip/ipaddress.c
@@ -26,6 +26,7 @@
 
 #include <linux/netdevice.h>
 #include <linux/if_arp.h>
+#include <linux/if_infiniband.h>
 #include <linux/sockios.h>
 #include <linux/net_namespace.h>
 
@@ -349,9 +350,10 @@ static void print_af_spec(FILE *fp, struct rtattr *af_spec_attr)
 
 static void print_vf_stats64(FILE *fp, struct rtattr *vfstats);
 
-static void print_vfinfo(FILE *fp, struct rtattr *vfinfo)
+static void print_vfinfo(struct ifinfomsg *ifi, FILE *fp, struct rtattr *vfinfo)
 {
 	struct ifla_vf_mac *vf_mac;
+	struct ifla_vf_broadcast *vf_broadcast;
 	struct ifla_vf_tx_rate *vf_tx_rate;
 	struct rtattr *vf[IFLA_VF_MAX + 1] = {};
 
@@ -365,13 +367,41 @@ static void print_vfinfo(FILE *fp, struct rtattr *vfinfo)
 	parse_rtattr_nested(vf, IFLA_VF_MAX, vfinfo);
 
 	vf_mac = RTA_DATA(vf[IFLA_VF_MAC]);
+	vf_broadcast = RTA_DATA(vf[IFLA_VF_BROADCAST]);
 	vf_tx_rate = RTA_DATA(vf[IFLA_VF_TX_RATE]);
 
 	print_string(PRINT_FP, NULL, "%s    ", _SL_);
 	print_int(PRINT_ANY, "vf", "vf %d ", vf_mac->vf);
-	print_string(PRINT_ANY, "mac", "MAC %s",
-		     ll_addr_n2a((unsigned char *) &vf_mac->mac,
-				 ETH_ALEN, 0, b1, sizeof(b1)));
+
+	print_string(PRINT_ANY,
+			"link_type",
+			"    link/%s ",
+			ll_type_n2a(ifi->ifi_type, b1, sizeof(b1)));
+
+	print_color_string(PRINT_ANY, COLOR_MAC,
+			"address", "%s",
+			ll_addr_n2a((unsigned char *) &vf_mac->mac,
+				ifi->ifi_type == ARPHRD_ETHER ?
+				ETH_ALEN : INFINIBAND_ALEN,
+				ifi->ifi_type,
+				b1, sizeof(b1)));
+
+	if (vf[IFLA_VF_BROADCAST]) {
+		if (ifi->ifi_flags&IFF_POINTOPOINT) {
+			print_string(PRINT_FP, NULL, " peer ", NULL);
+			print_bool(PRINT_JSON,
+					"link_pointtopoint", NULL, true);
+		} else
+			print_string(PRINT_FP, NULL, " brd ", NULL);
+
+		print_color_string(PRINT_ANY, COLOR_MAC,
+				"broadcast", "%s",
+				ll_addr_n2a((unsigned char *) &vf_broadcast->broadcast,
+					ifi->ifi_type == ARPHRD_ETHER ?
+					ETH_ALEN : INFINIBAND_ALEN,
+					ifi->ifi_type,
+					b1, sizeof(b1)));
+	}
 
 	if (vf[IFLA_VF_VLAN_LIST]) {
 		struct rtattr *i, *vfvlanlist = vf[IFLA_VF_VLAN_LIST];
@@ -1102,7 +1132,7 @@ int print_linkinfo(struct nlmsghdr *n, void *arg)
 		open_json_array(PRINT_JSON, "vfinfo_list");
 		for (i = RTA_DATA(vflist); RTA_OK(i, rem); i = RTA_NEXT(i, rem)) {
 			open_json_object(NULL);
-			print_vfinfo(fp, i);
+			print_vfinfo(ifi, fp, i);
 			close_json_object();
 		}
 		close_json_array(PRINT_JSON, NULL);
-- 
2.12.3

