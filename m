Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4677E0A72
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Nov 2023 21:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjKCUnq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Nov 2023 16:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKCUnp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Nov 2023 16:43:45 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AADA2
        for <linux-rdma@vger.kernel.org>; Fri,  3 Nov 2023 13:43:42 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-586beb5e6a7so1300690eaf.1
        for <linux-rdma@vger.kernel.org>; Fri, 03 Nov 2023 13:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699044222; x=1699649022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YI0XB1iQjVF0MyL+ruYAi69HJq7V3ME1liAzaRGTrnk=;
        b=Vt/paHN+tcg3IwmQoGS4OXAziw+NyTi5UML6QMYS/xvqiJeP0Z2csVWx9ouDFBaHMq
         0Ozz2x0/Zs5joiM9kSaQEw6bYK9yDkIY7ilwTccoFAx6cqVdnde6smu79kJ9JBzT+FAx
         GspL8i87CAbs1g1+v3QGe/rOguAjwh87G8qyYtlqIBkCy4PjA/ZDf0E8T4gvu/6jZtoF
         /CtUdy43IpePrJIOnBcZc1xMedQihCsnQ7fJO1TILeO4smj8fA61hx8e2NmQFXU15Y/9
         4A4Ifea9ywq88qIGZslFxHLVFaKhynWMZ4PWwlvsXtWU+MMZ1gSpMiRw3BK8VuM4WIDY
         ZZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699044222; x=1699649022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YI0XB1iQjVF0MyL+ruYAi69HJq7V3ME1liAzaRGTrnk=;
        b=kVptigwxGYd/pcWMF5snYjIw+XNhDUGqTQsYDtQ38eVGQr8yZZcaeJVLBp0shur3/v
         o2HlsuAwqkmSH7TEgsihaaFBm6cnFC+rojB2zIEY74NtIRF/DRudfRIBxVPlIaEhsbJk
         w5B3Qx7agYOsicT6QLVGgsBscquQ8/Q2A+ZAiS+eaStoDut4dWaEL5Vq8FBb66MfGpbY
         DcBfhzbBcDMBS5dVDWEBi9CbkH6vbJuTi5W1y3NdLcPF6LQa7Ti6sVeVjUouNWg1uI3V
         3Z6ARjtXSTO+t0Cul+CLL3qPjxHv0L91GKZSXql64s9KRY8c+2Ux8xuUUNvjoNHU/pQK
         TL5Q==
X-Gm-Message-State: AOJu0YyYXqsLGFdnHiFV5WWIbmNLEompgMOHsGetcFadY727Nf84UXMu
        crmuP1dKF7katyrjk2ZQU+k=
X-Google-Smtp-Source: AGHT+IFPOiBAgASets/wM5/OqQd1iNYzAsvmyBQIQvbPwjTqwAv0CgL0y6oxBYh+UpASzNnO2wER4w==
X-Received: by 2002:a4a:da4f:0:b0:582:3c4a:923a with SMTP id f15-20020a4ada4f000000b005823c4a923amr20652349oou.9.1699044222225;
        Fri, 03 Nov 2023 13:43:42 -0700 (PDT)
Received: from bob-3900x.lan (2603-8081-1405-679b-6bc0-11b9-c519-2c18.res6.spectrum.com. [2603:8081:1405:679b:6bc0:11b9:c519:2c18])
        by smtp.gmail.com with ESMTPSA id v9-20020a4ae049000000b00581e5b78ce5sm447766oos.38.2023.11.03.13.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 13:43:41 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, yanjun.zhu@linux.dev, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 0/6] RDMA/rxe: Make multicast actually work
Date:   Fri,  3 Nov 2023 15:43:18 -0500
Message-Id: <20231103204324.9606-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

After developing a test program which exercises node to node
testing of RoCE multicast it bacame clear that there are a
number of issues with the current rdma_rxe multicast implementation.

The issues seen include:
	- There is no support for IPV4 multicast addresses.
	- Once a multicast MAC is added it is not removed.
	- Multicast packets are sent with the wrong QP number.
	- Multicast packets sent from the local node are not
	  loopbacked to local QPs which have joined the same
	  multicast group and were not the sender.
	- Multicast IP addresses are not created and without
	  them no multicast packets received on the interface
	  are delivered to the rdma_rxe driver.
	- The implementation in rxe_mcast.c is potentially
	  racy if multiple simultaneous attach/detach operations
	  are issued.

This patch set fixes these issues. 

Bob Pearson (6):
  RDMA/rxe: Cleanup rxe_ah/av_chk_attr
  RDMA/rxe: Handle loopback of mcast packets
  RDMA/rxe: Register IP mcast address
  RDMA/rxe: Let rxe_lookup_mcg use rcu_read_lock
  RDMA/rxe: Split multicast lock
  RDMA/rxe: Cleanup mcg lifetime

 drivers/infiniband/sw/rxe/rxe.c        |   2 +-
 drivers/infiniband/sw/rxe/rxe_av.c     |  50 +--
 drivers/infiniband/sw/rxe/rxe_loc.h    |   6 +-
 drivers/infiniband/sw/rxe/rxe_mcast.c  | 511 +++++++++++--------------
 drivers/infiniband/sw/rxe/rxe_net.c    |  27 +-
 drivers/infiniband/sw/rxe/rxe_net.h    |   1 +
 drivers/infiniband/sw/rxe/rxe_opcode.h |   2 +-
 drivers/infiniband/sw/rxe/rxe_qp.c     |   4 +-
 drivers/infiniband/sw/rxe/rxe_recv.c   |  11 +-
 drivers/infiniband/sw/rxe/rxe_req.c    |  11 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c  |   5 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h  |   5 +-
 12 files changed, 285 insertions(+), 350 deletions(-)

-- 
2.40.1

