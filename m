Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7157D7EC726
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Nov 2023 16:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjKOP2A (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Nov 2023 10:28:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbjKOP17 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Nov 2023 10:27:59 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6862419B
        for <linux-rdma@vger.kernel.org>; Wed, 15 Nov 2023 07:27:56 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-53d9f001b35so10467912a12.2
        for <linux-rdma@vger.kernel.org>; Wed, 15 Nov 2023 07:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1700062075; x=1700666875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xsuufIm5XNVULohJZKB+MSo5W4fqFo8nrXdNsZ/32qw=;
        b=iVydB4IiDUa2jWx0/Y9GwvoohOOlFGSlTmkrJyKwTD/Fobt7PZtQ6L22aSd8F+k/FJ
         mm6MLhwgB/sr3D9x6VzPDHOk/mPta9M0mArpO7dewx1ulv4hyLB6kizkYChfGuTSLbdA
         OSjwePOEbAZMYr1gJe/MucafP4m+DNujXpuqXngpFN39D5sZiwK2MIIESUN+VFR/czCN
         UJCreDa+uMGQ/ljup7nA1LX8J7a2uXdyapATP3e5Hgy4EIHI1PA2v8VVb8IIFtmOOAEL
         NZ3U7rlYB9uk+aaFfotn07XQk+rGMnZKUJYXGu/RoYrAQSy9vinD7jQLpjQ5uxERhcgn
         +wtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700062075; x=1700666875;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xsuufIm5XNVULohJZKB+MSo5W4fqFo8nrXdNsZ/32qw=;
        b=xL3+ZwBueyTIY8U2uRpo/a7kaZGpHiPhMAdSTjJC1ugpVylupgR9ewo9n1VmoWgSI9
         IjwHTpGJHUS21m66ccZxDgDMj1ENaAH0r6GSkiZdZi4XUkwzr8/Hk7c26L4r1gTpFu22
         3V3AUrKEF0FmBO+Ft4WQJVi7zEtGlx9QctltF+wfFyUJxiiakfRGE495Y4EF9yNdcl92
         KBxC0521QJ3CvHm+Lcq9haboeEx711pleL8OV9ZEolcei4laH/vLof6rFzvKHGRWSnxw
         8mmJ8y749Wsdq3Jd3eYUfsqPIfImQ8W39Txx2cyGk1hHhwpJck0AXFklC04gDO9TmwkK
         1uPQ==
X-Gm-Message-State: AOJu0YyyKACcB/L0QX0q4csSAyJt3VA/pYA9/Zm1N1WvetOipz81/Eml
        +nxAU8u89ame/eSuQRjwzotyQFEVRV/ClIwkvhg=
X-Google-Smtp-Source: AGHT+IGK6HbM+jGNGnOLu9u4RUtICbvPzduWwyE9OHPurBiOHBTycC38/txNiWI/uHlS2b9hy3BZZA==
X-Received: by 2002:a05:6402:1052:b0:543:52be:e6ad with SMTP id e18-20020a056402105200b0054352bee6admr9686231edu.5.1700062074819;
        Wed, 15 Nov 2023 07:27:54 -0800 (PST)
Received: from lb01533.fkb.profitbricks.net ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id u6-20020a056402064600b00542da55a716sm6577349edx.90.2023.11.15.07.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 07:27:54 -0800 (PST)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, jgg@ziepe.ca,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com
Subject: [PATCH for-next 0/9] Misc patches for RTRS
Date:   Wed, 15 Nov 2023 16:27:40 +0100
Message-Id: <20231115152749.424301-1-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason, hi Leon,

Please consider to include following changes to the next merge window.

Jack Wang (4):
  RDMA/rtrs-srv: Do not unconditionally enable irq
  RDMA/rtrs-clt: Start hb after path_up
  RDMA/rtrs-clt: Fix the max_send_wr setting
  RDMA/rtrs-clt: Remove the warnings for req in_use check

Md Haris Iqbal (4):
  RDMA/rtrs-clt: Add warning logs for RDMA events
  RDMA/rtrs-srv: Check return values while processing info request
  RDMA/rtrs-srv: Free srv_mr iu only when always_invalidate is true
  RDMA/rtrs-srv: Destroy path files after making sure no IOs in-flight

Supriti Singh (1):
  RDMA/rtrs: use %pe to print errors

 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 15 ++++++-----
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 37 +++++++++++++++++++-------
 drivers/infiniband/ulp/rtrs/rtrs.c     |  4 +--
 3 files changed, 37 insertions(+), 19 deletions(-)

-- 
2.25.1

