Return-Path: <linux-rdma+bounces-505-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EAD81FD64
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Dec 2023 07:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 408601F21C59
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Dec 2023 06:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADA38F4B;
	Fri, 29 Dec 2023 06:56:39 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3268BE7;
	Fri, 29 Dec 2023 06:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4T1bfX2kvnz1FFVw;
	Fri, 29 Dec 2023 14:52:36 +0800 (CST)
Received: from kwepemi500006.china.huawei.com (unknown [7.221.188.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 9DB7D1400D6;
	Fri, 29 Dec 2023 14:56:29 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 29 Dec 2023 14:56:29 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>, <dsahern@gmail.com>,
	<stephen@networkplumber.org>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
	<huangjunxian6@hisilicon.com>
Subject: [PATCH iproute2-rc 1/2] rdma: Fix core dump when pretty is used
Date: Fri, 29 Dec 2023 14:52:40 +0800
Message-ID: <20231229065241.554726-2-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20231229065241.554726-1-huangjunxian6@hisilicon.com>
References: <20231229065241.554726-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500006.china.huawei.com (7.221.188.68)

From: Chengchang Tang <tangchengchang@huawei.com>

There will be a core dump when pretty is used as the JSON object
hasn't been opened and closed properly.

Before:
$ rdma res show qp -jp -dd
[ {
    "ifindex": 1,
    "ifname": "hns_1",
    "port": 1,
    "lqpn": 1,
    "type": "GSI",
    "state": "RTS",
    "sq-psn": 0,
    "comm": "ib_core"
},
"drv_sq_wqe_cnt": 128,
"drv_sq_max_gs": 2,
"drv_rq_wqe_cnt": 512,
"drv_rq_max_gs": 1,
rdma: json_writer.c:130: jsonw_end: Assertion `self->depth > 0' failed.
Aborted (core dumped)

After:
$ rdma res show qp -jp -dd
[ {
        "ifindex": 2,
        "ifname": "hns_2",
        "port": 1,
        "lqpn": 1,
        "type": "GSI",
        "state": "RTS",
        "sq-psn": 0,
        "comm": "ib_core",{
            "drv_sq_wqe_cnt": 128,
            "drv_sq_max_gs": 2,
            "drv_rq_wqe_cnt": 512,
            "drv_rq_max_gs": 1,
            "drv_ext_sge_sge_cnt": 256
        }
    } ]

Fixes: 331152752a97 ("rdma: print driver resource attributes")
Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 rdma/utils.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/rdma/utils.c b/rdma/utils.c
index 09985069..dcf24337 100644
--- a/rdma/utils.c
+++ b/rdma/utils.c
@@ -926,7 +926,7 @@ void print_driver_table(struct rd *rd, struct nlattr *tb)
 		return;
 
 	if (rd->pretty_output)
-		newline_indent(rd);
+		open_json_object(NULL);
 
 	/*
 	 * Driver attrs are tuples of {key, [print-type], value}.
@@ -960,5 +960,9 @@ void print_driver_table(struct rd *rd, struct nlattr *tb)
 			key = NULL;
 		}
 	}
+
+	if (rd->pretty_output)
+		newline_indent(rd);
+
 	return;
 }
-- 
2.30.0


