Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFEA3B79CC
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Jun 2021 23:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235937AbhF2VS1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Jun 2021 17:18:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53362 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235926AbhF2VS1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Jun 2021 17:18:27 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15TKj6Fv105225;
        Tue, 29 Jun 2021 17:15:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : references
 : subject : from : to : cc : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=q1r/tdpeJ8+Oi1UCLHn475mZIn7824r2oaC4tHRUtFQ=;
 b=Gxf3QV4NNzjqXgcqC60rWh4PvqcrETVlThHUnDl9XesDSh2vNN65VL5vE9Sd+xrkOU/k
 9cT5pFREtMGw4hxSdpsAQCfp8Pa5vrfwLt/hU0dTg5D4UNh6+BgYNKfmPx/BuIaKEPOl
 cO/CeIYIUCfRvyYTLCZyCBJtr1MFfGrDKk7UzAyFnskrc8d1ARxxgaCu8Dc/6Tm1cjeO
 dsMjTWwhKy9u5v526kIEcBKI0sKD0yfgQKe/nY9Z7kOcZmHZLXQ3BFaVssuyXTDBrgl3
 zkfQuxIHKyHc7/e+5ttkq4P4sx0GoGwui5RLkQsDWKa0BGTOFXKxfOc1hWArnUdr5uer ZQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39gatu8qeb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Jun 2021 17:15:58 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15TL7wW8018983;
        Tue, 29 Jun 2021 21:15:57 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 39duv8hf7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Jun 2021 21:15:56 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15TLFsVJ34275670
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jun 2021 21:15:54 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8AB4DA4040;
        Tue, 29 Jun 2021 21:15:54 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 52EF0A404D;
        Tue, 29 Jun 2021 21:15:54 +0000 (GMT)
Received: from PGAAMSML35001.SL.BLUECLOUD.IBM.COM (unknown [9.209.254.249])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 29 Jun 2021 21:15:54 +0000 (GMT)
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
In-Reply-To: <20210624174814.2822896-1-ira.weiny@intel.com>
References: <20210624174814.2822896-1-ira.weiny@intel.com>,
        <20210623221543.2799198-1-ira.weiny@intel.com>
Subject: Re: [PATCH V4] RDMA/siw: Convert siw_tx_hdt() to kmap_local_page()
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     "ira.weiny" <ira.weiny@intel.com>
Cc:     "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Mike Marciniszyn" <mike.marciniszyn@cornelisnetworks.com>,
        "Dennis Dalessandro" <dennis.dalessandro@cornelisnetworks.com>,
        "Doug Ledford" <dledford@redhat.com>,
        "Faisal Latif" <faisal.latif@intel.com>,
        "Shiraz Saleem" <shiraz.saleem@intel.com>,
        "Kamal Heib" <kheib@redhat.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Tue, 29 Jun 2021 14:11:04 +0000
Message-ID: <OF8390CEF8.B4919E81-ON00258703.004DEB09-00258703.004DEB36@ch.ibm.com>
X-Mailer: Lotus Domino Web Server Release 11.0.1FP2HF95   June 28, 2021
X-MIMETrack: Serialize by http on MWW0302/03/M/IBM at 06/29/2021 14:11:04,
        Serialize complete at 06/29/2021 14:11:04,
        Serialize by Router on D06ML350/06/M/IBM(Release 11.0.1FP2|October 20, 2020) at
 29/06/2021 23:24:45
X-KeepSent: 8390CEF8:B4919E81-00258703:004DEB09;
 type=4; name=$KeepSent
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eDQLHnyzdBHwMrZVVPojWLO4Qz-pjauS
X-Proofpoint-GUID: eDQLHnyzdBHwMrZVVPojWLO4Qz-pjauS
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-29_14:2021-06-29,2021-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106290128
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----ira.weiny@intel.com wrote: -----

>To: "Jason Gunthorpe" <jgg@ziepe.ca>
>From: ira.weiny@intel.com
>Date: 06/24/2021 07:48PM
>Cc: "Ira Weiny" <ira.weiny@intel.com>, "Mike Marciniszyn"
><mike.marciniszyn@cornelisnetworks.com>, "Dennis Dalessandro"
><dennis.dalessandro@cornelisnetworks.com>, "Doug Ledford"
><dledford@redhat.com>, "Faisal Latif" <faisal.latif@intel.com>,
>"Shiraz Saleem" <shiraz.saleem@intel.com>, "Bernard Metzler"
><bmt@zurich.ibm.com>, "Kamal Heib" <kheib@redhat.com>,
>linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
>Subject: [EXTERNAL] [PATCH V4] RDMA/siw: Convert siw_tx_hdt() to
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
>m=3D01QnZvj05j7vvgDChewVpHJlDytiIFuttai7VRUdJMs&s=3DzS4nDlvF_3MDi9wu7GaL6
>qooDhiboqP5ii5ozBeDpLE&e=3D=20
>
>Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>
>---
>Changes for V4:
>	From Bernard
>		Further optimize siw_unmap_pages() by eliminating the
>		CRC page from the iov array.
>
>Changes for V3:
>	From Bernard
>		Use 'p' in kmap_local_page()
>		Use seg as length to siw_unmap_pages()
>
>Changes for V2:
>	From Bernard
>		Reuse iov[].iov_base rather than declaring another array
>		of pointers and preserve the use of kmap_mask to know
>		which iov's were kmapped.
>---
> drivers/infiniband/sw/siw/siw_qp_tx.c | 30
>+++++++++++++++++----------
> 1 file changed, 19 insertions(+), 11 deletions(-)
>
>diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c
>b/drivers/infiniband/sw/siw/siw_qp_tx.c
>index db68a10d12cd..1f4e60257700 100644
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
>+					siw_unmap_pages(iov, kmap_mask, seg);
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
>+					void *kaddr =3D kmap_local_page(p);
>=20
> 					/* Remember for later kunmap() */
> 					kmap_mask |=3D BIT(seg);
>+					iov[seg].iov_base =3D kaddr + fp_off;
>+					iov[seg].iov_len =3D plen;
>=20
> 					if (do_crc)
> 						crypto_shash_update(
>@@ -542,7 +550,7 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx,
>struct socket *s)
>=20
> 			if (++seg > (int)MAX_ARRAY) {
> 				siw_dbg_qp(tx_qp(c_tx), "to many fragments\n");
>-				siw_unmap_pages(page_array, kmap_mask);
>+				siw_unmap_pages(iov, kmap_mask, seg-1);
> 				wqe->processed -=3D c_tx->bytes_unsent;
> 				rv =3D -EMSGSIZE;
> 				goto done_crc;
>@@ -593,7 +601,7 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx,
>struct socket *s)
> 	} else {
> 		rv =3D kernel_sendmsg(s, &msg, iov, seg + 1,
> 				    hdr_len + data_len + trl_len);
>-		siw_unmap_pages(page_array, kmap_mask);
>+		siw_unmap_pages(iov, kmap_mask, seg);
> 	}
> 	if (rv < (int)hdr_len) {
> 		/* Not even complete hdr pushed or negative rv */
>--=20
>2.28.0.rc0.12.gb6a658bd00c9
>
>
Sry my misconfigured email attached some HTML crap. So I did not
reach the list.

Tested V4 which works as intended. Thanks, Ira!

Reviewed-by: Bernard Metzler <bmt@zurich.ibm.com>
