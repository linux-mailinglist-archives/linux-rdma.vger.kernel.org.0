Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C7541D334
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Sep 2021 08:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348288AbhI3GWS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Sep 2021 02:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348256AbhI3GWM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Sep 2021 02:22:12 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C35FC06161C
        for <linux-rdma@vger.kernel.org>; Wed, 29 Sep 2021 23:20:30 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id e66-20020a9d2ac8000000b0054da8bdf2aeso3758892otb.12
        for <linux-rdma@vger.kernel.org>; Wed, 29 Sep 2021 23:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=HiybMtL3oTOqhfbzpPHAJ82Ac6PGi35Tix6YKtj/MUY=;
        b=WnAs56WTHuame0wISzaU1D/eX+SGWlP7Wu3CcXRT8U/GA+4+dJsAhPvIUpWlUbmiaa
         Ka2IEb9O73r4piCt3uIbjVrzgZ3ZqBUFwTME0twyG3c/DAXz8SMaFRIBFNeMbyhHYACd
         JgwFyW8o4Lz3jabhEMLRfcYvkJa/ZsEotAS/f/VS41cm3So6figvx1bZdZHhRbw1g3el
         7Xcce7AmZlP8QEeOTg+QFHr4dekxE/H5fzFiXUsmBtS6YFs6HVJL0Q9FbVpkNXz0qNLu
         ZuDK57bK2dXOtyEZyiheD+y+PlkB2BsGjuh/nJtgnuKuerKK38ZBod/Rvur1I8wc99wW
         EAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HiybMtL3oTOqhfbzpPHAJ82Ac6PGi35Tix6YKtj/MUY=;
        b=gDHXJ0XKCa3Ht7UniGVdHf3yPaKSISg2JLKy7RGtRyeT+U5+YxpaEBYb6uSXA90FKq
         1Q80JsnnRMJTEsmMAmX30DfFmVT6IJdWYkJDU6kC7qjMdQVVL46P5HdJO3WGPLN1amHt
         DtveY1HGoMrnhUfPYq7RGtwgVR5M/qmXNqNJ+TOa6ofnl/uewBy9zSi7KskErpRHGCZL
         i8e/E7K1Pi5xlmN8cj/EFckrQbK9vD2TR3SgPvYN55twtW34EKtdaDleIcWAzhNoR5NA
         ZEqK3Y/Cjzx6jTekjUg/m4XeuNg+p822nF9t4T3WZ3CvjcgmRLZzlBwFAoXJmm6HULvO
         7KVw==
X-Gm-Message-State: AOAM531IYpKqwktBxUdNn9fcOrxJ2vupTXuVZsu0O9Av3o5sytGOLrIE
        2l9K0CbExR4QqiRjJXjyIqr6/w==
X-Google-Smtp-Source: ABdhPJy3Nqgd6MRL81ECqIQqY6DRWIZ+hD9vIeH8yHHvPsFEreTwXeQsyGNYWH6if9e/Wa/v1gWXLQ==
X-Received: by 2002:a9d:1913:: with SMTP id j19mr3740651ota.166.1632982829691;
        Wed, 29 Sep 2021 23:20:29 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id x4sm421228otq.25.2021.09.29.23.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 23:20:28 -0700 (PDT)
From:   Shunsuke Mie <mie@igel.co.jp>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Shunsuke Mie <mie@igel.co.jp>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jianxin Xiong <jianxin.xiong@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        Maor Gottlieb <maorg@nvidia.com>,
        Sean Hefty <sean.hefty@intel.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, dhobsong@igel.co.jp, taki@igel.co.jp,
        etom@igel.co.jp
Subject: [RFC PATCH v2 0/1] Providers/rxe: Add dma-buf support
Date:   Thu, 30 Sep 2021 15:20:13 +0900
Message-Id: <20210930062014.38200-1-mie@igel.co.jp>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This is an user space counter-part of the kernel patch set to add
dma-buf support to the RXE driver.

Pull request at GitHub: https://github.com/linux-rdma/rdma-core/pull/1055

This is the secound version of the patch. Change log:
v2:
* Fix code formats that were indicated by Azure CI
v1: https://www.spinics.net/lists/linux-rdma/msg105380.html
* Initial patch set
* Implement a callback function for reg_dmabuf_mr

Shunsuke Mie (1):
  Providers/rxe: Add dma-buf support

 providers/rxe/rxe.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

-- 
2.17.1

