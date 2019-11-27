Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA06510AE03
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Nov 2019 11:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfK0Knr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Nov 2019 05:43:47 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45462 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfK0Knr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 27 Nov 2019 05:43:47 -0500
Received: by mail-pf1-f194.google.com with SMTP id z4so10775560pfn.12
        for <linux-rdma@vger.kernel.org>; Wed, 27 Nov 2019 02:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=a2IDbK4WuaZerW8XjnZl4XtXagKskHz70T8fYIVz2As=;
        b=DWagZbApiL2hYJgpSCrcGkLous9dAYVPBuznsk+yz+ymfn4XO2wobhukMvLS/fUbfU
         hkiBydLhowGOi4TO2hrtFYdgPpVlvCt1pP3DK4wjbt+Y349insMZHg+vkfTQXm+nloYo
         Yw0CTG7XKUPpG9dst2gpDqq9igHk7cQYEllWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=a2IDbK4WuaZerW8XjnZl4XtXagKskHz70T8fYIVz2As=;
        b=l4MCQTNdZ5p5WQXEKt8RNlPxWswOb/JQ5V0oRvuLYIkmpo3uXuEgCi3KDrFDAN2XrS
         oxD2THKB7oeUnl4+zSs3nBfRYuOkkK0xBWimp9c8cTFn5/Mt56OQLUpBTcIPkq2sUnNW
         VJenJ33szE+lH9I5R1QbVpZvrFnWG3AczUuQRF0LsaWRXovjqxL2dWBQ2Y0IdpkvRPPl
         Bw7jViUwHrwXIF/UFH/NUB3O/1jbMV/pNMSZaAFtVOoTdZ4swqRYCnsJKzjLNzQv2XuT
         fZr768PK4m8LP3hq2GVwz3bgV8cL0UUM0Xb8vdPU645Skdyyta9m9WLtfO2tZ3RsBPr1
         IXBA==
X-Gm-Message-State: APjAAAVNhUK0HD4BMnps1VyoIDldMG/LlnAg5D60o2yBysBhnMteSOLl
        skLGkzQ3R5DVaNlIzALh7Z29yQ==
X-Google-Smtp-Source: APXvYqwQSHhT13mDYeNWGZXyly2F4rG7fT44sKnXAU8udMs1erMXVd8genI9ZoofJ2hBP7zAXWd8yg==
X-Received: by 2002:a63:4553:: with SMTP id u19mr4103899pgk.436.1574851426071;
        Wed, 27 Nov 2019 02:43:46 -0800 (PST)
Received: from neo00-el73.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id x190sm16104286pfc.89.2019.11.27.02.43.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2019 02:43:45 -0800 (PST)
From:   Devesh Sharma <devesh.sharma@broadcom.com>
To:     dledford@redhat.com, jgg@mellanox.com, leonro@mellanox.com
Cc:     nmoreychaisemartin@suse.com, linux-rdma@vger.kernel.org,
        Devesh Sharma <devesh.sharma@broadcom.com>
Subject: [PATCH rdma-core 0/2] bnxt_re/lib: libbnxt_re bug fixes
Date:   Wed, 27 Nov 2019 05:43:33 -0500
Message-Id: <1574851415-4407-1-git-send-email-devesh.sharma@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series contains two patches which are important urgent
fixes. The first patch adds missing PCI ids. The second patch
enables adaptors based on new gen p5 chip revs.

Luke Starrett (1):
  bnxt_re/lib: Recognize additional 5750x device ID's

Naresh Kumar PBS (1):
  bnxt_re/lib: Add remaining pci ids for gen P5 devices

 providers/bnxt_re/main.c | 14 +++++++++++---
 providers/bnxt_re/main.h |  5 ++++-
 2 files changed, 15 insertions(+), 4 deletions(-)

-- 
1.8.3.1

