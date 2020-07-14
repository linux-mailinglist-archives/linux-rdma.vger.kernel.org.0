Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F46121ED95
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2020 12:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbgGNKEe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Jul 2020 06:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgGNKEd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Jul 2020 06:04:33 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBAEC061755;
        Tue, 14 Jul 2020 03:04:33 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id b15so16402548edy.7;
        Tue, 14 Jul 2020 03:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Z9A/niHETTJ6sG1YCidrVIts+5Cm3jRqOKxgMwZf804=;
        b=bJw/CWfEaGdgNEsvB+E0Pil+beiADxQRlYxFucL33vnzGqhY657FC8SLKndNCYmWBW
         RG5pWkJLTJi7uV42p3TsQHKr/zZfidLqtMJ6mhYMNC7lnI8wL9ob0ZHPC/oUfDh7idx9
         YzZ5BPoKFaD4VIy/72jiqKG0NxCQQ/8/m0foHD5mlcSJx45cFGCE0ILJ//80+HYv7hgW
         vQPwbztXczFxvfH8naRy5OzPhS16kn4sp5IQ1SShba7JIk1FYKiSmcPbBnzuxhJPin52
         zs+2qK4Yl/c3Za2m01tJx2/dAlc7v3zAHdgKWQuYZnn8eWzCtCNQsxS2ZxmznDCviBeh
         Aeng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Z9A/niHETTJ6sG1YCidrVIts+5Cm3jRqOKxgMwZf804=;
        b=XuRXw8XqR/Djz3HSx4juHq98axkx/Mwh8ty51ATn0Hx9h0CiYZEEuCBXWRLz8CnIRO
         gWXw5vBAxy4dQRtIe5ELCc9dThMX8CyRN7PZz10mHi8AeJz6Ux4euMYm/kA3d2uPahXq
         whcro/SOCP5B0VTVu4nIAEm/ZFOvOX9QDrw65bDj+BXBAB6fLxke/OAe3wJa8EYADMdP
         47SUbaUOn/34Yyuge6MugsBEa6APZtw2KvNZoxsd+Z+SeyoTbukMntROW44ASow9uE7U
         ZExIy53JkLZyCjOS/mWWBZ82382TK0xaShgKTnz5BLfUDtNcPTmi0FzctoGaZXPIR5bX
         BZvQ==
X-Gm-Message-State: AOAM5333Epmbh62lMNj8C+1zspjPT0EaGyk63vZMZ6DObgjHNjY3+cz7
        VBQRilY7I3NxL6BU6EYA0Q8=
X-Google-Smtp-Source: ABdhPJz5BLx6UNGp+PcUoVcl9C9PveBd35/nU0renWNn761chkn0KvLT9qpMImrdubKCO2n43ShSeQ==
X-Received: by 2002:a05:6402:176e:: with SMTP id da14mr3798086edb.262.1594721071939;
        Tue, 14 Jul 2020 03:04:31 -0700 (PDT)
Received: from net.saheed (54007186.dsl.pool.telekom.hu. [84.0.113.134])
        by smtp.gmail.com with ESMTPSA id bs18sm14137672edb.38.2020.07.14.03.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 03:04:31 -0700 (PDT)
From:   Saheed Olayemi Bolarinwa <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     Bolarinwa Olayemi Saheed <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 0/14 v4] PCI: Remove '*val = 0' from pcie_capability_read_*()
Date:   Tue, 14 Jul 2020 13:04:42 +0200
Message-Id: <20200714110445.32605-1-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>

v4 CHANGES:
- Remove unnecessary boolean conversion
- fix bugs introduced by previous version in PATCH 11/14

v3 CHANGES:
- Split previous PATCH 6/13 into two : PATCH 6/14 and PATCH 7/14
- Fix commit message of PATCH 5/14
- Update Patch numbering and Commit messages
- Add 'Acked by Greg KH' to PATCH 2/14
- Add PATCH version

v2 CHANGES:
- Fix missing comma, causing the email cc error
- Fix typos and numbering errors in commit messages
- Add commit message to 13/13
- Add two more patches: PATCH 3/13 and PATCH 4/13

MERGING:
Patch 7/14 depends on Patch 6/14. However Patch 6/14 has no dependency.
Please, merge PATCH 7/14 only after Patch 6/14.
Patch 14/14 depend on all preceeding patchs. Except for Patch 6/14 and
Patch 7/14, all other patches are independent of one another. Hence,
please merge Patch 14/14 only after other patches in this series have
been merged.


