Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F02E8A3E6
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2019 19:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfHLQ7y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Aug 2019 12:59:54 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:54143 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726548AbfHLQ7x (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Aug 2019 12:59:53 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from haimbo@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 12 Aug 2019 19:59:51 +0300
Received: from r-ufm115.mtr.labs.mlnx (r-ufm115.mtr.labs.mlnx [10.209.36.210])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x7CGxpFw002663;
        Mon, 12 Aug 2019 19:59:51 +0300
Received: from r-ufm115.mtr.labs.mlnx (localhost [127.0.0.1])
        by r-ufm115.mtr.labs.mlnx (8.14.7/8.14.7) with ESMTP id x7CGxpDY024844;
        Mon, 12 Aug 2019 16:59:51 GMT
Received: (from haimbo@localhost)
        by r-ufm115.mtr.labs.mlnx (8.14.7/8.14.7/Submit) id x7CGxpsA024843;
        Mon, 12 Aug 2019 16:59:51 GMT
From:   Haim Boozaglo <haimbo@mellanox.com>
To:     linux-rdma@vger.kernel.org
Cc:     Haim Boozaglo <haimbo@mellanox.com>
Subject: [PATCH rdma-core 0/1] Support 128 IB devices
Date:   Mon, 12 Aug 2019 16:59:47 +0000
Message-Id: <1565629188-24799-1-git-send-email-haimbo@mellanox.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series extend the maximum of available InfiniBand devices
to 128.

Thanks

Haim Boozaglo (1):
  libibumad: Support 128 devices

 libibumad/umad.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
1.8.3.1

