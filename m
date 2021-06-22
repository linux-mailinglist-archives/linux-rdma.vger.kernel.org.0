Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1833B0A89
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 18:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbhFVQpL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Jun 2021 12:45:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18892 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230438AbhFVQpL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Jun 2021 12:45:11 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15MGWUrU149468
        for <linux-rdma@vger.kernel.org>; Tue, 22 Jun 2021 12:42:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : subject :
 from : to : cc : date : references : content-type : message-id :
 content-transfer-encoding : mime-version; s=pp1;
 bh=cyFcrkz/DsCo82vETRqOoOAQ4D9ZLp90Jz9I+JKrQD8=;
 b=jBghao7OvnxcAyl4s0LQZ15s2bTxKHDwsnhsIKcbm0DbAW6bYNRG0/8pY3c6rw7rvRUT
 +jhoziTnewM7GySEoHibuPhpXEStzhF9AoJohD0JLJRcQlQnx6aTweMF4ZMylbxY+znb
 2CRJqLMVJnWZBH9KtAB5ngzkUos9ft+dM7t41Kp/UHFIx3AQL/cmuH5maftOIVKdHQKw
 GhmIBlt+pdWflFfb/1eBzV+itG4S4fqRNXn59ZpY9D91gy9i5/cFk9BCCiHJ3Qf0EbRF
 3+J1fH9bJ/dXhIa/GFuybSMxY/MnqatA0/UgfC0QnGvcME/Gpx37iJl0KrDjOvysXFT0 0g== 
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.112])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39bjtb9kns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 22 Jun 2021 12:42:54 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 22 Jun 2021 16:42:53 -0000
Received: from us1b3-smtp05.a3dr.sjc01.isc4sb.com (10.122.203.183)
        by smtp.notes.na.collabserv.com (10.122.47.54) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 22 Jun 2021 16:42:51 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp05.a3dr.sjc01.isc4sb.com
          with ESMTP id 2021062216424972-501643 ;
          Tue, 22 Jun 2021 16:42:49 +0000 
In-Reply-To: <20210622061422.2633501-5-ira.weiny@intel.com>
Subject: Re: [PATCH 4/4] RDMA/siw: Convert siw_tx_hdt() to kmap_local_page()
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "ira.weiny" <ira.weiny@intel.com>
Cc:     "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Mike Marciniszyn" <mike.marciniszyn@cornelisnetworks.com>,
        "Dennis Dalessandro" <dennis.dalessandro@cornelisnetworks.com>,
        "Doug Ledford" <dledford@redhat.com>,
        "Faisal Latif" <faisal.latif@intel.com>,
        "Shiraz Saleem" <shiraz.saleem@intel.com>,
        "Kamal Heib" <kheib@redhat.com>,
        "linux-rdma" <linux-rdma@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Date:   Tue, 22 Jun 2021 16:42:49 +0000
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20210622061422.2633501-5-ira.weiny@intel.com>,<20210622061422.2633501-1-ira.weiny@intel.com>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP130 January 13, 2021 at 14:04
X-KeepSent: 400EF61E:38060C6A-002586FC:005B421A;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 7959
X-TNEFEvaluated: 1
Content-Type: text/plain; charset=UTF-8
x-cbid: 21062216-4615-0000-0000-0000040B2983
X-IBM-SpamModules-Scores: BY=0.004727; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0; ST=0; TS=0; UL=0; ISC=; MB=0.000204
X-IBM-SpamModules-Versions: BY=3.00015370; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000296; SDB=6.01548293; UDB=6.00838383; IPR=6.01330255;
 MB=3.00037291; MTD=3.00000008; XFM=3.00000015; UTC=2021-06-22 16:42:52
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2021-03-22 14:02:06 - 6.00012377
x-cbparentid: 21062216-4616-0000-0000-000005C931E2
Message-Id: <OF400EF61E.38060C6A-ON002586FC.005B421A-002586FC.005BCFB3@notes.na.collabserv.com>
X-Proofpoint-GUID: jAOH4L6_KUaYtaqgeNYjeAYNsyhA8iga
X-Proofpoint-ORIG-GUID: jAOH4L6_KUaYtaqgeNYjeAYNsyhA8iga
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-22_11:2021-06-22,2021-06-22 signatures=0
X-Proofpoint-Spam-Reason: orgsafe
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----ira.weiny@intel.com wrote: -----

