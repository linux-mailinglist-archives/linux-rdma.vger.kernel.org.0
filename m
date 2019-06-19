Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79DD04B4FD
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2019 11:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbfFSJdo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jun 2019 05:33:44 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47924 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbfFSJdo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Jun 2019 05:33:44 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5J9SWjD181012
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jun 2019 09:33:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=Ud2kMJ+Ya7jvDD9pu3ZrNkRyEXeaSCDAQmzUURjGxaM=;
 b=Te4eIKh5X4KKbWz2p9eHMlsPwITqrKkzV3Xs7iftfama7HbjNKOiXmG3R0ID73gWUWqD
 8sQlDlY3B1FTbKrfLf411CGTDb+GfVckFNNbBNXVCqzZr4RiE+iQWL653+6FWyTdfe3n
 4ZUhLnDc+IejcgdwrmwGpERKPla+6KNXnf35dztt/jJbhm80YzxUIxJ6FxCse8j1CbVQ
 R9NZTb4mHGOdz7G86LZub650z8rH0HuB1tG6f4ULGBU2CxiQu4VukGzROWx4RkX899fc
 1SbAGqNV6xxbMMo+fCO4VD6KCB+MJtLE1yWT/ezVzheRk1DG4jfVg8ZKCZeHiecXjYgX HA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2t7809aajb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jun 2019 09:33:42 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5J9XDk7143075
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jun 2019 09:33:42 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2t77yn7x87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jun 2019 09:33:41 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5J9XfHs007234
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jun 2019 09:33:41 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 Jun 2019 02:33:41 -0700
Date:   Wed, 19 Jun 2019 12:33:35 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [bug report] IB/rdmavt: Add completion queue functions
Message-ID: <20190619093335.GA24201@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=838
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906190078
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=884 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906190078
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello Shamir Rabinovitch,

The patch ff23dfa13457: ("IB: Pass only ib_udata in function prototypes")
leads to the following static checker warning:

	drivers/infiniband/sw/rdmavt/cq.c:273 rvt_create_cq()
	error: 'cq->ip' dereferencing possible ERR_PTR()

drivers/infiniband/sw/rdmavt/cq.c
   217          /*
   218           * Return the address of the WC as the offset to mmap.
   219           * See rvt_mmap() for details.
   220           */
   221          if (udata && udata->outlen >= sizeof(__u64)) {
   222                  cq->ip = rvt_create_mmap_info(rdi, sz, udata, wc);

This warning is a false positive which is kind of involved to explain.
This function returns a mix of error pointers and NULL.  Smatch parses
correctly so it knows that "cq->ip" isn't an error pointer here.  But
really it shouldn't return error pointers.

When a function returns error pointers and NULL the NULL return should
be treated as a special success case.  For example, we could say
"p = get_some_feature();"  If it get_some_feature() returns an error
pointer that means kmalloc() failed or whatever, but if it returns a
NULL that means the feature is disabled.

   223                  if (!cq->ip) {
   224                          err = -ENOMEM;
   225                          goto bail_wc;
   226                  }
   227  
   228                  err = ib_copy_to_udata(udata, &cq->ip->offset,
   229                                         sizeof(cq->ip->offset));
   230                  if (err)
   231                          goto bail_ip;
   232          }

regards,
dan carpenter
