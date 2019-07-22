Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F42A6F9E5
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jul 2019 09:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfGVHGU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jul 2019 03:06:20 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35277 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfGVHGU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Jul 2019 03:06:20 -0400
Received: by mail-wr1-f65.google.com with SMTP id y4so38171892wrm.2
        for <linux-rdma@vger.kernel.org>; Mon, 22 Jul 2019 00:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=smMO22NsJO5YRemABcEiW5c5x7Nr4wSDYiUsIvrYfow=;
        b=ph7EHTtLMAv32+wNSb0/dQMRSKCnkPLkTLs5Kdn+W34j3+1bUK6tHAF/XBgqq+mAoX
         7eTFA+2FTDr2qh13634W8aeif3Ra3ArQjhCG4twiFEABLJOuXrfAcMof/2zaJzgzZaoQ
         ZDsk8s15aJObe5i0uhOt7r85Do4cJs5ofK86lH0piMnkwsONpb66mAFZwX3AGd8MvMa2
         abMvYVyrTdXMZ1j2m2ELX22S6zuCUDvo17X08KYsyPa/NldugR4RT1/pDW4HBtFa7drJ
         /eKrtXAjSzHmPLm2lCkQ+lG8AnhW6fByqaT3e/WL5kTzWkl3rsct2wIxkjJK2h2IrX1m
         pJkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=smMO22NsJO5YRemABcEiW5c5x7Nr4wSDYiUsIvrYfow=;
        b=ZW/I3p3VkGZkOKZMvOuB7mYPDjTpxRQrPuDqUA3Oi1MMnSqNxYxq+bXk4+PLSeUvaA
         NfFiEoytHiAgPiWdMBP70SuT2Tje86fV8h4gIvAYEtF/GMAJizcVFNRcgzocff7Debto
         IZa/5qpUElTkoSN9oQOrdeZrhVajSeLD+MZ9B6r9hNxKcOEOBjt8DkSYlqsXVkf1I9RS
         +BEESIOjiiFr0ZoCKFCrpVQ6AFSWEaAo/qG+vwDOPJgc7KcLPI7Gobcvcmf1hNpXvpa1
         M5bCwDNcV9Xc3bquYdqjZ+z3wzl/IDzwKER+d84As1CtzLmIyPNWbnvusU/gv35KhHyT
         KKsg==
X-Gm-Message-State: APjAAAVjxtaV4PsBPVQzhn7o0ckCZwyiDjdOLgAk6aUkGSK8KIkvPymv
        /KU3N3k3hYeYnxK7OzQ+g84fIT21
X-Google-Smtp-Source: APXvYqwlHExTTuvnG8DwiP7W6Z6q1Gbib6lmo4orlzFG782LVCIEjKJ4GuBejejei1YM3c9BSdyD5g==
X-Received: by 2002:a05:6000:1189:: with SMTP id g9mr34439743wrx.51.1563779177883;
        Mon, 22 Jul 2019 00:06:17 -0700 (PDT)
Received: from kheib-workstation.redhat.com (bzq-79-178-23-200.red.bezeqint.net. [79.178.23.200])
        by smtp.gmail.com with ESMTPSA id y18sm37360991wmi.23.2019.07.22.00.06.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 00:06:17 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next 0/3] {cxgb3, cxgb4, i40iw} Report phys_state
Date:   Mon, 22 Jul 2019 10:05:47 +0300
Message-Id: <20190722070550.25395-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series includes three patches that add the support for reporting
physical state for the cxgb3, cxgb4, and i40iw drivers via sysfs.

Kamal Heib (3):
  RDMA/cxgb3: Report phys_state in query_port
  RDMA/cxgb4: Report phys_state in query_port
  RDMA/i40iw: Report phys_state in query_port

 drivers/infiniband/hw/cxgb3/iwch_provider.c | 16 +++++++++++-----
 drivers/infiniband/hw/cxgb4/provider.c      | 16 +++++++++++-----
 drivers/infiniband/hw/i40iw/i40iw_verbs.c   |  7 +++++--
 3 files changed, 27 insertions(+), 12 deletions(-)

-- 
2.20.1

