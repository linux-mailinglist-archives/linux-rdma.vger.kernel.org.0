Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3E5210343F
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Nov 2019 07:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbfKTGUb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Nov 2019 01:20:31 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56127 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfKTGUb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Nov 2019 01:20:31 -0500
Received: by mail-wm1-f65.google.com with SMTP id b11so5686715wmb.5
        for <linux-rdma@vger.kernel.org>; Tue, 19 Nov 2019 22:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=V5Z7rMtfH/Ud14ZS0lwM/6hxRu9Guu+XhxgsWYgmhko=;
        b=MqZMFDLucnb9F3ggb8efT3zM4ulJCHvY9KiCr4mGOHrxcxPcJ99KI9Ix00u6zpt3z1
         tLFkd7IjuoGu6Lfyga8mlJlsihBytjzOefY+eBr7Nmut85/BxLPD8dYNOn+aeqw0rH38
         Vy0pR5j+O7RIRJjARUPeR3F/3lJhrVLG26j8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=V5Z7rMtfH/Ud14ZS0lwM/6hxRu9Guu+XhxgsWYgmhko=;
        b=sasW273hAY4B51Ot3r009QT7B31Mi09/3+eMhFHFmVfd7HQXMLfDpbGkqE5ixDq3a3
         r2NO7gPUoy7VImF216FcojfZfyX//VGbatWMYFuuFb2KWDsSHS2vEzpCG+b3lljv1TAy
         r/fEZF/zbR4xtDX1bx7Iqw0CMhXAQ0DBCCM45n8gpC2PIURb7naHpOQ/8FlGKhM5zm3z
         vXOhZyjSXFnmZ85Y2v/2dZek0lmI8FCuJWFX8dnnrk1vcpRvYLruhZ5aG4GwPBXIkjSg
         46IcuA+IidATNtZkEOopYX5UrRK7FzYZ+bFEmgBN5iqJndgC3+UiYzyqvd/RXyrKVHB3
         ZHmg==
X-Gm-Message-State: APjAAAVU+oF6/at5HXIznWie5bcd7KVBqy7Sn7F9GVDrZi+qY/7nNnF7
        8p/OICvbvu7lRd06pcpCwsng8w==
X-Google-Smtp-Source: APXvYqxH7lvipbR5JGuMPqC1QNz2Knu2PIkXr+yBpmT5v5elTTN5Q1Y6x2mpWb9buLZi7T+9MAQM6w==
X-Received: by 2002:a1c:4606:: with SMTP id t6mr1123097wma.73.1574230829275;
        Tue, 19 Nov 2019 22:20:29 -0800 (PST)
Received: from neo00-el73.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id j7sm32466705wro.54.2019.11.19.22.20.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Nov 2019 22:20:28 -0800 (PST)
From:   Devesh Sharma <devesh.sharma@broadcom.com>
To:     dledford@redhat.com, jgg@mellanox.com
Cc:     linux-rdma@vger.kernel.org,
        Devesh Sharma <devesh.sharma@broadcom.com>
Subject: [PATCH V2 for-rc 0/2] Broadcom's roce driver bug fixes
Date:   Wed, 20 Nov 2019 01:20:16 -0500
Message-Id: <1574230818-30295-1-git-send-email-devesh.sharma@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This submission for for-rc branch contains 2 patches, both the
patches are important urgent fixes for Gen P5 device. The first
patch deals with device detection in device open. While second 
patch fixes hardware counters.

changes from V1 to V2
 - dropped patch related to sparse warnings.
 - updated patch description to report the motivation
   for submission to for-rc branch.

changes for V0 to V1
 - originally this series had only 1 patch which is the first patch.
 - Added Fixes tag on the first patch.
 - added two more patches to fix other quick bug fixes.

Devesh Sharma (1):
  RDMA/bnxt_re: fix stat push into dma buffer on gen p5      devices

Luke Starrett (1):
  RDMA/bnxt_re: Fix chip number validation Broadcom's Gen P5 series

 drivers/infiniband/hw/bnxt_re/main.c      | 1 +
 drivers/infiniband/hw/bnxt_re/qplib_res.h | 8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

-- 
1.8.3.1

