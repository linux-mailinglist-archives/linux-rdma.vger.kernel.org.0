Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81575302B4
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2019 21:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbfE3TTx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 May 2019 15:19:53 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47286 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfE3TTx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 May 2019 15:19:53 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4UJEEM9029359;
        Thu, 30 May 2019 19:19:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=1x8Nj/QBNm3NEUcqK5KyvxJiUHcpL5ryqzxJhslXL1o=;
 b=Ph+9O1hPipAwhorLe+0+vhMEOnj3hREYrUol9kzlYsDMn5z/jTWHS6sJfhk/UstBbtEk
 RnfsOAcwEJndlZ0k19CwuUe14COjqtchotwOiR7S8TBeNrLhto9CFtx5xq4YSVZHZVP8
 dfSe3AV69xvBFKrNxya6h/gGYTbS849FXVUo0XIY4NpfpZnWx19QCYtBl8V+OgZ22f23
 0hBA73wV5CiPKr4y5mWWmU9W8kF0G+nuCM9xocURiGVlw7FLINM1BOgFGsuPiIEFvplb
 5Pr0Y0qe2XFFGpBydvlMr0lzPAUjKtynmdMF2vd5cZjXX3lTNcl4FK1ggrjeVHOHTraP RA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2spw4tt81p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 19:19:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4UJHP7J066843;
        Thu, 30 May 2019 19:19:14 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2ss1fp8wgc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 19:19:14 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4UJJCHl010458;
        Thu, 30 May 2019 19:19:12 GMT
Received: from lap1 (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 May 2019 12:19:11 -0700
Date:   Thu, 30 May 2019 22:19:07 +0300
From:   Yuval Shaia <yuval.shaia@oracle.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Michal Kalderon <mkalderon@marvell.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v3 rdma-core] verbs: Introduce a new reg_mr API for
 virtual address space
Message-ID: <20190530191906.GA25962@lap1>
References: <20190530060539.7136-1-yuval.shaia@oracle.com>
 <MN2PR18MB3182E08DB0E164C6BE6C409FA1180@MN2PR18MB3182.namprd18.prod.outlook.com>
 <20190530143452.GA19236@lap1>
 <20190530181717.GP13461@mellanox.com>
 <20190530185608.GA25754@lap1>
 <20190530185737.GG13475@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530185737.GG13475@ziepe.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9273 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905300135
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9273 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905300135
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 30, 2019 at 03:57:37PM -0300, Jason Gunthorpe wrote:
> On Thu, May 30, 2019 at 09:56:09PM +0300, Yuval Shaia wrote:
> > On Thu, May 30, 2019 at 06:17:21PM +0000, Jason Gunthorpe wrote:
> > > On Thu, May 30, 2019 at 05:34:53PM +0300, Yuval Shaia wrote:
> > > > On Thu, May 30, 2019 at 12:37:18PM +0000, Michal Kalderon wrote:
> > > > > > From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> > > > > > owner@vger.kernel.org> On Behalf Of Yuval Shaia
> > > > > > 
> > > > > > The virtual address that is registered is used as a base for any address passed
> > > > > > later in post_recv and post_send operations.
> > > > > > 
> > > > > > On a virtualized environment this is not correct.
> > > > > > 
> > > > > > A guest cannot register its memory so hypervisor maps the guest physical
> > > > > > address to a host virtual address and register it with the HW. Later on, at
> > > > > > datapath phase, the guest fills the SGEs with addresses from its address
> > > > > > space.
> > > > > > Since HW cannot access guest virtual address space an extra translation is
> > > > > > needed to map those addresses to be based on the host virtual address that
> > > > > > was registered with the HW.
> > > > > > This datapath interference affects performances.
> > > > > > 
> > > > > > To avoid this, a logical separation between the address that is registered and
> > > > > > the address that is used as a offset at datapath phase is needed.
> > > > > > This separation is already implemented in the lower layer part
> > > > > > (ibv_cmd_reg_mr) but blocked at the API level.
> > > > > > 
> > > > > > Fix it by introducing a new API function which accepts an address from guest
> > > > > > virtual address space as well, to be used as offset for later datapath
> > > > > > operations.
> > > > > > 
> > > > > Could you give an example of how an app would use this new API? How will
> > > > > It receive the new hca_va addresss ? 
> > > > 
> > > > In my use case an application is device emulation that runs in the context
> > > > of a userspace process in the host.
> > > > This (virtual) device receives from guest driver a dma address (in form of
> > > > scatter-gather list) along with guest user-space virtual address. 
> > > 
> > > How do you handle the scatter-gather list?
> > 
> > Well, it is not exactly scatter-gather, lets think of it as an array of
> > guest dma addresses, in mellanox terms it is mtt, in vmware it is page
> > directory.
> > So i guess your question is how to register list of scattered addresses,
> > right?
> 
> Yes..
> 
> I've always thought we should have an API to do that.

Yeah, we had this discussion at RDMA Plumbers two years ago. Then comes a
RFC from Mellanox suggesting a generic way to register non-contiguous
memory but i didn't saw any progress on that.

Anyway, what i did is to create an "alias" to first address using mremap
system call. This new address points to a buffer of size of the sum of
sizes of all buffers in the array. Then loop on the array and with a
different use of mremap to map each entry to the corresponding offset in
the big contiguous address. This way i have a contiguous virtual address
that can be registered as MR.
Hope i was able to explain the flow. If needed i can share the code.

> 
> Jason
