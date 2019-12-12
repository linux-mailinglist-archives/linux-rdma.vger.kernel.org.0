Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1C4011CD0E
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2019 13:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbfLLMWs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Dec 2019 07:22:48 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:40300 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729118AbfLLMWs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Dec 2019 07:22:48 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBCCEJu9131976;
        Thu, 12 Dec 2019 12:22:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=Z/aziWIJSIilEYt3keRtKX0gU0KUyQX6yGgmKLwBxTM=;
 b=Ax0wtYdiHyWvMmp9hyhrtpn3ZcSYkRrBsUF+gXuEgVnI2guNZUqBegms5zPIbXp8iykX
 jty/xWVko4Ok/Y8bXoBsbNWcclDwDTN68F/HMaVN3Pr/69vdebmXBE7XGNJ9WfADbmJM
 GLIFlGepkHPbR+usAjQMm5ohONN0AD7qUH2y4ovHTlQHpgAA5m49GPcCdg6Kb+U76rQ5
 VTa2U+PTtxI7cnz2J2ZvYgtQ08lBu11q3B6qOttsiXzXsrtOxqBCbOsjD4jT84XiYv5P
 CNKKpDPu0BPnt15YwQYDQ63oUAKHq6wmHySdHD/Kc83HFLagx/k/tKrWye0Rayg0fyE3 ng== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2wrw4nfh1k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Dec 2019 12:22:36 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBCCECOs095159;
        Thu, 12 Dec 2019 12:22:36 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2wumu3v2gq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Dec 2019 12:22:35 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBCCMYQM023389;
        Thu, 12 Dec 2019 12:22:34 GMT
Received: from dhcp-10-175-185-179.vpn.oracle.com (/10.175.185.179)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 12 Dec 2019 04:22:34 -0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH RDMA/netlink] RDMA/netlink: Adhere to returning zero on
 success
From:   =?utf-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
In-Reply-To: <CB8FC366-9983-417D-8280-DD1EB0DCB778@oracle.com>
Date:   Thu, 12 Dec 2019 13:22:31 +0100
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        Mark Haywood <mark.haywood@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DCC69344-DA7D-4364-BFED-D1D7847E765E@oracle.com>
References: <20191211103400.2949140-1-haakon.bugge@oracle.com>
 <20191211123955.GS67461@unreal>
 <75D5DC74-A39B-425F-BCF7-E0AEBBE464CD@oracle.com>
 <697DC4C7-223E-4321-A304-C950EB93D2B1@oracle.com>
 <20191212114038.GX67461@unreal>
 <AD5EE341-4238-439A-A078-299F00C61B85@oracle.com>
 <20191212121020.GZ67461@unreal>
 <CB8FC366-9983-417D-8280-DD1EB0DCB778@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
X-Mailer: Apple Mail (2.3601.0.10)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9468 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=861
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912120093
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9468 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=928 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912120093
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Missed the reply-all somewhere in this exchange.

-h


> On 12 Dec 2019, at 13:16, H=C3=A5kon Bugge <haakon.bugge@oracle.com> =
wrote:
>=20
>=20
>=20
>> On 12 Dec 2019, at 13:10, Leon Romanovsky <leon@kernel.org> wrote:
>>=20
>> On Thu, Dec 12, 2019 at 12:59:51PM +0100, H=C3=A5kon Bugge wrote:
>>>=20
>>>=20
>>>> On 12 Dec 2019, at 12:40, Leon Romanovsky <leon@kernel.org> wrote:
>>>>=20
>>>> On Wed, Dec 11, 2019 at 08:31:18PM +0100, H=C3=A5kon Bugge wrote:
>>>>>=20
>>>>>=20
>>>>>> On 11 Dec 2019, at 14:13, H=C3=A5kon Bugge =
<haakon.bugge@oracle.com> wrote:
>>>>>>=20
>>>>>>=20
>>>>>>=20
>>>>>>> On 11 Dec 2019, at 13:39, Leon Romanovsky <leon@kernel.org> =
wrote:
>>>>>>>=20
>>>>>>> On Wed, Dec 11, 2019 at 11:34:00AM +0100, H=C3=A5kon Bugge =
wrote:
>>>>>>>> In rdma_nl_rcv_skb(), the local variable err is assigned the =
return
>>>>>>>> value of the supplied callback function, which could be one of
>>>>>>>> ib_nl_handle_resolve_resp(), ib_nl_handle_set_timeout(), or
>>>>>>>> ib_nl_handle_ip_res_resp(). These three functions all return =
skb->len
>>>>>>>> on success.
>>>>>>>>=20
>>>>>>>> rdma_nl_rcv_skb() is merely a copy of netlink_rcv_skb(). The =
callback
>>>>>>>> functions used by the latter have the convention: "Returns 0 on
>>>>>>>> success or a negative error code".
>>>>>>>>=20
>>>>>>>> In particular, the statement (equal for both functions):
>>>>>>>>=20
>>>>>>>> if (nlh->nlmsg_flags & NLM_F_ACK || err)
>>>>>>>>=20
>>>>>>>> implies that rdma_nl_rcv_skb() always will ack a message, =
independent
>>>>>>>> of the NLM_F_ACK being set in nlmsg_flags or not.
>>>>>>>=20
>>>>>>> The more accurate description is that rdma_nl_rcv_skb() always =
generates
>>>>>>> NLMSG_ERROR without relation to NLM_F_ACK flag. The NLM_F_ACK =
flag is
>>>>>>> requested to get acknowledges for the success.
>>>>>=20
>>>>>=20
>>>>> Yes. And when, lets say a legitimate path record response, =
containing N positive bytes, is sent back from ibacm to the kernel, =
rdma_nl_rcv_skb() think this is an error, due to "if (nlh->nlmsg_flags & =
NLM_F_ACK || err)" _and_ ib_nl_handle_resolve_resp() returning N.
>>>>=20
>>>> How did you test this patch?
>>>> Do we have open-source applications which don't set NLM_F_ACK for
>>>> ib_nl_*() calls?
>>>=20
>>> As I alluded to above, yes, ibacm doesn't set it.
>>=20
>> In this regards, I'm amazed that this patch didn't break ibacm.
>=20
> On the contrary. The patch avoids the kernel sending back an error/ACK =
for every path record / resolve response.
>=20
>=20
> H=C3=A5kon
>=20
>>=20
>> Thanks
>=20

