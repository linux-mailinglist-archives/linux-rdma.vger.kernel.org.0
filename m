Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 329D61702F9
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2020 16:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgBZPpn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Feb 2020 10:45:43 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:34028 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbgBZPpn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Feb 2020 10:45:43 -0500
Received: by mail-pj1-f66.google.com with SMTP id f2so2299895pjq.1
        for <linux-rdma@vger.kernel.org>; Wed, 26 Feb 2020 07:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=kJ+Vz0h46gXPemsAeApEgoMpx5RtDCVTaUkCZ0b4+Kk=;
        b=SrmIYxnPd4NL3kzaBDwSO2GdKpFQ1uaNp3Je6LPe+860tStkTBXuA0RTZhLf4EO+WK
         b/2RWTcNE4WRlq64Ym4OPz0l1KYLWn1XRHdnPpdkDr1xmdR/p4g8JYo0cj4j1OMT96g8
         7vP2Z5YFeXhLz/R8evOZbUiZtJALRHA5n8NmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kJ+Vz0h46gXPemsAeApEgoMpx5RtDCVTaUkCZ0b4+Kk=;
        b=mmzvmb3BI4J22jRYdFdeFdfP99+3FYBeCUcEYaPPtQSXYIAmsr1SzIADWd7/iZ5etS
         AUe4Th1A86I1oFwxqkPJ/hRdOiaG0QR6gQ9oVXXDMJI2FpVjKMBk1DkM56zjpCekGTfF
         EhBjVfTYgsaDH7468I24FyItxHonWHFC5BKmXmNDREy50+WFOfDdK4tjb7+Mz6ga2qq+
         FDp094sp5Vz1JljBSF7RSg8XYMSLAcFS/P2z9CEOepdetjQJa5P0+ZO6j22Du4Gv/Qxa
         J8m4SdXrE63zLoi5NheAR/41k0EEAD1r/D36XuXliwrUdT/nG++n1HPWzknj0eS1NXcc
         Ymeg==
X-Gm-Message-State: APjAAAUk3z4l5+JaoyORhS6M31zxAPuuLZf/qBMQrXeBEQg3tRy6m86t
        T4i8wryXjQv7A2gZqThQQfluCbGz37U=
X-Google-Smtp-Source: APXvYqw6k22GeZ1OpSGfqbL4WdBjPcidQSIOUMVWaaiTYxTCBu0CWkIFkuxViuVFA65dicDJTd5T6g==
X-Received: by 2002:a17:90a:7784:: with SMTP id v4mr5961800pjk.134.1582731942178;
        Wed, 26 Feb 2020 07:45:42 -0800 (PST)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id h3sm3502785pfo.102.2020.02.26.07.45.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Feb 2020 07:45:41 -0800 (PST)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     dledford@redhat.com, jgg@mellanox.com
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next v4 0/2] RDMA/bnxt_re driver update
Date:   Wed, 26 Feb 2020 07:45:30 -0800
Message-Id: <1582731932-26574-1-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Includes code refactoring in the device init/deinit path and
use the new driver unregistration APIs.

Please apply to for-next.

Thanks,
Selvin

v3-> v4:
 - Added netdev state query  and report the correct link state
   during device registration
 - Removed GID event during device registration
v2 -> v3:
 - Droped the patch which was adding more state macros
 - To prevent addition of any device during driver removal,
   unregister netdev notifier and delete the driver's workqueu
   before calling ib_unregister_driver
v1-> v2:
 - Remove the patches 1,2 and 6 from the v1 series.
   They are already merged.
 - Added ASSERT_RTNL instead of comment in Patch 2
 - For Patch 3, explicitly queue the removal of the VF devices
   before calling ib_unregister_driver. This can avoid command
   timeouts seen, if the PFs gets removed before the VFs.
   Previous discussion - https://patchwork.kernel.org/patch/11260013/

Selvin Xavier (2):
  RDMA/bnxt_re: Refactor device add/remove functionalities
  RDMA/bnxt_re: Use driver_unregister and unregistration API

 drivers/infiniband/hw/bnxt_re/main.c | 213 ++++++++++++++++++-----------------
 1 file changed, 108 insertions(+), 105 deletions(-)

-- 
2.5.5

