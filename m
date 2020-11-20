Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 623112BB381
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Nov 2020 19:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730371AbgKTSfG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Nov 2020 13:35:06 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:43836 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730845AbgKTSfG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Nov 2020 13:35:06 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AKIOr1i170968;
        Fri, 20 Nov 2020 18:35:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=SYZwxIozdmOnycvEDobbRvfnI59VjJJebvX1yBnruUY=;
 b=ZHGraGFpM4XipsRSv5VYP3liLW9DvtoSz+6YHktqYJHbipTuEuKW89ChRClbVayjIjT4
 WQZSUsAdOXpbezRwO2fUWATfd1UtlH19DHcTQ+NTovzKqw7PfC5GarZs+G7ZvonOiTPo
 AhqDrdPPpqErSMFEUNYxpdjUcKbeFhzxEk6OAfhOqhj+vThiSGbjX2YnepXq98VqaUGJ
 iDSiLrUB1dr3aPTeQjLku9wsjBL+RVOLuq6fg/n6C1VIqljBwMQnJM2CgcbTZOXRegWc
 R5rXnSVIgGYKPFyoyagoVmVlYKEF9pm1rlWN5WtH2HqfaUIj03sqQ/GMaTIlMVVg1BxK /A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 34t76mc2e5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Nov 2020 18:35:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AKIPgb7070093;
        Fri, 20 Nov 2020 18:35:03 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 34umd3sxyj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Nov 2020 18:35:03 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AKIZ1Hd015643;
        Fri, 20 Nov 2020 18:35:02 GMT
Received: from dhcp-10-175-168-234.vpn.oracle.com (/10.175.168.234)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 20 Nov 2020 10:35:01 -0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: Is there a working cache for path record and lids etc for
 librdmacm?
From:   =?utf-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
In-Reply-To: <alpine.DEB.2.22.394.2011201805000.248138@www.lameter.com>
Date:   Fri, 20 Nov 2020 19:34:59 +0100
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Mark Haywood <mark.haywood@oracle.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6F632AE0-7921-4C5F-8455-F8E9390BD071@oracle.com>
References: <alpine.DEB.2.22.394.2011170253150.206345@www.lameter.com>
 <20201117193329.GH244516@ziepe.ca>
 <alpine.DEB.2.22.394.2011201805000.248138@www.lameter.com>
To:     Christopher Lameter <cl@linux.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9811 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 mlxscore=0 phishscore=0
 spamscore=0 bulkscore=0 mlxlogscore=778 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011200126
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9811 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 phishscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1011 mlxlogscore=789
 malwarescore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011200126
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On 20 Nov 2020, at 19:05, Christopher Lameter <cl@linux.com> wrote:
>=20
> On Tue, 17 Nov 2020, Jason Gunthorpe wrote:
>=20
>> If it really doesn't work at all any more we should delete it from
>> rdma-core if nobody is interested to fix it.
>>=20
>> Haakon and Mark had stepped up to maintain it a while ago because =
they
>> were using it internally, so I'm surprised to hear it is broken.
>=20
> Oh great. I did not know. Will work with them to get things sorted =
out.

Inside Oracle, we're only using it for resolving IB routes. A cache for =
address resolution already exists in the kernel. There is a config =
option to disable address resolution from user-space =
(acme_plus_kernel_only).


Thxs, H=C3=A5kon


