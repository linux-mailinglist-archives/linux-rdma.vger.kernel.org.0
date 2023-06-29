Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93DC074293E
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jun 2023 17:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjF2PQ3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Jun 2023 11:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbjF2PQ2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Jun 2023 11:16:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDB630E6
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jun 2023 08:16:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5DD86156C
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jun 2023 15:16:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3133C433C8;
        Thu, 29 Jun 2023 15:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688051786;
        bh=OEShT14hBDXo7kUhTzk1OzPTHJ4jr4r8iNGWOLxFx9g=;
        h=Subject:From:To:Cc:Date:From;
        b=irvhG/SB3+0eg6tNEu+nGh4jfDAW1MOmcgnfz9lrghygH7QkOwU5G2u3FzRYp48c5
         fNhB/Dk8+ZsedfGsFtp5o6LV5376mltmAIW8fF64IbicEuRnaC34Jyr4sm1aho1/xp
         3Zq8xLSwYxo1sA4SyKjvvv+Izy06EiRN83uzszZTOOsz9fFphCAEmlRDekTKzvsPH6
         0prvPV5JKuIaVS9wBj4jGUKTh6JqVifB0UY5TLIVW5zOmICqyKIJpWN/FtDalk3eCH
         IUJ/PbbyNjBginoFgkR0eG/qP9CSC5kyeibuooE//c1NhwdiQsbblJH5K4ffG3YM3p
         t2pNIVZr/+4Hg==
Subject: [PATCH v5 0/4] Handle ARPHRD_NONE devices for siw
From:   Chuck Lever <cel@kernel.org>
To:     jgg@nvidia.com
Cc:     Bernard Metzler <bmt@zurich.ibm.com>, Tom Talpey <tom@talpey.com>,
        Chuck Lever <chuck.lever@oracle.com>, tom@talpey.com,
        BMT@zurich.ibm.com, linux-rdma@vger.kernel.org,
        yanjun.zhu@linux.dev
Date:   Thu, 29 Jun 2023 11:16:24 -0400
Message-ID: <168805171754.164730.1318944278265675377.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Here's a series that implements support for siw on tunnel devices,
based on suggestions from Jason Gunthorpe and Tom Talpey.

This series does not address a similar issue with rxe because RoCE
GID resolution behaves differently than it does for iWARP devices.
An independent solution is likely to be required for rxe.

Changes since v4:
- Address review comments from Tom Talpey

Changes since v3:
- Clean up RCU dereference in cma_validate_port()

Changes since v2:
- Split into multiple patches
- Pre-initialize gid_attr::ndev for iWARP devices

---

Chuck Lever (4):
      RDMA/siw: Fabricate a GID on tun and loopback devices
      RDMA/core: Set gid_attr.ndev for iWARP devices
      RDMA/cma: Deduplicate error flow in cma_validate_port()
      RDMA/cma: Avoid GID lookups on iWARP devices


 drivers/infiniband/core/cache.c       | 11 +++++++++++
 drivers/infiniband/core/cma.c         | 26 +++++++++++++++++++++-----
 drivers/infiniband/sw/siw/siw.h       |  1 +
 drivers/infiniband/sw/siw/siw_main.c  | 22 ++++++++--------------
 drivers/infiniband/sw/siw/siw_verbs.c |  4 ++--
 5 files changed, 43 insertions(+), 21 deletions(-)

--
Chuck Lever

