Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFFB487921
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2019 14:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406285AbfHIL77 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Aug 2019 07:59:59 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34166 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406197AbfHIL77 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Aug 2019 07:59:59 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x79BxBFc148755;
        Fri, 9 Aug 2019 11:59:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=t/Rfi3thiR2wurHxgDPr7uMaYadK0eb1zFCtDv3IqcA=;
 b=kuPsTHVaUxz8nkqHb/2XSf/nFA7hvbPubpmwPmPrIqLibFB6Dkz2pdGVLCChBGE5hCJo
 aODbcaPuKESKDH8V+5k6ayeCaO08YmyYoeVBrtT/O64lE1UwfdzDN8b473uQckvJajnV
 jCMEjktFOWD7X5AtgcfI8TxTEATaXpkwmnVFcngbayMnRku3PzVbHr+GKECfnPw7J3vd
 KHA95r8IRP3bp4Sa3gzjLP/VNkLPDWk3+ulwUKn5nlOHv5hBg5fkrA1g5qUKJjcfR7Sx
 ZJ2gJIa+LnfbI1p8HUUB9M0j40vcboHrORocDy+qOaxe2QLc8Xm1W9VMR91RQMYtUsV8 Tg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=t/Rfi3thiR2wurHxgDPr7uMaYadK0eb1zFCtDv3IqcA=;
 b=IR1srG5WQ3n0A01xvFSi1yKH5w5YpRiAW58WKaKvXAIZmhBIvpTlOt/Uul3GdKGohHtc
 fDQ+zGOJzTsmeB91YhWiwOQ0uvpll6gTG+yZFmrD04DXOqVRRtB7xUSMcFVAsmpMmyRb
 Pefay0WMFAnfNUw0w8FkhrK+DNtrpQptre+Y7DiXPAnuVriKk6iguZir6nOXw6KzF8SF
 Okpx0D2Q/QBcjkDTOIu+rf/7q463O04IBy5Si3hR8OcSarTwN/XKi3NuaE0Aul3lMY9M
 z4La3XnDn2Gz3QZxtC2QuAZBFUp3z0kB3NPSzerDu+z9wFJut0/MuTL5BiA39j7tHhad OQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2u8hgp71u5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Aug 2019 11:59:48 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x79BvX38057854;
        Fri, 9 Aug 2019 11:59:47 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2u8x1gpn9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Aug 2019 11:59:47 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x79BxjGE029926;
        Fri, 9 Aug 2019 11:59:45 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 09 Aug 2019 04:59:44 -0700
Date:   Fri, 9 Aug 2019 14:59:36 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/siw: Fix a memory leak in siw_init_cpulist()
Message-ID: <20190809115936.GR1974@kadam>
References: <20190809101619.GB17867@mwanda>
 <OF1431A46D.4DAAB987-ON00258451.003E917F-00258451.0040859B@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF1431A46D.4DAAB987-ON00258451.003E917F-00258451.0040859B@notes.na.collabserv.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9343 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908090125
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9343 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908090125
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 09, 2019 at 11:44:45AM +0000, Bernard Metzler wrote:
> -----"Dan Carpenter" <dan.carpenter@oracle.com> wrote: -----
> 
> >To: "Bernard Metzler" <bmt@zurich.ibm.com>
> >From: "Dan Carpenter" <dan.carpenter@oracle.com>
> >Date: 08/09/2019 12:16PM
> >Cc: "Doug Ledford" <dledford@redhat.com>, "Jason Gunthorpe"
> ><jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
> >kernel-janitors@vger.kernel.org
> >Subject: [EXTERNAL] [PATCH] RDMA/siw: Fix a memory leak in
> >siw_init_cpulist()
> >
> >The error handling code doesn't free siw_cpu_info.tx_valid_cpus[0].
> >The
> >first iteration through the loop is a no-op so this is sort of an off
> >by
> >one bug.
> >
> >Fixes: bdcf26bf9b3a ("rdma/siw: network and RDMA core interface")
> >Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> >---
> > drivers/infiniband/sw/siw/siw_main.c | 4 ++--
> > 1 file changed, 2 insertions(+), 2 deletions(-)
> >
> >diff --git a/drivers/infiniband/sw/siw/siw_main.c
> >b/drivers/infiniband/sw/siw/siw_main.c
> >index d0f140daf659..95ace3967391 100644
> >--- a/drivers/infiniband/sw/siw/siw_main.c
> >+++ b/drivers/infiniband/sw/siw/siw_main.c
> >@@ -160,9 +160,9 @@ static int siw_init_cpulist(void)
> > 
> > out_err:
> > 	siw_cpu_info.num_nodes = 0;
> >-	while (i) {
> >+	while (--i >= 0) {
> > 		kfree(siw_cpu_info.tx_valid_cpus[i]);
> >-		siw_cpu_info.tx_valid_cpus[i--] = NULL;
> >+		siw_cpu_info.tx_valid_cpus[i] = NULL;
> > 	}
> > 	kfree(siw_cpu_info.tx_valid_cpus);
> > 	siw_cpu_info.tx_valid_cpus = NULL;
> >-- 
> >2.20.1
> >
> >
> Dan, many thanks for catching this one!
> 
> I suggest you provide an even simpler fix, taking the 
> chance to remove the redundant
> "siw_cpu_info.tx_valid_cpus[i] = NULL;" line (since
> the whole structure gets kfree'd a line further
> down...).
> This shall be suffcient:
> 
> -	while (i) {
> +	while (--i >= 0)
>  		kfree(siw_cpu_info.tx_valid_cpus[i]);
> -		siw_cpu_info.tx_valid_cpus[i--] = NULL;

Yeah that's a good point.  I'll resend.

regards,
dan carpenter

