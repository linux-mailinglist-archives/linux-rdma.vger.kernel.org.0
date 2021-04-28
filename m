Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE1F436DEB0
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Apr 2021 19:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243366AbhD1R4G (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Apr 2021 13:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243349AbhD1R4G (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 28 Apr 2021 13:56:06 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E1BC061574
        for <linux-rdma@vger.kernel.org>; Wed, 28 Apr 2021 10:55:20 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id lr7so15067900pjb.2
        for <linux-rdma@vger.kernel.org>; Wed, 28 Apr 2021 10:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=IXE4lrUTtC/fcZSSikTjmsNLf1BSdReBXiBTFFNlgtw=;
        b=lhvZrTRvPyx2bOUt4V1ow9GWRxQcqk8xh20XiFVxNWtvB9an/gWEUZXRC8xgLdb5Uy
         1UuLHJ9tS+Hn9quaAU7z2ojpuK1z3xtrAJy+/R9IeU7EOyTeGsrOr8yKq/r+UN1Yyt3y
         0cjmvuqNCM/O0iQIC/Bb+1MF1cFpT4J6+bIk46Cja/uu3Ny4Lpu6aZGIU2uZ0zfnBm5o
         BIAhY56r0lIoDuM1/YRAJDSpfJ+ACK96zZye4cBkewAMKcl99HVhuohcVV8ni505xOc4
         qM0n6KyQ8hq/5794a9jVABDPoHECt473366dojQklrELjejdGlHTozeAZjib5Yy2aLj+
         iDkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=IXE4lrUTtC/fcZSSikTjmsNLf1BSdReBXiBTFFNlgtw=;
        b=oq7EvjIIaXTmhJENu1G2G7lFiHN6kIO8zGvB/lHY2d5eT2qyDIFrQoWJKSYpJ3omLz
         JoReX6iR5CfNbxed57jvSlQmLHDWsXiB0BIil2KJNW3GSSLAFUfvwK1wAs0SKzfFS2qG
         WfRoFDHczBi3cEAtd6oGeBm/QJ812lt7bNDW1oVLK2rfG500ilh4K1X3/jdHUABJcPAN
         u+WgZ2ohdPqb0SxV6pH5zsGhA7T5mpSe5WQUlDfl5xt9yymmyo2+22vLf385jOzxlgvE
         m5DOuIoKFTl/7w8PCOcr6ClyX+XPiibOh38v0Z/qXI0TrDPcyi2jTIFQLhCh/5ES6phx
         znWA==
X-Gm-Message-State: AOAM530z2fwCzvDRKLGVSavuuhClYXYLzpeC0ClCodXioDaVS7hoYozz
        NFlBKhzcRrpunrMwze2VXokv3hZbcN8XBb9vns8=
X-Google-Smtp-Source: ABdhPJwn7OCgR8VAlURIbAb6MoerM9wnhdBaUs2t+InWP/fv4oBqne1g+pcI3mvnhrjrelMH8o3J4GVsh9n7tIyWbW0=
X-Received: by 2002:a17:90a:6f45:: with SMTP id d63mr5194600pjk.39.1619632520069;
 Wed, 28 Apr 2021 10:55:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a20:7f9a:b029:1d:2140:cffe with HTTP; Wed, 28 Apr 2021
 10:55:19 -0700 (PDT)
Reply-To: k238336@gmail.com
From:   Joseph Kallu <davidottih0@gmail.com>
Date:   Wed, 28 Apr 2021 10:55:19 -0700
Message-ID: <CAHvD5oaTDV6AZiODfbjiA8tffi8RKb5cnj2p0A3hnJLX25Pt6A@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

0KXQtdGYLCDRgdGA0LXRm9Cw0L0g0LTQsNC9LCDQv9C+0YHQu9Cw0L4g0YHQsNC8INGC0Lgg0LUt
0LzQsNC40Lsg0ZjRg9GH0LUsINCw0LvQuA0K0J3QtdC80LAg0L7QtNCz0L7QstC+0YDQsCwg0L7Q
tNCz0L7QstC+0YDQuNGC0LUg0L7QtNC80LDRhQ0K
