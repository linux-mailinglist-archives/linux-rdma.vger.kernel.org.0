Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40E142C1420
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Nov 2020 20:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730754AbgKWTBa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Nov 2020 14:01:30 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:44514 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730451AbgKWTB3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Nov 2020 14:01:29 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ANIt0q8003745;
        Mon, 23 Nov 2020 19:01:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=eepMO/utGPYiklUNl6Z+g1H63jfC14jr8AP5KpJ6CL0=;
 b=bi1CFoVgTR89LX0F40GteITACyC88tS12wKLjeb7T5JrpezBzJbI4cLJSgIFFqCxMRuS
 StPCAApm75Qygg/mPwI12jID4x0Q/p3k57qc4vMkUZRogTBkDSFpXgsiZgqK1pWtPenv
 jmESV8LjmJ+vZEwpAiReRPUlp5/MmlBC1Dtf0IHGazkmz8EI0HnNkt++i/mMqE5wUXDA
 x7LVog79sgjUBUUP8BscPRDJugTosNZMe/g0PwfHXTBXISUu9F4ijIhXk8D/o7OeT4uB
 FcJn6cmgzNUEKV76n60sdLIeXERrss5J5ZQyHzb02z69FEU8bh6am/Ujrt7jqf1hyyCm uQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 34xrdaq0y0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 23 Nov 2020 19:01:25 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ANItvAw182697;
        Mon, 23 Nov 2020 19:01:25 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 34ycfm9aqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Nov 2020 19:01:25 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0ANJ1NNv032642;
        Mon, 23 Nov 2020 19:01:24 GMT
Received: from dhcp-10-175-163-206.vpn.oracle.com (/10.175.163.206)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 23 Nov 2020 11:01:23 -0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: Is there a working cache for path record and lids etc for
 librdmacm?
From:   =?utf-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
In-Reply-To: <alpine.DEB.2.22.394.2011231244490.272074@www.lameter.com>
Date:   Mon, 23 Nov 2020 20:01:20 +0100
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Mark Haywood <mark.haywood@oracle.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <648D2533-E8E8-4248-AF2D-C5F1F60E5BFC@oracle.com>
References: <alpine.DEB.2.22.394.2011170253150.206345@www.lameter.com>
 <20201117193329.GH244516@ziepe.ca>
 <alpine.DEB.2.22.394.2011201805000.248138@www.lameter.com>
 <6F632AE0-7921-4C5F-8455-F8E9390BD071@oracle.com>
 <alpine.DEB.2.22.394.2011221246230.261606@www.lameter.com>
 <801AE4A1-7AE8-4756-8F32-5F3BFD189E2B@oracle.com>
 <alpine.DEB.2.22.394.2011221919240.265127@www.lameter.com>
 <alpine.DEB.2.22.394.2011231244490.272074@www.lameter.com>
To:     Christopher Lameter <cl@linux.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9814 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 bulkscore=0 suspectscore=3 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011230123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9814 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 adultscore=0 suspectscore=3 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011230123
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On 23 Nov 2020, at 13:50, Christopher Lameter <cl@linux.com> wrote:
>=20
> On Sun, 22 Nov 2020, Christopher Lameter wrote:
>=20
>>> If you set acme_plus_kernel_only to one in said config file, you app =
will resolve the address using the kernel neighbour cache and the route =
resolution will go into the kernel and then "bounce" back  to user space =
and ibacm through NetLink.
>>=20
>> Have not seen that in the RHEL7.8 version of ibacm.
>>=20
>=20
> Got version 33.0 from Redhat with the option. Set it but ibacm still =
times
> out when trying to contact the SM.

Contact the peer ibacm, that is. Is it started?

And, ib_acme bypasses the kernel_only check. I assume a real app (e.g., =
qperf <destination_ip> -cm1 rc_bw) would work, but incur an excess delay =
due to the ibacm timeout, before failing back to the kernel neighbour =
cache.


Thxs, H=C3=A5kon




>=20
> ib_acme says:
>=20
> ib_acm_resolve_ip failed: Connection timed out
>=20
>=20
> ibmacm.log says
>=20
> acmp_process_wait_queue: notice - failing request
> acmp_process_timeouts: notice - dest 192.168.50.39
>=20
>=20

