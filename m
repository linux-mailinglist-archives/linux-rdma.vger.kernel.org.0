Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29535C32C6
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Oct 2019 13:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732555AbfJALkI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 1 Oct 2019 07:40:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35168 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387409AbfJALkG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Oct 2019 07:40:06 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x91BdGlh022708
        for <linux-rdma@vger.kernel.org>; Tue, 1 Oct 2019 07:40:05 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.75])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vc3kew99u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 01 Oct 2019 07:40:05 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 1 Oct 2019 11:40:04 -0000
Received: from us1a3-smtp03.a3.dal06.isc4sb.com (10.106.154.98)
        by smtp.notes.na.collabserv.com (10.106.227.123) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 1 Oct 2019 11:39:55 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp03.a3.dal06.isc4sb.com
          with ESMTP id 2019100111395464-438143 ;
          Tue, 1 Oct 2019 11:39:54 +0000 
In-Reply-To: <20190930231707.48259-4-bvanassche@acm.org>
Subject: Re: [PATCH 03/15] RDMA/siw: Simplify several debug messages
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Bart Van Assche" <bvanassche@acm.org>
Cc:     "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Leon Romanovsky" <leonro@mellanox.com>,
        "Doug Ledford" <dledford@redhat.com>, linux-rdma@vger.kernel.org
Date:   Tue, 1 Oct 2019 11:39:54 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190930231707.48259-4-bvanassche@acm.org>,<20190930231707.48259-1-bvanassche@acm.org>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP57 August 05, 2019 at 12:42
X-LLNOutbound: False
X-Disclaimed: 8927
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19100111-6875-0000-0000-0000008DD5C4
X-IBM-SpamModules-Scores: BY=0.021109; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.029637
X-IBM-SpamModules-Versions: BY=3.00011870; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000292; SDB=6.01269146; UDB=6.00671686; IPR=6.01051172;
 MB=3.00028898; MTD=3.00000008; XFM=3.00000015; UTC=2019-10-01 11:40:02
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-10-01 11:19:46 - 6.00010474
x-cbparentid: 19100111-6876-0000-0000-000000D4264E
Message-Id: <OF073BA5F3.9EA2563D-ON00258486.004013F1-00258486.004013F8@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-01_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Bart Van Assche" <bvanassche@acm.org> wrote: -----

