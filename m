Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEB229B210
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Aug 2019 16:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390879AbfHWOeG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 23 Aug 2019 10:34:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55058 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390812AbfHWOeF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 23 Aug 2019 10:34:05 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7NERxuj103188
        for <linux-rdma@vger.kernel.org>; Fri, 23 Aug 2019 10:34:04 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.82])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ujg33wcjh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Fri, 23 Aug 2019 10:34:04 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Fri, 23 Aug 2019 14:34:03 -0000
Received: from us1a3-smtp05.a3.dal06.isc4sb.com (10.146.71.159)
        by smtp.notes.na.collabserv.com (10.106.227.105) with smtp.notes.na.collabserv.com ESMTP;
        Fri, 23 Aug 2019 14:33:57 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp05.a3.dal06.isc4sb.com
          with ESMTP id 2019082314335666-544286 ;
          Fri, 23 Aug 2019 14:33:56 +0000 
In-Reply-To: <0f280f83ded4ec624ab897f8a83b4ab1565f35cd.camel@redhat.com>
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Doug Ledford" <dledford@redhat.com>
Cc:     "Leon Romanovsky" <leon@kernel.org>, linux-rdma@vger.kernel.org,
        jgg@ziepe.ca, geert@linux-m68k.org
Date:   Fri, 23 Aug 2019 14:33:56 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <0f280f83ded4ec624ab897f8a83b4ab1565f35cd.camel@redhat.com>,<20190822173738.26817-1-bmt@zurich.ibm.com>
 <20190822184147.GO29433@mtr-leonro.mtl.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP57 August 05, 2019 at 12:42
X-LLNOutbound: False
X-Disclaimed: 17263
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19082314-9463-0000-0000-00000098A0AB
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.027190
X-IBM-SpamModules-Versions: BY=3.00011640; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01250975; UDB=6.00660511; IPR=6.01032538;
 MB=3.00028300; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-23 14:34:01
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-08-23 10:33:47 - 6.00010320
x-cbparentid: 19082314-9464-0000-0000-00002833AE55
Message-Id: <OF013F89F4.F7760460-ON0025845F.004F2CE0-0025845F.00500308@notes.na.collabserv.com>
Subject: RE: [PATCH v3] RDMA/siw: Fix 64/32bit pointer inconsistency
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-23_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Doug Ledford" <dledford@redhat.com> wrote: -----

