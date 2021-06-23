Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A78183B1CA5
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jun 2021 16:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbhFWOjH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Jun 2021 10:39:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50699 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231184AbhFWOjH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 23 Jun 2021 10:39:07 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15NEYYM1132124
        for <linux-rdma@vger.kernel.org>; Wed, 23 Jun 2021 10:36:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : subject :
 from : to : cc : date : references : content-type : message-id :
 content-transfer-encoding : mime-version; s=pp1;
 bh=R/x0Dwd4s1GXRloBipRE8+Nmzp4up4fg93kwTMxwMbY=;
 b=JDcgKtOZmZ+bWIXwjEnDuNV9GtIfDrDt+4lc5RDcTcmmvoJ+q1rZ0WLq9IEmlSVUC6BH
 XRu9mv0UF/16quwlz3/3DMpg9z7ZMjlzqhUX0hAv6SJHgzAFGAbq5iKVa+/hmbP61aog
 dRdGEfccD0fu9Oc75+53nNXDD3Ow9y1MOLqs4a5j5QyaTramR76DPLC/JEjdLUARWwlx
 wo0QdnY7Yl7OLiH4Or0TlF39irrzqi+zUOJcp31jLVR4Gcn6G7xlLUNiii/+sOoaxL9K
 jfCV9fXZKrnmIpNCY4pFaH6mNbpUrDfCO4ikFUuL1BDcF017Jrs0JmSd6MneV1GVWkGb pA== 
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.110])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39c6sbr6k9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Wed, 23 Jun 2021 10:36:49 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Wed, 23 Jun 2021 14:36:48 -0000
Received: from us1b3-smtp01.a3dr.sjc01.isc4sb.com (10.122.7.174)
        by smtp.notes.na.collabserv.com (10.122.47.50) with smtp.notes.na.collabserv.com ESMTP;
        Wed, 23 Jun 2021 14:36:46 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp01.a3dr.sjc01.isc4sb.com
          with ESMTP id 2021062314364555-465809 ;
          Wed, 23 Jun 2021 14:36:45 +0000 
In-Reply-To: <20210622203432.2715659-1-ira.weiny@intel.com>
Subject: Re: [PATCH V2] RDMA/siw: Convert siw_tx_hdt() to kmap_local_page()
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
Date:   Wed, 23 Jun 2021 14:36:45 +0000
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20210622203432.2715659-1-ira.weiny@intel.com>,<20210622061422.2633501-5-ira.weiny@intel.com>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP130 January 13, 2021 at 14:04
X-KeepSent: 951DAF0B:941A938D-002586FD:003F1610;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 62187
X-TNEFEvaluated: 1
Content-Type: text/plain; charset=UTF-8
x-cbid: 21062314-1059-0000-0000-0000040024D7
X-IBM-SpamModules-Scores: BY=0.004727; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0; ST=0; TS=0; UL=0; ISC=; MB=0.000001
X-IBM-SpamModules-Versions: BY=3.00015370; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000296; SDB=6.01555896; UDB=6.00845132; IPR=6.01348296;
 MB=3.00037289; MTD=3.00000008; XFM=3.00000015; UTC=2021-06-23 14:36:47
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2021-03-23 12:31:21 - 6.00012377
x-cbparentid: 21062314-1060-0000-0000-0000CCC4303F
Message-Id: <OF951DAF0B.941A938D-ON002586FD.003F1610-002586FD.00504522@notes.na.collabserv.com>
X-Proofpoint-ORIG-GUID: alw6SWJ3dKDC-vIEYvBjP4mL7p8KKFhS
X-Proofpoint-GUID: alw6SWJ3dKDC-vIEYvBjP4mL7p8KKFhS
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-23_09:2021-06-23,2021-06-23 signatures=0
X-Proofpoint-Spam-Reason: orgsafe
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----ira.weiny@intel.com wrote: -----

