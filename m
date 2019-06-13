Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE501449C7
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2019 19:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbfFMRjq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Jun 2019 13:39:46 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53032 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbfFMRjq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Jun 2019 13:39:46 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5DHd4Zg185540;
        Thu, 13 Jun 2019 17:39:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=mi9aElUTCRIiQJie6XA4eLpTipbeI9MjyOvAunbdU/M=;
 b=k6uPVU1rrtdvUJOhXKY7/nJHUkwHYhPS59cSDuKj3bHFVedl5PHcBifOfBvzSBqRfhq1
 iGBr93FhN3vuY+NxzWCIUb9oe2nXYsWjL5NeGByyht/ACIvyZyD18YqmpXMruT63zm2c
 lXaY5AbzZHjo5WDbvw8e3b0NQaUnjgP42EBQTFrgQmgHAnY8PyAC17eUzxcPlZgEXIbd
 8hqxEEXHzCvin+m0tEN1i629+gYWI57BQII3y2PeOHJWY5OWHH0cCfbdQBgvmDLhYHc/
 lt2ZhJw5wE+yyuZ4AqVgNooUHR6nC42pZq8hSFC7EU3FLsgi3Cz4agGvc0hf9JVgbBpr qA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2t05nr32bg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jun 2019 17:39:32 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5DHcFUY196011;
        Thu, 13 Jun 2019 17:39:31 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2t0p9shnt2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jun 2019 17:39:31 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5DHdTSR009412;
        Thu, 13 Jun 2019 17:39:29 GMT
Received: from [192.168.10.144] (/51.175.236.248)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 13 Jun 2019 10:39:29 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2] RDMA/cma: Make CM response timeout and # CM retries
 configurable
From:   =?utf-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
In-Reply-To: <20190613172355.GF22901@ziepe.ca>
Date:   Thu, 13 Jun 2019 19:39:24 +0200
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Parav Pandit <parav@mellanox.com>,
        Steve Wise <swise@opengridcomputing.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1D8E6B14-3336-42B3-B572-596DD2183D89@oracle.com>
References: <20190226075722.1692315-1-haakon.bugge@oracle.com>
 <174ccd37a9ffa05d0c7c03fe80ff7170a9270824.camel@redhat.com>
 <67B4F337-4C3A-4193-B1EF-42FD4765CBB7@oracle.com>
 <20190613172355.GF22901@ziepe.ca>
To:     Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9287 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906130129
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9287 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906130129
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On 13 Jun 2019, at 19:23, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>=20
> On Thu, Jun 13, 2019 at 06:58:30PM +0200, H=C3=A5kon Bugge wrote:
>=20
>> If you refer to the backlog parameter in rdma_listen(), I cannot see
>> it being used at all for IB.
>>=20
>> For CX-3, which is paravirtualized wrt. MAD packets, it is the proxy
>> UD receive queue length for the PF driver that can be construed as a
>> backlog.=20
>=20
> No, in IB you can drop UD packets if your RQ is full - so the proxy RQ
> is really part of the overall RQ on QP1.
>=20
> The backlog starts once packets are taken off the RQ and begin the
> connection accept processing.

Do think we say the same thing. If, incoming REQ processing is severly =
delayed, the backlog is #entries in the QP1 receive queue in the PF. I =
can call rdma_listen() with a backlog of a zillion, but it will not =
help.

>> Customer configures #VMs and different workload may lead to way
>> different number of CM connections. The proxying of MAD packet
>> through the PF driver has a finite packet rate. With 64 VMs, 10.000
>> QPs on each, all going down due to a switch failing or similar, you
>> have 640.000 DREQs to be sent, and with the finite packet rate of MA
>> packets through the PF, this takes more than the current CM
>> timeout. And then you re-transmit and increase the burden of the PF
>> proxying.
>=20
> I feel like the performance of all this proxying is too low to support
> such a large work load :(

That is what I am aiming at, for example to spread the =
completion_vector(s) for said QPs ;-)

-h

>=20
> Can it be improved?
>=20
> Jason

