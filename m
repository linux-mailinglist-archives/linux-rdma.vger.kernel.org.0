Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F392B1247F3
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Dec 2019 14:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfLRNUe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Dec 2019 08:20:34 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:44036 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfLRNUd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Dec 2019 08:20:33 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBIDJh4E186050;
        Wed, 18 Dec 2019 13:20:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=T1eN6g76Nofqg7/+9cMLu6MKDa5OeoZCrkArgIczePE=;
 b=pEwhPcYZ/T9H76SqW6nW7LXZTkZxdQ7jxEhJ54fG1Q5DWRR9gELvw88n1b0UShJCio5A
 dw0iQrSOthNUqKPNvXbmR/tJhE+p4rvXVSQ1FZ14VQ7tiEEIS/Ksvr1EfOu5+fxshFcH
 qoeQXtQoqNW8mrsSQm3GbEdIjUFJIaflGg9H/BSh74+ykmaCzoXbT9GL/hrLSeTFOn19
 tOTJSVizn7rZvbuCygb30WAvSraxxPpKo5oZjhCeE4tAC35o7e/LVO4lqN4en+i0UJGF
 Ijh/QgsYeOOyUpBLyPuB0ZBg6rj0xaItoZFb2IjmPoHuagqlqWkPHHl9sHjNubf8DGnH QA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2wvqpqdhv3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Dec 2019 13:20:25 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBIDJsaN113168;
        Wed, 18 Dec 2019 13:20:24 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2wxm77yayn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Dec 2019 13:20:24 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBIDKLJS020367;
        Wed, 18 Dec 2019 13:20:21 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 18 Dec 2019 05:20:21 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v9 0/3] Proposed trace points for RDMA/core
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20191218053644.GJ66555@unreal>
Date:   Wed, 18 Dec 2019 08:20:20 -0500
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FFC65516-E488-472C-90EA-DBE54BE341C8@oracle.com>
References: <20191216154924.21101.64860.stgit@manet.1015granger.net>
 <20191218002214.GL16762@mellanox.com> <20191218053644.GJ66555@unreal>
To:     Leon Romanovsky <leon@kernel.org>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9474 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912180110
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9474 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912180110
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On Dec 18, 2019, at 12:36 AM, Leon Romanovsky <leon@kernel.org> wrote:
>=20
> On Wed, Dec 18, 2019 at 12:22:19AM +0000, Jason Gunthorpe wrote:
>> On Mon, Dec 16, 2019 at 10:53:43AM -0500, Chuck Lever wrote:
>>> Hey y'all-
>>>=20
>>> Refresh of the RDMA/core trace point patches. Anything else needed
>>> before these are acceptable?
>>=20
>> Can Leon compile and run it yet?
>=20
> Nope, it is enough to apply first patch to see compilation error.

I've never seen that here. There is another report of this problem
with an earlier version of the series, so I thought it had been
resolved.

I'll look into it.


> _  kernel git:(rdma-next) _ git am --continue
> Applying: RDMA/cma: Add trace points in RDMA Connection Manager
> _  kernel git:(rdma-next) mkt build
> Start kernel compilation in silent mode
> In file included from drivers/infiniband/core/cma_trace.h:391,
>                 from drivers/infiniband/core/cma_trace.c:16:
> ./include/trace/define_trace.h:95:42: fatal error: ./cma_trace.h: No =
such file or directory
>   95 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
>      |                                          ^
> compilation terminated.
> make[3]: *** [scripts/Makefile.build:266: =
drivers/infiniband/core/cma_trace.o] Error 1
> make[3]: *** Waiting for unfinished jobs....
> make[2]: *** [scripts/Makefile.build:503: drivers/infiniband/core] =
Error 2
> make[1]: *** [scripts/Makefile.build:503: drivers/infiniband] Error 2
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1692: drivers] Error 2
>=20
>>=20
>> Jason

--
Chuck Lever



