Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66440131779
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jan 2020 19:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgAFS3j (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jan 2020 13:29:39 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:38240 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgAFS3j (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Jan 2020 13:29:39 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 006IJoNQ027166;
        Mon, 6 Jan 2020 18:29:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=WT/bqZ0mVYvy9jSBIkR2+7A4aLK0ICwvg2gt+z3FX5A=;
 b=f1iUxTC+tXRXmzdFq+OJn34K1++5rHOK4x/i+ipypO53SicbbVZfosFNEMOa55KUuhhW
 o7tlc030s47mLhj010geHTuBya7cKOZI2Ypmqdq+cxjc14tNBD+Sxi0zigdGmUIpX9lB
 Sw59uI9Ofeg0+yFkDdCk5VoG6LsH7CS43arwxtHNk/FCH5CK4MjVcWiawfpjjfBgOo1p
 fVYooM27B8ptEMwm0DdzErUm5QOU7k1kxC2ZfgxSoNSDjBRJMCn46DGWDx2PHQUkOsbP
 G6HH1pH2RBtLjUvxMW6u9AAgI2gJLrtuXoN5GQom0RGCJufXfPx0cw/hK3QZbsTdJMR+ 6g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2xajnpruv3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jan 2020 18:29:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 006ITDtA030359;
        Mon, 6 Jan 2020 18:29:32 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2xb4675y0n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jan 2020 18:29:28 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 006IShMF031096;
        Mon, 6 Jan 2020 18:28:43 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 06 Jan 2020 10:28:42 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v10 0/3] Proposed trace points for RDMA/core
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20191218201631.30584.53987.stgit@manet.1015granger.net>
Date:   Mon, 6 Jan 2020 13:28:41 -0500
Cc:     linux-rdma@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <94A656F2-577A-48A5-B845-568A10D30FCA@oracle.com>
References: <20191218201631.30584.53987.stgit@manet.1015granger.net>
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9492 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001060153
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9492 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001060152
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On Dec 18, 2019, at 3:18 PM, Chuck Lever <chuck.lever@oracle.com> =
wrote:
>=20
> Hey y'all-
>=20
> Refresh of the RDMA/core trace point patches.

<ping>


> Changes since v9:
> - One-line Makefile fix to ensure patch 1/3 compiles
>=20
> Changes since v8:
> - Merged up to v5.5-rc2
> - Added trace points to record lifetime of rdma_cm_id's QP
> - Added trace points in the "drain QP" path
> - Various other clean-ups
>=20
> Changes since v7:
> - Capture the return value from the ULP's CM event handler
> - Record the lifetime of each rdma_cm_id
> - Include an example patch for capturing MR lifetime
>=20
> Changes since v6:
> - Move include/trace/events/rmda_cma.h to =
drivers/infiniband/core/cma_trace.h
> - Add sample trace log output to the patch descriptions
> - Back to the inlined version of ib_poll_cq()
>=20
> Changes since v5:
> - Add low-overhead trace points in the Connection Manager
> - Address #include heartburn found by lkp
>=20
> Changes since v4:
> - Removed __ib_poll_cq, uninlined ib_poll_cq
>=20
> Changes since v3:
> - Reverted unnecessary behavior change in __ib_process_cq
> - Clarified what "id" is in trace point output
> - Added comment before new fields in struct ib_cq
> - New trace point that fires when there is a CQ allocation failure
>=20
> Changes since v2:
> - Removed extraneous changes to include/trace/events/rdma.h
>=20
> Changes since RFC:
> - Display CQ's global resource ID instead of it's pointer address
>=20
> ---
>=20
> Chuck Lever (3):
>      RDMA/cma: Add trace points in RDMA Connection Manager
>      RDMA/core: Trace points for diagnosing completion queue issues
>      RDMA/core: Add trace points to follow MR allocation
>=20
>=20
> drivers/infiniband/core/Makefile    |    6 -
> drivers/infiniband/core/cma.c       |   88 ++++++--
> drivers/infiniband/core/cma_trace.c |   16 +
> drivers/infiniband/core/cma_trace.h |  391 =
+++++++++++++++++++++++++++++++++++
> drivers/infiniband/core/cq.c        |   27 ++
> drivers/infiniband/core/trace.c     |   14 +
> drivers/infiniband/core/verbs.c     |   43 +++-
> include/rdma/ib_verbs.h             |    5=20
> include/trace/events/rdma_core.h    |  394 =
+++++++++++++++++++++++++++++++++++
> 9 files changed, 946 insertions(+), 38 deletions(-)
> create mode 100644 drivers/infiniband/core/cma_trace.c
> create mode 100644 drivers/infiniband/core/cma_trace.h
> create mode 100644 drivers/infiniband/core/trace.c
> create mode 100644 include/trace/events/rdma_core.h
>=20
> --
> Chuck Lever

--
Chuck Lever



