Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22FB7F382F
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Nov 2019 20:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbfKGTJP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Nov 2019 14:09:15 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:46606 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbfKGTJP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Nov 2019 14:09:15 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA7Itl88094014;
        Thu, 7 Nov 2019 19:09:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=LozE6g/DQoqMnhpctwaCmcG7qphOA8ZBpRXkP4e3X+I=;
 b=f1CaqqfyJkw/CYnmYGhIwG1X1odrrq86Dt3sAelFcm71j91/Sa+QuUL4GvG6mQwPnzVy
 /b8uOsoCZ8Ln6ct7EdHKlz1UYVMtfzHyHJoPJE8fsQ5+B2FXGU8tgy1pCBxGz0IK+8rp
 sO1anYAFIhfjn5sgCqmFXDM4GTHU+3Zrm1DSemfav5bz4xkQLkDY/goCFIWV47Ed2o/x
 ZkezyQjY//MsqjDRwnP9sLd/p5mS+sq0rAsHymh2co1ZPqBZPxLap+1NfOY8W9Mu0x0/
 8e5NK0cOuBjj+Vx5ht+GTPW/NIDOCnlOSWrIJYgBaUqy6Psl7hJ2Gzi0CU2ekc537hkE uw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2w41w18ebd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Nov 2019 19:09:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA7J8irx084783;
        Thu, 7 Nov 2019 19:09:13 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2w41wfmtxk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Nov 2019 19:09:11 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xA7J8vw7020422;
        Thu, 7 Nov 2019 19:08:57 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 07 Nov 2019 11:08:57 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v4] IB/core: Trace points for diagnosing completion queue
 issues
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20191106201730.GA25804@ziepe.ca>
Date:   Thu, 7 Nov 2019 14:08:56 -0500
Cc:     linux-rdma@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C804F833-C864-44D2-BAA2-0C6164ED6A70@oracle.com>
References: <20191012193714.3336.53797.stgit@manet.1015granger.net>
 <20191106201730.GA25804@ziepe.ca>
To:     Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9434 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911070180
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9434 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911070177
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On Nov 6, 2019, at 3:17 PM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>=20
> On Sat, Oct 12, 2019 at 03:42:56PM -0400, Chuck Lever wrote:
>> +static int __ib_poll_cq(struct ib_cq *cq, int num_entries, struct =
ib_wc *wc)
>> +{
>> +	int rc;
>> +
>> +	rc =3D ib_poll_cq(cq, num_entries, wc);
>> +	trace_cq_poll(cq, num_entries, rc);
>> +	return rc;
>> +}
>=20
> Why not put the trace point in ib_poll_cq directly?

in rdma/ib_verbs.h:

3876 static inline int ib_poll_cq(struct ib_cq *cq, int num_entries,
3877                              struct ib_wc *wc)
3878 {
3879         return cq->device->ops.poll_cq(cq, num_entries, wc);
3880 }

The trace point would have to go in every driver's ->poll_cq.

Putting #include <trace/events/rdma_core.h> in a header could
be a problem. I've found it almost never works well, due to the
extra stuff that is pulled into every source file that would
include rdma/ib_verbs.h.

Note that the use of an indirect call here is also challenging
for adding a kprobe in this path (ie, for eBPF). Maybe a better
approach would be to move ib_poll_cq to drivers/infiniband/core/cq.c
and then add the trace point there?


> What is the overhead of these things if you don't use them?

IIUC, one conditional branch.


--
Chuck Lever



