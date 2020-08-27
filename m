Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2442547A7
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Aug 2020 16:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbgH0Owq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Aug 2020 10:52:46 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35578 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727959AbgH0NVV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Aug 2020 09:21:21 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07RCFTKD058903;
        Thu, 27 Aug 2020 12:21:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=DTfi02yR5uf1b5dHE4jiuTg6oaz+Q0/Q7GobOSdrVNg=;
 b=N49NObNQw0DHdYEzTVHs4jgO+9yZhwvC9XBtcNYqqfxzcmDCQElESLklNXAHXJweczUu
 5paTxu3usYS0Pl7clETkZWD7mIGUUCmXxKbM80H89TvnjaIogGIg0i0u5Anwcrs0+ttb
 i6JKc7f2KkJ0lgEPWzHnBe7vFLueernsJUfi0Aa5p1k8XTdGgyhBYh7hp+A8EQbhAarR
 1pS5hz56KLy0e/lhnSvY0+kv2jwBYX2jfC0XfG+4tqH4ZkReIXFkt3dtPpTj757f1XOz
 BHe0hN7wXNUzE8RDtXztRbw82Ug9qV/Ej0bUUkLs/N7VdsYOXD1FAfu/iAfQiePr5zVF Pw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 333w6u4j4t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Aug 2020 12:21:02 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07RCFPCh189438;
        Thu, 27 Aug 2020 12:21:02 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 333r9n64vb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Aug 2020 12:21:02 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07RCL0QW028933;
        Thu, 27 Aug 2020 12:21:01 GMT
Received: from dhcp-10-175-177-113.vpn.oracle.com (/10.175.177.113)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Aug 2020 05:21:00 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH for-next] RDMA/usnic: Remove the query_pkey callback
From:   =?utf-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
In-Reply-To: <20200827120139.GL24045@ziepe.ca>
Date:   Thu, 27 Aug 2020 14:20:57 +0200
Cc:     Gal Pressman <galpress@amazon.com>,
        Kamal Heib <kamalheib1@gmail.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Christian Benvenuti <benve@cisco.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <ACEC991F-E03B-49F5-95D0-42C78CC2B78E@oracle.com>
References: <20200820125346.111902-1-kamalheib1@gmail.com>
 <efb8ce2b-fb37-2950-36fd-fb45b845632a@amazon.com>
 <20200820135338.GA114615@kheib-workstation>
 <20200827075356.GA394866@kheib-workstation>
 <4be87aa7-bc3c-d8f1-05e2-9276125cacc2@amazon.com>
 <20200827120139.GL24045@ziepe.ca>
To:     Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9725 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=3 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008270093
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9725 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=3 phishscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 clxscore=1011 mlxscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008270093
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On 27 Aug 2020, at 14:01, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>=20
> On Thu, Aug 27, 2020 at 11:20:16AM +0300, Gal Pressman wrote:
>> On 27/08/2020 10:53, Kamal Heib wrote:
>>> On Thu, Aug 20, 2020 at 04:53:38PM +0300, Kamal Heib wrote:
>>>> On Thu, Aug 20, 2020 at 04:11:23PM +0300, Gal Pressman wrote:
>>>>> On 20/08/2020 15:53, Kamal Heib wrote:
>>>>>> Now that the query_pkey() isn't mandatory by the RDMA core, this
>>>>>> callback can be removed from the usnic provider.
>>>>>=20
>>>>> Not directly related to this patch, but pyverbs has a test which =
verifies that
>>>>> max_pkeys > 0, maybe this check should be removed.
>>>>=20
>>>> Or changed to work only for node_type =3D=3D e.IBV_NODE_CA?
>>>>=20
>>>> Thanks,
>>>> Kamal
>>>=20
>>> BTW, do the efa care about pkey?
>>=20
>> Depends.. We only support the default pkey so it doesn't do much in =
terms of
>> functionality, but we still need to support it as part of the QP =
state machine
>> for modify QP.
>=20
> Does the pkey appear on the wire, or is it just some cruft for API =
sake?

On the wire. Included in the BTH (Base Transfer Header).

H=C3=A5kon


>=20
> Jason

