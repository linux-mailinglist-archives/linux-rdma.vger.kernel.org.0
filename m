Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D56EAA3D62
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Aug 2019 20:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfH3SE1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Aug 2019 14:04:27 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46714 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727246AbfH3SE1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 30 Aug 2019 14:04:27 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7UI3e6s098928;
        Fri, 30 Aug 2019 18:03:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : content-type :
 content-transfer-encoding : mime-version : subject : message-id : date :
 cc : to; s=corp-2019-08-05;
 bh=wBF1jDo/QmeegHS+4zN04JgQxifxNBpBloGoRVNe3i0=;
 b=XLk+/lyXAcisyQVmMbX5jYaqpzSFzlALDkI3hCM2iZICg++0bwquh31hTkTTrWgrYR10
 pevkqLFKUGgh7JTIbF7gsuGWz2XVyXhB16+4TYI+VKGzuO1sK2UcfxjzFlPTeb63go+i
 kLXHZUmGmZ1SBzRqVM1ak2sB54KOfFp4Ul++wolgpxxfnRHOyLZ/kBd4Vo98xe1ghfHq
 Axzk9FqQKHoGIzETPKAp7ZJEUfrAWJiYs06G/x+NEVaWMKk2zO88aBSh8IcBlLLmvN6E
 fEQS8JA4bKZKfYz8OsjDAZtbCdcQ8/0MbkeIgU+6g0pHZsJxRtDhZOkmBA1CpyKxFSUX vg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2uq8nt8148-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Aug 2019 18:03:41 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7UI3dEZ106189;
        Fri, 30 Aug 2019 18:03:40 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2upc8xs0f8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Aug 2019 18:03:39 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7UI3HZw024997;
        Fri, 30 Aug 2019 18:03:18 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 30 Aug 2019 11:03:17 -0700
From:   Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: qedr memory leak report
Message-Id: <93085620-9DAA-47A3-ACE1-932F261674AC@oracle.com>
Date:   Fri, 30 Aug 2019 14:03:16 -0400
Cc:     linux-rdma <linux-rdma@vger.kernel.org>
To:     Michal Kalderon <Michal.Kalderon@cavium.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9365 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908300176
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9365 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908300176
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Michal-

In the middle of some other testing, I got this kmemleak report
while testing with FastLinq cards in iWARP mode:

unreferenced object 0xffff888458923340 (size 32):
  comm "mount.nfs", pid 2294, jiffies 4298338848 (age 1144.337s)
  hex dump (first 32 bytes):
    20 1d 69 63 88 88 ff ff 20 1d 69 63 88 88 ff ff   .ic.... .ic....
    00 60 7a 69 84 88 ff ff 00 60 82 f9 00 00 00 00  .`zi.....`......
  backtrace:
    [<000000000df5bfed>] __kmalloc+0x128/0x176
    [<0000000020724641>] qedr_alloc_pbl_tbl.constprop.44+0x3c/0x121 [qedr]
    [<00000000a361c591>] init_mr_info.constprop.41+0xaf/0x21f [qedr]
    [<00000000e8049714>] qedr_alloc_mr+0x95/0x2c1 [qedr]
    [<000000000e6102bc>] ib_alloc_mr_user+0x31/0x96 [ib_core]
    [<00000000d254a9fb>] frwr_init_mr+0x23/0x121 [rpcrdma]
    [<00000000a0364e35>] rpcrdma_mrs_create+0x45/0xea [rpcrdma]
    [<00000000fd6bf282>] rpcrdma_buffer_create+0x9e/0x1c9 [rpcrdma]
    [<00000000be3a1eba>] xprt_setup_rdma+0x109/0x279 [rpcrdma]
    [<00000000b736b88f>] xprt_create_transport+0x39/0x19a [sunrpc]
    [<000000001024e4dc>] rpc_create+0x118/0x1ab [sunrpc]
    [<00000000cca43a49>] nfs_create_rpc_client+0xf8/0x15f [nfs]
    [<00000000073c962c>] nfs_init_client+0x1a/0x3b [nfs]
    [<00000000b03964c4>] nfs_init_server+0xc1/0x212 [nfs]
    [<000000001c71f609>] nfs_create_server+0x74/0x1a4 [nfs]
    [<000000004dc919a1>] nfs3_create_server+0xb/0x25 [nfsv3]

It's repeated many times.

The workload was an unremarkable software build and regression test
suite on an NFSv3 mount with RDMA.


--
Chuck Lever