>To: "Jason Gunthorpe" <jgg@ziepe.ca>
>From: ira.weiny@intel.com
>Date: 06/22/2021 10:35PM
>Cc: "Ira Weiny" <ira.weiny@intel.com>, "Mike Marciniszyn"
><mike.marciniszyn@cornelisnetworks.com>, "Dennis Dalessandro"
><dennis.dalessandro@cornelisnetworks.com>, "Doug Ledford"
><dledford@redhat.com>, "Faisal Latif" <faisal.latif@intel.com>,
>"Shiraz Saleem" <shiraz.saleem@intel.com>, "Bernard Metzler"
><bmt@zurich.ibm.com>, "Kamal Heib" <kheib@redhat.com>,
>linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
>Subject: [EXTERNAL] [PATCH V2] RDMA/siw: Convert siw_tx_hdt() to
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
>siw_tx_hdt() tracks pages used in a page_array.  It uses that array
>to
>unmap pages which were mapped on function exit.  Not all entries in
>the
>array are mapped and this is tracked in kmap_mask.
>
>kunmap_local() takes a mapped address rather than a page.  Alter
>siw_unmap_pages() to take the iov array to reuse the iov_base address
>of
>each mapping.  Use PAGE_MASK to get the proper address for
>kunmap_local().
>
>kmap_local_page() mappings are tracked in a stack and must be
>unmapped
>in the opposite order they were mapped in.  Because segments are
>mapped
>into the page array in increasing index order, modify
>siw_unmap_pages()
>to unmap pages in decreasing order.
>
>Use kmap_local_page() instead of kmap() to map pages in the
>page_array.
>
>[1]
>INVALID URI REMOVED
>lkml_20201009195033.3208459-2D59-2Dira.weiny-40intel.com_&d=3DDwIDAg&c=3D
>jf_iaSHvJObTbx-siA1ZOg&r=3D2TaYXQ0T-r8ZO1PP1alNwU_QJcRRLfmYTAgd3QCvqSc&
>m=3DujJBVqPLdVdVxXvOu_PlFL3NVC0Znds3FgxyrtWJtwM&s=3DWZIBAdwlCqPIRjsNOGlly
>gQ6Hsug6ObgrWgO_nvBGyc&e=3D=20
>
>Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>
>---
>Changes for V2:
>	From Bernard
>		Reuse iov[].iov_base rather than declaring another array of
>		pointers and preserve the use of kmap_mask to know which iov's
>		were kmapped.
>
>---
> drivers/infiniband/sw/siw/siw_qp_tx.c | 32
>+++++++++++++++++----------
> 1 file changed, 20 insertions(+), 12 deletions(-)
>
>diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c
>b/drivers/infiniband/sw/siw/siw_qp_tx.c
>index db68a10d12cd..fd3b9e6a67d7 100644
>--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
>+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
>@@ -396,13 +396,20 @@ static int siw_0copy_tx(struct socket *s,
>struct page **page,
>=20
> #define MAX_TRAILER (MPA_CRC_SIZE + 4)
>=20
>-static void siw_unmap_pages(struct page **pp, unsigned long
>kmap_mask)
>+static void siw_unmap_pages(struct kvec *iov, unsigned long
>kmap_mask, int len)
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
>+		if (kmap_mask & BIT(i)) {
>+			unsigned long addr =3D (unsigned long)iov[i].iov_base;
>+
>+			kunmap_local((void *)(addr & PAGE_MASK));
>+		}
> 	}
> }
>=20
>@@ -498,7 +505,7 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx,
>struct socket *s)
> 					p =3D siw_get_upage(mem->umem,
> 							  sge->laddr + sge_off);
> 				if (unlikely(!p)) {
>-					siw_unmap_pages(page_array, kmap_mask);
>+					siw_unmap_pages(iov, kmap_mask, MAX_ARRAY);
> 					wqe->processed -=3D c_tx->bytes_unsent;
> 					rv =3D -EFAULT;
> 					goto done_crc;
>@@ -506,11 +513,12 @@ static int siw_tx_hdt(struct siw_iwarp_tx
>*c_tx, struct socket *s)
> 				page_array[seg] =3D p;
>=20
> 				if (!c_tx->use_sendpage) {
>-					iov[seg].iov_base =3D kmap(p) + fp_off;
>-					iov[seg].iov_len =3D plen;
>+					void *kaddr =3D kmap_local_page(page_array[seg]);

we can use 'kmap_local_page(p)' here
>=20
> 					/* Remember for later kunmap() */
> 					kmap_mask |=3D BIT(seg);
>+					iov[seg].iov_base =3D kaddr + fp_off;
>+					iov[seg].iov_len =3D plen;
>=20
> 					if (do_crc)
> 						crypto_shash_update(
>@@ -518,7 +526,7 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx,
>struct socket *s)
> 							iov[seg].iov_base,
> 							plen);

This patch does not apply for me. Would I have to install first
your [Patch 3/4] -- since the current patch references kmap_local_page()
already? Maybe it is better to apply if it would be just one siw
related patch in that series?



> 				} else if (do_crc) {
>-					kaddr =3D kmap_local_page(p);
>+					kaddr =3D kmap_local_page(page_array[seg]);

using 'kmap_local_page(p)' as you had it is straightforward
and I would prefer it.

> 					crypto_shash_update(c_tx->mpa_crc_hd,
> 							    kaddr + fp_off,
> 							    plen);
>@@ -542,7 +550,7 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx,
>struct socket *s)
>=20
> 			if (++seg > (int)MAX_ARRAY) {
> 				siw_dbg_qp(tx_qp(c_tx), "to many fragments\n");
>-				siw_unmap_pages(page_array, kmap_mask);
>+				siw_unmap_pages(iov, kmap_mask, MAX_ARRAY);

to minimize the iterations over the byte array in 'siw_unmap_pages()',
we may pass seg-1 instead of MAX_ARRAY


> 				wqe->processed -=3D c_tx->bytes_unsent;
> 				rv =3D -EMSGSIZE;
> 				goto done_crc;
>@@ -593,7 +601,7 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx,
>struct socket *s)
> 	} else {
> 		rv =3D kernel_sendmsg(s, &msg, iov, seg + 1,
> 				    hdr_len + data_len + trl_len);
>-		siw_unmap_pages(page_array, kmap_mask);
>+		siw_unmap_pages(iov, kmap_mask, MAX_ARRAY);

to minimize the iterations over the byte array in 'siw_unmap_pages()',
we may pass seg instead of MAX_ARRAY

> 	}
> 	if (rv < (int)hdr_len) {
> 		/* Not even complete hdr pushed or negative rv */
>--=20
>2.28.0.rc0.12.gb6a658bd00c9
>
>

