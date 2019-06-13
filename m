Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77BFC44A3A
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2019 20:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfFMSEf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Jun 2019 14:04:35 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33516 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfFMSEf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Jun 2019 14:04:35 -0400
X-Greylist: delayed 3924 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Jun 2019 14:04:34 EDT
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5DGrpok004190;
        Thu, 13 Jun 2019 16:58:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=6+5uOXGUqpVe8l+j2JuRuHJpjiBJEwkfCvYqyjglD9c=;
 b=ticmJkeSwDxOe8hD+GOtaTLPcoKN4trEF+RZaRTAB+fwTqYt0lJIy83KlVY0+AECVtkR
 maulPoWxv3brp4qMdVvw1H6WbqSNRoE1eAnMOmHFN8luyGAVdTys31YUXpkaCy2aHSwF
 Y4NqBPkj8g6koo5XGx+GofBIC5Qo0PCKu36jTVF9JAs9KAp6UnZmdtUVVQf7owQUTddd
 YnSzubeVSWNg9p9BZvI/UumkA029RBlX3ImvrB1+E8REGKg8QY5aOwYzrRX2ApY/J8wx
 R/aWZ/Hu+UIif/4q4z1o1lWQOaB8lAWimBmkpb106QY04C7Kv0JzycaEZ9sJ3TNHLOaT Cw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2t04yntsn2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jun 2019 16:58:40 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5DGviSH038486;
        Thu, 13 Jun 2019 16:58:40 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2t04j0jt0g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jun 2019 16:58:39 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5DGwbtW013038;
        Thu, 13 Jun 2019 16:58:37 GMT
Received: from [192.168.10.144] (/51.175.236.248)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 13 Jun 2019 09:58:37 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2] RDMA/cma: Make CM response timeout and # CM retries
 configurable
From:   =?utf-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
In-Reply-To: <174ccd37a9ffa05d0c7c03fe80ff7170a9270824.camel@redhat.com>
Date:   Thu, 13 Jun 2019 18:58:30 +0200
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Parav Pandit <parav@mellanox.com>,
        Steve Wise <swise@opengridcomputing.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <67B4F337-4C3A-4193-B1EF-42FD4765CBB7@oracle.com>
References: <20190226075722.1692315-1-haakon.bugge@oracle.com>
 <174ccd37a9ffa05d0c7c03fe80ff7170a9270824.camel@redhat.com>
To:     Doug Ledford <dledford@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9287 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906130123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9287 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906130123
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On 13 Jun 2019, at 16:25, Doug Ledford <dledford@redhat.com> wrote:
>=20
> On Tue, 2019-02-26 at 08:57 +0100, H=C3=A5kon Bugge wrote:
>> During certain workloads, the default CM response timeout is too
>> short, leading to excessive retries. Hence, make it configurable
>> through sysctl. While at it, also make number of CM retries
>> configurable.
>>=20
>> The defaults are not changed.
>>=20
>> Signed-off-by: H=C3=A5kon Bugge <haakon.bugge@oracle.com>
>> ---
>> v1 -> v2:
>>   * Added unregister_net_sysctl_table() in cma_cleanup()
>> ---
>> drivers/infiniband/core/cma.c | 52 ++++++++++++++++++++++++++++++---
>> --
>> 1 file changed, 45 insertions(+), 7 deletions(-)
>=20
> This has been sitting on patchworks since forever.  Presumably because
> Jason and I neither one felt like we really wanted it, but also
> couldn't justify flat refusing it.

I thought the agreement was to use NL and iproute2. But I haven't had =
the capacity.

>  Well, I've made up my mind, so
> unless Jason wants to argue the other side, I'm rejecting this patch.=20=

> Here's why.  The whole concept of a timeout is to help recovery in a
> situation that overloads one end of the connection.  There is a
> relationship between the max queue backlog on the one host and the
> timeout on the other host. =20

If you refer to the backlog parameter in rdma_listen(), I cannot see it =
being used at all for IB.

For CX-3, which is paravirtualized wrt. MAD packets, it is the proxy UD =
receive queue length for the PF driver that can be construed as a =
backlog. Remember that any MAD packet being sent from a VF or the PF =
itself, is sent to a proxy UD QP in the PF. Those packets are then =
multiplexed out on the real QP0/1. Incoming MAD packets are =
demultiplexed and sent once more to the proxy QP in the VF.

> Generally, in order for a request to get
> dropped and us to need to retransmit, the queue must already have a
> full backlog.  So, how long does it take a heavily loaded system to
> process a full backlog?  That, plus a fuzz for a margin of error,
> should be our timeout.  We shouldn't be asking users to configure it.

Customer configures #VMs and different workload may lead to way =
different number of CM connections. The proxying of MAD packet through =
the PF driver has a finite packet rate. With 64 VMs, 10.000 QPs on each, =
all going down due to a switch failing or similar, you have 640.000 =
DREQs to be sent, and with the finite packet rate of MA packets through =
the PF, this takes more than the current CM timeout. And then you =
re-transmit and increase the burden of the PF proxying.

So, we can change the default to cope with this. But, a MAD packet is =
unreliable, we may have transient loss. In this case, we want a short =
timeout.

> However, if users change the default backlog queue on their systems,
> *then* it would make sense to have the users also change the timeout
> here, but I think guidance would be helpful.
>=20
> So, to revive this patch, what I'd like to see is some attempt to
> actually quantify a reasonable timeout for the default backlog depth,
> then the patch should actually change the default to that reasonable
> timeout, and then put in the ability to adjust the timeout with some
> sort of doc guidance on how to calculate a reasonable timeout based on
> configured backlog depth.

I can agree to this :-)


Thxs, H=C3=A5kon

>=20
> --=20
> Doug Ledford <dledford@redhat.com>
>    GPG KeyID: B826A3330E572FDD
>    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57
> 2FDD

