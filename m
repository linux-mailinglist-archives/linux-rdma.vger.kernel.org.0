Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96FC52BC694
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Nov 2020 16:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbgKVPuc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 22 Nov 2020 10:50:32 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:54450 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727876AbgKVPub (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 22 Nov 2020 10:50:31 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AMFnr1H099441;
        Sun, 22 Nov 2020 15:50:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=ews1W+AhunL5A4EYyEiHqF35ePBNE6n3tTDT2hL8Xzc=;
 b=DwRYkb/A82WzNTbOZWF46iJbrw9pMk7MK7Hd3YYlJ1V+w3kUEu102+tVf8BaAuuYCGlp
 GmpzFR2wvOl/6EYE4EM63CfvcC/1hFmRHs5vDXn2g3wF+CCKnXbY9FNpRZvaFVNyJiW3
 Az9vObUKf9CXWjXf6UM+F917J0q/XGdxMU1g5GwIaZLIoJBT3WhMyW3do69kBSj+o5hc
 hld65pkewqHf2PGu2YpyeEWN5ong/2KHYxlDMdysPrfZTPfhbBDh0QtidCDEJk4J/5HU
 UbsdO70DmONFy3DTqIFec6TvifthJVSjh7flu9wDbOQWpbc1nhi4r6Db29fiKuLVwFwQ Pw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 34xuhmjekk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 22 Nov 2020 15:50:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AMFnXjE174509;
        Sun, 22 Nov 2020 15:50:28 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 34ycsvkn6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 22 Nov 2020 15:50:28 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AMFoRTJ010815;
        Sun, 22 Nov 2020 15:50:27 GMT
Received: from dhcp-10-175-177-236.vpn.oracle.com (/10.175.177.236)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 22 Nov 2020 07:50:27 -0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: Is there a working cache for path record and lids etc for
 librdmacm?
From:   =?utf-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
In-Reply-To: <alpine.DEB.2.22.394.2011221246230.261606@www.lameter.com>
Date:   Sun, 22 Nov 2020 16:50:24 +0100
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Mark Haywood <mark.haywood@oracle.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <801AE4A1-7AE8-4756-8F32-5F3BFD189E2B@oracle.com>
References: <alpine.DEB.2.22.394.2011170253150.206345@www.lameter.com>
 <20201117193329.GH244516@ziepe.ca>
 <alpine.DEB.2.22.394.2011201805000.248138@www.lameter.com>
 <6F632AE0-7921-4C5F-8455-F8E9390BD071@oracle.com>
 <alpine.DEB.2.22.394.2011221246230.261606@www.lameter.com>
To:     Christopher Lameter <cl@linux.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9813 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=3
 mlxlogscore=999 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011220113
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9813 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=3 priorityscore=1501 mlxlogscore=999 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011220113
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On 22 Nov 2020, at 13:49, Christopher Lameter <cl@linux.com> wrote:
>=20
> On Fri, 20 Nov 2020, H=C3=A5kon Bugge wrote:
>>> Oh great. I did not know. Will work with them to get things sorted =
out.
>> Inside Oracle, we're only using it for resolving IB routes. A cache =
for
>> address resolution already exists in the kernel. There is a config
>> option to disable address resolution from user-space
>> (acme_plus_kernel_only).
>=20
> The app that we have runs in user space. Can it use the cache? Is the
> cache only in Mellanox OFED? I heard that it was removed.

An app in user space can use the ibacm cache. If you use the default =
configuration that comes with rdma-core, both address and route =
resolution will be from librdmacm directly to ibacm, i.e., no kernel =
involved. The ibacm options are by default installed in =
/etc/rdma/ibacm_opts.cfg

If you set acme_plus_kernel_only to one in said config file, you app =
will resolve the address using the kernel neighbour cache and the route =
resolution will go into the kernel and then "bounce" back  to user space =
and ibacm through NetLink.

I do not know if ibacm is present in Mellanox OFED, but it is easy to =
find out:

# rpm -q ibacm


> This is an an option while building ibacm?

Nop, runtime config option as depicted above.

> And yes we need it to resolve IB routes.

Then the above will work.

> Can you share a working config?

The default provided by rdma-core should work, possible requiring the =
option above.


Thxs, H=C3=A5kon

