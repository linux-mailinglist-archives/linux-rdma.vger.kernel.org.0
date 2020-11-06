Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5160D2AA09D
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Nov 2020 00:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbgKFXBe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 Nov 2020 18:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728111AbgKFXBb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 6 Nov 2020 18:01:31 -0500
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902CCC0613CF
        for <linux-rdma@vger.kernel.org>; Fri,  6 Nov 2020 15:01:31 -0800 (PST)
Received: by mail-oo1-xc42.google.com with SMTP id t28so735701ood.6
        for <linux-rdma@vger.kernel.org>; Fri, 06 Nov 2020 15:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UTqlqlQLMwLNCg7+Wn/ofmV2pxkAEfSHKDpVZNdhU2U=;
        b=U6Jv5o2OaeYgVj/b+pmmcoc9SDn5jzTCEwQK7WxAuFHqzkTls0UCsboozjk15r9i6T
         4QBSMtulqkU/Ij5NQuIW6rtVuy3btS50KaCPcexWXwp/UHVhuZPOsHK6tEJDrF/GxKlI
         ej1y0bVavK1U8cT25fBJj6jnNvcgRpfkYUrYKZcGZv58L3MGpBlPwt8lWypDBjxZ9qGd
         eQMpFzroIYF3dDbRsc9wpCmxg6dBFAEH+zTs1ymDWQ82Gz9UDEs3LpKRVWTSZtdJ4BqJ
         FcoIyFTdaHCevGXkdIchvMatdMZ7Ke3GxLnrTDW3eDTRrVzFj/9KbZChc0mrrJ1rRvIW
         krpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UTqlqlQLMwLNCg7+Wn/ofmV2pxkAEfSHKDpVZNdhU2U=;
        b=FmC9G2jFA8nKpltX9hS2AHbrpnrMesKGQUNmbOH66n+68WVi+CJghk6hfmg/LImxbF
         dTUKq7psZqFOvheycVn23Wgg8+WcROwq5h+wQg0d0rYrmn2rw/185ixxbAT/uFUrYOR/
         8zuRofbw5A/ZKaAg+0OqvNoSpDf8zLfheMCvng6Q+W+GMLrLx5+0eL4WdS1bbWxqLXCf
         AcbrDsJARDXAbi8XMDeHpwkPmAaFQ+14/73I/pqGgJWAxh5tL68yd0NuvA3mDEJWOjQD
         c5w9VLVzFNHizogWeeKaP/iLicrJW/vB4YUsZdiwSuOtpVcPUELcY1gh29PFgpmoHt9x
         M5tQ==
X-Gm-Message-State: AOAM533yTP6XBkqEVvmRtsVP/sO6fiExbEiMqgA16u53qYtZfsQPYtOW
        fl8VAp7mlwQ49CWXE0lDKjM=
X-Google-Smtp-Source: ABdhPJxhIK4Xxz1RvNm7XDE8Afn28hpGvb29M9RDGXn9lETg/QnAIvWkRQKcinEd+gBHeoSHpFv8MA==
X-Received: by 2002:a4a:c018:: with SMTP id v24mr2781015oop.2.1604703691039;
        Fri, 06 Nov 2020 15:01:31 -0800 (PST)
Received: from localhost (2603-8081-140c-1a00-f960-8e80-5b89-d06d.res6.spectrum.com. [2603:8081:140c:1a00:f960:8e80:5b89:d06d])
        by smtp.gmail.com with ESMTPSA id 72sm641368otd.11.2020.11.06.15.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 15:01:30 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH 0/4] Provider/rxe: Implement extended verbs APIs
Date:   Fri,  6 Nov 2020 17:01:18 -0600
Message-Id: <20201106230122.17411-1-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Implement the following erxtended verbs APIs:
	ibv_query_device_ex
	ibv_create_cq_ex
	ibv_create_qp_ex

Also implement the field parse and set ops in struct ibv_cq and ibv_qp.

Introduce a pair of SW capability bit masks that are exchanged between
the user space provider and the kernel space driver during the
ibv_alloc_context verb to allow the provider and driver to adjust
shared data structures depending on which capabilities are supported.
This is an extensible mechanism to avoid changes to ABI version.

This patch set depends on the following patch
	0001-Provider-rxe-Cleanup-style-warnings.patch

Bob Pearson (4):
  Provider/rxe: Exchange capabilities with driver
  Provider/rxe: Implement ibv_query_device_ex verb
  Providers/rxe: Implement ibv_create_cq_ex verb
  Providers/rxe: Implement ibv_create_qp_ex verb

 kernel-headers/rdma/rdma_user_rxe.h |  49 ++
 providers/rxe/rxe-abi.h             |   8 +-
 providers/rxe/rxe.c                 | 976 +++++++++++++++++++++++++++-
 providers/rxe/rxe.h                 |  27 +-
 providers/rxe/rxe_queue.h           |  80 ++-
 5 files changed, 1092 insertions(+), 48 deletions(-)

Signed-off-by: Bob Pearson <rpearson@hpe.com>
-- 
2.27.0

