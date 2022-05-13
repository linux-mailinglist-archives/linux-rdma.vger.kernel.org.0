Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892D952632D
	for <lists+linux-rdma@lfdr.de>; Fri, 13 May 2022 15:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbiEMNuE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 May 2022 09:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382461AbiEMNs0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 May 2022 09:48:26 -0400
Received: from gentwo.de (gentwo.de [IPv6:2a02:c206:2048:5042::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F042EFD3C
        for <linux-rdma@vger.kernel.org>; Fri, 13 May 2022 06:48:22 -0700 (PDT)
Received: by gentwo.de (Postfix, from userid 1001)
        id C7AC5B0061B; Fri, 13 May 2022 15:48:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.de; s=default;
        t=1652449699; bh=9bPKZ31zyrzkdNSM2sG9QfqIvg8NzDUFA0AgpOMGiiU=;
        h=Date:From:To:cc:Subject:From;
        b=Zyxta5BmDpjHGfV8n96YaOH0cNWnHnPuegLC8fHwvszYG6SVz+TJhEp/fa7FIugd/
         ECLUXCMP8YqogUoXJl1A6KubZuU4ZSyayCOYj8jaMbIj5OlXDPFNm3cU8XaYA13v8W
         1nzbxzgix7IefeLe50qXgvJs/H6tIVjYv/F01Kaql5yQATbrlcsJBsACKoF2a0TPa2
         Fs5HoN4ZsHmCqsvZcIen/OIPGU/soaCLpU/tYBTwTIWNJ+c545ij8rhQ74y0890gsh
         NftH8q3A/7ty6ktgwrJdawDMCJM6KaZx3bxoDqUKxn3yODiNkEydOFZOutRHxi0PeL
         uK4pWacL/LJmg==
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id C59C7B00149;
        Fri, 13 May 2022 15:48:19 +0200 (CEST)
Date:   Fri, 13 May 2022 15:48:19 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
To:     Bob Pearson <rpearsonhpe@gmail.com>
cc:     linux-rdma@vger.kernel.org, zyjzyj2000@gmail.com, jgg@nvidia.com
Subject: Redhat 9 removes RXE (SoftROCE) support
Message-ID: <alpine.DEB.2.22.394.2205131542300.2577@gentwo.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

I was surprised to find that RHEL 9 removes ROCE support after it was a
"tech preview" in Redhat 8. Its a good feature with many use cases here
and there for development, testing and production issues.

Any idea why Redhat would not support RXE? Could we get a campaign going
to convince Redhat to include RXE?


From:
https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/9-beta/pdf/considerations_in_adopting_rhel_9/red_hat_enterprise_linux-9-beta-considerations_in_adopting_rhel_9-en-us.pdf


11.2. REMOVED HARDWARE SUPPORT

This section lists devices (drivers, adapters) that have been removed from RHEL 9.
PCI device IDs are in the format of vendor:device:subvendor:subdevice. If no device ID is listed, all
devices associated with the corresponding driver are unmaintained. To  check the PCI IDs of the
hardware on your system, run the lspci -nn command.

Device ID Driver Device name
Soft-RoCE (rdma_rxe)
HNS-RoCE HNS GE/10GE/25GE/50GE/100GE RDMA Network
Contro
