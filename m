Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 320C211CF80
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2019 15:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729538AbfLLOP3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Dec 2019 09:15:29 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:41404 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729529AbfLLOP3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Dec 2019 09:15:29 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBCEENVe021132;
        Thu, 12 Dec 2019 14:15:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=jbbICM1V+Grs76BiUPeo2TUSwZnEZiYi2OLS2IGQQIc=;
 b=GAwiQeRZUkrsjT9Ws34jtFxyEt/aIPNPH+yWZHipkV6ixiLv93lsLTCAH1kzj6I2Xx6y
 iEFSgOvuodbc+FVCC8JSNNeXPqAUnRAjLRddEUcb2FifQ2Ww8Av4FyXG28DbxGtzorBa
 weG4nK6nRgv/qhkAh9lD0bLqm7xSKZXXeYChx2Jr0wiir/NXyDCsf0RbdccE7fz0Ev2w
 go7UFKPaYhBJKk6cAKuTmLyJ8CwuF3HQOFfiZ0pfpgGEmAe7WYHkV4o06nEWtp2mmy1J
 BYGCnD4018cNOpkesS3b/YP1IWLY74gL2AzveZ083Up/PL//4r93Gnl2W+vEyYxltopJ Hg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2wr4qru671-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Dec 2019 14:15:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBCE8axw158690;
        Thu, 12 Dec 2019 14:15:16 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2wumvyptcs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Dec 2019 14:15:16 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBCEFE7l030727;
        Thu, 12 Dec 2019 14:15:14 GMT
Received: from Marks-Mac-mini-2.local (/10.39.232.247)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 12 Dec 2019 06:15:14 -0800
Subject: Re: [PATCH RDMA/netlink] RDMA/netlink: Adhere to returning zero on
 success
To:     =?UTF-8?Q?H=c3=a5kon_Bugge?= <haakon.bugge@oracle.com>,
        Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
References: <20191211103400.2949140-1-haakon.bugge@oracle.com>
 <20191211123955.GS67461@unreal>
 <75D5DC74-A39B-425F-BCF7-E0AEBBE464CD@oracle.com>
 <697DC4C7-223E-4321-A304-C950EB93D2B1@oracle.com>
 <20191212114038.GX67461@unreal>
 <AD5EE341-4238-439A-A078-299F00C61B85@oracle.com>
 <20191212121020.GZ67461@unreal>
 <CB8FC366-9983-417D-8280-DD1EB0DCB778@oracle.com>
 <20191212122719.GA67461@unreal>
 <F6B487BC-CEBA-47D5-9E01-B15A8A1902E1@oracle.com>
From:   Mark Haywood <mark.haywood@oracle.com>
Message-ID: <c7d1cb3d-c55f-2bca-c616-6f50a619383b@oracle.com>
Date:   Thu, 12 Dec 2019 09:14:29 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <F6B487BC-CEBA-47D5-9E01-B15A8A1902E1@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9468 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912120108
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9468 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912120109
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 12/12/19 7:37 AM, Håkon Bugge wrote:
>
>> On 12 Dec 2019, at 13:27, Leon Romanovsky <leon@kernel.org> wrote:
>>
>> On Thu, Dec 12, 2019 at 01:16:54PM +0100, Håkon Bugge wrote:
>>>
>>>> On 12 Dec 2019, at 13:10, Leon Romanovsky <leon@kernel.org> wrote:
>>>>
>>>> On Thu, Dec 12, 2019 at 12:59:51PM +0100, Håkon Bugge wrote:
>>>>>
>>>>>> On 12 Dec 2019, at 12:40, Leon Romanovsky <leon@kernel.org> wrote:
>>>>>>
>>>>>> On Wed, Dec 11, 2019 at 08:31:18PM +0100, Håkon Bugge wrote:
>>>>>>>
>>>>>>>> On 11 Dec 2019, at 14:13, Håkon Bugge <haakon.bugge@oracle.com> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>> On 11 Dec 2019, at 13:39, Leon Romanovsky <leon@kernel.org> wrote:
>>>>>>>>>
>>>>>>>>> On Wed, Dec 11, 2019 at 11:34:00AM +0100, Håkon Bugge wrote:
>>>>>>>>>> In rdma_nl_rcv_skb(), the local variable err is assigned the return
>>>>>>>>>> value of the supplied callback function, which could be one of
>>>>>>>>>> ib_nl_handle_resolve_resp(), ib_nl_handle_set_timeout(), or
>>>>>>>>>> ib_nl_handle_ip_res_resp(). These three functions all return skb->len
>>>>>>>>>> on success.
>>>>>>>>>>
>>>>>>>>>> rdma_nl_rcv_skb() is merely a copy of netlink_rcv_skb(). The callback
>>>>>>>>>> functions used by the latter have the convention: "Returns 0 on
>>>>>>>>>> success or a negative error code".
>>>>>>>>>>
>>>>>>>>>> In particular, the statement (equal for both functions):
>>>>>>>>>>
>>>>>>>>>> if (nlh->nlmsg_flags & NLM_F_ACK || err)
>>>>>>>>>>
>>>>>>>>>> implies that rdma_nl_rcv_skb() always will ack a message, independent
>>>>>>>>>> of the NLM_F_ACK being set in nlmsg_flags or not.
>>>>>>>>> The more accurate description is that rdma_nl_rcv_skb() always generates
>>>>>>>>> NLMSG_ERROR without relation to NLM_F_ACK flag. The NLM_F_ACK flag is
>>>>>>>>> requested to get acknowledges for the success.
>>>>>>>
>>>>>>> Yes. And when, lets say a legitimate path record response, containing N positive bytes, is sent back from ibacm to the kernel, rdma_nl_rcv_skb() think this is an error, due to "if (nlh->nlmsg_flags & NLM_F_ACK || err)" _and_ ib_nl_handle_resolve_resp() returning N.
>>>>>> How did you test this patch?
>>>>>> Do we have open-source applications which don't set NLM_F_ACK for
>>>>>> ib_nl_*() calls?
>>>>> As I alluded to above, yes, ibacm doesn't set it.
>>>> In this regards, I'm amazed that this patch didn't break ibacm.
>>> On the contrary. The patch avoids the kernel sending back an error/ACK for every path record / resolve response.
>> As long as ibacm continues to work with this patch, i'm ok.
>> What type of testing did you perform?
> I'll let Mark respond to the testing. The background is that ibacm was very *liberal* when it comes checking the requests it received from the kernel. In an attempt to tighten that, Mark discovered that ibacm received an unexpected ACK from the kernel just after having sent a response.


Without this patch, for every response to a RDMA_NL_LS_OP_RESOLVE 
request, ibacm receives an ACK with a nlmsgerr error value equal to the 
length of the response message.

With this patch, no ACKs are received.

If I add the NLM_F_ACK to the nlmsg_header flags when responding to the 
RDMA_NL_LS_OP_RESOLVE request, ibacm once again receives the ACKs.

Mark


>
> That aside, I think the RDMA NL callbacks shall adhere to the RTNETLINK conventions, thus, that's why this commit changes the callbacks and not the  rdma_nl_rcv_skb().
>
>
> Thxs, Håkon
>
>> Thanks
>>
>>>
>>> Håkon
>>>
>>>> Thanks

