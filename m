Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7A7DF4E59
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Nov 2019 15:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfKHOle (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Nov 2019 09:41:34 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:55516 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfKHOle (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Nov 2019 09:41:34 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA8Ed0j5060032;
        Fri, 8 Nov 2019 14:41:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=wosJjr7kwe+Pdb8niSUsNB4nrOv/tKKvKse/du+zOOI=;
 b=ordJGzs+5vQE+QtiWZF3HQRVzmXI64QH1xkRwHFbHlJSUBwCo6lLZMa+kma6hFXL0Oy4
 LuNxHmTWhwlNeh4+8mhDgxAFuBtY4OYcmygPOuaArYYfS6jSw7GXlhdaFU56NaOCDYKH
 DF4JRg3osAXIBXHaWEgK9x+ehAe5sPE+JI7iUf0rCPQrBM1sJjkLo0Qcpx9pJJLHE6Zn
 TckmfTHMyu07R5OLGL2+eGeGlX85ScJNJ69tHeNiBOXODyOnPY3/EtaiZWZPgpHdlGph
 ZOgfC5UbkdT0lfhO6H/A5g7hVG9zCnmlpqF7QXSErneCnwS05txfxBxWYFxFmbYhirSz 5w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2w41w1dr1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Nov 2019 14:41:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA8EdEKR116555;
        Fri, 8 Nov 2019 14:41:32 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2w41wcwfyb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Nov 2019 14:41:32 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA8EfSCE000361;
        Fri, 8 Nov 2019 14:41:28 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 08 Nov 2019 06:41:28 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v5] IB/core: Trace points for diagnosing completion queue
 issues
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20191108142157.GB10956@ziepe.ca>
Date:   Fri, 8 Nov 2019 09:41:27 -0500
Cc:     linux-rdma@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <533870DD-41E0-41F9-8553-5E84DBDE4EC2@oracle.com>
References: <20191107205239.23193.69879.stgit@manet.1015granger.net>
 <20191108142157.GB10956@ziepe.ca>
To:     Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9434 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911080147
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9434 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911080147
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On Nov 8, 2019, at 9:21 AM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>=20
> On Thu, Nov 07, 2019 at 03:54:34PM -0500, Chuck Lever wrote:
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> Reviewed-by: Parav Pandit <parav@mellanox.com>
>> drivers/infiniband/core/Makefile |    2=20
>> drivers/infiniband/core/cq.c     |   36 +++++
>> drivers/infiniband/core/trace.c  |   14 ++
>> include/rdma/ib_verbs.h          |   11 +-
>> include/trace/events/rdma_core.h |  251 =
++++++++++++++++++++++++++++++++++++++
>> 5 files changed, 307 insertions(+), 7 deletions(-)
>> create mode 100644 drivers/infiniband/core/trace.c
>> create mode 100644 include/trace/events/rdma_core.h
>>=20
>> Changes since v4:
>> - Removed __ib_poll_cq, uninlined ib_poll_cq
>=20
> Oh I don't think uninlining is such a good idea, isn't this rather
> performance sensitive?

So would you rather go with v4?

Not clear to me that the compiler won't do the right thing,
at least for __ib_process_cq.


--
Chuck Lever



