Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D38FC3337
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Oct 2019 13:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbfJALpQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 1 Oct 2019 07:45:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19038 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732572AbfJALpQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Oct 2019 07:45:16 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x91BhAdm192765
        for <linux-rdma@vger.kernel.org>; Tue, 1 Oct 2019 07:45:15 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.90])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vc4k8k9x2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 01 Oct 2019 07:45:14 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 1 Oct 2019 11:45:14 -0000
Received: from us1a3-smtp07.a3.dal06.isc4sb.com (10.146.103.14)
        by smtp.notes.na.collabserv.com (10.106.227.141) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 1 Oct 2019 11:45:09 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp07.a3.dal06.isc4sb.com
          with ESMTP id 2019100111450904-410875 ;
          Tue, 1 Oct 2019 11:45:09 +0000 
In-Reply-To: <20190930231707.48259-5-bvanassche@acm.org>
Subject: Re: [PATCH 04/15] RDMA/siw: Fix port number endianness in a debug message
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Bart Van Assche" <bvanassche@acm.org>
Cc:     "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Leon Romanovsky" <leonro@mellanox.com>,
        "Doug Ledford" <dledford@redhat.com>, linux-rdma@vger.kernel.org
Date:   Tue, 1 Oct 2019 11:45:08 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190930231707.48259-5-bvanassche@acm.org>,<20190930231707.48259-1-bvanassche@acm.org>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP57 August 05, 2019 at 12:42
X-LLNOutbound: False
X-Disclaimed: 11415
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19100111-3649-0000-0000-000000C9ED57
X-IBM-SpamModules-Scores: BY=0.02222; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.000570
X-IBM-SpamModules-Versions: BY=3.00011870; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000292; SDB=6.01269147; UDB=6.00671687; IPR=6.01051174;
 MB=3.00028898; MTD=3.00000008; XFM=3.00000015; UTC=2019-10-01 11:45:13
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-10-01 11:07:12 - 6.00010474
x-cbparentid: 19100111-3650-0000-0000-0000013E4634
Message-Id: <OF83902C0F.AB82A935-ON00258486.00408ED3-00258486.00408EDD@notes.na.collabserv.com>
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
>Subject: [EXTERNAL] [PATCH 04/15] RDMA/siw: Fix port number
>endianness in a debug message
>
>sin_port and sin6_port are big endian member variables. Convert these
>port
>numbers into CPU endianness before printing.
>
>Cc: Bernard Metzler <bmt@zurich.ibm.com>
>Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
>Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>---
> drivers/infiniband/sw/siw/siw_cm.c | 9 +--------
> 1 file changed, 1 insertion(+), 8 deletions(-)
>
>diff --git a/drivers/infiniband/sw/siw/siw_cm.c
>b/drivers/infiniband/sw/siw/siw_cm.c
>index 5a75deb9870b..3bccfef40e7e 100644
>--- a/drivers/infiniband/sw/siw/siw_cm.c
>+++ b/drivers/infiniband/sw/siw/siw_cm.c
>@@ -1853,14 +1853,7 @@ static int siw_listen_address(struct iw_cm_id
>*id, int backlog,
> 	list_add_tail(&cep->listenq, (struct list_head
>*)id->provider_data);
> 	cep->state = SIW_EPSTATE_LISTENING;
> 
>-	if (addr_family == AF_INET)
>-		siw_dbg(id->device, "Listen at laddr %pI4 %u\n",
>-			&(((struct sockaddr_in *)laddr)->sin_addr),
>-			((struct sockaddr_in *)laddr)->sin_port);
>-	else
>-		siw_dbg(id->device, "Listen at laddr %pI6 %u\n",
>-			&(((struct sockaddr_in6 *)laddr)->sin6_addr),
>-			((struct sockaddr_in6 *)laddr)->sin6_port);
>+	siw_dbg(id->device, "Listen at laddr %pISp\n", laddr);
> 
> 	return 0;
> 
>-- 
>2.23.0.444.g18eeb5a265-goog
>
>


Thanks again Bart!
Looks much better now. You may even collapse this patch
with PATCH 03/15 you sent just before, but doesn't
really matter of course.

Reviewed-by: Bernard Metzler <bmt@zurich.ibm.com>

