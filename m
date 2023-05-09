Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD2D6FC98C
	for <lists+linux-rdma@lfdr.de>; Tue,  9 May 2023 16:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235963AbjEIOwb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 May 2023 10:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235952AbjEIOwa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 9 May 2023 10:52:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDFF359A
        for <linux-rdma@vger.kernel.org>; Tue,  9 May 2023 07:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683643900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6DT17VXXztLjAT+pRHoLv7g4ckkPiKxswurFhFqxSXw=;
        b=QDkL49kxZu93vgtH5smJHg2pN30tjJTNCMtT3MI4jySiTLmSNsgvQ2YmyWOZ+QWMxuewQu
        tOgNyUNvZZSr2qoMfTHO0UdQLf+2iRPtx98LZiltQWW60anYwkHL6jCt36yjuy1MbrSCNi
        ZVMypoMX7qCpFaKHNk2dWDfHn9MyqqA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-169-zhpLfPgQNr2IJ4y7PvPgSw-1; Tue, 09 May 2023 10:51:34 -0400
X-MC-Unique: zhpLfPgQNr2IJ4y7PvPgSw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8CC842823824;
        Tue,  9 May 2023 14:51:33 +0000 (UTC)
Received: from fedora-x1.redhat.com (unknown [10.22.33.230])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1F08C40C6E6B;
        Tue,  9 May 2023 14:51:33 +0000 (UTC)
From:   Kamal Heib <kheib@redhat.com>
To:     linux-rdma@vger.kernel.org
Cc:     Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Kamal Heib <kheib@redhat.com>
Subject: [PATCH 0/3] RDMA/iRDMA: Cleanups and improvements
Date:   Tue,  9 May 2023 10:51:24 -0400
Message-Id: <20230509145127.33734-1-kheib@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series includes a few cleanup patches for the iRDMA driver.

Kamal Heib (3):
  RDMA/iRDMA: Return void from irdma_init_iw_device()
  RDMA/iRDMA: Return void from irdma_init_rdma_device()
  RDMA/iRDMA: Move iw device ops initialization

 drivers/infiniband/hw/irdma/verbs.c | 35 +++++++++++------------------
 1 file changed, 13 insertions(+), 22 deletions(-)

-- 
2.40.1

