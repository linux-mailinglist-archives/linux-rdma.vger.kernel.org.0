Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFD8C1ACB0A
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2020 17:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897187AbgDPNfn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Apr 2020 09:35:43 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57550 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2897170AbgDPNfi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Apr 2020 09:35:38 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03GDRuCr008601;
        Thu, 16 Apr 2020 13:35:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=pB4RFjmJnZEger3DzMc3XUODnXkLJAAR7JUcOa5yHvc=;
 b=VyOle/UYWdi5wzE7SBbbSGHUiG6mdV7pAudIPbcd26Wbg4FBnfc4Q2PcfuYCwVQgFp1K
 yK7NVLeQI7aixGJXhbzLFE+RHMTVi89Cljk6fZt9affO7iFBA2FJxaSFd4ocKVGvjjBM
 9fj8sTlYdYmiVlczk5IEsOZutgE17fUAu+PhqaDe83iW4HIh34phkAlLo6DFDNN3i7eO
 FUl87iUuCnZmMsqaxZtgMkhU/EVTZqK/QIppqHBLeOywN6Wxm+BaWwun39CsSVYVpB60
 ZKQPQOcoaZ+CQjaNbRcW46ud4/3dWnPgv5l5MF+OpJ8czRGIH2nXDrX4h1MGQj6tW9/N Lw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 30emejh76c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Apr 2020 13:35:32 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03GDR8Q3065578;
        Thu, 16 Apr 2020 13:33:32 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 30emen2bnq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Apr 2020 13:33:32 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03GDXVW0032510;
        Thu, 16 Apr 2020 13:33:31 GMT
Received: from [192.168.10.144] (/51.175.204.144)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 16 Apr 2020 06:33:31 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH for-rc] RDMA/cma: fix race between addr_handler and
 resolve_route
From:   =?utf-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
In-Reply-To: <20200414161141.GL11945@mellanox.com>
Date:   Thu, 16 Apr 2020 15:33:28 +0200
Cc:     Doug Ledford <dledford@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        george kennedy <george.kennedy@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3168883E-169E-4D96-A4F5-8FF882B164BC@oracle.com>
References: <20200403185707.GE8514@mellanox.com>
 <1720C7BF-D6E4-4779-B05D-203703042B36@oracle.com>
 <20200403193656.GF8514@mellanox.com>
 <EDBCDCC1-E03F-428A-8352-734E3F01B316@oracle.com>
 <20200406173149.GH11616@mellanox.com>
 <09A6E613-AA59-4C5F-889A-EF45722B7F69@oracle.com>
 <20200406181032.GI11616@mellanox.com>
 <EAE5B24F-142B-478D-BBA5-BBF784AA9E39@oracle.com>
 <20200414125012.GK11945@mellanox.com>
 <BCFFD1E1-F013-4B09-9DC5-5A4EE205EA10@oracle.com>
 <20200414161141.GL11945@mellanox.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9592 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004160096
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9592 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 impostorscore=0
 mlxscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 adultscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004160096
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On 14 Apr 2020, at 18:11, Jason Gunthorpe <jgg@mellanox.com> wrote:
>=20
> On Tue, Apr 14, 2020 at 03:57:20PM +0200, H=C3=A5kon Bugge wrote:
>>=20
>>=20
>>> On 14 Apr 2020, at 14:50, Jason Gunthorpe <jgg@mellanox.com> wrote:
>>>=20
>>> On Tue, Apr 14, 2020 at 12:34:35PM +0200, H=C3=A5kon Bugge wrote:
>>>=20
>>>>>>>> Shall I make a v2 base on next based on this idea, or do you =
have
>>>>>>>> something coming?
>>>>>>>=20
>>>>>>> Sure, I have nothing :)
>>>>>>>=20
>>>>>>> Also that rdma_destroy_id in addr_handler looks wrong.. ie we =
still
>>>>>>> retain pointers to the rdma_cm_id it destroys inside the struct
>>>>>>> ucma_context, don't we?
>>>>>>=20
>>>>>> On entry from user-space, we use the u32 id and looks it up in =
the
>>>>>> XArray. But if rdma_destoy_id() is called asynchronously called
>>>>>> between ucma_get_ctx_dev() and the de-reference of ctx->cm_id, we
>>>>>> are toast.
>>>>>=20
>>>>> Is that what happens on the addr_handler path?
>>>>=20
>>>> No, there, the main problem is the revert of the state
>>>> transitions. The first transition enables rdma_resolve_route() to
>>>> pass its gate (i.e. state =3D=3D ADDR_RESOLVED). Then it thinks the
>>>> address is resolved, but the addr_handler changes its mind
>>>> afterwards.
>>>=20
>>> That is a problem, but the call to rdma_destroy_id looks like =
another
>>> problem
>>=20
>> I am not sure. Almost all events/incoming packets, can, after the
>> cm_id's event_handler is called from cma_ib_handler(), call
>> rdma_destroy_id().=20
>=20
> I think the trick is that ucma_event_handler never returns failure
> unless RDMA_CM_EVENT_CONNECT_REQUEST, which means the cm_id isn't in
> the xarray yet?

Sure does. 1 or -ENOMEM. But the ULP's event handlers isn't that polite. =
But a different issue from this syzkaller one.

>> I assume the refcounting takes care of this.
>=20
> There is no refcounting for destroy, it must be called once.

I was thinking about the "cma_deref_id(id_priv);" stuff, but I may have =
misunderstood.



Thxs, H=C3=A5kon

