Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB0AFEA3B
	for <lists+linux-rdma@lfdr.de>; Sat, 16 Nov 2019 03:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbfKPCUZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 15 Nov 2019 21:20:25 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:53416 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727275AbfKPCUY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 15 Nov 2019 21:20:24 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 45C225AD5C08DE88A2AA
        for <linux-rdma@vger.kernel.org>; Sat, 16 Nov 2019 10:20:22 +0800 (CST)
Received: from [127.0.0.1] (10.61.25.96) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Sat, 16 Nov 2019
 10:20:20 +0800
From:   oulijun <oulijun@huawei.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     linux-rdma <linux-rdma@vger.kernel.org>
Subject: =?UTF-8?B?44CQaW5maW5pYmFuZF9kaWFncyB0b29sIHF1ZXN0aW9u44CR?=
Message-ID: <eca1607e-5c25-f816-9325-281b6a2d0069@huawei.com>
Date:   Sat, 16 Nov 2019 10:20:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.61.25.96]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi, Jason Gunthorpe
    I have noticed that you have integrated infiniband_diags in the new rdma-core repo.
I want to try to using it in RoCE. it is fail. the print as flows:
roo
root@(none)# ./ibaddr -g 0
 ibwarn: [1054] mad_rpc_open_port: client_register for mgmt 1 failed
  Failed to open (null) port 0

I found through process analysis that it needs ca to support IB_QPT_SMI.
I understand that if hca does not support SMI, then we will not be able to use infiniband_diags tool?

Thanks
Lijun Ou

