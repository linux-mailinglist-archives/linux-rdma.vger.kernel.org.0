Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC351485129
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jan 2022 11:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiAEKcn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jan 2022 05:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiAEKcn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jan 2022 05:32:43 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB23BC061761
        for <linux-rdma@vger.kernel.org>; Wed,  5 Jan 2022 02:32:42 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id f134-20020a1c1f8c000000b00345c05bc12dso3036900wmf.3
        for <linux-rdma@vger.kernel.org>; Wed, 05 Jan 2022 02:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=message-id:subject:from:to:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=w0PCN6C3YtqqSVo1nD6yRLm700h0G687MZ83WdjSiKw=;
        b=W5m9fDRADWEsEQRYi2khLS/9BF1efhv/ERlJr8lXovyWJIveW1pSuprujQtlMcyRfp
         /UR59YYHhX0Qn4sW5umQBPmo+eLIGckQLgwHzzVvaTAEEztiA1HrGZvVP6kaULc9sSsl
         hm0CNmfNfx9a0BwZQb0gxvJuKXC3f0rZUKkujtnIhjgzKcUgO8vA9XMl7pLLIYkwDK6s
         9Oglo9fMB+4B2W6xjzXWsaa3DGM6n4JH1Td3zZX8GDqzKoHDaebdn15mxIuSJtwDEtXT
         ktEFcaYsxr+p54q4UXuEXXKs8h+2Fq/vRdvpodC5joAJ3A74sSVo+PxaC+zcqtC4QBuj
         Aoeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=w0PCN6C3YtqqSVo1nD6yRLm700h0G687MZ83WdjSiKw=;
        b=2V+DnI9/UvsLNGcSH+SfUUtMvSGisQLk5dDPpTtPgUUArzHIuRF619QpPZLKLKOJhz
         eWFHsNJ0UVTfcBMw26OFFGMPuUpSjQ5PisR1jaQiWAitc1DL00PGk4jzD8aLCbRtJqq8
         FW92oklOoQoxbmbbv8QIUwYMPn4uZj3ykkN8S6588ASdjQKfBYAKcdbkAGZA0y967WGO
         1lSrzbChfKYm0/yAjvMiHVqARCDmcVUBJI/4iQY92fuq3ulLZYKW3dmDb0vZs2y+28LL
         WU+HHMxGRYp5m4ehJGIX1JeGFCwsHTg7yhN2w8aBUbC3hXggbRxCk//YWW0N1lgSE8WW
         vd1g==
X-Gm-Message-State: AOAM531h/93LzAgfxMO2aBwJQs8UNY7EzgfbX8NGzzS+t05LEMpM3pho
        PRKervGNbL3liZzGnb/0tASznpHvaoNgfw==
X-Google-Smtp-Source: ABdhPJw3gwbigzkJ8xxhTmMfHIWoEepg2kn/lZaSJ1bFpepFrO6DgYV0r7KjatDbbGfY+0XTsnznNA==
X-Received: by 2002:a1c:ed01:: with SMTP id l1mr2250028wmh.185.1641378761475;
        Wed, 05 Jan 2022 02:32:41 -0800 (PST)
Received: from fiftytwodotfive.fritz.box (p200300e03f0d6c0075f7d8ec3244ded0.dip0.t-ipconnect.de. [2003:e0:3f0d:6c00:75f7:d8ec:3244:ded0])
        by smtp.gmail.com with ESMTPSA id p1sm43354731wrr.75.2022.01.05.02.32.40
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 02:32:41 -0800 (PST)
Message-ID: <44396b05adcf8a414a9f4d6a843fce16670a83c1.camel@ionos.com>
Subject: iblinkinfo for Python
From:   Benjamin Drung <benjamin.drung@ionos.com>
To:     linux-rdma@vger.kernel.org
Date:   Wed, 05 Jan 2022 11:32:40 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

we have an in-house Shell script that uses iblinkinfo to check if the
InfiniBand cabling is correct. This information can be derived from the
node names that can be seen for the HCA port. I want to improve that
check and rewrite it in Python, but I failed to find an easy and robust
way to retrieve the node names for a HCA port:

1) Call "iblinkinfo --line" and parse the output. Parsing the output
could probably be done with a complex regular expression. This solution
is too ugly IMO.

2) Extend iblinkinfo to provide a JSON output. Then let the Python
script call "iblinkinfo --json" and simply use json.load for parsing.
This solution requires some C coding and probably a good json library
should be used to avoid generating bogus JSON.

3) Use https://github.com/jgunthorpe/python-rdma but this library has
not been touched for five years and needs porting to Python 3. So that
is probably a lot of work as well.

4) Use pyverbs provided by rdma-core, but I found neither a single API
call to query similar data to iblinkinfo, nor an example for that use
case.

What should I do?

-- 
Benjamin Drung

Senior DevOps Engineer and Debian & Ubuntu Developer
Compute Platform Operations Cloud

IONOS SE | Revaler Str. 30 | 10245 Berlin | Deutschland
E-Mail: benjamin.drung@ionos.com | Web: www.ionos.de

Hauptsitz Montabaur, Amtsgericht Montabaur, HRB 24498

Vorstand: Hüseyin Dogan, Dr. Martin Endreß, Claudia Frese, Henning
Kettler, Arthur Mai, Britta Schmidt, Achim Weiß
Aufsichtsratsvorsitzender: Markus Kadelke


Member of United Internet

