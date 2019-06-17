Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3B147DAA
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2019 10:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfFQIxv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Jun 2019 04:53:51 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43686 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727342AbfFQIxv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 Jun 2019 04:53:51 -0400
Received: by mail-ed1-f68.google.com with SMTP id e3so14968582edr.10
        for <linux-rdma@vger.kernel.org>; Mon, 17 Jun 2019 01:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-powerpc-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Xbwbd2FuvWF2sMTKfN6EsRdJUe6Rnva9AqWY64EVH9E=;
        b=mGXtzatvJrQq8a//WSUgeckp9VrsVo2XiJ/fJ82pDg56n2EhjYzYNUsYLksxzJqezW
         mocMJ5p73B44zkYB5X7UM308G1qMiouHWibIpElrO6a9p0cPPtfguTzxYZ+PHzGrnZT9
         az7sNDZq9T46e2hdE9lUtSJ4SaqqwCnQh2TUHaT/XWWJAI0SNJbEDZKSq8WrQHnnIeZ2
         w/lB0+bxF414cIu8bdcz5kJ7ry6WfwF4vzxcgE5mMARAPNqEwfzM8of88T+Lb6LoEU+K
         t7/BecBeTB+CycoI8/Vh7E2b6U1JsZ28g1AMfqdynEwe9Vgijlf3oNItMu5ey/CmMbNs
         WM0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Xbwbd2FuvWF2sMTKfN6EsRdJUe6Rnva9AqWY64EVH9E=;
        b=tcgRpkNdUM9DstiHg+eghjA9w+wxru5fjHNmWyT6s1Zt8DlOT3wg/oRWKY+CAPvQ/E
         1T3qcXJ/mQ/KtaLnW9RcQcajBAQIxvvpPc4O/99H1oCdyuBQVuBA/nETx6UKVBPvCoqK
         I0fYE3n5eJo/SdojC+wVyCzQxaN6IE7jJt1RbjMij26uLcxRcHoBOYhcL9Bt67LNwQ+D
         hYYZrjeLoKkBCuezIWSjpp+RLhimxrtSK+0Bkl5QzQNLmEJK/juCseC01tW7/42NDHz8
         XvGRpjwFGCrIbYNWUPgdLvnHxCjHlwMorBSJDKTy2z3s55bFcoKnfVOpewtAiKDfNenv
         48fg==
X-Gm-Message-State: APjAAAXCnYdLFH9dn0WGkAZGs4OqeNDAsp1PPDfZijBGjIxDj68vanT3
        zmNPKjG7IJ/BOr2FPP6By7qVSg==
X-Google-Smtp-Source: APXvYqwrjBgN6Nb/wgweArzBrYYBNqK8jfpaXqCx+M2bb14EQRkWWWnQ33cl2Nsbw9np3fcVSfz5hA==
X-Received: by 2002:a17:906:8053:: with SMTP id x19mr76442222ejw.306.1560761629426;
        Mon, 17 Jun 2019 01:53:49 -0700 (PDT)
Received: from tegmen.arch.suse.de (nat.nue.novell.com. [195.135.221.2])
        by smtp.gmail.com with ESMTPSA id y11sm2075735ejb.54.2019.06.17.01.53.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Jun 2019 01:53:48 -0700 (PDT)
From:   Denis Kirjanov <kda@linux-powerpc.org>
X-Google-Original-From: Denis Kirjanov <dkirjanov@suse.com>
To:     davem@davemloft.net, dledford@redhat.com
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        mkubecek@suse.cz, Denis Kirjanov <kda@linux-powerpc.org>
Subject: [PATCH net-next v4 1/2] ipoib: correcly show a VF hardware address
Date:   Mon, 17 Jun 2019 10:53:40 +0200
Message-Id: <20190617085341.51592-3-dkirjanov@suse.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20190617085341.51592-1-dkirjanov@suse.com>
References: <20190617085341.51592-1-dkirjanov@suse.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

in the case of IPoIB with SRIOV enabled hardware
ip link show command incorrecly prints
0 instead of a VF hardware address.

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

v1->v2: just copy an address without modifing ifla_vf_mac
v2->v3: update the changelog

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

