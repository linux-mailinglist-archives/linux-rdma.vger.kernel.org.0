Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B16024531D
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Aug 2020 23:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbgHOV6l (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 15 Aug 2020 17:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728943AbgHOVv4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 15 Aug 2020 17:51:56 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3499AC0612FE
        for <linux-rdma@vger.kernel.org>; Fri, 14 Aug 2020 21:59:27 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id v13so9996058oiv.13
        for <linux-rdma@vger.kernel.org>; Fri, 14 Aug 2020 21:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O6Gjc9fV1Keca/ifT/kNk0bTHBksQ0tOGrDRzJm+T/Q=;
        b=t7m7nMOH+YAUlMcliu0/EAI953d5IgL4VwLsWTnLUp5/DBJG4DL9rg1zAbTkZ/FjEB
         P02wY0GC3L3UaQi2hT2nHlmDczL50X8LnhBDhjjeD1RYcw7U5d4i79kNn3uxuhF9kN6b
         rPT6qAqED/Bm6PfxWSAetirs1sUDVchXQop5N5oU1GEN4CqNHQC0tZ4rK6g7X6saJvX3
         DR4c1yNa12gGt//+u1azyfWGmelPp4Ljm6jZttblWBSHGCCEJMBQlBjAoOV0Euwk1nUh
         x1/V3kg10Q/mIrSKXP5Q83wALQm9cys+pTc5jDmRyalzFRk2DHXo1t4NrpOR3FCd1mdf
         2uXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O6Gjc9fV1Keca/ifT/kNk0bTHBksQ0tOGrDRzJm+T/Q=;
        b=IuzkGJP6+yPtaxt2TdUTXwYB1DKSnbRwnQIjY8LkEzXL7lZMctvnXnexD3OGxAxmbR
         59ptfH+fdjmT+2Ao2Q0QBJwdXiBF0DyFqqUTXl9LENGeVbhCWT/fvjK+34xzqD2nY4Ci
         jLEj1wgepMgrmjyEasFVVqJoFPd8GTfijHn/+G13+lGueVqZ0Wp4csmdyW0V1l4uVzZX
         XnC7TUGTUVAdhorqdMipsbQgYFic8sfzZoQInpvKavk+0kWKrHNaPUk5+t3DMSE0M1r3
         OG5gRq5M9S2z14CHAGUofB2fK7ni8qzaZgKxkfk610EHLac1AUn3oJfCmr1Zr9nj0p15
         FF0Q==
X-Gm-Message-State: AOAM532tFUYefOxDyhJ3xbHeRYUnuQbRQKracY8i27x7n2iWQyR4sszS
        v4AtzOYSIftTKHlC1/imoIiMYzEIZnTF4g==
X-Google-Smtp-Source: ABdhPJxl17DwgvrDF0UN/q1T/7ozXzwVe8JPbjSlMPIQNJO9oVtleJwzTwOceSovav2sn+C3u95V0A==
X-Received: by 2002:aca:cc50:: with SMTP id c77mr3369818oig.152.1597467566559;
        Fri, 14 Aug 2020 21:59:26 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:b453:c5f2:2895:a54c])
        by smtp.gmail.com with ESMTPSA id j10sm2206408oiw.29.2020.08.14.21.59.25
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 21:59:26 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     linux-rdma@vger.kernel.org
Subject: Memory windows support for rxe
Date:   Fri, 14 Aug 2020 23:58:24 -0500
Message-Id: <20200815045912.8626-1-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


Bob

