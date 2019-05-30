Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3C4A30273
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2019 20:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfE3S42 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 May 2019 14:56:28 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38194 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfE3S42 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 May 2019 14:56:28 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4UImoLe014354;
        Thu, 30 May 2019 18:56:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=99h6cjxXzBImmdRfohErDSFVG0U3Sx22RBv7brSpZdA=;
 b=wdu6xKEkji/ky01NJhsw3A4EGXX1W8pdFbXyQ62LBZ4tTYF0Owu6mZPaIQJ2QuovS3Bf
 noorKFdCkWICqC/iE3rA086Fu7PMZnqS5HhV9bC8WssrczOhF3vDZBl+OmBJ8JwC2Qu7
 FptJ9mdv/ON+zgiAXS8yE9aodZBmSFzdsROrjqNnLo4hPDMEcsg3RV2cQ10w1Ufv9VyE
 zzAKBkYf1uQn9NMO6ZekRuxEPtPkiQYB94cNnlfZ7AllWt+YDOImI8zyE35zg7E21clJ
 stVE0NANcqe9ZCpNZ4+ZEI2W6dOceAaT1hJnk1PIWJnXbS5mBNA1PSdkbdQcVoSUEr0d fg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2spxbqhyt6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 18:56:18 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4UItuEq044698;
        Thu, 30 May 2019 18:56:17 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2srbdy65uq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 18:56:17 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4UIuFqg016046;
        Thu, 30 May 2019 18:56:15 GMT
Received: from lap1 (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 May 2019 11:56:15 -0700
Date:   Thu, 30 May 2019 21:56:09 +0300
From:   Yuval Shaia <yuval.shaia@oracle.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Michal Kalderon <mkalderon@marvell.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v3 rdma-core] verbs: Introduce a new reg_mr API for
 virtual address space
Message-ID: <20190530185608.GA25754@lap1>
References: <20190530060539.7136-1-yuval.shaia@oracle.com>
 <MN2PR18MB3182E08DB0E164C6BE6C409FA1180@MN2PR18MB3182.namprd18.prod.outlook.com>
 <20190530143452.GA19236@lap1>
 <20190530181717.GP13461@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530181717.GP13461@mellanox.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9273 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=816
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905300132
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9273 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=846 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905300132
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 30, 2019 at 06:17:21PM +0000, Jason Gunthorpe wrote:
> On Thu, May 30, 2019 at 05:34:53PM +0300, Yuval Shaia wrote:
> > On Thu, May 30, 2019 at 12:37:18PM +0000, Michal Kalderon wrote:
> > > > From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> > > > owner@vger.kernel.org> On Behalf Of Yuval Shaia
> > > > 
> > > > The virtual address that is registered is used as a base for any address passed
> > > > later in post_recv and post_send operations.
> > > > 
> > > > On a virtualized environment this is not correct.
> > > > 
> > > > A guest cannot register its memory so hypervisor maps the guest physical
> > > > address to a host virtual address and register it with the HW. Later on, at
> > > > datapath phase, the guest fills the SGEs with addresses from its address
> > > > space.
> > > > Since HW cannot access guest virtual address space an extra translation is
> > > > needed to map those addresses to be based on the host virtual address that
> > > > was registered with the HW.
> > > > This datapath interference affects performances.
> > > > 
> > > > To avoid this, a logical separation between the address that is registered and
> > > > the address that is used as a offset at datapath phase is needed.
> > > > This separation is already implemented in the lower layer part
> > > > (ibv_cmd_reg_mr) but blocked at the API level.
> > > > 
> > > > Fix it by introducing a new API function which accepts an address from guest
> > > > virtual address space as well, to be used as offset for later datapath
> > > > operations.
> > > > 
> > > Could you give an example of how an app would use this new API? How will
> > > It receive the new hca_va addresss ? 
> > 
> > In my use case an application is device emulation that runs in the context
> > of a userspace process in the host.
> > This (virtual) device receives from guest driver a dma address (in form of
> > scatter-gather list) along with guest user-space virtual address. 
> 
> How do you handle the scatter-gather list?

Well, it is not exactly scatter-gather, lets think of it as an array of
guest dma addresses, in mellanox terms it is mtt, in vmware it is page
directory.
So i guess your question is how to register list of scattered addresses,
right?

> 
> Jason
