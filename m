Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 753D8F2D96
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Nov 2019 12:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbfKGLk2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Nov 2019 06:40:28 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:53298 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbfKGLk2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Nov 2019 06:40:28 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA7BYHVa075848;
        Thu, 7 Nov 2019 11:40:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=YoU6jtG1ySY1uPxHBuKNU3IbhZ3lECJn7QO9JFRyqtc=;
 b=dVSTo6iDSzDKCzz5rQmEFcOGdGiqHk/ug5P6CUiWhzjX9/Sp+IXybhNvI1sX6Q+uWZDj
 c2tKvO/E6ZXRP9moTS0Pfzsj1Y6GASZ/E+TPXfSYOyEV34tLgwTUP/k4lHj8dqNX9baN
 hHBYrKVmfVFQylE1AaOcQX853Ti0nEx+PG6baZIHnQmgBfae2cF6YwKbgFYtomo3IIc/
 MWM2K2hpUHZNeg8eqYGPLpLYvgQt4zv5YpppVR8k2TRFYq+oU3uvX0rOyi81jDOAHiIY
 Xnrp6vQud+PRcqufTY8EabNA9y7Kz+LftiO+I9NYFZRT1Rdb6P28ucpl8s+F2waB88Bb Jw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2w41w15gkc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Nov 2019 11:40:25 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA7BdxQe073830;
        Thu, 7 Nov 2019 11:40:24 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2w41whr2ne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Nov 2019 11:40:21 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA7BeJMY025504;
        Thu, 7 Nov 2019 11:40:20 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 07 Nov 2019 03:40:18 -0800
Date:   Thu, 7 Nov 2019 14:40:10 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     michal.kalderon@marvell.com, linux-rdma@vger.kernel.org
Subject: Re: [bug report] RDMA/qedr: Add doorbell overflow recovery support
Message-ID: <20191107114009.GL21796@kadam>
References: <20191106075259.GA22565@mwanda>
 <20191106153857.GB15851@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106153857.GB15851@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9433 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=912
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911070119
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9433 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=989 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911070118
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 06, 2019 at 11:38:57AM -0400, Jason Gunthorpe wrote:
> >    959                  rc = qedr_init_user_queue(udata, dev, &cq->q, ureq.addr,
> >    960                                            ureq.len, true,
> >    961                                            IB_ACCESS_LOCAL_WRITE,
> >    962                                            1, 1);
> >    963                  if (rc)
> >    964                          goto err0;
> >    965  
> >    966                  pbl_ptr = cq->q.pbl_tbl->pa;
> >    967                  page_cnt = cq->q.pbl_info.num_pbes;
> >    968  
> >    969			cq->ibcq.cqe = chain_entries;
> >    970			cq->q.db_addr = ctx->dpi_addr + db_offset;
> >                                         ^^^^^^^^^^^^^
> > New unchecked dereference.
> 
> For rdma_udata_to_drv_context(), udata != NULL implies ctx != NULL
> 

In that case, the other check for NULL ctx is inside an if (udata)
condition so it could be removed.

  1036		return 0;
  1037	
  1038	err2:
  1039		destroy_iparams.icid = cq->icid;
  1040		dev->ops->rdma_destroy_cq(dev->rdma_ctx, &destroy_iparams,
  1041					  &destroy_oparams);
  1042	err1:
  1043		if (udata) {
                    ^^^^^
  1044			qedr_free_pbl(dev, &cq->q.pbl_info, cq->q.pbl_tbl);
  1045			ib_umem_release(cq->q.umem);
  1046			if (ctx)
                            ^^^
Too late.

  1047				rdma_user_mmap_entry_remove(&ctx->ibucontext,
  1048							    cq->q.db_mmap_entry);




regards,
dan carpenter


