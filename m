Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDD3211BD08
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2019 20:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfLKTba (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Dec 2019 14:31:30 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:35422 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfLKTba (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 Dec 2019 14:31:30 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBBJTHIF146215;
        Wed, 11 Dec 2019 19:31:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=z9wOUSwJwa5lUTrGFpjMhi2iuCEYSFtpBQxskVMyfW8=;
 b=FYHOyUwTU88VGHwcJa/oG3HuDLCHmchPCyU/sDHJJ7mwOa4Ev0JYLwNb6MtVDLEGA+Hr
 1UDyMSs/ph+16OIvOmXId2X9QS4rWeIMIBXaIn3ZNuKqf7FZm8xvZ6Vb9/OE7SxDk3++
 LEw94awY553TK2MJEQHvgNz5y56NWeMcnqoiQuxcyObiWuAzfAvzbYU6kwdU+hYsFqSn
 ZCfXVyUFJKT7OA5uTe5HtASmNzJh5NgamUFwdS8Z4p2l0b5B9cWHSmNTCdV5gwys6Vi1
 TnXsJJDDeVpi39RHNABbE9AmctpnDbZ+ArODemV1bq8ABkuylTcwrIlhBOYHJXqlK72n tQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2wr4qrppg0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Dec 2019 19:31:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBBJSodk021340;
        Wed, 11 Dec 2019 19:31:22 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2wu2fuvt1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Dec 2019 19:31:22 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBBJVLJb005538;
        Wed, 11 Dec 2019 19:31:21 GMT
Received: from [192.168.10.185] (/51.175.209.121)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Dec 2019 11:31:21 -0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH RDMA/netlink] RDMA/netlink: Adhere to returning zero on
 success
From:   =?utf-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
In-Reply-To: <75D5DC74-A39B-425F-BCF7-E0AEBBE464CD@oracle.com>
Date:   Wed, 11 Dec 2019 20:31:18 +0100
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        Mark Haywood <mark.haywood@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <697DC4C7-223E-4321-A304-C950EB93D2B1@oracle.com>
References: <20191211103400.2949140-1-haakon.bugge@oracle.com>
 <20191211123955.GS67461@unreal>
 <75D5DC74-A39B-425F-BCF7-E0AEBBE464CD@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
X-Mailer: Apple Mail (2.3601.0.10)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9468 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912110161
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9468 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912110161
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On 11 Dec 2019, at 14:13, H=C3=A5kon Bugge <haakon.bugge@oracle.com> =
wrote:
>=20
>=20
>=20
>> On 11 Dec 2019, at 13:39, Leon Romanovsky <leon@kernel.org> wrote:
>>=20
>> On Wed, Dec 11, 2019 at 11:34:00AM +0100, H=C3=A5kon Bugge wrote:
>>> In rdma_nl_rcv_skb(), the local variable err is assigned the return
>>> value of the supplied callback function, which could be one of
>>> ib_nl_handle_resolve_resp(), ib_nl_handle_set_timeout(), or
>>> ib_nl_handle_ip_res_resp(). These three functions all return =
skb->len
>>> on success.
>>>=20
>>> rdma_nl_rcv_skb() is merely a copy of netlink_rcv_skb(). The =
callback
>>> functions used by the latter have the convention: "Returns 0 on
>>> success or a negative error code".
>>>=20
>>> In particular, the statement (equal for both functions):
>>>=20
>>>  if (nlh->nlmsg_flags & NLM_F_ACK || err)
>>>=20
>>> implies that rdma_nl_rcv_skb() always will ack a message, =
independent
>>> of the NLM_F_ACK being set in nlmsg_flags or not.
>>=20
>> The more accurate description is that rdma_nl_rcv_skb() always =
generates
>> NLMSG_ERROR without relation to NLM_F_ACK flag. The NLM_F_ACK flag is
>> requested to get acknowledges for the success.


Yes. And when, lets say a legitimate path record response, containing N =
positive bytes, is sent back from ibacm to the kernel, rdma_nl_rcv_skb() =
think this is an error, due to "if (nlh->nlmsg_flags & NLM_F_ACK || =
err)" _and_ ib_nl_handle_resolve_resp() returning N.

Thxs, H=C3=A5kon


>>=20
>>>=20
>>> The fix could be to change the above statement, but it is better to
>>> keep the two *_rcv_skb() functions equal in this respect and instead
>>> change the callback functions in the rdma subsystem to the correct
>>> convention.
>>=20
>> AFAIR, RTNETLINK has the same implementation as RDMA netlink.
>=20
> With the exception of the callback functions, as noted above.
>=20
>=20
> Thxs, H=C3=A5kon
>=20
>>=20
>> Thanks
>=20

