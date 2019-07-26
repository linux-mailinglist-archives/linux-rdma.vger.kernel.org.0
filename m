Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 190CE76E82
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jul 2019 18:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfGZQHA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 26 Jul 2019 12:07:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12592 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727218AbfGZQHA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 26 Jul 2019 12:07:00 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6QG6H6d065449
        for <linux-rdma@vger.kernel.org>; Fri, 26 Jul 2019 12:06:59 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.93])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u035sdhfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Fri, 26 Jul 2019 12:06:57 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Fri, 26 Jul 2019 16:06:55 -0000
Received: from us1a3-smtp08.a3.dal06.isc4sb.com (10.146.103.57)
        by smtp.notes.na.collabserv.com (10.106.227.39) with smtp.notes.na.collabserv.com ESMTP;
        Fri, 26 Jul 2019 16:06:49 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp08.a3.dal06.isc4sb.com
          with ESMTP id 2019072616064906-639764 ;
          Fri, 26 Jul 2019 16:06:49 +0000 
In-Reply-To: <20190726092540.22467-1-anders.roxell@linaro.org>
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Anders Roxell" <anders.roxell@linaro.org>
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 26 Jul 2019 16:06:48 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190726092540.22467-1-anders.roxell@linaro.org>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP55 May 22, 2019 at 11:09
X-LLNOutbound: False
X-Disclaimed: 1223
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19072616-1799-0000-0000-00000C64BADF
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.062086
X-IBM-SpamModules-Versions: BY=3.00011497; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01237770; UDB=6.00652490; IPR=6.01019151;
 BA=6.00006357; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00027905; XFM=3.00000015;
 UTC=2019-07-26 16:06:53
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-07-26 15:06:58 - 6.00010212
x-cbparentid: 19072616-1800-0000-0000-0000008BD7F1
Message-Id: <OFE52012B8.B3E39B05-ON00258443.0057F9D5-00258443.005883B6@notes.na.collabserv.com>
Subject: Re:  [PATCH] rdma: siw: remove unused variable
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-26_12:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Anders Roxell" <anders.roxell@linaro.org> wrote: -----

>To: bmt@zurich.ibm.com, dledford@redhat.com, jgg@ziepe.ca
>From: "Anders Roxell" <anders.roxell@linaro.org>
>Date: 07/26/2019 11:26AM
>Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, "Anders
>Roxell" <anders.roxell@linaro.org>
>Subject: [EXTERNAL] [PATCH] rdma: siw: remove unused variable
>
>The variable 'p' si no longer used and the compiler rightly complains
>that it should be removed.
>
>../drivers/infiniband/sw/siw/siw_mem.c: In function ‘siw_free_plist’:
>../drivers/infiniband/sw/siw/siw_mem.c:66:16: warning: unused
>variable
> ‘p’ [-Wunused-variable]
>  struct page **p = chunk->plist;
>                ^
>
>Rework to remove unused variable.
>
>Fixes: 8288d030447f ("mm/gup: add make_dirty arg to
>put_user_pages_dirty_lock()")
>Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
>---
> drivers/infiniband/sw/siw/siw_mem.c | 2 --
> 1 file changed, 2 deletions(-)
>
>diff --git a/drivers/infiniband/sw/siw/siw_mem.c
>b/drivers/infiniband/sw/siw/siw_mem.c
>index 358d440efa11..ab83a9cec562 100644
>--- a/drivers/infiniband/sw/siw/siw_mem.c
>+++ b/drivers/infiniband/sw/siw/siw_mem.c
>@@ -63,8 +63,6 @@ struct siw_mem *siw_mem_id2obj(struct siw_device
>*sdev, int stag_index)
> static void siw_free_plist(struct siw_page_chunk *chunk, int
>num_pages,
> 			   bool dirty)
> {
>-	struct page **p = chunk->plist;
>-
> 	put_user_pages_dirty_lock(chunk->plist, num_pages, dirty);
> }
> 
>-- 
>2.20.1
>
>

If we can cut down siw_free_plist() to just calling
put_user_pages_dirty_lock(), we shall better call it directly
and not obfuscate that by another function. 

Reviewed-by: Bernard Metzler <bmt@zurich.ibm.com>

