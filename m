Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9102B104ABC
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Nov 2019 07:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbfKUGWk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Nov 2019 01:22:40 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35356 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfKUGWk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Nov 2019 01:22:40 -0500
Received: by mail-wr1-f66.google.com with SMTP id s5so2922436wrw.2
        for <linux-rdma@vger.kernel.org>; Wed, 20 Nov 2019 22:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=LM0svKfF+hpHyc9fqDL2OBns88RTteUTdttR1bJ9fBs=;
        b=eabETdM4j7Arh9hEGUIRIF2z+llBiCVih4VcK75FMI8ytTwXh4f7kh2tTs8pEPxRAi
         PF2V/RUx7XWFjSLqF68FAyU8+ZL4L58CoKDrQRbj8jv9Q4KTPjlMJbc1/1BDgkGRDXbB
         A67RFXMpBiI5aKUiA9/t7h4ZWbHIURY7vlUXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LM0svKfF+hpHyc9fqDL2OBns88RTteUTdttR1bJ9fBs=;
        b=VaZiuMfldiNHAgqULhuMlcaLE1XUB3C7aSeACmdqAQmm9GVahKqWkagF7XFjuI5mJO
         ZG7AGemE1pFTc6X+tddIJO6MrKo+GZmPc5L+6dnEO4EKn1CZcYwAJehJ5A84cWvqzdEx
         AYnu0zZ7xR8FIMaAHhZH+fHetZpbyUhX+hP4RomJeMUBuGn//b2WEmCvMPNi0aKQNLAz
         YL1anRQ/Ij1HgzUKc4JAI0JNJjc0onH7CuIoISQlBZNVwPtPsPU1JZI0x3Ok7d8cY6xz
         r0qmcE6Ip+I44nKe52kV3viTm2erClE4ShwEt7QwBaKq4WKwNjKihNGVZ5LQKhLRxiaA
         gjvQ==
X-Gm-Message-State: APjAAAWwBt6+YCp0MLMTmPqQeuwK97hEBA/IzNjbdrBDKUrjpapa/9aS
        oKoqZebhGqgJ7kUg3Hhq6E6uhA==
X-Google-Smtp-Source: APXvYqwa1l7hXZuPQ+vQWg2kFd7+7j71a5iWvtlaYS58BYf17xmT9O5wQBsSQ9UI1CmAsDFpPMUzvA==
X-Received: by 2002:adf:f6d1:: with SMTP id y17mr8066005wrp.255.1574317357343;
        Wed, 20 Nov 2019 22:22:37 -0800 (PST)
Received: from neo00-el73.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id y11sm76377wrq.12.2019.11.20.22.22.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 22:22:36 -0800 (PST)
From:   Devesh Sharma <devesh.sharma@broadcom.com>
To:     dledford@redhat.com, jgg@mellanox.com
Cc:     linux-rdma@vger.kernel.org,
        Devesh Sharma <devesh.sharma@broadcom.com>
Subject: [PATCH V3 for-next 0/3] Broadcom's roce driver bug fixes
Date:   Thu, 21 Nov 2019 01:22:20 -0500
Message-Id: <1574317343-23300-1-git-send-email-devesh.sharma@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This submission for for-next branch contains 3 patches, first two
patches are important urgent fixes for Gen P5 device. The first
patch deals with device detection in device open. While second
patch fixes hardware counters.

The third patch fixes few sparse warnings from main.c.

changes from V2 to V3
 - moved the series from for-rc to for-next
 - added back the sparse warning fix patch.

changes from V1 to V2
 - dropped patch related to sparse warnings.
 - updated patch description to report the motivation
   for submission to for-rc branch.

changes for V0 to V1
 - originally this series had only 1 patch which is the first patch.
 - Added Fixes tag on the first patch.
 - added two more patches to fix other quick bug fixes.

Devesh Sharma (2):
  RDMA/bnxt_re: fix stat push into dma buffer on gen p5 devices
  RDMA/bnxt_re: fix sparse warnings

Luke Starrett (1):
  RDMA/bnxt_re: Fix chip number validation Broadcom's Gen P5 series

 drivers/infiniband/hw/bnxt_re/main.c      | 9 +++++----
 drivers/infiniband/hw/bnxt_re/qplib_res.h | 8 ++++++--
 2 files changed, 11 insertions(+), 6 deletions(-)

-- 
1.8.3.1

