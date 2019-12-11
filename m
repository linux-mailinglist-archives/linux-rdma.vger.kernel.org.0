Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF9B911ABC8
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2019 14:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbfLKNNe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Dec 2019 08:13:34 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:36786 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729230AbfLKNNe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 Dec 2019 08:13:34 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBBD99YJ002327;
        Wed, 11 Dec 2019 13:13:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=QN8DiZJVoK7unVOw5jwVJKcScm1b3TGTOXoA2TCpOjg=;
 b=FK4pQQSt/DXUMGi6HJzFuU/xl97kDyek+qpH5plRcE07jXGWlFrYWtfyUGfE+VRKgbOc
 pf1wsBnH/RQcbaZ6AQPpmUPxqMkuoRY+rLLzSm/LOFonOoFZAytuGZHOlgMpAbqlguLh
 WZ47+wVqixX+k2aitDgvVRFEDdsTM5CjbDAzCf4CVmt1p3HliJOnK23gqmvwvLoUMZR1
 /+PuF1JvG5Hio3cdMhfTeHueEYrX/TdYe3xjKER6U6dB2DVD5/hNyBjXmTnz1XEKfKyc
 51ZvTuGAJSYCPuTHTc2fE4BY94vOTRW9dkI/3+/NmcUqIeo0va/VamL4pshDea/vEFYI 6g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2wr4qrmdxt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Dec 2019 13:13:18 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBBD8jDn113335;
        Wed, 11 Dec 2019 13:13:18 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2wte9bysbj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Dec 2019 13:13:18 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBBDDHpa003370;
        Wed, 11 Dec 2019 13:13:17 GMT
Received: from dhcp-10-172-157-208.no.oracle.com (/10.172.157.208)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Dec 2019 05:13:16 -0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH RDMA/netlink] RDMA/netlink: Adhere to returning zero on
 success
From:   =?utf-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
In-Reply-To: <20191211123955.GS67461@unreal>
Date:   Wed, 11 Dec 2019 14:13:13 +0100
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        Mark Haywood <mark.haywood@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <75D5DC74-A39B-425F-BCF7-E0AEBBE464CD@oracle.com>
References: <20191211103400.2949140-1-haakon.bugge@oracle.com>
 <20191211123955.GS67461@unreal>
To:     Leon Romanovsky <leon@kernel.org>
X-Mailer: Apple Mail (2.3601.0.10)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9467 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=886
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912110112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9467 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=935 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912110112
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On 11 Dec 2019, at 13:39, Leon Romanovsky <leon@kernel.org> wrote:
>=20
> On Wed, Dec 11, 2019 at 11:34:00AM +0100, H=C3=A5kon Bugge wrote:
>> In rdma_nl_rcv_skb(), the local variable err is assigned the return
>> value of the supplied callback function, which could be one of
>> ib_nl_handle_resolve_resp(), ib_nl_handle_set_timeout(), or
>> ib_nl_handle_ip_res_resp(). These three functions all return skb->len
>> on success.
>>=20
>> rdma_nl_rcv_skb() is merely a copy of netlink_rcv_skb(). The callback
>> functions used by the latter have the convention: "Returns 0 on
>> success or a negative error code".
>>=20
>> In particular, the statement (equal for both functions):
>>=20
>>   if (nlh->nlmsg_flags & NLM_F_ACK || err)
>>=20
>> implies that rdma_nl_rcv_skb() always will ack a message, independent
>> of the NLM_F_ACK being set in nlmsg_flags or not.
>=20
> The more accurate description is that rdma_nl_rcv_skb() always =
generates
> NLMSG_ERROR without relation to NLM_F_ACK flag. The NLM_F_ACK flag is
> requested to get acknowledges for the success.
>=20
>>=20
>> The fix could be to change the above statement, but it is better to
>> keep the two *_rcv_skb() functions equal in this respect and instead
>> change the callback functions in the rdma subsystem to the correct
>> convention.
>=20
> AFAIR, RTNETLINK has the same implementation as RDMA netlink.

With the exception of the callback functions, as noted above.


Thxs, H=C3=A5kon

>=20
> Thanks

