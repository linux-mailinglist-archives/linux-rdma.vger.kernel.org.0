Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9E8736855
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jun 2023 11:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbjFTJvc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Jun 2023 05:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbjFTJu4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Jun 2023 05:50:56 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C73152957;
        Tue, 20 Jun 2023 02:49:10 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id A5C7592009C; Tue, 20 Jun 2023 11:49:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id A241B92009B;
        Tue, 20 Jun 2023 10:49:08 +0100 (BST)
Date:   Tue, 20 Jun 2023 10:49:08 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
cc:     linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] PCI+IB/hfi1: Fold duplicate secondary bus reset code
Message-ID: <alpine.DEB.2.21.2306200153110.14084@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,HDRS_LCASE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

 In the course of verifying my PCIe link training failure workaround (cf. 
<https://lore.kernel.org/r/alpine.DEB.2.21.2305310024400.59226@angie.orcam.me.uk/>) 
in the context of secondary bus reset handling I found a piece of code in 
the InfiniBand HFI1 driver that duplicates what we already have as private 
code in PCI core.  This patch series removes this duplication by exporting 
said private code and than making use of it in the HFI1 driver.

 As I have no means to run-time verify InfiniBand code I have only build 
these patches, for x86-64, with the HFI1 driver both built in and modular.
Please see individual change descriptions for further details.

 Please consider.

  Maciej
