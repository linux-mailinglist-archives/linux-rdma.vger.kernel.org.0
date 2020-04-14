Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0211A7EF9
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2020 15:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388534AbgDNN5f (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Apr 2020 09:57:35 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36768 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388513AbgDNN5c (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Apr 2020 09:57:32 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03EDtbF9105473;
        Tue, 14 Apr 2020 13:57:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=v76e+q/MLDPFP9tsb/iUMwuIOALrpj9yccjBXtTk2vQ=;
 b=JZFxO9ykf9NGT/lAdMMkjru84/BCz5d833Tt9sUVmw9CTskSjnjhE8dsHAjiU+M6NspY
 pNoovpCX0EcA+fBWyZgyRW+Z83b+boq27MBU2nsyuQpnJwDca8LET836bjxXPJtp3W79
 0dRSUX/zN2TDZJ3QmVuT5n+IwgRWKukCcHuuuKD0RyubZEDvUlvrHrEc1DCbwgDNo6bU
 64wURZteKQEcnh2fvq4p6iNETS7oD6AkRFr13bpWjxB87dTKfUHgm4GdI3JPZ8vO3o82
 YO/vyDR+U3Y5HO3RDrpENj5Z/SsuMCMJt9ixyGhiWf1IfYEGHEr8MRqtJIfhf78JOR2C Tg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 30b5um4v36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 13:57:25 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03EDm1m5194057;
        Tue, 14 Apr 2020 13:57:25 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 30bqpgjtja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 13:57:25 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03EDvN5J027614;
        Tue, 14 Apr 2020 13:57:23 GMT
Received: from dhcp-10-175-176-104.vpn.oracle.com (/10.175.176.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 Apr 2020 06:57:23 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH for-rc] RDMA/cma: fix race between addr_handler and
 resolve_route
From:   =?utf-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
In-Reply-To: <20200414125012.GK11945@mellanox.com>
Date:   Tue, 14 Apr 2020 15:57:20 +0200
Cc:     Doug Ledford <dledford@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        george kennedy <george.kennedy@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BCFFD1E1-F013-4B09-9DC5-5A4EE205EA10@oracle.com>
References: <20200403184328.1154929-1-haakon.bugge@oracle.com>
 <20200403185707.GE8514@mellanox.com>
 <1720C7BF-D6E4-4779-B05D-203703042B36@oracle.com>
 <20200403193656.GF8514@mellanox.com>
 <EDBCDCC1-E03F-428A-8352-734E3F01B316@oracle.com>
 <20200406173149.GH11616@mellanox.com>
 <09A6E613-AA59-4C5F-889A-EF45722B7F69@oracle.com>
 <20200406181032.GI11616@mellanox.com>
 <EAE5B24F-142B-478D-BBA5-BBF784AA9E39@oracle.com>
 <20200414125012.GK11945@mellanox.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9591 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 bulkscore=0 spamscore=0 suspectscore=3 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004140112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9591 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 bulkscore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=3 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004140112
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On 14 Apr 2020, at 14:50, Jason Gunthorpe <jgg@mellanox.com> wrote:
>=20
> On Tue, Apr 14, 2020 at 12:34:35PM +0200, H=C3=A5kon Bugge wrote:
>=20
>>>>>> Shall I make a v2 base on next based on this idea, or do you have
>>>>>> something coming?
>>>>>=20
>>>>> Sure, I have nothing :)
>>>>>=20
>>>>> Also that rdma_destroy_id in addr_handler looks wrong.. ie we =
still
>>>>> retain pointers to the rdma_cm_id it destroys inside the struct
>>>>> ucma_context, don't we?
>>>>=20
>>>> On entry from user-space, we use the u32 id and looks it up in the
>>>> XArray. But if rdma_destoy_id() is called asynchronously called
>>>> between ucma_get_ctx_dev() and the de-reference of ctx->cm_id, we
>>>> are toast.
>>>=20
>>> Is that what happens on the addr_handler path?
>>=20
>> No, there, the main problem is the revert of the state
>> transitions. The first transition enables rdma_resolve_route() to
>> pass its gate (i.e. state =3D=3D ADDR_RESOLVED). Then it thinks the
>> address is resolved, but the addr_handler changes its mind
>> afterwards.
>=20
> That is a problem, but the call to rdma_destroy_id looks like another
> problem

I am not sure. Almost all events/incoming packets, can, after the =
cm_id's event_handler is called from cma_ib_handler(), call =
rdma_destroy_id(). I assume the refcounting takes care of this.


Thxs, H=C3=A5kon


