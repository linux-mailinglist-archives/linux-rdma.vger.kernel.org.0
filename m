Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16E3D2BF76
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2019 08:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbfE1Gbs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 May 2019 02:31:48 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50566 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfE1Gbr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 May 2019 02:31:47 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4S6OE5A012325;
        Tue, 28 May 2019 06:31:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=Q8UKmowVwXJBqB8tiS2WKx4+mhdIvZaSXeTQm2opsd4=;
 b=NPmyojb7Rod5pwoS9Hx301aaamCXe3iKBAAk1hD7qmMUlHKP2+dn4IpML7hh7YDofBtg
 8TEOBZRMUts2Wfl9yvclTJ/rEeQECeIC5dTfcixPfduLQ/nxjP2qZXF83BM8tMwjE+S3
 903sfAQOrwOYYdaB0NYkhHXSIwDQCeRzjvCQ+Xe0XvekkL0fIiN2h/uXKXAmu0OPG3tq
 SYmFo2U+hoWjfcz3pXVOeXU5RQtHAkNcyl6Ei5SIPKXQTbUnqvhPw9rjle96UI5f37fd
 jixrGdCY5nt3ZyurmLNz75DIYuAyBBDgXt2O1T9fzmCKDBPLXglcQATWfZTjJfP/RuLs MA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2spxbq0p6d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 May 2019 06:31:03 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4S6TuaC056123;
        Tue, 28 May 2019 06:31:03 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2sr31ug0cw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 May 2019 06:31:03 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4S6V1BV028394;
        Tue, 28 May 2019 06:31:01 GMT
Received: from lap1 (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 27 May 2019 23:31:00 -0700
Date:   Tue, 28 May 2019 09:30:56 +0300
From:   Yuval Shaia <yuval.shaia@oracle.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     yishaih@mellanox.com, dledford@redhat.com, leon@kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-core] verbs: Introduce a new reg_mr API for virtual
 address space
Message-ID: <20190528063055.GA2558@lap1>
References: <20190527150004.21191-1-yuval.shaia@oracle.com>
 <20190527182219.GF18100@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527182219.GF18100@ziepe.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9270 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905280044
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9270 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905280044
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 27, 2019 at 03:22:20PM -0300, Jason Gunthorpe wrote:
> On Mon, May 27, 2019 at 06:00:04PM +0300, Yuval Shaia wrote:
> > The virtual address that is registered is used as a base for any address
> > used later in post_recv and post_send operations.
> > 
> > On a virtualised environment this is not correct.
> > 
> > A guest cannot register its memory so hypervisor maps the guest physical
> > address to a host virtual address and register it with the HW. Later on,
> > at datapath phase, the guest fills the SGEs with addresses from its
> > address space.
> > Since HW cannot access guest virtual address space an extra translation
> > is needed to map those addresses to be based on the host virtual address
> > that was registered with the HW.
> > 
> > To avoid this, a logical separation between the address that is
> > registered and the address that is used as a offset at datapath phase is
> > needed.
> > 
> > This separation is already implemented in the lower layer part
> > (ibv_cmd_reg_mr) but blocked at the API level.
> > 
> > Fix it by introducing a new API function that accepts a address from
> > guest virtual address space as well.
> > 
> > Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> >  libibverbs/verbs.c | 24 ++++++++++++++++++++++++
> >  libibverbs/verbs.h |  6 ++++++
> >  2 files changed, 30 insertions(+)
> > 
> > diff --git a/libibverbs/verbs.c b/libibverbs/verbs.c
> > index 1766b9f5..9ad74ee0 100644
> > +++ b/libibverbs/verbs.c
> > @@ -324,6 +324,30 @@ LATEST_SYMVER_FUNC(ibv_reg_mr, 1_1, "IBVERBS_1.1",
> >  	return mr;
> >  }
> >  
> > +LATEST_SYMVER_FUNC(ibv_reg_mr_virt_as, 1_1, "IBVERBS_1.1",
> > +		   struct ibv_mr *,
> > +		   struct ibv_pd *pd, void *addr, size_t length,
> > +		   uint64_t hca_va, int access)
> > +{
> 
> Doesn't need this macro since it doesn't have a compat version

That is weird, without this it fails in link stage.

/usr/bin/ld: hw/rdma/rdma_backend.o: in function `rdma_backend_create_mr':
rdma_backend.c:(.text+0x260a): undefined reference to `ibv_reg_mr_virt_as'
collect2: error: ld returned 1 exit status

> 
> > +	struct verbs_mr *vmr;
> > +	struct ibv_reg_mr cmd;
> > +	struct ib_uverbs_reg_mr_resp resp;
> > +	int ret;
> > +
> > +	vmr = malloc(sizeof(*vmr));
> > +	if (!vmr)
> > +		return NULL;
> > +
> > +	ret = ibv_cmd_reg_mr(pd, addr, length, hca_va, access, vmr, &cmd,
> > +			     sizeof(cmd), &resp, sizeof(resp));
> 
> It seems problematic not to call the driver, several of the drivers
> are wrappering mr in their own type (ie bnxt_re_mr) and we can't just
> allocate the wrong size of memory here.
> 
> What you should do is modify the existing driver callback to accept
> another argument and go and fix all the drivers to pass that argument
> into their ibv_cmd_reg_mr as the hca_va above. This looks pretty
> trivial.

So back to what was proposed in the RFC besides the addition of new arg
instead of new callback, right?

> 
> Jason
