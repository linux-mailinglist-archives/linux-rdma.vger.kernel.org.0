Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41B5811CD60
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2019 13:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbfLLMjg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Dec 2019 07:39:36 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:60846 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729232AbfLLMjf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Dec 2019 07:39:35 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBCCdA3x135764;
        Thu, 12 Dec 2019 12:39:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=lqyvGPrwbhl5VeQONLfI27x8cb8Or9OGtDfNxmp73ME=;
 b=sjwPJa7IZ7SGJek8pKz5hDbo4+DS07cxMQk8KyAiSz5rybzicxk82b+7UYp45LZghpxV
 83JqAi5uaIe4D+/zcOVa+kBWb6qljyQTTyTLfPfvez2OmJhGbOnv5RHQgtCWeMYqMJXl
 BM0VyIem/4AaB44qLn7fZM3KxDNybI+cfixJk7VejcEmks9w2a/jEWPwtp4fRje7kGE1
 4o83aysVxnu7/Ejj1TgzLeO+GHM5uifvkbNR+buE/QxQdUoE9h+zonB58bat/CRHsr8N
 Ue+lgGi94x3lIDPVKVW1f/SAf0nnF2nT7fwPEZdlg356+Z6lYkEHilhGYd0OZ4VYasxS 1A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2wr4qrtnu3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Dec 2019 12:39:25 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBCCdHwU129870;
        Thu, 12 Dec 2019 12:39:24 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2wumvy49s3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Dec 2019 12:39:20 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBCCbxq6014625;
        Thu, 12 Dec 2019 12:37:59 GMT
Received: from dhcp-10-175-185-179.vpn.oracle.com (/10.175.185.179)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 12 Dec 2019 04:37:59 -0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH RDMA/netlink] RDMA/netlink: Adhere to returning zero on
 success
From:   =?utf-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
In-Reply-To: <20191212122719.GA67461@unreal>
Date:   Thu, 12 Dec 2019 13:37:56 +0100
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        Mark Haywood <mark.haywood@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F6B487BC-CEBA-47D5-9E01-B15A8A1902E1@oracle.com>
References: <20191211103400.2949140-1-haakon.bugge@oracle.com>
 <20191211123955.GS67461@unreal>
 <75D5DC74-A39B-425F-BCF7-E0AEBBE464CD@oracle.com>
 <697DC4C7-223E-4321-A304-C950EB93D2B1@oracle.com>
 <20191212114038.GX67461@unreal>
 <AD5EE341-4238-439A-A078-299F00C61B85@oracle.com>
 <20191212121020.GZ67461@unreal>
 <CB8FC366-9983-417D-8280-DD1EB0DCB778@oracle.com>
 <20191212122719.GA67461@unreal>
To:     Leon Romanovsky <leon@kernel.org>
X-Mailer: Apple Mail (2.3601.0.10)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9468 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912120095
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9468 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912120095
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On 12 Dec 2019, at 13:27, Leon Romanovsky <leon@kernel.org> wrote:
>=20
> On Thu, Dec 12, 2019 at 01:16:54PM +0100, H=C3=A5kon Bugge wrote:
>>=20
>>=20
>>> On 12 Dec 2019, at 13:10, Leon Romanovsky <leon@kernel.org> wrote:
>>>=20
>>> On Thu, Dec 12, 2019 at 12:59:51PM +0100, H=C3=A5kon Bugge wrote:
>>>>=20
>>>>=20
>>>>> On 12 Dec 2019, at 12:40, Leon Romanovsky <leon@kernel.org> wrote:
>>>>>=20
>>>>> On Wed, Dec 11, 2019 at 08:31:18PM +0100, H=C3=A5kon Bugge wrote:
>>>>>>=20
>>>>>>=20
>>>>>>> On 11 Dec 2019, at 14:13, H=C3=A5kon Bugge =
<haakon.bugge@oracle.com> wrote:
>>>>>>>=20
>>>>>>>=20
>>>>>>>=20
>>>>>>>> On 11 Dec 2019, at 13:39, Leon Romanovsky <leon@kernel.org> =
wrote:
>>>>>>>>=20
>>>>>>>> On Wed, Dec 11, 2019 at 11:34:00AM +0100, H=C3=A5kon Bugge =
wrote:
>>>>>>>>> In rdma_nl_rcv_skb(), the local variable err is assigned the =
return
>>>>>>>>> value of the supplied callback function, which could be one of
>>>>>>>>> ib_nl_handle_resolve_resp(), ib_nl_handle_set_timeout(), or
>>>>>>>>> ib_nl_handle_ip_res_resp(). These three functions all return =
skb->len
>>>>>>>>> on success.
>>>>>>>>>=20
>>>>>>>>> rdma_nl_rcv_skb() is merely a copy of netlink_rcv_skb(). The =
callback
>>>>>>>>> functions used by the latter have the convention: "Returns 0 =
on
>>>>>>>>> success or a negative error code".
>>>>>>>>>=20
>>>>>>>>> In particular, the statement (equal for both functions):
>>>>>>>>>=20
>>>>>>>>> if (nlh->nlmsg_flags & NLM_F_ACK || err)
>>>>>>>>>=20
>>>>>>>>> implies that rdma_nl_rcv_skb() always will ack a message, =
independent
>>>>>>>>> of the NLM_F_ACK being set in nlmsg_flags or not.
>>>>>>>>=20
>>>>>>>> The more accurate description is that rdma_nl_rcv_skb() always =
generates
>>>>>>>> NLMSG_ERROR without relation to NLM_F_ACK flag. The NLM_F_ACK =
flag is
>>>>>>>> requested to get acknowledges for the success.
>>>>>>=20
>>>>>>=20
>>>>>> Yes. And when, lets say a legitimate path record response, =
containing N positive bytes, is sent back from ibacm to the kernel, =
rdma_nl_rcv_skb() think this is an error, due to "if (nlh->nlmsg_flags & =
NLM_F_ACK || err)" _and_ ib_nl_handle_resolve_resp() returning N.
>>>>>=20
>>>>> How did you test this patch?
>>>>> Do we have open-source applications which don't set NLM_F_ACK for
>>>>> ib_nl_*() calls?
>>>>=20
>>>> As I alluded to above, yes, ibacm doesn't set it.
>>>=20
>>> In this regards, I'm amazed that this patch didn't break ibacm.
>>=20
>> On the contrary. The patch avoids the kernel sending back an =
error/ACK for every path record / resolve response.
>=20
> As long as ibacm continues to work with this patch, i'm ok.
> What type of testing did you perform?

I'll let Mark respond to the testing. The background is that ibacm was =
very *liberal* when it comes checking the requests it received from the =
kernel. In an attempt to tighten that, Mark discovered that ibacm =
received an unexpected ACK from the kernel just after having sent a =
response.

That aside, I think the RDMA NL callbacks shall adhere to the RTNETLINK =
conventions, thus, that's why this commit changes the callbacks and not =
the  rdma_nl_rcv_skb().


Thxs, H=C3=A5kon

>=20
> Thanks
>=20
>>=20
>>=20
>> H=C3=A5kon
>>=20
>>>=20
>>> Thanks

