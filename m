Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A13774939C0
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jan 2022 12:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354267AbiASLmQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jan 2022 06:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354264AbiASLmQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Jan 2022 06:42:16 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22921C061574
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jan 2022 03:42:16 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id q9-20020a7bce89000000b00349e697f2fbso13962894wmj.0
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jan 2022 03:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=roLwsATNT7qOLhpiKYL2P1IiAkWe3qzHV3cJKV0RqI8=;
        b=WXu0c0eiPqFZujbwgrkimm5z4gqDZSJj60kaKJzskuNIm24dvCFndbcOP9mfBjyGz+
         20k4FHJyDAIdMynQydj1Axh+cMdjSpIbYID/vEPb182xNxaxqi5/+2+AzVKUvF0Nc1jT
         79FEP4wQaVDrP5q9fBKQwL2dIQk8GiOIASde9j9O/+POt9WorGG4XfDklL//5yQvLxoZ
         of14fY1d+VTeGt7ls9H+xRsMa1hCbrVJCLZmv7sEuc4rknvW80mdki7RAl3LfOYhrObn
         2VmB/R0QGBGYzZigX9VAV9NPfsQTu13X/10RYGiXowLnkKZkL8vsIgHCSm+P6bP2nKSq
         Qcww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=roLwsATNT7qOLhpiKYL2P1IiAkWe3qzHV3cJKV0RqI8=;
        b=NOVPAOtW/RzMZBAd9Qm4qPv3KxxehSIUIUlEPRwhmRGryWKaaLahsI0ZykXWR5YR9d
         +aBZ78q30KOfV09izoKc/EnOD+rAUt5W3fiMlSor1LAWgPmFWAzZqdBTDmR+1frkhYpu
         cHqvC+vw2+8VS5qMXveEcdBHSuQ0qBdFYCf9fi6+uyNSrLB2f2ibZl18ur2tt8eKhXw3
         EuoZ+RDqpAIYdv2/hHaXeiSBfDvIF/GKpNv11qCifiuEy/dWjkxCs2J80ImJc1vW1t4z
         5OEEX7LDqNiFRAIuwpobYW/zftvorts7ftiiPGInVJyl0YTWujKawYmGLSHC5r0T/hYs
         krvA==
X-Gm-Message-State: AOAM532H6GQKASkV2KwL84Tc8pX8qKLD/qmGJ0mKk9rZtr9wn5VL7zZ7
        UF0L7Jf+WiiBHezPa1vcOw/w60716lTRLMIv6g7/RZzJVtw=
X-Google-Smtp-Source: ABdhPJxPf0NoE5v2JHCI2u+Xah1FDlbPTE1JlhHa23KtPrXcFEmVVy1X8ziKgaL8XxzcqsBPPYJ+3a2uycBZjSsFEJY=
X-Received: by 2002:a1c:f70d:: with SMTP id v13mr3098550wmh.133.1642592534419;
 Wed, 19 Jan 2022 03:42:14 -0800 (PST)
MIME-Version: 1.0
From:   Alexander Kalentyev <comrad.karlovich@gmail.com>
Date:   Wed, 19 Jan 2022 12:42:03 +0100
Message-ID: <CABrV9Yt0HYenR_qk_QWFkvH4-0Ooeb61y+CyT3WVOnDiAmxjhA@mail.gmail.com>
Subject: rdma_rxe usage problem
To:     linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

I am trying to install and use soft RoCE for development purposes
(right now on a localhost).
I installed rdma-core on a MANJARO system from AUR.
Then I did:

sudo modprobe rdma_rxe
sudo rdma link add rxe0 type rxe netdev wlp60s0

then ibstat shows:
CA 'rxe0'
        CA type:
        Number of ports: 1
        Firmware version:
        Hardware version:
        Node GUID: 0x4a51c5fffef6e159
        System image GUID: 0x4a51c5fffef6e159
        Port 1:
                State: Active
                Physical state: LinkUp
                Rate: 2.5
                Base lid: 0
                LMC: 0
                SM lid: 0
                Capability mask: 0x00010000
                Port GUID: 0x4a51c5fffef6e159
                Link layer: Ethernet

But launching any example I always get an error by call of: ibv_modify_qp
with an attempt to modify QP state to RTR (for example by launching
.ibv_rc_pingpong)
The type of the error is EINVAL.
I believe I miss something very obvious.
