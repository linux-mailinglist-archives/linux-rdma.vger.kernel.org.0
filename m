Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7915440A766
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Sep 2021 09:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240685AbhINHci (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Sep 2021 03:32:38 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:27973 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S240665AbhINHch (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Sep 2021 03:32:37 -0400
IronPort-Data: =?us-ascii?q?A9a23=3AqB1KVKMq/h/lDnDvrR2dlcFynXyQoLVcMsFnjC/?=
 =?us-ascii?q?WdQW81G4g3j0DzmscDTqEPvaOZGX3Kdx1PY2w80IG7ZbTm99gGjLY11k3ESsS9?=
 =?us-ascii?q?pCt6fd1j6vIF3rLaJWFFSqL1u1GAjX7BJ1yHiK0SiuFaOC79CEtjP3QH9IQNca?=
 =?us-ascii?q?fUsxPbV49IMseoUI78wIJqtYAbemRW2thi/uryyHsEAPNNwpPD44hw/nrRCWDE?=
 =?us-ascii?q?xjFkGhwUlQWPZintbJF/pUfJMp3yaqZdxMUTmTId9NWSdovzJnhlo/Y1xwrTN2?=
 =?us-ascii?q?4kLfnaVBMSbnXVeSMoiMOHfH83V4Z/Wpvuko4HKN0hUN/mjyPkMA3ysRlu4GyS?=
 =?us-ascii?q?BsyI+vHn+F1vxxwSngiYfAYp+SYSZS4mYnJp6HcSFP+0vd8HUNsZdVA0ulyCGB?=
 =?us-ascii?q?Ks/cfLVglahGFmvLz2r6+Q8Fyick5asrmJoUSvjdn1z6xJfQpTrjRQqjS6JlT1?=
 =?us-ascii?q?V8NampmdRrFT5NBL2MxM1KbOFsSUmr7wakWxI+A7kQTuRUBwL5NmZcK3g=3D?=
 =?us-ascii?q?=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ApzxWMKtv7tX1z9ITnaSz3hZn7skC5YMji2hC?=
 =?us-ascii?q?6mlwRA09TyXGra6TdaUguiMc1gx8ZJhBo7C90KnpewK7yXdQ2/htAV7EZnibhI?=
 =?us-ascii?q?LIFvAZ0WKG+Vzd8kLFh4tgPMtbAsxD4ZjLfCdHZKXBkXmF+rQbsaG6GcmT7I+0?=
 =?us-ascii?q?pRodLnAJGtJdBkVCe32m+yVNNXh77PECZeOhD6R81l2dkSN9VLXEOpBJZZmOm/?=
 =?us-ascii?q?T70LbdJTIWDR8u7weDyRuu9b7BChCdmjMTSSlGz7sO+XXM11WR3NTsj9iLjjvn?=
 =?us-ascii?q?k0PD5ZVfn9XsjvNFGcy3k8AQbhHhkByhaohNU6CL+Bo1vOaswlA3l8SkmWZuA+?=
 =?us-ascii?q?1Dr1fqOk2lqxrk3AftlB4o9n/Z0FedxUDupMToLQhKQPZptMZ8SF/0+kAgtNZz?=
 =?us-ascii?q?3OZgxGSCradaChvGgWDU+8XIfwsCrDv2nVMS1cooy1BPW4oXb7Fc6aYF+llOLZ?=
 =?us-ascii?q?sGFCXmrKg6DehVCt3G7vo+SyLbU5nghBgr/DWQZAV2Iv/fKXJy/fB9kgIm3UyR?=
 =?us-ascii?q?9nFohvD2xRw7hdQAo5ot3ZWNDk0nrsAWcie6BZgNc9vpevHHf1Aldyi8eV56EW?=
 =?us-ascii?q?6XZp3vBEi936IfwI9Frt1CK6Z4gafbpvz6ISVlXCgJChrTNfE=3D?=
X-IronPort-AV: E=Sophos;i="5.85,292,1624291200"; 
   d="scan'208";a="114456737"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 14 Sep 2021 15:31:18 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 211324D0D9DF;
        Tue, 14 Sep 2021 15:31:15 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 14 Sep 2021 15:31:14 +0800
Received: from Fedora-31.g08.fujitsu.local (10.167.220.99) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 14 Sep 2021 15:31:14 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <zyjzyj2000@gmail.com>, <jgg@ziepe.ca>,
        Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH 0/3] RDMA/rxe: Do some cleanup for macros
Date:   Tue, 14 Sep 2021 16:02:50 +0800
Message-ID: <20210914080253.1145353-1-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 211324D0D9DF.A59FA
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Xiao Yang (3):
  RDMA/rxe: Add new RXE_READ_OR_WRITE_MASK
  RDMA/rxe: Add MASK suffix for RXE_READ_OR_ATOMIC and RXE_WRITE_OR_SEND
  RDMA/rxe: Remove unused WR_READ_WRITE_OR_SEND_MASK

 drivers/infiniband/sw/rxe/rxe_opcode.h | 6 +++---
 drivers/infiniband/sw/rxe/rxe_req.c    | 6 +++---
 drivers/infiniband/sw/rxe/rxe_resp.c   | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

-- 
2.23.0



