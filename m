Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE5F1CEEF4
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2020 10:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbgELIRX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 May 2020 04:17:23 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59044 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgELIRW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 May 2020 04:17:22 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04C88Rh5158523;
        Tue, 12 May 2020 08:17:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=Wtx+Im5F71V8RatK2uIv9RRgCiFIudT/bKBzgs/sGXg=;
 b=nok1386cXMS6Oe+Zkr8IKuydliXujlazuBGl2LfAdxEjgLc6SLo00Kb3IBJYW6C2WY7u
 BTXT5SxRj/XX8WB4YisKBRnazxN3CND40C2XbwkKrcdDG4GoxGHQ6x8LfXCTtnOpNAcw
 ALPRc0V8pClr7wevKzCuUicaejs3Hi8DD4qZI34JRNkAERQcZ6gPVOt6BERM4VM7VnVW
 n7gxEm7DwFSVodq+b9XOZBOLFyTp+KraSV9oawPkp+KlwQdRDsmpTwJAe+9/HCB280t1
 u/m73MBOYGNGcg8WPzXwv8aTMdaB/WEFvAGVOic+IgBz5LMoP8WH+BVpCyqWRxA5aFAU ww== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 30x3gmhgnq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 May 2020 08:17:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04C8DvgB137018;
        Tue, 12 May 2020 08:17:14 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 30ydspya4k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 May 2020 08:17:14 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04C8HD7M010693;
        Tue, 12 May 2020 08:17:13 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 May 2020 01:17:12 -0700
Date:   Tue, 12 May 2020 11:17:06 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Zhu Yanjun <yanjunz@mellanox.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/rxe: Return -EFAULT if copy_from_user() fails
Message-ID: <20200512081706.GJ9365@kadam>
References: <20200511183742.GB225608@mwanda>
 <20200512062936.GE4814@unreal>
 <20200512070203.GG4814@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512070203.GG4814@unreal>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005120070
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 clxscore=1015 spamscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005120069
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 12, 2020 at 10:02:03AM +0300, Leon Romanovsky wrote:
> On Tue, May 12, 2020 at 09:29:36AM +0300, Leon Romanovsky wrote:
> > On Mon, May 11, 2020 at 09:37:42PM +0300, Dan Carpenter wrote:
> > > This function used to always return -EINVAL but we updated it to try
> > > preserve the error codes.  Unfortunately the copy_to_user() is returning
> > > the number of bytes remaining to be copied instead of a negative error
> > > code.
> > >
> > > Fixes: a3a974b4654d ("RDMA/rxe: Always return ERR_PTR from rxe_create_mmap_info()")
> > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > ---
> > >  drivers/infiniband/sw/rxe/rxe_queue.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> >
> > Thanks,
> > Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
> 
> Actually Yanjun is right and "err" can be removed.
> 
> Thanks

I don't know if the code you guys are looking at is older or newer than
linux-next...  :P

drivers/infiniband/sw/rxe/rxe_queue.c
    39  int do_mmap_info(struct rxe_dev *rxe, struct mminfo __user *outbuf,
    40                   struct ib_udata *udata, struct rxe_queue_buf *buf,
    41                   size_t buf_size, struct rxe_mmap_info **ip_p)
    42  {
    43          int err;
                    ^^^

    44          struct rxe_mmap_info *ip = NULL;
    45  
    46          if (outbuf) {
    47                  ip = rxe_create_mmap_info(rxe, buf_size, udata, buf);
    48                  if (IS_ERR(ip)) {
    49                          err = PTR_ERR(ip);
    50                          goto err1;
                                ^^^^^^^^^
    51                  }
    52  
    53                  err = copy_to_user(outbuf, &ip->info, sizeof(ip->info));
    54                  if (err)
    55                          goto err2;
                                ^^^^^^^^^
    56  
    57                  spin_lock_bh(&rxe->pending_lock);
    58                  list_add(&ip->pending_mmaps, &rxe->pending_mmaps);
    59                  spin_unlock_bh(&rxe->pending_lock);
    60          }
    61  
    62          *ip_p = ip;
    63  
    64          return 0;
    65  
    66  err2:
    67          kfree(ip);
    68  err1:
    69          return err;
                       ^^^
    70  }

regards,
dan carpenter
