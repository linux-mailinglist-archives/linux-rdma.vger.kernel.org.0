Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 267371F9179
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2020 10:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgFOIcM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 15 Jun 2020 04:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbgFOIcM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 15 Jun 2020 04:32:12 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3B2C061A0E;
        Mon, 15 Jun 2020 01:32:12 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j10so16123714wrw.8;
        Mon, 15 Jun 2020 01:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9KYL3/QNGdUfmk+FO2Zw/YosA4y8k6PjID3Uf7sVNdc=;
        b=QtOkR5jfF7lmmFdPdljqkdC04VnCGOnahNDsT9a2uCWPfLVGqPGebsOQohqZdJmAvO
         Q9kerB0b+T23muU/+2Yiydhh1mVDK5jhtS+tyjRqZlsLxmrPjIJOM01J96eIryeRw3nd
         HrsdmS5De7fOFhuWQNR80hKHSC0jWry8ZtylyDvAKaoglk7CLsNrmf8vGjGn6y6BEuUZ
         TCF59RiuSsjizZdHIMC3UqT6ThWx8GgWALJXvI9zMYNkRTAJsji+c1Js19VKRUJKuGHh
         4Dtn9I7UI/WUhNNY7JUZzJ4mgyOTLNMtDgEWW/KBcp4EbsVrQe9+ab2yD4mtTQmFIT/7
         qEfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9KYL3/QNGdUfmk+FO2Zw/YosA4y8k6PjID3Uf7sVNdc=;
        b=uHr9qGJNEOGO9zak3KydO4LhcXVxtaspA4i0E1XCIum4pWR478zw1ISswd92PujOFT
         j4aSVdstlfDL2f0o5wxnvmVRzkQV+JgkKH5r5WRB5eV4ecks/lCTETdG67TbsbB6Q0k1
         nUN3txmb5em/UYyHD4WRPhfqhRVQ/bftvXkJG8Jc2d2pfPToWjt383LzQp0u1QQ6v1Cx
         i45L+TGV8JDpQPO1MmOmmEl/RF/n1IBFcaSIRnmU+qKKhsocXdroe3qcfgB1JEmZf8xU
         9d2M2aSL0yge45AEiJm8jH+yFk55eiF3wY1Ea0JSwfWFKFe6wG+xPBSOSp03LAzANZm7
         9hSg==
X-Gm-Message-State: AOAM5311LLKGeF8fMCvHlrBA6uR8332qLumU24ZRWb0qqhYrdQLyNdlJ
        MeFSav1uDugAKpCRj6uticY=
X-Google-Smtp-Source: ABdhPJxLXnD+PnWZMq7OsnU4Mxg6o2Ccm3rgVEepbhXZzGk1RDZts5KG01u8CP0K7rsYZGJjSKF1qg==
X-Received: by 2002:a5d:428e:: with SMTP id k14mr27402732wrq.21.1592209930738;
        Mon, 15 Jun 2020 01:32:10 -0700 (PDT)
Received: from net.saheed (54006BB0.dsl.pool.telekom.hu. [84.0.107.176])
        by smtp.gmail.com with ESMTPSA id z206sm21954745wmg.30.2020.06.15.01.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 01:32:10 -0700 (PDT)
From:   refactormyself@gmail.com
To:     helgaas@kernel.org
Cc:     Bolarinwa Olayemi Saheed <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        Don Brace <don.brace@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        esc.storagedev@microsemi.com, linux-scsi@vger.kernel.org,
        Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/8 v2] PCI: Align return values of PCIe capability and PCI accessors
Date:   Mon, 15 Jun 2020 09:32:17 +0200
Message-Id: <20200615073225.24061-1-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>


PATCH 1/8 to 7/8:
PCIBIOS_ error codes have positive values and they are passed down the
call heirarchy from accessors. For functions which are meant to return
only a negative value on failure, passing on this value is a bug.
To mitigate this, call pcibios_err_to_errno() before passing on return
value from PCIe capability accessors call heirarchy. This function
converts any positive PCIBIOS_ error codes to negative generic error
values.

PATCH 8/8:
The PCIe capability accessors can return 0, -EINVAL, or any PCIBIOS_ error
code. The pci accessor on the other hand can only return 0 or any PCIBIOS_
error code.This inconsistency among these accessor makes it harder for
callers to check for errors.
Return PCIBIOS_BAD_REGISTER_NUMBER instead of -EINVAL in all PCIe
capability accessors.

MERGING:
These may all be merged via the PCI tree, since it is a collection of
similar fixes. This way they all get merged at once.

Version 2:
* cc to maintainers and mailing lists
* Edit the Subject to conform with previous style
* reorder "Signed by" and "Suggested by"
* made spelling corrections
* fixed redundant initialisation in PATCH 3/8
* include missing call to pcibios_err_to_errno() in PATCH 6/8 and 7/8


Bolarinwa Olayemi Saheed (8):
  dmaengine: ioatdma: Convert PCIBIOS_* errors to generic -E* errors
  IB/hfi1: Convert PCIBIOS_* errors to generic -E* errors
  IB/hfi1: Convert PCIBIOS_* errors to generic -E* errors
  PCI: Convert PCIBIOS_* errors to generic -E* errors
  scsi: smartpqi: Convert PCIBIOS_* errors to generic -E* errors
  PCI/AER: Convert PCIBIOS_* errors to generic -E* errors
  PCI/AER: Convert PCIBIOS_* errors to generic -E* errors
  PCI: Align return values of PCIe capability and PCI accessorss

 drivers/dma/ioat/init.c               |  4 ++--
 drivers/infiniband/hw/hfi1/pcie.c     | 18 +++++++++++++-----
 drivers/pci/access.c                  |  8 ++++----
 drivers/pci/pci.c                     | 10 ++++++++--
 drivers/pci/pcie/aer.c                | 12 ++++++++++--
 drivers/scsi/smartpqi/smartpqi_init.c |  6 +++++-
 6 files changed, 42 insertions(+), 16 deletions(-)

-- 
2.18.2

