Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1742DA460
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Dec 2020 00:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbgLNXuL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Dec 2020 18:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbgLNXuJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Dec 2020 18:50:09 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44EEBC061793
        for <linux-rdma@vger.kernel.org>; Mon, 14 Dec 2020 15:49:29 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id p126so21282742oif.7
        for <linux-rdma@vger.kernel.org>; Mon, 14 Dec 2020 15:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rGwb6Vn+SQ80ten1rIk4ibrv0T3kz0SnWjWNA8WAoJ4=;
        b=KkXRR7ZvoNpGfuzlx104CqkgunPLbU+xNPlsvwna31V5gV0NpDk7ico03RUrXOikvH
         Bi9KXoDepiYyZrqMzVWjin0NJZk6e847AWw3WtuDNzxnOZW0lkvQoQFqcV05yIXYYawT
         sncEweFrON6qzHRFRqIcmVGFztJUBcFcQey3sBKt7GMUCoN5WtKySs/5AvEdLTJeSWuS
         tJf/aMzudZJdvCFxKjLvau5mAIntkMhDEa1ZtabxpkYbamNcnyt1IxlwfmtRouWBQ3Ca
         tXQLn1dxDrF22V5XHtqG9+7DV6GVl2QDp6b5RbQOh32NkGW/tqZPglhZGf44TdQywlum
         JuEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rGwb6Vn+SQ80ten1rIk4ibrv0T3kz0SnWjWNA8WAoJ4=;
        b=ekwsBvPxPiT8KtjQjqriFcINaSE9HVhKvgpg2LzMb/EhY2IhIjYhrvFCUrQ5mMbR2d
         1lLmnB8vxBgJk06F9/vKaEZL5kyC1AlHRfGZJ4IrCpMrZUWMgd8elt9auFacKs90HHgI
         sczJGL9SLJwVKijzD70c3JODzEff/p4Xc6ADEXd2upb8iR+NzKfA26sSki48ccNsGRmJ
         xAsWLOU2MKHMgIQHKvBekai8dOWOwfqMoQxUMZXOuxlUT1um0riNUVTzNwN4iAqhORfz
         gbrraHoNLsIsTBetOFBDy7NgP4VjED/YHmW1Zy4uVXU/o2/FKDPRp5UPJREA4o6h8i7U
         a+cQ==
X-Gm-Message-State: AOAM531uzToWH7ZlbSJTmchaohloIblHP9EFDmomE4bL7y6100KwfJq5
        oYtWxf6VPEySymAj3CFWybM=
X-Google-Smtp-Source: ABdhPJxFJT7U63g+KH+UvixW02bVVoP5vH5ezDL6JB86aUikRrkbvEgwJb4yYe6eFN1JmNCKzYkGBg==
X-Received: by 2002:a54:4413:: with SMTP id k19mr4267944oiw.110.1607989768788;
        Mon, 14 Dec 2020 15:49:28 -0800 (PST)
Received: from localhost (2603-8081-140c-1a00-2c18-5865-370f-5fc9.res6.spectrum.com. [2603:8081:140c:1a00:2c18:5865:370f:5fc9])
        by smtp.gmail.com with ESMTPSA id y84sm4839970oig.36.2020.12.14.15.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 15:49:28 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next 0/7] RDMA/rxe: cleanup and extensions
Date:   Mon, 14 Dec 2020 17:49:12 -0600
Message-Id: <20201214234919.4639-1-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch series makes various cleanups and extensions to the
object pool core in RDMA/rxe. They are mostly extracted from an
earlier patch set that implemented memory windows and extended
verbs APIs but are separated out since they stand on their own.

Bob Pearson (7):
  RDMA/rxe: Remove unneeded RXE_POOL_ATOMIC flag
  RDMA/rxe: Let pools support both keys and indices
  RDMA/rxe: Add elem_offset field to rxe_type_info
  RDMA/rxe: Make pool lookup and alloc APIs type safe
  RDMA/rxe: Make add/drop key/index APIs type safe
  RDMA/rxe: Add unlocked versions of pool APIs
  RDMA/rxe: Fix race in rxe_mcast.c

 drivers/infiniband/sw/rxe/rxe_mcast.c |  64 +++++---
 drivers/infiniband/sw/rxe/rxe_pool.c  | 226 +++++++++++++++++---------
 drivers/infiniband/sw/rxe/rxe_pool.h  |  94 ++++++++---
 drivers/infiniband/sw/rxe/rxe_verbs.c |  16 +-
 4 files changed, 268 insertions(+), 132 deletions(-)

-- 
2.27.0

