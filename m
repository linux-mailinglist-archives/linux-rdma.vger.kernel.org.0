Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB07040C28E
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Sep 2021 11:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237094AbhIOJOK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Sep 2021 05:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237404AbhIOJOC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Sep 2021 05:14:02 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05492C061766;
        Wed, 15 Sep 2021 02:12:44 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id r2so2044174pgl.10;
        Wed, 15 Sep 2021 02:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=6f6pDvm1KB1BUD+UI80GJZw/FNQsGRi1bsEqgFCm1SA=;
        b=hwNLoJUW1SUbnq/yZHao0sjUZE+wXWmWOViRlZnW+hMrbBnucncgcekehk2vPARNUu
         NiigLrgjZGQQC0VwTHexgjPyKx3V5fqy8ZruVQnbMJwvQEP6fv9e+4gAZBLnH4f4UbrP
         1Wr7VLZdz0tUsfMeD8yxKZOXfS0Bpwa3fKTtSS3Q5GEOSmsF09RIgoaO2FVV1PH/HUjB
         aRdWGoiw7ITTidyTPW9xcNrYpTkHNLTGeJ89ScvLORVglr0LNdZI9mlIwdUojhYeOgeT
         XoAxC4vV7C8J+YhkXXS4+PP1MMN6WwuuJJzyfEDcQSv6sDDaaq7LFwcVN497+38MRecA
         TTng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=6f6pDvm1KB1BUD+UI80GJZw/FNQsGRi1bsEqgFCm1SA=;
        b=KNef8vavpdT2COOvGRNCtA3+R8rnUYSzbDEm222M4aeaGrunGJUiYaS+kiHyU3zQuY
         JKpV7lvpfJeyWSJgp15JnX/LmLjMqWAno7adazuey8UVSR8gm38j5FTxXJpsLhbxJGvc
         maRwVFr2XzrJcJI26TkeqRr9fUVM/xJJZ3RZ/Tgrp1gwwnmL2wyf12ExTp/I7poKkiF1
         Doj2KOsGPDyn/R5XAZmwnx49fRLXehjzQKio2pK3PCbEgCJywX/Wetnu031Rmvp0mxiH
         uNAot3v0ZUtwBt0X1EUJ0Jt4ygsh7138oJAnvCqlICCZoWfkp/UGwEvlGVw2orY6lS8Q
         SERA==
X-Gm-Message-State: AOAM5330lznjDDtvv+6YUMQxdqofhFvm447fLCq/Ag7tyq9lD8wteLX/
        YpljcAQ4u7St5wyuiEgCU72Vvp4fZuo=
X-Google-Smtp-Source: ABdhPJxHdj75JxKB720E6P1osyeykhY+XTLKNbbtP4v+0Esti9LpljtFzOHFsex4JMJvfghcfC8DiA==
X-Received: by 2002:a63:1717:: with SMTP id x23mr19536519pgl.182.1631697163202;
        Wed, 15 Sep 2021 02:12:43 -0700 (PDT)
Received: from [10.114.0.6] ([45.145.248.139])
        by smtp.gmail.com with ESMTPSA id i1sm1520945pja.26.2021.09.15.02.12.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 02:12:42 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] infiniband: hw: hfi1: possible ABBA deadlock in pio_wait() and
 sc_disable()
To:     mike.marciniszyn@cornelisnetworks.com,
        dennis.dalessandro@cornelisnetworks.com, dledford@redhat.com,
        jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <857df2fa-7d60-bff3-70f2-642201888977@gmail.com>
Date:   Wed, 15 Sep 2021 17:12:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

My static analysis tool reports a possible ABBA deadlock in the hfi1 
driver in Linux 5.10:

sc_disable()
   write_seqlock(&sc->waitlock); --> Line 956 (Lock A)
   hfi1_qp_wakeup()
     spin_lock_irqsave(&qp->s_lock, flags); --> Line 441 (Lock B)

pio_wait()
   spin_lock_irqsave(&qp->s_lock, flags); --> Line 939 (Lock B)
   write_seqlock(&sc->waitlock); --> Line 941 (Lock A)

When sc_disable() and pio_wait() are concurrently executed, the deadlock 
can occur.

I am not quite sure whether this possible deadlock is real and how to 
fix it if it is real.
Any feedback would be appreciated, thanks :)

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>


Best wishes,
Jia-Ju Bai
