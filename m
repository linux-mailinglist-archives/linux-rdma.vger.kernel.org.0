Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7A344931F3
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jan 2022 01:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350435AbiASAlm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jan 2022 19:41:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237177AbiASAll (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Jan 2022 19:41:41 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921F8C061574
        for <linux-rdma@vger.kernel.org>; Tue, 18 Jan 2022 16:41:41 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id g14so2138484ybs.8
        for <linux-rdma@vger.kernel.org>; Tue, 18 Jan 2022 16:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=l+cjeI7+67eCpCqD940XrrstGEkV020f2b8ppSSGa3k=;
        b=m7Q+yi8VaLwroslx9MqPjs7l/M917HTccxYNvzTNJzuf4EVioSPruaxfL6NmfBnL1s
         YtNGMaoESwfcs5+8Jnnr0nmRitMSA1WJYLGNuOuaVmuxllDmjuzNt4SThJ6nfIizKlhR
         t4S8JLo2DhqhGNjowYmp7y5YZr84IbaM7KZAGQXxnkVUUUQRlP0tAs16ZqjBuLC9R8gS
         YDYYI5D0Xr02/Ocfa4sJwNY1cQ5AtZF0c9VONB0iKT1wJYzRM5fIETERnodf77yZnEtY
         l/59fKlDTr/aiUjW5Aq2BDaiLYWrX/SS6QJXxJmV5n3/S2WhuEDc2iyrH2vbAL/cjx7b
         dYGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=l+cjeI7+67eCpCqD940XrrstGEkV020f2b8ppSSGa3k=;
        b=XRG+KPAKHVOParCUbbCb2rW2V7CNvrh7kAlHggPgtD1gZbEmeV5I+rTOLDvjGFN7aQ
         n/elEsLiaXkwrZzlpn3G7OvokEPj46cvqU2klVwv5O40y+jzp6TIJkGPQ/RyxScUXB1k
         B0zkzsSX6EsubR0OzUyrQxiHP6Pj34bMfE7VhVMzzDWLi20RA/ai719f2I30RybQwJzF
         v7lh9nLl28EZuXdqetrl0w9/xxXMfcYwcwVHtfIGaRu/jRAx5ykgsH5wXCoJofMRlNab
         DW9n+YhEJmnC+JPJ4sNB+EUh+OYL1SBrAtOPLfgZe2QMF4eZdkL1Ws/JRC3vPfHUmY1h
         T3vg==
X-Gm-Message-State: AOAM530Zk5D/kt7GC2elQtkcK0lKriZoRRHcaz4ytdRdK0cNQsc39kxU
        G2PAFdTyWJJGvWKJ7A30oytYAjWsiE5CVbS8w8rn9dnkHws=
X-Google-Smtp-Source: ABdhPJxrnVCt9/VeTp8f/CHMk0rHnI5EDBlWwrxC58Tt073Kw50ppPK3R5WP+pHJYO5nDbUZynfaLyubr1TLnc2aAfE=
X-Received: by 2002:a25:51c2:: with SMTP id f185mr29246107ybb.677.1642552900695;
 Tue, 18 Jan 2022 16:41:40 -0800 (PST)
MIME-Version: 1.0
From:   Christian Blume <chr.blume@gmail.com>
Date:   Wed, 19 Jan 2022 13:41:30 +1300
Message-ID: <CAGP7Hd4atpB0J-PP-AC6peiUaD=Y75Fdue9Ab7AS8nkQPwdXvQ@mail.gmail.com>
Subject: SoftRoCE and OpenSM
To:     linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello!

Is it at all possible for a SoftRoCE node to talk to OpenSM? Can I set
up OpenSM in such a way that it automatically discovers all SoftRoCE
nodes on my subnet? Thanks for your help.

Cheers,
Christian