>To: "Leon Romanovsky" <leon@kernel.org>, "Bernard Metzler"
><bmt@zurich.ibm.com>
>From: "Doug Ledford" <dledford@redhat.com>
>Date: 08/22/2019 09:08PM
>Cc: linux-rdma@vger.kernel.org, jgg@ziepe.ca, geert@linux-m68k.org
>Subject: [EXTERNAL] Re: [PATCH v3] RDMA/siw: Fix 64/32bit pointer
>inconsistency
>
>On Thu, 2019-08-22 at 21:41 +0300, Leon Romanovsky wrote:
>> On Thu, Aug 22, 2019 at 07:37:38PM +0200, Bernard Metzler wrote:
>> > Fixes improper casting between addresses and unsigned types.
>> > Changes siw_pbl_get_buffer() function to return appropriate
>> > dma_addr_t, and not u64.
>> > 
>> > Also fixes debug prints. Now any potentially kernel private
>> > pointers are printed formatted as '%pK', to allow keeping that
>> > information secret.
>> > 
>> > Fixes: d941bfe500be ("RDMA/siw: Change CQ flags from 64->32
>bits")
>> > Fixes: b0fff7317bb4 ("rdma/siw: completion queue methods")
>> > Fixes: 8b6a361b8c48 ("rdma/siw: receive path")
>> > Fixes: b9be6f18cf9e ("rdma/siw: transmit path")
>> > Fixes: f29dd55b0236 ("rdma/siw: queue pair methods")
>> > Fixes: 2251334dcac9 ("rdma/siw: application buffer management")
>> > Fixes: 303ae1cdfdf7 ("rdma/siw: application interface")
>> > Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
>> > Fixes: a531975279f3 ("rdma/siw: main include file")
>> > 
>> > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> > Reported-by: Jason Gunthorpe <jgg@ziepe.ca>
>> > Reported-by: Leon Romanovsky <leon@kernel.org>
>> > Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
>> > ---
>> >  drivers/infiniband/sw/siw/siw.h       |  8 +--
>> >  drivers/infiniband/sw/siw/siw_cm.c    | 74
>++++++++++++----------
>> > -----
>> >  drivers/infiniband/sw/siw/siw_cq.c    |  5 +-
>> >  drivers/infiniband/sw/siw/siw_mem.c   | 14 ++---
>> >  drivers/infiniband/sw/siw/siw_mem.h   |  2 +-
>> >  drivers/infiniband/sw/siw/siw_qp.c    |  2 +-
>> >  drivers/infiniband/sw/siw/siw_qp_rx.c | 26 +++++-----
>> >  drivers/infiniband/sw/siw/siw_qp_tx.c | 43 ++++++++--------
>> >  drivers/infiniband/sw/siw/siw_verbs.c | 40 +++++++--------
>> >  9 files changed, 106 insertions(+), 108 deletions(-)
>> > 
>> > diff --git a/drivers/infiniband/sw/siw/siw.h
>> > b/drivers/infiniband/sw/siw/siw.h
>> > index 77b1aabf6ff3..dba4535494ab 100644
>> > --- a/drivers/infiniband/sw/siw/siw.h
>> > +++ b/drivers/infiniband/sw/siw/siw.h
>> > @@ -138,9 +138,9 @@ struct siw_umem {
>> >  };
>> > 
>> >  struct siw_pble {
>> > -	u64 addr; /* Address of assigned user buffer */
>> > -	u64 size; /* Size of this entry */
>> > -	u64 pbl_off; /* Total offset from start of PBL */
>> > +	dma_addr_t addr; /* Address of assigned buffer */
>> > +	unsigned int size; /* Size of this entry */
>> > +	unsigned long pbl_off; /* Total offset from start of PBL */
>> >  };
>> > 
>> >  struct siw_pbl {
>> > @@ -734,7 +734,7 @@ static inline void siw_crc_skb(struct
>> > siw_rx_stream *srx, unsigned int len)
>> >  		  "MEM[0x%08x] %s: " fmt, mem->stag, __func__,
>> > ##__VA_ARGS__)
>> > 
>> >  #define siw_dbg_cep(cep, fmt,
>> > ...)                                             \
>> > -	ibdev_dbg(&cep->sdev->base_dev, "CEP[0x%p] %s: "
>> > fmt,                  \
>> > +	ibdev_dbg(&cep->sdev->base_dev, "CEP[0x%pK] %s: "
>> > fmt,                  \
>> >  		  cep, __func__, ##__VA_ARGS__)
>> > 
>> >  void siw_cq_flush(struct siw_cq *cq);
>> > diff --git a/drivers/infiniband/sw/siw/siw_cm.c
>> > b/drivers/infiniband/sw/siw/siw_cm.c
>> > index 9ce8a1b925d2..ae7ea3ad7224 100644
>> > --- a/drivers/infiniband/sw/siw/siw_cm.c
>> > +++ b/drivers/infiniband/sw/siw/siw_cm.c
>> > @@ -355,8 +355,8 @@ static int siw_cm_upcall(struct siw_cep *cep,
>> > enum iw_cm_event_type reason,
>> >  		getname_local(cep->sock, &event.local_addr);
>> >  		getname_peer(cep->sock, &event.remote_addr);
>> >  	}
>> > -	siw_dbg_cep(cep, "[QP %u]: id 0x%p, reason=%d, status=%d\n",
>> > -		    cep->qp ? qp_id(cep->qp) : -1, id, reason, status);
>> > +	siw_dbg_cep(cep, "[QP %u]: reason=%d, status=%d\n",
>> > +		    cep->qp ? qp_id(cep->qp) : -1, reason, status);
>>                                              ^^^^
>> There is a chance that such construction (attempt to print -1 with
>%u)
>> will generate some sort of warning.
>> 
>> Thanks
>
>I didn't see any warnings when I built it.  And %u->-1 would be the
>same
>error on 64bit or 32bit, so I think we're safe here.
>

Doug,
May I ask you to amend this patch in a way which would
just stop this monument of programming stupidity from
prolonging into the future, while of course recognizing
the impossibility of erasing it from the past?
Exchanging the %u with %d would help me regaining
some self-confidence ;)

Thanks!
Bernard. 


>Thanks Bernard, it's in my wip/dl-for-rc branch to get 0day testing.
>
>-- 
>Doug Ledford <dledford@redhat.com>
>    GPG KeyID: B826A3330E572FDD
>    Fingerprint = AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD
>
[attachment "signature.asc" removed by Bernard Metzler/Zurich/IBM]

