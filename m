Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF5C21A787E
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2020 12:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438429AbgDNKe7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Apr 2020 06:34:59 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58364 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438420AbgDNKep (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Apr 2020 06:34:45 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03EAY6P7104127;
        Tue, 14 Apr 2020 10:34:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=ODYjFKovVROzUffQ0Q5ivlO/NVShVWUd9U0ez6Ob+/M=;
 b=oMjbxPr5bvpeIWLYjDUb/X/0jGmLgtp0Dtw8+ySx8wn/QptD3yoNjH6VO1Wv6yxT+o1t
 LwIW07h3RS4l4z+M8Ak+19lQe6ZKScydFXO7srTgxYp6p0Y7bOUe7XP9VYDl9ZBdvhpf
 3BgHIdPWVPALpkh9Ywr7shFedSWwOIE4WATzWIQVyKeEWUIVp1TUGgYoHaqM8n1SLdZd
 F+HM4IY/NiwTPOSf7FWhtmVB1alEWko2gSslNWaHCBh1Wxh5u/aNUm96WRlW5UNq+Cf0
 fok5yBl3r+mLR8TVzQKGhIlXEsolaNeWjtFiT+ZPxLBgPE4E8f+wPRHOzHx34h1lRQjE dQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 30b5um3p0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 10:34:39 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03EAWu16018924;
        Tue, 14 Apr 2020 10:34:38 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 30bqm1d60n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 10:34:38 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03EAYb0h011233;
        Tue, 14 Apr 2020 10:34:37 GMT
Received: from dhcp-10-175-176-104.vpn.oracle.com (/10.175.176.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 Apr 2020 03:34:37 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH for-rc] RDMA/cma: fix race between addr_handler and
 resolve_route
From:   =?utf-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
In-Reply-To: <20200406181032.GI11616@mellanox.com>
Date:   Tue, 14 Apr 2020 12:34:35 +0200
Cc:     Doug Ledford <dledford@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        george kennedy <george.kennedy@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EAE5B24F-142B-478D-BBA5-BBF784AA9E39@oracle.com>
References: <20200403184328.1154929-1-haakon.bugge@oracle.com>
 <20200403185707.GE8514@mellanox.com>
 <1720C7BF-D6E4-4779-B05D-203703042B36@oracle.com>
 <20200403193656.GF8514@mellanox.com>
 <EDBCDCC1-E03F-428A-8352-734E3F01B316@oracle.com>
 <20200406173149.GH11616@mellanox.com>
 <09A6E613-AA59-4C5F-889A-EF45722B7F69@oracle.com>
 <20200406181032.GI11616@mellanox.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9590 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=3 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004140087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9590 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 bulkscore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=3 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004140087
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On 6 Apr 2020, at 20:10, Jason Gunthorpe <jgg@mellanox.com> wrote:
>=20
> On Mon, Apr 06, 2020 at 08:02:41PM +0200, H=C3=A5kon Bugge wrote:
>=20
>>> However, I'm not sure what the state machine is supposed to look
>>> like..
>>=20
>> The neat state machines in Figure 13{5,6} in IBTA version 1.3. If you =
do not have it handy, I can send you the PDF off list.
>=20
> That is the IB CM state machine
>=20
> The RDMA CM I thought had extra things like this defered addr_resolve
> business

The "runway" before you can send a REQ is not captured by IBTA. So the =
{ADDR,ROUTE}_{QUERY,RESOLVED} states are not IBTA defined.

>>>> Shall I make a v2 base on next based on this idea, or do you have
>>>> something coming?
>>>=20
>>> Sure, I have nothing :)
>>>=20
>>> Also that rdma_destroy_id in addr_handler looks wrong.. ie we still
>>> retain pointers to the rdma_cm_id it destroys inside the struct
>>> ucma_context, don't we?
>>=20
>> On entry from user-space, we use the u32 id and looks it up in the
>> XArray. But if rdma_destoy_id() is called asynchronously called
>> between ucma_get_ctx_dev() and the de-reference of ctx->cm_id, we
>> are toast.
>=20
> Is that what happens on the addr_handler path?

No, there, the main problem is the revert of the state transitions. The =
first transition enables rdma_resolve_route() to pass its gate (i.e. =
state =3D=3D ADDR_RESOLVED). Then it thinks the address is resolved, but =
the addr_handler changes its mind afterwards.


Thxs, H=C3=A5kon


