Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0633F565D
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Aug 2021 05:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234252AbhHXDCw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Aug 2021 23:02:52 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:45911 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234514AbhHXDBz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Aug 2021 23:01:55 -0400
Received: by mail-pf1-f171.google.com with SMTP id t42so14494796pfg.12;
        Mon, 23 Aug 2021 20:01:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=1DRHsv6N/K/YIyXINEkpLksZfI85v8MrvkBX6U2/RP4=;
        b=JwgmZqoOTGY5ywh21pYXI4lJc3a2YxGPfiW5RpXB0QtKRpBcxv4irpIGfqJXaPHQZ6
         7sGz17sd30kG7D72waeLz05d5EN8VIXFePYoLxsMphTQwGfVV+HUKGkHkPfMFP0OEf7y
         XfLAdjfwssysIrVOelghrIe848Q+vaR0oe5xkrgCOc+09W+YHq3KwHtQuoECMEelSmp4
         QVmQks9fPJ+f2DCDsEBWcrRSIAp7G4dQcw/shJzGlz+JfIOKQOUyp3+Uqc2lZ7DS3HIT
         XY250XkJjQt+vzTpsLznk36LWfBM6yVaY2tNYMvSv4CfdxRiSFzZ0lwtoj8Wwb7roW2x
         DmFg==
X-Gm-Message-State: AOAM533YTcltc0IdBlkCzikEoJ/6bjhozCk6nrAc4r9nIDIUoAUN/drQ
        mkprsrNu5xCbRpdIdSzBauIpNh243wY=
X-Google-Smtp-Source: ABdhPJyZrY71VpkdUdDodaxUJuPm+yix8Agd8eVI0C6Z2QMb4AGWq6d7m1MFBj/cstjZIv0gJZ8Kgg==
X-Received: by 2002:a63:7883:: with SMTP id t125mr34556613pgc.243.1629774065136;
        Mon, 23 Aug 2021 20:01:05 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:68:8a8:39ff:312? ([2601:647:4000:d7:68:8a8:39ff:312])
        by smtp.gmail.com with ESMTPSA id w14sm17538160pfn.91.2021.08.23.20.01.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 20:01:04 -0700 (PDT)
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
Subject: v5.14 RXE driver broken?
Message-ID: <c3d1a966-b9b0-d015-38ec-86270b5045fc@acm.org>
Date:   Mon, 23 Aug 2021 20:01:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Bob,

If I run the following test against Linus' master branch then that test
passes (commit d5ae8d7f85b7 ("Revert "media: dvb header files: move some
headers to staging"")):

# export use_siw=1 && modprobe brd && (cd blktests && ./check -q srp/002)
srp/002 (File I/O on top of multipath concurrently with logout and login (mq)) [passed]
    runtime    ...  48.849s

The following test fails:

# export use_siw= && modprobe brd && (cd blktests && ./check -q srp/002)
srp/002 (File I/O on top of multipath concurrently with logout and login (mq)) [failed]
    runtime  48.849s  ...  15.024s
    --- tests/srp/002.out       2018-09-08 19:43:42.291664821 -0700
    +++ /home/bart/software/blktests/results/nodev/srp/002.out.bad      2021-08-23 19:51:05.182958728 -0700
    @@ -1,2 +1 @@
     Configured SRP target driver
    -Passed

The only difference between these two tests is that test (1) use the siw
(soft-iWARP) driver while test (2) uses the rdma_rxe driver (soft-RoCE).
Both tests run reliably against previous Linux kernel versions, e.g.
v5.13. Can you take a look at this? The blktests software is available at
https://github.com/osandov/blktests/.

Thanks,

Bart.
