Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2F9F2493A9
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Aug 2020 05:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgHSDuN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Aug 2020 23:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgHSDuL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Aug 2020 23:50:11 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D326DC061389
        for <linux-rdma@vger.kernel.org>; Tue, 18 Aug 2020 20:50:11 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id v21so18000771otj.9
        for <linux-rdma@vger.kernel.org>; Tue, 18 Aug 2020 20:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7cQzZmEnYp/LaQ/0LzrVHEXPUWDQVh9yMk28vMVDTLI=;
        b=at0nYyt6RB2czMn23PUYyaWq5zwiQAqR8gci4LdafuZeM4jL1RpZm4M/DMe4m+8NF6
         vXLy+k0B4Lz5d4NRrt3TOqVidBWmGTwp7tY3Evl7/B6nKuCaUL3gzROfqDpO657O9Gd0
         HAjxpzEzT/xJCdz7K//XTWOQZFBKdH15lDv0l/Zm9ht4bEAkV865SkiirBRtiVYER7UQ
         bnzGqtdmp58DMjnvG/RWZu2Wh0Z8lMU7OFn8/br03F3UrNFNO4dASzlJ/rxZJeOxO7jA
         aZl/ndgeuKjSdHOoZw3aOvkCKmirzTFFb/SiZhaIfRH6Wd4C3GdBI3wf+kbGXhu9ZFE0
         xYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7cQzZmEnYp/LaQ/0LzrVHEXPUWDQVh9yMk28vMVDTLI=;
        b=ffksNTyTy/ZRGIjH0aL3JuYrWHvIWNC91iF0FNO/XEIolEHMr1vuT7mg07V3eDxFJN
         QBDsLO3E6RksCokEl+bLWe9aEsmWv/3z7lnIaQ4NpcuLkuvIFNbqBt5iiv1IjxfXZLKc
         tp7GPx4AeHYwjn8UeO6KNU4y4h18B1kdLVtwBRWaYebVvdLHx7oriYmn0IRPaUbjGVQO
         FHQNHFfNGNjFwAMayMqLOI07A2j/Y6gSWglTA0MskQHI05H1hB8mkkib/gVCsw0v0M9V
         brKGCt05dByMFKyMiuWYvSlKthR5MfWIgb5JoP1TkHYgjRckxHutfwWoE4Jwwwr+FVVQ
         LoCw==
X-Gm-Message-State: AOAM530UAIoQe6lCttD241IDw30oH0QtZ30MNLMgJk2yvKBbZ8eJhedx
        qbET+Q3sDlf+Bq8vmwGM3I0=
X-Google-Smtp-Source: ABdhPJzXWgEyyQc7EoGhSURDJQ3DMiCiAiDOpfCWFa02mOBYVLJfjhEaBskQqU4DH9fBHTcwb2DQqw==
X-Received: by 2002:a9d:621:: with SMTP id 30mr17366531otn.261.1597809011302;
        Tue, 18 Aug 2020 20:50:11 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:2731:80e6:14c6:1150])
        by smtp.gmail.com with ESMTPSA id z6sm4547415oot.18.2020.08.18.20.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 20:50:10 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: User library support for memory windows on rxe
Date:   Tue, 18 Aug 2020 22:49:51 -0500
Message-Id: <20200819034952.9036-1-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch extends providers/rxe to support memory windows
operations implemented by the matching kernel patch set.

