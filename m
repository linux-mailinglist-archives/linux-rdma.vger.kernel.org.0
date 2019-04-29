Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D53F4EA98
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Apr 2019 21:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbfD2TDA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Apr 2019 15:03:00 -0400
Received: from mail-qt1-f173.google.com ([209.85.160.173]:38327 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbfD2TDA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 Apr 2019 15:03:00 -0400
Received: by mail-qt1-f173.google.com with SMTP id d13so13244896qth.5
        for <linux-rdma@vger.kernel.org>; Mon, 29 Apr 2019 12:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dev-mellanox-co-il.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=xjw9naTtLbn8+C8hM1HR6sin0BDpsU9th1ktWDeUp6M=;
        b=HqpIrbvh7jhRT3psnCvpVdKhLQRBT28t7aPYdEqy4fTfCloWArrju+lCDFPOGG2OkB
         5iBwO6+ROASZrspICKNSMcEj3TMK+n1d+O3DWmY+Zuix4dWj0oTCrJ6A54P0Z+HnbAtj
         336/KaVnF19LPZdj6/tnJs1+fbnFFk7gnR+rn5teiOM4cVhc/1qUosU/J3aCoAes60WS
         ceIJzpCNON6wq25QduHrcbooWcelC8RKGrzPUg0MyFeb9oQ2f8r0qECPqxqWbXsbgUhf
         B9nfQktOBmAQkgTNh2K1m1ua8YpAVDGks0E/rqcsxagZE5PtNV30CJafMoSuH627PROV
         Kl6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=xjw9naTtLbn8+C8hM1HR6sin0BDpsU9th1ktWDeUp6M=;
        b=Sj2q7rPviZ8WDb4mNKY5NvxHWDcY7y3KM+oSj1klwg60IaWIzJWX0v6k2XQlALTtTy
         Ew4mVkS0wpy6+NpEg41Oy0P/aRL+DUHWgxgrUxmAftRvTgqz5cBs437OQKZ9nOQ1+pl1
         yOYqy9KZD6qIc4/zrOnhLpxeKo+vYA8k5UPq2RuSO2M0HeDkZCxpiV3+kxBFScqVrYNd
         sD/xNr4HlA+vc6RuP2KnFnDPAn/GAiZB48KpTqS/y51Nth1tFYwrk0jc2Hzre2pPgLqg
         ppfFqK2zDf4oonAFPIkhh74kMsHLYBGpERsy28E/kj9c09y2A4rXQsfjqzDFMRcEJRCu
         cj9Q==
X-Gm-Message-State: APjAAAXRuxKJ1mRdTAogd/q7UxFCNg/4abnFoC7Wtl3VuVx+Q1LIAhFy
        7nT4e3YU596t0nbns6+FRLAGiA==
X-Google-Smtp-Source: APXvYqzFBGIkpiUm1T77VXoOIvEK2e+/WJBPYNWrpAY5egitZVbb9nacJDou/Wj8P+orPkYTPkfmIw==
X-Received: by 2002:a0c:c951:: with SMTP id v17mr14428565qvj.65.1556564579453;
        Mon, 29 Apr 2019 12:02:59 -0700 (PDT)
Received: from [192.168.1.119] (c-73-142-227-196.hsd1.ma.comcast.net. [73.142.227.196])
        by smtp.googlemail.com with ESMTPSA id x29sm4670912qta.75.2019.04.29.12.02.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 12:02:58 -0700 (PDT)
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Cc:     "Tamir Ronen <tamirr@mellanox.com>;Daniel Klein" 
        <danielk@mellanox.com>
From:   Hal Rosenstock <hal@dev.mellanox.co.il>
Subject: Upstream IB management maintenance handover
Message-ID: <f3a119db-0ba9-a1a7-1ad9-b677cc1a5e23@dev.mellanox.co.il>
Date:   Mon, 29 Apr 2019 15:02:57 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

My second stint as upstream IB management maintainer (for OpenSM, ibsim,
and libibumad) is now coming to an end. It’s been my pleasure to have
worked with the linux-rdma community since the inception of OpenIB.

Please welcome Tamir Ronen <tamirr@mellanox.com> and Daniel Klein
<danielk@mellanox.com> as the new maintainers for these components. They
have both been involved with IB management internally at Mellanox for
quite some time now so they are uniquely qualified to step into the
maintainership role. Tamir will be taking over OpenSM and ibsim. Daniel
will be taking over libibumad (in rdma-core). Please join me in wishing
them success in their new roles.

-- Hal
