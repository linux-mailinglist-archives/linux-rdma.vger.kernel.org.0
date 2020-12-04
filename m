Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADDF2CECEC
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Dec 2020 12:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbgLDLSU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Dec 2020 06:18:20 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:47934 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbgLDLST (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Dec 2020 06:18:19 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B4B9gDb098344;
        Fri, 4 Dec 2020 11:17:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=w9MDRbe+CdJ7+eSVfuktmP1582RkiqgQSgxDUo8a9Q4=;
 b=LYO7z95VNfschmFMU7CQI+zPXemUZpiTJvmSEYmGEHo0A77KISj0PL4Y3g7tCGSLwacv
 +SJt48enB1QTzuPuq+DQTHClhVd4MbQp+w+zKFrcduyMlecLBteO77cDsgSiQjDFMGL6
 kOcNcZZwcnmFYNLA+8ZLeyTL1ak2fYLMjGcDkH7tbHSEmUhM18AsmdqUnDKm/66O1NCX
 6QvNyZH7fEcyhQmDzoOlRo7eSYRzM6BqLvfjMjEyNl5X/bfMuANlElydghDTBvvs0U0e
 sQBaLmypcCKQgILox4/scMTRElIM/J5zYdGRnf/vlnhZUTret/Cq0R/EF6zLMuRBt9fn DQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 353dyr2s3r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 04 Dec 2020 11:17:35 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B4BAQCh033630;
        Fri, 4 Dec 2020 11:17:34 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 3540axwt1v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Dec 2020 11:17:34 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0B4BHX3t027682;
        Fri, 4 Dec 2020 11:17:33 GMT
Received: from [172.20.10.5] (/89.8.147.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 04 Dec 2020 03:17:32 -0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.20.0.2.21\))
Subject: Re: Is there a working cache for path record and lids etc for
 librdmacm?
From:   =?utf-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
In-Reply-To: <alpine.DEB.2.22.394.2011300811190.336472@www.lameter.com>
Date:   Fri, 4 Dec 2020 12:17:27 +0100
Cc:     Honggang LI <honli@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Mark Haywood <mark.haywood@oracle.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7812B8AB-7D26-4148-8C8C-E1241A1FC8CD@oracle.com>
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
 <E2349D8B-26AC-469C-8483-A2241B9B649A@oracle.com>
 <alpine.DEB.2.22.394.2011300811190.336472@www.lameter.com>
To:     Christopher Lameter <cl@linux.com>
X-Mailer: Apple Mail (2.3654.20.0.2.21)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9824 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012040068
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9824 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 clxscore=1015 mlxscore=0 spamscore=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012040068
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On 30 Nov 2020, at 09:24, Christopher Lameter <cl@linux.com> wrote:
>=20
> On Fri, 27 Nov 2020, H=C3=A5kon Bugge wrote:
>=20
>>> Huh? When does it talk to a subnet manager (or the SA)?
>>=20
>> When resolving the route AND the option "route_prot" is set to "sa". =
If
>> set to "acm", what Hong describes above applies.
>=20
> My config has "route_prot" set to "sa"
>=20
>>> If its get an IP address of an IB node that does not have ibacm then =
it
>>> fails with a timeout ..... ? And leaves hanging kernel threads =
around by
>>> design?
>>=20
>> Nop, the kernel falls back and uses the neighbour cache instead.
>=20
> But ib_acme hangs? The main issue here is what the user space app =
does.
> And we need ibacm to cache user space address resolutions.

I got the impression that you are debugging this with Honggang. If you =
want me to help, I need, to start with, an strace of ib_acme and ditto =
of ibacm.

>>> So it only populates the cache from its local node information?
>>=20
>> No, if you use ibacm for address resolution the only protocol it has =
is
>> "acm", which means the information comes from a peer ibacm.
>>=20
>> If you talk about the cache for routes, it comes either from the SA =
or a
>> peer ibacm, depending on the "route_prot" setting.
>=20
> I have always run it with that setting. How can I debug this issue and =
how
> can we fix this?

k


>=20
>>=20
>>>> To resolve IPoIB address to PathRecord, you must:
>>>> 1) The IPoIB interface must UP and RUNNING on the client and target
>>>> side.
>>>> 2) The ibacm service must RUNNING on the client and target.
>>>=20
>>> That is working if you want to resolve only the IP addresses of the =
IB
>>> interfaces on the client and target. None else.
>>=20
>> That is why it is called IBacm, right?
>=20
> Huh? IBACM is an address resolution service for IB. Somehow that only
> includes addresses of hosts running IBACM?

Yes. As Honggang explained, ibacmn's address resolution protocol is =
based on IB multicast, as such, the peer must have ibacm running in =
order to send a unicast response back with the L2 addr.

>>> Here is the description of ibacms function from the sources:
>>>=20
>>> "Conceptually, the ibacm service implements an ARP like protocol and
>>> either uses IB multicast records to construct path record data or =
queries
>>> the SA directly, depending on the selected route protocol. By =
default, the
>>> ibacm services uses and caches SA path record queries."
>>>=20
>>> SA queries dont work. So its broken and cannot talk to the SM.
>>=20
>> Why do you say that? It works all the time for me which uses "sa" as =
"route_prot".
>=20
> Not here and not in the tests that RH ran to verify the issue.
>=20
> "route_prot" set to "sa" is the default config for the Redhat release =
of
> IBACM.
>=20
> However, the addr_prot is set to  "acm" by default. I set it to "sa" =
with
> no effect.

OK. Understood. As stated above, let me know if you want me to debug =
this.


Thxs, H=C3=A5kon

