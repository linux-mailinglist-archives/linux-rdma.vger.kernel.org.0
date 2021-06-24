Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCFC33B32C8
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Jun 2021 17:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhFXPse (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Jun 2021 11:48:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35216 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230008AbhFXPse (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 24 Jun 2021 11:48:34 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15OFXU3R166092;
        Thu, 24 Jun 2021 11:46:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : references
 : subject : from : to : cc : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=GTf/wIA+GOLBkcCd7PTLrFPYGf0o/+/FVq2Lq2hzxMw=;
 b=JFvGNsQI+niIjYbeJCcj7FuX1A5YdVRet6FI4MMiKDJssQyaR5LcdhxyA4Bv+WQe2wE/
 meoWXchckfmwFK+x+rHRtLB7Z6dOiQIdbLHyZZIVtGmbLFZNxzU08Fc0SyxolYQmFdT0
 KMt3XLzZkYKAS6t/+5vklDXHJlhteMJKoqd1Wc5PFLwWeuUeyQChj6FZdZ+N/10kkfC2
 Ye0svkuSdpUxEuC+oWPMkyn2pz9v8l/OxcBiX8yjd497Clo0A0mBv/39E4TEV9X0uwS9
 hErvnPM7yeoTzUbtHduu7a4UT2iwBynHeQfEehkvg1CAfwhM1ZJ0gKogGfPVL/3nU0BT ug== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39cttkdqsx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Jun 2021 11:46:12 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15OFhBN1014581;
        Thu, 24 Jun 2021 15:46:10 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04fra.de.ibm.com with ESMTP id 399878sf52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Jun 2021 15:46:10 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15OFk8kM29163808
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Jun 2021 15:46:08 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B3E8A405F;
        Thu, 24 Jun 2021 15:46:08 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D21AAA4060;
        Thu, 24 Jun 2021 15:46:07 +0000 (GMT)
Received: from PGAAMSML35001.SL.BLUECLOUD.IBM.COM (unknown [9.209.254.249])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 24 Jun 2021 15:46:07 +0000 (GMT)
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
In-Reply-To: <20210623221543.2799198-1-ira.weiny@intel.com>
References: <20210623221543.2799198-1-ira.weiny@intel.com>,
        <20210622203432.2715659-1-ira.weiny@intel.com>
Subject: Re: [PATCH V3] RDMA/siw: Convert siw_tx_hdt() to kmap_local_page()
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
Date:   Thu, 24 Jun 2021 15:45:55 +0000
Message-ID: <OF739F2480.B35209F8-ON002586FE.00569A1A-002586FE.00569A24@ch.ibm.com>
X-Mailer: Lotus Domino Web Server Release 11.0.1FP2HF88   April 28, 2021
X-MIMETrack: Serialize by http on MWW0302/03/M/IBM at 06/24/2021 15:45:55,
        Serialize complete at 06/24/2021 15:45:55,
        Serialize by Router on D06ML350/06/M/IBM(Release 11.0.1FP2|October 20, 2020) at
 24/06/2021 17:54:48
X-KeepSent: 739F2480:B35209F8-002586FE:00569A1A;
 type=4; name=$KeepSent
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XR0H147IF_vKQ-yeu83WcKZayLopHI9u
X-Proofpoint-ORIG-GUID: XR0H147IF_vKQ-yeu83WcKZayLopHI9u
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-24_12:2021-06-24,2021-06-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 mlxscore=0
 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106240086
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


-----ira.weiny@intel.com wrote: -----

>To: "Jason Gunthorpe" <jgg@ziepe.ca>
>From: ira.weiny@intel.com
>Date: 06/24/2021 12:16AM
>Cc: "Ira Weiny" <ira.weiny@intel.com>, "Mike Marciniszyn"
><mike.marciniszyn@cornelisnetworks.com>, "Dennis Dalessandro"
><dennis.dalessandro@cornelisnetworks.com>, "Doug Ledford"
><dledford@redhat.com>, "Faisal Latif" <faisal.latif@intel.com>,
>"Shiraz Saleem" <shiraz.saleem@intel.com>, "Bernard Metzler"
><bmt@zurich.ibm.com>, "Kamal Heib" <kheib@redhat.com>,
>linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
>Subject: [EXTERNAL] [PATCH V3] RDMA/siw: Convert siw_tx_hdt() to
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
>m=3DeI4Db7iSlEKRl4l5pYKwY5rL5WXWWxahhxNciwy2lRA&s=3Dvo11VhOvYbAkABdhV6htX
>TmXgFZeWbBZAFnPDvg7Bzs&e=3D=20
>
>Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>
>---
>Jason, I went ahead and left this a separate patch.  Let me know if
>you really
>want this and the other siw squashed.
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
>index db68a10d12cd..89a5b75f7254 100644
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
>+		siw_unmap_pages(iov, kmap_mask, seg+1);

seg+1 is one to many, since the last segment references the iWarp
trailer (CRC). There are 2 reason for this multi-segment processing
in the transmit path. (1) efficiency and (2) MTU based packet framing.
The iov contains the complete iWarp frame with header, (potentially
multiple) data fragments, and the CRC. It gets pushed to TCP in one
go, praying for iWarp framing stays intact (which most time works).
So the code can collect data form multiple SGE's of a WRITE or
SEND and tries putting those into one frame, if MTU allows, and
adds header and trailer.=20
The last segment (seg + 1) references the CRC, which is never kmap'ed.

I'll try the code next days, but it looks good otherwise!

Thanks very much!
> 	}
> 	if (rv < (int)hdr_len) {
> 		/* Not even complete hdr pushed or negative rv */
>--=20
>2.28.0.rc0.12.gb6a658bd00c9
>
>
