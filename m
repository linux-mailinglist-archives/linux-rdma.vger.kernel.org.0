Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038AD4FBFBF
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Apr 2022 17:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347423AbiDKPDF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 Apr 2022 11:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347703AbiDKPDC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 Apr 2022 11:03:02 -0400
X-Greylist: delayed 417 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 11 Apr 2022 08:00:47 PDT
Received: from gentwo.de (gentwo.de [IPv6:2a02:c206:2048:5042::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1691F60C
        for <linux-rdma@vger.kernel.org>; Mon, 11 Apr 2022 08:00:46 -0700 (PDT)
Received: by gentwo.de (Postfix, from userid 1001)
        id 727A8B00275; Mon, 11 Apr 2022 16:53:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 70E6CB0023D;
        Mon, 11 Apr 2022 16:53:46 +0200 (CEST)
Date:   Mon, 11 Apr 2022 16:53:46 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.org>
X-X-Sender: cl@gentwo.de
To:     Selvin Xavier <selvin.xavier@broadcom.com>
cc:     Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        linux-rdma@vger.kernel.org
Subject: ROCE multicast support in BNXT driver
Message-ID: <alpine.DEB.2.22.394.2204111648420.202521@gentwo.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

We bought some of those NICs from Broadcom but were disappointed when we
discoverd that they do not support ROCE multicast.

linux/drivers/infiniband/hw/bnxt_re/ib_verbs.c sets

ib->attr->max_mcast_grp = 0

ROCE uses the IGMP logic in the kernel. So I guess there is a limited
amount of things that the NIC needs to do like passing the messages
to the correct QP.

The spec says that multicast replication is supported for other protocols.
Why not ROCE?


Would it be possible to implement multicast somehow in the driver?

