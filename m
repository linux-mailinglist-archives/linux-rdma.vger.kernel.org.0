Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12B1CEA9A
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Apr 2019 21:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbfD2TDa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Apr 2019 15:03:30 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36675 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbfD2TDa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 Apr 2019 15:03:30 -0400
Received: by mail-qt1-f196.google.com with SMTP id c35so13279288qtk.3
        for <linux-rdma@vger.kernel.org>; Mon, 29 Apr 2019 12:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dev-mellanox-co-il.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=xEp/PI74uIiokqtwQYXQXDufFMZ8YrnL6KbBxF6ooO8=;
        b=bS3JqR7qKthrfVWhqNmtjnzY+UChJ/aKvSOel+yuqceOTihU/3oAkfFUxUM5QvT26n
         wzo1spiPbMTJ4m/xvdft8hQH+j0Xzn7N6qAEeZn7VAq8alxOt9qYSwlC/FePRqLqpeMQ
         PrmlhEdvyzy1sWFDuKXa4ENMlprn0TEr92gUFDJwXpex7EAXDhfdThqNYfNdwzJIe/26
         7HXe5/5hJxEQLQE+bZbQjl7dYzmnqAfNpH+I3g0VPULfbr8jhEktdQdXAnITInZqAubK
         iqhaWCvTp2HEYYXZWzFnsmR9nPFkk9wMpoELWA2igrob8dgHU6rmQy+6QOY8M89D1Tdg
         KQ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=xEp/PI74uIiokqtwQYXQXDufFMZ8YrnL6KbBxF6ooO8=;
        b=i5mRG/dc4CLcPuO03XpVSOeYfAXZzeUA4alpLLrrlh2lhNGSq0nGo3tH7rJ3c/1ljo
         +jJZVPKssIstrrxasU3wW4THM2TfooASqVGpX27xUyatX58NKN/XeeCk2oaIGJlXICgc
         TfjmbAkX84WlIOEM/B2AGstGyOSGJS/tMG+ZkeE0o8ql2b7YCXI0ex7J7D2HXycTveD4
         B7Q9aUoyVQxwyHEGLI+zdSchP9rGLUxM/+AQkLVzjTHgPRVptiu3m9e8AWHfipWdUtyp
         R488hE8lR8QTXkRwQv4pQGV+E5pRgXeLLQbdW6LaqqNYft3IMe/o8A9nI9bipslLsDPk
         U4Pw==
X-Gm-Message-State: APjAAAW6pn9o8i/Tf2tFzasgyKY2H0KMxdQA2soDpz0SnrbciARi5Mhp
        gdeymO3Tp78uNncrNShBOIqTHA==
X-Google-Smtp-Source: APXvYqzJ2zITJwefvutcoRh6sVEYAIPwYYVsDQr244ufW9DN7Lvvjstq84l3RetnZCmiVmyIAUyg/w==
X-Received: by 2002:a0c:8706:: with SMTP id 6mr10365045qvh.75.1556564609668;
        Mon, 29 Apr 2019 12:03:29 -0700 (PDT)
Received: from [192.168.1.119] (c-73-142-227-196.hsd1.ma.comcast.net. [73.142.227.196])
        by smtp.googlemail.com with ESMTPSA id t25sm1588138qtc.2.2019.04.29.12.03.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 12:03:29 -0700 (PDT)
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Cc:     Daniel Klein <danielk@mellanox.com>
From:   Hal Rosenstock <hal@dev.mellanox.co.il>
Subject: [PATCH rdma-core] MAINTAINERS: Update libibumad maintainer
Message-ID: <dfc72e53-b441-ccc5-ac0d-2fe1d461e207@dev.mellanox.co.il>
Date:   Mon, 29 Apr 2019 15:03:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


Signed-off-by: Hal Rosenstock <hal@mellanox.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e76c21b..d3b534b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -100,7 +100,8 @@ S:	Supported
 F:	iwpmd/
 
 LIBIBUMAD USERSPACE LIBRARY FOR SMP AND GMP MAD PROCESSING (/dev/infiniband/umadX)
-M:	Hal Rosenstock <hal@dev.mellanox.co.il>
+M:	Daniel Klein <danielk@mellanox.com>
+H:	Hal Rosenstock <hal@dev.mellanox.co.il>
 H:	Sasha Khapyorsky <sashak@voltaire.com>
 H:	Shahar Frank <shahar@voltaire.com>
 S:	Supported
-- 
2.8.4

