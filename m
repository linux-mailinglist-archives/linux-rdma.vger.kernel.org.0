Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6D93E1717
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Aug 2021 16:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239457AbhHEOjL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Aug 2021 10:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237990AbhHEOjK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Aug 2021 10:39:10 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91003C061765
        for <linux-rdma@vger.kernel.org>; Thu,  5 Aug 2021 07:38:55 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id u3so10019908ejz.1
        for <linux-rdma@vger.kernel.org>; Thu, 05 Aug 2021 07:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:from:date:message-id:subject:to;
        bh=bUaEIz+0et2GLZACFLqMpbto4Y4+tyoI8JnXvvr1kuc=;
        b=nqHCL+yY494Cx0Usym26ElFNrjrw7UNLJsVZi2kFBQOchloh9zBUMiQ9SHLEFxckDw
         C68JcuoIueb63KOJ3p1Cp+a0XVNMb7qmrVkjJy0JpJMYZh/nUfHgmxyjFJhflKs/I/gh
         0K9lIhX9K9ugW8rKVfVcvoK3tXMr/SI+ZONc/7YeDfZKzhe3E94+4uuIzkh/X0xJBr0o
         VzWIpFp3Tf0Wisss723stsE3jnhFHhM9z1xyGbDOV7gwL52tFgsypOrB2rhPujK5rFRm
         tlSw8/UMERgBeF4I+7KeKcDvvUT9CiIgRV66p3FRTHSVGmJOmMB5EHDfe0dTIRyRBKaI
         u9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=bUaEIz+0et2GLZACFLqMpbto4Y4+tyoI8JnXvvr1kuc=;
        b=cYpDcr5+67LPXSmsL3kb7GdXEguhBNZTQrMYV0iQhlTPqclD0ux3U2eRKSEn2IwXz/
         yZUdDcxexxjR//9npUKyvzFzpF8yh8dOAoOBTI/pvulMW2Q9Ax4nNrtK0558rhrQRxef
         0vpOLTMOyfU/0wA3zyKCIqiFfKlNlvBsHAi3i6SD/iBNjgpDXd1o/jf63iJgXDFjt4IM
         xWnxeT38ErqkVOQFwn5uzFVsEnrwM1V2V5VR1G8PlVpo6DBN9LVxqNJORCAO7pJswjgU
         gknDhF8hOiN61jUq7wcDuDP1kzmA89gkmxnYZDk5KBUxSNIJZN1FN5Js0Cx68F+pxcQF
         7X2g==
X-Gm-Message-State: AOAM533Sh4QX13THCV6+Pr5vnzCPDLYXG5cCZEfxIORGtEsne/26MV2R
        bTLriYfDwwdCFbU61IjXuc8gPh8F92gc97o9g5w2euqS
X-Google-Smtp-Source: ABdhPJzkmLbaTPVyTA1mT5Dd/iZAXnR2l4H6eX0QySMw9FeNJS2H8mFSL4HW8zLOzXTryMKKcFB9stgveW9yam5Orow=
X-Received: by 2002:a17:906:4e52:: with SMTP id g18mr5339566ejw.432.1628174333681;
 Thu, 05 Aug 2021 07:38:53 -0700 (PDT)
MIME-Version: 1.0
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Thu, 5 Aug 2021 10:38:42 -0400
Message-ID: <CAN-5tyGiuTXBy2pcSd6PT3_Bdxx6H8QWzXaurSooMz7uhU2rrw@mail.gmail.com>
Subject: Help understand use of MAC address resolution in RDMA
To:     linux-rdma <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi folks,

Can somebody help me understand how RoCE (this is probably RDMA core
and not specific to RoCE but I'm not sure) manages destination MAC
addresses for its connection?

Specifically the problem being observed is a server initiates an RDMA
CM disconnect (client replies), client tries to reconnect. Server
sends an ARP advertising a different MAC for the IP that the RDMA
connection was using. RDMA code keeps sending the RDMA CM connect
message to the old MAC for a certains period of time (90-100sec) then
it finally sends it to the new MAC address.

Question: how does the core RDMA layer manage the MAC address for the
connection. Why does it seem like it ignores the ARP updates?

Thank you.
