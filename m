Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38A82DBC8
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Apr 2019 08:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfD2GJ4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Apr 2019 02:09:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54122 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726566AbfD2GJz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 29 Apr 2019 02:09:55 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3T64KB2107007
        for <linux-rdma@vger.kernel.org>; Mon, 29 Apr 2019 02:09:54 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s5tjwjah9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Mon, 29 Apr 2019 02:09:54 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-rdma@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Mon, 29 Apr 2019 07:09:52 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 29 Apr 2019 07:09:49 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3T69mUg32309268
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Apr 2019 06:09:48 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B65F852052;
        Mon, 29 Apr 2019 06:09:48 +0000 (GMT)
Received: from osiris (unknown [9.152.212.21])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 75C1D52057;
        Mon, 29 Apr 2019 06:09:48 +0000 (GMT)
Date:   Mon, 29 Apr 2019 08:09:47 +0200
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
References: <20190428115207.GA11924@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190428115207.GA11924@ziepe.ca>
X-TM-AS-GCONF: 00
x-cbid: 19042906-4275-0000-0000-0000032F6605
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042906-4276-0000-0000-0000383EB9F7
Message-Id: <20190429060947.GB3665@osiris>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-29_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=932 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904290047
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Apr 28, 2019 at 11:52:12AM +0000, Jason Gunthorpe wrote:
> Hi Linus,
> 
> Third rc pull request
> 
> Nothing particularly special here. There is a small merge conflict
> with Adrea's mm_still_valid patches which is resolved as below:
...
> Jason Gunthorpe (3):
>       RDMA/mlx5: Do not allow the user to write to the clock page
>       RDMA/mlx5: Use rdma_user_map_io for mapping BAR pages
>       RDMA/ucontext: Fix regression with disassociate

This doesn't compile. The patch below would fix it, but not sure if
this is what is intended:

drivers/infiniband/core/uverbs_main.c: In function 'rdma_umap_fault':
drivers/infiniband/core/uverbs_main.c:898:28: error: 'struct vm_fault' has no member named 'vm_start'
   vmf->page = ZERO_PAGE(vmf->vm_start);
                            ^~
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index 7843e89235c3..65fe89b3fa2d 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -895,7 +895,7 @@ static vm_fault_t rdma_umap_fault(struct vm_fault *vmf)
 
 	/* Read only pages can just use the system zero page. */
 	if (!(vmf->vma->vm_flags & (VM_WRITE | VM_MAYWRITE))) {
-		vmf->page = ZERO_PAGE(vmf->vm_start);
+		vmf->page = ZERO_PAGE(vmf->vma->vm_start);
 		get_page(vmf->page);
 		return 0;
 	}

