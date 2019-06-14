Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5DF645E3F
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jun 2019 15:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbfFNNc7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Jun 2019 09:32:59 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33156 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727729AbfFNNc7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 14 Jun 2019 09:32:59 -0400
Received: by mail-ed1-f65.google.com with SMTP id i11so3576813edq.0
        for <linux-rdma@vger.kernel.org>; Fri, 14 Jun 2019 06:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-powerpc-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=Xbwbd2FuvWF2sMTKfN6EsRdJUe6Rnva9AqWY64EVH9E=;
        b=P4l/749/6w7w0u+I8a0x9Mq6xwN8uEi6lcuObPfC2jGJOxxj977gYw0P9DNxMVRYuR
         IeDNWHg9wrpACLRYw2HrSHnu5PeggUS4RlzDPThp4ri1ot4kcF+b42joYzOZNZalZy4A
         eZNnJyrm64lHAOL1KEd4B6Jz2nPGXg4hB0NTUqO5CBVT8Vfo5nUHVRHn1O9pg4viLYGl
         IYCa294nYs0O79355NxX0sF2M0h0ryvvhCTu5mEd+dPjZKMqjaQo+jnbk+GclvkQYhyQ
         lpNf7dDaUrPQnd0MP3kywWXN0IofSPdUjvwh3+E6F8qBTX31VHFr8U8ikkbJpulVQwim
         e4mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Xbwbd2FuvWF2sMTKfN6EsRdJUe6Rnva9AqWY64EVH9E=;
        b=qEYqVgQwfQFN2px7UZrxKVh3hstGQr9vWSLJvdq02mROGVeQbYE8XQaVaCfPsbYpRV
         becwhYx3EPBlsUOns6NmWx4EJZALVyrjWYyDTXV+A1Gy4Omcg5CDINp1W98WLSdDJagf
         pK0LZeJNkZcn0dFZLjALZmqGd/D961+vJfVkuv0HGeRhoS+T9D9Em95CBrqCJMYTiiVo
         +XvWBcjc4RRhxyQbukXubWpvtEhuc4UkXUOxHbFIqs9CLgXu/gJAhR7EOPAf0ZXIIVkC
         2N9hKmvR/Wgs9Fq+1/MOlOn2VtPraTO7ikzsE/UgXLiFRrNrjtLUMqRsp3HAQJIQjmWb
         M/ZA==
X-Gm-Message-State: APjAAAXGPft8izSvVq//OgAp7yktHQF+D4upFv+us7uELm8Noc/uPUkz
        bWSV9J8uyNdg6/j3epwz2DygPw==
X-Google-Smtp-Source: APXvYqy/MDwtm+0C6d59yT9OcEDGG8IZkCrMOAK6009SIIyKNiw673+xIZDafT6Y4ZxuqudSwaeuaQ==
X-Received: by 2002:a17:906:1858:: with SMTP id w24mr73721955eje.212.1560519177434;
        Fri, 14 Jun 2019 06:32:57 -0700 (PDT)
Received: from tegmen.arch.suse.de (nat.nue.novell.com. [195.135.221.2])
        by smtp.gmail.com with ESMTPSA id r11sm320509ejr.57.2019.06.14.06.32.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Jun 2019 06:32:56 -0700 (PDT)
From:   Denis Kirjanov <kda@linux-powerpc.org>
X-Google-Original-From: Denis Kirjanov <dkirjanov@suse.com>
To:     davem@davemloft.net, dledford@redhat.com
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        mkubecek@suse.cz, Denis Kirjanov <kda@linux-powerpc.org>
Subject: [PATCH 1/2] ipoib: correcly show a VF hardware address
Date:   Fri, 14 Jun 2019 15:32:46 +0200
Message-Id: <20190614133249.18308-1-dkirjanov@suse.com>
X-Mailer: git-send-email 2.12.3
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

