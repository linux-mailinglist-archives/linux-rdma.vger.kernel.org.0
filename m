Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12FA75CB2A
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jul 2023 17:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbjGUPNy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Jul 2023 11:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbjGUPNv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Jul 2023 11:13:51 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5A530E3;
        Fri, 21 Jul 2023 08:13:43 -0700 (PDT)
Received: from tp-owlcat.intra.ispras.ru (unknown [10.10.165.6])
        by mail.ispras.ru (Postfix) with ESMTPSA id 48BD440B27AC;
        Fri, 21 Jul 2023 15:05:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 48BD440B27AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1689951956;
        bh=XTwyWVZFfamFmp6s8GAMDD3q7CDQ92gXY7bdsxBiQgM=;
        h=From:To:Cc:Subject:Date:From;
        b=PLyJJ0OYyZKy8MvMZvxtAZQIuGtOWU6a3m58PwuMkGqtDcQtYLfrI34fNN4pqgP4X
         WqQdOKEBzerD3zpShixEKvc0xcFqmga7zPBogZy94XzlgHDoAJcvuKxhlj3ivoryvx
         dWHNOzmCmsYq54vPJ0wkJjqEgWf79FciN8oQ++y4=
From:   Anton Gusev <aagusev@ispras.ru>
To:     stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Anton Gusev <aagusev@ispras.ru>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Mark Zhang <markzhang@nvidia.com>,
        =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
        Michael Guralnik <michaelgur@nvidia.com>,
        Roland Dreier <rolandd@cisco.com>,
        Sean Hefty <sean.hefty@intel.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: [PATCH 5.10 0/1] RDMA/cma: Ensure rdma_addr_cancel() happens before issuing more requests
Date:   Fri, 21 Jul 2023 18:05:32 +0300
Message-ID: <20230721150535.191318-1-aagusev@ispras.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Syzkaller reports use-after-free at addr_handler in 5.10 stable
releases. The problem was fixed in upstream and backported into
5.14, but wasn't applied to 5.10 and lower versions due to a small
merge conflict.

This patch is a modified version that can be cleanly applied to 5.10 and
5.4 stable branches.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