>To: "Jason Gunthorpe" <jgg@ziepe.ca>
>From: "Bart Van Assche" <bvanassche@acm.org>
>Date: 10/01/2019 01:17AM
>Cc: "Leon Romanovsky" <leonro@mellanox.com>, "Doug Ledford"
><dledford@redhat.com>, linux-rdma@vger.kernel.org, "Bart Van Assche"
><bvanassche@acm.org>, "Bernard Metzler" <bmt@zurich.ibm.com>
>Subject: [EXTERNAL] [PATCH 03/15] RDMA/siw: Simplify several debug
>messages
>
>Do not print the remote address if it is not used. Use %pISp instead
>of %pI4 %d.
>
>Cc: Bernard Metzler <bmt@zurich.ibm.com>
>Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>---
> drivers/infiniband/sw/siw/siw_cm.c | 36
>++++++------------------------
> 1 file changed, 7 insertions(+), 29 deletions(-)
>
>diff --git a/drivers/infiniband/sw/siw/siw_cm.c
>b/drivers/infiniband/sw/siw/siw_cm.c
>index 8c1931a57f4a..5a75deb9870b 100644
>--- a/drivers/infiniband/sw/siw/siw_cm.c
>+++ b/drivers/infiniband/sw/siw/siw_cm.c
>@@ -1373,22 +1373,8 @@ int siw_connect(struct iw_cm_id *id, struct
>iw_cm_conn_param *params)
> 		rv = -EINVAL;
> 		goto error;
> 	}
>-	if (v4)
>-		siw_dbg_qp(qp,
>-			   "pd_len %d, laddr %pI4 %d, raddr %pI4 %d\n",
>-			   pd_len,
>-			   &((struct sockaddr_in *)(laddr))->sin_addr,
>-			   ntohs(((struct sockaddr_in *)(laddr))->sin_port),
>-			   &((struct sockaddr_in *)(raddr))->sin_addr,
>-			   ntohs(((struct sockaddr_in *)(raddr))->sin_port));
>-	else
>-		siw_dbg_qp(qp,
>-			   "pd_len %d, laddr %pI6 %d, raddr %pI6 %d\n",
>-			   pd_len,
>-			   &((struct sockaddr_in6 *)(laddr))->sin6_addr,
>-			   ntohs(((struct sockaddr_in6 *)(laddr))->sin6_port),
>-			   &((struct sockaddr_in6 *)(raddr))->sin6_addr,
>-			   ntohs(((struct sockaddr_in6 *)(raddr))->sin6_port));
>+	siw_dbg_qp(qp, "pd_len %d, laddr %pISp, raddr %pISp\n", pd_len,
>laddr,
>+		   raddr);
> 
> 	rv = sock_create(v4 ? AF_INET : AF_INET6, SOCK_STREAM, IPPROTO_TCP,
>&s);
> 	if (rv < 0)
>@@ -1935,7 +1921,7 @@ static void siw_drop_listeners(struct iw_cm_id
>*id)
> /*
>  * siw_create_listen - Create resources for a listener's IWCM ID @id
>  *
>- * Listens on the socket addresses id->local_addr and
>id->remote_addr.
>+ * Listens on the socket address id->local_addr.
>  *
>  * If the listener's @id provides a specific local IP address, at
>most one
>  * listening socket is created and associated with @id.
>@@ -1959,7 +1945,7 @@ int siw_create_listen(struct iw_cm_id *id, int
>backlog)
> 	 */
> 	if (id->local_addr.ss_family == AF_INET) {
> 		struct in_device *in_dev = in_dev_get(dev);
>-		struct sockaddr_in s_laddr, *s_raddr;
>+		struct sockaddr_in s_laddr;
> 		const struct in_ifaddr *ifa;
> 
> 		if (!in_dev) {
>@@ -1967,12 +1953,8 @@ int siw_create_listen(struct iw_cm_id *id, int
>backlog)
> 			goto out;
> 		}
> 		memcpy(&s_laddr, &id->local_addr, sizeof(s_laddr));
>-		s_raddr = (struct sockaddr_in *)&id->remote_addr;
> 
>-		siw_dbg(id->device,
>-			"laddr %pI4:%d, raddr %pI4:%d\n",
>-			&s_laddr.sin_addr, ntohs(s_laddr.sin_port),
>-			&s_raddr->sin_addr, ntohs(s_raddr->sin_port));
>+		siw_dbg(id->device, "laddr %pISp\n", &s_laddr);
> 
> 		rtnl_lock();
> 		in_dev_for_each_ifa_rtnl(ifa, in_dev) {
>@@ -1992,17 +1974,13 @@ int siw_create_listen(struct iw_cm_id *id,
>int backlog)
> 	} else if (id->local_addr.ss_family == AF_INET6) {
> 		struct inet6_dev *in6_dev = in6_dev_get(dev);
> 		struct inet6_ifaddr *ifp;
>-		struct sockaddr_in6 *s_laddr = &to_sockaddr_in6(id->local_addr),
>-			*s_raddr = &to_sockaddr_in6(id->remote_addr);
>+		struct sockaddr_in6 *s_laddr = &to_sockaddr_in6(id->local_addr);
> 
> 		if (!in6_dev) {
> 			rv = -ENODEV;
> 			goto out;
> 		}
>-		siw_dbg(id->device,
>-			"laddr %pI6:%d, raddr %pI6:%d\n",
>-			&s_laddr->sin6_addr, ntohs(s_laddr->sin6_port),
>-			&s_raddr->sin6_addr, ntohs(s_raddr->sin6_port));
>+		siw_dbg(id->device, "laddr %pISp\n", &s_laddr);
> 
> 		rtnl_lock();
> 		list_for_each_entry(ifp, &in6_dev->addr_list, if_list) {
>-- 
>2.23.0.444.g18eeb5a265-goog
>
>

Thanks Bart! Obviously, I wasn't aware of %pISp formatting...
Looks so much prettier!

Reviewed-by: Bernard Metzler <bmt@zurich.ibm.com>

