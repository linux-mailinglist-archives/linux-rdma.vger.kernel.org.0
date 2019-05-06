Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC99154D4
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2019 22:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfEFUS4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 May 2019 16:18:56 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46512 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfEFUSz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 May 2019 16:18:55 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x46KEGFA160642;
        Mon, 6 May 2019 20:18:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=8If4SS2VGm/i0scvwt2lkA2C95Z+Wkk9PcbEkyQIRZw=;
 b=MQ/hbXzO6sRRw8fgnsC3mNPFcg6aaO5RUlT7AgW8rS6Xwi51YsexlnWgXg3S2yQCRfYn
 Ts3iHDmb4kMv1CqnFEg2vvp+gGDF7Leilwy+ahUect4cj8CLF1AMsimbydNGFYeDzrlo
 mWsEJcIZD5uMNwF31YFu0NI3Vk7DfXiKYmBASzZ4NkcMT3hT16l+vheD1UGhJUMhgB1P
 jutHz54p6kqB++F2Ohx5Q4jZ1dbxDtpEkkuJOAFub06IRk9L2i+pRjA5Txi21uj8aPwz
 TJSsNjQuuJCe9ADe12//1tOiJ+sM3glseDAUwJq/018GuveYCYT9YqW1cqqsXn9S/VPC sQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2s94bfryq9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 May 2019 20:18:48 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x46KH0qF037086;
        Mon, 6 May 2019 20:18:47 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2s9ayegctp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 May 2019 20:18:47 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x46KIjs1003108;
        Mon, 6 May 2019 20:18:45 GMT
Received: from anon-dhcp-171.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 06 May 2019 13:18:45 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH for-rc 1/5] IB/hfi1: Fix WQ_MEM_RECLAIM warning
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20190506200849.GF6201@ziepe.ca>
Date:   Mon, 6 May 2019 16:18:44 -0400
Cc:     Leon Romanovsky <leon@kernel.org>,
        "Marciniszyn, Mike" <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        "Tejun Heo (tj@kernel.org)" <tj@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Ruhl, Michael J" <michael.j.ruhl@intel.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7C7AD392-B9EE-41D8-92C9-D09037E8B6E5@oracle.com>
References: <20190327171611.GF21008@ziepe.ca>
 <20190327190720.GE69236@devbig004.ftw2.facebook.com>
 <20190327194347.GH21008@ziepe.ca>
 <20190327212502.GF69236@devbig004.ftw2.facebook.com>
 <053009d7de76f8800304f354e3cbde068453257f.camel@redhat.com>
 <32E1700B9017364D9B60AED9960492BC70D3737D@fmsmsx120.amr.corp.intel.com>
 <580150427022440ab0475cda91d666322ef7e055.camel@redhat.com>
 <32E1700B9017364D9B60AED9960492BC70D38297@fmsmsx120.amr.corp.intel.com>
 <20190506181610.GB6201@ziepe.ca> <20190506190356.GO6938@mtr-leonro.mtl.com>
 <20190506200849.GF6201@ziepe.ca>
To:     Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: Apple Mail (2.3445.104.8)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9249 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905060164
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9249 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905060164
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On May 6, 2019, at 4:08 PM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>=20
> On Mon, May 06, 2019 at 10:03:56PM +0300, Leon Romanovsky wrote:
>> On Mon, May 06, 2019 at 03:16:10PM -0300, Jason Gunthorpe wrote:
>>> On Mon, May 06, 2019 at 05:52:48PM +0000, Marciniszyn, Mike wrote:
>>>>>=20
>>>>> My mistake.  It's been a long while since I coded the stuff I did =
for
>>>>> memory reclaim pressure and I had my flag usage wrong in my =
memory.
>>>>> =46rom the description you just gave, the original patch to add
>>>>> WQ_MEM_RECLAIM is ok.  I probably still need to audit the ipoib =
usage
>>>>> though.
>>>>>=20
>>>>=20
>>>> Don't lose sight of the fact that the additional of the =
WQ_MEM_RECLAIM is to silence
>>>> a warning BECAUSE ipoib's workqueue is WQ_MEM_RECLAIM.  This =
happens while
>>>> rdmavt/hfi1 is doing a cancel_work_sync() for the work item used by =
the QP's send engine
>>>>=20
>>>> The ipoib wq needs to be audited to see if it is in the data path =
for VM I/O.
>>>=20
>>> Well, it is doing unsafe memory allocations and other stuff, so it
>>> can't be RECLAIM. We should just delete them from IPoIB like Doug =
says.
>>=20
>> Please don't.
>=20
> Well then fix the broken allocations it does, and I don't really see
> how to do that. We can't have it both ways.
>=20
> I would rather have NFS be broken then normal systems with ipoib
> hanging during reclaim.

TBH, NFS on IPoIB is a hack that I would be happy to see replaced
with NFS/RDMA. However, I don't think we can have it regressing
at this point -- and it sounds like there are other use cases that
do depend on WQ_MEM_RECLAIM remaining in the IPoIB path.

If you are truly curious, bring this up on linux-nfs to find out
what NFS needs and how it works on Ethernet-only network stacks.

--
Chuck Lever