>To: "Jason Gunthorpe" <jgg@ziepe.ca>
>From: ira.weiny@intel.com
>Date: 06/22/2021 08:14AM
>Cc: "Ira Weiny" <ira.weiny@intel.com>, "Mike Marciniszyn"
><mike.marciniszyn@cornelisnetworks.com>, "Dennis Dalessandro"
><dennis.dalessandro@cornelisnetworks.com>, "Doug Ledford"
><dledford@redhat.com>, "Faisal Latif" <faisal.latif@intel.com>,
>"Shiraz Saleem" <shiraz.saleem@intel.com>, "Bernard Metzler"
><bmt@zurich.ibm.com>, "Kamal Heib" <kheib@redhat.com>,
>linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
>Subject: [EXTERNAL] [PATCH 4/4] RDMA/siw: Convert siw_tx_hdt() to
>kmap_local_page()
>
>From: Ira Weiny <ira.weiny@intel.com>
>
>kmap() is being deprecated and will break uses of device dax after
>PKS
>protection is introduced.[1]
>
>The use of kmap() in siw_tx_hdt() is all thread local therefore
>kmap_local_page() is a sufficient replacement and will work with
>pgmap
>protected pages when those are implemented.
>
>kmap_local_page() mappings are tracked in a stack and must be
>unmapped
>in the opposite order they were mapped in.
>
>siw_tx_hdt() tracks pages used in a page_array.  It uses that array
>to
>unmap pages which were mapped on function exit.  Not all entries in
>the
>array are mapped and this is tracked in kmap_mask.
>
>kunmap_local() takes a mapped address rather than a page.  Declare a
>mapped address array, page_array_addr, of the same size as the page
>array to be used for unmapping.
>

Hi Ira, thanks for taking care of that!

I think we can avoid introducing another 'page_array_addr[]' array
here, which must be zeroed first and completely searched for
valid mappings during unmap, and also further bloats the
stack size of siw_tx_hdt(). I think we can go away with the
already available iov[].iov_base addresses array, masking addresses
with PAGE_MASK during unmapping to mask any first byte offset.
All kmap_local_page() mapping end up at that list. For unmapping
we can still rely on the kmap_mask bit field, which is more
efficient to initialize and search for valid mappings. Ordering
during unmapping can be guaranteed if we parse the bitmask
in reverse order. Let me know if you prefer me to propose
a change -- that siw_tx_hdt() thing became rather complex I
have to admit!

Best,
Bernard.

