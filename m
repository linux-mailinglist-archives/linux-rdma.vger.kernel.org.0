Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D0F6AF5FE
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Mar 2023 20:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbjCGToA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Mar 2023 14:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbjCGTnh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Mar 2023 14:43:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE8A25E05;
        Tue,  7 Mar 2023 11:32:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4DAEFB81A13;
        Tue,  7 Mar 2023 19:32:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C45D1C433D2;
        Tue,  7 Mar 2023 19:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678217535;
        bh=Ni1yzPNnvWqwvM1DdC8krsgd0tFVlKYsWSGzV8SzUz4=;
        h=From:To:Cc:Subject:Date:From;
        b=YcVETIqxpKr4T8DO2iHHk4PG0PaFIAFLDI3Fru/Bae6xPp7VsgMqLntkLTRZ5oHxy
         ThsjTuiYEI6za8k69WKNm02sG9fmo0PBGGb+yoRTGdIBjRO3aUymbFoxkM2Xdmcfjz
         QzYqfo8uETa7TVqwMoFFJKPcGSYkoYLJgkt0TsgCSrzzRqwMo2XKlvF/WQBFhGAAPX
         gY5kWinRHzCnS62DwNgIMQwlfrGpwQGltQTNw6VrfL7JrtRExFxJGFFG78hRFfsXN0
         PfLZkkotT7BnJlGzOEbn6TBtxPNBzirbSgoGGxvHcsIMmp0fptYUF26veAc8uQjWuB
         mgbY0ftyqvZvg==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/2] PCI/AER: Remove redundant Device Control Error Reporting Enable
Date:   Tue,  7 Mar 2023 13:32:09 -0600
Message-Id: <20230307193211.874747-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Since f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is native"),
which appeared in v6.0, the PCI core has enabled PCIe error reporting for
all devices during enumeration.

Remove driver code to do this.

Bjorn Helgaas (2):
  IB/hfi1: Drop redundant pci_enable_pcie_error_reporting()
  IB/qib: Drop redundant pci_enable_pcie_error_reporting()

 drivers/infiniband/hw/hfi1/pcie.c    | 2 --
 drivers/infiniband/hw/qib/qib_pcie.c | 8 --------
 2 files changed, 10 deletions(-)

-- 
2.25.1

