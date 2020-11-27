Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EADE72C6844
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Nov 2020 15:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730970AbgK0OyW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Nov 2020 09:54:22 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:46922 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729913AbgK0OyW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Nov 2020 09:54:22 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AREmj8a047039;
        Fri, 27 Nov 2020 14:54:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=EgG/4ATcW2aRUD5UOhZpTAuhNfcNQDpTYuKs1jC6YVg=;
 b=DD7B1UX//r0T6plC/ps+j0yPpauZPJuYeF01S34NihiKb6U3JXUkOrPAbmwt2Bj1pI2t
 JJXj5M8qLGnv4ZSeYGsgaMmB3P0U60PGd8UOY540g7PUhq/oKWOOTR2RPI2dVOsahAv+
 blmwo25kQyWE9voh4Fw2VEU8Q1RuPYVOzSaP+oVALIlu8JXw82KgDT9cJjEXIoeRjBnP
 5ZoLYbzjV0s6jvBTtjTqOe+oh+uUXJs7TAj+AuQmKqw6yMXTbsflG08PGLr7ytO9TdYC
 7eea39pMYqX8F2XSPCm3oyEWZgJxTs1x0+ixszd3goT7Hp2nUHTpk5xNhS2hUZqtNClj jQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 351kwhhnjc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 27 Nov 2020 14:54:18 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AREoBfb059559;
        Fri, 27 Nov 2020 14:52:18 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 351n2mdbp7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Nov 2020 14:52:18 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AREqH39004053;
        Fri, 27 Nov 2020 14:52:17 GMT
Received: from dhcp-10-175-160-225.vpn.oracle.com (/10.175.160.225)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 27 Nov 2020 06:52:17 -0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: Is there a working cache for path record and lids etc for
 librdmacm?
From:   =?utf-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
In-Reply-To: <alpine.DEB.2.22.394.2011251632300.298485@www.lameter.com>
Date:   Fri, 27 Nov 2020 15:52:14 +0100
Cc:     Honggang LI <honli@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Mark Haywood <mark.haywood@oracle.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E2349D8B-26AC-469C-8483-A2241B9B649A@oracle.com>
References: <alpine.DEB.2.22.394.2011170253150.206345@www.lameter.com>
 <20201117193329.GH244516@ziepe.ca>
 <alpine.DEB.2.22.394.2011201805000.248138@www.lameter.com>
 <6F632AE0-7921-4C5F-8455-F8E9390BD071@oracle.com>
 <alpine.DEB.2.22.394.2011221246230.261606@www.lameter.com>
 <801AE4A1-7AE8-4756-8F32-5F3BFD189E2B@oracle.com>
 <alpine.DEB.2.22.394.2011221919240.265127@www.lameter.com>
 <alpine.DEB.2.22.394.2011231244490.272074@www.lameter.com>
 <648D2533-E8E8-4248-AF2D-C5F1F60E5BFC@oracle.com>
 <alpine.DEB.2.22.394.2011241859340.286936@www.lameter.com>
 <20201125081057.GA547111@dhcp-128-72.nay.redhat.com>
 <alpine.DEB.2.22.394.2011251632300.298485@www.lameter.com>
To:     Christopher Lameter <cl@linux.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9817 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 bulkscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011270088
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9817 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=3 adultscore=0 impostorscore=0 mlxscore=0
 spamscore=0 phishscore=0 malwarescore=0 clxscore=1011 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011270088
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On 25 Nov 2020, at 17:43, Christopher Lameter <cl@linux.com> wrote:
>=20
> On Wed, 25 Nov 2020, Honggang LI wrote:
>=20
>>> How do I figure out why ibacm is not talking to the subnet manager?
>>=20
>> No, you can't talking to subnet manager, if you resolve IPoIB IP =
address
>> or hostname to PathRecord. The query MAD packets will be send to one
>> multicast group all ibacm service attached.
>=20
> Huh? When does it talk to a subnet manager (or the SA)?

When resolving the route AND the option "route_prot" is set to "sa". If =
set to "acm", what Hong describes above applies.

> If its get an IP address of an IB node that does not have ibacm then =
it
> fails with a timeout ..... ? And leaves hanging kernel threads around =
by
> design?

Nop, the kernel falls back and uses the neighbour cache instead.

> So it only populates the cache from its local node information?

No, if you use ibacm for address resolution the only protocol it has is =
"acm", which means the information comes from a peer ibacm.

If you talk about the cache for routes, it comes either from the SA or a =
peer ibacm, depending on the "route_prot" setting.

>> To resolve IPoIB address to PathRecord, you must:
>> 1) The IPoIB interface must UP and RUNNING on the client and target
>> side.
>> 2) The ibacm service must RUNNING on the client and target.
>=20
> That is working if you want to resolve only the IP addresses of the IB
> interfaces on the client and target. None else.

That is why it is called IBacm, right?

> Here is the description of ibacms function from the sources:
>=20
> "Conceptually, the ibacm service implements an ARP like protocol and
> either uses IB multicast records to construct path record data or =
queries
> the SA directly, depending on the selected route protocol. By default, =
the
> ibacm services uses and caches SA path record queries."
>=20
> SA queries dont work. So its broken and cannot talk to the SM.

Why do you say that? It works all the time for me which uses "sa" as =
"route_prot".


Thxs, H=C3=A5kon