>Use kmap_local_page() instead of kmap() to map pages in the
>page_array.
>
>Because segments are mapped into the page array in increasing index
>order, modify siw_unmap_pages() to unmap pages in decreasing order.
>
>The kmap_mask is no longer needed as the lack of an address in the
>address array can indicate no unmap is required.
>
>[1]
>INVALID URI REMOVED
>lkml_20201009195033.3208459-2D59-2Dira.weiny-40intel.com_&d=3DDwIDAg&c=3D
>jf_iaSHvJObTbx-siA1ZOg&r=3D2TaYXQ0T-r8ZO1PP1alNwU_QJcRRLfmYTAgd3QCvqSc&
>m=3DwnRcc-qyXV_X7kyQfFYL6XPgmmakQxmo44BmjIon-w0&s=3DY0aiKJ4EHZY8FJlI-uiPr
>xcBE95kmgn3iEz3p8d5VF4&e=3D=20
>
>Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>---
> drivers/infiniband/sw/siw/siw_qp_tx.c | 35
>+++++++++++++++------------
> 1 file changed, 20 insertions(+), 15 deletions(-)
>
>diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c
>b/drivers/infiniband/sw/siw/siw_qp_tx.c
>index db68a10d12cd..e70aba23f6e7 100644
>--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
>+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
>@@ -396,13 +396,17 @@ static int siw_0copy_tx(struct socket *s,
>struct page **page,
>=20
> #define MAX_TRAILER (MPA_CRC_SIZE + 4)
>=20
>-static void siw_unmap_pages(struct page **pp, unsigned long
>kmap_mask)
>+static void siw_unmap_pages(void **addrs, int len)
> {
>-	while (kmap_mask) {
>-		if (kmap_mask & BIT(0))
>-			kunmap(*pp);
>-		pp++;
>-		kmap_mask >>=3D 1;
>+	int i;
>+
>+	/*
>+	 * Work backwards through the array to honor the kmap_local_page()
>+	 * ordering requirements.
>+	 */
>+	for (i =3D (len-1); i >=3D 0; i--) {
>+		if (addrs[i])
>+			kunmap_local(addrs[i]);
> 	}
> }
>=20
>@@ -427,13 +431,15 @@ static int siw_tx_hdt(struct siw_iwarp_tx
>*c_tx, struct socket *s)
> 	struct siw_sge *sge =3D &wqe->sqe.sge[c_tx->sge_idx];
> 	struct kvec iov[MAX_ARRAY];
> 	struct page *page_array[MAX_ARRAY];
>+	void *page_array_addr[MAX_ARRAY];
> 	struct msghdr msg =3D { .msg_flags =3D MSG_DONTWAIT | MSG_EOR };
>=20
> 	int seg =3D 0, do_crc =3D c_tx->do_crc, is_kva =3D 0, rv;
> 	unsigned int data_len =3D c_tx->bytes_unsent, hdr_len =3D 0, trl_len =3D
>0,
> 		     sge_off =3D c_tx->sge_off, sge_idx =3D c_tx->sge_idx,
> 		     pbl_idx =3D c_tx->pbl_idx;
>-	unsigned long kmap_mask =3D 0L;
>+
>+	memset(page_array_addr, 0, sizeof(page_array_addr));
>=20
> 	if (c_tx->state =3D=3D SIW_SEND_HDR) {
> 		if (c_tx->use_sendpage) {
>@@ -498,7 +504,7 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx,
>struct socket *s)
> 					p =3D siw_get_upage(mem->umem,
> 							  sge->laddr + sge_off);
> 				if (unlikely(!p)) {
>-					siw_unmap_pages(page_array, kmap_mask);
>+					siw_unmap_pages(page_array_addr, MAX_ARRAY);
> 					wqe->processed -=3D c_tx->bytes_unsent;
> 					rv =3D -EFAULT;
> 					goto done_crc;
>@@ -506,11 +512,10 @@ static int siw_tx_hdt(struct siw_iwarp_tx
>*c_tx, struct socket *s)
> 				page_array[seg] =3D p;
>=20
> 				if (!c_tx->use_sendpage) {
>-					iov[seg].iov_base =3D kmap(p) + fp_off;
>-					iov[seg].iov_len =3D plen;
>+					page_array_addr[seg] =3D kmap_local_page(page_array[seg]);
>=20
>-					/* Remember for later kunmap() */
>-					kmap_mask |=3D BIT(seg);
>+					iov[seg].iov_base =3D page_array_addr[seg] + fp_off;
>+					iov[seg].iov_len =3D plen;
>=20
> 					if (do_crc)
> 						crypto_shash_update(
>@@ -518,7 +523,7 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx,
>struct socket *s)
> 							iov[seg].iov_base,
> 							plen);
> 				} else if (do_crc) {
>-					kaddr =3D kmap_local_page(p);
>+					kaddr =3D kmap_local_page(page_array[seg]);
> 					crypto_shash_update(c_tx->mpa_crc_hd,
> 							    kaddr + fp_off,
> 							    plen);
>@@ -542,7 +547,7 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx,
>struct socket *s)
>=20
> 			if (++seg > (int)MAX_ARRAY) {
> 				siw_dbg_qp(tx_qp(c_tx), "to many fragments\n");
>-				siw_unmap_pages(page_array, kmap_mask);
>+				siw_unmap_pages(page_array_addr, MAX_ARRAY);
> 				wqe->processed -=3D c_tx->bytes_unsent;
> 				rv =3D -EMSGSIZE;
> 				goto done_crc;
>@@ -593,7 +598,7 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx,
>struct socket *s)
> 	} else {
> 		rv =3D kernel_sendmsg(s, &msg, iov, seg + 1,
> 				    hdr_len + data_len + trl_len);
>-		siw_unmap_pages(page_array, kmap_mask);
>+		siw_unmap_pages(page_array_addr, MAX_ARRAY);
> 	}
> 	if (rv < (int)hdr_len) {
> 		/* Not even complete hdr pushed or negative rv */
>--=20
>2.28.0.rc0.12.gb6a658bd00c9
>
>

