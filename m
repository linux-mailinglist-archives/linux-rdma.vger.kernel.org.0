Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADD0519DE57
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Apr 2020 21:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgDCTHX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Apr 2020 15:07:23 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52460 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgDCTHX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Apr 2020 15:07:23 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 033J3c9p138466;
        Fri, 3 Apr 2020 19:07:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=AmS89nPeF++QTAUZauONAus722J+38nAEpLpE/0Imfg=;
 b=DZiVukd7W3ygpBq7phPg1FBK2kT8UOYvakuv7lxzYsWLCkRQJJszFpelSrB4BNbj6qy5
 UMLHTt4zWeWAskwnKYmyLCNPoIXgapDaB5JFzdnD6RMDE64uCfBQvE6O03CgL5K/g6kz
 4d/66iUdauOWlZcl9JuEz76IYN2k/e8SmWa/7M7wvOau5p5JtsrYseCSONME5bdKBMlK
 cJNdujCq6VmiZuhtrxf9S6CNcGh87PitymjHUi9SXuWl+zhL3hhLRfRIs8jUPbfcD4OA
 7L2r/wJ9C6XBxyqFUSidzPGKl7tZOd0QPgTTU6E/WWDRgv0WfryLu34Phmz+OeluaOzz 5A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 303cevjrut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Apr 2020 19:07:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 033J6PJN183755;
        Fri, 3 Apr 2020 19:07:15 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 302g4y12ec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Apr 2020 19:07:15 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 033J7DLH002489;
        Fri, 3 Apr 2020 19:07:14 GMT
Received: from dhcp-10-175-182-241.vpn.oracle.com (/10.175.182.241)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 03 Apr 2020 12:07:13 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH for-rc] RDMA/cma: fix race between addr_handler and
 resolve_route
From:   =?utf-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
In-Reply-To: <20200403185707.GE8514@mellanox.com>
Date:   Fri, 3 Apr 2020 21:07:10 +0200
Cc:     syzbot+69226cc89d87fd4f8f40@syzkaller.appspotmail.com,
        Doug Ledford <dledford@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        george kennedy <george.kennedy@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1720C7BF-D6E4-4779-B05D-203703042B36@oracle.com>
References: <20200403184328.1154929-1-haakon.bugge@oracle.com>
 <20200403185707.GE8514@mellanox.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9580 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=4
 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=733 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030155
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9580 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 adultscore=0
 clxscore=1011 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 suspectscore=4 mlxscore=0 impostorscore=0 mlxlogscore=795 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030154
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On 3 Apr 2020, at 20:57, Jason Gunthorpe <jgg@mellanox.com> wrote:
>=20
> On Fri, Apr 03, 2020 at 08:43:28PM +0200, H=C3=A5kon Bugge wrote:
>> A syzkaller test hits a NULL pointer dereference in
>> rdma_resolve_route():
>=20
> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git =
for-next
>=20
> This commit in 5.7 probably fixes this:

I think it will not. The mutex in 7c11910783a1 ("RDMA/ucma: Put a lock =
around every call to the rdma_cm layer") will not prevent addr_handler() =
to run concurrently with rdma_resolve_route(), right?

And, I also suspect 7c11910783a1 to have major performance impact. But, =
that's a different story.


Thxs, H=C3=A5kon




>=20
> commit 7c11910783a1ea17e88777552ef146cace607b3c
> Author: Jason Gunthorpe <jgg@ziepe.ca>
> Date:   Tue Feb 18 15:45:38 2020 -0400
>=20
>    RDMA/ucma: Put a lock around every call to the rdma_cm layer
>=20
>=20
> Lets find out.
>=20
> Jason