PATCH 6/14:
Make the function set status to "Power On" by default and only set to
Set "Power Off" only if pcie_capability_read_word() is successful and
(slot_ctrl & PCI_EXP_SLTCTL_PCC) == PCI_EXP_SLTCTL_PWR_OFF. 

PATCH 1/14 to 13/14:
Check the return value of pcie_capability_read_*() to ensure success or
confirm failure. While maintaining these functions, this ensures that the
changes in PATCH 14/14 does not introduce any bug. 

PATCH 14/14:
There are several reasons why a PCI capability read may fail whether the
device is present or not. If this happens, pcie_capability_read_*() will
return -EINVAL/PCIBIOS_BAD_REGISTER_NUMBER or PCIBIOS_DEVICE_NOT_FOUND
and *val is set to 0.

This behaviour if further ensured by this code inside
pcie_capability_read_*()

 ret = pci_read_config_dword(dev, pci_pcie_cap(dev) + pos, val);
 /*
  * Reset *val to 0 if pci_read_config_dword() fails, it may
  * have been written as 0xFFFFFFFF if hardware error happens
  * during pci_read_config_dword().
  */
 if (ret)
	 *val = 0;
 return ret;

a) Since all pci_generic_config_read() does is read a register value,
it may return success after reading a ~0 which *may* have been fabricated
by the PCI host bridge due to a read timeout. Hence pci_read_config_*() 
will return success with a fabricated ~0 in *val, indicating a problem.
In this case, the assumed behaviour of  pcie_capability_read_*() will be
wrong. To avoid error slipping through, more checks are necessary.

b) pci_read_config_*() will return PCIBIOS_DEVICE_NOT_FOUND only if 
dev->error_state = pci_channel_io_perm_failure (i.e. 
pci_dev_is_disconnected()) or if pci_generic_config_read() can't find the
device. In both cases *val is initially set to ~0 but as shown in the code
above pcie_capability_read_*() resets it back to 0. Even with this effort,
drivers still have to perform validation checks more so if 0 is a valid
value.

Most drivers only consider the case (b) and in some cases, there is the 
expectation that on timeout *val has a fabricated value of ~0, which *may*
not always be true as explained in (a).

In any case, checks need to be done to validate the value read and maybe
confirm which error has occurred. It is better left to the drivers to do.

Check the return value of pcie_capability_read_dword() to ensure success
and avoid bug as a result of Patch 14/14.
Remove the reset of *val to 0 when pci_read_config_*() fails.


Bolarinwa Olayemi Saheed (14):
  IB/hfi1: Check the return value of pcie_capability_read_*()
  misc: rtsx: Check the return value of pcie_capability_read_*()
  ath9k: Check the return value of pcie_capability_read_*()
  iwlegacy: Check the return value of pcie_capability_read_*()
  PCI: pciehp: Check the return value of pcie_capability_read_*()
  PCI: pciehp: Make "Power On" the default 
  PCI: pciehp: Check the return value of pcie_capability_read_*()
  PCI/ACPI: Check the return value of pcie_capability_read_*()
  PCI: pciehp: Check the return value of pcie_capability_read_*()
  PCI: Check the return value of pcie_capability_read_*()
  PCI/PM: Check return value of pcie_capability_read_*()
  PCI/AER: Check the return value of pcie_capability_read_*()
  PCI/ASPM: Check the return value of pcie_capability_read_*()
  PCI: Remove '*val = 0' from pcie_capability_read_*()

 drivers/net/wireless/ath/ath9k/pci.c         | 5 +++--
 drivers/net/wireless/intel/iwlegacy/common.c | 4 ++--
 drivers/infiniband/hw/hfi1/aspm.c | 7 ++++---
 drivers/misc/cardreader/rts5227.c | 5 +++--
 drivers/misc/cardreader/rts5249.c | 5 +++--
 drivers/misc/cardreader/rts5260.c | 5 +++--
 drivers/misc/cardreader/rts5261.c | 5 +++--
 drivers/pci/pcie/aer.c  |  5 +++--
 drivers/pci/pcie/aspm.c | 33 +++++++++++++++++----------------
 drivers/pci/hotplug/pciehp_hpc.c | 47 ++++++++++++++++----------------
 drivers/pci/pci-acpi.c           | 10 ++++---
 drivers/pci/probe.c              | 29 ++++++++++++--------
 drivers/pci/access.c | 14 --------------
 13 files changed, 87 insertions(+), 87 deletions(-)

-- 
2.18.2

