Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E484F14BB
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Apr 2022 14:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234591AbiDDM3a (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Apr 2022 08:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiDDM33 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Apr 2022 08:29:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A671A3C486;
        Mon,  4 Apr 2022 05:27:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CFBE60F3C;
        Mon,  4 Apr 2022 12:27:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2746FC2BBE4;
        Mon,  4 Apr 2022 12:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649075252;
        bh=yzkDWuKC17uNtASFqSCJrpv5uYa1u8aQ3tUSzblm3Ic=;
        h=From:To:Cc:Subject:Date:From;
        b=QVKhFiSLNV97tPsMKvzn6YR/36kYb4Ibn9fSoaKpNrXb9psBMWnn4c7imyiinPMVF
         CjQ6pokAKV9sV0gl6NuDKMLtc2TliuXyU1s4bRi7Rna/WyoY3c10Oim1VsTKliCdVz
         eKYxmZ/0hviPsLfPnelBpYlSinCTQvRhcXEw7ASZPCPyDCIMhO8V+ZzPUSCLSF8cfA
         TVFeO/bqsPslFdFz4h8FJga/wgn1+pfilcefPnsvQ/V1ozsscxaxkl0PJIS9C0KVtP
         OyLSJfqUurEKvJx5k+g28iWYznFZP3kTl5hXU983K7jyxQinBXGxhSjInlFiljTREJ
         lWEkTZCTMQl1w==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Mark Zhang <markzhang@nvidia.com>,
        Patrisious Haddad <phaddad@nvidia.com>
Subject: [PATCH rdma-next 0/2] Add gratuitous ARP support to RDMA-CM
Date:   Mon,  4 Apr 2022 15:27:25 +0300
Message-Id: <cover.1649075034.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

In this series, Patrisious adds gratuitous ARP support to RDMA-CM, in
order to speed up migration failover from one node to another.

Thanks

Patrisious Haddad (2):
  RDMA/core: Add an rb_tree that stores cm_ids sorted by ifindex and
    remote IP
  RDMA/core: Add a netevent notifier to cma

 drivers/infiniband/core/cma.c      | 260 +++++++++++++++++++++++++++--
 drivers/infiniband/core/cma_priv.h |   1 +
 2 files changed, 249 insertions(+), 12 deletions(-)

-- 
2.35.1

