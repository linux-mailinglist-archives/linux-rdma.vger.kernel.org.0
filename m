Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E702D261D3C
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Sep 2020 21:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731528AbgIHTeR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Sep 2020 15:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731926AbgIHTeN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Sep 2020 15:34:13 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE859C061573
        for <linux-rdma@vger.kernel.org>; Tue,  8 Sep 2020 12:34:12 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id i17so17549749oig.10
        for <linux-rdma@vger.kernel.org>; Tue, 08 Sep 2020 12:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Fy5ymBjjWnfEAeyjKphSyewH/is6WKQ7xMzptSFI3WA=;
        b=FSeEJm3JNjA5bjWqkbG5tllrfEz0HXXEU+evZIASdgurVMDc88oftYxSdj4l4plNpd
         XKiuDjQrEubJvst5I0miVJU+MncllhmIhYYCgu0L/1NvM9rYEs+PUWi+Hcfoh3R4X0IF
         ffMvhAcJGUD6EKnNXD+G3uBZYuqnyGMyJAWRw5yg/X8LaDoEUo0FonCj1Z/6SaC/YzX6
         tvwnJHi7KfKoWVQHg2OhY3dewONv87EaoLBBiGhlwNumdIGN4Vus7Im6UVsh7iJHys3E
         MciGG/UrFGT/+h3CNEnbDvOjh7YtznZd/dRSgSx0UIACsNRzf8zRoQRuBDcKCJnW0yK+
         YWRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Fy5ymBjjWnfEAeyjKphSyewH/is6WKQ7xMzptSFI3WA=;
        b=C0susZsq6ku3DYXjc1ygJX48a8FI0ZKXNHALuOLJxlOdQaYOWYIiAl0UxgVh/6uQ0j
         CL/qMChsWnn7TrJvQVgoO65L5pQBr1zb0gllWkpZ1okU2OSmYmm2yaJu7p5ud6zP9nTh
         hbbdQstwu0RJ9ZWAiX7PKLTLZYGmuemF1d1cqi4ws2ohyII4/xNQUaMy64KiFiNgzIVQ
         XMH/6MGjXIDJ/O2u5ZLYHIMAMfmoP8iI3SOrccn8e7yjIawmWgirpOeJYBglySTgjYzR
         rjlRC7veNzdZ5jw8ZJQI2X3loKdYjiPPLC9heajs8Y5ZjREnipfv27SPdjjfumKdn2KJ
         e1jg==
X-Gm-Message-State: AOAM532WiTorKBOi4ccGjNv9Yv2eOLqxr8gg/ZhN0ZTl/82448YvjmoM
        8Jydu68ufRXlsktp8ODRavuSvpAa3x4=
X-Google-Smtp-Source: ABdhPJzpYv76dpeazGJl/epuw7cxf7aTHAs+UOcrnDxhdno9CBrH1I7EKf3tLP3ksinUo9m/SB7NrA==
X-Received: by 2002:a05:6808:3d6:: with SMTP id o22mr349378oie.150.1599593649986;
        Tue, 08 Sep 2020 12:34:09 -0700 (PDT)
Received: from ?IPv6:2605:6000:8b03:f000:9815:7696:31ff:cdb4? ([2605:6000:8b03:f000:9815:7696:31ff:cdb4])
        by smtp.gmail.com with ESMTPSA id z16sm26153oth.43.2020.09.08.12.34.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2020 12:34:09 -0700 (PDT)
To:     Jason Gunthorpe <jgg@nvidia.com>, linux-rdma@vger.kernel.org
From:   Bob Pearson <rpearsonhpe@gmail.com>
Subject: mcast bugs
Message-ID: <10c076fe-3a45-d42e-7e33-218ccc635b7e@gmail.com>
Date:   Tue, 8 Sep 2020 14:34:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Jason,

I have fixed the multicast bugs in the rxe driver. Aside from what we discussed last week there were some issues in the pools code. This work is done on top of the memory windows work which also changed the pools code. My preference is to wait until you accept the rest of the MW patches and then submit the extended API work (which is done) and then the multicast work but I don't know when or if all that will happen. The current status is that rxe no longer fails any of the pyverbs tests and only skips 31 of them (DMR, XRC, and a few others.)

Bob
